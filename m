Return-Path: <linux-kernel+bounces-248883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B14392E32A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6BC1C20FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E515573B;
	Thu, 11 Jul 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYFbomGL"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63A2D02E;
	Thu, 11 Jul 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689007; cv=none; b=FqTmUMzODKBRIEJrsN8xWIlfTWyoq6GOO7n51ZLHdjoAWkK5Y+lRNS4bjw/uaMlFFr5PLUcF8DiE8JP7i6t2xFTtO4IPf6D8Vj+dhNtjRMlEhuAXsGm3MoOuUCet34otHjBJXEYs48KgpxtMbBal3vb2uC2tXc1aDYM2gKHhIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689007; c=relaxed/simple;
	bh=+oy0Z7r4tpSnJtqI7rCdzd5clp5UFBQ7gpr3Bk9pXzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAbRThmHkBaINUlUo5ysmIIYOe48VEOxQPPZ2zZrTBP8D/NoOFO+Lf3+9ef3ANb/cbLLYuMQDbApvWO988Pugcp7oBY2JH6ifH9PFhDL17YyeKCV5hIrhDkK78W5/jgZEl+BXFa+6ewTDP3ZgQvZMruTFfhMPPlukXdbugQh1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYFbomGL; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c66b53232aso309154eaf.1;
        Thu, 11 Jul 2024 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720689005; x=1721293805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XsucxGW9Y+TjxP5luc1qfbPrrug0CyYu7la7U7tC3b8=;
        b=aYFbomGLR/CqFTB8jgTQRzuAEOnGo/MXGcWt7/rRINDxEWXGo9WjqHe2MlGoFfuP5Z
         Ge+e3hZW5mixhFW/ifMsEAC82CJXkfHvtttittyuPGaMfIOQO6t4M8MyBoFUdBzW1ou4
         cjqpuuVSZOr4/egRdgrFlntpV4NNgCFXXm2ipvLKk5IslIZG70Xe7oWdN6Ecdo0jJrcZ
         7pUi/N6p3eUczdRuGhwVoQ2vZdfYtuSlv+X0sq61XKLYck/cID5zc+QInjQ7623lvx71
         N6mfZBS7eHxMj4nifplCyxVadh05u0I2fxDFWDCVgi+MBplGtITaKShFc+eFj4BL+d3d
         duhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720689005; x=1721293805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsucxGW9Y+TjxP5luc1qfbPrrug0CyYu7la7U7tC3b8=;
        b=N1p4Yu2+49NSIcTz4qi3NECQdg3aBRVKHqK8U1TW8A94KReFdP0ZhwGzaNRU8or7p+
         1L2wRdS5ohXFsZxWbOUJZ37+YqPyu4YI9YTZlDaSKcMZslQxz7B3ENSkzo6UFAdw+zox
         r84VVoOwQwhULCHBT2eBWwUQaOtfZCXXiq9j17QEojbM4JtoqKkcK1FRvAMSgSir6btq
         Bl7RbDnVGjy9MdnRPc2TqhA54j389nG/LLPJFXVjgkTlStRJg8dFYSjyCg2D62Mrugmc
         S6Dsb9FrmljRqQAAACP8AVJYF2vt9R7QTjk//4tGTiSzPAJyf9OT7vVQuaMe+3N/ZyOl
         TgwA==
X-Forwarded-Encrypted: i=1; AJvYcCUcjSgADkcOpoFTNFzea9xsRn+MBtNA9KG3qVaK7FG/w3PEt6KfKFAnb7NNyKcxi0W3oOdpFo5/slH3NE7Cana8w8UZmgjw3ycQxj6crXr4d3snwvfJhjzyn/1UZ5+7Oh4F0JQ6/pDxhw==
X-Gm-Message-State: AOJu0YyQAGBTGSmDvsXk4u4eB4JFdRoMsufGv9GeJANz/bLWVI543GFm
	G6dYHrq4qe6cpQjWFgDmp6X7VR5FmqxgoGltDjEN61G/PvGYyRjBmZ0ecnMb3Cx+wJgUN3j4p5v
	SCQYn8DRbMQA13K7e3/3oGkswnscRrEQT
X-Google-Smtp-Source: AGHT+IGMwf9afo3OG1lHgS1ygbb9ZfnegCOtYS2szd+hQvD0ovzyg8NehAjnnLFB/W90zesnDvVLncGZ45ZwhA2XryA=
X-Received: by 2002:a4a:51c1:0:b0:5c2:20eb:aebe with SMTP id
 006d021491bc7-5c68e49f1bamr8218134eaf.9.1720689005129; Thu, 11 Jul 2024
 02:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711060939.1128-1-linux.amoon@gmail.com> <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
In-Reply-To: <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 11 Jul 2024 14:39:48 +0530
Message-ID: <CANAwSgQCn3jgiruiLs0cu-C+DguLtnk=msboAh8jNSF4P28gjA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonas,

Thanks for your review comments.

On Thu, 11 Jul 2024 at 14:13, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Anand,
>
> On 2024-07-11 08:09, Anand Moon wrote:
> > Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
> > signals.Each component of PCIe communication have the following control
> > signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
> > high-speed signals and communicate with other PCIe devices.
> > Used by root complex to endpoint depending on the power state.
> >
> > PERST is referred to as a fundamental reset. PERST should be held low
> > until all the power rails in the system and the reference clock are stable.
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
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index 2e7512676b7e..ab3a20986c6a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -301,7 +301,7 @@ &pcie30phy {
> >
> >  &pcie3x4 {
> >       pinctrl-names = "default";
> > -     pinctrl-0 = <&pcie3_rst>;
> > +     pinctrl-0 = <&pcie30x4m1_pins>;
>
> Use of the existing pcie30x4m1_pins group may not be fully accurate for
> the PERST pin. The use of reset-gpios indicate that the PERST pin is
> used with GPIO function and the driver will implicitly change the
> function from perstn_m1 to GPIO. So this may not be best representation
> of the hw, hence my initial suggestion, something like:
>
>         pcie30x4_pins: pcie30x4-pins {
>                 rockchip,pins =
>                         <4 RK_PB4 4 &pcfg_pull_none>,
>                         <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
>                         <4 RK_PB5 4 &pcfg_pull_none>;
>         };
>
> Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
> not just pcie3x4.
>

Ok but it is better to update this in rk3588s-pinctrl.dtsi otherwise
the pcie30x4m1_pins
will not be used at all on all the boards
I will update the PERST pin to RK_FUNC_GPIO on all the pcie2x1l0,
pcie2x1l2 and  pcie30x4
is this ok for you?

> Regards,
> Jonas

Thanks
-Anand
>
> >       reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
> >       vpcie3v3-supply = <&vcc3v3_pcie30>;
> >       status = "okay";
> > @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
> >       };
> >
> >       pcie3 {
> > -             pcie3_rst: pcie3-rst {
> > -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
> > -             };
> > -
> >               pcie3_vcc3v3_en: pcie3-vcc3v3-en {
> >                       rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> >               };
> >
> > base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
>

