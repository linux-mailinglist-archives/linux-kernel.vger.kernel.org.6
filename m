Return-Path: <linux-kernel+bounces-447959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB69F3939
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679A916A595
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E058207646;
	Mon, 16 Dec 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETcU4YiA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3E161302
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374885; cv=none; b=uT0VFguCwLGzsKBnVdoMoN9WQMzDpo799sy90uSlf8cfZVJ7uvpc5PdcD4xSEMCE2i185kvAV3DtnrawkadL9cYGq+hqnzaBiJEl+NCxEdhKyPtHVLigqsA6rNmawa3TZjUi30YC9ABykFLfWqgZPb9PrtfFOitvNgPWzCxmiFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374885; c=relaxed/simple;
	bh=IRzoBXmUNj6ICkr538emgmcuhbGnx/cZUHQC22RyN98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQvJcxfDR0qrpYSiOFbfrLWv3ibhZkRHJAYOL0bN8sfVBlwosR4mZO4fSIq+ijlp0Xy/PkrHWeLNGFehRu7rYf3zxQ1vzWrRlUt005ea6U9e42TLL7wgIhkbBkFvEJG2xAcCRdqqsRT/Q6Vmr8dbKF1EE+sjkpluAqQ2O/elvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETcU4YiA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215464b0432so4309675ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734374883; x=1734979683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljZDBe+woNif3z5aKXbwbDAeIWtDR2ec5K+hUlmzxA8=;
        b=ETcU4YiAG8NWKgtJO6qYl6LKg2ZMc8PG5BXk4IfyOIV23pofJladL3crgoYeHPE3zm
         0qZ17/kZnltvIaoJPDJWTU60N7lKVFUKJMR9m1CXC6+h/gpgsS+6qsAiov7ntMmSUube
         LQbYBAPfALAN5zG2lnXxVIQNt34BKlqPhySiExAgJoCbKcFvSQCrMp1oYFq2rWkzCQkK
         SDXB9JlQj0JUeRDCKHENFRx1rZcSYcPMpiIXpDgre0nHpQW3Ty5Jz7hmFJG98s3V6Bzi
         Fojk0IJso13RdW5jgFhjB1WWLDP0UkAVoMIYznKmwwcM2F4thKIkjjHiHLmdYYmbBRGi
         +u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734374883; x=1734979683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljZDBe+woNif3z5aKXbwbDAeIWtDR2ec5K+hUlmzxA8=;
        b=apED3cQbrEUtCgzft/YiGdTEqDLQzCNYpMgya6RfSyffiesSASJniSYj6aY6M90Bjy
         dUVAE0B1fnjqeYqzS555vRvu+GkWbjXdBwiKtgdWPDoFsWnOb293rOEm15wTRrk5oze4
         exD3wBPDOIC3YMU9WubBl9jPYU8qOS017B1pduUGwAts6Vh15V3nJcLqdRISjKOc/ABu
         LT7TNhRs/yp2DGRClbCRgRIo0nDehj0IzBjUDVTvnn4vk5q9gpLljZEgFA4Bpxzfh+Vv
         KP4SfpjK69dYtV18EeRK4bluMURhEFSSlB/5t+BJtDN8aGbMG4Csts5PYJN3IebR287a
         qOfw==
X-Forwarded-Encrypted: i=1; AJvYcCVS2sPPq0miBo/U/8+Hf71Sh1IPrUhGNYGswV4iohjni8d8yVkK17pe345kfUWbvpOO5vwZn1eH/FsKqvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjm+r812xZB6BM3Yx5UDrg0QKejCSah1Qqb4QEjICrDIisSv7n
	ISlvzEjI6KoBY+m69FCndZVj6MXfHP4aenLNJziL+GJ+KuX0vnxXzHoOJSLSKb8xWFHdrXZQE/0
	vbTB/SPa4LcuoNczq2bZaBi1dM8Y=
X-Gm-Gg: ASbGncsHdOf/XJBSELzNmCsZeDwq3LTFOFa7MtY+HqFQADdJHzbUJ5Z3WTzTADi2CDP
	cjc0C1KvB62mRGsTqSDnFBUlR65vtTUVXvUzB6w==
X-Google-Smtp-Source: AGHT+IFOlkCaNMhKwLIVGjAXnp0uVRePJEeesKmKskiAI+JnZrKpt43DpCfH7EY6KVkdOn4CDQWf6sVzJyMr5F4k2yg=
X-Received: by 2002:a17:902:ecc8:b0:20c:df08:9a78 with SMTP id
 d9443c01a7336-21892ab4fb8mr69822205ad.13.1734374882852; Mon, 16 Dec 2024
 10:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215122857.927606-1-karprzy7@gmail.com>
In-Reply-To: <20241215122857.927606-1-karprzy7@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2024 13:47:51 -0500
Message-ID: <CADnq5_NroGebRLLpdde9kvyeer8JWo1Yy9_0An3DO6TosPMfqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix potential integer overflow in scheduler
 mask calculations
To: Karol Przybylski <karprzy7@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, srinivasan.shanmugam@amd.com, 
	Hawking.Zhang@amd.com, Jack.Xiao@amd.com, lijo.lazar@amd.com, 
	Jesse.zhang@amd.com, tao.zhou1@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sun, Dec 15, 2024 at 7:38=E2=80=AFAM Karol Przybylski <karprzy7@gmail.co=
m> wrote:
>
> The use of 1 << i in scheduler mask calculations can result in an
> unintentional integer overflow due to the expression being
> evaluated as a 32-bit signed integer.
>
> This patch replaces 1 << i with 1ULL << i to ensure the operation
> is performed as a 64-bit unsigned integer, preventing overflow
>
> Discovered in coverity scan, CID 1636393, 1636175, 1636007, 1635853
>
> Fixes: c5c63d9cb5d3b drm/amdgpu: add amdgpu_gfx_sched_mask and amdgpu_com=
pute_sched_mask debugfs
> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 69a6b6dba0a5..8fb6c5f6a060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2050,7 +2050,7 @@ static int amdgpu_debugfs_gfx_sched_mask_set(void *=
data, u64 val)
>         if (!adev)
>                 return -ENODEV;
>
> -       mask =3D (1 << adev->gfx.num_gfx_rings) - 1;
> +       mask =3D (1ULL << adev->gfx.num_gfx_rings) - 1;
>         if ((val & mask) =3D=3D 0)
>                 return -EINVAL;
>
> @@ -2078,7 +2078,7 @@ static int amdgpu_debugfs_gfx_sched_mask_get(void *=
data, u64 *val)
>         for (i =3D 0; i < adev->gfx.num_gfx_rings; ++i) {
>                 ring =3D &adev->gfx.gfx_ring[i];
>                 if (ring->sched.ready)
> -                       mask |=3D 1 << i;
> +                       mask |=3D 1ULL << i;
>         }
>
>         *val =3D mask;
> @@ -2120,7 +2120,7 @@ static int amdgpu_debugfs_compute_sched_mask_set(vo=
id *data, u64 val)
>         if (!adev)
>                 return -ENODEV;
>
> -       mask =3D (1 << adev->gfx.num_compute_rings) - 1;
> +       mask =3D (1ULL << adev->gfx.num_compute_rings) - 1;
>         if ((val & mask) =3D=3D 0)
>                 return -EINVAL;
>
> @@ -2149,7 +2149,7 @@ static int amdgpu_debugfs_compute_sched_mask_get(vo=
id *data, u64 *val)
>         for (i =3D 0; i < adev->gfx.num_compute_rings; ++i) {
>                 ring =3D &adev->gfx.compute_ring[i];
>                 if (ring->sched.ready)
> -                       mask |=3D 1 << i;
> +                       mask |=3D 1ULL << i;
>         }
>
>         *val =3D mask;
> --
> 2.34.1
>

