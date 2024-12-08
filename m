Return-Path: <linux-kernel+bounces-436299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F549E840B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 07:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7664281AE0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A5B82488;
	Sun,  8 Dec 2024 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4iVzTte"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E073176
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733640299; cv=none; b=QVpCcYSO/z4NG59fSOeaS+NtXGah6J8APqv5su5hUdel92WtK4/jw6ZVKyxbtTcd9sEWZzFs4dS2jK6Pc2Mryexv6VprJZ/sdtlYudtyYmvn7y0miJ8iFiC3unblpCs641DgexNQlwn/9E3MM17ILqlNKwR78tOLwtFzIU4Gkfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733640299; c=relaxed/simple;
	bh=U+22P7F7LLVUcbjZzgyNY9L179vVm+rtFwy13NDaJ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3sg1DfGeQgJH6KT4RC16pwBWkQy1/Cmpac+96Pzp92G10htGyjgu0YbJexSNAB4/Evo1lLlOwpcnyYSqULdWJ2U9hflVtyadvOsiKGV6upDdfPwVD1HPTIiHo5dG9B0ml0MQ5df6ggFCr0/QsQnQpXWJWmHr01oGubS98ieZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G4iVzTte; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso33462951fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 22:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733640295; x=1734245095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdGNHQAJUzYyjbohAt/0A6Ng2wZg9B9r6ItAJe2eaBk=;
        b=G4iVzTteOX+U5283WUdE5MNawcAL3noWz/a32faH83XxWeTOH7JEMpW8GY67keTgTM
         /V8bKMRjZbJ0h//6oASQjnpY0oTd4cM7f5hXyVaXtvNWEAP6hZOqy7wl9d+2mPChF8C6
         99kGTuLWe4PwpghYy5Z/Br2JL2I6BRf9nBkMHPlPVsiGw3iEDxIwmuliwoF7v28pVciV
         Frl0Io+p7edohpcwReL7K78b6n7JTATi7b235WoNtLslRaSRDMoU7eohvoTW5v3uo6bF
         T+bQoq6PeyNw3Rdok7dbQX07TAWU0W3Wgt9GL6nCeYqCe8f/tMjCbEailmtLo6v2LhoB
         f/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733640295; x=1734245095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdGNHQAJUzYyjbohAt/0A6Ng2wZg9B9r6ItAJe2eaBk=;
        b=Wl57TMXmeTSsxCIi2mPBwcVb7CMDDAcip8PGG8reePtyv6txPnTnfuxJSW1P1txLPo
         qq7uAB7krodEb/XpqgpNCEl07r3psEU2LfRFQ3p5Jv+fR9GApc+yu5BhOHwL/K17UDGO
         ryvWHheTVNbK7JwRQDKjulemHM7QqTtORsgyelCjyK/vFsHY0zgJepVWrVC8KpKO71pT
         a6dNTXqhfuVHjEtvvPSoefq7BYcCmXkyw5XFd7ofJLxA0Pw0BWtfgD/+sEchUwBph81Q
         UrLQW7GY0L/qLZhkxeWlYRdGNT177AfRzeHh022VkPHVgV7Co8aYb4OGaw4xg5BKWnjq
         3DRg==
X-Forwarded-Encrypted: i=1; AJvYcCV4zTdwencgtxB9ONiJqkj1ozF575VaKBRDq358YPNlSpxPApeqM5MT9d+d3imCnxoEPFTXB7+yAWX84D0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/M47DHBUubgOFS64jG8HPZzdf7WyU3lOagAHRb8NYnc18Ofn9
	/yZaXSpqc8OYCxQIkOjscRwkfliYcffx3oX6y0yVgYvRt3BM/z6Z7EH/xfWAYHA=
X-Gm-Gg: ASbGnctawezywERYVYppf3vxPMn1lGIRibi9qzZakTfecj5SqC6lTFUxtEJy+5qcpha
	9TwFhD7skMYo5pJ7N9NSAc7yd/5aIWlJLoh9779wKQjPy06LsXnBJpD7FEdxDU6zk6tknXmibJ9
	4hbkiOyK9LcwWaNALiWgeMNKgUAI1nJBoxLd9tHLiZd/J10QknxXd8Rf59uMVNg39oK6roaVSGh
	NLYrnY+mTmHz/zrUAh60tKWEBl+CMukjg6vhEFfsBcY4tjzaL0E0HxFTCX6LbWHU/nbpFvVlRbk
	J2KlZXZD/6aNRPvjrJ4FqN32I19vxw==
X-Google-Smtp-Source: AGHT+IFRKf628IlWh4nLJD6CbktAnRSTG9qf3ocyzqfN6z84pO4+nuRak4uKnZ3RxXg2D8mepLotNg==
X-Received: by 2002:a2e:a98b:0:b0:302:1861:6df4 with SMTP id 38308e7fff4ca-3021861726emr6312831fa.35.1733640295057;
        Sat, 07 Dec 2024 22:44:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020d85076sm9314561fa.23.2024.12.07.22.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 22:44:53 -0800 (PST)
Date: Sun, 8 Dec 2024 08:44:52 +0200
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
Subject: Re: [PATCH 33/45] drm/msm/dp: add irq hpd callback for dp mst
Message-ID: <dp45ml6ozghkvz2rgzj2v5xupy2zncz5gksnj5umfaldvfmgu3@lqh672yqlgl3>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-33-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-33-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:32:04PM -0800, Abhinav Kumar wrote:
> Add irq hpd callback for the dp mst module which shall be
> invoked from the dp_display's irq hpd handler to perform
> mst specific operations in case of irq hpd. In MST case, route

Nit: MST, IRQ, HPD

> the IRQ HPD messages to MST module.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 17 +++++++++++++----
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 36 +++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h |  2 ++
>  3 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 60316633cc6bcfdfad8ab356d803642d353add61..97f8228042773f51f23a9d39fc009de0798059d7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -583,7 +583,9 @@ static int msm_dp_display_usbpd_attention_cb(struct device *dev)
>  {
>  	int rc = 0;
>  	u32 sink_request;
> +

Drop.

>  	struct msm_dp_display_private *dp = dev_get_dp_display_private(dev);
> +	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	/* check for any test request issued by sink */
>  	rc = msm_dp_link_process_request(dp->link);
> @@ -591,12 +593,18 @@ static int msm_dp_display_usbpd_attention_cb(struct device *dev)
>  		sink_request = dp->link->sink_request;
>  		drm_dbg_dp(dp->drm_dev, "hpd_state=%d sink_request=%d\n",
>  					dp->hpd_state, sink_request);
> -		if (sink_request & DS_PORT_STATUS_CHANGED)
> -			rc = msm_dp_display_handle_port_status_changed(dp);
> -		else
> +		if (sink_request & DS_PORT_STATUS_CHANGED) {
> +			if (!msm_dp_display->mst_active)
> +				rc = msm_dp_display_handle_port_status_changed(dp);

Why?

> +		} else {
>  			rc = msm_dp_display_handle_irq_hpd(dp);
> +		}
>  	}
>  
> +	/* let MST specific IRQ events be handled by its callback */
> +	if (msm_dp_display->mst_active)
> +		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> +
>  	return rc;
>  }
>  
> @@ -736,7 +744,8 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp, u32 data)
>  	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>  			dp->msm_dp_display.connector_type, state);
>  
> -	if (state == ST_MAINLINK_READY || state == ST_DISCONNECT_PENDING) {
> +	if ((state == ST_MAINLINK_READY || state == ST_DISCONNECT_PENDING) &&
> +	    !dp->msm_dp_display.mst_active) {

Why?

>  		/* wait until ST_CONNECTED */
>  		msm_dp_add_event(dp, EV_IRQ_HPD_INT, 0, 1); /* delay = 1 */
>  		mutex_unlock(&dp->event_mutex);
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index 2934fe6a93ff8b927b035c01b6007f3f4ec91a3f..2d92084586b466d4953429e8a6fbf766d081cb9f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -559,6 +559,40 @@ static struct msm_dp_mst_bridge_state *msm_dp_mst_br_priv_state(struct drm_atomi
>  										&bridge->obj));
>  }
>  
> +/* DP MST HPD IRQ callback */
> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
> +{
> +	int rc;
> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> +	u8 ack[8] = {};

4 should be enough

> +	u8 esi[14];
> +	unsigned int esi_res = DP_SINK_COUNT_ESI + 1;

inline

> +	bool handled;
> +
> +	rc = drm_dp_dpcd_read(mst->dp_aux, DP_SINK_COUNT_ESI,
> +			      esi, 14);

Why do we need 14 bytes? Other drivers read smaller chunks.
drm_dp_mst_hpd_irq_handle_event() explicitly documents just 4 bytes
there. Please consider extracting generic helper funciton that just
handles ESI read, drm_dp_mst_hpd_irq_handle_event() and writing of ACK.

> +	if (rc != 14) {
> +		DRM_ERROR("dpcd sink status read failed, rlen=%d\n", rc);
> +		return;
> +	}
> +
> +	drm_dbg_dp(dp_display->drm_dev, "mst irq: esi1[0x%x] esi2[0x%x] esi3[%x]\n",
> +		   esi[1], esi[2], esi[3]);
> +
> +	rc = drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handled);
> +
> +	/* ack the request */
> +	if (handled) {
> +		rc = drm_dp_dpcd_writeb(mst->dp_aux, esi_res, ack[1]);
> +
> +		if (rc != 1)
> +			DRM_ERROR("dpcd esi_res failed. rc=%d\n", rc);
> +
> +		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
> +	}
> +	drm_dbg_dp(dp_display->drm_dev, "mst display hpd_irq handled:%d rc:%d\n", handled, rc);
> +}
> +
>  /* DP MST Connector OPs */
>  static int
>  msm_dp_mst_connector_detect(struct drm_connector *connector,
> @@ -570,7 +604,7 @@ msm_dp_mst_connector_detect(struct drm_connector *connector,
>  	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
>  	enum drm_connector_status status = connector_status_disconnected;
>  
> -	if (dp_display->link_ready)
> +	if (dp_display->link_ready && dp_display->mst_active)

Why is it a part of this patch?

>  		status = drm_dp_mst_detect_port(connector,
>  						ctx, &mst->mst_mgr, mst_conn->mst_port);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> index 9a8535b97193d911592b44fdfcf43ca2f252cea0..5fe5dc7596086467e9a3b3d7d04a665853fbb3d7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> @@ -103,4 +103,6 @@ int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
>  int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams,
>  		    u32 max_dpcd_transaction_bytes, struct drm_dp_aux *drm_aux);
>  
> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
> +
>  #endif /* _DP_MST_DRM_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

