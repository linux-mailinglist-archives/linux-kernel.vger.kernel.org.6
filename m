Return-Path: <linux-kernel+bounces-520573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584DEA3ABA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 23:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638913A6AE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4451D86C7;
	Tue, 18 Feb 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyF6X87Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880F1D6DAD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917650; cv=none; b=OMdhfzQqQAfafcTWK1aNqnItk0yLJ+yp9Fe0GK5IvAr1bY+fuddIdIbJXpSmvZY5zwGcIYYsr74ohfENTCY8pQV/VaXRnBv+CgqidmoisXNIeX27Zfjk4hHVnqIOLnPbVFjJLB7i0/CASMTZ4wIXeXQIW1Z1uLCmBR27pRF10uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917650; c=relaxed/simple;
	bh=R2Z+EiQfPTI1cTJRSIo5QQlqbt/tGC6vKcxiz+9+AJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3poFCwlt34+NOAuTiMuruCEIJW+w9knIjDK3RXwdOrI7kcnbINC7rsT4qqbw8joUH2M1inky9UqaDCftCvweSrz8zFjl8pn7zZ2AEhthndNg01wC/lmsYwc2tycPNRy4wP1f1GVNeSdI6k+7o37lOJmc1KRZUtdhth0t3QihEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyF6X87Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739917649; x=1771453649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R2Z+EiQfPTI1cTJRSIo5QQlqbt/tGC6vKcxiz+9+AJw=;
  b=IyF6X87Y04ttcNHk8/Xj2jGNPelFB031aXH23BRBpJWop1UAzax3XmzQ
   bAB0lD/j4bbR6UQ3sSCBeg8cfIk/VixLsApn37he1R38UkIdmA+PVBLON
   uvjb9ooLGXYiYI5/l/bpjJPkJmLflPmT2Kq6twy9JHz//9gKs/1z/8AOh
   R3YmKhH9TkS0YidZBIaZfJlCTmkkZGuiTJpV8YbS9JkxNtPeNuvkxVeSm
   KxZlzJvu6Uge87ECloqg9vVPJTYMPcB/3nFYFrgsN1ClwSfqg7zO0Dj8A
   N0m9ICVmd8Pbr9RsQ2r/LfAGy6nJBWIlZ6LugxR/lVc/5Onts//GLV4CZ
   w==;
X-CSE-ConnectionGUID: d+qMDseaTf6ybfMHTrojjg==
X-CSE-MsgGUID: mOsinrhnRguOaSINn76DSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="58174869"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="58174869"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 14:27:28 -0800
X-CSE-ConnectionGUID: H6MXhDhjR9qUAOs2t4/SgA==
X-CSE-MsgGUID: 9u130mWdQsWiiYGxS7mGTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115006326"
Received: from mgoodin-mobl2.amr.corp.intel.com (HELO [10.125.109.220]) ([10.125.109.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 14:27:27 -0800
Message-ID: <5f4d58fe-4fa1-4b59-81a7-e8c8d3030d0a@intel.com>
Date: Tue, 18 Feb 2025 14:27:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/12] x86/mm: use INVLPGB for kernel TLB flushes
To: Rik van Riel <riel@surriel.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
 zhengqi.arch@bytedance.com, nadav.amit@gmail.com, thomas.lendacky@amd.com,
 kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 jackmanb@google.com, jannh@google.com, mhklinux@outlook.com,
 andrew.cooper3@citrix.com, Manali Shukla <Manali.Shukla@amd.com>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-7-riel@surriel.com>
 <ab55a809-e0d2-4364-84ce-917a40ee299a@intel.com>
 <20250214194013.GA2198@noisy.programming.kicks-ass.net>
 <c42c314c-3c1b-4e4a-803a-ecf31685d4cc@intel.com>
 <3e26626aa1c01aaa5d1e7b42d3ffbd632c3264fb.camel@surriel.com>
 <Z6_3O75TzANMFrKN@google.com>
 <724d17ce3fbe07d1d9404f8f32ba518071bcfa4a.camel@surriel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <724d17ce3fbe07d1d9404f8f32ba518071bcfa4a.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 10:00, Rik van Riel wrote:
> On Sat, 2025-02-15 at 02:08 +0000, Yosry Ahmed wrote:
>> So I think what Dave wants (and I agree) is:
>> 	if (!broadcast_kernel_range_flush(info))
>> 		ipi_kernel_range_flush(info)
>>
>> Where ipi_kernel_range_flush() contains old_thing1() and oldthing2().

That's OK-ish. But it still smells of hacking in the new concept without
refactoring things properly.

Let's logically inline the code that we've got.  I think it actually
ends up looking something like this:

	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
		if (info->end == TLB_FLUSH_ALL) {
			invlpgb_flush_all();
		} else {
			for_each(addr)
				invlpgb_flush_addr_nosync(addr, nr);
		}
	} else {
		if (info->end == TLB_FLUSH_ALL)
 			on_each_cpu(do_flush_tlb_all, NULL, 1);
	 	else
 			on_each_cpu(do_kernel_range_flush, info, 1);
	}

Where we've got two inputs:

	1. INVLPGB support (or not)
	2. TLB_FLUSH_ALL (basically ranged or full flush)

So I think we should group by *one* of those. The above groups by
INVLPGB support and this groups by TLB_FLUSH_ALL:

	if (info->end == TLB_FLUSH_ALL) {
		if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
			invlpgb_flush_all();
		} else {
			on_each_cpu(do_flush_tlb_all, NULL, 1);
		}
	} else {
		if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
 			for_each(addr)
				invlpgb_flush_addr_nosync(addr, nr);
	 	else
 			on_each_cpu(do_kernel_range_flush, info, 1);
	}

So, if we create some helpers that give some consistent naming:

static tlb_flush_all_ipi(...)
{
	on_each_cpu(do_flush_tlb_all, NULL, 1);
}

static tlb_flush_all(...)
{
	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
		invlpgb_flush_all(...);
	else
		tlb_flush_all_ipi(...);
}

and then also create the ranged equivalents (which internally have the
same cpu_feature_enabled() check):

	tlb_flush_range_ipi(...)
	invlpgb_flush_range(...)

Then we can have the top-level code be:

	if (info->end == TLB_FLUSH_ALL)
		tlb_flush_all(info);
	else
		tlb_flush_range(info);

That actually looks way nicer than what we have today. For bonus points,
if a third way of flushing the TLB showed up, it would slot right in:

 static tlb_flush_all(...)
 {
	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
		invlpgb_flush_all(...);
+	else if cpu_feature_enabled(X86_FEATURE_RAR))
+		rar_flush_all(...);
	else
		tlb_flush_all_ipi(...);
 }

That's *exactly* the way we want the code to read. At the higher level,
it's deciding based on the generic thing that *everybody* cares about:
ranged or full flush. Then, at the lower level, it's deciding how to
implement that high-level flush concept.

