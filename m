Return-Path: <linux-kernel+bounces-231166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A03918709
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07A4284500
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BF318FC7B;
	Wed, 26 Jun 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jO+673Ve"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC818FC68
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418285; cv=none; b=sl8OPyAe3u5A1Y2skJroZBqZ/qRFM02PHn1grvGdoJdK6G9uHzh3yajktWeI3/+O53Cd86sKSwPcpp9RPRS3Suppch5s4gOIqHhacvYkUZ90sza9tZAZi2LgNILSZN9Ahl7b8MhCNbPu6x4vMUb+GlXNmvnN5fOf0Wx8JCD0I6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418285; c=relaxed/simple;
	bh=IF+nGeFxDoq9PHrclbX2hA73yrjso5FCn0OVuBUXr/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4npQlIwqmM3vwmhuv/6AG/m81GV4Vt8VyACi0ipNnmLbQ7sFjdomnmftp/D5QbAFNV/Wv+G8fJ0y2DeQ8QNPPfBVMuzdUHRIQpcO9JDbhrHS2RtMN85davhwT20XpqwKUIGSPb/PXqWZLI4ToVkjuN96ecfhx1MlI2ETEUEl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jO+673Ve; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso4492817e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719418282; x=1720023082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbhEvjvG0+S0jKL73QhvebbikzYI6KgKKLPFOTW6JQo=;
        b=jO+673VehH6SbnvmJQQd17X0UqtL5w+2gVaMDh9xE0sYkfQO3bbSZKMuD/9YCVki4U
         OFBLMZnguUMkI6U9ctc0KqLV/7QT6rfEji6KWuweN5FROZ0Vz/YBxTKjmfcZhFD7R8I1
         C6+odqHLL+Dtv5lL49nEo0V1m5DXbcO2/CqH7gQ+BExEm15p37KIb+33QeEvzn324uio
         fYWhe9REEKr6QGKzGEnOujz2rJYYAu+LTM23GUNsfaL54veAb3f4AkAyYfkaINsIFGqy
         vU8MD/HmT/TeyrDea8CgeESHSoGmSc3cPOM5Zq4IKDdL5HwTZ2ok4f6eIbAjXEGz1MY3
         C7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418282; x=1720023082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbhEvjvG0+S0jKL73QhvebbikzYI6KgKKLPFOTW6JQo=;
        b=Qs3n76fqUWuSEnKi2TZqUCNJla6S0iHtP8cQqD1zBawVQ7G8bZtSzUZUt6gSFepBE2
         caQ7Zc2cQmo97jKHQZCWIe+1Xhll/wqyWz63+pv+pCdIF8QmwVaT3xoqpJ/mnaKiZDpm
         U8Y8ZT9f253Lmo9sOZtGKyEc6JKBhVegWHgN8JiThUP2vjuipafwZlImqc3qCjgDOCX+
         o3K2F4XEvQkyDQjZ/xCDzoAgyabGmLXuYnVy9zHpcFj+uMyKkuGDeYcdfEw03kFbv05P
         xuTRMs7YRvcdQiT7chpHw2fFWJKFkU53gItTtLLvFluK7Z3m7Zg/Asd/J85DtsVjEHAv
         zGHw==
X-Forwarded-Encrypted: i=1; AJvYcCW/xLwymxrys1CRzxtNqKDnpUr6RtLle8iwWlseNYXsm+oojw4CIzMdqsNfI3eKRAfe1Z1eFT3X4jCJ+WgjdzAIwZtD6XV+2qD5uPk+
X-Gm-Message-State: AOJu0Yzt2IKHznBoi54eEpast+yWQkAk4R+RTBeTD/178rc9TXja+UmR
	BQ4ovVfWnWm3AbhE2yG6/YKK2MfjxOCgRloxjCYAqYcM+AZooFBWTMU/jBJu0JI=
X-Google-Smtp-Source: AGHT+IFovT/Qkyd3fRnmp87RGtlsQxy3mmsB/6xiCPOtkFo7Oz4ZDoO6+zh5Vt8N6Y6HDfEU10YxmQ==
X-Received: by 2002:ac2:5195:0:b0:52c:e080:6a07 with SMTP id 2adb3069b0e04-52ce1835949mr8564186e87.39.1719418280199;
        Wed, 26 Jun 2024 09:11:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cebf46335sm658632e87.132.2024.06.26.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:11:19 -0700 (PDT)
Date: Wed, 26 Jun 2024 19:11:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH RFC 3/5] drm/connector: implement generic HDMI codec
 helpers
Message-ID: <r5226a5zzbp2d7zmxbskll6ed7coy4qbxhd6aaqulqzyuom6sp@dliwhreaqmtl>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-3-d59fc7865ab2@linaro.org>
 <20240621-glorious-oryx-of-expression-1ad75f@houat>
 <CAA8EJpr=ervT-KD+tYphPeTfrFGDfSaxNaYC5hfzmtVch5v10g@mail.gmail.com>
 <20240626-spiked-heavenly-kakapo-1dafce@houat>
 <CAPY8ntAn3y5Su+SLJPv7FLq_aUhCv=vaATt4jLs4VUu4Xnd6aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPY8ntAn3y5Su+SLJPv7FLq_aUhCv=vaATt4jLs4VUu4Xnd6aA@mail.gmail.com>

On Wed, Jun 26, 2024 at 04:10:05PM GMT, Dave Stevenson wrote:
> Hi Maxime and Dmitry
> 
> On Wed, 26 Jun 2024 at 15:05, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Fri, Jun 21, 2024 at 02:09:04PM GMT, Dmitry Baryshkov wrote:
> > > On Fri, 21 Jun 2024 at 12:27, Maxime Ripard <mripard@kernel.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Sorry for taking some time to review this series.
> > >
> > > No problem, that's not long.
> > >
> > > >
> > > > On Sat, Jun 15, 2024 at 08:53:32PM GMT, Dmitry Baryshkov wrote:
> > > > > Several DRM drivers implement HDMI codec support (despite its name it
> > > > > applies to both HDMI and DisplayPort drivers). Implement generic
> > > > > framework to be used by these drivers. This removes a requirement to
> > > > > implement get_eld() callback and provides default implementation for
> > > > > codec's plug handling.
> > > > >
> > > > > The framework is integrated with the DRM HDMI Connector framework, but
> > > > > can be used by DisplayPort drivers.
> > > > >
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > >  drivers/gpu/drm/Makefile                   |   1 +
> > > > >  drivers/gpu/drm/drm_connector.c            |   8 ++
> > > > >  drivers/gpu/drm/drm_connector_hdmi_codec.c | 157 +++++++++++++++++++++++++++++
> > > > >  include/drm/drm_connector.h                |  33 ++++++
> > > > >  4 files changed, 199 insertions(+)
> > > > >

[...]

> > > > > +
> > > > > +static int drm_connector_hdmi_codec_get_eld(struct device *dev, void *data,
> > > > > +                                         uint8_t *buf, size_t len)
> > > > > +{
> > > > > +     struct drm_connector *connector = data;
> > > > > +
> > > > > +     //  FIXME: locking against drm_edid_to_eld ?
> > > > > +     memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static int drm_connector_hdmi_codec_hook_plugged_cb(struct device *dev,
> > > > > +                                                 void *data,
> > > > > +                                                 hdmi_codec_plugged_cb fn,
> > > > > +                                                 struct device *codec_dev)
> > > > > +{
> > > > > +     struct drm_connector *connector = data;
> > > > > +
> > > > > +     mutex_lock(&connector->hdmi_codec.lock);
> > > > > +
> > > > > +     connector->hdmi_codec.plugged_cb = fn;
> > > > > +     connector->hdmi_codec.plugged_cb_dev = codec_dev;
> > > > > +
> > > > > +     fn(codec_dev, connector->hdmi_codec.last_state);
> > > > > +
> > > > > +     mutex_unlock(&connector->hdmi_codec.lock);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +void drm_connector_hdmi_codec_plugged_notify(struct drm_connector *connector,
> > > > > +                                          bool plugged)
> > > > > +{
> > > > > +     mutex_lock(&connector->hdmi_codec.lock);
> > > > > +
> > > > > +     connector->hdmi_codec.last_state = plugged;
> > > > > +
> > > > > +     if (connector->hdmi_codec.plugged_cb &&
> > > > > +         connector->hdmi_codec.plugged_cb_dev)
> > > > > +             connector->hdmi_codec.plugged_cb(connector->hdmi_codec.plugged_cb_dev,
> > > > > +                                              connector->hdmi_codec.last_state);
> > > > > +
> > > > > +     mutex_unlock(&connector->hdmi_codec.lock);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_hdmi_codec_plugged_notify);
> > > >
> > > > I think we should do this the other way around, or rather, like we do
> > > > for drm_connector_hdmi_init. We'll need a hotplug handler for multiple
> > > > things (CEC, HDMI 2.0, audio), so it would be best to have a single
> > > > function to call from drivers, that will perform whatever is needed
> > > > depending on the driver's capabilities.
> > >
> > > I see, this API is probably misnamed. The hdmi_codec_ops use the
> > > 'plugged' term,
> >
> > Is it misnamed?
> >
> > It's documented as:
> >
> >   Hook callback function to handle connector plug event. Optional.
> >
> > > but most of the drivers notify the ASoC / codec during atomic_enable /
> > > atomic_disable path, because usually the audio path can not work with
> > > the video path being disabled.
> >
> > That's not clear to me either:
> >
> >   - rockchip/cdn-dp, msm/dp/dp-audio, dw-hdmi, seem to call it at
> >     enable/disable
> >
> >   - anx7625, mtk_hdmi and mtk_dp calls it in detect
> >
> >   - adv7511, ite-it66121, lontium-lt9611, lontium-lt9611uxc, sii902x,
> >     exynos, tda998x, msm_hdmi, sti, tegra, vc4 don't call it at all.
> 
> FWIW I have a patch in the next set that adds the call to vc4. The
> downstream version of the patch is at [1].

Nice!

> > So it doesn't look like there's a majority we can align with, and
> > neither should we: we need to figure out what we *need* to do and when,
> > and do that.
> >
> > From the documentation and quickly through the code though, handling it
> > in detect looks like the right call.
> 
> We concluded that hotplug detect appeared to be the right place as well.

Probably you also stumbled upon hotplug vs enable/disable. Could you
please comment, why you made your decision towards hotplug path?

> 
>   Dave
> 
> [1] https://github.com/raspberrypi/linux/commit/051392bfdc6dc54563ed9909cc1164e8d734af43
> 


-- 
With best wishes
Dmitry

