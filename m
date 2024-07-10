Return-Path: <linux-kernel+bounces-247959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D56B92D6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F23F1C20EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2E195FEF;
	Wed, 10 Jul 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrpvLcFK"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367A193445;
	Wed, 10 Jul 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629303; cv=none; b=Kpd2GydJdIGj1uOe0vivfmwIzpFGDT21qt7BFxzImbhJ1BbRVCN5f1xBE8BX3+uAtXVxFxI4ala32aikRLPKlxIiU80Jqb2d8s/gIW+yAaL5oC+L+QHiT01qEo68pKYh1kJrtogqF7yMScFA8QoTbmeXlGlQz+WWdk9SYDag0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629303; c=relaxed/simple;
	bh=cigVI0/QagXC8kd68wWHO+vt27ycO/n/2ePlPQR9ee4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhZXHI2IKl5QyKsqenNnXT1Hj7xB+4OXPoXRhT4fT1srj4mNAhS3zBUAoOECzl4E98y9XaDqvxzC09c2+4/Nix01hMamM2sLQTGUd003gu/+Ju+DZ+HKxmJP2hMki0jLitdUGjspalNUyPnQWxUv0BSbHK+G6yUMlyHBj0/7GHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrpvLcFK; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c47ad9967cso3473001eaf.2;
        Wed, 10 Jul 2024 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720629301; x=1721234101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9sOw1jVOlPobAJPu4gbAldy0PGuhCOSwT4XWJvQdr+M=;
        b=UrpvLcFKKQdeErGIxvK5HgJTHyxX/Tevi6ZbYWKxo5d73fY5ISpM2RX3YLCDm3vcf5
         VS9v3XzrsQmNcfzGXKFj509UlTb3HjIBrqRgsD+1h78IXkwkLhqF2X5bjAjELxFilENF
         0vq67dkGTZWlS1VU8itIi0V2qUN+5pi96zbwj/68mXZ1BgehtbV354J9bRGfT5DG2BXy
         swvJoOE+1cL/UEIcGLhEOrJaMh3scdX9WUYd3HoqUWnHJInhDkgl912TTxrIsv4T55IT
         w2NK5o6CeZObdwuBmwPzkzRTyOjq10LRBIJ6CJxfHHn6tXyVsmPQnJqeMZTScOUdlV5L
         eCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629301; x=1721234101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sOw1jVOlPobAJPu4gbAldy0PGuhCOSwT4XWJvQdr+M=;
        b=XPMExduuzRpBL6s8pYfRAMh6KQgHDeEIJL7CsSUoK6zcFvmNrW8U/CXSiZmxvimtcB
         CpazMOLVH8SPIvKVra0EAGc08jwDDNfZICsk3Q/mxW0ea1casfhcf0wMesb4KABAxjws
         1jatWXycJCzn24pORl3X8xupghLXB2qYpOdmbhoZti20NTkpnHaXZZzaS/njvVVWe5Um
         q33tvpiaBFwNnfecVAds7ZvXz38dC7PsNY8wUML39NBMpx5sKw+xPcAzIxAQu956arAg
         qfGXzjxUpYo75anD85+4e6+5p7PgAQBMGIqFdlk6Kn5oZ3ySHtz6DPZF1fE199nRuevv
         m7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDNi58nm27Og3VGs0UTQheA95dgf0rlFMKB9t3RW9giSQn/UvU03gi4rzwOGdf4445BxKyaZIJ5HVmo8lo91JeVJWmqx4rXG0sc25n3QaphOsmp6UyBITxv1umOVRhDF0IIMySaJLEAg==
X-Gm-Message-State: AOJu0YxYjN8DzAZ9ONecjWGLY+uCh7OgGe/cAgOk3AuJVdJdLAOLtR75
	o9Jbz4bH/JaVheYTr1fTC/AHYjdYyl4rR7X2NeAp+6kDlUep2bU6atfKzvWx05t4qk+IEW+ClAf
	RZNCJQwi+20a59omEa3QX9+p4hAo=
X-Google-Smtp-Source: AGHT+IF1zYlVf2JrR0UfDR5LnB72Hd9SePyzSM9ncesabGOLw4uWD1oZizxNrLHziXyws/BSSl8GrVl4f4+HnbSyZ4c=
X-Received: by 2002:a4a:ac0c:0:b0:5c6:72fb:103e with SMTP id
 006d021491bc7-5c68e16fb36mr6096218eaf.7.1720629301347; Wed, 10 Jul 2024
 09:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710142001.7234-1-linux.amoon@gmail.com> <84dc40f4-1948-4eb7-b16e-8a79357c2622@kwiboo.se>
In-Reply-To: <84dc40f4-1948-4eb7-b16e-8a79357c2622@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 10 Jul 2024 22:04:44 +0530
Message-ID: <CANAwSgQr2J_MU1idf5xGt4Q=gSLxLHJSEJGwnnPxWLhRjrx=6Q@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

On Wed, 10 Jul 2024 at 20:11, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Anand,
>
> On 2024-07-10 16:19, Anand Moon wrote:
> > Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> > signals. Rename node from 'pcie3' to 'pcie30x4' to align with schematic
> > nomenclature.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 20 +++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index 2e7512676b7e..a9b55b7996cf 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -301,7 +301,7 @@ &pcie30phy {
> >
> >  &pcie3x4 {
> >       pinctrl-names = "default";
> > -     pinctrl-0 = <&pcie3_rst>;
> > +     pinctrl-0 = <&pcie30x4_perstn_m1 &pcie30x4_clkreqn_m1 &pcie30x4_waken_m1>;
> >       reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> >       vpcie3v3-supply = <&vcc3v3_pcie30>;
> >       status = "okay";
> > @@ -340,14 +340,22 @@ pcie2_2_rst: pcie2-2-rst {
> >               };
> >       };
> >
> > -     pcie3 {
> > -             pcie3_rst: pcie3-rst {
> > -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> > -             };
> > -
> > +     pcie30x4 {
> >               pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >                       rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> >               };
> > +
> > +             pcie30x4_clkreqn_m1: pcie30x4-clkreqn-m1 {
> > +                     rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
> > +             };
> > +
> > +             pcie30x4_waken_m1: pcie30x4-waken-m1 {
> > +                     rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
> > +             };
>
> Should these not be routed to the clkreqn_m1 and waken_m1 function
> instead of gpio function?
>
> E.g. something like:
>
>                 pcie30x4m1_pins: pcie30x4m1-pins {
>                         rockchip,pins =
>                                 <4 RK_PB4 4 &pcfg_pull_none>,
>                                 <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
>                                 <4 RK_PB5 4 &pcfg_pull_none>;
>                 };
>
> There are other rk35xx boards where only the perstn pin is configured
> and could use a similar fix.
>

I understand this grouping for Gpio, but I am not very familiar with
this feature.

> Regards,
> Jonas
>
Thanks
-Anand

