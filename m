Return-Path: <linux-kernel+bounces-233477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B2B91B787
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFDF51F21D71
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385113DB90;
	Fri, 28 Jun 2024 07:04:08 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C5125AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558247; cv=none; b=gjMCuFMz3AA1h4k3NTGVK5GkC4KElm1J0wv7Ifpxy9QmvNKHuupWtMxHLp52BplW054E5VOJYmhrnXaMwqzUooXDng+zTYoEke51odNwJYWTBeCkKHC6hNgOq13Ox0p5pIpbO1OtOKR00RLd6s3AUjN4MsDh+9BHlpaF6x9wHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558247; c=relaxed/simple;
	bh=lxYNJK4GyW/o8cyCG3eFSJLlMQJAQfW3Y7irdMMEYNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYCyOI9+/aJach+hvN2OgAgJ6/IgTbL5DakwHeRhzolHPMkq0iOfEJ+6YH+B4NyWUY5zvDxhCnUG0E+yqeh3L/0NnpquqO7nnYVHyZ2UGMTN3Xe/S5ed6ClU8ShVgCEK8MItnyMIyLLwlIPQ3mhy4Xou3UqwBzAt1JJhNHO3Tbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64789495923so2532307b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558243; x=1720163043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4VYcLeI6FK6UKDIjd//YA7QOqVsn4Xvt1s7Cj81jOs=;
        b=eSRkR3ffQZ8cplKM2FQ4r08k7C9GNSmI41znJXS/cBQKe4U7xpxiqo7WV8/YG2uHW3
         94ZvEPil5TdQX5qwWySXDowFcSzK/CxoAB5Mg9Y+ZxMDPu8KVyC9lwcUamyGj+D3vay5
         3s2FqD1qYWIyi8KVRwjX8MLHyGH2RuJO149uOGyrEFKTTxaqb+NCvNy6b26HJNpw9GxZ
         Jdls078iGz/TU437sQvl6LP/REERuycWmdvki5ypgU+eShxBviY5+vkEuPYE5lzgQotS
         wGZi0rtAIMaLLZCXdP1r5pWpiyei1BNz2SRXLGwHuBNSDNHH2fFiIC0huwPoW1/cFJ20
         1a+A==
X-Forwarded-Encrypted: i=1; AJvYcCUgiInhHhlPNKr0AyBRmxYOnY+y6LVSl7MLDqZlnj+dlKdy2EL2ZDXpybe1F63JBGOLkEiEZBSVCujX2gE2Nxoqp71DRmSk/dyAbg3a
X-Gm-Message-State: AOJu0YzEMTrCrmjxDqxC2tytt6hgE9ROvlK+pEybBqvVtouXSYgFpLH2
	hhYmkAA9YtcB800kY2pYFzTcfffQN1/IQhuixLVZ6P0EDdClph2MfJr12GET
X-Google-Smtp-Source: AGHT+IGKlx9DNBdvRvzjsltJmYQRAcFupGvwZf4TlFsc3qU6wjm3GTUoKrtXF9lKB1WC2oDjM4H4ug==
X-Received: by 2002:a81:844a:0:b0:63b:d242:4fa0 with SMTP id 00721157ae682-649c13117aemr37868787b3.21.1719558243430;
        Fri, 28 Jun 2024 00:04:03 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a239b5asm2458577b3.41.2024.06.28.00.04.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:04:03 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64789495923so2532127b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:04:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUETatJOV/XJ3RjuS2AfkMIz5R1L6ADa26nwFuBEypgF7/beJ7FXSZpkw5LtwgbP8M2HlLqfxJoJRvmwz6GL/N+eoin0GdCjdzZMEYM
X-Received: by 2002:a05:690c:944:b0:64a:397f:9599 with SMTP id
 00721157ae682-64a397f9801mr27078607b3.30.1719558242907; Fri, 28 Jun 2024
 00:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627173530.460615-1-thuth@redhat.com>
In-Reply-To: <20240627173530.460615-1-thuth@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Jun 2024 09:03:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU4cpizpk7CWPbCs3GKJcG95yrnh9FwwEgLsm17wa-fNA@mail.gmail.com>
Message-ID: <CAMuHMdU4cpizpk7CWPbCs3GKJcG95yrnh9FwwEgLsm17wa-fNA@mail.gmail.com>
Subject: Re: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
To: Thomas Huth <thuth@redhat.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

CC Christian

On Thu, Jun 27, 2024 at 7:35=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
> Starting with kernel 6.7, the framebuffer text console is not working
> anymore with the virtio-gpu device on s390x hosts. Such big endian fb
> devices are usinga different pixel ordering than little endian devices,
> e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.
>
> This used to work fine as long as drm_client_buffer_addfb() was still
> calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
> internally to get the right format. But drm_client_buffer_addfb() has
> recently been reworked to call drm_mode_addfb2() instead with the
> format value that has been passed to it as a parameter (see commit
> 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to drm_mode_=
addfb2()").
>
> That format parameter is determined in drm_fbdev_generic_helper_fb_probe(=
)
> via the drm_mode_legacy_fb_format() function - which only generates
> formats suitable for little endian devices. So to fix this issue
> switch to drm_driver_legacy_fb_format() here instead to take the
> device endianness into consideration.
>
> Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to dr=
m_mode_addfb2()")
> Closes: https://issues.redhat.com/browse/RHEL-45158
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
works fine on m68k-virt, so:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Christian had reported a similar issue before[1].
I submitted a different solution fixing virtio[2] instead, but that
caused issues with virtio-mouse-pci cursor...

> --- a/drivers/gpu/drm/drm_fbdev_generic.c
> +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> @@ -84,7 +84,8 @@ static int drm_fbdev_generic_helper_fb_probe(struct drm=
_fb_helper *fb_helper,
>                     sizes->surface_width, sizes->surface_height,
>                     sizes->surface_bpp);
>
> -       format =3D drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->s=
urface_depth);
> +       format =3D drm_driver_legacy_fb_format(dev, sizes->surface_bpp,
> +                                            sizes->surface_depth);
>         buffer =3D drm_client_framebuffer_create(client, sizes->surface_w=
idth,
>                                                sizes->surface_height, for=
mat);
>         if (IS_ERR(buffer))

[1] https://lore.kernel.org/6530cea3-4507-454e-bc36-a6970c8e7578@xenosoft.d=
e/
[2] "[PATCH v2] drm/virtio: Add suppport for non-native buffer formats"
    https://lore.kernel.org/47a81d2e0e47b1715718779b6978a8b595cc7c5d.170014=
0609.git.geert@linux-m68k.org

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

