Return-Path: <linux-kernel+bounces-447302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873249F3040
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1318849A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8B205E14;
	Mon, 16 Dec 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpBj3Lsq"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803E204C00
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351109; cv=none; b=AKM+Z/8YVyHKLbVB3Fqw0JLr7uICM1o7ZkYgVfgxKFyDGloDpQZJ3aOys71Rrq9hPdBG2mZPn5VSNQa8aUF8fFNsp92fkVNNrBYnZKHMsjwoE0Bs5Qi5f62bNkigt7LSBxGQhTvixQ5naJDDeELPkK78R4rB/odNVCTHr+peZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351109; c=relaxed/simple;
	bh=vFOLTSoV5POHRwVesxjGBChUOtRg9mODKN5o6+tU0iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz7zY5wTmiTzgOjIy8wLnoBXhAPE3/RXDMVp3C29dmEHIsZv0mgquHvOhExTKC3pohT38tXd6PtHL8+OpLJKUArMA13dGn+Izq4FQOwxT7aVurKMei5ktsntZmU9W9Nd7rOPWSKf1Y4EcmC39ms+dR/73/CXiCKRJmj5weogpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RpBj3Lsq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so4042972e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734351105; x=1734955905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYJ6bHIynmrdW1kW95N7YBXu67T1wjVBtmzNbXMkjmY=;
        b=RpBj3LsqSTbE1WyhFyMV5NPeu2bJilZodljk2hHT5+xYSuQemGjCTmSfvLbNAf6eEB
         aVq6C6LJWEcZBvJjDR1EqfbB+MsXJ2tuq9T31AQr06NkiEBcK30xJvQkDTlMi8wKhZi2
         MHG5aqGrb4Yx/DBUNsRd1wG/rSixdjrIdvyLBizHb5TWoapvHwWwaIuHIGSUsw6flvE2
         PS0a8G99qOTEmnalSaGXMC74LSngQ9X99XPZz3BMoaaEYQ2fedDO4Dhp/vLb24dNrTz1
         ZxewuAn3k6I4yiBVzTQrWIJXm6SaJPJ7Y2XPs8/yPQSxKHotBgJIxi+szrJeG/32Vlq8
         MxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351105; x=1734955905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYJ6bHIynmrdW1kW95N7YBXu67T1wjVBtmzNbXMkjmY=;
        b=Jprr5iQDGHmf/7l5asP66kTQFmens6+ZogF9evOUSKmUNR5rKUXkhOYCT8cl37b6T3
         hsz98zH30xzSl15730jsfBBtIN6ZDi6Z9pGUcsjvB2ssSaPQRIRBzdeAt/I6Y6wDDJT7
         y3pKvPowsRC35MqY/S4wHZINzKy5zlLHJ6mOs1m9YLYzEwsW6xIBg1QRMaXu0hzSAxRn
         EDifCfd3Hy0e+867dkcyIJnMKamZATEC0hSMXSERBHeOW2gmmCgCysWUIJqT+kDjvM2o
         eiTnK9hxmeKzj53jJDFgNEGaDeJTZjd4KX1k4Lt5O6HVQPmdW3FnIstglI4OHLAx3zDi
         QLaw==
X-Forwarded-Encrypted: i=1; AJvYcCXDm/NsB/hth54THkk8gXyCPeKYI2aGrwtRvq5V+lEG7MHMqeD7BSjEb73qXanoQMzWYxfwAR926yCZ9yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTo2tHUEi78hKmm47Pi/vfhT90PEoI8qARiNsnyTjSdc4RS/D
	7JKZZnvrU7AMarvDGRNr72Lw9gWjlWMeoSsRWRrKtRwZdS/gKx+4vI8uSqWqzLg=
X-Gm-Gg: ASbGncuSA+dMf+XUaO6CLrr+eoBajHDR7c00Qakv8DLc/foqXAhfExKgPiga3bAGOMo
	761HyOvrj122upJ6AHlTLZgrZpoiyLq1nDKZzPmPJvNXw2RF895MM5ExWR9YDeJHrq1J+z6KnH8
	MzkphMlmONLsR5pLq4+YyJF7uXvILhIt+xdjYRzZ258aEFq6uGefPiOAuM6xKat4MT5cEMGDoVp
	dLmf4i4XzNOD/ZplQLyhuqdOZxh8P7B+xhVWojoA8swCr2hZn10OTEh9zOo1tbRTBn39Sxcelvh
	hLZAy/2Dc1cMbkRSJsAPt/gL3OfmzQoIkrPI
X-Google-Smtp-Source: AGHT+IHrwRS1QfWMBwy9QLkErfwsKJMw9vVs4tgqRJfw5TQSQERm2FXX9oalBSjWvdHKRYw73Gk+nw==
X-Received: by 2002:a05:6512:308e:b0:540:3550:b1dd with SMTP id 2adb3069b0e04-5408b800785mr4235963e87.3.1734351105082;
        Mon, 16 Dec 2024 04:11:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13eb8sm822646e87.218.2024.12.16.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:11:43 -0800 (PST)
Date: Mon, 16 Dec 2024 14:11:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 0/2] drm/nouveau: remove drm_encoder_slave interface
Message-ID: <fw7i3kusogrrsslb5sjdid27uqnwey5qa5yhyrfa677n4iqqhq@tfh5s6bmqgna>
References: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
 <Z2ASy3TQ4suupdvd@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2ASy3TQ4suupdvd@cassiopeiae>

On Mon, Dec 16, 2024 at 12:45:15PM +0100, Danilo Krummrich wrote:
> On Sun, Dec 15, 2024 at 12:19:22PM +0200, Dmitry Baryshkov wrote:
> > The nouveau driver is the only user of the drm_encoder_slave interface.
> > Demote it from KMS helpers module to the nouveau driver itself, moving
> > corresponding I2C encoders to be handled by nouveau driver too.
> 
> I understand nouveau is the only driver using this interface (and the
> corresponding i2c encoders).
> 
> However, I'm not quite seeing the advantage of folding the interface (including
> the two i2c drivers) into nouveau. I don't think this legacy interface does harm
> the subsystem in any way / does prevent the subsystem from moving forward.
> 
> Can't we just keep it as it is?

Well, drm_encoder_slave is a part of the DRM KMS helpers module, so it
take (a little bit) of space on every system. The nouveau situation
isn't unique, other drivers (i915, ast) also incorporate the code for
I2C backends. For the further discussion see the thread starting from
Laurent's email ([1]).

[1] https://lore.kernel.org/all/20241117205426.GE12409@pendragon.ideasonboard.com/

> 
> > 
> > Ideally those two drivers should be converted to the drm_bridge
> > interface, but it's unclear if it's worth spending time on that.
> 
> Probably not.
> 
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> > Changes in v2:
> > - Renamed symbols in defconfig (Laurent)
> > - Added missing Kbuild file (Laurent, LKP)
> > - Renamed guarding defines in include files.
> > - Dropped mentions of two removed functions.
> > - Link to v1: https://lore.kernel.org/r/20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org
> > 
> > ---
> > Dmitry Baryshkov (2):
> >       drm/nouveau: incorporate I2C TV encoder drivers
> >       drm/nouveau: vendor in drm_encoder_slave API
> > 
> >  arch/arm/configs/multi_v7_defconfig                |   4 +-
> >  arch/parisc/configs/generic-32bit_defconfig        |   4 +-
> >  arch/parisc/configs/generic-64bit_defconfig        |   4 +-
> >  drivers/gpu/drm/Makefile                           |   1 -
> >  drivers/gpu/drm/i2c/Kconfig                        |  18 ----
> >  drivers/gpu/drm/i2c/Makefile                       |   6 --
> >  drivers/gpu/drm/nouveau/Kconfig                    |  20 ++++
> >  drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   3 +
> >  drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  12 +--
> >  drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild        |   5 +
> >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c    |  30 +++---
> >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c   |   8 +-
> >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h   |  11 ++-
> >  .../drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c    |  33 ++++---
> >  .../dispnv04/nouveau_i2c_encoder.c}                |  85 +++++-----------
> >  drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  20 ++--
> >  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   4 +-
> >  .../gpu/drm/nouveau/include}/i2c/ch7006.h          |   4 +-
> >  .../gpu/drm/nouveau/include/i2c/encoder_i2c.h      | 109 ++++++++-------------
> >  .../gpu/drm/nouveau/include}/i2c/sil164.h          |   4 +-
> >  drivers/gpu/drm/nouveau/nouveau_connector.c        |   6 +-
> >  drivers/gpu/drm/nouveau/nouveau_encoder.h          |  13 +--
> >  22 files changed, 172 insertions(+), 232 deletions(-)
> > ---
> > base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
> > change-id: 20241214-nouveau-encoder-slave-a6dd422fa4a9
> > 
> > Best regards,
> > -- 
> > Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 

-- 
With best wishes
Dmitry

