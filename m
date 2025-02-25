Return-Path: <linux-kernel+bounces-531540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA092A441A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2387A94E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E14D26B958;
	Tue, 25 Feb 2025 13:58:40 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A526B2B8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491920; cv=none; b=MM/HZPP5Jyx8KptfHyTUVgR0pT+GU1/r2BKwn5vMPhgO3Xj0ErsGVUUhHyZ09XvoRynE8K5s+P+dXGDDiQIb05x+nb2IkgNwEXrXC3n/G8x7pt/CIMQ6WSz1OTI7GazmF2l5bNKBiM4DFKhLR0ySRc2YszZsI4U1nJk6FirbHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491920; c=relaxed/simple;
	bh=9Ry8UCXH97A+xa9D+Tan6hCfWl3wRKXIOp8GynzNJkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd68sIBohzRGd1FylRHx8UjxtLTuFrRZP+i/rIfoGgFhtXdheCSagYb79crOsyu3IglHeWotfxD7RCemiF/DBlI/MFnVz2jp0IpJxdaWnLY8M0t5ypKVF7NohUzxh4kg/6tDkehXQwlIfWIfMRA3YmNTWz1opX9ru9XFFgtqOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gnumonks.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
	(envelope-from <laforge@gnumonks.org>)
	id 1tmvSD-003lBM-TC; Tue, 25 Feb 2025 14:58:34 +0100
Received: from laforge by nataraja.fritz.box with local (Exim 4.98)
	(envelope-from <laforge@gnumonks.org>)
	id 1tmvRy-00000000a9g-3PWX;
	Tue, 25 Feb 2025 14:58:18 +0100
Date: Tue, 25 Feb 2025 14:58:18 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, david@rowetel.com
Subject: Re: users of drivers/misc/echo ?
Message-ID: <Z73MevharqkC5dt8@nataraja>
References: <Z7tZhYET41DAoHVf@gallifrey>
 <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
 <Z724l3DFJbGevtPF@nataraja>
 <Z72_EnXyHoDACRk5@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72_EnXyHoDACRk5@gallifrey>

Hi Dave, Arnd, Greg,

On Tue, Feb 25, 2025 at 01:01:06PM +0000, Dr. David Alan Gilbert wrote:
> > However, those DAHDI-using deployments that I personally am familiar
> > with do not use the software echo canceller discussed here.  On the
> > other hand, I'm quite certain that there are many PBX/IVR related
> > systems out there (unrelated to my area of cellular or trunked radio)
> > that would still use the echo canceller discussed here.

I have to correct myself here:  "that would still use software echo cancellation".

As I stated before, in "my" deployments, the echo canceller is not used
and hence I'm not super familiar with it.  My use cases either don't
need echo cancellation, or use hardware echo cancellation.

Revisiting the DAHDI source code as a result of this thread: There are
actually several different software echo cancellation implementations,
only one of which (oslec) is using the drivers/misc/echo.

> Some questions:
> 
> 1) I see drivers/dahdi/dahdi_echocan_oslec.c
> 
> /* Fix this if OSLEC is elsewhere */
> #include "../staging/echo/oslec.h"
> //#include <linux/oslec.h>
> 
> now that moved to drivers/misc in 2014 by Greg's
> 6e2055a9e56e ("staging: echo: move to drivers/misc/")
> 
> So is most of this on ancient kernels or do people
> actually use modern stuff?

Actually, looking at DAHDI, I really don't think anyone is still using
the dahdi_echocan_oslec code.  It is disabled by default and only built
if explicitly enabled by the user, and indeed if anyone did that it
would fail to build for any kernels that have moved it out of staging.

> 2) I see there is a fir.h that's different from the kernels
> drivers/misc/echo/fir.h  doesn't that cause problems?
> Should one get updated from the other somehow?

I'll not investigate that given the above determination.

> 3) Any idea why it's never been upstreamed?

I can only speculate, but I guess it was never a strong priority for the authors,
and indeed likely the code would have had to undergo quite some changes.

DAHDI is clearly well beyond its peak user base these days, and I would
expect the amount of effort into mainlining it, together with the
associated risk of introducing bugs during required refactoring simply
doesn't make it an attractive proposition.  Also, given that userspace
applications for it have been around for decades, it would be impossible
to address any upstreaming related change requests without rendering
those applications incompatible.

So I'd really not bother at this point anymore.  The few adjustments
I/we had to make to keep it building + working with recent kernels over
the past few years are minimal, and mostly trivial stuff like minor
kernel API changes.  In the end, DAHDI doesn't interact with a lot of
other kernel.  It talks to the hardware via its own device drivers, and
it talks to userspace programs via character devices.  So unless some
core kernel memory allocator, or PCI or USB device drive APIs or
character device API changes, we're mostly good.

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

