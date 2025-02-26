Return-Path: <linux-kernel+bounces-534764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E9A46AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 066413B07D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129BE23959E;
	Wed, 26 Feb 2025 19:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcfmka38"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4842397B4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597748; cv=none; b=WLWl0TfGuvpJ9LW1Xcxeo9GnyxSbuujVXiZhxSXBAdEm7lhNrfkycb+s4P30fh6e0pI2JzMOEKe8HCn49XjZagdk8jLyBFHG3BlepA2yn9fRrqhxa/baA2iMGARsyVfCQqU/0zsk3jW+JJZKWYJNS8VId7B35YvStoEf2S73DNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597748; c=relaxed/simple;
	bh=wSR3W8OfnLO8hMVgjqMSb/3Rx24rkpJcG0QFu43lqeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH1tOtGUL5oJlxzq0BJd8Z8+CeH9KR/XLRGihtBt+rfXd7k8UkzPDMxg/Hca7oo4CptuZUufM6FI5KttYmVkIRMBvX6/TL5sci+yp94XOpayjhcBqh3Wy4XoG39X0iJ0/c1vXHK9dfeB5y5tNNJkMpIbdOvPzc/2oGbbU7ghens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcfmka38; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc95e20e72so48479a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740597746; x=1741202546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y7AKbsdNld8g2hpFglN8JrmjtPrHU1b2vsuKh5wAQM=;
        b=Gcfmka38/i9TpAOeNiNW44GNs/HUUpleeS7oJCj+EL/doA08HgxBdwIOuK4L2fOVCF
         awgaUvqKvcLsRqkWS33L/Cpud/o0pLQMuhFyf4HLDFVQi34yNUzBbkBCGLYsFdL6Res8
         yBcO4Frcg9QVJLgKSYunDdF3ije1UsmKps6PyKK3h7gRn0MCmU0UcNnJAXhM/hJJpFvA
         gE07af4c1ZR23Gjn90V1E7Rs0leyGS2U99KLD0lTJeq5mF4LILDw67yzwmsiwbeXpPIH
         yrxQeHc5yG5w0HnUKucDZjypYBkXQcuYmUG/jlnZx+nM10++bZMF/+DQgOkuUezqm4pj
         L7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597746; x=1741202546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y7AKbsdNld8g2hpFglN8JrmjtPrHU1b2vsuKh5wAQM=;
        b=Lh6rr27YOg7wkMANTVArzHnYfLntuSkLTyUECW4WNnBUuO4X4WduYft1fQo50uRz6s
         4HyBYq+wEpwd25s+owmrLQz2/0vamXzJgux63bajNsB3eDcO+9riWUg2BcX9LeR+Jfj8
         WO9csjKFjWy7TLNk1rOyAYDCxE7iEmLhDkXmumwloTYmf/cH/aOY6ZJWAH4yDLNselYu
         8QZtUPFXEB8OLL/IUyEd7mACw6SNuVZnfZsy26YbGNl5/04Ye+QOWJecmmRjx8OECA8Y
         oZWXdv3OgUGo5BxLu1tBc07JwYw7V9M63lrJClNdx0/5gVo/a6ynG6Ni12nMWmikzlsX
         dfGg==
X-Forwarded-Encrypted: i=1; AJvYcCXV8ecEwAQw2zEhWQ/ZN41iYrCdI7eEhRvA1A3dlxHs94C9u4RHR+b08jmUpgQ9ICSenp0jg7sMnFombuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlXBUOFCckwcYC5IqfnmP5U1OXR449FJNvouazwL1iCZTOtXq
	j95C7G6TTbHnEsInDrTdaSOje1PHMi/Uz3U4uOCcncOVDEv2Mi17piLUPmnXUBG5d3BxukVTjad
	VRl/JLKYNXcKyplRPdd5TETg46AI=
X-Gm-Gg: ASbGnct6wqye3TUy4IvGs5MIgfEfkTly5QCfC6lLJriy3Fi/umavrq6kcQ5jKhP+JDI
	G5wELN9A2C40sWhQSXvLDdIM9muiZ2WsgcOh75beCnTOS306rc7WPlf1J9i77ZE5rHv0PfwtyVJ
	Oeq4sYcN4=
X-Google-Smtp-Source: AGHT+IFXlPewfDjTcQd23uWt5JHmAkzRm8cSyjPkDV01jbpADxXVm68Lc0wOKp9OIqOnGomJpkNfOnYa2s2/BMzgZ+k=
X-Received: by 2002:a17:90b:4acb:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-2fe91d0f86bmr1193058a91.2.1740597746090; Wed, 26 Feb 2025
 11:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226131118.1012223-1-andrealmeid@igalia.com>
In-Reply-To: <20250226131118.1012223-1-andrealmeid@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Feb 2025 14:22:13 -0500
X-Gm-Features: AQ5f1Jrj8uBp_Nld3i5VpcTJQMhPSbajAtBz4HQQ7cHskmCGLtzNlphUVbvrm-o
Message-ID: <CADnq5_MjDxqG9GzPShL0oucpCPx9J5HodMWRuaOAgs0s0CD0=A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Create a debug option to disable ring reset
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, siqueira@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Feb 26, 2025 at 8:11=E2=80=AFAM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Prior to the addition of ring reset, the debug option
> `debug_disable_soft_recovery` could be used to force a full device
> reset. Now that we have ring reset, create a debug option to disable
> them in amdgpu, forcing the driver to go with the full device
> reset path again when both options are combined.
>
> This option is useful for testing and debugging purposes when one wants
> to test the full reset from userspace.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 +++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 69895fccb474..75dc4b962d64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1186,6 +1186,7 @@ struct amdgpu_device {
>         bool                            debug_use_vram_fw_buf;
>         bool                            debug_enable_ras_aca;
>         bool                            debug_exp_resets;
> +       bool                            debug_disable_gpu_ring_reset;
>
>         bool                            enforce_isolation[MAX_XCP];
>         /* Added this mutex for cleaner shader isolation between GFX and =
compute processes */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 95a05b03f799..edeb12c816e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -136,6 +136,7 @@ enum AMDGPU_DEBUG_MASK {
>         AMDGPU_DEBUG_USE_VRAM_FW_BUF =3D BIT(3),
>         AMDGPU_DEBUG_ENABLE_RAS_ACA =3D BIT(4),
>         AMDGPU_DEBUG_ENABLE_EXP_RESETS =3D BIT(5),
> +       AMDGPU_DEBUG_DISABLE_GPU_RING_RESET =3D BIT(6),
>  };
>
>  unsigned int amdgpu_vram_limit =3D UINT_MAX;
> @@ -2221,6 +2222,11 @@ static void amdgpu_init_debug_options(struct amdgp=
u_device *adev)
>                 pr_info("debug: enable experimental reset features\n");
>                 adev->debug_exp_resets =3D true;
>         }
> +
> +       if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_GPU_RING_RESET) {
> +               pr_info("debug: ring reset disabled\n");
> +               adev->debug_disable_gpu_ring_reset =3D true;
> +       }
>  }
>
>  static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned=
 long flags)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 7b79b0f39ba1..8ab23182127e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -137,8 +137,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>
>         /* attempt a per ring reset */
> -       if (amdgpu_gpu_recovery &&
> -           ring->funcs->reset) {
> +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +               dev_err(adev->dev, "Ring reset disabled by debug mask\n")=
;
> +       } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>                 dev_err(adev->dev, "Starting %s ring reset\n", s_job->sch=
ed->name);
>                 /* stop the scheduler, but don't mess with the
>                  * bad job yet because if ring reset fails
> --
> 2.48.1
>

