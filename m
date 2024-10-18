Return-Path: <linux-kernel+bounces-372085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECB19A444E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A4D1F2173B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A937620401F;
	Fri, 18 Oct 2024 17:07:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F525200C87
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271248; cv=none; b=m+eQSuCK92yvQhsUT3eq0OaiIBpr4HpsrpvHri/WMA1lu8bnQW3Q96KSpzLC/kElVdo2h5X9LW3NI2bnGE6h5ClglGQkUqrkxtPT9az1I3XYjMekwQBlFGS44BOj57JXOA3hXh0+bypuBgTsAOSbbpGg+YrCzposet5xifYCIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271248; c=relaxed/simple;
	bh=8dt7/7n0iXHG3Olz49iZlufe0Bo8jSBO492BeeG2oRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V17+sND+i9ETyI0CBpJwBwrMd04vfj5mz3vcuPPYmLysKQF129SdTACzv+CbHaw9yCT0AGIyUels92RNkjxloJxECJijp74TYFL2kfiUr9F4Uxuan+jgSFsTbHr47Vc/8yPEZtij3UXGBKECWfWbBw6eACatcWxojURV53QSocE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED022106F;
	Fri, 18 Oct 2024 10:07:54 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00D3A3F792;
	Fri, 18 Oct 2024 10:07:17 -0700 (PDT)
Message-ID: <e6570a61-1608-4baa-9f61-fb87f39a76f6@arm.com>
Date: Fri, 18 Oct 2024 18:07:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/40] x86/resctrl: Rewrite and move the
 for_each_*_rdt_resource() walkers
Content-Language: en-GB
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
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
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-18-james.morse@arm.com>
 <ZwR2D4ISzIrZRTHi@agluck-desk3.sc.intel.com>
 <439810ad-92eb-4fa9-be35-82f54624c0c5@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <439810ad-92eb-4fa9-be35-82f54624c0c5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tony, Reinette,

On 08/10/2024 17:40, Reinette Chatre wrote:
> On 10/7/24 5:00 PM, Tony Luck wrote:
>> On Fri, Oct 04, 2024 at 06:03:24PM +0000, James Morse wrote:
>>> The for_each_*_rdt_resource() helpers walk the architecture's array
>>> of structures, using the resctrl visible part as an iterator. These
>>> became over-complex when the structures were split into a
>>> filesystem and architecture-specific struct. This approach avoided
>>> the need to touch every call site, and was done before there was a
>>> helper to retrieve a resource by rid.
>>>
>>> Once the filesystem parts of resctrl are moved to /fs/, both the
>>> architecture's resource array, and the definition of those structures
>>> is no longer accessible. To support resctrl, each architecture would
>>> have to provide equally complex macros.
>>>
>>> Rewrite the macro to make use of resctrl_arch_get_resource(), and
>>> move these to the core header so existing x86 arch code continues
>>> to use them.

>> Apologies if this comment was suggested against earlier versions
>> of this series.
>>
>> Did you consider replacing rdt_resources_all[] a list (in the filesystem
>> code) instead of an array (in the architecture code)?

I didn't consider this, but it would be a more natural fit for the secret for loops that
are all over the resctrl code.


>> List would start empty. Architecture init code would enumerate features
>> and add entries to the list for those that exist and are to be enabled.

That saves the 'can't return NULL' wart - but that was intended to be temporary - and only
a headache for !x86 architectures.


>> The "for_each" macros then walk the list (variants for all entries,
>> for "alloc_capable" and for "mon_capable"). Note that only enabled
>> entries appear on the lists.
>>
>> There are currently a bunch of places in filesystem code that
>> do:
>> 	r = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
>> or
>> 	r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
>>
>> those could become:
>>
>> 	r = resctrl_arch_get_mba_resource();
>>
>> 	r = resctrl_arch_get_l3_resource();

Where these walk this list instead of 'knowing' the offset.
(just in case I'm missing a trick here)


>> Then the whole "enum resctrl_res_level" and ->rid field in
>> struct rdt_resource could go away?

I think level is still going to be useful for cache resources - that is something we
expose via the sysfs cpu cache/indexX stuff too. I'd like resctrl to generate the names of
resources - just to ensure they are the same on every architecture.

The rid is an existing field just to make the array searching work.


>> Remaining uses look like
>> distinguishing MBA from SMBA. Perhaps better done with a
>> flags word?
>>
>> Advantage of doing this would be to avoid the generic
>> enum resctrl_res_level having to be a superset of all
>> features across all architectures.

Ah, I see this as an advantage - its much harder for an architecture to add a new type of
control or resource than it is to provide compatibility with one that is already there.
This in turn is better for user-space.

MPAM's bandwidth controls don't have the same control format as Intel RDT - but its much
better for everyone if I convert the values to hide the differences instead of trying to
shoehorn in ARM_MB as a new resource, only to find another architecture grows something
similar.

The difficult bit is making sure new resources/controls are as generic as possible,
meaning other architectures can adopt them. (L3's bitmap is a good example).

(and I agree there will always be platform specific things each camp has)

>> E.g. ARM might want to add L4/L5 resources,

/me shudders.

I've seen folk wanting to add the 'system cache' - which sits where the L3 should be, but
behaves differently. And ACPI's "Memory Side Caches" which gives me a hilarious TLA
collision to navigate).
I've argued neither of these are L<n> caches because they aren't visible to user-space in
/sys/devices/system/cpu/cpu0/cache ...

[..]

> Ideally resctrl fs would remain as an interface that a user can use to interact
> with all architectures without knowing architecture specific details. Platform
> differences can be exposed by resctrl in a generic way to support this.
> I am afraid that allowing architectures to diverge would require resctrl fs users
> to additionally know which platform they are running on.
> 
>> If this v5 series is close to being applied then I don't
>> want to derail with a re-write at this late stage.
>> All of this could be done as a cleanup after this series
>> has been applied.
> 
> Due to the already significant size of this work I think it would make it easier
> if the number of functional changes are minimal. Specifically, only those functional
> changes that are required to accomplish the goal of moving the code.

Yup - hence the need for !alloc_capable && !mon_capable resources behind
resctrl_arch_get_resource() - this is keeping the behaviour of the existing code.


> Considering that one goal of this proposal is to support architectural
> flexibility I do think it would be easier to understand its impact if it
> is implemented on top of the arch/fs split.

Make sense to me,


Thanks,

James

