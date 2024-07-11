Return-Path: <linux-kernel+bounces-249153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8592E7B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495EA1F23025
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD215B119;
	Thu, 11 Jul 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Po+6D5K3"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378915A868
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698966; cv=none; b=ZF2zaaG8kTlPe07iEy03j88q9v9QFitzwd5v2Xmi5vvQ1/xXC8jQZu8zi4vQY423unRnXfFRSIAZafyPoyHuRSIItsUdKi4WgrukvEm1F4RE3MVIvfQQWlWEi4Zu+/KICSoh1m+UjkmQM6parusjF8y7ZGUK8MNvLVLiCjdXzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698966; c=relaxed/simple;
	bh=gRrWZPXbbuh38L30PIccHIvZEjlCcuqdTNLnyWeuziM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JsAmkuo0RS6iv7lqv2WOjkmWQCfgCt48vJrnF36JENhhaqnO7nb6TOB55c0vOp5tGOB513kjqSX2CkeL2gtGVzfh/nkosmV+jeXcawjsXtwxAocuq2aTbNYWKl07SPWyTPGHAQg8ApuE3PEvoE3l4PNRs18Z8P6vdiouYewVjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Po+6D5K3; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FmKQiCVwoJvQlzRn+/H/6S98Ji9W5JbPGtmsQUBhz88=; b=Po+6D5K3g32wOLM0bI2Fz6FySC
	Uz1m0uFf6/ibVas2/bMI11yotq1lvSJ501NnNrTQbiCL2X+kXH+YuGtz80Q38VrMIA+CzXZPtTeP6
	Lh8XHmI8ZD4Lm59oKCJdfK85+IoCjGmymEnaAvPqAUxeortxGCmjtlk+Hbf6B5xE5n7wwNAFZLiWj
	RNPhWeDzo5bD4rHKk3eb5FeWa/WO54LqViYXIUmvEe7RTa429ZJd4HDkyPkS7Ic7lJ5WX//HlGKgN
	tJKdI1G/pzOrPUiq5slTxOLrXME5lNYTQxa0iqL2OdId/ijlZFr+W9LUoWJ7LzmoegbRN/SKXtdzq
	l3ouvOLA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRsP0-00013f-Is; Thu, 11 Jul 2024 13:55:58 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRsOz-0006wb-2G;
	Thu, 11 Jul 2024 13:55:58 +0200
From: Esben Haabendal <esben@geanix.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
In-Reply-To: <D2ML6RG09T38.RZU3CCH0XD9I@kernel.org> (Michael Walle's message
	of "Thu, 11 Jul 2024 11:02:39 +0200")
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
	<20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com>
	<a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org>
	<D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org> <871q413x72.fsf@geanix.com>
	<D2ML6RG09T38.RZU3CCH0XD9I@kernel.org>
Date: Thu, 11 Jul 2024 13:55:57 +0200
Message-ID: <87zfqoqh0y.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

"Michael Walle" <mwalle@kernel.org> writes:

>> > I actually had the same concern. But currently there is no
>> > non-deprecated way to handle this case, right?
>> >
>> > Right now we have the following cases:
>> >  (1) pure SFDP parsing
>> >  (2) non-SFDP flashes with static configuration only
>> >  (3) legacy implementation, where the magic flags decide whether we
>> >      use SFDP
>>
>> Actually, in the code we have two variants of 2.
>>
>> (2a) non-SFDP flashes with SPI_NOR_SKIP_SFDP set
>> (2b) non-SFDP flashes without SPI_NOR_SKIP_SFDP and with none of the
>>      DUAL/QUAD/OCTAL read bits set
>
> Isn't (2b) my case (3)? The SPI_NOR_SKIP_SFDP flag was intended to
> be for flashes we know for a fact, there are no SFDP tables.
>
> I'm looking at spi_nor_init_params(). Maybe I'm missing something?

Probably not. I might just be confusing things here.

Your case (3) is conditional. Based on the magic flags checking in
spi_nor_init_params_deprecated(), it is either doing static
configuration only (this is what I tried to redefine as case (2b)) or
parsing SFDP with fallback to static configuration.

The issue I am getting at is that while the 2 different ways to end up
doing static configuration only is almost identical, there is a slight
difference.

But I will be addressing this in a v3 patch of this series.

Coming up shortly, and looking forward to discuss it.

/Esben

>> These almost handled the same way. But
>> spi_nor_manufacturer_init_params() is only called for 2b, and not for
>> 2a.
>>
>> Is this desired behavior, or something that we want to align?
>>
>> > Which case is eventually used depends on the ID of the flash -
>> > assuming there will only be IDs which either fall into (1) *or* (2).
>> > That assumption is clearly wrong :)
>> >
>> > I'd propose a new case in spi_nor_init_params()
>> >  (4) try SFDP with a fallback to the static flags from the
>> >      flash_info db.
>>
>> /Esben

