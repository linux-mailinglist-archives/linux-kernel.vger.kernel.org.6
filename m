Return-Path: <linux-kernel+bounces-195309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDF18D4AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33D51F2224F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855115B542;
	Thu, 30 May 2024 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lLlxvgAB"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DE14AD3B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068910; cv=none; b=WydBS8l6RfnkJLScpn2sx3FXxM5baDZXCi74VWPrzWfyxT2ysEU9BE3qNpkMQTaJqTeZ4GVBwfEHgzGvvV8FSxSmr6U0eAzvq//TFIb5k6P0/eJ0A83jC8xV5lhu/Q4EuoMn+vQKMlhCXSxLnU922UVQQA2paP96CDQiXxYNuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068910; c=relaxed/simple;
	bh=BoQASBPUqaQo+E82MXqt+QyRpl9UFAs3ffdChOkkvhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKXpq1q1UdQzJu9IeOcCzJOWAUyvv2aGQoNau104+oVNaSyXDQmVEnb/rO5lofpXLWp2XmWysfB3ehjBgqyEs9+klTvD1v9xzBdnNSdNPi/K4Aty9gJ3vSHKmMkYJ9YX7LM0OfZBbgr2pqbDUELke2INf7WksKpp9C3LQxHTO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lLlxvgAB; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295e488248so785427e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 04:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717068906; x=1717673706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxpMuKi+LXyXGnJgFY2tdfzN1kQoY6oVI5V7Y+J38bw=;
        b=lLlxvgABcyzWQH1z+szaL7TMvs7nsN/R8J/XbIlASwDJiWGvg7VBTHtmDSheqibIv8
         3HDm1N2fiOvzNhQKaM0+XxRLCGga48NMyOGaYIympGuJOIuVJWnucQtNcScGk6ALkLLx
         AykafTISeHdG97LZwitojPDiojnHWGnmiNu8wYTaskVK4GridXnxPBBKtc47fre0zu1d
         n5Vfh+3pYORJv3bpudocP18GX0eNqUwx4fDU+tQ+CnQ3cTj3kcb3YC+MeCsRAcnSZjM2
         fZY/FraGjWurAdcUKRouBkt3cAW+R0kTn26ypOfGh/aSiu1U4dmxi7QUZ+8rhqyX32KR
         VfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717068907; x=1717673707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxpMuKi+LXyXGnJgFY2tdfzN1kQoY6oVI5V7Y+J38bw=;
        b=J6yTuy3yG76juokm3u1Jn1JLnyqOJx/yRhxzpHE7kSe8dtzuIqafGuvx0OSBSTO++t
         kuUu3XF7h00oeE6ImtpG3x6FTFFP4bgb5ZaXTotJYbDSdXzNiqzYhE+i7HMh1aJo1opy
         xdH9rFsPmKgX1BLOFcD5vyXsC15vGaCSzNsXl9lWcXhGMv3d8xRzVomasNhrMbse19Gp
         K8KLuUTWgaII4H9SyCG5kU8BbyckrBq7Y6z3vwd7yK1/PMLXl9zTuV6ydqMRfSFzTckw
         JIV1/I8GHhDjoMR7xYl6TOOO/fkF6/1hNc7Xiy3eHMobRVJOWIVhPbxr3xRT45QdTMcM
         zGyw==
X-Forwarded-Encrypted: i=1; AJvYcCWvRIAUExhRES+WV3ERcvgnlniAAj42kX2RiXuslbmV+9uyu8SE05ZlKo/VJQuSxnvKju9+7hk/7gGtDZPM+PfnIsofBAp5herh6/yh
X-Gm-Message-State: AOJu0Ywa6/4U82QMQ3Z14dtx1/ZVELPIlMsBQ5eQxWN+gml7+YCW/9ag
	OdJePeCxSuHXh5nVLy6JTAkBupHus3HhY/kRve5+GanFLsdMtwJcAbDHu2ODl+4=
X-Google-Smtp-Source: AGHT+IEa+chLqLIDVqsM++sBJf0eXp91/FeFjOPnSviE3q1lQzzwC22rOXWI7iSC6GcMFIT55xs9Rg==
X-Received: by 2002:a19:521a:0:b0:51d:9e17:29ea with SMTP id 2adb3069b0e04-52b7d422099mr1055198e87.15.1717068906185;
        Thu, 30 May 2024 04:35:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b7043b402sm344963e87.211.2024.05.30.04.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:35:05 -0700 (PDT)
Date: Thu, 30 May 2024 14:35:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] drm/msm/hdmi: make use of the drm_connector_hdmi
 framework
Message-ID: <u63p7wuvtrcdnbzikbgucedhsgjtyrx7zknkytcy5cu3hbbsxx@jm46d2od2jmi>
References: <20240530-bridge-hdmi-connector-v3-0-a1d184d68fe3@linaro.org>
 <20240530-bridge-hdmi-connector-v3-5-a1d184d68fe3@linaro.org>
 <20240530-poised-burgundy-petrel-7affed@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530-poised-burgundy-petrel-7affed@houat>

On Thu, May 30, 2024 at 11:16:08AM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Thu, May 30, 2024 at 02:12:28AM GMT, Dmitry Baryshkov wrote:
> > Setup the HDMI connector on the MSM HDMI outputs. Make use of
> > atomic_check hook and of the provided Infoframe infrastructure.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> As a general comment: I really like it, it looks super tidy. Thanks!
> 
> There's a couple of minor issues below
> 
> > -int msm_hdmi_audio_update(struct hdmi *hdmi)
> > +static int msm_hdmi_audio_update(struct hdmi *hdmi)
> >  {
> >  	struct hdmi_audio *audio = &hdmi->audio;
> > -	struct hdmi_audio_infoframe *info = &audio->infoframe;
> >  	const struct hdmi_msm_audio_arcs *arcs = NULL;
> >  	bool enabled = audio->enabled;
> >  	uint32_t acr_pkt_ctrl, vbi_pkt_ctrl, aud_pkt_ctrl;
> > -	uint32_t infofrm_ctrl, audio_config;
> > +	uint32_t audio_config;
> > +
> > +	if (!hdmi->hdmi_mode)
> > +		return -EINVAL;
> > +
> > +	DBG("audio: enabled=%d, channels=%d, rate=%d",
> > +	    audio->enabled, audio->channels, audio->rate);
> >  
> > -	DBG("audio: enabled=%d, channels=%d, channel_allocation=0x%x, "
> > -		"level_shift_value=%d, downmix_inhibit=%d, rate=%d",
> > -		audio->enabled, info->channels,  info->channel_allocation,
> > -		info->level_shift_value, info->downmix_inhibit, audio->rate);
> >  	DBG("video: power_on=%d, pixclock=%lu", hdmi->power_on, hdmi->pixclock);
> 
> pixclock should come from the connector state too. It's still calculated
> by the driver in msm_hdmi_bridge_mode_set

Yes, that's why I asked on IRC regarding the char rate and ALSA codec.
I'll see what I can do.

> 
> > @@ -341,8 +425,11 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi)
> >  	bridge->funcs = &msm_hdmi_bridge_funcs;
> >  	bridge->ddc = hdmi->i2c;
> >  	bridge->type = DRM_MODE_CONNECTOR_HDMIA;
> > +	bridge->vendor = "Qualcomm";
> > +	bridge->product = "Snapdragon";
> >  	bridge->ops = DRM_BRIDGE_OP_HPD |
> >  		DRM_BRIDGE_OP_DETECT |
> > +		DRM_BRIDGE_OP_HDMI |
> >  		DRM_BRIDGE_OP_EDID;
> >  
> >  	ret = devm_drm_bridge_add(hdmi->dev->dev, bridge);
> 
> It looks like you're not setting either the supported formats or bpc?

I've added what looks to be sane defaults to the drm_bridge_connector:
RGB only and bpc = 8. If at some point we get to YUV or HDR support,
that would need to be reflected here.




-- 
With best wishes
Dmitry

