Return-Path: <linux-kernel+bounces-182313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 200B18C898B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B38B6B2183E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771D12F5A7;
	Fri, 17 May 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2H+UFAH"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4FC12F591
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960790; cv=none; b=Cu+8MRdtJXvkNTWzWpx/G/uakv05ScItN2YSp7O8xNtZo6YW6y4G9+tUGLgcmQys1DUslhjIouKAFuwFLradl7N2pC3jnx7XdfBjj+YlhysOHWzHxtBEYVZMHg7dRSiffy0+qz258gLwYOsa3nRGM7z6QSNOMVwD9Yf+/A9+r0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960790; c=relaxed/simple;
	bh=L+/cqJrfLgz1kjou+NmF9NFKoLdY5p3cQhtaNnEuh5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKKJHv+7fX4O8rGaYzgsFnKP8fGJUd9pUWGkjjVeG66vvzy4lCtwagFloyCdJ6n621q8RMlzh/xo9FBy/ASF4MEJNAahLamSRxoUfMr64LQY7Xxo28mlGA7z6J4c24QLXcfIpHRHyscL2tWv7lnyTwhi/GHKt4MClFwSlTGDbYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2H+UFAH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec486198b6so12109295ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715960788; x=1716565588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgpuDYI8j+33tJ7Dk5uqzFwntZEb5ZpRgbewCzVqOoQ=;
        b=F2H+UFAHtsLTpHJ++449q8j4Zki8P5I6kcDQZzzSGItv4OMoFUYHfeDBFfxuhbLYUU
         TzK2A5mekil7v+566mPr0PfEJS0nv5DF+ojXiYZxri8HFRH4GRMEG8CwvqkGD71oujz5
         CgMNtgAvDGbiEdfF8coNPQQ4dEBQVi1Au7RVLJq+SODxw8gnFseP1SgWkuWaSGdsqHJf
         L+K6KDeL5s/N+3puJSAMe2V0UXIvRQxfWlQyPycF9vuL52J+bil2Mra8mWOb3Z6tY8BA
         6ibaukpghoW24B7ae083FuJLf7GYtjq/gNS7OSWArD6zinITXAXMQ+hs1jlj0fkU5bxm
         gsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715960788; x=1716565588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgpuDYI8j+33tJ7Dk5uqzFwntZEb5ZpRgbewCzVqOoQ=;
        b=sSaRA4x48MJtTt+0NcvMsfCPFsqaVfVAnr6Um3lzMY6/sQYWGKSZkUBF0K9UbpqGeJ
         9TBRExe7NavP4Jq4Ncaw3rkvJYRoK0am1XV50OyYg83G+lj60Y00qyDNGpIjnPWZUMQl
         tEWF2OlxReHbzAhngjFea9kywOtDndv23PxSCA1v4n8OMQIz2JtRz/4qus10SvWS6otj
         FrHuOLJQsm+vNgPDvsWWohpdpVUmpxibcy4nuN7tY4bdGC2x/qfyCraSLSmBKu9Ha22U
         qESBvFZE95eWi4Hr3Xy0s/NmDmdDjz4Lt9iCk6qpdl8oNr5sDvl9brghmtS4bRH6HY5E
         QSRw==
X-Forwarded-Encrypted: i=1; AJvYcCW6d/jr08bzygedDQ2VGvG7/jP61daD4oyqzC8T/WffyIUHqd/RnJsng/jeXNPweEfKPSEBAwbTbuLxJVckkmWZruMDbbA5jE1GX/Pw
X-Gm-Message-State: AOJu0YywO9Qeo1tX5Zj1A+1+7XB4bDRu/JfTSWHm/tE4Jr21Vr35AU77
	WM3LQn7uyjkwuBOrBYe31vmRzrpr1gBENgu4+VvIslrjf+rbwIp9aGaxom+IeFjDjNaryGXz/mY
	J7KpodKKbPWQCUHEkhMJxrZIBvTQ=
X-Google-Smtp-Source: AGHT+IG4waejpOf/qZLwoj5ZE1TOjOYuV5JPU5s1UwIqmRNmcsyC3TIfxfK361yvR3M1Lc0rBKgAs5yjmvxDuRVdaMQ=
X-Received: by 2002:a17:90b:4f45:b0:2b1:534f:ea09 with SMTP id
 98e67ed59e1d1-2b6cc76d27amr21340210a91.23.1715960788222; Fri, 17 May 2024
 08:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
 <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
In-Reply-To: <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 May 2024 11:46:16 -0400
Message-ID: <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tim Van Patten <timvp@chromium.org>, LKML <linux-kernel@vger.kernel.org>, 
	alexander.deucher@amd.com, prathyushi.nangia@amd.com, 
	Tim Van Patten <timvp@google.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>, 
	Shiwu Zhang <shiwu.zhang@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 2:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.05.24 um 19:57 schrieb Tim Van Patten:
> > From: Tim Van Patten <timvp@google.com>
> >
> > The following commit updated gmc->noretry from 0 to 1 for GC HW IP
> > 9.3.0:
> >
> >      commit 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=3D1")
> >
> > This causes the device to hang when a page fault occurs, until the
> > device is rebooted. Instead, revert back to gmc->noretry=3D0 so the dev=
ice
> > is still responsive.
>
> Wait a second. Why does the device hang on a page fault? That shouldn't
> happen independent of noretry.
>
> So that strongly sounds like this is just hiding a bug elsewhere.

Fair enough, but this is also the only gfx9 APU which defaults to
noretry=3D1, all of the rest are dGPUs.  I'd argue it should align with
the other GFX9 APUs or they should all enable noretry=3D1.

Alex

>
> Regards,
> Christian.
>
> >
> > Fixes: 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=3D1")
> > Signed-off-by: Tim Van Patten <timvp@google.com>
> > ---
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index be4629cdac049..bff54a20835f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -876,7 +876,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *a=
dev)
> >       struct amdgpu_gmc *gmc =3D &adev->gmc;
> >       uint32_t gc_ver =3D amdgpu_ip_version(adev, GC_HWIP, 0);
> >       bool noretry_default =3D (gc_ver =3D=3D IP_VERSION(9, 0, 1) ||
> > -                             gc_ver =3D=3D IP_VERSION(9, 3, 0) ||
> >                               gc_ver =3D=3D IP_VERSION(9, 4, 0) ||
> >                               gc_ver =3D=3D IP_VERSION(9, 4, 1) ||
> >                               gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
>

