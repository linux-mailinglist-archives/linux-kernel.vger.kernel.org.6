Return-Path: <linux-kernel+bounces-211098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E6904D19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918B41F21F19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B116C699;
	Wed, 12 Jun 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jaX7PZYR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9817C9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178467; cv=none; b=sYHfemYh8JxEtGYxEi8e+mnzD1OBJIZAvPrDhsM4jn2oLyEl6QoViOrk1FDt5Rjy14XehZmHyp9i1hcrDYFtBokdX62aJJEbnwnKzbYrM0ylJBKBiMFZ+KbathLFgVqrv8IAtAGjwUAawf8BdBAQoKOyVKGc/iECS7kxJj4cvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178467; c=relaxed/simple;
	bh=+tl9JMqUu0n+y7TzF8Ko462bpmGnHN5qKwZIJDCVbU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA0mFnT5lIB5pN4+//FeqNbC/TFnZlRXB2FjRAWRZifDZxHKwoSJACcCi2WgXQcnwVcSYa0sUwZnpLEVxgRBrOCSsBVPG+vX6Uo935XpLo46kkR/5M/3GpZifsMByfUMOdW0mZfp4fctt6jehv13/+6o1CtMuuOZoauUyev3SUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jaX7PZYR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc1261f45so5073132e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718178462; x=1718783262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLdTXN9lYe0a3EsiIXNNLenN6Ja+aPhpUeSTY7jocuk=;
        b=jaX7PZYRr2Ktc3Ao3BIi5Xw92yLS37DI6+uEJaGmMpRlJAq0rlzzQfEkYluwOigUZo
         j87gsAzAHn23OYO806EyzIKT4Tt4J2oK92yqFryng0egZASs/v2kJDGwBwgJjDMOAI0q
         jNLKX1q+33hZhm7wzh6HtahzUy/Etur6kTZew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178462; x=1718783262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLdTXN9lYe0a3EsiIXNNLenN6Ja+aPhpUeSTY7jocuk=;
        b=T9i6fI2UlPAjx0Thnh8xYvNpeRjXeaVKlTczHbhPv+4Y6wGHiXozetejneHZxa3nzS
         cKgv+M4Hu03ldg11nBes77dAEW6aErDOZ3lCbahn4bu2yKmz/hUhsTIMYrd8FP51ujWa
         ZyCBkGAYhPuoRXiGhAdfQBI5bBrZVL5MtjYPvrzbRLLUOXOVgmzf7efeB/J5jYIxizZE
         J3KU/N/K8Esq2M8W+7JJRj5p+7kzsDiOTLVhn0N+/8zXnCjm+ulrPNog2BMoeGSueKWp
         7bGN9cYBhIVARW1fcDjlh7PZdaYmrOrdShCwM9/sXlb/79xe5rH16P0eD0AbYIxOmnxx
         kDBw==
X-Forwarded-Encrypted: i=1; AJvYcCVtJE4sHza+oxX9fxKBkgX+E1yTO7Pl4lrZbfMdakLI4ddvxMw7mJ1LzA4WTIbzAVULZLykrtp31JV8JqHzA6/2d/cHmnv7dGFXNsw0
X-Gm-Message-State: AOJu0YwEvSalKSy7oqU8qPuFwUgVKW2Kqjw0dZA3J18Mp+MzTkPVthvk
	z2wMc1icBANSWoPuQurDdFhKk2urLJI1daS7r0BDadBOV03CLagAikXGmumGkaRDk26UiNjbnTn
	xTLyd
X-Google-Smtp-Source: AGHT+IHEjBhhKBTGsmKZsgVTT2SpEB12AS0UlFo9uEd5yNSMHUIfrTa3ByB/zyF1EI8zbShjJUm+lA==
X-Received: by 2002:a19:ca0d:0:b0:52b:bd9f:d8ef with SMTP id 2adb3069b0e04-52c9a4053dfmr528385e87.60.1718178462118;
        Wed, 12 Jun 2024 00:47:42 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e2054sm2374798e87.49.2024.06.12.00.47.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 00:47:41 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52bc1261f45so5073117e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:47:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzlOraT+7pFJj6uwDAj9wHzUqY2FOvMRTQeU9zXyMZkEIT/pC8oRwSQR9V0CfZL/KEwK/dKW424D7uol5IYAv3wze3AZ364vyZAJzA
X-Received: by 2002:a05:6512:61b:b0:52b:ce2f:5d11 with SMTP id
 2adb3069b0e04-52c9a3c6eb8mr505332e87.25.1718178461142; Wed, 12 Jun 2024
 00:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <20240323-resend-hwtimestamp-v10-4-b08e590d97c7@chromium.org>
 <4kck7oedsnj6kfiv7ykwsjg35qodg5bdktu5t5w3xtg2xuscto@2yh6kfdqwimc>
 <20240610114306.GR18479@pendragon.ideasonboard.com> <CAAFQd5DAXq6fTrp6jF42URrwzwE+tGz_jJCRM2bhieD76u+QpA@mail.gmail.com>
 <20240612074342.GA28989@pendragon.ideasonboard.com>
In-Reply-To: <20240612074342.GA28989@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 12 Jun 2024 09:47:26 +0200
X-Gmail-Original-Message-ID: <CANiDSCuM9RdQ9Tq4-vL2b8UP3_GFV41gvnKm7Gmh2dpmCO98+A@mail.gmail.com>
Message-ID: <CANiDSCuM9RdQ9Tq4-vL2b8UP3_GFV41gvnKm7Gmh2dpmCO98+A@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] media: uvcvideo: Allow hw clock updates with
 buffers not full
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jun 2024 at 09:44, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jun 12, 2024 at 12:28:56PM +0900, Tomasz Figa wrote:
> > On Mon, Jun 10, 2024 at 8:43=E2=80=AFPM Laurent Pinchart wrote:
> > > On Wed, May 29, 2024 at 05:03:08PM +0900, Tomasz Figa wrote:
> > > > On Sat, Mar 23, 2024 at 10:48:05AM +0000, Ricardo Ribalda wrote:
> > > > > With UVC 1.5 we get as little as one clock sample per frame. Whic=
h means
> > > > > that it takes 32 frames to move from the software timestamp to th=
e
> > > > > hardware timestamp method.
> > > > >
> > > > > This results in abrupt changes in the timestamping after 32 frame=
s (~1
> > > > > second), resulting in noticeable artifacts when used for encoding=
.
> > > > >
> > > > > With this patch we modify the update algorithm to work with whate=
ver
> > > > > amount of values are available.
> > > > >
> > > > > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > > > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++--
> > > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/us=
b/uvc/uvc_video.c
> > > > > index d6ca383f643e3..af25b9f1b53fe 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > > @@ -768,10 +768,10 @@ void uvc_video_clock_update(struct uvc_stre=
aming *stream,
> > > > >
> > > > >     spin_lock_irqsave(&clock->lock, flags);
> > > > >
> > > > > -   if (clock->count < clock->size)
> > > > > +   if (clock->count < 2)
> > > > >             goto done;
> > > > >
> > > > > -   first =3D &clock->samples[clock->head];
> > > > > +   first =3D &clock->samples[(clock->head - clock->count + clock=
->size) % clock->size];
> > > > >     last =3D &clock->samples[(clock->head - 1 + clock->size) % cl=
ock->size];
> > > > >
> > > > >     /* First step, PTS to SOF conversion. */
> > > > > @@ -786,6 +786,18 @@ void uvc_video_clock_update(struct uvc_strea=
ming *stream,
> > > > >     if (y2 < y1)
> > > > >             y2 +=3D 2048 << 16;
> > > > >
> > > > > +   /*
> > > > > +    * Have at least 1/4 of a second of timestamps before we
> > > > > +    * try to do any calculation. Otherwise we do not have enough
> > > > > +    * precision. This value was determined by running Android CT=
S
> > > > > +    * on different devices.
> > > > > +    *
> > > > > +    * dev_sof runs at 1KHz, and we have a fixed point precision =
of
> > > > > +    * 16 bits.
> > > > > +    */
> > > > > +   if ((y2 - y1) < ((1000 / 4) << 16))
> > > > > +           goto done;
> > > >
> > > > Not a comment for this patch directly, but...
> > > >
> > > > This kind of makes me wonder if we don't want to have some document=
ation
> > > > that specifies what the userspace can expect from the timestamps, s=
o
> > > > that this isn't changed randomly in the future breaking what was fi=
xed
> > > > by this patch.
> > >
> > > I think timestamp handling should really be moved to userspace. It wi=
ll
> > > be easier to handle with floating-point arithmetic there. That would
> > > have been difficult to manage for applications a while ago, but now t=
hat
> > > we have libcamera, we could implement it there. This isn't high on my
> > > todo list though.
> >
> > While indeed that would probably be a better way to handle the complex
> > logic if we designed the driver today, we already have userspace that
> > expects the timestamps to be handled correctly in the kernel. I
> > suspect moving it to the userspace would require some core V4L2
> > changes to define a new timestamp handling mode, where multiple raw
> > hardware timestamps are exposed to the userspace, instead of the high
> > level system monotonic one.
>
> The uvcvideo driver already supports exposing the packet headers to
> userspace through a metadata capture device, so I think we have all the
> components we need. The only missing thing would be the implementation
> in libcamera :-)

We would still have to duplicate the quirk information in libcamera
and the kernel.



>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

