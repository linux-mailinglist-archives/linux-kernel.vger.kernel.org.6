Return-Path: <linux-kernel+bounces-447222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AA99F2F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E5166F00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7035C204579;
	Mon, 16 Dec 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DanS6eae"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573C2040BC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348397; cv=none; b=hON/KfP9plP465uvJQSO+q3FgjavRYBY8FBmD+t3zm/OhV6yCrOsURkzo7DjDyBPwmPyPcHX4F5klj594vI9ltXbP4a8D80WtK8VYg4VBo0BIPf+YGPC1x58PhjUzsf7grrUzf89uB3gGzG7wIwulbqwOGcUvG3jy6Uv2VygEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348397; c=relaxed/simple;
	bh=FDCGvgz6+IaikCukN41+aa6UXILjPaDMYojr1vvsyiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYJEdvsbfDwbwi4gPvunTl1Iaj6rMkg/Z0iEfVdk+zGKpJGhPNt8hEib9FI2bnr00K0sURKO4G9sjqtZ0RaoUHtADXg5hxXiDcBFVAv12V3+oX8cCgspRPy5CKKzgsRB8G4EV1bl87l4qNElNWsO1z94c97p0z61z89WxdUjQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DanS6eae; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53ff1f7caaeso4624354e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734348393; x=1734953193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YThwe23mDMw58S0YzeDlQzDzb/FEzhlX3ugmbXf8RUY=;
        b=DanS6eaeUoxDU183IknbsXbTPMjstOR9W4RmNQdRjNsN5GxY5VAMNOS9tyZU3jiDZp
         dqkPaBTXPeXzzxLKoFkwuwEr6SasDjQAixujuV22RMRXQfO+fb9SHGpwP9kocHLTsX6/
         OiprFvqiBCn+AH83GmCyB4f+pv/b1TbFUXjXaxpTTIyWCZ2Ne8CiLxLGTphYzS1UAccT
         XZSwh5xOrmd0T6021p+UgMfGrl2mf+y0c1iSVC1Fe751dQ/44JjLfhV/kyH0jW1gklRf
         UeMdEAlTMFF7LwUXNMhJVLV5xUcHpWzPasg5RHn9yK9TfGBNy/9JDCdn2yIjx3geYudh
         BzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734348393; x=1734953193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YThwe23mDMw58S0YzeDlQzDzb/FEzhlX3ugmbXf8RUY=;
        b=e/DC8aAGICtNsTJCplvoM4G3JVBSeF4C+vtQ5DMJQPSUdHV1H2oPaaxNQmIIh+urs0
         ZeZZP0pCRjemZevPXEBNcAV0ZnThHo0p7rQVJvXhjmcJyL0VxIc76/SweqZy2TuZfeuX
         O/Vm9o/58rBQiRvo2uBwm3DUbSZcYOQNg6F9eDQRyhx0vnG7KksTINXr8FEKq6l4C2Re
         dOZf3VhzTzA2KugQHi8TWNU3WOEJ424xZfKISB+iHLOWu1BPkKuP4a7Nv8LzWUXhLgaO
         02EQuzUrSUQOuZNLpbaJFW9D9XwtrBbigC2a1iDl/p41rb1Xz6Iv3p4cvDzO306A3XbQ
         RLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqa+weMaPuZ52DmOOP4Y4r7fzShl2tAHuwzAChGK1cXuyD3Htg2hbpbU6EjbTljwmXXyc7I/6TG/fNIfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5Xo16RMxMb9rkTJ+KX6RSaUO3+B+UbGX7BeayMUmFRp/bvzx
	+4m2zBvP/6vGWRZ9Nre3NKtQEw7cBI9a9tLQPQpOh0A9bIP1muOOFsMn4gpzT3g=
X-Gm-Gg: ASbGnctpO9GeZaz2Pqf8ADt18muMfi4x68G2n/4x1ZE0/csa5c1AgdQz1AKsEYG3HXO
	X0ENpJjykwYiKiT2rncVIHerfBVm2+0/kK6DBNvvXfSrxaAZlxIbjLh43DUyk25mrNYNHci5YyC
	VCdctP/o3R5KKV8COj3WB9vhScTj492S9Q+OTFwNNHVr6BMfUVIl7fHaK2TIu7A99qF4aFHL18G
	Yz2MLzJQ+FEeS8kXmz8xUY4rqSDJggjUV8UOFND6ZSnROzDn2VXgOCE6tGynPbKbl1bXeMizt3w
	Op0NcR98M8N7FTkXYas7j+T0HxCu4018VO3w
X-Google-Smtp-Source: AGHT+IEC5KXhrrXGsT1eFAB/sps15bbUKYwoGeuTdcyybvAtpoczQRZn+Xw2w8c/HQ9Uc8g8NeiFrQ==
X-Received: by 2002:a05:6512:318b:b0:540:2a6e:3731 with SMTP id 2adb3069b0e04-5408b8f4a05mr4156948e87.5.1734348392766;
        Mon, 16 Dec 2024 03:26:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9e02sm811914e87.100.2024.12.16.03.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 03:26:32 -0800 (PST)
Date: Mon, 16 Dec 2024 13:26:29 +0200
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
Subject: Re: [PATCH v6 09/10] drm/vc4: hdmi: stop rereading EDID in
 get_modes()
Message-ID: <smaa7geowgyuvqvn6sph63ls5ublpt46zqdvt4yvqcg64scz3q@te52ty7x2soz>
References: <20241206-drm-bridge-hdmi-connector-v6-0-50dc145a9c06@linaro.org>
 <20241206-drm-bridge-hdmi-connector-v6-9-50dc145a9c06@linaro.org>
 <20241206-caped-proficient-rattlesnake-c882f3@houat>
 <73xdxb575n4ncmadffkwqzczoewbadq3forpvqt4vp7zfln2nq@o2wmbbbepwgg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73xdxb575n4ncmadffkwqzczoewbadq3forpvqt4vp7zfln2nq@o2wmbbbepwgg>

On Sun, Dec 08, 2024 at 01:06:46PM +0200, Dmitry Baryshkov wrote:
> On Fri, Dec 06, 2024 at 03:34:52PM +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > On Fri, Dec 06, 2024 at 12:16:03PM +0200, Dmitry Baryshkov wrote:
> > > The vc4_hdmi_connector_detect_ctx() via vc4_hdmi_handle_hotplug()
> > > already reads EDID and propagates it to the drm_connector. Stop
> > > rereading EDID as a part of the .get_modes() callback and just update
> > > the list of modes. This matches the behaviour of the i915 driver.
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/gpu/drm/vc4/vc4_hdmi.c | 21 ---------------------
> > >  1 file changed, 21 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > index e5ab42f72f618b90f956482db6c9c8074c1e3bf1..3364ef90968dad3074800f02926300ffceb75c69 100644
> > > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > > @@ -470,31 +470,10 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
> > >  
> > >  static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
> > >  {
> > > -	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
> > >  	struct vc4_dev *vc4 = to_vc4_dev(connector->dev);
> > > -	const struct drm_edid *drm_edid;
> > >  	int ret = 0;
> > >  
> > > -	/*
> > > -	 * NOTE: This function should really take vc4_hdmi->mutex, but doing so
> > > -	 * results in reentrancy issues since cec_s_phys_addr() might call
> > > -	 * .adap_enable, which leads to that funtion being called with our mutex
> > > -	 * held.
> > > -	 *
> > > -	 * Concurrency isn't an issue at the moment since we don't share
> > > -	 * any state with any of the other frameworks so we can ignore
> > > -	 * the lock for now.
> > > -	 */
> > > -
> > > -	drm_edid = drm_edid_read_ddc(connector, vc4_hdmi->ddc);
> > > -	drm_edid_connector_update(connector, drm_edid);
> > > -	cec_s_phys_addr(vc4_hdmi->cec_adap,
> > > -			connector->display_info.source_physical_address, false);
> > > -	if (!drm_edid)
> > > -		return 0;
> > > -
> > >  	ret = drm_edid_connector_add_modes(connector);
> > > -	drm_edid_free(drm_edid);
> > 
> > I don't think that works though, for mostly two reasons:
> > 
> >  1) We're not sure we'll even have an hotplug interrupt if the system
> >     boots with the connector plugged in for example.
> > 
> >  2) afaik, the get_modes ioctl directly calls get_modes too.
> 
> I think both paths use .fill_modes, not get_modes. And fill_modes
> explicitly calls .detect / .detect_ctx. It would be nice if somebody can
> verify the change on the acual hw. But as I wrote, i915 driver does
> exactly the same: the EDID is read / updated in .detect_ctx(), while
> .get_modes() only performs drm_edid_connector_add_modes().
> Okay, there is one significant difference which we should probably patch
> out: the .force() is also implemented to update EDID in the forced case.
> I should probably do the same for the drivers being handled in this
> patchset.

Maxime, will .force() cover your concerns? I probably fail to see a path
when .get_mode() is called without calling .detect() / .force() first.

-- 
With best wishes
Dmitry

