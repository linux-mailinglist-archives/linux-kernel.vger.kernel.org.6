Return-Path: <linux-kernel+bounces-175579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B016A8C21C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506E41F23E17
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10753165FCB;
	Fri, 10 May 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2IQqdwqP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC248161935
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335912; cv=none; b=KTU+ce3VzpiuKGFP2s/A4MkXz1dkdckxq/TrE8FiTrNJMFYHX8jtQ1/vFWfK9x/i5g4MLfPXp5v3BO219pzwAoA05nf2j9fOtR4bwLOB3uhgJLteKcVzJO3Vj+9NkD6UhyLe681gMoVJ3X/pQ3NrZuXpfv7l8V1zxt9En8UPeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335912; c=relaxed/simple;
	bh=vtrYm/vQSHim3jgRX04nOQj9guH68BZEvaolheL2Xv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCld/bIsCvzycnUiIRUqeFyS/3Gc5LJOKtVXIcOOnS1a8MHrv/xkN504wCl2nOtLBDJTisTU06bZik7f9a+teqmXqIGPPlb7/3/W+3DPr9gByCi/iafXzjKH5zALR0WxANg9t9nXGuKy/A/Rvaene0TP6d+ME61ryJpxlyDIzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2IQqdwqP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715335550;
	bh=vtrYm/vQSHim3jgRX04nOQj9guH68BZEvaolheL2Xv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2IQqdwqPtoZkkk19USWWt8xgqlcwa+gPD66JC9VAEpwOYIPtXk4CcL340IG3zLdxP
	 nzVp/rwU70UIPRcxvhfHIAobSvLl++PUysKOpB++6Q2BiGJvL4zoPGhKuK52g3RbCJ
	 sUcfDpqiOIe43x1vzTgceS5gGHgqIdDsvw1WuhyHTjzO8LQJRL3MdvPT8U5xiYubn/
	 l7/HEJNl93y2U8hJN0yc7i6GMo1sFCkhbR2EQJA8v4P7sMAAZyG1tVvGCrU5ew6Ew/
	 WxdygCOQ+rLS/K6NZCU7LvPUAHPqq/v+4+UKcbchzpBVRKRbRfkdTqHhcvOm39v6x9
	 olb7rHKz8B05g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 92DD6378217A;
	Fri, 10 May 2024 10:05:49 +0000 (UTC)
Message-ID: <8d624845-7450-485c-8000-0194bcf56458@collabora.com>
Date: Fri, 10 May 2024 12:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Support YUV422 for DPTX.
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 matthias.bgg@gmail.com, jitao.shi@mediatek.com, mac.shen@mediatek.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240510021810.19302-1-liankun.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240510021810.19302-1-liankun.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/05/24 04:15, Liankun Yang ha scritto:
> Adjust the training sequence.Detects the actual link condition
> and calculates the bandwidth where the relevant resolution resides.
> 
> The bandwidth is recalculated and modes that exceed the bandwidth are
> filtered.
> 
> Example Modify bandwidth filtering requirements.
> 
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dp.c | 81 ++++++++++++++++++-------------
>   1 file changed, 46 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index 2136a596efa1..3e645bd6fe27 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -66,6 +66,13 @@ enum {
>   	MTK_DP_CAL_MAX,
>   };
>   
> +enum mtk_dp_color_format {
> +	MTK_DP_COLOR_FORMAT_RGB = 0,
> +	MTK_DP_COLOR_FORMAT_YUV422 = 0x1,
> +	MTK_DP_COLOR_FORMAT_YUV444 = 0x2,
> +	MTK_DP_COLOR_FORMAT_YUV420 = 0x3,
> +};

This is giving the same values as drm_dp.h, hence unneeded.

> +
>   struct mtk_dp_train_info {
>   	bool sink_ssc;
>   	bool cable_plugged_in;
> @@ -84,7 +91,7 @@ struct mtk_dp_audio_cfg {
>   };
>   
>   struct mtk_dp_info {
> -	enum dp_pixelformat format;
> +	enum mtk_dp_color_format format;
>   	struct videomode vm;
>   	struct mtk_dp_audio_cfg audio_cur_cfg;
>   };
> @@ -457,7 +464,7 @@ static void mtk_dp_set_msa(struct mtk_dp *mtk_dp)

.snip..

> @@ -1888,9 +1896,28 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
>   			memset(&mtk_dp->info.audio_cur_cfg, 0,
>   			       sizeof(mtk_dp->info.audio_cur_cfg));
>   
> +			mtk_dp->enabled = false;
> +			/* power off aux */
> +			mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> +			       DP_PWR_STATE_BANDGAP_TPLL,
> +			       DP_PWR_STATE_MASK);
> +

This commit is not even based on upstream, so you haven't even tested it upstream.

Don't send untested commits.
There's nothing to review here.

Regards,
Angelo

