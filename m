Return-Path: <linux-kernel+bounces-401859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB5E9C2039
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBC41F2499E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1302022FD;
	Fri,  8 Nov 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFzMJqjo"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618B2003D5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079107; cv=none; b=U9/rlf+dPjf2qi03NsXGnZcbnGCCYx0dC9WA0HO5kH+PZkqpu0EYB9GlJClEope7kA/S3pTm2f4gZYhrs4XeSdftO8F/+tOW6D89taMifsNrzEMqRLo0vO9ESCbQe+tFbxg+2cGNVNLtdUriPrqolBCiPFHu10NOdd5u9pHn4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079107; c=relaxed/simple;
	bh=JhGghDdZ7ClErjeyvREkPyDhktaOz+nvwo6tu9E24Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws/XkT/ato6L8nxr6Ug2ttFaWgA1dYZBH0lZc3uQdZ3IR0QnvvBDtymyTy9vR+MpKpOWz6rVA1Hluv3RyaYRjYfR4JmEhojDGcTODNWB0Tb8Ic/t8irpp0JsfJAUebAhTW3r2lihv7SVE8ibpLeTwwjQ5p0iTCL+4SursUQnzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFzMJqjo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e7131931dso125739b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731079105; x=1731683905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ztSpKe+LQpulamyWGR10ZiG7OBgDMtt+SUrCLR6C3M=;
        b=nFzMJqjo9os7EBbxD0lMdvshBdAJml/uCaqpuCLZt3bbbIcpf9YN2j/KwSkXWb7QiW
         rN0RVxoGLmLgDyfEOkpqw+zVEpy4wFy30SWzccPUyb5LGH3pCzHPiULsbouPTApOJyja
         twAYquF26+KmNVu+8U4Zt96anuYEA1FmnAbceVmNKw5e/f3FCXYeL8VKtzYLqTpUOgy+
         JgyDl9BG32uAZmfbnOCMxFIWSCN916kfJs32FMCksYhZDs7X1M75hv59rGHJlxsJwq/j
         tcP7DvIBK3wkBOC42ddm1M+jKBSA2VKIx8AZfAq8fL0/YfowupnXmutTzlWBLaVyhs+i
         2E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079105; x=1731683905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ztSpKe+LQpulamyWGR10ZiG7OBgDMtt+SUrCLR6C3M=;
        b=wl7+JyJxonqMuHqB1o5djpY6WdsPGBz3PA9heN8HwWlE4rCkBpawuHnocva8GkNkZu
         MkcAXgLHgi/p8PaXYV2rva5uFmFrs6Muu7TguQSDtcVUzFxljg1+kuTrEo3telReJaGS
         njJKA7q4wsCk+aaQKCQ5A0CMwwn4wDcImEKii7mhmUg3sAK8AvTYBicJ6vXZh7+6f/H7
         GYdTI0aMumVBGGityPeJERC8ichL+BjzFKbfLPeTblG4PmGj1bIzn/Wv0UusdwrrSWzB
         6g6w6ahS1shNS0vrfR/Qh+mjv+a4fzqtlygKB5MgqUm07J8FYZ9ekiETiyuBrVKkHVYk
         KPXw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Mi2Sc7sY77+X324gWDMY33+Os7isg1AVfIrNLTsrTw+NqVFDaIBarRXKCYlPGRcYd2qDRfAKywH1eAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNTFO0bhQT8JuU1ZIGJWDZPwT++mxk9oAPVzKIdyWWnidIBQS
	AlTXUZDh4gEUZYMPqbSryGWB4A4D9RjUO/jwnobDXlBCANgwnGRz0KWNrckMMchEoqtFjXGZByf
	0RpVhL0960YuE1bc7jFfogplKD7w=
X-Google-Smtp-Source: AGHT+IGalmBCBFBbCttGfKwAgL2JZxgJjBfbYNdkcVmz7yTC0ji3IWfKbBqyZ438BnH4DIaQKzJ215ynoQNwBNhM0PI=
X-Received: by 2002:a17:90b:3b87:b0:2e9:4a0c:252f with SMTP id
 98e67ed59e1d1-2e9b167f7edmr1948422a91.1.1731079104080; Fri, 08 Nov 2024
 07:18:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008191623.8171-1-advaitdhamorikar@gmail.com> <CAJ7bep+uo5_xF13e_1mYFMf1npWw1cTbcOe+f19avpjEPfyBqQ@mail.gmail.com>
In-Reply-To: <CAJ7bep+uo5_xF13e_1mYFMf1npWw1cTbcOe+f19avpjEPfyBqQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Nov 2024 10:18:12 -0500
Message-ID: <CADnq5_OCL7x7-m5y1RYwmFxH7XVssX_FK_59UmEiAK9thtLMQw@mail.gmail.com>
Subject: Re: [PATCH-next v3] drm/amdgpu: Cleanup shift coding style
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, leo.liu@amd.com, 
	sathishkumar.sundararaju@amd.com, saleemkhan.jamadar@amd.com, 
	sonny.jiang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!  Sorry for the delay.

Alex

On Fri, Nov 8, 2024 at 10:11=E2=80=AFAM Advait Dhamorikar
<advaitdhamorikar@gmail.com> wrote:
>
> Hello,
>
> I have addressed the previous comments,
> Is there something more that I need to address in this version of the pat=
ch?
> I would appreciate feedback.
>
> Best regards,
> Advait
>
> On Wed, 9 Oct 2024 at 00:46, Advait Dhamorikar
> <advaitdhamorikar@gmail.com> wrote:
> >
> > Improves the coding style by updating bit-shift
> > operations in the amdgpu_jpeg.c driver file.
> > It ensures consistency and avoids potential issues
> > by explicitly using 1U and 1ULL for unsigned
> > and unsigned long long shifts in all relevant instances.
> >
> >
> > Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> > ---
> > v1->v2: address review comments
> > https://lore.kernel.org/lkml/CAJ7bepJrm9tJJMSZXz0B_94y8817X4oFpwnrTmUHe=
agOFgVL7g@mail.gmail.com/
> > v2->v3: update changelog and add additional 1U cleanups
> > https://lore.kernel.org/lkml/CADnq5_OgZvTgUDvDqDikoUh28jTRm2mOAVV6zAEtW=
E9RHTFkyA@mail.gmail.com/
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_jpeg.c
> > index 95e2796919fc..995bc28b4fe6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> > @@ -47,7 +47,7 @@ int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
> >                 adev->jpeg.indirect_sram =3D true;
> >
> >         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
> > -               if (adev->jpeg.harvest_config & (1 << i))
> > +               if (adev->jpeg.harvest_config & (1U << i))
> >                         continue;
> >
> >                 if (adev->jpeg.indirect_sram) {
> > @@ -73,7 +73,7 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
> >         int i, j;
> >
> >         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > -               if (adev->jpeg.harvest_config & (1 << i))
> > +               if (adev->jpeg.harvest_config & (1U << i))
> >                         continue;
> >
> >                 amdgpu_bo_free_kernel(
> > @@ -110,7 +110,7 @@ static void amdgpu_jpeg_idle_work_handler(struct wo=
rk_struct *work)
> >         unsigned int i, j;
> >
> >         for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> > -               if (adev->jpeg.harvest_config & (1 << i))
> > +               if (adev->jpeg.harvest_config & (1U << i))
> >                         continue;
> >
> >                 for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j)
> > @@ -357,7 +357,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void =
*data, u64 val)
> >         if (!adev)
> >                 return -ENODEV;
> >
> > -       mask =3D (1 << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jpeg_=
rings)) - 1;
> > +       mask =3D (1ULL << (adev->jpeg.num_jpeg_inst * adev->jpeg.num_jp=
eg_rings)) - 1;
> >         if ((val & mask) =3D=3D 0)
> >                 return -EINVAL;
> >
> > @@ -388,7 +388,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_get(void =
*data, u64 *val)
> >                 for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> >                         ring =3D &adev->jpeg.inst[i].ring_dec[j];
> >                         if (ring->sched.ready)
> > -                               mask |=3D 1 << ((i * adev->jpeg.num_jpe=
g_rings) + j);
> > +                               mask |=3D 1ULL << ((i * adev->jpeg.num_=
jpeg_rings) + j);
> >                 }
> >         }
> >         *val =3D mask;
> > --
> > 2.34.1
> >

