Return-Path: <linux-kernel+bounces-539306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F4061A4A31A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028AE7A69B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC31230BE3;
	Fri, 28 Feb 2025 19:53:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8211B87FB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772421; cv=none; b=OLw6sRbJedC2KzFtM+YrOO53TbA55HWd4As4/V4P3kzg9QSwOzdF6Hy6WxtVVQbCCnjf2KbAQCTz7ToLCmUPNrovR6nnJeN74+8YHFu6EA+fIKycY7mRchMMG6n/xfs2cTmSOfxNNADyJsoGL6EZ4OPudNud+PfA8MT82I0h9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772421; c=relaxed/simple;
	bh=8vG4uwrhcSdI+MjS+4BXkpsVWwm3WHTIYdayX6FmLro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PITyEtl44UhC9JX3gDRoBDaP7r5JEHKT8e9iWG7hIkIV3DWAT0eydBOxzx9QmEHTYl+CYSmdKnmgrB0lSyScYVD7QhWghMqdvSykUHcCd5hTXAtqF0KknjbxzQmYVu0nxd6rX2h0tx+I4ewuRW8lPXWbEcAPCn1j88+gDEeoHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE709150C;
	Fri, 28 Feb 2025 11:53:53 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92A853F5A1;
	Fri, 28 Feb 2025 11:53:29 -0800 (PST)
Message-ID: <54a797ba-792f-4eba-ba19-91bf80caf412@arm.com>
Date: Fri, 28 Feb 2025 19:53:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/42] x86/resctrl: Claim
 get_{mon,ctrl}_domain_from_cpu() helpers for resctrl
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
 <20250207181823.6378-31-james.morse@arm.com>
 <c735cf97-dc26-42be-82c9-cb37f96e896b@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <c735cf97-dc26-42be-82c9-cb37f96e896b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 04:08, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> get_{mon,ctrl}_domain_from_cpu() are handy helpers that both the arch
>> code and resctrl need to use. Rename them to have a resctrl_ prefix
>> and move them to a header file.

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 29415d023aab..511dab4ffcdc 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -3,6 +3,7 @@
>>  #define _RESCTRL_H
>>  
>>  #include <linux/cacheinfo.h>
>> +#include <linux/cpu.h>
>>  #include <linux/kernel.h>
>>  #include <linux/list.h>
>>  #include <linux/pid.h>
>> @@ -399,6 +400,42 @@ static inline u32 resctrl_get_config_index(u32 closid,
>>  	}
>>  }
>>  
>> +/*
>> + * Caller must hold the cpuhp read lock to prevent the struct rdt_domain from

> struct rdt_domain has since been split into struct rdt_ctrl_domain and struct rdt_mon_domain.
> I assume this comment covers both helpers so perhaps this can be "to prevent the domain
> from ..."?

Makes sense - thanks!


>> + * being freed.
>> + */
>> +static inline struct rdt_ctrl_domain *
>> +resctrl_get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
>> +{
>> +	struct rdt_ctrl_domain *d;
>> +
>> +	lockdep_assert_cpus_held();
>> +
>> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>> +		/* Find the domain that contains this CPU */
>> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>> +			return d;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline struct rdt_mon_domain *
>> +resctrl_get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
>> +{
>> +	struct rdt_mon_domain *d;
>> +
>> +	lockdep_assert_cpus_held();
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		/* Find the domain that contains this CPU */
>> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>> +			return d;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
> 
> Similar to previous requests, could you please provide a motivation for
> the switch to inline?

Hmmm, this has diverged over time. x86 is now using its get_domain_id_from_scope() and
resctrl_find_domain() to cover this. I can probably do away with MPAMs use of these...

~

This gets replaced by a patch that moves them to live next to their callers which lets
them be static, and makes the automated move feasible.


Thanks,

James

