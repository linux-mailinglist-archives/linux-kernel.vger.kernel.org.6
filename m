Return-Path: <linux-kernel+bounces-513573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E3A34BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB0747A14B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2462040BA;
	Thu, 13 Feb 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag8zqumo"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899B15539A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467549; cv=none; b=b3o+gMsoXiIE9Zux8E23Ye5unQBRN6waUhsB2ygDByLanS42vrYMjiCvFJyFbdhTgTqH93oA4Eyz3Z9Dm+Kq26ZMm1pc0ZNawq2IMHXnohSE/PrOkdDCk7wdduGeNNraGNrHuZfsZit7AZpH9hHcrHAjfi77M/khyfYIOomn/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467549; c=relaxed/simple;
	bh=uwpwiqCLT5gFK2VhVvqP45RS70JxBw0ePzc6q7pp9ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XskxMygD6a8VBQomoV4qtu6bGbvRZddbWqxs9SPcSCyddcqERUU92Fk1p8rrvAhSf7BEJNobZuMTo9JaehW6q83fSGVWJtdCnCE3TrV2oC1R/M2kwqLJGdVYb/p5SgpgQDTD3NUX5F518cgS8dfF7bR+GYYfqgRMj7WwL4+jPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag8zqumo; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so259980a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739467547; x=1740072347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQt2nM6cOaVW5Z1WMLvj5xiaDRt1BJCGxPQlYjDOz6o=;
        b=ag8zqumo/OkctVckhy1vmLBP7rxhTeXwEiDTXzW87/pmtINfcmWV66UGlaiBAtWQuO
         tAIriDLv3cFt5/ERZX+XjWyNZHVnfRdVVuNE3FX06ngNwrRV78Xs/f+tnIaSh3FJLqTH
         nLFhYYwld5ID2n/fKzS4PnPXdVzW3xad0f5ewwbHpHrMPQk1JqSYKNet5+272B3raaz/
         kNGPlcyCaB9mPaN0ZySoRgUvHrOn7dqq3FvfB0Qd38KmtWAfV7QFmhdAQ1RNBg55uHN8
         T6Ynyvc5Mp+BIOrKuuS/Bew0vFFekfsyzmxzrJJpTerNblPkFkuXenKWxsEnks21mHxA
         5PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467547; x=1740072347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQt2nM6cOaVW5Z1WMLvj5xiaDRt1BJCGxPQlYjDOz6o=;
        b=N/cecwODpazCfR6kPvknNu9ovjbcNfzb/wa3Dy+GV8kNw60g7BZSTmjNspl6Su+ALo
         vhkOBj62lx3C7/n83iZoMVCgVmvth82pKu5nWzGVmd5r3Px6AsHjrLEKXBm095QfZvCy
         BKxjb2Lv8Cp0AfFi6wymxjCVli+znF7Mr5G6WovNSaIuL8AIyQsTyvgyrSE2MvZWkBEY
         fm+XZbiGrA4RltiEifUyzH3GYDyqnpNDxKFvYWdksnKbE95Istlr2unGSyRl0FPVRMMr
         9GThg+zLMxYhfli/7ET9fOK+JO/EqhKCYNSxDnEN77DQ0sG+p/axAHazpwgNPU/eRDN5
         zzEw==
X-Forwarded-Encrypted: i=1; AJvYcCWDYecdHj2lPwgaHALWfC/ECIPbiXwCgRdZ0cq0vrQIvGq6UTLeBKFZRCSdYNTdZ4actInwj2Qv43ncDYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1v5TdNy8XeAqYIB59yR03RdpYSQPVco8t38Yiy7c6USrHTKW+
	eQ46sHD/akSerqEIKSQAFjQrFT775JP6EZMaqHwUhWWXLCem7qRElxQkgK56Aht29uoQRNeR9h1
	8aRYB8t9gQk93Hx+aBADoBlgidg8=
X-Gm-Gg: ASbGnctLjsGluoVGZaXCPBSFlrarXvW1Y/Nop0GOYcVgsx+dLlYnSAFxVb9kVYiNahm
	ystw/zoM26NyuyMuOhCdzEHD9LN44w+0DGRtjG+cHdGyAr1lmhAx0IzNCj9zxdr+KAPcLX0V7
X-Google-Smtp-Source: AGHT+IFXvWUZJ8ux/coB6+6DORYP4GiTvYPhLeJSRObBqnhsCZxy4H5ck45V/JMFjHvHlduZEgQYUM/9+4w6ZhsfRxc=
X-Received: by 2002:a17:90b:3b52:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-2fbf5c8b19amr4557826a91.3.1739467546858; Thu, 13 Feb 2025
 09:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114135856.16192-1-n.zhandarovich@fintech.ru> <6a817784-f3d4-43c2-bd94-ac40c73e8583@fintech.ru>
In-Reply-To: <6a817784-f3d4-43c2-bd94-ac40c73e8583@fintech.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Feb 2025 12:25:35 -0500
X-Gm-Features: AWEUYZmJttkq0mujfO9Y3969oXZ6mahn5TvBiRDP8qiOPEi38mhs4JlPLzJtklE
Message-ID: <CADnq5_Pnj5t=1vyOfmJ6bMoeAqFQM1YyDpQn9GPEfxokjz-Vhw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/ci_dpm: Remove needless NULL checks of dpm tables
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 12:03=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Gentle ping :)

Was already applied:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/189abca05a89fc7b422811e=
497a7116b3e4f4dca

Thanks,

Alex

>
> On 1/14/25 16:58, Nikita Zhandarovich wrote:
> > This patch removes useless NULL pointer checks in functions like
> > ci_set_private_data_variables_based_on_pptable() and
> > ci_setup_default_dpm_tables().
> >
> > The pointers in question are initialized as addresses to existing
> > structures such as rdev->pm.dpm.dyn_state.vddc_dependency_on_sclk by
> > utilizing & operator and therefore are not in danger of being NULL.
> >
> > Fix this by removing extra checks thus cleaning the code a tiny bit.
> >
> > Found by Linux Verification Center (linuxtesting.org) with static
> > analysis tool SVACE.
> >
> > Fixes: cc8dbbb4f62a ("drm/radeon: add dpm support for CI dGPUs (v2)")
> > Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> > ---
> >  drivers/gpu/drm/radeon/ci_dpm.c | 34 ++++++++++-----------------------=
-
> >  1 file changed, 10 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/c=
i_dpm.c
> > index abe9d65cc460..7c3a960f486a 100644
> > --- a/drivers/gpu/drm/radeon/ci_dpm.c
> > +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> > @@ -3405,12 +3405,8 @@ static int ci_setup_default_dpm_tables(struct ra=
deon_device *rdev)
> >               &rdev->pm.dpm.dyn_state.cac_leakage_table;
> >       u32 i;
> >
> > -     if (allowed_sclk_vddc_table =3D=3D NULL)
> > -             return -EINVAL;
> >       if (allowed_sclk_vddc_table->count < 1)
> >               return -EINVAL;
> > -     if (allowed_mclk_table =3D=3D NULL)
> > -             return -EINVAL;
> >       if (allowed_mclk_table->count < 1)
> >               return -EINVAL;
> >
> > @@ -3468,24 +3464,20 @@ static int ci_setup_default_dpm_tables(struct r=
adeon_device *rdev)
> >       pi->dpm_table.vddc_table.count =3D allowed_sclk_vddc_table->count=
;
> >
> >       allowed_mclk_table =3D &rdev->pm.dpm.dyn_state.vddci_dependency_o=
n_mclk;
> > -     if (allowed_mclk_table) {
> > -             for (i =3D 0; i < allowed_mclk_table->count; i++) {
> > -                     pi->dpm_table.vddci_table.dpm_levels[i].value =3D
> > -                             allowed_mclk_table->entries[i].v;
> > -                     pi->dpm_table.vddci_table.dpm_levels[i].enabled =
=3D true;
> > -             }
> > -             pi->dpm_table.vddci_table.count =3D allowed_mclk_table->c=
ount;
> > +     for (i =3D 0; i < allowed_mclk_table->count; i++) {
> > +             pi->dpm_table.vddci_table.dpm_levels[i].value =3D
> > +                     allowed_mclk_table->entries[i].v;
> > +             pi->dpm_table.vddci_table.dpm_levels[i].enabled =3D true;
> >       }
> > +     pi->dpm_table.vddci_table.count =3D allowed_mclk_table->count;
> >
> >       allowed_mclk_table =3D &rdev->pm.dpm.dyn_state.mvdd_dependency_on=
_mclk;
> > -     if (allowed_mclk_table) {
> > -             for (i =3D 0; i < allowed_mclk_table->count; i++) {
> > -                     pi->dpm_table.mvdd_table.dpm_levels[i].value =3D
> > -                             allowed_mclk_table->entries[i].v;
> > -                     pi->dpm_table.mvdd_table.dpm_levels[i].enabled =
=3D true;
> > -             }
> > -             pi->dpm_table.mvdd_table.count =3D allowed_mclk_table->co=
unt;
> > +     for (i =3D 0; i < allowed_mclk_table->count; i++) {
> > +             pi->dpm_table.mvdd_table.dpm_levels[i].value =3D
> > +                     allowed_mclk_table->entries[i].v;
> > +             pi->dpm_table.mvdd_table.dpm_levels[i].enabled =3D true;
> >       }
> > +     pi->dpm_table.mvdd_table.count =3D allowed_mclk_table->count;
> >
> >       ci_setup_default_pcie_tables(rdev);
> >
> > @@ -4880,16 +4872,10 @@ static int ci_set_private_data_variables_based_=
on_pptable(struct radeon_device *
> >       struct radeon_clock_voltage_dependency_table *allowed_mclk_vddci_=
table =3D
> >               &rdev->pm.dpm.dyn_state.vddci_dependency_on_mclk;
> >
> > -     if (allowed_sclk_vddc_table =3D=3D NULL)
> > -             return -EINVAL;
> >       if (allowed_sclk_vddc_table->count < 1)
> >               return -EINVAL;
> > -     if (allowed_mclk_vddc_table =3D=3D NULL)
> > -             return -EINVAL;
> >       if (allowed_mclk_vddc_table->count < 1)
> >               return -EINVAL;
> > -     if (allowed_mclk_vddci_table =3D=3D NULL)
> > -             return -EINVAL;
> >       if (allowed_mclk_vddci_table->count < 1)
> >               return -EINVAL;
> >
>

