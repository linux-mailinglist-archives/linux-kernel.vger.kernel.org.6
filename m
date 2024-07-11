Return-Path: <linux-kernel+bounces-248949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8B392E449
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7DF1F21B15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C415887C;
	Thu, 11 Jul 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DELgQzJC"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255531527A1;
	Thu, 11 Jul 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692685; cv=none; b=T6d5gzagMIBkFUPPxXf9M+qdrCpJ3XRIYDY9Jw3eL8Rc9eTTztE0wBLk7TpgN5gWix8intab1Tg9q3/ft4TXo1gNV0NO9bLix0kCTAWxzSYqyzl7GFI0B33opFJO7MX/eorVpZLXZCCq7L5h+VAvgWFPVGRnNImQ6Rzq3BvtOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692685; c=relaxed/simple;
	bh=rnLNYxYC6p1mpumMYjsgC1M4Y15Dk7aT99vspyuPh2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTjznB8H8Crr+yfXCTjOadhTH+QiWe/al/pnkJWN002amp+ySaG9HjUcaVNFTdxe4Hc7LX5tUE4EVrNwyt3VvEO9p8GZLSZiZ7oX999lHYANs/vdHpSO6oFsbsHzLsUZhohvX0lMfL5ld4+WezXbGSzl9lrQcOPp/PNdzlMnuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DELgQzJC; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c651c521f2so351554eaf.1;
        Thu, 11 Jul 2024 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720692683; x=1721297483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sssdm/mEGaX8VGYzfAqbuhLtQj02OuS8MMuxfvANIDE=;
        b=DELgQzJCpepMPl/0fXdf6piFo/E/blRqHogN/9Dlxo+UdVOQjsnGGV89br4DBAJMcq
         0xjO0Q4z4A8LLV/KC/n8VQ3MiOM8t266OauUyLZ84/66ZDDiSS7pusVTmDko2fBXwJ0T
         to2uOWRNGuyv4+rd0TdfvrHDY+SlhfRcaAHbQCYjeGF4+foHKli7Pj2wnVjCkIjWesID
         jL7xntxKnZHh/31Z+0zCv/xlZJqS2q3togRXLiAsvCBppXHoZeGGabDN/qDgPvYmtHUy
         CAfcx8eMH4Rd0DeL065nnF2zvZxt3jVLIMrAF9npcITQstDbhVfPlR3scltEKx1nMCwt
         6GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720692683; x=1721297483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sssdm/mEGaX8VGYzfAqbuhLtQj02OuS8MMuxfvANIDE=;
        b=O9Le2cJPUy7d3w5mrkRdMlSJoSF0F6bjn2dqciR+K9xTpzslnFSzcMrilFWjnGYMbY
         ImhW1VdEuB2cmcwixQtsGq294KjzO3J/7HvaKMMfRKc4swf/sCaqVKCCISvN1PLNUjxu
         f0jEyup207YMr0RE7BgH4h1u3S17S008snLeSfgDxktifBpLL2Lalu0Eu4rg/7kVP095
         yH63XbJ4zqDejrRLHOWkrR5imIxkITIjIDU/0HtRXHKn3VUcU+pG0wwXbZ1dVun3XXQc
         CFBxbU4lszNjovT/teagj6TrRSqfmSW1QMd8Qi1p2UFcRsE+XgK5v332OjoBoTtkf9/3
         KzaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjFMJQQQP1mPE3h6Beu0YKCcXJk4dEXkGM843iRa5nqQP01DusCrpxLS9g3t2bV1PtvHIAXR209esh6kkos610e5euGbyImTqYUYp6enWEfJLcU9Oj0hex+hv8ShF6KHAfk0lEXWQzhg==
X-Gm-Message-State: AOJu0YyreEVgueETzHuWStoRHb7b8O/f3GVS2nwCAB3gmBpO5eo2Drf1
	djkwzEXIh8JRqs2JNw8YzfDaMt/m4E4xKoZNZj3r3NcB8fVWK+Tvnyy4xTlXXkqjo5b3M3S+BNa
	Jp5FPwqIlQSLl43nb82GolnZd8Pk5DWkK
X-Google-Smtp-Source: AGHT+IH1ttR/75JuJ021My5b2HIIn6/NSlK3cCUvgWvkm1omkLOkdMxUT723shGbnPaKxgwdRxEBdva9+b/Da6UWs40=
X-Received: by 2002:a4a:302:0:b0:5bd:b695:5bf1 with SMTP id
 006d021491bc7-5c68e49e561mr8401082eaf.9.1720692683096; Thu, 11 Jul 2024
 03:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711060939.1128-1-linux.amoon@gmail.com> <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
 <CANAwSgQCn3jgiruiLs0cu-C+DguLtnk=msboAh8jNSF4P28gjA@mail.gmail.com> <6250fa05-7a06-4fa1-a2be-9cb66a2d2822@kwiboo.se>
In-Reply-To: <6250fa05-7a06-4fa1-a2be-9cb66a2d2822@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 11 Jul 2024 15:41:06 +0530
Message-ID: <CANAwSgQdr-SADuKMxZqa=j6mHAC0K1N7nje29RTPm9N5j-++qg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas

On Thu, 11 Jul 2024 at 15:15, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Anand,
>
> On 2024-07-11 11:09, Anand Moon wrote:
> > Hi Jonas,
> >
> > Thanks for your review comments.
> >
> > On Thu, 11 Jul 2024 at 14:13, Jonas Karlman <jonas@kwiboo.se> wrote:
> >>
> >> Hi Anand,
> >>
> >> On 2024-07-11 08:09, Anand Moon wrote:
> >>> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> >>> signals.Each component of PCIe communication have the following control
> >>> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
> >>> high-speed signals and communicate with other PCIe devices.
> >>> Used by root complex to endpoint depending on the power state.
> >>>
> >>> PERST is referred to as a fundamental reset. PERST should be held low
> >>> until all the power rails in the system and the reference clock are stable.
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
> >>>     use pinctl group as its pre define in pinctl dtsi
> >>> ---
> >>>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
> >>>  1 file changed, 1 insertion(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> index 2e7512676b7e..ab3a20986c6a 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>> @@ -301,7 +301,7 @@ &pcie30phy {
> >>>
> >>>  &pcie3x4 {
> >>>       pinctrl-names = "default";
> >>> -     pinctrl-0 = <&pcie3_rst>;
> >>> +     pinctrl-0 = <&pcie30x4m1_pins>;
> >>
> >> Use of the existing pcie30x4m1_pins group may not be fully accurate for
> >> the PERST pin. The use of reset-gpios indicate that the PERST pin is
> >> used with GPIO function and the driver will implicitly change the
> >> function from perstn_m1 to GPIO. So this may not be best representation
> >> of the hw, hence my initial suggestion, something like:
> >>
> >>         pcie30x4_pins: pcie30x4-pins {
> >>                 rockchip,pins =
> >>                         <4 RK_PB4 4 &pcfg_pull_none>,
> >>                         <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
> >>                         <4 RK_PB5 4 &pcfg_pull_none>;
> >>         };
> >>
> >> Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
> >> not just pcie3x4.
> >>
> >
> > Ok but it is better to update this in rk3588s-pinctrl.dtsi otherwise
> > the pcie30x4m1_pins
> > will not be used at all on all the boards
>
> I agree that it is unfortunate that the PERST pin is included in the
> groups in pinctrl.dtsi, however, for pcie ep mode the pins should more
> than likely be using the perstn_m1 function and not GPIO, so there are
> uses for the existing pin groups for ep mode.
>
> In my opinion using pcie30x4m1_pins as-is and having implicitly changing
> to GPIO function when driver/usage in the software require it is an okay
> description of the hw.
>
> However, seeing how use of pcie ep is described using its own node in DT
> I can understand that for rc mode the pin should be changed to GPIO to
> properly describe the expected usage.
>

Thanks for your explanation.

> When I tried to add similar implicit change to use GPIO function in
> U-Boot to fix system freeze when improper pinctrl was used, it resulted
> in some discussions, see [1] ;-)
>
> [1] https://lore.kernel.org/u-boot/20240511112821.1156519-1-jonas@kwiboo.se/t/#u
>
Ok, I get this.

> > I will update the PERST pin to RK_FUNC_GPIO on all the pcie2x1l0,
> > pcie2x1l2 and  pcie30x4
> > is this ok for you?
>
> This should probably be reworked in pinctrl.dtsi together with all
> affected boards and/or use a group override in the board dts.

I will keep these board-specific pinctl changes.

>
> Regards,
> Jonas
>

Thanks
-Anand

