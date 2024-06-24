Return-Path: <linux-kernel+bounces-227930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E65915833
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD5B2862BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E17919D88D;
	Mon, 24 Jun 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjK5BkHH"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C038F9A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261940; cv=none; b=prCa614dIySaXJhYKX/LTxKqlW5EC3/TA1OzMloEXrk1aRTsVKBAGEP2smJpqQO3NOXWUdjcO8kvtoThazr3ODZscxwDpn4uh4ME0DQZIuFpiSR23CB4hFtB/vJBeTdpPhZ4P2pDcf3HDF6tpEhGNqHgBVN1Vwyjr2v/a2A9uoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261940; c=relaxed/simple;
	bh=Ofe5Udbju62wIPycBMd9BKkYVB1oN6NMkyEzC9dWzk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIRhahhDkd/3poeF34eLoYeR8B164NqVurYoIdOHWd+/Sv1Lt7x7EksK2xJQQPJcFtOQVOnjAYLh5xtHPN+Ez3zef738bE8FbAFJp/nvmw8H3KuYljhiK4rCQOHf6O9Chp0qiZRozeEhj30BDJkTJ4nAZywwxIxddN5eXBbxSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SjK5BkHH; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d541d93127so1027033b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719261937; x=1719866737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTharbi6ZPnC1Zed84UrT9QU8P9auaSnZ5aSyQ0TZ6o=;
        b=SjK5BkHHc65brFskRSyt+n4DIicZp+KlRY09/CNGwHjk5LZa1ECNHlkXUgfdtJJRur
         isdTUyRJY3bVImH/SB3M2TP2RhoDwlnSO4Y5zuRfGr6xPz2jGem2eDPQ6limxUT3PUdN
         rVP98scW+aB01svD7dQeazDYhfawjQYd8qHM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719261937; x=1719866737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTharbi6ZPnC1Zed84UrT9QU8P9auaSnZ5aSyQ0TZ6o=;
        b=tDjVud4Y2bsec/JPHxCeuXY7X8nsr1jYJnmBeS00P6HXcmcT8mB3+vfeyifxyC/wSi
         WDbfOv911dp23tvHB1ds1wiPYAYSkHJTS0D5dGLreE1pDXcxEDJ8Jxo4TshTpu9cFHoN
         4l/wnIqCjp6M/JTEAmYQ0uTgPN02noYS1Z1rQUXhH3jMg6LXMVvRAMKkn2G6lGXmJD1U
         lcQrXjTThFLkdSPAVkd3fxYUoK3eQ7XEyywDojgDtUQ8D6nP8x5A36rxdlglFmGc1Y9Q
         F87f6j/ZEv45+DU60yvn3jY04q/dypbkvd1LutpbY2+c0bXiX80Fa1Vlf4N9g4/PwCP3
         8NAw==
X-Forwarded-Encrypted: i=1; AJvYcCXI1RN4j478l7XpuSdD7+wxVCbeIULA4PV4e3TEuVG6stGmaME+V+Ro914Mh+hRsnuYD7bLswOVuvQuLygocjxMeqbRHGlcTGjkbxUl
X-Gm-Message-State: AOJu0Ywuc/Z33nQqQas5BUcTQmpNm5oDdT35FQIoWXX8em9+fuMQXz4y
	5n/7nb67uxmt8f/I+BdhnbI4abdg7VfVm+xirnOd43WBHpOZBoJvpYy+unHeNpvoJjJiFtjrOY8
	=
X-Google-Smtp-Source: AGHT+IH8qgyVozwtzWduWy69I0p+GLdu+/cIY0AR0wpTqfGZWUdTdRp0jnjKpa5S7+qUz/Nyv3nKEg==
X-Received: by 2002:a05:6808:1881:b0:3d2:1cc7:6490 with SMTP id 5614622812f47-3d545963994mr6202115b6e.11.1719261936694;
        Mon, 24 Jun 2024 13:45:36 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b0d64sm347026285a.28.2024.06.24.13.45.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 13:45:36 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4405dffca81so16811cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:45:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuLrtQZhN3cNG8FejzDvYr5z7dXdeRdTx7lBJ71JPI8UzPQHihHvbbCRuQvejoHHzAJZ/rQyZFj4WUV8rBjg5weHFpB5zxFva+Eswn
X-Received: by 2002:ac8:5f0c:0:b0:43e:295:f160 with SMTP id
 d75a77b69052e-444f2520a22mr883301cf.24.1719261935354; Mon, 24 Jun 2024
 13:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org>
 <20240624133135.7445-2-johan+linaro@kernel.org> <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
In-Reply-To: <CAD=FV=VZXnnbwTNc6dSqZvyCUc0=Wjg9mvBYsA1FJK3xR6bDEg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 13:45:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwyzA614tDoq7BntW1DWmic=DOszr+iRJVafVEYrXhpw@mail.gmail.com>
Message-ID: <CAD=FV=UwyzA614tDoq7BntW1DWmic=DOszr+iRJVafVEYrXhpw@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: qcom-geni: fix hard lockup on buffer flush
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 10:39=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel=
.org> wrote:
> >
> > The Qualcomm GENI serial driver does not handle buffer flushing and use=
d
> > to print garbage characters when the circular buffer was cleared. Since
> > commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo") this
> > instead results in a lockup due to qcom_geni_serial_send_chunk_fifo()
> > spinning indefinitely in the interrupt handler.
> >
> > This is easily triggered by interrupting a command such as dmesg in a
> > serial console but can also happen when stopping a serial getty on
> > reboot.
> >
> > Fix the immediate issue by printing NUL characters until the current TX
> > command has been completed.
> >
> > Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I don't love this, though it's better than a hard lockup. I will note
> that it doesn't exactly restore the old behavior which would have
> (most likely) continued to output data that had previously been in the
> FIFO but that had been cancelled.
>
> ...actually, if we're looking for a short term fix that mimics the old
> behavior more closely, what would you think about having a
> driver-local buffer that we fill when we kick off the transfer. Then
> the data can't go away from underneath us. It's an extra copy, but
> it's just a memory-to-memory copy which is much faster than the MMIO
> copy we'll eventually need to do anyway... This local buffer would
> essentially act as a larger FIFO.
>
> You could choose the local buffer size to balance being able to cancel
> quickly vs. using the FIFO efficiently.

Also: if we're looking at quick/easy to land and just fix the hard
lockup, I'd vote for this (I can send a real patch, though I'm about
to go on vacation):

--

@@ -904,8 +904,8 @@ static void qcom_geni_serial_handle_tx_fifo(struct
uart_port *uport,
                goto out_write_wakeup;

        if (!port->tx_remaining) {
-               qcom_geni_serial_setup_tx(uport, pending);
-               port->tx_remaining =3D pending;
+               port->tx_remaining =3D min(avail, pending);
+               qcom_geni_serial_setup_tx(uport, port->tx_remaining);

                irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
                if (!(irq_en & M_TX_FIFO_WATERMARK_EN))

--

That will fix the hard lockup, is short and sweet, and also doesn't
end up outputting NUL bytes.

I measured time with that. I've been testing with a file I created
called "alphabet.txt" that just contains the letters A-Z repeated 3
times followed by a "\n", over and over again. I think gmail will kill
me with word wrapping, but basically:

ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVW=
XYZ
...
...

FWIW:

head -200 /var/alphabet.txt  | wc
    200     200   15800

Before my patch I ran `time head -200 /var/alphabet.txt` and I got:

real    0m1.386s

After my patch I ran the same thing and got:

real    0m1.409s

So it's slower, but that's not 25% slower. I get 1.7% slower:

In [6]: (1.409 - 1.386) / 1.386 * 100
Out[6]: 1.659451659451669

IMO that seems like a fine slowdown in order to avoid printing NUL bytes.

