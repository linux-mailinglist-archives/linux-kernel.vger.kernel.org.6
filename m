Return-Path: <linux-kernel+bounces-220375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B0B90E072
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06855282D30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F61DA4D;
	Wed, 19 Jun 2024 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iO4ekF4J"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFC01803A;
	Wed, 19 Jun 2024 00:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755540; cv=none; b=FPxGLRIk0g5ZuGt0LunoTvB3Vsn+x1THTiuG+f3dR+PNgqEoS5P5wdh9DBoNM7Z74bb5NQwhvjGekVvIeOpUp15G3mJ3uLYJjEKgJ+e307N0sEi0eU48q4qaLhX7fiK6XewqLw/hieUAhXFfEf1B/XWBEC/F4OZNeKh0f/bb6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755540; c=relaxed/simple;
	bh=vAe48MXmbPKueYnmHej8O0XqTO2omV5wJ2Fa834ul5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KS/ciHuJwx+ASw4A5imAyADDEalS0yfKb42TI91iXEc1QtUsxdi7cAMyYUWDWqgwAgn+IflsHY3v/H3Mr5v6blZvTzmiO4qNW/UH+xYW3tFXIHNrEB/UPMD0+NmM4Mw+LYV/30y7HqhfEAM2p3aOotICDUlKoiur2GHdhqOX2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iO4ekF4J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILaUnc016025;
	Wed, 19 Jun 2024 00:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cAcQfsWVz5vDGKCXbOtiTUAns6qW0Ns7EW+gW119pV4=; b=iO4ekF4JJe48PRcy
	+I5CMeUnO10nIx82VGqbBsWBujY9Y68F83vt6a/U1Pp0FsKvIuPjl4yT5znaMyqc
	WAdqV4KebCO1JBFpmaIsIrGjWayI6cO+BdHRxDskSN/+3wgbtqcWVIPijuhToVyC
	mpg+gKvtAZNJ2T1CL02a4EHibODONGNVFF/bN7c8l3cnc2oVVb6ettrdsiqackOC
	93qLxEr5yRFmLY1epZm3UJKCEdbCq4wLvZNRMy3LuKLTWdX5JtVvxYNtrXzoXQIf
	BvTaaP2IKmeEkTYpuQQd62vBX2MzOAJ8QuJDkxEPKTIhi6GKriBt3M1RDeER1zO1
	ICrfAw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja507ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J05VFM030108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:31 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 17:05:30 -0700
Message-ID: <1af1433a-61e9-4bda-912c-0cb82b26683b@quicinc.com>
Date: Tue, 18 Jun 2024 17:05:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] drm/msm/hdmi: add runtime PM calls to DDC
 transfer function
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
 <20240522-fd-hdmi-hpd-v2-8-c30bdb7c5c7e@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-8-c30bdb7c5c7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: g7rTboBHf8ebNRhR91NU-jZfAzgsdX67
X-Proofpoint-GUID: g7rTboBHf8ebNRhR91NU-jZfAzgsdX67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180176



On 5/22/2024 3:51 AM, Dmitry Baryshkov wrote:
> We must be sure that the HDMI controller is powered on, while performing
> the DDC transfer. Add corresponding runtime PM calls to
> msm_hdmi_i2c_xfer().
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/msm/hdmi/hdmi_i2c.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
> index 7aa500d24240..ebefea4fb408 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_i2c.c
> @@ -107,11 +107,15 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
>   	if (num == 0)
>   		return num;
>   
> +	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
> +	if (ret)
> +		return ret;
> +
>   	init_ddc(hdmi_i2c);
>   
>   	ret = ddc_clear_irq(hdmi_i2c);
>   	if (ret)
> -		return ret;
> +		goto fail;
>   
>   	for (i = 0; i < num; i++) {
>   		struct i2c_msg *p = &msgs[i];
> @@ -169,7 +173,7 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
>   				hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS),
>   				hdmi_read(hdmi, REG_HDMI_DDC_HW_STATUS),
>   				hdmi_read(hdmi, REG_HDMI_DDC_INT_CTRL));
> -		return ret;
> +		goto fail;
>   	}
>   
>   	ddc_status = hdmi_read(hdmi, REG_HDMI_DDC_SW_STATUS);
> @@ -202,7 +206,13 @@ static int msm_hdmi_i2c_xfer(struct i2c_adapter *i2c,
>   		}
>   	}
>   
> +	pm_runtime_put(&hdmi->pdev->dev);
> +
>   	return i;
> +
> +fail:
> +	pm_runtime_put(&hdmi->pdev->dev);
> +	return ret;
>   }
>   
>   static u32 msm_hdmi_i2c_func(struct i2c_adapter *adapter)
> 
> -- 
> 2.39.2
> 

