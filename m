Return-Path: <linux-kernel+bounces-221805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E22390F8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2222B1F21EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574015B0F7;
	Wed, 19 Jun 2024 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e57bgd6T"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719874068;
	Wed, 19 Jun 2024 22:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718835208; cv=none; b=iZ714m9VY+vB9d7S/MWBOsVDg+aTkVjM7jnUa+G7RxuiCWPWSTz6/EOJlMH5w3subeHDUUYvBPX5OS8Ts1q+hF2JEKQzIl5gRLVbeSErCapUmH6vuq0IoVKsqV4JBP10hm6O2pmlwLjQ1iGFqGHBruBR9xwvofi2yM8AMWzxF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718835208; c=relaxed/simple;
	bh=w2dKnarKNiz3g0JVeyLgLKn00s2+dR8VIn8QWV02/Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SpDX4hPOrLRgih8Eco2aehmbAVZizvXzKFwNiF5ipUhinVAHKz2XhffG3Ib7QWz1VzJzZE9BpYXxmmxKNKjwQBJRdE4o7FiqEl899WuS8M8T8F8mjGEsJD8MiW3dxQmO3gbwizPCktLpSFDd5P+S0A9VQbDNkur//Rg1MZCqY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e57bgd6T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JKF8TO001111;
	Wed, 19 Jun 2024 22:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kyW90F4AofMEF8qcEigvaFzWOh9KbCuVNDe+PSwHOzc=; b=e57bgd6TEa0CAh8L
	y+j5jFhTNl6GBtLk8Zkb0hrwkvon5Bw4Y9/jKL6wX2N6hmuHJGggqUljCVBsQmJL
	u36Bn4IjggaBbi2/oEYWUme32i6v1HW9yvTq5HYz4ODjezCfzNi1nSp0KVpbXRvC
	dy2BcjEscWEc/7h99biytJJdzvPgno0CSKocIe9PYRJfFDzU1V6ivtkr07bR5Gaz
	sQqCauGrrDLyXFyYV5eh+Smxm51X90T4FuIeZp8pkM38Mfrgr+HZ9n8l7H3+u4/o
	Uc7J1N0PFXtoyHKfG3uU9DaDbKKFUycxFIXgcA+ceN5yT2O3v5dHB1mAsG9CAQLE
	yulrxw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuja2av3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:13:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JMDJuj011554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:13:19 GMT
Received: from [10.71.108.229] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 15:13:18 -0700
Message-ID: <fba1e0d4-105f-4a1e-8aab-388b5af864b0@quicinc.com>
Date: Wed, 19 Jun 2024 15:13:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] drm/msm/hdmi: ensure that HDMI is one if HPD is
 requested
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
 <20240522-fd-hdmi-hpd-v2-13-c30bdb7c5c7e@linaro.org>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240522-fd-hdmi-hpd-v2-13-c30bdb7c5c7e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OyfO6UNj3ZqXRW-kdt7UC-rm7X5HoFUn
X-Proofpoint-ORIG-GUID: OyfO6UNj3ZqXRW-kdt7UC-rm7X5HoFUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=831 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190168



On 5/22/2024 3:51 AM, Dmitry Baryshkov wrote:
> The HDMI block needs to be enabled to properly generate HPD events. Make
> sure it is not turned off in the disable paths if HPD delivery is enabled.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

> ---
>   drivers/gpu/drm/msm/hdmi/hdmi.c        | 1 +
>   drivers/gpu/drm/msm/hdmi/hdmi.h        | 2 ++
>   drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 8 +++++++-
>   drivers/gpu/drm/msm/hdmi/hdmi_hpd.c    | 9 ++++++++-
>   4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index a9437054c015..2890196857f8 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -409,6 +409,7 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
>   	hdmi->pdev = pdev;
>   	hdmi->config = config;
>   	spin_lock_init(&hdmi->reg_lock);
> +	mutex_init(&hdmi->state_mutex);
>   
>   	ret = drm_of_find_panel_or_bridge(pdev->dev.of_node, 1, 0, NULL, &hdmi->next_bridge);
>   	if (ret && ret != -ENODEV)
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
> index 268ff8604423..7f0ca5252018 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.h
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
> @@ -42,6 +42,8 @@ struct hdmi {
>   
>   	/* video state: */
>   	bool power_on;
> +	bool hpd_enabled;
> +	struct mutex state_mutex; /* protects two booleans */
>   	unsigned long int pixclock;
>   
>   	void __iomem *mmio;
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> index cddba640d292..104107ed47d0 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> @@ -117,11 +117,13 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>   
>   	DBG("power up");
>   
> +	mutex_lock(&hdmi->state_mutex);
>   	if (!hdmi->power_on) {
>   		msm_hdmi_phy_resource_enable(phy);
>   		msm_hdmi_power_on(bridge);
>   		hdmi->power_on = true;
>   	}
> +	mutex_unlock(&hdmi->state_mutex);
>   
>   	if (hdmi->hdmi_mode) {
>   		msm_hdmi_config_avi_infoframe(hdmi);
> @@ -147,7 +149,10 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>   		msm_hdmi_hdcp_off(hdmi->hdcp_ctrl);
>   
>   	DBG("power down");
> -	msm_hdmi_set_mode(hdmi, false);
> +
> +	/* Keep the HDMI enabled if the HPD is enabled */
> +	mutex_lock(&hdmi->state_mutex);
> +	msm_hdmi_set_mode(hdmi, hdmi->hpd_enabled);
>   
>   	msm_hdmi_phy_powerdown(phy);
>   
> @@ -158,6 +163,7 @@ static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>   			msm_hdmi_audio_update(hdmi);
>   		msm_hdmi_phy_resource_disable(phy);
>   	}
> +	mutex_unlock(&hdmi->state_mutex);
>   }
>   
>   static void msm_hdmi_bridge_mode_set(struct drm_bridge *bridge,
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
> index d3353c6148ed..cb89e9e2c6ea 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_hpd.c
> @@ -73,10 +73,14 @@ int msm_hdmi_hpd_enable(struct drm_bridge *bridge)
>   	if (ret)
>   		return ret;
>   
> +	mutex_lock(&hdmi->state_mutex);
>   	msm_hdmi_set_mode(hdmi, false);
>   	msm_hdmi_phy_reset(hdmi);
>   	msm_hdmi_set_mode(hdmi, true);
>   
> +	hdmi->hpd_enabled = true;
> +	mutex_unlock(&hdmi->state_mutex);
> +
>   	hdmi_write(hdmi, REG_HDMI_USEC_REFTIMER, 0x0001001b);
>   
>   	/* enable HPD events: */
> @@ -106,7 +110,10 @@ void msm_hdmi_hpd_disable(struct hdmi *hdmi)
>   	/* Disable HPD interrupt */
>   	hdmi_write(hdmi, REG_HDMI_HPD_INT_CTRL, 0);
>   
> -	msm_hdmi_set_mode(hdmi, false);
> +	mutex_lock(&hdmi->state_mutex);
> +	hdmi->hpd_enabled = false;
> +	msm_hdmi_set_mode(hdmi, hdmi->power_on);
> +	mutex_unlock(&hdmi->state_mutex);
>   
>   	pm_runtime_put(dev);
>   }
> 
> -- 
> 2.39.2
> 

