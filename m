Return-Path: <linux-kernel+bounces-240545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB62A926E9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210BA1C21D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F814430E;
	Thu,  4 Jul 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN2wF44C"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A01B963
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720069099; cv=none; b=QptFYK/sPHI8G7dmBOE3l9vViCGG2JZjHkZCLgZ5RF8I+tyZnKctYpOkPm3u5YRIvk64ZPcrYsAYoud00+oKNwIz704TTaYfM3LEZUnRtaK1V8kZhzKXkPP16L99+R2t0G148Xt29Y19svOIDqj7eg6z2x0vSEwI8e8F4b+qhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720069099; c=relaxed/simple;
	bh=IBfsDZz2gLd9qG/ipb6dOAYBW8CyW00AmC1wvMpM8HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBwt0vENbLmfgPTKhM6rhCikKQM9pt/l5FuWMQrvrlJIlHO5LfWy3FIwzU1ujFqWXDG6uD/GFVb19T/Rvv/gU7slm5WaZzn+1FLnJ7eNfHeL13qpzjsKfSnFrpioPOXyA7bwfbCP/s2pGyfasrqQcMqnRSbWfMmalrVF1Y5wQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN2wF44C; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so2004381fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720069096; x=1720673896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7zncIRfeuDlItOIy7D0MDTD3orFgOC3UeicdZPk4r4=;
        b=CN2wF44Ct0muQ67p2Ixk0bempFdRQko9ITHJj9+pxM1Owq0nbUH9bZbP1CD1194p1/
         81TkthCoAZ0sgzeRwhjR2X0z+iMPsaV++bUg+Vw+XF+P0aZyoqN/l6EWPU4kErKPpKmC
         rTYyLuvjBpDTPPMUI14APLwVGL+NgVJmzczReZ1tvPEnc2PEYMxIw9Q43fCiVmunj5f3
         DRqFLTx+VJUuqTkk83DSKETY7ER/V4DnR0iCQLi766ROm3mtBG3zHfMVRH4RwO1ZwUXQ
         pEfmZYuC2CI/kvmeWx/nkgvoHOdBJf4MnGGvB5ihO/+De9E0KOMc/fhTjagKSaoMse0t
         kY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720069096; x=1720673896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7zncIRfeuDlItOIy7D0MDTD3orFgOC3UeicdZPk4r4=;
        b=iCf5aYxq1utj5VF/bnejZExhkrTZt6ohpXjo8p2ciKk1I1S3GJ7/4Y1LrpIWpb8eH2
         1h6HhrlbmT8N+c4C4q6qnMz9CaNuQlvc3mrqT2tDwZkuIApFn9F0fSLvMWqHJEHsSAbl
         gxj30BTPz9igHcdJe5VAtXHr5gNJiLubUbmpLp37iE+7xYvCEaP3Nmx0PX7hhIgBfyl9
         z8Vf5OIeW56h0gwyKJ1hMiTEcLM5DOuX1O0hOfO5L2dR/58scU0gHOjuslOKMkKt7jYS
         +EWhoJGWxsHGtz/z36FPCJxeNMffA9gzluSqiIu8IFSzSakAoJmKiLP8xCho5BBCHxwt
         5cCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwtXZGHB/8W9bcHve9ucxdFx2wnh7Aav6k6MKhqRuiOBXr7b0ZLSL1HaUpBhHX6JytwoasBxD3uAP/LgpT5yMPq+bGZFbETCeex+S0
X-Gm-Message-State: AOJu0YyiYwz2dsUcStDxNFfYZzg1R/cIym8P9wzg2sScSTCeDw7SYEJO
	GPKEhKcLFRn1Ae3etPhFSB80gHCQ7gSqn18r7VHXxGpXzl2bzRrcy7u3DF4sV7tp1sLLwZ/8/p/
	2Go6AnmCjB8ElrXiLB1X8nEkeGbSEmg==
X-Google-Smtp-Source: AGHT+IF0DLCtxx1ONKaWIRWGcQaRLMMZnMXe1/bJJ23kQW1gwZq1F3/MHvrqsk9LZCHS4bi/2zcKgih857VzQG3iP9Y=
X-Received: by 2002:a2e:bc86:0:b0:2ed:58d0:b711 with SMTP id
 38308e7fff4ca-2ee8edfaa32mr3768541fa.33.1720069095952; Wed, 03 Jul 2024
 21:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630165949.117634-1-wuhoipok@gmail.com> <748e1bd6-6c40-443d-acbc-3d379229d068@suse.de>
In-Reply-To: <748e1bd6-6c40-443d-acbc-3d379229d068@suse.de>
From: Hoi Pok Wu <wuhoipok@gmail.com>
Date: Thu, 4 Jul 2024 00:58:04 -0400
Message-ID: <CANyH0kDFSn6voXWnF-91fYufRT=Y3eRBLG66JBXz2_=rxJHXfg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] drm/radeon: remove load callback & drm_dev_alloc
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks a lot for your help Thomas.

On Wed, Jul 3, 2024 at 4:52=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse.=
de> wrote:
>
> Hi
>
> Am 30.06.24 um 18:59 schrieb Wu Hoi Pok:
> > .load and drm_dev_alloc are deprecated. These patch series aims to
> > remove them.
> >
> > v3: Both v1 and v2 sucks. v3 improves greatly on readability.
>
> Very nice, thank you. I tested the patches with Radeon hardware and did
> not find issues. AFAICT this can be merged as-is. I think it should go
> into the amd trees. Maybe Alex or Christian can pick it up.
>
> Thanks for sticking with it.
>
> Best regards
> Thomas
>
> >
> > Wu Hoi Pok (6):
> >    drm/radeon: change variable name "dev" to "ddev" for consistency
> >    drm/radeon: remove load callback from kms_driver
> >    drm/radeon: use variable flags as parameter
> >    drm/radeon: add helper rdev_to_drm(rdev)
> >    drm/radeon: change rdev->ddev to rdev_to_drm(rdev)
> >    drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc
> >
> >   drivers/gpu/drm/radeon/atombios_encoders.c |  2 +-
> >   drivers/gpu/drm/radeon/cik.c               | 14 ++--
> >   drivers/gpu/drm/radeon/dce6_afmt.c         |  2 +-
> >   drivers/gpu/drm/radeon/evergreen.c         | 12 ++--
> >   drivers/gpu/drm/radeon/ni.c                |  2 +-
> >   drivers/gpu/drm/radeon/r100.c              | 24 +++----
> >   drivers/gpu/drm/radeon/r300.c              |  6 +-
> >   drivers/gpu/drm/radeon/r420.c              |  6 +-
> >   drivers/gpu/drm/radeon/r520.c              |  2 +-
> >   drivers/gpu/drm/radeon/r600.c              | 12 ++--
> >   drivers/gpu/drm/radeon/r600_cs.c           |  2 +-
> >   drivers/gpu/drm/radeon/r600_dpm.c          |  4 +-
> >   drivers/gpu/drm/radeon/r600_hdmi.c         |  2 +-
> >   drivers/gpu/drm/radeon/radeon.h            |  7 +-
> >   drivers/gpu/drm/radeon/radeon_acpi.c       | 10 +--
> >   drivers/gpu/drm/radeon/radeon_agp.c        |  2 +-
> >   drivers/gpu/drm/radeon/radeon_atombios.c   |  2 +-
> >   drivers/gpu/drm/radeon/radeon_audio.c      |  4 +-
> >   drivers/gpu/drm/radeon/radeon_combios.c    | 12 ++--
> >   drivers/gpu/drm/radeon/radeon_device.c     | 13 ++--
> >   drivers/gpu/drm/radeon/radeon_display.c    | 74 +++++++++++----------=
-
> >   drivers/gpu/drm/radeon/radeon_drv.c        | 27 +++++---
> >   drivers/gpu/drm/radeon/radeon_fbdev.c      | 26 ++++----
> >   drivers/gpu/drm/radeon/radeon_fence.c      |  8 +--
> >   drivers/gpu/drm/radeon/radeon_gem.c        |  2 +-
> >   drivers/gpu/drm/radeon/radeon_i2c.c        |  2 +-
> >   drivers/gpu/drm/radeon/radeon_ib.c         |  2 +-
> >   drivers/gpu/drm/radeon/radeon_irq_kms.c    | 12 ++--
> >   drivers/gpu/drm/radeon/radeon_kms.c        |  8 +--
> >   drivers/gpu/drm/radeon/radeon_object.c     |  2 +-
> >   drivers/gpu/drm/radeon/radeon_pm.c         | 20 +++---
> >   drivers/gpu/drm/radeon/radeon_ring.c       |  2 +-
> >   drivers/gpu/drm/radeon/radeon_ttm.c        |  6 +-
> >   drivers/gpu/drm/radeon/rs400.c             |  6 +-
> >   drivers/gpu/drm/radeon/rs600.c             | 14 ++--
> >   drivers/gpu/drm/radeon/rs690.c             |  2 +-
> >   drivers/gpu/drm/radeon/rv515.c             |  4 +-
> >   drivers/gpu/drm/radeon/rv770.c             |  2 +-
> >   drivers/gpu/drm/radeon/si.c                |  4 +-
> >   39 files changed, 184 insertions(+), 179 deletions(-)
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

