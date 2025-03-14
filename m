Return-Path: <linux-kernel+bounces-561743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F837A61596
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C1B17DEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2B201267;
	Fri, 14 Mar 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5jodgnJ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CD2AE77
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968039; cv=none; b=cbSjyPK8TPkDhkw9tSLqBkUwWWyaHTPoKxmiiKVFWPFAZwhbHWLsBDds00Bfquf+HK3QtLWrByeKml4NJvQV5Bl+G7ichS16YkpdDOJj775/Ufx35YN3xu6vNuNs1PjoUxHWhdPLSOcWP/TH+pX4wn9IEOpRv9jhSqU66idBavk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968039; c=relaxed/simple;
	bh=ax7jDivqNCm8Fd79tbZPgMwBc3TPoRnbbcDI9CxwYzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ET8V0tIQq4hTxafNT4ei8lehp7OJCLsqkEjMiUJBfdhyPZ6bZwVn+PNSMKIsgpg64mQRazGIuo13A0/0ZuVlw47n+kidf628cfQBiUlCq3pgT+jMgCZb9a7xjPNKPRY7ajZlFLZap+vtWhzAdA6l6JgVx1XcbGjaLzavL5j/ACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5jodgnJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso554319a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741968038; x=1742572838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIY165QBF2I7E64kxf0y7gan5+WkPY6SwpR93M25+8U=;
        b=i5jodgnJYaO47+KNZ0HK//0ZOUvtt50wQe4B9jaDFgKDgNxDOsabJfn1u7aOvS+hTc
         QCv0VssrRFnsztib21uCjGU1WgcowjQhPmTSgfvoInP8zhj/J4FT59nQVsMq1Kri13m8
         z2gjqQZHdKNxVgWS4TwslOMDfAr0+98l55KNu4fygKqXZ+TgGUIjARz/mQ5JERMmrzYi
         H/08EZLVRNuoLwBh4PpWZChb6Ha/cfPxlaeYdrcuOCKkjyON5R7mr3WSsEJJFi8/niG5
         6zfI+siD/p1OWVCpg7puOxVsYbEYGxCRyyE0PiuagoG3RYZvqLpPfs0sgPklfsbhncQg
         0eUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968038; x=1742572838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIY165QBF2I7E64kxf0y7gan5+WkPY6SwpR93M25+8U=;
        b=LGf7U1GmoKAiVNwZlj66LkQ6FKmKEgEiR+dPfzMTYaif0NzPqTPa3aTCPothnI4Qv0
         3NAKocPZz/4mbx6dqx/hJSxcuGIiXrJebqN9r5U8KNApNPeKHcmGf89zzYrrpzsTxVSo
         vSYnEBVbYv9OYtMm3EbhYPS6n5anFoLZAadwJMj3OnfGdhqZFVLVxugVroFEGD+sXYQm
         n4SP6g2eQ6uOf8/M9z7YP96Fk9wvv0/lCNfbaxMMwcrYkaeJL3woVfB20eHBm5uguXUs
         QDPvJSqrD0HRvQx5CKINcZkm7lBbEpOWiZDk5p5NW0fRyKW8imFG65tbdmXHGvwPlCPO
         rHng==
X-Forwarded-Encrypted: i=1; AJvYcCWA2tM+xrKyhQkwssHX8MSzCywDzvN725uZ1p5Aie9cm7tlCzy9/TbxJ+ZGsU/9OzZJxmNq49FBE9Bk3y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8graaxPqbwbbDKrXsrdr+sozjCXzVG6QjhQXmgVAQsl7imMl
	cnwkEprVdWOMTiOjSyplVEw9MowAeJSkwP7dEZbTwW/8JlNX1jjUHnyGSJOBdu0kFMSUp4o9enb
	gMLawlInzcIsvIOamUlGx8lppRA==
X-Gm-Gg: ASbGncvhwg3alTmkP6ojqCdjAa1F1VeydWhnLKGZGtKcqQfR7CHho7pzvzCqQyqkmJv
	maJb0xFkzNZE7QC75tc8MdTA13W/cerV45licuj76ds7tFwDFy1LnvJQQS8scjTQJwxeP1mPDr+
	ZP8EEq2jci97NgMj8JfatXhHf378s=
X-Google-Smtp-Source: AGHT+IHPg5LEX9RcXJcT7z3Dh6z47dRs4csMp548pLAhreG5srJVcZIIpfZ8T/92XQSoT8s0QhUvp3pVVX5xQ+RxwCQ=
X-Received: by 2002:a17:90b:164f:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-30151c88e12mr1556703a91.1.1741968037522; Fri, 14 Mar 2025
 09:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314012029.668306-1-chenyuan0y@gmail.com> <20250314-prophetic-attentive-platypus-3ab214@houat>
In-Reply-To: <20250314-prophetic-attentive-platypus-3ab214@houat>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Fri, 14 Mar 2025 11:00:26 -0500
X-Gm-Features: AQ5f1JoUD0V5ZOdvR5FcIitlHbVLK_E695Xu4I0ACsV86e_NOveKe5yScUlp2jo
Message-ID: <CALGdzurT1_fY_o8Hv92j4+XFQHu1iHRzqVtZAM8upHYBPfA1BA@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: backend: Fix error pointers in sun4i_backend_atomic_check
To: Maxime Ripard <mripard@kernel.org>
Cc: wens@csie.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, jernej.skrabec@gmail.com, 
	samuel@sholland.org, neil.armstrong@linaro.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Maxime.

Thanks so much for pointing that out!

How about such a patch?

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c
b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 2dded3b828df..5ad0e90d3e6b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -490,9 +490,14 @@ static int sun4i_backend_atomic_check(struct
sunxi_engine *engine,
  drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
  struct drm_plane_state *plane_state =3D
  drm_atomic_get_plane_state(state, plane);
- struct sun4i_layer_state *layer_state =3D
- state_to_sun4i_layer_state(plane_state);
- struct drm_framebuffer *fb =3D plane_state->fb;
+ struct sun4i_layer_state *layer_state =3D NULL;
+ struct drm_framebuffer *fb =3D NULL;
+
+ if (IS_ERR(plane_state))
+ return PTR_ERR(plane_state);
+
+ layer_state =3D state_to_sun4i_layer_state(plane_state);
+ fb =3D plane_state->fb;

  if (!sun4i_backend_plane_is_supported(plane_state,
        &layer_state->uses_frontend))
--=20

-Chenyuan

On Fri, Mar 14, 2025 at 2:17=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> Hi,
>
> On Thu, Mar 13, 2025 at 08:20:29PM -0500, Chenyuan Yang wrote:
> > The function sun4i_backend_atomic_check was dereferencing pointers
> > returned by drm_atomic_get_plane_state without checking for errors. Thi=
s
> > could lead to undefined behavior if the function returns an error point=
er.
> >
> > This commit adds checks using IS_ERR to ensure that plane_state is
> > valid before dereferencing them.
> >
> > Similar to commit da29abe71e16
> > ("drm/amd/display: Fix error pointers in amdgpu_dm_crtc_mem_type_change=
d").
> >
> > Fixes: 96180dde23b7 ("drm/sun4i: backend: Add a custom atomic_check for=
 the frontend")
> > Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/su=
n4i/sun4i_backend.c
> > index 2dded3b828df..a8e0e2123764 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> > @@ -490,6 +490,10 @@ static int sun4i_backend_atomic_check(struct sunxi=
_engine *engine,
> >       drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
> >               struct drm_plane_state *plane_state =3D
> >                       drm_atomic_get_plane_state(state, plane);
> > +
> > +             if (IS_ERR(plane_state))
> > +                     return PTR_ERR(plane_state);
> > +
>
> This introduces a build warning. You shouldn't mix declarations and code.
>
> Maxime

