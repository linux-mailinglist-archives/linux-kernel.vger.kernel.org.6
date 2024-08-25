Return-Path: <linux-kernel+bounces-300379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1C295E2FF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1E91C20B40
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD913DBBB;
	Sun, 25 Aug 2024 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZstqMLn7"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948822F34;
	Sun, 25 Aug 2024 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724583391; cv=none; b=hDJQ8ovQFiMHgYCIIYTHkvxrklftlMOl7WG06wKGThQXAc/Op+2Y4tBKknpO+Ud5ZgnX7bapOq+Y/SGdknW9K+NTPtq7gZ2lM1KmBMSbqBI2j2kKE2PYBYyzsgV7vy5y1q0JCGCH/kBQywU0UJ6BYjg/tdd3FbCqM1dCkqDZZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724583391; c=relaxed/simple;
	bh=i74JpuVQK8Iqd0MNXy9tvmYAcpImYRXZ/1aXJCvj2QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkwtfyNY6LSOxPUetrR9Y5GGRyJrsG9s71wP1iiKeXOCNb8X3ZMixq15lCPbQTT5ykFonktCxzWxThGeTKRr861PHlO1WtoPJdKK+WuWzjy9Z/IXrwWGELafUFRATljTlPhXsfDqY9rwhXS68NTHlsawzD4cpzoxOQUpr9PxxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZstqMLn7; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7cd9e634ea9so1909246a12.0;
        Sun, 25 Aug 2024 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1724583389; x=1725188189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwMvtDRif7+FlWTgSF1tQDTNDkFXHUY4zKJQhL09Nao=;
        b=ZstqMLn7hcba8dwOCdafws4GpEx1a1oWoekwCkxoCBndlU0MgkIwbCtX6i3uNis/ou
         F+NOaoHJBxZV2nfmsO2M/MWkvpbcOkML0zI9dnPnesNFy+O7J+dqr2mjZr0xd546+/uW
         Y4hwBMA911Hq5rtDdXYnQ5Z5jjOGYVlZLREDgrp97ojEOr+P65GjXbN76vcGqmRpTKPL
         BxVZdeoLk1LTS6dc7UFmrkpWdkX+Hfgm4VKzNVKlV6OOJ28Nx4v7uvhU3kwXlK/clxiz
         kty1yqDk1QFrdNZinzfTwZ83AXcKbfC/0kuYv6IsErNg6Pi+y+6hgXeNCrSgbzXfcaQO
         YG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724583389; x=1725188189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwMvtDRif7+FlWTgSF1tQDTNDkFXHUY4zKJQhL09Nao=;
        b=uX+Fz9/8jKLQiKwgOKXAlFSUE9ru+dKkUdYHexvosKXTktwiIcSg1TxeMMey6q+7hT
         CIlGVaoD6oAOVQw4dmaUEswIpjYJ5cI68CTOx92F2aLt6+Os+4ZgyIizKwqM+1XpuxeB
         +8WfuYGjpKm9Hy4YnU5+Hd7V1yjuXBujanp28r05/G0R9mMbC4y1b1SHQdAt8HhDEQVD
         pSyYe7ir88asSxQvOr3UZo6Rh/hvxc8U8KfmpUB9nmv/KbHxHsovpiMqYYoQSzkxx0RG
         UO/W1gwogVcQStg77UZKNlgKGunNIreVupCPPL1Z2pfKQLAuuSR6siCb/lJ1dzoA4Xqd
         37PA==
X-Forwarded-Encrypted: i=1; AJvYcCUAK0kqHzkTB00Rt6kquAh/QZgDiJBnZOV6lnq7FbfdkdWHzQpnGAji8bJX+zNoVZrWgae7Z5RmEsr+JAw=@vger.kernel.org, AJvYcCX5HLhS9Vcpx6HrfceihdsB1WnSMV6uL3BGQTta8JSw7dHce9g64Nw6O5pZ9BdQTViA25nk24Uq/l9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwODmZget/WGUQ2hMO27Ntt7oUIs6Grh95WnTJLz60Vsr16PVcV
	5WN3m9Yi4PmnYs9jIt0Ew1ve+H/rdbqgp7cOmHsEIkJa0SvO/RO2C0IHGHnB/Se7QRODKu1gdBJ
	K42ICmBg4aFBx0uDW+f6rsR86I6MIRg3x
X-Google-Smtp-Source: AGHT+IHogx7Y36QzQh4fI03VeOZwLYAvmzqBTuk5y4LhKB4ZJDgYV6PWFMSMcQ0dxklAxU4PXRinT8lWZlNH5Zz9xEo=
X-Received: by 2002:a17:903:186:b0:202:2e81:27a3 with SMTP id
 d9443c01a7336-2039e4d9fcfmr65711665ad.29.1724583388669; Sun, 25 Aug 2024
 03:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507131522.3546113-1-clabbe@baylibre.com> <20240507131522.3546113-2-clabbe@baylibre.com>
 <Zp5q5V_OnLAdvBrU@hovoldconsulting.com> <CAFBinCC9ftXxkyoiY=3ia6UubTeG-cHXa40ddd7WMNUhvVjr+g@mail.gmail.com>
 <Zp_WiocH4D14mEA7@hovoldconsulting.com>
In-Reply-To: <Zp_WiocH4D14mEA7@hovoldconsulting.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 25 Aug 2024 12:56:17 +0200
Message-ID: <CAFBinCATe+RXHz6Cy9cbo=vYL+qm_kz1qDTB8oL775xdgk=TYg@mail.gmail.com>
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
To: Johan Hovold <johan@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, Jul 23, 2024 at 6:13=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
[...]
> > > Do you need to include any copyrights from the vendor driver? It look=
s
> > > like at least some of the code below was copied from somewhere (but
> > > perhaps not that much).
>
> > If you - or someone else - have any advice on this I'd be happy to go w=
ith that!
>
> If you copy code directly (even if you clean it up after) you should
> include it, but not necessarily if you just use it for reference for the
> protocol.
>
> It doesn't hurt mentioning anyway when you add the reference to the
> vendor driver, for example:
>
>         Based on the XXX driver:
>
>                 https://...
>
>         Copyright YYY
Thanks, I'll include that in the next version.

[...]
> > For slow speeds I never receive the "Transmitter holding register
> > empty" interrupt/signal when using the full TX buffer.
> > It's not that the interrupt/signal is late - it just never arrives.
> > I don't know why that is (whether the firmware tries to keep things
> > "fair" for other ports, ...) though.
>
> Perhaps you can run some isolated experiments if you haven't already.
> Submitting just a single URB with say 128, 512 or 1024 bytes of data and
> see when/if you ever receive a transmitter holding empty interrupt.
>
> How does the vendor driver handle this? Does it really wait for the THRE
> interrupt before submitting more data?
The vendor driver:
- first acquires a per-device (not per port) write_lock [0]
- then waits for the (per-device, not per port) write buffer to be empty [1=
]
- and only then submits more data to be transmitted [2]

> You could try increasing the buffer size to 2k and see how much is
> received on the other end if you submit one URB (e.g. does the hardware
> just drop the last 1k of data when the device fifo is full).
I have not tried this yet but if still relevant (after the info about
the THRE interrupt) then I can try it and share the results.

[...]
> > > > +             * If we ingest more data then usb_serial_generic_writ=
e() will
> > > > +             * internally try to process as much data as possible =
with any
> > > > +             * number of URBs without giving us the chance to wait=
 in
> > > > +             * between transfers.
> > >
> > > If the hardware really works this way, then perhaps you should not us=
e
> > > the generic write implementation. Just maintain a single urb per port
> > > and don't submit it until the device fifo is empty.
>
> > I tried to avoid having to copy & paste (which then also means having
> > to maintain it down the line) most of the generic write
> > implementation.
> > This whole dance with waiting for the "Transmitter holding register
> > empty" by the way was the reason why parts of the transmit buffer got
> > lost, see the report from Nicolas in v6 [1]
>
> I understand, but the generic implementation is not a good fit here as
> it actively tries to make sure the device buffers are always full (e.g.
> by using two URBs back-to-back).
>
> If you can't find a way to make the hardware behave properly then a
> custom implementation using a single URBs is preferable over trying
> to limit the generic implementation like you did here. Perhaps bits can
> be reused anyway (e.g. chars_in_buffer if you use the write fifo).
I cannot find any other usb-serial driver which uses this pattern.
Most devices seem to be happy to take more data once they trigger the
write_bulk_callback but not ch348.

If there's any other (even if it's not a usb-serial) driver that I can
use as a reference implementation for your suggestion?
I'm not sure whether to use a dedicated kthread, single threaded workqueue,=
 ...

> > > > +static struct usb_serial_driver ch348_device =3D {
> > > > +     .driver =3D {
> > > > +             .owner =3D THIS_MODULE,
> > > > +             .name =3D "ch348",
> > > > +     },
> > > > +     .id_table =3D             ch348_ids,
> > > > +     .num_ports =3D            CH348_MAXPORT,
> > > > +     .num_bulk_in =3D          1,
> > > > +     .num_bulk_out =3D         1,
> > >
> > > Set both of these to 2 so that core verifies that you have all four
> > > endpoints.
>
> > I will have to test this because I thought that:
> > - using 2 here makes usb-serial allocate an URB as well and by default
> > assign it to the first and second port
> > - usb-serial should not touch the second bulk in / bulk out endpoint
> > (as they're entirely vendor / chip specific)
>
> Setting these two should make core make sure that the endpoints exist,
> and by default they will be assigned to the first and second port, but
> you can override that calc_num_endpoints() (as you already do).
>
> For the second IN EP, you could even let core allocate the URB and use
> that instead of doing so manually (e.g. by submitting yourself or using
> the generic read implementation as mxuport does).
Thanks for the hint - I have tried this and it indeed simplifies the code!


Best regards,
Martin


[0] https://github.com/WCHSoftGroup/ch9344ser_linux/blob/d4fc95fb1cca996238=
4ca88b0007df8738ae5829/driver/ch9344.c#L1100
[1] https://github.com/WCHSoftGroup/ch9344ser_linux/blob/d4fc95fb1cca996238=
4ca88b0007df8738ae5829/driver/ch9344.c#L1152-L1156
[2] https://github.com/WCHSoftGroup/ch9344ser_linux/blob/d4fc95fb1cca996238=
4ca88b0007df8738ae5829/driver/ch9344.c#L1166

