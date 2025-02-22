Return-Path: <linux-kernel+bounces-526956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1229CA405A7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3DF702F0E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1E71F03DC;
	Sat, 22 Feb 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="foOLKw0v"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5B770E2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740202275; cv=none; b=mbJCGVxYN/LOV00w2MQ/6BYC91Q940ep+xNFYPHLDX18ofJhqaqYu9/tUDP2aa6mMlCcaUu+NBzNyxkmrLOsm5W2IjQ2jeKo7vpdBr8bDMabf2wGkW1wxqDQu72zILdRbdXaR/9cdhnUXKICrtnFc+xuGIQJ6h75AxdSZBX94DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740202275; c=relaxed/simple;
	bh=1xOMlQXZst5Mqc30X91Wh9vETl5AV5KJ9zxBHtL/SHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK2J1i1u7Aysva6MrWN/l3quvymnjes0WOAq28exkYHLhSsvxNeHrEwT6n/Es4QnHU4W1j+4Bun67BkUv2u2Nl9HwwAafQt0/RGT0p4jTH0R4fscpsGTx7bmSjy7HgTZvfsKi/EvH/091NNqH4PMbMtFrnso5sTjwjy0sSsektw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=foOLKw0v; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54622940ef7so3089315e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740202272; x=1740807072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=692t9KtSpJuDmEMvBMOA3yej/31QmD5LmR5dhTfFxao=;
        b=foOLKw0v4EZS6C583tkUBGDHkfYGmMsh9VoRZFPYVCd9n3Fz5RU7j39QZADGcrI5j6
         d25jBxuwWDvKlUY24SNeqjiPS7klmUrQOVc9voZiBCtIgJekFTmEsfF31E0IzTy2Z2FV
         s22t2CkrSs6P13wigPYz7bWgmqsyJRqs77PxGD78bnqdxr3gI5ZPSPH8QEc6C2cQKLch
         /mO/7cu+3anVuCYj0h3MRP4gtYflqdXA18W62kZDRb2Ru95VhKS1/RDs1V5k+Aj1w8CJ
         7vofa1gj+4jEEb7NKKebbsVNS8LmsULZtHWxhP4B9oQ+stGlsT9sHNgNgyX8pavtzXgl
         2FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740202272; x=1740807072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=692t9KtSpJuDmEMvBMOA3yej/31QmD5LmR5dhTfFxao=;
        b=vUmlxrx5KGPbdvFINrA84D/okiiT2L9RpZGjDk3drwET1VPkGg4KtGV3cSQ178e7W6
         HoDk9rzi1uIklmXPXWkCaibiNHUus7I1xeuaXL4oHt+vKtVh7+YFIJxQyJdILJDHvqUV
         l4UqjZrc5pMm6wnVhWXSN6ERzW2eDqxBknRl+VZMyBX9UW5fuCjQqRYbJkELhhl3Jrgv
         /TqpdeLSbJUxFplltACJV6pFhNx8rhlHd+RbcVQfiHnKl/TxwkI/N9uR6PL6ujGXR/m8
         t1OFvlRaKoQimIskcc8NpISIOZhL/9zVBL7EmaX9ZY2A07mpkgnZ9fU0lc8YN5QpNHal
         vC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhyDJYQrTqowFmA3QFpQZKd19SDdXP9tCz1w+AcdaG4o8KM/+fDe7hTXTp8hTUw8zJPxR4RfeyZzm5wTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dkyJHQjZrd/5EtW6aqtYBPRQxo1C/ENqFO/LrZgcmKY4d4MM
	c6pTTG3a9c8vIPNBbWeTjq8D2hZ1o3VSL8FnUdinD8TlDLIs+iCIbV8yNZUbkNA=
X-Gm-Gg: ASbGncvFvlTE1VAddOAJxX2nti6zRdjanQjAU0P2GAiEOs8RTnRZxzKKYntEkX454Ka
	sD6iuD5jClc94I1cbCzeYrHQk1+8JzKP1TkUBATXRGEc3DamIkjrIqax4JnuWkwU9cM98T7s6B6
	vUJFGoW0bV0vm4gFMn/RU9KBg4NSiHHM3B3d4Ti9iZ5QHbSr8dH+Imev8lqxiiYdEo5xJcQMvs1
	63ziA6T0EXVdrGgJYWOn2qjBub7crYRdEXf2WsTjzQdYeTgUz3YCsiJehHrjwPDNhTQ7n1BFlrJ
	LgI/XFiqm1msdUUT2zkqxiTBlUVYOoO1KT9Tnl/WJfqpWuKBWTkSNXxywKVDKOxV8BbVWpkHZB2
	nmvYpUw==
X-Google-Smtp-Source: AGHT+IF61Bc0IB55BcHXaBW8QvUMpJcyRRONQV/+7MbYnEEcLtLOL6ljiaBWgmGKtrQT36MElp7few==
X-Received: by 2002:a05:6512:239b:b0:545:10cf:3462 with SMTP id 2adb3069b0e04-54838f4e423mr2480960e87.41.1740202271699;
        Fri, 21 Feb 2025 21:31:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452ca28f47sm2431142e87.38.2025.02.21.21.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:31:10 -0800 (PST)
Date: Sat, 22 Feb 2025 07:31:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 3/8] drm/hisilicon/hibmc: Add dp serdes cfg in
 dp process
Message-ID: <d77bfuqor2rsd5tg4abywkckiqwy7j5xr43p73to2ofwpirws3@4m4g7hkvji2a>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222025102.1519798-4-shiyongbang@huawei.com>

On Sat, Feb 22, 2025 at 10:50:56AM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add dp serdes cfg in link training process, and related adapting
> and modificating. Change some init values about training,
> because we want completely to negotiation process, so we start with
> the maximum rate and the electrical characteristic level is 0.
> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
>   - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
> ---
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 ++-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 33 ++++++++++++++++---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  1 +
>  .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.h    |  6 ++++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  8 ++---
>  6 files changed, 43 insertions(+), 11 deletions(-)
> 

Mostly LGTM.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> index 812d0794543c..e0537cc9af41 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> @@ -4,12 +4,15 @@
>  #ifndef DP_SERDES_H
>  #define DP_SERDES_H
>  
> +#include "dp_comm.h"

No, please include it directly, where required. This simplifies possible
inter-header dependencies.

> +
>  #define HIBMC_DP_HOST_OFFSET		0x10000
>  #define HIBMC_DP_LANE0_RATE_OFFSET	0x4
>  #define HIBMC_DP_LANE1_RATE_OFFSET	0xc
>  #define HIBMC_DP_LANE_STATUS_OFFSET	0x10
>  #define HIBMC_DP_PMA_LANE0_OFFSET	0x18
>  #define HIBMC_DP_PMA_LANE1_OFFSET	0x1c
> +#define HIBMC_DP_HOST_SERDES_CTRL	0x1f001c
>  #define HIBMC_DP_PMA_TXDEEMPH		GENMASK(18, 1)
>  
>  /* dp serdes TX-Deempth Configuration */
> @@ -24,6 +27,9 @@
>  #define DP_SERDES_VOL2_PRE1		0x4500
>  #define DP_SERDES_VOL3_PRE0		0x600
>  #define DP_SERDES_BW_8_1		0x3
> +#define DP_SERDES_BW_5_4		0x2
> +#define DP_SERDES_BW_2_7		0x1
> +#define DP_SERDES_BW_1_62		0x0
>  
>  #define DP_SERDES_DONE			0x3
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index e6de6d5edf6b..67d39e258cac 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -28,9 +28,7 @@
>  #include "hibmc_drm_drv.h"
>  #include "hibmc_drm_regs.h"
>  
> -#define HIBMC_DP_HOST_SERDES_CTRL		0x1f001c
> -#define HIBMC_DP_HOST_SERDES_CTRL_VAL		0x8a00
> -#define HIBMC_DP_HOST_SERDES_CTRL_MASK		0x7ffff
> +#include "dp/dp_serdes.h"
>  
>  DEFINE_DRM_GEM_FOPS(hibmc_fops);
>  
> @@ -122,8 +120,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>  	}
>  
>  	/* if DP existed, init DP */
> -	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
> -	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
> +	ret = readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
> +	if (ret) {

Why?

>  		ret = hibmc_dp_init(priv);
>  		if (ret)
>  			drm_err(dev, "failed to init dp: %d\n", ret);
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

