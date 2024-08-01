Return-Path: <linux-kernel+bounces-270625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF27944246
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C192842E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193E213E03A;
	Thu,  1 Aug 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRZDLa8B"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274513D511;
	Thu,  1 Aug 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722487903; cv=none; b=HVaW3arIAv8Ttdo/u/MwcGb3aa1mmMAVvR5mpLCu/gQoKfS8QeNSJDHEtkL0w1nnsa4MQ2eqevESqGKbyOOSzeZbuMLORTZ94slil0474EBgtG/dbRJ6KX0gRNpz5p8BTF9R8U2OEuC3e39hVSv5JXNCRrKyBzfiZ5KKtdNczVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722487903; c=relaxed/simple;
	bh=v67DqagLekYG0xGorf4LsXB5nhxgDvmE07q1FO5GqWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYDgpBQBGswLdiL5Kg7gMgbZeA5YZ/r2NSLhJ67HjVF/FyKah8MrgM1FBqSNMT8476uvC9Ll8KSHDl4Nyde/btKSfxR6rtA+GX39P61J4WFzQBYkVX6+oLCtVm9hmEAy3GPJYuIzjAopWP6gSMvc/lYnITE4zIGzBCObJtUKjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRZDLa8B; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-264988283a3so3885848fac.0;
        Wed, 31 Jul 2024 21:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722487900; x=1723092700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYl8KsqqsE0s43ykwxuKRWn5cuWPZB/M4T0TSnaHMxU=;
        b=dRZDLa8B8tE9TgTW9ckLvNDqsc/XeOXyog9Z21/u/s3LYTcuHz8yszcxeYorlMhXGl
         vruoH3tipIxcCf9nYZGDKh7hU7iSymJN9EykAZFkjF87EC3LW55hGjfY4QikT7obNlWn
         HlCGU3EDEK0kGTtY0rql523y2LtN8iIIQzuDRhj9Q73a+oQoMcmnxmeqIA2OQQ7LYEYg
         f+5zvPVk7P8CMyx8Pnt54de8AKdCXz4IPMvzins2KPgKsUduagwlSNOcayuppazo0HaR
         3eTvtp+pbhqHahplRu6aXUeA9lHLl3H29R2lD/s1XoZMUOmUOP5kLFDpq7xx2Q4Nm0XQ
         fOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722487900; x=1723092700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYl8KsqqsE0s43ykwxuKRWn5cuWPZB/M4T0TSnaHMxU=;
        b=Wq4AdCTMINwE3eoXlAxzeKBLVi5SD8wQxrrxGMszjgLKWyGROpQwrSSf13tHjUzuI6
         ZjVik8pt6q81fnLAuv2hDfaV0IWyRFF2n4BEksgWda00DzMOqW8QQ5LfsxmvWTPvBzv/
         nbo+EKfx19vnQG3gkJppARt5R+UvTj7qfoWzExkn9ihcT7bL/9kJKSP/JLaoCkTNtWap
         MudUvbPQnTY23/SLT46at95/kdGu6cw7JJe4fLWtlszbf9ShfTnqnqeJtn7WA4Z+CPK0
         JiV4zjne3BKxsdtloPpep25YD/24bbbu34/K9xKF4DYiQWeVsF+yXMta1/QICIOYbJKG
         L1pA==
X-Forwarded-Encrypted: i=1; AJvYcCXxeKzBEVPz82ZvN+x0QL0UQBRFpQxjC7B9chWdNLYL1+pWsI1FJOZPdoXsuPiUmRGeMkCg1KUY8Z3J/OQpIjVSSe96/v2guGU/BUTroZSzspcjjKQPHb62LHU5BNEiPZyT7nlJS11Z3Q==
X-Gm-Message-State: AOJu0Yy0fPsga9C9QpIJBxBQE+Iqs94fqCtYjpbb59PoedTiOWFC79jB
	tJ2tSUUCqLBtH2+fuVYiQ/aj318Ov2fPZKmbH4uWgjRmx8KDbudJ+73wleXKlTNZmTRvuuKwj5/
	YZu/lQSaB+SaF5IJkpGgaza0nz5itcKFO
X-Google-Smtp-Source: AGHT+IHR6wMGuB5v7XhS+PnzipAe8hzpgVLf+p2PhmEa/mQGbTDi5yLyHZecqgk+hu4Rvv+XeufuWOp6u1zhwBo0v7k=
X-Received: by 2002:a05:6870:7021:b0:261:12a8:5b69 with SMTP id
 586e51a60fabf-2687a4ec9f1mr1553112fac.18.1722487900472; Wed, 31 Jul 2024
 21:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711060939.1128-1-linux.amoon@gmail.com> <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
 <CANAwSgQCn3jgiruiLs0cu-C+DguLtnk=msboAh8jNSF4P28gjA@mail.gmail.com>
 <6250fa05-7a06-4fa1-a2be-9cb66a2d2822@kwiboo.se> <394ad670-c4ea-432b-8737-89720c526653@rock-chips.com>
In-Reply-To: <394ad670-c4ea-432b-8737-89720c526653@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 1 Aug 2024 10:21:24 +0530
Message-ID: <CANAwSgT+-UcjrH=hhD6fF1qoRMDHuudeKOi8fTpArJfhxy9Unw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kever, Jonas.

On Thu, 1 Aug 2024 at 07:53, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Anand, Jonas,
>
> On 2024/7/11 17:44, Jonas Karlman wrote:
> > Hi Anand,
> >
> > On 2024-07-11 11:09, Anand Moon wrote:
> >> Hi Jonas,
> >>
> >> Thanks for your review comments.
> >>
> >> On Thu, 11 Jul 2024 at 14:13, Jonas Karlman<jonas@kwiboo.se>  wrote:
> >>> Hi Anand,
> >>>
> >>> On 2024-07-11 08:09, Anand Moon wrote:
> >>>> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> >>>> signals.Each component of PCIe communication have the following control
> >>>> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
> >>>> high-speed signals and communicate with other PCIe devices.
> >>>> Used by root complex to endpoint depending on the power state.
> >>>>
> >>>> PERST is referred to as a fundamental reset. PERST should be held low
> >>>> until all the power rails in the system and the reference clock are stable.
> >>>> A transition from low to high in this signal usually indicates the
> >>>> beginning of link initialization.
> >>>>
> >>>> WAKE signal is an active-low signal that is used to return the PCIe
> >>>> interface to an active state when in a low-power state.
> >>>>
> >>>> CLKREQ signal is also an active-low signal and is used to request the
> >>>> reference clock.
> >>>>
> >>>> Signed-off-by: Anand Moon<linux.amoon@gmail.com>
> >>>> ---
> >>>> V2: Update the commit messge to describe the changs.
> >>>>      use pinctl group as its pre define in pinctl dtsi
> >>>> ---
> >>>>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
> >>>>   1 file changed, 1 insertion(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>>> index 2e7512676b7e..ab3a20986c6a 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> >>>> @@ -301,7 +301,7 @@ &pcie30phy {
> >>>>
> >>>>   &pcie3x4 {
> >>>>        pinctrl-names = "default";
> >>>> -     pinctrl-0 = <&pcie3_rst>;
> >>>> +     pinctrl-0 = <&pcie30x4m1_pins>;
> >>> Use of the existing pcie30x4m1_pins group may not be fully accurate for
> >>> the PERST pin. The use of reset-gpios indicate that the PERST pin is
> >>> used with GPIO function and the driver will implicitly change the
> >>> function from perstn_m1 to GPIO. So this may not be best representation
> >>> of the hw, hence my initial suggestion, something like:
> >>>
> >>>          pcie30x4_pins: pcie30x4-pins {
> >>>                  rockchip,pins =
> >>>                          <4 RK_PB4 4 &pcfg_pull_none>,
> >>>                          <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
> >>>                          <4 RK_PB5 4 &pcfg_pull_none>;
> >>>          };
> >>>
> >>> Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
> >>> not just pcie3x4.
> >>>
> >> Ok but it is better to update this in rk3588s-pinctrl.dtsi otherwise
> >> the pcie30x4m1_pins
> >> will not be used at all on all the boards
> > I agree that it is unfortunate that the PERST pin is included in the
> > groups in pinctrl.dtsi, however, for pcie ep mode the pins should more
> > than likely be using the perstn_m1 function and not GPIO, so there are
> > uses for the existing pin groups for ep mode.
> Please note that the pcie30x4m1_pins define in pinctrl.dtsi is somehow
> not correct due to the TRM.
> - The WAKE should always work in GPIO mode, this is totally support by
> SoC, not PCIe controller;
> - The PERST should always work in GPIO mode in PCIe RC mode; and for all
> the rk3588 EP mode
> hardware I have seem, the PERST from RC connect in to board POR instead
> of SoC PERST;
> The PCIe in most of boards works in RC mode, so we should make PERST
> default as GPIO;
> - CLKREQ, it depends on boards, if the board need to support L1SS or
> not, most of the boards
> does not support L1SS, which means CLKREQ works in GPIO mode instead of
> PCIe function.
>

As per the PCIe hardware pin description below,
it seems that PCIE_CLKREQN is NC (Not connected).

[1] https://docs.radxa.com/en/rock5/rock5b/hardware-design/hardware-interface#pcie

Thanks
-Anand

> Thanks,
> - Kever
> > In my opinion using pcie30x4m1_pins as-is and having implicitly changing
> > to GPIO function when driver/usage in the software require it is an okay
> > description of the hw.
> >
> > However, seeing how use of pcie ep is described using its own node in DT
> > I can understand that for rc mode the pin should be changed to GPIO to
> > properly describe the expected usage.
> >
> > When I tried to add similar implicit change to use GPIO function in
> > U-Boot to fix system freeze when improper pinctrl was used, it resulted
> > in some discussions, see [1] ;-)
> >
> > [1]https://lore.kernel.org/u-boot/20240511112821.1156519-1-jonas@kwiboo.se/t/#u
> >
> >> I will update the PERST pin to RK_FUNC_GPIO on all the pcie2x1l0,
> >> pcie2x1l2 and  pcie30x4
> >> is this ok for you?
> > This should probably be reworked in pinctrl.dtsi together with all
> > affected boards and/or use a group override in the board dts.
> >
> > Regards,
> > Jonas
> >
> >>> Regards,
> >>> Jonas
> >> Thanks
> >> -Anand
> >>>>        reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> >>>>        vpcie3v3-supply = <&vcc3v3_pcie30>;
> >>>>        status = "okay";
> >>>> @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
> >>>>        };
> >>>>
> >>>>        pcie3 {
> >>>> -             pcie3_rst: pcie3-rst {
> >>>> -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> >>>> -             };
> >>>> -
> >>>>                pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >>>>                        rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> >>>>                };
> >>>>
> >>>> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip

