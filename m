Return-Path: <linux-kernel+bounces-546338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2580FA4F96A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640BC1886EF2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E11FF7D8;
	Wed,  5 Mar 2025 09:01:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551E1C6FE8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165303; cv=none; b=rG0Lo0szmO19pF+2086V/Cs34tJgSUwB2ZTQ53dcsqOIWqkSCaWgXlG+tnLL4cFYvCafHxGoTKa3Rz4Td5XfdA0CSMWYOUXuyyV0rKa5Bn8FPfYXXhkNSq/ziuhF857EkDEaNzNE7vFKVsy36nBztdfFYPEJtaZONP+txfF77/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165303; c=relaxed/simple;
	bh=FNWlxy1hNjb33+KpyfHLdDcob9JZshR2zydDTm/aTaA=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EgEEkUfPel09+fxgqj7aGrnw4Co+eLGNYZdKXWQuyur2smLKY4cBjEY4SESyGLmJYlQgXhLK++IohBmtn4aubxJGLtba58qtlheTKIB9WQByHCO1VqK8iOObm+4TWOhkMk3fQCTz3isqr/yZ5PMwoo7gLgWEKYJIK739KIt0m1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z75zz0DvVzCs97;
	Wed,  5 Mar 2025 16:58:07 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id B769814022D;
	Wed,  5 Mar 2025 17:01:36 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 5 Mar 2025 17:01:35 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 3/4] arm64: topology: Support SMT control on ACPI
 based system
To: Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, <dietmar.eggemann@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-4-yangyicong@huawei.com> <Z8HAkZiHYRjj97M7@bogus>
 <336e9c4e-cd9c-4449-ba7b-60ee8774115d@arm.com>
 <20250228190641.q23vd53aaw42tcdi@bogus>
 <a52972c7-aadd-4a77-a292-057fa5f8372d@arm.com> <Z8WPiOweOjFZqTwN@bogus>
 <32e572d6-dedd-d8a3-13be-6de02303a64d@huawei.com>
 <2fdea4f6-db98-4dc7-947f-e19ee54d2c3c@arm.com> <Z8bPtsO7dEV0lq2M@bogus>
 <153df413-9989-42fe-b574-598ff0fa9716@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <86e32fb3-0ff5-f4f0-3d44-222e63b5a69f@huawei.com>
Date: Wed, 5 Mar 2025 17:01:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <153df413-9989-42fe-b574-598ff0fa9716@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/3/4 23:07, Pierre Gondois wrote:
> 
> 
> On 3/4/25 11:02, Sudeep Holla wrote:
>> On Tue, Mar 04, 2025 at 09:25:02AM +0100, Pierre Gondois wrote:
>>>
>>>
>>> On 3/3/25 15:40, Yicong Yang wrote:
>>>> On 2025/3/3 19:16, Sudeep Holla wrote:
>>>>> On Mon, Mar 03, 2025 at 10:56:12AM +0100, Pierre Gondois wrote:
>>>>>> On 2/28/25 20:06, Sudeep Holla wrote:
>>>>>>>>>
>>>>>>>>> Ditto as previous patch, can get rid if it is default 1.
>>>>>>>>>
>>>>>>>>
>>>>>>>> On non-SMT platforms, not calling cpu_smt_set_num_threads() leaves
>>>>>>>> cpu_smt_num_threads uninitialized to UINT_MAX:
>>>>>>>>
>>>>>>>> smt/active:0
>>>>>>>> smt/control:-1
>>>>>>>>
>>>>>>>> If cpu_smt_set_num_threads() is called:
>>>>>>>> active:0
>>>>>>>> control:notsupported
>>>>>>>>
>>>>>>>> So it might be slightly better to still initialize max_smt_thread_num.
>>>>>>>>
>>>>>>>
>>>>>>> Sure, what I meant is to have max_smt_thread_num set to 1 by default is
>>>>>>> that is what needed anyways and the above code does that now.
>>>>>>>
>>>>>>> Why not start with initialised to 1 instead ?
>>>>>>> Of course some current logic needs to change around testing it for zero.
>>>>>>>
>>>>>>
>>>>>> I think there would still be a way to check against the default value.
>>>>>> If we have:
>>>>>> unsigned int max_smt_thread_num = 1;
>>>>>>
>>>>>> then on a platform with 2 threads, the detection condition would trigger:
>>>>>> xa_for_each(&hetero_cpu, hetero_id, entry) {
>>>>>>       if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)     <---- (entry->thread_num=2) and (max_smt_thread_num=1)
>>>>>>           pr_warn_once("Heterogeneous SMT topology is partly
>>>>>>                         supported by SMT control\n");
>>>>>>
>>>>>> so we would need an additional variable:
>>>>>> bool is_initialized = false;
>>>>>
>>>>> Sure, we could do that or skip the check if max_smt_thread_num == 1 ?
>>>>>
>>>>> I mean
>>>>>     if (entry->thread_num != max_smt_thread_num && max_smt_thread_num != 1)
>>>>>
>>>
>>> I think it will be problematic if we parse:
>>> - first a CPU with 1 thread
>>> - then a CPU with 2 threads
>>>
>>> in that case we should detect the 'Heterogeneous SMT topology',
>>> but we cannot because we don't know whether max_smt_thread_num=1
>>> because 1 is the default value or we found a CPU with one thread.
>>
>> Right, but as per Dietmar's and my previous response, it may be a valid
>> case. See latest response from Dietmar which is explicitly requesting
>> support for this. It may need some special handling if we decide to support
>> that.
> 
> Ah ok, right indeed.
> For heterogeneous SMT platforms, the 'smt/control' file is able to accept
> on/off/forceoff strings. But providing the max #count of threads as an integer would
> be wrong if the CPU doesn't have this #count of threads.
> 
> Initially the idea was to just warn that support might be needed for heterogeneous
> SMT platforms, and let whoever would have such platform solve this case, but just
> disabling the integer interface in this case would solve the issue generically.
> 

ok so let's regard the asymmetric platform as a valid case as suggested (also mentioned
by Dietmar on another thread) and remove the check here. Will update and test.

Thanks.


