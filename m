Return-Path: <linux-kernel+bounces-236805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711191E74C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9BD6B23986
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1616EBF6;
	Mon,  1 Jul 2024 18:17:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AB16EBF0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857873; cv=none; b=Sgf02kU9PfwLqB+20kY8zRRFTxxltjLCjXcwyVrTSr/4TUuGuQZjKEhesdvn9mheirjuAnILht3xueoJbTZsWzEFxgQU8WXTwd5qyPzsbjuEWjFm8epqlK5YtTZFdO4K9tsZK6Ye+7pG/sFo5gjhz7GqRqKLD0HNKW7jdY7ATS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857873; c=relaxed/simple;
	bh=S+4dTREH6lhcjn1Pb0b4UTnO12MqMYB1CC9R9lsZBbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W31BE04FHpz9B7MxnkwWlaBSRCsqKN4tANoOsz4R5GOh8IHXZ2xmfhNrNPLqiAichHf/mjYrcgh2X70UnHvdLiju3vJWMdNKsbC45yXz4YxxlPjN89q3MeIXMK9aWPYyK27XpfvQ8iYSiNoAN165MG868zJlfQ9zQgy2fVzo3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8A2D339;
	Mon,  1 Jul 2024 11:18:16 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2503F766;
	Mon,  1 Jul 2024 11:17:48 -0700 (PDT)
Message-ID: <26844dc5-5fbb-40ea-842a-a467240c679d@arm.com>
Date: Mon, 1 Jul 2024 19:17:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/38] x86/resctrl: Move monitor exit work to a restrl
 exit call
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
 <20240614150033.10454-16-james.morse@arm.com>
 <a4b5644e-347e-48a4-a777-893003788920@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <a4b5644e-347e-48a4-a777-893003788920@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 28/06/2024 17:46, Reinette Chatre wrote:
> On 6/14/24 8:00 AM, James Morse wrote:
>> rdt_put_mon_l3_config() is called via the architecture's
>> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
>> and closid_num_dirty_rmid[] arrays. In reality this code is marked
>> __exit, and is removed by the linker as resctl can't be built
>> as a module.
>>
>> To separate the filesystem and architecture parts of resctrl,
>> this free()ing work needs to be triggered by the filesystem,
>> as these structures belong to the filesystem code.
>>
>> Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
>> and call it from resctrl_exit(). The kfree() is currently
>> dependent on r->mon_capable. resctrl_mon_resource_init()

> resctrl_mon_resource_init() does not exist at this point making
> this motivation difficult to follow.

Right - I re-ordered the patches to make the diffs simpler. I'll drop this paragraph.


>> takes no arguments, so resctrl_mon_resource_exit() shouldn't
>> take any either. Add the check to dom_data_exit(), making it
>> take the resource as an argument. This makes it more symmetrical
>> with dom_data_init().

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 3e5375c365e6..7d6aebce75c1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -965,10 +965,12 @@ static int dom_data_init(struct rdt_resource *r)
>>       return err;
>>   }
>>   -static void __exit dom_data_exit(void)
>> +static void dom_data_exit(struct rdt_resource *r)
>>   {
>> -    mutex_lock(&rdtgroup_mutex);
>> +    if (!r->mon_capable)
>> +        return;
>>   +    mutex_lock(&rdtgroup_mutex);
> 
> I know there has been a bit of back&forth on whether the mutex is needed
> here. With this change moving dom_data_exit() out from __exit I think
> the locking should aim to be consistent with existing runtime
> and thus the check of r->mon_capable should be with mutex held. Having
> this little snippet outside mutex will just cause confusion.

> Do you have motivation for needing this be done outside of mutex?

Just to avoid sleeping - then returning having done nothing.


> I think it
> ended up this way with this patch aiming to keep existing flow exactly,
> but that ended up as convenience in a flow where mutex was not really
> needed at all.

Sure - I don't think it matters either way. Its not a path where performance matters.
The property is read-only from when resctrl_init() is called. I'll make it look like
resctrl_offline_domain().


Thanks,

James

