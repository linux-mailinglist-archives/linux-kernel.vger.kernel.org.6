Return-Path: <linux-kernel+bounces-516296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9CA36F6B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE90118966D6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0EE1E5B77;
	Sat, 15 Feb 2025 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/Cg6/z6"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197031C84AF
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636421; cv=none; b=UZwEXZApMREHZmQiScrhQWWZcF6ghD4Usl3XTDVxBai9bFEAU7wf6vgQ/bUFuOguDZZEUs2p08nL4qpkdtZyxSIPawRdXw00TL+GcEgMlDNFoy3iOgrnjmzROerX8aiCS1P+iZEdT6y/He6+cjqNwSX5ozS1C/uq33NUDAU0YVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636421; c=relaxed/simple;
	bh=jTkCjPq93a+S+y5RPdqqAWXGTvwpwXWa/3j5eqTS1yg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nro/vsGTb957wDW/rAZUOdu/8fx0fQ/IGl1SXGXijXNfuN/j1LNYPh2uTIRaSgGAa4XysccekFUAkd/H24aSjS3wkTXaOPN6OkvktVQpYQwRXe0BO0tmeZvpSgqSvod/POIbHZABrQxUjWe7KCIJT2/DyiBzvoH+KM//4vlrEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B/Cg6/z6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so18069175e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739636418; x=1740241218; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dNyoNFfqH0PsydSjFbFoobKDexjUlMZLc47JqJwFJrk=;
        b=B/Cg6/z6xdUmMA9On+vj/agiswEFLLcyy3T4d6JnGzqlsegzBkfO+ALYWzefYMBnYK
         27evObyomKvxaDSOFiRXxQodeAekss0XZAiCmkCYdxm875iqPYKo8dPOesi2M+LoUATw
         2WShgbcjpfC90VEWMKDuc0QK1jpJwTEr/4yHAEVKdK6UI6PlfImUemS7dtvq2tLAA1sH
         j5GUJzAMG5YnbceR9RvVF4mwWYySL9/QIHgRCcIHTWf8rJ0uJUgiib/7naJLXvyThm9G
         rLXugRAeUQSVW9TxBJrh5lDnZatbXHMiOFQlxpbR9rOeUhv2vwLHFjVO2NZ7klRqYZu3
         pNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739636418; x=1740241218;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNyoNFfqH0PsydSjFbFoobKDexjUlMZLc47JqJwFJrk=;
        b=OMn4BFqVN+4VyoX9OgEAZSBA9/0TIsXWJvamlB+Ar4UcOv3zhjT/KkLhzKirj0EhUC
         Xp+O8XUJZX4sL1HYirOVoAqn6pIN5thp+YU8lNGr1DYA71LfHQ/PdeaOylQHInXKQ5bn
         PoqiFF2Fbzf7Iq9kjYOBQzEUKLfW+X4cpT++qISfqTaUbyjtKoxqn4oGhWES0iZAiZS6
         xpMn6rG1S5ICxc29eccNQczV7z++0q/y8h3aAQTnYqWHlkh7KTTEIdD6/+EnWXZbiEt9
         sPyh10ZH3ocF8M8WsbFtvt3GkxuhHmqGqSWSINnD2qO5mZ0zTvLEJm0pk8259w8ANZNg
         7rcw==
X-Forwarded-Encrypted: i=1; AJvYcCWhNOTgmpUFzKDqSz+Cl4O9etJAaJlgjkyUIirtaP4dxoX/q/lyczFl10NQoDghuxrk2yb9N5/4F1HD0x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyi7XKaVpXG82F6CUUuY4MT4sXGAivAASOPqULzOx4h1ND9A1T
	zJwwzJWn40ZtK2yOrqoWAcWJSlMQ49UEGFQStfW4MSQa/ruGYJdkPXqaiGq7ig0=
X-Gm-Gg: ASbGnct3ORbuw/G+PBnxpgGU3e1hFbqNksrdXCEgOLxKoFmHWgAVlSskGne5VtJ5XtE
	iuKavAm3jywg/ABt568OqkdkCvaOwu/kLR8hkEZVlVpz0UJDAHUeLTwN2YBZZIHSCHOyZsYCARS
	dgaqvfOTX/1UaVqgxH+ku2KQ7Ks8B6aDvE1GfZh5At19Z5V+Xgs2qqR2amuPU6pvGkAM+Ln5n4c
	uBgAjYWdlp15XP7RO8s7OudVS5jwn4q98g2MzEEMK+GNrOzpCK84HH3imxnwvpG+qeTerxMOQdx
	ZMA3ufzYW+greqKRd/U=
X-Google-Smtp-Source: AGHT+IG1iRvsBX6PLkvzMs5VpNDDf9z76BCIL+JAkXGVtBLduGXf6zEIP0vw/72qC+rgRgHoj9P1ew==
X-Received: by 2002:a05:6000:1561:b0:38a:888c:679c with SMTP id ffacd0b85a97d-38f33f52fd8mr4562539f8f.42.1739636418355;
        Sat, 15 Feb 2025 08:20:18 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa1esm7483252f8f.100.2025.02.15.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 08:20:18 -0800 (PST)
Message-ID: <bc292f121afaacb29fdc7d600c72cb3008b6b56a.camel@linaro.org>
Subject: Re: [PATCH] phy: exynos5-usbdrd: Fix broken USB on Exynos5422
 (TYPEC dependency)
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vinod Koul
 <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter
 Griffin <peter.griffin@linaro.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Sat, 15 Feb 2025 16:20:17 +0000
In-Reply-To: <20250215094122.60535-1-krzysztof.kozlowski@linaro.org>
References: <20250215094122.60535-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Krzysztof,

On Sat, 2025-02-15 at 10:41 +0100, Krzysztof Kozlowski wrote:
> Older Exynos designs, like Exynos5422, do not have USB Type-C and the
> USB DRD PHY does not really depend on Type-C for these devices at all.
> Incorrectly added dependency on CONFIG_TYPEC caused this driver to be
> missing for exynos_defconfig and as result Exynos5422-based boards like
> Hardkernel Odroid HC1 failed to probe USB.
>=20
> Drop incorrect dependency and rely on module to be reachable by the
> compiler.
>=20
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Closes: https://krzk.eu/#/builders/21/builds/6139
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/3c0b77e6-357d-453e-8b63-4757c3231bde@=
samsung.com/
> Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notif=
ier if required")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Patch for issue in linux-next
> ---
> =C2=A0drivers/phy/samsung/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
> =C2=A02 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
> index 7fba571c0e2b..e2330b0894d6 100644
> --- a/drivers/phy/samsung/Kconfig
> +++ b/drivers/phy/samsung/Kconfig
> @@ -81,7 +81,6 @@ config PHY_EXYNOS5_USBDRD
> =C2=A0	tristate "Exynos5 SoC series USB DRD PHY driver"
> =C2=A0	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
> =C2=A0	depends on HAS_IOMEM
> -	depends on TYPEC || (TYPEC=3Dn && COMPILE_TEST)

This line ensures that PHY_EXYNOS5_USBDRD changes to M if
TYPEC is M.

> =C2=A0	depends on USB_DWC3_EXYNOS
> =C2=A0	select GENERIC_PHY
> =C2=A0	select MFD_SYSCON
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsu=
ng/phy-exynos5-usbdrd.c
> index ff2436f11d68..e8a9fef22107 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1456,7 +1456,7 @@ static int exynos5_usbdrd_setup_notifiers(struct ex=
ynos5_usbdrd_phy *phy_drd)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	if (!IS_ENABLED(CONFIG_TYPEC))
> +	if (!IS_REACHABLE(CONFIG_TYPEC))

On arm64, the defconfig has TYPEC as module (while PHY_EXYNOS5_USBDRD
defaults to y above), and therefore all following code is becomes
disabled with your change on arm64.

Can we find a different solution to unbreak arm32 and keep arm64
defconfig working as intended?

Cheers,
Andre'


