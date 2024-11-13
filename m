Return-Path: <linux-kernel+bounces-407457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061DB9C6DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0CEB256EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A52003CC;
	Wed, 13 Nov 2024 11:17:36 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DF1F81A0;
	Wed, 13 Nov 2024 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496655; cv=none; b=cY/QDNiWLMHv/8Bl1eI7fqFKUpQjC+6Lrd3TOlWOFvdbMyqgBW/0PGXDp5P4kcov3fDstPso5dWIpDnWwIC7RjSDCpZ2Be93vx1cOBFnEYAOpngYowMcSILCTKiBK7oy/n3p92gJBoYBkX7jNHewM7NbJmzYbltG+j4UsILHuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496655; c=relaxed/simple;
	bh=kbUd3RndLyVU5DfAC1jtcy4xTCkzDJ9aDZlF1Mu6nHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBtDLFghu5/AzIkmgrs7lWGmEuj5knmiE+C6IXrVL2Nos4REyIN/IBjvKNBy05NQ/xqrwPDkZa+jl0IEQNfazk81I0V0Z0RvLY5Zodt+YwfJdNwyO6EXTG79mIlluRKr61RZBEolGQmhOgvP4KpBfOGt2ZmSMPawKDIo6c8IVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso4390874a12.3;
        Wed, 13 Nov 2024 03:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496653; x=1732101453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoVwZM5PK/KUvFOBHI86j/rHYVrm+oOdI9cHG70GtxE=;
        b=D7X4lq1jt235H9ov2OZnq/2HKEnHZsQMucDLscXdnPOmH82NExUpMTS7BJNYxTgeFq
         0QlbJPaPJPtf1IAcILTofJflJoErW4MBOPCp5eThVdJpw7Ngtdiis2L/mNxfGmotEowY
         hSMD5cd/CPrXj0860ZE5cb7mDCgZpuv6EmwOkplDdaEv7go7gUZ2mIKKyChmZ1Bjnx5J
         Vitq89bsP5UaiEBNdDfszsfjKBXZDUO+zV5pePV0nEDlvFAy3tJo6qKrfkZJEGXCl7ax
         RhGRK8yX+XcpAtLpDNT+TqrsiBJTTEStxev0JKdVFbDxu2G5SSTA+igfKqUw/bzjpelI
         P/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUbcm5BW6ajBNkEJR2UBUvXAu/5UEJpD40r3Kv5V0lOVKGpydGFQTKVyXpqcrCOOfgXv54X5iJJ7WVNakBs@vger.kernel.org, AJvYcCUniVUVR11Rfi79bL23vz3jrTHOUuzmtxz79Su0FyNIpyKtG1EcS462MrVrYB54migM9O1FQdRimQoP@vger.kernel.org
X-Gm-Message-State: AOJu0YzfSSgsPCEgkf0LsuXnJu+rlso4Be7MLWDf5vDxdHnTWDhtTYiB
	BsukuMozvuiMQTmGkMphbbj0WezHhnX+mj6e+8RRnTG55vGFb6Cb4d5T/QL8
X-Google-Smtp-Source: AGHT+IHrYl8P9JVrGuqyacIyejGBHslmPRwt98qa/P6lMKFO3k+foWhYowDZ5SWfizyGo0C05GuB9A==
X-Received: by 2002:a17:90a:ec86:b0:2e1:d5c9:1bc4 with SMTP id 98e67ed59e1d1-2e9e4aa8a19mr7863219a91.7.1731496653480;
        Wed, 13 Nov 2024 03:17:33 -0800 (PST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9f3edd874sm1327554a91.24.2024.11.13.03.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 03:17:33 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720be27db27so5671982b3a.2;
        Wed, 13 Nov 2024 03:17:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDFy1PWDkXLitZhi1Q+XYwVmb/mgFt5q6QGCBo3eKu5d6yItZRpDbvu+1Hhi/RVErJJODUk9CXMqx8asD6@vger.kernel.org, AJvYcCWW2LIFAMwz4SZ9A7kDiGElfhJIBUW3ITuQwRJzvoFK/XgEp1NBRXyWtvuS1fGvQau9rhUoyjqnAH2f@vger.kernel.org
X-Received: by 2002:a05:6a20:a125:b0:1db:d83e:df34 with SMTP id
 adf61e73a8af0-1dc5f8cc25cmr7381994637.8.1731496652970; Wed, 13 Nov 2024
 03:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-4-tszucs@linux.com>
 <4ba81dfa-f276-4e05-b46b-92f50dbcfcc4@kwiboo.se> <CA+GksrJLpeU8x-kjR1Ng3ySf+giiufCsJuBssng9qoX1PjAunA@mail.gmail.com>
 <9330ebb370780c001fd2aaee49aec9e8@manjaro.org> <CA+GksrJjDPve29Vh7ZFhM+JFp058xmXZAPeuLuFth7v=JeiH2w@mail.gmail.com>
 <0eb19e4daf2cdf3d4a04935876c3d3b0@manjaro.org> <CA+Gksr+E-tZe4sKVNa8zpATwdTW_DiOQxOf_Jujf5SURzhSPSg@mail.gmail.com>
 <dc628e6e50239aac65a4424738000612@manjaro.org>
In-Reply-To: <dc628e6e50239aac65a4424738000612@manjaro.org>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Wed, 13 Nov 2024 12:17:20 +0100
X-Gmail-Original-Message-ID: <CA+GksrJCJRW43ex8u3hD-aQ7YdDrTtaNRXGjer6ROFh2N8P3XQ@mail.gmail.com>
Message-ID: <CA+GksrJCJRW43ex8u3hD-aQ7YdDrTtaNRXGjer6ROFh2N8P3XQ@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 11:38=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Tamas,
>
> On 2024-11-13 11:24, Tam=C3=A1s Sz=C5=B1cs wrote:
> > On Wed, Nov 13, 2024 at 12:25=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> On 2024-11-12 22:04, Tam=C3=A1s Sz=C5=B1cs wrote:
> >> > On Tue, Nov 12, 2024 at 4:07=E2=80=AFPM Dragan Simic <dsimic@manjaro=
.org>
> >> > wrote:
> >> >> Please correct me if I'm wrong, but isn't this UART supposed to be
> >> >> used for the Bluetooth part of an SDIO WiFi + Bluetooth module, in
> >> >> form of a non-standard M.2 module that Radxa sells?
> >> >
> >> > UART8 is supposed to be used for any radio module connected to the M=
2E
> >> > connector.
> >> > It will typically be responsible for Bluetooth or BLE but it could b=
e
> >> > 802.15.4 or whatever. In any case, all wanting to use it will need t=
he
> >> > uart8 node enabled.
> >>
> >> I see, but I'm still guessing what's the actual use of enabling the
> >> UART8 when it will remain pretty much useless without the additional
> >> DT configuration, such as in the WiFi+Bluetooth DT overlay that Jonas
> >> sent a bit earlier?
> >
> > The actual use is device enablement.
>
> Hmm, I'll need to think more about how it fits together.
>
> >> I think that the UART8 should be enabled together with something that
> >> actually makes use of it, which in this case unfortunately cannot be
> >> automatically detected and configured, so it belongs to a DT overlay.
> >> I'll get back to this in my next response.
> >
> > I agree, bluetooth blocks dedicated to specific modules should belong
> > to DT overlays.
> >
> >> >> With that in mind, I see very little sense in just enabling the UAR=
T,
> >> >> without defining the entire Bluetooth interface, which AFAIK produc=
es
> >> >
> >> > Defining a bluetooth node would hardwire idiosyncrasies of a given
> >> > radio module's Bluetooth core. Sure you could add a sleep clock, all
> >> > kind of sideband signals for wakeups, reset, power down, etc. But he=
y,
> >> > some will use them, some won't. I think it's undesirable and
> >> > unnecessary. You can hciattach from here and most will work just lik=
e
> >> > that. Tighter integration or anything special, module specific on to=
p
> >> > should be handled individially, on a case-by-case basis. This is a d=
ev
> >> > board after all. I say trick of all trades.
> >> >
> >> >> nasty looking error messages in the kernel log when there's actuall=
y
> >> >> nothing connected to the UART.
> >> >
> >> > My dmesg is clean as a whistle
> >> > root@rock-3b:~# dmesg | grep -E 'fe6c0000|ttyS0'
> >> > [    0.344818] fe6c0000.serial: ttyS0 at MMIO 0xfe6c0000 (irq =3D 26=
,
> >> > base_baud =3D 1500000) is a 16550A
> >> > What kind of nasty errors do you recall?
> >>
> >> Those would be the kernel error messages produced with the Bluetooth
> >> DT configuration in place, but with no SDIO module installed.
> >
> > These are the kernel messages related to UART8 with the uart8 DT node
> > enabled and an SDIO module installed.
>
> Out of curiosity, what M.2 module are you testing it with?

https://www.u-blox.com/en/short-range-radio-modules#Host-based
and some more you don't see here.

Kind regards,
Tamas

