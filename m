Return-Path: <linux-kernel+bounces-436320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4099E845E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B291884A44
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B20339A0;
	Sun,  8 Dec 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNyNjEmG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922812D758
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733648323; cv=none; b=lPykk0tP96zRJzhGIsv0DTXsePG1CMpct+NOm11F2gnIrJ1dWwE5exPEIg2IAq5BjIvUIU8CP2lokNskdgY6UtyPc3hD9x+uKW2fH8WVkvDcgQpk8a08nhxMBbxMOfvNvGWuQL/PlrWXGyoiff7Nw85qk/5wp1Hj44RmshwlYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733648323; c=relaxed/simple;
	bh=RQbkyjKr4TiDipSsUEXn2zR8QYwoe4/tilEBRq4ksH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXAoGCxQKwt6WJPLnQPPJ2JAheKYaLAvLLIPoQMV51Qvq7OHXAQBBK3Xnu65sPW01rYbsSXNJh3g+rG+2XqxhRJWf+KUPYp9Vzf8t/9JDqgZL/1aBnoaM5dn8oDKqNsJ/f+tk3Zb/xxTpVM2d+pA9kRZYCCULsFAaxWQkV+z3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNyNjEmG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e3778bffdso2027478e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733648319; x=1734253119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7Uh+SJQekyCtS3Bb8quKYzQ2jhfqR7g6RmC561JgnU=;
        b=eNyNjEmGSVAhTKyUeV1I3mCtANCswL7L0hTrC30eEM8em0XHcMBiEuJxBZFvQyapIV
         cGXAv7m7vyWFkLpa29QULkvILTzl6j3BNlv2Y2v6vUbLlFAWoKtZOI3nCs92dXbbqY8W
         X/9OKDhOmJeC+Qh4Ykqx9MSfceUSKPpba4eUyNduMGq17NICkdPmWmWNAhnUCKU95esI
         Qi3DINqb9eglJ8+wUlUrRhcN6FznaFKgqW6YiLLzR/rQmE52rRG6tucsuh6eZGV7kTBZ
         DgH+vO2NfonyD+MykHh64z/H9eD/5wLSYkd9xhG+qYsjaRrPqFXm50L34pgQUsp8tSzi
         Iypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733648319; x=1734253119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7Uh+SJQekyCtS3Bb8quKYzQ2jhfqR7g6RmC561JgnU=;
        b=iRCvSlgptJ/B3ZXVtQwUl3NCZ/KtLQlhQMs4aagLp3TUdcP8esVH89XMB5P8QIA5YW
         jT/JZ2bADQo5+JGkHdQ/tX3p5DOQUM6VfmnWBD0LJvZBq3fjy9KXxQXY2zfREWZHe8tS
         iKcsWrb5/qqrmkFCuB9uJOdJd2TbuIEuuvEMvIciE1ZjKxDlyW1sdijOKMgWOSGqXOli
         l2Q5dgSksD6ALCIvTj7efEjRR+YX5FT47xoOnthrRqbpt08dlXEPjt2zM3aTW56D88x4
         tKcbY/ETbPbG6QaMeyLcFlsvgNOBS2UxVX1oWYV0EulxRBx0ps/s7AYHhu2DudRQAm/A
         62gg==
X-Forwarded-Encrypted: i=1; AJvYcCUicEC6+GbvEN9L+0Lafn4cjhBCN9yhmpqhUKuNb3uQj4Tjg1IS3sDBAPH/W161pHo+en+mJgyo9+CKDl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymGd1vTWvQZScdUsi5Ie4FhavRtvWvErEdYmZznVcM73RNjnEF
	Eii+Oo+IxgKrEoJOuN6Ez6hibWb/57cX29dePUMEo9iRthYFqLExvh9bJQP9R3s=
X-Gm-Gg: ASbGncuwehKtRAT8AiT1yEtkff1rp1PG2r/3hULkZj30Q3hBpqssTM5sX1cu75Cpqzg
	8WFMkoa/RW76W8Qhw9uHLNn/f4mONDRUXwAffKXSfgWlDpl7sPgNiQg9PRCcojjMrvo5PHpWiHT
	E6LT3IFUDiwymyQm2LxzD3DYub1q76whEtVcX0IrA0zxFZgmHYD6iI9n94FP5gIus/jE5JNNuBo
	/xB2ubO57SxNBOqx0uarAkmLvo57etnlFECe+Wmk2aLZh8PMO+Sg0viYZhcEGSUuHSVL0forAsj
	xRwkE2FqfYH1vSRkbbPcvVeWnwlZeg==
X-Google-Smtp-Source: AGHT+IH2ch7ihmd9jopH5ZUgfSxWgUmNfamdhAezIqSfVOYXD+euFjFOJiJWhx2N3HmtHnu0C5AiMQ==
X-Received: by 2002:a05:6512:2208:b0:540:1e17:10d2 with SMTP id 2adb3069b0e04-5401e1713acmr110960e87.49.1733648319062;
        Sun, 08 Dec 2024 00:58:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f22eaec0esm364933e87.72.2024.12.08.00.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 00:58:37 -0800 (PST)
Date: Sun, 8 Dec 2024 10:58:35 +0200
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
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH 36/45] drm/msm/dp: propagate hpd state changes to dp mst
 module
Message-ID: <z55f2r7ooavjoj7gbjr4cg6xbf3p7bjayl5oe2uk26esgpdvfz@jx4kxbmyz7zq>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-36-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-36-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:07PM -0800, Abhinav Kumar wrote:
> From: Yongxing Mou <quic_yongmou@quicinc.com>
> 
> Propagate the hpd state changes to dp mst module so that it

please fix upcase.

> can be synchronized with the cable connect/disconnect.

It doesn't propagate HPD state. Instead it updates MST state when the
device is plugged / unplugged.

> 
> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 20 ++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>  3 files changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 97f8228042773f51f23a9d39fc009de0798059d7..80df79a7c2077d49184cdeb7b801bf0699ff4ece 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -26,6 +26,7 @@
>  #include "dp_drm.h"
>  #include "dp_audio.h"
>  #include "dp_debug.h"
> +#include "dp_mst_drm.h"
>  
>  static bool psr_enabled = false;
>  module_param(psr_enabled, bool, 0);
> @@ -409,6 +410,17 @@ static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
>  	msm_dp->mst_active = true;
>  }
>  
> +static void msm_dp_display_set_mst_mgr_state(struct msm_dp_display_private *dp,
> +					     bool state)
> +{
> +	if (!dp->msm_dp_display.mst_active)
> +		return;
> +
> +	msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, state);
> +
> +	drm_dbg_dp(dp->drm_dev, "mst_mgr_state: %d\n", state);
> +}
> +
>  static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  {
>  	struct drm_connector *connector = dp->msm_dp_display.connector;
> @@ -455,6 +467,8 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  		goto end;
>  	}
>  
> +	msm_dp_display_set_mst_mgr_state(dp, true);
> +
>  	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
>  
>  end:
> @@ -521,6 +535,12 @@ static int msm_dp_display_usbpd_configure_cb(struct device *dev)
>  static int msm_dp_display_notify_disconnect(struct device *dev)
>  {
>  	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
> +	struct msm_dp *dp_display = &dp->msm_dp_display;
> +
> +	if (dp_display->mst_active) {
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
> +		dp_display->mst_active = false;
> +	}
>  
>  	msm_dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index 313eb63b9a35cbbb36db2d7d8f0a85e4441f2998..1149af71d01f99ba5326870fa69e30ae081d6101 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -1043,6 +1043,24 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
>  	return &mst_connector->connector;
>  }
>  
> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
> +{
> +	int rc;
> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> +
> +	if (state)
> +		mst->mst_session_hpd_state = state;

Where is mst_session_hpd_state cleared?

> +
> +	rc = drm_dp_mst_topology_mgr_set_mst(&mst->mst_mgr, state);
> +	if (rc < 0) {
> +		DRM_ERROR("failed to set topology mgr state to %d. rc %d\n",
> +			  state, rc);
> +	}
> +
> +	drm_dbg_dp(dp_display->drm_dev, "dp_mst_display_set_mgr_state state:%d\n", state);
> +	return rc;
> +}
> +
>  static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
>  	.add_connector = msm_dp_mst_add_connector,
>  };
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> index b1adb8a61115d4809107553809206bb2ed3c6c3d..b89913ef7b343d449e0003f56b96df049fa36e89 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> @@ -105,5 +105,6 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams,
>  		    u32 max_dpcd_transaction_bytes, struct drm_dp_aux *drm_aux);
>  
>  void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
>  
>  #endif /* _DP_MST_DRM_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

