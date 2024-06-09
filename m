Return-Path: <linux-kernel+bounces-207494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A55901809
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 21:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9DB1C2096D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15BC446AB;
	Sun,  9 Jun 2024 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrjfdEUi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704418B14
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717961926; cv=none; b=ser05PLMrxGlNd/30CwZMuy2fyUD12Thhm80376yrCHzCDmRvODfEzM24jMoRoVS5SIUu1AT1VNkamhzzXp9/b06NUB/lxtOqNgrSx/qBOy8WPlwW46ftdyRJDyGairrk32NmtSRjcEaFjpdJhVQ5Ud/r3Az1w2XP2TyZOmSCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717961926; c=relaxed/simple;
	bh=7Co9P7eOY4NGJgNk6IY4rYXcNj4Y5wPFEiwIBYemaKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei1nSjveK0n73ZjKH3VvUzb8e3vcxYK6/ZW7i5UKDiZ3nvaEFIQWFx1nFIMe3iqcW2pC3E64eAUHidawHEbclvMBCGaC/HnVg6oagZJb6YGacwkMmPCGmEFvpPHP/xIBrQy7VEuUAqMWdKIY05KhGiKLsbejd0jKXyT7MkuPu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrjfdEUi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52961b77655so4152350e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717961922; x=1718566722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFG9zs+TOxLu+QRcet0jDU4W7tv1prViIcV9q7WG5hg=;
        b=UrjfdEUiWBCSvVCN5M4KJDCoajoOhLLxz9sGfDAg29oPrmYhJ2Lk/bHKJli8T7OY1n
         vGT2w5UxRbdAu8ExqlCyzQGiDP44PK7EcPTaLhzJRAsXKOtSSZE512oCftPhr7CI8r0k
         SutGvmWl7s/W8dXv1M7ac4BhwB7ZZFedB1x7GYSWkVsEt4ezv5ImBqP/EOqpRGOJZ+hL
         2s1bkYrk1IQqTCtzWvtMoTFgV85szm3LcA5QwUxAp0VQQJQZ3IEyinvKsRWVqHGeU5To
         xAUgYqY3VbUHaDomTaPzwtn2AuAKeO6RAO+VZ0YulyVSCEdLSQmnNiW1zAfzJUah7HKE
         D3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717961922; x=1718566722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFG9zs+TOxLu+QRcet0jDU4W7tv1prViIcV9q7WG5hg=;
        b=bhTEOG/ZqwVjCo8srSoIPm7BERsll43gx73NehQQbB7zitmvljl3Q3/oHJnYVuHTCj
         u8m1OjmxEOk2YJZ2/Biq36dHj9PTtGBJse/6sBWjq9yy+dnQEFEziyHBcbgdqXQWX/ZR
         BgTtjfSapCJL8FaSUuCQYAo9kZ2VNYdT4+2vGttfEiXRfsvI0dVKrxPFk6/htwPYQwSU
         MHMw1rqnRkOKgO29nYjHsdFKfE7hvRp+TP+JcF9rdRI6YEkYFPcPmYAFasBX7eGFubKJ
         ydWQ5V+9cjUn3IEGY2v5AGov0FjHkeIjSFsNql8nJIguYAirZqIxBRSWKevPpLocUSg1
         OP4A==
X-Forwarded-Encrypted: i=1; AJvYcCUhUymeEAZHEiIqrxdcFB0GKHDimMUf9Rk5CzzMbNXuc1gixi9F74IDMhetts5hi9g+AgosMUfo0fDVhNu1S2NOF65706AOsrrmEneY
X-Gm-Message-State: AOJu0YzFIQhsbhLrXbKsh0TxbA99AtDAW2s9vHOxYEEX+sH5EmAbhP2Z
	t14QhbxJclPtKblg+szEewwL/V4HQYNKvdpCbWIX++Q+Fyd89IL4Iwi0t5dzu7M=
X-Google-Smtp-Source: AGHT+IHSueJBRFGzWu+izXA3ywWeAfW1MkJMtWq2Trm5auscntgaCkFjmL0QP5uI/dfmwuEq2P352g==
X-Received: by 2002:a05:6512:2211:b0:52b:bf8e:ffea with SMTP id 2adb3069b0e04-52bbf8f01c6mr5065732e87.40.1717961921651;
        Sun, 09 Jun 2024 12:38:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzbgq2gvv5-kpclzt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a04:adb1:631c:fd0c:1269])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41fa022sm1286759e87.118.2024.06.09.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 12:38:41 -0700 (PDT)
Date: Sun, 9 Jun 2024 22:38:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Allen Chen <allen.chen@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Hermes Wu <hermes.wu@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: it6505: Fix potential NULL dereference
Message-ID: <vk76z5x3al6rrzb3n2misu6br4fbmc4kj3agyo4ry5fz7ajsm6@dfpq5yzuolvm>
References: <5e6e8882-478a-46c0-9119-b643d524cc0c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6e8882-478a-46c0-9119-b643d524cc0c@moroto.mountain>

On Sat, Jun 08, 2024 at 05:21:08PM +0300, Dan Carpenter wrote:
> Smatch complains correctly that the NULL checking isn't consistent:
> 
>     drivers/gpu/drm/bridge/ite-it6505.c:2583 it6505_poweron()
>     error: we previously assumed 'pdata->pwr18' could be null
>     (see line 2569)
> 
> Add a NULL check to prevent a NULL dereference on the error path.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 3f68c82888c2..4f01fadaec0f 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2580,7 +2580,8 @@ static int it6505_poweron(struct it6505 *it6505)
>  		usleep_range(1000, 2000);
>  		err = regulator_enable(pdata->ovdd);
>  		if (err) {
> -			regulator_disable(pdata->pwr18);
> +			if (pdata->pwr18)
> +				regulator_disable(pdata->pwr18);

Wait... I wat too quick to R-B it. The driver uses devm_regulator_get(),
which always returns non-NULL result. So all `if (pdata->pwr18)` and
`if (pdata->ovdd)` checks in the driver are useless. Could you please
send a patch, removing them?

>  			return err;
>  		}
>  	}
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

