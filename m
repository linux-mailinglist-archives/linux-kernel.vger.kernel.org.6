Return-Path: <linux-kernel+bounces-182092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD08C862D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FB7281143
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84CE41213;
	Fri, 17 May 2024 12:16:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFFE18651
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948208; cv=none; b=OpnSXjzHkwkpvfxTW168uJB9pSaNBcky3qKB+dMouesQPNsGMgaMkN22cjUkiLG4mXfr8cP6kmaYAR6dqrb1HwqpxxK+q5qXE7l5Ocek7ZQx+y5Sv+LmZz/8hZmLqj/O8WxzGSsBYRtJp1ZaXeyUEY0MzjvpSULn56p7wbbzgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948208; c=relaxed/simple;
	bh=FMEIJwpBSoHxgQQzBAd+1A3d9AcAxtLG1GG25U5na/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dckb6EKzw8WbG+mC2HSWuHqJlHv7Ls17uPrNmhY+Yk7uCPXPBGEAa0TEkY+Wb/KvPu8Mxhfa6FNYSDCIPsSC1EQqWbq3fMTPw/e5AW+96jOIZNb5iB5TQMaweTy8izg4dtnq7t2GeGJ28m3z8g8KEjpsbb71fyu0iFysdcPE2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85D5B1424;
	Fri, 17 May 2024 05:17:08 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3901C3F7A6;
	Fri, 17 May 2024 05:16:41 -0700 (PDT)
Message-ID: <e5497be9-85c7-42ac-925d-194b690a0eac@arm.com>
Date: Fri, 17 May 2024 13:16:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-dmc620: Fix lockdep assert in ->event_init()
To: Will Deacon <will@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, Greg Thelen <gthelen@google.com>,
 Tuan Phan <tuanphan@os.amperecomputing.com>
References: <20240514180050.182454-1-namhyung@kernel.org>
 <20240517120234.GA32598@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240517120234.GA32598@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/05/2024 1:02 pm, Will Deacon wrote:
> On Tue, May 14, 2024 at 11:00:50AM -0700, Namhyung Kim wrote:
>> for_each_sibling_event() checks leader's ctx but it doesn't have the ctx
>> yet if it's the leader.  Like in perf_event_validate_size(), we should
>> skip checking siblings in that case.
>>
>> Fixes: f3c0eba287049 ("perf: Add a few assertions")
>> Reported-by: Greg Thelen <gthelen@google.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Tuan Phan <tuanphan@os.amperecomputing.com>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   drivers/perf/arm_dmc620_pmu.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
>> index 8a81be2dd5ec..88c17c1d6d49 100644
>> --- a/drivers/perf/arm_dmc620_pmu.c
>> +++ b/drivers/perf/arm_dmc620_pmu.c
>> @@ -542,12 +542,16 @@ static int dmc620_pmu_event_init(struct perf_event *event)
>>   	if (event->cpu < 0)
>>   		return -EINVAL;
>>   
>> +	hwc->idx = -1;
>> +
>> +	if (event->group_leader == event)
>> +		return 0;
>> +
>>   	/*
>>   	 * We can't atomically disable all HW counters so only one event allowed,
>>   	 * although software events are acceptable.
>>   	 */
>> -	if (event->group_leader != event &&
>> -			!is_software_event(event->group_leader))
>> +	if (!is_software_event(event->group_leader))
>>   		return -EINVAL;

Oh, come to think of it, I believe we shouldn't actually need to keep 
this check either, since commit bf480f938566 ("perf/core: Don't allow 
grouping events from different hw pmus").

Thanks,
Robin.

>>   
>>   	for_each_sibling_event(sibling, event->group_leader) {
>> @@ -556,7 +560,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
>>   			return -EINVAL;
>>   	}
>>   
>> -	hwc->idx = -1;
>>   	return 0;
>>   }
> 
> Thanks, I'll pick this up, although Mark reckoned he'd found some other
> issues over at:
> 
> https://lore.kernel.org/r/Zg0l642PgQ7T3a8Z@FVFF77S0Q05N
> 
> but didn't elaborate on what exactly he'd found :/
> 
> Will
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

