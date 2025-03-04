Return-Path: <linux-kernel+bounces-544605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2ABA4E309
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83C619C0169
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D526A0A8;
	Tue,  4 Mar 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExPMUZPs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F3239579
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100998; cv=none; b=MzzFmumKRR96VylTSH9O+g5ToDpksGEmVuAOoyEhC3S64VCZzNMLxVR+4kOb6vpZKDMJ1tl9P1AK0be+ozT9vxnCLj8IjEDkpkg+NMi1Zue0/zX2LmoqN5JYA3GWYGeF8LnZEW4sTToMU1Zxx1yBDmceD0wfmdWwGrhRy1Qscfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100998; c=relaxed/simple;
	bh=opmnGSMl5a3rw4PfYRN77P+Mh1CbJMCOLTe7ToepzFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GswbOJ8fB+fXv9xGkSwOaT6yTbKCWbv8gSB1c0Yp7gT6H6wL5Jeh70yLts9M8/rlV4fO0F+Pxg+zj41bcPQubK3pzPk86ZX37axMFypkMwxdyBeT5vQ8xVq6SYN4lWOk6EEit/Qb3DZIDEC8Q8hJqj6nEVZI189vw4DA65esHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExPMUZPs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741100996; x=1772636996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=opmnGSMl5a3rw4PfYRN77P+Mh1CbJMCOLTe7ToepzFw=;
  b=ExPMUZPs754CB68mklRAaJkBgRbqgc6Ft5M5U6ZGj4gaGe7LTguWAB6y
   zKSfLVexmHCMHMfWjkPXukeR2kzflwwFkyweZSBq4s+g/aXttoWAC2KEN
   0LQ2cuEK/8zKxL4Ms9VDb27hMjDJTXIgWIBIbkKH37/2h4A43zqxIla3F
   9QLiM1y8dX9IAp2RTqJ71V5J4RK0p1cGq0/VcCBeaYvEJtUoiGlt+diCH
   nGjdS0P+WGZTzh14A46ahoNGO4iFGi+HDwwTbQIwS6g5P786FBlBli5ND
   5PQSlzjBOSz7/suVWrtfStjOde3QKOX9zweXUsUnK2My5Pw1YpugzpEuY
   A==;
X-CSE-ConnectionGUID: Wy9RbGzWS2q6EG8bJXxL7Q==
X-CSE-MsgGUID: eA7+tcrvTCiNDaaCT8jRHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42216272"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42216272"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:09:56 -0800
X-CSE-ConnectionGUID: Sg0R8AiqRrqT13SZRdhoQA==
X-CSE-MsgGUID: WdUDCJMiSBafbrn400eNuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118404768"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.109.94]) ([10.125.109.94])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:09:54 -0800
Message-ID: <ec7247d0-0379-487d-a2d7-21b81dcd0c38@intel.com>
Date: Tue, 4 Mar 2025 07:10:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/13] x86/mm: add INVLPGB support code
To: Borislav Petkov <bp@alien8.de>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-4-riel@surriel.com>
 <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>
 <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>
 <34b80474-a309-493b-81e9-3a7d4de8a369@intel.com>
 <20250304110032.GEZ8bdUOg2WLUrhMcm@fat_crate.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250304110032.GEZ8bdUOg2WLUrhMcm@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 03:00, Borislav Petkov wrote:
> On Mon, Mar 03, 2025 at 11:23:58AM -0800, Dave Hansen wrote:
>> Here's a plain diff if you just want to squish it in.
> 
>> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>> index 5375145eb9596..3bd617c204346 100644
>> --- a/arch/x86/include/asm/tlb.h
>> +++ b/arch/x86/include/asm/tlb.h
>> @@ -28,6 +28,11 @@ static inline void invlpg(unsigned long addr)
>>  	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");
>>  }
>>  
>> +enum invlpgb_stride {
> 
> Right, this is an address stride, as the text calls it.
> 
>> +	NO_STRIDE  = 0,
>> +	PTE_STRIDE = 0,
> 
> Ok, so those are confusing. No stride is PTE stride so let's just zap
> NO_STRIDE.

Passing "PTE_STRIDE" to an operation that doesn't have a stride is
pretty confusing too.

...
>  /* Flush all mappings, including globals, for all PCIDs. */
> @@ -117,21 +126,21 @@ static inline void invlpgb_flush_all(void)
>  	 * as it is cheaper.
>  	 */
>  	guard(preempt)();
> -	__invlpgb(0, 0, 0, 1, 0, INVLPGB_INCLUDE_GLOBAL);
> +	__invlpgb(0, 0, 0, 1, PTE_STRIDE, INVLPGB_FLAG_INCLUDE_GLOBAL);
>  	__tlbsync();
>  }

This one, for example. It's not flushing PTEs an doesn't have a start
address or nr>0.

So, we could have the enum be totally divorced from the hardware type:

	NO_STRIDE,
	PTE_STRIDE,
	PMD_STRIDE

and decode it at the end:

	if (stride == PMD_STRIDE)
		foo | PMD_STRIDE_BIT;


