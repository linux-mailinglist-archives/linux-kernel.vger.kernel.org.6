Return-Path: <linux-kernel+bounces-263967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E5393DD4F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 06:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0DB5284940
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34817578;
	Sat, 27 Jul 2024 04:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aytHwZZ4"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF19179A3;
	Sat, 27 Jul 2024 04:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722056008; cv=none; b=smUa9N9UDFUficlRz4+CpVBNcM7PXtQ1buMc7ndMJAq97mea5xS6XA7TinGlmKIFsULLkAHwlX5TQDMLXzHoiHyJZRvdDZjfq+DzoPsglT1pT1+zeXdp8px2MiHTEuCQfpZ+YW9CvriaGW715AMpUz+IWzH+/Ycn5A/3e4vpSdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722056008; c=relaxed/simple;
	bh=pgiPRRJUaV9SjkhMKXzS4wezm9EHUXOuv9yYTdI+UmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIP0uxZMv9yDKCv0JEVfaLF1QSzEAwPayceqoIw97JjyFkSy/ZeMku4RCkKXl0OFk9zDyfuEqjnVB8BFeWGI9B6nqg/ozX8JSys0u/ZdhJtletCGwM+z84rkAcOmdR7g6QiqC4NvaF0MBZhwmYBe19fH6icjXkmNeuxzda3ZT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aytHwZZ4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45007373217so3602951cf.0;
        Fri, 26 Jul 2024 21:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722056005; x=1722660805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JoHvCQISoMO0jbID3CnOp2mPsYkKhaCyec+InY9TAy0=;
        b=aytHwZZ4KxyXllKKLG3ykzCNh7W+ZwA70y6UqzOM84b9SXIfrE0MIBhmxFbILd5sey
         +sXGmBYAhD4m5dMeHMVqCQsEFfCmtaZprVVjaz9A4ywbJ84RkCX8gozkuFWuw+dHHETX
         E8p5IL4gnelIYNrsPCFDMcM0bUEoJtPmsGVKrK/MwHVBYiN6GSbnOJ/rEKGtHOqKCG3g
         OmkzEjZ2RJbMgTcETAzh4W6f14/4pWHzzwZhQngQ/5DlI6Lp4DxA4Jrcnnb7Xs1H9peo
         m5RmCaYnNynypm94rD1ELUa/k8xJAqXn0OlHl4QHvbl9xwQdVYMM6LoXyYKuQXwvn1Ew
         hxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722056005; x=1722660805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoHvCQISoMO0jbID3CnOp2mPsYkKhaCyec+InY9TAy0=;
        b=rPnYXIpeQzAxvJG9FrOLxm+ThvbyeVmjInkZdR4qwf1uDTht1oWZi6HK5SZWtIFawp
         KZbxRynDgUo1zwW4s56m9Xp6SP9n4RB37bzHzhQg9dvOKCwD81MleAIb01xfaBBJDsJU
         eKJGWvJq3/mxAA/Zrq7TJu5buXmA2o7XlV7g/74+CGMvZE7xy4zS5qI7yByVeU4K4rM2
         GNF03WDBLiZoiHKn2BYoKLMDzDqGfJ+RQOFkMTtmicZvLPmvqFPEvBH8wFAr1dYz6fb5
         Vq5NmfKNi8rko2aJSwV8CY3trfQZSUgQiXKX2A0wPyn/PiLOvw65JymVHqe3rIzmIVFn
         YpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEJqTty3wYIkPax5qGOu7NLq+kpvb5SwIFdNyRG+ztUL+wdyP7w7x11r5WC7dhNmIF8gVUXTzzFlU27Y4Lth8c7Mm0gHsc4pfkajkC758ONjbQ4HyN/f+R7g8gzXmDhVsJsXNTs0AFWg==
X-Gm-Message-State: AOJu0Yy6O2ujqk1H6HJOS5KAIZWmh+iVGlavjrlGe45lkyZY5WWAdwtr
	JXW9xOXa6manQBLZXz4iXunidszIjR59Rt8fykJpZBnknRVPRiaH
X-Google-Smtp-Source: AGHT+IHgKMHItSUW5b8p2u82vxwhU+uTxRq9zCuPuZHmPXk9q8DY/riQxocG/OowM/5gV/MidyyZ9Q==
X-Received: by 2002:ac8:59d4:0:b0:447:f292:e4b5 with SMTP id d75a77b69052e-45005adcf0cmr34045901cf.9.1722056005009;
        Fri, 26 Jul 2024 21:53:25 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe820092fsm19366981cf.60.2024.07.26.21.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 21:53:24 -0700 (PDT)
Date: Sat, 27 Jul 2024 00:53:22 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: airlied@gmail.com, conor+dt@kernel.org, daniel@ffwll.ch, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, krzk+dt@kernel.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mehdi.djait@bootlin.com, 
	mripard@kernel.org, robh@kernel.org, tzimmermann@suse.de
Subject: Re: [PATCH v2 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <kmmxqakarwohqse7iomcqwsrns7lt5xkp23tfw6ftvmqwvkttc@h4bm3ttlhrsc>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-3-lanzano.alex@gmail.com>
 <0c759c38-eebb-4889-b748-3fd5925d0690@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c759c38-eebb-4889-b748-3fd5925d0690@wanadoo.fr>

On Sat, Jul 27, 2024 at 12:12:01AM GMT, Christophe JAILLET wrote:
> Le 26/07/2024 à 21:44, Alex Lanzano a écrit :
> > Add support for the monochrome Sharp Memory LCDs.
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Co-developed-by: Mehdi Djait <mehdi.djait-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Mehdi Djait <mehdi.djait-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> > ---
> >   MAINTAINERS                         |   7 +
> >   drivers/gpu/drm/tiny/Kconfig        |  20 +
> >   drivers/gpu/drm/tiny/Makefile       |   1 +
> >   drivers/gpu/drm/tiny/sharp-memory.c | 726 ++++++++++++++++++++++++++++
> >   4 files changed, 754 insertions(+)
> >   create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c
> > 
> 
> Hi,
> 
> below some other tiny comments, hoping it helps.
> 
> Also "./scripts/checkpatch.pl --strict" gives some hints, should some be of
> interest.
> 

Ah! Thank you. I'll be sure to use strict from now on

> > +static int sharp_memory_probe(struct spi_device *spi)
> > +{
> > +	int ret;
> > +	struct device *dev;
> > +	struct sharp_memory_device *smd;
> > +	enum sharp_memory_model model;
> > +	struct drm_device *drm;
> > +	const char *vcom_mode_str;
> > +
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&spi->dev, ret, "Failed to setup spi device\n");
> > +
> > +	dev = &spi->dev;
> 
> 6 times below, &spi->dev could be replaced by dev, to slightly simplify
> things.
> 
> > +	if (!dev->coherent_dma_mask) {
> > +		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Failed to set dma mask\n");
> > +	}
> > +
> > +	smd = devm_drm_dev_alloc(&spi->dev, &sharp_memory_drm_driver,
> > +				 struct sharp_memory_device, drm);
> 
> Missing error handling.
> 
> > +
> > +	spi_set_drvdata(spi, smd);
> > +
> > +	smd->spi = spi;
> > +	drm = &smd->drm;
> > +	ret = drmm_mode_config_init(drm);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to initialize drm config\n");
> > +
> > +	smd->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> > +	if (smd->enable_gpio == NULL)
> 
> Nitpick: if (!smd->enable_gpio)
> 
> > +		dev_warn(&spi->dev, "Enable gpio not defined\n");
> > +
> > +	/*
> > +	 * VCOM is a signal that prevents DC bias from being built up in
> > +	 * the panel resulting in pixels being forever stuck in one state.
> > +	 *
> > +	 * This driver supports three different methods to generate this
> > +	 * signal depending on EXTMODE pin:
> > +	 *
> > +	 * software (EXTMODE = L) - This mode uses a kthread to
> > +	 * periodically send a "maintain display" message to the display,
> > +	 * toggling the vcom bit on and off with each message
> > +	 *
> > +	 * external (EXTMODE = H) - This mode relies on an external
> > +	 * clock to generate the signal on the EXTCOMM pin
> > +	 *
> > +	 * pwm (EXTMODE = H) - This mode uses a pwm device to generate
> > +	 * the signal on the EXTCOMM pin
> > +	 *
> > +	 */
> > +	smd->vcom = 0;
> 
> Nitpick: devm_drm_dev_alloc() already zeroes the allocated memory. So this
> is useless. Unless you think it gives some useful hint, it could be removed.
> 
> > +	if (device_property_read_string(&spi->dev, "vcom-mode", &vcom_mode_str))
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Unable to find vcom-mode node in device tree\n");
> > +
> > +	if (!strcmp("software", vcom_mode_str)) {
> > +		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
> 
> ...
> 
> > +	smd->pitch = (SHARP_ADDR_PERIOD + smd->mode->hdisplay + SHARP_DUMMY_PERIOD) / 8;
> > +	smd->tx_buffer_size = (SHARP_MODE_PERIOD +
> > +			       (SHARP_ADDR_PERIOD + (smd->mode->hdisplay) + SHARP_DUMMY_PERIOD) *
> > +			       smd->mode->vdisplay) / 8;
> > +
> > +	smd->tx_buffer = devm_kzalloc(&spi->dev, smd->tx_buffer_size, GFP_KERNEL);
> > +	if (!smd->tx_buffer)
> > +		return dev_err_probe(&spi->dev, -ENOMEM, "Unable to alloc tx buffer\n");
> 
> There is no need to log a message for memory allocation failure.
> return -ENOMEM; should be just fine IMHO.
> 
> > +
> > +	mutex_init(&smd->tx_mutex);
> > +
> > +	drm->mode_config.min_width = smd->mode->hdisplay;
> > +	drm->mode_config.max_width = smd->mode->hdisplay;
> > +	drm->mode_config.min_height = smd->mode->vdisplay;
> > +	drm->mode_config.max_height = smd->mode->vdisplay;
> > +
> > +	ret = sharp_memory_pipe_init(drm, smd,
> > +				     sharp_memory_formats,
> 
> Nitpick: you could save 1 LoC if this is put at the end of the previous
> line.
> 
> > +				     ARRAY_SIZE(sharp_memory_formats),
> > +				     NULL);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to initialize display pipeline.\n");
> > +
> > +	drm_plane_enable_fb_damage_clips(&smd->plane);
> > +	drm_mode_config_reset(drm);
> > +
> > +	ret = drm_dev_register(drm, 0);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to register drm device.\n");
> > +
> > +	drm_fbdev_dma_setup(drm, 0);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> CJ
> 
> 

I appreciate the review! I'll get these addressed in v3

Best regards,
Alex

