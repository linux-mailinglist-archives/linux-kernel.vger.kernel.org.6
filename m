Return-Path: <linux-kernel+bounces-218915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DC190C7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB202859FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9741BE868;
	Tue, 18 Jun 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM9Vffu0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18BE147C8B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701751; cv=none; b=OcN5YpLXURpwBd4NeO2XaIcJwiI9Uqx6naTZMEgyGZZ9/TrH/5QdTpQyjmEbsTwa7OBqhc93lqxZ04Y/czJ7e/u6bczGSHlHy0eg9KwA74lpysuSRhicYSCyaHgwPxVvBzZGup3WLwOL4nQ+P7hq//GfKddPHpAUSXqMX11JWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701751; c=relaxed/simple;
	bh=x56JhyybaWu7AB3q/qUwWjzb7F+x4sl7xdJuHzToxBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csf67TdGX8jQ8BLuoqRjUgeB1F7o/umcP48ZJ76Wgkr06Td+tUr+W8CezUFYN0xCNJjJUAlH9t+Xa4FN7qwrbQmhSPgJ2trnTkieCzehuHZE/hq/V8fUs8S3i93ywU+IcwnALCUCs6n4t3HJkXm8Leo19q+h9tnIQEQBA19nLYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM9Vffu0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718701750; x=1750237750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x56JhyybaWu7AB3q/qUwWjzb7F+x4sl7xdJuHzToxBQ=;
  b=QM9Vffu0vJQyfedUzEz3mHUzidTKN0WJ6JBozsUwqFb0hCSRBV5kRoIF
   6sbpeb+SHg+FqTG+0D/MxAKG5BKhCofIFt0zBdINGc+gWJ5GP3iT/Fpt0
   DWNGohb+ekGbv7IFHKmwGLn0uUcQAiwwL2VUiyQr5ehgyIxRNG2d1p5x1
   Jh86qX5VSBg4XxripJhBd0wgoJtUS7k9ur/icTiZKgEcC/MBeZA4IpX65
   QmBEztEH3xeuoLUSVNdbUHDbJboREW/ay4BqzQZeA7dOFKmSQd3UjWcxO
   KfQVWq7ehKjtsoBTIgkGXZJkW6xVGLsiUxxZW7mRy1hyEtc3CJVSf9eDH
   w==;
X-CSE-ConnectionGUID: Qh6C12C/SLinnvvR4S06kQ==
X-CSE-MsgGUID: WvCFNy87SJCyaFTzOihOmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15433798"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15433798"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 02:09:09 -0700
X-CSE-ConnectionGUID: 95HmH3YHRO+cobVMF/7/mg==
X-CSE-MsgGUID: t9f9XjLCTdyQThXsPgYl4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="78942601"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 02:09:08 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 04EEF11F7E1;
	Tue, 18 Jun 2024 12:09:04 +0300 (EEST)
Date: Tue, 18 Jun 2024 09:09:03 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/1] container_of: Document container_of_const() is
 preferred
Message-ID: <ZnFOrziVMDwtu1NA@kekkonen.localdomain>
References: <20240617100825.2510728-1-sakari.ailus@linux.intel.com>
 <2024061702-vexingly-hypocrisy-d93d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061702-vexingly-hypocrisy-d93d@gregkh>

Hi Greg,

On Mon, Jun 17, 2024 at 12:44:55PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 17, 2024 at 01:08:25PM +0300, Sakari Ailus wrote:
> > There is a warning in kerneldoc documentation of container_of() that
> > constness of @ptr is lost. While this is a suggestion container_of_const()
> > should be used instead, the vast majority of new code still uses
> > container_of():
> > 
> > $ git diff v6.8 v6.9|grep container_of\(|wc -l
> > 788
> > $ git diff v6.8 v6.9|grep container_of_const|wc -l
> > 11
> 
> That is because container_of_const is new, and you don't normally go
> back and change things unless you have to.  Which is what I am starting
> to do for some cases now in the driver core interactions, but generally
> it's rare to need this.

container_of_const() does provide a useful a useful sanity check and I
think we should encourage people to use it. I'm happy to see many macros
under include/ use container_of_const() already, but there seem to be more
than 1000 cases where the constness qualifier of a pointer is just
discarded just in the scope that got compiled with my current .config (not
allyesconfig). While the vast majority are probably benign, I wouldn't be
certain there aren't cases where the container of a const pointer ends up
being modified.

> 
> Also note that container_of_const does not work in an inline function,
> which is another reason people might not want to use it.

Does not work or is less useful (compared to a macro)? _Generic() would
need to be used if you'd like to have const and non-const variants of an
inline function but I guess in most cases macros are just fine.

> 
> > Make an explicit recommendation to use container_of_const(), unless @ptr
> > is const but its container isn't.
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  include/linux/container_of.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > index 713890c867be..7563015ff165 100644
> > --- a/include/linux/container_of.h
> > +++ b/include/linux/container_of.h
> > @@ -13,7 +13,9 @@
> >   * @type:	the type of the container struct this is embedded in.
> >   * @member:	the name of the member within the struct.
> >   *
> > - * WARNING: any const qualifier of @ptr is lost.
> > + * WARNING: any const qualifier of @ptr is lost. container_of() should only be
> > + * used in cases where @ptr is const and its container is not and you know what
> > + * you're doing. Otherwise always use container_of_const().
> 
> I know of no cases where a @ptr would be const yet the container would
> not be, do you?  So why say that here?  That implies that it is a valid
> thing to actually do.
> 
> I don't understand the goal here, do you want to just not have new
> usages use container_of() at all?  Or are you trying to warn people of a
> common problem that they make?  Having a const @ptr is not normal in the
> kernel, so this should be ok.  If not, send patches to fix up those
> users please.

My immediate goal is to encourage people to use container_of_const() for
the added sanity check and stop adding technical debt (code that ignores
const qualifier). Currently people also do think they should be using
container_of() instead of container_of_const() because the pointer they
have is not const (at the time of writing the code at least).

Eventually (or hopefully?) adding that sanity check for container_of() may
be possible so we'd again have just one macro for the job.

-- 
Kind regards,

Sakari Ailus

