Return-Path: <linux-kernel+bounces-292528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330B3957078
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3BB1F242A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1643117838F;
	Mon, 19 Aug 2024 16:35:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB171779A9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085351; cv=none; b=kQ7lV9eojt3lGFlmWv8V2V0eqNZKGtToCGF4ZrwpaOeIqzSD1vePmBjWXgYQkzK1w9oSFZwm/JFjyhAdHvKR2TP9Zqu7wN7Vij8mswCQ+nANcw0eK2Q7QcWpk0nYH4sfNFGuXBo9OH90aPWRYptcaoAJ+YHSSpStyI5wwYkBgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085351; c=relaxed/simple;
	bh=0s0wtDKdE1qj/vDUAxqDBI8lMHTGn0YD7eZspiSvTgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWfOwVZHfaCgEOhml+IphPr1LgPYwnTVkzWuSIkCzW7S6LwTPjBPy4fQKgE0Q2/JUgKF1p9F38HDitcOd8pQQegKGeRhc/b1MNK887NRNOQZ5zHOtI6SndQgDwX+9JLTOE4FnPixWuPP6GZ2rVluZrZ3qbRo0aAZLKaIJ0dQzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D52D0339;
	Mon, 19 Aug 2024 09:36:14 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF5413F66E;
	Mon, 19 Aug 2024 09:35:47 -0700 (PDT)
Message-ID: <5286c498-99a4-4068-8f0e-5d99e18519bf@arm.com>
Date: Mon, 19 Aug 2024 17:35:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] perf/arm-cmn: Make cycle counts less surprising
To: Mark Rutland <mark.rutland@arm.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com
References: <cover.1723229941.git.robin.murphy@arm.com>
 <570c473134426b8e11bb043aa59e3cde3dab8af3.1723229941.git.robin.murphy@arm.com>
 <Zr8pGEMmzmexNGL8@J2N7QTR9R3>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zr8pGEMmzmexNGL8@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2024 11:25 am, Mark Rutland wrote:
> On Fri, Aug 09, 2024 at 08:15:44PM +0100, Robin Murphy wrote:
>> By default, CMN has automatic clock-gating with the implication that a
>> DTC's cycle counter may not increment while the domain is sufficiently
>> idle.
> 
> Similar is true for the cycles event on the CPU side, so this has some
> precedent.
> 
>> Given that we may have up to 4 DTCs to choose from when scheduling
>> a cycles event, this may potentially lead to surprising results if
>> trying to measure metrics based on activity in a different DTC domain
>> from where cycles end up being counted. Make the reasonable assumption
>> that if the user wants to count cycles, they almost certainly want to
>> count all of the cycles, and disable clock gating while a DTC's cycle
>> counter is in use.
> 
> As above, the default does match the CPU side behaviour,

It may end up looking equivalent with only a single DTC domain, but the 
effect with multiple DTCs is as if any cpu_cycles event always counted 
on CPU0 (or more recently, any random CPU) - that's the real issue here.

> and a user
> might be trying to determine how much clock gating occurs over some
> period, so it's not necessarily right to always disable clock gating.
> That might need to be an explicit option on the cycles event.

I have also been wondering whether there would be any use-case for a 
"dtc_active_cycles" event, but it would would have to be targeted at a 
specific DTC node ID or domain number to be meaningful, so would still 
be a new thing either way, but even then it seems it would be incredibly 
niche - you couldn't get an actual measure of idleness without a second 
DTC to count ungated cycles over the same period, and it could only be 
correlated with targeted single-node events, since we don't have support 
or a syntax for aggregating only within a specific DTC domain.

Yes, some of that could be achieved, but it would represent significant 
further complication to the driver and interface, in aid of something 
which to the best of my knowledge nobody's actually asking for. What 
users *have* asked me, though, is why they were seeing inconsistent 
dtc_cycles counts, hence this patch.

> Do we always have the ability to disable clock gating, or can that be
> locked down by system integration or FW?

Yes, the entire PMU may be locked down by a secure override, but 
otherwise if we do have use of the DTC then there is no limitation on 
cg_disable itself.

Thanks,
Robin.

> 
> Mark.
> 
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/perf/arm-cmn.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index 8f7a1a6f8ab7..4d128db2040c 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -115,6 +115,7 @@
>>   /* The DTC node is where the magic happens */
>>   #define CMN_DT_DTC_CTL			0x0a00
>>   #define CMN_DT_DTC_CTL_DT_EN		BIT(0)
>> +#define CMN_DT_DTC_CTL_CG_DISABLE	BIT(10)
>>   
>>   /* DTC counters are paired in 64-bit registers on a 16-byte stride. Yuck */
>>   #define _CMN_DT_CNT_REG(n)		((((n) / 2) * 4 + (n) % 2) * 4)
>> @@ -1544,9 +1545,12 @@ static void arm_cmn_event_start(struct perf_event *event, int flags)
>>   	int i;
>>   
>>   	if (type == CMN_TYPE_DTC) {
>> -		i = hw->dtc_idx[0];
>> -		writeq_relaxed(CMN_CC_INIT, cmn->dtc[i].base + CMN_DT_PMCCNTR);
>> -		cmn->dtc[i].cc_active = true;
>> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
>> +
>> +		writel_relaxed(CMN_DT_DTC_CTL_DT_EN | CMN_DT_DTC_CTL_CG_DISABLE,
>> +			       dtc->base + CMN_DT_DTC_CTL);
>> +		writeq_relaxed(CMN_CC_INIT, dtc->base + CMN_DT_PMCCNTR);
>> +		dtc->cc_active = true;
>>   	} else if (type == CMN_TYPE_WP) {
>>   		u64 val = CMN_EVENT_WP_VAL(event);
>>   		u64 mask = CMN_EVENT_WP_MASK(event);
>> @@ -1575,8 +1579,10 @@ static void arm_cmn_event_stop(struct perf_event *event, int flags)
>>   	int i;
>>   
>>   	if (type == CMN_TYPE_DTC) {
>> -		i = hw->dtc_idx[0];
>> -		cmn->dtc[i].cc_active = false;
>> +		struct arm_cmn_dtc *dtc = cmn->dtc + hw->dtc_idx[0];
>> +
>> +		dtc->cc_active = false;
>> +		writel_relaxed(CMN_DT_DTC_CTL_DT_EN, dtc->base + CMN_DT_DTC_CTL);
>>   	} else if (type == CMN_TYPE_WP) {
>>   		for_each_hw_dn(hw, dn, i) {
>>   			void __iomem *base = dn->pmu_base + CMN_DTM_OFFSET(hw->dtm_offset);
>> -- 
>> 2.39.2.101.g768bb238c484.dirty
>>

