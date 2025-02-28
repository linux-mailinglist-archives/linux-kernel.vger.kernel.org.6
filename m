Return-Path: <linux-kernel+bounces-539320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9816A4A334
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940013BE013
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5705E27CCCB;
	Fri, 28 Feb 2025 19:55:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F631B87FB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772546; cv=none; b=b0LDmZCmkbCLCkuctU2x0VivrGsc/c/+3uG69ZHi+jv2smLk0eCK/t9DsEDoIEE0xHcq5JuPYbUWJzRrPATeOuHC+BFDExOnvCvB+EE70e8WzL4R3XqrONTzimKYoOPPxD7RdJOxqLrISdTFwedqezCetMDNhREytj151hKQwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772546; c=relaxed/simple;
	bh=EBAwrLYUs5EiC/9WM6SS7V/4axXNQSXAyU0Pes16ruI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ur/YOeilrCJTdIpDxkoul4hZ7SQCv8gomrd1N8eajKIMbVV0fSR9AW4TB+GSQVql/Uy+Su8N45lcRT6riJ6zH6V5A5L0IxJpWa2HXm5PKqZUhvF2LtuLN0S4nJSMzrGOy/RL1ghWfy5MiUhurruw09RfsMsZb/1w4OqXzBNcm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CE5C1515;
	Fri, 28 Feb 2025 11:55:59 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9683F5A1;
	Fri, 28 Feb 2025 11:55:38 -0800 (PST)
Message-ID: <29a01140-a6dc-49a2-8ef8-ba0cef5b1d6e@arm.com>
Date: Fri, 28 Feb 2025 19:55:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/42] x86/resctrl: Move the is_mbm_*_enabled() helpers
 to asm/resctrl.h
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
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-19-james.morse@arm.com>
 <3b0ac0aa-dcc1-429f-9822-f1b0c55b162a@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <3b0ac0aa-dcc1-429f-9822-f1b0c55b162a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 19/02/2025 23:55, Reinette Chatre wrote:
> On 2/7/25 10:17 AM, James Morse wrote:
>> The architecture specific parts of resctrl provide helpers like
>> is_mbm_total_enabled() and is_mbm_local_enabled() to hide accesses
>> to the rdt_mon_features bitmap.
>>
>> Exposing a group of helpers between the architecture and filesystem code
>> is preferable to a single unsigned-long like rdt_mon_features. Helpers
>> can be more readable and have a well defined behaviour, while allowing
>> architectures to hide more complex behaviour.
>>
>> Once the filesystem parts of resctrl are moved, these existing helpers can
>> no longer live in internal.h. Move them to include/linux/resctrl.h
>> Once these are exposed to the wider kernel, they should have a
>> 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.
>>
>> Move and rename the helpers that touch rdt_mon_features directly.
>> is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
>> so can be moved into that file.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 1730ba814834..b7d93670ed94 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> 
> ...
> 
>> @@ -761,6 +761,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
>>  	struct rdtgroup *entry;
>>  	u32 cur_bw, user_bw;
>>  
>> +	if (!resctrl_arch_is_mbm_local_enabled())
>> +		return;
>> +
>>  	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>>  	evt_id = rgrp->mba_mbps_event;
>>  
> 
> Please drop this hunk. A new [1] resctrl feature makes it possible for software
> controller to work with local as well as total bandwidth events. 

Thanks - that was evidently a rebase conflict I messed up!

James

