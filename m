Return-Path: <linux-kernel+bounces-340481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F6D9873F1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4638D1C22EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88854208D7;
	Thu, 26 Sep 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkueuIzn"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564B6EEB7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355471; cv=none; b=BfJ/VL5235gOX7BgzFTCd427W0sfGah5jMu5/MkG342Dk7HNci4AZi6o/JKQPjN021c3yki5odzA00HB2ItyEWFnZOetzI865p6PdZobQSLClGSXv88EhbK/L2O/Orv+LT1jUw2KxQMm5sfUKTAxXhwMpOomkjn9IpqbbLoGi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355471; c=relaxed/simple;
	bh=C5slDmCM2EqhuEIIb1D/SwFD1m21ZZ6gDIoZidx+nnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEY2mXs1xRCTuPuwAJnUjNIn/8aKLvD3Xl5D6yRcht0PkRPUOHD5B8udGu9mBxrIggrYOaIztbNgvhsEA212ZRGPcII22W6LmvJCYYDxTcfE3dbyYBt8hcKIIjaGIpuzTvLFOsEsv1TCaP5cZJKofdAnPsfAZhEqki6SRI6fgMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZkueuIzn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7ba97ebaaso10488431fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727355467; x=1727960267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vM4riqznf53XEshqaMI3LvYoXS/N4+2mM9WtOrWMb8o=;
        b=ZkueuIzniwKPg2tW8BdheWZV367oW8Hv5ROdW6QT4/LsFJYF99DEob8dF80EYXfuHY
         Q6X16Lkau4bRueoTIqrLl1e8iPmToM61rXvcXYaNAsd1QKMyyn2B1uoGp6BFlwUypgdP
         ShMQWtytSKrbjXZAW5KC6Rywsw25pGQQZiJBOL76KelraXv/jvXBSpfwTI2gifIvYn8g
         /yELp/7+guRQlNMC+PdQu7Ngh9Q3HqKeBRzeS13OOKKTclVBtOYMLiZ2Pm4oz7s//wRc
         WTDh91hrD2EhJ6QGDyReL+MH7/chAbfg9N38SoirKQ9bbIlySARL2lOOa7CPvcgH0BAY
         CZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355467; x=1727960267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM4riqznf53XEshqaMI3LvYoXS/N4+2mM9WtOrWMb8o=;
        b=IkpOVqZh6zCwhNDgfOw9M9YK4clqPQ9qLUB3y/nuo6MSSzJaw8iNXl9GGY9IK2tVFu
         YbhJRZWL8o2wHXUe+X3piC8zvEqUiZ8h23kYJorRwPcKnh14VDYsBMNpw4v0uGyx9Umc
         LCrqyipOGmhl/Y9Z0KCIpGMNuSbOVIOOfU1IvSMpKTeDsmDBqIfNRS9ZCKkphBigd3p0
         VnTiNoEcpPtS1/tg4VjUT/31K298NB9fRMpX9Ew5+oNXlAVZIUY/c2yejXHxDcNtrSr9
         HXv4uRaGk+mpo7ghUvoyQFWA3ZmsvO7GcqKPdHHPv0FnEXmPlVLWBtpBIa+M2gSNkDUU
         28Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVylMfzDyk54f7BqLK+n9g3pxGNs+zawOq+Zn7oeEz1PIHeBobu3b2Rrf4azDQMlE7IYc4QBxH429Gehf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lmjKUUkJCDA/LC4gJqSO9jQXgfikp2qj4EHxaH0+cKXeAWN7
	AbWYQMCKRDWTU5c7lgta+pEnslUfNDAn0L4afVCuKOS0S9b0TG2D/jLNTr18Bxo=
X-Google-Smtp-Source: AGHT+IGACxAZbt+YnAz82WrzOPNhqNGcFBiNcJqqzSjSkXYYarhKI+vR0hYRRNk/L+HWs70Vy0mDew==
X-Received: by 2002:a05:651c:1027:b0:2f3:a06a:4c5 with SMTP id 38308e7fff4ca-2f91ca6fb6dmr31821781fa.29.1727355467473;
        Thu, 26 Sep 2024 05:57:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d288e0dfsm7981491fa.77.2024.09.26.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:57:46 -0700 (PDT)
Date: Thu, 26 Sep 2024 15:57:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Allen Chen <allen.chen@ite.com.tw>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/11] drm/bridge: it6505: Add aux i2c functionality
Message-ID: <loulf3p74x3p6dinublo6xenwjoyssm2f5rk5g3env54abhath@37i4vlvxjn3f>
References: <20240926075134.22394-1-Hermes.Wu@ite.com.tw>
 <20240926075134.22394-2-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926075134.22394-2-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:51:34PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> Add aux-i2c operaction in order to support the MCCS function.

Brevity is the soul of wit. However in the commit message we appreciate
more details. Is it enough to get monitor control to work? Or is there
anything left to be implemented?

> 
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")

This is definitely not a fix.

> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 177 +++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 2 deletions(-)

-- 
With best wishes
Dmitry

