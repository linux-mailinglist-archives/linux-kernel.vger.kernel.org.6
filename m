Return-Path: <linux-kernel+bounces-228114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5AB915B14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CAC283DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29221101D5;
	Tue, 25 Jun 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fi7OwLMU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87108F6F;
	Tue, 25 Jun 2024 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276247; cv=none; b=lNYHX4jPCNiXTB7tGhqy4SwV4/IkZjh6YEkfUQ0rCGPgnzbCkdKcsTu5F8PE+CR+NsN49uclY0svSiOO7hHYGXUcQzEborT8zndz6VuNeAAdUWTe8tIV9di84CRWKRNMydZx+mag5nI7yU0u2zmtQqWd1YsTblcvh1NP1o21IgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276247; c=relaxed/simple;
	bh=6lu4Us4+fCNlrGQaBoS+9fNKG2LoS4LtvOY6+EFKVUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k5+YMpcUAArabe4Csc3HIwNDHvwsH0dh8WQ1LMpHtyLWLaRhfJnL4pXV+zEEnE1mAjo0EbxWQ3dwRtfCx2mEUb0PDf8uNsKss8Qe2EdaIlblVz7bi0Tf0HLBeQocmCkOBkaeeSXvWcu04Kt8P0tLIelSwxQlIT4FHeKpTLoZ6cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fi7OwLMU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIjPhr017208;
	Tue, 25 Jun 2024 00:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFAL+uBcLgdxna0HoxG1YZdp3YhcmlUpb2GTOdRogEQ=; b=Fi7OwLMUYy4dlI0m
	SMJLfUQZbzG7SrdJAH2F6LE7nAT1PJETAuWFg3zO1RAuL+kYLi2iBsHZpmi2dcsL
	bB1aNHpAAp7McSQwTHI/2xldp4E+Qh8KTp5n/Kn5ZaTGAoSmfs+4LdtDAd4K/xLJ
	7o8WGHGMJcMPG1m2gWOKB2JAmUqc/KITZQfB6QgXX72F8Z2D4sNFWcRgl3yaB1hG
	2QTxQ9UgiQ0ctVxYMumWggtY4teZHLfaMcM3ADyY4SlN7cewqzqOxwGiRF6R/J9Y
	xPHnPD+vTzCpbFBf3pPVtA12RJT05nG3M89bRGqX4gG5K1J7LwLZU4/XOUAwWc6t
	oE2F4Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw9cte7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 00:43:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45P0hjop015213
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 00:43:45 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 17:43:45 -0700
Message-ID: <33cb6804-7a9a-45bb-803f-0506c4aa0160@quicinc.com>
Date: Mon, 24 Jun 2024 17:43:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] drm/panel: jd9365da: Add the function of adjusting
 orientation
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jikos@kernel.org>, <benjamin.tissoires@redhat.co>,
        <dianders@google.com>, <hsinyi@google.com>, <jagan@edgeble.ai>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240624141926.5250-6-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Language: en-US
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240624141926.5250-6-lvzhaoxiong@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 45lHfue0QZdIkHP0fg3imT9XIXfAW9JH
X-Proofpoint-GUID: 45lHfue0QZdIkHP0fg3imT9XIXfAW9JH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_21,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406250004



On 6/24/2024 7:19 AM, Zhaoxiong Lv wrote:
> This driver does not have the function to adjust the orientation,
> so this function is added.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
> Changes between V5 and V4:
> - 1. Change dev_err() to dev_err_probe().
> 
> V4:https://lore.kernel.org/all/20240620080509.18504-5-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> Changes between V4 and V3:
> - No changes.
> 
> ---
>   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 593e12b31ebd..c6b669866fed 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -42,7 +42,7 @@ struct jadard {
>   	struct drm_panel panel;
>   	struct mipi_dsi_device *dsi;
>   	const struct jadard_panel_desc *desc;
> -
> +	enum drm_panel_orientation orientation;
>   	struct regulator *vdd;
>   	struct regulator *vccio;
>   	struct gpio_desc *reset;
> @@ -178,12 +178,20 @@ static int jadard_get_modes(struct drm_panel *panel,
>   	return 1;
>   }
>   
> +static enum drm_panel_orientation jadard_panel_get_orientation(struct drm_panel *panel)
> +{
> +	struct jadard *jadard = panel_to_jadard(panel);
> +
> +	return jadard->orientation;
> +}
> +
>   static const struct drm_panel_funcs jadard_funcs = {
>   	.disable = jadard_disable,
>   	.unprepare = jadard_unprepare,
>   	.prepare = jadard_prepare,
>   	.enable = jadard_enable,
>   	.get_modes = jadard_get_modes,
> +	.get_orientation = jadard_panel_get_orientation,
>   };
>   
>   static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
> @@ -880,6 +888,10 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
>   	drm_panel_init(&jadard->panel, dev, &jadard_funcs,
>   		       DRM_MODE_CONNECTOR_DSI);
>   
> +	ret = of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get orientation\n");
> +
>   	ret = drm_panel_of_backlight(&jadard->panel);
>   	if (ret)
>   		return ret;
> -- 
> 2.17.1
> 

