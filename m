Return-Path: <linux-kernel+bounces-445615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2A9F184C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0517A0310
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B670194C86;
	Fri, 13 Dec 2024 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipN4AOPT"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2B1DA4E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127370; cv=none; b=ERFuD84mumIzqe70+5WWsvk3q7JWNu7TM0xjey8F9DEWZsogGwsb3wgnOBQvGtL98DnDf7AFsyPI4UNsaTX2KMs8RyC0tFzLV49rbIzScmlvDl4/Otg9sZsckAielIIsCIRVb3wqZpgk/yqda+Fn+dyFwu4Ty2CnZYai+HNdJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127370; c=relaxed/simple;
	bh=3fT6QBQL/2MhJSNZuMQZny8f9lxbnoEvXOfu47IDsj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbOHDrmwnG4W8LSiQYnf8H8JpKQljUgFYyu4yRJF1iTCeZPoCfSf7er2SVcEgLkjisJHNqrDdncv2xD+THC/zLXQ8ZmjFfx+rwmsMJ3hEOis5lRUST5PLGyX+OQSiuwUBKVgOabpeYB4IFyl/a6NjF6y3JGyPBEPST54ahWDERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipN4AOPT; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53df6322ea7so3164560e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734127367; x=1734732167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fT6QBQL/2MhJSNZuMQZny8f9lxbnoEvXOfu47IDsj8=;
        b=ipN4AOPTP4SLVJf4lKBjWC5IhoWXEk5LPJ+Rfh5p98h2vCM9/Iv+hznb0trZiXV26p
         Oa8S+TEtImfLRwnMbRdonKTHkT2SV6SkGydwt4AQTADHWGmsbs7dkujfKmREC+VMbh9M
         Mry7zRcEs4l7zOq+QbtxVpNRErm/O9VXfqxNTduWupB188fxJVEJPRYsbnD5Jh+z+5gf
         IHPgBYlDEtvOKbImjceuKRWmvPDlx4If2o1jDWuBRQd+jgM2EPUpfN9WZY6KUukuhr1E
         HbOZ98GDaW2WOt5WzstofEC/LPfqStbfO9YsTDbo9vGite7QvL7i5kY/T5qfMCQBTKFX
         gtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127367; x=1734732167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fT6QBQL/2MhJSNZuMQZny8f9lxbnoEvXOfu47IDsj8=;
        b=q3e+9eMaXlO1L/LleoR5ErvuBb5/h4zscIjE6DY7bHZp5FBrAI5NAHSaOIvbFX5koy
         ZdS8ZrSj1HMgnLQ3xgAXNO8gK3fsZUpqrY1IT+98xj7oRg02ezpi4p4rujMe1yiJ+pzt
         pXaEZYOh9KCWGqoXC4tZ0fuRVg7noxKuHi4LJwE/VXyc67G/uKl6J/s1QKv0D5dGHQ+E
         UYHOSFE53kUCWmximPNRBZOEqGPWbSaNUGd/RsBIOKPVOQSlpEZcOmdi3FPaqIWFbAAC
         2dvTJAMrGE4+GuWmVkCoDKYTvnnM/yvSjylwxMOhwk4Q2uIr2UsWCcOlazrwJxZQmSh4
         U92Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv07ycYEBkt6diDoZDMM2eNKjKjn0bByUX0I0ciBBirLELWZ3mLvyBjDrLkcqSJwMXJcs0BRtXNzSCevk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWOPohbvv2GGqsF+i2L/7t9WTByt0STIdqNLoY8meQ61IStu+
	LZ/jYRqJSGQ6mWU+1eX44eNDVz8eh7WjpOEiPeSYUHb/f+XDww8qOChnZb12SMo7SD0muPG9p6u
	tFebIYa573cWewPHyemIxRNEGl0IlDtBSCIx/r7qwDSvX8/aQXw==
X-Gm-Gg: ASbGnct+Zh6wV8srWxqa0q0u5uEMTDwMmcl6LtNPoKxvf9yqCYFn8DIia33Ih8w9qDL
	7rT0pZtDP63WZ6tnz1lxBDUEnKO6Eh0RkMDUth+/EfD+NEPrkIy0r2NzM1C/imJxK
X-Google-Smtp-Source: AGHT+IEdvX8UCDRHwMsM6tElC5pzCUR6NnPXZ6/2dYHPyLngGaSRf0A3HFQ57okaG6m08xez14kCUm816z6DCZuXJI0=
X-Received: by 2002:a05:6512:2815:b0:53e:3740:4a92 with SMTP id
 2adb3069b0e04-5409059572bmr1481442e87.42.1734127366767; Fri, 13 Dec 2024
 14:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFERDQ2hLHek+0ViVqbqgOD+4xwC2ZwK1KhgGdLP_zGnonEs4w@mail.gmail.com>
 <d02a7143-43e7-4851-a06e-d57981362a5a@gmx.net> <CAFERDQ0AUhCp_c0LLRRR9SWyvDON-CdXFvK3eqcLFc_SMhdPRw@mail.gmail.com>
In-Reply-To: <CAFERDQ0AUhCp_c0LLRRR9SWyvDON-CdXFvK3eqcLFc_SMhdPRw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 13 Dec 2024 14:02:10 -0800
X-Gm-Features: AbW1kvaRZEbg79r0iuOt3DfYvyY31TNdR3EOMiJgmzNfAPz6oPlmMYNe9esc_zM
Message-ID: <CAGETcx-NWnBDfVq7hwrS7dQDdbEeBaVOuS=YzAfTyS6e6xCUCQ@mail.gmail.com>
Subject: Re: Raspberry Pi 3B: Failed to create device link with soc:firmware:gpio
To: Martin Wetterwald <martin@wetterwald.eu>
Cc: Stefan Wahren <wahrenst@gmx.net>, f.fainelli@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:13=E2=80=AFAM Martin Wetterwald <martin@wetterwa=
ld.eu> wrote:
>
> On Thu, Dec 12, 2024 at 2:16=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> =
wrote:
> > What happens if you replace your custom config with arm64/defconfig?
> > Does the issue still occurs?
>
> I've just launched a kernel with the arm64 defconfig:
>
> > 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq =3D 99, base_baud =3D =
0) is a PL011 rev2
> > serial serial0: tty port ttyAMA0 registered
> > raspberrypi-firmware soc:firmware: Attached to firmware from 2024-09-13=
T16:00:01
> > hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
> > hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
> > Bluetooth: hci0: BCM: chip id 94
> > Bluetooth: hci0: BCM: features 0x2e
> > Bluetooth: hci0: BCM43430A1
> > Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000
>
> And it worked perfectly. Thanks for your suggestion. It confirmed the pro=
blem
> came from my kernel config.
>
> I then compared both .config and it appeared I was missing this config fl=
ag:
>
> > CONFIG_SERIAL_DEV_CTRL_TTYPORT
>
> I had already enabled CONFIG_SERIAL_DEV_BUS, but not CTRL_TTYPORT.
> Nevertheless, that first kernel config item's prompt had been clear about=
 that,
> but I missed the advice:
>
> > CONFIG_SERIAL_DEV_BUS
> > Core support for devices connected via a serial port.
> > Note that you typically also want to enable TTY port controller support=
.
>
> It's so much better now to see the HCI attachment handled by the kernel
> directly!

Glad this got sorted out without my help :) Thanks Stefan!


-Saravana

