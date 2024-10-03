Return-Path: <linux-kernel+bounces-349599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2633698F8D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4802B20B7B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645391AD41F;
	Thu,  3 Oct 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmDclLRu"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501A12EBDB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990569; cv=none; b=YcqZAxHj38f7FdrPE6OSrbAuGhoudlf+aZ2It1cvRpaqceRBmd1L6+HTVOiUxpAMNUTgSrH2ueNVTYqMq+THDrb0qL2PNGU5ZgneIUvRHVzl1nq9vQ2Nj9h7NpV/H+OwHy2ghdhGxyzul5K8/5XXABBcsnB2eDRuxGee4aEqR4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990569; c=relaxed/simple;
	bh=CNzahBkfjS3yRjvidpPb8V945drtuKMzb081jXD+MCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGMMp9DY8zsXTpiFTgeCaCMtKRAXTmEk0u1wa56Nhmqz3gg7I8AR/OkcVEZFaMf4GR1CXoyL00Ao5+HB9tGUOH4s1sdImorT/zWdQG3HHb64tYcmG+VNTJWsvc/CzwaOHWvqFlRNtKakpWTPdwuObzSuE2acCfPF7bqLprHDsOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmDclLRu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0ad414718so233526a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727990568; x=1728595368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8bMyDSFrLBNevUJ9LtMU8i6rbFbMQVqj25AXNIEIAk=;
        b=nmDclLRuqGEiNnZcLTvHEhcuo3XqlowCistI5tpseNgQmmEpLVDuaKeWHZOMVbSuoT
         rKH/sxO9axqiAjpIQ+1non+lo0akp8dWq4qAZp51PrWXnEZ0LRy83D74jHp0NVBGaH/e
         O1wRYqJT+NipfWIPMnxl4GURAquekkQSeFRKikOdnf/vzYjx7Y0/OJNmXOcNVRcl0upq
         RGWjz5gHwdFkIbsYNvqiYGFwkB/BIhIDQz/pn4SpGPnkFrwDpGBDFgk9xeWEIjbos8O9
         Uael5IW9VrC4adx1j/wrWVDuJlI+ABS1pd6t08wPj5Xl59D2uVVFwI2tfTN9W46/P2x/
         PRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727990568; x=1728595368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8bMyDSFrLBNevUJ9LtMU8i6rbFbMQVqj25AXNIEIAk=;
        b=YAWyAGDfStMsz+XDSj7/xU8pYWeG5+a8NzGT5CIUH3BI2qUJb7P128SN2OgYwCQXgB
         8Oqy9veZP9Utz2Gnj+5fJ+2APIkl6BehgjOdIar0vgUKzPmyRqpyYQImsUslYjVOt3cg
         Jqv6DRdfiPLliOvLwwQ6TALd1FH+mRZ2ZGmZHnlR/EQPguBazg6dp+qSIFEHGGe5AfBF
         80zRu/bmweHKrFMSYSDS7Nua3eQhmWqlGUO0gVZF73mLsKs7dvOuOXn7uC91Cpd6uaDK
         2yxCT0QF+WLdXfDQfd15gYmVs+tQZcW8zkjwF6q18UP58oMOPLGefwO0yfGulMX94wtX
         K56A==
X-Forwarded-Encrypted: i=1; AJvYcCVK7jneJu3RrIBpRMnhunaAvySkjSM95u1yGIrkEorRBTRjBx58BKcRkVrdKhWmkMzve9aAeub63pmA+88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUWdgvf2Db68mdoWVgCckQoxwmY4JsikkukeArfOMPJCLY2B/
	Kf9JFVzzn3/BPurf0lQlaLD8rfjRF5g5zSb2Y4BgTOLD8l6BQyuqRwmfX5qUD+zdvSY4O47vi+n
	F/gJAPh/2Z+oinK3+A9EMb9xmUEk=
X-Google-Smtp-Source: AGHT+IGTRPzNfQ/7+u7BSzM6FZnIvSZ1AWAcxUHxX7WRYTwAD2cHcF+DqMengiGIAam5tHXtqq5TtLp6rPq/ga4a6So=
X-Received: by 2002:a17:90b:310b:b0:2e0:9147:7dc1 with SMTP id
 98e67ed59e1d1-2e1e63636b6mr209190a91.6.1727990567826; Thu, 03 Oct 2024
 14:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003102623.11262-1-advaitdhamorikar@gmail.com> <c344f4ac-1ff2-4250-bf31-c17430675751@amd.com>
In-Reply-To: <c344f4ac-1ff2-4250-bf31-c17430675751@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Oct 2024 17:22:35 -0400
Message-ID: <CADnq5_OgZvTgUDvDqDikoUh28jTRm2mOAVV6zAEtWE9RHTFkyA@mail.gmail.com>
Subject: Re: [PATCH-next v2] Fix unintentional integer overflow
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>
Cc: Advait Dhamorikar <advaitdhamorikar@gmail.com>, alexander.deucher@amd.com, 
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com, 
	simona@ffwll.ch, leo.liu@amd.com, sathishkumar.sundararaju@amd.com, 
	saleemkhan.jamadar@amd.com, Veerabadhran.Gopalakrishnan@amd.com, 
	sonny.jiang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Oct 3, 2024 at 6:53=E2=80=AFAM Sundararaju, Sathishkumar
<sasundar@amd.com> wrote:
>
>
> The patch is Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.co=
m>
>
> Regards,
> Sathish
>
>
> On 10/3/2024 3:56 PM, Advait Dhamorikar wrote:
> > Fix shift-count-overflow in JPEG instance
> > multiplication. The expression's value may not be
> > what the programmer intended, because the expression
> > is evaluated using a narrower integer type.
> >
> > Fixes: f0b19b84d391 ("drm/amdgpu: add amdgpu_jpeg_sched_mask debugfs")
> > Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> > ---
> >   V1 -> V2: addressed review comments
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_jpeg.c
> > index 95e2796919fc..b6f0435f56ba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > @@ -357,7 +357,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void =
*data, u64 val)
> >       if (!adev)
> >               return -ENODEV;
> >
> > -     mask =3D (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_ri=
ngs)) - 1;
> > +     mask =3D ((uint64_t)1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.n=
um_jpeg_rings)) - 1;
> >       if ((val & mask) =3D=3D 0)
> >               return -EINVAL;
> >

