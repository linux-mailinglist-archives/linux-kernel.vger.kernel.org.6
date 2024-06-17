Return-Path: <linux-kernel+bounces-218217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC2F90BB41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A895B1F22576
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C98B187545;
	Mon, 17 Jun 2024 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hZbSvA9z"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF9187326
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653086; cv=none; b=a1PJxEfiiSAr9PGr7BurQFgpe+aKnVPqJTLHtfX15R4oCbXkSxG1riQfNIHS0CILlnP5v0SB3anOutpa0+20Yf51+OVx3VUJlcJeq4kR4gaymlZ6Xiorjkeg+EIhtUXnuk5IJmrqbYc5Ml3h7+qw1I03VzmYttfYB9+ofCC0Er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653086; c=relaxed/simple;
	bh=wlo+NPQPjkhJDcsoBLXWcznRisfoTBjuU62SEtBO9Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyOf+fwtHq4qv/BR1mpJVeM2kG/VQv4E/yi+6ff+BaCPKKqZN/mn4UMRKiQIf+MyCWOWGDbf3eqOrVZe2hkBm3roHKIRmy4bf6g8Cl38N14SKsc5TdxFiL6c/P29kEkwm2c2AK9jlc7kqD/sTNDUqtgXQ596YsjvO/LQ/UofdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hZbSvA9z; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7961fb2d1cfso391279485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718653080; x=1719257880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeWty9541wg5SD9NtVmG1BHrErKfkqRa0zvwO/tO/ls=;
        b=hZbSvA9zbtcPY5dyNGk7eqWZFYlVHnjudkAFTg/FQqYgJtAtxqoc32hv1iR6YlYB/p
         ykR0LiIJc6oDs93r65G0JxmQpT29rpBsDRlAHJ8KdYsfJIGyulBWo1p1zpIuSiPsMrGH
         eSta4Qu4WM2KUw6RVxeGUVk850qO7oSEGOoT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718653080; x=1719257880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeWty9541wg5SD9NtVmG1BHrErKfkqRa0zvwO/tO/ls=;
        b=a+scDo8jALU4AMk65zyAv1uYjn0y/z+AGt/Oka/hiGrV+M//DnbU8BcNy/9qn2FWLz
         LBZqDqe+KV6FHCcb8q5sI/D/rtL0nrZJPY5P2SWn5VVH7mqPO/p7QkQcO9cwpRO+QSPH
         9P4Di3+9nwkWEYzFyhmjmAx9X9K47iz5hHKytKQYloACRVpuLdj2d5vE7+v4v70fH5O5
         cV3351iNlJV3Q2Qod5L7bJsjWjPwXPt3S4kG5TsSzoUTnB5L7hzZ5nXzQJshDjlp+e0I
         v4VK7jWybPGS8hwulr1ob5klB7MsoVXV19h7VsnIPkOpzpWWCd+tOj0KJxpdX1sDeeq7
         Ybkg==
X-Forwarded-Encrypted: i=1; AJvYcCW5yuH4hIsdVYECll4Tp8zpTn7qw/M58WKv2B7FNsrtoCm3nQcXeLDNdmppJUlxLpZzL/wy49sGC8fbit/aCcFOHq1Id+qNKn9h7AQd
X-Gm-Message-State: AOJu0Yw+VIXtW+epZyJIbgDx7BsSbuuo+baNNRtRRxdSfJSkX6ILDli7
	VvgthRuYnpCYIeATKmnm/xequYBdrYQiP4cTz5N0NmeVTjNgCJU3Ahtn7LpoPxMzhmnC0MUOHtc
	=
X-Google-Smtp-Source: AGHT+IGHcjA1F5lsuKbVbwCovF4bNUh9dB5NAabKQ8eiy+f6BWPrKks66HCSQz745weMXWMn6qblLw==
X-Received: by 2002:ad4:5be5:0:b0:6b0:6a26:9083 with SMTP id 6a1803df08f44-6b2afd5b8c0mr132340106d6.40.1718653080598;
        Mon, 17 Jun 2024 12:38:00 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf24f5sm58829396d6.3.2024.06.17.12.37.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:37:59 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4405dffca81so40821cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:37:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8hqHF2tpLfPt2LOm0hMluEZRl9Jf9ZRHSpvPui8G4VRcjcWyOVhAG7Yg+3/102hxGF/qceGdsyx/kuthjSZPMp47Zym7s1JnzCTz4
X-Received: by 2002:a05:622a:1813:b0:442:172e:4dd2 with SMTP id
 d75a77b69052e-4449c71ad9dmr515541cf.18.1718653078487; Mon, 17 Jun 2024
 12:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.8.I1af05e555c42a9c98435bb7aee0ee60e3dcd015e@changeid> <bc4892b7-7c34-4fcb-b4c0-e383890162f8@linaro.org>
In-Reply-To: <bc4892b7-7c34-4fcb-b4c0-e383890162f8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 17 Jun 2024 12:37:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UuChPf0DH7aYq8r2XLCr7D+mbm4QSfthf-9ezvFeNUbg@mail.gmail.com>
Message-ID: <CAD=FV=UuChPf0DH7aYq8r2XLCr7D+mbm4QSfthf-9ezvFeNUbg@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Johan Hovold <johan+linaro@kernel.org>, 
	John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 12:10=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
>
>
> On 6/11/24 00:24, Douglas Anderson wrote:
> > The fact that the Qualcomm GENI hardware interface is based around
> > "packets" is really awkward to fit into Linux's UART design.
> > Specifically, in order to send bytes you need to start up a new
> > "command" saying how many bytes you want to send and then you need to
> > send all those bytes. Once you've committed to sending that number of
> > bytes it's very awkward to change your mind and send fewer, especially
> > if you want to do so without dropping bytes on the ground.
>
> [...]
>
>
> > +static void qcom_geni_serial_enable_cmd_done(struct uart_port *uport)
> > +{
> > +     struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> > +
> > +     /* If we're not in FIFO mode we don't use CMD_DONE. */
> > +     if (port->dev_data->mode !=3D GENI_SE_FIFO)
> > +             return;
> > +
> > +     writel(M_CMD_DONE_EN, uport->membase + SE_GENI_M_IRQ_EN_SET);
> > +}
>
> IDK if this is worth of a separate function, instead of checking for the
> FIFO in port_setup and writing it there, but generally this patch looks
> good to me

Sure. Somehow it felt weird to me to put it straight in there, but I
could go either way. Do you think I should spin the series just for
this, or just make this change if I happen to need to spin the series
for something else?


> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks for your reviews, I appreciate it!

-Doug

