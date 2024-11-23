Return-Path: <linux-kernel+bounces-419187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BBE9D6A80
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D406B16197E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8E7CF16;
	Sat, 23 Nov 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PK06vol8"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1717578
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382277; cv=none; b=rGjRmOn3egDZN0UEMLz0frN1JVrMtEbHmcthlW2kIN1kJpHOR0HphO6afs6tNHPVDI/bsTe416QGNRveawtm06ah8kqfdOG2/lKiqZkSFzIy5ajmrad4W+AXTGQYOeaZIaaLxZZsE2lHHWUXoaO3a9Ho1JEPw55ehuXUW/HnPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382277; c=relaxed/simple;
	bh=N/c2G4T+3luo3gfO0/Cnn5uaOPk6LCqz/xHBnqKCtRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSihsc+jM7YqyG0WA2MiO+LBhYVGeYh2LWOjD1QtshsEaerx1SrTHW75jklHnm3RTVCrmp2RAXDmbf1PGl9TYz/AOdqU3TvXkQybH1zb16177Mp7OtM9/oOQhflJqJV/NcEb1qDz/ZTOaM1NJ42WaNuHmBZZL1Vm+mRCGR3M6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PK06vol8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a68480164so440944466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732382273; x=1732987073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YsYYdoht4nVDWT1U34pWzA3/O43nanfgBhW3M7KZMvQ=;
        b=PK06vol82KSVf8mW7WwXmdt+HFqrPWbJhS45GVZZbLOc1lCoD0fSMldtjdlHJDGhUR
         wXYQ/IzCGU4qsSAr0oO2JOzneHA2NJSDMcWltHWnbn6PWUQZZfPKdqnqo8PtwY9bflHJ
         ZyS5uhufmUq9N0FqtU9l21MT5EF3dVn+I1cbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382273; x=1732987073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsYYdoht4nVDWT1U34pWzA3/O43nanfgBhW3M7KZMvQ=;
        b=Yvna4YTWBCHXU3Y6aTP6qE/16GNa01DyYhe23Edu+BCIw/cUq30tYf3jEA7f2BJGt9
         +1SPJAVhXJc2JgfeJaGtho8TzWAwK4itWDgEN8O7ZacjTnVdMaetHqCzEvqiOgELokaJ
         LMioeASJGiVU3ExwpbfFjzE0HW8mM4x5IVVZaar3idQu4q6rBwA6iW4fjtVgv9X9W2Cc
         avjXgnXJl7/a21KdcqVj6hUK92twf7IO/3YsBfSI6cS6jZYneSpQU+ucOY6KdrQMMiMq
         a5ydVAFh1EQ85J8fKlyvW/aPgcOAiEnpvSBSO6P1qAF/PMyn0wfCGLONFbQiTZaJh3GY
         MqGA==
X-Forwarded-Encrypted: i=1; AJvYcCWbnqQCppeECYelZQiuU5iyn09ZTHorQnbqtdNp3DV/9Dg0zZ9cbFpDGxU5JVabgRgVbvY8aQnKVFWBSSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Wx78tYpsNYCz/QcfvE9rDHNDMcStEMfZTrHIu4wzaqrSz8jK
	W+bgaPPinGiGheJdHfIzth7LAgH+jByNRm8aav23SAZqHqcYDSR9/pzjnPpbM/Yr8PW3IyPVG7R
	X+pS+Rw==
X-Gm-Gg: ASbGncuu0kFzsCjH+HyC8GmBfZr2/gc7PbDu3IyFQ7dZPFhtVAxkxjzp5+j71bVCLCV
	+A/w55C1uSTtnbBVf5pGyFEn2hWX1VeguvINKO2v8PAyob/XEKMrqc/akSY9rRFaQbEvi7yHX22
	sMiJE+lTsGDR3IbNmiGkDg7SFjbehrYFyU5TwHqLY5Z80zBPptOqEqKqh3G63TnyCHlycP3MAE4
	n64TVYv16R4SVlT8fJV4NcHRnBJKZ9hwWka0ktLVbQvjNLA5BEANo7bfGjlKaVIqNxPZY/hZ6rQ
	H62cRnJYSqLg/Y4x4DDmFS1q
X-Google-Smtp-Source: AGHT+IEMk2TS8PWIkfG1pM4Hcw1TfkxTKN7q/O9ojvsev8HFH4bVo+mexGGZRRwa6YQZbprHAyeErQ==
X-Received: by 2002:a17:906:1baa:b0:aa5:308c:3489 with SMTP id a640c23a62f3a-aa5308c351cmr277386366b.58.1732382273079;
        Sat, 23 Nov 2024 09:17:53 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa53afa8eb8sm63328066b.197.2024.11.23.09.17.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:17:52 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa4833e9c44so360344766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:17:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz3WpPs8nkXcDPf79+a995AiV945R5zLEgohYNEqlocuERd0jaTpMKKZWmLIpYVTYlrTSZ7PjCZTiF9H4=@vger.kernel.org
X-Received: by 2002:a17:906:9ca:b0:aa5:35cc:f838 with SMTP id
 a640c23a62f3a-aa535ccfb35mr206712766b.36.1732382271382; Sat, 23 Nov 2024
 09:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com> <ziofbee4q5cvxvovpzb2rfjw2cduefpm4umwtfyyx5kfwajjp4@nrjwkqryz2j5>
In-Reply-To: <ziofbee4q5cvxvovpzb2rfjw2cduefpm4umwtfyyx5kfwajjp4@nrjwkqryz2j5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 09:17:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2XYoq5Rp-An0SMRiA0x7mzGWgt1RyqQYpm1DtX0XwJQ@mail.gmail.com>
Message-ID: <CAHk-=wj2XYoq5Rp-An0SMRiA0x7mzGWgt1RyqQYpm1DtX0XwJQ@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.13
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 08:42, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> IMO the suspect might be 526748b925185e95f1415900ee13c2469d4b64cc.

I'll try reverting it when I have more time (which is probably end of
next week.. merge window).

> In addition to Jiri's requests, could you also post the dmesg after the
> fresh (and broken) reboot, and after unplug/replug the dongle? We would
> get more information on to which kernel modules are involved this way.

All I get for a unplug/replug is

  usb 5-4.2.2: USB disconnect, device number 10
  usb 5-4.2.2: new full-speed USB device number 11 using xhci_hcd
  usb 5-4.2.2: New USB device found, idVendor=046d, idProduct=c52b,
bcdDevice=24.11
  usb 5-4.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
  usb 5-4.2.2: Product: USB Receiver
  usb 5-4.2.2: Manufacturer: Logitech

and then

  logitech-djreceiver 0003:046D:C52B.0019: hiddev100,hidraw9: USB HID
v1.11 Device [Logitech USB Receiver] on usb-0000:46:00.1-4.2.2/input2
  input: Logitech MX Anywhere 3 as
/devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:08.0/0000:46:00.1/usb5/5-4/5-4.2/5-4.2.2/5-4.2.2:1.2/0003:046D:C52B.0019/0003:046D:4090.001A/input/input36
  logitech-hidpp-device 0003:046D:4090.001A: input,hidraw10: USB HID
v1.11 Mouse [Logitech MX Anywhere 3] on
usb-0000:46:00.1-4.2.2/input2:1
  logitech-hidpp-device 0003:046D:4090.001A: HID++ 4.5 device connected.

but doing some grepping, at bootup time I also see a line line

  hid-generic 0003:046D:4090.000E: input,hidraw10: USB HID v1.11 Mouse
[Logitech Wireless Device PID:4090] on usb-0000:46:00.1-4.2.2/input2:1

which does not happen at replug. There's a few other boot-time
messages that seem to be about module init stuff too, ie

  input: Logitech USB Receiver as /devices/...
  input: Logitech USB Receiver Mouse as /devices/...
  input: Logitech USB Receiver Consumer Control as /devices/...
  input: Logitech USB Receiver System Control as /devices/...
  input: Logitech Wireless Device PID:4090 Mouse as /devices/...

and that only happens once and then never again. Some module loading
thing? I have

  CONFIG_HID=y
  CONFIG_HID_BATTERY_STRENGTH=y
  CONFIG_HIDRAW=y
  CONFIG_HID_GENERIC=y

but then the Logitech part is modules:

  CONFIG_HID_LOGITECH=m
  CONFIG_HID_LOGITECH_DJ=m
  CONFIG_HID_LOGITECH_HIDPP=m

which I think is all normal (ie I have my own local config, but that
part matches the default distro kernel config)

             Linus

