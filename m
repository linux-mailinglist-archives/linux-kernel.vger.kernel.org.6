Return-Path: <linux-kernel+bounces-431326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B13BC9E3BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DEE280D01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B81F9EAB;
	Wed,  4 Dec 2024 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtcCIGnQ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDC1B86CC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320938; cv=none; b=ZNBohd6fvuxuJt3s75PaOUu/nxlIMTIs8JZhis8j46s+Z73HEf4B+7hzzeRgVH96ykTBW+jQpwOeiIDy5N4ABLTjyix2cZe77jFVbbY4NEIc8jPNh9oYnaQkuuggMECAvNci8efqLBWrQ4EsctCo1oqpdiiQJ3Dz5kS9rMK0x6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320938; c=relaxed/simple;
	bh=EF6Gt+T6W7BZkopuI+DSu4Amz2QuoavNBsIjJLhIag0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PU+pDOSsNCWfO8lfVYibZ2jDfbnGgOrtUn4Hw+GLZOtYsmCqzIuHrDy7gfxJivBJPYw9hp6QFUcVIQ48TimEsAc/jDMoKuQ+HyeuFwTb9pl0UPoB08uKsu67jDSEybawa678QOmT5OGMG12z1jpNwf8gQP4cLDJKnHbaA17tbGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtcCIGnQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de7321675so7336749e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320935; x=1733925735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqP87WCiN6ncxgmgpniBE1T1mI3RT4GMjwb4A1C8J6c=;
        b=xtcCIGnQ9CYcxGWexOBUEEJxxhAe/eAXRx2/6DQS7N/TT7h4qnNhNKsPzGD073yPTh
         NBk2Yhr1MMuuRK6uAUkNnCB5fK2SrCXxg0T1N9uy3lPdzOiv6K4tVJ87ptvYbfDzFWqi
         lV5GsQPKAhkt+1QTBrZTomopWxOr84/lfOyyq/XMVRYa8E1jykHPz7Bk3lmRxd6BWY/t
         sJQ3oHI89DzsIBHnkfg8Ql+AuI2VnxW5FukOpF/RcohA9i5zJBGpNaI2G42rSVuaQQqj
         JJlvucWJXiyK0IW6/bAccaS5OUJ6d0TbPc/q8KT72FMHC/0jpirJPpxchJA17GCE67F/
         nWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320935; x=1733925735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqP87WCiN6ncxgmgpniBE1T1mI3RT4GMjwb4A1C8J6c=;
        b=F8KL7laYOQXLSARBaTPBapWK7nUXSl4pVcFR5weCd/gkCbDkvJlExmdqNqro1lcjKv
         LvcCkey57eUFJc0p78RknDLAyYoPEl7TdpqaHCxr/nSM6Ky0L+l0QaR734f0mL4z/f2Z
         YCN7TGne/v0Fxa+fMvkK0YmSQG4k1GeedUI4rvHOISG4D45DebkqiRnIkE1fH6e552Lv
         gL1Mn3l1/1YkDG8rxfBufYnvOloq2igWJpccVBSPqFm9rWEMAeJOJd7nSVHvIBp/C99H
         BORtCM+cGG4P58md1SW1Pn+hgPWY9u3SGShoNVwQDnYnBulywDrVdBrlTa6BK9KSwOuo
         kLNQ==
X-Gm-Message-State: AOJu0YzoNYhvP0/5vBjoey0qWBObbWeesDRkIYhGinLBZi7vJ6sFyuhq
	OisiFrhHJfHI9kepGRXX3MrsCjqKrzIq5+8hfptnqMyOth/G9wWnXcaGEy9lhOvaOeTSVKRPxFN
	7DDJuiadZFP8eOZgHHKBofOzK9+SoJCynYUNRqg==
X-Gm-Gg: ASbGncvTPBABBh8cf54uOcvV4WWqZ9Y0aZTF9elZglbuwrQh+bTGtiGc/WYdHbYNIwz
	eSqOBAE/+3W2a3VfPe6CzJAgt3ZrRBQ==
X-Google-Smtp-Source: AGHT+IF42JEDDralS/q7GAyf8ShLhuPw9fjRPS3IF1nVPtKZCVFYhoqWECbNYFk03ea8B3Fz+6drL1O/4aVN2nZ4eJw=
X-Received: by 2002:a05:6512:1256:b0:53d:cb91:2f3e with SMTP id
 2adb3069b0e04-53e129f36c8mr4029043e87.22.1733320934341; Wed, 04 Dec 2024
 06:02:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-4-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-4-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 15:02:03 +0100
Message-ID: <CACRpkdYws_rfGPe--xj8d4Gu1pON=_T2sSAoTi3=sMz7wpSFHQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] ARM: rework ARM11 CPU selection logic
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
> Support for SMP on ARM1136r0 has been broken for a while, and nobody
> is working on fixing it. I had a plan to change ARMv6 support to no
> longer coexist in a common kernel with ARMv7 CPUs but instead ARMv5 and
> below. This would have addressed the problem, but after a recent mailing
> list discussion, we concluded that an easier approach is to just forbid
> ARM1136r0 CPU support on SMP-enabled kernels.
>
> This mainly affects users of the Nokia N800/N810 tablets using an
> OMAP2420 SoC, which is the only commercial product with an ARM1136r0
> that is still supported by the kernel.
>
> The other machines that are still in the same hardware catogory are:
>
>  - TI OMAP2420 H4 reference board
>  - TI OMAP2430 SDP software development platform
>  - Freescale/NXP i.MX31 Lite Development Kit
>  - Buglabs i.MX31 Bug 1.x prototype
>  - Arm Integrator/AP with CM1136JF-S core module
>
> To my knowledge, none of these have any actual users aside from
> reference boards being used more easily test the platforms.
>
> There are also a few ARM1136r1 machines, which implement the
> ARMv6K SMP support (barriers, atomics and TLS):
>
>  - Eukrea CPUIMX35 reference platform
>  - Freescale/NXP i.MX35 Product Development Kit
>  - ARM Integrator/CP/IM-LT3 with ARM1136J Core Tile

I can't test that, I doubt anyone can. I think this support can
be simply deleted unless there is some QEMU support or
so.

>  - ARM Realview/EB with ARM1136J Core Tile

I will check if I have this one, otherwise this can probably go
as well.

>  arch/arm/mach-versatile/Kconfig | 10 +++++-----

For Versatile:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

