Return-Path: <linux-kernel+bounces-230398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE88917C42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A9628E17B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7BB16D9C1;
	Wed, 26 Jun 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1+apxTf"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DEA16A948
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393336; cv=none; b=pIMSmjN4l5RDgBwdCUY5aiP/cSePgaz+xh/NY4AoyDN71TMyP2PEjnKlIvAiAqsA8wm+JwpMrBuYuTA9+v2cruaKHU7Ow1DfrxHRL8S025O8mes9gQMuFXbdX8L1IxNXWI31D7xEqJ0S2zKSg++BHkid9P78KpAvbeI3KRSWYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393336; c=relaxed/simple;
	bh=1oJhdzOe6APUUeZ5Bt3L+6w0fBQ8DcMKY89ZYua6KfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbSjZF9ZppicoUNK1PnOpWCBxCc7ipuVQYf7RS2h8yRIKwgKQZK4TIOfw8HuYbzeuzlGerlcqzPAmvc1ftSOHm/SzgPc785jlpZIZE4P4c0fRpFdr9Q9jX1gD63MOZnA0DFrw7JtGNP9QHyDcNyQnO5yY8rc7fSRyvMePF5Wvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1+apxTf; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ce674da85so3307159e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 02:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719393332; x=1719998132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qqYdOJxs+VFbdv5Sum02xSfIfK4O1Ds0i5uQR9Cc/Lg=;
        b=K1+apxTfpF4xceOTFoLPUYFz6xb7/rywQRM9IwVA2sQNCI3N9/Q1Y9Ua8RvowrNxWH
         7VGajRiYbN+L5ER59DR00Z4mRbJIVplpTh5UCW+l1mdmyuRo6zhM7Ujt7/ay2OVLGFOJ
         i3qcI9gGgNQWQsNUlOEhd29OTQUlUXmXHpC8FsFUUrpceuScDVrqCz0Bn+yU3oXAiavQ
         LLVXQn35bLOh0t59TNo1lATpKIdVM6+GHOXlQbpM68LwuMcDNNlBdeLjE6Lz6L2T/Gt7
         h8XXzQWk+4keCX9ICc0PIVMI1EjPmFK7U3Y3AZuKJQOMezz0jih844q9pz1M/n1MKfNG
         zLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719393332; x=1719998132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqYdOJxs+VFbdv5Sum02xSfIfK4O1Ds0i5uQR9Cc/Lg=;
        b=GD+aq67nIbjFS6Ni1YSQJUhfSm6cNduw5EWnB2tChQP+CU8F1+Hh7LFTI+oGGLx2Ur
         3XOtK0/MMlB5XXd0tf3GjzSvfejqkP8PdMzXqbb8+H2HKsx8cuAGPrygpOJ5V/XzT27A
         yfSVX9nlbZluntCb3wJUdYGnN7DxCJ3deLJqIJzSpA9zTzyQAjK6KdCXsXwCxOWKoXHk
         9gYc8qbOMTxuTfeUzd/Q7gI//DdkpkjduEherQJQVD+rN7NviP/U4hGqC/J/cl/AZKyE
         EL580oFffE8kOHRSr+jvoMDPBvWLkieVzO9P8YeG6+QcHYRNNDQsy6hkPGfR0AgQjzu8
         zEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo+hF6mrLreZiGXikogPfNiVRR8xhg+QZ9O/7g6HPRinO/qBpFIxFpbtXYZEWU1adO+DmU/LYPMpyTrGfrlw2X+Sw7vEEUxX+mMxoj
X-Gm-Message-State: AOJu0Yz3MP7b9ruEinEEOv0dYKltPNugvnws/7ts2ON2nVKHhl6I96m/
	nfoV4YBC52iiVWk9JP43k8Fmq3RW4uj+/EQMezP1dVnxJMy7Ibuh12gk3NA6qko=
X-Google-Smtp-Source: AGHT+IEoPEZ+Z1GDHwYgi6YwL3Dp42WEH58e9eBo3wjc+0KVQYyGcZlw/ZsNg8ZiVT7ZuwxnNv3rXg==
X-Received: by 2002:a19:e014:0:b0:52c:dfe6:6352 with SMTP id 2adb3069b0e04-52ce185db23mr7675461e87.48.1719393332427;
        Wed, 26 Jun 2024 02:15:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd641f655sm1496404e87.162.2024.06.26.02.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:15:31 -0700 (PDT)
Date: Wed, 26 Jun 2024 12:15:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/3] drm/panel: add lincoln lcd197 support
Message-ID: <xc4laokjirwetexrcgfxq4kk3wrqn2i7k2kiqe7ivylhgmjw3w@pwwde5mlwxit>
References: <20240625142552.1000988-1-jbrunet@baylibre.com>
 <20240625142552.1000988-4-jbrunet@baylibre.com>
 <irzer3be5fj2rg2bmc2oqxqtaw6jybbdkgv3jgxpyhdvojwv24@e4i2v6d454nz>
 <1jmsn8gjq6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jmsn8gjq6.fsf@starbuckisacylon.baylibre.com>

On Wed, Jun 26, 2024 at 11:02:25AM GMT, Jerome Brunet wrote:
> On Wed 26 Jun 2024 at 07:41, Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
> > On Tue, Jun 25, 2024 at 04:25:50PM GMT, Jerome Brunet wrote:
> >> Add support for the Lincoln LCD197 1080x1920 DSI panel.
> >> 
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  drivers/gpu/drm/panel/Kconfig                |  11 +
> >>  drivers/gpu/drm/panel/Makefile               |   1 +
> >>  drivers/gpu/drm/panel/panel-lincoln-lcd197.c | 333 +++++++++++++++++++
> >>  3 files changed, 345 insertions(+)
> >>  create mode 100644 drivers/gpu/drm/panel/panel-lincoln-lcd197.c
> >> 
> >
> > [...]
> >
> >> +
> >> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB9, 0xFF, 0x83, 0x99);
> >
> > - Please use lowercase hex instead
> > - Please consider switching to _multi() functions.
> 
> Could you be a bit more specific about these '_multi' function ?
> I've looked at 'drm_mipi_dsi.h' and can't really make what you mean.
> 
> Maybe I'm not looking in the right place.

What is your baseline? Please see commits 966e397e4f60 ("drm/mipi-dsi:
Introduce mipi_dsi_*_write_seq_multi()") and f79d6d28d8fe
("drm/mipi-dsi: wrap more functions for streamline handling") (and
66055636a146 ("drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep") as
it fixes a mistake in those two).

> 
> >
> >
> >> +	usleep_range(200, 300);
> >
> > This will require new helper msm_dsi_usleep_range(ctx, 200, 300);
> 
> I don't really understand why I would need something else to just sleep
> ? Could you add some context please ?
> 
> Isn't 'msm_' usually something Qcom specific ?

Yes, mipi_dsi_usleep_range(). Mea culpa.

> >> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xB6, 0x92, 0x92);
> >> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xCC, 0x00);
> >> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xBF, 0x40, 0x41, 0x50, 0x49);
> >> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC6, 0xFF, 0xF9);
> >> +	mipi_dsi_dcs_write_seq(lcd->dsi, 0xC0, 0x25, 0x5A);
> >> +	mipi_dsi_dcs_write_seq(lcd->dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x02);
> >> +
> >> +	err = mipi_dsi_dcs_exit_sleep_mode(lcd->dsi);
> >> +	if (err < 0) {
> >> +		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
> >> +		goto poweroff;
> >> +	}
> >> +	msleep(120);
> >> +
> >> +	err = mipi_dsi_dcs_read(lcd->dsi, MIPI_DCS_GET_DISPLAY_ID, display_id, 3);
> >
> > This probably needs new _multi helper too.
> >
> >> +	if (err < 0) {
> >> +		dev_err(panel->dev, "Failed to read display id: %d\n", err);
> >> +	} else {
> >> +		dev_dbg(panel->dev, "Display id: 0x%02x-0x%02x-0x%02x\n",
> >> +			display_id[0], display_id[1], display_id[2]);
> >> +	}
> >> +
> >> +	lcd->prepared = true;
> >
> > Should not be required anymore.
> 
> The whole driver is heavily inspired by what is already in
> drivers/gpu/drm/panel/ and a lot are doing something similar.
> 
> Maybe there has been a change since then and the existing have been
> reworked yet. Would you mind pointing me that change if that is
> the case ?

See d2aacaf07395 ("drm/panel: Check for already prepared/enabled in
drm_panel")

> 
> >
> >> +
> >> +	return 0;
> >> +
> >> +poweroff:
> >> +	gpiod_set_value_cansleep(lcd->enable_gpio, 0);
> >> +	gpiod_set_value_cansleep(lcd->reset_gpio, 1);
> >> +	regulator_disable(lcd->supply);
> >> +
> >> +	return err;
> >> +}
> >> +
> >
> >> +
> >> +static const struct drm_display_mode default_mode = {
> >> +	.clock = 154002,
> >> +	.hdisplay = 1080,
> >> +	.hsync_start = 1080 + 20,
> >> +	.hsync_end = 1080 + 20 + 6,
> >> +	.htotal = 1080 + 204,
> >> +	.vdisplay = 1920,
> >> +	.vsync_start = 1920 + 4,
> >> +	.vsync_end = 1920 + 4 + 4,
> >> +	.vtotal = 1920 + 79,
> >> +	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
> >> +};
> >> +
> >> +static int lincoln_lcd197_panel_get_modes(struct drm_panel *panel,
> >> +					  struct drm_connector *connector)
> >> +{
> >> +	struct drm_display_mode *mode;
> >> +
> >> +	mode = drm_mode_duplicate(connector->dev, &default_mode);
> >> +	if (!mode) {
> >> +		dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> >> +			default_mode.hdisplay, default_mode.vdisplay,
> >> +			drm_mode_vrefresh(&default_mode));
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	drm_mode_set_name(mode);
> >> +	drm_mode_probed_add(connector, mode);
> >> +	connector->display_info.width_mm = 79;
> >> +	connector->display_info.height_mm = 125;
> >
> > drm_connector_helper_get_modes_fixed()
> 
> Thanks for the hint
> 
> >
> >> +
> >> +	return 1;
> >> +}
> >> +
> >
> >
> >> +
> >> +static void lincoln_lcd197_panel_shutdown(struct mipi_dsi_device *dsi)
> >> +{
> >> +	struct lincoln_lcd197_panel *lcd = mipi_dsi_get_drvdata(dsi);
> >> +
> >> +	drm_panel_disable(&lcd->panel);
> >> +	drm_panel_unprepare(&lcd->panel);
> >> +}
> >
> > I think the agreement was that there should be no need for the panel's
> > shutdown, the DRM driver should shutdown the panel.
> 
> I'm happy to drop that if there is such agreement. Again, most panel
> drivers do implement that callback so I just did the same.
> 
> Could you point me to this 'agreement' please, so I can get a better
> understanding of it ? 

Quoting one of commit messages:

    It's the responsibility of a correctly written DRM modeset driver to
    call drm_atomic_helper_shutdown() at shutdown time and that should be
    disabling / unpreparing the panel if needed. Panel drivers shouldn't
    be calling these functions themselves.

I could not describe it better.

-- 
With best wishes
Dmitry

