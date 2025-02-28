Return-Path: <linux-kernel+bounces-539239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC9A4A254
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2687F7A7772
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF08C1C548C;
	Fri, 28 Feb 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D94ZvWDH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893481ADC8C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769242; cv=none; b=Jc0lYR8QPz0eIW+52OUlVB6X+febNSllLZd4jwQKGP97E5e5cVsbb3xE7wttLQ+9elVh4pkXHIzuxSG8J/rAtUeJebXcD9gllb5xFmV5/j/Dhcg6sl6BzQW8OiglxOGz1g+D1VBMtNv5ezs/IfCHE3p4I5tfRzJ4FXYzhsnUQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769242; c=relaxed/simple;
	bh=iACDd02u4Vigl14lY5aeCbf6ulrY2wlpS901xYTxoD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHGRIzRS1bSSH+jb/8uRfDAxJ1Uh3cEsbwuLJnjaenIf9VF3w0kMr+phqCAwY8U3Q+M5vvWz1h999EPhHab778FGCdwguplrcfG+Z2uVO4ARVyXIi22Ez6deVyOdIxVh/u6QFL6HTuNzQE5mIopLIRKPktePzBUpgXa4mRvJMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D94ZvWDH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740769241; x=1772305241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iACDd02u4Vigl14lY5aeCbf6ulrY2wlpS901xYTxoD8=;
  b=D94ZvWDHWodCleHsBhkEEAH8DuKtlyiC6hWbHy7h945u6WTDjANaWSMO
   X0x83BiRO53DH7XcYIIfPd78Atzzpgs/+0Q7TfP7+Y6qZSV8WVzPl7FGh
   qJDhocOCxNVvi4Z/TdWboPJscOMA4UUPoT3c8+WH4Fk1hKFWw0be3mqrW
   lpQYUqjlT95EBE8NSnXJR9L1mRgM/Qg/frdXlrbwz4nTs0/iOzucgWnUh
   YrF5exGdyhXBTFc1UQILwObTMbWLKPoDE6tJ2E+IeRHuBF7gZg3/criit
   ZVvEEsuPaq7vsMm8QCYwyiTO1DV5xvhL6me3CaqxrCcNcmoqhMkNSLnFa
   g==;
X-CSE-ConnectionGUID: /TFNbEk2QMWiHndKILF2Wg==
X-CSE-MsgGUID: GKP+klqESjqwPch3qRJNVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41829000"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41829000"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 11:00:39 -0800
X-CSE-ConnectionGUID: EBMu4hBbS/Crc4gtf7KobA==
X-CSE-MsgGUID: /UwnTwopSteZ2ardV4z7pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117172545"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.137]) ([10.125.108.137])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 11:00:39 -0800
Message-ID: <4c2144a4-8889-483b-bb16-4d361d1d3d90@intel.com>
Date: Fri, 28 Feb 2025 11:00:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/13] x86/mm: use INVLPGB for kernel TLB flushes
To: Rik van Riel <riel@surriel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-5-riel@surriel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250226030129.530345-5-riel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 19:00, Rik van Riel wrote:
> Use broadcast TLB invalidation for kernel addresses when available.
> 
> Remove the need to send IPIs for kernel TLB flushes.

Nit: the changelog doesn't address the refactoring.

*Ideally*, you'd create the helpers and move the code there in one patch
and then actually "use INVLPGB for kernel TLB flushes" in the next. It's
compact enough here that it's not a deal breaker.

> +static void invlpgb_kernel_range_flush(struct flush_tlb_info *info)
> +{
> +	unsigned long addr, nr;
> +
> +	for (addr = info->start; addr < info->end; addr += nr << PAGE_SHIFT) {
> +		nr = (info->end - addr) >> PAGE_SHIFT;
> +		nr = clamp_val(nr, 1, invlpgb_count_max);
> +		invlpgb_flush_addr_nosync(addr, nr);
> +	}
> +	__tlbsync();
> +}

This needs a comment or two. Explaining that the function can take large
sizes:

/*
 * Flush an arbitrarily large range of memory with INVLPGB
 */

But that the _instruction_ can not is important.  This would be great in
the loop just above the clamp:

		/*
		 * INVLPGB has a limit on the size of ranges
		 * it can flush. Break large flushes up.
		 */

>  static void do_kernel_range_flush(void *info)
>  {
>  	struct flush_tlb_info *f = info;
> @@ -1087,6 +1099,22 @@ static void do_kernel_range_flush(void *info)
>  		flush_tlb_one_kernel(addr);
>  }
>  
> +static void kernel_tlb_flush_all(struct flush_tlb_info *info)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +		invlpgb_flush_all();
> +	else
> +		on_each_cpu(do_flush_tlb_all, NULL, 1);
> +}
> +
> +static void kernel_tlb_flush_range(struct flush_tlb_info *info)
> +{
> +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
> +		invlpgb_kernel_range_flush(info);
> +	else
> +		on_each_cpu(do_kernel_range_flush, info, 1);
> +}
> +
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
>  	struct flush_tlb_info *info;
> @@ -1097,9 +1125,9 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  				  TLB_GENERATION_INVALID);
>  
>  	if (info->end == TLB_FLUSH_ALL)
> -		on_each_cpu(do_flush_tlb_all, NULL, 1);
> +		kernel_tlb_flush_all(info);
>  	else
> -		on_each_cpu(do_kernel_range_flush, info, 1);
> +		kernel_tlb_flush_range(info);
>  
>  	put_flush_tlb_info();
>  }

But the structure of this code is much better than previous versions.
With the comments fixed:

Acked-by: Dave Hansen <dave.hansen@intel.com>

