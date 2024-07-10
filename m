Return-Path: <linux-kernel+bounces-248048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9592D7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA19B2194B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F50919306B;
	Wed, 10 Jul 2024 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBDtHJfb"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820E848E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720633657; cv=none; b=jxS7K7fp0JCqydVr39Kdh6Y51CBshh+98qUX+04FxUYrbwEewwL3lOkxAVdNYPjNOpssUlnSO8Is1R320PpshIHuBGsZCBBZKBrp3Als8C1qqTfPC9eTxxLRhVSULTI6BhnXslDMyWrLr+kTBhwXgzxB7IAiePiQ9gGMv4AymSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720633657; c=relaxed/simple;
	bh=i389QRnHQ6ZZ2nt5lo9H1WmPvVCNnVqklYtqUudIKXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxaXCitB0VNPqcngPhyT1Wt6mFqY49qWp6gD1TaJVNiwoMDMwNAAVtR/A+BMHPwQT/jLXrKawQc6Cf+SFmKIfxSnOoeutfYzXUScpJ3ym0kVrRqT5m1XsPVcAjkgpvaWtMiSQY3li8i5ZqIvNWlyrmN+/BqtgeycL1HEnyZf6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WBDtHJfb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b2c6291038so710496d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720633653; x=1721238453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0i6GGvi4N+b60jAHl9CBW1IjNhXewguKcPzleEMnR20=;
        b=WBDtHJfbbiLScuyTJ4xQAprnzGaSzOowCjjE5WhuD4s98p9hrl3975LRDINRMsh0bP
         bYVeHBIhRrHz+wFO1DMxatEcW79C+78/O1UUut+lijEpDXhD8vqpM54spDGMts7l1V87
         KdssxxPt+0fBMuXqfkze47B14oKlRpWdoygRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720633653; x=1721238453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i6GGvi4N+b60jAHl9CBW1IjNhXewguKcPzleEMnR20=;
        b=QWgdEUc/VKskJ0ucx8PbTypfa0zMqY4t1plNeEmiykLcjESIRQsqr4vtAr+tGGCIlj
         XyYXvresqCfjNaJAw7IHmZPuehH4gDRLmRk1I6u1UOrRN8mOa21JimpBjz0EXjJhe+In
         TgPXNj3ssWHvY8jdeibRfjrMJQZh7kbQZbcuueEi96ulGoCd7FLpzWm9A78T5w3W7Cfr
         qIKo+vgL0P7AJVbXgj0L5AUc1YWCM4CtTv34Sj8MdTsKlKIQ639mvo1/dL45zntZ4WOd
         2MiT5kxdtFioDbx8XYxSMslo0mbJbXfvZiaftDFBb4oynEKvRIdcZbr4ejNMWFbkdQwk
         lRDw==
X-Forwarded-Encrypted: i=1; AJvYcCWnZ4IVV9HhVGOy6rl2PmH7iK1xv1wPxBJJnzlRJ7PKc3g39sNqT4wqYmEX9bcwvu3gvR/rRMbsPJosyHflhtUoLyrZotm44HF6maoV
X-Gm-Message-State: AOJu0YxqFTy6QO3Y92QSBug0apxGiWdL9lpz7r6s/ckcI6zu/AXfwXvG
	YuMH7F55E2h4Q6NLOzwm7z2jSrAgya6dJHhUs2JxfyLopNgSaf92sO5VnE7UcIumU2l4bRgwDMS
	SFw==
X-Google-Smtp-Source: AGHT+IEdqCdlTKdP8VO/GGZdhmU33Zw8b1HxQGyvFCosMRvfzENcxCI8gcVIrxQRSsIG/WIX4BNpyg==
X-Received: by 2002:a05:6214:252a:b0:6af:7b2e:1868 with SMTP id 6a1803df08f44-6b74af7491amr8060416d6.18.1720633653496;
        Wed, 10 Jul 2024 10:47:33 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba73de5sm18864846d6.98.2024.07.10.10.47.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 10:47:32 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447f8aa87bfso35261cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:47:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNDZ+3PL/CGhH99qE35AsB0IRWpBtgernFCCucAdFYuU3d4OUQGRyScwDlZKsB+LqUDC3mB/2Prn5CUuYNOme79YTboEIQfzYN1790
X-Received: by 2002:ac8:5843:0:b0:444:dc22:fb1d with SMTP id
 d75a77b69052e-44d0aa44e97mr150461cf.12.1720633652080; Wed, 10 Jul 2024
 10:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709162841.1.I93bf39f29d1887c46c74fbf8d4b937f6497cdfaa@changeid>
 <2024071001-justice-catfight-37f0@gregkh> <CAD=FV=XX0+jE28CRQmWu9Q09KRf5ZbqLYizmem8kk6ajX05qfw@mail.gmail.com>
 <2024071035-prize-puppy-a288@gregkh>
In-Reply-To: <2024071035-prize-puppy-a288@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 10:47:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XQ5Qd1VEcM30ztLY2e4mjTg4Ft6pJt=o-By38eNrtW=Q@mail.gmail.com>
Message-ID: <CAD=FV=XQ5Qd1VEcM30ztLY2e4mjTg4Ft6pJt=o-By38eNrtW=Q@mail.gmail.com>
Subject: Re: [PATCH] serial: qcom-geni: Show '@' characters if we have a FIFO underrun
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 10:28=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jul 10, 2024 at 09:01:10AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jul 9, 2024 at 10:35=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Jul 09, 2024 at 04:28:45PM -0700, Douglas Anderson wrote:
> > > > As of commit 2ac33975abda ("serial: qcom-geni: do not kill the mach=
ine
> > > > on fifo underrun") a FIFO underrun will no longer hard lockup the
> > > > machine. Instead, a FIFO underrun will cause the UART to output a
> > > > bunch of '\0' characters. The '\0' characters don't seem to show up=
 on
> > > > most terminal programs and this hides the fact that we had an
> > > > underrun. An underrun is aq sign of problems in the driver and
> > > > should be obvious / debugged.
> > > >
> > > > Change the driver to put '@' characters in the case of an underrun
> > > > which should make it much more obvious.
> > > >
> > > > Adding this extra initialization doesn't add any real overhead. In
> > > > fact, this patch reduces code size because the code was calling
> > > > memset() to init 4 bytes of data. Disassembling the new code shows
> > > > that early in the function w22 is setup to hold the '@@@@' constant=
:
> > > >   mov     w22, #0x40404040
> > > >
> > > > Each time through the loop w22 is simply stored:
> > > >   str     w22, [sp, #4]
> > > >
> > > > Cc: Johan Hovold <johan@kernel.org>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/se=
rial/qcom_geni_serial.c
> > > > index 69a632fefc41..332eaa2faa2b 100644
> > > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > > @@ -872,10 +872,10 @@ static void qcom_geni_serial_send_chunk_fifo(=
struct uart_port *uport,
> > > >  {
> > > >       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > > >       unsigned int tx_bytes, remaining =3D chunk;
> > > > -     u8 buf[BYTES_PER_FIFO_WORD];
> > > >
> > > >       while (remaining) {
> > > > -             memset(buf, 0, sizeof(buf));
> > > > +             u8 buf[BYTES_PER_FIFO_WORD] =3D { '@', '@', '@', '@' =
};
> > >
> > > Why is '@' a valid character for an underrun?  Why would any characte=
rs
> > > be ok?  Where is this now documented?
> >
> > '@' is arbitrary. If you have a different character suggestion then
> > I'm happy to change it. I'm mostly looking for something other than
> > '\0' to be printed out in the case of underruns, which is what happens
> > now. Printing out '\0' is much harder to notice but could still end up
> > causing problems with file transfers / automated programs trying to
> > work with serial data.
>
> Any character is "wrong", so picking this one feels odd.
>
> Do we know when an underrun happens?  If so, handle that error.  If not,
> well, something else is really wrong with this uart then

It no longer happens. Johan's recent patches fixed it. Quick history:

1. Pre-kfifo, we used to output stale characters (ones that had been
dropped) in the FIFO underrun case. Nobody noticed for years.

2. After kfifo we got a hard lockup.

3. Johan's early patches to fix the hard lockup caused us to output
'\0' characters upon FIFO underrun. It was not obvious that the '\0'
characters were being output. To make it easier to debug / see, both
he and I locally made it output some other character which was more
obvious.

4. Johan fixed the FIFO underrun.

5. Johan added a patch such that if we ever get another FIFO underrun
in the future we'll output '\0' characters in the FIFO instead of
getting a hard lockup.

If we're really confident that we can't get a FIFO underun we could
just revert commit 2ac33975abda ("serial: qcom-geni: do not kill the
machine on fifo underrun") and we'll get a hard lockup if we ever
underrun. IMO, though, it's better to output _something_ in this case
to make it more obvious. If you hate this patch, though, fine. Let's
drop it and we'll hope that either we never introduce a bug causing a
FIFO underrun in the future or that someone notices the '\0'
characters.


> (why are people
> making new uarts still...)

Yeah, tell me about it. :( ...and doing a bad job of it, too...


> > NOTE: this is not an underrun in the sense that we didn't get an
> > interrupt fast enough or that we couldn't keep up. This is an underrun
> > that could only happen as a result of a bug in the driver. The driver
> > should not ever get into this situation.
>
> But obviously it has otherwise you wouldn't have seen it, right?

Right, because there was a bug.


> > I have no idea where one would document something like this. Do you
> > have any suggestions? I'm happy to add a comment in the code saying
> > that the '@' should never show up but if it does then that's a driver
> > bug.
> >
> >
> > > And shouldn't you use a memset to get the BYTES_PER_FIFO_WORD amount =
of
> > > '@' here?
> >
> > That feels like overkill and results in much less efficient code, but
> > I can change it to that if you want.
>
> Are you sure it will?  Constant memcopies should be really fast by the
> compiler these days.

Fair. If we care to keep this patch we could just change the memset to:

  memset(buf, '@', sizeof(buf));


-Doug

