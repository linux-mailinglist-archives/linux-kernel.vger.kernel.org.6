Return-Path: <linux-kernel+bounces-296872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048995B00F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF8D1F22A44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758917A588;
	Thu, 22 Aug 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f7iTGhq8"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CA176FCF;
	Thu, 22 Aug 2024 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314677; cv=none; b=eda6JiSMKrwToW0e9ndszRf858SPKA1l3NZY7HuPLDljwNA2vcKUPPUpnYrR1ygWMaxL/Ta5Cl65gLymsVsuKLl05DWNFRmHbCtAhMusW4YGd6EkmV5BPZbc7PdN5PsfjePed1QC4TNYhE1PEqUeH+m/1pH7mxy0UqfNkPCi6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314677; c=relaxed/simple;
	bh=NqmSxpe1MO8XoWRvN/3Czc4Ol3rCVDg3jAFBUwMgN9I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnJyZ+WNpHeFhQHDEb7t1fVlfCp5BfGSSVGT1/pm9OIqDYjl6SfqN16FUlKuROBTOPSJ243U0XBxfN+0blctgO8JAef+1k/H7obcOf9Q5OK3HHvQEYzPDNy31P5X5Db0nIj/xmMfm8VlFOsV+Kmb2ItoaN/UGxTVOUD8ZqqxWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f7iTGhq8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF8E2240005;
	Thu, 22 Aug 2024 08:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724314667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLmAUqCpjFppoDxgApNLZBtCJUtY++ru5GMpCrgHDqg=;
	b=f7iTGhq8vedFE11n/0rRwDedvjSFEEL5BKqO+trhi80xJEsMmwxnrtuXmc+78r4/4Qw7Ba
	7zeez/x9GLji220CPXCTuOK1JdQMdCvNUSD1IHuo+dywpoQJ8QoCufvfAAlbSEanHDEmMW
	nKFjfq7+6WpRbZb4YsnveruK+5jLT3itRdOupIwc6lC+WTso5j0eoL9Lm+a4URW+2/Udkk
	oJR9eE4RD69a8Vf9dZFAsgJEpo/rOLVWWEQrZNj+HM7srDcQovOi3MAWROLsHSvnC1U3mt
	rbS9yJOJp+Y2lMJyzzF0cPQ4FwziqqGoz3Qt84KtKVPn6xWAZKeB9+c09ImlEA==
Date: Thu, 22 Aug 2024 10:17:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks
Message-ID: <20240822081746db0ce2bb@mail.local>
References: <20240820132730.357347-1-ada@thorsis.com>
 <20240821055136.6858-1-ada@thorsis.com>
 <20240821235205b302068b@mail.local>
 <20240822-dragging-grapple-f26e4361e009@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822-dragging-grapple-f26e4361e009@thorsis.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 22/08/2024 08:53:59+0200, Alexander Dahl wrote:
> Hello Alexandre,
> 
> Am Thu, Aug 22, 2024 at 01:52:05AM +0200 schrieb Alexandre Belloni:
> > On 21/08/2024 07:51:36+0200, Alexander Dahl wrote:
> > > The RTC and RTT peripherals use the "timing domain slow clock (TD_SLCK),
> > > sourced from the 32.768 kHz crystal oscillator.
> > > 
> > > (The previously used Monitoring domain slow clock (MD_SLCK) is sourced
> > > from an internal RC oscillator which is most probably not precise enough
> > > for real time clock purposes.)
> > > 
> > > Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
> > > Fixes: 5f6b33f46346 ("ARM: dts: sam9x60: add rtt")
> > > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > > ---
> > > 
> > > Notes:
> > >     Picked the wrong patch in the first try.  This v2 one has a slightly
> > >     adapted commit message and more context below.
> > >     
> > >     This obviously requires a 32.768 kHz crystal oscillator to be present,
> > >     but the sam9x60.dtsi does contain that, and the clock-controllers
> > >     reference that, so I assume it's always present.
> > 
> > The crystal is optional so this is going to break the boards that don't
> > have one. I don't really mind but this should probably be part of the
> > commit message.
> 
> Okay right, according to the datasheet (Figure 27.1 SCKC Block
> Diagram) you don't need that crystal, you can clear TD_OSCSEL and
> td_slck runs from the internal rc then.  However, td_slck is always
> present, it either sources from the internal slow rc oscillator or the
> crystal oscillator.  And the datasheet says in section 29.1 (PMC):
> 
>     "The Slow Clock Controller (SCKC) selects the source of TD_SLCK
>     (drives the real-time part (RTT/RTC)).  The source of MD_SLCK
>     (drives the rest of the system controller: wake-up logic,
>     watchdog, PMC, etc.) is always the slow RC oscillator."
> 
> md_slck and td_slck are both registered by the at91 sckc driver, and
> the td_slck gets two parents in of_sam9x60_sckc_setup() when
> registered by at91_clk_register_sam9x5_slow().  The parent can be
> switched by clk_sam9x5_slow_set_parent() from sam9x5_slow_ops then,
> correctly setting the OSCSEL bit.
> 
> The whole idea of the patch is giving the rtc/rtt td_slck as a parent
> as documented in the datasheet.  I don't see how this should be
> affected by the parents of td_slck?  Am I missing something?
> 

You are right, I got confused because you were referring t the 32768 Hz
crystal in your commit message and though you aimed at selected the
parent of td_slck (and also, I didn't really work on the sam9x60).


> > This makes me realise that we always assumed the RC oscillator was
> > running at 32768 while the sam9x60 datasheet refers to it has a 32kHz
> > oscillator. However the RTC only has a 32768 divider...
> 
> When sourced from the internal rc oscillator, this would mean the
> output would be incorrect, right?  How could one prove this?


I guess you could have a look at how the RTC is drifting when selecting
the RC osc as the parent but it will anyway be way less precise than the
crystal so i'm not sure how you could get a conclusive result.

> 
> Greets
> Alex
> 
> > 
> > >     
> > >     /sys/kernel/debug/clk/clk_summary content excerpt before:
> > >     
> > >          slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
> > >             md_slck                          4       4        0        32768       0          0     50000      Y      fffffea8.rtc                    no_connection_id
> > >                                                                                                                       fffffe20.rtc                    no_connection_id
> > >                                                                                                                       fffffe10.poweroff               no_connection_id
> > >                                                                                                                       fffffe00.reset-controller       no_connection_id
> > >                                                                                                                       timer@f8008000                  slow_clk
> > >                                                                                                                       deviceless                      no_connection_id
> > >     …
> > >          slow_xtal                           0       0        0        32768       0          0     50000      Y   deviceless                      no_connection_id
> > >             slow_osc                         0       0        0        32768       0          0     50000      Y      deviceless                      no_connection_id
> > >                td_slck                       0       0        0        32768       0          0     50000      Y         deviceless                      no_connection_id
> > >     
> > >     And after:
> > >     
> > >          slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
> > >             md_slck                          2       2        0        32768       0          0     50000      Y      fffffe10.poweroff               no_connection_id
> > >                                                                                                                       fffffe00.reset-controller       no_connection_id
> > >                                                                                                                       timer@f8008000                  slow_clk
> > >                                                                                                                       deviceless                      no_connection_id
> > >     …
> > >          slow_xtal                           1       1        0        32768       0          0     50000      Y   deviceless                      no_connection_id
> > >             slow_osc                         1       1        0        32768       0          0     50000      Y      deviceless                      no_connection_id
> > >                td_slck                       2       2        0        32768       0          0     50000      Y         fffffea8.rtc                    no_connection_id
> > >                                                                                                                          fffffe20.rtc                    no_connection_id
> > >                                                                                                                          deviceless                      no_connection_id
> > > 
> > >  arch/arm/boot/dts/microchip/sam9x60.dtsi | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > index 291540e5d81e..d077afd5024d 100644
> > > --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > @@ -1312,7 +1312,7 @@ rtt: rtc@fffffe20 {
> > >  				compatible = "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
> > >  				reg = <0xfffffe20 0x20>;
> > >  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> > > -				clocks = <&clk32k 0>;
> > > +				clocks = <&clk32k 1>;
> > >  			};
> > >  
> > >  			pit: timer@fffffe40 {
> > > @@ -1338,7 +1338,7 @@ rtc: rtc@fffffea8 {
> > >  				compatible = "microchip,sam9x60-rtc", "atmel,at91sam9x5-rtc";
> > >  				reg = <0xfffffea8 0x100>;
> > >  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> > > -				clocks = <&clk32k 0>;
> > > +				clocks = <&clk32k 1>;
> > >  			};
> > >  
> > >  			watchdog: watchdog@ffffff80 {
> > > 
> > > base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> > > -- 
> > > 2.39.2
> > > 
> > 
> > -- 
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

