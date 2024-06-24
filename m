Return-Path: <linux-kernel+bounces-227962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E79158CC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 912512815A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A71A08CE;
	Mon, 24 Jun 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgZ/G8O1"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D823746
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719264251; cv=none; b=opPayOV8CBvDhvuHXThiAKT4QPRHnNsocaSeo7BWTGtvWF6zVwIJ1NDNyOpAMQ0axIrMMeO6Ava8HaCj/9lNI9sqYbHAHzbaHS8ZLcMKC7T/CxGFQu/sP3JCmOWQt09B9FewL6l/LTJrBGHHnBEs+15tklEvORP+dVsuAd1zZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719264251; c=relaxed/simple;
	bh=IFZr6MV4AR6r14kqmLG6qUlrfX6va9/24Y1lP+Gq/00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XV+dPBBH4PZpWcyaK0HX7UoF+pPvvvQwDPYbwIsLOo16LiyoVAWnSokfOm2MkXLYSNt26M2TipHnJlWIXsBpR7mxmCIODhPEH6p+8i7Cz64dGHKC9cphUznfYzUHcqWeeTOkJNbX7mxk2Nx4qJNa3HTO4o4KhSFVOyAi1UpL3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jgZ/G8O1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7954f8b818fso303502785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719264247; x=1719869047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JOTUT9twe9eD9jXfuDuG0OciOCniJECQvgGWn276Tc=;
        b=jgZ/G8O1Pey0zI7uBb6xrIqUDn8wqqMQXc0w3XMr8tdeHrGhA/289FK/L96tLs6Vup
         H6xJvLH+PbEwhqgBSE8Kwj4E/lGSEXRYbuUMZQGiaYkHplf0HuVp1X1+fX+X6KHEsejp
         lS2G51hXMyfloZ4uWONcMIIpkN86NFlW/A7I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719264247; x=1719869047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JOTUT9twe9eD9jXfuDuG0OciOCniJECQvgGWn276Tc=;
        b=LWSzcyff/jjWqDJT+/8r6NdQgBXvM/kN554LN25gUiv+0nsaxaKCe7pH7sn2wkk4We
         EZdM493RUH4YCb8mtXWs8Y0XFvL6oBtzrp11oPdqfnzY6wEBhC8FJ2Yj1RI8aYkO1ICL
         XlElgqJk90RMZzhfOlUXJMQdcA6saviRi/N4f4qUQoTa09f6a4MW4MJ6nROONM1m7W41
         w/c0hycYnKjmBI8/DOEeCu3k66hv/KMS2iiIQtrEjJ3avYHe88sAUPQ8BpqZdQ9vY0V2
         GtixNMTKA0pVx6wDkj/YUCt9l09h0ydc2QWpemWKBgFYmetM1NoPdcxrqScNi2bQKFyO
         NNtA==
X-Forwarded-Encrypted: i=1; AJvYcCW7w4SqxZQ1MxMr23oQP1RMK29fh6G2YGF3NTdUjTISYqJqf7uib91lPtLunHNDfpQklj7rkfWksDi8uDrJk2vl+tuKqDNeAo02WmDo
X-Gm-Message-State: AOJu0YxWiy4//9EdUW5qy9gR9shJPsX1bYliSwV4m79x42t/d+yR8LI0
	p56K9O5ji8rfLgbmp0kYLCOldygpCdWBEBCOg60v2BuRtnqvv2WMKXPpmIvAUMnZ1F+5gzcw1Qo
	=
X-Google-Smtp-Source: AGHT+IFZzCTUjR+w4URku14OHgT46/LzAIM0oAGDv4Arqt5GE12zmUB8403RvUYQVtQH0JJYJr9pPg==
X-Received: by 2002:a05:620a:29d5:b0:79b:f10e:1196 with SMTP id af79cd13be357-79bf10e148fmr497226085a.0.1719264247513;
        Mon, 24 Jun 2024 14:24:07 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce92f538sm348243585a.99.2024.06.24.14.24.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 14:24:04 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44056f72257so35951cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:24:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzfxBaGUYOOP57c6cSCKw8TJQ28mkZh+o3YVAgByiaL0SNbyhIKjjr7zYpmQeJk84SI0KAT4Bru+OkriXB/vWqwXzVBXmapTerK0Du
X-Received: by 2002:ac8:7fc6:0:b0:444:b755:2aa1 with SMTP id
 d75a77b69052e-444f368e55amr295621cf.17.1719264244099; Mon, 24 Jun 2024
 14:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-3-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-3-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 14:23:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
Message-ID: <CAD=FV=UauWffRM45FsU2SHoKtkVaOEf=Adno+jV+Ashf7NFHuA@mail.gmail.com>
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

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The stop_tx() callback is used to implement software flow control and
> must not discard data as the Qualcomm GENI driver is currently doing
> when there is an active TX command.
>
> Cancelling an active command can also leave data in the hardware FIFO,
> which prevents the watermark interrupt from being enabled when TX is
> later restarted. This results in a soft lockup and is easily triggered
> by stopping TX using software flow control in a serial console but this
> can also happen after suspend.
>
> Fix this by only stopping any active command, and effectively clearing
> the hardware fifo, when shutting down the port. Make sure to temporarily
> raise the watermark level so that the interrupt fires when TX is
> restarted.

Nice! I did quite a few experiments, but it sounds like you found
something that I wasn't able to find. Specifically once I cancelled an
ongoing command I could never manage to get it started back up, but it
must have just been that data was still in the FIFO and thus the
watermark never fired again.

When I was experimenting, I also swore that there were cases where
geni would sometimes fully drop bytes when I tried to "cancel" a
command, but maybe I was mistaken. Everything I figured out was
essentially by running experiments and I could easily have had a bug
in my experiment.


> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 4.17
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 28 +++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 1d5d6045879a..72addeb9f461 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -651,13 +651,8 @@ static void qcom_geni_serial_start_tx_fifo(struct ua=
rt_port *uport)
>  {
>         u32 irq_en;
>
> -       if (qcom_geni_serial_main_active(uport) ||
> -           !qcom_geni_serial_tx_empty(uport))
> -               return;
> -
>         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en |=3D M_TX_FIFO_WATERMARK_EN | M_CMD_DONE_EN;
> -
>         writel(DEF_TX_WM, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
>  }
> @@ -665,16 +660,28 @@ static void qcom_geni_serial_start_tx_fifo(struct u=
art_port *uport)
>  static void qcom_geni_serial_stop_tx_fifo(struct uart_port *uport)
>  {
>         u32 irq_en;
> -       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
>
>         irq_en =3D readl(uport->membase + SE_GENI_M_IRQ_EN);
>         irq_en &=3D ~(M_CMD_DONE_EN | M_TX_FIFO_WATERMARK_EN);
>         writel(0, uport->membase + SE_GENI_TX_WATERMARK_REG);
>         writel(irq_en, uport->membase + SE_GENI_M_IRQ_EN);
> -       /* Possible stop tx is called multiple times. */

If qcom_geni_serial_stop_tx_fifo() is supposed to be used for UART
flow control and you have a way to stop the transfer immediately
without losing data (by using geni_se_cancel_m_cmd), maybe we should
do that? If the other side wants us to stop transferring data and we
can stop it right away that would be ideal...


> +}
> +
> +static void qcom_geni_serial_clear_tx_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
>         if (!qcom_geni_serial_main_active(uport))
>                 return;
>
> +       /*
> +        * Increase watermark level so that TX can be restarted and wait =
for
> +        * sequencer to start to prevent lockups.
> +        */
> +       writel(port->tx_fifo_depth, uport->membase + SE_GENI_TX_WATERMARK=
_REG);
> +       qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
> +                                       M_TX_FIFO_WATERMARK_EN, true);

Oh, maybe this "wait for sequencer to start to prevent lockups." is
the part that I was missing? Can you explain more about what's going
on here? Why does waiting for the watermark interrupt to fire prevent
lockups? I would have imagined that the watermark interrupt would be
part of the geni hardware and have nothing to do with the firmware
running on the other end, so I'm not sure why it firing somehow would
prevent a lockup. Was this just by trial and error?


> @@ -684,6 +691,8 @@ static void qcom_geni_serial_stop_tx_fifo(struct uart=
_port *uport)
>                 writel(M_CMD_ABORT_EN, uport->membase + SE_GENI_M_IRQ_CLE=
AR);
>         }
>         writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
> +
> +       port->tx_remaining =3D 0;
>  }
>
>  static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, boo=
l drop)
> @@ -1069,11 +1078,10 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> -       if (uart_console(uport))
> -               return;

Can you explain this part of the patch? I'm not saying it's wrong to
remove this special case since this driver seems to have lots of
needless special cases that are already handled by the core or by
other parts of the driver, but this change seems unrelated to the rest
of the patch. Could it be a separate patch?

