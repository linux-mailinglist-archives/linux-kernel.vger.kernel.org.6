Return-Path: <linux-kernel+bounces-219014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC490C8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54D6B27143
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDAB2093EB;
	Tue, 18 Jun 2024 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QcprsH+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F42093E5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704894; cv=none; b=CGmJE94u1KAec8zUEIRqRG/4ufS/MEXRqakjwLPkvzjNYpgtpB9r6kagZG+94DCCSv4V/y329YurDTGzUs/fJOnM7MZzXDFqXJ2KBCJiIO+wa+4/aYIczpy6mgihV8OBB/M1dix3TiSiTcMPMs1pzlXPO64OzJWHTUSTfWQF1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704894; c=relaxed/simple;
	bh=yOh+LtPxm/3KyFCjguRGZbLlWrXkgeTsue3aEKRtSsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAj18l3wy55dslqav1M+jI8reYJZ6PG+Wrrwt3+PyVeRrvv1R0uA3i9tA164UAm3cmaA//p/WO3zQaarXOWkcYJLtsxLCBQOjdd1LA2yIbQwIso9JBPBlwofh1B0Ma+DyxBDEOvCpTW3G388U5791GXktEU3Yv8/U0JBW1xyjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QcprsH+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54687C4AF1D;
	Tue, 18 Jun 2024 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718704893;
	bh=yOh+LtPxm/3KyFCjguRGZbLlWrXkgeTsue3aEKRtSsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QcprsH+C0mcjEs5C4VXD7gnhp4ql7gpjc3RxCdaAO1h/oX/tmkv+O44xv0xIufhTM
	 3S5ZMyMB5hfXioOQGsEVraoqgG5EtoXvHMR+X982L542i8di3NC8NOwZSneVGFdg/M
	 UJHk1BtlOrUGPhFNW6cF9G2xkIsSnZq6zQkv0wo0=
Date: Tue, 18 Jun 2024 12:01:30 +0200
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
Message-ID: <2024061827-revival-handwrite-5eb0@gregkh>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
 <2024061702-vexingly-hypocrisy-d93d@gregkh>
 <ZnFOrziVMDwtu1NA@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnFOrziVMDwtu1NA@kekkonen.localdomain>

On Tue, Jun 18, 2024 at 09:09:03AM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Mon, Jun 17, 2024 at 12:44:55PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 17, 2024 at 01:08:25PM +0300, Sakari Ailus wrote:
> > > There is a warning in kerneldoc documentation of container_of() that
> > > constness of @ptr is lost. While this is a suggestion container_of_const()
> > > should be used instead, the vast majority of new code still uses
> > > container_of():
> > > 
> > > $ git diff v6.8 v6.9|grep container_of\(|wc -l
> > > 788
> > > $ git diff v6.8 v6.9|grep container_of_const|wc -l
> > > 11
> > 
> > That is because container_of_const is new, and you don't normally go
> > back and change things unless you have to.  Which is what I am starting
> > to do for some cases now in the driver core interactions, but generally
> > it's rare to need this.
> 
> container_of_const() does provide a useful a useful sanity check and I
> think we should encourage people to use it. I'm happy to see many macros
> under include/ use container_of_const() already, but there seem to be more
> than 1000 cases where the constness qualifier of a pointer is just
> discarded just in the scope that got compiled with my current .config (not
> allyesconfig). While the vast majority are probably benign, I wouldn't be
> certain there aren't cases where the container of a const pointer ends up
> being modified.
> 
> > 
> > Also note that container_of_const does not work in an inline function,
> > which is another reason people might not want to use it.
> 
> Does not work or is less useful (compared to a macro)? _Generic() would
> need to be used if you'd like to have const and non-const variants of an
> inline function but I guess in most cases macros are just fine.

I could not figure out a way to make this an inline function at all.
Try it yourself and see, maybe I was wrong.

> > > Make an explicit recommendation to use container_of_const(), unless @ptr
> > > is const but its container isn't.
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  include/linux/container_of.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > > index 713890c867be..7563015ff165 100644
> > > --- a/include/linux/container_of.h
> > > +++ b/include/linux/container_of.h
> > > @@ -13,7 +13,9 @@
> > >   * @type:	the type of the container struct this is embedded in.
> > >   * @member:	the name of the member within the struct.
> > >   *
> > > - * WARNING: any const qualifier of @ptr is lost.
> > > + * WARNING: any const qualifier of @ptr is lost. container_of() should only be
> > > + * used in cases where @ptr is const and its container is not and you know what
> > > + * you're doing. Otherwise always use container_of_const().
> > 
> > I know of no cases where a @ptr would be const yet the container would
> > not be, do you?  So why say that here?  That implies that it is a valid
> > thing to actually do.
> > 
> > I don't understand the goal here, do you want to just not have new
> > usages use container_of() at all?  Or are you trying to warn people of a
> > common problem that they make?  Having a const @ptr is not normal in the
> > kernel, so this should be ok.  If not, send patches to fix up those
> > users please.
> 
> My immediate goal is to encourage people to use container_of_const() for
> the added sanity check and stop adding technical debt (code that ignores
> const qualifier). Currently people also do think they should be using
> container_of() instead of container_of_const() because the pointer they
> have is not const (at the time of writing the code at least).

That's fine, so for new things, use container_of_const(), but generally
the need for a const is quite rare, outside of the driver core
interactions.

> Eventually (or hopefully?) adding that sanity check for container_of() may
> be possible so we'd again have just one macro for the job.

That would be nice, try doing that and see what blows up.

thanks,

greg k-h

