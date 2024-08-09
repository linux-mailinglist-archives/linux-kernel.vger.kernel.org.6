Return-Path: <linux-kernel+bounces-280766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A694CED7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465391C20EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B41922EB;
	Fri,  9 Aug 2024 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L17EBObD"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902815ECE2;
	Fri,  9 Aug 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200093; cv=none; b=HA1U6E9uOvZTwcLUwONNAtCjEW8mJPAQA18OGZj4hwtEhpszOMkuFwr5Yq/PGt11Hj69anXP0Ffge0JvfOqj7RfJNHSDLHK9FtvSwQ55KbBnnzx+koIay8uYAJUwcO9YnMJH1PJJFyEQKwmq3yC1KckMbtTgnh8Fz6c+2ch6dTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200093; c=relaxed/simple;
	bh=mzRx+HY5t6Wie2KFsGNeamXf1EWIWdNoeo8LP1R+9Pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuqENNjFR3rpOyA22Orp1n/8NLM8AWUetCiUwJKGtW1F5YW44r91DVxKvncPQsXbQoagClEQdzJkvsY38CwrbRXPAgIUDw2YcCFrvGPml81uh25cIhtVzu6OUbEBEG6fl+E3910POldUsJsmJ8Ea3d5x3UR27VNth1+MA8LwWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L17EBObD; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-264988283a3so1073159fac.0;
        Fri, 09 Aug 2024 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723200090; x=1723804890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/0D7SlJyEWvZp2TIWQ24w8pUyGFffXsilki1ZPLHEw=;
        b=L17EBObDqTDJEqTJ9sVWrWSUQM4F8oW6bZpXLd79xBc3+GxIuxAiddP0E7lB7pXw5s
         VOCEOFAqh3GyOOVa0EjG6IQZVlz+N7cLFmceYinPI5ed/z66WTqgM/O4lLA/Bo+5nd7H
         DE4qJ12AY5zPTx9AhCssPM+5hp7iRUsTWqgKfvX4avlkD26NZ0r1al1GgHBnhK9D4VOU
         eQY0+/bokO8bATnr9BC4/oKCVDlpYbf0CN3yXvj+bic265a4KmKSSbAVxA4mRlwrU36w
         Ycfp7IpW7QiUARh6C2EwXnf/cay/rx1B+3cXfrYvyZCGxHPa7FJHsaMSg3cgzPI34YVY
         Aaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723200090; x=1723804890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/0D7SlJyEWvZp2TIWQ24w8pUyGFffXsilki1ZPLHEw=;
        b=btG+zMBWD7cyWGTUT2U4lWnGH2xwEdTZcg/JPO1Q3IsrMBITaOT8dSZ8E0/lPDfDPp
         yTSVAmRctqwa/5qtkzxPGbxkuJriNqFS5osqDY+niAoPg86AvJyNienWZCMj/vMNxIqS
         knBJOGx8K2MBbpeuv+HZeo/oe2oGPmZqKfSJHMXQjM3jq9t3d/XnxwyUvIEsaLieyaPs
         K/olic9qPeUgV8cekJ8tnRnOiUFTEHkjiB50ZN2X2nnRkoupFPFDsC3+9vPpeckTuFZF
         l7Jd/5p8Axls3BRZxzCOjBJziENIXP+9nGfYDHIPlhoCkIzJxQ3syd1Libv+mtkkfIjq
         +9xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Xvuqu+R6j0ntrLTVmbcClCPffM4eNjkdBediGCzmQhHIvB3IRd7OQLgGRSAQwxljsT8ow/KdF8I/N+S5eLKqLUpV1MFU16hWyodcBBUB2CxxnrJ+mzXIbrAr+QmEoOzujk59cVy98w==
X-Gm-Message-State: AOJu0YwYKGiFYipWlQqWbwi1WsPqpL+Mv8Ga8baHJPuUeK10f6MOTbtC
	33IDXzRlQy7gCXJSkd0eR9LF9yyzoYr5+vJ8BJBjWM7cN8MtsDIn7PuDGcavys0T8AU/Hy1cMUj
	fE6Zr9JWHz8y/NV8SRrvBiV5yPlg=
X-Google-Smtp-Source: AGHT+IGH8NOCeTlZMxn75fyG0afkB+59N6O7DH1dIMeDzn66FMmYVOsrWlUDhiAtoroDUki1LLFizsp2KqWz82XJJQc=
X-Received: by 2002:a05:6870:211:b0:261:8c:da1e with SMTP id
 586e51a60fabf-26c62cb7211mr1146336fac.28.1723200090516; Fri, 09 Aug 2024
 03:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729123709.2981-1-linux.amoon@gmail.com> <17c5e90e-a99d-4e4d-bc18-0366019f0bcf@kwiboo.se>
In-Reply-To: <17c5e90e-a99d-4e4d-bc18-0366019f0bcf@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 Aug 2024 16:11:14 +0530
Message-ID: <CANAwSgTr-FAF63LK3Ac5fTMFYcS3caUXWY5PQSWYDxCwFdDgyA@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: rockchip: Add missing pinctrl wake and
 clkreq for PCIe node
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas

On Fri, 9 Aug 2024 at 15:29, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Anand,
>
> On 2024-07-29 14:37, Anand Moon wrote:
> > Add missing pinctrl settings WAKE and CLKREQ for PCIe 3.0 x4, PCIe 3.0 =
x1
> > and PCIe 2.1 x1 nodes. Each component of PCIe communication have the
> > following control signals: PERST, WAKE, CLKREQ, and REFCLK.
> > These signals work to generate high-speed signals and communicate with
> > other PCIe devices. Used by root complex to endpoint depending on
> > the power state.
> >
> > PERST# is referred to as a fundamental reset. PERST should be held
> > low until all the power rails in the system and the reference clock
> > are stable. A transition from low to high in this signal usually
> > indicates the beginning of link initialization.
> >
> > WAKE# signal is an active-low signal that is used to return the PCIe
> > interface to an active state when in a low-power state.
> >
> > CLKREQ# signal is also an active-low signal and is used to request the
> > reference clock.  L1 sub-states is providing a digital signal
> > (CLKREQ#) for PHYs to use to wake up and resume normal operation.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v5: Merged all 3 patch into single patch, reabse on master
> >     Fix the $subject and commit message.
> >     Drop the RK_FUNC_GPIO for WAKE and CLKREQ as these seignal are
> >     ment for was introduced to allow PCI Express devices to enter
> >     even deeper power savings states (=E2=80=9CL1.1=E2=80=9D and =E2=80=
=9CL1.2=E2=80=9D) while still
> >      appearing to legacy software to be in the =E2=80=9CL1=E2=80=9D sta=
te
> > ---
> >  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 46 +++++++++++++------
> >  1 file changed, 33 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index 966bbc582d89..a1e83546f1be 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -318,7 +318,7 @@ map2 {
> >
> >  &pcie2x1l0 {
> >       pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&pcie2_0_rst>;
> > +     pinctrl-0 =3D <&pcie30x1_pins>;
> >       reset-gpios =3D <&gpio4 RK_PA5 GPIO_ACTIVE_HIGH>;
> >       vpcie3v3-supply =3D <&vcc3v3_pcie2x1l0>;
> >       status =3D "okay";
> > @@ -326,7 +326,7 @@ &pcie2x1l0 {
> >
> >  &pcie2x1l2 {
> >       pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&pcie2_2_rst>;
> > +     pinctrl-0 =3D <&pcie20x12_pins>;
> >       reset-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_HIGH>;
> >       vpcie3v3-supply =3D <&vcc3v3_pcie2x1l2>;
> >       status =3D "okay";
> > @@ -338,7 +338,7 @@ &pcie30phy {
> >
> >  &pcie3x4 {
> >       pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&pcie3_rst>;
> > +     pinctrl-0 =3D <&pcie30x4_pins>;
> >       reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> >       vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> >       status =3D "okay";
> > @@ -363,28 +363,48 @@ hp_detect: hp-detect {
> >               };
> >       };
> >
> > -     pcie2 {
> > -             pcie2_0_rst: pcie2-0-rst {
> > -                     rockchip,pins =3D <4 RK_PA5 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > +     pcie20x1 {
> > +             pcie20x12_pins: pcie20x12-pins {
> > +                     rockchip,pins =3D
> > +                             /* PCIE20_1_2_CLKREQn_M1_L */
> > +                             <3 RK_PC7 4 &pcfg_pull_up>,
> > +                             /* PCIE_PERST_L */
> > +                             <3 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>,
> > +                             /* PCIE20_1_2_WAKEn_M1_L */
> > +                             <3 RK_PD0 4 &pcfg_pull_up>;
>
> Some unanswered questions from v4:
>
> How come you use internal pull-up/down on these pins?

As per the schematic radxa_rock5b_v13_sch.pdf [1] pin description

GPIO3_B0_u    pin for PCIE_PERST_L                      (pcfg_pull_up)
GPIO3_D0_u    pin for PCIE20_1_2_WAKEn_M1_L  (pcfg_pull_up)
GPIO4_A4_d    pin for PCIE30x1_0_WAKEn_M1_L  (pcfg_pull_down)

[1] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock5b_v13_sch.pdf

> And why do they differ for each pcie node in this series?

It also depends on how the pins are defined in the schematics.
I have not made many changes in this series combined in a single patch.

>
> Regards,
> Jonas

Thanks
-Anand
>
> >               };
> > +     };
> >
> > +     pcie30x1 {
> >               pcie2_0_vcc3v3_en: pcie2-0-vcc-en {
> >                       rockchip,pins =3D <1 RK_PD2 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> >               };
> >
> > -             pcie2_2_rst: pcie2-2-rst {
> > -                     rockchip,pins =3D <3 RK_PB0 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > +             pcie30x1_pins: pcie30x1-pins {
> > +                     rockchip,pins =3D
> > +                             /* PCIE30x1_0_CLKREQn_M1_L */
> > +                             <4 RK_PA3 4 &pcfg_pull_down>,
> > +                             /* PCIE30x1_0_PERSTn_M1_L */
> > +                             <4 RK_PA5 RK_FUNC_GPIO &pcfg_pull_down>,
> > +                             /* PCIE30x1_0_WAKEn_M1_L */
> > +                             <4 RK_PA4 4 &pcfg_pull_down>;
> >               };
> >       };
> >
> > -     pcie3 {
> > -             pcie3_rst: pcie3-rst {
> > -                     rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > -             };
> > -
> > +     pcie30x4 {
> >               pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >                       rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> >               };
> > +
> > +             pcie30x4_pins: pcie30x4-pins {
> > +                     rockchip,pins =3D
> > +                             /* PCIE30X4_CLKREQn_M1_L */
> > +                             <4 RK_PB4 4 &pcfg_pull_up>,
> > +                             /* PCIE30X4_PERSTn_M1_L */
> > +                             <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
> > +                             /* PCIE30X4_WAKEn_M1_L */
> > +                             <4 RK_PB5 4 &pcfg_pull_down>;
> > +             };
> >       };
> >
> >       usb {
> >
> > base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
>

