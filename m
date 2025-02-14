Return-Path: <linux-kernel+bounces-514135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE4A352F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D489C16C0AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE253BE;
	Fri, 14 Feb 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="igv1w0fk"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8B17E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493184; cv=none; b=WzAnudfMYAc7ekC1pLFsdZaMTgUhxk/w2yVNaraJ3/5zFWteRCaNvJFJwdymdZ1kZAkANyal2SmLJA6PkywC87G3mbhKNu6dIps8fu6zGHTwooGRZb0yRUAucrgtqRWGZ2csPQkwgv+SQAPtKLsN2tRF3hVp8xGH+JfuLAvskTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493184; c=relaxed/simple;
	bh=DVxQJMerGPojuX1iozB+3dffp+oKXrUgC1yl9gt4z1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J55aYGWwz17ok1anZ9DEy0ZgLlhTjsbcbTZGbAgRayo/VPJ0mlAQx58dNnC0NQJwMC/QJwwukrbow4bmYjLf6bgBidOujVbdPIidLyLUw0/qVpAIb9/HH87o98c1OkqfxCbk8HsJAWYL/g+nZWmCIz8UCg4FYUCix7/pJp7Gs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=igv1w0fk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5450b91da41so1262219e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739493180; x=1740097980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCJQvmJXiPFh2goOM9jkGtpXIXlz22/vifOcphOgUtE=;
        b=igv1w0fkKsJuHnLDKx5cU6KsZcx7WSv7pQsf0pFozzMpP1g8DfaZgY5EE4InFAVf21
         vMi/7e6MxIZHSK6ITSZPXyZuK593uiOca7ACRZCpfnzwWz7jvojWeYttJe9yAHSt1GVl
         mSky+TwbsSdLdEaGq70jtZFRso2ObbhduL/m6hAZtlyoLDqHnBunL36pd2PaT2M7RQ2O
         Tfwmf0xNcaqYoojRFtzVVSDLPD2P+U05mC/RVd6frLzw5B7betj5ES//XG636FO4h0AY
         GKbcnfrQchVoOV/Ui6BPZ9oPJ5hhr6MSgaBFzIVGqAt3IdC4uDv1jfqnPzUlneUfCUKN
         yBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739493180; x=1740097980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCJQvmJXiPFh2goOM9jkGtpXIXlz22/vifOcphOgUtE=;
        b=pWbNO1hK4feQ6kQmcxjtSre0CbdVPsn63Svkgfy4K9ft9szm4zyDTuqAA7mX/dfnWd
         a/KgGZ2QbiPViZoAnOAXuU8yBrYkJAKjIboEBoOTlZkbFK2qntluWs6qMVee5kiF+BOW
         efnd1jZXrsl74aAo14W13eu1JReO97LC7jC1YBHDc/qIfOII+Gc8Ml57WiMKtWIjSiCS
         Pb+ouGI4SuDyPdSHxYx/laslkinzKz876BKIUUWUBR+B0x7mtQZLimRofgWd4VANgrhq
         7PGfwNCmEJ3+sdv9GzyC33b3kIOcCayEzod5ChhpS1hNbWi7izalix/nXLTLjv2d4M1s
         8VTw==
X-Forwarded-Encrypted: i=1; AJvYcCUeMzHNOJp0eFLagngGAuPv5ncrXtnV6NtFZIEcrhgZnTIglNSyUvLn3wSP/4qvj4LiFxmXUO2rbHGqvgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6FGSSIPPI2wDnPU4N3bagmRR3WXW6dU+uNmeg6ATMnYwerlc
	jhwggxMSo1D1Y0LFCCt9ljSO5OkPAu1VvDt5Ny0lb6dmpRQzvt5gj8YdECuWgss=
X-Gm-Gg: ASbGncvxlhTUljYzk6+gIjRAjI3kZuvhIS1OaN/rg79SQ9DAkaz3wm448jAHp3wPSO8
	VPSmyLZ5RHKIh55GbQuty/xONvGDeLFBpTqAfsczI913h6uKwQCotdX4elGpWjCgCMdSeU95GUu
	oDzETiZb/CnAj9zf4VQBc8DtQGF8jR2pyCN1Dvko1M3Pgp+Cg0KGDcf8+LRXG3NhILgZmXXSzIc
	L8OiN1dcMYfXn4VUQZw1BHwIRYMVVdjVg+jt5/VJt2AttWlI0qDRC4ZlqRXTEAaAbfxxbd/l8Tg
	QjG7q95lMEctpWLE+Jjc93WXRWu/diUUMLzmVJSqvw2UOIeThG83SMkILKt8PvSYdDCJtSI=
X-Google-Smtp-Source: AGHT+IEfydBKcHof3VEaXy+2/v6L3kM2LOQCgM22hAujPdM+MNRwYuWCbjJn5LEHHlguyNWJRt4mCw==
X-Received: by 2002:ac2:5e77:0:b0:545:9e:bed4 with SMTP id 2adb3069b0e04-54518166d55mr2546299e87.52.1739493180145;
        Thu, 13 Feb 2025 16:33:00 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-545284e2817sm26859e87.116.2025.02.13.16.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 16:32:58 -0800 (PST)
Date: Fri, 14 Feb 2025 02:32:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Hermes Wu <Hermes.wu@ite.com.tw>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] drm/display: bridge-connector: add DisplayPort
 bridges
Message-ID: <teokrp5lycipuchh6e64tvqabxzzf4ez7epuyrae5ahd7dqnjs@x7vyrjgzth2i>
References: <20250209-dp-hdmi-audio-v2-0-16db6ebf22ff@linaro.org>
 <20250209-dp-hdmi-audio-v2-1-16db6ebf22ff@linaro.org>
 <20250213235745.GA7688@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213235745.GA7688@pendragon.ideasonboard.com>

On Fri, Feb 14, 2025 at 01:57:45AM +0200, Laurent Pinchart wrote:
> Hi Dmitry,
> 
> Thank you for the patch.
> 
> On Sun, Feb 09, 2025 at 03:41:18PM +0200, Dmitry Baryshkov wrote:
> > DRM HDMI Codec framework is useful not only for the HDMI bridges, but
> > also for the DisplayPort bridges. Add new DRM_BRIDGE_OP_DisplayPort
> > define in order to distinguish DP bridges. Create HDMI codec device
> > automatically for DP bridges which have declared audio support.
> > 
> > Note, unlike HDMI devices, which already have a framework to handle HPD
> > notifications in a standard way, DP drivers don't (yet?) have such a
> > framework. As such it is necessary to manually call
> > drm_connector_hdmi_audio_plugged_notify(). This requirement hopefully
> > can be lifted later on, if/when DRM framework gets better DisplayPort
> > ports support in the core layer.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/drm_bridge_connector.c | 66 ++++++++++++++++++++------
> >  include/drm/drm_bridge.h                       | 14 +++++-
> >  2 files changed, 65 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> > index 30c736fc0067e31a97db242e5b16ea8a5b4cf359..5e031395b801f9a1371dcb4ac09f3da23e4615dd 100644
> > --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> > +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> > @@ -98,6 +98,13 @@ struct drm_bridge_connector {
> >  	 * HDMI connector infrastructure, if any (see &DRM_BRIDGE_OP_HDMI).
> >  	 */
> >  	struct drm_bridge *bridge_hdmi;
> > +	/**
> > +	 * @bridge_dp:
> > +	 *
> > +	 * The bridge in the chain that implements necessary support for the
> > +	 * DisplayPort connector infrastructure, if any (see &DRM_BRIDGE_OP_DisplayPort).
> > +	 */
> > +	struct drm_bridge *bridge_dp;
> >  };
> >  
> >  #define to_drm_bridge_connector(x) \
> > @@ -496,6 +503,25 @@ static const struct drm_connector_hdmi_audio_funcs drm_bridge_connector_hdmi_aud
> >  	.mute_stream = drm_bridge_connector_audio_mute_stream,
> >  };
> >  
> > +static int drm_bridge_connector_hdmi_audio_init(struct drm_connector *connector,
> > +						struct drm_bridge *bridge)
> > +{
> > +	if (!bridge->hdmi_audio_max_i2s_playback_channels &&
> > +	    !bridge->hdmi_audio_spdif_playback)
> > +		return 0;
> > +
> > +	if (!bridge->funcs->hdmi_audio_prepare ||
> > +	    !bridge->funcs->hdmi_audio_shutdown)
> > +		return -EINVAL;
> > +
> > +	return drm_connector_hdmi_audio_init(connector,
> > +					     bridge->hdmi_audio_dev,
> > +					     &drm_bridge_connector_hdmi_audio_funcs,
> > +					     bridge->hdmi_audio_max_i2s_playback_channels,
> > +					     bridge->hdmi_audio_spdif_playback,
> > +					     bridge->hdmi_audio_dai_port);
> > +}
> > +
> >  /* -----------------------------------------------------------------------------
> >   * Bridge Connector Initialisation
> >   */
> > @@ -564,6 +590,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >  		if (bridge->ops & DRM_BRIDGE_OP_HDMI) {
> >  			if (bridge_connector->bridge_hdmi)
> >  				return ERR_PTR(-EBUSY);
> > +			if (bridge_connector->bridge_dp)
> > +				return ERR_PTR(-EINVAL);
> >  			if (!bridge->funcs->hdmi_write_infoframe ||
> >  			    !bridge->funcs->hdmi_clear_infoframe)
> >  				return ERR_PTR(-EINVAL);
> > @@ -576,6 +604,16 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >  				max_bpc = bridge->max_bpc;
> >  		}
> >  
> > +		if (bridge->ops & DRM_BRIDGE_OP_DisplayPort) {
> > +			if (bridge_connector->bridge_dp)
> > +				return ERR_PTR(-EBUSY);
> > +			if (bridge_connector->bridge_hdmi)
> > +				return ERR_PTR(-EINVAL);
> > +
> > +			bridge_connector->bridge_dp = bridge;
> > +
> > +		}
> > +
> >  		if (!drm_bridge_get_next_bridge(bridge))
> >  			connector_type = bridge->type;
> >  
> > @@ -612,21 +650,21 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >  		if (ret)
> >  			return ERR_PTR(ret);
> >  
> > -		if (bridge->hdmi_audio_max_i2s_playback_channels ||
> > -		    bridge->hdmi_audio_spdif_playback) {
> > -			if (!bridge->funcs->hdmi_audio_prepare ||
> > -			    !bridge->funcs->hdmi_audio_shutdown)
> > -				return ERR_PTR(-EINVAL);
> > +		ret = drm_bridge_connector_hdmi_audio_init(connector, bridge);
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +	} else if (bridge_connector->bridge_dp) {
> > +		bridge = bridge_connector->bridge_dp;
> >  
> > -			ret = drm_connector_hdmi_audio_init(connector,
> > -							    bridge->hdmi_audio_dev,
> > -							    &drm_bridge_connector_hdmi_audio_funcs,
> > -							    bridge->hdmi_audio_max_i2s_playback_channels,
> > -							    bridge->hdmi_audio_spdif_playback,
> > -							    bridge->hdmi_audio_dai_port);
> > -			if (ret)
> > -				return ERR_PTR(ret);
> > -		}
> > +		ret = drmm_connector_init(drm, connector,
> > +					  &drm_bridge_connector_funcs,
> > +					  connector_type, ddc);
> > +		if (ret)
> > +			return ERR_PTR(ret);
> > +
> > +		ret = drm_bridge_connector_hdmi_audio_init(connector, bridge);
> > +		if (ret)
> > +			return ERR_PTR(ret);
> >  	} else {
> >  		ret = drmm_connector_init(drm, connector,
> >  					  &drm_bridge_connector_funcs,
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index 496dbbd2ad7edff7f091adfbe62de1e33ef0cf07..40f37444426b1b8ded25da9ba9e2963f18ad6267 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -811,9 +811,21 @@ enum drm_bridge_ops {
> >  	 *
> >  	 * Note: currently there can be at most one bridge in a chain that sets
> >  	 * this bit. This is to simplify corresponding glue code in connector
> > -	 * drivers.
> > +	 * drivers. Having both HDMI and DisplayPort bridges in the same bridge
> > +	 * chain is also not allowed.
> >  	 */
> >  	DRM_BRIDGE_OP_HDMI = BIT(4),
> > +	/**
> > +	 * @DRM_BRIDGE_OP_DisplayPort: The bridge provides DisplayPort connector
> > +	 * operations. Currently this is limited to the optional HDMI codec
> > +	 * support.
> > +	 *
> > +	 * Note: currently there can be at most one bridge in a chain that sets
> > +	 * this bit. This is to simplify corresponding glue code in connector
> > +	 * drivers. Having both HDMI and DisplayPort bridges in the same bridge
> > +	 * chain is also not allowed.
> > +	 */
> > +	DRM_BRIDGE_OP_DisplayPort = BIT(5),
> 
> The OP bits are not supposed to describe tbe type of bridge, but the
> operations it implements. I see quite a bit of duplication between HDMI
> and DisplayPort in this patch. Can we have a single bit named after the
> feature that you want to support ? The bridge_hdmi and bridge_dp fields
> should also be merged into a single one.

In this case these ops actually describe the set of ops implemented by
the bridge. DRM_BRIDGE_OP_HDMI implements hdmi_tmds_char_rate_valid(),
hdmi_write_infoframe(), hdmi_clear_infoframe() and hdmi_audio_*()
callbacks. It is impossible to just use HDMI helpers for any
DRM_MODE_CONNECTOR_HDMIA bridge as they lack required callbacks.
At the same time it is perfectly legic to have a
DRM_MODE_CONNECTOR_HDMIA bridge which doesn't set DRM_BRIDGE_OP_HDMI:
this bridge chain will not use HDMI Connector / HDMI State helpers, but
it should be fine otherwise.

DRM_BRIDGE_OP_DisplayPort bridges currently implement hdmi_audio_*(),
but I have long-term plans for that set of ops.

It is not quite possible to merge bridge_hdmi and bridge_dp fields:
for bridges, which implement DRM_BRIDGE_OP_HDMI, drm_bridge_connector
call various drm_atomic_helper_connector_hdmi_*() functions. For
DisplayPort there is no corresponding functionality (yet).

-- 
With best wishes
Dmitry

