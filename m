Return-Path: <linux-kernel+bounces-551738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28FA57023
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5BC188CF1D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A623FC54;
	Fri,  7 Mar 2025 18:08:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418D18DB32
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370925; cv=none; b=XzCBNhABlz0MOe0lFj6w8DUxRQ/rj17rvsVFskERgNj6LTu2YFENIM2AtywYfl2HlfCtUZEAhXPmk9rwe2iGwQAxU74zulrVp1xv3M2/L0NzyGegdXabapNdVFFyZGNsCO7hd4SUgExLCtO7Jo7cnD2mErJjol96lKoCiYEkpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370925; c=relaxed/simple;
	bh=LZnI5p8xIDvueq3e9u19eadPmK04KRDX31Qbc8+mNZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGUqk/Jqv72zGIGgFJzOx/jvsmACYlXSYwL7y4PHtjIAIBJJvwGGbtUMiThx+O48AV7EZJuzL3tw/88YHDn+5jd/RxvcdeoUh4v6UfyBsgHRj5BK+oT1AyQPyYDACv8Wi4BGN0orhiV9/MA/qa9SYlqVRhUTT33cRA9KmNg6OIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A60EF1A2D;
	Fri,  7 Mar 2025 10:08:54 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7E493F66E;
	Fri,  7 Mar 2025 10:08:35 -0800 (PST)
Message-ID: <c064e0d4-e120-4921-a226-db0ec5ac409c@arm.com>
Date: Fri, 7 Mar 2025 18:08:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/49] x86/resctrl: Generate default_ctrl instead of
 sharing it
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-9-james.morse@arm.com>
 <ab7becca-7a14-44d2-b0e3-1b12655c8be1@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <ab7becca-7a14-44d2-b0e3-1b12655c8be1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 07/03/2025 04:33, Reinette Chatre wrote:
> On 2/28/25 11:58 AM, James Morse wrote:
>> The struct rdt_resource default_ctrl is used by both the architecture
>> code for resetting the hardware controls, and sometimes by the
>> filesystem code as the default value for the schema, unless the
>> bandwidth software controller is in use.
>>
>> Having the default exposed by the architecture code causes unnecessary
>> duplication for each architecture as the default value must be specified,
>> but can be derived from other schema properties. Now that the
>> maximum bandwidth is explicitly described, resctrl can derive the default
>> value from the schema format and the other resource properties.

>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 4504a12efc97..5280a2819760 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -143,7 +143,10 @@ static inline void cache_alloc_hsw_probe(void)
>>  {
>>  	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
>>  	struct rdt_resource *r  = &hw_res->r_resctrl;
>> -	u64 max_cbm = BIT_ULL_MASK(20) - 1, l3_cbm_0;
>> +	u64 max_cbm, l3_cbm_0;
>> +
>> +	r->cache.cbm_len = 20;
>> +	max_cbm = resctrl_get_default_ctrl(r);
>>  
>>  	if (wrmsrl_safe(MSR_IA32_L3_CBM_BASE, max_cbm))
>>  		return;
> 
> It is unclear to me why this architecture code continues to use
> resctrl_get_default_ctrl() while you switched away from it in the other
> architecture code.
> As resctrl_get_default_ctrl() is "intended for callers that don't know
> or care what the format is" [1], here it clearly is required to be a
> bitmask. Using resctrl_get_default_ctrl() here also seems to contradict
> your argument for not using it in cbm_validate(). [1]

Sure, I'll drop this hunk on the same reasoning.


Thanks,

James

