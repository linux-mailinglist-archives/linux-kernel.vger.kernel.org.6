Return-Path: <linux-kernel+bounces-211205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD71904E74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2270F287B39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154116D4DF;
	Wed, 12 Jun 2024 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BfQtPKIb"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A216D305
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182118; cv=none; b=DfIousAbQw5SSLz37hqYQJaw5IfydHXTXGQQQFSrJYZZ4eBH5DF5ovEJOEBA69gX7CxBB1oR54k5FjH03O5iQXYXQXu0PG0KmOkFZ0tHEVi41BJU1GqtaCPMZQ+v8Tdj43szZGbNfu6Y2gR1A+EGY4tIuTp0LObOc6BKh5xMj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182118; c=relaxed/simple;
	bh=uW3zlwozbkwBk3Q0UO6Rb/luAmvnclY7u9aDX3Hq14w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koGkwReUfHMr7gW8LLnNM9BYvanjXElPPHlz5FZZNEl0CLs7TdKX2glaFIYik3DiIoBBy3A0KtoaDY9yulza6OUGY35+m+h2A2pPugFTcXHjFjEYjhjPjJnvbO2BBYU2FIZMMUdPlxVxx0JFMGsIdHs+6nazV7qd21YY1nfHT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BfQtPKIb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so481987466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718182114; x=1718786914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtVbKt1Lt/6TaBr1LN7eGKLsWZLDTjib6uq4q3NlYf0=;
        b=BfQtPKIbv6wbIv3KDR67Bero1oc7umSI3o0oJ2gOxo93mPP0r9VuD4Rg99RYZa2UVi
         hjimtmU4xyYcFukC041DrqHYXSqdphgXD6y0jZMOXINIHvdiHicS8BV76CH6ZKkOrozB
         v+ur5RfrFO653cGlqlQpDmbZlqL1F8UjWGRWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718182114; x=1718786914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtVbKt1Lt/6TaBr1LN7eGKLsWZLDTjib6uq4q3NlYf0=;
        b=KPul118hRWvPmjbMe7DPm5VoqboYHd5P0jldjTP0B0eG6QpoFwmOq+DIDnXpPZSm3L
         Z2mPVaYQMZSgJT54Z7RKdx2G/hyJnsmyu7FrTQsCSlEwDnkmC9Tyc5Z5OY2mcuw2HbOK
         FLcBT3ZGAlPDuT7GEGPn61QXl3F0HGMFdJfh/PZ8ncly12AzuYIVkgpxXQ3MdB9u0/wk
         Dg3wSo9zhCTWHrx+uVCH8uSoL6jisksoyF/nR0MmTTYh6eO5P85qT0avsG7QwhG5w5Zx
         kNtBudbW4YLIW/J+7dWMpen0aB3Mt7Er3E9AIDvcZ4/E0JlwKw81+ara7jwnkY+iwD33
         3Bow==
X-Forwarded-Encrypted: i=1; AJvYcCWYq4q2X1EDbowt3kWzU96fKuqQBXdBwwCnpZXG04A41oajUsHHYeDvf31qh1Qbk4kixC7HXzVZfe4moJORnOKYZgRhE3dskrAzVy3P
X-Gm-Message-State: AOJu0YzmPqpsksXbn4LIgLm0dlcZL0LY71P4dQOvNgERwRx7PxYjXAyQ
	VbRiMuxfQ/FZ9MGKqEakJXDleiVhN8jINzwef0bQz4RqxnNW4jl6ioB4AcSiRCmEKbP+6rqE18B
	+/A==
X-Google-Smtp-Source: AGHT+IEu/9GOJhP0lZlXEyAz/tjVyf7uUHP7IlxTLmNCoImwq28c/VujQ2f0dRUGUqOjR23068cP0g==
X-Received: by 2002:a17:907:9724:b0:a6e:f6b0:c49d with SMTP id a640c23a62f3a-a6f47d526b2mr86760766b.34.1718182114530;
        Wed, 12 Jun 2024 01:48:34 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0e47b8f7sm518143566b.31.2024.06.12.01.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 01:48:33 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso4898093a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:48:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOb06e9UtjRFZr4iC2G6rM75cACP/fdJHK16OOJfClD5eSUOtPsRljABZq11xcpwBsLribLh2O08g/l6LxMz4yZrJZ8vxZPOaXqCgK
X-Received: by 2002:a17:906:f5a3:b0:a64:722f:4051 with SMTP id
 a640c23a62f3a-a6f47c07d92mr76196066b.0.1718182112798; Wed, 12 Jun 2024
 01:48:32 -0700 (PDT)
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
 <20240612074342.GA28989@pendragon.ideasonboard.com> <CANiDSCuM9RdQ9Tq4-vL2b8UP3_GFV41gvnKm7Gmh2dpmCO98+A@mail.gmail.com>
 <20240612082040.GD28989@pendragon.ideasonboard.com>
In-Reply-To: <20240612082040.GD28989@pendragon.ideasonboard.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 12 Jun 2024 17:47:52 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B8eOkXMY0m=y6A+3MjEny-UMTteBAhAahDWc1y52woWw@mail.gmail.com>
Message-ID: <CAAFQd5B8eOkXMY0m=y6A+3MjEny-UMTteBAhAahDWc1y52woWw@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] media: uvcvideo: Allow hw clock updates with
 buffers not full
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 5:21=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Jun 12, 2024 at 09:47:26AM +0200, Ricardo Ribalda wrote:
> > On Wed, 12 Jun 2024 at 09:44, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 12:28:56PM +0900, Tomasz Figa wrote:
> > > > On Mon, Jun 10, 2024 at 8:43=E2=80=AFPM Laurent Pinchart wrote:
> > > > > On Wed, May 29, 2024 at 05:03:08PM +0900, Tomasz Figa wrote:
> > > > > > On Sat, Mar 23, 2024 at 10:48:05AM +0000, Ricardo Ribalda wrote=
:
> > > > > > > With UVC 1.5 we get as little as one clock sample per frame. =
Which means
> > > > > > > that it takes 32 frames to move from the software timestamp t=
o the
> > > > > > > hardware timestamp method.
> > > > > > >
> > > > > > > This results in abrupt changes in the timestamping after 32 f=
rames (~1
> > > > > > > second), resulting in noticeable artifacts when used for enco=
ding.
> > > > > > >
> > > > > > > With this patch we modify the update algorithm to work with w=
hatever
> > > > > > > amount of values are available.
> > > > > > >
> > > > > > > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > > > > > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.=
com>
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > ---
> > > > > > >  drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++--
> > > > > > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/medi=
a/usb/uvc/uvc_video.c
> > > > > > > index d6ca383f643e3..af25b9f1b53fe 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > > > > @@ -768,10 +768,10 @@ void uvc_video_clock_update(struct uvc_=
streaming *stream,
> > > > > > >
> > > > > > >     spin_lock_irqsave(&clock->lock, flags);
> > > > > > >
> > > > > > > -   if (clock->count < clock->size)
> > > > > > > +   if (clock->count < 2)
> > > > > > >             goto done;
> > > > > > >
> > > > > > > -   first =3D &clock->samples[clock->head];
> > > > > > > +   first =3D &clock->samples[(clock->head - clock->count + c=
lock->size) % clock->size];
> > > > > > >     last =3D &clock->samples[(clock->head - 1 + clock->size) =
% clock->size];
> > > > > > >
> > > > > > >     /* First step, PTS to SOF conversion. */
> > > > > > > @@ -786,6 +786,18 @@ void uvc_video_clock_update(struct uvc_s=
treaming *stream,
> > > > > > >     if (y2 < y1)
> > > > > > >             y2 +=3D 2048 << 16;
> > > > > > >
> > > > > > > +   /*
> > > > > > > +    * Have at least 1/4 of a second of timestamps before we
> > > > > > > +    * try to do any calculation. Otherwise we do not have en=
ough
> > > > > > > +    * precision. This value was determined by running Androi=
d CTS
> > > > > > > +    * on different devices.
> > > > > > > +    *
> > > > > > > +    * dev_sof runs at 1KHz, and we have a fixed point precis=
ion of
> > > > > > > +    * 16 bits.
> > > > > > > +    */
> > > > > > > +   if ((y2 - y1) < ((1000 / 4) << 16))
> > > > > > > +           goto done;
> > > > > >
> > > > > > Not a comment for this patch directly, but...
> > > > > >
> > > > > > This kind of makes me wonder if we don't want to have some docu=
mentation
> > > > > > that specifies what the userspace can expect from the timestamp=
s, so
> > > > > > that this isn't changed randomly in the future breaking what wa=
s fixed
> > > > > > by this patch.
> > > > >
> > > > > I think timestamp handling should really be moved to userspace. I=
t will
> > > > > be easier to handle with floating-point arithmetic there. That wo=
uld
> > > > > have been difficult to manage for applications a while ago, but n=
ow that
> > > > > we have libcamera, we could implement it there. This isn't high o=
n my
> > > > > todo list though.
> > > >
> > > > While indeed that would probably be a better way to handle the comp=
lex
> > > > logic if we designed the driver today, we already have userspace th=
at
> > > > expects the timestamps to be handled correctly in the kernel. I
> > > > suspect moving it to the userspace would require some core V4L2
> > > > changes to define a new timestamp handling mode, where multiple raw
> > > > hardware timestamps are exposed to the userspace, instead of the hi=
gh
> > > > level system monotonic one.
> > >
> > > The uvcvideo driver already supports exposing the packet headers to
> > > userspace through a metadata capture device, so I think we have all t=
he
> > > components we need. The only missing thing would be the implementatio=
n
> > > in libcamera :-)
> >
> > We would still have to duplicate the quirk information in libcamera
> > and the kernel.
>
> Sure, and there will be some level of code duplication. My point is that
> I believe it can be done in userspace, and while small changes to the
> clock handling on the kernel side are fine, if we wanted to change the
> code significantly I think it would be better moved to userspace.

Okay, that sounds much more reasonable. I guess I misunderstood your
original reply, sorry.

Best regards,
Tomasz

> I
> don't have plans to work on this, and I'm not requesting anyone to do so
> either at this point.
>
> --
> Regards,
>
> Laurent Pinchart

