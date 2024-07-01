Return-Path: <linux-kernel+bounces-236803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D291E74A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50F21C21713
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D116EBF0;
	Mon,  1 Jul 2024 18:17:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749922BB04
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857857; cv=none; b=C2gZp93D1zvnLHmaipH1zT9Qj0ZT+NyJvKUoByFR2zqxaTUfV5+LrexWyrTsntF6uVvPuU8WyGjoxFkaorvusocqSOX6ebumeYiNgBbSC0/Ld0eQmdlMrOqCKy9T773GPpylBclSzL/9Ec9/7LrmNEgwqSb+hx9f+q8EIAbTAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857857; c=relaxed/simple;
	bh=XdcG/9ei4s0U2rkhjfTdCsfXjRbj6VXcWHOYdpZHZuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6hJ/Yuxkl2Rj0BTGgTSHYEqEXU8Py4ZtOCXBsrGadEB2pPSrGQSruzrm67uAq5hcYLsPlq7VXIZ7vBDVpDewhWr22PLvGzKfqyBGjKFBZC6/yuSMeolvmfbqWjWCxRpKXTZxM6grnl4WEoUC6FgmvwWVH3/oN1Oz6f/MCF9Zcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1759339;
	Mon,  1 Jul 2024 11:17:59 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 954BC3F766;
	Mon,  1 Jul 2024 11:17:31 -0700 (PDT)
Message-ID: <21d1598e-47a1-4fce-ae5d-ca66419671c2@arm.com>
Date: Mon, 1 Jul 2024 19:17:31 +0100
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
From: James Morse <james.morse@arm.com>
In-Reply-To: <c7b3c16a-afb0-459a-b1ca-c420122f296d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

On 28/06/2024 17:47, Reinette Chatre wrote:
> On 6/14/24 8:00 AM, James Morse wrote:
>> rdt_get_mon_l3_config() is called from the architecture's
>> resctrl_arch_late_init(), and initialises both architecture specific
>> fields, such as hw_res->mon_scale and resctrl filesystem fields
>> by calling dom_data_init().
>>
>> To separate the filesystem and architecture parts of resctrl, this
>> function needs splitting up.
>>
>> Add resctrl_mon_resource_init() to do the filesystem specific work,
>> and call it from resctrl_init(). This runs later, but is still before
>> the filesystem is mounted and the rmid_ptrs[] array can be used.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 7d6aebce75c1..527c0e9d7b2e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1016,12 +1016,28 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>>           list_add_tail(&mbm_local_event.list, &r->evt_list);
>>   }
>>   +int resctrl_mon_resource_init(void)
> 
> (Lack of an __init is unexpected but I assume it was done since that will be removed
> in later patch anyway?)

Yup - I'll add and remove that if you find it surprising.


> This function needs a big warning to deter anybody from considering this to
> be the place where any and all monitor related allocations happen. It needs
> to warn developers that only resources that can only be touched after fs mount
> may be allocated here.

I'm afraid I don't follow. Can you give an example of the scenario you are worried about?

This is called from resctrl_init(), which is called once the architecture code has done
its setup, and reckons resctrl is something that can be supported on this platform. It
would be safe for the limbo/overflow callbacks to start ticking after this point - but
there is no point if the filesystem isn't mounted yet.
Filesystem mount is triggered through rdt_get_tree(). The filesystem can't be mounted
until resctrl_init() goes on to call register_filesystem().
These allocations could be made later (at mount time), but they're allocated once up-front
today.


I've added:
/**
 * resctrl_mon_resource_init() - Initialise monitoring structures.
 *
 * Allocate and initialise the rmid_ptrs[] used for the limbo and free lists.
 * Called once during boot after the struct rdt_resource's have been configured
 * but before the filesystem is mounted.
 */


Thanks,

James

