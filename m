Return-Path: <linux-kernel+bounces-420580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C279D7CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFB2163272
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5D187FF4;
	Mon, 25 Nov 2024 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxH1O/A2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48CE5103F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523087; cv=none; b=EOCrV15ty888FQAQAPNbWlOA7+TnOao05ngwVg4+JxzymEFdhVCgLy9yYms9gyZyqiA16p9D7K6aoa1PQ6CXKR1AZsARxo/iQRoDcYd0TqsrxkhQHvdH03H1V+jkPQCIcrzjaGWFM1OHReRdOkqM/eYYc1AdGNR0B5jbj4nvq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523087; c=relaxed/simple;
	bh=dPUNVugbmIRxF6aWi9RGx4qnGP53t1NnPpGp+0stUu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKPqZpmio+9s6Vce4baOELq450FjMcFpery+SB1OqozQD1wTPx4Zj4iHyVDNqQPBw0BaUB8MTUE/zKEGSLRDNjgOxLDBq7YM/0BeEvMB8TnDQ/1VRBmDqpxymrlQWVCPDSINtZ1y7bOKGqQrl8jrC5JFmQxTjDqV6aFO6ustbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxH1O/A2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCBCC4CECE;
	Mon, 25 Nov 2024 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732523087;
	bh=dPUNVugbmIRxF6aWi9RGx4qnGP53t1NnPpGp+0stUu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxH1O/A2zC6PQvYSorwjvffnXOLp/MsZtwKotyXj2skgO+VXPMYg764DwqavcXGxa
	 3BKPgOg21mH+x/OpLvxyjCstT+4Fvn/QbZLxu2h4wUUKc0NFh1xUTJSFuRcKH5MeXb
	 54PXMUQao4i/gcPJzMB9Gx5UuY3c/yoWx59zOIuysS2dxXqkbBfsM4utCwky/pZ05e
	 TRZLuYzUyp3FVyAJNxky4ex9vd3PUVmiQ+Q8PgYJF1tmX/XYl8ahO5Yr4NXkO9GszH
	 xSJFyQBM2Vw1cLEiT5zDSsqe9IBJ3bg5r2oQTZ/gwdGHWgBdKiVy9MVwlXvUn1Je00
	 +0Rcbdtv4lhbA==
Date: Mon, 25 Nov 2024 09:24:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
Message-ID: <Z0Q0PJzTMg_Or22I@gmail.com>
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
 <Z0C3mDCngAf7ErM2@gmail.com>
 <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Fri, Nov 22, 2024 at 05:55:52PM +0100, Ingo Molnar wrote:
> > > --- a/arch/x86/boot/compressed/head_32.S
> > > +++ b/arch/x86/boot/compressed/head_32.S
> > > @@ -24,7 +24,6 @@
> > >   */
> > >  	.text
> > >  
> > > -#include <linux/init.h>
> > >  #include <linux/linkage.h>
> > >  #include <asm/segment.h>
> > >  #include <asm/page_types.h>
> > > @@ -32,6 +31,10 @@
> > >  #include <asm/asm-offsets.h>
> > >  #include <asm/bootparam.h>
> > >  
> > > +#ifdef KERNEL_PROPER_HEADER
> > > +#error Do not include kernel proper namespace headers
> > > +#endif
> > 
> > The canonical solution in such cases is to use the existing header 
> > guard, ie:
> > 
> >  #ifdef _LINUX_INIT_H
> >  # error Do not include kernel proper namespace headers
> >  #endif
> > 
> > Then we can skip defining KERNEL_PROPER_HEADER as well, and this change 
> > will be purely to x86 code.
> 
> Yap, I know, thought about it.
> 
> However, if we have to protect against every header, then we will have to do
> a big
> 
> if defined...
> 
> which doesn't really work.
> 
> For the above example:
> 
> #if defined(_LINUX_INIT_H) || defined(_LINUX_LINKAGE_H)
> 
> and that would protect against the two headers which are included here.
> 
> If someone includes another one, it won't fire.

And if someone doesn't add the ugly KERNEL_PROPER_HEADER defines to a 
new header that somehow gets included into the decompressor build 
virally, it won't fire either. I think it's better to concentrate the 
uglies in the 'weird' code, ie. the decompressor.

Also, what's the root problem being solved? The changelog says:

   > no collisions and ugly ifdeffery when those kernel proper headers 
   > get shared.

But that's pretty vague - is there some recent build regression this is 
responding to? Which kernel headers collided with which headers used by 
the decompressor build?

Thanks,

	Ingo

