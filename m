Return-Path: <linux-kernel+bounces-447349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B69F3106
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F72166EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E846204C3A;
	Mon, 16 Dec 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNMy1FMV"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070E1C54A5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353947; cv=none; b=rHT8iH1G3hIGBHZP/oZl/Tq9BcPfg0QXBZrnEDYBuCwhTGgku4ViRh6P98GIzNhF+Dg6JUTub/SGXPsEDGZDwGDr+7jSfxYFCF6cHWiB2aD1kmYdOnWYxbkSbhWTJbSjD+b3LRbyRjkJXBTdKGSr5rzcojFVSxTK3P8cwTuhIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353947; c=relaxed/simple;
	bh=Eo5OcVruVIUUvg5qLtVABrzFj3TYkfbbcYirjBylF24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4cq99WDD5crShFIzKdR11Do8RHQ0vNI3Mixc+YwdDseczVPO8B4b0u5PhkjkY6CHBPy++nvMtwhlMMhBN7ZUzgOZZwSzlyP4XHKYVTqCDM1vHjCHyI+AKH9O9jA8+oipILtaS1wrnvT54RswGi7bMmMLWTc7q4Ga4GwsQEDva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jNMy1FMV; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so4468919e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734353943; x=1734958743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TVuB3oapyzQ+WabPFqKkBmsN+XaTc6foo/uBq/7dt04=;
        b=jNMy1FMVkmUTy2MrlA6JcfQIQhTnhsbnWS+rxpc9NVybU7+6t9CPo2uc5KK3YWsp8i
         Bcs9lkqyu+xqx2dXpQ1K0ogR/dvc09C/EAm8DokvSNgPKttid5kpoRSU/t4LQ+vmhkbD
         vprwuTVsBEFrt3gZYMMOFEX9rjp8QD7pj0HYe3tK0ormir9teZrqYNgvOPd1r2BrbEtb
         v4GTESairxqOEqYvvMIhu5Znx2iUFtXEuIt60Ijl/bZHwhRnQSqMPLSV0wXXqtL2Ee/a
         N4OXQp6Z0h1M5uLAMwOelD084XYGKqtMEmS87+9RlOEpCprhlhGewDR7hJD2NmXSPWmL
         1ksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734353943; x=1734958743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVuB3oapyzQ+WabPFqKkBmsN+XaTc6foo/uBq/7dt04=;
        b=dy32fLgHujA1EqaMyzAzIoHQEYgfNt3E/bqCcn1IeDAt9livd/tx6oHEpfxz289RFF
         JWss1bcIN5SkODm509gU4IAh6ZHrUbYaQlOSWFxqZqfZcRX3t/Dtop3VML1npuiW4YqI
         JzQvyZFBqvntcdx4tx/GHnsldRp1a5NsaFHon1h8XNml9VHpXg/+aIPfgckaXghnB6Vr
         sgwIa1H5AEnPrdCxZDrPxCcEI6lKdOhNdLioa9kqeMrOnqAKN0eYV2CBmz3Zyyl4UE7R
         PxU5A0IbNotRyxZH0fWgoPGMiHlEKiqxCq55P43o/C/ZKW7zcBdYITg6i8uu/J8Evr1G
         42IA==
X-Forwarded-Encrypted: i=1; AJvYcCUvYQj7UWW4Q9r5RwB79FckZaJ6gpBS4vxplmdBAIkE/lpJ6Va0SRI1IiQofO80/Fc/XO+hW+YrwGJxDOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrPLmX6Euq8+YSZVvN16MMJ4xa1EA78v7J1zLu/B+DU1ntVJO
	ZN39W5Ijlu3krK+On01cKPHNtq6px/4wBRFft4SCZWpopdiLcMv7aByWr286BHY=
X-Gm-Gg: ASbGncsuT7gIOjmx5V3E75V3cg6rwLBZemCvjUu6xnlfl4lXpsmf4XjWAmgapX+F4Ag
	JBHydx37SBVOGBDZYt4VqVAHJ/J/VkID+vfcJSLux8xJpZSwa+FFfg2tQkbp9uUDuVwFrbPx+RP
	YEXUvLCMqDn1pJIXPzKi4SDSfc8x2rdvjxUsWmWqNSoj675useAcs/xIEQXU9aR+a5RbuzR+AyB
	o6O9X/eC/1lV6ENuahtqDkBMe8KIS1Tc2hvS+q4XQ0HlF/HIo4h7GGWaVOsrzWE3iyDDSY7QwYt
	ua730zen02YJa8+m0ZxYfuvapkQNG4STYXmx
X-Google-Smtp-Source: AGHT+IG3chtNkwEjewlJ7p/muv4mfFjLOsomSWhSVXAb0PK0zkdUgPizAruVdCjqh080agAIFaBnNQ==
X-Received: by 2002:a05:6512:1191:b0:540:2533:436e with SMTP id 2adb3069b0e04-540905aacb4mr4442478e87.37.1734353943338;
        Mon, 16 Dec 2024 04:59:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303440452a8sm9240921fa.40.2024.12.16.04.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:59:02 -0800 (PST)
Date: Mon, 16 Dec 2024 14:58:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] drm/nouveau: remove drm_encoder_slave interface
Message-ID: <2p2rx6zmuph4bdwjork5aqp5n3xkho7cohapvgfijka64vbpop@nse4i55pkyy7>
References: <20241215-nouveau-encoder-slave-v2-0-ef7a0e687242@linaro.org>
 <Z2ASy3TQ4suupdvd@cassiopeiae>
 <fw7i3kusogrrsslb5sjdid27uqnwey5qa5yhyrfa677n4iqqhq@tfh5s6bmqgna>
 <20241216121651.GP32204@pendragon.ideasonboard.com>
 <Z2AgFHV2BaaZYGTx@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2AgFHV2BaaZYGTx@cassiopeiae>

On Mon, Dec 16, 2024 at 01:41:56PM +0100, Danilo Krummrich wrote:
> On Mon, Dec 16, 2024 at 02:16:51PM +0200, Laurent Pinchart wrote:
> > On Mon, Dec 16, 2024 at 02:11:41PM +0200, Dmitry Baryshkov wrote:
> > > On Mon, Dec 16, 2024 at 12:45:15PM +0100, Danilo Krummrich wrote:
> > > > On Sun, Dec 15, 2024 at 12:19:22PM +0200, Dmitry Baryshkov wrote:
> > > > > The nouveau driver is the only user of the drm_encoder_slave interface.
> > > > > Demote it from KMS helpers module to the nouveau driver itself, moving
> > > > > corresponding I2C encoders to be handled by nouveau driver too.
> > > > 
> > > > I understand nouveau is the only driver using this interface (and the
> > > > corresponding i2c encoders).
> > > > 
> > > > However, I'm not quite seeing the advantage of folding the interface (including
> > > > the two i2c drivers) into nouveau. I don't think this legacy interface does harm
> > > > the subsystem in any way / does prevent the subsystem from moving forward.
> > > > 
> > > > Can't we just keep it as it is?
> > > 
> > > Well, drm_encoder_slave is a part of the DRM KMS helpers module, so it
> > > take (a little bit) of space on every system. The nouveau situation
> > > isn't unique, other drivers (i915, ast) also incorporate the code for
> > > I2C backends. For the further discussion see the thread starting from
> > > Laurent's email ([1]).
> > > 
> > > [1] https://lore.kernel.org/all/20241117205426.GE12409@pendragon.ideasonboard.com/
> 
> The drm_encoder_slave code it's rather small, but I guess this can be used as
> argument for both, keeping it where it is and moving it.
> 
> If you want to move it to nouveau, I'm not going to object. But please fold the
> helper code, such that we aren't left with unused functions and unnecessary
> function pointer indirections through struct drm_encoder_slave_funcs.

This is more or less what I've done. Or would you prefer to keep the
wrapping functions that just execute the callback? I can change the
patchset accordingly.

> 
> > 
> > It's also a question of whether maintenance of this code based used by
> > the nouveau driver only should be the responsibility of the drm-misc
> > community or the nouveau driver maintainers.
> 
> Good question. It's common infrastructure; do we expect / require the last user
> of such infrastructure to take ownership?

Unfortunately it's more like 'the only one' :-( In other words, if we
were expecting other users, there would not be such a move. But
hopefully all new drivers will use bridges infrastructure.

> 
> > 
> > > > > Ideally those two drivers should be converted to the drm_bridge
> > > > > interface, but it's unclear if it's worth spending time on that.
> > > > 
> > > > Probably not.
> > > > 
> > > > > 
> > > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Renamed symbols in defconfig (Laurent)
> > > > > - Added missing Kbuild file (Laurent, LKP)
> > > > > - Renamed guarding defines in include files.
> > > > > - Dropped mentions of two removed functions.
> > > > > - Link to v1: https://lore.kernel.org/r/20241214-nouveau-encoder-slave-v1-0-beda767472e3@linaro.org
> > > > > 
> > > > > ---
> > > > > Dmitry Baryshkov (2):
> > > > >       drm/nouveau: incorporate I2C TV encoder drivers
> > > > >       drm/nouveau: vendor in drm_encoder_slave API
> > > > > 
> > > > >  arch/arm/configs/multi_v7_defconfig                |   4 +-
> > > > >  arch/parisc/configs/generic-32bit_defconfig        |   4 +-
> > > > >  arch/parisc/configs/generic-64bit_defconfig        |   4 +-
> > > > >  drivers/gpu/drm/Makefile                           |   1 -
> > > > >  drivers/gpu/drm/i2c/Kconfig                        |  18 ----
> > > > >  drivers/gpu/drm/i2c/Makefile                       |   6 --
> > > > >  drivers/gpu/drm/nouveau/Kconfig                    |  20 ++++
> > > > >  drivers/gpu/drm/nouveau/dispnv04/Kbuild            |   3 +
> > > > >  drivers/gpu/drm/nouveau/dispnv04/dfp.c             |  12 +--
> > > > >  drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild        |   5 +
> > > > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_drv.c    |  30 +++---
> > > > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_mode.c   |   8 +-
> > > > >  .../drm/{ => nouveau/dispnv04}/i2c/ch7006_priv.h   |  11 ++-
> > > > >  .../drm/{ => nouveau/dispnv04}/i2c/sil164_drv.c    |  33 ++++---
> > > > >  .../dispnv04/nouveau_i2c_encoder.c}                |  85 +++++-----------
> > > > >  drivers/gpu/drm/nouveau/dispnv04/tvnv04.c          |  20 ++--
> > > > >  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c          |   4 +-
> > > > >  .../gpu/drm/nouveau/include}/i2c/ch7006.h          |   4 +-
> > > > >  .../gpu/drm/nouveau/include/i2c/encoder_i2c.h      | 109 ++++++++-------------
> > > > >  .../gpu/drm/nouveau/include}/i2c/sil164.h          |   4 +-
> > > > >  drivers/gpu/drm/nouveau/nouveau_connector.c        |   6 +-
> > > > >  drivers/gpu/drm/nouveau/nouveau_encoder.h          |  13 +--
> > > > >  22 files changed, 172 insertions(+), 232 deletions(-)
> > > > > ---
> > > > > base-commit: 4176cf5c5651c33769de83bb61b0287f4ec7719f
> > > > > change-id: 20241214-nouveau-encoder-slave-a6dd422fa4a9
> > 
> > -- 
> > Regards,
> > 
> > Laurent Pinchart

-- 
With best wishes
Dmitry

