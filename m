Return-Path: <linux-kernel+bounces-217260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B7490AD84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40C52829DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D735194C6C;
	Mon, 17 Jun 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUo3BhFu"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7249194C63
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625590; cv=none; b=iq68gdE+ITanxrV5z47vXeI2BrjA5q1kM818aY7olwIDUhyScngxN9OI3rkhHlDR65mjyWAXGJQySu3UDw+P42Vpv+KU0GtTREPSFWgQPX/3CZ5Sifk/g8cCJK1JkdFq4iNsYAumTHxwN6gN14umD4fDliyL/I7iRjRuR5DakaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625590; c=relaxed/simple;
	bh=cwjxyIgTtMF6ra8Xr6jQTFDq+OWaodUhAU4mBZlbqCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkfCYSiYe166nJeyosyhwAyemvTmZMamnOQKjnh3mvAPe/p3cDiSfHM7BuQMGIO8jz9mDT0CjUkscFdJ2ZtK9opwLLbSufwn0EFhrjd9cbwwsiVeIJbXWJ8cgJBcIk4fIpnW2rkCR14bgWS3a5tvk8XYM/qHqEncpTWIm3SapbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aUo3BhFu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so45180791fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718625587; x=1719230387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KXmCgiXbi+W1iA9MhwDCap2awLeCzu/ogu8EC1F34I=;
        b=aUo3BhFugoLgP9lylEcdCo+XDqhPdUNdwIAscTtmg9JLPdsbFwRhZZgFU6uZYoEhTM
         Qm0zzphgTqBfa+dt7tZfVMDsyEvOzHEENalFTzUmGGxHidDluONjjBw1pZSz8Gwp1kCb
         YkN8ySPrQylZOGiWmIdvdUj1ExK3sBoHWWbxKo/H5SOjQhulqUwxXkBnCxuZQFGa2gkD
         oVBoLcl088888fZQUGHzj1sNQFCYHVMOrUi3jCRmQE3drH/wErot0vK5C5BvMHI8eeim
         yN9WMfzfXPNZRrNvjwF93G28Ty8lHjgKs/OVnR11wcIDo4Zj134pV9YzzP8J1CAtf1nx
         PyzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718625587; x=1719230387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KXmCgiXbi+W1iA9MhwDCap2awLeCzu/ogu8EC1F34I=;
        b=hanSqyb2ednNg/+N4ovOJZ4AJfQjBPHe4wpWCLg3SZlFGbS6gZsPhkf4xy9dsOtew0
         9NlgOF3KrKfHpwh83+2eY22Hj6ZOE15HCKOnEHxFb2EwfSO9+FOF5bOz+fvig07+F9W6
         UEoG522ubeAw4nRbcyfC39QQ/PBcLTCkeygYtlpg1Y3gWfCBfBD3j3gto0ncuuXH50IK
         Awm2GU9kOCufTeSyliAn6+PT/MK4MsNDBrVB8obqhJQdsjN7vSGHnKWiqPjSAGQpkhk3
         pUkQN5fI6jBoknlYbcV964PeGmF+63SmFHnmTru2Do42jFk0MZU3Jq55OYqDkWa6s+00
         7V3g==
X-Forwarded-Encrypted: i=1; AJvYcCViA0aF2DhRB2Y9y0JhuymZDnQUraqJoY/+T7RTJJBucs+FCkmE9aWZecqDmGgZgLpFiR0E5eVfZo3lnfbYlmpx9xS6s1ie1D/z1lp3
X-Gm-Message-State: AOJu0Yytcg8Yt+8CoWlfGCFFKgdD3x6+ATXIsdW2XjacbBKOy4RvGfxZ
	Prum/PnozrxcgdqrF3QyOs0kJER+8eqM1FWMnyed62dq3/SFFhZeWNSTJhoEx80=
X-Google-Smtp-Source: AGHT+IHb0F1oY+avRngvVJAyvRtdtWw1Eah+FceAxdnQ2X+0t/BvA9o1+Qa1OfCxtGKD3VTd4vkpww==
X-Received: by 2002:a2e:9b17:0:b0:2eb:e787:47ea with SMTP id 38308e7fff4ca-2ec0e5c659fmr58540481fa.12.1718625586800;
        Mon, 17 Jun 2024 04:59:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec2fd3cf4bsm1801831fa.34.2024.06.17.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:59:46 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:59:44 +0300
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
	Dominik Haller <d.haller@phytec.de>, Sam Ravnborg <sam@ravnborg.org>, 
	Thierry Reding <treding@nvidia.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>, Devarsh Thakkar <devarsht@ti.com>, 
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH v3 02/10] drm/bridge: cdns-dsi: Fix the phy_initialized
 variable
Message-ID: <fyxer3rl54uq7qemgjx7htykgsnwgg5ywda2d5f4fhzd6ksjfg@blvkbzdy6op5>
References: <20240617105311.1587489-1-a-bhatia1@ti.com>
 <20240617105311.1587489-3-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617105311.1587489-3-a-bhatia1@ti.com>

On Mon, Jun 17, 2024 at 04:23:03PM GMT, Aradhya Bhatia wrote:
> Update the Phy initialized state to "not initialized" when the driver
> (and the hardware by extension) gets suspended. This will allow the Phy
> to get initialized again after resume.
> 
> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> index b016f2ba06bb..42565e253b2d 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> @@ -1153,6 +1153,7 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
>  	clk_disable_unprepare(dsi->dsi_p_clk);
>  	reset_control_assert(dsi->dsi_p_rst);
>  	dsi->link_initialized = false;

Most likely you should also call phy_exit() here. And in _remove() too.

> +	dsi->phy_initialized = false;
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

