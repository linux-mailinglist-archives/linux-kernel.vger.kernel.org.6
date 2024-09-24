Return-Path: <linux-kernel+bounces-337437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A19E984A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B5F2821B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E7642065;
	Tue, 24 Sep 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bniqSkoO"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAF2941B
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197518; cv=none; b=VbCagRZhvl2zdvGT3ZsIZ47PXAAjAKsKs8LzxbayBZLqGBzw8VpfjAb4Bevyw8i9qSxG2gen3Ot/HClIsYNKz95jD4oudTBkzFkFq5zBIe+4PnVLRiqbx/AJV/Ht9CGCKIW/E1+EKxU7xUd8e/hBhBTKXAvNbFPc6OkbUPv99SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197518; c=relaxed/simple;
	bh=qESImxhzjYTO90ypqyzdHc1Bxfik+Cgx3fJtK6O/JI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rngmRDIAYc4th9/cEolfqowffPs1fUBuY/oRiDWFScqhc5rCnp36m83OKMj4gW+EnamdYTsdSfaaNSYtYf5jWNoWuWItFMYfUad8rs258EIxWrbojc9fB4X+2XkZ0dn+R/q09AsREtabkXjBvVJ6Ylqh4XpMjtG0A8+oFReFbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bniqSkoO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d88ec20283so439892a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727197516; x=1727802316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lccss7b+PPPdgDMWVV+dLTdvaIaRkSluice+dhJE7yM=;
        b=bniqSkoOUTTpZlNJ7Xo68HI6FRvVtA6dqOcJcOgUb0cS0Ve+A9GpJpmxIkCW9MJVv5
         eYAxlYbw5HbkhPjh9duhc/xb1tc7rDUsNkLwnwaLXmpg85MeziaApYhhCBdj4CAMW1ZB
         5iN84lvN6RRDwP1pS2DtUgH0S5yVBwEIauVzhLY0pkW0ayg7Yu1QqMc21fB4EVqoq/i9
         XzyTRSoniqxSJLfrFPetWL5IDjFAADnDjobEcuA2Lrhm6oEwwJrkHgvi1r95Q76WwERm
         u7JxviGANAFlAiYDABSUwVZ6Z+OArnvWfhcnQJXITZZKnPpKSvOVs4bdyvOWfdG00SWB
         x/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727197516; x=1727802316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lccss7b+PPPdgDMWVV+dLTdvaIaRkSluice+dhJE7yM=;
        b=lhFKS0TnrnROMtqLAHZFZaS2WW4qx9JQ9bW8ln7W58nxFvdZg09OEF5+WXhdva0N/F
         AwwTZYTsrXarGh5J7Lge3QVAJR0XVjT6lHN5Ix/kmhBR7hmKbteVOR3Sl76gTwE61NU/
         7pHpB+w+E+OzuIyjpBtaR0dNyZ50Xbvx1ejkwpLyayz7VOiwJ8kCSqDOzsAJ2OIPvbH3
         akfpNMBBROLT+Ayt6R9iJrTJuOPjFqGzPVmVXUSze9ljPSGqBu3uGVz6EoA6lUSRuDrO
         Z3wuapMqWw/mJXGyc3q6Ijdzxr2KQDlqxruuMgQsWBeH1/lqTUK4E5p7aur8VN7aJo93
         exFA==
X-Forwarded-Encrypted: i=1; AJvYcCXkTJa4LA7BKpJ/jj4/jQyENXSTymnpvwyidiLeHgZS7l0i87X5pr6wLENDxB/mZDJ96qgOi593G0pVmqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvF9xFPAGX/pbGZjJCohtqjZrHG05n5DLhbZwrJIClM4SlsTx2
	wnmzCE0abam2lXhbwozqb1JRloMygQsxfx9nrxQO7k3sVhLwrWs/smFpHzhAyX4s+4kaM7u9iYq
	qX4bRjgBfuVLPmsZyOnELOZfhmBA=
X-Google-Smtp-Source: AGHT+IEm1M/263IJX2uy0cLLXAid7dgO/+hbup76IjqANE9iuRdSDZBYcCHLsVy8aY8VjxriJB40uwPp8Ry3nLtc5M0=
X-Received: by 2002:a17:90a:e513:b0:2d8:8cfd:585d with SMTP id
 98e67ed59e1d1-2e05802da10mr1707599a91.2.1727197516117; Tue, 24 Sep 2024
 10:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923012446.4965-1-linux@treblig.org> <20240923012446.4965-6-linux@treblig.org>
In-Reply-To: <20240923012446.4965-6-linux@treblig.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 13:05:04 -0400
Message-ID: <CADnq5_PiB1eofAzdBvq8yxZypkv-JKutwqy7US9CQ4CV_R218w@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu: Remove unused amdgpu_i2c functions
To: linux@treblig.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Sun, Sep 22, 2024 at 9:43=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> amdgpu_i2c_add and amdgpu_i2c_init were added in 2015's commit
> d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> but never used.
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 25 -------------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h |  4 ----
>  2 files changed, 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_i2c.c
> index 00d6211e0fbf..f0765ccde668 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -225,15 +225,6 @@ void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c)
>         kfree(i2c);
>  }
>
> -/* Add the default buses */
> -void amdgpu_i2c_init(struct amdgpu_device *adev)
> -{
> -       if (amdgpu_hw_i2c)
> -               DRM_INFO("hw_i2c forced on, you may experience display de=
tection problems!\n");
> -
> -       amdgpu_atombios_i2c_init(adev);
> -}
> -
>  /* remove all the buses */
>  void amdgpu_i2c_fini(struct amdgpu_device *adev)
>  {
> @@ -247,22 +238,6 @@ void amdgpu_i2c_fini(struct amdgpu_device *adev)
>         }
>  }
>
> -/* Add additional buses */
> -void amdgpu_i2c_add(struct amdgpu_device *adev,
> -                   const struct amdgpu_i2c_bus_rec *rec,
> -                   const char *name)
> -{
> -       struct drm_device *dev =3D adev_to_drm(adev);
> -       int i;
> -
> -       for (i =3D 0; i < AMDGPU_MAX_I2C_BUS; i++) {
> -               if (!adev->i2c_bus[i]) {
> -                       adev->i2c_bus[i] =3D amdgpu_i2c_create(dev, rec, =
name);
> -                       return;
> -               }
> -       }
> -}
> -
>  /* looks up bus based on id */
>  struct amdgpu_i2c_chan *
>  amdgpu_i2c_lookup(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_i2c.h
> index 63c2ff7499e1..21e3d1dad0a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
> @@ -28,11 +28,7 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_d=
evice *dev,
>                                           const struct amdgpu_i2c_bus_rec=
 *rec,
>                                           const char *name);
>  void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c);
> -void amdgpu_i2c_init(struct amdgpu_device *adev);
>  void amdgpu_i2c_fini(struct amdgpu_device *adev);
> -void amdgpu_i2c_add(struct amdgpu_device *adev,
> -                   const struct amdgpu_i2c_bus_rec *rec,
> -                   const char *name);
>  struct amdgpu_i2c_chan *
>  amdgpu_i2c_lookup(struct amdgpu_device *adev,
>                   const struct amdgpu_i2c_bus_rec *i2c_bus);
> --
> 2.46.1
>

