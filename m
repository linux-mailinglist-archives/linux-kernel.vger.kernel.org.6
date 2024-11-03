Return-Path: <linux-kernel+bounces-393673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CE59BA3E6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C921F2186A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 04:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272E12B169;
	Sun,  3 Nov 2024 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTo+YUjk"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304433D8
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 04:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730607050; cv=none; b=YzxaXmyonYbLPHtyF5Fp5U+fyNGJHkZGQ1wWE/qFDYOJsE3FfF++b9LnsPp78UkITB/eEwzT8NrkhThxQcpAjWOykQ97e4wg+IGof9jhQxpo6d4QmWdHpJXn3m4u3ZNkkJANsYWu2873uIjdJ2bMz5r3RbaF6OHqoFePk3oNngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730607050; c=relaxed/simple;
	bh=QdzYnp5F8fwiuUX2i3TJOg2PEx99+vmk2noVhRUIqQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njmyBJ5upFSFVKtnArCDjsDbNVa5N1ciSHeDqJiAhWe7rw2zMdmLUTxNnnFMftMdHP9NdiTGG9B+jZ10BwEkuOSPKs7pH5dJe5ncoluogyz74F+Mfj5/uakv/rl0d7Jv4vrtGFTffIKRfEEIARYquAQLsOSm+KB5gmsQM9Dhnpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oTo+YUjk; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539d9fffea1so3271967e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 21:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730607047; x=1731211847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oKjiI7+uYVjpcP4rbI91KyK4/aPOFwXr9jwYzxTPDbI=;
        b=oTo+YUjkLLAkP91p+oTieTb5DMabndPQkPIiZ/albjk/vy+B+R2lVXH8kgYmufdEz2
         Hiy4a0Szrn6aK6dvnknQdd0T6/zGBRw0fY/TBAL/6YQgeOrhrCG9ClsH+PHLxjabaukE
         +Tbnz+ytol2H3y7oj+hcJekUgmaoOCZYK9EovPVg0KgjjlRJgvdb4b8FJ7CCfRg4rgpG
         MUWJTHdSLiSjQwVPGsHqH4iEubiRNU+kVXY9ONt/7vwe44PkPbJ94w+95EBV54e+iI13
         vmlS+1yRBMKnhh37hk69mtLqovYKHsqjDQr3wp5rWwadQSndLZ2sg1DMeVjmLp3v4kwc
         PypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730607047; x=1731211847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKjiI7+uYVjpcP4rbI91KyK4/aPOFwXr9jwYzxTPDbI=;
        b=Yd3hVCkpaanVEMr1YXSKdLi7cahJFPTBkrjlTuJuLYd+hHCuW7qbTbUx5Vf4gnlztt
         YWLB2w+3MOzH5YuCSuAMg1pF1oKjJVbwDR9angX3ZhWjuhSF0Y4ylGDHguX2eJP4kNCG
         3gQRQWwHHmNxnufhjjYLIikz4AdTDwaiGyHKHYq4WvfzawEtPSD8coJVzhwLONLUPps3
         rgT382g7IkXUcFoA3HtwOONZgrov/BLemFWsVqGIt6qsRnbUEVCfDgYOB66NdEFs4f/S
         Wisu9niRBjDLLHjGdH3Tk/GRQoFUsGFUr24rV9gG+0vDWJqYngNuAeU11TvDO+BOXRHm
         ARKg==
X-Forwarded-Encrypted: i=1; AJvYcCVhxPxRF0ZcuzmhWR3l79TmwDVcPDW8Rqsw3fB8qcPKac40DoNz9aWRSdNAb35/EGhCl2heu5zkghy8rKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybHDniQG+VoRqkOl2wu7TQW7Ir7RcXyLYhwOWISDt+ykwTxtZ8
	hOQKMymKDQOVUJA/38NY9sqMt/u34XQ3JjLfEMZbFyfZsPF+Y8o50Gu74qRd4mU=
X-Google-Smtp-Source: AGHT+IH+dE8vbDtbk0g6KIFdQcvtei8xABv2NfChEkDMcDEuOiARbNNzwR5IRL8abnQAuzmweQTt3g==
X-Received: by 2002:a05:6512:2256:b0:539:edea:9ed9 with SMTP id 2adb3069b0e04-53b348ec028mr13441328e87.1.1730607046651;
        Sat, 02 Nov 2024 21:10:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc9598dsm1155053e87.22.2024.11.02.21.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 21:10:45 -0700 (PDT)
Date: Sun, 3 Nov 2024 06:10:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, Simon Ser <contact@emersion.fr>, 
	joshua@froggi.es, Xaver Hugl <xaver.hugl@gmail.com>, 
	Daniel Stone <daniel@fooishbar.org>, ville.syrjala@linux.intel.com, kernel-dev@igalia.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which
 planes to async flip
Message-ID: <y5vxaa3mwuhhrwn4etuxdvr6xemu4vprinp6lb75ch7a4amkdf@jajgfjczii7s>
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>

On Fri, Nov 01, 2024 at 03:23:47PM -0300, André Almeida wrote:
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
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Changes from v8:
> - Rebased on top of 6.12-rc1
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

