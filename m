Return-Path: <linux-kernel+bounces-337375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1E984940
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B222D285C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09511AC427;
	Tue, 24 Sep 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5PQ8iNQ"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2DA1AAE39
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194142; cv=none; b=qkOmwcDj0q7ncAP4X7mSZ4upJCo4esrhwDWwisgfkZvrKOCkpjjteR55mpU3/cWPD2h8lSvjHwchCARcsCiydygCHfhW6aysriOE3zCALQXDemXSmD2hWt9u55/6iYt7giFJEEZobsT3lEbdd5tYe32hPr1owUL+n5LSLMJdcvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194142; c=relaxed/simple;
	bh=KkmUzD1B3rTdMHQwTOB1+WCKsMotsvmbp0/GVAoTxJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbkDg63TMczzIVoPULcEWccJ0SKjleD92FGk607xLc/o5uYtICyPX7Z9c/fa50HLIzLd0p/EAEJqVI7Y1ZyRomsf3xtRZWSuLvbXYEijIxBjD8Okb0Jja5kqB34cBk+FDl7iBKxslX0NOLPm1p++pInwNnY3ux81Xw8PPxOpaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5PQ8iNQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718e0421143so1137071b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727194140; x=1727798940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWsuC1k58rgBxgEKQ95dKaFfehaSkHrV3qM3cnflsPg=;
        b=I5PQ8iNQ0qrF+JsgrBiX1drrJN4XXa+yWosGItkYVF0/hTvEH5ZF5Ezz5iYO0f2dCM
         t0n/zECBV/y6CKP5D3OOTZPYuxVtPR1WkPI1xEoDpAhFtST0/ORZvLJ2HfHAgoWe/q1o
         zA0+iHrhL9gwgHbcSqSnuix9QkVtsnRA8yrS6JpyDJoLc302nnn4cN7JfoRsR+tccKN0
         kay9+U26qZGj7xI3Q6R+6ww0Jh0Jy916OzzE+fv5LVb9MQlSByPKB2NeCrJe+hNiKVAY
         ZRSqTRTQoak52XOh8FGBmqv3But14+cURVSfiud5HnKEgJ45+ulIetaHFMvknPChe6V6
         X+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727194140; x=1727798940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWsuC1k58rgBxgEKQ95dKaFfehaSkHrV3qM3cnflsPg=;
        b=dkJrhfISqhySMG+DT8GvPbZMJb6HMinaBKp3PFcteyPTM7eWFMbBm8WmnH3y8984a9
         Io5SOSoAmFq6M9cmkVuxau3W/FLv1urtSltNIa3Y7glz9zb4zFXYQeQftBkZ4zs93XT6
         xa9eh5JGZ2kv+erflfQNihAfiHdOs8pWvGUYqYC72/EcYQPrc6ill80R8tYptZ4srkUH
         dtqKdkSA6dB6JmzmT71YuByDDgU43Al4C6tOPa733K7XxcIG4US8RYc8XD79tbmk6Syw
         c5Q3U5SsA6l1w/hrFeHWb/21j68ROkbMWyOCKu/zPdR14Mp9+7qCzo0enyO4VXDh0RRE
         Q0pg==
X-Forwarded-Encrypted: i=1; AJvYcCUjkXcEWGMzRI+0uFEZZF7mwKvQA0rg8PGfbJWpMVwkRSl7f5vIXEQ6JZjLYTJsvsXYnBCp2YQsYPjiuu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWj7ZMq58N6yrQBhAkNM1dhiDyR5RA20WePcPNjSxxg3tpyjW3
	yHA55dc2iMPx0nphRz1yAqd2YnCHKAFhZ5fma6z3hEV1ua1U/iquRTLtYnLqnzrlFTeeGqNpYSz
	1GEx3+BNby7X8v1R3Df0d76q/uo2GXQ==
X-Google-Smtp-Source: AGHT+IHOExPAGZCXFGmdvFYllAvrAWe+T33mgW0ydNW0IhFfuAjbsci12Zvgz4GCqe7jF+3muMjRPm97OHwCLHCD8KY=
X-Received: by 2002:a05:6a00:1889:b0:714:2051:89ea with SMTP id
 d2e1a72fcca58-71afb5c86bcmr2053630b3a.1.1727194139706; Tue, 24 Sep 2024
 09:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F25A139789E87C3E+20240920022755.1162495-1-wangyuli@uniontech.com> <ade271e8-2f6e-494b-979a-e53942b6b9a7@amd.com>
In-Reply-To: <ade271e8-2f6e-494b-979a-e53942b6b9a7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 12:08:47 -0400
Message-ID: <CADnq5_Pvq=W69KM08O4TOhG1fcQTO-KEE31KVqfsuOwJL9vv7w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix typo "acccess" and improve the comment
 style here
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: WangYuli <wangyuli@uniontech.com>, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com, 
	yifan1.zhang@amd.com, vitaly.prosyak@amd.com, Tim.Huang@amd.com, 
	Prike.Liang@amd.com, jesse.zhang@amd.com, lijo.lazar@amd.com, 
	Hawking.Zhang@amd.com, kevinyang.wang@amd.com, srinivasan.shanmugam@amd.com, 
	victorchengchi.lu@amd.com, Jiadong.Zhu@amd.com, tao.zhou1@amd.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, le.ma@amd.com, Wenhui.Sheng@amd.com, 
	Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Fri, Sep 20, 2024 at 2:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.09.24 um 04:27 schrieb WangYuli:
> > There are some spelling mistakes of 'acccess' in comments which
> > should be instead of 'access'.
> >
> > And the comment style should be like this:
> >   /*
> >    * Text
> >    * Text
> >    */
> >
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Link: https://lore.kernel.org/all/f75fbe30-528e-404f-97e4-854d27d7a401@=
amd.com/
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Link: https://lore.kernel.org/all/0c768bf6-bc19-43de-a30b-ff5e3ddfd0b3@=
suse.de/
> > Signed-off-by: WangYuli <wangyuli@uniontech.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 6 ++++--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 6 ++++--
> >   2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index d3e8be82a172..33fd2da49a2a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -1893,8 +1893,10 @@ static void gfx_v11_0_init_compute_vmid(struct a=
mdgpu_device *adev)
> >       soc21_grbm_select(adev, 0, 0, 0, 0);
> >       mutex_unlock(&adev->srbm_mutex);
> >
> > -     /* Initialize all compute VMIDs to have no GDS, GWS, or OA
> > -        acccess. These should be enabled by FW for target VMIDs. */
> > +     /*
> > +      * Initialize all compute VMIDs to have no GDS, GWS, or OA
> > +      * access. These should be enabled by FW for target VMIDs.
> > +      */
> >       for (i =3D adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; =
i++) {
> >               WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_BASE, 2 * i, 0);
> >               WREG32_SOC15_OFFSET(GC, 0, regGDS_VMID0_SIZE, 2 * i, 0);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index 408e5600bb61..57b55b6d797d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -1247,8 +1247,10 @@ static void gfx_v9_4_3_xcc_init_compute_vmid(str=
uct amdgpu_device *adev,
> >       soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
> >       mutex_unlock(&adev->srbm_mutex);
> >
> > -     /* Initialize all compute VMIDs to have no GDS, GWS, or OA
> > -        acccess. These should be enabled by FW for target VMIDs. */
> > +     /*
> > +      * Initialize all compute VMIDs to have no GDS, GWS, or OA
> > +      * access. These should be enabled by FW for target VMIDs.
> > +      */
> >       for (i =3D adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; =
i++) {
> >               WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID=
0_BASE, 2 * i, 0);
> >               WREG32_SOC15_OFFSET(GC, GET_INST(GC, xcc_id), regGDS_VMID=
0_SIZE, 2 * i, 0);
>

