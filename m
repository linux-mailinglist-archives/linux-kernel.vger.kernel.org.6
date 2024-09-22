Return-Path: <linux-kernel+bounces-335257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FF97E32A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B21C209E9
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229842047;
	Sun, 22 Sep 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWCOwZpE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BC6AA7
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727036226; cv=none; b=AoBpsdr+64xubTgoMRjUrb7QS2fuynFK5GeJJKeieZMC7yj7CHlA3Ed69wydVhWZ66+DiciFii+R8wGNay5oVjPm/NQsnNKjGIBy691SmjT4y7e7cEvu8Kbm2CWMUgP7IxI8dtktrwlQTwyMzp+PQ73eY10jf8m4y0k1Nfq6PkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727036226; c=relaxed/simple;
	bh=xpECfuFEN0POXvwbbzH5exRNO4OcMp2VNZBl/5jPI4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+KBlMLNRiY8H1AJCmdPAVLGypezealsq4nCdcvjYU66JDv5Lw3ZdzZOGQY9+OuwJ+dEdDC4q+FSPDFXjMTQosu7qSERoEuGUDdii7Q9jZotQGd6ukr7DIVwKR8Onhjh8EnWcKyr4XypPFAesmCitSCF7/HPwCA3EJt10J8C8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GWCOwZpE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso5600645e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 13:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727036223; x=1727641023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32JmbOeLWknizeDqyICO+CUtTh+HIReNZDfCv2JDvmQ=;
        b=GWCOwZpEfBPM4yYlrsMnJRfrXzGTi+45/SBOvaSAjgrpe7M3KodbjTvRm4Oh+3eVOy
         BnDl/EbPQLdSV+rLCQxOHhGQRkNOVbnlDpYkdwIY58eRmGUkIF+twnJJ6v5HAt5o0TAs
         9XD/wNBS64797fV98pUmDDfAXtNWKZ2v+qmUvtWh/3/oX3B+OD3o5pJ5meBtP9V+CXWq
         THNly3DRlWb7Dke603wU/24IDjgvP8Mi0KfTqaP+fNkT8vgg5tD78W4X3Rdi9BXTz3am
         JGdW3muP8MwrHrYxlPqqt3mBRHxx2y+7Hrwdu1LrDGdKVezdyY9JDem6ZuAzx3ls9Pf4
         QZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727036223; x=1727641023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32JmbOeLWknizeDqyICO+CUtTh+HIReNZDfCv2JDvmQ=;
        b=P3Hosbu9NIEBhWhbzHf/42vGZGJblrAmSB7wRcUW4vJImkRVB1ZbrAkgzqHI1z4TWG
         Ou5rhVFa6Bhsf1cP7U7JI88jLonlsohaB7Zl3l2L48l33Yo+e/cHhpEQLm9Uz4O8GUl6
         Y6sv7Oyz1cWKKSJezpCSyyIfGXAsv/16KeMIwnbCPRawiKknV57aYHt/qzQIzpgJ4fyr
         qXnoMXMNk/9ZDxpBzjsixFWZS/2wM9bCPm1t0Kg1jbpKeJafgolHFT5SVj21peHrphAV
         VkZdirYPhutgZ+kymrLLb5tSm5VaYkD6ppVvNtbF3qc10PXhpYBOSDd0Uk38mKcIsXf3
         rm8g==
X-Forwarded-Encrypted: i=1; AJvYcCWyBkPH9mxKmVTopxE+BSTUmshipvcmSKk3y7HP21uTyyW5QC6REJ0O8yqqL+lKS2VaOs8Ua8VWSiK/LoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTV6YdBgQGm0JWFI+qV45fnpid7l3TnHw313k3QbN4tG4QzMQf
	dlLBvU+/3YFPojvPPhadEAvrKRfFFCVZzpLHLrxdYpmOW5X7+iKHZCYjGu+CSXfOVMAgyuL8vUD
	uaMQ=
X-Google-Smtp-Source: AGHT+IHIJ5Z1q5ftPWndXlf+WM28a7eu2ci+JGMAhIoMyc0Mok2MnFmmri/eOqRIQ4n8/dO3KPuJ6g==
X-Received: by 2002:a05:6512:b8e:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-536ac33f1bcmr5933942e87.51.1727036223101;
        Sun, 22 Sep 2024 13:17:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687096936sm3049380e87.150.2024.09.22.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 13:17:01 -0700 (PDT)
Date: Sun, 22 Sep 2024 23:16:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 2/2] drm: fsl-dcu: enable PIXCLK on LS1021A
Message-ID: <pkpza56m6a7oeuuq5374l27kgeyemhbsnmbswnuyurqzbqpek5@rxh3arxdw7ve>
References: <20240904115135.1843274-1-alexander.stein@ew.tq-group.com>
 <20240904115135.1843274-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904115135.1843274-2-alexander.stein@ew.tq-group.com>

On Wed, Sep 04, 2024 at 01:51:35PM GMT, Alexander Stein wrote:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> 
> The PIXCLK needs to be enabled in SCFG before accessing certain DCU
> registers, or the access will hang.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 14 ++++++++++++++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
> index 5ca71ef87325..c9ee98693b48 100644
> --- a/drivers/gpu/drm/fsl-dcu/Kconfig
> +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
> @@ -8,6 +8,7 @@ config DRM_FSL_DCU
>  	select DRM_PANEL
>  	select REGMAP_MMIO
>  	select VIDEOMODE_HELPERS
> +	select MFD_SYSCON if SOC_LS1021A
>  	help
>  	  Choose this option if you have an Freescale DCU chipset.
>  	  If M is selected the module will be called fsl-dcu-drm.
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> index 90cbd18f096d..283858350961 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -100,12 +100,26 @@ static void fsl_dcu_irq_uninstall(struct drm_device *dev)
>  static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
>  {
>  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> +	struct regmap *scfg;
>  	int ret;
>  
>  	ret = fsl_dcu_drm_modeset_init(fsl_dev);
>  	if (ret < 0)
>  		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
>  
> +	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
> +	if (PTR_ERR(scfg) != -ENODEV) {
> +		/*
> +		 * For simplicity, enable the PIXCLK unconditionally. Disabling
> +		 * the clock in PM or on unload could be implemented as a future
> +		 * improvement.

This decision should be described in the commit message as well, as the
possible drawbacks (e.g. power consumption, stuck picure, etc).

> +		 */
> +		ret = regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
> +					SCFG_PIXCLKCR_PXCEN);
> +		if (ret < 0)
> +			return dev_err_probe(dev->dev, ret, "failed to enable pixclk\n");
> +	}
> +
>  	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
>  	if (ret < 0) {
>  		dev_err(dev->dev, "failed to initialize vblank\n");
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> index e2049a0e8a92..566396013c04 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> @@ -160,6 +160,9 @@
>  #define FSL_DCU_ARGB4444		12
>  #define FSL_DCU_YUV422			14
>  
> +#define SCFG_PIXCLKCR			0x28
> +#define SCFG_PIXCLKCR_PXCEN		BIT(31)
> +
>  #define VF610_LAYER_REG_NUM		9
>  #define LS1021A_LAYER_REG_NUM		10
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

