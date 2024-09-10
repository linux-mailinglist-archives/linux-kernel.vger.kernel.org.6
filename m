Return-Path: <linux-kernel+bounces-322774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8796972DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0F31F25D67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930B188A3A;
	Tue, 10 Sep 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZVFUfUYg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="GjOT2vS+"
Received: from a7-42.smtp-out.eu-west-1.amazonses.com (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE316C854
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960658; cv=none; b=lRLnQMb99VdXC9iJZfVLsn+UrnNHfgGwmqdaMrElPqmzYahX4BYRHsqVEe51R58Cm9kQ/v9z9pVS0ESEVmiXFlkcFSHj52tAGIiF7b2IQIlHxz3ZKnus8xi2w48gATzHPEXVbiOJkScmCvuoCPhitA2nYO6jVZ14ELLq5aDyGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960658; c=relaxed/simple;
	bh=f1VEHlFlmCeLFmqgFruvrVklSfh+GU0nyzOSNnOJfig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3HvtRyOrX6QopgqXrQF55Go0nmLqUUJluPP7rauO6pLpPawxl64/bORhFZP0H+BWCFHM8MOe3UDi4Olnaot8dEjEhV+NWMIw3GjFKntWylkpwzvpVKIRBIIWaLNsWrkiNrQBea8mE8pqs3f6bm0gHen5jdavkPNGaOx31eP/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZVFUfUYg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=GjOT2vS+; arc=none smtp.client-ip=54.240.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725960655;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=f1VEHlFlmCeLFmqgFruvrVklSfh+GU0nyzOSNnOJfig=;
	b=ZVFUfUYgj1wJmA1P3gUlc18tT+rYh5UOioOt8HIDDNtuU49woyor7OaXQOwGm0pq
	xfI3hWv+4JpGSrnuuq4lU6sQFN10cNPnK+gw5OQi0bEz1t6/2Luu8DZtUFzYjXAb6/N
	bYoM3DIvMISQqwD86Om1nt+AjdO+hviUBvhLtUNz42/hbvAGQ0d3tt/MfbojhnyauCr
	d5Q5THtJ3yBSAPWquIZ74T26h+9BlwLIUUxU0w1eb3GwJ7i3YiGxvewlw/13gPPrME7
	JxNJIatLr+WbS4xobWDqrgoR3puv59oxNI2/w1g3/cTN38flf/o1LaqGKpjMnZcZj+f
	RiTHrck1WQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725960655;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=f1VEHlFlmCeLFmqgFruvrVklSfh+GU0nyzOSNnOJfig=;
	b=GjOT2vS+KrNPn0WrkVByfdmmPv2HsKvGywOUQfldmcipYC/k+skpZs6VL+GJ8CDH
	wFoPDVrtG4gplIyhywfMJpzZITG3mtioh+utqGx9HBNorLtYHlHIq0RW7srTaUt2C61
	G12VXzDOLfKCES3cY6h7+/XX+aA18glST8sq6iew=
Message-ID: <01020191db45928b-bcb6d066-e490-41ff-aefd-f274d03da21e-000000@eu-west-1.amazonses.com>
Date: Tue, 10 Sep 2024 09:30:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] drm/mediatek: Fix get efuse issue for MT8188 DPTX
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, shuijing.li@mediatek.com, 
	jitao.shi@mediatek.com, mac.shen@mediatek.com, peng.liu@mediatek.com
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240905124041.3658-1-liankun.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240905124041.3658-1-liankun.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.10-54.240.7.42

Il 05/09/24 14:40, Liankun Yang ha scritto:
> Update efuse data for MT8188 displayport.
> 
> The DP monitor can not display when DUT connected to USB-c to DP dongle.
> Analysis view is invalid DP efuse data.
> 
> Fixes: 350c3fe907fb ("drm/mediatek: dp: Add support MT8188 dp/edp function")
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Changes in V4:
> - Remove excess newlines.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240903121028.20689-1-liankun.yang@mediatek.com/
> 
> Changes in V3
> - Update change log position in commit message.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240902133736.16461-1-liankun.yang@mediatek.com/
> 
> Changes in V2
> - Add Fixes tag.
> - Update the commit title.
> - Update the commit description.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240510061716.31103-1-liankun.yang@mediatek.com/
> ---
>   drivers/gpu/drm/mediatek/mtk_dp.c | 85 ++++++++++++++++++++++++++++++-
>   1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index d8796a904eca..f2bee617f063 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -145,6 +145,89 @@ struct mtk_dp_data {
>   	u16 audio_m_div2_bit;
>   };
>   
> +static const struct mtk_dp_efuse_fmt mt8188_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
> +	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
> +		.idx = 0,
> +		.shift = 10,
> +		.mask = 0x1f,
> +		.min_val = 1,
> +		.max_val = 0x1e,
> +		.default_val = 0xf,
> +	},
> +	[MTK_DP_CAL_CLKTX_IMPSE] = {
> +		.idx = 0,
> +		.shift = 15,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_0] = {
> +		.idx = 1,
> +		.shift = 0,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_1] = {
> +		.idx = 1,
> +		.shift = 8,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_2] = {
> +		.idx = 1,
> +		.shift = 16,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_3] = {
> +		.idx = 1,
> +		.shift = 24,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_0] = {
> +		.idx = 1,
> +		.shift = 4,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_1] = {
> +		.idx = 1,
> +		.shift = 12,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_2] = {
> +		.idx = 1,
> +		.shift = 20,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_3] = {
> +		.idx = 1,
> +		.shift = 28,
> +		.mask = 0xf,
> +		.min_val = 1,
> +		.max_val = 0xe,
> +		.default_val = 0x8,
> +	},
> +};
> +
>   static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX] = {
>   	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
>   		.idx = 3,
> @@ -2771,7 +2854,7 @@ static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_suspend, mtk_dp_resume);
>   static const struct mtk_dp_data mt8188_dp_data = {
>   	.bridge_type = DRM_MODE_CONNECTOR_DisplayPort,
>   	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
> -	.efuse_fmt = mt8195_dp_efuse_fmt,
> +	.efuse_fmt = mt8188_dp_efuse_fmt,
>   	.audio_supported = true,
>   	.audio_pkt_in_hblank_area = true,
>   	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,


