Return-Path: <linux-kernel+bounces-241082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D79A9276DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA341C21F94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A21AE84B;
	Thu,  4 Jul 2024 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FWDMpn8J"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C01A0AE5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098614; cv=none; b=XgtLJfrNOHFSf4SHD0/R09nq+ztFqhCW3e5tcEPOrEBDX2s7o9xyKfAeZWUg6bTUqvBR/FEzFerUunN8WrVUPCWHjjAvkDRsye4YyvXTyaVXCnC8r40TJbr4Y4ndUKF0r3zzIRfUPZ8PiIwvXJLjGzC+4HxW5WiTDet1XNRSQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098614; c=relaxed/simple;
	bh=1CDGB69UHFEw3XzkNuVDc1VX8QtbcXOxGcKZ6MzsdRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xl3osobDeNgOLWIK0pjSkP0uRZ0fWn3C00kuuD8rmVWevMxM7Nkiq0TZeLLvq8DF2GXsoHm/D7W40O18l33A2WbzOjmIb87fu8njE3Aslb0/le54ioDesTMtFgqBKnp4f4ogE6fkJstnKxoFDEFoGs9hYJ8xxsRb1/sNLwxlVvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FWDMpn8J; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720098610;
	bh=ktD7Ha3VJC6ylAvsp6i9aJB04xtxImlbVah9Wk9oUdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FWDMpn8Jy2xbMsZMuOl4tkksRAKiM2V9NQfTC2G6ugWEbBpObF74amfCqOGq+ky01
	 jpO9qzpXXOPALsrFHLQLpuUYtkIjoXf4UojeD2S5L6KwGIc9+IGazjYJ1vUgac0p9v
	 vGI5TXZF91Ni6V8KbHKiBep4d51W4DtUT/vq452aRtRH9Lc6LgKXNlJIqgMR9I6ZLb
	 L2ERP6vCxXneBzQmzt0xd4qTmaavkxnyVAev+vRaikx3ELwfKm+rl6eDw50JF6WYhB
	 6x241zDyYcnWpRPX8sEbVkslJ9ioyLWOsQbR3RamU+b+ZdgPcot6hqQ5de5VauJlR3
	 OHtaA+DyxJiIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WFH7Q0Wt4z4w2M;
	Thu,  4 Jul 2024 23:10:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anatolij Gustschin
 <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: pdm360ng and touchscreen set up
In-Reply-To: <ZoNHLjmSvCN12vU5@google.com>
References: <ZoNHLjmSvCN12vU5@google.com>
Date: Thu, 04 Jul 2024 23:10:09 +1000
Message-ID: <87r0c9i9qm.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> Hi Anatolij, Michael,
>
> I hope you can shed some light for me: why does pdm360ng have very
> elaborate set up for the "pendown" GPIO of the touchscreen? Can we
> simply fix the DTS in arch/powerpc/boot/dts/pdm360ng.dts and specify
> correct pendown GPIO there, as well as correct interrupt trigger,
> and remove most of arch/powerpc/platforms/512x/pdm360ng.c ?

Sorry, I don't know anything about this platform.

It looks like it's some sort of embedded display device? It's pretty old
and hasn't seen much activity for ~10 years.

> Something like this:
>
> diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
> index 67c3b9db75d7..5651bd9d9db3 100644
> --- a/arch/powerpc/boot/dts/pdm360ng.dts
> +++ b/arch/powerpc/boot/dts/pdm360ng.dts
> @@ -176,11 +176,12 @@ psc@11900 {
>  
>  			/* ADS7845 touch screen controller */
>  			ts@0 {
> -				compatible = "ti,ads7846";
> +				compatible = "ti,ads7845";
>  				reg = <0x0>;
>  				spi-max-frequency = <3000000>;
>  				/* pen irq is GPIO25 */
> -				interrupts = <78 0x8>;
> +				interrupts = <78 IRQ_TYPE_LEVEL_LOW>;
> +				pendown-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
>  			};
>  		};
>  
>
>
> The reason I'm asking is that I want to remove support for platform
> data in ads7846 driver and pdm360ng is one of the last 3 users of it in
> the kernel.

I think go ahead with the change, and if anyone is still using this
device they can speak up if there's any problems.

cheers

