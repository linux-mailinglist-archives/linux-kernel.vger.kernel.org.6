Return-Path: <linux-kernel+bounces-304757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99220962472
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F87284BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD7169AD0;
	Wed, 28 Aug 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JrshnpEN"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681715B98E;
	Wed, 28 Aug 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840046; cv=none; b=l7eI0Ajy1Rlr8nSvZQZastIyrG4Co/Xv3qlvnmz5TXW1RUsIObXZIedfGfR9Rwv+qOLyWfSWIBeChh+ZEFkdp4Ytwhc/nJ0RyWf7FFM5EE4iMJffSeUQa89SVomxq6L3J/jwhPPU1KZd/rRUnPoUm0yxsmQDEgOyvg4KVewq49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840046; c=relaxed/simple;
	bh=H/spxYuv25xMJd7avzns1jDAaEpUBgBfR27818iNls0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPFQOSgxIm1MCSZynA/tTNlAMTUfQJkHMAO/QIrSStt990XJ+7HUN7lCWkep+BCog/plI8n2RzOmCVPTpFUsXI77SDULsHk+BBJroE5n7ZBY7MUDIU2qqyXh0nLGeFDBWT+Ne3d9uU7vvw4wvf1S2znRDvul//cK9bbJq84SPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JrshnpEN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C92840006;
	Wed, 28 Aug 2024 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724840041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CB6BO/KLb4RXq0NQixkj5jR5dZS0zY9MFbOR0+McABQ=;
	b=JrshnpENn0+8kCxDPw+vOidiPhzUcXXxucnC4nGtiyuMRWQidOL3DVsxiasc3vXZAwp7B4
	ew2l+EBphQqvvPq1Dunr2Ct/olGkJG2cjbyKTzCvHAeXMlUZPOOG97soXRXRPsLJ0Akx0X
	eCKbfO9xYw6SOFggoIG70At4MjJ5CRAXOZpqWKL6dNEvd6Pm8fIbCuMxhhf3RcgYTS3w2K
	E6zmQcXPVI4E8tXnNmB7eqFE+77qXR+MYOSQn4wUN0szD+lFZ9R0mWxRG8dOjbE9T5Y9ec
	Jaln9w4t/Z2bHbqgkbc9U1A5YUN1GORqMR8PY3cNOHOR391NqdjmaUMqbu7w/Q==
Date: Wed, 28 Aug 2024 12:14:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>, nicolas.ferre@microchip.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: microchip: Use SCKC_{TD, MD}_SLCK IDs for
 clk32k clocks
Message-ID: <2024082810140092b1c3d7@mail.local>
References: <20240826173116.3628337-1-claudiu.beznea@tuxon.dev>
 <20240826173116.3628337-4-claudiu.beznea@tuxon.dev>
 <8ae724e3-f467-4df4-b8cc-f03489bd0f35@tuxon.dev>
 <20240828-chivalry-brunch-7e21bd12b7fa@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-chivalry-brunch-7e21bd12b7fa@thorsis.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 28/08/2024 09:07:05+0200, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Mon, Aug 26, 2024 at 08:42:10PM +0300 schrieb claudiu beznea:
> > 
> > 
> > On 26.08.2024 20:31, Claudiu Beznea wrote:
> > > Use the newly introduced macros instead of raw number. With this device
> > > tree code is a bit easier to understand.
> > > 
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > > ---
> > >  arch/arm/boot/dts/microchip/sam9x60.dtsi | 18 +++++++++---------
> > >  arch/arm/boot/dts/microchip/sama7g5.dtsi | 16 ++++++++--------
> > >  2 files changed, 17 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > index 04a6d716ecaf..eeda277e684f 100644
> > > --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > @@ -560,7 +560,7 @@ tcb0: timer@f8008000 {
> > >  				#size-cells = <0>;
> > >  				reg = <0xf8008000 0x100>;
> > >  				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
> > > -				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k 0>;
> > > +				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k SCKC_MD_SLCK>;
> > 
> > Actually, looking again at it, I don't know if it worth as we use numbers
> > directly also for other PMC clock IDs.
> 
> I think in this case it is worth it.  The macros you added are more
> like the already existing PMC_MCK et al. macros for PMC_TYPE_CORE and
> do essentially the same thing in driver code working as somewhat
> arbitrary array index, without relation to SoC internals.
> 
> The PMC clock IDs on the other hand are for PMC_TYPE_PERIPHERAL and
> are that long list in the Peripheral Identifiers table and correspond
> to the SoC internal IDs, which are not used in the same way.
> 
> So from my point of view, the patch series is valuable and should be
> further worked on.
> 

I agree with this.

> Greets
> Alex
> 
> > Sorry for the noise,
> > Claudiu Beznea
> > 
> > 
> > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

