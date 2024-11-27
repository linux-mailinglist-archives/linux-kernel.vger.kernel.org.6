Return-Path: <linux-kernel+bounces-423518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C859DA8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A248281466
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DD41FCF73;
	Wed, 27 Nov 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCekTdkt"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6481FCFDC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714883; cv=none; b=m6Yf/oCWkrzNVvnQKTPk/gESRNWfVjpcS0waPR8v7yBsAyGvXZlH/AtlxrNQ100MIMLnWB2EG3ukBQkyK+AT0ik8aU12OZuu9xQShAdBrQmX40Etlg4Hahx8fi/lh+8+zEK2cX/h6nQX7ZTz6PvnHgXB18dwubmHdp3kkHE3eyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714883; c=relaxed/simple;
	bh=ySPedvBJevYjtblSz3wodfE4A8z/KCFgNZPKngqn6RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCAsxciBNvQCufuHF1vEjgu8IlKw/50mH8dedmkUGDQRoEDbV01WA2fs9P4fuGWmYFr95oJjRMAK9z94cmMi9ZzSnZ0w5unbQh/lZ5A0vwnKG5F0gSzrB6CnG2cNYNAl6E7xDLZrm81Jj22vqGi4eDoXL1Vl+x5NoDjz3oamPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rCekTdkt; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de6b7da14so3266595e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714880; x=1733319680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+V0B8FgWwCZYmESnMjYEXbPLdTp7ON4XeU+NCnDG0sM=;
        b=rCekTdkt8YkjJpLmPc5KUeLL+2QN43j0QjeeB7RK19/9ggR6r5wLPvhqiyCegmpgI3
         cbcGvrArgBVXCudovRvI85RIsiJs4tWzZTIi0jaI+oao0x0UhvrhtJnl9tfYitJB8hPh
         vyBMd1km8v5Ph42Rj/kdqVUaZTRHm86phwjimVM1bTfdTg19yZJ0zlDytyGjBErdViTV
         dXHwyyCvMUq0FXNOFHag/77JDdOSmc0uCpxJbuzA0A7h03qBs7AFgzMsV3yQ4pIzGk6M
         xak0IVHwW3HmnH+nwCkc0Kns5g/TwdR7izsqqMvFRhSPzdWzGSlVq9yYp3UiYAdDHQeG
         GTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714880; x=1733319680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V0B8FgWwCZYmESnMjYEXbPLdTp7ON4XeU+NCnDG0sM=;
        b=V6hcZYvbTryVge/9jnXzlW/Zec7Ar3ZAspJL6YJ+gfXyqOqaBGmko/iohsrJXSiSjS
         Tha8ckvGYEslhNPfdL5LPdsSuF1hNfGN7QbeXwh1E8MReOvKRNRmzEJOyp+wk6VCenqc
         ZSQE5x6OiyFe5PpHB4C+jKMsOTjDqawRNKbHy/sayWmTq0xArBt5zKPR3jgl/gA7GYk8
         ajsQ4EQO9YEmVJ64X7zvVAuvjApIXkhYlTKLKlmSAtIKnw0B8pjPPp5cAJqJ6LaWXt2b
         jNSBgvKTmP3NClu0rHRbQyEmVOFEFGQFsJ3NGGZtecXLdVvYuYWyLNB+PWSxYGdJpakQ
         DNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfduvQ6CLHPqNO4GfqLt8F3KJOVD9852Ub/PNdvq3tvIwOQgSsPa5ubdsvpuBfTkWPodQkqsxN+KXQbUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7f1LGE3GqNz63HR8gSBTRzSGutG/+AkkwERrAGNg+4/esOIk9
	7UJJAG6yzhD4an49zPnnzPE0Etcv4IhM6YL6qyStN9sH/OZCqp1Cq/kYiuiTlfk=
X-Gm-Gg: ASbGncvTnwRE3qUUcnWMJyC/xQo2VM8idzctwoWJC5GVO1bNxuAOG+j58NY36XFSSIb
	r+6fFOIZvEvraV+jgQ15XnRdo/KXHYwZ2gTEoaz//QrIvr1TDqrSjv6IK0XSPKLU12jzNO3qsDs
	9lwIizut7nPjFvJ5dtT/aAkjN+yLYzWrIahGXRQpkhNxc5JgHZZ4FOvlVHajyPy4lalzI22nNsK
	JwX8kxZdbVOzpEGNXnYgXuT4ttBGZDATdy3p1zZ7gXk/xf5bUm9DeUnISUuZxP0q8yg0L9qy0fN
	U0aUZUNdt08X2BS1ZHh97LIfOQv6hQ==
X-Google-Smtp-Source: AGHT+IG9BNVyGMPhRMDkSB666seeuc69CW+Jv5lBWbNwNRZPtIr56nhPI2eE0zoLaGS7x7+3k7cyFg==
X-Received: by 2002:a05:6512:3a8f:b0:53d:a4f3:29ed with SMTP id 2adb3069b0e04-53df00dd707mr910972e87.27.1732714879617;
        Wed, 27 Nov 2024 05:41:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd336a530sm2263130e87.142.2024.11.27.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:41:19 -0800 (PST)
Date: Wed, 27 Nov 2024 15:41:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Ritesh Kumar <quic_riteshk@quicinc.com>
Subject: Re: [PATCH 2/4] phy: qcom: edp: Add support for eDP PHY on QCS8300
Message-ID: <new6hjxnwyuohetdprxwee3epf23uemwft2p7faym5f5zqv3og@fksrew4blk7p>
References: <20241127-qcs8300_dp-v1-0-0d30065c8c58@quicinc.com>
 <20241127-qcs8300_dp-v1-2-0d30065c8c58@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127-qcs8300_dp-v1-2-0d30065c8c58@quicinc.com>

On Wed, Nov 27, 2024 at 04:15:49PM +0800, Yongxing Mou wrote:
> Add support for eDP PHY v5 found on the Qualcomm QCS8300 platform.
> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index f1b51018683d51df064f60440864c6031638670c..90e0a399c25299ad1b2fb5df8512ba3888661046 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -532,6 +532,13 @@ static const struct phy_ver_ops qcom_edp_phy_ops_v4 = {
>  	.com_configure_ssc	= qcom_edp_com_configure_ssc_v4,
>  };
>  
> +static const struct qcom_edp_phy_cfg qcs8300_dp_phy_cfg = {
> +	.is_edp = false,
> +	.aux_cfg = edp_phy_aux_cfg_v5,
> +	.swing_pre_emph_cfg = &edp_phy_swing_pre_emph_cfg_v5,
> +	.ver_ops = &qcom_edp_phy_ops_v4,
> +};
> +
>  static const struct qcom_edp_phy_cfg sa8775p_dp_phy_cfg = {
>  	.is_edp = false,
>  	.aux_cfg = edp_phy_aux_cfg_v5,
> @@ -1133,6 +1140,7 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_edp_phy_match_table[] = {
> +	{ .compatible = "qcom,qcs8300-edp-phy", .data = &qcs8300_dp_phy_cfg, },

If the setup is the same as SA8775p and you don't expect any
QCS8300-specific tunings, please reuse sa8775p as a fallback compat.

>  	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },
>  	{ .compatible = "qcom,sc7280-edp-phy", .data = &sc7280_dp_phy_cfg, },
>  	{ .compatible = "qcom,sc8180x-edp-phy", .data = &sc7280_dp_phy_cfg, },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

