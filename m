Return-Path: <linux-kernel+bounces-217778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41F90B424
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FD71C223E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA9E1D9526;
	Mon, 17 Jun 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="K4cnZyR6"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723F1D9504;
	Mon, 17 Jun 2024 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636055; cv=none; b=a44EMTrombUTD0bG6RA3RJNCwjx9jfSt/tvCIg0ROcxNnQpmbJr5Bb01O9WPgBo4Ty54pIt8KIT60rJAqGpr98UDbwabbXDP0M0qkOs+zjy3kjebQKUL+D0AetDDSiZosi5CWVgHoQSYTVizZVweSPNBiUeYKzP7rxqao7qwodY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636055; c=relaxed/simple;
	bh=8oz61KWwx6qENWt5I3pmMWNMNjv+GnIgq4rfWORK2Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TfSMZ6z44rdGtwCK3pOviG52W7PCb0FycYV5JMyTnALwOtfMEfj256sfPQYwLFlVm1Fecv3KMAv0dRZVwevbVyeQyF+sH9FEtjSr08ZIsudu4FLdvCyBsQRzmPjIiJrgzZc8bqxBs3m0BX2TpnGPxARXn+UP91XzBlCGLOBG53w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=K4cnZyR6; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45H5aOP3023213;
	Mon, 17 Jun 2024 09:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=U4Zcc5B6sZapyPApYGDjLIIl5Wrww3U183306p+JLwY=; b=
	K4cnZyR69TYqf7B21jLk2FGNqTw+ymA07UWw0Ke2XrA23e7KoYq2AjkQEWLQYPS3
	30kKZjbIsP7FzIbjTYNeuTwEG/YDgAWZHcg50iKIWdFwaGAkqoRhyRb4JhoI7ukF
	k5QN7vqIn3lOrkgVD6CcEqNk67GL7QIXkFM5JSRWNZA6o2TyII9mYU2/DBLZQuu3
	7FP74T7D4n6hURaOVvBm6Tdu0aqZ+Zw7Y8iS+PpsZ93pRw1dqboBAok6ZmKl9Xla
	hf2O+nv/llcg5lPr+BeevW0z2zAjDNW5HLTHarfzMsyfxgswsewbbmKGUNB9h8n0
	w6xa9hiIXpHEC1D2oELQvA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ys8by1tuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 09:54:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 15:54:04 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 17 Jun 2024 15:54:04 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AD2FB820248;
	Mon, 17 Jun 2024 14:54:04 +0000 (UTC)
Message-ID: <f04958f0-b9e9-4f80-8a83-af9740fa83a0@opensource.cirrus.com>
Date: Mon, 17 Jun 2024 15:54:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
To: Simon Trimmer <simont@opensource.cirrus.com>,
        'Mark Brown'
	<broonie@kernel.org>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <917507e5-dc6c-4e18-a7e1-554625de604e@sirena.org.uk>
 <3451fcf6-ff33-4f72-83d1-945b026b925b@opensource.cirrus.com>
 <007b01dac0c5$7807ac30$68170490$@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <007b01dac0c5$7807ac30$68170490$@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: OnFXQ3XDq3MuxA7uOj9oWBSc-IXlVLcw
X-Proofpoint-GUID: OnFXQ3XDq3MuxA7uOj9oWBSc-IXlVLcw
X-Proofpoint-Spam-Reason: safe

On 17/06/2024 15:48, Simon Trimmer wrote:
>> From: Richard Fitzgerald <rf@opensource.cirrus.com>
>> Sent: Monday, June 17, 2024 3:34 PM
>> On 17/06/2024 15:04, Mark Brown wrote:
>>> On Mon, Jun 17, 2024 at 02:53:38PM +0100, Simon Trimmer wrote:
>>>> IRQ lookup functions such as those in ACPI can return error values when
>>>> an IRQ is not defined. The i2c core driver converts the error codes to
> a
>>>> value of 0 and the SPI bus driver passes them unaltered to client
> device
>>>> drivers.
>>>>
>>>> The cs35l56 driver should only accept positive non-zero values as IRQ
>>>> numbers.
>>>
>>> Have all architectures removed 0 as a valid IRQ?
>>
>>   From discussion threads we can find 0 might still used on x86 for a
>> legacy device.
>> But the conversations we can find on this don't seem to exclude passing
>> a negative error number, just that 0 can normally be assumed invalid.
>>
>> The kerneldoc for SPI says:
>>
>>    * @irq: Negative, or the number passed to request_irq() to receive
>>    *	interrupts from this device.
> 
> Yes and the threads of these lore links in these commits are rather feisty
> 
> ce753ad1549c platform: finally disallow IRQ0 in platform_get_irq() and its
> ilk
> a85a6c86c25b driver core: platform: Clarify that IRQ 0 is invalid
> 
> 
So 0 is invalid. Question is: is it also valid to pass -ve errors, or is
0 the _only_ invalid value?

