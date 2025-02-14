Return-Path: <linux-kernel+bounces-514294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B1A35530
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CC93AC7F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200615198F;
	Fri, 14 Feb 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFH2ibma"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC714F9E7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502388; cv=none; b=oZZ9tqMPbYM6gQZ4CprEJJJX8qxHrY2hR5hhMvc+g50CY1Z/TdnBSjiPXY68Jq3SCAyvHAvVcB0nc3hEtUuw4qu5OxmjXjH8MXOfXfFAxA2Dv/JueVFnh2DYPhbigDUJLbHJ/G6LjsL2zD0yLnYCotRSYtsr8v7gR9H7JYFkktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502388; c=relaxed/simple;
	bh=0K/PTc71xjBZUApYX5o5uWwqga4NZP0tGvsckTou8oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPuIAH9U1qPKrfduRwtnrW03rNCBCN/L+V5fv33ezypA2x6+wjf2WB3zZ5nzQ09NZKz695XkK/dEthu8z5tHhJAU1jQ5qGieItMISl2D5GRhmVwE8S3lhyWczMORZ2HqAAsShgwUTu5al+/LOkc1Durj9FnB+irto8wClcl0x/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fFH2ibma; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54505a75445so1819572e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739502385; x=1740107185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=He2OIlDaNSIcCdHM62LGFcAoOxAi/2Xh8uAl3w+TWBk=;
        b=fFH2ibma+ySwscNfnmju3oPUNH8nzpbTq+fk6CVbBJFekVVuMjQemSj0aJtbZzvEyl
         mkf7Son33TfL8zTwC9o8GmcFyejyun9BgHI1kWyjaBQMp1PvjRq89XONstsIamN4ilRA
         E4NtKGCxAOyuWxj54zil9gmWvXnLlPoOQPIlFlXiSyOLwx5/rsdZb3Tt5oWzYAaD5Kpw
         tmWjHInjnomIo2jRolDORFyLJM5NFaV7O2vmyaj0da/fZHsBXkMWttwgUmT5cEzc5Ds7
         uT3XCifpOxTZXjlKAWAH68BJA/yi8TIeGwLI9NsIn2ShTvzHonWNOqXaPI2IbkFL3SIA
         vaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739502385; x=1740107185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=He2OIlDaNSIcCdHM62LGFcAoOxAi/2Xh8uAl3w+TWBk=;
        b=FSXyfzSQS8vSAofYT0o8cGa83JYjq/B7Hb7glDDdY/XnZEq6xftvkRYNEQ8MNjJSqU
         66Mnt/LR79aLGE16lYIjId2ng1udtTWbyCnOo7TRDSlnX4jO3WEL95UWkxtrH+spO/zd
         bAZyIlz8uzEerKsl2e8ipnpZP5JMWRSppGRnfkOBYC4ek/GrfUtvIKg0l2ryyrERD3g8
         Xo2vH4m9xpRllxZYMmHkyMlWqiVic/76oUo98X5pvs8ZEWuaKPlOVhkk6a22tBFpO6cR
         heFePFRGKCXYAJWMjhOkYGqdt2tDRyXeRkGHlndfDg5Af8PS7wZI5kC/sLQksRZ6Rlzu
         yrsA==
X-Forwarded-Encrypted: i=1; AJvYcCXeIERTxzT6mDxLIjpSXeKW9kbrlsAgFybH0mNgGSLze/ynDGwZHE3LQccQHM3MvLZmVY2G9Amg/hKQMx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsN9mkhZtjhSpVQo1nw+9V7UuK2j+JRhc0iBhBoA+NdwX5MNe5
	T8teGFM/FEVMj83T4R5y1MkYZGsDOpH/GjUO5NfHfP6QvABCT6rhmodUg0EMTyM=
X-Gm-Gg: ASbGncu4XGW5/RtUH4kBT0PnAyv3RrOmF2psskDwYy/Eh+eAo7kWJ29OLrlwBNt/uKm
	96LHFRvJyUv8LWLx6sQOmBjW9EE0xJSLpTQ5kCMnr/yI5avOELik8UUlf+l5EYAZ5e9/LkxK/zd
	4TglvSKzCTQRy+IPuwQb2M7rlYPzK0o+xkvddMHK4kWXZywVg85USPj9GFPgi0XuxaZAToeBfDD
	eOR4CXVBcextmtf7rzHdLhtVWQ26ZF+4dBkCRFXt2Xh/g/cIozmld36rSjA1Er03KX1FyHUoG6B
	pbbfaKWXvEBRVNV0Ty0phJP3Izol4u7PT875W8H7r6fW0JLQUoaB/mXvEYI3IgNvzDOf60s=
X-Google-Smtp-Source: AGHT+IFsXPcFopquxx1KRlpAtXCuAqVjlzWfUjGSA8wzv2ScYBwMsM/cTrSxeOJpapLYhZ/a6P9XGg==
X-Received: by 2002:a05:6512:10cb:b0:544:ee5:87aa with SMTP id 2adb3069b0e04-545180ea29cmr3055900e87.4.1739502384732;
        Thu, 13 Feb 2025 19:06:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11edbbsm358441e87.248.2025.02.13.19.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 19:06:23 -0800 (PST)
Date: Fri, 14 Feb 2025 05:06:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sui Jingfeng <sui.jingfeng@linux.dev>, Aleksandr Mishin <amishin@t-argos.ru>, 
	Al Viro <viro@zeniv.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
	Jyri Sarha <jsarha@ti.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, 
	Swapnil Jakhade <sjakhade@cadence.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Fedor Pchelkin <pchelkin@ispras.ru>, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	Vadim Mutilin <mutilin@ispras.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] gpu: cdns-mhdp8546: fix call balance of mhdp->clk
 handling routines
Message-ID: <nhklokfut4vz7ijfxdzy64qngzmdsk4ji3xq2nj2c6uhrvonru@tn3y5b4madyx>
References: <20250213112801.1611525-1-mordan@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213112801.1611525-1-mordan@ispras.ru>

On Thu, Feb 13, 2025 at 02:28:01PM +0300, Vitalii Mordan wrote:
> If the clock mhdp->clk was not enabled in cdns_mhdp_probe(), it should not
> be disabled in any path.
> 
> Use the devm_clk_get_enabled() helper function to ensure proper call
> balance for mhdp->clk.
> 
> Found by Linux Verification Center (linuxtesting.org) with Klever.
> 
> Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")

Please describe, what is the actual issue that is being fixed. In other
words, which path leads to unbalanced enable or disable call. Otherwise
it seems to be a valid patch, not qualified as a fix.

> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
> ---
> v2: Use devm_clk_get_enabled() helper function, as per Dmitry Baryshkov's
> request.
> 
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index d081850e3c03..d4e4f484cbe5 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2463,9 +2463,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>  	if (!mhdp)
>  		return -ENOMEM;
>  
> -	clk = devm_clk_get(dev, NULL);
> +	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk)) {
> -		dev_err(dev, "couldn't get clk: %ld\n", PTR_ERR(clk));
> +		dev_err(dev, "couldn't get and enable clk: %ld\n", PTR_ERR(clk));
>  		return PTR_ERR(clk);
>  	}
>  
> @@ -2504,14 +2504,12 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>  
>  	mhdp->info = of_device_get_match_data(dev);
>  
> -	clk_prepare_enable(clk);
> -
>  	pm_runtime_enable(dev);
>  	ret = pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "pm_runtime_resume_and_get failed\n");
>  		pm_runtime_disable(dev);
> -		goto clk_disable;
> +		return ret;
>  	}
>  
>  	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->init) {
> @@ -2590,8 +2588,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
>  runtime_put:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> -clk_disable:
> -	clk_disable_unprepare(mhdp->clk);
>  
>  	return ret;
>  }
> @@ -2632,8 +2628,6 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
>  	cancel_work_sync(&mhdp->modeset_retry_work);
>  	flush_work(&mhdp->hpd_work);
>  	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
> -
> -	clk_disable_unprepare(mhdp->clk);
>  }
>  
>  static const struct of_device_id mhdp_ids[] = {
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

