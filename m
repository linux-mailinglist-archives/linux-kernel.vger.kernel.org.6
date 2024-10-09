Return-Path: <linux-kernel+bounces-356973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346ED9969BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED57B283F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881691922CC;
	Wed,  9 Oct 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="XSLsj/W6"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657B18C34B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476167; cv=none; b=j4fNvefwjoX9pY23jKba2oTG/Hr8OQSajtf4Z6Ab8UpQwWot7lzITxZYDT3tk+/mFhaQlj9D2eKlFJ8DngIp0meKwS/pefD686R2RT3suKcpgxMgJ8wPvYT8ZpPJw5IeTKziLCP5USfXgYCNFcWkKSAaVkEBlw4s41GPqFM/ZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476167; c=relaxed/simple;
	bh=fL5BMKCHZvhNvqU2KckoC1NE08e6VHPsdX1SKOuB0tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc3y9mTgrAjBb2cp9FRJwRF3q5QsmtXFLQDwPdoMAoTbbzXneP9Nmwv9qnmeoFDcx3CwuBG5syEIcRtj9l/nIX1C2f22oBnOk6062GjylUKILCQA2WP3oygNhL65RcsM7us+IpCZ5c6WTgJRHzy8u3lk5GKi5DmxiuFYTbqk1EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=XSLsj/W6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e28fc33fd8eso844870276.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1728476164; x=1729080964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP3TO6PzMnYHnnQsF3wSVvNFppGWS7tXRNkouPbefzM=;
        b=XSLsj/W6v7KaEUfucGaNDajT9GZoTsy8D+LhQtXZFDUsHwUGQ9w/k4+Pc3Qy7IhdqH
         jNJ8TwG0oTIiElxanFQAIGjn74RMO94cTFtfQSbxsBfx3WBk5CUaCcao+6KTvIEbmPS0
         M/NkqkAzkcEBispg4myPc/qFjr4mfa245K5cP1BTfkC6qEmuU6WfcFmSuPCU830FSElb
         zzCQbd8Ch2T+D78hbkM97COERev7xJVYHGbJjGkcxSlfeLnnJ17k1s4cn+j7FKTAta3h
         M1tbi0BvmHIqkHx0LlT8qJPJb0CI6FmrXQTYcHOKA/em8V9ODvDXg8yeY96lfK1o58tV
         JTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476164; x=1729080964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SP3TO6PzMnYHnnQsF3wSVvNFppGWS7tXRNkouPbefzM=;
        b=fcJUv56/WxIrhJe4TvTjbVUxtmgPT8PcK8upjoyAwOSJFCwMSEB5yHWuPjDVswtHco
         DvqrlyXZNPHkIR7vk6E00Tcm4kdCobS7nr7AxSYK0E7mZVaAZK7c2OPpWUZWSkUOqbw3
         y6g1aaYTk3nNeZqOV3rFoElg21umUwgOtPVzAkwuASGJ3LjHu0raGmZcFLWe+rZ/hRG4
         JOitwB2giZ18vVLxw/iQLtXkFnjVWcLEGlsM8ChyXNPzWRzJ2HLFac5FdTgXxAqKyvBD
         rVf+eEzk2hM6jrY1xoMCQLYnigKQKVj3/DB0ePFiwQ6swkvkk0zt/foJfqvgDSXiuS/D
         FORw==
X-Forwarded-Encrypted: i=1; AJvYcCXRV5YUkQMvGduxNaiomrGIVBqoRtMpmtVcYKp5nQoXxCChiXwsdyts8J8BrDQbIme8PmK/I5aKJHIUcvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOK6Heu/01w4huVlJBvzo6aA1psVdIfY/Jro5/0NjgcfdPaUvn
	1oAZLSyHUJPHmSFzZ6GQ0dRWx4iOHUkoWes5FRrhB6Joxfx/AaWvqFByGzPTXNjmp4h4KtNNR0x
	IlPT4oV/QJ3rfaaqXccqYkyYlvo4JmeYDqZaxfA==
X-Google-Smtp-Source: AGHT+IEjqph+QOBkdC2wgmaMeMXSihsDIdEYasz72e+xVwTC+AQjHciiKXf6ktHHAe3sCryvIdzDZehqTofRN1fBwpc=
X-Received: by 2002:a25:94d:0:b0:e20:291e:7fe1 with SMTP id
 3f1490d57ef6-e28fe45cf09mr1822059276.25.1728476164318; Wed, 09 Oct 2024
 05:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-vc4_fbdev_fix-v1-0-8737bd11b147@raspberrypi.com>
 <20241002-vc4_fbdev_fix-v1-1-8737bd11b147@raspberrypi.com> <b1d76661-41b9-4841-80f4-452654d9cd6b@igalia.com>
In-Reply-To: <b1d76661-41b9-4841-80f4-452654d9cd6b@igalia.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 9 Oct 2024 13:15:48 +0100
Message-ID: <CAPY8ntDgkyQ6ijdgB2Qmd45ArtXqYFwfmpvYgQhobnw=bUnd-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vc4: Run default client setup for all variants.
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Javier Martinez Canillas <javierm@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Oct 2024 at 12:02, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> Hi Dave,
>
> On 10/2/24 12:06, Dave Stevenson wrote:
> > Commit 45903624e9fc ("drm/vc4: Run DRM default client setup")
> > only added DRM_FBDEV_DMA_DRIVER_OPS for the vc4 (Pi0-3) driver
> > definition, which caused an issue on vc5 (Pi4) as there was no
> > fbdev_probe function defined.
> >
> > Fixes: 45903624e9fc ("drm/vc4: Run DRM default client setup")
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>
> Reviewed-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Applied to drm-misc-next.

> Best Regards,
> - Ma=C3=ADra
>
> > ---
> >   drivers/gpu/drm/vc4/vc4_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_dr=
v.c
> > index 13a1ecddbca3..a238f76a6073 100644
> > --- a/drivers/gpu/drm/vc4/vc4_drv.c
> > +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> > @@ -238,6 +238,7 @@ const struct drm_driver vc5_drm_driver =3D {
> >   #endif
> >
> >       DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(vc5_dumb_create),
> > +     DRM_FBDEV_DMA_DRIVER_OPS,
> >
> >       .fops =3D &vc4_drm_fops,
> >
> >

