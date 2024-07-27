Return-Path: <linux-kernel+bounces-264124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF84A93DF2A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486271F21913
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1FC58AD0;
	Sat, 27 Jul 2024 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qq7WzzJg"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39653362
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722080101; cv=none; b=nPMutM8/6U8UrtDZU2yQC6Cry2DhNEq0e6Lzai8gbXsplryTIVSnUFVItnm9pkH5DCk9dcb33jpp6bGLLgpFCGLZvIRO1CHPfTJb9Svg5wR1469Rab2CfjophixoD9s11Djn4vM5iMPgBVgu77cVA4KDujPv/ImQuLWikWX7BQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722080101; c=relaxed/simple;
	bh=dGkPNzjXmQ1id94RQi86ZKQoAYp7bGpvwH40yrwaN0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLi/OVJubozirb/Xk2T8cw+SngIEGUgGhZJpttAnm7NjJbtYbc8ObGLhc0XuxrBQ6uZV66bOJtC9Os0yeivLteSUewYdtpg25DFy7wuzxn4zw3WVrd6ItIEu2gfA8S8o1+5TQfWg7FQRVBGlTylDDDjJw6fofxoF3L7hzgB3xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qq7WzzJg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f01993090so3116672e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722080097; x=1722684897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyyuHvMll/kYgnvOIX1I1r+M8rgzKlKZGm3n8QbHFDU=;
        b=qq7WzzJgwCAQK/oIWpvDJeyoD/eut1jB0OllQuR9FNa3s2pizvNWrIvakxEvvWtNtx
         zySU7BS3vwJMUESyfV8LpfL39hxK4N+AYddPcFtDGR2YkDA3rxAV1uFAgAp4MRgy/XEH
         7UfBrw4JNOFdewSQSnE/FHJtgQX6mNo6A8kl91yOYUvbfH/qMVYISSCZ3/gpVH38ZJqY
         Yn5c+NSKUEV+HIOcgnMQ/RuKumV6A1ibhhx5h8MKF/FAXWM/tSmktEL98mloTvJ5OYCI
         hUi9T90Ubd9o3SwitypJ6GEoPHtWsvid8E2RbHA9hArYKJb1Guzzhg+G0XASbvnWrZei
         76Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722080097; x=1722684897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyyuHvMll/kYgnvOIX1I1r+M8rgzKlKZGm3n8QbHFDU=;
        b=lveAeuB3dao1rVwpllNz7QC/r/G2ZXx3CNwm97Y/NPhuK5cW5CG0aMoPenDywwtT0t
         /FTkQKdUgEMohLADrx7zPQ8G7lBkrXWcYhXIFL+0nNi2r9V46aUM2JCY34nZR0R4IhVq
         SKohj5O44YzfdojtYZ2ymM9G0IAd+AbDhiPed75Nv2RouVzawh+AXDcJIjCtsq9W4D/5
         sG6N/mqYVHP3R3SA9He9JTKFqubqKhITezeL7My1Nu6/3bqKPMax0CwOlSiPqrJ1lSsl
         3PpTUQQrZogwoPCZbgRpDm7CRXxZXrfMzrmepwdSxvNS8i1FTBipb/FAeCLUH3LP0yCB
         VbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXJeeJtU7BiOPSzqstPNxYp0Od3KumECyMjaZ1X31vozu1gHRqgeb3zE+p//e3FZL53+T7mFvhLkbHNYVvbB4m6e1Mz9id1JmBiC/H
X-Gm-Message-State: AOJu0Yxq82P8/Jq96vNTNmyv0o1arI+6gufjwuE+0/XXX5sc7jtZv3Tt
	r/XSu0tmxjQYh4emuHACl7J08zJ/rkujxH+9iks45c7GOgwGOyV0V9gus1WjkXI=
X-Google-Smtp-Source: AGHT+IG8ExHepO/QvOZixDdkT0pcQ4HxjuR7Su9PjH+5LF9QaSXIm1MRBk+J6Xd/d08EM8AXFbZtvg==
X-Received: by 2002:ac2:515a:0:b0:52e:97b3:42a1 with SMTP id 2adb3069b0e04-5309b272da8mr1542417e87.24.1722080096536;
        Sat, 27 Jul 2024 04:34:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0da2sm732044e87.79.2024.07.27.04.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 04:34:56 -0700 (PDT)
Date: Sat, 27 Jul 2024 14:34:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH RFC 3/5] drm/connector: implement generic HDMI codec
 helpers
Message-ID: <nwwucz3nrne5uv626qhtxozsztl76ygcrxlqtnop7wqreb46kc@3akiwafcdaun>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-3-d59fc7865ab2@linaro.org>
 <20240621-glorious-oryx-of-expression-1ad75f@houat>
 <CAA8EJpr=ervT-KD+tYphPeTfrFGDfSaxNaYC5hfzmtVch5v10g@mail.gmail.com>
 <20240626-spiked-heavenly-kakapo-1dafce@houat>
 <pkfbp4xyg5za3vnlpryhbflb6nvp7s3bs3542wk3y5zsonoy7l@y5qcua6kfi4h>
 <20240627-meaty-bullfrog-of-refinement-cc9d85@houat>
 <cwxmu5a37qaqerpaolohxw57nzerkvlumx4dsqwmqwx5t7xhxo@kq6j63hfydra>
 <20240725-rainbow-nuthatch-of-brotherhood-bbcedc@houat>
 <90607371-2826-4448-a459-9b8a1cf6079f@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90607371-2826-4448-a459-9b8a1cf6079f@kwiboo.se>

On Thu, Jul 25, 2024 at 01:06:35PM GMT, Jonas Karlman wrote:
> On 2024-07-25 11:25, Maxime Ripard wrote:
> > On Thu, Jun 27, 2024 at 04:29:49PM GMT, Dmitry Baryshkov wrote:
> >> On Thu, Jun 27, 2024 at 11:49:37AM GMT, Maxime Ripard wrote:
> >>> On Wed, Jun 26, 2024 at 07:09:34PM GMT, Dmitry Baryshkov wrote:
> >>>> On Wed, Jun 26, 2024 at 04:05:01PM GMT, Maxime Ripard wrote:
> >>>>> On Fri, Jun 21, 2024 at 02:09:04PM GMT, Dmitry Baryshkov wrote:
> >>>>>> On Fri, 21 Jun 2024 at 12:27, Maxime Ripard <mripard@kernel.org> wrote:
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Sorry for taking some time to review this series.
> >>>>>>
> >>>>>> No problem, that's not long.
> >>>>>>
> >>>>>>>
> >>>>>>> On Sat, Jun 15, 2024 at 08:53:32PM GMT, Dmitry Baryshkov wrote:
> >>>>>>>> Several DRM drivers implement HDMI codec support (despite its name it
> >>>>>>>> applies to both HDMI and DisplayPort drivers). Implement generic
> >>>>>>>> framework to be used by these drivers. This removes a requirement to
> >>>>>>>> implement get_eld() callback and provides default implementation for
> >>>>>>>> codec's plug handling.
> >>>>>>>>
> >>>>>>>> The framework is integrated with the DRM HDMI Connector framework, but
> >>>>>>>> can be used by DisplayPort drivers.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>>> ---
> >>>>>>>>  drivers/gpu/drm/Makefile                   |   1 +
> >>>>>>>>  drivers/gpu/drm/drm_connector.c            |   8 ++
> >>>>>>>>  drivers/gpu/drm/drm_connector_hdmi_codec.c | 157 +++++++++++++++++++++++++++++
> >>>>>>>>  include/drm/drm_connector.h                |  33 ++++++
> >>>>>>>>  4 files changed, 199 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> >>>>>>>> index 68cc9258ffc4..e113a6eade23 100644
> >>>>>>>> --- a/drivers/gpu/drm/Makefile
> >>>>>>>> +++ b/drivers/gpu/drm/Makefile
> >>>>>>>> @@ -45,6 +45,7 @@ drm-y := \
> >>>>>>>>       drm_client_modeset.o \
> >>>>>>>>       drm_color_mgmt.o \
> >>>>>>>>       drm_connector.o \
> >>>>>>>> +     drm_connector_hdmi_codec.o \
> >>>>>>>>       drm_crtc.o \
> >>>>>>>>       drm_displayid.o \
> >>>>>>>>       drm_drv.o \
> >>>>>>>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> >>>>>>>> index 3d73a981004c..66d6e9487339 100644
> >>>>>>>> --- a/drivers/gpu/drm/drm_connector.c
> >>>>>>>> +++ b/drivers/gpu/drm/drm_connector.c
> >>>>>>>> @@ -279,6 +279,7 @@ static int __drm_connector_init(struct drm_device *dev,
> >>>>>>>>       mutex_init(&connector->mutex);
> >>>>>>>>       mutex_init(&connector->edid_override_mutex);
> >>>>>>>>       mutex_init(&connector->hdmi.infoframes.lock);
> >>>>>>>> +     mutex_init(&connector->hdmi_codec.lock);
> >>>>>>>>       connector->edid_blob_ptr = NULL;
> >>>>>>>>       connector->epoch_counter = 0;
> >>>>>>>>       connector->tile_blob_ptr = NULL;
> >>>>>>>> @@ -529,6 +530,12 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
> >>>>>>>>
> >>>>>>>>       connector->hdmi.funcs = hdmi_funcs;
> >>>>>>>>
> >>>>>>>> +     if (connector->hdmi_codec.i2s || connector->hdmi_codec.spdif) {
> >>>>>>>> +             ret = drmm_connector_hdmi_codec_alloc(dev, connector, hdmi_funcs->codec_ops);
> >>>>>>>> +             if (ret)
> >>>>>>>> +                     return ret;
> >>>>>>>> +     }
> >>>>>>>> +
> >>>>>>>>       return 0;
> >>>>>>>>  }
> >>>>>>>>  EXPORT_SYMBOL(drmm_connector_hdmi_init);
> >>>>>>>> @@ -665,6 +672,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
> >>>>>>>>               connector->funcs->atomic_destroy_state(connector,
> >>>>>>>>                                                      connector->state);
> >>>>>>>>
> >>>>>>>> +     mutex_destroy(&connector->hdmi_codec.lock);
> >>>>>>>>       mutex_destroy(&connector->hdmi.infoframes.lock);
> >>>>>>>>       mutex_destroy(&connector->mutex);
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/gpu/drm/drm_connector_hdmi_codec.c b/drivers/gpu/drm/drm_connector_hdmi_codec.c
> >>>>>>>> new file mode 100644
> >>>>>>>> index 000000000000..a3a7ad117f6f
> >>>>>>>> --- /dev/null
> >>>>>>>> +++ b/drivers/gpu/drm/drm_connector_hdmi_codec.c
> >>>>>>>> @@ -0,0 +1,157 @@
> >>>>>>>> +/*
> >>>>>>>> + * Copyright (c) 2024 Linaro Ltd
> >>>>>>>> + *
> >>>>>>>> + * Permission to use, copy, modify, distribute, and sell this software and its
> >>>>>>>> + * documentation for any purpose is hereby granted without fee, provided that
> >>>>>>>> + * the above copyright notice appear in all copies and that both that copyright
> >>>>>>>> + * notice and this permission notice appear in supporting documentation, and
> >>>>>>>> + * that the name of the copyright holders not be used in advertising or
> >>>>>>>> + * publicity pertaining to distribution of the software without specific,
> >>>>>>>> + * written prior permission.  The copyright holders make no representations
> >>>>>>>> + * about the suitability of this software for any purpose.  It is provided "as
> >>>>>>>> + * is" without express or implied warranty.
> >>>>>>>> + *
> >>>>>>>> + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
> >>>>>>>> + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
> >>>>>>>> + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
> >>>>>>>> + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
> >>>>>>>> + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
> >>>>>>>> + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
> >>>>>>>> + * OF THIS SOFTWARE.
> >>>>>>>> + */
> >>>>>>>> +
> >>>>>>>> +#include <linux/mutex.h>
> >>>>>>>> +#include <linux/platform_device.h>
> >>>>>>>> +
> >>>>>>>> +#include <drm/drm_connector.h>
> >>>>>>>> +#include <drm/drm_managed.h>
> >>>>>>>> +
> >>>>>>>> +#include <sound/hdmi-codec.h>
> >>>>>>>> +
> >>>>>>>> +static int drm_connector_hdmi_codec_get_eld(struct device *dev, void *data,
> >>>>>>>> +                                         uint8_t *buf, size_t len)
> >>>>>>>> +{
> >>>>>>>> +     struct drm_connector *connector = data;
> >>>>>>>> +
> >>>>>>>> +     //  FIXME: locking against drm_edid_to_eld ?
> >>>>>>>> +     memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
> >>>>>>>> +
> >>>>>>>> +     return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +static int drm_connector_hdmi_codec_hook_plugged_cb(struct device *dev,
> >>>>>>>> +                                                 void *data,
> >>>>>>>> +                                                 hdmi_codec_plugged_cb fn,
> >>>>>>>> +                                                 struct device *codec_dev)
> >>>>>>>> +{
> >>>>>>>> +     struct drm_connector *connector = data;
> >>>>>>>> +
> >>>>>>>> +     mutex_lock(&connector->hdmi_codec.lock);
> >>>>>>>> +
> >>>>>>>> +     connector->hdmi_codec.plugged_cb = fn;
> >>>>>>>> +     connector->hdmi_codec.plugged_cb_dev = codec_dev;
> >>>>>>>> +
> >>>>>>>> +     fn(codec_dev, connector->hdmi_codec.last_state);
> >>>>>>>> +
> >>>>>>>> +     mutex_unlock(&connector->hdmi_codec.lock);
> >>>>>>>> +
> >>>>>>>> +     return 0;
> >>>>>>>> +}
> >>>>>>>> +
> >>>>>>>> +void drm_connector_hdmi_codec_plugged_notify(struct drm_connector *connector,
> >>>>>>>> +                                          bool plugged)
> >>>>>>>> +{
> >>>>>>>> +     mutex_lock(&connector->hdmi_codec.lock);
> >>>>>>>> +
> >>>>>>>> +     connector->hdmi_codec.last_state = plugged;
> >>>>>>>> +
> >>>>>>>> +     if (connector->hdmi_codec.plugged_cb &&
> >>>>>>>> +         connector->hdmi_codec.plugged_cb_dev)
> >>>>>>>> +             connector->hdmi_codec.plugged_cb(connector->hdmi_codec.plugged_cb_dev,
> >>>>>>>> +                                              connector->hdmi_codec.last_state);
> >>>>>>>> +
> >>>>>>>> +     mutex_unlock(&connector->hdmi_codec.lock);
> >>>>>>>> +}
> >>>>>>>> +EXPORT_SYMBOL(drm_connector_hdmi_codec_plugged_notify);
> >>>>>>>
> >>>>>>> I think we should do this the other way around, or rather, like we do
> >>>>>>> for drm_connector_hdmi_init. We'll need a hotplug handler for multiple
> >>>>>>> things (CEC, HDMI 2.0, audio), so it would be best to have a single
> >>>>>>> function to call from drivers, that will perform whatever is needed
> >>>>>>> depending on the driver's capabilities.
> >>>>>>
> >>>>>> I see, this API is probably misnamed. The hdmi_codec_ops use the
> >>>>>> 'plugged' term,
> >>>>>
> >>>>> Is it misnamed?
> >>>>>
> >>>>> It's documented as:
> >>>>>
> >>>>>   Hook callback function to handle connector plug event. Optional.
> >>>>>
> >>>>>> but most of the drivers notify the ASoC / codec during atomic_enable /
> >>>>>> atomic_disable path, because usually the audio path can not work with
> >>>>>> the video path being disabled.
> >>>>>
> >>>>> That's not clear to me either:
> >>>>>
> >>>>>   - rockchip/cdn-dp, msm/dp/dp-audio, dw-hdmi, seem to call it at
> >>>>>     enable/disable
> >>>>>
> >>>>>   - anx7625, mtk_hdmi and mtk_dp calls it in detect
> >>>>>
> >>>>>   - adv7511, ite-it66121, lontium-lt9611, lontium-lt9611uxc, sii902x,
> >>>>>     exynos, tda998x, msm_hdmi, sti, tegra, vc4 don't call it at all.
> >>>>>
> >>>>> So it doesn't look like there's a majority we can align with, and
> >>>>> neither should we: we need to figure out what we *need* to do and when,
> >>>>> and do that.
> >>>>>
> >>>>> From the documentation and quickly through the code though, handling it
> >>>>> in detect looks like the right call.
> >>>>
> >>>> It is tempting to have it in the hotplug call. However:
> >>>>
> >>>> - It is used to send events to the ASoC Jack, marking the output as
> >>>>   plugged or unplugged. Once the output is plugged, userspace might
> >>>>   consider using it for the audio output. Please correct me if I'm
> >>>>   wrong, but I don't think one can output audio to the HDMI plug unless
> >>>>   there is a video stream.
> >>>
> >>> That's something to check in the HDMI spec and with the ALSA
> >>> maintainers.
> >>
> >> Mark and Liam are on CC list. I've also pinged Mark on the IRC (on
> >> #alsa, if the channel logs are preserved somewhere)
> >>
> >> <lumag> I'm trying to implement a somewhat generic implementation that the drivers can hook in. The main discussion is at [link to this discussion]
> >> <lumag> So in theory that affects all ASoC platforms having HDMI or DP audio output
> >> <broonie> In that case I'd be conservative and try to follow the state of the physical connection as closely as possible.
> >>
> >> So it is really 'plugged'.
> > 
> > Ack.
> > 
> >>>> - Having it in the hotplug notification chain is also troublesome. As
> >>>>   Dave pointed out in the quoted piece of code, it should come after
> >>>>   reading the EDID on the connect event. On the disconnect event it
> >>>>   should probably come before calling the notification chain, to let
> >>>>   audio code interract correctly with the fully enabled display devices.
> >>>
> >>> EDIDs are fetched when hotplug is detected anyway, and we need it for
> >>> other things anyway (like CEC).
> >>
> >> I see that:
> >>
> >> - VC4 reads EDID and sets CEC address directly in hotplug notifier and
> >>   then again in get_modes callback. (why is it necessary in the hotplug
> >>   notifier, if it's done anyway in get_modes?)
> > 
> > vc4 is probably somewhat correct, but also a bit redundant here: the CEC
> > physical address is supposed to be set when we detect a sink.
> > 
> > When that sink is removed, we don't have a physical address anymore and
> > we thus need to call cec_phys_addr_invalidate.
> > 
> > When a sink is plugged again, we need to call cec_s_phys_addr() with the
> > sink address.
> > 
> > So what vc4_hdmi_handle_hotplug is doing is fine, but the one in the
> > get_modes might be redundant.

I see the logic here, but I don't like the duplication between
detect_ctx() and get_modes(). Doesn't it make drm_edid_read_ddc() in
get_modes() redundant?

> >> - sun4i sets CEC address from get_modes
> > 
> > Yeah, that doesn't work. 
> > 
> > If the display is switched to another one and if the userspace doesn't
> > react to the hotplug event by calling get_modes, the physical address
> > will be the old one.

Ack.

> > 
> > But since it's a polled hotplug, it's a situation that generally sucks.
> > 
> >> - ADV7511 does a trick and sets CEC address from edid_read() callback
> >>   (with the FIXME from Jani that basically tells us to move this to
> >>   get_modes)
> > 
> > Same situation than sun4i here, except for the fact that it can handle
> > hotplug through an interrupt.
> > 
> >> - omapdrm clears CEC address from hpd_notify, but sets it from the
> >>   edid_read() callback with the same FIXME.
> > 
> > I think it's still broken there. It properly clears the physical address
> > when the sink is disconnected, but relies on someone calling get_modes
> > to set it again, which isn't guaranteed.
> > 
> >> - i915 sets CEC address from .detect_ctx callback
> > 
> > That one is vc4 minus the get_modes redundancy.
> > 
> >> So there is no uniformity too. Handling it from drm_bridge_connector() /
> >> get_modes might help, but that requires clearing one of TODO items.
> > 
> > There's no uniformity, but I guess both vc4 and i915 are much more
> > battle-tested than sun4i, omapdrm, or adv7511 might be, and they both
> > behave pretty much the same.
> > 
> > Generally speaking (and it might be sad), but i915 is what userspace
> > expects, so it's usually what we want to follow.
> 
> For the dw-hdmi connector I also moved the edid read and cec phys addr
> handling from hpd irq to the detect callback in [1]. That seem to be the
> best option as it gets called by core after/during hpd processing and
> also more closely matches i915.

Yes, it seems that we should settle on this (and maybe document it as
the BCP).

> Was not fully sure what to do about the hdmi-codec callback so left it
> at enable/disable as that seemed to best match the expected plugged
> state. However, dw-hdmi connector will more than likely trigger a
> disconnected/connected state change and a disable/enable cycle during
> an edid refresh from the sink, i.e. when a connected AVR is powered on
> or off, so it does now always match the physical plugged state.

If I understood Mark correctly, the plugged callback should really
reflect the 'plugged' state (well, probably after reading the EDID to
make ELD available to ASoC subsys). Maybe we should have a separate
control for making the sink available for audio output, but nobody has
that yet.

> [1] https://lore.kernel.org/all/20240611155108.1436502-1-jonas@kwiboo.se/

-- 
With best wishes
Dmitry

