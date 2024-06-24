Return-Path: <linux-kernel+bounces-227988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49201915959
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD8B21F235B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25771A08DF;
	Mon, 24 Jun 2024 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BExXfbAp"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538CE13C901
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266340; cv=none; b=ZLwIYba4oY5bWmL7IeV6VmQfh7AWMzpu/04qTTo0QH0x7oyawKbAGV1H4B8jCwkbi5LTbSy8h3YksORxapLZrgNssQPo6SnXssyLCtYg+uLsItAmli6LX+b+vZ1T99z4NwkIsNklYeWUCUJgZCOS61zZelxbB/DtS1R56nc02ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266340; c=relaxed/simple;
	bh=VLdhJLIwaxQ8wxTJQNH+te/BcT//2ZP5Bbh7eH2t22E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH3up3NtMUfunJBbrFcNt+xzjcJOCxjhl7ltClED1poUE41Q1Ih9NIst5R21iKPDLRXE8HIJHiZTCZ4FMjBmx0sbXRxUcE1zXO/TFFENWFrsz3ye5ybMpGrDaXsC3jNoOejiLOrGv+DxGvFAVJYAsQZGLSQLKgCLzJmNFapbnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BExXfbAp; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48f6337b567so330533137.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719266336; x=1719871136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PykbmAe7/RecVGDwZZ/IKDsll6JeakGvoiBa3T2dozg=;
        b=BExXfbAp92/sI40WbfKFkVGqMC73Qtm9XF7ACVzRDSruVF+Vi8VCE6TvcAbmR//dTq
         UDQvpmzdG4uFtyGiRqlLEQnlE5vJVg/3/4EeK/Ap6Ct83xBOSEKWzDM6vVnZN2Db39ai
         IvxJT6seuxT8m27xXCepc5eyljuJOF+rVT5U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266336; x=1719871136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PykbmAe7/RecVGDwZZ/IKDsll6JeakGvoiBa3T2dozg=;
        b=XQNBx8q0okN4UWIHrdkzIKUJ+RgJfJyQlOITMR4hG6TZTSWn1hDw79t2MrxJ0+pkmc
         Wb+XRVDI0SXqKjyycKm/Sy7HS7QToLJ+6YWJcUwf27PfEF1A49tOyBWdGhIyvre+aSTI
         vZsqtxsEHE3/9BGNrJ9OkD8YYn5Wkx3tsC3BizDxQ1U4yI9Vjx+CkJR0+L5pwXHzNvze
         nBTvRwdIc0P1KVgVsnXOBAFfZ7Y3Dj1XhFdNHo6ESXLtXzKWsj/prnPgLqlG5VWgLZMe
         x1L+EfJ0lD/s3y+nE8JehDJ4tFW0KPbWIjSKAD4lWS0+Q9sokeF0vC7XW4HFW3H+uBnK
         5NLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMtc51COWgegLQ34uNakVvQViZshNpOeow8WRZuzplj4WfMDovFY2UYx7bHCzCbgl6Oflz+sNY398jcOsMlW7pGGHYuo33AFyiWoMs
X-Gm-Message-State: AOJu0YzG121U9PQUX6ocv+OfEenfgPsOf/wzhrhudoatQFBZ61XVu/o7
	G44wC/3kmb/bW08GxHojENcm5hJRdNGiTNdfuJkeuCS1cgMIxh8if1bYa+SfOMOw+t9eM+6C/1U
	=
X-Google-Smtp-Source: AGHT+IEI0wMOLQ4Gawo4+cbPJGvrqMHRI4DM/9sX6sOAlQyL9Y95QFczbyas9eGbtMB0GhggJ1S6XA==
X-Received: by 2002:a05:6102:2243:b0:48c:473a:24e2 with SMTP id ada2fe7eead31-48f52b76952mr3886899137.29.1719266335608;
        Mon, 24 Jun 2024 14:58:55 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444ed6b5a8csm8019581cf.74.2024.06.24.14.58.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:58:54 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4405dffca81so34291cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ7qQ//uZaITAPqSBqDEsxdWixooZBsDf6Pq6oIJFWJB5oiCzKK/UZ+QHdadSlYK379MOGDw2KdLJOb5UKTNOotKzdoZp/x2WAHtS9
X-Received: by 2002:ac8:59d0:0:b0:444:ba78:c32c with SMTP id
 d75a77b69052e-444f36a7810mr388891cf.11.1719266334099; Mon, 24 Jun 2024
 14:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org>
 <20240624133135.7445-3-johan+linaro@kernel.org> <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
In-Reply-To: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 14:58:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPKqjMcWhqk4OKxSOPgDKh-VM4J4oMEdQtgpFBw8WSXA@mail.gmail.com>
Message-ID: <CAD=FV=XPKqjMcWhqk4OKxSOPgDKh-VM4J4oMEdQtgpFBw8WSXA@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: qcom-geni: fix soft lockup on sw flow control
 and suspend
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 2:23=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel=
.org> wrote:
> >
> > The stop_tx() callback is used to implement software flow control and
> > must not discard data as the Qualcomm GENI driver is currently doing
> > when there is an active TX command.
> >
> > Cancelling an active command can also leave data in the hardware FIFO,
> > which prevents the watermark interrupt from being enabled when TX is
> > later restarted. This results in a soft lockup and is easily triggered
> > by stopping TX using software flow control in a serial console but this
> > can also happen after suspend.
> >
> > Fix this by only stopping any active command, and effectively clearing
> > the hardware fifo, when shutting down the port. Make sure to temporaril=
y
> > raise the watermark level so that the interrupt fires when TX is
> > restarted.
>
> Nice! I did quite a few experiments, but it sounds like you found
> something that I wasn't able to find. Specifically once I cancelled an
> ongoing command I could never manage to get it started back up, but it
> must have just been that data was still in the FIFO and thus the
> watermark never fired again.
>
> When I was experimenting, I also swore that there were cases where
> geni would sometimes fully drop bytes when I tried to "cancel" a
> command, but maybe I was mistaken. Everything I figured out was
> essentially by running experiments and I could easily have had a bug
> in my experiment.
>
>
> > Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver s=
upport for GENI based QUP")
> > Cc: stable@vger.kernel.org      # 4.17
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial=
/qcom_geni_serial.c
> > index 1d5d6045879a..72addeb9f461 100644
> > --- a/drivers/tty/serial/qcom_geni_serial.c
> > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > @@ -651,13 +651,8 @@ static void qcom_geni_serial_start_tx_fifo(struct =
uart_port *uport)
> >  {
> >         u32 irq_en;
> >
> > -       if (qcom_geni_serial_main_active(uport) ||
> > -           !qcom_geni_serial_tx_empty(uport))
> > -               return;
> > -
> >         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >         irq_en |=3D M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> > -
> >         writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
> >         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> >  }
> > @@ -665,16 +660,28 @@ static void qcom_geni_serial_start_tx_fifo(struct=
 uart_port *uport)
> >  static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
> >  {
> >         u32 irq_en;
> > -       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> >
> >         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
> >         irq_en &=3D ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
> >         writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
> >         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> > -       /* Possible stop tx is called multiple times. */
>
> If qcom_geni_serial_stop_tx_fifo() is supposed to be used for UART
> flow control and you have a way to stop the transfer immediately
> without losing data (by using geni_se_cancel_m_cmd), maybe we should
> do that? If the other side wants us to stop transferring data and we
> can stop it right away that would be ideal...
>
>
> > +}
> > +
> > +static void qcom_geni_serial_clear_tx_fifo(struct uart_port *uport)
> > +{
> > +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > +
> >         if (!qcom_geni_serial_main_active(uport))
> >                 return;
> >
> > +       /*
> > +        * Increase watermark level so that TX can be restarted and wai=
t for
> > +        * sequencer to start to prevent lockups.
> > +        */
> > +       writel(port->tx_fifo_depth, uport->membase + SE_GENI_TX_WATERMA=
RK_REG);
> > +       qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                       M_TX_FIFO_WATERMARK_EN, true);
>
> Oh, maybe this "wait for sequencer to start to prevent lockups." is
> the part that I was missing? Can you explain more about what's going
> on here? Why does waiting for the watermark interrupt to fire prevent
> lockups? I would have imagined that the watermark interrupt would be
> part of the geni hardware and have nothing to do with the firmware
> running on the other end, so I'm not sure why it firing somehow would
> prevent a lockup. Was this just by trial and error?

Actually, the more I look at it the more confused I am about your
qcom_geni_serial_clear_tx_fifo(). Can you explain and maybe add some
inline comments in the function since it's not obvious? Specifically,
things I'm confused about with your patch:

1. The function is named qcom_geni_serial_clear_tx_fifo() which
implies that when it finishes that the hardware FIFO will have nothing
in it. ...but how does your code ensure this?

2. If the function is really clearing the FIFOs then why do we need to
adjust the watermark level? The fact that you need to adjust the
watermark levels implies (to me) that there are things stuck in the
FIFO still. ...but then what happens to those characters? When are
they sent?

3. On my hardware you're setting the FIFO level to 16 here. The docs I
have say that if the FIFO level is "less than" the value you set here
then the interrupt will go off and further clarifies that if you set
the register to 1 here then you'll get interrupted when the FIFO is
empty. So what happens with your solution if the FIFO is completely
full? In that case you'd have to set this to 17, right? ...but then I
could believe that might confuse the interrupt handler which would get
told to start transmitting when there is no room for anything.


Maybe something is missing in my mental model here and testing your
patch and hitting Ctrl-C seems to work, but I don't really understand
why so hopefully you can clarify! :-)

-Doug

