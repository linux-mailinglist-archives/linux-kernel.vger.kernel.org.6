Return-Path: <linux-kernel+bounces-316798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748796D599
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4371C21D98
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D11957F8;
	Thu,  5 Sep 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="otalCKC9"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4992194A61;
	Thu,  5 Sep 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531316; cv=none; b=AvGDAq/2D3V5+3nWFTah+8TJ+kiBJaWl1yF1/hSbbqYz4AMvVL1khT5Kj3RDK8fUULbjcc4y8BQf+92rBZbyuEQpEw9F8HIXKMoc8Qn+aCxi+gBUYKyTvZydOeevckAz3uDR22TTGhCIia7/FbmtSacr5gwrPZ1WYV7YkGfOCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531316; c=relaxed/simple;
	bh=dXyyOP/jzCCnet7lBfvBlrRmo2AqlnRnTXE96XOSq6A=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekBlAqcio0fLAxWsYP6aFNIEPMLWTL3/sw6VRPaYUPnk4lwFbyw9UctW9fFPjw+j08dljKhfQmC8qa6yOO/0nDT2awcluSA7RYr71uWXgAvUJruXlssmL3Dl7GduzE8P6Kyu5Emkp52Z+XtyhTXaM1eMNNgz+uSwbFDSEdCFlos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=otalCKC9; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4855eGf9026075;
	Thu, 5 Sep 2024 05:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=JLerFiBs9AyR9ryOzSK5p+uNGMWY5cOgUI+fz7YtDqI=; b=
	otalCKC9VxGoyfSfrB71VU9MobDuSFcpzMMNgBSIe7g7rAbOYfDkiKSbrbVlsn5p
	okdQvBLczgtUIRrfuFRv3DgcHMtQVzOIATWwMPz4MB4CB18t/sYDFyzEV46EQ5y7
	sXiemiDkivw+pSqhcw5zNqcV7lK0IcETqSSIYzLJ0+6C4s/cZNqY9qDQgQm6kGWq
	nJdRuHaRkVI5AXWV/O0utUaNRtNvZ6ahgE8rA1Z6LD5O22B2H55CHFMsNeNjWYSM
	YTKkO2gkUkrP5z0rPCXpcd++OBzDp2pr+8IdVK8TjiDs6l/FEQSrh3+0ug+gnLCu
	tsWFcZwSwgMnIF+9PsOAFg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 41bykkdsmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 05:15:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 11:15:04 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 5 Sep 2024 11:15:04 +0100
Received: from EDIN6ZZ2FY3 (unknown [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 44BEC820249;
	Thu,  5 Sep 2024 10:15:04 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Mark Brown' <broonie@kernel.org>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240904120700.188644-1-simont@opensource.cirrus.com> <e1aeb66c-ecb3-4778-b306-f3a212caf879@sirena.org.uk> <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com> <6eb95724-9ba3-410f-a42e-e1013c449458@sirena.org.uk>
In-Reply-To: <6eb95724-9ba3-410f-a42e-e1013c449458@sirena.org.uk>
Subject: RE: [PATCH] ASoC/HDA cs35l56: Remove redundant IRQ handling
Date: Thu, 5 Sep 2024 11:15:04 +0100
Message-ID: <002401daff7c$79bc6bb0$6d354310$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQKHzAIo361Zljfa9iRBQSN4dy/XOQEQvrcuAYmGn2sCRS0RwLDIXT6A
X-Proofpoint-GUID: agu2UCo_fuirTBRrF8x0mjeOQ4ILMLXY
X-Proofpoint-ORIG-GUID: agu2UCo_fuirTBRrF8x0mjeOQ4ILMLXY
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 04, 2024 at 18:27:00PM +0000, Mark Brown wrote:
> On Wed, Sep 04, 2024 at 02:46:30PM +0100, Simon Trimmer wrote:
> > On Wed, Sep 04, 2024 at 12:25:00PM +0000, Mark Brown wrote:
> > > On Wed, Sep 04, 2024 at 12:07:00PM +0000, Simon Trimmer wrote:
> 
> > > > The IRQ handling in the cs35l56 driver was purely informational. It
was
> > > > not necessary to support the HDA or ASoC driver functionality and
added
> > > > unnecessary complexity to the drivers.
> 
> > > Given that the code is there now and has been since the driver was
> > > introduced about 18 months ago what's the ongoing cost of having it?
> > > The information it's providing is notification of hardware faults,
> > > reporting those does seem useful.
> 
> > Originally we were expecting to use the IRQ mechanism for an event
logging
> > stream that would function in a similar manner to compressed streams to
be
> > able to get an information feed for debug and tuning tools, but those
were
> > never created and the logging infrastructure not implemented.
> 
> Right.  Though ideally we might actually do something about some of
> the errors that are reported.
>
> > It's quite a spread of code and a lot of complexity in the regular
execution
> > paths managing them / synchronizing the contexts, there is more going on
in
> > the SoundWire bus variant compared to the conventional i2c/spi that it
is
> > hard to justify maintaining it all for a couple of log messages - in the
> > event that someone did encounter the two situations being reported the
> > regmap dump would point us to the cause pretty quickly.
> 
> I'm not sure how many end users are going to get as far as talking to
> you in the event that they have issues - people often won't get as far
> as trying to contact their distros or upstreams.  Even errors in dmesg
> are pretty obscure but they're more discoverable than interpreting the
> regmap, people would need to identify that they need to look at the chip
> first and actually be experiencing the problem when they figure that
> out.  Ideally we'd hae better handling for this (I did note that the
> latest Iron Devices driver will back off speaker volume during a thermal
> warning which isn't a terrible idea, though there's potential issues).

I'll have a chat to people when they are back at work - the IRQ signals we
were logging were from the firmware rather than the hardware as it entered a
protection state, this isn't fatal and can clear. Over the last few years I
don't think I've encountered them in testing except for when I deliberately
abused the hardware which I don't think anyone would recommend :)

How people behave when encountering trouble is certainly true - as more PCs
adopt our devices we have a steadily increasing stream of direct support
messages and have been getting tagged in distro issue reports. These have
been universally around missing support in particular kernel versions or the
linux-firmware package not containing the necessary tuning files, so far
I've only asked our field/partner engineers for a dump of a regmap and I've
not seen a report of a hardware warning yet but I too suspect these are the
tip of the iceberg for people encountering troubles.

A general Linux tangent - we had been debating how many of our end users
multiboot their hardware vs those who just run Linux on them - has anyone
seen any reports or statistics in this area?

> It sounds like the only real concern is the Soundwire stuff (I2C and SPI
> interrupt stuff should generally be trivial?) - if that's the case I'd
> be more inclined to only pull out the Soundwire bits and leave the
> support there for the simpler buses.

That is a good idea and would certainly make things better - I'll see what I
can do

-Simon



