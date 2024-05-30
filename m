Return-Path: <linux-kernel+bounces-195513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAAF8D4DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A310284892
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE55C17C206;
	Thu, 30 May 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RN2FEnIx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3021C176257
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079077; cv=none; b=LfrAmYh7CMbRzS8XY0N3eFVRXQarfnH5SHINaC1UAu7lq+GHvm+iY/0BzLrxxVxKdrmBy34GMBtvXkxUW4AedRyIV3/cGqOvtwA4hEhUvnN/VDAepsCNWtLcpujNUIc6Ef/sgEKx3m6BCmyzN5bePQOUvAWtt7qvPykx+z6WXTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079077; c=relaxed/simple;
	bh=3E5LoxECipLvfS2AgwSGX6u07NVAc3OVyjKRraCxLtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwjF60o/3kKjtZ7R+7idyBBPCLrcYw+Y49bWp2Met1f10lXBfRTMl6zH6aXBy+r1eVxutmnkkgNGfoIX+03NqgGi5NgiUkny+/otoVopILw6hID9yRVPejYBgImTOFDYEysBC+dALsEbujn6NtzwwV79CQcSA3qI3CaHngN/owA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RN2FEnIx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52b840a001dso137218e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717079074; x=1717683874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A05XxoAt0LbeaH967nkgJpVk8uAg3uaftb22v/uUOsU=;
        b=RN2FEnIx2dCUkcmviMo6oP/pL/0NYjmheUMJy4Pk8eqNqGZYMRt9ePp/biXLAu23wk
         xJazbOIvd17lVcZ7TaZJZ8vmQ7BxSR+q5K116QnF248hD7KCll4/CKCBLOkQytg7+QLs
         +RbRBocxqJg8UwamkAMRlRV9nA84/q2nU/o2OVDOJztmQAd7++dHVp9CKNS5BwL9m7nb
         5fW/O3lQ9TU9uhNCnjkjaoiywfDaMPX/fueuW19NCf8Hr7qUwYrv3nZ9kBIqh1MKimnx
         EZLD0K3iXVQsJhmBa0YRS917azA/PVD/LPDl0MY1QUOhfr1kwgqDaw11+YEe+w+iYSVb
         UpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079074; x=1717683874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A05XxoAt0LbeaH967nkgJpVk8uAg3uaftb22v/uUOsU=;
        b=aNH/Qy+J6wgb/vOg/9zRa2C5kP+n4rPNcEQEo+DGJHp5ydsYHKH85vGFc7HpgHA2zk
         29Ks503Aebn+na49HZFOU8AAw0cZxve104TMIYvCPnhwoR8CiZuYZIzuYejJvZlIGnp0
         GTDlWu8jTHaWlR/CQGcE7u0moLrSzIV76J02pyNE3EBays2MwOsHlqgansMEWIP97bRJ
         dOrCF1ICE4SIQWzTuWGdyoZK75H1Z6Jit5veO7Fdpljl+1Ah7vGOK6gztkC282zKOd0f
         RHv77zf2FcqxL6PZ9GKGy3Xfh8jczSeBLYG8nEz29IcpQSH/Vjsdfzm1HvvAZom+25jG
         97PA==
X-Forwarded-Encrypted: i=1; AJvYcCV8xulrcDUktD9IJJfsEtJwKyyMzdj13KCvRvjcRzK0TP38mDsKujncrJc0TjQn3PqyHl+l7aagMiV6KZKHZe4jeg55CbR3FnXX6/Zn
X-Gm-Message-State: AOJu0YzMIIzLIpkgIJQJTgsPBnekRYzjy9JIaWbc8h8Fr29QqQ0I5bJ3
	P1G838NLKOCAmTuauFiv0OjLokzVzwj9sY695IABtSY5yq/z7nu9aywojnkwE0k=
X-Google-Smtp-Source: AGHT+IF3IPCOHPkCufej0E3S4vIkJZN0bwr+uOjkvz4pFX2pYHg8b+tGuvTkupUA/Cc6jzgAiPesyQ==
X-Received: by 2002:a19:381d:0:b0:52b:8419:db27 with SMTP id 2adb3069b0e04-52b8419db72mr77706e87.35.1717079072333;
        Thu, 30 May 2024 07:24:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970c3343esm1600677e87.214.2024.05.30.07.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:24:31 -0700 (PDT)
Date: Thu, 30 May 2024 17:24:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	DRI Development List <dri-devel@lists.freedesktop.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thierry Reding <treding@nvidia.com>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
	Devarsh Thakkar <devarsht@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
	Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v2 1/9] drm/bridge: cdns-dsi: Fix OF node pointer
Message-ID: <mgl6dxypfj6mwzdj3l3xsb63vctxyoa3y32vuykzrojv5fuevr@akvrnmgdqwyg>
References: <20240530093621.1925863-1-a-bhatia1@ti.com>
 <20240530093621.1925863-2-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530093621.1925863-2-a-bhatia1@ti.com>

On Thu, May 30, 2024 at 03:06:13PM +0530, Aradhya Bhatia wrote:
> Fix the OF node pointer passed to the of_drm_find_bridge() call to find
> the next bridge in the display chain.

Please describe why, not what. In other words, please describe why you
have to pass np, no device's of_node.

> 
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index 7457d38622b0..b016f2ba06bb 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -952,7 +952,7 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
>  		bridge = drm_panel_bridge_add_typed(panel,
>  						    DRM_MODE_CONNECTOR_DSI);
>  	} else {
> -		bridge = of_drm_find_bridge(dev->dev.of_node);
> +		bridge = of_drm_find_bridge(np);
>  		if (!bridge)
>  			bridge = ERR_PTR(-EINVAL);
>  	}
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

