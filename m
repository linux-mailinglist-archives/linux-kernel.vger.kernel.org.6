Return-Path: <linux-kernel+bounces-443693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F09EFABC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EAF1728E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D72288F5;
	Thu, 12 Dec 2024 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b="kB2ek4Kc"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7F2288F6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027238; cv=none; b=C+zlEJbVlv5M6RVLGV6dobQSkFpfmt6xKEtbRttHEaPc0v9OvJJccIDosraFGsFF8z5j2KjHavRYFHIu0NyDhvK6gs+FQobWJgJ7RhVygU94OsP+LIa1HV7378UcFjuWbaaZ1sexe2bJHUmxDSC41leFwfqJYu+uT9nCxN0b2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027238; c=relaxed/simple;
	bh=7VKs24hxuVxtmadZdMFSS6V+LZqjYbyf1LkRAbvk+sE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHDkLvx/xMO3s5CQT7On+ObZe7UBdbXqaCgSuRQw/yS91RJ1gAE9MEVtPSGU8zXw/KdjieIj+/H3KTO5KgAnDSI7JsWU9pYWFtTAOdLBVb4ay0AefmZQLVxqevxxbm8yYcV0bK3dA92L/3rgXC5rdmgKnhtwRc6VRLiPsSBuhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wetterwald.eu; spf=pass smtp.mailfrom=wetterwald.eu; dkim=pass (2048-bit key) header.d=wetterwald-eu.20230601.gappssmtp.com header.i=@wetterwald-eu.20230601.gappssmtp.com header.b=kB2ek4Kc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wetterwald.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetterwald.eu
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5401e6efffcso1031222e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wetterwald-eu.20230601.gappssmtp.com; s=20230601; t=1734027232; x=1734632032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VKs24hxuVxtmadZdMFSS6V+LZqjYbyf1LkRAbvk+sE=;
        b=kB2ek4KcpnJloWE4mHq+h74P9p4u1ZqCt6A//VvbN9ZDKH5Qk2gBCmi0mo/gkIrxc0
         PnzPPbs4OpcfTia4tiedRnjp6+6X4L1Rt2U7Zw/NtjirSo73ClRsWmoloRrptov0bbP3
         SSbBzoM9OLrdUhsYJ+RCYN6/n3Lud4xxupnKQQRcB7byPG7XsHKyjT95ptQd5AorHma8
         4zCuwU+HDtaI0dFl7Uyo6X21XPVDRXlml6LaAHUMLYP5GH1rjsdDgPftXFdIDY2MueH0
         hac72BuzYLd6XB2fKyGkcTS5UDIrqRkJHEXJF/2gF4UWho3EKv+YXFkmoGeAy8zehxDP
         2I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027232; x=1734632032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VKs24hxuVxtmadZdMFSS6V+LZqjYbyf1LkRAbvk+sE=;
        b=rMYEuPysixafw+YmvneArY6+XSRjPtzx4lzE2W20ezIrFDsuf01x891G/qcmPWUiWg
         is6SCDmBTVltK8aczzGc0uHur5d3cI5d8q4nvt0gtQIoCpdzWusW0zONabrMVIMB7tqx
         1TYDzvwuoQzx4T3CZRI+ffuWZELWJIaHGqgw5AicD9L2XL4hsWjqxmCb1p/h1lvacNBw
         OiRxkb5I+p+dtX8akkvsqyKFjjjpyKQc0tyiBRl4MlQ9bBv/6i4QlyjghUYPXfITVMZe
         oUu0W26tix4+tzuujXwgt66FRljckPYpzHjAo+d/CHdEvn+ptwKPbh2jfwQsVZlCQz1E
         1HKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsDB6x9NmijBF11txqEUroBL+7mgYPdC7Cmn3dL5RpP3IrGNV2czZAev5n4putpqPeFBbgPaRL22aMdos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi5LyFE2dAgHfG5IrgOSKCjypmp0XyXAMe5m+Np0TlxNJp5CI
	6WkTYTLvM1jZPiJHllRi/X39QhdlP1AwU1qgLHTaMSzRKS1+PSTXC4hUnjxvcz0v8ET0XhNBSG8
	Ccj/Ag5ZFpu1rfb2sWGgC4t9/BEje2/AVy5tSAg==
X-Gm-Gg: ASbGncvyM9st5UTfFYvEfgQ8TQBspVUlZC2pWXB/L5ni0968eW4KEHcZdBR3aDXJu0t
	0Z/xnvPDAuGifriUhnfOlXLDDnGgxT4pkqL93zximjAk1asyZ6cCebxjbsPTXCO2E1YzCyA==
X-Google-Smtp-Source: AGHT+IEDiH60eg++Uh/HeCIMB+HgJoZ9cQFLJDVz2AKHBrKQ6jiO7gkPeQr3WtB7BxUWTMwU25XgXg4ONapCoUaEls8=
X-Received: by 2002:a05:6512:68e:b0:540:1a3f:e848 with SMTP id
 2adb3069b0e04-5403410614cmr737547e87.15.1734027232019; Thu, 12 Dec 2024
 10:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFERDQ2hLHek+0ViVqbqgOD+4xwC2ZwK1KhgGdLP_zGnonEs4w@mail.gmail.com>
 <d02a7143-43e7-4851-a06e-d57981362a5a@gmx.net>
In-Reply-To: <d02a7143-43e7-4851-a06e-d57981362a5a@gmx.net>
From: Martin Wetterwald <martin@wetterwald.eu>
Date: Thu, 12 Dec 2024 19:13:41 +0100
Message-ID: <CAFERDQ0AUhCp_c0LLRRR9SWyvDON-CdXFvK3eqcLFc_SMhdPRw@mail.gmail.com>
Subject: Re: Raspberry Pi 3B: Failed to create device link with soc:firmware:gpio
To: Stefan Wahren <wahrenst@gmx.net>
Cc: f.fainelli@gmail.com, saravanak@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 2:16=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:
> What happens if you replace your custom config with arm64/defconfig?
> Does the issue still occurs?

I've just launched a kernel with the arm64 defconfig:

> 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq =3D 99, base_baud =3D 0)=
 is a PL011 rev2
> serial serial0: tty port ttyAMA0 registered
> raspberrypi-firmware soc:firmware: Attached to firmware from 2024-09-13T1=
6:00:01
> hci_uart_bcm serial0-0: supply vbat not found, using dummy regulator
> hci_uart_bcm serial0-0: supply vddio not found, using dummy regulator
> Bluetooth: hci0: BCM: chip id 94
> Bluetooth: hci0: BCM: features 0x2e
> Bluetooth: hci0: BCM43430A1
> Bluetooth: hci0: BCM43430A1 (001.002.009) build 0000

And it worked perfectly. Thanks for your suggestion. It confirmed the probl=
em
came from my kernel config.

I then compared both .config and it appeared I was missing this config flag=
:

> CONFIG_SERIAL_DEV_CTRL_TTYPORT

I had already enabled CONFIG_SERIAL_DEV_BUS, but not CTRL_TTYPORT.
Nevertheless, that first kernel config item's prompt had been clear about t=
hat,
but I missed the advice:

> CONFIG_SERIAL_DEV_BUS
> Core support for devices connected via a serial port.
> Note that you typically also want to enable TTY port controller support.

It's so much better now to see the HCI attachment handled by the kernel
directly!

Thank you for your help.
Martin

