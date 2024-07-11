Return-Path: <linux-kernel+bounces-249117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A5892E721
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DB1280D97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A1156C61;
	Thu, 11 Jul 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdMXCM/Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B6383B0;
	Thu, 11 Jul 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697895; cv=none; b=lghhfeIZjrClzLe9Xd7fRVJEEeeNPuw9+Cf8eUfo9z+xB9tn9ZHjNbOkPybmBqS3NlzpzFdJYe3M9IHcsquDii7TM9F9yY6SxbdZ1F7fJxiZhLshBZGutLMqyMTLImqcsLsF8p6Uz4hEwMoGZxbBo/TVq34K/qa9CS46nbglKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697895; c=relaxed/simple;
	bh=gzjwilpCt6A2I2VABW8kvku49One7ZUnvij/YpLG/Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4qM5Kta7KgEsSs0gg5AZodzlQ9JYaGOzC/s6BlbdSUFPOOTclV/OMpxTG3hQTJx/A7f2iThXIaMY/2ErLxeZVETp16FjwSsLD8YaWIY/Z9RSZD8BBs5e1my6KlP/y+1DjgUhQejziFCILAQgL8QD4IONK1ePpb9TAXbsS4p/KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdMXCM/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08226C4AF0A;
	Thu, 11 Jul 2024 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720697895;
	bh=gzjwilpCt6A2I2VABW8kvku49One7ZUnvij/YpLG/Ik=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=KdMXCM/QcGtXg41MwyyaJoPvrB/AubK1mihkilTbRAQJSSOC5+M/U8jPO8Dhd7ej3
	 ax8BV+6cpeNmHW8zD49/hrun8A+123yXroTzmSDuq7EOF5NiP4u/z5t1UFKX8MTfcP
	 xuCV7P1kXpGOEaB/evpQtqqOaailxn5eUGJVsxRexXNoQMdECg9jodWhSODCEGCYhK
	 Y/RL1gG6thZJ180AOeQN0X/FjaB+uffHkwyi2VK8Je9Wa95IUahNOpFXNC9axDYc8B
	 mUkppzRMstgZPC8mpnbBHBuniUraD434MfME8BWCL+aUctFBJnRnr3MUSJEORn6V+K
	 sK5Bx4s3VQxow==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so11702961fa.0;
        Thu, 11 Jul 2024 04:38:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUen7X9wFX1RnQNFXSX50R4/Dl/nELis2ONS9v88OP677pq+pnQCGZ5tczkmbukZkdG/Armm0AYDrbtBk6+fhWoUYG7GuLpVFh1S8HP6RMjDAgp4lw4LZG8FfdzvdjPwZ2vZzVJDi9nWA==
X-Gm-Message-State: AOJu0YzA1SGJfRxuYZV9H+JVYAic8GVNvmWa5ca5SC5FyFulIidvQfKp
	96JtURwHI8lhFYLt2RTNTh283mykhFF1T3qfmP8VzSVk3B9i8pfEEvgYAD8RDY3FlsSfAWq81kf
	o3wi9fdxjLSpzc7jR6E/IdOrneWc=
X-Google-Smtp-Source: AGHT+IEfmuPHxaXctRdUhUkgULwRV03dNp3jlTso3tk8TYKA+dY1WV8r9gBxTk683lKSiGskeDkmC+261sV9wDSTUt0=
X-Received: by 2002:a2e:804a:0:b0:2ee:8f3d:e68d with SMTP id
 38308e7fff4ca-2eeb3188cddmr63837251fa.44.1720697893303; Thu, 11 Jul 2024
 04:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711060939.1128-1-linux.amoon@gmail.com> <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
 <CAGb2v65iR9BdAX43gfpBOeKF_B5PFm+RhPwu5FHUfRxCMeqh-w@mail.gmail.com> <e3410560-6dec-41de-ab14-441dbe8e5bb1@gmail.com>
In-Reply-To: <e3410560-6dec-41de-ab14-441dbe8e5bb1@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 11 Jul 2024 19:38:00 +0800
X-Gmail-Original-Message-ID: <CAGb2v66gmZGh-_7r6+ifeH-OfU4npxZNWucS-GhtL91LCSvqvQ@mail.gmail.com>
Message-ID: <CAGb2v66gmZGh-_7r6+ifeH-OfU4npxZNWucS-GhtL91LCSvqvQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Alex Bee <knaerzche@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, Anand Moon <linux.amoon@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 7:13=E2=80=AFPM Alex Bee <knaerzche@gmail.com> wrot=
e:
>
> Am 11.07.24 um 11:17 schrieb Chen-Yu Tsai:
> > On Thu, Jul 11, 2024 at 4:44=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se>=
 wrote:
> >>
> >> Hi Anand,
> >>
> >> On 2024-07-11 08:09, Anand Moon wrote:
> >>> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> >>> signals.Each component of PCIe communication have the following contr=
ol
> >>> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to gener=
ate
> >>> high-speed signals and communicate with other PCIe devices.
> >>> Used by root complex to endpoint depending on the power state.
> >>>
> >>> PERST is referred to as a fundamental reset. PERST should be held low
> >>> until all the power rails in the system and the reference clock are s=
table.
> >>> A transition from low to high in this signal usually indicates the
> >>> beginning of link initialization.
> >>>
> >>> WAKE signal is an active-low signal that is used to return the PCIe
> >>> interface to an active state when in a low-power state.
> >>>
> >>> CLKREQ signal is also an active-low signal and is used to request the
> >>> reference clock.
> >>>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> V2: Update the commit messge to describe the changs.
> >>>      use pinctl group as its pre define in pinctl dtsi
> >>> ---
> >>>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
> >>>   1 file changed, 1 insertion(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/a=
rm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> index 2e7512676b7e..ab3a20986c6a 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> @@ -301,7 +301,7 @@ &pcie30phy {
> >>>
> >>>   &pcie3x4 {
> >>>        pinctrl-names =3D "default";
> >>> -     pinctrl-0 =3D <&pcie3_rst>;
> >>> +     pinctrl-0 =3D <&pcie30x4m1_pins>;
> >>
> >> Use of the existing pcie30x4m1_pins group may not be fully accurate fo=
r
> >> the PERST pin. The use of reset-gpios indicate that the PERST pin is
> >> used with GPIO function and the driver will implicitly change the
> >> function from perstn_m1 to GPIO. So this may not be best representatio=
n
> >> of the hw, hence my initial suggestion, something like:
> >>
> >>          pcie30x4_pins: pcie30x4-pins {
> >>                  rockchip,pins =3D
> >>                          <4 RK_PB4 4 &pcfg_pull_none>,
> >>                          <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
> >>                          <4 RK_PB5 4 &pcfg_pull_none>;
> >>          };
> >>
> >> Similar change should probably also be done for pcie2x1l0 and pcie2x1l=
2,
> >> not just pcie3x4.
> >
> > Can we consider implementing strict mode in the pinctrl driver so we do=
n't
> > have to keep doing this GPIO + pinmux dance?
> >
>
> This is not about drivers, this is DT which is independent from drivers.
> Jonas and I had discussion recently on u-boot mailing list with somebody
> using Open/FreeBSD about exact that topic. Pinctrl mux settings should be
> very explicit, even if it is not required by the linux-driver.

The hardware also prevents you from using GPIOs with any other mux setting.
That is already implied by the compatible string and doesn't need to be
spelled out. The strict driver mode merely enforces this hardware limitatio=
n
without the very explicit setting. One could also say that the driver is
wrong to support conflicting settings.


ChenYu

> Alex
>
> > ChenYu
> >
> >
> >> Regards,
> >> Jonas
> >>
> >>>        reset-gpios =3D <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> >>>        vpcie3v3-supply =3D <&vcc3v3_pcie30>;
> >>>        status =3D "okay";
> >>> @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
> >>>        };
> >>>
> >>>        pcie3 {
> >>> -             pcie3_rst: pcie3-rst {
> >>> -                     rockchip,pins =3D <4 RK_PB6 RK_FUNC_GPIO &pcfg_=
pull_none>;
> >>> -             };
> >>> -
> >>>                pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >>>                        rockchip,pins =3D <1 RK_PA4 RK_FUNC_GPIO &pcfg=
_pull_none>;
> >>>                };
> >>>
> >>> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
> >>
> >>
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>

