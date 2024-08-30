Return-Path: <linux-kernel+bounces-308945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AF966421
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D811C232CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECE1B251C;
	Fri, 30 Aug 2024 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsUEulbA"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC311A287C;
	Fri, 30 Aug 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725027978; cv=none; b=mC1PI2Bq/EXN0vW3S8CYngR/16icwxHsD5juJ8Kh1jdQeYXtb4yJCa/Inijmekmh1WoCtgCOpPMfgN5r4tabqzQR0fsuq9ohdj7ApQgaRjal9r7Ky57ItxJftrLxRnBpGYtIFzwdPpM1ykmlbmxfKdYcR8gXYJgIXqvoCLIm4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725027978; c=relaxed/simple;
	bh=/lxB6OM0MBV+zgCQ/1R66rLa9t2Xg5JuxvAWQNcvk9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG7Aeu3EU/QCopM0HttJwdQ3+e8bmnpyo/TM4Lxhwe/kTxVGT4STscaF4x2t26qxuM6l+Oqe+BPNd94JPrbeAV6RKJk4ZpNUx3p8bOlfzF61QSmdMMgYmMMsYWjwaU0MIAzrvldehaSbfyeyR0eHD12KkOjoXR+JXkL6CgYpFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsUEulbA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4568780a168so9010811cf.0;
        Fri, 30 Aug 2024 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725027976; x=1725632776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=164jGs/89Um/AnOtSvrzje4FuBBYrC6pESzJaoUHWtE=;
        b=BsUEulbA+4czh/Ym2h90qGvXW1H0xXujljo/y9SrmCaCRvbyuCMvXyUdmU5LR57NGE
         oDHBQ5hGQ7BBuw+DUvYYUGcpI5oAwiJFNtPdFSz1y4LINRDFSoR1MMI3VxmpNVQMkK6Z
         ugUSHWTcKZGMOsybzMyj1ONcb7jUxWBsC6hx1vkK5znDG+i53FquTNwhWZZZCQMbjXtR
         UVJPlsxQydZQq1cKC0bG+7eSExVmxXivXUyWlSjUS1cBWQ8uwZ9VX4+sZbBIkfru3ZF4
         iHwljdGBwpshpeuyOWfxIPHNluP1F8vFmewNsWBrBQk1OlR99fBAGSmQ8xxpE5BfsLV2
         jxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725027976; x=1725632776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=164jGs/89Um/AnOtSvrzje4FuBBYrC6pESzJaoUHWtE=;
        b=RqtByZ7JJSdQV7w1YCRRS8yM5aaXXjS6Ru9Q6dVd0Gze652Aeouv0O9bs8plVbKQ2t
         JZiKG4ksJpJ+pfIy0Z95HI6g0+8JkEzxZnX4AFzitRj08bQctHUDIpYx6ijdnIPTvR6a
         kGoX6MbSx4XlJRrEtsdF0qNhxWOJ+TCInBWvlVHoyHNnc1Kpvy52quL6IeF21onBxx05
         7KGbkjAZYMqlNuUlSSghxZRqkI/bL/wkWWPYUZkTT4qrBWMf8IIjXwHTHF+FSys88Jtv
         qwX+Lr3a8RbbBPSWygHTXbjpceE+XoDRB8rEGemI3oGG1fJpyOcfFtuXSgQtfz95TERO
         /wHg==
X-Forwarded-Encrypted: i=1; AJvYcCVCt+rI7CDCNZvssdx+YaByhsbjSBD/lv8Ke/il7GL7A8v6/m8MEHwsFTOCpHipomju6BFt9GMj+6yryH+d@vger.kernel.org, AJvYcCWq8zUZbwlsY4xvlF3V/GQ/sOjj2uRxwJuDzMls/VModgSjhrVaaHJLSl9Y++ty5t8sDfGSYhHmyz00@vger.kernel.org
X-Gm-Message-State: AOJu0YzdTx9ClkNMcN7vUyl+MKFLkAItIRL336ttp6zKGNyUJJV30RnT
	nEFuMoy8RjeI9GkIepGWTteA2ZToyKJlatwSupVra2RyU+Qhm13L
X-Google-Smtp-Source: AGHT+IGtqcgwB7aiUspmKw2bWDAFI8RK/cwOxSXe7Pj969PwCKlkOWWz/klTvLJp/wHKXlKwMNZbew==
X-Received: by 2002:ac8:7c92:0:b0:456:81d1:dfe5 with SMTP id d75a77b69052e-45681d1e484mr48660541cf.40.1725027975851;
        Fri, 30 Aug 2024 07:26:15 -0700 (PDT)
Received: from VM-Arch (ip-185-104-139-72.ptr.icomera.net. [185.104.139.72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c865fcsm13994151cf.17.2024.08.30.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 07:26:15 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:26:11 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: airlied@gmail.com, conor+dt@kernel.org, daniel@ffwll.ch, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, krzk+dt@kernel.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, mehdi.djait@bootlin.com, 
	mripard@kernel.org, robh@kernel.org, tzimmermann@suse.de
Subject: Re: [RESEND PATCH v4 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <xjimc7o6lgaivockfugwfmdsae6fm7hz2cd4nvvwkuavabjjkd@kvo4alvvoqzl>
References: <20240819214943.1610691-1-lanzano.alex@gmail.com>
 <20240819214943.1610691-3-lanzano.alex@gmail.com>
 <3c8359ae-9a12-41c8-9799-86de9024fcd4@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c8359ae-9a12-41c8-9799-86de9024fcd4@wanadoo.fr>

On Tue, Aug 20, 2024 at 08:53:07AM GMT, Christophe JAILLET wrote:
> Le 19/08/2024 à 23:49, Alex Lanzano a écrit :
> > Add support for the monochrome Sharp Memory LCDs.
> 
> Hi,
> 
> a few nitpick below, should thre be a v5.
> 
> ...
> 
> > +struct sharp_memory_device {
> > +	struct drm_device drm;
> > +	struct spi_device *spi;
> > +
> > +	const struct drm_display_mode *mode;
> > +
> > +	struct drm_crtc crtc;
> > +	struct drm_plane plane;
> > +	struct drm_encoder encoder;
> > +	struct drm_connector connector;
> > +
> > +	struct gpio_desc *enable_gpio;
> > +
> > +	struct task_struct *sw_vcom_signal;
> > +	struct pwm_device *pwm_vcom_signal;
> > +
> > +	enum sharp_memory_vcom_mode vcom_mode;
> > +	u8 vcom;
> > +
> > +	u32 pitch;
> > +	u32 tx_buffer_size;
> > +	u8 *tx_buffer;
> > +
> > +	/* When vcom_mode == "software" a kthread is used to
> > +	 * periodically send a 'maintain display' message over
> > +	 * spi. This mutex ensures tx_buffer access and spi bus
> > +	 * usage is synchronized in this case
> 
> This comment could take only 3 lines and still be with < 80 lines.
> A dot could also be added at the end of the 2nd sentence.
> 
> > +	 */
> > +	struct mutex tx_mutex;
> > +};
> 
> ...
> 
> > +static int sharp_memory_probe(struct spi_device *spi)
> > +{
> > +	int ret;
> > +	struct device *dev;
> > +	struct sharp_memory_device *smd;
> > +	struct drm_device *drm;
> > +	const char *vcom_mode_str;
> > +
> > +	ret = spi_setup(spi);
> > +	if (ret < 0)
> > +		return dev_err_probe(&spi->dev, ret, "Failed to setup spi device\n");
> > +
> > +	dev = &spi->dev;
> 
> If done earlier (when dev is declared?), it could already be used in the
> dev_err_probe() just above?
> 
> > +	if (!dev->coherent_dma_mask) {
> > +		ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > +		if (ret)
> > +			return dev_err_probe(dev, ret, "Failed to set dma mask\n");
> > +	}
> > +
> > +	smd = devm_drm_dev_alloc(dev, &sharp_memory_drm_driver,
> > +				 struct sharp_memory_device, drm);
> > +	if (!smd)
> > +		return -ENOMEM;
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
> > +	if (!smd->enable_gpio)
> > +		dev_warn(dev, "Enable gpio not defined\n");
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
> > +	if (device_property_read_string(&spi->dev, "sharp,vcom-mode", &vcom_mode_str))
> 
> just dev?
> 
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Unable to find sharp,vcom-mode node in device tree\n");
> > +
> > +	if (!strcmp("software", vcom_mode_str)) {
> > +		smd->vcom_mode = SHARP_MEMORY_SOFTWARE_VCOM;
> > +
> > +	} else if (!strcmp("external", vcom_mode_str)) {
> > +		smd->vcom_mode = SHARP_MEMORY_EXTERNAL_VCOM;
> > +
> > +	} else if (!strcmp("pwm", vcom_mode_str)) {
> > +		smd->vcom_mode = SHARP_MEMORY_PWM_VCOM;
> > +		ret = sharp_memory_init_pwm_vcom_signal(smd);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to initialize external COM signal\n");
> > +	} else {
> > +		return dev_err_probe(dev, -EINVAL, "Invalid value set for vcom-mode\n");
> > +	}
> > +
> > +	drm->mode_config.funcs = &sharp_memory_mode_config_funcs;
> > +	smd->mode = spi_get_device_match_data(spi);
> > +
> > +	smd->pitch = (SHARP_ADDR_PERIOD + smd->mode->hdisplay + SHARP_DUMMY_PERIOD) / 8;
> > +	smd->tx_buffer_size = (SHARP_MODE_PERIOD +
> > +			       (SHARP_ADDR_PERIOD + (smd->mode->hdisplay) + SHARP_DUMMY_PERIOD) *
> > +			       smd->mode->vdisplay) / 8;
> > +
> > +	smd->tx_buffer = devm_kzalloc(&spi->dev, smd->tx_buffer_size, GFP_KERNEL);
> 
> Just dev?
> 
> > +	if (!smd->tx_buffer)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&smd->tx_mutex);
> > +
> > +	drm->mode_config.min_width = smd->mode->hdisplay;
> > +	drm->mode_config.max_width = smd->mode->hdisplay;
> > +	drm->mode_config.min_height = smd->mode->vdisplay;
> > +	drm->mode_config.max_height = smd->mode->vdisplay;
> > +
> > +	ret = sharp_memory_pipe_init(drm, smd, sharp_memory_formats,
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

Thank you for the review! Will address in v5

