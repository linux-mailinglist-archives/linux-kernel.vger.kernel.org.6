Return-Path: <linux-kernel+bounces-379123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A769ADA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE182282F19
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE872158D80;
	Thu, 24 Oct 2024 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L3WrdGS1"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF13C1CD3F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729739686; cv=none; b=GEVgpaRZ/kLgfdTF2pYu7F+3DQYfSLZB03cWC2imb+EctiAAJs/Lul3JI2uoZpSapBdcOGo9B9NBzo1EUt49Fi90TdJQ3AmnkbOUvW47tW/hlG0rc+5ld2ID7+rSA9drWttbDurwxYsQpQ0Dgz7ZjaQm14g4vAN3yhTOLQ+e0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729739686; c=relaxed/simple;
	bh=h6goQelkQhCtCNjQMZhXZHgq3DnK42C2BOkU88IzqXo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:Content-Type:
	 References; b=eLfhi/JaFAxv1IzKDzkBMzsJxUHIXLNFoKC+UPY6v/rINTrrPoO8dGXi3hliutYASqlQhji53TwORxs/s8oWboZMkl3YmJugqsw5wk3wzUsebjC3tZuQJHIZTsFQVmVdb1jzL+SZLzz+/whIRacmk0N8Mm6erVpdmGpSczLOqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L3WrdGS1; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241024031433epoutp01ea1b5571cd191fb9f6f561eb98362bee~BRRGat6Qp2837128371epoutp01y
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:14:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241024031433epoutp01ea1b5571cd191fb9f6f561eb98362bee~BRRGat6Qp2837128371epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729739673;
	bh=4A7t4wY4g8JdHoX+mOqquSVaVL9KhycL8z1IonG2Phc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=L3WrdGS16ISqt7SYNdq8AiHkBQ3OfEq/k6BGyk+nRRc+2nZc5u/W//kJbJL+mf9Y4
	 W/adqP+Ph1RUcOl7GsD7jnhNcxedv2jYGb1BBZSayyi6mPsZyMf7idSye9zH46t99w
	 lEGEvZY5IlVckqjjhMmFiFmAY01ocD96B4S/ZWEY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241024031433epcas1p29f3c2ec762dcf9d0fb280bd09611f8e5~BRRF-9BE71961619616epcas1p2K;
	Thu, 24 Oct 2024 03:14:33 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.134]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XYrcR5KBtz4x9Q1; Thu, 24 Oct
	2024 03:14:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	3D.4A.09951.79BB9176; Thu, 24 Oct 2024 12:14:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241024031431epcas1p2b3b5e06f95768605dae1ea5eacaefe61~BRREQdjl40949509495epcas1p2Y;
	Thu, 24 Oct 2024 03:14:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241024031431epsmtrp1cdcf13a1e18e2038f0b2ac31bf6c0a42~BRREPvqsd2747327473epsmtrp1J;
	Thu, 24 Oct 2024 03:14:31 +0000 (GMT)
X-AuditID: b6c32a38-b3fff700000026df-d3-6719bb974bb9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	26.80.08229.79BB9176; Thu, 24 Oct 2024 12:14:31 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241024031431epsmtip1f88613f8317bc08bcb95475d1c4ede41~BRREDWXur1889118891epsmtip11;
	Thu, 24 Oct 2024 03:14:31 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Tim Harvey'" <tharvey@gateworks.com>, "'Heiko Schocher'" <hs@denx.de>,
	"'Tom Rini'" <trini@konsulko.com>, "'Peng Fan'" <peng.fan@nxp.com>,
	<u-boot@lists.denx.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20241023202855.1571188-2-tharvey@gateworks.com>
Subject: RE: [PATCH 2/4] imx: power-domain: Convert to use livetree API for
 fdt access
Date: Thu, 24 Oct 2024 12:14:31 +0900
Message-ID: <0c5801db25c2$d7d2c840$877858c0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQI9tlBLkulT+iAYa8f+rqP6Oy1iRAKQ6qIIAYd1P1exr1XwAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmru703ZLpBvOPaVrsuHOf2eLyrjls
	Fj9WfWG1uHjiE7PF1Emb2S3e7u1kd2DzmDfrBIvHuZ67bB6vDqxi9zh7Zwejx8Z3O5g8Pm+S
	C2CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpD
	SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApU
	mJCd8fjZQ6aCM2IVMz7sYG1gPCbUxcjJISFgInHn/XzWLkYuDiGBHYwS/2etZ4RwPjFKHJ/f
	yQZSJSTwjVHi67tamI5rr/+yQxTtZZQ4unghG4TzklHi0rfDYB1sAnoS/xctZAZJiAisZpRY
	+XgS0BIODmYBJYmrp+RAajgFbCXOfZ7LBGILC0RIvGiawgxiswioShw5OI8FxOYVsJRofXaT
	EWKzgsTPp8tYQWxmARGJ2Z1tzCAjRQScJBpmloKskhB4yS7x+cw1qHoXidYzS9ghbGGJV8e3
	QNlSEi/729ghGpoZJZYuOcgK4fQwSvxruM4GUWUssX/pZCaIozUl1u/Sh1jMJ/Huaw/YLxIC
	vBIdbdBwVJG49PolE8z8u0/+s0LYHhIv125mhgTQYUaJXT//ME1glJ+F5IdZCBsWMDKtYhRL
	LSjOTU8tNiwwgUdlcn7uJkZw+tOy2ME49+0HvUOMTByMhxglOJiVRHgvZkimC/GmJFZWpRbl
	xxeV5qQWH2I0BYbkRGYp0eR8YALOK4k3NLE0MDEzMjaxMDQzVBLnPXOlLFVIID2xJDU7NbUg
	tQimj4mDU6qBqWgb556XOQ3PVPknv/+9aYrDa6HptrdFN5c+09Fa7vrfTulO52cdyUtbKrpv
	1SiLyabrOLCoB7yPnKBzPj7g/dT2G5JcAnaixV0ae9Lu1v2/N621ieX+oof/9vs4naneyzBD
	hd+uau81IbM/mjGBr7Xn/19tuvShOvfvSTfYDiuuu+bUUKeUsXni1vIjh54vbhU8+LtZcIPM
	ZLezBvUpGj48OQvNP68w+VTnumJhUfC1Y1ZNfD1XpgWqSJxfnOG13SjyVLGOavmW9Zvj6kI+
	W0Urec1ePfm/uS5T9PoDAiJTXR1XOLLlfv13mlvAYkbl2j+9U6YWmXSwbtE98NJteZDm5SX5
	mQrfLLYn2V3bpMRSnJFoqMVcVJwIACut5UIIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnO703ZLpBpcPiVvsuHOf2eLyrjls
	Fj9WfWG1uHjiE7PF1Emb2S3e7u1kd2DzmDfrBIvHuZ67bB6vDqxi9zh7Zwejx8Z3O5g8Pm+S
	C2CL4rJJSc3JLEst0rdL4Mp4/OwhU8EZsYoZH3awNjAeE+pi5OSQEDCRuPb6L3sXIxeHkMBu
	Rok/tw8yQiSkJD4/ncrWxcgBZAtLHD5cDFHznFFix+5rYDVsAnoS/xctZAZJiAisZ5SY3rGJ
	EaSBWUBJ4uopOYiG/YwS7S/7mEEaOAVsJc59nssEUiMsECZxpF8LJMwioCpx5OA8FhCbV8BS
	ovXZTagbFCR+Pl3GCmIzC4hIzO5sYwZpFRFwkmiYWTqBUWAWkswCRsZVjJKpBcW56bnFhgWG
	eanlesWJucWleel6yfm5mxjBoauluYNx+6oPeocYmTgYDzFKcDArifBezJBMF+JNSaysSi3K
	jy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cA0I/J10fsJOy5WH69l+t/a
	P09keqNsZy7jtL5PIaqrS+TSM01U1hx66bvjVNXRWGPjO1EMTm/v3Ve/rhuWOG3xN3Nn57KI
	DpVVsiZhW1QiUh7x/5MunpY7pWQP40EHzeqTNsLLnazK7vJ/vWp1nPkcc8CPu1pfP6002H27
	9pnthZdrLRa9V/PxE8rJuF6g6vUidCuLSoT3qd2Tfk9o3eK3sU6Rge3+tJ2e8U5Wj6a2bBW3
	Y59zPfVIjxnP+uIIFubKuDf5S1guJ9fpnws+1+ESd9TaK+OcpsHTcyEZP3QtaxT5jFI3mFX8
	X3vukFMhm3zxjg86vOf41zxKjgyetd/BRlhKpuVQ06Qf8eIbgpVYijMSDbWYi4oTAYy6MB3M
	AgAA
X-CMS-MailID: 20241024031431epcas1p2b3b5e06f95768605dae1ea5eacaefe61
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241023202955epcas1p2ec95a2a3fdf8e84e065b86e3570c9509
References: <20241023202855.1571188-1-tharvey@gateworks.com>
	<CGME20241023202955epcas1p2ec95a2a3fdf8e84e065b86e3570c9509@epcas1p2.samsung.com>
	<20241023202855.1571188-2-tharvey@gateworks.com>
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
> Subject: [PATCH 2/4] imx: power-domain: Convert to use livetree API for fdt access
>
> Convert to using livetree API functions.
>
> Without this if livetree is enabled (OF_LIVE) the imx8m-power-domain
> driver will (silently) fail to probe its children leaving you with
> no power domain support causing issues with certain devices.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/domain/imx8m-power-domain.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
> index 8b6870c86463..c22fbe60675e 100644
> --- a/drivers/power/domain/imx8m-power-domain.c
> +++ b/drivers/power/domain/imx8m-power-domain.c
> @@ -456,25 +456,22 @@ static int imx8m_power_domain_of_xlate(struct power_domain *power_domain,
>
>  static int imx8m_power_domain_bind(struct udevice *dev)
>  {
> -	int offset;
> +	ofnode subnode;
>  	const char *name;
>  	int ret = 0;
>
> -	offset = dev_of_offset(dev);
> -	for (offset = fdt_first_subnode(gd->fdt_blob, offset); offset > 0;
> -	     offset = fdt_next_subnode(gd->fdt_blob, offset)) {
> +	ofnode_for_each_subnode(subnode, dev_ofnode(dev)) {
>  		/* Bind the subnode to this driver */
> -		name = fdt_get_name(gd->fdt_blob, offset, NULL);
> +		name = ofnode_get_name(subnode);
>
>  		/* Descend into 'pgc' subnode */
>  		if (!strstr(name, "power-domain")) {
> -			offset = fdt_first_subnode(gd->fdt_blob, offset);
> -			name = fdt_get_name(gd->fdt_blob, offset, NULL);
> +			subnode = ofnode_first_subnode(subnode);
> +			name = ofnode_get_name(subnode);
>  		}
> -
>  		ret = device_bind_with_driver_data(dev, dev->driver, name,
>  						   dev->driver_data,
> -						   offset_to_ofnode(offset),
> +						   subnode,
>  						   NULL);
>
>  		if (ret == -ENODEV)
> @@ -514,8 +511,7 @@ static int imx8m_power_domain_of_to_plat(struct udevice *dev)
>  	struct imx_pgc_domain_data *domain_data =
>  		(struct imx_pgc_domain_data *)dev_get_driver_data(dev);
>
> -	pdata->resource_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
> -					    "reg", -1);
> +	pdata->resource_id = ofnode_read_u32_default(dev_ofnode(dev), "reg", -1);
>  	pdata->domain = &domain_data->domains[pdata->resource_id];
>  	pdata->regs = domain_data->pgc_regs;
>  	pdata->base = dev_read_addr_ptr(dev->parent);
> --
> 2.25.1
>




