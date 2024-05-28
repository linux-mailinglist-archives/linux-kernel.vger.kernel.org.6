Return-Path: <linux-kernel+bounces-192766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECDC8D21C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74695289A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9A172BC1;
	Tue, 28 May 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YqVvx0OV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B216D4FF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914403; cv=none; b=qEM98LaCTZOgYoA9riykDgh/FsjoMKBCjRCQ0xViPpz5bXulqQbUgFZSxUDIgB/UGE+u8fih8bhfWVQFlJqrzF53xChVQP6JowuEXMWi+uIRp5cFjzlIofXYCbr5od09MUmy+CKLOdX94waAHQrDGNvvFTwQnuX1YmVtePpuHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914403; c=relaxed/simple;
	bh=mn7Xm3aBJVUtsQUPSVrN5kRlmSJ0oEOVMHXCdbLjAFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pag4bFkHvtLcjic4GZIgZpUWO4LGPx6uNQQjyJ5MrO4cRK/2ci2SsKVHpQAm3xMzqA+ROpBeKg6qDdZhaQMFx4i86LKSN46f2TIdOxlrSjJIT0eu1zb9nz2eCMnKEHPlbtKhQFNxZyWWVarepfb79mwJqWABn/+RsCLKQivD/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YqVvx0OV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SBZaaX029559;
	Tue, 28 May 2024 16:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RGFf3q2KPsVLxGQHqjukDALhrvUhzkxB90RUCbCUZwQ=; b=YqVvx0OV2SB3XVo0
	jC95tTmwxkAYoBBnjMDTdBkOwUI4Yg0Q0MZMm9qYoFg/vzeMy9wL3P889hNp6llw
	IjYS9c1iAnFWV2X2DXVKoqXrVvNKgmEDW8a8jrlxW2zg4Nww9t0R1HIIlm2t+gjA
	rRlklNH6T+f6ArAZZMc2qcprhAaOc09PgsMay7S3odcV1GUhFzxo3H4XqL/QlWJp
	wniHtUUBxjYwwNtVfMCZjxsXTml3YXjTk6CUBB3xBs3e0HUWCyVj2yjLViVEU1k9
	CmbMjgl+2pxmLbB4VD+ltl+DAn9cDiw5y3MhQslrUaderyz5ypoOOOAaBFFzhf7T
	MYvKbw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2ppqub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 16:39:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44SGddAK014514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 16:39:39 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 May
 2024 09:39:39 -0700
Message-ID: <fe7a27b4-c245-4a02-a0c6-8f8603146938@quicinc.com>
Date: Tue, 28 May 2024 09:39:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: sitronix-st7789v: Add check for
 of_drm_get_panel_orientation
Content-Language: en-US
To: Chen Ni <nichen@iscas.ac.cn>, <neil.armstrong@linaro.org>,
        <sam@ravnborg.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <sre@kernel.org>, <michael.riesch@wolfvision.net>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240528030832.2529471-1-nichen@iscas.ac.cn>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240528030832.2529471-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 79FZCCsuuZvM01rxRvA7Koe-GGFSvtBK
X-Proofpoint-ORIG-GUID: 79FZCCsuuZvM01rxRvA7Koe-GGFSvtBK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_12,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405280124



On 5/27/2024 8:08 PM, Chen Ni wrote:
> Add check for the return value of of_drm_get_panel_orientation() and
> return the error if it fails in order to catch the error.
> 
> Fixes: b27c0f6d208d ("drm/panel: sitronix-st7789v: add panel orientation support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Hi Chen Ni,

Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index 88e80fe98112..8b15e225bf37 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -643,7 +643,9 @@ static int st7789v_probe(struct spi_device *spi)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get backlight\n");
>   
> -	of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
> +	ret = of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
>   
>   	drm_panel_add(&ctx->panel);
>   
> -- 
> 2.25.1
> 

