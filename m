Return-Path: <linux-kernel+bounces-227948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 388C591586F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9F4280E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C01A08A6;
	Mon, 24 Jun 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C7WKTJW9"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C1AFBEF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719263139; cv=none; b=p8PpjDmQlU/mjfY+7PCqCncujDRrSDB5ZSG7dtLzv+1COuBkWojbmfuBSR83YYhHSB6hixsJqkzyXfl1xm1ctUMm3FkBi4H9knzwtDgd9ZL6goFRTncLwJHLAgnx8NLpimgdah8Y1JigR18daRE71xNoqf5TJ7BX2FtcJQapeb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719263139; c=relaxed/simple;
	bh=rc+uf24RV4wU1ZmPVkashso27WnRydS2+EKRJ3fw3uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dehXwSCuWoaO0Jse10DHHOjGC9ibgBBadNKyIP18zC733DHf2mSZey2PO7/RLajSWr1MSO7mScqGcJFY6be6nzTAnrGjKpE0gqicEURGZItUpBtWtjRno1Ek5ZIlKgvon6z/MmQNyqbRgQZ32fRYxhbyI8ZBkZbDllX715A7EiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C7WKTJW9; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9c36db8eeso2515695b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719263137; x=1719867937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F26ETBZiZjhwFkvNSbxGcmTBqIZI6iLTpohts+kXXh4=;
        b=C7WKTJW9cwI2vuH4sFmGpGcgqjNbXB8oErJ9r9JAOGXmgSrBEmtvsX16gxG8dFXf7i
         eeKhCjbtBk7PUcgLuotiFtRzJTqEfxHj4Ym+2z5j42fGz7Y0ZydKIaWwqXMwbHWfj5Z1
         d48rlbUzIyu9tvTzfxrYAiMj80oaeNsYN1tzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719263137; x=1719867937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F26ETBZiZjhwFkvNSbxGcmTBqIZI6iLTpohts+kXXh4=;
        b=iyB51zJD5L2UuBUYyb5REvZpvJMKgY2Lsuny3gi2EeAAUyfE5hoJNFuw0TbWuzmwey
         mB4ZTytWf4HCb/besox/R5MitvKtuEdP+e/vKa4PwN9bukGg1wOsKRdWRwi9Wf3W10CS
         bL6Y6XFoh/KdtkZCzvEM4kubmH3NK5a6JDIM3vLPRjEHRAD82J+WortZw1r6dTo+gIR8
         c9lKVoLv5DP7SUQeaoSbxoi6Ja+wuLOnRfpNchhev/HDWlsQ5nyRNdfS8JQCjREbtAgc
         SaQUhcSdr8A7dNk+//+rxMtt7yiI5krClTLT4LZ99jtlvc7GOO3+Hsj/e7r4Yitefx06
         WWZA==
X-Forwarded-Encrypted: i=1; AJvYcCVwhOTbA4yKIZZPFfypQydEfkdgXeU9I8JitNknT6O0L15oUE1ETsX/kTPsksy9AG97xQCdLVEQkms2b3lQVagLg1zXxlFJ4WgUW2Xb
X-Gm-Message-State: AOJu0Yy36S5GPzP/jIZCLMz1wfjeQFEceLIAlqwJ+je7/EE8VULiG3qn
	2Eke0lyf7Gh8EB5rxgfayhBUnFtc+7dcRtlPIyWBSXFUJtduGCkoRF+B0q+uPtB6nahhfwtJ48s
	=
X-Google-Smtp-Source: AGHT+IG6KjfKbgAYuA15ESR9dDKLs3G/F25VY27spn4z5331K3FCbsnvte0xklVf0D+6c2yGrXJHbw==
X-Received: by 2002:a0c:f051:0:b0:6b2:c94d:a02f with SMTP id 6a1803df08f44-6b54099d279mr66175186d6.13.1719262727656;
        Mon, 24 Jun 2024 13:58:47 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm28965306d6.99.2024.06.24.13.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 13:58:46 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44056f72257so27771cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpsXrqqrHUfMlZ0MR4Er/dTFZxuY78JYIqdEZ2nJXRSDmq3+4Fc7Dvbm50gbuWY21uccmg4oh/hYZZZQLwZUFny6jmEvRGYLeDSeah
X-Received: by 2002:a05:622a:283:b0:442:1bc4:8fb2 with SMTP id
 d75a77b69052e-444f2566f1fmr919771cf.20.1719262726353; Mon, 24 Jun 2024
 13:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.7.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid> <ZnlilDj5UrvrVasv@hovoldconsulting.com>
In-Reply-To: <ZnlilDj5UrvrVasv@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 13:58:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=C+Myrb4cpGyV-J=RHn39C2aF1WT_Xt5M2vczbZ-AbA@mail.gmail.com>
Message-ID: <CAD=FV=U=C+Myrb4cpGyV-J=RHn39C2aF1WT_Xt5M2vczbZ-AbA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] serial: qcom-geni: Fix suspend while active UART xfer
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 5:12=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jun 10, 2024 at 03:24:25PM -0700, Douglas Anderson wrote:
> > On devices using Qualcomm's GENI UART it is possible to get the UART
> > stuck such that it no longer outputs data. Specifically, logging in
> > via an agetty on the debug serial port (which was _not_ used for
> > kernel console) and running:
> >   cat /var/log/messages
> > ...and then (via an SSH session) forcing a few suspend/resume cycles
> > causes the UART to stop transmitting.
>
> An easier way to trigger this old bug is to just run a command like
> dmesg and hit ctrl-s in a serial console to stop tx. Interrupting the
> command or hitting ctrl-q to restart tx then triggers the soft lockup.
>
> > The root of the problems was with qcom_geni_serial_stop_tx_fifo()
> > which is called as part of the suspend process. Specific problems with
> > that function:
> > - When an in-progress "tx" command is cancelled it doesn't appear to
> >   fully drain the FIFO. That meant qcom_geni_serial_tx_empty()
> >   continued to report that the FIFO wasn't empty. The
> >   qcom_geni_serial_start_tx_fifo() function didn't re-enable
> >   interrupts in this case so the driver would never start transferring
> >   again.
> > - When the driver cancelled the current "tx" command but it forgot to
> >   zero out "tx_remaining". This confused logic elsewhere in the
> >   driver.
> > - From experimentation, it appears that cancelling the "tx" command
> >   could drop some of the queued up bytes.
> >
> > While qcom_geni_serial_stop_tx_fifo() could be fixed to drain the FIFO
> > and shut things down properly, stop_tx() isn't supposed to be a slow
> > function. It is run with local interrupts off and is documented to
> > stop transmitting "as soon as possible". Change the function to just
> > stop new bytes from being queued. In order to make this work, change
> > qcom_geni_serial_start_tx_fifo() to remove some conditions. It's
> > always safe to enable the watermark interrupt and the IRQ handler will
> > disable it if it's not needed.
> >
> > For system suspend the queue still needs to be drained. Failure to do
> > so means that the hardware won't provide new interrupts until a
> > "cancel" command is sent. Add draining logic (fixing the issues noted
> > above) at suspend time.
>
> So I spent the better part of the weekend looking at this driver and
> this is one of the bits I worry about with your approach as relying on
> draining anything won't work with hardware flow control.
>
> Cancelling commands can result stalled TX in a number of ways and
> there's still at least one that you don't handle. If you end up with
> data in in the FIFO, the watermark interrupt may never fire when you try
> to restart tx.

Ah, that's a good call. Right now it doesn't really happen since
people tend to hook up the debug UART without flow control lines (as
far as I've seen), but it's good to make sure it works.


> I'm leaning towards fixing the immediate hard lockup regression
> separately and then we can address the older bugs and rework driver
> without having to rush things.

Yeah, that's fair. I've responded to your patch with a
counter-proposal to fix the hard lockup regression, but I agree that
should take priority.


> I've prepared a minimal three patch series which fixes most of the
> discussed issues (hard and soft lockup and garbage characters) and that
> should be backportable as well.
>
> Currently, the diffstat is just:
>
>          drivers/tty/serial/qcom_geni_serial.c | 36 +++++++++++++++++++++=
++++-----------
>          1 file changed, 25 insertions(+), 11 deletions(-)

I'll respond more in dept to your patches, but I suspect that your
patch series won't fix the issues that N=C3=ADcolas reported [1]. I also
tested and your patch series doesn't fix the kdb issue talked about in
my patch #8. Part of my reworking of stuff also changed the way that
the console and the polling commands worked since they were pretty
broken. Your series doesn't touch them.

We'll probably need something in-between taking advantage of some of
the stuff you figured out with "cancel" but also doing a bigger rework
than you did.

[1] https://lore.kernel.org/r/46f57349-1217-4594-85b2-84fa3a365c0c@notapian=
o

