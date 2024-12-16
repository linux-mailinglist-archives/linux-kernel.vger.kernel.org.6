Return-Path: <linux-kernel+bounces-447860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B389F3811
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE831881E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14596206F0F;
	Mon, 16 Dec 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lILPgTZ4"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462E2066FA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371766; cv=none; b=A2HMRUDDegZRNAbmInddb5w4Gpqyx2S+ge7fGVn8dYMlZuUwH7EBn5RV0QZAq0xAwvKZXNst5iURkzY+ZEkuNoZvZcuwcetOF5mtdoSqHZqvDvcdy7AIJb5CmpxvmQ4cn+8hMF5mRkFeaXGXvVnCp3MQfbCOrpRmzbV8wM0INus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371766; c=relaxed/simple;
	bh=jYOV+rLzJMIa5nPo8Ipdg7/NFKctvzV3MaiyusapoYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR/EkpsUH845kIgGXY3ZJC89JsgU4LLtl4O5C9Nz3YbWkd9/bWLEVsg1uL1HP71iqa0zHNbPyqS3PcEUquZM3HvBykse+/Fk44+yYavIaEjAEtvrWw+b/2/6MHPJFrxZVv5ZqQQiazCHpziqafUYHWpcUOCXJjcAHgaKIVC6oOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lILPgTZ4; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54026562221so4642961e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734371762; x=1734976562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwf0Q6wp6H/pRC8arADlqkyBJYwrH22sNYfvDfmEvNU=;
        b=lILPgTZ4QjwhSdPEN9jDjUg1AwH7SOG4daJE8WEv+WXtM8QgakqabZwD4ZQ1usObj/
         fzVH7IsQbOAtFjvDYMXwFB7dubC4R7TzrE6I80uZqn5vBCEQp+pYnWvRTaT9iWABVTZ2
         Dc0R/H9dXXFcaLsVOM2IW8DhVNN+YpMeVjJ4T8ipTY0zJAadCR5bCpytednqWPLM9n44
         3Oh8ufi7PSgHgzZ4kADQ621s5TgFAl6ReGRJilIq8H67BQfGVzY6yCDjqezyzu5UbRKZ
         o4Kv5zh0DEbmcO1wHbchho6oGMXxgstp1cz9mR7/rgbI31aPh7xUsiFit9+/2sBu4JHm
         bj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371762; x=1734976562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwf0Q6wp6H/pRC8arADlqkyBJYwrH22sNYfvDfmEvNU=;
        b=XtMDsZUT/MjiuWEy7F59roMT1dPcyPtk/an6iArG+mSaEYtBTWXKi5P1Pi99fvuWhg
         qJ6HD4Yevn52BCNYgx+/BfOn1VL6U2DplKFEGjyyjenAcMKxIELOITdVNc3xpaOJuxOr
         Y1E5sYiptPTUoISy5NqbpYNtz+ptHaMmQLVcDJPuuhZa3wInj2NBgTjsx7IMNzE1mKBL
         GxOXejHx2Jg/m+l5UtaNRSJpPuwQug1FTRlunq1vUW5FYCc2+nGejO1SL9k3HAz7Zgb+
         /QvQ6NkB2NjBOna3ebeeJuu/+5C1Tvl99YZ6LH3gGUuSybWEFGkCWeeT2AGz87xAWZog
         oNiw==
X-Forwarded-Encrypted: i=1; AJvYcCU7CvXE7zypQUPR1r7oF4ar5kienwA7aGg8dGR5qUpKk6bONur5n3gDgo6d+elK4hc3RS27POjYaigw+8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TMRGr0LJpoED0amvfV2dfkTnBTWWHLnmyVDBW4Biz5XzVQz4
	QUv+HAa9B4ZXOqYXP59D+N9ksI1QrcFoNNV9zjxXYkVgKEvBCW92p6mCxo72CgM=
X-Gm-Gg: ASbGncsD16BP62WBxtaGt7lqre9PPxdd4jQJXxMAS0tctGuyZ7GSUu6nuR3T4UlLKhu
	ouPYlDaASTd1JGyVsQK8ROXUUIGR5K/GJl8/VJtXbm2ozwDNLsG2EkUIBf7HB3BPv5wv8JFze3x
	ZgpjxEO4Lv/H4VDNGxm+EAtyWaRDLL2x+uIpFOPNwzDNTZMfqPwQY/6ce6v9CLXTotJYMTcT4BZ
	5w7SWyQiK5OsZz3cQGLnWuGecBIiulA74nDDy6OUxk/S2xoEc2TZEe9HUGxScv4eILFeitAWszK
	dbN5dTWEnJXl0Q56wecW/gA0Dg5hZgjPKlKD
X-Google-Smtp-Source: AGHT+IG29n5FlljcG2G5r78Pj66GgzI4srZEZjCTKnfT1NsJdZGIbQtNCeGwmhS44dO/GlUjtQdAug==
X-Received: by 2002:a05:6512:280a:b0:540:5b5c:c181 with SMTP id 2adb3069b0e04-5408b800764mr4435678e87.6.1734371761893;
        Mon, 16 Dec 2024 09:56:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f4b8sm949454e87.13.2024.12.16.09.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:56:00 -0800 (PST)
Date: Mon, 16 Dec 2024 19:55:57 +0200
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
Subject: Re: [PATCH v6 06/10] drm/display/hdmi: implement hotplug functions
Message-ID: <bapkgt2e33bhdmun4efcuaedshyyv7qvjgugu5y53ordw3gigl@n7zbfoga7qo7>
References: <20241206-drm-bridge-hdmi-connector-v6-0-50dc145a9c06@linaro.org>
 <20241206-drm-bridge-hdmi-connector-v6-6-50dc145a9c06@linaro.org>
 <20241216-courageous-mysterious-pelican-5a8d2e@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-courageous-mysterious-pelican-5a8d2e@houat>

On Mon, Dec 16, 2024 at 06:20:04PM +0100, Maxime Ripard wrote:
> On Fri, Dec 06, 2024 at 12:16:00PM +0200, Dmitry Baryshkov wrote:
> > The HDMI Connectors need to perform a variety of tasks when the HDMI
> > connector state changes. Such tasks include setting or invalidating CEC
> > address, notifying HDMI codec driver, updating scrambler data, etc.
> > 
> > Implementing such tasks in a driver-specific callbacks is error prone.
> > Start implementing the generic helper function (currently handling only
> > the HDMI Codec framework) to be used by drivers utilizing HDMI Connector
> > framework.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 61 +++++++++++++++++++++++++
> >  include/drm/display/drm_hdmi_state_helper.h     |  8 ++++
> >  2 files changed, 69 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > index 80bf2829ba89b5f84fed4fa9eb1d6302e10a4f9e..4cdeb63688b9e48acd8e8ae87a45b6253f7dd12b 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > @@ -769,3 +769,64 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
> > +
> > +/**
> > + * drm_atomic_helper_connector_hdmi_hotplug_edid - Handle the hotplug event for the HDMI connector passing custom EDID
> > + * @connector: A pointer to the HDMI connector
> > + * @status: Connection status
> > + * @drm_edid: EDID to process
> > + *
> > + * This function should be called as a part of the .detect() / .detect_ctx()
> > + * and .force() callbacks, updating the HDMI-specific connector's data. Most
> > + * drivers should be able to use @drm_atomic_helper_connector_hdmi_hotplug()
> > + * instead.
> > + *
> > + * Returns:
> > + * Zero on success, error code on failure.
> > + */
> > +int
> > +drm_atomic_helper_connector_hdmi_hotplug_edid(struct drm_connector *connector,
> > +					      enum drm_connector_status status,
> > +					      const struct drm_edid *drm_edid)
> > +{
> > +	if (status == connector_status_disconnected) {
> > +		// TODO: also handle CEC and scramber, HDMI sink disconnected.
> > +		drm_connector_hdmi_codec_plugged_notify(connector, false);
> > +	}
> > +
> > +	drm_edid_connector_update(connector, drm_edid);
> > +
> > +	if (status == connector_status_connected) {
> > +		// TODO: also handle CEC and scramber, HDMI sink is now connected.
> > +		drm_connector_hdmi_codec_plugged_notify(connector, true);
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug_edid);
> 
> I think we discussed it in a previous version's thread after you sent
> that one, but I'd rather have that helper call an edid retrieval
> function than passing it edids.

Ack, I forgot to add the hook. I'll do that for the next version. I'll
add the .read_edid callback to the HDMI functions.

> 
> Also, EDIDs are mandatory for HDMI, so I'd call the function
> drm_atomic_helper_connector_hdmi_hotplug.

See below.

> 
> > +/**
> > + * drm_atomic_helper_connector_hdmi_hotplug - Handle the hotplug event for the HDMI connector
> > + * @connector: A pointer to the HDMI connector
> > + * @status: Connection status
> > + *
> > + * This function should be called as a part of the .detect() / .detect_ctx()
> > + * and .force() callbacks, updating the HDMI-specific connector's data.
> > + *
> > + * Returns:
> > + * Zero on success, error code on failure.
> > + */
> > +int
> > +drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
> > +					 enum drm_connector_status status)
> > +{
> > +	const struct drm_edid *drm_edid;
> > +	int ret;
> > +
> > +	drm_edid = drm_edid_read(connector);
> > +	ret = drm_atomic_helper_connector_hdmi_hotplug_edid(connector, status, drm_edid);
> > +	drm_edid_free(drm_edid);
> 
> Oh. Why do we need the two variants? Or is it to deal with drivers that
> don't set connector->ddc?

Yes. There are enough HDMI bridge drivers that would provide the
callback instead of the DDC bus. Adding callback should solve that.

-- 
With best wishes
Dmitry

