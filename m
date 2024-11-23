Return-Path: <linux-kernel+bounces-419249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAE49D6B56
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3195CB21F85
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083319D089;
	Sat, 23 Nov 2024 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T4xWhJVP"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E388189BB1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391959; cv=none; b=qybJlIzTc0Yv6icQt9WYrdi+r2m29hhNoMTL+KHXdDwnQFROQFBdGfoWGDHN7tLLbFUXoF07OSyjzAAd5+rf1h1S2zpoJBWhaQEhiikTEiwgUmsFh6uH/d3GakAIyy/0kYBJGRE6xrazJxtxzyccmkYe12isupXDSEz9hYJoz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391959; c=relaxed/simple;
	bh=8CucEUoNecnqvhnAxT5844BmQVbacetJVEcL4eYgvK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxX1lHgPdtPIaxO4InoljhQ6WzzfDz+JoSIAUB8+GpuNS6nH39tJ+T3rX06DD1mJlEbk60VOprJdVnROVw74A+0HsQWua53OL9RucKeWY1/zUovxWXIm7I4gXowKd4mkMUKPNWBbZoAQk74YLeHBrzBQqm2M77NGacaK783UrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T4xWhJVP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so3620368a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732391956; x=1732996756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+x49yiLDnlEyhDxfPojqAvkBhVqkfLTRm15XVTAYEWg=;
        b=T4xWhJVPKgD9NScHclXZ115jzbRxMWH30yCg5G/Fyi+ZPkaSl2Vy7iutOOOnKfOhhO
         KdVl3wTrescDeMTT1jEvBLSVFfWz0NAM9IApofAPkanFPDZ7w8L0ZM7IeWGaCNp7gfiF
         1qhIlbQBUz20R0mqvZ7nfuOJ+D1YY+z1XSegE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732391956; x=1732996756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+x49yiLDnlEyhDxfPojqAvkBhVqkfLTRm15XVTAYEWg=;
        b=Gwn/MzD39XumJMfmQxsHAwYIt+28C2ePcv8PVW19FRb+iQOr+9nGDo8dvCUP5LQDkU
         tODX4B3RXOyg5B3v+ulF5CAGLkoVOE5RXMSOB8PxykVcTQ77ff99j2wg5YLz5+9k7mM3
         oHhbjjREtYUq0zgXXiGeze7GDNbEKWnKMaNYC9Bo94/oaph/Bu10utSxYvVVU8cq3iW+
         d0ojdx1toVtqCaM66JMyLoitv447dbPLwC/uzwGx8KWQnLJRb8WcSsio7RCMGP0HLyOn
         k1rUqKlvzlFqif8miE0dZHwnMNQsGBSK8g4mvDFH9FJZoaaZ0Tv70EOPl++qZbn+kQL5
         7yog==
X-Forwarded-Encrypted: i=1; AJvYcCU1pT5cCt3CqMV/JSidqUrfrPKT72EOZk6FxfSrST/SIXePrsvfdpvqjdh9L1h5SBYC/z3N3dUVOecaanY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu6/VLBB9DA57VzZXNCgGortOPA6AwpLi8x2TV5GufR/ZAl7n8
	LecLgiEg+oX1tUq0Oebejuw5qFqyQRQEFrUG8oOQqVOVO+Ks+DeSFwzHtC4vNId2Gji69J+ckdu
	5MKNsWg==
X-Gm-Gg: ASbGnctzSJadfMPzVGJlq/uYcDFzqYM1Z8b/Y8ZHDID8jq1CgXPolCOxwBKHDYCJT+C
	Dl3Otnr/ReWntbAojlNIrkC8ZExQgoXg6wqZdC0Xvyv6rKWNS63HYRGzMjwqrEsvO6IHbQIzSsj
	2PByWDzQBZAm+On6xMN9HmR+FPHC1mRu//ZIIVCucJLLB1vv7M5eJeaojAJAP7QB2gwuNY8dS6j
	8ruObxoofR33ue8TbV1ZI8X7FxB66CZA74FqpMm8oRSEGyrl9KOunc5MRHYdgDDM8/2ePKuLYOj
	HWZROCDtauUV9/MB2yTakx4r
X-Google-Smtp-Source: AGHT+IFU7qaWFVS4Tc1IqasptVxHDYRYCbEsSJFbIr+Fwag785XizPLzOheNwKT7I7vFvaoNGtFJwQ==
X-Received: by 2002:a05:6402:274e:b0:5cf:f453:4b97 with SMTP id 4fb4d7f45d1cf-5d020792da0mr5604398a12.24.1732391955671;
        Sat, 23 Nov 2024 11:59:15 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d02062428fsm2224165a12.40.2024.11.23.11.59.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 11:59:14 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so3620356a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:59:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC1J9YJbK4JtxV7gxUGIk7i/XY2a3pm0RbDRP7TeWNUcYJ1keQb+8Ctm1juRB59n0lcikkDnM9p+baQaM=@vger.kernel.org
X-Received: by 2002:a17:906:310b:b0:aa5:274b:60e6 with SMTP id
 a640c23a62f3a-aa5274b698cmr342028066b.46.1732391953496; Sat, 23 Nov 2024
 11:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
 <ziofbee4q5cvxvovpzb2rfjw2cduefpm4umwtfyyx5kfwajjp4@nrjwkqryz2j5>
 <CAHk-=wj2XYoq5Rp-An0SMRiA0x7mzGWgt1RyqQYpm1DtX0XwJQ@mail.gmail.com> <2eh3ep6ft5kekc6u6hj3m5qflk5bypbfatpwo6oiptnpspaa6j@wqapte332xgy>
In-Reply-To: <2eh3ep6ft5kekc6u6hj3m5qflk5bypbfatpwo6oiptnpspaa6j@wqapte332xgy>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 11:58:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=BKLd9FQiqxh8Sirvu96qkDojY+P1Ukrz2EdBXTN5dA@mail.gmail.com>
Message-ID: <CAHk-=wg=BKLd9FQiqxh8Sirvu96qkDojY+P1Ukrz2EdBXTN5dA@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.13
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 11:05, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> What would be interesting to know is if the line
>
> logitech-hidpp-device 0003:046D:4090.001A: HID++ 4.5 device connected.
>
> ever happens on a fresh reboot (before the unplus/replug).

It does happen, at boot too, although it happens a bit later:

  [    4.905196] input: Logitech USB Receiver Mouse as /devices/...
  [    4.905276] input: Logitech USB Receiver Consumer Control as /devices/...
  [    4.956062] input: Logitech USB Receiver System Control as /devices/...
  ...
  [    5.265096] input: Logitech MX Anywhere 3 Mouse as /devices/..
  ...
  [   24.330052] logitech-hidpp-device 0003:046D:4090.000E: HID++ 4.5
device connected.

while at unplug/replug it happens immediately.

The bootup delay isn't because this is a horribly slow machine, it's
probably me typing in the encrypted disk password etc, so there's at
least 10s due to that, but there's probably other boot time stuff
going on too.

In the systemd logs, that HID++ comes within a second after

    systemd[1]: Reached target graphical.target - Graphical Interface.

so I suspect it has something to do with X (or Wayland, I guess)
opening the mouse device?

> Anyway, this confirms my theory that the mouse wheel is set to high
> resolution mode by the previous boot and that the next one (using
> hid-generic) is actually not handling properly: I bet that if you scroll
> long enough in the same direction (can't remember exactly the actual
> multiplier) you'll eventually get one scroll event. Not convenient I
> agree :)

Yeah, that doesn't sound like a great user experience, but might match
what I see. I just didn't scroll enough.

> The problem seems to be that hid-generic is not letting
> hid-logitech-hidpp taking over (or that the driver is not properly
> loaded at boot time once the disk is ready). I have some suspicions on
> some core changes I made in hid-core for handling a new quirk, but I
> should be able to reproduce next week with all of that information.

Thanks,

             Linus

