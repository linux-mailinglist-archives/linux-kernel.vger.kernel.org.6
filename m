Return-Path: <linux-kernel+bounces-406738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE0C9C630C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4E1F236EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472121A4A0;
	Tue, 12 Nov 2024 21:04:59 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5F13FD99;
	Tue, 12 Nov 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445499; cv=none; b=WmJoYURjhGvywCiYrNgK6KJPo+evl4xv/iR6xLWuoCsmpr4aogtUG+NomF6/OVWrtzo/PUc5UpfV2k8dKu57cKd0cvATZVUTim2Xf4ieWl6s6TgGUCyMsTzyNUqp7nDNR0QYwzv6gPUbP57ApRZrxFT+hrdMVpinlNV8EHQSInY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445499; c=relaxed/simple;
	bh=TQ0/exzLDepX41JCJH6DPzgifIgtqk1K/F5c9oW43sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZRDsCNzlFy8jpSdJ6bn2T4HtRAiXFbcnzXsOCUviEK6Swch7+4i8tGZzQPKpVcxJFSnhPoOGx1UHI2k0WOY2TXJa+AJmoMa8j3b6Cu1o2QvX91zgBXAoSL5tQxXRFIMLbkt88FLCEgXTzJMLEkkTamZ6EVjhffb5xPo1EcJERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e625b00bcso5013411b3a.3;
        Tue, 12 Nov 2024 13:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731445497; x=1732050297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CvDHNQkFyG+LMIK7/fleVlgZZt4uzRHNtjY9nOElHs=;
        b=a++uzm1lw1JEUm2G05UHswk4uQTl8rARTwlouCOKDSez0NUL/BIEqzs0ipEp4boKm2
         cEbHc3CzsUC/sR4mgG9CmrHVypgQniSJhunLmPW5anY1Dqr0SHJYhQC9BsM7Byrd8Ocl
         zO23mXzJzFOlC7KwwGQLSu1JDcv3JMea2rLyR3MlDtcokVEIxk381uVWXMcd7pvGeLo9
         81d6Nlt2KmnOsBhYN+5T7f/Q4EPvVj49jOl33/8ZpLhWeLtCssNrbaOx99iPgFomelhu
         5pyoN1G8J7lt012YTDENf558WGwhpUPfYGtN+gAJuHMJ3f27eqZFPOjgiFnbY7hZSh2r
         vG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuAq7xOpsOfohW3qeqvyLukQeif4EYsF6Cnwx8PK5tcTIXEzc15R3A1KXR0Ny71uDCVeyKpUQUQ2+rh95C@vger.kernel.org, AJvYcCWX4ZtzaGfpwDr53U1C9fF++j6txKsQ4qMhV/99s1RqeTvvQr/SrtgezSRkDNS0rjnfQ4kw1+or4PBl@vger.kernel.org
X-Gm-Message-State: AOJu0YyduvcRHrzgXsc5gCuOMtWiI+LJ3poT9J6PcyBdNBFK87IAazWT
	ASlaSW76pc8J648PVQeh5041HmiEz3fdxJh3CZ/ekEepn95sYpWW6ZnRWiEo
X-Google-Smtp-Source: AGHT+IGcsWdrF+tY1KFaOyONuadw6SUdOxmTDjuraVog9v/493S6TI4E8TdZYxni9VT/AGxN5L4oDw==
X-Received: by 2002:a05:6a20:6a28:b0:1d9:270a:947a with SMTP id adf61e73a8af0-1dc7049839fmr1030587637.30.1731445495282;
        Tue, 12 Nov 2024 13:04:55 -0800 (PST)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com. [209.85.215.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860a6bsm11711321b3a.6.2024.11.12.13.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 13:04:54 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4442108a12.2;
        Tue, 12 Nov 2024 13:04:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9krSG7hQVEOIafQS8XxZejSU7QuY8Iv2k8K0r/Gr9UK7uVSz5OynsMG8Pned4i0ti+uyblMsepXhX@vger.kernel.org, AJvYcCVBIxXaDrcbrql94nch0MXR3zOV+j9dEHon1yq/A5sj1yH+lAkaRW05zfF4N6nwgi+4WhKUkPpLONYhjxT7@vger.kernel.org
X-Received: by 2002:a17:90b:524e:b0:2e2:d859:1603 with SMTP id
 98e67ed59e1d1-2e9f2d5c5a7mr421987a91.25.1731445494243; Tue, 12 Nov 2024
 13:04:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-4-tszucs@linux.com>
 <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se> <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
 <9330ebb370780c001fd2aaee49aec9e8@manjaro.org>
In-Reply-To: <9330ebb370780c001fd2aaee49aec9e8@manjaro.org>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Tue, 12 Nov 2024 22:04:43 +0100
X-Gmail-Original-Message-ID: <CA+GksrJjDPve29Vh7ZFhM+JFp058xmXZAPeuLuFth7v=JeiH2w@mail.gmail.com>
Message-ID: <CA+GksrJjDPve29Vh7ZFhM+JFp058xmXZAPeuLuFth7v=JeiH2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable UART8 on rock-3b
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>, Chukun Pan <amadeus@jmu.edu.cn>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dragan,

On Tue, Nov 12, 2024 at 4:07=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> Please correct me if I'm wrong, but isn't this UART supposed to be
> used for the Bluetooth part of an SDIO WiFi + Bluetooth module, in
> form of a non-standard M.2 module that Radxa sells?

UART8 is supposed to be used for any radio module connected to the M2E
connector.
It will typically be responsible for Bluetooth or BLE but it could be
802.15.4 or whatever. In any case, all wanting to use it will need the
uart8 node enabled.

>
> With that in mind, I see very little sense in just enabling the UART,
> without defining the entire Bluetooth interface, which AFAIK produces

Defining a bluetooth node would hardwire idiosyncrasies of a given
radio module's Bluetooth core. Sure you could add a sleep clock, all
kind of sideband signals for wakeups, reset, power down, etc. But hey,
some will use them, some won't. I think it's undesirable and
unnecessary. You can hciattach from here and most will work just like
that. Tighter integration or anything special, module specific on top
should be handled individially, on a case-by-case basis. This is a dev
board after all. I say trick of all trades.

> nasty looking error messages in the kernel log when there's actually
> nothing connected to the UART.

My dmesg is clean as a whistle
root@rock-3b:~# dmesg | grep -E 'fe6c0000|ttyS0'
[    0.344818] fe6c0000.serial: ttyS0 at MMIO 0xfe6c0000 (irq =3D 26,
base_baud =3D 1500000) is a 16550A
What kind of nasty errors do you recall?

Kind regards,
Tamas

