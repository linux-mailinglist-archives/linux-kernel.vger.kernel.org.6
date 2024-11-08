Return-Path: <linux-kernel+bounces-401846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC79C2018
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B8A1F224C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCB11F582A;
	Fri,  8 Nov 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2vofTIF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D138DC8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078697; cv=none; b=t1viVZ9oQ/UVsMa1M1dA15oql7RKlallr4ZqF+oxcVO8SdtI2RLzJuwpo6pT0VINsos46kRI9yGt3Hhn2DweRWlBRc6Ukp++EAOPp7CRmN7FI4E+BPQ0QCEISFX9L82Oua3PFipzBzn1hrWSeTLXk5y6lFBbJC2CitdhmhhLcbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078697; c=relaxed/simple;
	bh=zh4iVryS4Zr0VYvZS29kIhU11GmtplA78rUgXVKd/OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgVWBmX/keq3bkFt3XcFs8UPP9JOIRUAwuLP78PaH+DCXF5Lk6mhrcMvWhWgCd08cJcP2J6SZbR+cP2RVfIQ5n+HeVh1GD2as26CRyZC9kKOMfVZMTNH5eN2h5STXd7m6+MR0oFXgitFBogwTXgSM3x+45k+FUg/P5p3VU9nrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2vofTIF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53c779ef19cso2760670e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731078693; x=1731683493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U5wDavXbl6kHrtWLmw1AnY676L6vtteGxwlVTc97ABE=;
        b=c2vofTIF92qV+6OymHNpv/kX9Pr8IKi9KlyN4fX3SdV+jFHf0FE1xDz8VdhDdxajC+
         gdE3CZsL+MHKr7mA071XGFAKPdlBZ2sL1wE6u7n/TAyNHPk/lHkdQZ7quw99hvHRsi6b
         79P+3sbN4niUC0ZW2M3gXVIBSBCinejDC5XwOCrgwohIuUmEvLywFQEshWCDpzAs3ZZM
         yqhJK6Olt2hp50zZQDHtjJljCYUeA3WrLx4BXVHAjXfOhZhTGo+45AB/y43DHNPCsv2c
         UXji2WjmJ3QhlIdHMyi/QxTVloUgMloeUBrcfS/tCkLTelY9V6SrwJE70NoVK8JEmr+g
         3Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731078693; x=1731683493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5wDavXbl6kHrtWLmw1AnY676L6vtteGxwlVTc97ABE=;
        b=dSIueYwE5ocjYzKOYvShf6U+rvgYVnEhAD0tkeZMrt9Jwl/dhYlSf99+dK2yxQzKWI
         yN7umzt1QorOrpwadvGrz4sC+L/XXBuJy+ztpDADH/agUSufUvdmrRcoQy6hBzb1T3m4
         6maxGC+WEOdS3qBdab3yNZ2Ckrh7D1rgwRmELh1Rp/NIhsGvrccd7MrXsPf1wOgaMPB3
         3xi+9djgOKGQBzLqsuHWL7Pz7yZct/A1MAUNXHbAEkijT3V+g80pkY9d0l5GHjjFI0kL
         R9ds9kwOYBF1qA47+KOtO6E1q9gf3t/a6UhokvC+6JU2zZW6DySm9e0tAuSQeluwoYnY
         X7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXF1p53huAyjugPOwgoSdxWrWhn3gOBv93w2yGkVJEWrJr32csE0YeaPYeCnd6A9jVNufZGT6ddFgAPko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIHdHas0bLb1HLrXcgGbvS3BAtm1Z/sSUZdN1bNOVsq4Q7s8z
	9mF1VkZmyumqkvziK20OEmUe07S/zFcS/0WFIWUisTqZHiJZ9z6JQDnVcLlMOQyRCcq0SkjYecJ
	JdV5SXAEninSZvt9ejjQ/ntbc9oc=
X-Google-Smtp-Source: AGHT+IFv1gGClUgaEFptD5aM84mK3BN5LEkQyWsHQYYxxMAYDUMP/jNYEp4MzOiR4NVSTBa+hEA59v81vDQSmAp5+gQ=
X-Received: by 2002:a05:651c:2212:b0:2fb:556c:fdfc with SMTP id
 38308e7fff4ca-2ff2021eea6mr18749581fa.12.1731078692816; Fri, 08 Nov 2024
 07:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008191623.8171-1-advaitdhamorikar@gmail.com>
In-Reply-To: <20241008191623.8171-1-advaitdhamorikar@gmail.com>
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Date: Fri, 8 Nov 2024 20:41:21 +0530
Message-ID: <CAJ7bep+uo5_xF13e_1mYFMf1npWw1cTbcOe+f19avpjEPfyBqQ@mail.gmail.com>
Subject: Re: [PATCH-next v3] drm/amdgpu: Cleanup shift coding style
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, leo.liu@amd.com, 
	sathishkumar.sundararaju@amd.com, saleemkhan.jamadar@amd.com, 
	sonny.jiang@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I have addressed the previous comments,
Is there something more that I need to address in this version of the patch?
I would appreciate feedback.

Best regards,
Advait

On Wed, 9 Oct 2024 at 00:46, Advait Dhamorikar
<advaitdhamorikar@gmail.com> wrote:
>
> Improves the coding style by updating bit-shift
> operations in the amdgpu_jpeg.c driver file.
> It ensures consistency and avoids potential issues
> by explicitly using 1U and 1ULL for unsigned
> and unsigned long long shifts in all relevant instances.
>
>
> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
> v1->v2: address review comments
> https://lore.kernel.org/lkml/CAJ7bepJrm9tJJMSZXz0B_94y8817X4oFpwnrTmUHeagOFgVL7g@mail.gmail.com/
> v2->v3: update changelog and add additional 1U cleanups
> https://lore.kernel.org/lkml/CADnq5_OgZvTgUDvDqDikoUh28jTRm2mOAVV6zAEtWE9RHTFkyA@mail.gmail.com/
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 95e2796919fc..995bc28b4fe6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -47,7 +47,7 @@ int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
>                 adev->jpeg.indirect_sram = true;
>
>         for (i = 0; i < adev->jpeg.num_jpeg_inst; i++) {
> -               if (adev->jpeg.harvest_config & (1 << i))
> +               if (adev->jpeg.harvest_config & (1U << i))
>                         continue;
>
>                 if (adev->jpeg.indirect_sram) {
> @@ -73,7 +73,7 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>         int i, j;
>
>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -               if (adev->jpeg.harvest_config & (1 << i))
> +               if (adev->jpeg.harvest_config & (1U << i))
>                         continue;
>
>                 amdgpu_bo_free_kernel(
> @@ -110,7 +110,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>         unsigned int i, j;
>
>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -               if (adev->jpeg.harvest_config & (1 << i))
> +               if (adev->jpeg.harvest_config & (1U << i))
>                         continue;
>
>                 for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j)
> @@ -357,7 +357,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
>         if (!adev)
>                 return -ENODEV;
>
> -       mask = (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
> +       mask = (1ULL << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_rings)) - 1;
>         if ((val & mask) == 0)
>                 return -EINVAL;
>
> @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void *data, u64 *val)
>                 for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>                         ring = &adev->jpeg.inst[i].ring_dec[j];
>                         if (ring->sched.ready)
> -                               mask |= 1 << ((i * adev->jpeg.num_jpeg_rings) + j);
> +                               mask |= 1ULL << ((i * adev->jpeg.num_jpeg_rings) + j);
>                 }
>         }
>         *val = mask;
> --
> 2.34.1
>

