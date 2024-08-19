Return-Path: <linux-kernel+bounces-292536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD8957099
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A7B1C22F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5B176ABA;
	Mon, 19 Aug 2024 16:41:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6249013211A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085696; cv=none; b=MdBkHQx6Tcj8fw7tdW9loyj9l/LtB5WfWi0YA5yPSx0Q7Fn5mS5w1CEHy0nXYG/geDgBs/aLSUPLkcnY2lfOEOI3wF1gEmBQEu2akSheL9Fpj/PkknAeSRCNsPhUEOyGNAKn+RVsaoXe/UtxszVhpZASoY81EjiCzow/UhID8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085696; c=relaxed/simple;
	bh=3QUx/S7AQ9TtLOfTEo6EmZ9mi6VTFou1KPHF3+m2plM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoEH7osyVf7agXAgh3CYFIw6KbTnM9MJK9njGvbkvmCw+G97h0cvSR6lQvrIDJmwWH15cOiRFa8Xoc4nIY6eGkMf1Qb1cgiI0yj4P2pKX0b9hoP2bKgTJs1sbpKTosEuPDIk+31YxMr4uezCd9t23fGR/rowH4nk2YvmUrHX+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 294FB339;
	Mon, 19 Aug 2024 09:41:59 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E30E83F58B;
	Mon, 19 Aug 2024 09:41:31 -0700 (PDT)
Message-ID: <4854a6b2-805a-4705-b2d2-df723cfc1311@arm.com>
Date: Mon, 19 Aug 2024 17:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] perf/arm-cmn: Refactor DTC PMU register access
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
References: <cover.1723229941.git.robin.murphy@arm.com>
 <e1aac7d482e6f4a75819edcde1fd3198099a658c.1723229941.git.robin.murphy@arm.com>
 <Zr8p96jwMHepFeq7@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zr8p96jwMHepFeq7@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 11:29 am, Mark Rutland wrote:
> On Fri, Aug 09, 2024 at 08:15:45PM +0100, Robin Murphy wrote:
>> Annoyingly, we're soon going to have to cope with PMU registers moving
>> about. This will mostly be straightforward, except for the hard-coding
>> of CMN_PMU_OFFSET for the DTC PMU registers. As a first step, refactor
>> those accessors to allow for encapsulating a variable offset without
>> making a big mess all over.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm-cmn.c | 64 ++++++++++++++++++++++++------------------
>>   1 file changed, 36 insertions(+), 28 deletions(-)
> 
> Aside from a minoe comment below this looks fine to me.
> 
>>   struct arm_cmn_dtc {
>>   	void __iomem *base;
>> +	void __iomem *pmu_base;
>>   	int irq;
>> -	int irq_friend;
>> +	s8 irq_friend;
> 
> Unrelated change?
> 
> AFAICT there's no reason for 'irq_friend' to change from 'int' to 's8',
> and nothing in the commit message explains it.

Oops, I had meant to note in the commit message that this is a little 
structure repacking where there was a hole already, to compensate for 
adding the new member... I shall un-forget that for v2.

> Otherwise this all looks fine to me.

Thanks,
Robin.

> 
> Mark.

