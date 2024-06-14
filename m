Return-Path: <linux-kernel+bounces-215380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AE99091C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EBA28B1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6891A01C8;
	Fri, 14 Jun 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0bI5cyJ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787091B0118
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386385; cv=none; b=Yqca2xo5xTMcvW1yC+/OtVqMAYmV4c9Tu42aEGhXJukR2vXJKI96P9z5sWhhzOc6SHHAopn299aVXJLVViVbVshFZm3SoDuIgUlwOTTeT2Wo0STSdTXEJRkoQRXEwDXyfVS+Ufg2alFbNKsEz1ljNACwaVu2+DzjhMMfIlQ68eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386385; c=relaxed/simple;
	bh=5JfwGvXC3wQ1kOI8Zh+NA4+SfUuzSprZAy/CCQ3H0sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKWEj7zinPBV+qNBo0XMwWJmI7dLcBOzF0EGAoTL50xcYvGmYV4Lf9h3iAGTe2uxbGHBFJkOlKoXypsc3mpLF4N1uUbj6sEjh6WXTLVGMH8Q8cNI0tTwuMoImflsrh6LdHnMMumaZzCZMiBYl3hBzMN8QCbFTH3cmsDVCiB2Yo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k0bI5cyJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso24038181fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718386381; x=1718991181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6A2ldgCGRbiaAOg5pCXVmpJrxkciuNJ03uPiR1OSrWk=;
        b=k0bI5cyJ2RWxOTjr3j4LCy4mtrzAM7so5zwcCWFMg4VBkr2kmFAwaKAlFDUq0QCaoi
         gGAYCaveZxfLEVw5aVNaNds0zgf0HRpn7hgH5OG2zQ5rsn4ytzE2yq6xLB6hqMHj4QUm
         fqG0C4bq+c3jruCIh3JpdFZkizSZvMCLMAK+As1d/yGfzJDSf2uSXQ/g9C1HaOwRhWDo
         3vZeVr5K7veTuO4PiwAj+9kJTGOyi/a/zjeiEb1LrtV4QhXNUNNRg3YtaSokPm92PMPa
         3oSBQ0K3pm6nJf+jB6IpMJkTzM3gOCdiGGzgUaHyyZot75cX/YZujXaxZqoNF2ygWdxW
         vM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718386381; x=1718991181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A2ldgCGRbiaAOg5pCXVmpJrxkciuNJ03uPiR1OSrWk=;
        b=UdWIgFiU76CT8e8EZrVHdo0otdYCqXAEpwce7v+PfiEeLQynwhqovTcrnkbCuqw6Lj
         VtVQ2S0FaL5kwc29UWuo0WBfBXUR3zVfC9bWgmxQOkJroQ/pNuV6/tuzNETQeZAazM/x
         4z7gcuCIs3MEmT/2j7CLsIFLwFQ61IcL6K+E7YKB7XdidqM8mC/RmNgCZ5JdjhIsYvgj
         RWdO5vJ7C2avQWfklt3tWg73ESc4yDi2JrEy9MVfd3DQxdhJqM1CGkgqzkVckBXbD1XE
         NzILrJ4SmgsivNX5kXbdJtyIqXzsf0mvSqn/g2d2Z5mymti2xuZ+au+/PLqvvuk9RB88
         UcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVAVBIoPitkoVB41na0YpgoUwz0ft/J9KfAGM4hj7SEsdlBBm9jFtW8ZzZsEkoRXHOUmEB7g4H5j/daSAtZGfwY2k6Wt9gWmx6PIQC
X-Gm-Message-State: AOJu0YxYXTZZ3LK8wAOv85mGs+GqX8pRGVPfAcSTjgAyhYaSpcjAkJy8
	ltX+Dk/8F2YhO8oqkjT2A9JX3MlauBj490mrlY6JA68KgvaEBdLoNk49BRp4c1I=
X-Google-Smtp-Source: AGHT+IGGflvW9k9jMoe4a2j7bLc5DjsbVsi5TuTQwGN5Sq94prukV63YQPojspKpGvkvTN5wWda3rw==
X-Received: by 2002:a05:651c:220b:b0:2ec:165a:2250 with SMTP id 38308e7fff4ca-2ec165a2453mr18905411fa.6.1718386381498;
        Fri, 14 Jun 2024 10:33:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c06fecsm5894881fa.49.2024.06.14.10.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:33:01 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:32:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
	Melissa Wen <mwen@igalia.com>, alexander.deucher@amd.com, christian.koenig@amd.com, 
	Simon Ser <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, 
	Daniel Stone <daniel@fooishbar.org>, 'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>, 
	Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, 
	Joshua Ashton <joshua@froggi.es>, Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v6 0/8] drm: Support per-plane async flip configuration
Message-ID: <lxfxqbax6azdpeamwm2qqv2tulgxrb7y3qzb4ir4myt6x5sqez@imd3yd5mbk7u>
References: <20240614153535.351689-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614153535.351689-1-andrealmeid@igalia.com>

On Fri, Jun 14, 2024 at 12:35:27PM GMT, André Almeida wrote:
> AMD hardware can do async flips with overlay planes, but currently there's no
> easy way to enable that in DRM. To solve that, this patchset creates a new
> drm_plane field, bool async_flip, that allows drivers to choose which plane can
> or cannot do async flips. This is latter used on drm_atomic_set_property when
> users want to do async flips.
> 
> Patch 1 allows async commits with IN_FENCE_ID in any driver.
> 
> Patches 2 to 7 have no function change. As per current code, every driver that
> allows async page flips using the atomic API, allows doing it only in the
> primary plane. Those patches then enable it for every driver.
> 
> Patch 8 finally enables async flip on overlay planes for amdgpu.
> 
> Changes from v5:
> - Instead of enabling plane->async_flip in the common code, move it to driver
> code.
> - Enable primary plane async flip on every driver
> https://lore.kernel.org/dri-devel/20240612193713.167448-1-andrealmeid@igalia.com/
> 
> André Almeida (8):
>   drm/atomic: Allow userspace to use explicit sync with atomic async
>     flips
>   drm: Support per-plane async flip configuration
>   drm/amdgpu: Enable async flips on the primary plane
>   drm: atmel-hlcdc: Enable async flips on the primary plane
>   drm/i915: Enable async flips on the primary plane
>   drm/nouveau: Enable async flips on the primary plane
>   drm/vc4: Enable async flips on the primary plane
>   drm/amdgpu: Make it possible to async flip overlay planes
> 
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 ++
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c         | 3 +++
>  drivers/gpu/drm/drm_atomic_uapi.c                       | 8 +++++---
>  drivers/gpu/drm/i915/display/i9xx_plane.c               | 3 +++
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c                 | 4 ++++
>  drivers/gpu/drm/nouveau/dispnv50/wndw.c                 | 4 ++++
>  drivers/gpu/drm/vc4/vc4_plane.c                         | 4 +++-

The main question is why only these drivers were updated.

>  include/drm/drm_plane.h                                 | 5 +++++
>  8 files changed, 29 insertions(+), 4 deletions(-)
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

