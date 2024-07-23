Return-Path: <linux-kernel+bounces-260232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B6893A4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F571C22CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A95D157E94;
	Tue, 23 Jul 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdEM7e6i"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDBD14D431
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721754894; cv=none; b=l8iBPMCQ8EGTtOyl5QmtDeT4toG6D/GE+ZjTsITZTUNXCkTVqi/aXO4ItbJ/P9Ew8kv3Nd8AyGymcSJIE5zCZg2+Ky5O44kr9wQtNyUKPOFy0avqD5Sr9o/gVYvlhkrWEnEmIrKEN/K1ILXwrdzQTBTkdgifZyGleXH+IwxxDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721754894; c=relaxed/simple;
	bh=6kghmSBFAgraNaL0cxB5ROvZv7AzQs2gkL1BpsTzI4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfLYUunxGyPfUewIj2J48kBjta4quSFHpoUeMDpX9va8ji19KB3uHORvaThzJkMc2YP30CH6XHjeMCJjOMxoBZDhDcTrqETqtNE1lqzAqrkSlSvfpQ8OZaMTTjVLnNMMY0EKs0lj3x8WxqsHxwSscXv4nfDLxP1vVjNgIzpSXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdEM7e6i; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-75cda3719efso661385a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721754892; x=1722359692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YR/sRwpB1CCsWUP+4Ph7FU7thUB0l4sYMzG0JevTYg=;
        b=GdEM7e6iGVAo3zxG6o/PnDLcoanEFBdG2S6ZTtXg+1ZMV8MJV1xkF4EV0/XDBWFviq
         spKr8CnGvhstqZP3NR6MUcUdu7Ac0qc0lOkxn9ZQCtxmwvSzekX6MhsjiV7rTJF5mYzo
         x+rA+yxqp4vCFV3XpV6Z+2qyO85/A5z5DBb/wHxLmz4+LG5y/K2qQ+fJwMhE0hJMeFNg
         6ZKC6/xs9SOHKv94xYxucdSokFN85UO3grRj3ahfesnA0OP7ewto7PQqk+4RDdLrDOJ5
         Hq68x4/3QELP8Kkw5MDMZ12IJh0ncB8PxQhTo1kMVWS45EDT7qj9gsaUbaFLK+85SGlY
         N/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721754892; x=1722359692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YR/sRwpB1CCsWUP+4Ph7FU7thUB0l4sYMzG0JevTYg=;
        b=ebhg2M3NF4+q9nOR4cSceY8hZalYp3ca5fy2Uqbn3lBQqUJ0FCAm0a2m128t0ieMqF
         VyhWGNu9wSDhdkgXMhDqi3pNJ+Lbmhn/StyHr9hHk+hb42wiPDT9PDj10N2/SRoxLx4D
         EEp1cFFKKzmr4GkESk9cLsIW7i4sK9xtlxDPGjLAwx2g7pIOsHN+KbnNiKIZH0TJgUQn
         F1f4kYF+6a/ote/p6/iH6vuOZxjcVqTuK8uN9GsZYK/OhGKXe1H0VzAFiYJM5i2wEKic
         0jLlQIeNXLo+fv220KSk5H3vKwaAajGVsQVnICaGUteKdXqrRGMNeN4l5fksZ2te96xO
         HWxw==
X-Forwarded-Encrypted: i=1; AJvYcCXGdIksBx/2HagHXF7I28QiruRUUFAiOw2kYD3vuRwzl6+gROE02t1wWBSV3iWQ793wIFJTYugITlNg0G6Pepsg4zq1Nw42KiNOFOJR
X-Gm-Message-State: AOJu0Ywa16CQsudBfIU9F7w2QHCsClk9ZfSp1gOiaEiu83f2JFSZM89r
	g+axOmsVsnwQFgCARBtKb6GHjjnAJFZPM/9AY+Nc6lVLuYMwQpwTlEG56YdTNE6dIZNRBxxoiPJ
	uQKsCYBbh67JsCItVPXULDHcqoU8=
X-Google-Smtp-Source: AGHT+IGOWJh0Vr3vgfLKwgbdET9Ih1+E4GAFHNnhf5BKkoe1va0SUJ3C95dZPt2LE3dvS9NDOXkvc202wsNZKJQrkB0=
X-Received: by 2002:a17:90b:1e4d:b0:2c8:7897:eb46 with SMTP id
 98e67ed59e1d1-2cd274d48c6mr7012879a91.37.1721754892475; Tue, 23 Jul 2024
 10:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616-amdgpu-edid-bios-v1-1-2874f212b365@weissschuh.net>
 <ad78ada4-4e31-4994-845b-fe756b52a1ae@t-8ch.de> <CADnq5_OjRgMkqnsep_AtKxonhCxthZZCsv+eNERuGH4-fXw6Ww@mail.gmail.com>
In-Reply-To: <CADnq5_OjRgMkqnsep_AtKxonhCxthZZCsv+eNERuGH4-fXw6Ww@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Jul 2024 13:14:40 -0400
Message-ID: <CADnq5_NU51=+QM5OC+Ut4ahU_b-64zCAaTKfLB1BKbZijutHCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: convert bios_hardcoded_edid to drm_edid
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:49=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Sun, Jun 16, 2024 at 2:32=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weis=
sschuh.net> wrote:
> >
> > On 2024-06-16 11:12:03+0000, Thomas Wei=C3=9Fschuh wrote:
> > > Instead of manually passing around 'struct edid *' and its size,
> > > use 'struct drm_edid', which encapsulates a validated combination of
> > > both.
> > >
> > > As the drm_edid_ can handle NULL gracefully, the explicit checks can =
be
> > > dropped.
> > >
> > > Also save a few characters by transforming '&array[0]' to the equival=
ent
> > > 'array' and using 'max_t(int, ...)' instead of manual casts.
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > > ---
> > > While this patch introduces a new user for drm_edid_raw(),
> > > if amdgpu proper gets migrated to 'struct drm_edid', that usage will =
go
> > > away.
> > >
> > > This is only compile-tested.
> > >
> > > I have some more patches for the rest of amdgpu,
> > > to move to 'struct drm_edid'.
> > > This patch is a test-balloon for the general idea.
> > >
> > > The same can also be done for drm/radeon.
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c |  6 +-----
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h       |  4 ++--
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c       |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c | 21 +++++++---------=
-----
> > >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c         |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c         |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c          |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c          |  2 +-
> > >  8 files changed, 15 insertions(+), 26 deletions(-)
> >
> > <snip>
> >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers=
/gpu/drm/amd/amdgpu/atombios_encoders.c
> > > index 25feab188dfe..90383094ed1e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> > > @@ -2064,20 +2064,13 @@ amdgpu_atombios_encoder_get_lcd_info(struct a=
mdgpu_encoder *encoder)
> > >                               case LCD_FAKE_EDID_PATCH_RECORD_TYPE:
> > >                                       fake_edid_record =3D (ATOM_FAKE=
_EDID_PATCH_RECORD *)record;
> > >                                       if (fake_edid_record->ucFakeEDI=
DLength) {
> > > -                                             struct edid *edid;
> > > -                                             int edid_size =3D
> > > -                                                     max((int)EDID_L=
ENGTH, (int)fake_edid_record->ucFakeEDIDLength);
> > > -                                             edid =3D kmalloc(edid_s=
ize, GFP_KERNEL);
> > > -                                             if (edid) {
> > > -                                                     memcpy((u8 *)ed=
id, (u8 *)&fake_edid_record->ucFakeEDIDString[0],
> > > -                                                            fake_edi=
d_record->ucFakeEDIDLength);
> > > -
> > > -                                                     if (drm_edid_is=
_valid(edid)) {
> > > -                                                             adev->m=
ode_info.bios_hardcoded_edid =3D edid;
> > > -                                                             adev->m=
ode_info.bios_hardcoded_edid_size =3D edid_size;
> > > -                                                     } else
> > > -                                                             kfree(e=
did);
> > > -                                             }
> > > +                                             const struct drm_edid *=
edid;
> > > +                                             edid =3D drm_edid_alloc=
(fake_edid_record->ucFakeEDIDString,
> > > +                                                                   m=
ax_t(int, EDID_LENGTH, fake_edid_record->ucFakeEDIDLength));
> > > +                                             if (drm_edid_valid(edid=
))
> > > +                                                     adev->mode_info=
.bios_hardcoded_edid =3D edid;
> > > +                                             else
> > > +                                                     drm_edid_free(e=
did);
> >
> > The old code here seems broken in general.
> > In drivers/gpu/drm/amd/include/atombios.h the comment for ucFakeEDIDLen=
gth says:
> > (I expect the same field in the same struct for amdgpu to have the same=
 semantics)
> >
> >     UCHAR ucFakeEDIDLength;       // =3D 128 means EDID length is 128 b=
ytes, otherwise the EDID length =3D ucFakeEDIDLength*128
> >
> > So as soon as the EDID from the BIOS has extensions, only the first few
> > bytes will be copied into the allocated memory. drm_edid_is_valid() wil=
l
> > then read the uninitialized memory and if the "extensions" field ends u=
p
> > non-zero it will happily "validate" past the allocated buffer.
>
> I guess the allocation should be changed to something like:
> if (ucFakeEDIDLength =3D=3D 128)
>     edid_size =3D ucFakeEDIDLength;
> else
>     edid_size =3D ucFakeEDIDLength * 128;

The record size handling in atombios_encoders.c would also need to be fixed=
.

Alex

>
> That said, I don't know how many systems actually used this.  IIRC
> this was only used in GPUs from 15-20 years ago.  No objections to the
> patch in general.
>
> Alex
>
>
> >
> > The new code won't work either but at least it won't read uninitialized
> > memory nor will it read past the buffer bounds.
> >
> > >                                       }
> > >                                       record +=3D fake_edid_record->u=
cFakeEDIDLength ?
> > >                                                 struct_size(fake_edid=
_record,
> >
> > <snip>

