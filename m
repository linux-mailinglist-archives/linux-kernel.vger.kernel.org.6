Return-Path: <linux-kernel+bounces-290046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0005954ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294501C225F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9C1BE874;
	Fri, 16 Aug 2024 16:29:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29824817;
	Fri, 16 Aug 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825773; cv=none; b=Ms8oi35aNA1Z2WtoGi56TkwWVOS+L5hlCe2PfcfZxkyVpwVMwiPtEWST7Bvbfx3DqajiwtoEPzk0OljpX6R2Vf01Kl8pS84S5B1DCoU245GyuSRls/e2cE2EkgzieIkY+bwJSoLluTW0pPwS3LSWb9EOs+WNiAOcuw5MSuC5c2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825773; c=relaxed/simple;
	bh=CEkk78MpdOFg7y89qF834o19vL8cJIT1cZZ1OIlxXy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kq31hfQaP5xa8cdNF1fprTEa7YtyYFQZvhKmVL7AMWqKwIKSjKtQfqnHMoUtcwm4vIlug12oBNTogsjwtIA1u/77qYEQTqprQaydX85wbp08r4xbpsvZjLTiBv8FOgBCg0OPQx79YQGQKE+JQHwQXhguCSzH4OmSweINNMC36mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80B0B1474;
	Fri, 16 Aug 2024 09:29:57 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9602D3F58B;
	Fri, 16 Aug 2024 09:29:27 -0700 (PDT)
Message-ID: <f287fc4c-ece3-4914-bb17-fe1597517d65@arm.com>
Date: Fri, 16 Aug 2024 17:29:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 dave.hansen@linux.intel.com, fenghua.yu@intel.com, mingo@redhat.com,
 tglx@linutronix.de, corbet@lwn.net, bp@alien8.de,
 Reinette Chatre <reinette.chatre@intel.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
 <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

On 12/07/2024 23:05, Reinette Chatre wrote:
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Add the functionality to enable/disable AMD ABMC feature.
>>
>> AMD ABMC feature is enabled by setting enabled bit(0) in MSR
>> L3_QOS_EXT_CFG.  When the state of ABMC is changed, the MSR needs
>> to be updated on all the logical processors in the QOS Domain.
>>
>> Hardware counters will reset when ABMC state is changed. Reset the
>> architectural state so that reading of hardware counter is not considered
>> as an overflow in next update.
>>
>> The ABMC feature details are documented in APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC).

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 7e76f8d839fc..471fc0dbd7c3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2402,6 +2402,72 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool

>> +int resctrl_arch_abmc_enable(void)
>> +{
>> +    struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +    int ret = 0;
>> +
>> +    lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +    if (r->mon.abmc_capable && !hw_res->abmc_enabled) {
>> +        ret = _resctrl_abmc_enable(r, true);
>> +        if (!ret)
>> +            hw_res->abmc_enabled = true;
>> +    }
>> +
>> +    return ret;

> resctrl_arch_abmc_enable() should probably keep returning an int even though
> this implementation does not need it since other archs may indeed return error.

Just as a datapoint on this: arm64 does indeed need to be able to return an error here.
This helper gets used to allocate all the monitors (and an array to hold them) which can fail.


Thanks,

James

