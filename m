Return-Path: <linux-kernel+bounces-448294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701019F3E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39BB16315B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4431D8A0D;
	Mon, 16 Dec 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z43z+60/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957452AD11
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391677; cv=none; b=eRoKMSPlZZ6eKJUbsuwxCuEC7iwkAO4kNZ/VPH0aoZum376XMZEEjjiMHrNBjWMKmdX4kiOAuNipImM+6daWE06DAP6TFnH1sW9woFinmZ6caE75ZyEzOddjba4TBQOr66ufVLM0FqcARajs4H6UlhWW+VQBWfgtMgNWXMOQYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391677; c=relaxed/simple;
	bh=SrIfG7BvC5DbIwl9+ggDrilRfWnFR5anzuhDztcI6Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOZYWAgE/1eBXsjY8xEq3oTqdym3puGHhTWwsz1V7CsVWPHY7+H7Otk31Jxfzg8iVWWP6wtT2yXR394G7QFkG7Hgho1uOE9rFgMQKgHGrVambgxHd/hSBNFWkQLJ7Pgd8BFyfL4O6iZ8Yl4w8AX3r/vNhGR7w/DRk+W7SyxBDVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z43z+60/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-540215984f0so5322649e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734391674; x=1734996474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akfQP25JefiJ/TKw5uzaBdDihIUT/GOLadWDictxU6E=;
        b=Z43z+60/iID+K1MSaVYv7U6PvQe6FfQIcWfe0g8LDegTSgFizcZuyUuoIy6GhtOhLh
         Kbi/mn+q6mz0ZZliHsa56m0eKLq5WUoRBQAklQv/roXG8zzmA/Ogmu5FkSn4aqd6qUdL
         HCZM/3v0rsQcHl62bOiguYJtaeaDd6IqeVK4EYj+ZwFNIY1+cqyYc2G7yadwzT2vYLYZ
         YqNH4H4oX45mDbr0uBwIDeA6pyRR/W00royu84xbYlaZuNdk6hLRgE5ylSWrad9DNKTS
         6wxaHV6WCUOY2Lmp70w45HJ9ZvvP1YzOmQZNwa3JbI4j8srmmAkEF7KSoT+MQUAm5joJ
         V5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391674; x=1734996474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akfQP25JefiJ/TKw5uzaBdDihIUT/GOLadWDictxU6E=;
        b=V+GtmenyvcdVTwWj0NG+PSAqelxqyQSVr8V76vaO5ryx5Fl1vfroPFK/IfSZmKHruo
         fyCb/q3XVe1EwUDTs6YR99s8bz/Vx4pn2HRZpwbTNDLtG3BOGCYrUE8z87mxdnsuhRqL
         UnynQFo5LKAckGpS+V+4QTvRFmySLcdNPe05HUxaAbt6R/+ARC3iMRA9X7Y/weEsamOf
         zLUjqEytH/1fNB57rqO5tuM51/6PeVvn1Ill0sedTEqZ/xRSrHrng2/cT4tMaVawubyV
         eLHXYNWqFBfkL4CZiqdWaiRsz9vcCtk35T1jTCjlI+Q9YdgmFIJBQRu/FaLK0I4fQwCk
         A+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWTAsRBbWrrHIkOd7DdnQE2ZAcsUJWFWRIwre/mmhbcvWc22JeuUegd0HjJmrHPTYHyVTIw/s/6ahoqpIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tFnNXbRvUmoQRp7xKG39anOFaySwUJsRrPO7i7jd5nRc6Ske
	iQMVFWBLQjhv79L8xvkvQ1vNNpM1J+AM/poKsn/UIWhQl0mLhkNvhmBU4mIFMAI=
X-Gm-Gg: ASbGncvZ1LtMWDqU9Hmzvj2C5+bqz3mpdiM4fU+2fnqYxOGK2JG/dPA3NxIvRwxxbrx
	zgMyP0ZXdLdbGqzXGncGYrclxCr4NRN+82pLdgDX0kXRi+nTDom6MrQLSwYwPzgJgvoY0yrwDy2
	/92E12aKRSr5abw2INdK7cqjYMqu90b9UFJTwo79naBlGLwhlepqcRUsBAcmNgzM9MnyhFXamE2
	hIX9cyzL+chppqaQuhv+abEXzENXTNICMKGbU46FEa912CGJHAYQhTjXr6KHAo9crrM9/IlH77X
	ZFXt9fpjirQSgE8gRKn+0w7SuwWwUrKmqyh8
X-Google-Smtp-Source: AGHT+IHuMwbituYzpO/gqLrVnLgQvpnm7NvIBskKam1c0urWPpQ+JwfR+BJdSDwmwff6lC/CbAgOIw==
X-Received: by 2002:a05:6512:39c8:b0:53e:384e:13e5 with SMTP id 2adb3069b0e04-54090560b39mr5344046e87.32.1734391673495;
        Mon, 16 Dec 2024 15:27:53 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9945sm1011228e87.60.2024.12.16.15.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:27:52 -0800 (PST)
Date: Tue, 17 Dec 2024 01:27:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] drm/bridge-connector: Prioritize
 supported_formats over ycbcr_420_allowed
Message-ID: <c36o6ro5qqfkqipltlecb3r22d5k3xiqdt46rtl2gdyha7xtmm@l2ovdfono7np>
References: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
 <20241217-bridge-conn-fmt-prio-v3-1-3ecb3c8fc06f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-bridge-conn-fmt-prio-v3-1-3ecb3c8fc06f@collabora.com>

On Tue, Dec 17, 2024 at 12:54:07AM +0200, Cristian Ciocaltea wrote:
> Bridges having the DRM_BRIDGE_OP_HDMI flag set in drm_bridge->ops are
> supposed to rely on drm_bridge->supported_formats bitmask to advertise
> the supported colorspaces, including HDMI_COLORSPACE_YUV420.  Therefore,
> the newly introduced drm_bridge->ycbcr_420_allowed flag becomes
> redundant in this particular context.
> 
> Moreover, when drm_bridge_connector gets initialised, only
> drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
> the equivalent property of the base drm_connector, which effectively
> discards the formats advertised by the HDMI bridge.
> 
> Handle the inconsistency by overwriting drm_bridge->ycbcr_420_allowed
> for HDMI bridges according to drm_bridge->supported_formats, before
> adding them to the global bridge list.
> 
> Additionally, ensure the YUV420 related bit is removed from the bitmask
> passed to drmm_connector_hdmi_init() when the final ycbcr_420_allowed
> flag for the connector ends up not being set (i.e. the case of having at
> least one non-HDMI bridge in the pipeline that didn't enable it).
> 
> Fixes: 3ced1c687512 ("drm/display: bridge_connector: handle ycbcr_420_allowed")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 8 ++++++--
>  drivers/gpu/drm/drm_bridge.c                   | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)

I think the second patch in the series is enough, it ensures that
connector's state is consistent, no matter if the drm_bridge_connector
is being used or a normal drm_connector.

Nevertheless, I'd leave the final decision to DRM maintainers.

-- 
With best wishes
Dmitry

