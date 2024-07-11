Return-Path: <linux-kernel+bounces-248888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE492E349
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCB3281EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D51514F111;
	Thu, 11 Jul 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmq/9PBp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731BDDDF;
	Thu, 11 Jul 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689438; cv=none; b=qY/TXwDl+Pj6twwxIwcHMnI3sA3gXwOr/tlqrC/DWtE+ccmJO0d2TjxOJmRe0ESs30ochwIiKN6EHeKHE3xGdT0n9U4tk08tLj0IqbMdp7+EAxMiyDf3nBxXX0KX/IP7y82a7Fyn5N3nvDXCCL9aUIi51Aoxye/GmPSAYACB0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689438; c=relaxed/simple;
	bh=tECCGwY1OlgusfgCcr1+rEQ9zmP+52bDi0SwX5GW63M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4/y9yRPbO8JmdSIv20sx3GslQjIHl9Y1Pc6reU1C6Zi8214UdAsBxOQmmS8sBp0epyLGW2RSln4d1wne3hwHSPVnC+4n1RSH8AXoPKX78QH93q3Vo5eakcPB6Jz9NgzglL8VuzTIkfHarigyyaQmjizpPLehQQ6xvBBkdDIcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmq/9PBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D60C4AF07;
	Thu, 11 Jul 2024 09:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720689438;
	bh=tECCGwY1OlgusfgCcr1+rEQ9zmP+52bDi0SwX5GW63M=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=kmq/9PBpQ8BJOQVUc1LTq9N5hu05r+SjaQ5IjQeqtpn4oKx9JlD0WFzXJOcA0BSbz
	 cT0Aa5xzcsM5pT9zfnwRLaOsQ+923E7BliozltUWLTKe/6Y1WwBd382plU+LvKdrbW
	 Bs2EMmBdmmB5UtaMFcvOwA/vS3uNJn6LwDf7ZL0y3vDYK593i72GCeosaTvZxPjyfg
	 oQq+zOIZW3XEGuZbvwAsmXTLhyf7G9VrhKHBlgBb6B62RhJgI0UsXqfd9T6bpfk6gJ
	 vkyP2r3xoS9GNlVpbiPXyo+rYLxNilWn9mB2c3QruN/vdzelPssUzsu8a55T0Mf3dz
	 tKq/5FIBEsufA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so8537261fa.3;
        Thu, 11 Jul 2024 02:17:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdd3ywy1/yOTrUB0aoJkilRVEDgSO1EPfMjLHwjVKq4iy+4moGqGCBCi4mQr7zYP2jqLwILJFVEGNzUVA9ZeTJpOgVp/35uUNvBBbKm+wnGDzZEv78PfJq+UsT9PLNSrKTjykegFjBXQ==
X-Gm-Message-State: AOJu0YxSkqLHqFttQ1nkJgxUQKexAuObGA1IyaCmhuP6eSKhYvLaHNzz
	vin1ec/6xuy70FciR91q/2cfpUOZjQfkgPHaw1f0Cg+Kmew4pWNk2LJ4uU5tAl/rQ+547URDgEX
	yCeeRLI66/LyTpU82lDL+zdZHQx0=
X-Google-Smtp-Source: AGHT+IGfyS6XEu/kHP9VNipjsPb7FnGJXyJ4CUOh/ZKrY8VHjEHaEg8CWd8+NAhyz3x/GgZTCAkP6MA3bw4fTqw/TO4=
X-Received: by 2002:a2e:9e54:0:b0:2ec:6608:a3af with SMTP id
 38308e7fff4ca-2eeb3103d02mr48694601fa.31.1720689436392; Thu, 11 Jul 2024
 02:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711060939.1128-1-linux.amoon@gmail.com> <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
In-Reply-To: <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 11 Jul 2024 17:17:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v65iR9BdAX43gfpBOeKF_B5PFm+RhPwu5FHUfRxCMeqh-w@mail.gmail.com>
Message-ID: <CAGb2v65iR9BdAX43gfpBOeKF_B5PFm+RhPwu5FHUfRxCMeqh-w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:44=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Anand,
>
> On 2024-07-11 08:09, Anand Moon wrote:
> > Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> > signals.Each component of PCIe communication have the following control
> > signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generat=
e
> > high-speed signals and communicate with other PCIe devices.
> > Used by root complex to endpoint depending on the power state.
> >
> > PERST is referred to as a fundamental reset. PERST should be held low
> > until all the power rails in the system and the reference clock are sta=
ble.
> > A transition from low to high in this signal usually indicates the
> > beginning of link initialization.
> >
> > WAKE signal is an active-low signal that is used to return the PCIe
> > interface to an active state when in a low-power state.
> >
> > CLKREQ signal is also an active-low signal and is used to request the
> > reference clock.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > V2: Update the commit messge to describe the changs.
> >     use pinctl group as its pre define in pinctl dtsi
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index 2e7512676b7e..ab3a20986c6a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -301,7 +301,7 @@ &pcie30phy {
> >
> >  &pcie3x4 {
> >       pinctrl-names =3D "default";
> > -     pinctrl-0 =3D <&pcie3_rst>;
> > +     pinctrl-0 =3D <&pcie30x4m1_pins>;
>
> Use of the existing pcie30x4m1_pins group may not be fully accurate for
> the PERST pin. The use of reset-gpios indicate that the PERST pin is
> used with GPIO function and the driver will implicitly change the
> function from perstn_m1 to GPIO. So this may not be best representation
> of the hw, hence my initial suggestion, something like:
>
>         pcie30x4_pins: pcie30x4-pins {
>                 rockchip,pins =3D
>                         <4 RK_PB4 4 &pcfg_pull_none>,
>                         <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
>                         <4 RK_PB5 4 &pcfg_pull_none>;
>         };
>
> Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
> not just pcie3x4.

Can we consider implementing strict mode in the pinctrl driver so we don't
have to keep doing this GPIO + pinmux dance?

ChenYu


> Regards,
> Jonas
>
> >       reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> >       vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> >       status =3D "okay";
> > @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
> >       };
> >
> >       pcie3 {
> > -             pcie3_rst: pcie3-rst {
> > -                     rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > -             };
> > -
> >               pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >                       rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> >               };
> >
> > base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
>
>

