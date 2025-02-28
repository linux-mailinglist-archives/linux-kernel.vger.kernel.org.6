Return-Path: <linux-kernel+bounces-539319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD0EA4A333
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3D5189C960
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E4277815;
	Fri, 28 Feb 2025 19:55:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FFA2777FC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772537; cv=none; b=AcoKkpqIb5Glkfw2T7U+kXkRKggprmfHqF1sjdPXmAzo/jLwCZvOjrpkxcmM1XwBsHt5Or6M7ELKrSKwdCtnz4MSHb9UsHdGzuVia+mI3Qz/7+uHsmTLY07kQskxHPoJl2iFTEi5fHW734UW3FXuWRai/fBBuLgl4UgpikXeRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772537; c=relaxed/simple;
	bh=rEf5GjpwhcYZ/8NX1pXrf3a6W1OZNV3RRfD/Z8c54+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t44JhR89fuKZevYyqZEuch7UMhrmv8iz6U3KKqBLKgS84wjGAg1+k8CD5IDim8puZm8Vm3uWmdCcrLayGfmkvsDZa9z2JO3UAS3+YnMZAUHqIQJm6GVnK13NN3obyQSKqIXWjLgGsjkJpjgmkPMcOmYYiFx80BALTItiIZyBl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD87D1515;
	Fri, 28 Feb 2025 11:55:49 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C19F3F5A1;
	Fri, 28 Feb 2025 11:55:28 -0800 (PST)
Message-ID: <fcad500b-3d8c-4003-b25c-6f54d2b5fbe6@arm.com>
Date: Fri, 28 Feb 2025 19:55:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/42] x86/resctrl: Generate default_ctrl instead of
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
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-9-james.morse@arm.com>
 <d689293d-312c-4334-8f3d-be2da49c30c5@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <d689293d-312c-4334-8f3d-be2da49c30c5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 19/02/2025 22:54, Reinette Chatre wrote:
> On 2/7/25 10:17 AM, James Morse wrote:
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
>> index 4504a12efc97..6fd195b600b1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -281,8 +280,7 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>>  	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>>  	hw_res->num_closid = edx.split.cos_max + 1;
>>  	r->cache.cbm_len = eax.split.cbm_len + 1;
>> -	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>> -	r->cache.shareable_bits = ebx & r->default_ctrl;
>> +	r->cache.shareable_bits = ebx & resctrl_get_default_ctrl(r);
>>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>>  		r->cache.arch_has_sparse_bitmasks = ecx.split.noncont;
>>  	r->alloc_capable = true;

> Using resctrl_get_default_ctrl() in the architecture code like this seems awkward in
> the way that the caller depends on resctrl_get_default_ctrl() returning a bitmask, thus
> requiring caller to be familiar with internals of function called.

resctrl and the arch code that provides the interface are closely coupled, so I don't
think its a problem to have to know what the call does...

Using the helper here was just because the memory for the default value has gone away,
I agree that as this is being used to manipulating stuff from cpuid, it should probably be
open coded here. I'll drop this hunk, (adding default_ctrl as a local variable here).


>> @@ -329,7 +327,7 @@ static u32 delay_bw_map(unsigned long bw, struct rdt_resource *r)
>>  		return MAX_MBA_BW - bw;
>>  
>>  	pr_warn_once("Non Linear delay-bw map not supported but queried\n");
>> -	return r->default_ctrl;
>> +	return resctrl_get_default_ctrl(r);

> I wonder if returning MAX_MBA_BW directly would not be more appropriate here ...
> or returning r->membw.max_bw and doing so in previous patch.

My thinking was this value is at least in the correct format for the hardware if an AMD
platform manages to get in here - but its only called from the Intel helpers, so that
can't happen.

Using MAX_MBA_BW makes it clearer what the 'Non Linear' warning is about.



>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 23a01eaebd58..5d87f279085f 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -113,8 +113,9 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>>   */
>>  static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>  {
>> -	unsigned long first_bit, zero_bit, val;
>> +	u32 supported_bits = BIT_MASK(r->cache.cbm_len) - 1;

> What is criteria for caller to decide between using resctrl_get_default_ctrl() or
> computing the bitmask self? Most callers already seem to be using
> resctrl_get_default_ctrl() with clear expectation that it will return
> a bitmask or not so it is not obvious why some callers needing bitmask
> use resctrl_get_default_ctrl() while this caller compute bitmask self.

This one case is odd because it also needs to know the number of bits in the bitmap. I
felt computing the bitmap directly here made it clearer this was checking against a single
set of properties. (if you diagree - lets change it!)


resctrl_get_default_ctrl() is largely intended to fit callers like reset_all_ctrls() which
don't know or care what the format is, as long as it matches what the hardware expects.
Most other cases are intending to parse or format the value, so they already know what
kind of thing its going to be.


>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 1e0bae1a9d95..cd8f65c12124 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -978,7 +978,7 @@ static int rdt_default_ctrl_show(struct kernfs_open_file *of,
>>  	struct resctrl_schema *s = of->kn->parent->priv;
>>  	struct rdt_resource *r = s->res;
>>  
>> -	seq_printf(seq, "%x\n", r->default_ctrl);
>> +	seq_printf(seq, "%x\n", resctrl_get_default_ctrl(r));
>>  	return 0;
>>  }

> While the function is "rdt_default_ctrl_show()" the file is "cbm_mask"
> and so here also resctrl_get_default_ctrl() is implicitly assumed to
> return only a bitmask.

Because the file is hidden behind RFTYPE_RES_CACHE, which can only be set on the L2 or L3
if they have bitmask controls. If we ever support other kinds of controls, we'd need to do
somthing about this.
I agree the existing name is misleading, but I don't think its worth the extra patch to
rename it. (Curious that it isn't called rdt_cbm_mask_show())

For the distant future, I have patches that propose adding a file to expose the schema
type to resctrl, then a bunch of files prefixed with "bitmap_" or "percent_" that describe
the control properties. What we have today is a mix of control type and resource all in
one - what does the "cbm_mask" mean if the resource is not a cache?
(it goes without saying that the existing files must stay with their same values)


>> @@ -3417,7 +3417,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
>>  		}
>>  
>>  		cfg = &d->staged_config[CDP_NONE];
>> -		cfg->new_ctrl = r->default_ctrl;
>> +		cfg->new_ctrl = resctrl_get_default_ctrl(r);
>>  		cfg->have_new_ctrl = true;
>>  	}
>>  }

> Using resctrl_get_default_ctrl() only seems appropriate when setting or staging
> the register values where the value returned is not further manipulated with
> assumptions regarding its format.

Provided the schema format has already been checked, I agree. This is what led to
cbm_validate() generating the bitmap values itself. (I take your point about the cpuid
interactions above)

In rdtgroup_init_mba() we could reach in to retrieve r->membw.max_bw, but the value isn't
being parsed or formatted, so I don't think it matters. Once we have a helper, we may as
well use it everywhere we can.


Thanks,

James

