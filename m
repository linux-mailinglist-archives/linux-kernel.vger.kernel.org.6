Return-Path: <linux-kernel+bounces-547683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAC9A50C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14FD16EEE6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E261253F00;
	Wed,  5 Mar 2025 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FPhu15DU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD271A01B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205883; cv=none; b=Ic9hpYzMqf7rEIYFxQHY3QOQNA4Af7n8R7v54SXTS3bii1Vj3c2/FOfNgndy5zeagf0izv1/l3jbZ/e8W5PF0/pZHNqwAwmP2MP6tJT1eNFpyT+IsTcPy4ku0srBYpLLV9f2Orynufc0UUYfWVLbKFzNdXIaHlROyNOUEWXTd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205883; c=relaxed/simple;
	bh=i56Kp/7rpP6Blw7KgzHiLn1lrTyo4DT2XMJtpPqXFeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFnKl6UF35AgpmgxHzatdy3R/KUm4BFR9BV3iTuobUkmJ4GTZU7hBqpqv3pnEhB8JrkI+/Megzu9tpGFzu+eNqIuzpOGAMWvcojaH+gqALiFGljNEZI2jkC/CuLBZ4uGHUbgH+4T5iVUURIIdRccSeb1wQUWKLawzdaF91TRGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FPhu15DU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54959d1a856so1447076e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741205879; x=1741810679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYOlyE/UtiCRh5jP6oKp0hKwGJoeA7m+6rQ+nW6gLRw=;
        b=FPhu15DUeVNEZdDNoTo6hXuG5YTC/BksKrgvXy7hunkr7c0V0dNkwFwzzLuGfH+uY0
         XbKd+eCznklhS3fqX6OZnpyeJzYRWPJuzZb99OQFsRJW49cICK1qOOLc+N9FZIZoHhs2
         21ifP6lwfD7IrMbfGhItgfLTpuY3dqAtDew/XG5TTjAbmCu0Jz18WxjlJSZMNm13WJTZ
         r8b4De/7rfIcnHGS/uK67l9G701moWw0km2IZDxXu2d8+lIYp06FpYa4c1bB3DqT63iW
         dcLgHIl/xCmvSshGLV8xT4OUsXX3pb2tEEU6rKzCPfg1BIgotGGIrsNhSNC9xfjUc7oU
         V7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741205879; x=1741810679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYOlyE/UtiCRh5jP6oKp0hKwGJoeA7m+6rQ+nW6gLRw=;
        b=ZSSFhKai0Vv5a6y771y8PkcmNCmkbvkw/l+mHzwqW8a6W3MgfXyru6bf6dmGktd314
         U17yWUzF2hjErfJQluBrS+2DTbBxk16o1NMmnoEa7xuJJM5RopQjC14nyyMPV7VyMSBw
         C33QxqMcPuTCrHpPNOhj8f5TgHwLYd1dZNC84sfOavLeYmIR+jbOQEQna1UoU9I+EXXx
         XWdpk+HrpKfa2blGhwQDtb48VehsySR8lwvv6n9OllCNiQVt0Ddu0WNX1AhM4e2Gb3Ck
         6RGaTr0YXx6do0hw1+V2gYVzdc/W07QNr5PSpIfTf1AjcGmcSP5FSisQkKwt/rKwQ0qn
         7SkA==
X-Forwarded-Encrypted: i=1; AJvYcCU1oG/fVniPpFJB3tZnyzchukxrNstRgFyUpCbOZSZ6LWRACZ2X7WhIi1YC3MXpO54gCEdoDtKZWFFyz1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhsqWr84QV7RNjy5Ld+H35jPjnHDg3d73P1cadkUpzIttbI37
	x8Kx5jozrqkYqWiC9sItQzITGCjQ55tR0UhSfTMHI+0Dzy3AaKl2Pr06An+30Xg=
X-Gm-Gg: ASbGncslfkPiRjkbayW3zUJEG06wuOQj2e/k98VsQOIX6Przv13Qaox6Od8S5ck0ZKM
	ZCRZTE65jys+QgW4epVRw3btE6q7nRyw5LJ/DwitHfKHBxgswGfndRI6IsYzhEUDqH6okDVmeX9
	V10WQ5MrryhdThPtKBA8cekHl6oy21RqlMkPSam8Gx2hHBYcm3IBS0evatUU3ecqGew8h1PTJvH
	GiBJn+m0nA4u+OuFU5zH7GCt/KzkoFiE268XjJi0RmLEmzI3oHfPz7oL2mKtY8mvXRyp08oTe0x
	nqyzE5O7RssQjKaEciKw7W7vJwpc+cvpv5gDwqcv0qC+Lp08COA+1sRw6Ae3NPhhA8dYISxa4iL
	OlDkccqHJe8hcCkTNquaaGr8J
X-Google-Smtp-Source: AGHT+IEIJG5E53l5u0CMWxtBFVzfwJVo6R2kbMyIYyOXI9lhhi/ulkjJEK8lyfcdv5sHAcoowToDaw==
X-Received: by 2002:a05:6512:3e08:b0:545:c51:4a03 with SMTP id 2adb3069b0e04-54984be6443mr272551e87.11.1741205879455;
        Wed, 05 Mar 2025 12:17:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495fde71a2sm1146106e87.248.2025.03.05.12.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 12:17:58 -0800 (PST)
Date: Wed, 5 Mar 2025 22:17:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 3/8] drm/hisilicon/hibmc: Add dp serdes cfg in
 dp process
Message-ID: <bg5yiyru6fqnm73qctgullgsdnywdnv2zbcy72mvglxf2uttp4@v2cmuekciqgm>
References: <20250305112647.2344438-1-shiyongbang@huawei.com>
 <20250305112647.2344438-4-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305112647.2344438-4-shiyongbang@huawei.com>

On Wed, Mar 05, 2025 at 07:26:42PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Add dp serdes cfg in link training process, and related adapting
> and modificating. Change some init values about training,
> because we want completely to negotiation process, so we start with
> the maximum rate and the electrical characteristic level is 0.

In the commit message there should be a mention, why are you also
changing hibmc_kms_init().

> 
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - add comments for if-statement of dp_init(), suggested by Dmitry Baryshkov.
> v2 -> v3:
>   - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
>   - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
> v1 -> v2:
>   - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
> ---
>  1                                             |  0
>  .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 ++-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 32 ++++++++++++++++---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  5 +++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 12 +++----
>  6 files changed, 43 insertions(+), 12 deletions(-)
>  create mode 100644 1
> 

[...]

> @@ -121,9 +119,11 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>  		return ret;
>  	}
>  
> -	/* if DP existed, init DP */
> -	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
> -	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
> +	/* if the serdes reg is readable and is not equal to 0,
> +	 * DP existed, and init DP.
> +	 */

Nit: A typical format for block comments is:

  /*
   * Something Something Something
   */

Please follow it.

> +	ret = readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
> +	if (ret) {
>  		ret = hibmc_dp_init(priv);
>  		if (ret)
>  			drm_err(dev, "failed to init dp: %d\n", ret);
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

