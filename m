Return-Path: <linux-kernel+bounces-541942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3FA4C3A3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5FA16F531
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C62139BF;
	Mon,  3 Mar 2025 14:40:57 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9D12FF69
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012857; cv=none; b=dLVRM74Gx0KjPzaNcE5i71s/JUhDkgssyU9n44zujc/si/fmiJQF4+JcYS/XLkBk0P2wuD5FQl7yPvhnR3UBtEFIidCpusb+0LCTh1fvMj9U8A078vvh2sEgNkDQJ2yXbCm9+YVXgVwvfKCqsMKQkYtELRe7mA6+wKHMaQNurQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012857; c=relaxed/simple;
	bh=DOp3KjDEz0qGTGAuOx5OcUhKxH279AG6sIlVJA9e1ow=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=U4R4aU/q5hE169XyBjSBFEkq59WzHo7wx144bTAlqoLJp0Ac5TObe+7XFNfmTg+B46oE7x+u+ggG18FKb1eX/6FjRjI8ZgqrbvzHMUZ2xpo3fFb/XxWuPWcnL5KBHZzCbdMewgx/yH5O8antW9TySC+dcOJvcAg/xUKEW07q9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z61Zl13Y8zwW49;
	Mon,  3 Mar 2025 22:35:59 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 3682E1402C8;
	Mon,  3 Mar 2025 22:40:51 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 22:40:50 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <dietmar.eggemann@arm.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 3/4] arm64: topology: Support SMT control on ACPI
 based system
To: Sudeep Holla <sudeep.holla@arm.com>, Pierre Gondois
	<pierre.gondois@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-4-yangyicong@huawei.com> <Z8HAkZiHYRjj97M7@bogus>
 <336e9c4e-cd9c-4449-ba7b-60ee8774115d@arm.com>
 <20250228190641.q23vd53aaw42tcdi@bogus>
 <a52972c7-aadd-4a77-a292-057fa5f8372d@arm.com> <Z8WPiOweOjFZqTwN@bogus>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <32e572d6-dedd-d8a3-13be-6de02303a64d@huawei.com>
Date: Mon, 3 Mar 2025 22:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8WPiOweOjFZqTwN@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/3/3 19:16, Sudeep Holla wrote:
> On Mon, Mar 03, 2025 at 10:56:12AM +0100, Pierre Gondois wrote:
>> On 2/28/25 20:06, Sudeep Holla wrote:
>>>>>
>>>>> Ditto as previous patch, can get rid if it is default 1.
>>>>>
>>>>
>>>> On non-SMT platforms, not calling cpu_smt_set_num_threads() leaves
>>>> cpu_smt_num_threads uninitialized to UINT_MAX:
>>>>
>>>> smt/active:0
>>>> smt/control:-1
>>>>
>>>> If cpu_smt_set_num_threads() is called:
>>>> active:0
>>>> control:notsupported
>>>>
>>>> So it might be slightly better to still initialize max_smt_thread_num.
>>>>
>>>
>>> Sure, what I meant is to have max_smt_thread_num set to 1 by default is
>>> that is what needed anyways and the above code does that now.
>>>
>>> Why not start with initialised to 1 instead ?
>>> Of course some current logic needs to change around testing it for zero.
>>>
>>
>> I think there would still be a way to check against the default value.
>> If we have:
>> unsigned int max_smt_thread_num = 1;
>>
>> then on a platform with 2 threads, the detection condition would trigger:
>> xa_for_each(&hetero_cpu, hetero_id, entry) {
>>     if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)     <---- (entry->thread_num=2) and (max_smt_thread_num=1)
>>         pr_warn_once("Heterogeneous SMT topology is partly
>>                       supported by SMT control\n");
>>
>> so we would need an additional variable:
>> bool is_initialized = false;
> 
> Sure, we could do that or skip the check if max_smt_thread_num == 1 ?
> 
> I mean
> 	if (entry->thread_num != max_smt_thread_num && max_smt_thread_num != 1)
> 

this will work for me. will launch some tests.

Thanks.



