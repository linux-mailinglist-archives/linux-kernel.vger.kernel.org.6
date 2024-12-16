Return-Path: <linux-kernel+bounces-447847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A19F37CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2BC188EDF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8335B2066FF;
	Mon, 16 Dec 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIVjEACD"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8C2066DC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371260; cv=none; b=NeK2hnoIAcFCfPkm1cmNTpJtLUQMS6Q/J02xHVjjehTnYEQbXWjZ0D1cdTJwW02yaOcNNADxxQmbsuV8aXb9jyRmC1w74EGxolMg9Y9qrskCZXnfEyqzmDVbO2i0vLpPDsCYMb6csi6sKeychfOJrEte48sGoqXz0e/aOQ1axLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371260; c=relaxed/simple;
	bh=wrQ8wIHVZQtaics68xjL1ValwpddiW4LWarc3YMsN3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOxPpOw6pBiqIE+NJ9cFRemuQt7j/UPbyrNR/x/Fh0ACGUC0mq3z4GzalQujo7YczIAx4nwX20/2v/V0+/gvhHBXEd2jHC5Ns3kKp9rabQC2BRJReZCGBYb5Ck5c6tgOGBWH3BCOrEtjPpDPuwxhUq0birB/yLlpDW22X3qOV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uIVjEACD; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3022c61557cso46084111fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734371256; x=1734976056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oJRLQvoiM2uK9G/IvN+jPx+hGzx5GhhUNmirbsQlJV8=;
        b=uIVjEACD3XnhJE4WoAw/Gvr+eFsokxN63ZGW6U604nNWscrc4GNGyafA/RiSjVktVL
         52TlgjIwn8PUeGZvzvnmdW/NEK8cn9RS18twkiC+Xkf2fN+WHZ0CGQ6k0jIfGzFMsl8k
         KQ9O+5BQucfC1i7OlKtN+ptHPOot3JtIng9qLTunYQj6ssxWYaic+0QjlPLGas6wJuek
         UWG/SrwmXLx+Vzhdhcw6ryaAag82dosdukOWOeyeLkg1Uti2wt2RG6DZ21Fiz5Qn6BRB
         J6twOgIBlLUPRgSdudXZbJqgr4E5GxwRwmxwHXLP/2oZPk/XUwbvOoA0fykBMQ8mD2z9
         1mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371257; x=1734976057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJRLQvoiM2uK9G/IvN+jPx+hGzx5GhhUNmirbsQlJV8=;
        b=LVRlFsGic8gZzzgMs3/vrAX6n9nY46Bp8i/7VRfSELzWHfuh0KLnhgKJ/UC1QPtJTK
         wh5Flp1e8dfJKabdgb7ST7XIPqo6AzIZB0JJ5EzlFW21agsvLoLNAUggWgSFgmRY4NRn
         oO4KjZKOiXK59bOC6mSMiRH282cnIwkMfb9t8F5TBUPMbbZf9wGQ2O5drCnjYJsWKTVy
         2trqoKWO5p7t2uGRaAUpDiHJOokMb8EXX5Ckd2r1s0dlPLRjw748XGzMIk8hdJeeCRAu
         gLWzfEU/dHxSzssaLiY015U0mEy9yXOJGsilC59e97GUIzpWuI3lfrDs4q1GGBx2a3ED
         VaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVIHbBDZjWhCnNLW51DO4Ec5RfaNlgQihdgPighky9w6CMUBHxs8mNBoV6CbOWH9NQqwbLKe4NmpQltm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWA7XatRtqvMoh3XztVvwB/BC3VOwna/dGeSgWFdbFZwW+LUf9
	7V7c19Z8Bufh1apC3QIvTm2mcM1f2BidNhYEuwxK2X9dTNfe5NXPnOp/iSZ0xXA=
X-Gm-Gg: ASbGncv/W5ITALGYiwlIciVphWf4qhDA2Q6Qg5Zb/mRDX7ocmbVRsUUspGzTuU3iZQ4
	e7JQta+umXnmhDFsEhMsjbDF0RCG1aDujbglE4OGnWptxarzn0FZcZzpTOy6JyTGFLKT6/sUEvs
	iL0E6Wz4sY22DP1i9dzT9xM3dZNWUBFwzeVa812KuKZSCGDYHXYChzgKpIi++J1YYijNGqKTLTQ
	e0vZBvMbwNdairsH1ZnwvWVS9EU9ZCB+0/VgfPZ0ZrGI5+xhrNau0gSd89xxJaM05YcPw7MR9zX
	uy3WSmfOuioxkRSOqTHNeOMRL923q/vMy5Nx
X-Google-Smtp-Source: AGHT+IE7Nu2UZ05CbJ5TijHkK7V7tWXZvLvPyH+Y6uLbXlSNImUM95D3nGxGooUa/clMhfRqrHaYLA==
X-Received: by 2002:a05:651c:501:b0:302:34da:ac30 with SMTP id 38308e7fff4ca-302544617f2mr44913431fa.18.1734371256503;
        Mon, 16 Dec 2024 09:47:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344062bd3sm9649911fa.66.2024.12.16.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:47:35 -0800 (PST)
Date: Mon, 16 Dec 2024 19:47:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Phong LE <ple@baylibre.com>, 
	Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Russell King <linux@armlinux.org.uk>, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 03/10] drm/connector: implement generic HDMI codec
 helpers
Message-ID: <exocd3b65cy6cy5w47cwx3ykn54ncf34hwyj7ffihs5jjzean5@y677uywnlah2>
References: <20241206-drm-bridge-hdmi-connector-v6-0-50dc145a9c06@linaro.org>
 <20241206-drm-bridge-hdmi-connector-v6-3-50dc145a9c06@linaro.org>
 <20241216-heretic-mackerel-of-wholeness-fcfed7@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-heretic-mackerel-of-wholeness-fcfed7@houat>

On Mon, Dec 16, 2024 at 06:04:41PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Dec 06, 2024 at 12:15:57PM +0200, Dmitry Baryshkov wrote:
> > Several DRM drivers implement HDMI codec support (despite its name it
> > applies to both HDMI and DisplayPort drivers). Implement generic
> > framework to be used by these drivers. This removes a requirement to
> > implement get_eld() callback and provides default implementation for
> > codec's plug handling.
> > 
> > The framework is integrated with the DRM HDMI Connector framework, but
> > can be used by DisplayPort drivers.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/Makefile                   |   1 +
> >  drivers/gpu/drm/drm_connector.c            |   5 +
> >  drivers/gpu/drm/drm_connector_hdmi_codec.c | 185 +++++++++++++++++++++++++++++
> >  include/drm/drm_connector.h                |  80 +++++++++++++
> >  4 files changed, 271 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 1677c1f335fbb0c6114bdb4cc0b12eb407d84564..afdd9268ca23ac7602e73bbe45f3f9cd090a3afd 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -42,6 +42,7 @@ drm-y := \
> >  	drm_cache.o \
> >  	drm_color_mgmt.o \
> >  	drm_connector.o \
> > +	drm_connector_hdmi_codec.o \
> >  	drm_crtc.o \
> >  	drm_displayid.o \
> >  	drm_drv.o \
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index bbdaaf7022b62d84594a29f1b60144920903a99a..4abfbded962bf45b793a2bd5b1b5c4d9f478a1f7 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -33,6 +33,7 @@
> >  #include <drm/drm_sysfs.h>
> >  #include <drm/drm_utils.h>
> >  
> > +#include <linux/platform_device.h>
> >  #include <linux/property.h>
> >  #include <linux/uaccess.h>
> >  
> > @@ -280,6 +281,7 @@ static int __drm_connector_init(struct drm_device *dev,
> >  	mutex_init(&connector->eld_mutex);
> >  	mutex_init(&connector->edid_override_mutex);
> >  	mutex_init(&connector->hdmi.infoframes.lock);
> > +	mutex_init(&connector->hdmi_codec.lock);
> >  	connector->edid_blob_ptr = NULL;
> >  	connector->epoch_counter = 0;
> >  	connector->tile_blob_ptr = NULL;
> > @@ -632,6 +634,8 @@ void drm_connector_cleanup(struct drm_connector *connector)
> >  		    DRM_CONNECTOR_REGISTERED))
> >  		drm_connector_unregister(connector);
> >  
> > +	platform_device_unregister(connector->hdmi_codec.codec_pdev);
> > +
> >  	if (connector->privacy_screen) {
> >  		drm_privacy_screen_put(connector->privacy_screen);
> >  		connector->privacy_screen = NULL;
> > @@ -670,6 +674,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
> >  		connector->funcs->atomic_destroy_state(connector,
> >  						       connector->state);
> >  
> > +	mutex_destroy(&connector->hdmi_codec.lock);
> >  	mutex_destroy(&connector->hdmi.infoframes.lock);
> >  	mutex_destroy(&connector->mutex);
> >  
> > diff --git a/drivers/gpu/drm/drm_connector_hdmi_codec.c b/drivers/gpu/drm/drm_connector_hdmi_codec.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..1934fb53b4d128434559970c9fea548bbc4bedda
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_connector_hdmi_codec.c
> > @@ -0,0 +1,185 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright (c) 2024 Linaro Ltd
> > + */
> > +
> > +#include <linux/mutex.h>
> > +#include <linux/of_graph.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_device.h>
> > +
> > +#include <sound/hdmi-codec.h>
> > +
> > +static int drm_connector_hdmi_codec_audio_startup(struct device *dev, void *data)
> > +{
> > +	struct drm_connector *connector = data;
> > +	const struct drm_connector_hdmi_codec_funcs *funcs =
> > +		connector->hdmi.funcs->codec_funcs;
> > +
> > +	if (funcs->audio_startup)
> > +		return funcs->audio_startup(connector);
> > +
> > +	return 0;
> > +}
> > +
> > +static int drm_connector_hdmi_codec_prepare(struct device *dev, void *data,
> > +					    struct hdmi_codec_daifmt *fmt,
> > +					    struct hdmi_codec_params *hparms)
> > +{
> > +	struct drm_connector *connector = data;
> > +	const struct drm_connector_hdmi_codec_funcs *funcs =
> > +		connector->hdmi.funcs->codec_funcs;
> > +
> > +	return funcs->prepare(connector, fmt, hparms);
> > +}
> > +
> > +static void drm_connector_hdmi_codec_audio_shutdown(struct device *dev, void *data)
> > +{
> > +	struct drm_connector *connector = data;
> > +	const struct drm_connector_hdmi_codec_funcs *funcs =
> > +		connector->hdmi.funcs->codec_funcs;
> > +
> > +	return funcs->audio_shutdown(connector);
> > +}
> > +
> > +static int drm_connector_hdmi_codec_mute_stream(struct device *dev, void *data,
> > +						bool enable, int direction)
> > +{
> > +	struct drm_connector *connector = data;
> > +	const struct drm_connector_hdmi_codec_funcs *funcs =
> > +		connector->hdmi.funcs->codec_funcs;
> > +
> > +	if (funcs->mute_stream)
> > +		return funcs->mute_stream(connector, enable, direction);
> > +
> > +	return -ENOTSUPP;
> > +}
> > +
> > +static int drm_connector_hdmi_codec_get_dai_id(struct snd_soc_component *comment,
> > +		  struct device_node *endpoint,
> > +		  void *data)
> > +{
> > +	struct drm_connector *connector = data;
> > +	struct of_endpoint of_ep;
> > +	int ret;
> > +
> > +	if (connector->hdmi_codec.dai_port < 0)
> > +		return -ENOTSUPP;
> > +
> > +	ret = of_graph_parse_endpoint(endpoint, &of_ep);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (of_ep.port == connector->hdmi_codec.dai_port)
> > +		return 0;
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int drm_connector_hdmi_codec_get_eld(struct device *dev, void *data,
> > +					    uint8_t *buf, size_t len)
> > +{
> > +	struct drm_connector *connector = data;
> > +
> > +	mutex_lock(&connector->eld_mutex);
> > +	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
> > +	mutex_unlock(&connector->eld_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +static int drm_connector_hdmi_codec_hook_plugged_cb(struct device *dev,
> > +						    void *data,
> > +						    hdmi_codec_plugged_cb fn,
> > +						    struct device *codec_dev)
> > +{
> > +	struct drm_connector *connector = data;
> > +
> > +	mutex_lock(&connector->hdmi_codec.lock);
> > +
> > +	connector->hdmi_codec.plugged_cb = fn;
> > +	connector->hdmi_codec.plugged_cb_dev = codec_dev;
> > +
> > +	fn(codec_dev, connector->hdmi_codec.last_state);
> > +
> > +	mutex_unlock(&connector->hdmi_codec.lock);
> > +
> > +	return 0;
> > +}
> > +
> > +void drm_connector_hdmi_codec_plugged_notify(struct drm_connector *connector,
> > +					     bool plugged)
> > +{
> > +	mutex_lock(&connector->hdmi_codec.lock);
> > +
> > +	connector->hdmi_codec.last_state = plugged;
> > +
> > +	if (connector->hdmi_codec.plugged_cb &&
> > +	    connector->hdmi_codec.plugged_cb_dev)
> > +		connector->hdmi_codec.plugged_cb(connector->hdmi_codec.plugged_cb_dev,
> > +						 connector->hdmi_codec.last_state);
> > +
> > +	mutex_unlock(&connector->hdmi_codec.lock);
> > +}
> > +EXPORT_SYMBOL(drm_connector_hdmi_codec_plugged_notify);
> > +
> > +static const struct hdmi_codec_ops drm_connector_hdmi_codec_ops = {
> > +	.audio_startup = drm_connector_hdmi_codec_audio_startup,
> > +	.prepare = drm_connector_hdmi_codec_prepare,
> > +	.audio_shutdown = drm_connector_hdmi_codec_audio_shutdown,
> > +	.mute_stream = drm_connector_hdmi_codec_mute_stream,
> > +	.get_eld = drm_connector_hdmi_codec_get_eld,
> > +	.get_dai_id = drm_connector_hdmi_codec_get_dai_id,
> > +	.hook_plugged_cb = drm_connector_hdmi_codec_hook_plugged_cb,
> > +};
> > +
> > +/**
> > + * drm_connector_hdmi_codec_init - Initialize HDMI Codec device for the DRM connector
> 
> I think it'd be better to call it drm_connector_hdmi_audio_init over
> drm_connector_hdmi_codec_init (feature over implementation).
> 
> > + * @connector: A pointer to the connector to allocate codec for
> > + * @hdmi_codec_dev: device to be used as a parent for the HDMI Codec
> > + * @max_i2s_playback_channels: maximum number of playback I2S channels
> > + * @spdif_playback: set if HDMI codec has S/PDIF playback port
> > + * @dai_port: sound DAI port, -1 if it is not enabled
> > + *
> > + * Create a HDMI codec device to be used with the specified connector.
> > + *
> > + * Returns:
> > + * Zero on success, error code on failure.
> > + */
> > +int drm_connector_hdmi_codec_init(struct drm_connector *connector,
> > +				  struct device *hdmi_codec_dev,
> > +				  unsigned int max_i2s_playback_channels,
> > +				  bool spdif_playback,
> > +				  int dai_port)
> > +{
> > +	struct hdmi_codec_pdata codec_pdata = {
> > +		.ops = &drm_connector_hdmi_codec_ops,
> > +		.max_i2s_channels = max_i2s_playback_channels,
> > +		.i2s = !!max_i2s_playback_channels,
> > +		.spdif = spdif_playback,
> > +		.no_i2s_capture = true,
> > +		.no_spdif_capture = true,
> > +		.data = connector,
> > +	};
> > +	struct platform_device *pdev;
> > +
> > +	connector->hdmi_codec.dai_port = dai_port;
> > +
> > +	if (!connector->hdmi.funcs->codec_funcs->prepare ||
> > +	    !connector->hdmi.funcs->codec_funcs->audio_shutdown)
> > +		return -EINVAL;
> > +
> > +	pdev = platform_device_register_data(hdmi_codec_dev,
> > +					     HDMI_CODEC_DRV_NAME,
> > +					     PLATFORM_DEVID_AUTO,
> > +					     &codec_pdata, sizeof(codec_pdata));
> > +	if (IS_ERR(pdev))
> > +		return PTR_ERR(pdev);
> > +
> > +	connector->hdmi_codec.codec_pdev = pdev;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(drm_connector_hdmi_codec_init);
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index 1e2b25e204cb523d61d30f5409faa059bf2b86eb..1d113c0ceec7ce8196a412d7c00a1737175c6fbe 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -46,6 +46,8 @@ struct drm_property_blob;
> >  struct drm_printer;
> >  struct drm_privacy_screen;
> >  struct edid;
> > +struct hdmi_codec_daifmt;
> > +struct hdmi_codec_params;
> >  struct i2c_adapter;
> >  
> >  enum drm_connector_force {
> > @@ -1141,6 +1143,52 @@ struct drm_connector_state {
> >  	struct drm_connector_hdmi_state hdmi;
> >  };
> >  
> > +struct drm_connector_hdmi_codec_funcs {
> > +	/**
> > +	 * @audio_startup:
> > +	 *
> > +	 * Called when ASoC starts an audio stream setup. The
> > +	 * @hdmi_audio_startup is optional.
> > +	 *
> > +	 * Returns:
> > +	 * 0 on success, a negative error code otherwise
> > +	 */
> > +	int (*audio_startup)(struct drm_connector *connector);
> > +
> > +	/**
> > +	 * @prepare:
> > +	 * Configures HDMI-encoder for audio stream. Can be called
> > +	 * multiple times for each setup. Mandatory.
> > +	 *
> > +	 * Returns:
> > +	 * 0 on success, a negative error code otherwise
> > +	 */
> > +	int (*prepare)(struct drm_connector *connector,
> > +		       struct hdmi_codec_daifmt *fmt,
> > +		       struct hdmi_codec_params *hparms);
> 
> Missing newline
> 
> > +	/**
> > +	 * @audio_shutdown:
> > +	 *
> > +	 * Shut down the audio stream. Mandatory.
> > +	 *
> > +	 * Returns:
> > +	 * 0 on success, a negative error code otherwise
> > +	 */
> > +	void (*audio_shutdown)(struct drm_connector *connector);
> 
> And thus we can probably just call that one shutdown?

It should be called automatically by the sound system. I'd rather not
call items directly that we are not supposed to call.

-- 
With best wishes
Dmitry

