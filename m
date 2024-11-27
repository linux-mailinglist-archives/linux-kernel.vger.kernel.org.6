Return-Path: <linux-kernel+bounces-423531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278FA9DA8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC605282568
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381741FECB8;
	Wed, 27 Nov 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qm12pG0B"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6711FECB6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715002; cv=none; b=jgu5HOgpiU5OskOM8zqYn5uSW1Av1S3uv54NDadxrnIJYMJSv1ACZQ2Y/Q9s6/ZiGmGwva9s0a1QJPuiTUEkoBgWie4syw22O1Z+2bzx1TFGdHOBlEi0lRFnjUziZqUP3vRd600i3+uSMGFLH2SCPgD9ge9M7w4zDI//T0+JYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715002; c=relaxed/simple;
	bh=fELUlbyrfqJ+YDSFrgxsr0LeqbBgZQjyG+s8pLZM+/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNVapq1MddG1EqBq1kjgwHR3HNy+JtExCe3gXKRElkAyCh6m4TcAm6wG/FP5Eh6x6wD1lrPZF0nDY+YUlzTz8K1UKocxawTBwIlXwFXf3kQL3Ub1TFroC9zc0NiumDwqCWO8lNzIl7P85fz9Z4VLx5p4lsWqe7TY7zuIsA+W1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qm12pG0B; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so4063441e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714999; x=1733319799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LIXGs4fTwSxjqXemGFw9+p2YdwTHf2NnHZwaHRGF6Nc=;
        b=qm12pG0BdLfHev9tO4E9aBUybETw5u/i3v4M7iM6zmkQ2WOGQY0q3dNKDhVG1Tt+U4
         3q0aSCuParkqtigUjxcr4GvgXkYekQaWKeKSoUfIOjrZ66FRUF5Oom9/9Va+0Z5dG07R
         j9ZiGrhkcQdjXFnYgePuQViueLYST5Ip+C19PUHO1OOgE6nSaIHh7Dkhpw13XCKUlDSZ
         is/7dyV/L3i5nCbLI7IK8qxARcO9HQGB1cOeq0pxB3YQLgFw5efafYLnhEEwsJvRORUX
         5mMObBK/DqCwKjN4GXE9SLmEB5Kd0j/D+gjgaKusMqBjfGDn6n1RnXNw2aUQADKimcom
         CpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714999; x=1733319799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIXGs4fTwSxjqXemGFw9+p2YdwTHf2NnHZwaHRGF6Nc=;
        b=t26jSOWG/1kpqpe5TxNC7gmAFCBjqYgPDirXRt9+VmIcOmqu6Hxz75QJ34xkkW2Sr3
         mSW487Mla/3rTqMlW/qa4iandlgp+DeC3uryXClZttGnOqQyldkJ4sZEj/QTK2JMLM8Z
         8wgD+q4yfjrcKjVlBCe5F/L1agBr2++q+IXbfvmf0kxDJvXC2R2JgNv2hbw8icJdZpoD
         A74OvUxgLSXMB497DR9uqWU+wBy5cYQ/3TF1eP7ImqA+jFcA+aKAnCQlNPZybvsj94OA
         U+azMWQOmJk7zipGNPoNvz2k4YMUgF6YsbxsFbN2hk1COcqIcZ/WUl0qxgcWNdmS2O2p
         HfAg==
X-Forwarded-Encrypted: i=1; AJvYcCWt4qorkXuJEPdvkuALvr6UxYFEqid/SENMwqwER027djRXrdF1EwgmPBstquUfpzIEJb1lWin0/oS1CL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCTwsvarXVs4x7DY+DWaAJNI/SeaZtPfpIbGkC+AaeBgVXFc9l
	9JnGHghLIEq7FjjbD5JXJU/+zqXDMmcFqln4Yjxni7ry9O2fZgdmrTXSSvyae8c=
X-Gm-Gg: ASbGncs9tVYuuqhVFs+8UJfaXFaqPrwTYAvebCTVyyUsqEmyXJdK3+gi+QwpDHVdcRO
	dPa/vUigoAZ/PRd+7ObL2dLgvfe5bTjSnie0lIns6c2RvPiWHjh8TobVUXhp/0Asf7R8gRuJvzn
	oscVKn82cQsFh4T9N1I3snQpg43kXSyrGrOtq9WKmpc4pfWrBAc3VdDPRGwoB4bbJrfYZHnegbu
	+IaxucjM1njmMoDd3sw4lmwTbVkxTLtd1RuV5C+7JgdG8vi5uLc+qHEPo7dDHAoSjxEVl3XXJ27
	Ob+KBVBWJuj0K/4f4jMUvc1osg5GEQ==
X-Google-Smtp-Source: AGHT+IHl4xTqfFayy6N/PMSQFKk1zMBlFF166s3qCjZQxpVTE21zLDuT/xgWMcxx1dKM+yaLNkjIHg==
X-Received: by 2002:a05:6512:313a:b0:53d:f177:51d0 with SMTP id 2adb3069b0e04-53df177526amr1071412e87.9.1732714998834;
        Wed, 27 Nov 2024 05:43:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53ddbfc2b7dsm1721318e87.129.2024.11.27.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:18 -0800 (PST)
Date: Wed, 27 Nov 2024 15:43:16 +0200
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
Subject: Re: [PATCH 4/4] drm/msm/dp: Add DisplayPort controller for QCS8300
Message-ID: <2ld2iwmvhz6myn6ume3lspi63wjefa3hpctoj2rdreaqhwdxmx@seic3sq2yo4h>
References: <20241127-qcs8300_dp-v1-0-0d30065c8c58@quicinc.com>
 <20241127-qcs8300_dp-v1-4-0d30065c8c58@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127-qcs8300_dp-v1-4-0d30065c8c58@quicinc.com>

On Wed, Nov 27, 2024 at 04:15:51PM +0800, Yongxing Mou wrote:
> The Qualcomm QCS8300 platform comes with a DisplayPort controller
> with same base offset with SA8775P, add support for this in the
> DisplayPort driver.

Can we reuse SA8775P config then? And SA8775p compatible as a fallback,
not requiring any driver modifications.

> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index aba925aab7ad7c6652e81004043864c1cb3ac370..f870faa89f26a8cb5bd7f4caf11f42e919c9efac 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -118,6 +118,11 @@ struct msm_dp_desc {
>  	bool wide_bus_supported;
>  };
>  
> +static const struct msm_dp_desc msm_dp_desc_qcs8300[] = {
> +	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{}
> +};
> +
>  static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
>  	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>  	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> @@ -170,6 +175,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
>  };
>  
>  static const struct of_device_id msm_dp_dt_match[] = {
> +	{ .compatible = "qcom,qcs8300-dp", .data = &msm_dp_desc_qcs8300 },
>  	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
>  	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
>  	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

