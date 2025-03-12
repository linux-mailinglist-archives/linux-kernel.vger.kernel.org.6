Return-Path: <linux-kernel+bounces-558245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D89A5E363
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7B43B75C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8FF241C8B;
	Wed, 12 Mar 2025 18:04:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F87083C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802686; cv=none; b=T5oI6b+W1aiLGumgXNAtMRUxrkdkaHcj9Sg1AkxodvKdQNFR8Fz7Nc2BPYBzIOSG7SRN8w5PlUFgI08SluaoocDhf0NJtRSFCRZccDiLKsadAgMMPd6Yw/yJCDSLjrdz1UWmsbS0XVHjsse9M2CIvRC2d/m3Ee9T5OmeO0RcKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802686; c=relaxed/simple;
	bh=WhRXuXbQmYH99kTnAyfQVFA21V+mkdtazVpNNpLTA5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMRb5SPOXsACPxsvOfMnwczlVlubP3UDeH3kGNOOZVhmG1wuCuE+TELNYpdEI5XDCC4+dCVVx9dX7DXKRJsU7tH2l2QkUYbvAxLGJvXbyDPrYdJwtepkIZbX67Z1xM6pPmQ7Lk9usObpFWQsXaX1ewkQ//dXGHL6h5X+2kjOe6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F311516;
	Wed, 12 Mar 2025 11:04:54 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29FD43F5A1;
	Wed, 12 Mar 2025 11:04:38 -0700 (PDT)
Message-ID: <75244728-bc16-4657-9cab-9e931399e766@arm.com>
Date: Wed, 12 Mar 2025 18:04:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 37/49] x86/resctrl: Expand the width of dom_id by
 replacing mon_data_bits
To: Amit Singh Tomar <amitsinght@marvell.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
 Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-38-james.morse@arm.com>
 <072e82c2-97c2-429f-a0e3-10eb0bd00b1e@marvell.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <072e82c2-97c2-429f-a0e3-10eb0bd00b1e@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Amit,

On 07/03/2025 10:17, Amit Singh Tomar wrote:
>> MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
>> The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
>> the domain-id, and is packed into the mon_data_bits union bitfield.
>> The width of cache-id in this field is 14 bits.
>>
>> Expanding the union would break 32bit x86 platforms as this union is
>> stored as the kernfs kn->priv pointer. This saved allocating memory
>> for the priv data storage.
>>
>> The firmware on MPAM platforms have used the PPTT cache-id field to
>> expose the interconnect's id for the cache, which is sparse and uses
>> more than 14 bits. Use of this id is to enable PCIe direct cache
>> injection hints. Using this feature with VFIO means the value provided
>> by the ACPI table should be exposed to user-space.
>>
>> To support cache-id values greater than 14 bits, convert the
>> mon_data_bits union to a structure. This is allocated for the default
>> control group when the kernfs event files are created, and free'd when
>> the monitor directory is rmdir'd when the domain goes offline.
>> All other control and monitor groups lookup the struct mon_data allocated
>> for the default control group, and use this.
>> This simplifies the lifecycle of this structure as the default control
>> group cannot be rmdir()d by user-space, so only needs to consider
>> domain-offline, which removes all the event files corresponding to a
>> domain while holding rdtgroup_mutex - which prevents concurrent
>> readers. mkdir_mondata_subdir_allrdtgrp() must special case the default
>> control group to ensure it is created first.


>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/
>> rdtgroup.c
>> index aecd3fa734cd..443635d195f0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3114,6 +3114,110 @@ static struct file_system_type rdt_fs_type = {
>>       .kill_sb        = rdt_kill_sb,
>>   };
>>   +/**
>> + * mon_get_default_kn_priv() - Get the mon_data priv data for this event from
>> + *                             the default control group.
>> + * Called when monitor event files are created for a domain.
>> + * When called with the default control group, the structure will be allocated.
>> + * This happens at mount time, before other control or monitor groups are
>> + * created.
>> + * This simplifies the lifetime management for rmdir() versus domain-offline
>> + * as the default control group lives forever, and only one group needs to be
>> + * special cased.
>> + *
>> + * @r:      The resource for the event type being created.
>> + * @d:        The domain for the event type being created.
>> + * @mevt:   The event type being created.
>> + * @rdtgrp: The rdtgroup for which the monitor file is being created,
>> + *          used to determine if this is the default control group.
>> + * @do_sum: Whether the SNC sub-numa node monitors are being created.
>> + */
>> +static struct mon_data *mon_get_default_kn_priv(struct rdt_resource *r,
>> +                        struct rdt_mon_domain *d,
>> +                        struct mon_evt *mevt,
>> +                        struct rdtgroup *rdtgrp,
>> +                        bool do_sum)
>> +{
>> +    struct kernfs_node *kn_dom, *kn_evt;
>> +    struct mon_data *priv;
>> +    bool snc_mode;
>> +    char name[32];
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    snc_mode = r->mon_scope == RESCTRL_L3_NODE;
>> +    if (!do_sum)
>> +        sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);

> This change triggered a minor report during compilation.
> 
> fs/resctrl/rdtgroup.c: In function ‘mon_get_default_kn_priv’:
> fs/resctrl/rdtgroup.c:2931:28: warning: format ‘%d’ expects argument of type ‘int’, but
> argument 4 has type ‘long unsigned int’ [-Wformat=]
>  2931 |   sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
>       |                         ~~~^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       | |                                 |
>       | int                               long unsigned int
>       |                         %02ld

Heh, not yet its not! You must have rebased the MPAM tree on-top, its a patch in there
that causes this:
This is because of the device-tree folk want to make cache-id an unsigned long so they can
use the arm CPU's affinity id as a cache-id. That patch already has to cleanup this
pattern elsewhere in resctrl, I need to add this one to it.

That thing is a discussion for the DT folk to drive ... I think they could just as easily
use the CPU number - only it wouldn't be a hardware-derived value. (the upshot is
cache-ids could change over a firmware update - which I think is fine)


Thanks,

James

