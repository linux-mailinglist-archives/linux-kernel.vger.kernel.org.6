Return-Path: <linux-kernel+bounces-210888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D799049A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE211C20361
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82618208A1;
	Wed, 12 Jun 2024 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rzw1Gj/0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A4257D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718162971; cv=none; b=V06jotT4rLA7Jl2UGqvUvjdZyfgccNOENfhGKv0KlPyzy7UL64JUCOMFOppEMMfQrRyfz+mb0o5pt+fjqB9tcv/DLP2eB2SJuKqwXzKCV59QimKeYhgATF4BUib+fTjKC3S2D+L8HzmxQpvef4vGCvFg3fWrGPNKpaakeGqqm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718162971; c=relaxed/simple;
	bh=FY9fFF1F7cRvCwX73JSRpuljV2KG6+THYC6d4MhA8ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhfAQvzIBEz9srsIbBBnEdLB90WU0HMUFDzU5QL2/zcvYsWXTKA7WuzBLsKMv6UWqFRMABCMHhArSrXYC6+VvPUJyhJJkjiRZMaIqv3cBuL2E4S/HZiuuIvGcVryKUb+1Wn0lfRqLGUkFaLOYES5ICz93DW3ZhshW8ROX18Tzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rzw1Gj/0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c685bfd86so5295276a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718162968; x=1718767768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qct4xvMTygFxOfNWaCR3/q2u96535kRB68KKPO3xZ1c=;
        b=Rzw1Gj/0ZofNz5RIVAa2LB5as2e/ZPYVTTmWcYjY4w2aHrOFc7E53VJS5qntvrR4ap
         a1ZaQ73nsJfYT8CNCJq3uu4HOa+/IDAW7SMOVTCuLbdnnjKEykHk1kuPnAsIhE7z0+J6
         bIy+wlzsPEpdcRE3P6M53tP4o2fayoWs6EVRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718162968; x=1718767768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qct4xvMTygFxOfNWaCR3/q2u96535kRB68KKPO3xZ1c=;
        b=o5/Ojb+ujP3cakbhns4cr4uzb2CPOmxpNYnPZ4hCiRptV5eCy7VC/HSp3aQh0WuF+6
         lePp94uKr5qLQpo4NTSfXg4JbFDP16iNbqMw/wmeCG9Fb7v/f4//qHR+6X7DYluyG9PV
         bDLM8uOFIggUVaPvN0GviFnIXDxOwzfmdAbQeRWRQwlXcpkDF/QDVn/IH4JSdVXIbwLe
         3dL0VFjWskcxHasoAa61gNFgQefPTfkktsWGFVJ0npODviua4OqtK9yrmpurPIBmNJIt
         uqb1N7RtVlXI8qTsnxVe0QoCSSfWaqT/fxhmwKXOPPHKMms8m++q8ozpGjpbz/b/fJK1
         TuxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8jq8J7l53nzHtN+Uw01h5cE1M2w48AyHyFPgDpNo/woAnW3LIpx0JZJlg2V370wID26S7VxWpmdtU1PoIqrlcr8YkMRn3OIoauVeX
X-Gm-Message-State: AOJu0YxLQh273J4v03HBQaaotZqSU8qAca2/8Kuk4QRTb9OTtMxf48bF
	xTb8maWJCRf4K6ngjUunwPDkwaneR8lkPb5UyWJ4lToUr0kFWryHs6ZmfcvjDaNUGw+112GdCeF
	qEQ==
X-Google-Smtp-Source: AGHT+IGSnfaFWFs+sp0RJy1wgk1q3iIuIow1kEhAGq26hJ54gy/LiRmOJk05ycRArAssgEvIrRDfkw==
X-Received: by 2002:a50:d7d6:0:b0:578:676e:324 with SMTP id 4fb4d7f45d1cf-57ca976cccfmr306099a12.17.1718162967841;
        Tue, 11 Jun 2024 20:29:27 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7cf18193sm5413814a12.50.2024.06.11.20.29.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 20:29:26 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6ef64b092cso474110266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:29:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZieLhKSrdpSyl7Ueg8L9SK0rrH546tHs4GXW1NogemBx45I4cdO76Ud2k4qQzx/M52gyffFR7vLUWLEfLMxq8E6bdEjKn1Mpo+zMC
X-Received: by 2002:a17:906:f206:b0:a6e:fe97:b33a with SMTP id
 a640c23a62f3a-a6f47f938acmr28194866b.29.1718162965328; Tue, 11 Jun 2024
 20:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <20240323-resend-hwtimestamp-v10-4-b08e590d97c7@chromium.org>
 <4kck7oedsnj6kfiv7ykwsjg35qodg5bdktu5t5w3xtg2xuscto@2yh6kfdqwimc> <20240610114306.GR18479@pendragon.ideasonboard.com>
In-Reply-To: <20240610114306.GR18479@pendragon.ideasonboard.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 12 Jun 2024 12:28:56 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DAXq6fTrp6jF42URrwzwE+tGz_jJCRM2bhieD76u+QpA@mail.gmail.com>
Message-ID: <CAAFQd5DAXq6fTrp6jF42URrwzwE+tGz_jJCRM2bhieD76u+QpA@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] media: uvcvideo: Allow hw clock updates with
 buffers not full
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 8:43=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, May 29, 2024 at 05:03:08PM +0900, Tomasz Figa wrote:
> > On Sat, Mar 23, 2024 at 10:48:05AM +0000, Ricardo Ribalda wrote:
> > > With UVC 1.5 we get as little as one clock sample per frame. Which me=
ans
> > > that it takes 32 frames to move from the software timestamp to the
> > > hardware timestamp method.
> > >
> > > This results in abrupt changes in the timestamping after 32 frames (~=
1
> > > second), resulting in noticeable artifacts when used for encoding.
> > >
> > > With this patch we modify the update algorithm to work with whatever
> > > amount of values are available.
> > >
> > > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_video.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uv=
c/uvc_video.c
> > > index d6ca383f643e3..af25b9f1b53fe 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -768,10 +768,10 @@ void uvc_video_clock_update(struct uvc_streamin=
g *stream,
> > >
> > >     spin_lock_irqsave(&clock->lock, flags);
> > >
> > > -   if (clock->count < clock->size)
> > > +   if (clock->count < 2)
> > >             goto done;
> > >
> > > -   first =3D &clock->samples[clock->head];
> > > +   first =3D &clock->samples[(clock->head - clock->count + clock->si=
ze) % clock->size];
> > >     last =3D &clock->samples[(clock->head - 1 + clock->size) % clock-=
>size];
> > >
> > >     /* First step, PTS to SOF conversion. */
> > > @@ -786,6 +786,18 @@ void uvc_video_clock_update(struct uvc_streaming=
 *stream,
> > >     if (y2 < y1)
> > >             y2 +=3D 2048 << 16;
> > >
> > > +   /*
> > > +    * Have at least 1/4 of a second of timestamps before we
> > > +    * try to do any calculation. Otherwise we do not have enough
> > > +    * precision. This value was determined by running Android CTS
> > > +    * on different devices.
> > > +    *
> > > +    * dev_sof runs at 1KHz, and we have a fixed point precision of
> > > +    * 16 bits.
> > > +    */
> > > +   if ((y2 - y1) < ((1000 / 4) << 16))
> > > +           goto done;
> >
> > Not a comment for this patch directly, but...
> >
> > This kind of makes me wonder if we don't want to have some documentatio=
n
> > that specifies what the userspace can expect from the timestamps, so
> > that this isn't changed randomly in the future breaking what was fixed
> > by this patch.
>
> I think timestamp handling should really be moved to userspace. It will
> be easier to handle with floating-point arithmetic there. That would
> have been difficult to manage for applications a while ago, but now that
> we have libcamera, we could implement it there. This isn't high on my
> todo list though.

While indeed that would probably be a better way to handle the complex
logic if we designed the driver today, we already have userspace that
expects the timestamps to be handled correctly in the kernel. I
suspect moving it to the userspace would require some core V4L2
changes to define a new timestamp handling mode, where multiple raw
hardware timestamps are exposed to the userspace, instead of the high
level system monotonic one.

Best regards,
Tomasz

