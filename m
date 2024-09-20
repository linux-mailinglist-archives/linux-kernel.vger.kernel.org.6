Return-Path: <linux-kernel+bounces-334303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B0F97D55D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA6928390A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BB14D708;
	Fri, 20 Sep 2024 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLn4nMKg"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E84D8BC
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835326; cv=none; b=iOYX3Sy+3t9ovU14hw5IqmnAPFVoL2BkKmB8nhE5P2z83Bgf7xiHCwgqLL/Om75h07dqBT6dHv3LIVWPJX5OXJOp58Nuux2tATSAKcXUTtOC/7vwp8Z9B8MO65Z6uQsbgKvbEMmVVqq8uYuK70dZ2OJdC/QMmtbTjUyj8asIZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835326; c=relaxed/simple;
	bh=iit+uR/WIxsccGlxObPp8Gkk13EhuR66ocl8pncYXy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy9ADGgB1vhYBmOBH+ZwcP0RXCpspOETTTVQ3F6uC9cYY+IooTHZk542ZR4SSaS25TI7MmWdIvP/ktpjLwXLMYQmWyMhdyomfsQEuaVE2Y4b8ZIwFdolhpPnsAZAnuZlppKCtIUW4oKqKPfms93bRxbWxcGZE1ljXkPPeFAsfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iLn4nMKg; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-536584f6c84so2685395e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726835322; x=1727440122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KmyYTSzJGsL/YMovQsb/XKINA9qbOmIqA08DqAcjnQM=;
        b=iLn4nMKgqixWlMa2bRdp1E0Vi2DgPDZ7GwLr+A3YUIBQN7voZADmyBsrDbMnaOrI1w
         +mozvdWdq4lu1/nDZxAUSZMCLUYQUnNEMruXqeLVpDlvJ129p4FhRHDjDyKukhrDjYz9
         UVHT7ITAth3QXuUX8d+fCZZSuCUAdm7MUnElo+YuyzdGymsCUflVAIivPanj0aC4h3Ve
         uctb7FjoiCrMY8tXImzJ/pn8jx/QoKnYIRF5oI5EYhblZi/gZqYOfjzW7ZMCmgH0Fit/
         qjNXP2+sK/qBow2704lHVcJWySrcTBLHHQ6EZqbro8xYbhoshbgupJ12CwHll2EPyZXQ
         SMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726835322; x=1727440122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmyYTSzJGsL/YMovQsb/XKINA9qbOmIqA08DqAcjnQM=;
        b=oyZKHAII2wdEfM8oFgtcKTgUNO20qgurQuxnrAW5lBWNPudUOF3UskqaRc95OSl2k2
         1fpljimbQb1d5822IZv+JS7V0Nqb3Pcv17x3unpksFZRbfg7dphGp2wRYFKb3QPHCuei
         1fSaOsvYVN9xtD6HsByMGnqB0DMiUWDc1VXZYwp/YhbeXOKhO5Yp8fK1bDnRW+ET4mE1
         iKxhXGOlJua/m0a6gHYWf+p+3trQhClNtBT3Q2I+IF1e6nQOP2iqp+6sVFdZntEpTxUY
         3NkL26v4M3JATgIvSVngWusQZfS0MB0QwTK7HwxqUi5YPxawVGhn531Lw2iKIX4buYqK
         MjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfGr/uP2fgWLPr8GiKu+b9NDXQ41Y2CqlwLK96eDgHRwLjTOMm64Doz2Dv200lF1xOJ1T6H3w/GOg5AEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlfCo0L4L3xRPZbvn/HxDFxXdxte8YAU7XyepgTqjO6HBdM81u
	bq0y6j2YX6jp28DaFBNRBTLSqOpfS0f4OSuvJOAzBRpJZGQbnh9DWwegFzAofrU=
X-Google-Smtp-Source: AGHT+IHqUCZSjDBGtSw+A8NmpVy9eKMCzlJUf0BJqZSjg4++cq0bIVZpdwJeTY8vMubkrtJMtyGRdA==
X-Received: by 2002:a05:6512:304d:b0:535:6a75:8ac8 with SMTP id 2adb3069b0e04-536ac2e5e21mr1760442e87.23.1726835321653;
        Fri, 20 Sep 2024 05:28:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687096993sm2149440e87.140.2024.09.20.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:28:40 -0700 (PDT)
Date: Fri, 20 Sep 2024 15:28:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, 
	'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, 
	Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, 
	Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH RESEND v8 1/2] drm/atomic: Let drivers decide which
 planes to async flip
Message-ID: <h2nyiovf5ixbqjrmtqcofmj6uwigcps7yjwfu67j3xdewnoj5x@fyu6ee7qjgk4>
References: <20240806135300.114469-1-andrealmeid@igalia.com>
 <20240806135300.114469-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806135300.114469-2-andrealmeid@igalia.com>

On Tue, Aug 06, 2024 at 10:52:59AM GMT, André Almeida wrote:
> Currently, DRM atomic uAPI allows only primary planes to be flipped
> asynchronously. However, each driver might be able to perform async
> flips in other different plane types. To enable drivers to set their own
> restrictions on which type of plane they can or cannot flip, use the
> existing atomic_async_check() from struct drm_plane_helper_funcs to
> enhance this flexibility, thus allowing different plane types to be able
> to do async flips as well.
> 
> In order to prevent regressions and such, we keep the current policy: we
> skip the driver check for the primary plane, because it is always
> allowed to do async flips on it.

Unfortunately this needs to be rebased on top of 929725bd7eb4
("drm/atomic: allow no-op FB_ID updates for async flips"), but the
approach looks good to me and it fits the existing API.

> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index fc16fddee5c5..8568c2428670 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -27,8 +27,9 @@
>   * Daniel Vetter <daniel.vetter@ffwll.ch>
>   */
>  
> -#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_drv.h>
> @@ -1059,6 +1060,7 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  		struct drm_plane *plane = obj_to_plane(obj);
>  		struct drm_plane_state *plane_state;
>  		struct drm_mode_config *config = &plane->dev->mode_config;
> +		const struct drm_plane_helper_funcs *plane_funcs = plane->helper_private;
>  
>  		plane_state = drm_atomic_get_plane_state(state, plane);
>  		if (IS_ERR(plane_state)) {
> @@ -1073,11 +1075,20 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			break;
>  		}
>  
> -		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
> -			drm_dbg_atomic(prop->dev,
> -				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
> -				       obj->id);
> -			ret = -EINVAL;
> +		if (async_flip) {
> +			/* we always allow primary planes */
> +			if (plane->type != DRM_PLANE_TYPE_PRIMARY) {
> +				ret = -EINVAL;
> +
> +				if (plane_funcs && plane_funcs->atomic_async_check)
> +					ret = plane_funcs->atomic_async_check(plane, state);
> +
> +				if (ret) {
> +					drm_dbg_atomic(prop->dev,
> +						       "[PLANE:%d] does not support async flips\n",
> +							obj->id);
> +				}
> +			}
>  			break;
>  		}
>  
> -- 
> 2.46.0
> 

-- 
With best wishes
Dmitry

