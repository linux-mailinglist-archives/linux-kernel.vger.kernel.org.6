Return-Path: <linux-kernel+bounces-272893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41F946261
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFB81F21E8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C340815C12B;
	Fri,  2 Aug 2024 17:23:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17C1537DF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619403; cv=none; b=n/yG5kOeuQhmUR05xmZepndXSM+R96j05LM+l+GP/Q8qQn4jAhVXZH4Yw77Hao9xm+Oj53S0838uR2JqPsNE8IN9FyQr0sPn7TokY9R6qYYRrYfHWidfqK9OVl4WN64aFRtMcHnzUA+y3PbLxOqeistY/l/OV69GvsPZS3GPI4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619403; c=relaxed/simple;
	bh=8kH8jkN4k0sEty6FrOVN++0lTMGoST92wF1/C9OkOFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAnwry59cQ7QAkpf6AUewmhPRgQg11/kTdCIchJd9WrZMyW4iiAhwmf+bGBXJGqb4WaOOiy6sfLOMcggtT2WKmrj9Y7yr6CWEq11hGCGNz56vEB0xZ1+GfjrtyWtOwL/+M0YWxO45arNRz0fZRiVETjIZ4KNnMnTzOmiozd8hEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B81B7DA7;
	Fri,  2 Aug 2024 10:23:46 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852C93F64C;
	Fri,  2 Aug 2024 10:23:17 -0700 (PDT)
Message-ID: <76d51ef1-2503-4c97-ba5c-1bbd119fa958@arm.com>
Date: Fri, 2 Aug 2024 18:23:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/38] x86/resctrl: Move monitor init work to a resctrl
 init call
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20240614150033.10454-1-james.morse@arm.com>
 <20240614150033.10454-17-james.morse@arm.com>
 <c7b3c16a-afb0-459a-b1ca-c420122f296d@intel.com>
 <21d1598e-47a1-4fce-ae5d-ca66419671c2@arm.com>
 <64a0fd8a-7c2f-4121-ac20-433cfdcefa9a@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <64a0fd8a-7c2f-4121-ac20-433cfdcefa9a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 01/07/2024 22:11, Reinette Chatre wrote:
> On 7/1/24 11:17 AM, James Morse wrote:
>> On 28/06/2024 17:47, Reinette Chatre wrote:
>>> On 6/14/24 8:00 AM, James Morse wrote:
>>>> rdt_get_mon_l3_config() is called from the architecture's
>>>> resctrl_arch_late_init(), and initialises both architecture specific
>>>> fields, such as hw_res->mon_scale and resctrl filesystem fields
>>>> by calling dom_data_init().
>>>>
>>>> To separate the filesystem and architecture parts of resctrl, this
>>>> function needs splitting up.
>>>>
>>>> Add resctrl_mon_resource_init() to do the filesystem specific work,
>>>> and call it from resctrl_init(). This runs later, but is still before
>>>> the filesystem is mounted and the rmid_ptrs[] array can be used.
>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> index 7d6aebce75c1..527c0e9d7b2e 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>>> @@ -1016,12 +1016,28 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>>>>            list_add_tail(&mbm_local_event.list, &r->evt_list);
>>>>    }
>>>>    +int resctrl_mon_resource_init(void)
>>>
>>> (Lack of an __init is unexpected but I assume it was done since that will be removed
>>> in later patch anyway?)
>>
>> Yup - I'll add and remove that if you find it surprising.
>>
>>
>>> This function needs a big warning to deter anybody from considering this to
>>> be the place where any and all monitor related allocations happen. It needs
>>> to warn developers that only resources that can only be touched after fs mount
>>> may be allocated here.
>>
>> I'm afraid I don't follow. Can you give an example of the scenario you are worried about?

> My concern is not a scenario with current code flow but a request for informational
> comments to prevent future mistakes. Specifically, as I understand the CPU online/offline
> handlers can run before this function is called. Those handlers do a lot of setup, getting
> resctrl and the system ready. It can be reasonable that some future action may need to touch
> a new monitoring structure and with a name like resctrl_mon_resource_init() it seems
> appropriate
> to allocate this new monitoring structure there. I am hoping that resctrl_mon_resource_init()
> will have sufficient comments to deter that.

Ah, Of course! ... this is about 'global' allocations that don't belong to a specific domain.

I've reworded the comment above the function as:
| * Allocate and initialise global monitor resources that do not belong to a
| * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
| * Called once during boot after the struct rdt_resource's have been configured
| * but before the filesystem is mounted.
| * Resctrl's cpuhp callbacks may be called before this point to bring a domain
| * online.

and a similar comment above domain_setup_mon_state:
| * Allocate monitor resources that belong to this domain.
| * Called when the first CPU of a domain comes online, regardless of whether
| * the filesystem is mounted.
| * During boot this may be called before global allocations have been made by
| * resctrl_mon_resource_init().



>> This is called from resctrl_init(), which is called once the architecture code has done
>> its setup, and reckons resctrl is something that can be supported on this platform. It
>> would be safe for the limbo/overflow callbacks to start ticking after this point - but
>> there is no point if the filesystem isn't mounted yet.
>> Filesystem mount is triggered through rdt_get_tree(). The filesystem can't be mounted
>> until resctrl_init() goes on to call register_filesystem().
>> These allocations could be made later (at mount time), but they're allocated once up-front
>> today.
>>
>>
>> I've added:
>> /**
>>   * resctrl_mon_resource_init() - Initialise monitoring structures.
> 
> How about a more specific "Initialise monitoring structures used after filesystem mount"?

Sure, this has become;
| * resctrl_mon_resource_init() - Initialise global monitoring structures used
| *				  after filesystem mount.


>>   *
>>   * Allocate and initialise the rmid_ptrs[] used for the limbo and free lists.
>>   * Called once during boot after the struct rdt_resource's have been configured
>>   * but before the filesystem is mounted.
> 
> Can there be a warning (please feel free to improve):
>     "Only for resources used after filesystem mount. For example, do not allocate resources
>      needed by the CPU online/offline handlers since these handlers may run before this
>      function."

Enumerating what not to do feels like the beginning of a never ending story!
I think describing these as global/specific-to-a-domain makes it clear what kind of
allocation should go here.


Thanks,

James

