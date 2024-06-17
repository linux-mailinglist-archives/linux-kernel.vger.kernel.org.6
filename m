Return-Path: <linux-kernel+bounces-217792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F390B452
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C9028794D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FF1386C6;
	Mon, 17 Jun 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGjuIJo1"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D43132492
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636498; cv=none; b=UWoLn7+Uix6uUDhYKKqvXR6CXJc+bMY5zC+iThH/EWp4GRq+2kqh7bITOdfchFHvsh8yJNC/c7J2EIZmrMZjb4/+EOkqGGpvEzqiROuudPW3Vvi6HpGJs4ipkLP7iLfX78b+KciwSRxhnEE+oh2Dv8fLbsrwPZEZqCEEHBKT2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636498; c=relaxed/simple;
	bh=UZcmaFQ5A1I86/zGY+KEMThcxXJFe+3hbfhhkVwJXMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8VDShC64+vM7cI2CyCSrgVTFnsQp5B+qXoEsj3yIzxDF92lrCDOUyv30vO9kJpI0M6/9BpiysCyRyDx84j35IxlCUo07PnLjWNP20r4VKupZyeTkT+G4bNiTaub3SWUPVypSgUDdjgDH7OWvHcVJjtb8bqDo10N1/KOCrjKQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGjuIJo1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f717ee193fso31923055ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718636496; x=1719241296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkUQ3FK7gYksAvRoh/DqalNd7XUdjUDoinpyvvkETiQ=;
        b=nGjuIJo1fKeRq/X/jACCHOqw0GpqstXetDWI+Q1+/l3sABre8IME/HoLBKlup4/YnQ
         Psxyz8OouwC20B9UegWQ5PBiFI634HZPXYe0Y/Opn2Se/hwyOjOdCejNKJ0a1xo5Px4v
         MnAniazGC2zLcZHnNmKzfeFQ6teLCgcGOyDN20Uh9hy/8jj+lDUMshnz4/X5UHxJm6Sz
         42aKnARz8lgAt1Giu/8xtcS23se4pTpl2dhWVM7CQUbDqFGXytebne38/3xm3DLTQ/hj
         RjFQw+DFbCzuEiPB/+BFQWPZAKyILzU2IKs5E9DuBIEnE40KW+yuqEgVLpziPu9s0w3m
         QSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718636496; x=1719241296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkUQ3FK7gYksAvRoh/DqalNd7XUdjUDoinpyvvkETiQ=;
        b=dwRn9TxYm6iBgvWQ0cuuaVdWjp8wJLZ4Mb1yEGpAQq0YSInm/fyezqNw7xaAE2fVRA
         lE7+xyalPB2BE7ZKDhmxJpSeBc/URWr1LSQZj6ZIbaUY/cyP0NRKqbU7QQVPe5WFWr24
         HAdAXyL0ENj+eWMkDr2FjkOVNY5LjpUq2M+uimEAMlb9ese+p0R43RUrB4LYbyZQoSNZ
         oKEhmNvyEqO/LNuNcqvYaYBoMjuum2dSVp7UbRHMaWX5N7YEpFHKT0NXvem3yFc4c4h0
         b78c+X1ohpAErTmbWVbM1grKau3EkTMJMXh+3w1xIQKl/hw6VgWYflBS7uW+PAQgfNMn
         25GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs2K0icOFW9MzZbKrmiNXRdEk7rOmBLN/UYTWjreyI3rdrLA5/fEx7Xh3kwi+HI3pfpa0K/6FNl8yTE5gt0zCwrGbAPgqskln/RHDV
X-Gm-Message-State: AOJu0YzzW58PHfk1Fryc2zi6PfjDktKW6viHdoZrcTxdyuWwvz5Itx8m
	61Ny+k19ePdy3q3xF0m5fbUTFONcgxp9NoWlk0q6yJDfrPuljBMsAdq4P/ojTaItKqD+NRBirJE
	zZckMvqHtkF/jGI/gNjaWf/65Xdo=
X-Google-Smtp-Source: AGHT+IEsuB6l5SG4Cvs3xhhF/nAx6UFaYr3Uz3Btfd7tVaTu5y32qyHjK4CqtjZtHEK5N5kZIj3e55sj623ih9eKwIw=
X-Received: by 2002:a17:902:e847:b0:1f8:49e0:4d19 with SMTP id
 d9443c01a7336-1f8629fed6dmr145642115ad.57.1718636496299; Mon, 17 Jun 2024
 08:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org> <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
In-Reply-To: <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Jun 2024 11:01:24 -0400
Message-ID: <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Candice Li <candice.li@amd.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shashank Sharma <shashank.sharma@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org, 
	chenxuebing <chenxb_99091@126.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Based on grepping through the source code this driver appears to be
> missing a call to drm_atomic_helper_shutdown() at system shutdown
> time. Among other things, this means that if a panel is in use that it
> won't be cleanly powered off at system shutdown time.
>
> The fact that we should call drm_atomic_helper_shutdown() in the case
> of OS shutdown/restart comes straight out of the kernel doc "driver
> instance overview" in drm_drv.c.
>
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This commit is only compile-time tested.
>
> ...and further, I'd say that this patch is more of a plea for help
> than a patch I think is actually right. I'm _fairly_ certain that
> drm/amdgpu needs this call at shutdown time but the logic is a bit
> hard for me to follow. I'd appreciate if anyone who actually knows
> what this should look like could illuminate me, or perhaps even just
> post a patch themselves!

I'm not sure this patch makes sense or not.  The driver doesn't really
do a formal tear down in its shutdown routine, it just quiesces the
hardware.  What are the actual requirements of the shutdown function?
In the past when we did a full driver tear down in shutdown, it
delayed the shutdown sequence and users complained.

Alex

>
> (no changes since v1)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 ++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index f87d53e183c3..c202a1d5ff5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1197,6 +1197,7 @@ static inline struct amdgpu_device *amdgpu_ttm_adev=
(struct ttm_device *bdev)
>  int amdgpu_device_init(struct amdgpu_device *adev,
>                        uint32_t flags);
>  void amdgpu_device_fini_hw(struct amdgpu_device *adev);
> +void amdgpu_device_shutdown_hw(struct amdgpu_device *adev);
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev);
>
>  int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 861ccff78af9..a8c4b8412e04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4531,6 +4531,16 @@ void amdgpu_device_fini_hw(struct amdgpu_device *a=
dev)
>
>  }
>
> +void amdgpu_device_shutdown_hw(struct amdgpu_device *adev)
> +{
> +       if (adev->mode_info.mode_config_initialized) {
> +               if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
> +                       drm_helper_force_disable_all(adev_to_drm(adev));
> +               else
> +                       drm_atomic_helper_shutdown(adev_to_drm(adev));
> +       }
> +}
> +
>  void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  {
>         int idx;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index ea14f1c8f430..b34bf9259d5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2409,6 +2409,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>         struct drm_device *dev =3D pci_get_drvdata(pdev);
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>
> +       amdgpu_device_shutdown_hw(adev);
> +
>         if (amdgpu_ras_intr_triggered())
>                 return;
>
> --
> 2.45.2.505.gda0bf45e8d-goog
>

