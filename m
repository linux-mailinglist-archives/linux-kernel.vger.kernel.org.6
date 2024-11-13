Return-Path: <linux-kernel+bounces-407388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9CF9C6CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65533B2B45F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A31FC7E5;
	Wed, 13 Nov 2024 10:24:42 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5D1FB73F;
	Wed, 13 Nov 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493482; cv=none; b=KP2nc1ihBKIDodu9AMOO3l6xMDO2HKZaJjV+6EQPiXYf/l/RjgW5k7dNlwlssBHhbdoIJNzQXrI7XtpHTK88gFaf/MBELZKS4+iQY3OD5t4+hDPLCrb5XoNifej0U8KFACdgL6mBXdKkgoEyVyDMTonfqJe3QgZ4TV9oRF5MBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493482; c=relaxed/simple;
	bh=6DYZBiBmWBZuBfHQPTj9QubUeg0f5W25AkMQ7NnxwmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCBM7h3DQySA66yxvXn/GsQMOXxT8s10R6jLunW928GXB2o6iOm02anmj2S0iEQUVwiwE7aUowbqb79bail6zcR0ZjJBbIsIWo7GeuKJPXqkIpU3BT2QRF49XG3yOq7R56fZh5tfjt0k7a5H0C1nB4PfIqOlneQYlAhAR6oXNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cb47387ceso69985345ad.1;
        Wed, 13 Nov 2024 02:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493480; x=1732098280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VFf/Xc2nlS+yNT+I41QxsowbM1i+EaeG4ziE6m3Pdg=;
        b=Mzh+Hvf8tWpETTMhLAZimu+YFDPBjOywYO9KHCGuCR4oZ4135jwZWvuRb2WZ9gzlLY
         lfWtP9dRe9b+eL8Yl42tys7zISP5fsQJg8FPjm2nGm/PDrUibZEMmUJamLuoB3ILpbGd
         9ZSLYZTUlGyqVua2c02UqnAtQpj9dZD16fmqQ6w5wt1eyhf+ZzCKkyz5SipDP5T2LN5Q
         6eLlSzTTZkJnvAwWllmm7aaMIMF9/WOHhuWnOVUiRRnJQzWJNOteTa20sahF0MdvIH8E
         5+VnBukzm91Z9MygPem2QSjJr8jcR9NDEXhqCZJn4eHxJ+RIfENHsAtHGy79ez4bnRQa
         acmA==
X-Forwarded-Encrypted: i=1; AJvYcCVwRt7TofMujYmLmhSICNC8DjLJouiPeJVQtY+Qjn+o1drr+YjjHrJqo1znlF6oous/Rc8kl8kT+RuH@vger.kernel.org, AJvYcCWVbl653C3zJkQ/t/EzUXwryTcfFSuXiPUn7zREctD8eAEe1Tc90GEQhS59sFm9rP4lqsFLF7bdRYg6Wuvf@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNxLMaUm31W8GovCQ1aazPATqUYKAM98YvobkO+noZNP45iV8
	O2KqPzkzlj1VV5c0asKVq/fLecyHpbBEd0dGjIzdS8PGbyBOceI7poBBGcjD
X-Google-Smtp-Source: AGHT+IFSb/mA5H/3i7TQLvmoZyHyUJtwzIpARqLVBlNPqag0PQg8EYQOcAslh6GQNIDQG+qN8oIdMg==
X-Received: by 2002:a17:903:804:b0:211:a6d:85e8 with SMTP id d9443c01a7336-2118359cd69mr195828325ad.39.1731493479845;
        Wed, 13 Nov 2024 02:24:39 -0800 (PST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3f4fe5esm1109035a91.49.2024.11.13.02.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:24:39 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720c286bcd6so6044841b3a.3;
        Wed, 13 Nov 2024 02:24:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUV1Zph9MO1HVL1xSpot84yR4rznbKGB30yXFdJwqir5CgNTGKhWiodPNpV+XR076X8OhGD/6P6GoZpv7VR@vger.kernel.org, AJvYcCVSg4HbNQPJv4ReQ09D0lo+NSoreoQgQtFx6VTqg5zen/W2gNYgdT79d8m5B2p2/PLAino97OXkz0g9@vger.kernel.org
X-Received: by 2002:a05:6a00:14d3:b0:71e:659:f2e7 with SMTP id
 d2e1a72fcca58-724132a1a87mr26548820b3a.8.1731493479293; Wed, 13 Nov 2024
 02:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-4-tszucs@linux.com>
 <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se> <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
 <9330ebb370780c001fd2aaee49aec9e8@manjaro.org> <CA+GksrJjDPve29Vh7ZFhM+JFp058xmXZAPeuLuFth7v=JeiH2w@mail.gmail.com>
 <0eb19e4daf2cdf3d4a04935876c3d3b0@manjaro.org>
In-Reply-To: <0eb19e4daf2cdf3d4a04935876c3d3b0@manjaro.org>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Wed, 13 Nov 2024 11:24:28 +0100
X-Gmail-Original-Message-ID: <CA+Gksr+E-tZe4sKVNa8zpATwdTW_DiOQxOf_Jujf5SURzhSPSg@mail.gmail.com>
Message-ID: <CA+Gksr+E-tZe4sKVNa8zpATwdTW_DiOQxOf_Jujf5SURzhSPSg@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 12:25=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Tamas,
>
> On 2024-11-12 22:04, Tam=C3=A1s Sz=C5=B1cs wrote:
> > On Tue, Nov 12, 2024 at 4:07=E2=80=AFPM Dragan Simic <dsimic@manjaro.or=
g>
> > wrote:
> >> Please correct me if I'm wrong, but isn't this UART supposed to be
> >> used for the Bluetooth part of an SDIO WiFi + Bluetooth module, in
> >> form of a non-standard M.2 module that Radxa sells?
> >
> > UART8 is supposed to be used for any radio module connected to the M2E
> > connector.
> > It will typically be responsible for Bluetooth or BLE but it could be
> > 802.15.4 or whatever. In any case, all wanting to use it will need the
> > uart8 node enabled.
>
> I see, but I'm still guessing what's the actual use of enabling the
> UART8 when it will remain pretty much useless without the additional
> DT configuration, such as in the WiFi+Bluetooth DT overlay that Jonas
> sent a bit earlier?

The actual use is device enablement.

>
> I think that the UART8 should be enabled together with something that
> actually makes use of it, which in this case unfortunately cannot be
> automatically detected and configured, so it belongs to a DT overlay.
> I'll get back to this in my next response.

I agree, bluetooth blocks dedicated to specific modules should belong
to DT overlays.

>
> >> With that in mind, I see very little sense in just enabling the UART,
> >> without defining the entire Bluetooth interface, which AFAIK produces
> >
> > Defining a bluetooth node would hardwire idiosyncrasies of a given
> > radio module's Bluetooth core. Sure you could add a sleep clock, all
> > kind of sideband signals for wakeups, reset, power down, etc. But hey,
> > some will use them, some won't. I think it's undesirable and
> > unnecessary. You can hciattach from here and most will work just like
> > that. Tighter integration or anything special, module specific on top
> > should be handled individially, on a case-by-case basis. This is a dev
> > board after all. I say trick of all trades.
> >
> >> nasty looking error messages in the kernel log when there's actually
> >> nothing connected to the UART.
> >
> > My dmesg is clean as a whistle
> > root@rock-3b:~# dmesg | grep -E 'fe6c0000|ttyS0'
> > [    0.344818] fe6c0000.serial: ttyS0 at MMIO 0xfe6c0000 (irq =3D 26,
> > base_baud =3D 1500000) is a 16550A
> > What kind of nasty errors do you recall?
>
> Those would be the kernel error messages produced with the Bluetooth
> DT configuration in place, but with no SDIO module installed.

These are the kernel messages related to UART8 with the uart8 DT node
enabled and an SDIO module installed.

