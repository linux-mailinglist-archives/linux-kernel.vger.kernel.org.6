Return-Path: <linux-kernel+bounces-379035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D8F9AD8DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EADE1F22CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C96FEC5;
	Thu, 24 Oct 2024 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IBrwHY7M"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817D136A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729728425; cv=none; b=Qzaj/Zco5oruT3pB9ECgrbKCKjSyDL4gD/GDPF3rF06VOiF6evc1QszudAMdduXMuxcQGd5u09erDOvnweu5BzqLGRthP7m8NGqu/kSWSJLFBq4aoKWr/fEwqyWlwwJD6uvGNMnc28XVHFUgs/hqt+JK4trT2zQrZw7mThFIwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729728425; c=relaxed/simple;
	bh=sYrSAGjlDRfaCmMfSPqA0E1E8Wo0epDqQL6Ql21UBj4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:Content-Type:
	 References; b=kzd5z7Wh7ZqVcD9itIQi/qCbyW7JYecjvQI5BsbXd18I07Y7hril7pz5fUCKRkzOsyzlYsQpHhRu0ocS4NWBFmT56HYy3xXYyJCiN3oUOCTODZfNftSJDpaxloF3NX4wmRu2QkLWDRbn2xgiFMs07JhzsPyuUq3hcW7F46akiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IBrwHY7M; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241024000652epoutp04078a74773428e9cfd4d4c2c67a66e895~BOtO4tKtq1679416794epoutp04e
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:06:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241024000652epoutp04078a74773428e9cfd4d4c2c67a66e895~BOtO4tKtq1679416794epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729728412;
	bh=MOYloseJjEeLgcgK/SNvProDLrJQDHs0EI10EqayTe8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=IBrwHY7MT9bgek9m4COOI0ZnUjNCaa7/YpFpDRHCBf2vQlXHVDDFr6nvwXHMlI1ik
	 H3HXJUcX8Yy9vgEgkPNtSROOfBHgO/YtafWNvHG0QhwM65Bt0y34eKsxp0juHgmIUO
	 lEFFoHgRkP8sFHXoPq+Mwet0u/cv8RBdom2n0Dik=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241024000652epcas1p3b2a6053aa692d46f341557b3e98cdbdd~BOtOh-jzn2798227982epcas1p3n;
	Thu, 24 Oct 2024 00:06:52 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XYmRv0qhgz4x9Q2; Thu, 24 Oct
	2024 00:06:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.EB.09398.B9F89176; Thu, 24 Oct 2024 09:06:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241024000650epcas1p186b53e05118fa7cdc277c1b6e8689b37~BOtM40TpV0945009450epcas1p10;
	Thu, 24 Oct 2024 00:06:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241024000650epsmtrp199aafa8018f30e5cb1372653ddbe5d4d~BOtM4J55o1453814538epsmtrp1-;
	Thu, 24 Oct 2024 00:06:50 +0000 (GMT)
X-AuditID: b6c32a39-5f9f8700000024b6-a0-67198f9bc09c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.02.18937.A9F89176; Thu, 24 Oct 2024 09:06:50 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241024000650epsmtip231fb4749050e995d05130639dfa6c6f1~BOtMkvnDJ2947029470epsmtip2f;
	Thu, 24 Oct 2024 00:06:50 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tim Harvey'" <tharvey@gateworks.com>, "'Heiko Schocher'" <hs@denx.de>,
	"'Tom Rini'" <trini@konsulko.com>, "'Peng Fan'" <peng.fan@nxp.com>,
	<u-boot@lists.denx.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20241023202855.1571188-4-tharvey@gateworks.com>
Subject: RE: [PATCH 4/4] mmc: fsl_esdhc: Convert to use livetree API for fdt
 access
Date: Thu, 24 Oct 2024 09:06:49 +0900
Message-ID: <0bf101db25a8$9fe17d10$dfa47730$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQI9tlBLkulT+iAYa8f+rqP6Oy1iRAKkIeFFAvkOAWGxovrhcA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmru7sfsl0g/9vmC123LnPbHF51xw2
	ix+rvrBaXDzxidli6qTN7BZv93ayO7B5zJt1gsXjXM9dNo9XB1axe5y9s4PRY+O7HUwenzfJ
	BbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2h
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUq
	TMjOuNKYVrBDuOLO8/+MDYyzBboYOTgkBEwknl+N7mLk4hAS2MEoMWfnbSYI5xOjxJaF51m6
	GDkhnO6ZOiA2SMOXrs2MEPGdjBI3Z5pANLxklLhw9A4zSIJNQE/i/6KFzCAJEYHVjBIrH09i
	BVnHLKAkcfWUHEgNp4CtxOUZ88HqhQVCJebPugC2jEVAVeLG8klMIDavgKXEvDl9TBCLFSR+
	Pl3GCmIzC4hIzO5sA+sVEXCS6Jzwkg2i5iW7xPRvkRC2i8TVf9cZIWxhiVfHt7BD2FISL/vb
	2EFukxBoZpRYuuQgK4TTwyjxr+E61CRjif1LJzNBHK0psX6XPsRiPol3X3tYIUHHK9HRJgRR
	rSJx6fVLJpj5d5/8Z4WwPSRau6+zQwLoMDBEP21lncAoPwvJD7MQNixgZFrFKJZaUJybnlps
	WGAKj8fk/NxNjODEp2W5g3H62w96hxiZOBgPMUpwMCuJ8F7MkEwX4k1JrKxKLcqPLyrNSS0+
	xGgKDMmJzFKiyfnA1JtXEm9oYmlgYmZkbGJhaGaoJM575kpZqpBAemJJanZqakFqEUwfEwen
	VAPTvD3SDGveLPwYoHF9b9my9J8GFpxz4nuMZeuem30QP31kipH2A9uGXSr1bQ+dPnW+Ytq9
	k2v/pau/PxYZVX6Qy0+q6d4n/3+xp8v8qBXzhCdM09ke9yTTqIJ/67GQss+MU2MjmCeWs5/e
	fUPuSf4iXzvfW3d6F/ifDYj6I1+8ooE/dWV16AIen5+Obn91Oh6KvHleONG4sqDn7N+SDiHb
	lIZJHZPfXLfpWceTZ+HE4TDlxemwh9sZTrJ+brCtrPSL53ZYYeUYf0p3K6NGiEXJ0kmT/r7V
	WthUL6JZ1nV8PlO33yXLf4KnDE7EfFwre7Y7hrVAS8/05NOACM/6Red2tCgK70xvUGlSmTRN
	gE2JpTgj0VCLuag4EQDRxpRVBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWy7bCSvO6sfsl0gxtr1Sx23LnPbHF51xw2
	ix+rvrBaXDzxidli6qTN7BZv93ayO7B5zJt1gsXjXM9dNo9XB1axe5y9s4PRY+O7HUwenzfJ
	BbBFcdmkpOZklqUW6dslcGVcaUwr2CFccef5f8YGxtkCXYycHBICJhJfujYzdjFycQgJbGeU
	mDl3KitEQkri89OpbF2MHEC2sMThw8UQNc8ZJU4/2MYEUsMmoCfxf9FCZpCEiMB6RonpHZsY
	QRqYBZQkrp6SA6kREtjPKNG12xnE5hSwlbg8Yz4zSImwQLDExnnJIGEWAVWJG8sngY3kFbCU
	mDenjwniBAWJn0+XgZ3DLCAiMbuzjRnEFhFwkuic8JJtAqPALCSpBYyMqxhFUwuKc9NzkwsM
	9YoTc4tL89L1kvNzNzGCA1YraAfjsvV/9Q4xMnEwHmKU4GBWEuG9mCGZLsSbklhZlVqUH19U
	mpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cBkxfZzx+1Q8QLXhAnKz1Tr9u15
	uqlSImKewePfL/ZaT5p3dOtz6UfvPfyXhDacv7rjyyeHyomWfFbx0zPinhlb25m/KAh8ubW0
	OO3WnE9PMwO+lujcj1N7on+Y4a3P12s3AvffNtZI2eWdmXk5LaKXZ6WvsKbAc8NZa/Lb2F8K
	/rK0K3iRePPVxEc/d2nnF6wIT3XkE29ccU/Gd23pnNmHtQzTD+vIbVkpL59UMUVmp++Snxek
	7q7ZsGLDfNsHk3fNXyur92uilW/bdb2L73ebuCwvFpQ44760evu3kMUyL0R4pnBw/c56OGPJ
	sg9yT7yecmyfZaGQq3TYd7dH1ZpIm95HXr8r56w/5j194bZXMkosxRmJhlrMRcWJABnvLiXH
	AgAA
X-CMS-MailID: 20241024000650epcas1p186b53e05118fa7cdc277c1b6e8689b37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241023202929epcas1p153367751258e5df3feab5c189458e841
References: <20241023202855.1571188-1-tharvey@gateworks.com>
	<CGME20241023202929epcas1p153367751258e5df3feab5c189458e841@epcas1p1.samsung.com>
	<20241023202855.1571188-4-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>



> -----Original Message-----
> From: Tim Harvey <tharvey@gateworks.com>
> Sent: Thursday, October 24, 2024 5:29 AM
> To: Heiko Schocher <hs@denx.de>; Tom Rini <trini@konsulko.com>; Peng Fan <peng.fan@nxp.com>; Jaehoon
> Chung <jh80.chung@samsung.com>; u-boot@lists.denx.de
> Cc: linux-kernel@vger.kernel.org; Tim Harvey <tharvey@gateworks.com>
> Subject: [PATCH 4/4] mmc: fsl_esdhc: Convert to use livetree API for fdt access
>
> Convert to using livetree API functions.
>
> Without this if livetree is enabled (OF_LIVE) the fsl_esdhc_imx
> driver will fail to read vendor-specific properties from the dt.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/fsl_esdhc_imx.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
> index fb410104c1fc..d7a45ef0ad0d 100644
> --- a/drivers/mmc/fsl_esdhc_imx.c
> +++ b/drivers/mmc/fsl_esdhc_imx.c
> @@ -1398,8 +1398,7 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
>  	struct udevice *vqmmc_dev;
>  	int ret;
>
> -	const void *fdt = gd->fdt_blob;
> -	int node = dev_of_offset(dev);
> +	ofnode node = dev_ofnode(dev);
>  	fdt_addr_t addr;
>  	unsigned int val;
>
> @@ -1413,15 +1412,15 @@ static int fsl_esdhc_of_to_plat(struct udevice *dev)
>  	priv->dev = dev;
>  	priv->mode = -1;
>
> -	val = fdtdec_get_int(fdt, node, "fsl,tuning-step", 1);
> +	val = ofnode_read_u32_default(node, "fsl,tuning-step", 1);
>  	priv->tuning_step = val;
> -	val = fdtdec_get_int(fdt, node, "fsl,tuning-start-tap",
> -			     ESDHC_TUNING_START_TAP_DEFAULT);
> +	val = ofnode_read_u32_default(node, "fsl,tuning-start-tap",
> +				      ESDHC_TUNING_START_TAP_DEFAULT);
>  	priv->tuning_start_tap = val;
> -	val = fdtdec_get_int(fdt, node, "fsl,strobe-dll-delay-target",
> -			     ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
> +	val = ofnode_read_u32_default(node, "fsl,strobe-dll-delay-target",
> +				      ESDHC_STROBE_DLL_CTRL_SLV_DLY_TARGET_DEFAULT);
>  	priv->strobe_dll_delay_target = val;
> -	val = fdtdec_get_int(fdt, node, "fsl,signal-voltage-switch-extra-delay-ms", 0);
> +	val = ofnode_read_u32_default(node, "fsl,signal-voltage-switch-extra-delay-ms", 0);
>  	priv->signal_voltage_switch_extra_delay_ms = val;
>
>  	if (dev_read_bool(dev, "broken-cd"))
> --
> 2.25.1
>




