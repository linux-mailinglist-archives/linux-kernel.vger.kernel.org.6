Return-Path: <linux-kernel+bounces-449176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B0A9F4AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A5A188AB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC5F1F1312;
	Tue, 17 Dec 2024 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkG+fhJl"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD01E282D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438714; cv=none; b=Tt7T8BOFIhHVgb41wsFmTqwDNu3V6me9aiUIbKlGM/ycvVlGULdaiEmlF2tJZRZ4wP7EyAgeaLwIAMVQo9qllnRHKqMcGFLKuXWmhFiHP1w8RWYU4Pu5prCdmQMZQufNwUjbfIpjbOMkk5y24b9Un1tWganQIaol2PujRCcQJXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438714; c=relaxed/simple;
	bh=7N9XWsRRznkPFIWEExuMVt17UZ3nd7QjBaGJxD0x96k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI6wKgCRegIQdOC2bvHRgCkbTOHtLqwKVdwGZp+gNuZELPppXiiWtDHFwXLSwznCoF8ZqatFPR/4va1WRjnagUrbQtOaPxXqV6O5J1kH0N47M26HvQvN5ePKu4GH6THE0gKfANHJtbF9A8VFTd8DaT2GAStHV6wr8C3i7iEOvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XkG+fhJl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5401c68b89eso5687694e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734438711; x=1735043511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OD2airYmXEIM5XCQfXb6/TEVO/ZX203WR6AY+SunHbs=;
        b=XkG+fhJl+eUSXWdZkTmsAlBgluEsHe0alVEhyTB74yQcx59zfSDfyQl+a908jfGkAO
         ydDfBpbfYtMjDbiwzzYflqlKfaaCc5zb/WuOYS1Zf/KGGa/cQ1NPTk4NnrY0uaoWUCc2
         +T4gFEB5Kvn8sJg0RYG8gnwULLKhniANWcMu9tgTDZg2AeO9iLGSsx47Ccv3u0O+OPTF
         JXAhG5ttfjigvwNloQEnMf6shTMubp5LWGfjh8YOfAC8QLV6EnCa3FYDdwvz7FhswMxC
         Ze7YRIT8EUhYEW6jlzPcdfKuQI0zSvhBlKxim65mwiXqFipPjSK7w6l6ltNErBteAsUD
         RTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734438711; x=1735043511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OD2airYmXEIM5XCQfXb6/TEVO/ZX203WR6AY+SunHbs=;
        b=dBkCWwPehzX1XR9HSEBW59PxnqnOYwx/fwzbolD9jeFAEL6PWw7KZmXw6hBYJu+BQB
         RbRdXg2hRIrdopM8h8KsG+qG1cIJtGhBey/DQjYJi9/LLe4/ww9J/xK+1l8U/k/bvCmC
         xtlL/4EqGWM9ypEP7iahGUjOIiAoR178YkafkxowCgiHcZMm8rmDi71fS3IcjgMEXKQw
         iNHghRh4/W4S+pVAHaw0AwIs3bFeFKDEq5DbrHRqoF1JvliZtUEE4um3QoLJFVhVJUNH
         2DO/tBoo2a1seypVPIbkCaW+2YOEfnE6dINwD6KeTQ0gE7y9/vf2Nc9m2p1b11UTLGnN
         3JAA==
X-Forwarded-Encrypted: i=1; AJvYcCXz9hZCGBDkUeUsIY7TdvsVMpnO08MRgxj685ETUJpNEXk1Cns1d97kGszmp0Xqo2CjToTHzyadW3LcHYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp8Ozilz6sY+vJATE5I66077DL6FiFdEW3o+onIqq1A58U0f0
	Gg8CktGXodik2ifX9vcA39tBIJwA93qdwx/zIEn3+A11cDqTvMRyUhxa2CyKOEU=
X-Gm-Gg: ASbGncuY5qCkzbslYhfdhydeqbx1PHoAsMq3muu2RKCI6hRsOj1P7+O5IODYa3dCJyR
	f2z0gZ94dL9/LcqS6KoyvXvysNqSGuSqD7DsAgN1O0TwhGRInMNPH6VgoFaDwO/phX2AMYRnWdj
	+QZnrg9EgJ+k2oLuZhRTJwpRqRkxBUQBIRgy56XhMcrzbX9qzg+nRDivXm5yNIrih9RuJY9RpaY
	zXgxOelvOr8RZka75f2yorQoENfilqQ07BXwiOfYAmvi5NxKhM+j3Bk00l3iJfT3Sn0dcAInhrR
	jiJq5qD2l9seHHKF6Z2srWrP8gbWDU+7JN9+
X-Google-Smtp-Source: AGHT+IGLqNfuo6dVnZwB0IG9CYkUL75QpM9W/HERVzyQaVYoG4TeHcNOZSSbW2843k7yE5uyrSEtJA==
X-Received: by 2002:a05:6512:3e0c:b0:540:1fec:f331 with SMTP id 2adb3069b0e04-541315ac7a5mr947299e87.27.1734438711130;
        Tue, 17 Dec 2024 04:31:51 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f3d0sm1145293e87.30.2024.12.17.04.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:31:49 -0800 (PST)
Date: Tue, 17 Dec 2024 14:31:47 +0200
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
Message-ID: <buem3nnscnyh7latovvnsbhp2ci6pbjpckfmrft2267afzwdwq@2roahluiow7t>
References: <20241206-drm-bridge-hdmi-connector-v6-0-50dc145a9c06@linaro.org>
 <20241206-drm-bridge-hdmi-connector-v6-3-50dc145a9c06@linaro.org>
 <20241216-heretic-mackerel-of-wholeness-fcfed7@houat>
 <exocd3b65cy6cy5w47cwx3ykn54ncf34hwyj7ffihs5jjzean5@y677uywnlah2>
 <20241217-heretic-hopeful-jaguar-aeabec@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-heretic-hopeful-jaguar-aeabec@houat>

On Tue, Dec 17, 2024 at 08:43:10AM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Dec 16, 2024 at 07:47:32PM +0200, Dmitry Baryshkov wrote:
> > On Mon, Dec 16, 2024 at 06:04:41PM +0100, Maxime Ripard wrote:
> > > > +struct drm_connector_hdmi_codec_funcs {
> > > > +	/**
> > > > +	 * @audio_startup:
> > > > +	 *
> > > > +	 * Called when ASoC starts an audio stream setup. The
> > > > +	 * @hdmi_audio_startup is optional.
> > > > +	 *
> > > > +	 * Returns:
> > > > +	 * 0 on success, a negative error code otherwise
> > > > +	 */
> > > > +	int (*audio_startup)(struct drm_connector *connector);
> > > > +
> > > > +	/**
> > > > +	 * @prepare:
> > > > +	 * Configures HDMI-encoder for audio stream. Can be called
> > > > +	 * multiple times for each setup. Mandatory.
> > > > +	 *
> > > > +	 * Returns:
> > > > +	 * 0 on success, a negative error code otherwise
> > > > +	 */
> > > > +	int (*prepare)(struct drm_connector *connector,
> > > > +		       struct hdmi_codec_daifmt *fmt,
> > > > +		       struct hdmi_codec_params *hparms);
> > > 
> > > Missing newline
> > > 
> > > > +	/**
> > > > +	 * @audio_shutdown:
> > > > +	 *
> > > > +	 * Shut down the audio stream. Mandatory.
> > > > +	 *
> > > > +	 * Returns:
> > > > +	 * 0 on success, a negative error code otherwise
> > > > +	 */
> > > > +	void (*audio_shutdown)(struct drm_connector *connector);
> > > 
> > > And thus we can probably just call that one shutdown?
> > 
> > It should be called automatically by the sound system. I'd rather not
> > call items directly that we are not supposed to call.
> 
> I meant that with my suggestion to call the function
> drm_connector_hdmi_audio_init, that structure would be called
> drm_connector_hdmi_audio_funcs, and thus the audio prefix in
> audio_shutdown is redundant.

I see. I posted the next iteration already, but I'll try to remember
this change for the next iteration.

-- 
With best wishes
Dmitry

