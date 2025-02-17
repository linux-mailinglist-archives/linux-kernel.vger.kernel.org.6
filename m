Return-Path: <linux-kernel+bounces-517250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1EAA37E33
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B660188D569
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C11F8EFA;
	Mon, 17 Feb 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="xTkSOCEH"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E851F6694;
	Mon, 17 Feb 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783762; cv=none; b=CvLWz9MqrGlfnW0l6dgs/j8YPm+WPhzLQI4jmrI99CNdMFXDt5jRv3EH35e3kha5RxU0jpOppSTt29SzCPUbi1xtCMrNAPUs/zNcXJ9FPJHfdmIhVWbeyLkNt4gZXUrrD+FdwxIXwqFEvCmadPKcV+gxCU9YA/dOI33MEN8fBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783762; c=relaxed/simple;
	bh=EmYMttKtd2gbGj4ZORK+IVGCTNL4R/NduweQiC/x/ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYRpF2BHvK14iDF91eNlRGFWn99JuDSaw74TMXDIvs2nTRwK63J/H1vu0sj+7RJyLbWzKZi120/CM48P2a9Udfx8zQYAT78YD+HeGITUU+xc66ziHF+WyPGYKitSydnnTVdMa+AM8SxGSIaPa4izaLUsm2UNt/+xV3tIYCBvDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=xTkSOCEH; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E2FB14832A5;
	Mon, 17 Feb 2025 10:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1739783749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EY+jNj4UwnDAQ6YicrxbADHJO/7EvFXIpu5Hh8B3/U=;
	b=xTkSOCEHHSf+HQqMdf/50S7wUNjzN5A0O+8wdVTuPZ0ezA1Yf6Z6nZ6VdecYlRIW/UmqnT
	+TKGoBXEf+hmlle4orH7Vfg42bf9jYRDiXi5eeuKbGP+OgEUWX83LUw8mrcgl7pbJjlH1x
	NdCXbNq2aSprewdPhrdn2YD4/G6kR4bKUre3iwWEHXHl7RxoSwaFTiSBV6291LhqWKF3S1
	yk4ahqS7oxRn+S8eSd5J6Lz9pwDpkQ+ceGlhrNujAELwyaPMelONaDERuU3naTbzOvJ2hK
	fCDCdpBQxrVdjcOYqHpdGIxfpE9pOWJQlJDTFGxYM0kI+OOO6P6GFr/yhvOGHQ==
Date: Mon, 17 Feb 2025 10:15:42 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Peter Rosin <peda@axentia.se>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: microchip: Move address/size-cells properties
 to SoC dtsi
Message-ID: <20250217-jogging-retention-c1947d68bac8@thorsis.com>
Mail-Followup-To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Peter Rosin <peda@axentia.se>,
	"moderated list:ARM/Microchip (AT91) SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250204165205.2375940-1-ada@thorsis.com>
 <c04fc470-5ac7-4cef-98ef-5f06c3315ce4@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c04fc470-5ac7-4cef-98ef-5f06c3315ce4@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Mon, Feb 17, 2025 at 09:05:47AM +0200 schrieb Claudiu Beznea:
> Hi, Alexander,
> 
> 
> On 04.02.2025 18:52, Alexander Dahl wrote:
> > Avoids warnings with board dts files enabling ethernet-controller node
> > together with phy child node(s).
> > 
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >  arch/arm/boot/dts/microchip/at91-dvk_su60_somc.dtsi    | 4 ----
> >  arch/arm/boot/dts/microchip/at91-sam9_l9260.dts        | 2 --
> >  arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts | 2 --
> >  arch/arm/boot/dts/microchip/at91-sam9x60ek.dts         | 2 --
> >  arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi    | 2 --
> >  arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi  | 2 --
> >  arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts    | 2 --
> >  arch/arm/boot/dts/microchip/at91-sama5d2_xplained.dts  | 2 --
> >  arch/arm/boot/dts/microchip/at91-sama5d3_xplained.dts  | 4 ----
> >  arch/arm/boot/dts/microchip/at91-sama7g5ek.dts         | 4 ----
> >  arch/arm/boot/dts/microchip/at91-tse850-3.dts          | 3 ---
> >  arch/arm/boot/dts/microchip/at91-vinco.dts             | 3 ---
> >  arch/arm/boot/dts/microchip/at91rm9200.dtsi            | 2 ++
> >  arch/arm/boot/dts/microchip/at91sam9260.dtsi           | 2 ++
> >  arch/arm/boot/dts/microchip/at91sam9263.dtsi           | 2 ++
> >  arch/arm/boot/dts/microchip/at91sam9g45.dtsi           | 2 ++
> >  arch/arm/boot/dts/microchip/at91sam9x5_macb0.dtsi      | 2 ++
> >  arch/arm/boot/dts/microchip/at91sam9x5_macb1.dtsi      | 2 ++
> >  arch/arm/boot/dts/microchip/sam9x60.dtsi               | 4 ++++
> >  arch/arm/boot/dts/microchip/sam9x7.dtsi                | 2 ++
> >  arch/arm/boot/dts/microchip/sama5d2.dtsi               | 2 ++
> >  arch/arm/boot/dts/microchip/sama5d3_emac.dtsi          | 2 ++
> >  arch/arm/boot/dts/microchip/sama5d3_gmac.dtsi          | 2 ++
> >  arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi        | 2 --
> >  arch/arm/boot/dts/microchip/sama5d3xmb_cmp.dtsi        | 2 --
> >  arch/arm/boot/dts/microchip/sama5d3xmb_emac.dtsi       | 2 --
> >  arch/arm/boot/dts/microchip/sama5d3xmb_gmac.dtsi       | 2 --
> >  arch/arm/boot/dts/microchip/sama7g5.dtsi               | 4 ++++
> >  28 files changed, 28 insertions(+), 40 deletions(-)
> > 
> 
> There are some other warnings triggered by these changes:

Are these somehow mixed due to parallel building?  Some lines don't
make sense to me.  I tried reproducing with `make dtbs W=1` now, and I
think I identified three warnings which match your output.

> 
>   DTC [C] arch/arm/boot/dts/microchip/at91sam9m10g45ek.dtb
> ../arch/arm/boot/dts/microchip/at91rm9200.dtsi:213.29-225.6: Warning
> (avoid_unnecessary_addr_size): /ahb/apb/ethernet@fffbc000: unnecessary
> #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
> property
> /home/claudiu/repos/linux-microchip/build-arm32/arch/arm/boot/dts/microchip/at91rm9200ek.dtb:
> ethernet-phy: 'reg' is a required property

Not sure how at91sam9m10g45ek comes in here, but for at91rm9200ek this
warning is due to eth having a phy subnode without explicit <reg>
address.  I could not determine the address from looking at RM9200-EK
schematics, which states the board would have a DM9161E PHY, and the
datasheet of that PHY.

The at91rm9200.dtsi is just used by two other dts/dtsi files, which do
not have a phy sub node.

We could _not_ add the address/size properties to the eth node in
at91rm9200.dtsi, which would probably make this dts warning go away.
This would violate dt bindings however, namely net/cdns,macb.yaml and
net/ethernet-phy.yaml … so I'm not sure how to proceed here?

> ../arch/arm/boot/dts/microchip/sama5d3_gmac.dtsi:66.29-77.6: Warning
> (avoid_unnecessary_addr_size): /ahb/apb/ethernet@f0028000: unnecessary
> #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
> property
>   also defined at
> ../arch/arm/boot/dts/microchip/at91-sama5d3_ksz9477_evb.dts:50.8-58.3
> ../arch/arm/boot/dts/microchip/sama5d2.dtsi:382.29-393.6: Warning
> (avoid_unnecessary_addr_size): /ahb/apb/ethernet@f8008000: unnecessary
> #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg"
> property

Contrary to other boards using the sama5d2.dtsi the
at91-sama5d2_icp.dts uses a "fixed-link" subnode instead of
"ethernet-phy@?" subnode.  According to
Documentation/devicetree/bindings/net/cdns,macb.yaml this looks okay
to me.  Not sure why dtc throws a warning here.

Same for at91-sama5d3_ksz9477_evb.dts using sama5d3_gmac.dtsi

So in my opinion all three are problems with .dtb where I have no idea
how to solve that:

- microchip/at91rm9200ek.dtb
- microchip/at91-sama5d2_icp.dtb
- microchip/at91-sama5d3_ksz9477_evb.dtb

Suggestions?

Greets
Alex


