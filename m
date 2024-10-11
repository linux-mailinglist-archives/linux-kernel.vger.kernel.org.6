Return-Path: <linux-kernel+bounces-361559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039999A9B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C661F237A6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4E1A070E;
	Fri, 11 Oct 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cKvjmkw1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9635196DB1;
	Fri, 11 Oct 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667089; cv=none; b=sjgkIsAZe0BGj9HV0Hbatv3r7XTVuzscj+ExcoOD29V70XdyybCYSAMbZvZ9AT1w7jdQa7NkTeQgf8vzZocv/QaYEe1U3b3u9JY0/vtaBECjcgcsmfwQhJLf8wuq0TkiPIGc9f5ESXQ1zKKzreUtGXGCNjvrXWDs4jwF465ASMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667089; c=relaxed/simple;
	bh=tbEMF3m98Vq5Q5XI5ItVULRbf73c95iDku6lCGFJ818=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dnn/jow2xyCetmWqXlkt7uiXSpCB2Yu48BEZTzOoCRalxPotm3vxdvj9q8xD3DFPf86Qk6mIwTaAYIepf9o3sOjHL309a40mY/3HTrUVb5RLXD/65LLbVbEuBtHDTCTix/5O0AM/uAeaj4ecfnOnSPnFTy2ZmxjtKx4MT7mcADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cKvjmkw1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BFhQiS024074;
	Fri, 11 Oct 2024 17:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Er+9IWq6PcBbaWxKcA/fefqTEe9x4G35ud7dwSVM+Y=; b=cKvjmkw1820T33vf
	TbOIBmJ9IKr7wPNgqm/JT5+YFK69rdiFwmUyHos3+HLmWPuKoT9vsSwCmZg/sW0D
	EMy4/ZY8Yjliyv2bpvxMHaHwqEs5snQuXVqG+L+ovQ0XSd+FcFOd0U1TMgA8mr28
	onWc82b4lKR+LtpQElNTWLJkT4sTtLlM0eXN4XnHEgRhhOWCnRkbWTW6aXjQtxBy
	bYVKtoLvrPoIT58TNnBOnNXpFr9WXkp06T+4w8SNZh/aCUIybmgyCAU8YbLSxIln
	rRqIrPQmhOWo7K6/z9WCH0Nn6wBRkKnpD/ZNOtkPzuEh7U28TyG/GeIOPUUJkHnN
	U33xgw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 426y3vst81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 17:17:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49BHHwsM022559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 17:17:58 GMT
Received: from [10.110.78.155] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 11 Oct
 2024 10:17:57 -0700
Message-ID: <1e23cfa8-66c6-476b-927c-695172e76143@quicinc.com>
Date: Fri, 11 Oct 2024 10:17:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/panel: samsung-s6e88a0-ams427ap24: Add flip
 option
To: Jakob Hauser <jahau@rocketmail.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
References: <cover.1728582727.git.jahau@rocketmail.com>
 <70ea852342001779956905ed9002a977d1d95293.1728582727.git.jahau@rocketmail.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <70ea852342001779956905ed9002a977d1d95293.1728582727.git.jahau@rocketmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fUkM-HGwwqDqadETGWFm-B_usaTNU1vd
X-Proofpoint-GUID: fUkM-HGwwqDqadETGWFm-B_usaTNU1vd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110120



On 10/10/2024 11:31 AM, Jakob Hauser wrote:
> The way of implementing a flip option follows the existing
> panel-samsung-s6e8aa0.c [1][2][3].
> 
> The value to flip the screen is taken from a downstream kernel file of
> a similar but older panel [4]. The mipi clock [5] for the new panel
> samsung-s6e88a0-ams427ap24 matches 461 MHz and a hardware read-out of the
> 0xcb values corresponds to revision R01 of that older panel [6]. Although
> for samsung-s6e88a0-ams427ap24 that's in non-flipped state while in this
> older driver it seems to be the other way around. Further up there is a

Hi Jakob,

I'm a bit confused by the wording here. Do you mean that even though the 
downstream driver comments state the panel is in a non-flipped state by 
default, your observations suggest that it's actually defaulting to a 
flipped state?

Thanks,

Jessica Zhang

> hint [7] basically saying for revision R01 to change the first word of the
> 0xcb command from 0x06 to 0x0e, which is actually setting BIT(3) of that
> word. This causes a horizontal flip.
> 
> [1] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c#L103
> [2] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c#L207-L211
> [3] https://github.com/torvalds/linux/blob/v6.11/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c#L954-L974
> [4] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c
> [5] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L2027-L2028
> [6] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L137-L151
> [7] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/blob/lineage-15.1/drivers/video/msm/mipi_samsung_oled_video_qhd_pt-8930.c#L66-L74
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>   .../drm/panel/panel-samsung-s6e88a0-ams427ap24.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> index 657120d7dd33..4d5c494e03ae 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
> @@ -32,6 +32,7 @@ struct s6e88a0_ams427ap24 {
>   	struct mipi_dsi_device *dsi;
>   	struct regulator_bulk_data *supplies;
>   	struct gpio_desc *reset_gpio;
> +	bool flip_horizontal;
>   	bool prepared;
>   };
>   
> @@ -539,6 +540,10 @@ static int s6e88a0_ams427ap24_on(struct s6e88a0_ams427ap24 *ctx)
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcc, 0x4c);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf2, 0x03, 0x0d);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf1, 0xa5, 0xa5);
> +
> +	if (ctx->flip_horizontal)
> +		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcb, 0x0e);
> +
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
>   	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfc, 0xa5, 0xa5);
>   
> @@ -673,6 +678,15 @@ static int s6e88a0_ams427ap24_register_backlight(struct s6e88a0_ams427ap24 *ctx)
>   	return ret;
>   }
>   
> +static void s6e88a0_ams427ap24_parse_dt(struct s6e88a0_ams427ap24 *ctx)
> +{
> +	struct mipi_dsi_device *dsi = ctx->dsi;
> +	struct device *dev = &dsi->dev;
> +	struct device_node *np = dev->of_node;
> +
> +	ctx->flip_horizontal = of_property_read_bool(np, "flip-horizontal");
> +}
> +
>   static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
>   {
>   	struct device *dev = &dsi->dev;
> @@ -707,6 +721,8 @@ static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
>   		       DRM_MODE_CONNECTOR_DSI);
>   	ctx->panel.prepare_prev_first = true;
>   
> +	s6e88a0_ams427ap24_parse_dt(ctx);
> +
>   	ret = s6e88a0_ams427ap24_register_backlight(ctx);
>   	if (ret < 0)
>   		return ret;
> -- 
> 2.39.5
> 


