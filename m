Return-Path: <linux-kernel+bounces-355918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD39958E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0E283D56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DDD215F46;
	Tue,  8 Oct 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn/gkifS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C81E0B8C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421528; cv=none; b=juGth/5Zm0hGeOAlsEnjgSW+cjrI1D/zhHWsh6auodgi67qKoO20/F9WcmHAO+oaNq5HpEcNHLaK4h3m/2nlSfakhKGFrog7actnHrOkGdakddQkCBolavd8EmaKA5TYCe9dlfth+UGZPC4FiV2P88yxb6z+ijHh2Rfc1CEJ7BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421528; c=relaxed/simple;
	bh=A5zKkNnRv/TK4FdPtPKqZcWK5HvI13mYFfVc5IiNyg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNyLAwHmaPSbSsRbHzh1awjyKDxVOxw2n42onu2VrAXatUzje1gd2su7c9RdMo3VQkuKubzG2ujDLk7QVOGmVxqCGrWMXI05KJ99u6pvUSWiHsLt/ecTWkFiJtx1//F5M+tm/gUt4nip4/GF9FWPQicZDSKQZPliucRBb8vV1kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qn/gkifS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728421526; x=1759957526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A5zKkNnRv/TK4FdPtPKqZcWK5HvI13mYFfVc5IiNyg0=;
  b=Qn/gkifSh7bBjNU1twbE0pZoz2cZwwZhafYkyWE3CKvED40a7uEiQ9e6
   i1bbv+tDi25xbXgD/MVKc7CPsviowme6tvDrgYek9qTmOpJbS2Xl9Ie49
   WDjtpZsWfkUKwKPHm6b6leF7pnditxzfF5rdnFok1j3TPmFhQDIBdU3IE
   cXvS5xcDKK4J10UY4l8BMhhozXEhKQSlUoZbY9vvY+3ksszUYst2RW7/T
   RI10XqVfCdpKn5OgrL88Cyf5ntqOhUEgVcrHyFgzdfKgBUUmSY8/6QfJ+
   o+Y/f4/Y6jLzeRyZ6qZqNoxZN20aDzGIr+GlKaL46C7kGuHbN/8wX+SBR
   g==;
X-CSE-ConnectionGUID: O2hJpiCtSQa6lyiW29FVgw==
X-CSE-MsgGUID: kREafrlNQf+NOvE+qU7puw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31448646"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="31448646"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 14:05:25 -0700
X-CSE-ConnectionGUID: QysLVHgRTJqydKkD7xUWuw==
X-CSE-MsgGUID: Fmrrd6zvTxSo2XdbbolwHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="76245972"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 14:05:25 -0700
Received: from [10.212.24.252] (kliang2-mobl1.ccr.corp.intel.com [10.212.24.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5791420B5782;
	Tue,  8 Oct 2024 14:05:24 -0700 (PDT)
Message-ID: <ed3c066f-5040-4573-a91f-3ee95014c951@linux.intel.com>
Date: Tue, 8 Oct 2024 17:05:22 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
To: Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
 mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: Oliver Sang <oliver.sang@intel.com>,
 Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20240913171033.2144124-1-kan.liang@linux.intel.com>
 <875xq2tv05.ffs@tglx> <3b65fd68-8f5b-4029-8dbd-46c0b2cc34c7@linux.intel.com>
 <87ploas5rb.ffs@tglx> <87msjes56x.ffs@tglx>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <87msjes56x.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-10-08 4:36 p.m., Thomas Gleixner wrote:
> On Tue, Oct 08 2024 at 22:23, Thomas Gleixner wrote:
>> On Tue, Oct 08 2024 at 16:10, Kan Liang wrote:
>>> On 2024-10-08 12:33 p.m., Thomas Gleixner wrote:
>>>> On Fri, Sep 13 2024 at 10:10, kan liang wrote:
>>>>> +static void __init init_rapl_pmu(void)
>>>>> +{
>>>>> +	struct rapl_pmu *pmu;
>>>>> +	s32 rapl_pmu_idx;
>>>>> +	int cpu;
>>>>> +
>>>>> +	cpus_read_lock();
>>>>> +
>>>>> +	for_each_cpu(cpu, cpu_online_mask) {
>>>>
>>>> How is that supposed to work, when not all CPUs are online when
>>>> init_rapl_pmus() is invoked?
>>>>
>>>
>>> RAPL is a module. The module_init() is called during do_initcalls(),
>>> which is after the smp_init(). The cpu_online_mask has been setup in the
>>> smp_init().
>>>
>>> I also patched the kernel to double check. The cpu_online_mask indeed
>>> shows all the online CPUs.
>>>
>>> [    7.021212] smp: Brought up 1 node, 48 CPUs
>>> [    7.021212] smpboot: Total of 48 processors activated (211200.00
>>> BogoMIPS)
>>> ... ...
>>> [   16.557323] RAPL PMU: rapl_pmu_init: cpu_online_mask 0xffffffffffff
>>
>>  1) Start your kernel with maxcpus=2 (not recommended, but ...)
>>  2) Load the module
>>  3) Online the rest of the CPUs from userspace
>>
>> If your machine has more than one die you might be surprised...

Thanks. I will find a 2 sockets machine and give it a try.

> 
> You can make this work because the new topology code allows you to
> retrieve the possible number of cores/dies/packages even when they have
> not been onlined yet. 
>

Actually, I think the possible CPU mask should be good enough here. The
init_rapl_pmu() just intends to allocate the space for a pmu in each die.

The worst case of using a possible mask is that some space may be
wasted, when there is no online CPUs on a die. But it should be an
unusual case. It should be harmless.

Thanks,
Kan

