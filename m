Return-Path: <linux-kernel+bounces-436318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365A9E8451
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330D5165601
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2813BC12;
	Sun,  8 Dec 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsYaYn8g"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7D7F7FC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733648008; cv=none; b=da0AKF2pOrzPZT3sodJM8z7pLIxumCdztPLSscD9a3jIhyQ3J/W167G4+UDQuhRwVDbFOsKJynUS0YyxrlZHj47okqZxF4wTI14c6aUPfwWILX/PgopOXZdpYLAIW19a9UHDYnFuOylKTuf//4SygRbjzGFh35VT4b7VVzw8krw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733648008; c=relaxed/simple;
	bh=H5EyL9jQ21RFhE6zuTSUWs9tj+SwHmAvMrEHYHMxKKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWpgJyYA35UAWGexVfvO1b0cEpw7GrhJz7N712DIM63oTvdbBSv3lQEw7rZekSKydhdPvFHS4V1np7NqNd0SbHRP71YJ5SSocEsYJQ9P1HFKzJzfSloY94xccKGAa5jutgXEkBt/cZsDJ19fnZAA5NTq397XjDfQaDAJ23Gvu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LsYaYn8g; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso1125596e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 00:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733648004; x=1734252804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zY+Pv5KBIJ+oPWTRsUPh052qMWmxG7CG8z02rc7oAFw=;
        b=LsYaYn8ga6ajkwWFGzpSozWXAwMv0h5wwoLK19STQgyq+W2CkmHunezmZax3IgFyGI
         DowY3MOdBSgZJU6PdEz72gnatsx3x46oX3uhBsbEKfyiNw02et+IGiCvqsB8cDu0yqU1
         sLPV25NSmUrOxNARiZUE0goEn3K2KWjOq8gMSYLrGw0vxyI8C6hNkZvV8Zg05y6ZZxQ5
         zCzNsNltEEc3QCD7Sj2w5PXA4VnbSNK/ViPOK7XNuLcSGFqaZdO5zaXWVTpZepdi+myS
         0gNmnVNms5Jmy1+crdICZ+d5565sVf9WOyrLZQnB0PAfeeCP8650TRP6Xd4SdtjEUDE9
         ODdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733648004; x=1734252804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY+Pv5KBIJ+oPWTRsUPh052qMWmxG7CG8z02rc7oAFw=;
        b=QTb5YxUx1ATcvaqu8aLWsYUBGqp6Wg8C+Rk/GYW7TCvxdetDwYEk5i/ijEQBFS6rF/
         1AAVismzi+snRWa1pQbdtXQ9QpnxHlygISkN/uagggXiRIA25YwcpPxcnIh+SQHLMXaB
         2UGaAdYeVtVeh7PtQIT9axEJXtq0IknNCZU0KyXOlr9yM76hDwDPCWIJNvQqFgQnUsFD
         JNPl1tBnPTzXmCATLp8jsairXoCnWsWPIKvOureSIMpTgxpuvwg0BrXTkhaPs5edoClM
         1mu+SVAlHSqRxjjl2Vr4KQBemZNy5Zvws9hqqtSHsdqAOjDGoM6I27yKNu4kxev0VhRm
         /czw==
X-Forwarded-Encrypted: i=1; AJvYcCWKXz3JII6Ya3MlSVj3vhGsiNNgXhiz7gvVBqmU26w1Pn2rMTIXl3KppEnynGQo8mRsOwxuCAt3Als46Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGuyN1L4yQKZHWci3y4R9OjfQrR1qMk46TcQja8GDlOtbW5FmY
	8rs2lGLDFw49PBcvnr5npFxKYWd+w4rWquLMcYCUbU6uS+fSUZNpRqiO76ffO5E=
X-Gm-Gg: ASbGnct3zFC5Z/cH/B3lkYHN6HVgFipmSdqg6uWrwf2LkQ7Ucnb3n54NQn5yV5kNKYh
	f4gT6hhozZQm8oYEQ3SXi8zO8MzRs0ND7i8sc/vQK62TFKlLYb772y1gxxXlK9cN7hi5nkYHSfV
	kG1xflckHv7bc4Q6JWiRyf29DrECU08WMMX9M2zEvpR0EOWRnX2yhHCFeD5GYFo5/0drf8t3Rpq
	1q8EWODGL9EthqrMmTnpkeqAjAwatUBNtYS4fVXP4JpIu0vA1nT5P0Ac2ROXhg/zGKGSrz/Lfdn
	HchkEWaTCVGVXpRqxNvSu22z35w2tQ==
X-Google-Smtp-Source: AGHT+IF7VW3CEt9YUY48meab0OCFP6OZd58+C+IHLBA2TCMgaXgZWeZ4Fj2CYW6DegRR++wyQYIJVg==
X-Received: by 2002:a05:6512:1385:b0:540:19ce:6895 with SMTP id 2adb3069b0e04-54019ce6b9cmr725514e87.1.1733648004347;
        Sun, 08 Dec 2024 00:53:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22947abbsm1040344e87.19.2024.12.08.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 00:53:23 -0800 (PST)
Date: Sun, 8 Dec 2024 10:53:21 +0200
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
Subject: Re: [PATCH 34/45] drm/msm/dp: add support to re-use and clear the
 panel edid
Message-ID: <va2hxznd76lu7fei4gspvxh4usfd3ebwawd2isvbhjbxjvlldc@gd2drcvx7ts2>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-34-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-34-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:05PM -0800, Abhinav Kumar wrote:
> During certain cases, the dp mst connector's panel edid can be
> re-used such as getting multiple get_modes() without irq_hpd and
> should be cleared in cases when the connector is destroyed or when
> irq hpd is received. Add support to handle these cases for the
> mst_connector's panel edid.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index 2d92084586b466d4953429e8a6fbf766d081cb9f..15c61fd37c418889074222c0f576778adadf51c9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -559,6 +559,34 @@ static struct msm_dp_mst_bridge_state *msm_dp_mst_br_priv_state(struct drm_atomi
>  										&bridge->obj));
>  }
>  
> +static void msm_dp_mst_clear_panel_edid(struct msm_dp *dp_display)
> +{
> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> +	struct msm_dp_mst_connector *mst_conn;
> +	struct msm_dp_panel *dp_panel;
> +	struct msm_dp_mst_bridge *dp_bridge;
> +	int i;
> +
> +	if (!dp_display) {
> +		DRM_ERROR("invalid input\n");
> +		return;
> +	}

Drop

> +
> +	for (i = 0; i < mst->max_streams; i++) {
> +		dp_bridge = &mst->mst_bridge[i];
> +		mst_conn = to_msm_dp_mst_connector(dp_bridge->connector);
> +		dp_panel = dp_bridge->msm_dp_panel;
> +
> +		if (!dp_panel || !mst_conn || !mst_conn->mst_port)
> +			continue;
> +
> +		if (dp_panel->drm_edid) {
> +			drm_edid_free(dp_panel->drm_edid);
> +			dp_panel->drm_edid = NULL;
> +		}
> +	}
> +}
> +
>  /* DP MST HPD IRQ callback */
>  void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
>  {
> @@ -585,6 +613,9 @@ void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
>  	if (handled) {
>  		rc = drm_dp_dpcd_writeb(mst->dp_aux, esi_res, ack[1]);
>  
> +		if (ack[1] & DP_UP_REQ_MSG_RDY)
> +			msm_dp_mst_clear_panel_edid(dp_display);
> +
>  		if (rc != 1)
>  			DRM_ERROR("dpcd esi_res failed. rc=%d\n", rc);
>  
> @@ -620,6 +651,9 @@ static int msm_dp_mst_connector_get_modes(struct drm_connector *connector)
>  	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
>  	struct msm_dp_panel *dp_panel = mst_conn->dp_panel;
>  
> +	if (dp_panel->drm_edid)
> +		goto duplicate_edid;
> +
>  	drm_edid_free(dp_panel->drm_edid);
>  
>  	dp_panel->drm_edid = drm_dp_mst_edid_read(connector, &mst->mst_mgr, mst_conn->mst_port);
> @@ -628,6 +662,7 @@ static int msm_dp_mst_connector_get_modes(struct drm_connector *connector)
>  		return -EINVAL;
>  	}
>  
> +duplicate_edid:
>  	drm_edid_connector_update(connector, dp_panel->drm_edid);

No need to update connector. Goto to the next line instead.

>  
>  	return drm_edid_connector_add_modes(connector);
> @@ -894,6 +929,10 @@ static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
>  static void dp_mst_connector_destroy(struct drm_connector *connector)
>  {
>  	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(connector);
> +	struct msm_dp_panel *dp_panel = mst_conn->dp_panel;
> +
> +	drm_edid_free(dp_panel->drm_edid);
> +	dp_panel->drm_edid = NULL;
>  
>  	drm_connector_cleanup(connector);
>  	drm_dp_mst_put_port_malloc(mst_conn->mst_port);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

