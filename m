Return-Path: <linux-kernel+bounces-189868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5898CF604
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0241F21152
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C65139CFF;
	Sun, 26 May 2024 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8EpIa2u"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D511A2C26
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716756455; cv=none; b=Xj4NVI6JmIsbMgFvoEjfsdaCgmMaI3VU6XIuP6dgTDJBtaBGU9FCNTQGPU9aXsWCYdEORVRDFcVPvnv5edn/+/NP4aWCgrQSxwSATxYrCWPBovvZPJATyXqaBmZ7LSfYaRCfVeJ+ojALLTz9lSzo2UtZV/u7bl8DtyYfQkJYe1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716756455; c=relaxed/simple;
	bh=9x8Powgupa5Ch2WCzTKMefreAqfem88tbowpqqCuY38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAC9fYtgWahn3cUhyN/htiZGPenucGsESfqK5F8VroYe/CMGa33H++Ma/gT4kLx4sj6LTUy+VXQfoKzny3wMp+3YANAFUMl8TWa6tSdoxUvy2vmvv4f1vnXHv7aoe6WNqDZVfQB38LcM1Z5rTrddb20WnDQoH45R+yquDkDLmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8EpIa2u; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so82842361fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 13:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716756452; x=1717361252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUNdaUpczqWjYKFL6mjsCYM10st8i6fklZ84b9FNQNs=;
        b=B8EpIa2u1azTHTw+BRhzrVlcX7ix8miejORHFu81FmWIrn1g9ZJy6UX2pNt2iLdPuY
         9d2b1l+AzUwsxTm0vK645SalboMN1N7A3uZYOk7ANcSUMn2XZty7jGVH1Z/QOVSsAGxw
         lG4Y8jfywdt8X127qKec8Wy9lsHna1qnhh/8yBLsaBETVhNIf0/CSPHQre/dgKJZcp0N
         Dn5zInA3OkpHcrIErZjkuGuLgOLSfNydOWQNdDIM8/P6kgfFROfAqDU5e2N0itpsyZYP
         WoadnkS/FtloN159WswzogmuLXug1gczS4sGrIqCjlPtJwCc37WZoubii5+qP5CdmFkD
         cVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716756452; x=1717361252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUNdaUpczqWjYKFL6mjsCYM10st8i6fklZ84b9FNQNs=;
        b=u1X6Uxp/Rzkgu+tslfaszeSb4uG4mY7eftVtpCKn2f92xusXz9NH6ethXG0RKkq5Pm
         C6zuc0Gsa77/0zWKnnGCybfs/s7FYjl5eW+A+80pv2HKRyLF/pKEKhpc9wQaSTWA94K1
         ZjSaBg0p4rB64lqMWZPWfF5o7PUVzceSrQ1SzuSVCNBrG09PDEXOSaGfb1/TlrtEnYrv
         Qd0wACIs2LgBliN6XutGs2Pn7FLmbrJENO4Q8Kf2HFRwqdHSMFbqi71E449HEos2ZFct
         98vYAkURuJTpAsiWIhVJIxVczy7FtotP9lQIQiX8MaKnpAGkiJGXxsdsLM/iRxrowBgS
         MrYw==
X-Forwarded-Encrypted: i=1; AJvYcCU7nRc6oNPJiW8V2NsisaxeS4ySWXySaF2Uny6CU+SUS+FMBTy9dDew+MjpUZiR/oG5wSBG2MAdx9j2kqljL+6XK37x1mwqtbVeequ2
X-Gm-Message-State: AOJu0YxLxtHX4j7DUdHbr4oMPeILDSxwYtza1Kh/Un+oHwn/S0Ja8AFl
	aWZgyP22XUPBnMPxRBwsyqrXY6y7WxW7QmBMMbskMCAvXln2WhP9XIIQt5qNM3s=
X-Google-Smtp-Source: AGHT+IEEXhwP+qIOwKK1tFTRNk3B1C8k2M0WmwWkOiqLG+CYudMn2XQVaIgWUbkjv81/5YhQq3lqOA==
X-Received: by 2002:a05:651c:2041:b0:2d3:4b73:7b40 with SMTP id 38308e7fff4ca-2e95b1cc4c6mr46374631fa.17.1716756451582;
        Sun, 26 May 2024 13:47:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4962sm15862611fa.11.2024.05.26.13.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 13:47:31 -0700 (PDT)
Date: Sun, 26 May 2024 23:47:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2 1/3] drm/loongson: Add a helper for creating child
 devices
Message-ID: <wupp3362ym5nkemlry2b7nmnj4gu5mfnjtry5vznn2q56uwpew@topd2a2uhw54>
References: <20240526195826.109008-1-sui.jingfeng@linux.dev>
 <20240526195826.109008-2-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526195826.109008-2-sui.jingfeng@linux.dev>

On Mon, May 27, 2024 at 03:58:24AM +0800, Sui Jingfeng wrote:
> In some display subsystems, the functionality of a PCIe device may too
> complex to be managed by a single driver. A split of the functionality
> into child devices can helpful to achieve better modularity.
> 
> Another benefit is that we could migrate the dependency on exterinal
> modules to a submodule level with the helper created. For example, it's
> not uncommon that some exterinal module will return -EPROBE_DEFER to our
> driver during probe time. KMS driver has to tear down everything when it
> receives -EPROBE_DEFER, the problem is that it's completely not necessary
> and rising cyclic dependency problems if not process correctly.
> 
> Add the loongson_create_platform_device() function, which allows the KMS
> driver to create sub-devices for it. The manually created decice acts as
> agents for the principal part, migrate the potential issue to submodule.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/loongson/loongson_device.c | 42 ++++++++++++++++++++++
>  drivers/gpu/drm/loongson/lsdc_drv.h        |  6 ++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/loongson/loongson_device.c b/drivers/gpu/drm/loongson/loongson_device.c
> index 9986c8a2a255..b268549d643e 100644
> --- a/drivers/gpu/drm/loongson/loongson_device.c
> +++ b/drivers/gpu/drm/loongson/loongson_device.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  
>  #include "lsdc_drv.h"
>  
> @@ -100,3 +101,44 @@ lsdc_device_probe(struct pci_dev *pdev, enum loongson_chip_id chip_id)
>  {
>  	return __chip_id_desc_table[chip_id];
>  }
> +
> +int loongson_create_platform_device(struct device *parent,
> +				    const char *name, int id,
> +				    struct resource *pres,
> +				    void *data,
> +				    struct platform_device **ppdev)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc(name, id);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	pdev->dev.parent = parent;
> +
> +	if (pres) {
> +		ret = platform_device_add_resources(pdev, pres, 1);
> +		if (ret) {
> +			platform_device_put(pdev);
> +			return ret;
> +		}
> +	}
> +
> +	if (data) {
> +		void *pdata = kmalloc(sizeof(void *), GFP_KERNEL);
> +
> +		*(void **)pdata = data;
> +		pdev->dev.platform_data = pdata;
> +	}
> +
> +	ret = platform_device_add(pdev);
> +	if (ret) {
> +		platform_device_put(pdev);
> +		return ret;
> +	}

Please use platform_device_register_resndata().

> +
> +	*ppdev = pdev;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/loongson/lsdc_drv.h b/drivers/gpu/drm/loongson/lsdc_drv.h
> index fbf2d760ef27..a2c6b496a69f 100644
> --- a/drivers/gpu/drm/loongson/lsdc_drv.h
> +++ b/drivers/gpu/drm/loongson/lsdc_drv.h
> @@ -47,6 +47,12 @@ enum loongson_chip_id {
>  const struct lsdc_desc *
>  lsdc_device_probe(struct pci_dev *pdev, enum loongson_chip_id chip);
>  
> +int loongson_create_platform_device(struct device *parent,
> +				    const char *name, int id,
> +				    struct resource *pres,
> +				    void *data,
> +				    struct platform_device **ppdev);
> +
>  struct lsdc_kms_funcs;
>  
>  /* DC specific */
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

