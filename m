Return-Path: <linux-kernel+bounces-513464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7EA34A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDA9178036
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB0724168B;
	Thu, 13 Feb 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dJcg9s0U"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508D28A2B8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464681; cv=none; b=ly1Sl5lmqrjLHdd1epIOqGz2ueFkP/+iGLZeXNjazTzUNA9pCWi4M/7NxPyt4GjOcoRZyzHGi3wbFP2Ev31nxAFlBMrJKdNzibTUoDIXLyjkZMNfhxGMlXsMVXEBZgJVQqoKDYYDuqO+nMVC3C3ImaBl2ydDTiIZoixbyEvHLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464681; c=relaxed/simple;
	bh=u69ZlDQN1aRduApNgy23RQ5UF70C+blD8tASjHVhGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na9o0Q2D2ufsurBY6iH6xyWAmEhqGgjxTi86TZSIB/LftOdiD5ZvQn7ffR6lqUyA2ZP43zCzHxX0jx7d6lriWYXg3gqu7gChQFydT51xCXzMkmYfPUc+hsobFACnXh+mAxch7JRxstLTxDxv2iTSAWb7Hy8EUBo67W1fgHOxhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dJcg9s0U; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-308ee953553so12121381fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464677; x=1740069477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2OJO2GugyrIDT84GECqN9j4PJ39hKLweHZ/9c9DZPE=;
        b=dJcg9s0U1tlcUs6IYt9MJ8vKCUaBOtkDygnSZjVFjtN8R9S+dEDYazt4I8uUyXPXWH
         EM2CUN7cqQtxprKKP6Tcr9P5dHp2RRglTB8EBnvXXLAw4K9GGjpJqN3PGy9IwOQItNjq
         gKBgOekHUHeoBjusFQZQajGgVkjsI9wzooPnmpCy5P3hfUfyIwR4XtFSVGOVronAe4kX
         eppb1imNZbEvFWrt2O9HA9ln/ABiKaT94gfHvFpLz7m9MpeTPoquVHa/PD2MyI7hVkrN
         PjPn3sgesHPTfsZs9+BCXhKWBbkQsJzpCLBNM1KJuSHGQH7baLcrqlQocKNl/ZpXbb+X
         ZjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464677; x=1740069477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2OJO2GugyrIDT84GECqN9j4PJ39hKLweHZ/9c9DZPE=;
        b=ajuhheVlUgbGnmLkjM6GNdFNW7tX/RitFNrzDM8ZivyX5I1EwFDjgTjT7aRQIQY/kv
         8q0IM1QIwZVM/WsSRwMPUvXNPfILFDo9O41Vq6Yr3EmieYL8VbCQW1ZQZa7ZbQJt6v8U
         vsrqylNPyzJ8ZcJXygdoCL4jgosGISGbOUUL1NtV/8vUU2rw03MwCHGc+vlWzScan5JU
         O8R+EXHecHuibLZEpZfdeaCu3B/m4a/cyE6QdNpIkzT6/1N+yE18j2CkSfSjatmD4xRX
         wadiHS5QE1voWzjtC02IjQ7do4RpLN2kfhMHP+nRsAvibrv2aBGiYSODO89KLILe3kTB
         7SFg==
X-Forwarded-Encrypted: i=1; AJvYcCVAYu8iiioR2VhUXoSNcJ8Ys+5OTACeJ1CXFCqERx+8QoGSTuKxIzlNAljOGHFKdQ9Q3ckdUYpe1p/byqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVUir8AwiO2Y+a8ZZbPzWl/D5QRaCz2PZClgVj0bWq8TVnBNZ
	9NI+nd8TJ/4YlYjKiNz6KLKkVBaGB+VcWVeLB/Ch3hHWEqu1aouZL/oJ3yEsDfg=
X-Gm-Gg: ASbGncuolv8Di9NDh4nL/8WUJ/6RJ1RwJWmE1o1O1c7bwByexKJ/MWxOTGK9vc2PKqB
	CXEGwUuffW5gl0Sm5s6l4x3Gg65Bux25PXPsBAZmTaLuqMOo6x1PRE5n/XQjH7eUqaU89GhrLlb
	tJnk3G13hVLIpDWD0Sf9GVJR3CP5yVoxLBzjbWx+xj1sbmOoK0IfUnpjO8r4qtMwlf7xxCStt3M
	jkleVVnABvGI2RTcK7NBZh6fV+iCIoRL+I1ok5sMMxfa2OsNUt7wnHtYdMEzMiXa7T/CH+QRRig
	zhOxXFaFEV0ILwAjyBCV9G04lUBcvch2twUFn016RdD0sAjiue+a06R3Oh4Jxkn8bkYnNQo=
X-Google-Smtp-Source: AGHT+IEYPr8PatrnM+bo756o01wElcjGGflpyRxlOCKGCeLdga6SpFD3q+R7NLU0ZfCSCaUqAuY7lg==
X-Received: by 2002:a05:651c:154b:b0:307:dc28:750b with SMTP id 38308e7fff4ca-309037c134cmr27597481fa.13.1739464677494;
        Thu, 13 Feb 2025 08:37:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100c643fsm2502811fa.17.2025.02.13.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:37:56 -0800 (PST)
Date: Thu, 13 Feb 2025 18:37:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 36/37] drm/bridge: tc358768: Convert to atomic helpers
Message-ID: <hydowq7gzniv4m2ynsswtn7iarh25gl6tvkpooflpq3dwck7up@ea5rudjawzrd>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-36-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-36-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:55PM +0100, Maxime Ripard wrote:
> The tc358768 driver follows the drm_encoder->crtc pointer that is
> deprecated and shouldn't be used by atomic drivers.
> 
> This was due to the fact that we did't have any other alternative to
> retrieve the CRTC pointer. Fortunately, the crtc pointer is now provided
> in the bridge state, so we can move to atomic callbacks and drop that
> deprecated pointer usage.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

