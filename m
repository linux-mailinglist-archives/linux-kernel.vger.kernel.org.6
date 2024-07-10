Return-Path: <linux-kernel+bounces-247179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F0592CC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B1F285915
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A3D84A32;
	Wed, 10 Jul 2024 07:51:14 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988735CB8;
	Wed, 10 Jul 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597873; cv=none; b=q8sqywlCEIfm9lfjtr9dOAU+JLA1ncdmoNAzIi1SH6lGJgbrAopRCeCdVnB/8gST5mJmy1ECUpelhUAAE481Z8gEyCPGeHphtCTnsx6vqzUGDFLFNVag2WOty8NzV4fSZwe/Xw4XFxnlhcogio6rYxyYjhby2k/+Q9aMm0KKFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597873; c=relaxed/simple;
	bh=j9D8EnqCO6rUDfX2KsGZvRybWwMp5yvoLvK/MoKl9oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wkv2R4R1Dnm7Y1cMtaPS3wNPZ6YX+QFCJcBxuEAeeajUQGMwRhU+k/1G/XicFqUBn/ANFIPnnqjjsraZ24gLLkwATKqYALgDikJAvw4iHyLfSMjNPiZSNKP9P1AO0brb3Ly5t0X4o9JCl0uP+/1QS4A5eUPhZeg20j42nyyXztM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sRS6O-0005Or-Ip; Wed, 10 Jul 2024 09:51:00 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Anand Moon <linux.amoon@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, quentin.schulz@cherry.de,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/6] Binding and driver for "dumb" clock generators
Date: Wed, 10 Jul 2024 09:50:59 +0200
Message-ID: <4022386.ZaRXLXkqSa@diego>
In-Reply-To:
 <CANAwSgQGoeyy3V9hBNcxFynRgR-rUanUzVN41uFxu0-_OqKKZg@mail.gmail.com>
References:
 <20240709123121.1452394-1-heiko@sntech.de>
 <CANAwSgQGoeyy3V9hBNcxFynRgR-rUanUzVN41uFxu0-_OqKKZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Anand,

Am Mittwoch, 10. Juli 2024, 05:02:57 CEST schrieb Anand Moon:
> On Tue, 9 Jul 2024 at 18:02, Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Rockchip boards with PCIe3 controllers inside the soc (rk3568, rk3588) have
> > external clock generators on the board to generate the needed 100MHz
> > reference clock the PCIe3 controller needs.
> >
> > Often these clock generators need supplies to be enabled to run.
> >
> > Modelling this clock has taken a number of shapes:
> > - The rk3568 Rock-3a modelled the generator-regulator as "phy-supply" [0]
> >   &pcie30phy {
> >         phy-supply = <&vcc3v3_pi6c_03>;
> >         status = "okay";
> >   };
> >   which is of course not part of the binding
> >
> > - On the Rock-5-ITX the supply of the clock generator is controlled by
> >   the same gpio as the regulator supplying the the port connected to the
> >   pcie30x4 controller, so if this controller probes first, both
> >   controllers will just run. But if the pcie30x2 controller probes first
> >   (which has a different supply), the controller will stall at the first
> >   dbi read.
> >
> > - Recent Theobroma-Systems boards (Jaguar and Tiger) modelled their
> >   generator as a combination of fixed clock and gpio-gate, which works
> >   because the generator's vdd-supply is always on and only the output-
> >   enable pin needs to be toggled.
> >
> >
> > So this series attempts to improve the situation by allowing to model
> > these clock generators as actual entities in the devicetree, to not have
> > them just accidentially work or break bindings.
> >
> 
> I was wondering if these changes apply to Radxa Rock 5b SbC, it does not have
> pi6c557 clock generator but the schematic supports GEN_CLK_100MHZ is
> input to CLKin0 which is generated via the VCC3V3_PI6C_05 (100MHz,3.3V,3225)
> regulator.

yes, that is the same setup as on the Rock 5 ITX, see it's patch in
this series.

The difference being that for your Rock 5b it already works by accident,
as the pcie30x4 port-supply and the supply for the clock-generator are
controlled by the same gpio.

So it does make sense to model this correctly for correctness sake, but
there is no immediate need for action, as there is no fault happening
like on the Rock 5 ITX with its two separate ports.


Heiko


> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts#n605
> >
> > Heiko Stuebner (6):
> >   dt-bindings: clocks: add binding for generic clock-generators
> >   clk: add driver for generic clock generators
> >   arm64: dts: rockchip: fix the pcie clock generator on Rock 5 ITX
> >   arm64: dts: rockchip: use clock-generator for pcie-refclk on
> >     rk3588-jaguar
> >   arm64: dts: rockchip: use clock-generator for pcie-refclk on
> >     rk3588-tiger
> >   arm64: dts: rockchip: add pinctrl for clk-generator gpio on
> >     rk3588-tiger
> >
> >  .../bindings/clock/clock-generator.yaml       |  62 ++++++++
> >  .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |  13 +-
> >  .../boot/dts/rockchip/rk3588-rock-5itx.dts    |  34 ++++-
> >  .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |  21 +--
> >  drivers/clk/Kconfig                           |   7 +
> >  drivers/clk/Makefile                          |   1 +
> >  drivers/clk/clk-generator.c                   | 133 ++++++++++++++++++
> >  7 files changed, 251 insertions(+), 20 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/clock-generator.yaml
> >  create mode 100644 drivers/clk/clk-generator.c
> >
> > --
> > 2.39.2
> >
> >
> 





