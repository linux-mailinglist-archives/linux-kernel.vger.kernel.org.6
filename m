Return-Path: <linux-kernel+bounces-293947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2D9586CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2859B27444
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4118FC72;
	Tue, 20 Aug 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="SCXL+pYI"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE218A6BC;
	Tue, 20 Aug 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724156428; cv=none; b=hyr/CpMFgGe/NBflvLWcKFpcKbcjb7B2txk6EBFphZVq1fppO5rqMFZJucFDw2P7GP1LL4w3tKucPr+S+YMjgKhWweLuPQiATXBJITC7msAoIAyDRVQfT2J03J3kCTPTqb5R2cxhlu+7Wl6ceWOXShqref4xmbpKTb8QeIEyYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724156428; c=relaxed/simple;
	bh=cmH8LeB3XQV3FWrWLmPQQortO5BwjzrvyvSS30/UKLA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTFqbDF3uNBCkbnuUcCDz/Zr1vHZ7pRh5HflJx+cDVYx4BnPFvpvo0snLXZtUi3SbK+Ff5NUXpSlSKwqlKKP2CCTMpwqLThwpXhufMTgm1dgrRs/Bgz5FvZBNo+nFoJY0WD/RxPabF40VD7ijJs00skgQAUYflmIkTzFrk7eIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=SCXL+pYI; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F37D148330C;
	Tue, 20 Aug 2024 14:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1724156423;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=6lsGEQXfU/2msmfbLV6xAW1tGi05xaQSNBIo8l41vSc=;
	b=SCXL+pYIULWut8pttHq+yiF+DLNqkn1yYpHLDFgHaR84kXLDpS1/mA7yqwBYvjvLYN+690
	1FwXAFpjUH0uoAhp/a4dgXbzfYZ7oSmBP4Tr1UxWOLORh7j4lJqo8iVo6N0q/Es53Jd7K0
	17PDCSmVENaypIHr7i+WopIv0ACs4uFB/6Ao/gIDKCwBFrTpB2lULFjoB/MWcsP6LcI8WQ
	iu5D8F0K+09jG92e0BbMMp5zUj6+vq+uDNyjXLrrNb7d+Dd+3j7cjc+/sqa9GRXs6DDHP8
	OnmbCmMZ7Zg9tnL1YSzSKAwyVuQ/d+Q156nbMc1MO5FvZbN0P56WOeO0e70Drw==
Date: Tue, 20 Aug 2024 14:20:21 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: get, prepare, enable a clock not in DT?
Message-ID: <20240820-stinging-altitude-d1186a067824@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
 <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
 <20240820-grandpa-down-fec4231f971c@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-grandpa-down-fec4231f971c@thorsis.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Tue, Aug 20, 2024 at 02:17:58PM +0200 schrieb Alexander Dahl:
> Hello Claudiu,
> 
> Am Tue, Aug 20, 2024 at 02:54:59PM +0300 schrieb claudiu beznea:
> > Hi, Alexander,
> > 
> > On 16.08.2024 17:34, Alexander Dahl wrote:
> > > Hello everyone,
> > > 
> > > while further investigating timeout issues with the at91 otpc
> > > controller on sam9x60 [1] I came to the conclusion the main RC
> > > oscillator on that SoC must be enabled for that driver to work.
> > 
> > Not sure how that works (unless undocumented) as figure Figure 28-1. Clock
> > Generator Block Diagram from [1] states that main_rc_osc feeds only the mainck.
> 
> It can feed the main clock and you're right from Clock Generator POV.
> However it is not completely undocumented.  Section "23.4 Product
> Dependencies" of the SAM9X60 datasheet (DS60001579G) says:
> 
>     "The OTPC is clocked through the Power Management Controller (PMC).
>     The user must power on the main RC oscillator and enable the
>     peripheral clock of the OTPC prior to reading or writing the OTP
>     memory."
> 
> Apparently this also applies to reading, at least according to my
> tests on sam9x60-curiosity.
> 
> btw, the last public release of the atmel-software-package, source for
> the sam-ba applets, also enables that clock, although the reasoning
> was for writing. [1]

Sorry, forgot that reference, FWIW:

[1] https://github.com/atmelcorp/atmel-software-package/blob/master/drivers/nvm/otp/otpc.c#L99

Greets
Alex

> 
> > Also, Table 9-1. Peripheral Identifiers from [1] say that there is no clock
> > control for OTCP on the PMC side.
> > 
> > [1]
> > https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAM9X60-Data-Sheet-DS60001579.pdf
> 
> You're right from the datasheet POV.  Not sure if the datasheet is
> right here?  It's not complete in some register contents anyway, maybe
> some things are kept confidential, and OTPC is part of that?
> 
> Maybe someone can confirm my findings on sam9x60-curiosity, e.g.
> after I sent a patch series with what I consider fixes for this topic?
> 
> > > (Verified that by poking single bits in registers through devmem
> > > already.)
> > > 
> > > Fortunately the necessary clk is already registered from the SoC code
> > > in drivers/clk/at91/sam9x60.c [2] and I can see the clock in sysfs clk
> > > summary:
> > > 
> > >     root@DistroKit:~ head -n4 /sys/kernel/debug/clk/clk_summary 
> > >                                      enable  prepare  protect                                duty  hardware                            connection
> > >        clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
> > >     ---------------------------------------------------------------------------------------------------------------------------------------------
> > >      main_rc_osc                         0       0        0        12000000    50000000   0     50000      Y   deviceless                      no_connection_id         
> > > 
> > > That clock has no parent and is not found anywhere in devicetree, nor
> > > is it handled by the two clock-producers on that platform, so
> > > from within mchp_otpc_probe() I just tried this:
> > > 
> > >     otpc->clk = devm_clk_get_enabled(&pdev->dev, "main_rc_osc");
> > 
> > > 
> > > However that returns with -ENOENT, so I assume I can not reference the
> > > clock just by name?  Same result with this:
> > > 
> > >     otpc->clk = devm_clk_get_enabled(NULL, "main_rc_osc");
> > > 
> > > How do I get a pointer to that clk then to enable it?  Docs [3] where
> > 
> > To expose it though DT you may want to save its hw object to one array
> > entry in sam9x60_pmc, sam9x60_pmc->chws[] fits best for this atm.
> 
> Great to see I came to the same conclusion.  I have a proof-of-concept
> working meanwhile, will send a patch series later this week I guess.
> 
> Thanks for your support.
> 
> > Otherwise, you can try to register the main_rc_osc with CLK_IS_CRITICAL for
> > simple trials.
> 
> Don't think that is necessary anymore. :-)
> 
> By chance: I don't have a sama7g5 based board at hand for testing.
> The datasheet says the same as for sam9x60.
> Does the nvmem_microchip_otpc driver actually work without timeout on
> sama7g5?
> 
> Greets
> Alex
> 
> > 
> > Thank you,
> > Claudiu Beznea
> > 
> > > not as useful as I hoped for, neither was clk.h header docs. :-/
> > > 
> > > From what I understood from header docs reading 'device for clock
> > > "consumer"' I must pass the device from which I call that clk_get() as
> > > first parameter, so this would be the otpc device then, right?  What's
> > > that second parameter clock consumer id then?  Are these terms
> > > explained somewhere?
> > > 
> > > Greets
> > > Alex
> > > 
> > > [1] <20240813-payable-ecology-8a9e739704bb@thorsis.com>
> > > [2] https://elixir.bootlin.com/linux/v6.10.4/source/drivers/clk/at91/sam9x60.c#L217
> > > [3] https://kernel.org/doc/html/latest/driver-api/clk.html
> > > 
> > 
> 

