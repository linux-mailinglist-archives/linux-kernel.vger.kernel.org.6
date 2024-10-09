Return-Path: <linux-kernel+bounces-356929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837139968DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1654EB223CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182E618FDDB;
	Wed,  9 Oct 2024 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="aVQ/ypzO"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E43D18E35D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473561; cv=none; b=soUBrkMnb6QkmUrVxEeMUybGxgyhAqjTGIIOWQOmkiPxDFzoQ+2tLgHKsQ/dgunRLmK61fSDY7FyAn9dUPqvKfJOUGugiXwML4QerYHoRi5KYK251B6oytOEGnyGG2xpJfYI1eIQLQ3tUnX4HDmEX7t/I82SPHQGkpuh2JKDz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473561; c=relaxed/simple;
	bh=on684W/2XEMM2jB2AX61bV2vO2lXG2k4HF88M7BdBZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSGjtW+fo3jc4/iW82N3ZEYPlfX9mfKsDlz6m8QhNomzTgUjcqLZiCHIw/vX0XhwhyrtCxSdRLsvOnNV0axSGvfrh4Sdya9rUpaSAMUmbC3MvecGLXd70PRp7d1TsCmi+lw+tvzaamApCOtrTCLm0fr8XJAOPyP0o8UWhGV81iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=aVQ/ypzO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e25d6342837so5835165276.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1728473558; x=1729078358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=008a6k3ZxIHkOV0CVfLapnrZh0drWKWmGkJbRnXXaRQ=;
        b=aVQ/ypzOitBw9gglkY0TnadS8EluejQ7/+ju0pqWvEdLB+2gc5XMirNR+a1DryM8/H
         5N3r97yNbA9VKAOA/nD6X2YF718YyaxYM7J1OMGnsquUWKd6pmpiCQokQ7nbaVX3/Sct
         MUTm4q6K2EHHuNg2LJ/Vn0NQrNUOD3YQKNNoa12pKEekryJeHxT9pAsNf+G3gBanCXqX
         tK20YK+mGwpvKYMqcpY4eOtmObhKXHuTNaIfP/8J9sSsDHcCrkqt1Ghps5es69/Iitsh
         liG7E9izQnp8ImhkoRli08MPcJtzuMLMgOE8TBF7eutNK+ZHkvEKakXU1J7sRGzlDPgD
         nVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728473558; x=1729078358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=008a6k3ZxIHkOV0CVfLapnrZh0drWKWmGkJbRnXXaRQ=;
        b=RdXIACRETbS2oF4xejbLMqUHEAlzJN1TnoGTjla+D7UDKPXMwBV4alL/adKBXlwWm+
         pmQPDVm3qKmOWmaIjFXPkU7ZeMTeL4iKtw2FYAsVJa3Zrd8F5ayjF2z3tnrrP7D08Xef
         UsIiv7da4tSy+b4Tm2fDhsFtfhFZnLAX/EdYk9rnEFyQWbTQLtyjuRR7iG4T3oJb2Ry6
         Xx10R6LY3zn9GaqB4ILSEaKx2GNPfZL37cbDKtyWqiAuCJ3AbQuNdEpD7zpbyz4SYJkY
         Yo9EB3KKILBdqM1oSDI2QMPpVyKMeaSWjohDYQ8saxTl97Db88J/wyfaPqRDw88k9+kE
         +M6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbtQD+IHoj6N/U8jsni4uH5zGYdILNPBvwC5yomkkuc+RGynLJVFH/XYxBTur0nSC0KaHX1jhUoJKWUYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCNYb7Dt3No3TZ+3viwV2FqMj+ahJY8DOjYv8KBWYPy0fdnWW
	lVEqZiASnHF07TWnr0sfPSp3qhjSYlDv+rHoy6scX13ziqhGp0MQ7pZWKgCSeVoVKDSEIvUZSE7
	cvkYrlSyqIkeqLi87aCbcgqt3FjC17/Ne4Y9yKw==
X-Google-Smtp-Source: AGHT+IGF6K2rkk5aK8OxRzvwgQwEZfKkBm8BbIv2Dv+dz+zXDULDbCRgjuRxw3SCMfT8bzTBK44ZnD9sD3fVbMuBX7w=
X-Received: by 2002:a05:6902:2b89:b0:e11:6348:5d95 with SMTP id
 3f1490d57ef6-e28fe32e09amr1681374276.7.1728473558552; Wed, 09 Oct 2024
 04:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
 <20241008-drm-vc4-fixes-v1-3-9d0396ca9f42@raspberrypi.com> <a0922d76-0dc0-46a5-8408-a8eda3a07f26@igalia.com>
In-Reply-To: <a0922d76-0dc0-46a5-8408-a8eda3a07f26@igalia.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 9 Oct 2024 12:32:21 +0100
Message-ID: <CAPY8ntDTY-ybd8vViTP4vGuxT8DQsssTY_KJ2EQ6xhk2sV98UA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/vc4: Correct generation check in vc4_hvs_lut_load
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maira

Thanks for the review

On Wed, 9 Oct 2024 at 02:30, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> Hi Dave,
>
> On 10/8/24 13:44, Dave Stevenson wrote:
> > Commit 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
> > incorrectly swapped a check of hvs->vc4->is_vc5 to
> > hvs->vc4->gen =3D=3D VC4_GEN_4 in vc4_hvs_lut_load, hence breaking
> > loading the gamma look up table on Pi0-3.
> >
> > Correct that conditional.
> >
> > Fixes: 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >   drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hv=
s.c
> > index c5ebc317188a..1edf6e3fa7e6 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> > @@ -224,7 +224,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
> >       if (!drm_dev_enter(drm, &idx))
> >               return;
> >
> > -     if (hvs->vc4->gen =3D=3D VC4_GEN_4)
> > +     if (hvs->vc4->gen !=3D VC4_GEN_4)
>
> Again, another nit: I believe `hvs->vc4->gen > VC4_GEN_4` is more
> semantic and it's the standard I usually see around the driver.

With 24c5ed3ddf27 which this is fixing, all instances in vc4_hvs.c
were changed to =3D=3D VC4_GEN_4 or =3D=3D VC4_GEN_5. So I guess =3D=3D VC4=
_GEN_5
would have been the better option here.

Yes downstream we now have GEN_6 (which I'm nearly at a point to send
to the list), and I'll need to update this conditional when that's
added.
I'll leave it as is for now, and ensure I've done an audit of all of
them before pushing GEN_6.

Thanks
  Dave

> But this isn't critical, so:
>
> Reviewed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>
> Best Regards,
> - Ma=C3=ADra
>
> >               goto exit;
> >
> >       /* The LUT memory is laid out with each HVS channel in order,
> >

