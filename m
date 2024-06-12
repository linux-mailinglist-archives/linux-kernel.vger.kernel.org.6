Return-Path: <linux-kernel+bounces-211190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3190904E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18CC1C23423
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1049316D32D;
	Wed, 12 Jun 2024 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kOqLVRCa"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3223169ACD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181364; cv=none; b=k4bNnIEj2hequ7ScoLOsYLqebKNDNR5w0XmDtEbM5liS1KZUe5Y/Ouu12n91a0ybQXwI3wtO9zBU3P4Jp30pA7FH2X0c03O7kREb8v5T+Q6R6gvlDu0+Ok+ztaC4GliZjLVx5TGajXy0IA4iwxEDelnj4RsRTDn3rCwBEky6ziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181364; c=relaxed/simple;
	bh=doc3wh/NDobak9luRx8Vah60RaiI2YbRUzuglJj4iF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUW0ocfVaIW/7BWxeKPQJ/V4gxJ9qWdOC0M3/m1D6jlkKa2AS5nkz/N22ey/8Ed80Kj9dQMjYFSeuZqFuMm6s3O/3apuIumoEJM8Ml7s8X+IcMGibMraULKh6SNuhRt1cQ2vQvAINFTUcQHlhePvBq5W8p+87osmJjYRs3k63HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kOqLVRCa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so237416266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718181360; x=1718786160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96JHV5aiT5xFVHpkcSz0cCY5wiynRMtgpF9ScNLxjE4=;
        b=kOqLVRCaNQLBlIVOR5jIzBkS9kjhau9co0udjMp4HnUB+LGuYIObgPxlaKUfgL2flC
         7zNphPS4K3F/24pxLCBM8ZKqvsgGJdtenIqGB9qmxLDzXw89N+pmdNZG9nokOWAvuMva
         vBCYwPWjtFs1sfag3of9+dnMaej/9TTeYBGhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718181360; x=1718786160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96JHV5aiT5xFVHpkcSz0cCY5wiynRMtgpF9ScNLxjE4=;
        b=nj4hwi/a0uPHH2lj5ph2TVkycIJltRqCK1u/74rWK6HYH8uBUjXOnsxQHCXj9O0I5N
         DcDPqBvgBpjcveJvJylNcIYP1dzyiNtZMHhYhHXI/q1vb+MI+9itcY0c5h00nuDX3SuB
         eLXTfrW75b9eBsLSo9m6lfJJD2rVuLFblZXYJ8M1sV1Vra2vwOCujvR5J9X1+rE4LCMc
         fAPM28eGs0mklyFV73IqDh47ZoYpFaS7+szrNMbM+VLwQZp5kTP02E5hr21NLA3+s0Fv
         MSVKLgYKi614A2607ElMQIqIr/8wDiVMHk2CTZx6uU26AQJEQvheIVCzIbF2shnxblnx
         tKiA==
X-Forwarded-Encrypted: i=1; AJvYcCUKVj+mOFSASGpfJgDUvc4VNdLY6vsPBEmnzzokiucWryULRjnrRGkiibLk3qFYUpetPrefW7g7FrtaisHpFTRvVYXDHP+Vft+NKJEo
X-Gm-Message-State: AOJu0Yzuv+iDuIVD5oX/igRuqFHfw72AVZNy5OimnKPus93KM7pYUqRe
	paiFpcroDsCuZkuWTKYstphZTqmF5PKR4UXggVRrDRjPHnctO7SfWlSLPXNfufpIDz/mwKbgRns
	TOA==
X-Google-Smtp-Source: AGHT+IF+1noQhBYdbefnKVMlgRYIDWr3IlJVxPa8HoEyKtYnm25J5HyHpt1g91XhKaFqOTRpKi7DtQ==
X-Received: by 2002:a17:906:f35b:b0:a68:d2dd:e006 with SMTP id a640c23a62f3a-a6f47cbc16amr73358566b.17.1718181359648;
        Wed, 12 Jun 2024 01:35:59 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1dd4595asm374287266b.22.2024.06.12.01.35.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 01:35:59 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f176c5c10so231901866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:35:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtyDN0POm290XDfcSiAJlOnUu3a+fILtFWUAZfUYRMpXTSwZ0Fq2bgZt0De427gqUzIs78yYB7QrIe8801W4USR0CmthKIdUuPUcVP
X-Received: by 2002:a17:906:741:b0:a6f:1f7b:6a8b with SMTP id
 a640c23a62f3a-a6f47f803fbmr63433366b.66.1718181358251; Wed, 12 Jun 2024
 01:35:58 -0700 (PDT)
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
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 12 Jun 2024 17:35:38 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AS_h_ydkNnKU-y--Cd_SSoMyyQhj6tXeZ_oydoqzwFFw@mail.gmail.com>
Message-ID: <CAAFQd5AS_h_ydkNnKU-y--Cd_SSoMyyQhj6tXeZ_oydoqzwFFw@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] media: uvcvideo: Allow hw clock updates with
 buffers not full
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 4:44=E2=80=AFPM Laurent Pinchart
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

Okay, I see. That would make it easier indeed. :)

That said, we still need to provide some valid timestamps in the
v4l2_buffer struct returned from DQBUF, as per the current API
contract, so we can't simply remove the timestamp handling code from
the kernel completely.

