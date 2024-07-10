Return-Path: <linux-kernel+bounces-247855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214D92D5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E2B1F23691
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7161194A44;
	Wed, 10 Jul 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cl8q1WAw"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA517B05F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627290; cv=none; b=blQdZ0xy8or+co1PmAgqRxP6iFy6vZVC0ENrx/HPoNm5ncwaJieKN9Re7dwpIP5LsAdS/hNrQ6JLU0IN9d+jn0rSZ3iNCCZPJiIY6GbzaASMzSrPIqDSXrOo+wZKHEZYxUoGVW2MDvomeYbH4LApPENugylTYcTfqXD+7xbhHXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627290; c=relaxed/simple;
	bh=hGgQW0B81BUQgE9RlObqbstkTQND3yS3pzPBACJW85s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+3LiD3xHOvu5aQpEU2s12aEVZZMzESuIIq6m+bnHlczHNcx56+3SpukY22npB4MvXuFhbDatbMuoMrMltSBd2Ozc4rIChlroa3PHE1jsYn8KoeyT0mclqmyCOX50hMypNYJwlHH7uDLmsUBOZkKi0xw0Bqf+yVb/Fgug71KHbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cl8q1WAw; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso9766789a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720627286; x=1721232086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Es++BYrl7MuUEY8tHxL0VOh/sP8aN4itkcXjtpocc8U=;
        b=Cl8q1WAw27KF2NC49Wb1n/XIq0yigqGptoyy61EWbPpJWeX1GaouHSORlacA2qstrw
         2LNIJ6VOdrNyUMnguI9X5LC4jlC3ckfWZJHmCocmm5ScG3kWMVNJ097rmwXJpyfE+7MH
         0N8dFj8CnA8fg+TbCk1HCRo5LD5xiCHbRGifM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627286; x=1721232086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Es++BYrl7MuUEY8tHxL0VOh/sP8aN4itkcXjtpocc8U=;
        b=UIvv3cKhPwcZ+iaI8rwLuVhKEqZ/+PIyHxjH1yS+WbfOB0dKoTmGC+eNSFoM8iMPv2
         d6FdvtOYq2gkaetpv8b4nUUZ5FK1Qx+nEnfQn9YiDb+vJEWOnRZ9cyGVPoXLiQJ74DJp
         4BAnB74WdQH3wTdmxNfkA+CSDmU7DGBST+PaG5hDBbeBx14BYRwMqRzD5NIhiVvM42gS
         ji185YbZ9X4cw18S46W83UbDgbQn4bpB6GDDScmDHBBs+IBSwojBP3KN6Tk7pMbaeFRK
         71HBSH+RTwPlD2zh8E3HZ4hem49Mf2IRgOhmoI1rshYdu5EuIIpccujOoC8LxwCfFCYL
         m5wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqCq65gDfFcg/Vj8uh0jZ3t0RwpToBfZG8ucZUyOGcT4vDvCYd77bBmrCWXz2mL4yu3yBNeiiBqjpG8hWkNTdaYxt8kHSypuGI13LR
X-Gm-Message-State: AOJu0Yy0lPy7Yqtalqjn40oqXK2rouQDkPAOoZjmbkzwd+UNNuTqf4GM
	Qz+ETgNS88L+uhgzi9AHMzSUjtUh7ipJNzUklbahJbXo8XqlLtJGK7BU36TZHxJfEINlir/o5JI
	l/g==
X-Google-Smtp-Source: AGHT+IF59tNibMYNdvb3oujGryLPdTeEoJxuEUNxFY4lClIrmy+sl+PpjBnrUhM+j4QdZ/bv7lXSQg==
X-Received: by 2002:aa7:d88a:0:b0:57c:8027:534d with SMTP id 4fb4d7f45d1cf-594bc7ca26amr3309986a12.27.1720627285590;
        Wed, 10 Jul 2024 09:01:25 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2d482sm2355034a12.38.2024.07.10.09.01.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 09:01:24 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42725f8a789so59745e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:01:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVz4bJJVzd99fxhowM7XN2wYbp5eTZVyq4xSruSccVgISUYvVu76mhzExeK69NVHQj5dWCPgge9t9Eu4WBHzfzncmviaungiPy4hHv5
X-Received: by 2002:a7b:ce99:0:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-427942230e7mr1577215e9.1.1720627284244; Wed, 10 Jul 2024
 09:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709162841.1.I93bf39f29d1887c46c74fbf8d4b937f6497cdfaa@changeid>
 <2024071001-justice-catfight-37f0@gregkh>
In-Reply-To: <2024071001-justice-catfight-37f0@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 09:01:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XX0+jE28CRQmWu9Q09KRf5ZbqLYizmem8kk6ajX05qfw@mail.gmail.com>
Message-ID: <CAD=FV=XX0+jE28CRQmWu9Q09KRf5ZbqLYizmem8kk6ajX05qfw@mail.gmail.com>
Subject: Re: [PATCH] serial: qcom-geni: Show '@' characters if we have a FIFO underrun
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, 
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 9, 2024 at 10:35=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 09, 2024 at 04:28:45PM -0700, Douglas Anderson wrote:
> > As of commit 2ac33975abda ("serial: qcom-geni: do not kill the machine
> > on fifo underrun") a FIFO underrun will no longer hard lockup the
> > machine. Instead, a FIFO underrun will cause the UART to output a
> > bunch of '\0' characters. The '\0' characters don't seem to show up on
> > most terminal programs and this hides the fact that we had an
> > underrun. An underrun is aq sign of problems in the driver and
> > should be obvious / debugged.
> >
> > Change the driver to put '@' characters in the case of an underrun
> > which should make it much more obvious.
> >
> > Adding this extra initialization doesn't add any real overhead. In
> > fact, this patch reduces code size because the code was calling
> > memset() to init 4 bytes of data. Disassembling the new code shows
> > that early in the function w22 is setup to hold the '@@@@' constant:
> >   mov     w22, #0x40404040
> >
> > Each time through the loop w22 is simply stored:
> >   str     w22, [sp, #4]
> >
> > Cc: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial=
/qcom_geni_serial.c
> > index 69a632fefc41..332eaa2faa2b 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -872,10 +872,10 @@ static void qcom_geni_serial_send_chunk_fifo(stru=
ct uart_port *uport,
> >  {
> >       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> >       unsigned int tx_bytes, remaining =3D chunk;
> > -     u8 buf[BYTES_PER_FIFO_WORD];
> >
> >       while (remaining) {
> > -             memset(buf, 0, sizeof(buf));
> > +             u8 buf[BYTES_PER_FIFO_WORD] =3D { '@', '@', '@', '@' };
>
> Why is '@' a valid character for an underrun?  Why would any characters
> be ok?  Where is this now documented?

'@' is arbitrary. If you have a different character suggestion then
I'm happy to change it. I'm mostly looking for something other than
'\0' to be printed out in the case of underruns, which is what happens
now. Printing out '\0' is much harder to notice but could still end up
causing problems with file transfers / automated programs trying to
work with serial data.

NOTE: this is not an underrun in the sense that we didn't get an
interrupt fast enough or that we couldn't keep up. This is an underrun
that could only happen as a result of a bug in the driver. The driver
should not ever get into this situation.

I have no idea where one would document something like this. Do you
have any suggestions? I'm happy to add a comment in the code saying
that the '@' should never show up but if it does then that's a driver
bug.


> And shouldn't you use a memset to get the BYTES_PER_FIFO_WORD amount of
> '@' here?

That feels like overkill and results in much less efficient code, but
I can change it to that if you want. Let me know. In this case
BYTES_PER_FIFO_WORD is more of a constant to add to readability than
something that we'd expect to change. Technically, the hardware can
handle BYTES_PER_FIFO_WORD of 1/2/4, but if we changed that there
would be a bunch of places in the driver that would need to change. In
this case if someone wanted to try to change it to something other
than 4 at least we'd get a compile error.


-Doug

