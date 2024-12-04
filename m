Return-Path: <linux-kernel+bounces-431315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2E9E3BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37719B26C66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE91F6688;
	Wed,  4 Dec 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxFU4rYn"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7391B85CA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320746; cv=none; b=OTsh7jy4MMjgTpoh5lohTgE1idGYgeQrs3Su3dueWFNaSjC9qT0l/ThipSgrfQG1EraKjSXehSTzBpcf6JoLwrkhylnSTO0upBzHrTgiQXlvMol3fuSb/EAon2Lxvb2Nu8O0XzYEmDghVJw2wFRljpVLwzLqa6/crKtijvLA71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320746; c=relaxed/simple;
	bh=h+I9a18brvfcXfamplXm1IUv1WGTQgP89NzSRG9bAxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKsbw9WsVIncsByK+CtEakTH6ShKR6FR3VGhir8d7+HEQzQXm5rvQXHDoQcSmF/IjdmbFm9G9sC2o0Nr4bq8N9ZVUhDwmyI/flkeadP9hOKFLoGZBerveu8q/yxegctfIjNIwyBqzfukuVrw9YBSIUXYl4pXzyPUVB3jR3yoCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxFU4rYn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df67d6659so10808185e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320743; x=1733925543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHK1HVNEZ43w2Z1xUykye6r5z7hYi8iWdxWZtLZeFMk=;
        b=lxFU4rYnyz9HjbWbaaYmvk9fupLtKXwYjyjRV0+T0NHnM9UdhWv5uuOMtmdEvZM/6Z
         rIX7UoAQtbHd34Wfw7NdYdskZMZzDN/y6dDEBhHdBtAthCpyikeZeUivnd/wy12LzxYF
         ggKrTcE3iW0hey0rJfnNOgf4V8vg9bbU2S9xwYfA5mYAK8X7TtjQrnVIrRM0hRQAGeWm
         aW6IROh14fjgZ6zEdn0kORkDRca+Pz4bifGS+ZzajqljzdqGKWd8SiduWxlmHwB7SuzA
         fV32FrBH1tZ6DiU3yEZCV4SDglIozHLFYnbW8w/SdQyL1WcSM4B2qlzMmlOy7TkJyr92
         0YPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320743; x=1733925543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHK1HVNEZ43w2Z1xUykye6r5z7hYi8iWdxWZtLZeFMk=;
        b=hJ7sdZMGgLlVvMrNCzB+2yKpb+t0qzTCL6knLyAZ9Y5JvdyeEeA2XGooFDmycqwsJV
         3nYZPugSWOxR5pCDord435l3nxAfJH0INTX81mnohkwo2PvJkAP3yc6egjibenPsbVZn
         X2L3U3eB+ITGHuXov80SukjQC2Cl2fejCL/R3HIT/EPi8E18MGnGqWz8B3iAQE95Na0P
         /Ac3+vwkrg56A1QZTaBFUsCZQFSH3BgBe636WzRKRWjzHaXmShJcpGKbHI8KdarWN3TN
         4rLepyVxF/OFDvooXh8FkLNw5cyrRFaN/f0+VFa4vXIcT7yspxSN4Qk77Af3QIX2tmu0
         EZ4Q==
X-Gm-Message-State: AOJu0YzYvpmYQ2g/KfiUBXl1HyCtPJb4bAHLi+cz1/c+FQYBluoAjB/i
	BxOdwSjFZ7P6sY+nq6djrVOOfOqjG/dpEAmZfRAyCsjwB887dk+LETpEzQnnb673KYT9/fwEIee
	A7KRVqAxz0I3NytaCNSWYd5zUXBBb0c1ztC4BQQ==
X-Gm-Gg: ASbGncsyp5jPjFL67ApUyNi7hSFsV3ZUYLT9yjxyaSWEcj5iGuHaIq9NnoL1Htrcost
	q2OxdzAahe7a8+kIAtfE2HQklQyIr3g==
X-Google-Smtp-Source: AGHT+IFUO9mBPhpg6S0Kvk3PDrX6OFpFY+tvVAd/2zYNYYChe+XyIM673D7LgWSMhxfZcFzoPfmo0nt91APgbJwU7p0=
X-Received: by 2002:a05:6512:39cb:b0:53d:a3a7:fe84 with SMTP id
 2adb3069b0e04-53e129ef587mr6063237e87.8.1733320742975; Wed, 04 Dec 2024
 05:59:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204102904.1863796-1-arnd@kernel.org> <20241204102904.1863796-3-arnd@kernel.org>
In-Reply-To: <20241204102904.1863796-3-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 4 Dec 2024 14:58:51 +0100
Message-ID: <CACRpkdY243J4C3A9_13eTN84T2SeOjyoh0bWk6U1mqffUd6urw@mail.gmail.com>
Subject: Re: [PATCH 02/15] ARM: limit OABI support to StrongARM CPUs
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
> As discussed on the mailing lists, there is no way to build OABI userspac=
e
> binaries any more since gcc-4.8, and now support is also getting dropped =
in
> binutils, which will make it impossible to build pure OABI kernels at som=
e
> point in the future.
>
> I found no evidence of anyone still sing OABI userspace on embedded syste=
ms
> that keep getting kernel updates, but there are a few desktop-class machi=
nes
> that date back to the 1990s using Intel StrongARM processors that were
> supported by old versions of Debian, Red Hat or the official Corel
> Netwinder distribution.
>
> Add a much stricter Kconfig dependency for both native OABI and OABI_COMP=
AT
> enabled kernels, only allowing either of them to be selected when buildin=
g
> a kernel that targets a StrongARM based machine.
>
> Link: https://lore.kernel.org/lkml/2831c5a6-cfbf-4fe0-b51c-0396e5b0aeb7@a=
pp.fastmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For
>  arch/arm/configs/versatile_defconfig   |  1 -

Acked-by: Linus Walleij <linus.walleij@linaro.org>


> diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/foo=
tbridge_defconfig
(...)
>  CONFIG_ARCH_NETWINDER=3Dy
> +# CONFIG_AEABI is not set
>  CONFIG_FPE_NWFPE=3Dy
>  CONFIG_FPE_NWFPE_XP=3Dy
> -# CONFIG_AEABI is not set

Hm why do we need a separate netwinder_defconfig if this defconfig already
supports it?

I am occasionally booting the NetWinder and then I use this defconfig,
the netwinder_defconfig wasn't even working for me.

Do you want to propose a separate patch to delete netwinder_defconfig,
otherwise I can send one. I think everyone (which is like ... 3 people) are
using footbridge_defconfig.

Yours,
Linus Walleij

