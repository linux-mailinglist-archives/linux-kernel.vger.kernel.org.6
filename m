Return-Path: <linux-kernel+bounces-305377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C1962DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3631C23C8F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586BB1A4F27;
	Wed, 28 Aug 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et2wiQwP"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BA188013;
	Wed, 28 Aug 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862890; cv=none; b=U5NWt4q2QBK43+dV6YD6uTFQpJKji9W5heitTQi9QnNrTeuKefD5MAJLC7fVh9XvBtaS0si0sTUbOS+bopoKLgjf7yxj6jmzcae/X+WXp1bkWiJoUXcuJCclrHAynIm6j9wQuRwDz78KYyqq/oUzDJ+3BGlvEzzESyiRQlmJG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862890; c=relaxed/simple;
	bh=YfzGb0LPro++5S5nA+CG5yodr60yKTnJrum7zhR05Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cflUz24cBB/UC2DhhS2pHmKrQ1B7tzP8g9lu9rxElBIVsnB7tizatK8fgzTqKizqAIx4KM44Pfqy6l7LJJkuoB69gpc4TS/9dD4dccNwIJrqQkxby5DUv2s2yh83OBKt9IkQvmXxUzYlyR99kx0xIH7IVx58vqqyDOgcGZc7QE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et2wiQwP; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf6beda038so38602606d6.2;
        Wed, 28 Aug 2024 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724862888; x=1725467688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuFjGisZ0s9lorMlnQsY528nzMQU5B8PlrfpwJpBONQ=;
        b=Et2wiQwPanW4mUrT0yp7Mb6r+5cNz0GI1wxAFGHTSTpLtn++c3z/4Xf6aZVZW5Kpg7
         d0IHW737IIRIoQjtKv1i9JaxTrtQSmcHRFpoj1KkCiG6bf3XRN6JqMDMPVtNQwYswGU1
         aCgK53FkeIDAmhb4gV0dQugpv1VA/8bQ3nYa4k6bdr0wToXI1V4/ecuahhaU/kwEjLLM
         RSKBkAAaQ5ik96krV+W58gqCwswIyVpob+WuKO+bwgJXA5uwRUAEb2o0bwCUYvn/rNX3
         eCL56O41cSYYKIVH3h34BzfZJuy+cSCzZ6fQylwhOf10ofqW9GOYXrPZw6ue32HSBDPt
         bEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862888; x=1725467688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuFjGisZ0s9lorMlnQsY528nzMQU5B8PlrfpwJpBONQ=;
        b=cO5bN4h4VzUREtMfEfyHJHmwUdaSLTtJ+yJSU6P86ceT6QOsrgf+/jxqLZIn6hkROC
         Vs5FwbTnjuAQygpooecob7lQ0wFQbZQYDTEKNDDeEA4a9vz+9A0Hy20X8J6XbqMCc2/N
         KU4nHuF1l6sP4HdZpFEaU1nTQ/q3C7YGoM1x4bafnzAwxYzMyR+pdy9MH0O5xz5gBIVJ
         UqCYEGtIgIBDx9J9EDL8RWghDyFE37PC2tCw1NbA8FCYZwc2l3rNBfHQ5DH3pzexT0XH
         yYNhguLLFvcesCiQLvmOAKVxNRa7X6mSVcNC4CGrfKoTLT7nHfZxr+KDvEONwpOYLFAw
         /uKg==
X-Forwarded-Encrypted: i=1; AJvYcCVsum5pRWcnVlSCkTF6P+9nahjBowx64gS+w61WJ7fGIaNMdCbgyb3P/EzpaSZUrwMS/LVLT1ZMoJnmq9de@vger.kernel.org, AJvYcCXPYlhTJDbLnL/TrtE3qY1c1+nRqCol9kWUd/W1Ipwsap0xUs07pE3tz/dzR7G/jwuE1zq5cX1NDFCs@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxAPM3sRnTE8frfkSbTPRjBJ8dyz4NP1m5hE1zV0XBFoSVbIG
	hEQ+hn6L+X8IRnNmS0W3tMEMt1tiId87KUDEEA4FkXTEHNsqJD+vMIUai16pGFINbRJvxj/i50G
	BkHycCoe0HqHrzIrQodAbgVi8LPM=
X-Google-Smtp-Source: AGHT+IEdSPYuM5tEhcageySN1uqmNtBnz7riesdUz+oTA9a8duoQQ2WG6N/XPTd9KTDRbxK0H5NCr7dqq+l/CZEeLUA=
X-Received: by 2002:a05:6214:5691:b0:6c1:6c71:e889 with SMTP id
 6a1803df08f44-6c33e6467f7mr372946d6.34.1724862887334; Wed, 28 Aug 2024
 09:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com> <20240824184415.o7ehjqm523igqbbi@cornhusk>
 <CAOCHtYiap7JzwEXZ3aHDC+yhXEdoJuyb+q-sZAmbMENHCjtvUw@mail.gmail.com>
In-Reply-To: <CAOCHtYiap7JzwEXZ3aHDC+yhXEdoJuyb+q-sZAmbMENHCjtvUw@mail.gmail.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 28 Aug 2024 11:34:20 -0500
Message-ID: <CAOCHtYg8DTuGncoxKPvTOyKvGrF-zNMwVvKcNWzRHxT5Hvt7nw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: Add k3-am67a-beagley-ai
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>, 
	Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:38=E2=80=AFAM Robert Nelson <robertcnelson@gmail.=
com> wrote:
>
> On Sat, Aug 24, 2024 at 1:44=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:
> >
> > On 12:04-20240822, Robert Nelson wrote:
> > Minor nmits below:
> >
> > > BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> > > hardware single board computer based on the Texas Instruments AM67A,
> > > which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpos=
e
> > > digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA=
),
> > > GPU, vision and deep learning accelerators, and multiple Arm Cortex-R=
5
> > > cores for low-power, low-latency GPIO control.
> > >
> > [...]
> > > +
> > > +     vdd_3v3: regulator-2 {
> > > +             compatible =3D "regulator-fixed";
> > > +             regulator-name =3D "vdd_3v3";
> > > +             regulator-min-microvolt =3D <3300000>;
> > > +             regulator-max-microvolt =3D <3300000>;
> > > +             vin-supply =3D <&vsys_5v0>;
> > > +             regulator-always-on;
> > > +             regulator-boot-on;
> > > +     };
> > > +
> > > +     vdd_mmc1: regulator-mmc1 {
> >
> >         Also responding:
> >
> > > Okay, i'll change these... I already see a problem, as I've got two
> > > 3v3... can we use 'regulator-[0-9]v[0-9]-X' ?
> >
> >
> > let us just call them regulator-3 and so on incrementally. You can
> > already name with regulator-name property. We really don't need the "v'
> > specification here.
>
> Okay, renamed all as `regulator-X`
>
>
> >
> > [...]
> > > +&wkup_i2c0 {
> > > +     pinctrl-names =3D "default";
> > > +     pinctrl-0 =3D <&wkup_i2c0_pins_default>;
> > > +     clock-frequency =3D <100000>;
> > > +     bootph-all;
> > > +     status =3D "okay";
> > > +
> > > +     tps65219: pmic@30 {
> > > +             compatible =3D "ti,tps65219";
> > > +             reg =3D <0x30>;
> > > +             buck1-supply =3D <&vsys_5v0>;
> > > +             buck2-supply =3D <&vsys_5v0>;
> > > +             buck3-supply =3D <&vsys_5v0>;
> > > +             ldo1-supply =3D <&vdd_3v3>;
> > > +             ldo3-supply =3D <&vdd_3v3>;
> > > +             ldo4-supply =3D <&vdd_3v3>;
> > > +
> > > +             pinctrl-names =3D "default";
> > > +             pinctrl-0 =3D <&pmic_irq_pins_default>;
> > > +             interrupt-parent =3D <&gic500>;
> > > +             interrupts =3D <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> > > +             interrupt-controller;
> > > +             #interrupt-cells =3D <1>;
> > > +
> > > +             system-power-controller;
> > > +             ti,power-button;
> > > +             bootph-all;
> >
> > Flip the bootph-all above the system-power-controller to stay within th=
e
> > coding style boundaries?
>
> Fixed!
>
> >
> > > +
> > > +             regulators {
> >         [...]
> > > +};
> > > +
> > > +&sdhci1 {
> > > +     /* SD/MMC */
> > > +     vmmc-supply =3D <&vdd_mmc1>;
> > > +     vqmmc-supply =3D <&vdd_sd_dv>;
> > > +     pinctrl-names =3D "default";
> > > +     pinctrl-0 =3D <&main_mmc1_pins_default>;
> > > +     disable-wp;
> > > +     cd-gpios =3D <&main_gpio1 48 GPIO_ACTIVE_LOW>;
> > > +     cd-debounce-delay-ms =3D <100>;
> > > +     ti,fails-without-test-cd;
> > > +     bootph-all;
> >
> > Nit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> > keep the  bootph property above the vendor prefixed ones..
>
> Fixed!
>
> >
> > > +     status =3D "okay";
> > > +};
> > > --
> > > 2.39.2
> > >
> >
> >
> > Additionally, with dtbs_check on next-20240823, I get:
> >
> > /workdir/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb: leds: led-0: U=
nevaluated properties are not allowed ('linux,default-trigger' was unexpect=
ed)
> > /workdir/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb: leds: led-0:li=
nux,default-trigger: 'oneOf' conditional failed, one must be fixed:
> >
> > Please fix appropriately.
>
> fixed with: linux,default-trigger =3D "off";

Nope, also not allowed..

/builds/RobertCNelson/arm64-multiplatform/KERNEL/arch/arm64/boot/dts/ti/k3-=
am67a-beagley-ai.dtb:
leds: led-0:linux,default-trigger: 'oneOf' conditional failed, one
must be fixed:
'off' is not one of ['backlight', 'default-on', 'heartbeat',
'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern',
'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash',
'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget',
'usb-host', 'usbport']

I guess, 'none' is close... off/etc..

Thanks

--=20
Robert Nelson
https://rcn-ee.com/

