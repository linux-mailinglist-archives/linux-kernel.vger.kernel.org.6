Return-Path: <linux-kernel+bounces-209001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BDF902BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67256B235E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B931514F3;
	Mon, 10 Jun 2024 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LU8bIS3v"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6614F9CA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058402; cv=none; b=dFaomV4f7wuNa9TZvxDwtOMvcbXsir5Cdf73LeAum2yiEe19DfRsNKl791xaGPg5aDjB29s9EdAvyHK8zsgK8NDIlFAKDkfGDa/G38fsSZesT1y6WcpvJAhDB/AV7qsMZlzlS7aVzLyu7pa/Y/5WY+8jNgz3XIE/tPMuHimr3uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058402; c=relaxed/simple;
	bh=jkVV1qC5l78Q3rbJemzf3Lvhx8BH5IjwVLa5ql5PA1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6vDUs8rbZTUsoCcWDaEDXNbRIScJ910eDaND4d1x9Mp6ZoYBetLmOBsYXo9eiiMo/4qVPMbH/q0MOd1OdyuEsLOxkT8UZ+/gAiHXdNgT+/tBp3I7w7uB5+dd/y1LcCfs+VlJQqv6BXA1NhcmoqWcLip3ux4S+TiUIqW91jLDZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LU8bIS3v; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43fb094da40so51719171cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058398; x=1718663198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t61vhNKu4lfde12Y7MkGP0C3wTMA8CL4vSTRQiLNbi4=;
        b=LU8bIS3vBADw8n19ZuMa7gXEVQ7GAb77Hp5ErnEsCevyJBW4wHzD7i4Zt3SBWbGG63
         qZiBsqrg+XJZw1KDDAOwM/3JxPbadALuf3soW1LoUwSJURinytJxECtqwCggl11QIhTa
         pePXZBE90bC26cSXI7RB7G5cQECwFo9nSSRXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058398; x=1718663198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t61vhNKu4lfde12Y7MkGP0C3wTMA8CL4vSTRQiLNbi4=;
        b=gxluEOjaJMPnuBUeIi394iPRzSwhkKvYp1G1uYYR8NY2naokLsC2IblqQAOSIhLnrd
         Rxzs3215qgQxUo/jaiKwT5OucgaBusQBA/L1nnBSLXZULTSqeJrjiw4wmiHzzBuiGo2J
         GnCxafTs1w9ZwmSBebxC2jn75NkQw9BPIuQGYue4ChzXYnkQXmQyI4mj09sbpYDqomv0
         +U0ARlIGvqXLoc58soSLNBXZLQzDABAW+a4KYDT7yYUCgf3wCmpUDLbeuR/sST/LTlXe
         m1leSamdOCQNHl5WPV6UqhgAwu1t2QBX6ULvcB1kWkJfUnd/yw/2hPCLldCyjrFXbU35
         Q3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWur4MPA76IMGhh6CGFXTokykqs2In3VU9RpNMEdH545LhJeUktFXFKtangJC2DAb8WgSU53LABJcZvgKwMlSugsihJgpKXnAiKWnd8
X-Gm-Message-State: AOJu0YyJjWggkfOPqBQVv7KhkwWNn7EGPj2eZC5P6BjOsAqS5ZTet/xH
	GCTS5tx6MNefSBFS6Kd4PUv90V/VjOt58r/qF1Tt1/dIxi6rZd2FHfKs5eOKns1rHAFYcK7g8Y0
	=
X-Google-Smtp-Source: AGHT+IHE8s6DBh+SXLTOrFW5b59qYt9igxegxQTOhkExmSXHEzcX0nnX5RJNtt1WINA0QZ66Up1qzg==
X-Received: by 2002:a05:622a:87:b0:440:25e8:15d7 with SMTP id d75a77b69052e-4413ab8e74emr19150101cf.6.1718058398189;
        Mon, 10 Jun 2024 15:26:38 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a684c4sm39952501cf.21.2024.06.10.15.26.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 15:26:36 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4400cc0dad1so192261cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:26:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUceMJfqUrvvBXMvUD+BcgNAsZZQpZMOoHgyhv2D924Fbh4KeoskVkZX3zC6fj8QfgTNqDe9Z8l3F9CzgFysqDR8vJcDAk7hjCsKVmy
X-Received: by 2002:a05:622a:5818:b0:440:331b:59f7 with SMTP id
 d75a77b69052e-441401262famr1308541cf.6.1718058395830; Mon, 10 Jun 2024
 15:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604160123.2029413-1-dianders@chromium.org>
 <20240604090028.v3.6.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid> <2c5c3d46-5fe2-6678-34ea-647c28f5a4f0@linux.intel.com>
In-Reply-To: <2c5c3d46-5fe2-6678-34ea-647c28f5a4f0@linux.intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 10 Jun 2024 15:26:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDcFsStOcViTQLLQqPtbCOqeVeoU0T7fi81jhHodpa=A@mail.gmail.com>
Message-ID: <CAD=FV=XDcFsStOcViTQLLQqPtbCOqeVeoU0T7fi81jhHodpa=A@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] serial: qcom-geni: Fix suspend while active UART xfer
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-msm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-serial <linux-serial@vger.kernel.org>, John Ogness <john.ogness@linutronix.de>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Stephen Boyd <swboyd@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 12:43=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> > @@ -311,11 +312,14 @@ static bool qcom_geni_serial_poll_bit(struct uart=
_port *uport,
> >
> >  static void qcom_geni_serial_setup_tx(struct uart_port *uport, u32 xmi=
t_size)
> >  {
> > +     struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> >       u32 m_cmd;
> >
> >       writel(xmit_size, uport->membase + SE_UART_TX_TRANS_LEN);
> >       m_cmd =3D UART_START_TX << M_OPCODE_SHFT;
>
> Unrelated to this patch and won't belong to this patch but I noticed it
> while reviewing. This could be converted into:
>
>         m_cmd =3D FIELD_PREP(M_OPCODE_MSK, UART_START_TX);
>
> (and after converting the other use in the header file, the SHFT define
> becomes unused).

Sure. I'm going to leave that to someone in the future, though. I've
already spent more time than I should on this series and, if we're
going to do this, we should convert the whole driver (and perhaps all
the geni drivers).


> > @@ -335,6 +339,64 @@ static void qcom_geni_serial_poll_tx_done(struct u=
art_port *uport)
> >       writel(irq_clear, uport->membase + SE_GENI_M_IRQ_CLEAR);
> >  }
> >
> > +static void qcom_geni_serial_drain_tx_fifo(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > +
> > +     /*
> > +      * If the main sequencer is inactive it means that the TX command=
 has
> > +      * been completed and all bytes have been sent. Nothing to do in =
that
> > +      * case.
> > +      */
> > +     if (!qcom_geni_serial_main_active(uport))
> > +             return;
> > +
> > +     /*
> > +      * Wait until the FIFO has been drained. We've already taken byte=
s out
> > +      * of the higher level queue in qcom_geni_serial_send_chunk_fifo(=
) so
> > +      * if we don't drain the FIFO but send the "cancel" below they se=
em to
> > +      * get lost.
> > +      */
> > +     qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GENMAS=
K(31, 0),
>
> That GENMASK(31, 0) is a field in a register (even if it covers the
> entire register)? It should be named with a define instead of creating th=
e
> field mask here in an online fashion.

Sure. Done.


> > +                                    port->tx_total - port->tx_remainin=
g);
> > +
> > +     /*
> > +      * If clearing the FIFO made us inactive then we're done--no need=
 for
> > +      * a cancel.
> > +      */
> > +     if (!qcom_geni_serial_main_active(uport))
> > +             return;
> > +
> > +     /*
> > +      * Cancel the current command. After this the main sequencer will
> > +      * stop reporting that it's active and we'll have to start a new
> > +      * transfer command.
> > +      *
> > +      * If we skip doing this cancel and then continue with a system
> > +      * suspend while there's an active command in the main sequencer
> > +      * then after resume time we won't get any more interrupts on the
> > +      * main sequencer until we send the cancel.
> > +      */
> > +     geni_se_cancel_m_cmd(&port->se);
> > +     if (!qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                    M_CMD_CANCEL_EN, true)) {
> > +             /* The cancel failed; try an abort as a fallback. */
> > +             geni_se_abort_m_cmd(&port->se);
> > +             qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> > +                                             M_CMD_ABORT_EN, true);
>
> Misaligned.

Done.

