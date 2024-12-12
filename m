Return-Path: <linux-kernel+bounces-442912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796AC9EE3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49877168326
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF82101B7;
	Thu, 12 Dec 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b="R1/ETQcZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1021F949
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998424; cv=none; b=B2aIooF3AKnQOWt1nRTCcodXMpdVtKCVCEdJMvcmJRPsikoHEvqh28ExTH8KUI+YdVV2Op8WFahNzfWs2F4gyn/zwZ1rZ6eFj6WyCsY3+FACbTws57p4fYUImeIjAa0M/i+HJAngvplpYnmPMvjw0ZJltrb/CnVKnqMSWLnBQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998424; c=relaxed/simple;
	bh=vjl7udsYZj5OR0YkaT5BnoL0taUATJBU3cEYKFx+4Qs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=AETF3WSZLsAKhalxjVsxJMXrxk5r5XjS7/EjGQO4ByklpMIm/cQBD0XzK7O+2FOavbTHPo3IkKTg+Ml9f/o8sWKuLXZ3UZKlKbD3oxQ8SvKrTQEBahP/Whw0VYgixWT0+X3SjGgmBeXqljBi2kVA7dRU05kq/XAXeLIsy2PaUPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wetterwald.eu; spf=pass smtp.mailfrom=wetterwald.eu; dkim=pass (2048-bit key) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b=R1/ETQcZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetterwald.eu
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401b7f7141so365661e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wetterwald-eu.20230601.gappssmtp.com; s=20230601; t=1733998419; x=1734603219; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EI22DQzZVDVnTxt6RUW2tG/G1/4buJh4utbAY1WkjKk=;
        b=R1/ETQcZbyNaT1jKipWPxf5q7K5RFNblywKBwILI7dFsRsHFhV8MUqqoH0kBcyhYfv
         lRYz/Tf4H2iF6WHxfP34ib0h5tGryT3vu27QoWVgjPeWcCi2jgwCWv+tdwkn4zHNb/xu
         lDdVbDcPFH4Q4bPnXcBVsnZNOQJEg7770xMsYIxmE8+PRs5QRYrrpL1Ow4Y1GuWRflPY
         5VsmCL66PTf1fQMb01n7Xd0YIucvDKtcoGAS8jAY4bwv5+HWdBZyxEOdpWqg5LVj4ohy
         EhQezTaQLDpHWpwPWi+njIO6HdvHaTNda2Mb0SmoXeVL8k6t7EiMrsM4Q3HtGj+F/CaF
         9lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998419; x=1734603219;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EI22DQzZVDVnTxt6RUW2tG/G1/4buJh4utbAY1WkjKk=;
        b=G5rJR7tbz2jYAjiERPr5Ec4fhgTnpDuMQ4n9s2u4D/Hjvmmhsi2iep/Dg3riglXZF9
         XZk7vttgxSzUKTKg8RqAEh4vBgo8FaQTpqqUNvCcqtkSLg5v1KZ2X9JlWU7HqDxAHIHP
         6SItpADScY6BPyl6V8K0S116iH7in9/ynqvuiccOhcalED4vOxbN+jYmFBQlFpFSuCWO
         AvbdlvFUanSjNYt2Ff9nHWlrFFag8xHb7svtuYNR53GpZusSCIv6hLjAbS68zbqh0/Gz
         n+xFIFerrbjx4Q/ACtdfFrN8JwOfxccsejvRjgY2Mcr7QeKQRp64tiRpQTWZM5K/JIKq
         rDtA==
X-Forwarded-Encrypted: i=1; AJvYcCVQo42kOeXZ+yID4gCRMyRjtHfUr6VpXZe4U1mBjzjFpr6mf5/AiEdTV6jiCO3qAArF4dstg91/iXP8Slg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAJvKQunDqJgbUXlGm1Uwopnm4xTe8pM4zWqwttO4+gvdBLqm
	DGkoQ7Cs/TmMSmoCd0IbIjth/jgIzJ5eCXnsUV3nz1rIa7xRL179bltOf0dxBCNJIUhms81qIyh
	hIyYgdDJbwC62Y+5KmIcpVg2WGNVqYfSRzLENeJ5uXV3ghtvgg64=
X-Gm-Gg: ASbGnctE4SDU+uyfs10mciTdhFGWTAWxIP2UGwh9+bndkgygJvlry1yoH29ANNQlUkJ
	8oOkTCsCoY2HTzniJx6LISHuNzwKXE4sdSEAl6H+sf60xD0OyRyCJcJ9O9oIMSLUBBjPFkg==
X-Google-Smtp-Source: AGHT+IE3hiuuk4G/KOtpfY7TlYPOOY0d5gVRWjcYEGOWpovgfyQ6kA/hV98D39NWqWy30GJxW18y+khOQn1iZgitaHc=
X-Received: by 2002:a05:6512:1089:b0:540:2160:1f80 with SMTP id
 2adb3069b0e04-54032d49048mr218103e87.40.1733998418616; Thu, 12 Dec 2024
 02:13:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Martin Wetterwald <martin@wetterwald.eu>
Date: Thu, 12 Dec 2024 11:13:27 +0100
Message-ID: <CAFERDQ2hLHek+0ViVqbqgOD+4xwC2ZwK1KhgGdLP_zGnonEs4w@mail.gmail.com>
Subject: Raspberry Pi 3B: Failed to create device link with soc:firmware:gpio
To: f.fainelli@gmail.com, saravanak@google.com, stefan.wahren@i2se.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Saravana and Florian,

Back in 2023, you discussed about an issue concerning the Raspberry Pi 4, that
you fixed in commit 1a5ecc73b2bfeffe036212d4a6bfacee053ab0a1:
https://lore.kernel.org/lkml/03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com/
https://lore.kernel.org/all/20230302023509.319903-1-saravanak@google.com/

Today, I notice I see the same issue, but it's with the Raspberry Pi 3B (V1.2).
I'm using the upstream kernel 6.12.3, with the upstream DTB.

You can find my kernel miniconfig (basis being allnoconfig) here:
https://gist.github.com/mwetterw/299bb1317fccf9e68125cb0f5da7384c

During boot, I see following messages:
> Bluetooth: HCI UART driver ver 2.3
> Bluetooth: HCI UART protocol H4 registered
> Bluetooth: HCI UART protocol Broadcom registered
> bcm2835-mbox 3f00b880.mailbox: mailbox enabled
> 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 99, base_baud = 0) is a PL011 rev2
> raspberrypi-firmware soc:firmware: Attached to firmware from 2024-09-13T16:00:14
> uart-pl011 3f201000.serial: Failed to create device link (0x180) with soc:firmware:gpio

Here is an extract of the relevant FDT nodes.
Because my setup involves first the proprietary GPU firmware, then the U-Boot
bootloader before finally launching the kernel, I used following command in
order to make sure I see the same FDT as Linux:

> ssh rpi 'cat /sys/firmware/fdt' | fdtdump -

> firmware {
>     compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
>     mboxes = <0x0000001b>;
>     phandle = <0x0000001c>;
>     clocks {
>         compatible = "raspberrypi,firmware-clocks";
>         #clock-cells = <0x00000001>;
>         phandle = <0x00000015>;
>     };
>     gpio {
>         compatible = "raspberrypi,firmware-gpio";
>         gpio-controller;
>         #gpio-cells = <0x00000002>;
>         gpio-line-names = "BT_ON", "WL_ON", "STATUS_LED", "LAN_RUN", "HDMI_HPD_N", "CAM_GPIO0", "CAM_GPIO1", "PWR_LOW_N";
>         status = "okay";
>         phandle = <0x0000000a>;
>     };
> };

> serial@7e201000 {
>     compatible = "arm,pl011", "arm,primecell";
>     reg = <0x7e201000 0x00000200>;
>     interrupts = <0x00000002 0x00000019>;
>     clocks = <0x00000007 0x00000013 0x00000007 0x00000014>;
>     clock-names = "uartclk", "apb_pclk";
>     arm,primecell-periphid = <0x00241011>;
>     status = "okay";
>     pinctrl-names = "default";
>     pinctrl-0 = <0x00000008 0x00000009>;
>     phandle = <0x00000048>;
>     bluetooth {
>         compatible = "brcm,bcm43438-bt";
>         max-speed = <0x001e8480>;
>         shutdown-gpios = <0x0000000a 0x00000000 0x00000000>;
>         phandle = <0x00000049>;
>     };
> };

If I understand correctly, the serial dev bus, together with
CONFIG_BT_HCI_UART, CONFIG_BT_HCI_UART_BCM, and if associated to the correct
DTB nodes describing the bluetooth chip, should allow the kernel to handle the
serial Bluetooth HCI himself, without the userspace needing to launch user
space tools like hciattach or btattach?

Is the log

> uart-pl011 3f201000.serial: Failed to create device link (0x180) with soc:firmware:gpio

a hint to the reason why the kernel doesn't automatically handle my Bluetooth
HCI over serial?

How to solve this log error, and how to let the kernel handle the HCI himself?
Am I missing kernel configuration flags?

Thanks!
Martin

