Return-Path: <linux-kernel+bounces-194651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526098D3F7F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EFB1F2202E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDB71C68AE;
	Wed, 29 May 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LhKwkkz9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D218E06
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014086; cv=none; b=DR7AIf6lvnw5IVILpH5lTQ/+Ydpr8afMdQWj0FpjxvcG2eMv4KLcWabO9/5tb6yWLv87ucJ7kbpeNruZfXCG8d9fF0W/gkf1lQUYT0vr5dikD73VFDgqdBAwtIFPsSAPBQrHBqSrm/jRhh5Ip/EzJ9FxQwzItBeW0Uk2lypNn/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014086; c=relaxed/simple;
	bh=O2Xgfhg6ru+w2GvnufPz62XVw7kdrN5hbuagbcPFEoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jHMTkVlRUpqqQ/25fmWrxXPB80dS0nuCVSp6gDyyE8tymexWW1N2dEss2Pj5hzReC83V5N46exxWJ5k9qv9C6AQ0nL1LpOiS7KtpPhgwfsq0KrNMjYBFAhTUQe0hjJdbteRhnab9ey7Yd419T0BSzF0swBw63qNfQGa0o6B1rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LhKwkkz9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TBtFDb010054;
	Wed, 29 May 2024 20:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VLxWnZgCKiEb6sjEGXxOy0SRrO7Z0dsEeQ0/LUXuLJc=; b=LhKwkkz9jku//r2O
	sQDWlcBuVZbhY0HK1qEsvNjGg5N9GRQ6fE8ZdbI8hJYa89Zt+lpotT0POrAexuqn
	WCaeNsmCbYNcjVIvZQeXWLbdMxjweeZtOgiNE1RrvuU46xashGxpUDDjhH6HcFmM
	RVtIbHW8GwWrVBESRXXf9NkpWDmFDlMLlQ0ka4Oc1KuYYbUISCBi5O2Nzzm7Klll
	uyKlJ9rgbdFjnbgXe/WZOXWVFBmJJdwWvSF9iooXqoa06tvx3/hSXyvn/4WJYDNX
	jSAQCCXn5cjdrX27fkvjqGYIaHg4fv7mO2TzE+Qi0A3vuSkDFlxTbrvlQwK+x/hQ
	v1OBbQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2n27rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:20:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TKKuT1004009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:20:56 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 13:20:56 -0700
Message-ID: <c5c5fe1f-5fdf-4f13-8b89-984072f52838@quicinc.com>
Date: Wed, 29 May 2024 13:20:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/panel: sitronix-st7789v: tweak timing for
 jt240mhqs_hwt_ek_e3 panel
Content-Language: en-US
To: Gerald Loacker <gerald.loacker@wolfvision.net>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-0-e4821802443d@wolfvision.net>
 <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-2-e4821802443d@wolfvision.net>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240409-bugfix-jt240mhqs_hwt_ek_e3-timing-v2-2-e4821802443d@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rL9tqHFMZO8X8dg6ilTMKllG-lojgCqE
X-Proofpoint-ORIG-GUID: rL9tqHFMZO8X8dg6ilTMKllG-lojgCqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290142



On 5/29/2024 7:42 AM, Gerald Loacker wrote:
> Use the default timing parameters to get a refresh rate of about 60 Hz for
> a clock of 6 MHz.
> 
> Fixes: 0fbbe96bfa08 ("drm/panel: sitronix-st7789v: add jasonic jt240mhqs-hwt-ek-e3 support")
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>

Hi Gerald,

Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/panel/panel-sitronix-st7789v.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> index 32e5c0348038..c7e3f1280404 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
> @@ -282,9 +282,9 @@ static const struct drm_display_mode et028013dma_mode = {
>   static const struct drm_display_mode jt240mhqs_hwt_ek_e3_mode = {
>   	.clock = 6000,
>   	.hdisplay = 240,
> -	.hsync_start = 240 + 28,
> -	.hsync_end = 240 + 28 + 10,
> -	.htotal = 240 + 28 + 10 + 10,
> +	.hsync_start = 240 + 38,
> +	.hsync_end = 240 + 38 + 10,
> +	.htotal = 240 + 38 + 10 + 10,
>   	.vdisplay = 280,
>   	.vsync_start = 280 + 48,
>   	.vsync_end = 280 + 48 + 4,
> 
> -- 
> 2.37.2
> 

