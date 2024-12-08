Return-Path: <linux-kernel+bounces-436297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126589E8405
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 07:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0420162693
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45F13AA26;
	Sun,  8 Dec 2024 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w67a2wI/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D1136351
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733639500; cv=none; b=EKBIr2UjRRkzXu4d5PdX04Oq/5w3Wh6oSXMbjwMRe4DB2nheBH6d+Iv1bMyQKKmSGbdv/xcF8uANdoBrFPb5cYJ/fwYwUd+Hg7i+HLRMYpioB1jQwNaQ+4heIhzhSJ/A8RQp5VdLaz6LTa7t4yJY73zQpX2/1zATJYgIpr88k/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733639500; c=relaxed/simple;
	bh=EMqHWbML9Vixdihnehlwf6UhvKO7C47xVA1jXkSy+dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaI2iHZo26jjn5AE5quruA6fMYHuz3oxKStG/21om1/VxJ+7TeCUKiy0k5tPiH+Q5W63djNN2NYy/gV2Ww3xTckva5UqXFx1SJJ4n/x+ZOiOxoD8mhVopdRypoNmCev0T08//nvqz6IMr0B+7ZXRtneD56xzIvBqq6Bpk5Fv2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w67a2wI/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so1786882e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 22:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733639496; x=1734244296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ8VS1dgJrZl5iBo3P2WYLWkQ0RmM/v740EhGg00bcs=;
        b=w67a2wI/qTUo6O2fwC0Y9JfNmh/L5PLJya5CCv0YDbHID5Ko+5mImaZKTb2CocQyTD
         gDSxgGn8roZ1AUKYF0140ofV/vMRMBspt5oVHp/6WJqercsu6FPgRDOJhXDQrzy8Tu3u
         jbVrfUwfS1/CPF2+J52PmsgCa0xGuEFnwckubdV05/EQoo+NxmHbNbIy/YNCcWj1k5YQ
         48Qvprg8FpXkSwRGH0Z3UrSJj1jtFxeuHW0Es5CZVpO0C2Jti9sqB6EUFIIHAyv7DPBJ
         Lwzk7wQI3WZ7eSvKvC3wWQooHwH1taCGSjmMmUO9nKQ/KeiOZ0OJOT9R5DBW8M+emmQo
         Lbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733639496; x=1734244296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ8VS1dgJrZl5iBo3P2WYLWkQ0RmM/v740EhGg00bcs=;
        b=s8CJJjYZO6oJjXq8P9gicDzncwJ4po/j3LxLo3S3dnzTFGYd68tUGF5qDgssobCa3N
         9Y7h7IkwXXMoX7AUk3aFFFoOP4Uf3Em2ITiYKeWPrG6OaqTpKtgYYWoTVte3sTXA/UNA
         9LGmYebVtempwEm+sbtj5Ousq0GyCPkT7VZoaERVt3K3GsWU+85xDOoK6Xyw05CFFj6f
         TsVE3tnxtA9cluol7lgDCAHo98N/UcTac5u0gYgfiplpSs2Kl6dIKiux8oVPpG7fxMys
         wd+hmzbxxMfY8bd1ptekJKKud278tdvBdH1OAmwXVN8kT/ACiJINR2Ld001+dCUwvOjm
         /8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWuSWpNkeX1OFR0+qRa5W+b0Hl9TzrUFfbUsndKQzAQoS7eN7GwRa8AoookxSEk1qghjplAnErrUU5eo3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKW+L7KfUS5hjmU7BAbDhBkZ3wDm+EyetYtOhN4IilWnITRdQ
	8RuMv8WrijrtksGXX5Cpe2Vq9wufBuqsvtApDUt+I0CJddOKU/PdqE23yZ8+L0I=
X-Gm-Gg: ASbGncth4GI9Jlib6/3zwspJ9MBA4iCfXl8mFqHuCVy4np/U8uawSYldGduL8kx+vLI
	ydd/+z4esjgdZxG1wkE+LLjnw9qcDsYD6GCTsb8krEwWJszjs+BFCHDwZ2Y7iCiuONp2UOduw4d
	vyIgrpgdWTXhALPgHUEZhMM0dmh2IqcOHClMwccwbU1EIG0GfI9O8PSyK87Z+WxzqRKHlEEtC6w
	Xm5/OKV3ylKAPgs/3LWya3emRWsrmy6kdMwZI8kW35NoOv+3JX4DVd9s29QT/lTFXIyKSu/P8a/
	ASairXdK8wpALV2UeXES1ejZw8IB6g==
X-Google-Smtp-Source: AGHT+IH6hoZScy0MbedHNXt8kj+dVMVo4BB42zGWyZlNI1Ar7AQiGDckU1+y1l3Sqi29CH+nNiPp8w==
X-Received: by 2002:a05:6512:61b:b0:53e:3a73:d05a with SMTP id 2adb3069b0e04-53e3a73d106mr1079651e87.55.1733639495903;
        Sat, 07 Dec 2024 22:31:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401c0382c5sm112619e87.32.2024.12.07.22.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 22:31:34 -0800 (PST)
Date: Sun, 8 Dec 2024 08:31:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 39/45] drm/msm/dp: initialize dp_mst module for each DP
 MST controller
Message-ID: <qu3b5cfxvxnnxwn4rwuqyxdpadrpvkhycyprs5n4aycecmdb4f@pvt2n3aajpxv>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-39-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-39-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:10PM -0800, Abhinav Kumar wrote:
> For each MST capable DP controller, initialize a dp_mst module to
> manage its DP MST operations. The DP MST module for each controller
> is the central entity to manage its topology related operations as
> well as interfacing with the rest of the DP driver.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  6 ++++++
>  drivers/gpu/drm/msm/dp/dp_display.c     | 12 ++++++++++++
>  drivers/gpu/drm/msm/msm_drv.h           |  7 +++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 359de04abf4bbead3daa5e8b357a3c34216e3e65..734d8972bbd65153778d5d70a55ac09dfc693ac9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -664,6 +664,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
>  		stream_cnt = msm_dp_get_mst_max_stream(priv->dp[i]);
>  
>  		if (stream_cnt > 1) {
> +			rc = msm_dp_mst_register(priv->dp[i]);
> +			if (rc) {
> +				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
> +				return rc;
> +			}
> +

This seems to be put backwards. I'd prefer if DPU driver allocated all
MST encoders and then called into the DP driver, letting it handle all
MST-related internals.

>  			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
>  				info.stream_id = stream_id;
>  				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index eafec9ab4f83cb44e861687e7550748b4d9b7ece..7f2eace17c126e3758c68bb0dee67662463a6e05 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -69,6 +69,8 @@ enum {
>  
>  #define WAIT_FOR_RESUME_TIMEOUT_JIFFIES (HZ / 2)
>  
> +#define MAX_DPCD_TRANSACTION_BYTES 16
> +
>  struct msm_dp_event {
>  	u32 event_id;
>  	u32 data;
> @@ -1689,6 +1691,16 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
>  	return 0;
>  }
>  
> +int msm_dp_mst_register(struct msm_dp *dp)
> +{
> +	struct msm_dp_display_private *dp_display;
> +
> +	dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> +
> +	return msm_dp_mst_init(dp, dp_display->max_stream,
> +			   MAX_DPCD_TRANSACTION_BYTES, dp_display->aux);

This doesn't seem to change between plaforms. Please push it to
msm_dp_mst_init() instead.

> +}
> +
>  void msm_dp_display_atomic_prepare(struct msm_dp *dp)
>  {
>  	int rc = 0;
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 12b50a797772f574122481cd8a1c7c88aacb8250..7ed0e25d6c2bc9e4e3d78895742226d22d103e4c 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -376,6 +376,8 @@ int msm_dp_get_mst_max_stream(const struct msm_dp *dp_display);
>  
>  int msm_dp_mst_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder);
>  
> +int msm_dp_mst_register(struct msm_dp *dp_display);
> +
>  #else
>  static inline int __init msm_dp_register(void)
>  {
> @@ -397,6 +399,11 @@ static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
>  	return -EINVAL;
>  }
>  
> +static inline int msm_dp_mst_register(struct msm_dp *dp_display)
> +{
> +	return -EINVAL;
> +}
> +
>  int msm_dp_mst_bridge_init(struct msm_dp *dp_display, struct drm_encoder *encoder)
>  {
>  	return -EINVAL;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

