Return-Path: <linux-kernel+bounces-304456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F026C962054
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D471F25380
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30D158848;
	Wed, 28 Aug 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="MyIX8Iek"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7315852B;
	Wed, 28 Aug 2024 07:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828833; cv=none; b=omAWzb1OHSuKD6j9HN/3eaohZgAtW2IoGUpUBVFD74IPRCYe/uIrW0aQK3Ly80jwW8QES0ACoWzjd+KQijULE6KZXK7lPdAZz0MkdSSKeKjEDvduBWBfvW3yn7dIgVf0uJMsz96FjMDhK2lf8RcvD1JFGJgKKLgm1HQ0Nzjxszs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828833; c=relaxed/simple;
	bh=SZQ8MmWqyD1UnVlNPpQessNNhy51axfdAx9uFpsunZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFp4epqxRuazCjYg/y7+E1NeX40Aoy0I/DVI1IVYlDUID82/oNbUQou2C7J9Q4cLs49L3WmSkX2XBZmYHVzGOAVkdV4m8GLyec5EjQsCTlPbv0k/2U15j8I9YT5omiO1QytaoZOugWodCiZT2x+X0SU3pYujOc+QrR/HTS5Xexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=MyIX8Iek; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2D851483481;
	Wed, 28 Aug 2024 09:07:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724828827; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=YveW8MNJMQ/wSeyOIIEOplXeFkVWS1wpWaPUQ1l3sG8=;
	b=MyIX8IekILFmGAfenx/7D7jUKZ3EyHqDgfamPvb/F96IFLknxC7qedvz5Skt8188Hx7OhX
	iMHkGqz4CSVvDts1r+2JD1vWh93aVy8ojZAE6wsfIS81PR0sy44Y9fGi6WqvlR1DDvoAHB
	KYSZH9Nz0roL/a4KAwDM7ktHkTf3LOTiCMLhw51cAJHpVhzxONQJN0vDCVXpy1pHoe0Klg
	Vdhe63aRbGxzQI6EdG33TrQX+eALL076WzqPvovSjTw754QQikX+mcnm7nEXQ5yI032bFH
	zq7JmlNUK8NInOywWP189UpOzY2zPdeTHdx7kpaqj9DeanIyjZ9tv+qipev/1w==
Date: Wed, 28 Aug 2024 09:07:05 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: microchip: Use SCKC_{TD, MD}_SLCK IDs for
 clk32k clocks
Message-ID: <20240828-chivalry-brunch-7e21bd12b7fa@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240826173116.3628337-1-claudiu.beznea@tuxon.dev>
 <20240826173116.3628337-4-claudiu.beznea@tuxon.dev>
 <8ae724e3-f467-4df4-b8cc-f03489bd0f35@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae724e3-f467-4df4-b8cc-f03489bd0f35@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Mon, Aug 26, 2024 at 08:42:10PM +0300 schrieb claudiu beznea:
> 
> 
> On 26.08.2024 20:31, Claudiu Beznea wrote:
> > Use the newly introduced macros instead of raw number. With this device
> > tree code is a bit easier to understand.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > ---
> >  arch/arm/boot/dts/microchip/sam9x60.dtsi | 18 +++++++++---------
> >  arch/arm/boot/dts/microchip/sama7g5.dtsi | 16 ++++++++--------
> >  2 files changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > index 04a6d716ecaf..eeda277e684f 100644
> > --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > @@ -560,7 +560,7 @@ tcb0: timer@f8008000 {
> >  				#size-cells = <0>;
> >  				reg = <0xf8008000 0x100>;
> >  				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
> > -				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k 0>;
> > +				clocks = <&pmc PMC_TYPE_PERIPHERAL 17>, <&clk32k SCKC_MD_SLCK>;
> 
> Actually, looking again at it, I don't know if it worth as we use numbers
> directly also for other PMC clock IDs.

I think in this case it is worth it.  The macros you added are more
like the already existing PMC_MCK et al. macros for PMC_TYPE_CORE and
do essentially the same thing in driver code working as somewhat
arbitrary array index, without relation to SoC internals.

The PMC clock IDs on the other hand are for PMC_TYPE_PERIPHERAL and
are that long list in the Peripheral Identifiers table and correspond
to the SoC internal IDs, which are not used in the same way.

So from my point of view, the patch series is valuable and should be
further worked on.

Greets
Alex

> Sorry for the noise,
> Claudiu Beznea
> 
> 
> 

