Return-Path: <linux-kernel+bounces-251338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587B89303B8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1941C225E9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D51BC3F;
	Sat, 13 Jul 2024 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="ahK9aHoY"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4917BA7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 04:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720846088; cv=none; b=PDIdq/GSmvw85UG1eldIjEJyO2/cAA7CnRO4Ma8MPWCAziwCLTIX44cmDvYE1S2ryvqYsTPWQv4SVG8lNBCE89eP6UHOMyv680Wdbz/NLO6PiHaJoP+wEI0olvuSVE90DDjjtyzB1djzvjGvA/R2jMBNExfujy9xeM4ubshOeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720846088; c=relaxed/simple;
	bh=UijJmrOo4ZD2uvZrUYYwQPAaTVEbfzSehJxIGarFJpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CyZ+ujOiBGwSmIQ/1pCQpN/NNhU32KP64Oua3kR9uSdUJVD3WFggIN5+BrM2FoxpO5vQAzU+Obg7r424RjX+gITs+jHbAUJwmkvY4k89wcJKN8ztPiOC9uwqwNmNDjku32kZJ+fFjiST44p4+9IreNCHMu6+gkXnpUOzWP0W0bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=ahK9aHoY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so36689761fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 21:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1720846085; x=1721450885; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6hu/qr0AvU5O+DQMWgrZwZe/xsx8zdzsw60vWw30Fo=;
        b=ahK9aHoYSKErrbvs8tZtOwaixEzdWegcPVo3ZV6Aytlws0J53PVD/0n36HvIoKVoMD
         xYw/vw14I6OMYjNCxeipnSmlO65YIug9b+XRWy3u7U4aT6/NJSlyNP14hn0Sbt6KdeEQ
         qKmcCd6iRM8EaCkoNR+UJVOF8bhlmYUzcoBEgyFsQ+t3cobzSOetDF+5qkMpvdj5KeAA
         dSSf9WjQ6cYsYHnDcTnZnZnFGLxUCmW6+JGu6DADDsoQe4MNiQLNn4lS4g4oZSPP5so5
         HCL8KwEy9DSFFAEopmlg6ED1BGRVLrCgoBMg1FMPirBy1n+hA+It6P30efZo5yh5zRmE
         dkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720846085; x=1721450885;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6hu/qr0AvU5O+DQMWgrZwZe/xsx8zdzsw60vWw30Fo=;
        b=br1u/eDcxJ37pHYpcBsIhtgPiIdgBCwwTMlhRkmsqC1SVvXRhUPrHrZUk49Zd2CdU4
         I5wHyhaLJIwaDerR8p5SVKB2+8SVTJdOKkqeRbiD0QkaD4tFFOg3G5FdhL0O7vnlPedr
         Nbemx2hykN/qSWMXlFxRUTnNLk3EUD7GFaD4FHyB9t/Optj9/V1KPmjmyH5LrLBMgRlF
         IoVEaHnawlaCFoqrGXJSt9wJPZFQkGh1LFeFFS4/eEsEYA5X5qH/wo7RphCeHxnu3fcY
         mj3pdvvOv/uEIZVBxMFGqaoN8KUPePxeNJTcj7lSh5ZAeMdCqL+2lprf+epqzq73PsbX
         beCw==
X-Forwarded-Encrypted: i=1; AJvYcCVyTTw9H5EItuC1zJSXhtgt69QEaANE8iCsFjZanw52Gd6gpn+ZQJz6luunuMsrq5y4gPw/2ZU/SQT9FBWr6hP0CZ07jayXvQCUBYip
X-Gm-Message-State: AOJu0YwZemmRxROMxHvSxkLrQMdbgqnXq9YHCVzKMlmQs423oPmozu8q
	5ruZA0Bj88KrXQfBNYKRBGtJ9HFyC3+PDbMw0HZOCD4ahaT2s9bhkJXRCUpBsnkAANUYQjLL+qe
	AAMCcMGhWzrGRCiQt4faSipkJ6zhHcNj/pPyP
X-Google-Smtp-Source: AGHT+IExodKhWYEfarw1gh6skTTSLZwAi9xw81nKZqkKgixkPu0uBZdaEFwstoKovnEYxh0LY4nADJE0WOp//9PpA8M=
X-Received: by 2002:a2e:9b07:0:b0:2ec:422:126 with SMTP id 38308e7fff4ca-2eeb30fd474mr83286111fa.30.1720846085055;
 Fri, 12 Jul 2024 21:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpFfocvyF3KHaSzF@LQ3V64L9R2> <ZpGrstyKD-PtWyoP@krava>
 <CAP045ApgYjQLVgvPeB0jK4LjfBB+XMo89gdVkZH8XJAdD=a6sg@mail.gmail.com>
 <CAP045ApsNDc-wJSSY0-BC+HMvWErUYk=GAt6P+J_8Q6dcdXj4Q@mail.gmail.com>
 <CAP045AqqfU3g2+-groEHzzdJvO3nyHPM5_faUao5UdbSOtK48A@mail.gmail.com> <ZpHOQoyEE7Rl1ky8@LQ3V64L9R2>
In-Reply-To: <ZpHOQoyEE7Rl1ky8@LQ3V64L9R2>
From: Kyle Huey <me@kylehuey.com>
Date: Fri, 12 Jul 2024 21:47:51 -0700
Message-ID: <CAP045Apejcgz4A7jkevts25hKzzxYCzGeKgkbSZUwpC24YY4YA@mail.gmail.com>
Subject: Re: [bpf?] [net-next ?] [RESEND] possible bpf overflow/output bug
 introduced in 6.10rc1 ?
To: Joe Damato <jdamato@fastly.com>, Kyle Huey <me@kylehuey.com>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	acme@kernel.org, andrii.nakryiko@gmail.com, elver@google.com, 
	khuey@kylehuey.com, mingo@kernel.org, namhyung@kernel.org, 
	peterz@infradead.org, robert@ocallahan.org, yonghong.song@linux.dev, 
	mkarsten@uwaterloo.ca, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 5:45=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Fri, Jul 12, 2024 at 04:30:31PM -0700, Kyle Huey wrote:
> > Joe, can you test this?
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 8f908f077935..f0d7119585dc 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9666,6 +9666,8 @@ static inline void
> > perf_event_free_bpf_handler(struct perf_event *event)
> >   * Generic event overflow handling, sampling.
> >   */
> >
> > +static bool perf_event_is_tracing(struct perf_event *event);
> > +
> >  static int __perf_event_overflow(struct perf_event *event,
> >                   int throttle, struct perf_sample_data *data,
> >                   struct pt_regs *regs)
> > @@ -9682,7 +9684,9 @@ static int __perf_event_overflow(struct perf_even=
t *event,
> >
> >      ret =3D __perf_event_account_interrupt(event, throttle);
> >
> > -    if (event->prog && !bpf_overflow_handler(event, data, regs))
> > +    if (event->prog &&
> > +        !perf_event_is_tracing(event) &&
> > +        !bpf_overflow_handler(event, data, regs))
> >          return ret;
> >
> >      /*
> > @@ -10612,6 +10616,11 @@ void perf_event_free_bpf_prog(struct perf_even=
t *event)
> >
> >  #else
> >
> > +static inline bool perf_event_is_tracing(struct perf_event *event)
> > +{
> > +    return false;
> > +}
> > +
> >  static inline void perf_tp_register(void)
> >  {
> >  }
> >
>
> Thank you!
>
> I've applied the above patch on top of commit 338a93cf4a18 ("net:
> mctp-i2c: invalidate flows immediately on TX errors"), which seems
> to be latest on net-next/main.
>
> I built and booted that kernel on my mlx5 test machine and re-ran
> the same bpftrace invocation:
>
>   bpftrace -e 'tracepoint:napi:napi_poll { @[args->work] =3D count(); }'
>
> I then scp-ed a 100MiB zero filled file to the target 48 times back
> to back (e.g. scp zeroes target:~/ && scp zeroes target:~/ && ... )
> and the bpftrace output seems reasonable; there are no negative
> numbers and the values output *look* reasonable to me.
>
> The patch seems reasonable, as well, with the major caveat that I've
> only hacked on drivers and networking stuff and know absolutely
> nothing about bpf internals.
>
> All that said:
>
> Tested-by: Joe Damato <jdamato@fastly.com>

Thanks, I've sent a patch formally.

Hopefully this can slip into 6.10 before it ships.

- Kyle

