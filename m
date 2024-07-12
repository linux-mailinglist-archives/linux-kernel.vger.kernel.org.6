Return-Path: <linux-kernel+bounces-251164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0693016B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97D6282809
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14313481C4;
	Fri, 12 Jul 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UHy4r4np"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6D47F41;
	Fri, 12 Jul 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720818218; cv=none; b=cgLCQIMrmwYQ77OlXiIeLiTScKpeaMwZVGS7nLZ5W9285jLiTPcrvUyjEmQsf4bT1nqO+Yn9X4DVGQW7iAVCiBNaIn3E5Ev8HgQ6Egmq8h2Ki2altzzHro5+5xBi7QXGeXxc230rFQ57j/d4EqloqJ/2u+iPJCkJq/RwTZ1r46o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720818218; c=relaxed/simple;
	bh=xzSr4rTygjq40NySqIzPz/YhF/sBRLmGmXQ9xrTIJYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SlEWNO/BXmh35zCmzPeU8oMv+aU4nOlNHuPt+rEw7oe68LV7N0JLc5xLdPTTXXH42uBOf2+SswOWYFgSZF9p7WkxNZbvmwcXiEDtrI6rJs6RqH2eabVuAyQ6Ba+6+WN6ftoyhvTZeueFc89ATCbZyAKEA+0Ti0IjHGXq8GjR37w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UHy4r4np; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CEB3ul009130;
	Fri, 12 Jul 2024 21:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BQNyKzaB1t/sXuLQaAphOIYHQ+AM6KkZNjTtrGtunoc=; b=UHy4r4npUwwJ7u/O
	LF4+qrCtnkF+igi18P0qDQ/4f6s8LzL5eOUT6X0XSjO4SYtIBBtX2ESUZcpjRdFs
	zjizt+Gpbtq+Pxw3eI8QAU/b8/JeN1C9wvJqokoIlLCYzic0GzhJJPKfRcCL2j4r
	CeWEdADKTML95pCOHMKjBIURkfJsIeDH9dpW28XoZQYMTcOZdd23jTqApn4SNno7
	ZXMJ5WfR04lLYorOuaOygdm22lPm1VBILCyQnlm3sunR9lJ15L3/LYZcmuL83Em/
	j+Jux4Djq8cpXYyoTBWUDz90D1cTqexUlV0RWvSPCwHt/WMjzjIJa6BHLHaD752a
	xJxibg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4091jdtjxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 21:03:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CL3Iq3032258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 21:03:18 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Jul
 2024 14:03:18 -0700
Message-ID: <4f1a3bcb-31b0-4688-b6e5-92a940cf2881@quicinc.com>
Date: Fri, 12 Jul 2024 14:03:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panel: simple: add Innolux G070ACE-LH3 LVDS
 display support
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>
References: <20240712-b4-v6-10-topic-innolux-v1-0-bb0acf273d0d@pengutronix.de>
 <20240712-b4-v6-10-topic-innolux-v1-2-bb0acf273d0d@pengutronix.de>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240712-b4-v6-10-topic-innolux-v1-2-bb0acf273d0d@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jWJj7v02I0_F3zGgfULG9Tfor_3n9vKU
X-Proofpoint-ORIG-GUID: jWJj7v02I0_F3zGgfULG9Tfor_3n9vKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_16,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407120143



On 7/12/2024 4:05 AM, Steffen Trumtrar wrote:
> The G070ACE-LH3 is a 7" TFT Color LCD module with WLED backlight.
> 
> https://www.data-modul.com/sites/default/files/products/G070ACE-LH3-specification-12058417.pdf
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index dcb6d0b6ced06..d3ce78643fd86 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -2509,6 +2509,38 @@ static const struct panel_desc innolux_g070y2_l01 = {
>   	.connector_type = DRM_MODE_CONNECTOR_LVDS,
>   };
>   
> +static const struct display_timing innolux_g070ace_lh3_timing = {
> +	.pixelclock = { 25200000, 25400000, 35700000 },
> +	.hactive = { 800, 800, 800 },
> +	.hfront_porch = { 32, 32, 32 },
> +	.hback_porch = { 31, 31, 31 },
> +	.hsync_len = { 1, 1, 1 },

Hi Steffen,

The min/max horizontal and vertical porches here don't seem to add up to 
the min/max [HV]blanks specified in the datasheet linked in the commit 
msg. Any reason for that?

Thanks,

Jessica Zhang

> +	.vactive = { 480, 480, 480 },
> +	.vfront_porch = { 5, 5, 5 },
> +	.vback_porch = { 4, 4, 4 },
> +	.vsync_len = { 1, 1, 1 },
> +	.flags = DISPLAY_FLAGS_DE_HIGH,
> +};
> +
> +static const struct panel_desc innolux_g070ace_lh3 = {
> +	.timings = &innolux_g070ace_lh3_timing,
> +	.num_timings = 1,
> +	.bpc = 8,
> +	.size = {
> +		.width = 152,
> +		.height = 91,
> +	},
> +	.delay = {
> +		.prepare = 10,
> +		.enable = 450,
> +		.disable = 200,
> +		.unprepare = 510,
> +	},
> +	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
> +	.connector_type = DRM_MODE_CONNECTOR_LVDS,
> +};
> +
>   static const struct drm_display_mode innolux_g070y2_t02_mode = {
>   	.clock = 33333,
>   	.hdisplay = 800,
> @@ -4599,6 +4631,9 @@ static const struct of_device_id platform_of_match[] = {
>   	}, {
>   		.compatible = "innolux,g070ace-l01",
>   		.data = &innolux_g070ace_l01,
> +	}, {
> +		.compatible = "innolux,g070ace-lh3",
> +		.data = &innolux_g070ace_lh3,
>   	}, {
>   		.compatible = "innolux,g070y2-l01",
>   		.data = &innolux_g070y2_l01,
> 
> -- 
> 2.45.1
> 

