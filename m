Return-Path: <linux-kernel+bounces-297088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC795B2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943C31C22F36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75CA180032;
	Thu, 22 Aug 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="kfHRhhdc"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A8F181337;
	Thu, 22 Aug 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322335; cv=none; b=HTkQefMv2rVq2L/7VhEmhuHUPRjZ0EJirvMtybJKD0Qchm6AgMwYaHxn9Q8Phoy0Mu2W/DfP8X2i8YuUAc1CQw8kzgfE3otfYMz6vwy0dz84OqxQUqeZlxOEs52z4FjMPNQiJyw5Pq4buAGd7Crah7Y3z1Q5gOg35ncsSyFy/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322335; c=relaxed/simple;
	bh=YyOacIUzthdJ6SxDaXhBWGJda/3/Nu71Dr6OwU36xx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag1E3f+B2vUdTysCH1cFUfp1aoJ4rrm9WvPfwBPFUZAK0Yd4Yje6TgZOv7evunnDl+6r/UJ7YJUYm+GBT5AxLQG9bPSyJLWRijDjH8UPRRSAGFUWXCjZIH6CXo1J+/f/Ni8iWwRec0m27ZKqicx8PxVmCbOGz/Yx2flFcmLo/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=kfHRhhdc; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B86C61486736;
	Thu, 22 Aug 2024 12:25:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724322330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ybFfR40X1VQxaGlShBcj9xX9wciu3DwxZfXPx9BPwoo=;
	b=kfHRhhdcK0RwpiX81dnE/IfFwvOCdD3XUQKXxbY4lUbgSGmSu88pg5/yCE6FMAeJL3KLuB
	EboDznx6ZSzPN/lPNaLUbCk2Akn0lauDphdpVePNj2jTLJu8YqwsXAMjHoPJh8kytu+pAi
	8y4kkZfHFIx9kkXxqnQ6yFNA1XlHwUMn8UeM+0qGwrry6+znFw/TIlRwIF8M+Uk8JZTIwP
	ki/rACHHRVqRSYHpT7zX4fnR+Bg33JL210q5P5lmsftCDJQv+T0Dx/V6Vqfev5rqMxsZmw
	PA4sCSnrlmJX6MGfgEgXTWddcUsQx4Dis3P/J56tmNsg0Vat4k34TUqZZ32w0Q==
Date: Thu, 22 Aug 2024 12:25:26 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
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
Message-ID: <20240822-mute-ruby-fc8c86240f3c@thorsis.com>
Mail-Followup-To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240820132730.357347-1-ada@thorsis.com>
 <20240821055136.6858-1-ada@thorsis.com>
 <20240821235205b302068b@mail.local>
 <20240822-dragging-grapple-f26e4361e009@thorsis.com>
 <20240822081746db0ce2bb@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822081746db0ce2bb@mail.local>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Alexandre,

Am Thu, Aug 22, 2024 at 10:17:46AM +0200 schrieb Alexandre Belloni:
> On 22/08/2024 08:53:59+0200, Alexander Dahl wrote:
> > Hello Alexandre,
> > 
> > Am Thu, Aug 22, 2024 at 01:52:05AM +0200 schrieb Alexandre Belloni:
> > > On 21/08/2024 07:51:36+0200, Alexander Dahl wrote:
> > > > The RTC and RTT peripherals use the "timing domain slow clock (TD_SLCK),
> > > > sourced from the 32.768 kHz crystal oscillator.
> > > > 
> > > > (The previously used Monitoring domain slow clock (MD_SLCK) is sourced
> > > > from an internal RC oscillator which is most probably not precise enough
> > > > for real time clock purposes.)
> > > > 
> > > > Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
> > > > Fixes: 5f6b33f46346 ("ARM: dts: sam9x60: add rtt")
> > > > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > > > ---
> > > > 
> > > > Notes:
> > > >     Picked the wrong patch in the first try.  This v2 one has a slightly
> > > >     adapted commit message and more context below.
> > > >     
> > > >     This obviously requires a 32.768 kHz crystal oscillator to be present,
> > > >     but the sam9x60.dtsi does contain that, and the clock-controllers
> > > >     reference that, so I assume it's always present.
> > > 
> > > The crystal is optional so this is going to break the boards that don't
> > > have one. I don't really mind but this should probably be part of the
> > > commit message.
> > 
> > Okay right, according to the datasheet (Figure 27.1 SCKC Block
> > Diagram) you don't need that crystal, you can clear TD_OSCSEL and
> > td_slck runs from the internal rc then.  However, td_slck is always
> > present, it either sources from the internal slow rc oscillator or the
> > crystal oscillator.  And the datasheet says in section 29.1 (PMC):
> > 
> >     "The Slow Clock Controller (SCKC) selects the source of TD_SLCK
> >     (drives the real-time part (RTT/RTC)).  The source of MD_SLCK
> >     (drives the rest of the system controller: wake-up logic,
> >     watchdog, PMC, etc.) is always the slow RC oscillator."
> > 
> > md_slck and td_slck are both registered by the at91 sckc driver, and
> > the td_slck gets two parents in of_sam9x60_sckc_setup() when
> > registered by at91_clk_register_sam9x5_slow().  The parent can be
> > switched by clk_sam9x5_slow_set_parent() from sam9x5_slow_ops then,
> > correctly setting the OSCSEL bit.
> > 
> > The whole idea of the patch is giving the rtc/rtt td_slck as a parent
> > as documented in the datasheet.  I don't see how this should be
> > affected by the parents of td_slck?  Am I missing something?
> > 
> 
> You are right, I got confused because you were referring t the 32768 Hz
> crystal in your commit message and though you aimed at selected the
> parent of td_slck (and also, I didn't really work on the sam9x60).

Thanks for confirming.

Should I reword the commit message then to make it easier to
understand?

> > > This makes me realise that we always assumed the RC oscillator was
> > > running at 32768 while the sam9x60 datasheet refers to it has a 32kHz
> > > oscillator. However the RTC only has a 32768 divider...
> > 
> > When sourced from the internal rc oscillator, this would mean the
> > output would be incorrect, right?  How could one prove this?
> 
> 
> I guess you could have a look at how the RTC is drifting when selecting
> the RC osc as the parent but it will anyway be way less precise than the
> crystal so i'm not sure how you could get a conclusive result.

I would have to look deeper into rtc for that.
Maybe in a calm minute. ;-)

Greets
Alex

> 
> > 
> > Greets
> > Alex
> > 
> > > 
> > > >     
> > > >     /sys/kernel/debug/clk/clk_summary content excerpt before:
> > > >     
> > > >          slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
> > > >             md_slck                          4       4        0        32768       0          0     50000      Y      fffffea8.rtc                    no_connection_id
> > > >                                                                                                                       fffffe20.rtc                    no_connection_id
> > > >                                                                                                                       fffffe10.poweroff               no_connection_id
> > > >                                                                                                                       fffffe00.reset-controller       no_connection_id
> > > >                                                                                                                       timer@f8008000                  slow_clk
> > > >                                                                                                                       deviceless                      no_connection_id
> > > >     …
> > > >          slow_xtal                           0       0        0        32768       0          0     50000      Y   deviceless                      no_connection_id
> > > >             slow_osc                         0       0        0        32768       0          0     50000      Y      deviceless                      no_connection_id
> > > >                td_slck                       0       0        0        32768       0          0     50000      Y         deviceless                      no_connection_id
> > > >     
> > > >     And after:
> > > >     
> > > >          slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
> > > >             md_slck                          2       2        0        32768       0          0     50000      Y      fffffe10.poweroff               no_connection_id
> > > >                                                                                                                       fffffe00.reset-controller       no_connection_id
> > > >                                                                                                                       timer@f8008000                  slow_clk
> > > >                                                                                                                       deviceless                      no_connection_id
> > > >     …
> > > >          slow_xtal                           1       1        0        32768       0          0     50000      Y   deviceless                      no_connection_id
> > > >             slow_osc                         1       1        0        32768       0          0     50000      Y      deviceless                      no_connection_id
> > > >                td_slck                       2       2        0        32768       0          0     50000      Y         fffffea8.rtc                    no_connection_id
> > > >                                                                                                                          fffffe20.rtc                    no_connection_id
> > > >                                                                                                                          deviceless                      no_connection_id
> > > > 
> > > >  arch/arm/boot/dts/microchip/sam9x60.dtsi | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > > index 291540e5d81e..d077afd5024d 100644
> > > > --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > > +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> > > > @@ -1312,7 +1312,7 @@ rtt: rtc@fffffe20 {
> > > >  				compatible = "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
> > > >  				reg = <0xfffffe20 0x20>;
> > > >  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> > > > -				clocks = <&clk32k 0>;
> > > > +				clocks = <&clk32k 1>;
> > > >  			};
> > > >  
> > > >  			pit: timer@fffffe40 {
> > > > @@ -1338,7 +1338,7 @@ rtc: rtc@fffffea8 {
> > > >  				compatible = "microchip,sam9x60-rtc", "atmel,at91sam9x5-rtc";
> > > >  				reg = <0xfffffea8 0x100>;
> > > >  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> > > > -				clocks = <&clk32k 0>;
> > > > +				clocks = <&clk32k 1>;
> > > >  			};
> > > >  
> > > >  			watchdog: watchdog@ffffff80 {
> > > > 
> > > > base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> > > > -- 
> > > > 2.39.2
> > > > 
> > > 
> > > -- 
> > > Alexandre Belloni, co-owner and COO, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

