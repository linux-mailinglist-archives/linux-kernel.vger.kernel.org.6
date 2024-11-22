Return-Path: <linux-kernel+bounces-418529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38AE9D62B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22608160750
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158521632E0;
	Fri, 22 Nov 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VhgonB3Z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE813635C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294973; cv=none; b=hyiPlTjnKzxPBIeWgLAkQnVjihXUGTTBMZALQ/2QTaWd/AzepALECFHQ2wvLPoEOfqFhAOoqbaXA9YYLUnz5hMrI2gbLvA+vutOR32itl7mg+6LQUlToARp0DXlQHbSMBOCwXLrlZTXRtavA0Bn/YzoCrDJ3/V8IzhB/CNechJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294973; c=relaxed/simple;
	bh=7fbd7Ld1ViG0BLokE47IN77frd7qcv7irRwbdIdIRHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFNzW+9KIT1U4PvYwE2IYLFz3swY9MefpTRfSvClUHpeF6Uyb2QZ9P9HLcMA6L3HnnGdQcMFjo78+lWhkoFqfA7kAnTrExCwJusj8o9ZpRUbbNxfb3OOuljEZhE7iXMlhJn204gaM2WbmPU6Fln+TeMvz4//puSzDjm6EOWln4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VhgonB3Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 52F1340E0208;
	Fri, 22 Nov 2024 17:02:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wRKU92AfI2H1; Fri, 22 Nov 2024 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732294963; bh=MrTk+cIadO8/AF/qCmYvAa6wIvc/QX883KVMlR2EgQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhgonB3ZV5Fao0g7cskRa8g3EMP3JV0boaIlAE56/sNMSKtbleDtiBRGna1ddsfne
	 oLeffVgOsZ7lbOCfEOnaROkr5yXQ8mhT7o4tWIhALZOQDu6sLj19Vbjf++ya+sTbSK
	 hWe+35rDAttMWHKbMBK5sJfv3tVpVfy2l07VJiiXnFUMfO9SBXFJyKzp0Ol2Zw0MBI
	 wJkHoI264QCbMcVY1LnBuS0t+yye4a9MwOmM2scUY4mKN9O9Woo9Ic9hRUWMx6YjW8
	 CAcp/FgPrS6eRY0climEQTnEnNd+2KxtXGNiZpiqv7al+eyxAu4S5Cl5U00dSYNQUa
	 sX+jFQHgwR4kuwcOb3ZsOLXrKAPtO9REYT1D0zLMh0CJJZ4z4cCM7z7e9TPJU6Fs5n
	 M924rUJhIFulDbnw/szHOhPVJ4DREzEdDhTPPQR5HYsC4cHxIwmyB939kb3Cuyu0YN
	 IUE9z2Tlr3K9lY/dLUtaN2QUwOkcNK6D55sNO6GEN/73xbLe0LUECPpHNYu0vDCq81
	 N6qtPjIOeNu67OkDgPUADR7c/lCMJaPcxH52BsJs8Ohb1MobJXxjBmwQ4H5Gt24LKT
	 1ZMo7vzXdR7QpUmuICMNDAi4LjWlqKtA8f+l7YHXbfO1Qkq4txYwr17/jSDKLALO0e
	 VJNuIC85PMfqRpTywIlRmRqM=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5684B40E0196;
	Fri, 22 Nov 2024 17:02:39 +0000 (UTC)
Date: Fri, 22 Nov 2024 18:02:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
Message-ID: <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
 <Z0C3mDCngAf7ErM2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0C3mDCngAf7ErM2@gmail.com>

On Fri, Nov 22, 2024 at 05:55:52PM +0100, Ingo Molnar wrote:
> > --- a/arch/x86/boot/compressed/head_32.S
> > +++ b/arch/x86/boot/compressed/head_32.S
> > @@ -24,7 +24,6 @@
> >   */
> >  	.text
> >  
> > -#include <linux/init.h>
> >  #include <linux/linkage.h>
> >  #include <asm/segment.h>
> >  #include <asm/page_types.h>
> > @@ -32,6 +31,10 @@
> >  #include <asm/asm-offsets.h>
> >  #include <asm/bootparam.h>
> >  
> > +#ifdef KERNEL_PROPER_HEADER
> > +#error Do not include kernel proper namespace headers
> > +#endif
> 
> The canonical solution in such cases is to use the existing header 
> guard, ie:
> 
>  #ifdef _LINUX_INIT_H
>  # error Do not include kernel proper namespace headers
>  #endif
> 
> Then we can skip defining KERNEL_PROPER_HEADER as well, and this change 
> will be purely to x86 code.

Yap, I know, thought about it.

However, if we have to protect against every header, then we will have to do
a big

if defined...

which doesn't really work.

For the above example:

#if defined(_LINUX_INIT_H) || defined(_LINUX_LINKAGE_H)

and that would protect against the two headers which are included here.

If someone includes another one, it won't fire.

So we need a generic way to identify a kernel proper header. Either with
a define like KERNEL_PROPER_HEADER or some other magic (I don't know if there
is something like that), perhaps some preprocessor hackery which can figure
out whether some of the include paths have a include/linux/ in them and then
error out if so...

Maybe I should talk to toolchain folks...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

