Return-Path: <linux-kernel+bounces-233479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EB191B79E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2EB5B21665
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6349713F437;
	Fri, 28 Jun 2024 07:05:58 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3E13DB8A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558357; cv=none; b=e39u7RrP76AeTlbc598Co6Ih/DsMCDandENvDGpEETyV8SaOO/fGw2kLT6Ryl7RX4iWD6iCHaDRdJ2l42FfKz350oK6yxzFpX4DAwRjp/MkW7s4Wq6EdWZ756vwrIJCvIqzFhoYgyby40f7qrxpAoz1pVmdJFU6OQ4VDW8q8hrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558357; c=relaxed/simple;
	bh=botgzqyyuozUCKdPVfhlPn67HK8G/sIqeExP7g0sBdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmFii7fMkT64yPkz8fgb6dzh4UarDAzztbWlJCvYLO5o9cxcQgT3pB9rStEwoowzZO30jpF2cMn0yfFyCcGwe5C1hifBt4LqygWhzbFdRU4IQ9wZP1KREdvi4SRBrkrgnMxs7NbSeeTEUyMfTHkw9k2Ymdnuq9k8E1ov8nVC1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e02748b2402so263826276.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558354; x=1720163154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+FYZpltnsI5f0dWtxLVpiN9qP/1Z2ifl8T1bH4bPTE=;
        b=gJjNXJ1BGTcjYkX69VtsSpqzdCtSwjVZEwALwRDQ4PXnaimptEqsGuIGoce471lWQF
         Y94ajZReFKNrtux2Y3LvfGasJc3WkOvkjhV7nTNkV2OKO8dRrpLPGMLcwYe3a5dSLEjv
         bzQwApThaP+on8L9eh6+8SM6ocGP9WBh/9fv/Cl8P0OQ4i3/TBzXQdxil32/UTks2TP+
         iVeynePak4fZCUxHBwNGrIcFrq0ZsMgkgHjSe6vDwrLnFgYs8gjPif+npxK7rJ25Vn2D
         MfsZohSEcjojfSnAnfVeiX+9YS3oXbvJz0IwxklF9fXEJWTG6Xdh4/bzPZRRcMHbnolL
         /UMg==
X-Forwarded-Encrypted: i=1; AJvYcCVJosENm8jhZvbrZyAqk5Wi8OQTkw9626vzc3xIIk3rD0g1UfrLveWo+0KM/X6FjOdbSupRpgfcUsQEyX2h0ZyhawPK7f2uKuljy8oH
X-Gm-Message-State: AOJu0YzbyXPcuee11rmEiIFgegZvsD8ogoq4X1+0jPQ2UkxZQ0zIiZ0m
	l0SWzPb20nSQpegR7w6L9w4hNehI6KtIwFURF3HWYOZp6Nq/Kk4xcANMDQJD
X-Google-Smtp-Source: AGHT+IHUcZEIww3Um7AqL0wWBc4Zh96VV13FDlU+LISE2xSHuXgfz+o2bVepScZqjGFwNMWUoAYObw==
X-Received: by 2002:a81:f105:0:b0:622:df58:2cf6 with SMTP id 00721157ae682-643ac42da63mr125738117b3.50.1719558353845;
        Fri, 28 Jun 2024 00:05:53 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a803fb8sm2431317b3.60.2024.06.28.00.05.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:05:53 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-64b417e1511so929057b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:05:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNDp0RDnxYZXqWIs2aO4vrTEWCofC5bnAKwyvmBDC1OoewoHXpxfvWPATPzX8OCC3jpAwqwY6M9k15xVMAt4SFSyNqFjsZdUNl4kTq
X-Received: by 2002:a81:b049:0:b0:64b:4a32:850a with SMTP id
 00721157ae682-64b4a328848mr1657517b3.29.1719558352976; Fri, 28 Jun 2024
 00:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627173530.460615-1-thuth@redhat.com> <571556ed-17d2-4bcc-bb1f-fd4f827829c6@suse.de>
In-Reply-To: <571556ed-17d2-4bcc-bb1f-fd4f827829c6@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Jun 2024 09:05:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2tk76CZAR=xCJTuwiotO+=J=VaQaozSZ9fLU6eWeWZg@mail.gmail.com>
Message-ID: <CAMuHMdW2tk76CZAR=xCJTuwiotO+=J=VaQaozSZ9fLU6eWeWZg@mail.gmail.com>
Subject: Re: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, Jun 28, 2024 at 8:07=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
> Am 27.06.24 um 19:35 schrieb Thomas Huth:
> > Starting with kernel 6.7, the framebuffer text console is not working
> > anymore with the virtio-gpu device on s390x hosts. Such big endian fb
> > devices are usinga different pixel ordering than little endian devices,
> > e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.
> >
> > This used to work fine as long as drm_client_buffer_addfb() was still
> > calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
> > internally to get the right format. But drm_client_buffer_addfb() has
> > recently been reworked to call drm_mode_addfb2() instead with the
> > format value that has been passed to it as a parameter (see commit
> > 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mod=
e_addfb2()").
> >
> > That format parameter is determined in drm_fbdev_generic_helper_fb_prob=
e()
> > via the drm_mode_legacy_fb_format() function - which only generates
> > formats suitable for little endian devices. So to fix this issue
> > switch to drm_driver_legacy_fb_format() here instead to take the
> > device endianness into consideration.
> >
> > Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to =
drm_mode_addfb2()")
> > Closes: https://issues.redhat.com/browse/RHEL-45158
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
>
> > ---
> >   drivers/gpu/drm/drm_fbdev_generic.c | 3 ++-
>
> This file is now called drm_fbdev_ttm.c in drm-misc-next. And a similar
> patch might be necessary for drm_fbdev_dma.c. The code in
> drm_fbdev_shmem.c apparently has it already.

We are getting too many copies of this logic...
(yup, had to fix them all up in my WIP support for R1 ;-)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

