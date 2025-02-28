Return-Path: <linux-kernel+bounces-539327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC024A4A346
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328A17ACA50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98072276030;
	Fri, 28 Feb 2025 19:57:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA36B2755F6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772632; cv=none; b=CgwVjPIkGYIDhJByso3V/qGd/zqR06XYlPItedzCQ8KHqSZRyNjJFr55gZYGHAZg6sba/g3CwxTUW5u9y7oqOQ9vgmMKgW1vcqrIWu2QQVHU6ZDddy3ZAw49gR2eeVgMZnnclJeICQOO9BZ9FPNjDvIB5Fcd0zatpYjARFr0oNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772632; c=relaxed/simple;
	bh=pebr1TXgGFm56+12yhdg/apHD43pzKh/GAy8OJlUNUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M32O/a9feefZwsCseoHl6XylHydMerDgs3uIRfoydOI6oiNliwYKQJ0Gd1xta4SVUSZ95U9BW2OZajVTT0THUHUNjGfI7GuIUpOWlfDNWyemgxDYdxjeEEaFbKG5bZZxvlBkU+/6vQJwWJsjMY0LJOcOoM+DVNEEkWqi9vVwEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623AF1515;
	Fri, 28 Feb 2025 11:57:25 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD0E13F5A1;
	Fri, 28 Feb 2025 11:57:05 -0800 (PST)
Message-ID: <0b410f04-4711-4e4c-a275-e823038ebfdf@arm.com>
Date: Fri, 28 Feb 2025 19:57:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/42] x86/resctrl: Add resctrl_arch_ prefix to pseudo
 lock functions
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
 <20250207181823.6378-24-james.morse@arm.com>
 <2acf1b5b-1ada-4b52-a6af-8d8441fa66dd@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <2acf1b5b-1ada-4b52-a6af-8d8441fa66dd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 00:53, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> resctrl's pseudo lock has some copy-to-cache and measurement
>> functions that are micro-architecture specific.
>>
>> For example, pseudo_lock_fn() is not at all portable.
>>
>> Label these 'resctrl_arch_' so they stay under /arch/x86.
>> To expose these functions to the filesystem code they need an entry
>> in a header file, and can't be marked static.

>> -static int measure_l3_residency(void *_plr)
>> +int resctrl_arch_measure_l3_residency(void *_plr)
>>  {
>>  	struct pseudo_lock_region *plr = _plr;
>>  	struct residency_counts counts = {0};
>> @@ -1205,14 +1207,14 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
>>  	plr->cpu = cpu;
>>  
>>  	if (sel == 1)
>> -		thread = kthread_run_on_cpu(measure_cycles_lat_fn, plr,
>> -					    cpu, "pseudo_lock_measure/%u");
>> +		thread = kthread_run_on_cpu(resctrl_arch_measure_cycles_lat_fn,
>> +					     plr, cpu, "pseudo_lock_measure/%u");
> 
> checkpatch.pl does not like this extra space that sneaked in.

Looks like I missed the step to re-check that after the rebase.


> With spacing fixed:
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>


Thanks!

James

