Return-Path: <linux-kernel+bounces-375903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D559A9CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56CE1C203DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1B16E860;
	Tue, 22 Oct 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QET9J2rf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8227735
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586128; cv=none; b=WlBHvfkC0WgrFlK+4yh0/lGSJ1xghGlcMCaLf8dngHJgShGSp51qtgMkP+ZiFCSe0CZpJI8QJAPARzM+8Ajkh/ES9iFnl8QNfK2iUwfs7kRp8F1blelSopkB9mcqwW6vmThDARpAGus5B7JZx2WFwsyCUHKiVMimrhgLQfzT6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586128; c=relaxed/simple;
	bh=aJGyiVV1Vx+wkCJPog3Ga3tOsSFFzIoJWEjdxQipbM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFCpv5Om6cmbE+yc9qJeM/OvqN4P1zcWv7wPRPIG2MapFGimiZHbr7YZVz5QibprnpTQIakN7Qb4muVlRP/7IPyvTljpruKggxMp+AV6Vn1cNTMzqnDAV6TYID+MnMXHxGI9eI+vT28HY7z0ZlxnyHPJSj/qcYnv7w1SrIVcSTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QET9J2rf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729586125; x=1761122125;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=aJGyiVV1Vx+wkCJPog3Ga3tOsSFFzIoJWEjdxQipbM8=;
  b=QET9J2rfkjzpq95Kc+51EYN6XByo7VQ17F5VJ5rXKW7bD8hik9jZULnw
   1KViWIkuYgkZzqVussv9aEB8Fa9tx+4dFJRYXNy6Kg9/g8VRjTt3gfppE
   YPov6hGy/+hfxRX0CyAKz9AqilqBk7X001DWWVyjSXyUODSqNC3dn0LRI
   FBIZrt26CBLI+fsIjyvJD8g9sDqbxT05LIhBgQNyLotsCKpAtcqgt7lcN
   IdsEK01IjrDTec3gPEzKepdj1UghdpxHaexm4ECyT97MxwYD0wPwC39Z5
   TfjBu6QihwYyPpTYtzC/+GerK+Q7J/E7XKvmweDs1GO8Rft35dBUO6iol
   A==;
X-CSE-ConnectionGUID: RIjcN73iTeqC9jOGj9yxmw==
X-CSE-MsgGUID: mhwmeebrQ8qICIQ/C/tpzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29260035"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29260035"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:35:25 -0700
X-CSE-ConnectionGUID: 7gXu7vSUTKqgcCNx5pA5ow==
X-CSE-MsgGUID: iWFLw6k0QJqYXX+yMmEUGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80602371"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:35:22 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>,  x86@kernel.org,
  linux-coco@lists.linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Dan Williams <dan.j.williams@intel.com>,
  Kai Huang <kai.huang@intel.com>,  David Hildenbrand <david@redhat.com>,
  "H. Peter Anvin" <hpa@zytor.com>,  Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH -V3] x86/tdx, memory hotplug: Check whole hot-adding
 memory range for TDX
In-Reply-To: <ZxdY8ty-nAj3dlQQ@localhost.localdomain> (Oscar Salvador's
	message of "Tue, 22 Oct 2024 09:49:06 +0200")
References: <20241022031617.159969-1-ying.huang@intel.com>
	<ZxdY8ty-nAj3dlQQ@localhost.localdomain>
Date: Tue, 22 Oct 2024 16:31:48 +0800
Message-ID: <87r0884jyj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Oscar,

Oscar Salvador <osalvador@suse.de> writes:

> On Tue, Oct 22, 2024 at 11:16:17AM +0800, Huang Ying wrote:
>> On systems with TDX (Trust Domain eXtensions) enabled, current kernel
>> checks the TDX compatibility of the hot-added memory ranges through a
>> memory hotplug notifier for each memory_block.  If a memory range
>> which isn't TDX compatible is hot-added, for example, some CXL memory,
>> the command line as follows,
>> 
>>   $ echo 1 > /sys/devices/system/node/nodeX/memoryY/online
>> 
>> will report something like,
>> 
>>   bash: echo: write error: Operation not permitted
>> 
>> If pr_debug() is enabled, current kernel will show the error message
>> like below in the kernel log,
>> 
>>   online_pages [mem 0xXXXXXXXXXX-0xXXXXXXXXXX] failed
>> 
>> Both are too general to root cause the problem.  This may confuse
>> users.  One solution is to print some error messages in the TDX memory
>> hotplug notifier.  However, kernel calls memory hotplug notifiers for
>> each memory block, so this may lead to a large volume of messages in
>> the kernel log if a large number of memory blocks are onlined with a
>> script or automatically.  For example, the typical size of memory
>> block is 128MB on x86_64, when online 64GB CXL memory, 512 messages
>> will be logged.
>> 
>> Therefore, this patch checks the TDX compatibility of the whole
>> hot-adding memory range through a newly added architecture specific
>> function (arch_check_hotplug_memory_range()).  If this patch rejects
>> the memory hot-adding for TDX compatibility, it will output a kernel
>> log message like below,
>> 
>>   virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
>> 
>> The target use case is to support CXL memory on TDX enabled systems.
>> If the CXL memory isn't compatible with TDX, the kernel will reject
>> the whole CXL memory range.  While the CXL memory can still be used
>> via devdax interface.
>> 
>> This also makes the original TDX memory hotplug notifier useless, so
>> this patch deletes it.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks!

> One question below:
>
> ...
>
>> +int tdx_check_hotplug_memory_range(u64 start, u64 size)
>>  {
>> -	struct memory_notify *mn = v;
>> -
>> -	if (action != MEM_GOING_ONLINE)
>> -		return NOTIFY_OK;
>> +	u64 start_pfn = PHYS_PFN(start);
>> +	u64 end_pfn = PHYS_PFN(start + size);
>>  
>>  	/*
>>  	 * Empty list means TDX isn't enabled.  Allow any memory
>> -	 * to go online.
>> +	 * to be hot-added.
>>  	 */
>>  	if (list_empty(&tdx_memlist))
>> -		return NOTIFY_OK;
>> +		return 0;
>>  
>>  	/*
>>  	 * The TDX memory configuration is static and can not be
>> -	 * changed.  Reject onlining any memory which is outside of
>> +	 * changed.  Reject hot-adding any memory which is outside of
>>  	 * the static configuration whether it supports TDX or not.
>>  	 */
>> -	if (is_tdx_memory(mn->start_pfn, mn->start_pfn + mn->nr_pages))
>> -		return NOTIFY_OK;
>> +	if (is_tdx_memory(start_pfn, end_pfn))
>> +		return 0;
>>  
>> -	return NOTIFY_BAD;
>> +	pr_info("Reject hot-adding memory range: %#llx-%#llx for TDX compatibility.\n",
>> +		start, start + size);
>
> Why not using pr_err() here?
>
> I was checking which kind of information level we use when failing at
> hot-adding memory, and we seem to be using pr_err(), and pr_debug() when
> onlining/offlining.
>
> Not a big deal, and not saying it is wrong, but was just wondering the reasoning
> behind.

TBH, I have no strong opinion about which log level is more appropriate.
IMHO, it shouldn't be pr_debug() to make it easy for users to root cause
the hot-adding failure.  And, it appears too harsh to use pr_err(),
because there's no program error, etc.  So, I think that something
in-between is more appropriate.  That is, pr_warn(), pr_notice, or
pr_info().  In them, I prefer pr_info() a little.

--
Best Regards,
Huang, Ying

