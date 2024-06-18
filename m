Return-Path: <linux-kernel+bounces-219448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4890D2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815C81C22D51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87811AD9C6;
	Tue, 18 Jun 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wec5upIj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67B1AD4BF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716840; cv=none; b=IJkNd8k5AWrRhJ1nrTBEfT8nyqurhSPjuLzt0DWkQgO4RLuodyjx1n1PyY4j6SCBCZvbVQeA9/7gTnlJVEmGsAsurfKDn0+mtk1bGlutHOm54FBZkvgEZOZOnZFRzR/lrge9icbuAFz9KW/Ya7jnacT5a5O/XZN8+FezNhyKEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716840; c=relaxed/simple;
	bh=TchHJF4H6pZ5HhgR8lD+C3/ZokyoEJaEyP3Iiw2Qbog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS1pZlku0qnbP1B2yXY7NnjOC7LW8uOao9//4D8pdgOI7cEsvOShC/3o99Cj5n/Ls0mX4P+sxldeItjatnQzJmfO36MNhAeF2eYhO6qG+DB0y/Dk20iGSN4zdkBZ6Ff+N3E7vxxHaYx0ra96CMpjQRfuqjShXPQkovLlpVsyqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wec5upIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A1AC32786;
	Tue, 18 Jun 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716840;
	bh=TchHJF4H6pZ5HhgR8lD+C3/ZokyoEJaEyP3Iiw2Qbog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wec5upIjb+m4Xq+QKZFTRFbkytlPf1BL/+qeOlHRSjgfKL9kiMoegzke1qlDRYKUT
	 j5hmHfhYkTbwmL5zOsr5U0ODY/5l2zUEj1QI3QcDmZgK0CeDO2CWMBs6YAgPW04XeZ
	 Poo23CGLa9aSvFi228OSTiaG6UlckXl38fkF/Zks=
Date: Tue, 18 Jun 2024 14:54:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/1] container_of: Document container_of_const() is
 preferred
Message-ID: <2024061820-scrambled-playback-a73a@gregkh>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
 <2024061702-vexingly-hypocrisy-d93d@gregkh>
 <ZnFOrziVMDwtu1NA@kekkonen.localdomain>
 <2024061827-revival-handwrite-5eb0@gregkh>
 <ZnF06GjogseJut9q@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnF06GjogseJut9q@kekkonen.localdomain>

On Tue, Jun 18, 2024 at 11:52:08AM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Tue, Jun 18, 2024 at 12:01:30PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Jun 18, 2024 at 09:09:03AM +0000, Sakari Ailus wrote:
> > > Hi Greg,
> > > 
> > > On Mon, Jun 17, 2024 at 12:44:55PM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Jun 17, 2024 at 01:08:25PM +0300, Sakari Ailus wrote:
> > > > > There is a warning in kerneldoc documentation of container_of() that
> > > > > constness of @ptr is lost. While this is a suggestion container_of_const()
> > > > > should be used instead, the vast majority of new code still uses
> > > > > container_of():
> > > > > 
> > > > > $ git diff v6.8 v6.9|grep container_of\(|wc -l
> > > > > 788
> > > > > $ git diff v6.8 v6.9|grep container_of_const|wc -l
> > > > > 11
> > > > 
> > > > That is because container_of_const is new, and you don't normally go
> > > > back and change things unless you have to.  Which is what I am starting
> > > > to do for some cases now in the driver core interactions, but generally
> > > > it's rare to need this.
> > > 
> > > container_of_const() does provide a useful a useful sanity check and I
> > > think we should encourage people to use it. I'm happy to see many macros
> > > under include/ use container_of_const() already, but there seem to be more
> > > than 1000 cases where the constness qualifier of a pointer is just
> > > discarded just in the scope that got compiled with my current .config (not
> > > allyesconfig). While the vast majority are probably benign, I wouldn't be
> > > certain there aren't cases where the container of a const pointer ends up
> > > being modified.
> > > 
> > > > 
> > > > Also note that container_of_const does not work in an inline function,
> > > > which is another reason people might not want to use it.
> > > 
> > > Does not work or is less useful (compared to a macro)? _Generic() would
> > > need to be used if you'd like to have const and non-const variants of an
> > > inline function but I guess in most cases macros are just fine.
> > 
> > I could not figure out a way to make this an inline function at all.
> > Try it yourself and see, maybe I was wrong.
> 
> I didn't have any issues (apart from me misspelling function names ;)) with
> GCC 12, neither in using container_of_const() in a static inline function
> nor in using a static inline function as a _Generic() expression.

Really?  And how do you handle the pointer being either const or not,
and propagating that back out as the return type?  I'd like to see your
inline function please.

> If other compilers have issues we can update the documentation I guess? Or
> only make the check on compilers that properly support it? Or in the best
> case, fix those compilers. This does tend to take a long time though.

I tested this all with gcc-12 when I did the original work, so that
should be fine.

> > > > > Make an explicit recommendation to use container_of_const(), unless @ptr
> > > > > is const but its container isn't.
> > > > > 
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > ---
> > > > >  include/linux/container_of.h | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > > > > index 713890c867be..7563015ff165 100644
> > > > > --- a/include/linux/container_of.h
> > > > > +++ b/include/linux/container_of.h
> > > > > @@ -13,7 +13,9 @@
> > > > >   * @type:	the type of the container struct this is embedded in.
> > > > >   * @member:	the name of the member within the struct.
> > > > >   *
> > > > > - * WARNING: any const qualifier of @ptr is lost.
> > > > > + * WARNING: any const qualifier of @ptr is lost. container_of() should only be
> > > > > + * used in cases where @ptr is const and its container is not and you know what
> > > > > + * you're doing. Otherwise always use container_of_const().
> > > > 
> > > > I know of no cases where a @ptr would be const yet the container would
> > > > not be, do you?  So why say that here?  That implies that it is a valid
> > > > thing to actually do.
> > > > 
> > > > I don't understand the goal here, do you want to just not have new
> > > > usages use container_of() at all?  Or are you trying to warn people of a
> > > > common problem that they make?  Having a const @ptr is not normal in the
> > > > kernel, so this should be ok.  If not, send patches to fix up those
> > > > users please.
> > > 
> > > My immediate goal is to encourage people to use container_of_const() for
> > > the added sanity check and stop adding technical debt (code that ignores
> > > const qualifier). Currently people also do think they should be using
> > > container_of() instead of container_of_const() because the pointer they
> > > have is not const (at the time of writing the code at least).
> > 
> > That's fine, so for new things, use container_of_const(), but generally
> > the need for a const is quite rare, outside of the driver core
> > interactions.
> 
> Right, but I'm also looking to avoid drivers doing this inadvertly. Those
> instances are just as much a blocker for turning container_of() const-aware
> as anything else.

Almost no driver should be using container_of on their own, they should
be using the bus-provided macros instead.  Or if they are, they are
doing it for their own internal structures and as those are probably not
const, then there's not an issue here.

Specific examples of where you are seeing this being added where it
shouldn't be would be good.

Also, just start sweeping the tree if you want to, and send patches to
fix up where this is done incorrectly should be gladly accepted.

> > > Eventually (or hopefully?) adding that sanity check for container_of() may
> > > be possible so we'd again have just one macro for the job.
> > 
> > That would be nice, try doing that and see what blows up.
> 
> Currently a lot of things but it can be done gradually, one instance at a
> time.
> 
> How changing the container_of() documentation to this:
> 
>  * WARNING: any const qualifier of @ptr is lost. Use container_of_const()
>  * instead.

Is that really going to change anyone's opinion of what to use here?

thanks,

greg k-h

