Return-Path: <linux-kernel+bounces-519266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82AA39A93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051C3175335
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D052343BE;
	Tue, 18 Feb 2025 11:17:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937641AF0B7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877467; cv=none; b=mni3R/sOl6wSzd9Xk+Fhyq6d6jK2LISFBPYhbUFqlt2griE+fIcx6FYM8yQdUbGTWELQ+Fx1PN7xUGqn18sq6DX6pqn/U6x9Cul229Q7b6biiQNvTqsGzfUvBQYHqbhnUZppwap/YcBwd5E/ylFAHiqFtha97Fn42m2bHi+OSs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877467; c=relaxed/simple;
	bh=OtIp6Jg3WUfXEisR0wCM6raXDryIgT2dxMRscJbVH+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+qHOYbbAR4G+ZTeo16oXYYfVrAw1KsiUof9CC/132aZR1Qj+MJHgac3uBDqe28VDufLqC1H2Wyf4Cd75LgI0w64eTFcKLKHiYlLJFp5sSxIO0OdnUJYdu4OLLTFKqMQ73EX0wsLcER3ILhp4wEHdi62ZkRcyJJR2UIBf4o5uis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA5F913D5;
	Tue, 18 Feb 2025 03:18:02 -0800 (PST)
Received: from [10.1.27.186] (XHFQ2J9959.cambridge.arm.com [10.1.27.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB5253F6A8;
	Tue, 18 Feb 2025 03:17:42 -0800 (PST)
Message-ID: <590573cb-d9c6-4478-bd7c-2a61b39d7e9b@arm.com>
Date: Tue, 18 Feb 2025 11:17:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/2] arm64: cpufeature: detect FEAT_BBM level 2
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Miko Lenczewski <Miko.Lenczewski@arm.com>
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <20250103011822.1257189-2-yang@os.amperecomputing.com>
 <eef5fba9-da21-4131-a8a3-ae9a735869b1@arm.com>
 <0c644070-e4be-43c1-acb3-30cd030e20e1@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0c644070-e4be-43c1-acb3-30cd030e20e1@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yang,

On 13/02/2025 21:14, Yang Shi wrote:
> 
> 
> 
> On 2/11/25 3:55 AM, Ryan Roberts wrote:
> 
> Hi Ryan,
> 
> Thanks for taking time to review the patches.
> 
>> On 03/01/2025 01:17, Yang Shi wrote:
>>> FEAT_BBM level 2 allow changing block size of a translation with relaxed
>>> TLB flushing.  But it may incur TLB conflict abort.  We can handle the
>>> abort in kernel, however it is hard to guarantee the recuesive TLB
>> nit: recuesive -> recursive ?
> 
> Yes, it is a typo. Will fix in the next version.
> 
>>> conflct will never happen in the handling itself.
>>>
>>> Some implementations can handle TLB conflict gracefully without fault
>>> handler in kernel so FEAT_BBM level 2 can be enabled on those
>>> implementations safely.
>>>
>>> Look up MIDR to filter out those CPUs.  AmpereOne is one of them.
>>>
>>> Suggested-by: Will Deacon<will@kernel.org>
>>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/include/asm/cpufeature.h | 19 +++++++++++++++++++
>>>   arch/arm64/kernel/cpufeature.c      | 11 +++++++++++
>>>   arch/arm64/tools/cpucaps            |  1 +
>>>   3 files changed, 31 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/
>>> cpufeature.h
>>> index 8b4e5a3cd24c..33ca9db42741 100644
>>> --- a/arch/arm64/include/asm/cpufeature.h
>>> +++ b/arch/arm64/include/asm/cpufeature.h
>>> @@ -866,6 +866,25 @@ static __always_inline bool system_supports_mpam_hcr(void)
>>>       return alternative_has_cap_unlikely(ARM64_MPAM_HCR);
>>>   }
>>>   +static inline bool system_supports_bbmlv2(void)
>> nit: Arm language internally is starting to refer to FEAT_BBML1 / FEAT_BBML2 and
>> I believe this will soon make it's way to the Arm ARM. So probably better to
>> refer to bbml2 rather than bbmlv2 throughout.
> 
> Sure.
> 
>>> +{
>>> +    return cpus_have_final_boot_cap(ARM64_HAS_BBMLV2);
>>> +}
>>> +
>>> +static inline bool bbmlv2_available(void)
>> This function has no need to be in the header. system_supports_bbmlv2() is what
>> users should use. Suggest moving to has_bbmlv2() in cpufeature.c.
> 
> bbmlv2_available() will be called by map_mem() in patch 2, but map_mem() is
> called before CPU feature is finalized. I saw you suggest collapse the page
> table in the below comment, if it works we don't need this function anymore. But
> I have more questions about that.
> 
>>> +{
>>> +    static const struct midr_range support_bbmlv2[] = {
>>> +        MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>>> +        MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>>> +        {}
>>> +    };
>>> +
>>> +    if (is_midr_in_range_list(read_cpuid_id(), support_bbmlv2))
>>> +        return true;
>>> +
>>> +    return false;
>>> +}
>>> +
>>>   int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
>>>   bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
>>>   diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 6ce71f444ed8..a60d5fa04828 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -1889,6 +1889,11 @@ static bool has_lpa2(const struct
>>> arm64_cpu_capabilities *entry, int scope)
>>>   }
>>>   #endif
>>>   +static bool has_bbmlv2(const struct arm64_cpu_capabilities *entry, int scope)
>>> +{
>>> +    return bbmlv2_available();
>>> +}
>>> +
>>>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>>   #define KPTI_NG_TEMP_VA        (-(1UL << PMD_SHIFT))
>>>   @@ -2990,6 +2995,12 @@ static const struct arm64_cpu_capabilities
>>> arm64_features[] = {
>>>           ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
>>>       },
>>>   #endif
>>> +    {
>>> +        .desc = "BBM Level 2",
>>> +        .capability = ARM64_HAS_BBMLV2,
>>> +        .type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
>> I'm wondering if this will potentially lead to problems for assymetric
>> collections of CPUs (e.g. big.LITTLE)? I can imagine that little CPUs might not
>> support BBML2. In this case if you boot on a big CPU that does have BBML2, you
>> will require the feature and refuse to online the secondary little CPUs.
> 
> Yes. This is the behavior of this patch.
> >> Perhaps this really needs to be a system feature, where it is only enabled if
>> all CPUs in the system support it? I'm guessing that will make painting the
>> linear map harder; I guess you will need to initially set it up with PTE
>> mappings, then repaint as block mappings if BBML2 is determined to be supported
>> if that's not already what you are doing.
> 
> Actually I thought about this before I posted the RFC patches to upstream. There
> are a couple of options, but I can't tell which one is the preferred and whether
> it is really that important to handle asymmetric systems gracefully or not, so I

It is certainly important to handle asymmetric systems gracefully in general;
Almost all mobile handsets use big.LITTLE. And I think it's entirely possible
(likely even) that we will see systems where the big cores have BBML2 and the
little ones don't. There are cases where we don't currently handle asymetric
systems gracefully (e.g. LPA2), but we try to make those the exception rather
than the rule. In LPA2's case, the VA size is a compile-time option and I
suspect it's very unlikely that a 52-bit VA capable kernel would ever be
deployed on an asymmetric system (i.e. mobile handset). Given BBML2 is runtime
controlled only, I think we need to make it play nice with asymmetric systems.

> did it in the simplest way: just fail online the conflict cores. I also noticed
> some features behave similarly, for example, MPAM. And this RFC patch is mainly
> aimed to get some feedback from the community about whether it is worth it and
> the direction is right or not. So I tried to make it as simple as possible (for
> example, I didn't add CONT_PTE support in patch 2 either).

Based on your perf numbers, I defintely think this is something we should aim to
get upstream.

I think there are 3 options for the approach:

 - refuse to online secondary CPUs that don't support BBML2 if the boot CPU does
   support BBML2.
    - I don't personally think this is viable for the reasons above.

 - initially paint the linear map with ptes, then update it to block mappings if
   BBML2 is supported system-wide.
    - I'm guessing the main cost is the pte-mapping, and we already have that
      today, so it's not going to slow the boot down vs today. Re-painting with
      (mostly) PUD-sized block mappings will be significantly faster.
    - I anticipate we can just call the same function to do the mapping over the
      top of what's already there but with the BLOCK flag set.
    - It's easy to test on all systems

 - Guess at the system supporting BBML2 based only on the boot CPU, then if any
   secondaries don't support it, stop the machine and repaint linear map as
   PTEs (we do something similar today for nG)
    - It means that symmetric systems will boot marginally faster because they
      never map the linear map with ptes
    - Asymmetric systems will boot slower because they have to stop the machine
      to do the pte re-mapping
    - It's a code path that won't get tested very often

My view is that option 1 is a non-starter. Personally I lean towards option 2,
but could be persuaded that option 3 is better.

> 
> If I understand correctly, system feature needs to read the "sanitized" register
> value per the comment in cpufeature.c, but we read MIDR here. So it actually
> just uses the current CPU's (likely boot CPU) MIDR if it is s system feature,
> right? If we really want to handle such asymmetric systems gracefully, we need:
>     - read all cores' MIDR then determine whether BBML2 should be advertised or not
>     - update a flag or bitmap to tell us whether it is asymmetric or not
>     - take actions based on the flag or bitmap (i.e. collapse page table or do
> nothing)

It's my understanding that we want is ARM64_CPUCAP_SYSTEM_FEATURE. See it's
comment in cpufeature.h:

/*
 * CPU feature detected at boot time based on system-wide value of a
 * feature. It is safe for a late CPU to have this feature even though
 * the system hasn't enabled it, although the feature will not be used
 * by Linux in this case. If the system has enabled this feature already,
 * then every late CPU must have it.
 */

> 
> But system feature is not checked on the secondary cores. The
> check_local_cpu_capabilities() called by secondary_start_kernel() just checks
> SCOPE_LOCAL_CPU features if I read the code correctly. So local cpu feature may
> be better? The local cpu feature maintains a cpumask, it can tell us whether
> BBML2 is asymmetric or not.

I've not read through the details of the implementation but the docs point to
ARM64_CPUCAP_SYSTEM_FEATURE and there are many other cpu features defined as
ARM64_CPUCAP_SYSTEM_FEATURE which need these semantics. e.g. ARM64_HAS_TLB_RANGE.

> 
> In addition I'm also thinking about whether collapse is the best way or not. We
> should be able to have large block mapping in the first place if the boot CPU
> has BBML2, then split the page table if it is asymmetric. I'm supposed we need
> to stop machine anyway even though we do collapse. 

Yes I think you could do it this way as long as you stop the machine first.
There is already a pattern to follow for this with nG; see
kpti_install_ng_mappings().

I don't think you need to stop the machine if collapsing, as long as BBML2 is
supported.

> The split need to be called
> on the boot CPU. We already have split logic, we can reuse it anyway (maybe need
> some minor tweak to fit). It sounds simpler than collapse. 

I'm wondering if we can enhance the existing table walker in mmu.c
(__create_pgd_mapping()) to handle collapse and split gracefully. Then we could
reuse that logic for all collapse, split and permission change operations so
that we always have the largest possible blocks mapped.

It looks like it used to be able to do (some of) this prior to commit Commit
e98216b52176 ("arm64: mm: BUG on unsupported manipulations of live kernel
mappings"). That approach may turn out to be cleaner and more general than the
current logic you have to split a range to ptes?

> And the asymmetric
> systems may be not that many in real world? I know there are a lot of big.LITTLE
> SoCs in the wild, but those big cores may typically not support BBML2. If so we
> can save boot up time for the most cases.

Yes, you are beginning to persuade me that stop_machine() for asymmetric systems
may be the better way to go.

If the boot CPU does not support BBML2, paint with page mappings as before; no
change.

If the boot CPU does support BBML2, speculatively paint with block mappings. If
all CPUs later turn out to support BBML2 then no further action is needed, and
this gives us a reduction in boot time because we never had to paint per-page
PTEs. It's also a runtime advantage due to the TLB pressure reduciton.

If any secondary CPU later turns out not to support BBML2, stop the machine and
repaint with page mappings. Assuming the major cost is writing all the PTEs,
then this is lightly about the same speed as it is today. And as you say, this
path is lightly to be rare-ish.

OK I'm convinced.

> 
> The other concern is about cpu hotplug. For example, if all the booting cores
> have BBML2, but the hot plugged cores don't, shall we split the page table when
> the cores are hot added, and collapse the page table when the cores are hot
> removed?

I don't think we need to worry about this case too much. There are lots of
things today that require that the kernel can see at least 1 of each possible
CPU during boot (applying errata is a good example). If a new CPU model gets
hotplugged that it hasn't seen during boot then I think it's completely
reasonable to refuse to online it if it doesn't meet the configured feature
requirements. If you define BBML2 as a system feature, you'll get this behaviour
for free. In reality, hotplugged CPUs are going to be symmetric so I don't think
we will fall down this path in the real world.

> 
> I'm not sure whether the extra logic to support asymmetric systems is worth it
> or not. Maybe we should start from the symmetric systems, then add more graceful
> handle to asymmetric systems later if it turns out to be a real problem? And
> unfortunately I don't have the appropriate hardware to test the code. Maybe you
> or someone else from ARM has the right hardware?

My view is that we need to make BMML2 a system feature. Speculatively paint the
linear map with block mappings if the primary CPU supports BBML2. Stop machine
and repaint as page mappings if the system as a whole doesn't support BBML2 at
system feature finalization. In the unlikely event that the system does support
BBML2 and a CPU is hotplugged that doesn't support it, refuse to online it (that
bit is for free as a result of defining it as a system feature).

You can hack the code to always stop machine and remap as page mappings for
testing purposes.

I'm happy to collaborate on development of these patches and/or do testing as
required; I think the performance numbers you posted look compelling.

> 
> Thanks,
> Yang
> 
>> Thanks,
>> Ryan
>>
>>> +        .matches = has_bbmlv2,
>>> +    },
>>>       {},
>>>   };
>>>   diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
>>> index eb17f59e543c..287bdede53f5 100644
>>> --- a/arch/arm64/tools/cpucaps
>>> +++ b/arch/arm64/tools/cpucaps
>>> @@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
>>>   HAS_ADDRESS_AUTH_IMP_DEF
>>>   HAS_AMU_EXTN
>>>   HAS_ARMv8_4_TTL
>>> +HAS_BBMLV2
>>>   HAS_CACHE_DIC
>>>   HAS_CACHE_IDC
>>>   HAS_CNP
> 


