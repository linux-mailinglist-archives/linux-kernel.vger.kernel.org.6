Return-Path: <linux-kernel+bounces-195990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BC48D55C9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E441F25923
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900C183070;
	Thu, 30 May 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxXmydaU"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2C17545
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717109467; cv=none; b=it1qSiUtOF2bh9ZIe0JMsBdstBn50ppPyVmqvLsQ4QVoqMwPlMk9ss2t0d3kOsVoapPJQh7LQDmwD+HQKQzClmsrnCWhGBHCbYqHU13sQh76Q932EoVX/7EBcPq6RJo37Gzj6cFVyu5SX25Q0voKF4jeU/Ti7ud+zJSAvKRJJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717109467; c=relaxed/simple;
	bh=33aiZOcyTr7wjCXj4MkSVQHEobDBn6/UxXRCxIgAnUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B84aAvVpJu+QLLtBZZNivG8LRjvd3LmIIGUvILsDIAjwPR14oDe1B8wQ8fj60NV0oNma5aCzkTuNXXGuKWg4//x0WUNEnjAPLAN/3O6fLT4W477t/PAqQuSxXeLhjt6x4jFTHg2bPieXDiq+1F97cRyBZW+/WEgSkz9oJMPL6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxXmydaU; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dfa682a4025so947281276.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717109462; x=1717714262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33aiZOcyTr7wjCXj4MkSVQHEobDBn6/UxXRCxIgAnUo=;
        b=jxXmydaUgpRYFtRRbvzuCOTGgyIua5SvfQ0imqM/BXOlP6/GeM9KZ65IZsODoYRoRI
         /LFv0+rFLzHP8DK9kq8Eba7u6Mcb5mg+wIay8WFimV1/Y2KGkAe5c7MSSURDn9IPOIFq
         SxO0iehbyNFTvw85wSPTkn1D2mdCBJvtp1qe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717109462; x=1717714262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33aiZOcyTr7wjCXj4MkSVQHEobDBn6/UxXRCxIgAnUo=;
        b=TNshKVO/Bx7qpoog3+c7FXJxDltwrl0jzqUa7AloR0yTua5v6h3Y7OKkFF2DhXc1Lg
         8K/tfirveHpPbrQ1h7SxfhbOHhqicAPyno524pOoj8uvi4O0M+3X+7rmU0p8+yMGFmcz
         HBGwGAKNUWrZtBeZ0gT3KNVOxOInM0NBYk2LIhKSbLAROPiaWlVWdEkswU1H2MSFFR00
         ZYNs1mwlTII2f0XxWOH5Up6aR9xWum9CjOpc81F+KD1tmEqeXZSfCGBwlg1rMT84L3Qk
         BVqEtKgeH3XvHiyDuuYG3kqmKb30R2auP+OT+eKM5FxkMF7pBUsVnfZKhRbWWLmn8t7u
         AkeA==
X-Forwarded-Encrypted: i=1; AJvYcCXnAy+G9XC4UvSdm9ID1UrmOTRFzFxUabHKMIJJ6Y8mzeXxBI8Y/tnRRf8yUjWNQpdSGcmSuNBHX++iZydr/MDiiGKao9uJMxlGZhNb
X-Gm-Message-State: AOJu0YwDpDc+T7JUeTE5OKjnYT2WR0ynHbLdh3RSE0y76PwurdWnAsvr
	jByy2d+Q80Csm7FscmJIkDNQye+lGs5dOE6G8xlmbL2FCN9WNvyAmkYnqIi7DIKerWdsUnaI4up
	DVA==
X-Google-Smtp-Source: AGHT+IFS1s+cOlG9CklbqMvG5edlyW8yStAdk71iBXYDuxZYjXps735kRBBJzsaWO+kxcT4OmjCMSw==
X-Received: by 2002:a25:c5c9:0:b0:dfa:47d0:63a4 with SMTP id 3f1490d57ef6-dfa73bd0a55mr281016276.9.1717109461631;
        Thu, 30 May 2024 15:51:01 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b417d77sm2232696d6.124.2024.05.30.15.50.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 15:51:00 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so121231cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:50:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjyfyI95ibZik5OsDkwQEWNtfDfZyFVnZ4C7voOVeO1WnDEKSzmTMENjF5EfLlue67Klmm0YKk3+OO99q8lDCRuW+PZEQhVkrZFS+D
X-Received: by 2002:a05:622a:1b03:b0:43f:db90:2557 with SMTP id
 d75a77b69052e-43ff4f8d821mr207311cf.21.1717109458702; Thu, 30 May 2024
 15:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523232216.3148367-1-dianders@chromium.org>
 <20240523162207.2.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid>
 <CAE-0n53F3Xg2vOdgy-Vpjw4Kirdgi6B+BnO51fd6qOtDu0iXCg@mail.gmail.com> <CAD=FV=VeKiiHeOwmt_6uf7OSoGvOJLrLLMULVERubU1ut-=WqQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VeKiiHeOwmt_6uf7OSoGvOJLrLLMULVERubU1ut-=WqQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 May 2024 15:50:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJ6oyhbiY89MDbJkq1q1UDwneJ9p+9PVY6ZHdAg==rng@mail.gmail.com>
Message-ID: <CAD=FV=WJ6oyhbiY89MDbJkq1q1UDwneJ9p+9PVY6ZHdAg==rng@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: qcom-geni: Fix qcom_geni_serial_stop_tx_fifo()
 while xfer
To: Stephen Boyd <swboyd@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, John Ogness <john.ogness@linutronix.de>, 
	Tony Lindgren <tony@atomide.com>, linux-arm-msm@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 24, 2024 at 5:17=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> 1. It appears that M_GP_LENGTH can still advance after the FIFO
> becomes 0, which is extra proof that the transfer is still happening
> even though the FIFO says it's done. Presumably we could keep track of
> how many bytes we have enqueued into the FIFO for this command and
> then compare. As I was trying to do this, though, I noticed another
> option...
>
> 2. It appears that instead of "cancelling" the current command we can
> just issue a new 0-byte transfer and wait for the 0-byte transfer to
> be "done". This causes geni to give us back a "M_CMD_OVERRUN"
> interrupt, but that's fine and we can ignore it. That interrupt just
> says "hey, you gave me a command before the previous one was done" but
> it does seem to properly accept the new command and it doesn't drop
> any bytes.
>
> ...it turns out that we (apparently) already have been using option #2
> to interrupt a transfer without dropping bytes. When the UART is
> shared between an agetty and the kernel console this happens all the
> time. In qcom_geni_serial_console_write() we'll issue a new command
> before finishing a current one and then re-issue the current command
> with any remaining bytes. So not only should this be safe but it's
> already tested to work.
>
> I'll need to spend a little more time on this to really confirm it
> works as I expect and I'll send up a v2 using approach #2.

Just to connect the dots more, I did more testing and option #2
totally didn't work. The console/kdb stuff was working mostly through
ugly fragile hacks. Polling GP_LENGTH seemed like the only option,
though when I dug more I found that this wasn't the right place to do
it anyway...


> Also note that while spending more time on this I found _yet another_
> bug, this one more serious. My original testing was done on kernel 6.6
> (with stable backports) and I just did confirmation on mainline.
> That's why I didn't see this new bug originally. ...but this time I
> spent more time testing on mainline. It turns out that the recent
> patches for kfifo on mainline have badly broken geni serial.
> Specifically, if you just do "cat /var/log/messages" and then "Ctrl-C"
> the machine will hard lockup! Yikes! This is yet another side effect
> of the geni "packet"-based protocol biting us (so related to the
> problems in ${SUBJECT}, but not identical). Whenever we setup a TX
> transfer we set it up for the number of bytes in the queue at the
> time. If that number goes down then we're in trouble. Specifically, it
> can be noted that:
> * When we start transmitting we look at the current queue size, setup
> a transfer, and store "tx_remaining".
> * Whenever there's space in the FIFO we add bytes and remove them from
> the queue and "tx_remaining".
> * We don't ever expect bytes to disappear from the queue. I think in
> the old code if this happened we're just transfer some bogus bytes.
> Now we'll loop in qcom_geni_serial_send_chunk_fifo() because
> uart_fifo_out() will keep returning 0.
>
> I'll try to take a gander at that, too...

I spent _far_ too long poking at this and I've finally come up with a
v2 that _I think_ fixes everything. For reference:

https://lore.kernel.org/r/20240530224603.730042-1-dianders@chromium.org

