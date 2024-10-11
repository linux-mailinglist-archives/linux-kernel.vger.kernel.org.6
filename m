Return-Path: <linux-kernel+bounces-361294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30D99A65C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916011F2250A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A265C26AC1;
	Fri, 11 Oct 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQRit+cj"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404C624
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728657052; cv=none; b=PB331w5ayMZuQsfAFIeT4ulxys1vhHy9hbqdGFVBhnPfBq6JIosmzSsihZuiTuU+Uu21ITDbLo0TLeCUPBzYLGzUZy/Y6PDlMxvwQv2P6gktXi8SbtI7AnU0/WLd+xZ2A19asweXyHGBSWrBgC9yEweaSNVTYcn/4R1I09/3nKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728657052; c=relaxed/simple;
	bh=sk7ig4kmzzR0r3yaD+YqQ9AW4S497HPCFTId5lyO/eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh1C5xBfbs0jxGqug0uhuluGh+E5QoN0ihR0VkiYnGd0O3EmnaHds6A9W5PcdElWKrud0EnB9OnjSaAIBj69CsSbCd7b0XVXfvDGYW9HmQN0Ntc432GGPN5atWSwugMDeRtaeXzz6T7OsUZFc3XlxTQGDmSTYDVInAptHXZQMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VQRit+cj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-537a399e06dso2467205e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728657047; x=1729261847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BP0XnFYp3SsaSaiTxi9A6dV0XZX880MVcEXNqO2kxM=;
        b=VQRit+cjEZbvfVsZ0hdUN1MNLi0ACcDSAjfMXEDY7i8fx12a35Bpisg0e1Gsc8nw8z
         cu59XD0BWoUyHJlROeBT2NjV4Aag4uQQu5akyFnm7N9lLLV7ySvn74X21VgtPeheAJ/c
         9GYnVxKxtD8QDOaijGlWDDc0pgIwP1jlOgF7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728657047; x=1729261847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BP0XnFYp3SsaSaiTxi9A6dV0XZX880MVcEXNqO2kxM=;
        b=bBEU6iPJNVoC0STX8jffDyT9mVCkuVhP8FCdGCu603Qjal8vIDfJ+4nnx0K6CR3RFZ
         FdEsEjP7+a3U59oT1ao6UtXesylRrNf0dUF9giNtVlxJGhuu0o6O72n970pbgmKkpm1A
         RzgTD9sIvACOxICI+8xxm3t0HJrh+I3sCO3FES+OHgMF8BrxfgvYSk4lAug6JaTkT2rT
         oqtkptlKDLfLYtir4SjKUc03LJDDmXQvqOidXneAT9mmjmR+j9fDVVtL3+t0Zolz7JIS
         Th/GmHPbKAAHXXuHVyWRtvsqSAhgTifk1sE3WS8/VJ9kmJ87I9mOyVG7Un9Dj2OXpuKj
         Zrlg==
X-Forwarded-Encrypted: i=1; AJvYcCWPJlTk6GjrkActffihkS+6NYzmRxElYy15SGfqSjgMExj1kmMHYtT1upfQCGWCZXYauNU2FITNrcU+XaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRUNxsYJUnV5noR2FfoluXFqQjoMqMlf2RUBW/g3ie//JCPK5g
	UvLAsJjoTvMLyOTv7IUPzgWQATXTuawKU/R9lgEHPh2J8b7+Ifs0QQP6kErcdksyUAZlfJbAlow
	UODW6
X-Google-Smtp-Source: AGHT+IHvfdATejuhD+y+uz5EkYgFMAnGMVh0ZrqwVaGZ3tpw8E5F8ePIx40Ih1TzTWM6bPl00Fi8nw==
X-Received: by 2002:a05:6512:2211:b0:536:7a88:616b with SMTP id 2adb3069b0e04-539da4e1156mr1522999e87.26.1728657047123;
        Fri, 11 Oct 2024 07:30:47 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c12f6sm625293e87.56.2024.10.11.07.30.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:30:45 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53992157528so2365988e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXJbZnpGvOoOgllUledHEicAKrZ/q6hDT0tEZsyzsQosU+Hu5PZDbMUf8rWMXl/H8f8Dg4NxHLQlvlW/E=@vger.kernel.org
X-Received: by 2002:a05:6512:39ce:b0:52c:8abe:51fb with SMTP id
 2adb3069b0e04-539da3c1e52mr1341517e87.10.1728657045305; Fri, 11 Oct 2024
 07:30:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org>
 <20241001125033.10625-3-johan+linaro@kernel.org> <CAD=FV=UoU5Nd7sW66cjQzor+BP+W_f7uw0MGRaF6y7PH7KRN_g@mail.gmail.com>
 <ZwaO0hCKdPpojvnn@hovoldconsulting.com> <CAD=FV=UZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z0jkH4U30eQ@mail.gmail.com>
 <ZwjK-s0sMn9HOF04@hovoldconsulting.com>
In-Reply-To: <ZwjK-s0sMn9HOF04@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 Oct 2024 07:30:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XuEPGtDCe4ssXPy2avigqviTBAycc0Q_U_Pwi9x6t23g@mail.gmail.com>
Message-ID: <CAD=FV=XuEPGtDCe4ssXPy2avigqviTBAycc0Q_U_Pwi9x6t23g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2024 at 11:51=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> > > Not sure how your "console process" works, but this should only happe=
n
> > > if you do not enable the serial console (console=3DttyMSM0) and then =
try
> > > to use a polled console (as enabling the console will prevent port
> > > shutdown from being called).
> >
> > That simply doesn't seem to be the case for me. The port shutdown
> > seems to be called. To confirm, I put a printout at the start of
> > qcom_geni_serial_shutdown(). I see in my /proc/cmdline:
> >
> > console=3DttyMSM0,115200n8
> >
> > ...and I indeed verify that I see console messages on my UART. I then r=
un:
> >
> > stop console-ttyMSM0
> >
> > ...and I see on the UART:
> >
> > [   92.916964] DOUG: qcom_geni_serial_shutdown
> > [   92.922703] init: console-ttyMSM0 main process (611) killed by TERM =
signal
> >
> > Console messages keep coming out the UART even though the agetty isn't
> > there.
>
> And this is with a Chromium kernel, not mainline?

Who do you take me for?!?!  :-P :-P :-P Of course it's with mainline.


> If you take a look at tty_port_shutdown() there's a hack in there for
> consoles that was added back in 2010 and that prevents shutdown() from
> called for console ports.
>
> Put perhaps you manage to hit shutdown() via some other path. Serial
> core is not yet using tty_port_hangup() so a hangup might trigger
> that...
>
> Could you check that with a dump_stack()?

Sure. Typed from the agetty itself, here ya go. Git hash is not a
mainline git hash because I have your patches applied. "dirty" is
because of the printout / dump_stack().

lazor-rev9 ~ # stop console-ttyMSM0
[   68.772828] DOUG: qcom_geni_serial_shutdown
[   68.777365] CPU: 2 UID: 0 PID: 589 Comm: login Not tainted
6.12.0-rc1-g0bde0d120d58-dirty #1
ac8ed1a05abcc73f4fafe0543cbc76768ea594e1
[   68.789737] Hardware name: Google Lazor (rev9) with LTE (DT)
[   68.795581] Call trace:
[   68.798124]  dump_backtrace+0xf8/0x120
[   68.802025]  show_stack+0x24/0x38
[   68.805463]  dump_stack_lvl+0x40/0xc8
[   68.809265]  dump_stack+0x18/0x38
[   68.812702]  qcom_geni_serial_shutdown+0x38/0x110
[   68.817578]  uart_port_shutdown+0x48/0x68
[   68.821736]  uart_shutdown+0xcc/0x170
[   68.825530]  uart_hangup+0x54/0x158
[   68.829154]  __tty_hangup+0x20c/0x318
[   68.832954]  tty_vhangup_session+0x20/0x38
[   68.837195]  disassociate_ctty+0xe8/0x1a8
[   68.841355]  do_exit+0x10c/0x358
[   68.844716]  do_group_exit+0x9c/0xa8
[   68.848441]  get_signal+0x408/0x4d8
[   68.852071]  do_signal+0xa8/0x770
[   68.855526]  do_notify_resume+0x78/0x118
[   68.859605]  el0_svc+0x64/0x68
[   68.862790]  el0t_64_sync_handler+0x20/0x128
[   68.867218]  el0t_64_sync+0x1a8/0x1b0
[   68.872933] init: console-ttyMSM0 main process (589) killed by TERM sign=
al


> > Now I (via ssh) drop into the debugger:
> >
> > echo g > /proc/sysrq-trigger
> >
> > I see the "kgdb" prompt but I can't interact with it because
> > qcom_geni_serial_shutdown() stopped RX.
>
> How about simply amending poll_get_char() so that it enables the
> receiver if it's not already enabled?

Yeah, this would probably work.

-Doug

