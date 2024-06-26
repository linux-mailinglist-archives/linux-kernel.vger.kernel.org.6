Return-Path: <linux-kernel+bounces-230900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10666918393
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67991B272C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339F7184119;
	Wed, 26 Jun 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBkQzVU6"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7831755A;
	Wed, 26 Jun 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410530; cv=none; b=MW73D2K+nQGeTsXQr9ZGY23VJtCTp/fD5vpyn99326dz253hVFrFRAVM4RC/dw0fHBRwMKPDQKlBoGkH0k2sYTOnQnrMseKEnugpkflcFHp6RrVspnmFENHcRbkfdw/8gCUgjqRFBsMXBHlmGPb6CBlj88+u6z4WXhXj7RmbpLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410530; c=relaxed/simple;
	bh=Z35Nb4vXzItDiHKF9HUk9/dMjwDwEL8AOUtpP0W3VFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0ejuvnAJOgWhAao8sc9xrBwmxfqw7wueUol2TGxJP0/i4rVPcAnj9bd3ka4LcN2ff0XxDeRsnxFFWdLSALStFHrdOI/VXUmJUZIX9KT+p/XK6FjLaaLoSrV46Fjzka6Jx4rNlvBqlZpUbfJYJOjguVR0JPT6GR94qjqF/0EB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBkQzVU6; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2598001aae7so3301916fac.2;
        Wed, 26 Jun 2024 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719410528; x=1720015328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlX6ofd4eUvev3IitES3h0rQ2uet+ifDwXi5r0qMYlA=;
        b=ZBkQzVU6G3pf8MZ780XnAl6zg5DwYcJdGNa0UE3qWQGW6TaKypn8JY3isFw8Ycju/i
         DoQrSZfNAJMZUG/EI+jHtITKOExiuuQTN/5oLloCJ+g/avC3/znSaScM5RMjQ6lUIDLv
         G23T+m8hriuNkF3ndi8el1mmdTUznEGiCOdBSbqJ//wDvsYFlXc1BvgnztjwhRNJI6yQ
         tUVwnwfTw7SeHCFDGXQn+hvFU+FjFJ5YdhFMffp1QYurYwCQmZyPdPxGT0/d4PishLVN
         dioLTrduwPxVRAgFG27abitNMzSpzDRfVW57s1H2kOsIomUqsvfysP8WxaVsp2cKNji1
         vqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410528; x=1720015328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlX6ofd4eUvev3IitES3h0rQ2uet+ifDwXi5r0qMYlA=;
        b=QGunWQ0iR5DBIEJGwKIx8uDW2hKEeoQBi+x9fNEkZFtvVOh3PTVrAw6om4pSN/nPup
         dMlG2AFUsA6qxbM7Yt140Bag8EKufGEnOhS+Rns3zDcg8fAb32ARBERxjrbc0LD1lwDj
         tRlCdrog92HHkSK59Ff9aZqWd+MK8O1iq8zEG+fzTk0K3dY/RHd3Y06Dp0NNH8p896vB
         LFuirzo7dNHMsNKwxLiLciPVnzqsJib/77pM74lpvMWPPNqBJ1TcAU68dD1KaRlRMiey
         pSp0vAU3M2fM7zLCQqJmfr0Nc3Ajk9AlEu6lXqCxNU+krmbc4OQ+mFXP+XWti8MadVav
         cJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiqVmwBt7JrlE57WURO3/yilEeHwZNhjbQKwdc+hQxPESe1RVVwe0SeMFNkd69KwIvNfeU0wHW39MXPNhfdCjlcRFXuAzvEvjrDrZet4S+cyDEp0kh58Bl25zSr2HLAgxV/C3GXeY1rA==
X-Gm-Message-State: AOJu0YyIfU8Z3IUiBDnYYLYXwh8xKl5j+xM4Vp3UOhmGZFzeLiRPIeZG
	UaOJSd6hIHzUpJXdR+NSGKwNeAvJtXqMWRmSq7EybMhEUl4wHzgBr/w1Kpi/GVPz5kSCLBjcUVH
	aDH4C5gwbQgDJapUe6SD7K4xzhmCwGBzAwio=
X-Google-Smtp-Source: AGHT+IH1IDVeSLxIl19iRxYfSks6SiF5dVhrO6anINHh6vSqqhiBjcUChgbTG/g2pFbZXYVvnqxQn3g8GL6UuLaG9dk=
X-Received: by 2002:a05:6870:702a:b0:25b:3e23:e5e7 with SMTP id
 586e51a60fabf-25d016724b7mr9830696fac.3.1719410528222; Wed, 26 Jun 2024
 07:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com> <CAL_JsqL-b==HMLJGd_e-43yZHjBFYrrLV5J2a=E2LSEck=ii6w@mail.gmail.com>
In-Reply-To: <CAL_JsqL-b==HMLJGd_e-43yZHjBFYrrLV5J2a=E2LSEck=ii6w@mail.gmail.com>
From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Wed, 26 Jun 2024 22:01:55 +0800
Message-ID: <CALFa7M8bgVX_L30J72SqZ-0vzfezoJLtZHnKjL-dZki0kMJFoQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/17] Revise Facebook Minerva BMC DTS
To: Rob Herring <robh@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, patrick@stwcx.xyz, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jerry.Lin@quantatw.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 9:38=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Jun 26, 2024 at 7:05=E2=80=AFAM Yang Chen <yangchen.openbmc@gmail=
.com> wrote:
> >
> > Revise the Linux device tree entry related to Facebook platform Minerva
> > specific devices connected to the Aspeed AST2600 BMC.
> >
> > Changelog:
> > - v1:
>
> You already sent v1. This is v2.
Hi Rob,

I appreciate your reminder. Should I send another patch series and use v3?

Thanks,
Yang Chen

>
> >   - Modify the properties of spi to match the schema.
> >
> > Yang Chen (17):
> >   ARM: dts: aspeed: minerva: change the address of tmp75
> >   ARM: dts: aspeed: minerva: change aliases for uart
> >   ARM: dts: aspeed: minerva: add eeprom on i2c bus
> >   ARM: dts: aspeed: minerva: change RTC reference
> >   ARM: dts: aspeed: minerva: enable mdio3
> >   ARM: dts: aspeed: minerva: remove unused bus and device
> >   ARM: dts: aspeed: minerva: Define the LEDs node name
> >   ARM: dts: aspeed: minerva: Add adc sensors for fan board
> >   ARM: dts: aspeed: minerva: add linename of two pins
> >   ARM: dts: aspeed: minerva: enable ehci0 for USB
> >   ARM: dts: aspeed: minerva: add tmp75 sensor
> >   ARM: dts: aspeed: minerva: add power monitor xdp710
> >   ARM: dts: aspeed: minerva: revise sgpio line name
> >   ARM: dts: aspeed: minerva: Switch the i2c bus number
> >   ARM: dts: aspeed: minerva: remove unused power device
> >   ARM: dts: aspeed: minerva: add ltc4287 device
> >   ARM: dts: aspeed: minerva: Add spi-gpio
> >
> >  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 516 +++++++++++++-----
> >  1 file changed, 373 insertions(+), 143 deletions(-)
> >
> > --
> > 2.34.1
> >
> >

