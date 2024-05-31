Return-Path: <linux-kernel+bounces-197296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0718D68F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786011F23BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673717D343;
	Fri, 31 May 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoW73p0Q"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877017CA03;
	Fri, 31 May 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179643; cv=none; b=GP1rltx+EHCJ+UQAQbKNZlWCOpffMDjxPjJLY2zHlpfn9IgzRXyb75UBJmY/ML7SNYaHUM2XrpOh0vwN+Lmd8sp0UYWXQBaLWXBnU4+BnsuznrzVHAMBPpVqTZYtZs9GOg9/4MSiZOFzALfNKAAHKuYm4D7igJFxtEWGWWgR4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179643; c=relaxed/simple;
	bh=H6k9KopKfaFWOB0CAQg8qAB9APDD+0DUxxv1gA1s2AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hpwzk166asd6D1++d8PfaJmmO3YVkRclOYQUYz+JojkyDE2ghQBZMewUGIbw5v/KEhGQy+rgyzNwl4dXRzzE8fAMaQlPs10rOYlwOG4FjazF8oewRijDfCYUxkg5kb1d4X1e6WiPTS30j3hmSr2ZpLTjW5dBB5RDMlv60L5KysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoW73p0Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07acd3so21190505ad.0;
        Fri, 31 May 2024 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717179641; x=1717784441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6doFFCcSTAte6ymfy+Igul1WrbfPbryjlzogNwwZ8rc=;
        b=SoW73p0Qjz5jLJzxWbjj6AO6GXjyN+TmkVgjfOdAsSAffsvSrws03n+qyK8ceiinfS
         tOigU80HGsH59BOlBGSol77xxenUoQg4l2zaYW8Uh5oTQfvLfVZPK5TXFx6TbjCdWQQF
         AVWAscWR50YCP2btJx+5R+rrrbRppl8Q14zRCtfPAG2V5Chq3v9Anw/bfugzzxYr/zzA
         tyhs2DL9/d9qxFDTBraIIaL9ttd0wiEQHr+jo0EGfvlxcZBKwo4+Kg4KEoikTe5djpic
         wlHVlA8sxVTH+TjZo5Nn3c7RXSPArhJbX3VzZkHxvJokjzZjSmvA6TUrz6/UaanTivBX
         nGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717179641; x=1717784441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6doFFCcSTAte6ymfy+Igul1WrbfPbryjlzogNwwZ8rc=;
        b=GEBY9ESCjXgoqJENENbS+fzM+5RJRl7gy6ImKFCDHsFbQW8BPaxnvcd6JnjE2BxAwZ
         napq0V195NfFcwIMHK7/U3m3Yk4reNzr8Iq9RPb6tKcisA0gOaRhevhdOxFL4Y4nb52/
         PDE0hhexf3OtxwlWzwBO1/pZ4P5g6/2SUFCorU6kk2i7cLBNg5ho/GnJ6DJ0t6hPzAoY
         b7CXXusd4LsSbZtARwkdyN+sJKwU/MqAdkUp17M1/i0Z8tUnOybM7vH9+WRjlu031ltE
         Zv8siSNk5+wDjDpgQni8Q4r7rAC0Lszwf8S7fMp5Iw0m9wAV/akjiq1lpQMk+w/Mc+Do
         h3lg==
X-Forwarded-Encrypted: i=1; AJvYcCXxhhKpAY0WWlTsVlvWduNVH7jFbDuXZIB+EHoC8nCB6bSnt6zAhOJ+pD8Lc+1HggC7YlDpXqfc6e+9hPAeFs+Y2Pr/taGGqGIhRAhblvbgbv1X06g2W6+LYCe9BFa9OiOL7Vv98f1taqe411Nd
X-Gm-Message-State: AOJu0Yy9BDFmFNmXHn58ocTCBaEuQ6mmLRAHGdByXAcA4aiDVTYlbugQ
	A/xDnhDgTt1Awl1Of02hMIl8d931/bwCZUpf8orujDjTFHOFjI+ZLPcAPxApyEL5/ENg5k5HlIp
	1kwYko1azPzH8qs5fGCQRsI0IidI=
X-Google-Smtp-Source: AGHT+IFm/2TDsh9LMWk94O1lQr2/13xsjHvxYZ/V/XYrcs9yi3UE8PDmZqtliFdCgZmSTEh5hgjlk0ut9L+Hwo3E9co=
X-Received: by 2002:a17:902:f7c5:b0:1f4:8363:a6fc with SMTP id
 d9443c01a7336-1f6370203aemr24549975ad.25.1717179641457; Fri, 31 May 2024
 11:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531093211.498880-1-colin.i.king@gmail.com> <833fac2c-91f9-4e9a-9b9e-da2db955a488@infradead.org>
In-Reply-To: <833fac2c-91f9-4e9a-9b9e-da2db955a488@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 31 May 2024 14:20:29 -0400
Message-ID: <CADnq5_NCA31yex7Ye=hoVbMkpCzbgpBJvGrGub+AQ1jQBcCeCA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix a handful of spelling mistakes
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Fri, May 31, 2024 at 11:37=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 5/31/24 2:32 AM, Colin Ian King wrote:
> > There are a few spelling mistakes in dml2_printf messages. Fix them.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
> Thanks.
>
> > ---
> >  .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c      | 6 +++---
> >  .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c  | 6 +++---
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dm=
l2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_c=
ore/dml2_core_dcn4_calcs.c
> > index 8062144a5a6d..e7e6751f4477 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> > @@ -5731,7 +5731,7 @@ static bool CalculatePrefetchSchedule(struct dml2=
_core_internal_scratch *scratch
> >               dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->Tim=
eForFetchingVM);
> >               dml2_printf("DML: Tr0: %fus - time to fetch first row of =
data pagetables\n", s->TimeForFetchingRowInVBlank);
> >               dml2_printf("DML: Tsw: %fus =3D time to fetch enough pixe=
l data and cursor data to feed the scalers init position and detile\n", (do=
uble)s->LinesToRequestPrefetchPixelData * s->LineTime);
> > -             dml2_printf("DML: To: %fus - time for propogation from sc=
aler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (d=
ouble)p->myPipe->HTotal)) * s->LineTime);
> > +             dml2_printf("DML: To: %fus - time for propagation from sc=
aler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (d=
ouble)p->myPipe->HTotal)) * s->LineTime);
> >               dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tp=
re - To > 0\n");
> >               dml2_printf("DML: Tslack(pre): %fus - time left over in s=
chedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeF=
orFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScale=
r) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->=
TSetup);
> >               dml2_printf("DML: row_bytes =3D dpte_row_bytes (per_pipe)=
 =3D PixelPTEBytesPerRow =3D : %u\n", p->PixelPTEBytesPerRow);
> > @@ -8268,7 +8268,7 @@ static bool dml_core_mode_support(struct dml2_cor=
e_calcs_mode_support_ex *in_out
> >       dml2_printf("DML::%s: mode_lib->ms.DCFCLK =3D %f\n", __func__, mo=
de_lib->ms.DCFCLK);
> >       dml2_printf("DML::%s: mode_lib->ms.FabricClock =3D %f\n", __func_=
_, mode_lib->ms.FabricClock);
> >       dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz =3D %f\n", __fun=
c__, mode_lib->ms.uclk_freq_mhz);
> > -     dml2_printf("DML::%s: urgent latency tolarance =3D %f\n", __func_=
_, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kb=
ytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)=
));
> > +     dml2_printf("DML::%s: urgent latency tolerance =3D %f\n", __func_=
_, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kb=
ytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)=
));
> >  #endif
> >
> >       mode_lib->ms.support.OutstandingRequestsSupport =3D true;
> > @@ -11089,7 +11089,7 @@ static bool dml_core_mode_programming(struct dm=
l2_core_calcs_mode_programming_ex
> >                               if (display_cfg->plane_descriptors[k].imm=
ediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] =3D=3D false) =
{
> >                                       mode_lib->mp.ImmediateFlipSupport=
ed =3D false;
> >  #ifdef __DML_VBA_DEBUG__
> > -                                     dml2_printf("DML::%s: Pipe %0d no=
t supporing iflip!\n", __func__, k);
> > +                                     dml2_printf("DML::%s: Pipe %0d no=
t supporting iflip!\n", __func__, k);
> >  #endif
> >                               }
> >                       }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dm=
l2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/=
dml2_core_shared.c
> > index f2e2250d28d3..6eb3fec87ec1 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core=
_shared.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core=
_shared.c
> > @@ -1988,7 +1988,7 @@ bool dml2_core_shared_mode_support(struct dml2_co=
re_calcs_mode_support_ex *in_ou
> >       dml2_printf("DML::%s: mode_lib->ms.FabricClock =3D %f\n", __func_=
_, mode_lib->ms.FabricClock);
> >       dml2_printf("DML::%s: mode_lib->ms.uclk_freq_mhz =3D %f\n", __fun=
c__, mode_lib->ms.uclk_freq_mhz);
> >       dml2_printf("DML::%s: max_urgent_latency_us =3D %f\n", __func__, =
mode_lib->ms.support.max_urgent_latency_us);
> > -     dml2_printf("DML::%s: urgent latency tolarance =3D %f\n", __func_=
_, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kb=
ytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)=
));
> > +     dml2_printf("DML::%s: urgent latency tolerance =3D %f\n", __func_=
_, ((mode_lib->ip.rob_buffer_size_kbytes - mode_lib->ip.pixel_chunk_size_kb=
ytes) * 1024 / (mode_lib->ms.DCFCLK * mode_lib->soc.return_bus_width_bytes)=
));
> >  #endif
> >
> >       mode_lib->ms.support.OutstandingRequestsSupport =3D true;
> > @@ -8131,7 +8131,7 @@ static bool CalculatePrefetchSchedule(struct dml2=
_core_internal_scratch *scratch
> >               dml2_printf("DML: Tvm: %fus - time to fetch vm\n", s->Tim=
eForFetchingVM);
> >               dml2_printf("DML: Tr0: %fus - time to fetch first row of =
data pagetables\n", s->TimeForFetchingRowInVBlank);
> >               dml2_printf("DML: Tsw: %fus =3D time to fetch enough pixe=
l data and cursor data to feed the scalers init position and detile\n", (do=
uble)s->LinesToRequestPrefetchPixelData * s->LineTime);
> > -             dml2_printf("DML: To: %fus - time for propogation from sc=
aler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (d=
ouble)p->myPipe->HTotal)) * s->LineTime);
> > +             dml2_printf("DML: To: %fus - time for propagation from sc=
aler to optc\n", (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScaler) / (d=
ouble)p->myPipe->HTotal)) * s->LineTime);
> >               dml2_printf("DML: Tvstartup - TSetup - Tcalc - TWait - Tp=
re - To > 0\n");
> >               dml2_printf("DML: Tslack(pre): %fus - time left over in s=
chedule\n", p->VStartup * s->LineTime - s->TimeForFetchingVM - 2 * s->TimeF=
orFetchingRowInVBlank - (*p->DSTYAfterScaler + ((double)(*p->DSTXAfterScale=
r) / (double)p->myPipe->HTotal)) * s->LineTime - p->TWait - p->TCalc - *p->=
TSetup);
> >               dml2_printf("DML: row_bytes =3D dpte_row_bytes (per_pipe)=
 =3D PixelPTEBytesPerRow =3D : %u\n", p->PixelPTEBytesPerRow);
> > @@ -10959,7 +10959,7 @@ bool dml2_core_shared_mode_programming(struct d=
ml2_core_calcs_mode_programming_e
> >                               if (display_cfg->plane_descriptors[k].imm=
ediate_flip && mode_lib->mp.ImmediateFlipSupportedForPipe[k] =3D=3D false) =
{
> >                                       mode_lib->mp.ImmediateFlipSupport=
ed =3D false;
> >  #ifdef __DML_VBA_DEBUG__
> > -                                     dml2_printf("DML::%s: Pipe %0d no=
t supporing iflip!\n", __func__, k);
> > +                                     dml2_printf("DML::%s: Pipe %0d no=
t supporting iflip!\n", __func__, k);
> >  #endif
> >                               }
> >                       }
>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html

