Return-Path: <linux-kernel+bounces-219824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27CD90D847
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F62C285B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312150246;
	Tue, 18 Jun 2024 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RJ8tiCGq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B74D8B1;
	Tue, 18 Jun 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726893; cv=none; b=pzIyEhXm1bHqmfSRdCQEH6wHVQrsdFq0r3KK6MyML49xOIDI4cyYEsCETTPjggh1S880sOn2UyImvYMzTznh6GyeXQ4oldm89cTNh3QRU9hUzmeAz/3WnGxRvRVm8p66ncqgzbP16xZfPc+2TDU6DMUeRrVfEotA0L8NfE6nn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726893; c=relaxed/simple;
	bh=yhY+yhNuhzV8JcsD1wggApPMn0SgSn2LCJATgteCg2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=awyAl7emTSY3l9aTPaNXkWGH41itPeFIZa6TxPMkTXIlgPKhfD5fpUFuNOIkKGEGDAf3QrFObpexasPepRgCe7tc3367ZgLahnG0ulLBE/GXB0tr9VSOE0pljgGxMzk3dSa5c0dvuN9f7WdNluUrUnq9i9BX9oO4FW85KJkJqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RJ8tiCGq; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I58k5G021062;
	Tue, 18 Jun 2024 11:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=cLMCJLpV9wdh2VF9wEnp5mIrYOMRWX08/KC4Xg9ztoo=; b=
	RJ8tiCGqpXMLc0fkWTw5C77L+anhwySW8KUAWHElzlZzg0KglZVeX0J8eQxZtg/i
	ZuHF8vcQgunP5IOTuEBZNMA5fZ9M4Fnhq7zmeNMi/XWtaHmY3z4UdRCah03TBlCO
	najozzq2Wvg1I2RpFY1uVhwoIhWyMmmKqEAC3vE0zYCT2UB3bHijxXaU8zOzN0FH
	wY3IND03om7MZ6Wj8eBCWsdesoN2LyaQJYsJxeBrz3XNiFsyfi16wXPER6EgCf7I
	twVDGv9enEte6TCkcRADR3QL4MSuEWDMVG8Wg2kbnxOxwWr53ytWfCHSVDjVlP6N
	QURPP94xAJcot3TcHvkjPw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ys8by3nqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:08:02 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 17:07:59 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 18 Jun 2024 17:07:59 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E66D5820248;
	Tue, 18 Jun 2024 16:07:59 +0000 (UTC)
Message-ID: <9743c769-2aea-4b5a-90fc-30f79867ec5f@opensource.cirrus.com>
Date: Tue, 18 Jun 2024 17:07:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
To: Mark Brown <broonie@kernel.org>
CC: Simon Trimmer <simont@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk>
 <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
 <dfa7d5d7-2501-4c5f-a6e2-792c7aeb9bb3@sirena.org.uk>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <dfa7d5d7-2501-4c5f-a6e2-792c7aeb9bb3@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UaEanV-Hg3BbgB7qFmaFbiOM4g9li3Va
X-Proofpoint-GUID: UaEanV-Hg3BbgB7qFmaFbiOM4g9li3Va
X-Proofpoint-Spam-Reason: safe

On 18/06/2024 16:58, Mark Brown wrote:
> On Mon, Jun 17, 2024 at 03:33:59PM +0100, Richard Fitzgerald wrote:
>> On 17/06/2024 15:04, Mark Brown wrote:
> 
>>> Have all architectures removed 0 as a valid IRQ?
> 
>>  From discussion threads we can find 0 might still used on x86 for a
>> legacy device.
> 
> Some of the arm platforms were also an issue in the past, though
> possibly they've all been modernised by now.  Don't know about other
> older architectures.
> 
>> But the conversations we can find on this don't seem to exclude passing
>> a negative error number, just that 0 can normally be assumed invalid.
> 
> Yes, the question was specifically about the assumption that 0 is
> invalid.  The status of 0 is kind of a mess, people keep assuming that
> it isn't valid and it just depends if users of platforms which try to
> use 0 trip up over it.  Sometimes people work on trying to eliminate
> uses of 0 but it tends to get you into older code nobody wants to touch.
> 
>> The kerneldoc for SPI says:
> 
>>   * @irq: Negative, or the number passed to request_irq() to receive
>>   *	interrupts from this device.
> 
> Which includes the 0 as valid thing...
The statement of truth from Linus Torvalds et al. seems to be that 0 is
invalid except on x86. And on x86 it is specifically reserved for a
legacy timer IRQ so it can't be anything else.

