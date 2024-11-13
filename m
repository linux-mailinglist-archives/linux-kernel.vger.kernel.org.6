Return-Path: <linux-kernel+bounces-407387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C19C6CCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FFF01F228DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43781FBF7C;
	Wed, 13 Nov 2024 10:24:33 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD371FBF67;
	Wed, 13 Nov 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731493473; cv=none; b=VvHmbmq2rxv8bzymeISf45/Vof7CrEwcGsqU6p7GjoFfuGXUEcm+ZXoOT9R66oAsQd9z4qkIGgZMpLzqTqAviobQx5/uEUKmo8cCx4YGpmi4ESxzX9v2BWTWS1rRB0QrouNrcrBjrTvArWsPIa+aptHYwMLLxzBSngaUu/MTQ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731493473; c=relaxed/simple;
	bh=alon8YW/cNgGvR3wXE6+HR5oyAWbb5jQlcuF9r9XmyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMuzhgPKvmwg6XaFCt4sJOHlnstLJZLJprZmotE2Q4YA5NV2vf+8Ky3c9v1mPX+1rvMWN8DZFAdlPw1cspzeoU10b0PnouVP4LGOY/M3Z2FyABhyArkf8m/mZR851gQq9jRSCSQbU04H5vw3BG/L0Jh1/06ZF5HXpAXDpPdd4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2114214c63eso56994545ad.3;
        Wed, 13 Nov 2024 02:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731493471; x=1732098271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ3bR7NP6yUdrnlMpAZ95ydSaHbPQlqJpHBl9pVaNIQ=;
        b=NlqES8U2VNKyksvL1Agmp8UZYlHbXK1PTuMf0CuuhTHe4tsXQz1jFHfpU2o+i/xrfx
         G4JMRUj0lLkay0QXC+R6pOqgaQjjMj5PC8IYP9/2+1/OFIXg8pP8eG4/4wwiMhT39bs9
         invnEJUkXcdE9W8m9YqF3QMVXgvaPICqt3JV9s/MXeI8eDMeB68MefI5F3CX4J7+456F
         doCMt770ZebDdWR/Tot0ci61i8FaI3Kpz4MLTVbSKoJt1ya4n6jtxlWpVpKEDE0ET2OD
         F9+Yzwp1t0Y44ZVRH/iNU3FrOZYpM1cMGUGzEX52mA4m1jA0qD/ZeLA/tSTRAm8C2QC6
         i7AA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/yP1eD6yqbiNeMjpL7lo6ePLdesJvgueMZPw81eEzEAOnW1JyHIDD1CoaSG8F7kafge3ER4p4Yy5q8HI@vger.kernel.org, AJvYcCXLy8kCv8S3FlDoDgrqCFZvXpGlAQHtJILyj0hmSsYsg2CjWGbINK4ClY6ikLuzkzA8eOhH6zWqovOS@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQXupjcIHLfoBpt4z/L3y76DuchLvSSAI8slzRvMWh4UaIozR
	bnM7EJxOL3t0+hHzD5lywhHBHX7ZYAD2EXF52o7N6ax5a20SNxBcVz7g+9S1
X-Google-Smtp-Source: AGHT+IGaNkKwif99wBlt/VQEIyEwYdWqDKCnfNmiiRDxp4eA7+txx31kRii49TFcFSDGatfMh1F66w==
X-Received: by 2002:a17:902:c40b:b0:20d:2848:2bee with SMTP id d9443c01a7336-21183507aa0mr275418625ad.16.1731493470973;
        Wed, 13 Nov 2024 02:24:30 -0800 (PST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e59dd7sm107797165ad.176.2024.11.13.02.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:24:30 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cb47387ceso69983795ad.1;
        Wed, 13 Nov 2024 02:24:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCHj45TkYtHVJwClD+qnJVeyK1kGoDM3izmoaGl930Niu/cIxuWp+nNYlt448ghRVBzJHCoegOW3Re@vger.kernel.org, AJvYcCXwIPI1CRfN6ukrF1lk8Fr7Cq6M8teJ/X6nLH2FKtmOPR8ZE3flqTF7aEJBHdjEPSKF1EQVK/M0K5HM6151@vger.kernel.org
X-Received: by 2002:a17:90b:540b:b0:2e1:682b:361a with SMTP id
 98e67ed59e1d1-2e9b177fce7mr25968056a91.28.1731493470115; Wed, 13 Nov 2024
 02:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111181807.13211-1-tszucs@linux.com> <20241111181807.13211-2-tszucs@linux.com>
 <c89c2f16-ffb0-4b61-a962-9705f9f1e0e2@kwiboo.se> <CA+GksrJzkxffSQbuseGFL0=2PDxV+TRevX0-NOkc6FNYLmNgYA@mail.gmail.com>
 <e9ff5387-b3c1-41a7-b251-a12789d25a70@kwiboo.se>
In-Reply-To: <e9ff5387-b3c1-41a7-b251-a12789d25a70@kwiboo.se>
From: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>
Date: Wed, 13 Nov 2024 11:24:18 +0100
X-Gmail-Original-Message-ID: <CA+Gksr+E6_cf46iKEufWLvQwAbsuC15nq6O6N6gP=x2-BVTnSA@mail.gmail.com>
Message-ID: <CA+Gksr+E6_cf46iKEufWLvQwAbsuC15nq6O6N6gP=x2-BVTnSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Add supported UHS-I rates to
 sdmmc0 on rock-3b
To: Jonas Karlman <jonas@kwiboo.se>
Cc: =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, FUKAUMI Naoki <naoki@radxa.com>, Dragan Simic <dsimic@manjaro.org>, 
	Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Tue, Nov 12, 2024 at 11:37=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> Hi Tam=C3=A1s,
>
> On 2024-11-12 15:36, Tam=C3=A1s Sz=C5=B1cs wrote:
> > Hi Jonas,
> >
> > Thank you for pointing this out! I haven't noticed this before. I've
> > done some testing and I believe I am able to reproduce the issue you
> > described, although I cannot confirm the reason.
> > The only occasion I encounter any problems is when a UHS SD card or
> > SDIO device is connected to sdmmc0 during bootup. Sometimes the device
> > is recognized as HS only. Obviously no tuning value reported. Also,
> > sdmmc2 cuts out completely. I'm booting from eMMC and when the SD card
> > is removed in this state I lose my rootfs. Certainly, this needs more
> > attention but it seems to be unrelated to the changes here.
> >
> > I need more time to check but are you sure this SD card during bootup
> > issue is gone with UHS-I disabled?
>
> Yes, the issue is that the io voltage domain must be configured to match
> the io signal voltage used, and to use uhs the voltage changes from 3v3
> to 1v8. Causing a miss-match between io voltage domain config and the
> regulator voltage used during initial probe, unless io-domain driver
> happens to be fully loaded before mmc devices are probed.
>
> >
> > Also, in every other case, when you connect any device to sdmmc0 after
> > bootup, performance and stability is perfect.
> > Interestingly I also don't experience this behavior with an eMMC
> > device and / or an SDIO device connected to sdmmc2 during bootup. Only
> > sdmmc0 is problematic and only during bootup.
>
> Yes, as you have discovered, inserting the sd-card after system has
> booted and io-domain driver has been loaded, everything can work as
> expected with uhs speeds.
>
> Until this probe race condition has been solved booting with a sd-card
> inserted may or may not result in wrong tuning or other related issues.
>
> Because of this I advice not to enable uhs mode for sdmmc0 at this time.

All right, and thank you for the explanation. My hands are full at the
moment but let me think about this.

>
> Regards,
> Jonas
>
> >
> > Any more thoughts on this are very welcome.
> >
> > Kind regards,
> > Tamas
> >
> >
> >
> > Tam=C3=A1s Sz=C5=B1cs
> > tszucs@linux.com
> >
> > On Mon, Nov 11, 2024 at 8:00=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se>=
 wrote:
> >>
> >> Hi Tam=C3=A1s,
> >>
> >> On 2024-11-11 19:17, Tam=C3=A1s Sz=C5=B1cs wrote:
> >>> Add all supported UHS-I rates to sdmmc0 and allow 200 MHz maximum clo=
ck to
> >>> benefit modern SD cards.
> >>>
> >>> Signed-off-by: Tam=C3=A1s Sz=C5=B1cs <tszucs@linux.com>
> >>> ---
> >>>  arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/a=
rm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >>> index 3d0c1ccfaa79..242af5337cdf 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
> >>> @@ -670,8 +670,14 @@ &sdmmc0 {
> >>>       bus-width =3D <4>;
> >>>       cap-sd-highspeed;
> >>>       disable-wp;
> >>> +     max-frequency =3D <200000000>;
> >>>       pinctrl-names =3D "default";
> >>>       pinctrl-0 =3D <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det=
>;
> >>> +     sd-uhs-sdr12;
> >>> +     sd-uhs-sdr25;
> >>> +     sd-uhs-sdr50;
> >>> +     sd-uhs-sdr104;
> >>> +     sd-uhs-ddr50;
> >>
> >> There is an issue with io-domain driver not always being probed before
> >> mmc driver, this typically result in io-domain being configured wrong,
> >> and mmc tuning happen before io-domain is correctly configured.
> >>
> >> You can usually observe this by looking at the tuning value during boo=
t
> >> and comparing it to the tuning value after removing and re-insering a
> >> sd-card.
> >>
> >> Because of this uhs modes was left out from initial DT submission, som=
e
> >> cards will work others wont, sd-uhs-sdr50 is known to be working with
> >> most cards even with the probe order issue.
> >>
> >> Also I thought that lower speeds where implied?
> >>
> >> Regards,
> >> Jonas
> >>
> >>>       vmmc-supply =3D <&vcc3v3_sd>;
> >>>       vqmmc-supply =3D <&vccio_sd>;
> >>>       status =3D "okay";
> >>
>

