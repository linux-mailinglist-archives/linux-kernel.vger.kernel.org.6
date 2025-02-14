Return-Path: <linux-kernel+bounces-515219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB1EA361FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D00171248
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0004B267385;
	Fri, 14 Feb 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLW0E1nM"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680A2266EFD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547606; cv=none; b=PN4LSIM42gPIEnCDWPZjyhqROESdHVxt5QeHsZNNmdjpeUG3p3MvDOPgdBzcVMJDEaYqokXqhVieHTubspsbhtLh/sZPBvB2s/leoGBeCfjKk4cc0s4420OPygGqXzoJrz81X7mVz/K7jaQDqpRu5hTCpxXr61nZeSqcIRqTc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547606; c=relaxed/simple;
	bh=Ur1csxx5e9sT2v6HE7Bvi1Gidx/ecW+iVa1/b716UdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah1+e82jBcv4BxP19uh3eH1skqMfYySv1QUuEsAWJlxyXaRhJSoUg31eR/1S/nUV92eAPJa0BWXMbyyrPm5VVVMtDstBhATyiDwsxX180WDVzXcO86Y5eWwCqNgiqwA0YXqmWREb4fo9l0d9faWAKGTjOjPT0Ffgtu3PCof2YE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLW0E1nM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ef7c9e9592so18090467b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739547603; x=1740152403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDlfNVO3NueDu0Qi3f7HcF0fEdO1uHUOCWWSlLIIhqA=;
        b=bLW0E1nMAvMJv7DVSgBs/pbO0Eo91IPzwo+XP6qFqlKS7sDRfHesMHtHo4w4KRuCAV
         qH3nr8wsBMDTS/Fm7xeL7SgCMz4gAq539W8EIbXJvMaKpJ7eynb+3kx+PLr3QOVVR5Hs
         rNZCQ7wioP9rzyB4OstwAh/ECXNgsosdm8i2VbHrGG2O2ockuQkSL0wf7byDfmgGZax8
         7Pc/vykyOHvOX4qYN3zqZQM6Tj4N967NqD+mvHGSVldkTfG317ksIv8bzJW6DGBaK8dh
         57IG1vYnKGWQ01QtJQPsDuhBqGBvveXO6ObSlLtMr2XsUf9luNHHIVl5EfP+jHIVMJE6
         HAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547603; x=1740152403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDlfNVO3NueDu0Qi3f7HcF0fEdO1uHUOCWWSlLIIhqA=;
        b=XLaSlSmutcMAkGqwnXddymmZeFKKGKBYfRFCcxR091SZTGzNsMUeSKhA9nV9VynCQB
         avChxyuVMoTM4vfF1hczjrbarZnzR4tKQyrLY7meWrK/Nb46zjE4SmOXpiSMjcrm8JbD
         4sJw/dNPDlBQ9oI2jRTXpdPRL25Zsad/8KPruu3iFlSTpRrbEAd3CP0WA78MH2dHYfWY
         7tZi8gCzqxVGrQvjv9a2oPZr4ypExekZUETorajqufKhLoefN3CkD6BjfZntKt5VWbxL
         2QqW/xwMYunKvF9oHX5mTAA9nN3zgTNBTbXeBoXSdZUqmfrpNuSKCHMGDA9i/GhbyCC8
         u/lA==
X-Forwarded-Encrypted: i=1; AJvYcCXvgg3t2o/jeb0/21gVjuwOHlGqLqY460HX8HOhboltP+DuS7MyJ6kB0DN34K2Hbh86/WBrrQ9LgYPDxTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TW8UmEXBXhTgtLwR4y1Qi5xMFCpLoHLlKUbWrojkWcBOwTNw
	IPz9WwhJE0RJ1JvcMyezPNEeoYPIVPWjBRtRhKxorCncaIAY3068jgWGonbMxmLXPUYkDbZa7iO
	TsQk7uIZ1ddLw7Lh27XrhmNmgVr8h2a1LO+ZAWKzWLPVtYHyY
X-Gm-Gg: ASbGncsTGt8uxrWqfgGVhfDXRUXZvUR90G5PoN99u7337GCJXr5P5FhVNaTIqVLcWqr
	TgcDAN+uLF3f67cnmKEG5wYazUWFQcBojLg0hIXbWqe/mB/osZgX6e0TiSzGAgqZ+1JWAjZBQmi
	6BWaz6PKFBe60yiCVx0CNEu4+uveS5PrU=
X-Google-Smtp-Source: AGHT+IH8EDa+4ekuWWbXXBr/riLIN3JlPX6Dn3pM/FPKZAsai8Udd4H0wlop9vjoHOYPmZSk7PdvYO6YAK4exwTSyGU=
X-Received: by 2002:a05:6902:188e:b0:e58:173e:abcc with SMTP id
 3f1490d57ef6-e5da8102d3fmr8204636276.8.1739547603265; Fri, 14 Feb 2025
 07:40:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
 <20250212234034.284-4-wachiturroxd150@gmail.com> <40370a0e-775b-42e3-bb6c-8cacaa0482cf@linaro.org>
 <Z67f+lDxISVubiJJ@droid-r8s> <2ed6c5d8-b559-4ffc-b08e-412bab1f7917@linaro.org>
In-Reply-To: <2ed6c5d8-b559-4ffc-b08e-412bab1f7917@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 14 Feb 2025 09:39:52 -0600
X-Gm-Features: AWEUYZlElBm9hQ_fT18iHek-VpX4yHKDlxdz_rBItX0Tc5O4FlTpOcx5z1N4lMA
Message-ID: <CAPLW+4mbJoLHJ7TDcn9z8-WOEAFSiH7wBMt4Rk3fsw0h1wSSMA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: exynos990: define all PERIC USI nodes
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>, alim.akhtar@samsung.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-serial@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:49=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
>
>
> On 2/14/25 6:17 AM, Denzeel Oliva wrote:
> > On Thu, Feb 13, 2025 at 07:38:35AM +0000, Tudor Ambarus wrote:
>
> >> node properties shall be specified in a specific order. Follow similar
> >> nodes that are already accepted, gs101 is one.
> >
> > Not all Exynos SoCs will follow the same order
>
> you an fix them then. Please follow
> https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-o=
f-properties-in-device-node
>
> >
> >> <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_4>;
> >
> > Is
> >
> > GATE(CLK_GOUT_PERIC0_TOP0_IPCLK_4, "gout_peric0_top0_ipclk_4",
> >      "dout_peric0_uart_dbg",
> >      CLK_CON_GAT_GOUT_BLK_PERIC0_UID_PERIC0_TOP0_IPCLKPORT_IPCLK_4,
> >      21, 0, 0), [Mainline CLK]
>
> I don't get this reasoning, sorry.
> >
> > You can find it in the cmucal-node.c driver downstream of the kernel. [=
0]
> >
> >>> +                   };
> >>> +           };
> >>> +
> >>> +           usi0: usi@105500c0 {
>
> cut
>
> >>> +                   serial_2: serial@10550000 {
> >>
> >> why not serial_0 since you're in USI0.
> >
> > Because it is simply displayed in the exynos9830-usi.dtsi [1]
>
> I don't think it matters what downstream specifies for labels. Use what
> common sense says.
>

Yeah, in upstream we don't care about downstream at all. Downstream
code is very often is quite low-quality and doesn't follow mainline
kernel conventions and best practices. Mentioning the downstream code
as an answer to questions like "why it was done this way?" would often
trigger people. In this case I think it should be consecutive
ordering, if there are no very good explanation why it shouldn't be
so. Then aliases can be used in the board dts if you need to keep a
fixed order in the system.

> >
> >>> +           };
> >>> +
> >>> +           usi_i2c_0: usi@105600c0 {
> >>> +                   compatible =3D "samsung,exynos990-usi", "samsung,=
exynos850-usi";
> >>> +                   reg =3D <0x105600c0 0x20>;
> >>> +                   samsung,sysreg =3D <&sysreg_peric0 0x1008>;
> >>> +                   samsung,mode =3D <USI_V2_I2C>;
> >>> +                   #address-cells =3D <1>;
> >>> +                   #size-cells =3D <1>;
> >>> +                   ranges;
> >>> +                   clocks =3D <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_PCLK=
_6>,
> >>> +                            <&cmu_peric0 CLK_GOUT_PERIC0_TOP0_IPCLK_=
6>;
> >>> +                   clock-names =3D "pclk", "ipclk";
> >>> +                   status =3D "disabled";
> >>> +
> >>> +                   hsi2c_1: i2c@10560000 {
> >>> +                           compatible =3D "samsung,exynos990-hsi2c",
> >>> +                                        "samsung,exynosautov9-hsi2c"=
;
> >>> +                           reg =3D <0x10560000 0xc0>;
> >>> +                           interrupts =3D <GIC_SPI 398 IRQ_TYPE_LEVE=
L_HIGH>;
> >>> +                           pinctrl-names =3D "default";
> >>> +                           pinctrl-0 =3D <&hsi2c1_bus>;
> >>> +                           clocks =3D <&cmu_peric0 CLK_GOUT_PERIC0_T=
OP0_IPCLK_6>,
> >>> +                                    <&cmu_peric0 CLK_GOUT_PERIC0_TOP=
0_PCLK_6>;
> >>> +                           clock-names =3D "hsi2c", "hsi2c_pclk";
> >>> +                           #address-cells =3D <1>;
> >>> +                           #size-cells =3D <0>;
> >>> +                           status =3D "disabled";
> >>> +                   };
> >>
> >> shouldn't you define serial and SPI too?
> >
> > As shown in the node it only uses i2c which
> > corresponds to the exynos9830-usi.dts. [2]
>
> If you can't specify all the protocol modes for all the USI nodes, then
> make it clear in the commit message.
>

