Return-Path: <linux-kernel+bounces-235293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8736791D303
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3305E281599
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334AC153BD9;
	Sun, 30 Jun 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np4ylwn/"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98B149C7C
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719767118; cv=none; b=Nbr9UYkDSBVzFkF92cd/3F92L6BqpsaTWYz7JEe8P3dUeNfzO7Ts713/EzDsGQa3GU35SG5tAGQWVielIUNjW7zG5Pg9adPq7bZhJrDZEovpSqBz/cRAB6NCwv+jrgjlwz6lENFzkcfT/wLDh7sAcFosDZ46/9etDy5hGCUb0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719767118; c=relaxed/simple;
	bh=n2dAj2oN7HJiCQPqoHoq8A9BCbp7dPW4A95PEMCjjIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNLYlF3LEy2yoliwROGbEUy9NGnXR3lBbv779ilmttaM8i6IwzY2m5N1Z9klvEwTxuK1B8EeY9zyVVwNWCOF3Sdur4Z72OroeYSA6xbytCZ/QmJ5CpT3xdc+WTQ+jEDWTYLG62zjeq+9o7L53JFm2jpi2PMKQTzEtYpri+y5sSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Np4ylwn/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso26422131fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719767114; x=1720371914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSBwaS4j56NlcOuTEVGitgpl2zqsxNnDtYPNdmykvCQ=;
        b=Np4ylwn/OX873LAd6N+jAeVGvd340e2PMyuxPtKdhVVHdyW57UQ96/DFLczItivGJe
         opmNhfWixXHNGTKcMrDNSBN2+vdnjStJTLkMzID4HRLTfgKhs3MtINOYhnor03tQjtiA
         IXVk5BsPfWziQ3k7AqDq+bqqHqy1/66dA5RY3NFh82w1FPF47CaTaCRV3rninx+bFDnK
         wN2kAFjWE0PAaPPfujXIO3JoClTQbTgh/mvgRiW9qubeCgxBphvzjI1Dn+FX0x3579AH
         J+epHgOn7SCff9IgvF6GkAdnthV/UCvDQrihE+EgqEghPF4sFt954dpKhVTMb9CzC8cx
         uAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719767114; x=1720371914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSBwaS4j56NlcOuTEVGitgpl2zqsxNnDtYPNdmykvCQ=;
        b=WjpL59PWeY5maThpSP9dSSwo/s9PESEH2RzopuFGCLco84a36Tv87Ql++m0/GKhkVK
         XUOAeHgpmR7Jf7qON/Vcu6LvFbPKRS/6+CzSLyu9Oo/lYRGANKJI/l7abTJ+fPRwj1bB
         IJo7525x6lwk7G/XBouzFcEkBaB/bQTgMRHbQXp2QS3QKb7uNFMOsMA6pxdCc5CAm2D5
         4lFi7E9znli9MyBZBrsw9bhcO9GTgIei5zTGL7sSjmWSrCzWSt3u+iiONJXJEQy0954Q
         zuhDXBY19tRHcKD3IBk78m4pqRc9JdOZJI0jnIXghb4X6qhGAu6pnadev9jMw3x1L7Ix
         wMQA==
X-Forwarded-Encrypted: i=1; AJvYcCVqvuMtCLqit/nrbtNsh9yvqGEHbjnhVBFtnaLeDAj89fkicV0Ic3TxqazlDRFJk1wp48t1UTLWbz2gAgv7L+/r63fznGgsk095y0WA
X-Gm-Message-State: AOJu0YwqAckTaAMBn97fZ/Tz+wqOBdmDh0xuhaR7HyZp7LfWDOx/hAm5
	+IIlKHkooSGwQmsbuzRC75yfPJYb5JNjLroTovG1+6qzUed5XvZ7EQ2NtCw6eLYGDA/k3Fr4ueZ
	ZH7VfS4ljqhDUre4LlRjUtkBr6ZA=
X-Google-Smtp-Source: AGHT+IG7YHJPWnQ2Einzgx/hq1VY62FwoAmFbqi2vP0rjaW6mj6HE6Hk848vv1ff23xCzGk+ngx5RSdfIDimeiOwyGI=
X-Received: by 2002:a2e:bcc1:0:b0:2ee:6a72:f006 with SMTP id
 38308e7fff4ca-2ee6a72f0e6mr5705301fa.21.1719767114078; Sun, 30 Jun 2024
 10:05:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624151122.23724-1-wuhoipok@gmail.com> <3c627f1d-ab9e-480f-8f42-91a108477c24@suse.de>
In-Reply-To: <3c627f1d-ab9e-480f-8f42-91a108477c24@suse.de>
From: Hoi Pok Wu <wuhoipok@gmail.com>
Date: Sun, 30 Jun 2024 13:05:03 -0400
Message-ID: <CANyH0kAPuxnTR0UA3EBfzd8aAFH4kw9qVN1GLi-g60VE5NUYwg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] drm/radeon: remove load callback
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Thmoas,

Thanks a lot for the feedback.
I admit that my patch was a mess, sorry about that.

I have submitted a v3 to change a lot of stuff, these patches should
be able to be built now.
I also improve readability, where each patch does their own stuff.

Best regards,
Wu

On Wed, Jun 26, 2024 at 10:47=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Hi
>
> Am 24.06.24 um 17:10 schrieb Wu Hoi Pok:
> > Changes between v1 and v3:
> >
> > 1. add "ddev->dev_private =3D rdev;"
> > 2. include a cover letter
>
> A cover letter should briefly say what the patchset is about.
>
> BTW it's not clear to me why you need to modify radeon_dev.dev for
> removing the load callback. It seems it's a separate issue.
>
> Best regards
> Thomas
>
>
> >
> > Wu Hoi Pok (7):
> >    drm/radeon: remove load callback
> >    drm/radeon: rdev->ddev to rdev_to_drm(rdev) 1
> >    drm/radeon: rdev->ddev to rdev_to_drm(rdev) 2
> >    drm/radeon: rdev->ddev to rdev_to_drm(rdev) 3
> >    drm/radeon: rdev->ddev to rdev_to_drm(rdev) 4
> >    drm/radeon: rdev->ddev to rdev_to_drm(rdev) 5
> >    drm/radeon: rdev->ddev to rdev_to_drm(rdev) 6
> >
> >   drivers/gpu/drm/radeon/atombios_encoders.c |  2 +-
> >   drivers/gpu/drm/radeon/cik.c               | 14 ++--
> >   drivers/gpu/drm/radeon/dce6_afmt.c         |  2 +-
> >   drivers/gpu/drm/radeon/evergreen.c         | 12 ++--
> >   drivers/gpu/drm/radeon/ni.c                |  2 +-
> >   drivers/gpu/drm/radeon/r100.c              | 24 +++----
> >   drivers/gpu/drm/radeon/r300.c              |  6 +-
> >   drivers/gpu/drm/radeon/r420.c              |  6 +-
> >   drivers/gpu/drm/radeon/r520.c              |  2 +-
> >   drivers/gpu/drm/radeon/r600.c              | 12 ++--
> >   drivers/gpu/drm/radeon/r600_cs.c           |  2 +-
> >   drivers/gpu/drm/radeon/r600_dpm.c          |  4 +-
> >   drivers/gpu/drm/radeon/r600_hdmi.c         |  2 +-
> >   drivers/gpu/drm/radeon/radeon.h            | 11 +++-
> >   drivers/gpu/drm/radeon/radeon_acpi.c       | 10 +--
> >   drivers/gpu/drm/radeon/radeon_agp.c        |  2 +-
> >   drivers/gpu/drm/radeon/radeon_atombios.c   |  2 +-
> >   drivers/gpu/drm/radeon/radeon_audio.c      |  4 +-
> >   drivers/gpu/drm/radeon/radeon_combios.c    | 12 ++--
> >   drivers/gpu/drm/radeon/radeon_device.c     | 19 ++----
> >   drivers/gpu/drm/radeon/radeon_display.c    | 74 +++++++++++----------=
-
> >   drivers/gpu/drm/radeon/radeon_drv.c        | 27 +++++---
> >   drivers/gpu/drm/radeon/radeon_drv.h        |  1 -
> >   drivers/gpu/drm/radeon/radeon_fbdev.c      | 26 ++++----
> >   drivers/gpu/drm/radeon/radeon_fence.c      |  8 +--
> >   drivers/gpu/drm/radeon/radeon_gem.c        |  2 +-
> >   drivers/gpu/drm/radeon/radeon_i2c.c        |  2 +-
> >   drivers/gpu/drm/radeon/radeon_ib.c         |  2 +-
> >   drivers/gpu/drm/radeon/radeon_irq_kms.c    | 12 ++--
> >   drivers/gpu/drm/radeon/radeon_kms.c        | 18 ++----
> >   drivers/gpu/drm/radeon/radeon_object.c     |  2 +-
> >   drivers/gpu/drm/radeon/radeon_pm.c         | 20 +++---
> >   drivers/gpu/drm/radeon/radeon_ring.c       |  2 +-
> >   drivers/gpu/drm/radeon/radeon_ttm.c        |  6 +-
> >   drivers/gpu/drm/radeon/rs400.c             |  6 +-
> >   drivers/gpu/drm/radeon/rs600.c             | 14 ++--
> >   drivers/gpu/drm/radeon/rs690.c             |  2 +-
> >   drivers/gpu/drm/radeon/rv515.c             |  4 +-
> >   drivers/gpu/drm/radeon/rv770.c             |  2 +-
> >   drivers/gpu/drm/radeon/si.c                |  4 +-
> >   40 files changed, 193 insertions(+), 191 deletions(-)
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)
>

