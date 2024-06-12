Return-Path: <linux-kernel+bounces-212234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D113905D04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3BA1F22A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231984E0B;
	Wed, 12 Jun 2024 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuN7W3G4"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70284A56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225106; cv=none; b=rf15gd4rYFvMDOLGhYnNmoIU3ve2oiBVGKYM/oIxFM6MRn6C9JJ9gDnVjz8i9InoqdKMP6/iJBRPEVxD4mMQuhBExzQwA8dpG3tdOn8L1yRpGJG7y2FIb98aW5G/1NYGzOrWSvYWWdCLAg/7wgNzLEr7auEdNUWEBl4y0scETLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225106; c=relaxed/simple;
	bh=LJPyVLxQz22AUgai1hBIZOsMe6oYq/Z01oyfjpDxA7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGlxI2bdVihDXcgVVVgm48r9rQXi59OgUiARpXcfmovkOlcFox7OUS0LfKwn+A3dVj3KKVJQOYIXJWZhdy2OK8vMD1iU/2cqdPwikrnwbvDexPds2i6isbfy0hzPpIfFQPV/3fxRy3ax6Y5IoOATeUZdlkW3dJYfvsN9Wi7Ir3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wuN7W3G4; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso2920811fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718225102; x=1718829902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SEA70tBJ4PwBkoOMmWe3ULbP4tpxOmjC5IUbkfsrBUs=;
        b=wuN7W3G4i0bEunh3Zn2kPsv7VQc1iBvgTbSiCi42stiS8E2JXCKbV9Dm9Q8z054he+
         sQsmB0E2mup8J3mbHo0rBC27WUBdyEqSIkp5ru8Tu2zRMGxl+L4UTNblN3iI/dXoP16b
         RNtz70s3raT8O3kUhbmw4+Sh9V1/6pFmGRlud2tzivjDawzwtQxDKt6KMuq/+xFanMii
         2TRMKVTZofHa0sLa9Ww8r+Md8vKFfxVPtUBXjFd8hHHGbmTIoVjPD5hcr1ZUbgG+tK8e
         ZFVypr+ERMfEvlzIX9SjI2MewHoC4ZUu3tgQ7JMUP4f+GtIZ8xOHZheVUuwPPRIeOKDY
         CXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225102; x=1718829902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEA70tBJ4PwBkoOMmWe3ULbP4tpxOmjC5IUbkfsrBUs=;
        b=XqRQe0ugcAyRKGvwnG9gHqsEyOEYUVjuCfRmZreDBYkhaQ7YVW5iTxAExZBfDL+LQH
         WWQyC936ynHnvHSTtmdWyTporIeFaKQiALYsAHDrLGDlsRrc4CYhhqlvPU1ySFlL2+8g
         dpbLXzxXp64CGyH9DC1oMJUpBco9xPFzgYZAlpYnoLhB8BtT2BCqHuUaBXYVqrSD8XX0
         KihmzN3OhoFb9kG5oy94/1IEuwMFdjCMqPlR3+QszFRHtYOUbKKcFv6u3fTZJFQfi+LR
         s+ShxsEzuOHIpWCt7jBSrphd4N1+MKZgUAqiMgZjDB6sy+Y1fvfuHlQRzXJQATcevCPX
         Flwg==
X-Forwarded-Encrypted: i=1; AJvYcCVefpzUgokhkjiOkm2RZtT/7JqvxqXlZTTvooOfixrm/mX3HFq3V1Opj4qTjy9L+hCczDsyS5dRVblDnqbDQxOzNrB4Mm+/EUacfIVW
X-Gm-Message-State: AOJu0YzPFsZRhw25oFo7L1DXK6Cjfmz5ijt5tDUK1vKQiJ/OpyC/UYwh
	DnfSC7Cg9PTGMOV2tM1v8B7fJEEjLDjOUM+DXNbTtRhc7rHRJgfUkLrJ6M8Us3I=
X-Google-Smtp-Source: AGHT+IGVRVhHEiIlwITe9DlEo5WfJ4Eof41I9EM1LQ/eq9af4QfavH0OfsPqZ0JOdpEI84p8RNKzSw==
X-Received: by 2002:a2e:9ed1:0:b0:2eb:e840:4a1b with SMTP id 38308e7fff4ca-2ebfc8feb43mr16792821fa.7.1718225102385;
        Wed, 12 Jun 2024 13:45:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebe4169b35sm16912301fa.135.2024.06.12.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 13:45:01 -0700 (PDT)
Date: Wed, 12 Jun 2024 23:45:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Simon Ser <contact@emersion.fr>, 
	Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, 
	'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, 
	Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, 
	Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Subject: Re: [PATCH v5 2/3] drm: Allow drivers to choose plane types to async
 flip
Message-ID: <pu4nawhvy52imqgpib4lx3s5lsbatmfrq3e7aa4zxfmewt6xrn@ki7woraegakt>
References: <20240612193713.167448-1-andrealmeid@igalia.com>
 <20240612193713.167448-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612193713.167448-3-andrealmeid@igalia.com>

On Wed, Jun 12, 2024 at 04:37:12PM -0300, André Almeida wrote:
> Different planes may have different capabilities of doing async flips,
> so create a field to let drivers allow async flip per plane type.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
>  drivers/gpu/drm/drm_plane.c       | 3 +++
>  include/drm/drm_plane.h           | 5 +++++
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 57662a1fd345..bbcec3940636 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -385,6 +385,9 @@ static int __drm_universal_plane_init(struct drm_device *dev,
>  
>  	drm_modeset_lock_init(&plane->mutex);
>  
> +	if (type == DRM_PLANE_TYPE_PRIMARY)
> +		plane->async_flip = true;
> +

Why? Also note that the commit message writes about adding the field,
not about enabling it for the primary planes.

>  	plane->base.properties = &plane->properties;
>  	plane->dev = dev;
>  	plane->funcs = funcs;


-- 
With best wishes
Dmitry

