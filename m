Return-Path: <linux-kernel+bounces-526413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0708A3FE51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10267071DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57D1E5702;
	Fri, 21 Feb 2025 18:08:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B224CEEE;
	Fri, 21 Feb 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161306; cv=none; b=X8xcU1zBoYofhjEqrg9vvx8zOwqPCW3fdhbTm+ZJ3OkI2akeyxBVdxrBea1MPqZ/5mQjqRMaZIINwGzDyGMsScZxbh7wbWwB22oRyyyHiPgvpuhHYv5avtoGIRHQrbzYluPwyvqqLgf7LDT/wJuVbnRG6Omp0p3JT3bWDkvWZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161306; c=relaxed/simple;
	bh=hOS0CTaGVIMwC3SEzfUUQHm8owpSEkxqLDAs6zahYS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EAd/f4cToBdD3cEXO40ynM9K/D8Nwmi/iHpAaVtW9bVE5IcfeHdbZc3cbH/NHKeOtLaaRL5AlhwhSPryEsHPwGGD2EX4sh5IYAVfZaS+Z/SvqgoyJX0bEEnmqIbOb9RwcaVbArMBrR38BW4IluqyjuC92yHjarVFDWGV98nnxlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A41731EA6;
	Fri, 21 Feb 2025 10:08:42 -0800 (PST)
Received: from [10.1.26.146] (e125956.cambridge.arm.com [10.1.26.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83FFC3F59E;
	Fri, 21 Feb 2025 10:08:18 -0800 (PST)
Message-ID: <d0b12fb3-3deb-4327-86e4-519b495c0cac@arm.com>
Date: Fri, 21 Feb 2025 18:08:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 10/23] x86/resctrl: Remove MSR reading of event
 configuration value
To: "Luck, Tony" <tony.luck@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
 "pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "Huang, Kai" <kai.huang@intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "seanjc@google.com" <seanjc@google.com>, "Li, Xin3" <xin3.li@intel.com>,
 "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
 "ebiggers@google.com" <ebiggers@google.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "Eranian, Stephane" <eranian@google.com>
References: <cover.1737577229.git.babu.moger@amd.com>
 <b4298186c0be8db76be4eb74e1d948fbe5c1de7d.1737577229.git.babu.moger@amd.com>
 <53e104c0-64ee-4191-bddf-3ddb56dca1d5@intel.com>
 <SJ1PR11MB6083C234656AF934E41A7BA8FCF62@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <2a78f9a1-e03a-4e82-836b-26d3175d3f2b@intel.com>
 <SJ1PR11MB6083C4FA95527464031D5379FCF62@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
Autocrypt: addr=james.morse@arm.com; keydata=
 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
In-Reply-To: <SJ1PR11MB6083C4FA95527464031D5379FCF62@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tony, Reinette,

On 2/6/25 15:56, Luck, Tony wrote:
>>>> This new arch API has sharp corners because of asymmetry of where resctrl
>>>> runs the arch function. I do not think it is required to change this since we
>>>> can only speculate about how this may be used in the future but I do think
>>>> it will be helpful to add comments that highlight:
>>>>
>>>> resctrl_arch_mon_event_config_get() ->  May run on CPU that does not belong to domain.
>>>> resctrl_arch_mon_event_config_set() ->  Runs on CPU that belongs to domain.
>>>
>>> Here's a vague data point about the future to help with speculation.
>>>
>>> I have something coming along the pipeline that also can run on any CPU.

RISC-V has this - all their controls/monitors are accessible from any CPU.
Some MPAM platforms can do this too - but the code has to be structured for those
that need the IPI.

Having this be something resctrl can be told sounds like a great idea.

It sounds like all or nothing suits x86/riscv.
The MPAM driver has an accessibility cpumask for each thing it accesses that determines
if it needs to do an IPI.


>>> I am contemplating a flag in the rdt_resource structure (in appropriate substructure
>>> resctrl_cache/resctrl_membw) to indicate "domain" vs. "any" for operations.
>>>
>>> Would something like that be useful here?
>>
>> hmm ... I cannot envision how this may look. Could you please elaborate?
>>
>> You mention "a" (singular) flag in rdt_resource while this scenario involves
>> different ops having different scope. This makes me think that this flag may
>> have to be per operation that in turn would need additional infrastructure to
>> manage and track operations.
>>
>> These "arch" functions are evolving as the work to support MPAM is done and
>> so far I think it has been quite ad-hoc to just refactor arch specific code
>> into "arch" helpers instead of keeping track of which scope they are running in.
>> This currently requires any arch implementing an "arch" helper to be well aware
>> of how resctrl will call it.

This is how APIs in linux evolve - only the immediate problem needs solving.
Arch code being aware how resctrl uses a function shouldn't be surprising - it is the only user.


> I haven't fleshed it out yet. One option would be to have a "choose_cpu_mask()"
> function that takes resource and domain parameters (and given your comment
> about this case an operation code). Then use that as the mask in an smp_call*().
> 
> Operations that can run anywhere would return a mask with just bit for the
> current CPU.

That sounds like extra work. We already have a cpumask, if you set it to the cpu_possible mask
at boot, then smp_call_function() and friends will always prefer the current CPU, and it all falls
out in the wash.


Thanks,

James

