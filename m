Return-Path: <linux-kernel+bounces-305167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD9962A76
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CDE1C22106
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBFB18801A;
	Wed, 28 Aug 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOXRCaMo"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAA18786F;
	Wed, 28 Aug 2024 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724855936; cv=none; b=XOnaVCfPytxJ+cu48dRkD1zFm4+lt8xHYEl0B0K6ZUFIL+4KTxAlGp/I/N60s7s6ckMeqaKLVYbSL9WTsIdrN3kE2LbnVoJp5stIxWpnm0xPn2ZXYbJsApYSbQ022AJsSPg1S87srj2jxuHKXWn9aQwxLPNsA6Zl5g7BNnpsJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724855936; c=relaxed/simple;
	bh=IQGQBX+jR2nhBT1i3nk9PUilott+5xo/VHFcCU9Ixg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0cGt4Dxt0Bk7KFvgP8YK/Eu6IOYVS2Eb3wIVV4NDh+DN7dVOjP2StQGgNxCt00/YKw16gOogQ/Uro2+h2uxUkpdqViVISz1iGzXVl4Qj6BMI011aUkhoFn/9S3RgaxNxntGQBvv6wtMWhM6xDbuTHMvghkPrVK8rKYxqTZRotU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOXRCaMo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf6755323cso39248506d6.1;
        Wed, 28 Aug 2024 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724855933; x=1725460733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNVFsrKviUYVGZsJJS3QcPSjIKYSmns2GgeRHX+s058=;
        b=gOXRCaMo9COx19vHTGlwNsqeXP76Ef9nfHv2PLu3kXvwrJKwDz6iX8YdVDSpoWKxqQ
         n1JRjFEzbgFvt4XpR1VQlqYJv3M+PS60WZd/id51lzIbwdKlTgtJF1DX/03Ukh8i8or0
         MKzFlIhS4xmo+uAB4P4EdLzg4h9QI8PT0uHl9cNLBt7DoDzs/BD+K+meP81uOgduSJ0W
         +06K/+s7yLXCdPtLjMkC8byzGw3raS43xY1Je/y5A5vQocsy1uYkhK97nlj/7mS+awpQ
         WOQ7uDuNtAgkziCrjpXw16OBEl8oeO3oZbZGVma2A/ep5/Q3XF9L9r1lq27DIfMNn17L
         332w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724855933; x=1725460733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNVFsrKviUYVGZsJJS3QcPSjIKYSmns2GgeRHX+s058=;
        b=vQYhYiH7uvq+qe+l2nK0sK1ioIw2kUJ7Iq93lQEJxh3BbEk4CEaJww685w4Y6a9iU2
         VtuvK/yGy3zuiJcMjRIUFF27+zoxV90j1Yiyox8T9FEKbS2z8WyGbdL9td/n2ekWJNHM
         8lgQ5bhHyKaz1Ge2QXEfp7LvDF0HlQ7e9mYz8P+BDjbSNO9S/TJ7VPLYn1ayLGkVlBi4
         zUIe9TeqSzD4y4TFxhrCgNkR+6TE7tSX8R/e0C8glldA48dQqqJJExXGM6CvtgXl7RxJ
         TuftzN9iQa510Kc59M4iqawRVDP3s6Wtwe+xC7lAnhA+Ci3fMVGnYFov1aLvNnFZilYx
         u/3w==
X-Forwarded-Encrypted: i=1; AJvYcCVgbekgUhBmHmNZCYws4Y5fWAiQ/CT48zPLpLnqnI/xKGsQyOffvXK4Sl3pPBHEAmOozK6cC+hZvspEjR6c@vger.kernel.org, AJvYcCXOqx/fgFchNqb+7OPL9DA+m24lSVcDOCy4kQ5qECLqXg3kD3OwEFTB18o53TTDXpHQfj96NDhq//tl@vger.kernel.org
X-Gm-Message-State: AOJu0YzgjAC0NUNQSCS56jRDglwALr55BVF/UYm+LF36A3DBycX1Pgbo
	QKZJ4D1mMeCN26FR/tlRc4iCzFB63bZ22e8MPUB7r8vwP4V1B3Py9AxwOXVrHgEk7D8zQ+Vop/M
	JT3XnYqsNoWMGEQkQgWL4pTGXsZI=
X-Google-Smtp-Source: AGHT+IGAwcK805lN88HxJCO2KKmaM000oC6NPgsN+MFiiYpjLECrEVicxjM41oB53JfL/Q6wCWlpbfeYhMeS/3ctejk=
X-Received: by 2002:a05:6214:2d4a:b0:6c1:6aa0:c21 with SMTP id
 6a1803df08f44-6c3362be690mr20865576d6.3.1724855933306; Wed, 28 Aug 2024
 07:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com>
 <20240822170440.265055-2-robertcnelson@gmail.com> <20240824184415.o7ehjqm523igqbbi@cornhusk>
In-Reply-To: <20240824184415.o7ehjqm523igqbbi@cornhusk>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 28 Aug 2024 09:38:27 -0500
Message-ID: <CAOCHtYiap7JzwEXZ3aHDC+yhXEdoJuyb+q-sZAmbMENHCjtvUw@mail.gmail.com>
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

On Sat, Aug 24, 2024 at 1:44=E2=80=AFPM Nishanth Menon <nm@ti.com> wrote:
>
> On 12:04-20240822, Robert Nelson wrote:
> Minor nmits below:
>
> > BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> > hardware single board computer based on the Texas Instruments AM67A,
> > which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> > digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
> > GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> > cores for low-power, low-latency GPIO control.
> >
> [...]
> > +
> > +     vdd_3v3: regulator-2 {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vdd_3v3";
> > +             regulator-min-microvolt =3D <3300000>;
> > +             regulator-max-microvolt =3D <3300000>;
> > +             vin-supply =3D <&vsys_5v0>;
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     vdd_mmc1: regulator-mmc1 {
>
>         Also responding:
>
> > Okay, i'll change these... I already see a problem, as I've got two
> > 3v3... can we use 'regulator-[0-9]v[0-9]-X' ?
>
>
> let us just call them regulator-3 and so on incrementally. You can
> already name with regulator-name property. We really don't need the "v'
> specification here.

Okay, renamed all as `regulator-X`


>
> [...]
> > +&wkup_i2c0 {
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&wkup_i2c0_pins_default>;
> > +     clock-frequency =3D <100000>;
> > +     bootph-all;
> > +     status =3D "okay";
> > +
> > +     tps65219: pmic@30 {
> > +             compatible =3D "ti,tps65219";
> > +             reg =3D <0x30>;
> > +             buck1-supply =3D <&vsys_5v0>;
> > +             buck2-supply =3D <&vsys_5v0>;
> > +             buck3-supply =3D <&vsys_5v0>;
> > +             ldo1-supply =3D <&vdd_3v3>;
> > +             ldo3-supply =3D <&vdd_3v3>;
> > +             ldo4-supply =3D <&vdd_3v3>;
> > +
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&pmic_irq_pins_default>;
> > +             interrupt-parent =3D <&gic500>;
> > +             interrupts =3D <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-controller;
> > +             #interrupt-cells =3D <1>;
> > +
> > +             system-power-controller;
> > +             ti,power-button;
> > +             bootph-all;
>
> Flip the bootph-all above the system-power-controller to stay within the
> coding style boundaries?

Fixed!

>
> > +
> > +             regulators {
>         [...]
> > +};
> > +
> > +&sdhci1 {
> > +     /* SD/MMC */
> > +     vmmc-supply =3D <&vdd_mmc1>;
> > +     vqmmc-supply =3D <&vdd_sd_dv>;
> > +     pinctrl-names =3D "default";
> > +     pinctrl-0 =3D <&main_mmc1_pins_default>;
> > +     disable-wp;
> > +     cd-gpios =3D <&main_gpio1 48 GPIO_ACTIVE_LOW>;
> > +     cd-debounce-delay-ms =3D <100>;
> > +     ti,fails-without-test-cd;
> > +     bootph-all;
>
> Nit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> keep the  bootph property above the vendor prefixed ones..

Fixed!

>
> > +     status =3D "okay";
> > +};
> > --
> > 2.39.2
> >
>
>
> Additionally, with dtbs_check on next-20240823, I get:
>
> /workdir/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb: leds: led-0: Une=
valuated properties are not allowed ('linux,default-trigger' was unexpected=
)
> /workdir/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dtb: leds: led-0:linu=
x,default-trigger: 'oneOf' conditional failed, one must be fixed:
>
> Please fix appropriately.

fixed with: linux,default-trigger =3D "off";

Thanks!

--=20
Robert Nelson
https://rcn-ee.com/

