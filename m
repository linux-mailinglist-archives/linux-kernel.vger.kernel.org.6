Return-Path: <linux-kernel+bounces-397767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44389BE00C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76ED71F23CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF271D3182;
	Wed,  6 Nov 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrMPZxl8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87341D5147
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880772; cv=none; b=llOHo7luTs11TpVQ5ToiS23Kv9K2HqlzOAIs3m0dnR5nwzhMUmOItB7Q0QjJUFPDJeQWi1GJIFOuCqnPD13fkNAzqLHIhpbr1UA2VNs1xIJif2ehjwqh3bJAI3DG4LsJTTa05VDq37y40YsrW8bB8oVTSG8lpXSwK8HhTRYUWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880772; c=relaxed/simple;
	bh=LAjBJIrf+QHNvH66aqJrh4mDtpWYTGpgIATIK51lkbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MiUUiQLaVPXQkMeK7e3v17Jnsd+YhRCBbORYYvs5cyjDipL8l1VAmdp7YLKGy8Qo5tYl+BbLWCzQDCWd8fa8icJivtBsX5snz01qN95xtOmsSMEesFfSAvlIrQ6Bk8/lM2pjOjGIMapzFk7XHvnYRscIrfm/K1Zk0IgU/8TYnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrMPZxl8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730880769; x=1762416769;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LAjBJIrf+QHNvH66aqJrh4mDtpWYTGpgIATIK51lkbk=;
  b=NrMPZxl8Rwi8mkfYOdfXda6hUpLNd4eYRco11+1sVasa97GvOxlW5izF
   j2yFqPCFSI4nbTw/y9UB51MJB+SZbg02Fsyu2pvjnmbGjWSQq6vXZgP6A
   C3G5Fzo+2CFNh/+Rt/G2A+7wXZVtjYFj+F3nYC45roNog/CHd4atu+0ft
   5dhz2r1QTygg9ObJnG+9v7c92tEOhzPoLfr1r2XYT3SwfZsq7O9nVK+KG
   mjW//Lto3Ij1MzqA/jiW9tUkdD4ax4B5qgK2mit6nsRwnXIfxA7ot66Ro
   5TPNfZ7TubyXBecie9J8VkOVdWDZACqJz8715vB2yhrZQY1i7Ts1LDQhJ
   w==;
X-CSE-ConnectionGUID: VzlWq1X8RcGXjoQgphKYXA==
X-CSE-MsgGUID: 6I6YX9xhQkSiIHYPWXB8OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="48181088"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="48181088"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:12:48 -0800
X-CSE-ConnectionGUID: uwapckj2T5ejfV4+VNGkKA==
X-CSE-MsgGUID: udN9Jek8SPSeLJvI8gkZqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="84801241"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:12:45 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Borislav Petkov <bp@alien8.de>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>,  <x86@kernel.org>,
  <linux-coco@lists.linux.dev>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  Dan Williams <dan.j.williams@intel.com>,
  "Kai Huang" <kai.huang@intel.com>,  David Hildenbrand <david@redhat.com>,
  "Oscar Salvador" <osalvador@suse.de>,  "H. Peter Anvin" <hpa@zytor.com>,
  "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [PATCH -V3 RESEND] x86, tdx, memory hotplug: Check whole
 hot-adding memory range for TDX
In-Reply-To: <702d9dbd-fb7d-44d0-a352-e78adf92254e@intel.com> (Dave Hansen's
	message of "Tue, 5 Nov 2024 10:34:59 -0800")
References: <20241031085151.186111-1-ying.huang@intel.com>
	<702d9dbd-fb7d-44d0-a352-e78adf92254e@intel.com>
Date: Wed, 06 Nov 2024 16:09:11 +0800
Message-ID: <8734k47pi0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Dave,

Thanks a lot for your detailed review!

Dave Hansen <dave.hansen@intel.com> writes:

> First and foremost, this touches x86 and core mm code, but it seem to
> solidly lean on being an x86 thing.  If anyone thinks this isn't x86
> tree material, please speak up.
>
> On 10/31/24 01:51, Huang Ying wrote:
>> Therefore, this patch checks the TDX compatibility of the whole
>
> Please zap the "this patch" nomenclature.  It showed up in a couple of
> places.  ChatGPT is actually pretty good at this kind of stuff and using
> imperative voice.

Sure.  Will do that.

>> hot-adding memory range through a newly added architecture specific
>> function (arch_check_hotplug_memory_range()).  If this patch rejects
>> the memory hot-adding for TDX compatibility, it will output a kernel
>> log message like below,
>> 
>>   virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.
>
> I think this is more clear and much more succinct:
>
>   virt/tdx: Rejecting incompatible memory range: 0xXXXXXXXX-0xXXXXXXXX

Yes.  This looks better, will use this in the next version.

>
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index eba178996d84..6db5da34e4ba 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -116,11 +116,13 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
>>  int tdx_cpu_enable(void);
>>  int tdx_enable(void);
>>  const char *tdx_dump_mce_info(struct mce *m);
>> +int tdx_check_hotplug_memory_range(u64 start, u64 size);
>>  #else
>>  static inline void tdx_init(void) { }
>>  static inline int tdx_cpu_enable(void) { return -ENODEV; }
>>  static inline int tdx_enable(void)  { return -ENODEV; }
>>  static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
>> +static inline int tdx_check_hotplug_memory_range(u64 start, u64 size) { return 0; }
>>  #endif	/* CONFIG_INTEL_TDX_HOST */
>>  
>>  #endif /* !__ASSEMBLY__ */
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index ff253648706f..30a4ad4272ce 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -55,6 +55,7 @@
>>  #include <asm/uv/uv.h>
>>  #include <asm/setup.h>
>>  #include <asm/ftrace.h>
>> +#include <asm/tdx.h>
>>  
>>  #include "mm_internal.h"
>>  
>> @@ -974,6 +975,11 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>>  	return ret;
>>  }
>>  
>> +int arch_check_hotplug_memory_range(u64 start, u64 size)
>> +{
>> +	return tdx_check_hotplug_memory_range(start, size);
>> +}
>> +
>>  int arch_add_memory(int nid, u64 start, u64 size,
>>  		    struct mhp_params *params)
>>  {
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 4e2b2e2ac9f9..f70b4ebe7cc5 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -1388,36 +1388,37 @@ static bool is_tdx_memory(unsigned long start_pfn, unsigned long end_pfn)
>>  	return false;
>>  }
>>  
>> -static int tdx_memory_notifier(struct notifier_block *nb, unsigned long action,
>> -			       void *v)
>> +/*
>> + * We don't allow mixture of TDX and !TDX memory in the buddy so we
>> + * won't run into trouble when launching encrypted VMs that really
>> + * need TDX-capable memory.
>> + */
>
> No "we's" please.
>
> I'd probably explain it like this:
>
> /*
>  * By convention, all RAM in the buddy must be TDX compatible whenever
>  * TDX is enabled. This avoids having to do extra work later to find
>  * TDX compatible memory to run VMs. Enforce that convention and reject
>  * attempted hot-adds of any TDX-incompatible ranges.
>  *
>  * Returns 0 to pass the checks and allow the hot-add
>  * Returns -ERRNO to fail the checks and reject the hot-add
>  */

This looks better, Thanks!  Will use it in the next version.

>> +int tdx_check_hotplug_memory_range(u64 start, u64 size)
>>  {
>> -	struct memory_notify *mn = v;
>> -
>> -	if (action != MEM_GOING_ONLINE)
>> -		return NOTIFY_OK;
>> +	u64 start_pfn = PHYS_PFN(start);
>> +	u64 end_pfn = PHYS_PFN(start + size);
>
> Nit:                ^ please vertically align those

Sure.  Will do that in the next version.

>>  	/*
>>  	 * Empty list means TDX isn't enabled.  Allow any memory
>> -	 * to go online.
>> +	 * to be hot-added.
>>  	 */
>>  	if (list_empty(&tdx_memlist))
>> -		return NOTIFY_OK;
>> +		return 0;
>
> The changelog also needs _some_ discussion of why the locking context is
> the same between the old and new uses of this function and why this
> doesn't need any locking _here_.

Sure.  Will do that in the next version.

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
>> +
>> +	return -EINVAL;
>>  }

--
Best Regards,
Huang, Ying

