Return-Path: <linux-kernel+bounces-376593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76EF9AB393
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F2D282199
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BC1A7066;
	Tue, 22 Oct 2024 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JagwZroB"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A91A3038
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613574; cv=none; b=EXxLmthTkCUhigo7ilmUsGMVoJBjJNMtzIibNDlYYwPfqODU5Zc3uGkrWOw4HgOmdQQRedmaTYDrCnc0LWTxo9n71ONrF/gybVZ8fgBQsza082tkUCRL68+sDfAFa+pK2GC48ufmr/2cypnYJghuh/V5IFniDg0sCdXUYS0o1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613574; c=relaxed/simple;
	bh=os2vWw3As1ltpU8K161/JxD1EUb+eBNxacNzN4bKumY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRXZKYDBGd6QLEPktM8Omt4oZylKC/qntV2X27HNrP8/XaoxyGO451cgf+vNhvEsp2jtxrO/xu6hNgia2xUZh1F4wEcuBHc3SKkfWFon+Kf6Iq+VBsn+qZKdhHhMQPfwnBI7FUL0QlOh6FnVV10HNMn/K6bb36mkYva3qYEmRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JagwZroB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53a007743e7so7112502e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729613570; x=1730218370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9CFjc08LcWL0/ABOGF1hFYw5yTeZPCjsc8aV5Qz52Y=;
        b=JagwZroBsdmMseKkuO0UIOUhA2lm9FqbGXEIyaq4Jd5o9oM0MED2+o1Y1YHXFt2Ok8
         kVTNDnoSRELz1j6t5GtE8heiETsVITB6N+2WpJBzrQ8IpmG/ulSxYwZeQwy6zCXGQls+
         GIqcTkMGKXGeNRtxMac7u9DKRrkuBx6B06D88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613570; x=1730218370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9CFjc08LcWL0/ABOGF1hFYw5yTeZPCjsc8aV5Qz52Y=;
        b=TkRfXrS6diEhHlroa671Ocna1u7G1n1boRP1PzTjKdAQ8hcfXg+Y9XOQZ9Au0KgrfS
         pP57ESqF9E1AcVy4/+t4BLdob7jAG67qDfW8r0JbVKhbJb66WRQZYXojKmyYKNXkulM/
         PhTXMLwAhSquK6ytmHD6srJj3gKx0bIg/Ia3h3tC8Ypm4vUgURmc/ENEs9qOSBQrAcH8
         bqCu9KQeRB4ywHEteCGy8Tc+M3l9Ue7cE3HCMlcJmyvFIPZul7t+cXwBIFnVY6BYIvC5
         bwoeIrFxRvvkcPK7edI5UhQwIrPwEPOGmnDSMKro8b7HLkRTnmOzdL/q9pAU+D4b3iw2
         S6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW+BLVT1mfmLOOBrTj0xJu52C8LqtYOLMOJ7AUfIf6H9zxHIBlnXqg4HWvvpgX+B6c+kVXUrGqO3QrQkbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Bxq1jPenPjDm+y56y0Gk7CDDaWQBuVLKd2/NAY/CWXQiRVUz
	U8+rCxkn6vVMNjAMzk3GXkgL8E6SbnbflcoXJ9MXGxSw/edehW8TmfC3nBb7tJbo/jpywcnXLjV
	y9aYo
X-Google-Smtp-Source: AGHT+IHFAoAVuQAYseq6Fm0lGRWH1vTuPooEwXtZsCHuxJOXAJKZIygRutnHM3kwkmLnFSzB7hM8lA==
X-Received: by 2002:a05:6512:10d3:b0:539:ec87:bc7f with SMTP id 2adb3069b0e04-53b139e2ec5mr1733332e87.19.1729613569680;
        Tue, 22 Oct 2024 09:12:49 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22440476sm812207e87.290.2024.10.22.09.12.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 09:12:48 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e13375d3so6455231e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKYJ4k0D75KwtpL1Apl77vIKLcQZyC1IG2oamI7XrWLrkSR7R18oBtp3WhPI9qQJ25WRVzsED5WqUOP+A=@vger.kernel.org
X-Received: by 2002:a05:6512:691:b0:52e:faf0:40c with SMTP id
 2adb3069b0e04-53b139dc446mr1945625e87.3.1729613567969; Tue, 22 Oct 2024
 09:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018020815.3098263-2-charles.goodix@gmail.com>
 <CAD=FV=UFrk4QCxWzV9zUZnjhwiFf22Fji5KH83svdwba2mPVBA@mail.gmail.com>
 <ZxMfu4yxk961mZWB@ux-UP-WHL01> <fbde8a3a-3adc-4c1a-8529-fde0fa149c8e@kernel.org>
 <CAD=FV=VphXewyk_mpGHUZKw8_aK8HnH8T-YumwM70eyz22S+Aw@mail.gmail.com> <ZxdRaaCR7eTOCQkB@ux-UP-WHL01>
In-Reply-To: <ZxdRaaCR7eTOCQkB@ux-UP-WHL01>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Oct 2024 09:12:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFonOVHUP5_9+BfJp71CFX7KKA1Gx=boN0=3_4cCKnZw@mail.gmail.com>
Message-ID: <CAD=FV=UFonOVHUP5_9+BfJp71CFX7KKA1Gx=boN0=3_4cCKnZw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: Goodix SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: krzk@kernel.org, dmitry.torokhov@gmail.com, hbarnor@chromium.org, 
	conor.dooley@microchip.com, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 22, 2024 at 12:19=E2=80=AFAM Charles Wang <charles.goodix@gmail=
.com> wrote:
>
> Hi Doug,
>
> On Mon, Oct 21, 2024 at 08:37:32AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Oct 21, 2024 at 2:43=E2=80=AFAM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> > >
> > > On 19/10/2024 04:55, Charles Wang wrote:
> > > > Hi Doug
> > > >
> > > > On Fri, Oct 18, 2024 at 01:48:56PM -0700, Doug Anderson wrote:
> > > >>
> > > >> On Thu, Oct 17, 2024 at 7:09=E2=80=AFPM Charles Wang <charles.good=
ix@gmail.com> wrote:
> > > >>>
> > > >>> The Goodix GT7986U touch controller report touch data according t=
o the
> > > >>> HID protocol through the SPI bus. However, it is incompatible wit=
h
> > > >>> Microsoft's HID-over-SPI protocol.
> > > >>>
> > > >>> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> > > >>> ---
> > > >>>  .../bindings/input/goodix,gt7375p.yaml        | 68 +++++++++++++=
+++---
> > > >>>  1 file changed, 58 insertions(+), 10 deletions(-)
> > > >>
> > > >> I'm happy to let device tree folks make the call here, but IMO it
> > > >> would be much cleaner to just consider the I2C-connected GT7986U a=
nd
> > > >> the SPI-connected GT7986U to be different things and just use a
> > >
> > > Same device, you cannot have different compatibles. The way how the s=
ame
> > > (literally same chip) device sits on the bus is not part of the bindi=
ng,
> > > thus no different compatibles.
> >
> > I don't want to belabour the point too much, but this doesn't feel
> > completely black and white here.
> >
> > "Same chip": a whole lot of laptops and phones all use the "same chip"
> > (same SoC) yet are different products. ...or you can look at the fact
> > that many peripherals have the same STM32 or Nuvoton chip in them but
> > are wildly different peripherals.
> >
> > In this case, Goodix may have made an ASIC called "GT7986U" that has
> > some type of CPU on it that can run firmware that can talk as an I2C
> > device or a SPI device. This ASIC may be intended to be used as a
> > touchscreen controller, but fundamentally it doesn't feel that
> > different from an STM32. You can build different boards designs with
> > the "GT7986U" on it and those boards are intended to run different
> > firmware.
> >
> > People manufacturing touch controller boards presumably put this
> > "GT7986U" on their touch controller board, maybe set certain
> > strappings telling it that it's talking over SPI or I2C or maybe just
> > decide which pins they're going to wire out to the board-to-board
> > connector on the touch controller board. A touch controller board
> > intended to talk over SPI may look 98% the same as a touch controller
> > board intended to talk over I2C, but what percentage of "sameness"
> > means that we need the same compatible string?
> >
> > Would things be different if Goodix decided to manufacture touch
> > controller boards themselves and sold two SKUs: a GT7986U-S and a
> > GT7986U-I?
> >
> > I would also note that (reading back in previous conversations) I
> > think Charles said that they run different firmware on the SPI vs. I2C
> > touch controllers. As I understand it, the firmware running on a
> > device can make it a different device from a device tree perspective.
> > The device tree does its best to describe just the hardware but it can
> > get fuzzy. For instance the "VID/PID" of a USB device is usually
> > something programmable and could be updateable by a firmware change
> > but we still may need to encode the VID/PID of the firmware that is
> > intended to run on the device in the device tree.
> >
> > Anyway, I'm happy to be quiet about this and fine if folks want to
> > continue to work towards a "unified" binding. It makes me a little
> > uncomfortable that I'll still end up listed as a "maintainer" of the
> > unified binding because I don't totally agree with it, but I'm also
> > pragmatic and I'd rather have something that can land.
> >
>
> Thank you very much for your attention. Your understanding of the GT7986U
> SPI and I2C devices is correct. There is no fundamental difference betwee=
n
> them and the STM32, as they are all ASIC devices. The functionality of th=
e
> device is determined by the firmware that is loaded, although the GT7986U
> is an ASIC specifically designed for touchscreens.
>
> Additionally, the firmware and devices are generally bound to specific to=
uch
> panels, meaning that firmware intended for SPI will not function properly=
 on
> an I2C touch panel.

Just to get clarity: how is GT7986U delivered? For instance:

1. Maybe Goodix produces touchscreen controller boards and ships them
to customers for use in their products. In this case, does Goodix ship
a single board with two connectors, or a separate board for SPI vs.
I2C? I would have to believe that maybe a "dev" board might have both
connectors and a bunch of jumpers/switches to choose which ones to
use, but it feels unlikely someone would ship that in any quantity.

2. Maybe Goodix provides schematics for customers to produce their own
touchscreen controller boards and they tell customers to either hook
up the SPI lines and load the SPI firmware or hook up the I2C lines
and load the I2C firmware. In this case the assumption is that
customers using the same communication method are following the
schematics closely enough that they all behave the same and thus we
don't need some extra distinction.

In either case it seems like a touchscreen controller board that talks
over SPI and one that talks over I2C are two different products and
thus (to me) should have two distinct compatible strings. This is not
one device that merely has multiple interfaces.


-Doug

