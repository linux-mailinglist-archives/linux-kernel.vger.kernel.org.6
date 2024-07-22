Return-Path: <linux-kernel+bounces-259404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5341939563
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560751F22470
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC65446DC;
	Mon, 22 Jul 2024 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nAXMH9Qg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336A1E891;
	Mon, 22 Jul 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683365; cv=none; b=q7d7HkjfgmgG0mdIumUVghfayiYDqNXmKCTeY3yFhthtHTdtI10rbck2FKX0dUC42Klsbv7WnABgPVobluf6vsyNYkeK7T1a2aaYcsreDVFwTPlVM8vncZf/XFbgQfwmQcSqq3QDjYuO7TcjjBn8fP5A5Pma8aG8tjbWi3fuiKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683365; c=relaxed/simple;
	bh=dNqmRPbzhxfMtmOH2kAqF0q4HRORo1txouo+J4kJiv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAy6w7uZoP3EYcBh5VXqy2Dev0xrQnxp9bKvmUIZ84JzXBio9880RWDDcVblk0LlOmXzZkLGa+kO6uS5MamkQ2Zi2DYT+iwVcsJhY/V5cvZ/7OF6wBc7P/sMpCFHXL1YVA78vZmQIjMFKoL+ZIjmDj++eO6KAkdUtspQjuhxrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nAXMH9Qg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc5549788eso36460495ad.1;
        Mon, 22 Jul 2024 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721683363; x=1722288163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQr/7RC/VjpMlQ892H64p31mDRk6nZIad4SdpZs64ws=;
        b=nAXMH9QgTE3mholQTFlFudJATJy0EL9QD9MW2NQiLTIxaaHOi6ynzj3/RXkvKf/Cb8
         fI20vUgIbCEuuogMqledyX8J2Wcjq34GJmQWRH+Acyo16vmC5WlBfS3ehVCApCYmPVd+
         6A2i/pu0wAPFGU6ujm6AMDWDXQj5IxZZUOvCLbuFx5hGk/OUjGFCVpiB5CB3JowPYByy
         kL2f/AjR8QfMBbliGQFjbj61D/WBE9BC4TRWnyRyW4HqKs0Dt7P3TZrW7uiHDEDrFeHn
         bbPt+1VtBFOdYRwzWs23iBsGd6WBHjdcQg4Lzapw6PSgpaoFErU32vKw3ImeYmyac3+E
         s42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721683363; x=1722288163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQr/7RC/VjpMlQ892H64p31mDRk6nZIad4SdpZs64ws=;
        b=dmEKRja6zq4Ez5STmAhw612RKPVgfwLsvAdQ2Y3IM9K9UGDeg44CXRJw8I0l455isx
         ZOixOm5Pn8TpALOqMEd/HVMOn0TiWaVUrCXteOdNWuKtYjihqMWyom1B5BbF9BHa6yLS
         3lwzxSEhJBHOZtNXH8yWikYMwj9erC86KYU9q6N/QOr1vpoBA+RaOuuOrF0kKT5oV1Mb
         wmUyZRlvDDNYj39RN+ZDbD0ZPu6Fd3xvYblWtASy3sX5oZdd3wpUOzdB5cKXMvtU1a3F
         Gq3hbR8XPv2jcihBYd+m49MNKDNH+RJEdmjXf0NbHkZNw9IjdrHxOcKL35YrR2zzLcVk
         87Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXLNwgw0tPoGKxVasm64ghXmcWM2Yq2+aR1XenFwoVyD0SEnGsrYKXZeUTGcReLJRg2sQdKNLaxJhdXj3bHL3reKcyMcACZLa0CkDyshWN2A71ylbQAGaZGc7IX0SkabjatGjOX2YYn
X-Gm-Message-State: AOJu0YxSnEg9c2sLs4QXFyHEdAJMoug2yw8QEOUPq2rzW+wRV1TP8f7R
	z7yl7lhvJGJq5kbgPUhx+wmwqU7DGcfdyk3LTbsBGJVUpbSIw0obsdC4EwU2zA+bJSfEP3yIxtN
	VvkQeYSJnmmExtsH/1gH8un7NZvMGmitw
X-Google-Smtp-Source: AGHT+IFPY++jfiSDsNCLqW/DB+re75HSH4oIBOyxbtfZc6gz4wldWzhw7+5E/zfACJu71Ff7PxLtejhYYSIY/3WWVeY=
X-Received: by 2002:a17:902:e5c5:b0:1fd:abd4:ed5b with SMTP id
 d9443c01a7336-1fdabd4f218mr23307675ad.39.1721683363247; Mon, 22 Jul 2024
 14:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507131522.3546113-1-clabbe@baylibre.com> <20240507131522.3546113-2-clabbe@baylibre.com>
 <Zp5q5V_OnLAdvBrU@hovoldconsulting.com>
In-Reply-To: <Zp5q5V_OnLAdvBrU@hovoldconsulting.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 22 Jul 2024 23:22:32 +0200
Message-ID: <CAFBinCC9ftXxkyoiY=3ia6UubTeG-cHXa40ddd7WMNUhvVjr+g@mail.gmail.com>
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
To: Johan Hovold <johan@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Johan,

thanks for taking the time to go through this patch and providing feedback!

On Mon, Jul 22, 2024 at 4:21=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Tue, May 07, 2024 at 01:15:22PM +0000, Corentin Labbe wrote:
> > The CH348 is an USB octo port serial adapter.
> > The device multiplexes all 8 ports in the same pair of Bulk endpoints.
> > Since there is no public datasheet, unfortunately it remains some magic=
 values
>
> Could you please include a pointer to the vendor driver (which I assumed
> you based this on)?
We can do that, in case you want/need some info upfront you can find
the reference code here: [0]

[...]
> > @@ -0,0 +1,725 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * USB serial driver for USB to Octal UARTs chip ch348.
> > + *
> > + * Copyright (C) 2022 Corentin Labbe <clabbe@baylibre.com>
>
> Do you need to include any copyrights from the vendor driver? It looks
> like at least some of the code below was copied from somewhere (but
> perhaps not that much).
If you - or someone else - have any advice on this I'd be happy to go with =
that!

[...]
> > +#define R_II_B1              0x06
> > +#define R_II_B2              0x02
> > +#define R_II_B3              0x00
>
> This look like standard IIR masks (e.g. R_II_B2 would be Transmit
> holding register empty).
I didn't know about it until now - thanks for the hint.
note to self: git grep UART_IIR_ include/

[...]
> > +     struct urb *status_urb;
> > +     u8 status_buffer[];
>
> This buffer should be allocated separately as it is used for DMA.
I assume it's because of alignment reasons.
Lucky me that I didn't hit any issues on ARM or x86_64.

[...}
> > +     u8 reg_iir;
> > +     union {
> > +             u8 lsr_signal;
> > +             u8 modem_signal;
> > +             u8 init_data[10];
>
> This init_data field is never used and looks a bit odd. What is it used
> for?
I think the firmware is sending back the configuration that was
applied (see ch348_set_termios())

> You mentioned that that the modem lines are not yet used either.
My understanding is: we neither use init_data nor modem_signal in the
driver so let's drop them for now (and add them back when they're
actually needed).

[...]
> > +                     if (status_entry->lsr_signal & CH348_LO)
> > +                             port->icount.overrun++;
> > +                     if (status_entry->lsr_signal & CH348_LP)
> > +                             port->icount.parity++;
> > +                     if (status_entry->lsr_signal & CH348_LF)
> > +                             port->icount.frame++;
> > +                     if (status_entry->lsr_signal & CH348_LF)
>
> Should you really count every framing error as a break? Looks like this
> should have been CH348_LB.
Excellent catch - thank you!

Also note to self: git grep UART_LSR_ include
We can probably replace the custom #defines with the standard ones.

[...]
> > +static int ch348_configure(struct ch348 *ch348, int portnum)
> > +{
> > +     int ret;
> > +
> > +     ret =3D ch348_do_magic(ch348, portnum, CMD_W_R, R_C2, 0x87);
>
> This looks like it could be a write to the standard Fifo Control
> Register.
And again, thank you! 0x87 translates to (which also makes sense):
  UART_FCR_ENABLE_FIFO (0x01) |
  UART_FCR_CLEAR_RCVR (0x02) |
  UART_FCR_CLEAR_XMIT (0x04) |
  UART_FCR_R_TRIG_10 (0x80) |
  UART_FCR_T_TRIG_00 (0x00)

[...]
> > +static int ch348_write(struct tty_struct *tty, struct usb_serial_port =
*port,
> > +                    const unsigned char *buf, int count)
> > +{
> > +     struct ch348 *ch348 =3D usb_get_serial_data(port->serial);
> > +     struct ch348_port *ch348_port =3D &ch348->ports[port->port_number=
];
> > +     int ret, max_tx_size;
> > +
> > +     if (tty_get_baud_rate(tty) < 9600 && count >=3D 128)
>
> You don't hold the termios lock here so this needs to be handled
> differently. Perhaps you can set a flag in set_termios if this is
> really needed.
>
> > +             /*
> > +              * Writing larger buffers can take longer than the hardwa=
re
> > +              * allows before discarding the write buffer. Limit the
> > +              * transfer size in such cases.
> > +              * These values have been found by empirical testing.
> > +              */
> > +             max_tx_size =3D 128;
>
> Can you elaborate on you findings here? According to the vendor homepage
> this device has a 1024 byte TX fifo per port. Are you really saying that
> for some reason you can only fill it with 128 b when the line speed is
> below 9600?
For slow speeds I never receive the "Transmitter holding register
empty" interrupt/signal when using the full TX buffer.
It's not that the interrupt/signal is late - it just never arrives.
I don't know why that is (whether the firmware tries to keep things
"fair" for other ports, ...) though.

> > +     else
> > +             /*
> > +             * Only ingest as many bytes as we can transfer with one U=
RB at
> > +             * a time. Once an URB has been written we need to wait fo=
r the
> > +             * R_II_B2 status event before we are allowed to send more=
 data.
>
> As I mentioned above R_II_B2 appears to be the transfer holding register
> empty flag in IIR. So you write one endpoint size worth of data and then
> wait for all of it to be processed on the device before sending more.
>
> How big is the endpoint (please post lsusb -v)?
Bus 003 Device 022: ID 1a86:55d9 QinHeng Electronics USB2.0 To Multi
Serial Ports
Device Descriptor:
 bLength                18
 bDescriptorType         1
 bcdUSB               2.00
 bDeviceClass          255 Vendor Specific Class
 bDeviceSubClass       128 [unknown]
 bDeviceProtocol        55
 bMaxPacketSize0        64
 idVendor           0x1a86 QinHeng Electronics
 idProduct          0x55d9 USB2.0 To Multi Serial Ports
 bcdDevice            1.36
 iManufacturer           1 wch.cn
 iProduct                2 USB2.0 To Multi Serial Ports
 iSerial                 0
 bNumConfigurations      1
 Configuration Descriptor:
   bLength                 9
   bDescriptorType         2
   wTotalLength       0x002e
   bNumInterfaces          1
   bConfigurationValue     1
   iConfiguration          0
   bmAttributes         0x80
     (Bus Powered)
   MaxPower              200mA
   Interface Descriptor:
     bLength                 9
     bDescriptorType         4
     bInterfaceNumber        0
     bAlternateSetting       0
     bNumEndpoints           4
     bInterfaceClass       255 Vendor Specific Class
     bInterfaceSubClass    128 [unknown]
     bInterfaceProtocol     55
     iInterface              0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x82  EP 2 IN
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0200  1x 512 bytes
       bInterval               0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x02  EP 2 OUT
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0200  1x 512 bytes
       bInterval               0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x81  EP 1 IN
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0200  1x 512 bytes
       bInterval               0
     Endpoint Descriptor:
       bLength                 7
       bDescriptorType         5
       bEndpointAddress     0x01  EP 1 OUT
       bmAttributes            2
         Transfer Type            Bulk
         Synch Type               None
         Usage Type               Data
       wMaxPacketSize     0x0200  1x 512 bytes
       bInterval               0
Device Qualifier (for other device speed):
 bLength                10
 bDescriptorType         6
 bcdUSB               2.00
 bDeviceClass          255 Vendor Specific Class
 bDeviceSubClass         0 [unknown]
 bDeviceProtocol       255
 bMaxPacketSize0        64
 bNumConfigurations      1
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
 (Bus Powered)

> > +             * If we ingest more data then usb_serial_generic_write() =
will
> > +             * internally try to process as much data as possible with=
 any
> > +             * number of URBs without giving us the chance to wait in
> > +             * between transfers.
>
> If the hardware really works this way, then perhaps you should not use
> the generic write implementation. Just maintain a single urb per port
> and don't submit it until the device fifo is empty.
I tried to avoid having to copy & paste (which then also means having
to maintain it down the line) most of the generic write
implementation.
This whole dance with waiting for the "Transmitter holding register
empty" by the way was the reason why parts of the transmit buffer got
lost, see the report from Nicolas in v6 [1]

> > +             */
> > +             max_tx_size =3D port->bulk_out_size - CH348_TX_HDRSIZE;
> > +
> > +     reinit_completion(&ch348_port->write_completion);
>
> This is broken as write can be called at any time and may clear any
> previous completion.
I never hit that issue in my tests but I get your point.

[...]
> > +static struct usb_serial_driver ch348_device =3D {
> > +     .driver =3D {
> > +             .owner =3D THIS_MODULE,
> > +             .name =3D "ch348",
> > +     },
> > +     .id_table =3D             ch348_ids,
> > +     .num_ports =3D            CH348_MAXPORT,
> > +     .num_bulk_in =3D          1,
> > +     .num_bulk_out =3D         1,
>
> Set both of these to 2 so that core verifies that you have all four
> endpoints.
I will have to test this because I thought that:
- using 2 here makes usb-serial allocate an URB as well and by default
assign it to the first and second port
- usb-serial should not touch the second bulk in / bulk out endpoint
(as they're entirely vendor / chip specific)

I omitted replies to some of your comments because I agree with them
and repeatedly writing "ACK" didn't seem to add much value.


Best regards,
Martin


[0] https://github.com/WCHSoftGroup/ch9344ser_linux/tree/dcbe60d12ead4622b7=
fdd6dec24e62facee23663/driver
[1] https://lore.kernel.org/lkml/2595072.9XhBIDAVAK@archbook/

