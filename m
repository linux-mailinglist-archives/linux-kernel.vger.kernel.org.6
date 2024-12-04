Return-Path: <linux-kernel+bounces-431308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C559E3BCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1682830B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DC1F7061;
	Wed,  4 Dec 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4Ef63jQ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356761F667F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320479; cv=none; b=W/S0r5BrIyizHy2VINHsAS/8CUPnyf6DY0fl7Y6Z/CtqTQHAvUPwovOBPiEt0gD1KXGug65rEw0r1Q4trRuMss4yZBJesQOyXYIpB24jq17yHd+vARJH4N+VnjdDbrj8lv+f4p0AjMcROfKoeW+ttQt/Vl6h6pDzeq4qNfUSpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320479; c=relaxed/simple;
	bh=BjVJ/PKS6q7Pc06kHiso617H0t6nWlD4oMRTdfHBhA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTHA8ruHWBK9yxBDrSZrLeDU/pB77vlOwpHq88wD+NyKPNdwNfYzFEG0f/LDtDvRYxR6NOsVwCbZLC8QQcSYd/k2hLmNqiCy7IcSxe0RqF3yo0NbrtiQhpXO3TFzfxetNA+zGnMuWET5QWIqCCL/VzLhyHjAC6Z/rIq2cVL2qdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4Ef63jQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de79c2be4so8206378e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320475; x=1733925275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5dJWCCGmuo/rrbDElavgBYIrX7vdAKrghhtXY8nXwg=;
        b=L4Ef63jQlBTqyI2P0TzJ1TeYEdvN1L7p3Mr4JOx5o9gF8vyGSVgjBV1nPX2Z4rS0Qh
         2OUAidpMPA3miqtudL2cbe/3kWbT+fVgjv9V7pVpIFk4xA4rOer28TEF+3mCjRRADP1n
         I6FLRbUvcIh7SwASQRE8RC2y5xko4gIwaNc9c3N7O2jieNWx+d2qqmg3/8bWvzFVchaS
         hj7CwMqtfFDiaBC8BejhbCJ4BJsZsFFG2UWW7xZ7MJkIM+RhleF4FVrQiQWLduR25cDd
         Ole+PKC7wQvZSxGefFl+grr9wnrS9n0bboFpthn7LJAB4iSj549RTEfAhfADjJvNoFwp
         65NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320475; x=1733925275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5dJWCCGmuo/rrbDElavgBYIrX7vdAKrghhtXY8nXwg=;
        b=IVPChf4WIO/vCx8b5CeMY47MdQjPvfaBk5Casd3qWWJOxtZDY2zD64A/D0jnzpAc6z
         O89O6EmtsF/H+IETZPdWKkaUJ3FLHP3MGzIAjxQdfsxUkyPNXmVFQmwN4fix5Q5L/cuY
         mbdofbQSB8BoVxds7MjDrV3du4smTO6y3kJiMSPmU3RgQNITbf7GpnmDBt5OlDv3rSbF
         QLzA5vMshw4Fd+Bu4yzjU3FHHFh6BP4bQBifsDmwrbeZnD2XbqGn2Thn5vlQwpUfZPnc
         w+oot8mB+TTnZ1G1mbG3DN3vmqaB38Qx2R5ua6ky+c5s5weN8UDAg5Nh2vkiPe82kZt8
         LNeA==
X-Gm-Message-State: AOJu0YxTNpozbiZYufIkszK3CUfbx4WdJe6Mr7v7WYkUYH9aMVGYQZks
	wgLwh2t/uqhUptzZY5Aq5ATYN6Emyd5k1dnk/ap8C3JSyBY1XZtmKy3WaIKEl9DbUnCUlaIHuVC
	6JpC8zvyCIyECM781r5FhCTr1kTwwoWKia9ghbw==
X-Gm-Gg: ASbGncvW6Z5tF3dtsy2kB2MCoZCrZd0wP+SqQK22wyvV29jqWPWA9IGsJb/32w4PYpL
	zXZvxlBx5M9ccAKVFnChKBA6y/9fowA==
X-Google-Smtp-Source: AGHT+IFQAF45jSUX7G+c3P5oVfTSj462ZlR4upknCoRsECBqNzH0Ltm8COxlV0RAMg5Yp5X62i6d6iGKuwvltseW+R8=
X-Received: by 2002:a05:6512:12cd:b0:53d:d467:3aa1 with SMTP id
 2adb3069b0e04-53e12a26357mr3998871e87.40.1733320474328; Wed, 04 Dec 2024
 05:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-2-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-2-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 14:54:23 +0100
Message-ID: <CACRpkdYmCzYT6s3XaQURLW9ak1xvzuKPpm_LB5GM+AzNUHtv7g@mail.gmail.com>
Subject: Re: [PATCH 01/15] ARM: use CONFIG_AEABI by default everywhere
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Andrew Lunn <andrew@lunn.ch>, 
	Ard Biesheuvel <ardb@kernel.org>, Daniel Mack <daniel@zonque.org>, 
	Gregory Clement <gregory.clement@bootlin.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	"Jeremy J. Peper" <jeremy@jeremypeper.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Ralph Siemsen <ralph.siemsen@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@armlinux.org.uk>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:29=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> On ARMv4 and ARMv5, the default is still to build for OABI, with
> CONFIG_AEABI disabled, even though distros and toolchains no longer
> support OABI as a target.
>
> Change the default to EABI for all architecture levels and change
> the defconfig entries as follows:
>
>  - All machines that used to explicitly enable EABI can drop that line no=
w
>  - Machines that are likely to actually use old distros and had NWFPE
>    enabled in combination with OABI (rpc, footrbridge, netwinder,
>    assabet, neponset) explicitly turn it on now.
>  - Machines that already had both EABI and NWFPE disabled in defconfig
>    (at91_dt, collie, ep93xx, gemini, h3600, imx_v4_v5, integrator, jornad=
a,
>    moxart, multi_v4t, omap1) were likely not usable with either OABI or
>    EABI and now use EABI instead implicitly, making it more likely that
>    they could work.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For these:

>  arch/arm/configs/gemini_defconfig       |  1 -
>  arch/arm/configs/integrator_defconfig   |  1 -
>  arch/arm/configs/ixp4xx_defconfig       |  1 -
>  arch/arm/configs/netwinder_defconfig    |  1 +
>  arch/arm/configs/nhk8815_defconfig      |  1 -
>  arch/arm/configs/versatile_defconfig    |  1 -

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I only ever use these platforms with AEABI, and a corresponding
userspace.

My userspace for the Faraday FA526 uses the OpenWrt-resident
GCC --fix-v4bx hack:
https://github.com/openwrt/openwrt/blob/main/toolchain/gcc/patches-14.x/840=
-armv4_pass_fix-v4bx_to_ld.patch
(maybe this is a bit sloppy but it works for us)

Maybe LLVM CLANG can build an ARMv4 userspace without this
hack? I haven't looked closer.

Yours,
Linus Walleij

