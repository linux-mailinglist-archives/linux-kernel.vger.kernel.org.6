Return-Path: <linux-kernel+bounces-315317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6398996C0FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B635283CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79A1DB55A;
	Wed,  4 Sep 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="TUDK8BOM"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B41D014A;
	Wed,  4 Sep 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461027; cv=none; b=LgHgHKrN6Wp0oNhp7PqHbT5JJ+vOZclG5B14Am8kOcVDPxKp+Xo2xr0BjUitrMHQKN0wSt7ctT37fdQD7N/q3o3KBRd6qdM1FaCILmLZqL7fCTRHJC73hEygGiYCuhom3kSmfcoOCTeK9uk7IFZuSbS7W2SNEIlxviUdq/EezJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461027; c=relaxed/simple;
	bh=sm22nFmNR0md+jQRLeaQ33BZhvNSh1BKCjhCpox5JUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUdNpLK92gMtvQ6N/vk0/77RQnPDnWh1GaCTtp794n7XU1i05z6Lgu+8p85yjunKs7up0uKffbCzn94auXYeqNf4nrB+V9FUEECYC8H/47cEQOZqdh3311K18I/Ysdxq7uN9ueX3mA2mTP5lpDUFzuZvVm0BXQE5x0rCBVFVwS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=TUDK8BOM; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3551114834C3;
	Wed,  4 Sep 2024 16:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1725461015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hX+eifWAiveSb+KjZXoS1c51EErY84qpu6TvYzOZ/zc=;
	b=TUDK8BOM0mGPgL4l8iu9m6gdnBqXDP1Z4p+TTL0DRnFjW9wX4AAAIQ8OrCVed1ATOABGkU
	SLs687H/r4bPRHn+DJ1qyL4xTLpNOhgNou5xehqKaADj5P7S5cXZYJoh8dC8edCL/H5K2L
	6JcFiiHktjx7BP6wyl6M8KmFi6/bLWdkPL3DKQwUD/SgBqizD8/ibikmpm1VH5h65dteFI
	lARd4QHy33TUhrT6sUmrkrFTw2Sq68oqD+oyMdJbKXwcEY6MV52g7k3P/PuYbcAr0BCiVw
	qBj0g1vUCDwpE+bVANeIYVjv4rl44fhQ9N3LYo8fNCgIwHmkq+DyHKJAS7my6Q==
Date: Wed, 4 Sep 2024 16:43:32 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: claudiu beznea <claudiu.beznea@tuxon.dev>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: get, prepare, enable a clock not in DT?
Message-ID: <20240904-grandkid-algorithm-4e9a73971e96@thorsis.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	claudiu beznea <claudiu.beznea@tuxon.dev>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
 <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
 <20240820-grandpa-down-fec4231f971c@thorsis.com>
 <e7f69aa3-20a7-4233-96c7-0fa5fe67bbdc@tuxon.dev>
 <20240828-gainfully-cringing-2f420d8882bd@thorsis.com>
 <6cd18742-7ba8-4b0c-aff9-7065bccd4095@tuxon.dev>
 <20240902-machinist-straggler-cce44ffa4a7c@thorsis.com>
 <6bc72d8a-c7b8-40de-b4c2-0170dde36d33@tuxon.dev>
 <e1371121-8f06-4c36-a950-063ae716b47e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1371121-8f06-4c36-a950-063ae716b47e@microchip.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Claudiu, Nicolas,

Am Wed, Sep 04, 2024 at 03:26:45PM +0200 schrieb Nicolas Ferre:
> On 04/09/2024 at 09:33, claudiu beznea wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi, Alexander,
> > 
> > On 02.09.2024 11:24, Alexander Dahl wrote:
> > > Hello Claudiu,
> > > 
> > > Am Sat, Aug 31, 2024 at 06:49:59PM +0300 schrieb claudiu beznea:
> > > > Hi, Alexander,
> > > > 
> > > > On 28.08.2024 09:55, Alexander Dahl wrote:
> > > > > Hello Claudiu,
> > > > > 
> > > > > Am Fri, Aug 23, 2024 at 05:29:44PM +0300 schrieb claudiu beznea:
> > > > > > 
> > > > > > 
> > > > > > On 20.08.2024 15:17, Alexander Dahl wrote:
> > > > > > > By chance: I don't have a sama7g5 based board at hand for testing.
> > > > > > > The datasheet says the same as for sam9x60.
> > > > > > > Does the nvmem_microchip_otpc driver actually work without timeout on
> > > > > > > sama7g5?
> > > > > > 
> > > > > > Yes! This should be because system bus is clocked from MCK0 (as mentioned
> > > > > > in peripheral identifiers table) which is enabled by bootloader.
> > > > > 
> > > > > Not sure I can follow.  Citing the SAMA7G5 datasheet section 30.4
> > > > > (OTPC Product Dependencies):
> > > > > 
> > > > >      "The OTPC is clocked through the Power Management Controller
> > > > >      (PMC). The user must power on the main RC oscillator and enable
> > > > >      the peripheral clock of the OTPC prior to reading or writing the
> > > > >      OTP memory."
> > > > 
> > > > I don't see this in [1]. Only:
> > > > 
> > > > "The OTPC is clocked through the Power Management Controller (PMC), so the
> > > > programmer must first to configure the PMC."
> > > > 
> > > >  From this I got that it is about the MCK0 listed in table Table 8-11.
> > > > Peripheral Identifiers.
> > > > 
> > > > [1]
> > > > https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765A.pdf
> > > 
> > > Well, this seems to be an older version revision A from 03/2022.
> > > I have DS60001765B (revision B) from 12/2023 and got this here (note
> > > the missing 'A' in the filename):
> > > 
> > > https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf
> > 
> > This version clearly express your findings. The unknown now is the
> > "peripheral clock" that need to be enabled along with the
> > main_rc_oscillator. For that you may want to play around with PMC
> > Peripheral Control Register, PMC peripheral clock status register and see
> > if OTPC fails to work when disabling the peripheral clock with the OTPC ID
> > as there is no information about peripheral clock for OTPC in the
> > peripheral identifers table.

The SAM9X60 seems to be different here, than the SAMA7G5.

(I only have SAM9X60 here, I can not test on SAMA7G5.)

To make it work I did not enable or disable a certain PMC peripheral
clocks on SAM9X60.  The peripheral ID for OTPC is 46 on SAM9X60, and
in the Peripheral Identifiers table there's no checkmark under "PMC
Clock Control".  The ID is also not part of the sam9x60 clock drivers.
This tells me SAM9X60 does not need a PMC peripheral clock enabled for
the OTPC to work and my experiments confirm this.  Enabling the main
RC oscillator was sufficient.

> > Hope this helps.
> 
> FYI, I asked internally. I'll keep you posted.

Thanks Nicolas, I appreciate this.

Greets
Alex

> 
> Regards,
>   Nicolas
> 
> > > Linked here:
> > > 
> > > https://www.microchip.com/en-us/product/sama7g54
> > > 
> > > The revision history is not very specific, it only says "Updated Power
> > > Management".  Errata sheet has nothing interesting on that topic.
> > > 
> > > We both cited what we saw in the datasheets.  Revision A has the
> > > section you cited, revision B has the section I cited.
> > > 
> > > > > Table from section 8.5 (Peripheral Clocks …) has no check mark at "PMC
> > > > > clock control" but indeed lists MCK0 as main system bus clock.
> > > > 
> > > > This is what I was taking about.
> > > > 
> > > > >   If it
> > > > > works on SAMA7G5 without explicitly enabling main RC oscillator, then
> > > > > either that clock is on accidentally, or the datasheet is wrong in the
> > > > > OTPC section.
> > > > 
> > > > Might be.
> > > 
> > > I don't have a SAMA7G5 at hand.  Someone who has could test if OTPC
> > > works with/without MCK0, and with/without main RC osc, all possible
> > > combinations would be most helpful: with none of those, with only one,
> > > only the other, both.
> > > 
> > > Hope we get this clock stuff sorted out?!
> > > 
> > > Greets
> > > Alex
> > > 
> > > > 
> > > > Thank you,
> > > > Claudiu Beznea
> > > > 
> > > > > 
> > > > > Personally I find the "clocked through PMC" part in the OTPC
> > > > > section suspicious, because in the peripheral identifiers table OTPC
> > > > > has no "PMC Clock Control" mark.
> > > > > 
> > > > > Not sure what's the difference between SAM9X60 and SAMA7G5 internally,
> > > > > though.  From a user's POV it's possible one of them requires the
> > > > > main RC osc, and the other does not, but currently you can't tell from
> > > > > the datasheets.
> > > > > 
> > > > > > Here is a snapshot of reading the NVMEM on a SAMA7G5 with bootconfig and
> > > > > > thermal calibration packets:
> > > > > > https://www.linux4sam.org/bin/view/Linux4SAM/ThermalFaq
> > > > > 
> > > > > Greets
> > > > > Alex
> > > > > 
> > > > 
> 
> 

