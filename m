Return-Path: <linux-kernel+bounces-248569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F57E92DF24
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFABD283B80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770FA42AB5;
	Thu, 11 Jul 2024 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faUUmdFt"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A017BBB;
	Thu, 11 Jul 2024 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720672809; cv=none; b=c7RtDGsncvHXG+g/AYayFg3KqU6GE1tDGGE4+ceFzDKz3R8iVveebKqKJ+zvC/L+a/rDHEMXQl3EZOePyY20JeUmXBvvQrLhB63xUhW/EHjE1GjUS8pzAqP0EMPGvkQLltSXpUpkcDqsQCTU5Tuo+e+b8PWk8xfftyV55VC2ZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720672809; c=relaxed/simple;
	bh=sdExBqhbQDOS71TZoII4ug9fRelAQITJjMR9rEs7jQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPUzAcb8PxEw/IfXsLerVA5Q6gBHfZKRuy6Ndv+xA9ZXA019oh4v2xIUnJrc+l/R2fBA4ClhJabBGVR8a9M+WiYjBz7YXB0rH42joCuITgKaj0iSwepamUUOZsreN4JK7CkyjovulEvY5/+zY8CnnOM3B94avlWxz1hQHX/zQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faUUmdFt; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c694d5c5adso223924eaf.3;
        Wed, 10 Jul 2024 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720672807; x=1721277607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Od3R3bcGX+eiybg0jI2BEJpMtPiCU3KF2hR8eo1Z/4=;
        b=faUUmdFtyodijyrQYyfFrbOZ8yvGsAynU6yIvIknhMJZcb4XpsgSX8FgJ4dTNW2EX1
         OxI5A/Xxq6uStRnzf8PpRs0W+wT48hpokAyUlsMj+0ycEwZxW1tGvtYvcSIwGc9aA6LR
         OovtMrBceUhYsORATCloWJfZRT51bCoM4oZbAfPDRB/FfBnvK/TquMMZEiWYIIdhY+Yf
         DxG2NnPQSOF4d66UGzJML8WUZZTJhDnHS8lMXYb3Fw8pqMyEk+ipiwLnq0i6bCUWWdeE
         KE9o1woGJHZq+h5U7D/yX3se9Dloe2F396bioJ5V+BKRM7ivz6skIOj8nMDekqOM+fTw
         XQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720672807; x=1721277607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Od3R3bcGX+eiybg0jI2BEJpMtPiCU3KF2hR8eo1Z/4=;
        b=C434+TbcLIDdNhzElLUayG1J+MERnViJ8zW/N05knJNuCOEoqfcTSRKs4+B/iKsjZF
         mjeZKODBjMZwasUUvqAcm8XFgW3HrM9v4Xis/eegtPgQfg9+jh9JPDimfnbOmP47Q8DS
         mK3BixwMQq7N5q0RzvZ24JfgPulWlQ4ouI4OuYFTw9Ur88+xAr4J4ixRSv9N3a/8pe+E
         7ZnpeYUpa7Youd2RwAS1x+Bjw4EaAB9B2qIBJC4ro33imEgFERkxnD2bnI1os4E6CeaF
         9VCHNs5ITjMv3qQgiil1IpTfmS5OJlQeNZTDSF0AQi9xMssYYOGPNey2UEyqhxYLKtPL
         IMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAY+MlI+9sy4SRvB40c69wc/54NLC12XJBUhVYWRMbboqLO42Jos3FQPDny0DKyb9xaS2efktSZ8i0chnZnwLQ0wIDUyXNODJF7OSgOZrKFMhH3MS5pK0n1m9yxeznax5icEvARt0tAA==
X-Gm-Message-State: AOJu0YwbXk3k02qnAXwsUleFOD/745XrmXPpDJ35VCMY6fC262A8vlzX
	nyqVCPJFncUpE221FMsV0VjyNbPil8YMitc2Uucl/yk7o8m93z19w+pfj6Qr+6Fj5cFJb2gNWJn
	BP5pQcFXZMLdMovO/AJzvZmoiujIm7Txi
X-Google-Smtp-Source: AGHT+IEE8wlvduAXJFfisR7I1tclcoNEn8rpUAB5g3dGOkqwD99eNjtH/GaAJE6cXZhxzKTWgoPhyzZTKR73rm0u4fc=
X-Received: by 2002:a05:6820:179a:b0:5c6:9320:4f1e with SMTP id
 006d021491bc7-5c693204f51mr9884607eaf.6.1720672807275; Wed, 10 Jul 2024
 21:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710142001.7234-1-linux.amoon@gmail.com> <84dc40f4-1948-4eb7-b16e-8a79357c2622@kwiboo.se>
 <CANAwSgQr2J_MU1idf5xGt4Q=gSLxLHJSEJGwnnPxWLhRjrx=6Q@mail.gmail.com>
In-Reply-To: <CANAwSgQr2J_MU1idf5xGt4Q=gSLxLHJSEJGwnnPxWLhRjrx=6Q@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 11 Jul 2024 10:09:50 +0530
Message-ID: <CANAwSgQqCtURhjLJSmiN_5sJQVurcaSsDmb6uqN9jyry=w3yXA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Wed, 10 Jul 2024 at 22:04, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Jonas,
>
> On Wed, 10 Jul 2024 at 20:11, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Anand,
> >
> > On 2024-07-10 16:19, Anand Moon wrote:
> > > Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> > > signals. Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> > > nomenclature.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > >  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 20 +++++++++++++------
> > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > index 2e7512676b7e..a9b55b7996cf 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > > @@ -301,7 +301,7 @@ &pcie30phy {
> > >
> > >  &pcie3x4 {
> > >       pinctrl-names = "default";
> > > -     pinctrl-0 = <&pcie3_rst>;
> > > +     pinctrl-0 = <&pcie30x4_perstn_m1 &pcie30x4_clkreqn_m1 &pcie30x4_waken_m1>;
> > >       reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> > >       vpcie3v3-supply = <&vcc3v3_pcie30>;
> > >       status = "okay";
> > > @@ -340,14 +340,22 @@ pcie2_2_rst: pcie2-2-rst {
> > >               };
> > >       };
> > >
> > > -     pcie3 {
> > > -             pcie3_rst: pcie3-rst {
> > > -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> > > -             };
> > > -
> > > +     pcie30x4 {
> > >               pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> > >                       rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> > >               };
> > > +
> > > +             pcie30x4_clkreqn_m1: pcie30x4-clkreqn-m1 {
> > > +                     rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> > > +             };
> > > +
> > > +             pcie30x4_waken_m1: pcie30x4-waken-m1 {
> > > +                     rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> > > +             };
> >
> > Should these not be routed to the clkreqn_m1 and waken_m1 function
> > instead of gpio function?
> >
> > E.g. something like:
> >
> >                 pcie30x4m1_pins: pcie30x4m1-pins {
> >                         rockchip,pins =
> >                                 <4 RK_PB4 4 &pcfg_pull_none>,
> >                                 <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
> >                                 <4 RK_PB5 4 &pcfg_pull_none>;
> >                 };
> >
> > There are other rk35xx boards where only the perstn pin is configured
> > and could use a similar fix.
> >
>
> I understand this grouping for Gpio, but I am not very familiar with
> this feature.

Already we have a group of this pincrtl in the pinctrl.dtsi,
I will use this in my patch.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3588s-pinctrl.dtsi?h=v6.10-rc7#n1775

Thanks for the tip.

Thanks
-Anand

