Return-Path: <linux-kernel+bounces-558244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3DA5E362
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970F31895D84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BF24419B;
	Wed, 12 Mar 2025 18:04:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F117083C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802680; cv=none; b=mvsu7vVvPfLPeEOAlttX8zOxE6Z6UQKxv5a5CRNRNDKqX69WdsxMpRfNVvrxKix64FLnEjPAb7v56wsTiJJ5OSvc+DZAHPsgA2ziA8tMs36lFkscnaOHwy1CFxn6zUuYYi3m9rHDW94cMgGlxQ6NjGJ305gomjL/Dm+472FLP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802680; c=relaxed/simple;
	bh=XvXVw7Dr2bmvyu4dnBOm4m4cm7TaY4d6YreH8Q3GruA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM5ZIIsU/D+K0IU+numThG04jyIr3puc65E9xK0DgXbnWiZkLrkNGF3hh0OU+2LrhnrJ0Ap/T9yrrQS5sCw+vttGSQNo501w5/cWRbRH1lkw8oRzY/vJ9BUi+WkLgqq9TxiM65LctS5PRwn71Ysa4AGaXCimt2/7BwMt0FyTVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 664131515;
	Wed, 12 Mar 2025 11:04:48 -0700 (PDT)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B06163F5A1;
	Wed, 12 Mar 2025 11:04:32 -0700 (PDT)
Message-ID: <a54fe3e7-19cb-4f84-9189-f0e3853e98fe@arm.com>
Date: Wed, 12 Mar 2025 18:04:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 37/49] x86/resctrl: Expand the width of dom_id by
 replacing mon_data_bits
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
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-38-james.morse@arm.com>
 <e1816cbf-e2a7-44cf-92f9-bbd24d9e264b@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <e1816cbf-e2a7-44cf-92f9-bbd24d9e264b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 07/03/2025 05:03, Reinette Chatre wrote:
> On 2/28/25 11:59 AM, James Morse wrote:
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

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index aecd3fa734cd..443635d195f0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -3114,6 +3114,110 @@ static struct file_system_type rdt_fs_type = {
>>  	.kill_sb		= rdt_kill_sb,
>>  };
>>  
>> +/**
>> + * mon_get_default_kn_priv() - Get the mon_data priv data for this event from
>> + *                             the default control group.
> 
> Since this involves monitoring this would technically be the default "monitoring"
> group (throughout). 

Makes sense - fixed.
This has all leaked out of the observation 'you can't rmdir /'.


>> + * Called when monitor event files are created for a domain.
>> + * When called with the default control group, the structure will be allocated.
> 
> A bit difficult to parse. Assuming there is a re-spin, how about something like:
> "Allocate the structure when @rdtgrp is the default group."

Done,

>> + * This happens at mount time, before other control or monitor groups are
>> + * created.
>> + * This simplifies the lifetime management for rmdir() versus domain-offline
>> + * as the default control group lives forever, and only one group needs to be
>> + * special cased.
>> + *
>> + * @r:      The resource for the event type being created.
>> + * @d:	    The domain for the event type being created.
> 
> Stray tab makes for inconsisent spacing.

Fixed,


>> + * @mevt:   The event type being created.
>> + * @rdtgrp: The rdtgroup for which the monitor file is being created,
>> + *          used to determine if this is the default control group.
>> + * @do_sum: Whether the SNC sub-numa node monitors are being created.

> do_sum can be true or false when it comes to the SNC files (more below). 

I mis-understood what the hierarchy looks like on SNC systems.


>> + */
>> +static struct mon_data *mon_get_default_kn_priv(struct rdt_resource *r,
>> +						struct rdt_mon_domain *d,
>> +						struct mon_evt *mevt,
>> +						struct rdtgroup *rdtgrp,
>> +						bool do_sum)
>> +{
>> +	struct kernfs_node *kn_dom, *kn_evt;
>> +	struct mon_data *priv;
>> +	bool snc_mode;
>> +	char name[32];
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
>> +	if (!do_sum)
>> +		sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
> 
> When in SNC mode the "mon_<resource name>_ files always use d->ci->id as the domain id.

(that makes sense - I'd conflated it with the next problem)


>> +	else
>> +		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
>> +

> The mon_sub_<resource name>_ directories are always created when in SNC mode, they do
> not exist on non SNC enabled systems. The mon_<resource name>_ directories exists on
> both SNC enabled and non-SNC/SNC disabled systems. The mon_<resource name>_ directories
> on SNC enabled system will have "do_sum" set. I think what you may be trying to do
> here is something like:
> 
> 	if (!snc_mode) { /* do_sum is not relevant */
> 		sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
> 	} else if (snc_mode && do_sum) {
> 		sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
> 	} else { /* snc_mode && !do_sum */
> 		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
> 	}

Right - that makes sense. Thanks for explaining it.


>> +	kn_dom = kernfs_find_and_get(kn_mondata, name);
>> +	if (!kn_dom)
>> +		return NULL;
> 
> It seems like this either assumes the directories are on the same level or assumes
> kernfs_find_and_get() does a recursive find. As I understand kernfs_find_and_get()
> does not do a recursive find.  On SNC enabled systems the mon_sub_<resource name>_
> directories are subdirectories of the mon_<resource name>_ directories.

> Example of how hierarchy may look is at:
> https://lore.kernel.org/all/20240628215619.76401-9-tony.luck@intel.com/

(aha!)

> With all of the above I do not think this will work on an SNC enabled
> system ... to confirm this I tried it out and it is not possible to mount
> resctrl on an SNC enabled system and the WARN_ON_ONCE() this patch adds to
> mon_add_all_files() is hit.

I hadn't realised the mon_sub directories for SNC weren't all directly under mon_data.
Searching from mon_data will need the parent name too. What I've come up with is:
-------%<-------
	snc_mode = r->mon_scope == RESCTRL_L3_NODE;
	if (!snc_mode) {
		sprintf(name, "mon_%s_%02d", r->name, d->hdr.id);
		kn_target_dir = kernfs_find_and_get(kn_mondata, name);
	} else {
		sprintf(name, "mon_%s_%02d", r->name, d->ci->id);
		kn_target_dir = kernfs_find_and_get(kn_mondata, name);

		if (snc_mode && !do_sum) {
			sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
			kernfs_put(kn_target_dir);
			kn_target_dir = kernfs_find_and_get(kn_target_dir, name);
		}
	}
	kernfs_put(kn_target_dir);
	if (!kn_target_dir)
		return NULL;
-------%<-------

>> +
>> +	kn_evt = kernfs_find_and_get(kn_dom, mevt->name);
> 
> Note the "...and_get..." in kernfs_find_and_get() that gets a reference to
> the kn before returning it. I expect that this work will have symmetry when it
> comes to get/put of references but I see four new calls to kernfs_find_and_get() but
> no new matching kernfs_put() to release the new references. It looks like
> kernfs_find_and_get() is just used to figure out what the kn is so the references
> need not be kept around for long.

Not sure how I missed that. There is no need to hold an extra reference as rdtgroup_mutex
is being held, I'll add a kernfs_put() call after each involuntary _get(). (and a comment
above the lockdep assert)


>> +
>> +	/* Is this the creation of the default groups monitor files? */
>> +	if (!kn_evt && rdtgrp == &rdtgroup_default) {
>> +		priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +		if (!priv)
>> +			return NULL;
>> +		priv->rid = r->rid;
>> +		priv->domid = do_sum ? d->ci->id : d->hdr.id;
>> +		priv->sum = do_sum;
>> +		priv->evtid = mevt->evtid;
>> +		return priv;
>> +	}
>> +
>> +	if (!kn_evt)
>> +		return NULL;
>> +
>> +	return kn_evt->priv;
>> +}
>> +
>> +/**
>> + * mon_put_default_kn_priv_all() - Potentially free the mon_data priv data for
>> + *                                 all events from the default control group.
>> + * Put the mon_data priv data for all events for a particular domain.
>> + * When called with the default control group, the priv structure previously
>> + * allocated will be kfree()d. This should only be done as part of taking a
>> + * domain offline.
>> + * Only a domain offline will 'rmdir' monitor files in the default control
>> + * group. After domain offline releases rdtgrp_mutex, all references will
>> + * have been removed.
>> + *
>> + * @rdtgrp:  The rdtgroup for which the monitor files are being removed,
>> + *           used to determine if this is the default control group.
>> + * @name:    The name of the domain or SNC sub-numa domain which is being
>> + *           taken offline.
> 
> This is a bit confusing since domains do not have names. How about (please feel
> free to improve):
> "Name of directory containing monitoring files that is in process of being removed."

That's clearer, thanks!


>> +static void mon_put_default_kn_priv_all(struct rdtgroup *rdtgrp, char *name)
>> +{
>> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>> +	struct kernfs_node *kn_dom, *kn_evt;
>> +	struct mon_evt *mevt;
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	if (rdtgrp != &rdtgroup_default)
>> +		return;
>> +
>> +	kn_dom = kernfs_find_and_get(kn_mondata, name);
>> +	if (!kn_dom)
>> +		return;
> 
> I expect this will always fail when @name is a mon_sub_* directory.

Yup, fixed with a smiliar pattern to above - only the 'subname' is available to the
caller, so it can be passed in.


>> +
>> +	list_for_each_entry(mevt, &r->evt_list, list) {
>> +		kn_evt = kernfs_find_and_get(kn_dom, mevt->name);
>> +		if (!kn_evt)
>> +			continue;
>> +		if (!kn_evt->priv)
>> +			continue;
>> +
>> +		kfree(kn_evt->priv);
>> +		kn_evt->priv = NULL;
>> +	}
>> +}

>> @@ -3182,19 +3292,19 @@ static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *d,
>>  			     bool do_sum)
>>  {
>>  	struct rmid_read rr = {0};
>> -	union mon_data_bits priv;
>> +	struct mon_data *priv;
>>  	struct mon_evt *mevt;
>>  	int ret;
>>  
>>  	if (WARN_ON(list_empty(&r->evt_list)))
>>  		return -EPERM;
>>  
>> -	priv.u.rid = r->rid;
>> -	priv.u.domid = do_sum ? d->ci->id : d->hdr.id;
>> -	priv.u.sum = do_sum;
>>  	list_for_each_entry(mevt, &r->evt_list, list) {
>> -		priv.u.evtid = mevt->evtid;
>> -		ret = mon_addfile(kn, mevt->name, priv.priv);
>> +		priv = mon_get_default_kn_priv(r, d, mevt, prgrp, do_sum);
>> +		if (WARN_ON_ONCE(!priv))
>> +			return -EINVAL;
>> +

> This is the warning I hit on the SNC system.

Thanks for testing that, this is a 'should never happen - its a bug'.


Thanks!

James

