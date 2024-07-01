Return-Path: <linux-kernel+bounces-235880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4EA91DABB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16DF285CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE6613D63B;
	Mon,  1 Jul 2024 08:54:47 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E213C821
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824086; cv=none; b=NS67/NzyOfPxvm7SbQeGKyeE+/DqL7gdVOvLc20cKUUxds3m7w8A3H8T6nEFQMtmPYn5459sIyDQA+g1pted+qs7Vx1iOBCEowiAp64Qnuk3HkE/OibpgY6AgFDOSZfLBTg4n5cG9znsnxTkdd2paKgjMFAjqfRAc97UMixbMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824086; c=relaxed/simple;
	bh=9NxIL7IjJ+MjTfOCcfUkgAi3GetouhmyNiDMUfbAyyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwYxsfXg9XybCO7JS6xzL4lXCUB9fiaGPzy3Gg0HBKGr/xG9aYQKsrCvvW1/5i6sR5kzC1YYvZtSUnb6alok+G8VDdRpq6YcYTfpF9Yuo7i+CtZLhzmUssY99PXPaWkZYDDfzct77CXVLy96AkoNWtyfUUrXzv0ExmkkEF4FP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64f4fd64773so930727b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719824082; x=1720428882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRJ/sPxYk0gpST/B9ghvIkC+M8aByXNTXzLiqxdF79M=;
        b=etpaU8ckHChUoyNeISKA3OrbdsH4e2CLTkmq3MekChLjS6GqYxVJaHqXyKCXIcGj8k
         pud9MwQpd+e2qryAqlvR4bdZLRByu15NJFoYLsKtS4TOCN127XwCIY33HY4JywkryhCd
         DWwuDc1W6bdGVPD35rnVgYvdmPyzE4tsZdVrxwIv6T3ehtPO8jGmaTFmLKkPlePzbLbo
         Iw7NdudE44/aXwtf9cQvh47qs1CsURZ8mAUWPevKfAos++KsQueNK0Ozoe5AxHJyr5NW
         qpaavyyPwe4pVuBUb185c0HT86KGoISRIc/d4eIknYGYWClxrWu+6B2H43MDU6Kx6GVM
         egpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI47FsrknYyN4NESslQGtl1Tm2m+T5v7mClKnQeLqDeI1nILIH+J37T/Y7QFDYWOu2/M4+eZcnESlOgf//lQezwzHkpcPnr2urIyAH
X-Gm-Message-State: AOJu0YxgbKIpUxTBCPhLKZAhxcgfkxuTr1POBzIPKeboQVDYemr9XGL7
	ghI6lIt4RiW1kJbf1jpaLdloIEQaMl2RdXz36JxNxlFrA5xxpmPNQxdwczTX
X-Google-Smtp-Source: AGHT+IFQJ0TfxsIkZvNVVhQYUrCh252zwLKXOaMxuOTxg+rtUJn40JGP0CmcJKtcK2AQRa6/81S6cQ==
X-Received: by 2002:a81:bf51:0:b0:64a:d9a1:db3f with SMTP id 00721157ae682-64c7114456fmr65260047b3.7.1719824082273;
        Mon, 01 Jul 2024 01:54:42 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a23c0a4sm12870767b3.54.2024.07.01.01.54.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 01:54:41 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so2806950276.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:54:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2qMuc7GyGnwV5lmLYvQgM0IJG2dVD8L8gUqW+59Ex1dBl5svrEY6fIfIUKW+PoGa9WC/95oL5zHpF1FnWuTisED5tmFrzC5el6L9l
X-Received: by 2002:a81:440b:0:b0:627:972f:baba with SMTP id
 00721157ae682-64c71fc2105mr59079497b3.31.1719824081315; Mon, 01 Jul 2024
 01:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627173530.460615-1-thuth@redhat.com> <571556ed-17d2-4bcc-bb1f-fd4f827829c6@suse.de>
 <2108ac92-e241-4507-a759-c23de90d041e@redhat.com>
In-Reply-To: <2108ac92-e241-4507-a759-c23de90d041e@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Jul 2024 10:54:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWf3bE5UdFHoer_iVXeMwfqMpFeAFppo0dzyzL0zeU55A@mail.gmail.com>
Message-ID: <CAMuHMdWf3bE5UdFHoer_iVXeMwfqMpFeAFppo0dzyzL0zeU55A@mail.gmail.com>
Subject: Re: [PATCH] drm/fbdev-generic: Fix framebuffer on big endian devices
To: Thomas Huth <thuth@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	Javier Martinez Canillas <javierm@redhat.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Jul 1, 2024 at 10:42=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
> On 28/06/2024 08.07, Thomas Zimmermann wrote:
> > Am 27.06.24 um 19:35 schrieb Thomas Huth:
> >> Starting with kernel 6.7, the framebuffer text console is not working
> >> anymore with the virtio-gpu device on s390x hosts. Such big endian fb
> >> devices are usinga different pixel ordering than little endian devices=
,
> >> e.g. DRM_FORMAT_BGRX8888 instead of DRM_FORMAT_XRGB8888.
> >>
> >> This used to work fine as long as drm_client_buffer_addfb() was still
> >> calling drm_mode_addfb() which called drm_driver_legacy_fb_format()
> >> internally to get the right format. But drm_client_buffer_addfb() has
> >> recently been reworked to call drm_mode_addfb2() instead with the
> >> format value that has been passed to it as a parameter (see commit
> >> 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to
> >> drm_mode_addfb2()").
> >>
> >> That format parameter is determined in drm_fbdev_generic_helper_fb_pro=
be()
> >> via the drm_mode_legacy_fb_format() function - which only generates
> >> formats suitable for little endian devices. So to fix this issue
> >> switch to drm_driver_legacy_fb_format() here instead to take the
> >> device endianness into consideration.
> >>
> >> Fixes: 6ae2ff23aa43 ("drm/client: Convert drm_client_buffer_addfb() to
> >> drm_mode_addfb2()")
> >> Closes: https://issues.redhat.com/browse/RHEL-45158
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> >
> >
> >> ---
> >>   drivers/gpu/drm/drm_fbdev_generic.c | 3 ++-
> >
> > This file is now called drm_fbdev_ttm.c in drm-misc-next.
>
> Oh, ok, shall I send a v2 that is adjusted to that change, or can it be
> fixed while applying my patch?

As this is a regression in mainline, which needs to be backported,
too, it's best to apply your fix to v6.10-rc6, which does not have
drm_fbdev_ttm.c yet.

> > And a similar patch might be necessary for drm_fbdev_dma.c.
>
> Looks similar, indeed. Shall I send a patch for that one, too? ... I
> currently don't have a setup for testing that, though...

Obviously these need to be fixed, too.

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

