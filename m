Return-Path: <linux-kernel+bounces-517345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2505FA37F71
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C867A5563
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC421661C;
	Mon, 17 Feb 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="obikmQo7"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFE216E23
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786829; cv=none; b=KU5bXM658azUj28IN2HWJG2hcbkZ1juwlGEHYbI5rAqtTd/y2gYVmQrTV14lZmPr1djZh1Jj/L0GE0rD0gGhtZQqwUkLy6ZQ5Y08Cg9Z12RJeo/KLFpskEdRArb7oTWu+oOx4Y+bKjb1q/SKDYwGpZW2LgO0pEyd3ggWiDWFxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786829; c=relaxed/simple;
	bh=bQELPkec0MJoMy8bNhsAYADpRKR0ovTZ4GOt34YuvQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Zfw0tHRqH6Ssx5H6Od2QeYP4IRO7Xn1OHCh9sH+uWiMI8lQrr1h7WLP2akomKliR7VaDGUpEMzjk48ZPkjDtyVLzS1gi6y9GCxlIOhoB/o33+uh+k7vcQ1FB7fXwRzAoLs7r2xVsNKB4C2DJ+kmSkB/7pE2sfndFJ9eQJbXrCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=obikmQo7; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250217100659euoutp025ca73ac602db0c86ee9635f83f0473db~k9uT_i5Ta3090930909euoutp02y
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:06:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250217100659euoutp025ca73ac602db0c86ee9635f83f0473db~k9uT_i5Ta3090930909euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739786819;
	bh=Jobxjz0O5iU4Sq+a8KfVXaxTWH9devKPzLIw9uayggQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=obikmQo7WMO4yz5lwZ+rXdk/TNCyq0PZmUR07tDH9wfV5KwMfAhGmQ9DjJfL90cbK
	 4B0DPR6aB1Kh/54hYHCjAnAVUnqiiL2+4Yd4ioImK1/rXGX9/4lYRkuLf9WZLPyukg
	 sC6Q15WSjwltNxdxE22tm+kkyi8f2486/IC4ibW4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250217100659eucas1p16714f12a2e813207d6736f5ffa020ca8~k9uTpfA2J3003830038eucas1p1P;
	Mon, 17 Feb 2025 10:06:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C3.FF.20821.24A03B76; Mon, 17
	Feb 2025 10:06:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250217100658eucas1p29350cfc5dd819acfbf23462cc28f7d85~k9uTPyWqv1941919419eucas1p2R;
	Mon, 17 Feb 2025 10:06:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250217100658eusmtrp20642beaec24b54d0c061ba256c3ec38b~k9uTPJC6J2648126481eusmtrp2l;
	Mon, 17 Feb 2025 10:06:58 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-a2-67b30a42cce3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.14.19920.24A03B76; Mon, 17
	Feb 2025 10:06:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250217100657eusmtip18c77699e56a11c35aaa92766b8d7edc0~k9uSK4rj30406804068eusmtip1Y;
	Mon, 17 Feb 2025 10:06:57 +0000 (GMT)
Message-ID: <b452a106-a7e5-46b9-9274-dde8929ef3fd@samsung.com>
Date: Mon, 17 Feb 2025 11:06:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] phy: exynos5-usbdrd: Fix broken USB on Exynos5422
 (TYPEC dependency)
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Vinod Koul
	<vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, Peter Griffin
	<peter.griffin@linaro.org>, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250217090518.137606-1-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0yMcRjf933f7t4ul7cru0fInGGxImN7x83PtJutZcMoow6vC3XxvkWF
	OePoXmZpxXVTWsI5Q7pDpRsVipQSaef83FEr2Y5qYjru3tB/n+fzPJ/v5/M8+5K4rNgvlNyu
	TWdYrTpFIZIQtx4OtUQsl1g1c354EG3rsRL0A70Hp58+LRfT9t6bYrq9+qyIzrUMEnS5cZig
	q5yN+BJSVWExiFTOjhqRylp2UPWtImwVkSBRbmVStu9h2NmLkiTJr053o11tVKbewPvp0Hcp
	j/xJoObB/e4ajEcSUkaZETS3XxcLRT+CnAvHkFB8Q9Cf1yT6K2m5UeMnNC4hKB66N6J3I/g4
	dMbPOyWlFsGXykM+TFDToL+9Hxf4IHhU6CK8eBw1Gd46jGIvDqY2wevb1T7vEOoqBodri31i
	nAqH4+YCsYDl4HCdw7xYREUB38f/iUSS/tQKcFowYWQy3O47i3vfAcpJQvfgKSTEjoYC1x2x
	gIOhp8E2gieCp+ocJgiOISj5+XakyEWg63KMqBeCs+WHz82b6Hr1bIFeCpefD/hooAKhsy9I
	CBEIebfO4AIthZyjMmF6Opgarv2zrW19hucihWnUWUyjtjSNWsf037cEERYkZzK4VA3DRWmZ
	vZGcOpXL0Goit6SlVqA/X6hpuOFrJSrqcUfWIYxEdQhIXBEirePLNTLpVnVWNsOmJbIZKQxX
	hyaQhEIuLb2r18gojTqd2ckwuxj2bxcj/UN12MZJz9OfnWgNiAnfG18U+0gVbO6OCVxTn64L
	GDaH6KWe1tDkgPG5jseOzHG7eysLL+jC5Z8jX1w7MtRRZYt7Eq2zb7NtXqtT8jPXF+V/ajfw
	rvjE/PfNR5fs/qWnTZLY8Kb3xkTqcEdm0gPa2LwwYa7mTaz+CjumKvOlMi+sdmp94yxeO+ju
	YT/IprTYFxTYexe/ibEMGO/PqNZlveLy7Uv3NUWcX2e1YafyOqFsszLM+XGn62J0fae/PWj/
	kw+H5r7bsKytS87VGLriPOSOF4tLS05EZOPTilcqV5sftradLKNPJnVa3QONwdrKsUd2lGRn
	FfLzS+2GAyHunDQVqyC4ZHXUTJzl1L8BDMVGDLEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsVy+t/xu7pOXJvTDb70K1tsebWZxeJo639m
	i/PnN7Bb7H29ld3i8q45bBYTVn1jsdgw4x+Lxc47J5gdODw2repk87hzbQ+bx+Yl9R6fN8kF
	sETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZdye
	9oKx4KJARWtnF2sD4w/eLkZODgkBE4lzG/ewdjFycQgJLGWUeLLpOhNEQkbi5LQGVghbWOLP
	tS42iKL3jBJzlmwFK+IVsJN4t6MRrIhFQFXiy+UvzBBxQYmTM5+wgNiiAvIS92/NYAexhQXi
	JO5u38UOMkhEYC2TxIcPi8CKmAU0JbpXTAUrEhKYwSgxudURIi4ucevJfLBlbAKGEl1vQa7g
	4OAUcJW4s4oJosRMomtrFyOELS+x/e0c5gmMQrOQnDELyaRZSFpmIWlZwMiyilEktbQ4Nz23
	2FCvODG3uDQvXS85P3cTIzDmth37uXkH47xXH/UOMTJxMB5ilOBgVhLhPdS1IV2INyWxsiq1
	KD++qDQntfgQoykwLCYyS4km5wOjPq8k3tDMwNTQxMzSwNTSzFhJnNft8vk0IYH0xJLU7NTU
	gtQimD4mDk6pBiYL2bRplReM5y049jzF7eh2baf8Wdk9XurLdrcqZLZ8/Gd+MGpuvV5/fSbX
	u9J5DxrK9V+quwi8/ZUc5XFDxbo5YE6BeMpqTQbdN/X8J9YINR9umnfE9LpxV8kNn5V7/Ct1
	Z83xU2iq7ey8eyoivdh1/rT7k1dJ598JOW72e5XYm9uh5zvO8Gk0TGjbIZyWosf5mH3xhK0r
	WV144ovCfaYeenDdviZcxWS+3N2Y7qUOH9x81F/tvfFLXf0ja9+BzIlapw0urzB9NGPnjBC7
	DxfvnJkmUT1lslxJQpm6UOiiS7f/3/zw4/aR0/u44x0qf/y6meuw0ES5R1NOqvJi/bsbJrWT
	eXP3uXxznZu0yUGJpTgj0VCLuag4EQDf0qL/QgMAAA==
X-CMS-MailID: 20250217100658eucas1p29350cfc5dd819acfbf23462cc28f7d85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250217090527eucas1p1b0e271cbff234416eb2c9de0a0e35333
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250217090527eucas1p1b0e271cbff234416eb2c9de0a0e35333
References: <CGME20250217090527eucas1p1b0e271cbff234416eb2c9de0a0e35333@eucas1p1.samsung.com>
	<20250217090518.137606-1-krzysztof.kozlowski@linaro.org>

On 17.02.2025 10:05, Krzysztof Kozlowski wrote:
> Older Exynos designs, like Exynos5422, do not have USB Type-C and the
> USB DRD PHY does not really need CONFIG_TYPEC for these devices at all.
> Incorrectly added optional dependency on CONFIG_TYPEC caused this driver
> to be missing for exynos_defconfig and as result Exynos5422-based boards
> like Hardkernel Odroid HC1 failed to probe USB.
>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Closes: https://protect2.fireeye.com/v1/url?k=3ff42dbe-606f14a1-3ff5a6f1-000babdfecba-6594ef1677acb151&q=1&e=602788a5-c8c6-4f98-b7f3-304ceee337cf&u=https%3A%2F%2Fkrzk.eu%2F%23%2Fbuilders%2F21%2Fbuilds%2F6139
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/3c0b77e6-357d-453e-8b63-4757c3231bde@samsung.com/
> Fixes: 09dc674295a3 ("phy: exynos5-usbdrd: subscribe to orientation notifier if required")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Works fine with old ARM32bit Exynos5-based boards (exynos_defconfig) as 
well as TM2e and E850.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
> Patch for issue in linux-next
>
> Changes in v3:
> 1. Simplify and go back to standard optional dependency without
>     intermediate symbol
>
> Changes in v2:
> 1. Add PHY_EXYNOS5_USBDRD_TYPEC, so arm64 defconfig will have both
>     symbols in-sync
> ---
>   drivers/phy/samsung/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
> index 7fba571c0e2b..6566100441d6 100644
> --- a/drivers/phy/samsung/Kconfig
> +++ b/drivers/phy/samsung/Kconfig
> @@ -81,7 +81,7 @@ config PHY_EXYNOS5_USBDRD
>   	tristate "Exynos5 SoC series USB DRD PHY driver"
>   	depends on (ARCH_EXYNOS && OF) || COMPILE_TEST
>   	depends on HAS_IOMEM
> -	depends on TYPEC || (TYPEC=n && COMPILE_TEST)
> +	depends on TYPEC || !TYPEC
>   	depends on USB_DWC3_EXYNOS
>   	select GENERIC_PHY
>   	select MFD_SYSCON

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


