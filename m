Return-Path: <linux-kernel+bounces-555191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ABAA5A6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F931893480
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B611EB5EA;
	Mon, 10 Mar 2025 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLF6kusg"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C51E2834
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644221; cv=none; b=icd3UNwRWfz7v7ucVFgH+6ukI6tPyNbjByUVpfcOl+6FgtwLHQyvEAc7COh1B0ed5FkSdcVdzFjLDlWDJMHprNLvthO3G6qIpdvNBVgTAg9C8jreh0qzh5cpzd0LmZg+xUFwSeE+vQ8PA2zevJRfs/RxDZDh0OQlNPTXRCDmrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644221; c=relaxed/simple;
	bh=VucAr/WOQnARZGkELueQ4L+9KZqBx/ykd2S0xSad30w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2J3a2pTGNOvEI+3IxP+4ser4XlImUJBPyzdOEG3Bg079m/nALe3Ot4DA5ROk5g5NDjMV5hF0FeCD1ljPPHinkZmebuZHefaVOhOlhGIDh533R9mp8FzE5SM/1hxWzGMuwD31XUxt5SPQtgIXWRARC4SgegH1iUXTvruezSBpaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLF6kusg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fd02536660so1296301a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741644219; x=1742249019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYzg/u2IpcqWvAcuNVD136LsSFWdWQJXt/YKMQFKRsA=;
        b=dLF6kusg7ObaQsmtnrtM8JUtgjQir0q/eEVdTf3VuhK3t5pMKvHN06e7khA33UIx3q
         26Su+9Sidyzw82VfXY8VCoBEVLTb6AIFGGHX/quXPgkduJPhYUXKeu0Q0j8P8ApNYf6h
         2OePiF8Rx2T5evfYRKY7vCoV6Wk5Mdnh4su/Dg2OJ0PWHXYhMURYm/ETYm2WucmtkS5e
         TRPaAJ/rOgE2uC1yrxEKYh+F9VbvkL4LgltlCthA+0GFSuNV7HN7q3rPC7z2tUQEBZom
         03DxlycRRJn6NP/o3YGirTFIdxxCrHu/pOMUI0q891e3sVmRZUT+ZjisCd91jItrdar7
         Xe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741644219; x=1742249019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYzg/u2IpcqWvAcuNVD136LsSFWdWQJXt/YKMQFKRsA=;
        b=r5NxXZ3od1efAduBeGD/NXcyNycw0GwRpXR1+9wfoRKkCjxbHPYuqHKJlHvYv9FHI7
         0evxnTgeO2OifzC3tEbx1Rj8gdj9vAIiWE5by6Gi+hk83ohZz6216NMKskq2QzU2EVjN
         zU6E57jAbEIbYYP1XlqOcIGIdOhlCSe5E0ocvlDdP9PLFHZWFejwZdrjRQtEfW+lRbgy
         sbYlwd4mIqFXqAcAqp8EoTJJ/XjDyWAmdC1bxI3Jj5B8RuBp4HpCdx5uunU2ou7fHOUB
         G2o89N0384UjrsYHhmPc7jURluxFbMa/5wyw58HjX9Anp63gNI+rqMuzzhYWvVZ/ktjv
         xI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd4sgBWHPTYgr0y2tJ9nhPmdO64wOj78j9Dtr3SmnlU4OgcK8QGgUL2HRk441EnjJ7ZDFRddlFqSaByCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcz9hhMUniGsPVbFkk0cvrIHSDbk1UYdOil60DVPrHa6foiJgD
	DfwqWT8HvR6SaAR6r104vvUcstkqUBtVa3/ZrRodjGI0TKbvKfmYl0Mu5BiJlV47aD7resKniBO
	o9PbXPMaFH/TsjRTuaZ4AsGcmeSs=
X-Gm-Gg: ASbGncul4Hk5NC42Bbr1mE/eV56VPz6Od3a2QjeAJipDsJaAUkqU8sHOmp5htGi+YW3
	kBKbUCBbYfCsWDYL74WX9qVFiz5dWtNCzFzA1f02/KFbVLV5Jj37PasHjydGY6F/cNqyaZLLGsH
	dCsM7Eh+D5L++kclRZ6dUWWDFlEw==
X-Google-Smtp-Source: AGHT+IGytwiODt/P/QUDHtvcJD/CRyXbk3Tc1Som0tCe+NbmcvRB49qV/HyZx+UPOyGDO/3B+jWcxbX7Hk7kj/LDsN8=
X-Received: by 2002:a17:90b:1b52:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-300ff724c14mr648392a91.2.1741644218723; Mon, 10 Mar 2025
 15:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-3-andrealmeid@igalia.com> <Z8HO-s_otb2u44V7@black.fi.intel.com>
 <38b9cc8b-2a55-4815-a19f-f5bdf0f7687c@igalia.com> <Z8KjZfLYjH6ehYwy@black.fi.intel.com>
 <73602c9b-74f6-4b4a-82c6-918292b13cf7@igalia.com>
In-Reply-To: <73602c9b-74f6-4b4a-82c6-918292b13cf7@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 18:03:27 -0400
X-Gm-Features: AQ5f1JoHIt6Gv797OLqVVuaE_80ofmAmIRgK8qcq7RMDPVr8YwLqNekcRumjzU8
Message-ID: <CADnq5_PbZUoyxyqweqa=kUNsSXanjY=5mUJrn03aY3je6rER+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	amd-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch, 
	rodrigo.vivi@intel.com, jani.nikula@linux.intel.com, 
	Xaver Hugl <xaver.hugl@kde.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:54=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 01/03/2025 03:04, Raag Jadav escreveu:
> > On Fri, Feb 28, 2025 at 06:49:43PM -0300, Andr=C3=A9 Almeida wrote:
> >> Hi Raag,
> >>
> >> On 2/28/25 11:58, Raag Jadav wrote:
> >>> On Fri, Feb 28, 2025 at 09:13:53AM -0300, Andr=C3=A9 Almeida wrote:
> >>>> To notify userspace about which app (if any) made the device get in =
a
> >>>> wedge state, make use of drm_wedge_app_info parameter, filling it wi=
th
> >>>> the app PID and name.
> >>>>
> >>>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++=
--
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
> >>>>    2 files changed, 22 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_device.c
> >>>> index 00b9b87dafd8..e06adf6f34fd 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>>> @@ -6123,8 +6123,23 @@ int amdgpu_device_gpu_recover(struct amdgpu_d=
evice *adev,
> >>>>            atomic_set(&adev->reset_domain->reset_res, r);
> >>>> -  if (!r)
> >>>> -          drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVER=
Y_NONE, NULL);
> >>>> +  if (!r) {
> >>>> +          struct drm_wedge_app_info aux, *info =3D NULL;
> >>>> +
> >>>> +          if (job) {
> >>>> +                  struct amdgpu_task_info *ti;
> >>>> +
> >>>> +                  ti =3D amdgpu_vm_get_task_info_pasid(adev, job->p=
asid);
> >>>> +                  if (ti) {
> >>>> +                          aux.pid =3D ti->pid;
> >>>> +                          aux.comm =3D ti->process_name;
> >>>> +                          info =3D &aux;
> >>>> +                          amdgpu_vm_put_task_info(ti);
> >>>> +                  }
> >>>> +          }
> >>> Is this guaranteed to be guilty app and not some scheduled worker?
> >>
> >> This is how amdgpu decides which app is the guilty one earlier in the =
code
> >> as in the print:
> >>
> >>      ti =3D amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
> >>
> >>      "Process information: process %s pid %d thread %s pid %d\n"
> >>
> >> So I think it's consistent with what the driver thinks it's the guilty
> >> process.
> >
> > Sure, but with something like app_info we're kind of hinting to userspa=
ce
> > that an application was _indeed_ involved with reset. Is that also guar=
anteed?
> >
> > Is it possible that an application needlessly suffers from a false posi=
tive
> > scenario (reset due to other factors)?
> >
>
> I asked Alex Deucher in IRC about that and yes, there's a chance that
> this is a false positive. However, for the majority of cases this is the
> right app that caused the hang. This is what amdgpu is doing for GL
> robustness as well and devcoredump, so it's very consistent with how
> amdgpu deals with this scenario even if the mechanism is still not perfec=
t.

It's usually the guilty one, but it's not guaranteed.  For example,
say you have a ROCm user queue and a gfx job submitted to a kernel
queue.  The actual guilty job may be the ROCm user queue, but the
driver may not detect that the ROCm queue was hung until some other
event (e.g., memory pressure).  However, the timer for the gfx job may
timeout before that happens on the ROCm queue so in that case the gfx
job would be incorrectly considered guilty.

Alex

