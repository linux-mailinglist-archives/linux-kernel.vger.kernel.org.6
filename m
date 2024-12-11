Return-Path: <linux-kernel+bounces-441993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECB19ED690
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B041D18841FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D131C3F27;
	Wed, 11 Dec 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ae43oBNx"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E6259491
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733945726; cv=none; b=FjnJQ4gi5Bpx5+hq37xagFNMO7nam1He1LD6Ly7gsl6u1YJjHRylNDXXVU++c2l8wZBAeuhfjeOxGIKqyuwoZEvslfgpU8nnAjmkX4I4CZGn9d3ciwj/yiV+HF8QLqoA+7xDm9oLpWwh0wG0gHMhNjlzQ6YQ+3RztXKbkONlRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733945726; c=relaxed/simple;
	bh=GmW+qy/ktLawgnR58h1fi/TpOk7+UBvNzfXj3oihv2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rpl1D2KN0ryOCBekwZxorEnnllENVlf5j489+1MqCK8pMN40cuXdgJtS8B3LmuARSAHoMYtnOlEqInu0Yj4kMOKa8+8aZgwfnOMeisnDIYWbAqJ/QXtA+JfPWUz6+dJ2klr+s1zunA5IInw6zpP4i7K757RYtz5P8FVA1SlspuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ae43oBNx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c52000fso3697909e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733945721; x=1734550521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mlmxBycUGwX5pHsGKJE1We114Ns4Oa+/FIJwhXU3Bf0=;
        b=ae43oBNxC7ndfbqGsF7gcUES3PLk5hlT8mWWfEs4i+oEGmCcNBjJhY7ia2Lht1NCjH
         s2yHkumpHka3L+v5IzexBVEPiTQ8EY5UXHLEzo0rKbyNmsR9YAoU2p1BVsaqaPB38R1J
         g4rHrb2KGRFG4OD+SoFcpHxBIftlQew0bBXUZhGibmwlfkKpIPFzhiK1Tu1tMQcS51Sp
         Aum1Gz+ace4dTfdoyYdc0Afa45Vx126ZldcuG6BckAKy9A4ktQa+9GJblUS6syA+Fi/B
         OEAqzpADf1S/6Jes+w2fxFOUDPqm7KC8aX23Llzvr6bQUkd56uVD6ydRMHHsWxOrAO1d
         Ku0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733945721; x=1734550521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlmxBycUGwX5pHsGKJE1We114Ns4Oa+/FIJwhXU3Bf0=;
        b=OW9sb9yOz0d7IlKVttkx14mDMEOoa2rOLBUJTn0dAeBMrwIx4AQJeOzMsAXhVIxG16
         ox0z6V5nSpLJQii/xrqJCoiKqJY5dggcePuubsZSXpiYJT2C2yGGo47Y5GfT+9SIIRHi
         w3FOMyGvV8aNCCf8jcgASmwzKIZ5ziAA8ri50bRi/s1/ZgL73S0y38YQ4ripwQ65DuGl
         ZpynvL58N660q/W/FFY1pfwTxgkcJsJYqL6ArE/6UdVJoq39HsCgXH3wlawLpSCUBeor
         mjdXVgK18ZI1oEuo3qGtOp7Xm9DuHs5ogGEwEjr/uAz4fBOqpSf/2bTWYhPqrUhoOI6A
         xrPg==
X-Forwarded-Encrypted: i=1; AJvYcCVvs2ZvJ9PKO45BZOCDNmkOa05Kx3zDgve7LRFz3Q3dfyoT3UhdNSVqm/dsV2G5n2vuQ93cyIXK+nd33oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPaBqFuoiUvOFasiKjTrpQtao3BIKz0vR7Xt6/g1s5NSNQxaN
	+TB0Mk0ds++4I57lw3+lQOFnKZh3uyRMglzZXZVJE6UjaFDMGxRAfTqhz4WTHv8=
X-Gm-Gg: ASbGnct5CW1917Hze4yOhdYtLKxgF5MZsGNpXd+N3Oto6sDr4I8kLPANeSnAG0U92nK
	ulmqgaGGi9Mpuv9aQss6C5rrqzbeOB/ESx14eq/a9IxWkcLg/ifeVJnyZ//Auby1QpAps+XQJuq
	roGPNCnULMtdrU71ICFuuG2A2/XqudaWUsJVnDfz0kTzUNfSOVhLC8nVi65fjK1s/fZRPwNKAmM
	za6BeYMzA1v9bl00rWzrDS7EGRdy7wmxbomlEyqK6KuVMFa5UNiRgVB4DgZdt9tFvIRVrc/pULS
	hEIyzfr7LZafV+baZUjbW+h25MANclKMGA==
X-Google-Smtp-Source: AGHT+IFXG9kNop6Dow/dfMq9L/6cEoHmDiwAQOF9Wkw7NDsQvYPpji8SHNbXQPAGHwNjq9pSMY6jew==
X-Received: by 2002:a05:6512:1302:b0:540:17ac:b372 with SMTP id 2adb3069b0e04-5402a5eae13mr1520110e87.30.1733945720766;
        Wed, 11 Dec 2024 11:35:20 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c0d92sm2113398e87.171.2024.12.11.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:35:19 -0800 (PST)
Date: Wed, 11 Dec 2024 21:35:17 +0200
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
Subject: Re: [PATCH v10 0/2] drm/atomic: Ease async flip restrictions
Message-ID: <ouyulceg7zrnjirg2yf4qbgp5pfovz4y6hq5v6e573yx7ih5qe@uqqne6yq27wl>
References: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211-tonyk-async_flip-v10-0-6b1ff04847c2@igalia.com>

On Wed, Dec 11, 2024 at 12:25:07AM -0300, André Almeida wrote:
> Hi,
> 
> The goal of this work is to find a nice way to allow amdgpu to perform
> async page flips in the overlay plane as well, not only on the primary
> one. Currently, when using the atomic uAPI, this is the only type of
> plane allowed to do async flips, and every driver accepts it.
> 
> This patchset re-uses the per-plane function atomic_async_check() to
> this purpose, so drivers can allow different plane types. There's a
> `bool flip` parameter so the atomic_async_check() can do different
> decisions if it's a complete page flip or a plane update.
> 
> igt test: https://lore.kernel.org/igt-dev/20241211031820.115844-1-andrealmeid@igalia.com/
> 
> Changelog
>  v9: https://lore.kernel.org/r/20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com
>  - Add a 'flip' flag to indicate where the atomic_async_check() is being called from.

I think something went wrong. There is no changelog for v10 and also no
tags that you've got for v9.

> 
>  v8: https://lore.kernel.org/lkml/20240806135300.114469-1-andrealmeid@igalia.com/
>  - Rebased on top of 6.12-rc1 (drm/drm-next)
> 
>  v7: https://lore.kernel.org/dri-devel/20240618030024.500532-1-andrealmeid@igalia.com/
>  - Complete rewrite
> 
> ---
> André Almeida (2):
>       drm/atomic: Let drivers decide which planes to async flip
>       drm/amdgpu: Enable async flip on overlay planes
> 
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 11 ++++---
>  drivers/gpu/drm/drm_atomic_helper.c                |  2 +-
>  drivers/gpu/drm/drm_atomic_uapi.c                  | 37 ++++++++++++++++------
>  drivers/gpu/drm/loongson/lsdc_plane.c              |  3 +-
>  drivers/gpu/drm/mediatek/mtk_plane.c               |  2 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  2 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  2 +-
>  drivers/gpu/drm/tegra/dc.c                         |  3 +-
>  drivers/gpu/drm/vc4/vc4_plane.c                    |  2 +-
>  include/drm/drm_modeset_helper_vtables.h           |  7 +++-
>  10 files changed, 49 insertions(+), 22 deletions(-)
> ---
> base-commit: c40c32cf71b90d85386fcc066c19feb23eb42804
> change-id: 20241002-tonyk-async_flip-828cfe9cf3ca
> 
> Best regards,
> -- 
> André Almeida <andrealmeid@igalia.com>
> 

-- 
With best wishes
Dmitry

