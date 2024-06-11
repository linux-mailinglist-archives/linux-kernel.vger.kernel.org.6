Return-Path: <linux-kernel+bounces-210411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76D904354
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B541F2339A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435EC6EB7C;
	Tue, 11 Jun 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H7sTyp+y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113421D555;
	Tue, 11 Jun 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129770; cv=none; b=chdzpjCpMblRSXOIY/svoBr3PfjonyadkaAZwgdY9dv8AYRshyp6C+XrNfdldP90E8aIE3PkRKGJqY7MyrN9AV/r1SB0+KHwm4JD2W1Rcl0KTcc+ZqgzBTt0BVlQbh6+GQVzKcxg+O9pNt2TpttUdNKW+Ge6UkE7rFjo+SG4vJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129770; c=relaxed/simple;
	bh=L4mlXHmPgmTdHq37fhVTMJA9++Qb0x4oHaEe0le8dEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P9NH3M8JL/bBLbMGWKeKHVmKEdkVy7t7CbOcJ4sXr2A7jmA7TMHmuFcKR4Kg8lrs+P38vVRHLMJl4bYur6r7CT4Ag3nB2d28X5v3jdAtqEKceNxmbad4BHJwWrou/wFyBjwg2kgRMP1FYuSumcjex87CjLn/06VljlaTTAll+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H7sTyp+y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BClV2A008099;
	Tue, 11 Jun 2024 18:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9lAOe/MTNKXIcRfw4OLEZdwYeoSOv3urLU5CVFUEk9s=; b=H7sTyp+yyN+IIgxe
	NZDKD4RwPb2UFKAe5uE+b1gfRl12Jg/giVYuzGG/wxQvgT0j+mV2rMiXn6EESnA7
	aKMwNFhKP4yGYP1AsZgJ8NwexyTOFBBq3tKzeoMl/5u2QxTo3JghhCkNRovNAxuW
	XU1Y2+VTSBbo6u8/Q2QcPYGDvNFKAldN+hyvasIX5pg6fmOLZneXoQjQWrmrsIUD
	ro0G6S+2q7oft4jbHrnl5K54w5OFJ40QWd/Q/rrWFjkVlsKncbgZuP3E8qFNZ++q
	SRI6+gxMO5z+CN1kpix2VGXrVcUs9hl2UT5PftpgJZ/Ydoscc4xN2pebz/63IGsi
	ekr45A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymcnmy3m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:15:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45BIFvwW005391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 18:15:57 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 11 Jun
 2024 11:15:57 -0700
Message-ID: <66e7c762-8bbc-447a-8e06-c2616c305a5d@quicinc.com>
Date: Tue, 11 Jun 2024 11:15:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] drm/msm/hdmi: move the alt_iface clock to the
 hpd list
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul
	<sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "David
 Airlie" <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240522-fd-hdmi-hpd-v2-0-c30bdb7c5c7e@linaro.org>
 <20240522-fd-hdmi-hpd-v2-1-c30bdb7c5c7e@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-1-c30bdb7c5c7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qi4IxX2dDs28nvQ2jtxuUAn4IueEIEKx
X-Proofpoint-ORIG-GUID: Qi4IxX2dDs28nvQ2jtxuUAn4IueEIEKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110125



On 5/22/2024 3:50 AM, Dmitry Baryshkov wrote:
> According to the vendor kernel [1] , the alt_iface clock should be
> enabled together with the rest of HPD clocks, to make HPD to work
> properly.
> 
> [1] https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/commit/e07a5487e521e57f76083c0a6e2f995414ac6d03
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Hi Dmitry,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
>   drivers/gpu/drm/msm/hdmi/hdmi.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index 24abcb7254cc..108c86925780 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -235,9 +235,9 @@ static const struct hdmi_platform_config hdmi_tx_8960_config = {
>   };
>   
>   static const char *pwr_reg_names_8x74[] = {"core-vdda", "core-vcc"};
> -static const char *pwr_clk_names_8x74[] = {"extp", "alt_iface"};
> -static const char *hpd_clk_names_8x74[] = {"iface", "core", "mdp_core"};
> -static unsigned long hpd_clk_freq_8x74[] = {0, 19200000, 0};
> +static const char *pwr_clk_names_8x74[] = {"extp"};
> +static const char *hpd_clk_names_8x74[] = {"iface", "core", "mdp_core", "alt_iface"};
> +static unsigned long hpd_clk_freq_8x74[] = {0, 19200000, 0, 0};
>   
>   static const struct hdmi_platform_config hdmi_tx_8974_config = {
>   		HDMI_CFG(pwr_reg, 8x74),
> 
> -- 
> 2.39.2
> 

