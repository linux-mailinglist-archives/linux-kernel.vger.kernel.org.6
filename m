Return-Path: <linux-kernel+bounces-256131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F393497D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827CC280102
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F90978C7E;
	Thu, 18 Jul 2024 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9gd/rU2"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E71BDD0;
	Thu, 18 Jul 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289670; cv=none; b=dFxlaXeLVp8WAg2HJsSPbTQYKF4C21xOQMpPwer/VDlP1duCbA9mYLLL3HdAHqha8SLjwNSjEw5nJ+5LzxDFQkWQOGEqgMdM6+oy9PaFbDuB0+5zt4pLBWhdyDuZKedeX+bCz3s6kQQw1S6DORMN6FNZocfBRAJSKtU01YWcf/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289670; c=relaxed/simple;
	bh=+r29itcdOZPs8Ro3ndVqJq3QUC9n4YzXSoH8LrvIbBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbVzVbo9lF+SWlz5X1EZEZGZQJNUtOX8cTYbSR+EqBIUh+L6Nc1WEuWYgy4ZoWqPdV3I7q+8gE4PZPbS6z9TjMX1WkJbTJI4bkn8+ufjMy3uyaTKzmpYHRYFTOzI+sC1vo9DV5jj2eg70WzJK+v7AistEN9m3wWQ0IBNy+Fh/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9gd/rU2; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5c69848ca98so218507eaf.2;
        Thu, 18 Jul 2024 01:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721289668; x=1721894468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ4KLPCsHLF601xsALWSSWpNdAW9n5m+faKZQ6JL9u0=;
        b=l9gd/rU2AbBWt5edpaR3yPy10RBWZAg/XUZ5OvLm6O0UCm6UlHmKh9hdi90VJXIUfh
         5Va/Xj5mrvy/prXcs3giEZk2hn1uEPYgj5eDFVuzNoCQCslns7LP43vDaG1JRoqaCn8W
         u4QpyccyPeffqxfmePlxPoMgC7Oj5txAr4vLx+JiEwde71RC90mhodr8um+iKZCx1tmX
         nM1Z10sMLsnyZve7gADvzba+xrhOKg7SOFszS2OqWbHWoDefzDT0t6AJawhShKqErCZj
         ss15+eMjM44CzNPgBa+GlQW0r2MuSKKp+7jl9AGnIciRmVfESiz0XdrwWyLdR0Hjs4iU
         VUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289668; x=1721894468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ4KLPCsHLF601xsALWSSWpNdAW9n5m+faKZQ6JL9u0=;
        b=rG5E19YoH886aGwqCO9juhwEq4wqcBmqJPb9ZLBRegQ0khxFVBgLE46+5b4p4IrgQr
         O3DPyRSp19lOJFNEGiDfGrpAPJ+3pyt9p8PrH1oBvCJi77Apt7Knnc+cmtZr+ID306UA
         MB0a1LkFwp3V0srdQ/zKTkzEuUCbBcAtJQpzr3j68Nc8VrZQPP6jtswdYLkWjZ/RprwH
         eqCbjgrZ+cE1Mmv4Wiz9csLLBreT4pBp2yNG+JqY7dz27Erz89MGHEtaS7Zu7lvOIL+o
         5IY8s7q2kthAw1APKy1FatOHDVszXyUP992duNfsT9hM+AyWFD+yRwqwF9p93QtxnPGl
         +hxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuAArFl5V+e06UulfrwspnnLhtpXfMzT8y4gR2QBNOv8lw0Iw+GXShHYaEygXvy/1ikUg6xI1ymHLd5jz7sB3JWU37419i6TvyrKpfFLWbdwej1yr7H37hN5j+Il5z2GzgMgys5cC7kydcVDh88wdNQbmWN6HMjBpT/9FklSUrPT67RQ==
X-Gm-Message-State: AOJu0YxF9Svut7IBT1qYlVGBiUQUr0VT2OqDHCyw4L6PCqZfwc8/ALM0
	Z+cmnw8zNQaBHillqIyvtnYi26XmvDJ7qhJHZmQ1E4GA58cHZEb80Qp6+LWzoVrK759g371z3r8
	e6WMwiPAkiEXu3QbP/67Rw2Wz8PI=
X-Google-Smtp-Source: AGHT+IFI1ZltMngartedHgQwV1wVfgFoB+tXcMaJkFke5b0QVF204SgFc8cQFkPOxZ0NukJ5PoVnX15p8W2AsrPxZh8=
X-Received: by 2002:a05:6820:2782:b0:5c6:5f2d:8430 with SMTP id
 006d021491bc7-5d41a1ce1c7mr4684422eaf.2.1721289668077; Thu, 18 Jul 2024
 01:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715110251.261844-1-heiko@sntech.de> <20240715110251.261844-4-heiko@sntech.de>
 <CANAwSgS_ZaEkt5-kKud9OwdN4za+xvW5SoBr34EmOdU2OQJWnw@mail.gmail.com>
 <8a16eb6a29a39719ba4e4c43bae3b6ec@manjaro.org> <CANAwSgRZR8cM9qDD0Xn5ims4GX+PNMQ1+PEMBDQtZq2GxFd6Rw@mail.gmail.com>
 <72b84761ef93c1d4d6d61b16ef1bb1ce@manjaro.org>
In-Reply-To: <72b84761ef93c1d4d6d61b16ef1bb1ce@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 18 Jul 2024 13:30:51 +0530
Message-ID: <CANAwSgS7qFZ4wbvLOxZ+9k=F7c3mFGo=Ab4aJjLgVu+JhfQneg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: fix the pcie refclock
 oscillator on Rock 5 ITX
To: Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Dragan

On Thu, 18 Jul 2024 at 13:28, Dragan Simic <dsimic@manjaro.org> wrote:
>
> On 2024-07-18 09:52, Anand Moon wrote:
> > On Thu, 18 Jul 2024 at 13:02, Dragan Simic <dsimic@manjaro.org> wrote:
> >> On 2024-07-18 09:26, Anand Moon wrote:
> >> > On Mon, 15 Jul 2024 at 16:35, Heiko Stuebner <heiko@sntech.de> wrote:
> >> >>
> >> >> The Rock 5 ITX uses two PCIe controllers to drive both a M.2 slot and
> >> >> its
> >> >> SATA controller with 2 lanes each. The supply for the refclk
> >> >> oscillator is
> >> >> the same that supplies the M.2 slot, but the SATA controller port is
> >> >> supplied by a different rail.
> >> >>
> >> >> This leads to the effect that if the PCIe30x4 controller for the M.2
> >> >> probes first, everything works normally. But if the PCIe30x2
> >> >> controller
> >> >> that is connected to the SATA controller probes first, it will hang on
> >> >> the first DBI read as nothing will have enabled the refclock before.
> >> >
> >> > I just checked the rk3588-rock-5-itx.dts in the linux-next.
> >> > You have not enabled sata0 and sata2, which might be the problem
> >> > for the SATA controller not getting initialized.
> >>
> >> Rock 5 ITX doesn't use RK5588's built-in SATA interfaces, so that's
> >> fine.
> >> Please have a look at the board schematic, it uses a separate PCI
> >> Express
> >> SATA controller for its four SATA ports.
> >>
> > yes, But I am referring to sata node not enabled which enable
> > the PHY_TYPE_SATA.
> >
> > see rk3588-coolpi-cm5-evb.dts and rk3588-edgeble-neu6a-io.dtsi
> > rk3588-quartzpro64.dts
> > which have sata port on board.
> >
> > &sata0 {
> >         status = "okay";
> > };
>
> QuartzPro64, as an example, uses RK3588's built-in SATA interfaces,
> so it enables sata0 in its board dts.  Rock 5 ITX doesn't do that,
> as I already described.

Ok no problem,

Thanks
-Anand

