Return-Path: <linux-kernel+bounces-260211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8693A48D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E59283E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03030157E82;
	Tue, 23 Jul 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrDv3uok"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ED213B287
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753371; cv=none; b=ntHH8o2KT0n0o/D3TmrpIZ2Mq2S88gAzb1VIEicgDXdKnAetU7r9WJx8hHdhNSnSGSnonLIhdwHAN4Ji0LGA3xQn0xHOXPrWCVVL997QSoz2nderGFWsKMiKTg7B3RK0W8xkWdGZ2E6VnIhHiQa4c7kZfv4whBNRsSDvpSoxwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753371; c=relaxed/simple;
	bh=+W99CfqxoObYCuvVve/zHvc+NNu72hnwerRBRBU6VdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY1keot+2aXarmP10mluRlIlFQ5Uu5piyfeeINNC0xa3xCA/v0ZYokZSSVnhu/pOXvbyWu5afx0ValgGpNro1Fwb8i5HG1bbh//+3A6ep9P/71MEUSf96YlqaMrbEx0j+DozP3qpolluFlu4XX2GUFj6vEId1zIN2MLeiVl0kJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrDv3uok; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a115c427f1so595506a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721753369; x=1722358169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMmHjYZaR62eDvty50K2NRQt0UbFsIJ7pK7TgLOXdII=;
        b=NrDv3uokw245ln7ulm5/4rNyuXln+GIF3U1G9nK0inNxNIn0gcJJYBHFhd0gQxgENQ
         L5HAtVERq2Ao0AZUSCorhDnN1XNzCKzDrtqG+wRfYsQstmyxE9/L1+g/JhzJcbgWfXoY
         2cHeUUVJNk/Dzcnx+FH+z4d0oc/t8b2yL+xJqe2C8dxgS+CzehxEiiIjwWwMBzVcXdTM
         qd/BJH+FA3D7Mk/7lAAfEZ3sNxkMnUhjxblWWC9hV5tGc2fxdt9ARjCHqxld4ChDRNV2
         grhp7O6gj5iHTJv4wkO6ATCo/6SBmVKgYTjsPZ8gRlJopWZt2LPrOc1kMJxSJIyaVmIX
         1z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721753369; x=1722358169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMmHjYZaR62eDvty50K2NRQt0UbFsIJ7pK7TgLOXdII=;
        b=S3pNjwR+lPJGqZN6brKB9omfFnDGCD9R/6/XzqHzyN1YB7ryBoGW0IF2BgeR6OMO+l
         tPTk9Wu2ywBKOxgka3y4a+3qpbTW9t+8dz/eEjn9iefbzjHi/w1hlm6fsWjrUpF5D+WL
         3dr1y0biNIbXYN0olimvaCh78CDmD7Xp9iVc/c6nS4biWNJPjxa1NOCKVnyYHUvgI+HW
         qnx3igubmXftLLqBBAdFcByHuvTPHnHHigb5Zl+qHUjdCKHxpdcqzMJWmsVfeQUKoEZN
         JNfDm6ha8lZEscxmiBJs2MXquV1ZAtOBVd9fQO0uW6XaYe+a/NYw8jAIDSp3pC5VOpVc
         pzUg==
X-Forwarded-Encrypted: i=1; AJvYcCWE2qp+mEO1srYTy3eGut0Z/QMljy4CTJntCJ9boQuAkjOJ94ErjiZoK7JpuELhlxieljDKPZmjqOHs705Ai4x4Q9oyP0msMr4DjueM
X-Gm-Message-State: AOJu0YyIsuWwmzr4EkrbNr1dZMfPGQhd4an+2jb54YmrFVLpDNfy/7nI
	xwKmumIrfKGQksJRV6PeGRKulDW7Qg5P9FbQbLhQYLk7OwevsT98JHS1YqCYSJtrZPVYtUrYGaO
	pLMVIFjXr61E5xZTYUnarUWvIJ3k=
X-Google-Smtp-Source: AGHT+IE8JQBZvhS2e9eniMpbuWyekU8wcVXNlUi2GDa0myv7hS4wlZavVHKcmrE30IzEvkK6/tLYZObBbfVH90jq+Zg=
X-Received: by 2002:a17:90a:c20d:b0:2cb:4c4f:3280 with SMTP id
 98e67ed59e1d1-2cdaf5585b1mr259536a91.26.1721753368766; Tue, 23 Jul 2024
 09:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net> <ad78ada4-4e31-4994-845b-fe756b52a1ae@t-8ch.de>
In-Reply-To: <ad78ada4-4e31-4994-845b-fe756b52a1ae@t-8ch.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Jul 2024 12:49:17 -0400
Message-ID: <CADnq5_OjRgMkqnsep_AtKxonhCxthZZCsv+eNERuGH4-fXw6Ww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: convert bios_hardcoded_edid to drm_edid
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 2:32=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> On 2024-06-16 11:12:03+0000, Thomas Wei=C3=9Fschuh wrote:
> > Instead of manually passing around 'struct edid *' and its size,
> > use 'struct drm_edid', which encapsulates a validated combination of
> > both.
> >
> > As the drm_edid_ can handle NULL gracefully, the explicit checks can be
> > dropped.
> >
> > Also save a few characters by transforming '&array[0]' to the equivalen=
t
> > 'array' and using 'max_t(int, ...)' instead of manual casts.
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> > While this patch introduces a new user for drm_edid_raw(),
> > if amdgpu proper gets migrated to 'struct drm_edid', that usage will go
> > away.
> >
> > This is only compile-tested.
> >
> > I have some more patches for the rest of amdgpu,
> > to move to 'struct drm_edid'.
> > This patch is a test-balloon for the general idea.
> >
> > The same can also be done for drm/radeon.
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  6 +-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  4 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c       |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 21 +++++++-----------=
---
> >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  2 +-
> >  8 files changed, 15 insertions(+), 26 deletions(-)
>
> <snip>
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/g=
pu/drm/amd/amdgpu/atombios_encoders.c
> > index 25feab188dfe..90383094ed1e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > @@ -2064,20 +2064,13 @@ amdgpu_atombios_encoder_get_lcd_info(struct amd=
gpu_encoder *encoder)
> >                               case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
> >                                       fake_edid_record =3D (ATOM_FAKE_E=
DID_PATCH_RECORD *)record;
> >                                       if (fake_edid_record->ucFakeEDIDL=
ength) {
> > -                                             struct edid *edid;
> > -                                             int edid_size =3D
> > -                                                     max((int)EDID_LEN=
GTH, (int)fake_edid_record->ucFakeEDIDLength);
> > -                                             edid =3D kmalloc(edid_siz=
e, GFP_KERNEL);
> > -                                             if (edid) {
> > -                                                     memcpy((u8 *)edid=
, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
> > -                                                            fake_edid_=
record->ucFakeEDIDLength);
> > -
> > -                                                     if (drm_edid_is_v=
alid(edid)) {
> > -                                                             adev->mod=
e_info.bios_hardcoded_edid =3D edid;
> > -                                                             adev->mod=
e_info.bios_hardcoded_edid_size =3D edid_size;
> > -                                                     } else
> > -                                                             kfree(edi=
d);
> > -                                             }
> > +                                             const struct drm_edid *ed=
id;
> > +                                             edid =3D drm_edid_alloc(f=
ake_edid_record->ucFakeEDIDString,
> > +                                                                   max=
_t(int, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength));
> > +                                             if (drm_edid_valid(edid))
> > +                                                     adev->mode_info.b=
ios_hardcoded_edid =3D edid;
> > +                                             else
> > +                                                     drm_edid_free(edi=
d);
>
> The old code here seems broken in general.
> In drivers/gpu/drm/amd/include/atombios.h the comment for ucFakeEDIDLengt=
h says:
> (I expect the same field in the same struct for amdgpu to have the same s=
emantics)
>
>     UCHAR ucFakeEDIDLength;       // =3D 128 means EDID length is 128 byt=
es, otherwise the EDID length =3D ucFakeEDIDLength*128
>
> So as soon as the EDID from the BIOS has extensions, only the first few
> bytes will be copied into the allocated memory. drm_edid_is_valid() will
> then read the uninitialized memory and if the "extensions" field ends up
> non-zero it will happily "validate" past the allocated buffer.

I guess the allocation should be changed to something like:
if (ucFakeEDIDLength =3D=3D 128)
    edid_size =3D ucFakeEDIDLength;
else
    edid_size =3D ucFakeEDIDLength * 128;

That said, I don't know how many systems actually used this.  IIRC
this was only used in GPUs from 15-20 years ago.  No objections to the
patch in general.

Alex


>
> The new code won't work either but at least it won't read uninitialized
> memory nor will it read past the buffer bounds.
>
> >                                       }
> >                                       record +=3D fake_edid_record->ucF=
akeEDIDLength ?
> >                                                 struct_size(fake_edid_r=
ecord,
>
> <snip>

