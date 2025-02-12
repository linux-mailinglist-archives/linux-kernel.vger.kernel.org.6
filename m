Return-Path: <linux-kernel+bounces-511310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664CDA32938
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD02163FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0012101AF;
	Wed, 12 Feb 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHdYt0d0"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B020F06B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372082; cv=none; b=qxftYfRPLsxBDloPK0rpy0YXo3zf9MIdc40zikL/Y5HxWMz4LAMPpmu0iF8LetcjA0Nsjf3LvowiDI6EiJCsxdAfHaoG5ZMIGwBXfjJ6MglxKLEf4Z4vSYOqOJqBu233/pTj1dWRp83OZELSZzi3ZmUza98ETUBWrNlIG3619JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372082; c=relaxed/simple;
	bh=dJ46Y5iiqWYdMVi9i4vAYKv/FyFo257jdHTpXdamkQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIGXzILgJC4OGt4CzGu52z+lffvPPDiG0mPXyRGCy0SCVAnyOdBSRPE15pxAs+Z6BFfDDvhRpG/vu4wdcxLU8gBG153lIaepINe3Zc9nmGt4TBjSBCUns0jgbBAUVSKEgqNfGkqrdSEhNzc/REXh6Aa7Iwz/IRUBNC+tbGXHTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHdYt0d0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa8c788c74so621681a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739372080; x=1739976880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAkQk0vCtyjUEvQeMQjvpik2mcmrdn/YbyfEFLALom4=;
        b=LHdYt0d0JHFCnweZAc4fnjCNFvZOUJfjjx801nkHvQvIoZYDhIS9izgX16xEm1DtpV
         FqafCV9cgyLbLMd6+w/IZw4zjiB9PvbyW1j178Dr3vrk293mnnw3aubXr01fLKPSE4Fr
         6QmYaD0A24dRKuGq9BGafisXhf3M4byQjCn/A1grnTXK82LQz2HgoT+nzLXwm2cB+g5Q
         PGgsmmSSzVhrr/s3MUo+AOhsRIyIJ+KdH4uurreNrpAv1f4Wss0sraF6eLhBSaQoX7pe
         8AfC+p3T1a0wWgV8GciYWRx8T0fTDg0r4nMKdTPUVtAuPOxrkBb2Qw95IUYNGvHSaTz/
         /10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372080; x=1739976880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAkQk0vCtyjUEvQeMQjvpik2mcmrdn/YbyfEFLALom4=;
        b=bXmlHieBi+WnKrIQcBvaM8Th0Xooudmp0paX/GnfZ+7Hd+oqtFbR+3hoDuGX6VFC0J
         7FxVKjtOBrXiM5ntmgSyl9IYtyOGJJeVFPZNhKTG1pGO/xJT+CLLFR8TH/zhZvy1BGyE
         J8SiVW+NNS7/F0MbrZ3rAdAhAp1Iu0f5pN3HK/z03ntQeH8V2+cPgmx2tuyqAckuMhDP
         /q30580oQclUf+NYvaLDyHQ19vYkB9GsnVA4PG5cDnJAN7tbZgnURVVN7sLidFL/x1DR
         2iqV47Aif8zU4L4Xq7QHGU7jv9DYFqmTN3Uxh373n2S7IAjWx0yU/hUG7lxh7XZtZyTZ
         gJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0T8ajC5ayAgnnFWu05OK/KsqGAcHJNbWU5mPgo2uEUoVLl/MycoHJOEXtmA0Ar7GuNHyszA5UHORH7sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrrdmOPnFePtVU+LTDYJMz/R4R6T6VDjfANe94aM6vRDDI6OY
	Ny/Yz969IvIayOXXOCXRg8VjIPHoqj/TUjnbZ0anJf+QGX94URdfkusvseV+2P94TKiEApn3dWk
	v0++Olb/o4WCznRl51Q+B3f5J+0U=
X-Gm-Gg: ASbGnctCMQdZPpnBAhIlOYonyWAx7wyPmyhH1TLS7PhdO07j0vOC4XRDV9ICWOiYIis
	96WRl9rbA9lK2jlG7b+XvHQU1f173+g3HCwJoHQfT/ELCj9u+rklb0kRqM75jkhEEzHndtgYR
X-Google-Smtp-Source: AGHT+IFo2yCN2xd13k7pkRlQ8E0+as8C6qrcJ2fIeXpquYmq/wvPsy3OR22XEyVWdi28mKIGajdVEmPqauE7rW3eqb4=
X-Received: by 2002:a17:90b:1b50:b0:2fa:2011:c85d with SMTP id
 98e67ed59e1d1-2fbf5ca1356mr1899558a91.7.1739372080381; Wed, 12 Feb 2025
 06:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127-tonyk-async_flip-v12-0-0f7f8a8610d3@igalia.com>
 <20250127-tonyk-async_flip-v12-2-0f7f8a8610d3@igalia.com> <3e6f5e44-403b-41bb-b819-c4479948731c@amd.com>
In-Reply-To: <3e6f5e44-403b-41bb-b819-c4479948731c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 09:54:27 -0500
X-Gm-Features: AWEUYZmBHahplTG5qlcLVLsio8I4kY1VcqYEW5X_o2UrI_3pX2OADkQg-56WzMU
Message-ID: <CADnq5_N_SQHbx5zZGyWFJo8FcGbR+mT3aJr1C-uPRJ5Z9m27Vw@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] drm/amdgpu: Enable async flip on overlay planes
To: Harry Wentland <harry.wentland@amd.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, dmitry.baryshkov@linaro.org, 
	Simon Ser <contact@emersion.fr>, joshua@froggi.es, Xaver Hugl <xaver.hugl@gmail.com>, 
	Daniel Stone <daniel@fooishbar.org>, ville.syrjala@linux.intel.com, kernel-dev@igalia.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher@amd.com> for the series.

On Thu, Feb 6, 2025 at 5:37=E2=80=AFPM Harry Wentland <harry.wentland@amd.c=
om> wrote:
>
>
>
> On 2025-01-27 14:59, Andr=C3=A9 Almeida wrote:
> > amdgpu can handle async flips on overlay planes, so allow it for atomic
> > async checks.
> >
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 10 ++++++---=
-
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > index 774cc3f4f3fd9a964fe48c66eb596d2f6dfee602..6bfed3d1530e6610eea025b=
477f409ee505870da 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> > @@ -1258,21 +1258,23 @@ static int amdgpu_dm_plane_atomic_check(struct =
drm_plane *plane,
> >  }
> >
> >  static int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
> > -                                           struct drm_atomic_state *st=
ate)
> > +                                           struct drm_atomic_state *st=
ate, bool flip)
> >  {
> >       struct drm_crtc_state *new_crtc_state;
> >       struct drm_plane_state *new_plane_state;
> >       struct dm_crtc_state *dm_new_crtc_state;
> >
> > -     /* Only support async updates on cursor planes. */
> > -     if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
> > +     if (flip) {
> > +             if (plane->type !=3D DRM_PLANE_TYPE_OVERLAY)
> > +                     return -EINVAL;
> > +     } else if (plane->type !=3D DRM_PLANE_TYPE_CURSOR)
> >               return -EINVAL;
> >
> >       new_plane_state =3D drm_atomic_get_new_plane_state(state, plane);
> >       new_crtc_state =3D drm_atomic_get_new_crtc_state(state, new_plane=
_state->crtc);
> >       dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
> >       /* Reject overlay cursors for now*/
> > -     if (dm_new_crtc_state->cursor_mode =3D=3D DM_CURSOR_OVERLAY_MODE)
> > +     if (!flip && dm_new_crtc_state->cursor_mode =3D=3D DM_CURSOR_OVER=
LAY_MODE)
> >               return -EINVAL;
> >
> >       return 0;
> >
>

