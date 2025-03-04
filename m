Return-Path: <linux-kernel+bounces-543487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF02A4D63C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9B81740ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C261F891D;
	Tue,  4 Mar 2025 08:25:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6811FBCA1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076718; cv=none; b=Iv0053RkY+0Q9pJoXWcBIEjElnNdyyM2JRjtgbB7l9uWp5ZInmPrJlXy7mhRvVMJ/bzjpv2N/lA2qPNILW3UlleTrd+LPRWdWEz/s1920OztrFQMTE2cPyCrH8NO6Sc9H1NjcsTyj5iuA3S0q2IzXkfjKqhhqZbGoetY9birhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076718; c=relaxed/simple;
	bh=togOrjhO7oN1fgPiaw6Ef3qgBVgHc4Hv5BClWtBVcS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLX6a+446/2VlWvy+ERr4wsz8SOFzMIdpRlpLoduCgQf/WwmyOhW+BYw2hSuGdyaIBub7wb86xrJtIr+2uXg3nkOonz75AHuURJsw1MFrAgXA346w5JVcmdd/u6KsIbOblqFvrtB4psCSszYxbc/IwF0LLHuNAK218uhxWS6k94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 634871063;
	Tue,  4 Mar 2025 00:25:27 -0800 (PST)
Received: from [10.34.129.29] (unknown [10.34.129.29])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5ACD3F66E;
	Tue,  4 Mar 2025 00:25:08 -0800 (PST)
Message-ID: <2fdea4f6-db98-4dc7-947f-e19ee54d2c3c@arm.com>
Date: Tue, 4 Mar 2025 09:25:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] arm64: topology: Support SMT control on ACPI
 based system
To: Yicong Yang <yangyicong@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: yangyicong@hisilicon.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, peterz@infradead.org, mpe@ellerman.id.au,
 linux-arm-kernel@lists.infradead.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, dietmar.eggemann@arm.com,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 morten.rasmussen@arm.com, msuchanek@suse.de, gregkh@linuxfoundation.org,
 rafael@kernel.org, jonathan.cameron@huawei.com, prime.zeng@hisilicon.com,
 linuxarm@huawei.com, xuwei5@huawei.com, guohanjun@huawei.com,
 sshegde@linux.ibm.com
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-4-yangyicong@huawei.com> <Z8HAkZiHYRjj97M7@bogus>
 <336e9c4e-cd9c-4449-ba7b-60ee8774115d@arm.com>
 <20250228190641.q23vd53aaw42tcdi@bogus>
 <a52972c7-aadd-4a77-a292-057fa5f8372d@arm.com> <Z8WPiOweOjFZqTwN@bogus>
 <32e572d6-dedd-d8a3-13be-6de02303a64d@huawei.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <32e572d6-dedd-d8a3-13be-6de02303a64d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/25 15:40, Yicong Yang wrote:
> On 2025/3/3 19:16, Sudeep Holla wrote:
>> On Mon, Mar 03, 2025 at 10:56:12AM +0100, Pierre Gondois wrote:
>>> On 2/28/25 20:06, Sudeep Holla wrote:
>>>>>>
>>>>>> Ditto as previous patch, can get rid if it is default 1.
>>>>>>
>>>>>
>>>>> On non-SMT platforms, not calling cpu_smt_set_num_threads() leaves
>>>>> cpu_smt_num_threads uninitialized to UINT_MAX:
>>>>>
>>>>> smt/active:0
>>>>> smt/control:-1
>>>>>
>>>>> If cpu_smt_set_num_threads() is called:
>>>>> active:0
>>>>> control:notsupported
>>>>>
>>>>> So it might be slightly better to still initialize max_smt_thread_num.
>>>>>
>>>>
>>>> Sure, what I meant is to have max_smt_thread_num set to 1 by default is
>>>> that is what needed anyways and the above code does that now.
>>>>
>>>> Why not start with initialised to 1 instead ?
>>>> Of course some current logic needs to change around testing it for zero.
>>>>
>>>
>>> I think there would still be a way to check against the default value.
>>> If we have:
>>> unsigned int max_smt_thread_num = 1;
>>>
>>> then on a platform with 2 threads, the detection condition would trigger:
>>> xa_for_each(&hetero_cpu, hetero_id, entry) {
>>>      if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)     <---- (entry->thread_num=2) and (max_smt_thread_num=1)
>>>          pr_warn_once("Heterogeneous SMT topology is partly
>>>                        supported by SMT control\n");
>>>
>>> so we would need an additional variable:
>>> bool is_initialized = false;
>>
>> Sure, we could do that or skip the check if max_smt_thread_num == 1 ?
>>
>> I mean
>> 	if (entry->thread_num != max_smt_thread_num && max_smt_thread_num != 1)
>>

I think it will be problematic if we parse:
- first a CPU with 1 thread
- then a CPU with 2 threads

in that case we should detect the 'Heterogeneous SMT topology',
but we cannot because we don't know whether max_smt_thread_num=1
because 1 is the default value or we found a CPU with one thread.

