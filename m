Return-Path: <linux-kernel+bounces-387082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B799B4BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB82A1C233AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D17206E9D;
	Tue, 29 Oct 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMV0g4aU"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C61206E82
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210555; cv=none; b=YyGnpzTyX24FF5gKDIQssd2xjuQXStjaDAg52q2W5CcwdPApJeO64Jh5tsSZ+umkeXqsgBC/hNhxC5mOLW7+p4socjo27jeSFDPdpB9hSpHyjYzj45j2vGE0pxd5N9DDXbc1hTWzlFmtwqvyd2LZupMiZaO5kEtSFveXnq1xFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210555; c=relaxed/simple;
	bh=H2b3tZz2B7fmvb9WHk67+/ICXA4VUSZNHlWDL2gFBQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8pIO0oS6cB4vRUpX9mT2Eo14LntX1LEx11qsU1x6OjykEAEqp/qntbtX7BH+h2oGUDgy9A+U36cd46NQwu0nhUuX2Vkq+9M3z2B/QKxRqsvtgxX/JUSpfa5MI5Nxiuc3BJfwEVw6yXu6uDc4xmr96VtK+qnTEAv9YM4XGzEyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMV0g4aU; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e7131931dso336810b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730210552; x=1730815352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2OqKfzRqS2oj2sN68Xg9PC17To96WoL3aUxN4+A/rM=;
        b=lMV0g4aUW6wBSShvwrdlYguGbF34Kv01OlC+tBq9JmfeaH0I8AW0zBOn/7qgx5IC1k
         QU64mx1ho/uDZsD5k1/NMlWmIR142a145H/N3SqjjqOn/0iGzDu2f40zoNB61thwvFt9
         4r/UB1Pgh8syCQyS1xuVITegEJQXoKSq8HQo5EzfjiTZfNd6a+wT0aXWwrWMMHhy/wj7
         ykMku/I21VQSPo6zrYZ/u7cVt1JaDYKwgo7t9hBG1BJVVUL6TrV+dHZ32H0EbXTn23dd
         kE2iR9e4UeI04TAYl8j6Ee/wCuCp4hq3mGXkRYm3n103gAKiNgkB+M8ighb0j2C21Lyp
         pl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210552; x=1730815352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2OqKfzRqS2oj2sN68Xg9PC17To96WoL3aUxN4+A/rM=;
        b=tg7uUpBVjwy0sKCJ3jPIQ509CfKJN1sMTq5sFaI2gKSbbBPC9YN+VrEmv907JqAXTH
         fUfBnRL+Tip2cku732HB2avr20IIG67bHK2dTI1Uj0CkUbt8S0T2lPjK6PFb6yOVeRNy
         jkBVZDnBI8ij1nue2KxdeajqAJUYPWz6IUWQ5Ijm5/IfyfVzEm8brNtbW+ub+bxTMfhj
         LwgPU/1ea5/0+UOCQwg5Gj14BLqrRUJ3UFHmBpiNwhBpeox1t921sOsgqsHlz2qnV9w8
         f5c7ktcbK2g7FzmRna1u26IugUZ+4+RiKYi0DbsXDvPup0LhhLZctz9sCceaNNhyOxFL
         wgwA==
X-Forwarded-Encrypted: i=1; AJvYcCWp2ehy74PYE5CyzOAOcIgVrsLFriENA/mR0Eeex87Ml6U+zMVUvOMDdIUyVYQunxhj2d6RXsczbZgc0U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWxJr2oqiIxPYjxL0JwPrkOMa0yeLww3N1FWfKQWmUeutAAS5
	0ccUJr3qXoyxR3cJ1UbtRH702ubqp/iTeqVtopOzbDQxlZvxWBI+AS1G09zM0txKKKdrFQ1Se+r
	sZOtlUY2BcTBtl3I4n8iv29Bow7g=
X-Google-Smtp-Source: AGHT+IEcGWT3kLWKK2rQeP5CpXTBUNLrvmNdqQLI1ZZI+jM2ngZukzu2bKOrNjGXTRPhUfHPZkgIYZQYYI/CtjrIlZA=
X-Received: by 2002:a05:6a20:7492:b0:1cf:4903:7f66 with SMTP id
 adf61e73a8af0-1d9a83af7e3mr7955777637.2.1730210552148; Tue, 29 Oct 2024
 07:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029202758.2764535-1-lihuafei1@huawei.com>
In-Reply-To: <20241029202758.2764535-1-lihuafei1@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 10:02:20 -0400
Message-ID: <CADnq5_OunQkNHuc_5ur=LqCzVFoBoiCsc9CcZGGTa-vDPFht=g@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix the memory allocation issue in amdgpu_discovery_get_nps_info()
To: Li Huafei <lihuafei1@huawei.com>
Cc: alexander.deucher@amd.com, lijo.lazar@amd.com, 
	christophe.jaillet@wanadoo.fr, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, Hawking.Zhang@amd.com, 
	yifan1.zhang@amd.com, Likun.Gao@amd.com, Tim.Huang@amd.com, 
	pratap.nirujogi@amd.com, victorchengchi.lu@amd.com, Jun.Ma2@amd.com, 
	le.ma@amd.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:53=E2=80=AFAM Li Huafei <lihuafei1@huawei.com> wr=
ote:
>
> Fix two issues with memory allocation in amdgpu_discovery_get_nps_info()
> for mem_ranges:
>
>  - Add a check for allocation failure to avoid dereferencing a null
>    pointer.
>
>  - As suggested by Christophe, use kvcalloc() for memory allocation,
>    which checks for multiplication overflow.
>
> Additionally, assign the output parameters nps_type and range_cnt after
> the kvcalloc() call to prevent modifying the output parameters in case
> of an error return.
>
> Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
> Changes in v3:
>  - As suggested by Christophe, replace kvzalloc() with kvcalloc()
>  - Link to v2: https://lore.kernel.org/lkml/20241029101839.2605713-1-lihu=
afei1@huawei.com/
>
> Changes in v2:
>  - kvzalloc() call uses 'nps_info->v1.count' instead of '*range_cnt'
>  - Link to v1: https://lore.kernel.org/lkml/20241028215933.2599271-1-lihu=
afei1@huawei.com/

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 4bd61c169ca8..620090f092ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_d=
evice *adev,
>
>         switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>         case 1:
> +               mem_ranges =3D kvcalloc(nps_info->v1.count,
> +                                     sizeof(struct amdgpu_gmc_memrange),
> +                                     GFP_KERNEL);
> +               if (!mem_ranges)
> +                       return -ENOMEM;
>                 *nps_type =3D nps_info->v1.nps_type;
>                 *range_cnt =3D nps_info->v1.count;
> -               mem_ranges =3D kvzalloc(
> -                       *range_cnt * sizeof(struct amdgpu_gmc_memrange),
> -                       GFP_KERNEL);
>                 for (i =3D 0; i < *range_cnt; i++) {
>                         mem_ranges[i].base_address =3D
>                                 nps_info->v1.instance_info[i].base_addres=
s;
> --
> 2.25.1
>

