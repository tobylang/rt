# BEGIN BPS TAGGED BLOCK {{{
# 
# COPYRIGHT:
#  
# This software is Copyright (c) 1996-2005 Best Practical Solutions, LLC 
#                                          <jesse@bestpractical.com>
# 
# (Except where explicitly superseded by other copyright notices)
# 
# 
# LICENSE:
# 
# This work is made available to you under the terms of Version 2 of
# the GNU General Public License. A copy of that license should have
# been provided with this software, but in any event can be snarfed
# from www.gnu.org.
# 
# This work is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
# 
# 
# CONTRIBUTION SUBMISSION POLICY:
# 
# (The following paragraph is not intended to limit the rights granted
# to you to modify and distribute this software under the terms of
# the GNU General Public License and is only of importance to you if
# you choose to contribute your changes and enhancements to the
# community by submitting them to Best Practical Solutions, LLC.)
# 
# By intentionally submitting any modifications, corrections or
# derivatives to this work, or any other work intended for use with
# Request Tracker, to Best Practical Solutions, LLC, you confirm that
# you are the copyright holder for those contributions and you grant
# Best Practical Solutions,  LLC a nonexclusive, worldwide, irrevocable,
# royalty-free, perpetual, license to use, copy, create derivative
# works based on those contributions, and sublicense and distribute
# those contributions and any derivatives thereof.
# 
# END BPS TAGGED BLOCK }}}
package RT::URI::t;

use RT::Ticket;
use RT::URI::base;

use strict;
use vars qw(@ISA);
@ISA = qw/RT::URI::fsck_com_rt/;

my $scheme = "t";

=head2 ParseURI URI

When handed an t: URI, figures out if it is an RT ticket.  This is an
alternate short form of specifying a full ticket URI.

=begin testing

use_ok("RT::URI::t");
my $uri = RT::URI::t->new($RT::SystemUser);
ok(ref($uri), "URI object exists");

my $uristr = "t:1";
$uri->ParseURI($uristr);
is(ref($uri->Object), "RT::Ticket", "Object loaded is a ticket");
is($uri->Object->Id, 1, "Object loaded has correct ID");
is($uri->URI, 'fsck.com-rt://'.$RT::Organization.'/ticket/1',
   "URI object has correct URI string");

=end testing

=cut

sub ParseURI { 
    my $self = shift;
    my $uri = shift;

    # "t:<articlenum>"
    # Pass this off to fsck_com_rt, which is equipped to deal with
    # tickets after stripping off the t: prefix.

    if ($uri =~ /^$scheme:(\d+)/) {
	return $self->SUPER::ParseURI($1);
    } else {
	$self->{'uri'} = $uri;
	return undef;
    }
}

=head2 Scheme

Return the URI scheme 

=cut

sub Scheme {
  return $scheme;
}

1;
