Return-Path: <linux-kernel+bounces-310822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590F39681A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF241F21376
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63DF185B5E;
	Mon,  2 Sep 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="bmOzbG9n"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDC17C9B3;
	Mon,  2 Sep 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265475; cv=none; b=TCpxif9OdclCtOCW9aky3LU9CUKPco2TMe8GrTR3Q78ywRyi7DiH/utj8ZXZsd1C+cv/JgL5eeDCmpV/4SUesvPBiIw+EGsEGR8EoM3It0QVmSV/RCzp9no34C3Q94bR9e4WIEX2+k9X5skW5TiucHcaaM87nUa9f0ANrXAmSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265475; c=relaxed/simple;
	bh=pslQU41FGdhkmaUkEZ9dQ5WuxgEanAdXBKZB2w5Nqto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4UkS4zFb1QGeyvoxwONeZqMY07136mnS5VTGjs+bUBr8ksYwgXjUZ8Cq4FVIfMNZ87lEYICUj+GsBC/tGD9ktQB4QqJ52wK9JBiYwL6t08P5QVC2siOvPX1yf6PZgkUWV6pSQV7xtI5ykGaR3PzJ5p+fJPzHmjkZUH8RQ2wIMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=bmOzbG9n; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A41431482FA3;
	Mon,  2 Sep 2024 10:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1725265469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mI8+uZ1zQ3Whmswrx6WrAOVyRCcCM9kOZQ5ZCv9PtoM=;
	b=bmOzbG9nfpXqW241QxHnQpysQs92hEsCBDpVAemdevUnuADsnuP8DDJ7VUr19ROHB128MF
	g8i+m+1bBW71+0sfziI07Z/4gRkDxGvb2x7fALwVp7LwmDOBuOtp0UZX4H/+aZLnUvBOLF
	ImwWPbKL1B/gH4cHQbBXut9l9sg/XXPIQDQ7Lgx91KOozm8vm1x/Jbp7NreTJDdzDmfily
	5/cMO7Svv3FX3hatFKQ00JCcjH1QcsPuG2mNgbzs/p8bB+7Cp7nAuadJIukBJ5iOuBlIsu
	xt8GL9yrZOA/AuCUZZnGJ29ATKOBsHCCJbEI7lSGUwIhkagPPs8eKQIbuzBHZw==
Date: Mon, 2 Sep 2024 10:24:27 +0200
From: Alexander Dahl <ada@thorsis.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: get, prepare, enable a clock not in DT?
Message-ID: <20240902-machinist-straggler-cce44ffa4a7c@thorsis.com>
Mail-Followup-To: claudiu beznea <claudiu.beznea@tuxon.dev>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
 <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
 <20240820-grandpa-down-fec4231f971c@thorsis.com>
 <e7f69aa3-20a7-4233-96c7-0fa5fe67bbdc@tuxon.dev>
 <20240828-gainfully-cringing-2f420d8882bd@thorsis.com>
 <6cd18742-7ba8-4b0c-aff9-7065bccd4095@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cd18742-7ba8-4b0c-aff9-7065bccd4095@tuxon.dev>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu,

Am Sat, Aug 31, 2024 at 06:49:59PM +0300 schrieb claudiu beznea:
> Hi, Alexander,
> 
> On 28.08.2024 09:55, Alexander Dahl wrote:
> > Hello Claudiu,
> > 
> > Am Fri, Aug 23, 2024 at 05:29:44PM +0300 schrieb claudiu beznea:
> >>
> >>
> >> On 20.08.2024 15:17, Alexander Dahl wrote:
> >>> By chance: I don't have a sama7g5 based board at hand for testing.
> >>> The datasheet says the same as for sam9x60.
> >>> Does the nvmem_microchip_otpc driver actually work without timeout on
> >>> sama7g5?
> >>
> >> Yes! This should be because system bus is clocked from MCK0 (as mentioned
> >> in peripheral identifiers table) which is enabled by bootloader.
> > 
> > Not sure I can follow.  Citing the SAMA7G5 datasheet section 30.4
> > (OTPC Product Dependencies):
> > 
> >     "The OTPC is clocked through the Power Management Controller
> >     (PMC). The user must power on the main RC oscillator and enable
> >     the peripheral clock of the OTPC prior to reading or writing the
> >     OTP memory."
> 
> I don't see this in [1]. Only:
> 
> "The OTPC is clocked through the Power Management Controller (PMC), so the
> programmer must first to configure the PMC."
> 
> From this I got that it is about the MCK0 listed in table Table 8-11.
> Peripheral Identifiers.
> 
> [1]
> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765A.pdf

Well, this seems to be an older version revision A from 03/2022.
I have DS60001765B (revision B) from 12/2023 and got this here (note
the missing 'A' in the filename):

https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf

Linked here:

https://www.microchip.com/en-us/product/sama7g54

The revision history is not very specific, it only says "Updated Power
Management".  Errata sheet has nothing interesting on that topic.

We both cited what we saw in the datasheets.  Revision A has the
section you cited, revision B has the section I cited.

> > Table from section 8.5 (Peripheral Clocks …) has no check mark at "PMC
> > clock control" but indeed lists MCK0 as main system bus clock.
> 
> This is what I was taking about.
> 
> >  If it
> > works on SAMA7G5 without explicitly enabling main RC oscillator, then
> > either that clock is on accidentally, or the datasheet is wrong in the
> > OTPC section.
> 
> Might be.

I don't have a SAMA7G5 at hand.  Someone who has could test if OTPC
works with/without MCK0, and with/without main RC osc, all possible
combinations would be most helpful: with none of those, with only one,
only the other, both.

Hope we get this clock stuff sorted out?!

Greets
Alex

> 
> Thank you,
> Claudiu Beznea
> 
> > 
> > Personally I find the "clocked through PMC" part in the OTPC
> > section suspicious, because in the peripheral identifiers table OTPC
> > has no "PMC Clock Control" mark.
> > 
> > Not sure what's the difference between SAM9X60 and SAMA7G5 internally,
> > though.  From a user's POV it's possible one of them requires the
> > main RC osc, and the other does not, but currently you can't tell from
> > the datasheets.
> > 
> >> Here is a snapshot of reading the NVMEM on a SAMA7G5 with bootconfig and
> >> thermal calibration packets:
> >> https://www.linux4sam.org/bin/view/Linux4SAM/ThermalFaq
> > 
> > Greets
> > Alex
> > 
> 

