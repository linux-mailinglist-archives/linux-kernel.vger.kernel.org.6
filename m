Return-Path: <linux-kernel+bounces-572820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B2A6CF1E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2028B18988EB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADE204C3D;
	Sun, 23 Mar 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mhSAlpxg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3C204C00
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742731573; cv=none; b=VNCCwfcdhFt+1rp/VrAMw03fcJKEs8kc2RxH+tU0fRq9WrOebt6Rl63toQBrjedC0ugI2Uo3ECx6babXlYoJygMm3LpP9VgISBxdGp43QXmQnOKrmC2CO9w8sVeI4UsUzZwy71X/4rnPPTWObiwkopwFyX08nJElikBwSjV4j8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742731573; c=relaxed/simple;
	bh=a5BRRRtbCnYmmOGcyIFlPekdw2fVBQnk2B1iwJFGtQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK1MctHVJbMMRPjG/eBASqNiNRYIgmVYGl/3ryeN8AJngvJ4gE11AKZ7xC7oeDehIV27VAmqMxEIClEQXJByEYOZT+Fwsl/msUwCRvrFj1r2u0JOYvwYvRq4GzWcy8kO5qL3lAq3HQLBAiAvDZCGPfMWRFseUT8CZ1RgVM4BO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mhSAlpxg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N9KDGM032449
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MV32qCiB38FYLSVABwWjrG0V
	5R2pP5jz+dWOa/JclsU=; b=mhSAlpxgAt7A7bAdKGZ2oIrYq/sM9Xu6hMy5chAa
	DRrmZrhYINDUQuziAlJynO6xUl+l4IMQARyRnDuJf1IQibZePQg1Yo5cBwvSj9Mp
	MNaIlP+52uuyu5OOX8N+FUCbBoj9V9QWLNH7TQh7IAtBddZcKnaxuHxb6HsXRAGw
	uqyHrKqnwKPmMFRJSgI9nWOBkhyIwbee/KmNDky5iWHKZ527+9mcqO1k/7EvvrAb
	Q1KJ+joEUHwutL2xitTajlDPRdLUgghcSFms1jtkCdurAGgL0+K7DWez8iRvIfqp
	yiRMS47bawCRI+8GZlDCjyacd+uP3VIQ1NFCwxe/m+QMrQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnk8hyux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:06:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0b0cf53f3so572901585a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742731569; x=1743336369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV32qCiB38FYLSVABwWjrG0V5R2pP5jz+dWOa/JclsU=;
        b=qd0IyOMUjDqQ+bNEVU8bFg8YkWS9WwekRD5kWzJgCZ+Eazm0ZHeckbbviF5r1sUp+5
         zvQYAdSy+lskx8lt9O6y/COwPnGjIjr9Ep6OlBi7uDunNvBElkidqlceCCHRhun8uude
         gSrf0szlRK7whGb8RCNngqFYX1Xn/CZRmE1PHUAkaG4yrFFUXiWdqaxzxrT4Hb8ifzU0
         c9XXComBRhkAvjaVg+r372BxJX7k7JRja+ravivYTkNXQvozZ2JMUH9/C8aFDKP6Apng
         SNNmZVT6XOd6wbVzK482GJSgjvpVoBMQ8+7qctyAQ45j27j2YQBXF7DwmPypaeH4pNCj
         j9hA==
X-Forwarded-Encrypted: i=1; AJvYcCXpILpSQMc2ONpTbCNXrh8fN7w8YqEI6qCJUXbsv28jjPDkV4VP70V1tGSqelC09I2vv/iXBfmQv7ekPh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ppLHXXFPF9qjEIdmbijfRm8sLKzQ8XqwOhUCaw8Bf+Fy9sSw
	bVJjp16wPkWW/dJDtRH8WTBJUED8wZuQ59myNumhMKxCrjII33WayrjuHYRJEljS5ZUu1H9AQQW
	OeKITWoiifWYqaxsbU+AclBj1gnKzhdrTk45yWFXTtao0vEptjR95swr0BXEHzZU=
X-Gm-Gg: ASbGncu12bvyNlO8W2KJ+NSczWI0EIZujqEIGYUmmmvLfC83UWhWwO9NytudABeUO+a
	wTw9+Z9333vn3KfnuRfTCMk+NJSsu8qbmPCHrPfoWEqQBcYx/DlhwoaSB0HFBRcHzCWg/F8jx2J
	LKL5krkwn3hr+38kF2Kk1iGwpS0E4D3iRRJExYYop8c9k+K7jrj9rcRpseYr4pQn5ZVHtDF2I05
	YnA1bQ5qGbphLw2J/7SRdC45upsKjs/38N0AU/wzyC5iH66aNBMAOCdm3xj34XWK2bAKD6UhqId
	BIzDY3qscC9e8vfZyHytzWqCn+/iheB7Psb5iyX8umfGFtLexfgK5SRifgfMR9TIR3O+Gvilt44
	FlVA=
X-Received: by 2002:a05:620a:191e:b0:7c5:5d83:2ea8 with SMTP id af79cd13be357-7c5ba191d17mr1282046085a.34.1742731569464;
        Sun, 23 Mar 2025 05:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSk5U6ZXm8gW7Il/iWs/ZGcfd2ZuajH0qgw8cFlxalF2lUpkYJJ58AqSDCJy+z1woszsYucQ==
X-Received: by 2002:a05:620a:191e:b0:7c5:5d83:2ea8 with SMTP id af79cd13be357-7c5ba191d17mr1282040785a.34.1742731568968;
        Sun, 23 Mar 2025 05:06:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbb1asm764400e87.120.2025.03.23.05.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:06:06 -0700 (PDT)
Date: Sun, 23 Mar 2025 14:06:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes Wu <Hermes.wu@ite.com.tw>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3] drm/bridge: it6505: skip auto training when
 previous try fail
Message-ID: <ygndq6rndwduzxi77clpofvck4px5ohsnifpug6nupjzt4cs7g@npjx2othedpp>
References: <20250318-fix-link-training-v1-0-19266711142c@ite.com.tw>
 <20250318-fix-link-training-v1-3-19266711142c@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-fix-link-training-v1-3-19266711142c@ite.com.tw>
X-Proofpoint-ORIG-GUID: hgbowtHgfHjmoIhOSwz8jCaG5B20zJhG
X-Authority-Analysis: v=2.4 cv=KMlaDEFo c=1 sm=1 tr=0 ts=67dff932 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=Ns9eNvu6AAAA:8 a=CAG1TeXkPrI7es7L6SQA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-GUID: hgbowtHgfHjmoIhOSwz8jCaG5B20zJhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503230090

On Tue, Mar 18, 2025 at 04:32:11PM +0800, Hermes Wu wrote:
> When connect to device which can only training done by
> step training, skip auto training when link training restart,
> usually happen when display resolution is changed.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 11231a642bbe185c4f36bf5f2a0b115fa056213b..730481a9446ff00a54ef70e86b4c28ff0a3f417e 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -468,6 +468,7 @@ struct it6505 {
>  	struct work_struct hdcp_wait_ksv_list;
>  	struct completion extcon_completion;
>  	u8 auto_train_retry;
> +	u8 step_train_only;
>  	bool hdcp_desired;
>  	bool is_repeater;
>  	u8 hdcp_down_stream_count;
> @@ -2459,11 +2460,13 @@ static void it6505_link_step_train_process(struct it6505 *it6505)
>  				     ret ? "pass" : "failed", i + 1);
>  		if (ret) {
>  			it6505_link_train_ok(it6505);
> +			it6505->step_train_only = true;
>  			return;
>  		}
>  	}
>  
>  	DRM_DEV_DEBUG_DRIVER(dev, "training fail");
> +	it6505->step_train_only = false;
>  	it6505->link_state = LINK_IDLE;
>  	it6505_video_reset(it6505);
>  }
> @@ -2479,21 +2482,23 @@ static void it6505_link_training_work(struct work_struct *work)
>  
>  	if (!it6505_get_sink_hpd_status(it6505))
>  		return;
> -
> -	retry = it6505->auto_train_retry;
> -	do {
> -		it6505_link_training_setup(it6505);
> -		it6505_reset_hdcp(it6505);
> -		it6505_aux_reset(it6505);
> -
> -		ret = it6505_link_start_auto_train(it6505);
> -		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
> -			     ret ? "pass" : "failed", it6505->auto_train_retry);
> -		if (ret) {
> -			it6505_link_train_ok(it6505);
> -			return;
> -		}
> -	} while (retry--);
> +	/* skip auto training if previous auto train is fail*/
> +	if (!it6505->step_train_only) {
> +		retry = it6505->auto_train_retry;
> +		do {
> +			it6505_link_training_setup(it6505);
> +			it6505_reset_hdcp(it6505);
> +			it6505_aux_reset(it6505);
> +
> +			ret = it6505_link_start_auto_train(it6505);
> +			DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
> +				ret ? "pass" : "failed", it6505->auto_train_retry);
> +			if (ret) {
> +				it6505_link_train_ok(it6505);
> +				return;
> +			}
> +		} while (retry--);

This really looks like

	for (retry = 0;
	     retry < AUTO_TRAIN_RETRY && !it6505->step_train_only ;
	     retry++)

Please consider changing the previous patch and this patch accordingly.

> +	}
>  
>  	/*After HW auto training fail, try link training step by step*/
>  	it6505_link_step_train_process(it6505);
> @@ -2605,6 +2610,7 @@ static void it6505_irq_hpd(struct it6505 *it6505)
>  			it6505_parse_link_capabilities(it6505);
>  		}
>  		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
> +		it6505->step_train_only = false;
>  
>  		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
>  					     DP_SET_POWER_D0);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

