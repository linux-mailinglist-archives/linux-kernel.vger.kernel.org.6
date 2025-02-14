Return-Path: <linux-kernel+bounces-515530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B1A365EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3B33B1CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78713193435;
	Fri, 14 Feb 2025 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iciYmixf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34B134AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559117; cv=none; b=Srsm7IQZTl1QktZsINYNKlDXFowfMJo0HUO4dkarznmG/B1uDT6xzD6OC1k63khnGZj6vruXIEjrSUl7aaymYn8aDbxsiWd33r3e23/TEuLVPWZcys1FYRWz8ezn8JAq1cNSbS7SpnaloUWTMU35KxnGbFY/2ZwzU+6mcDNRYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559117; c=relaxed/simple;
	bh=MaSVqZxrNY9IQD/tdXmpCeFc2YnxxHUucY/tpy+CXss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aC8LCsQAJVP4j+H0q6mdjAF0Sdiuks0IL30zpzfojx2jxt7FrVPtf+RUYX+TdZkTOGuf0BdCghuFhzCGPkds2XrHuc6Pzozio3utQKrdKr2NfjfsJjuV/i02PQx3+b8jx9gjfMHSVCVFWiPJLJsJ9DHSvU8Ds27R+qtPM6vazdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iciYmixf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739559116; x=1771095116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MaSVqZxrNY9IQD/tdXmpCeFc2YnxxHUucY/tpy+CXss=;
  b=iciYmixfTMqgz/X8Rwwd5sf2E+7XHJ9h0WvKlGv3Emjxdni1vdwb93Xu
   fz3mYomMgzVakSwKVjiD1ZYWL0w5RW40uTK8SwKTC8taSnso45HCS0VNn
   MysKHXRIgkr9JXj3aC/8/LpnrB7IyBFMOdkK3bDep6uZzFF/14qxLJVa7
   h4vyPpI/WflIOCZ0IPSK84IYnZ1NVZLK4eQvyVUh9KH1s/529vgEe488i
   opEVD6JG+ky9XGrWGC6cpoYGaopOf3SDfXmQBMQ1KREaFvb8QgSPz10TO
   GKTz4/rjq0SLr4/hQsWrBs+dsjPyDmz5zKO5L/3QtKjk0ypytnmA1Hy7p
   A==;
X-CSE-ConnectionGUID: 2vZK4EuJT5qwFz6A3g6QEA==
X-CSE-MsgGUID: 7hPkGtf3QKqey5jllcX5fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="51721535"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="51721535"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 10:51:55 -0800
X-CSE-ConnectionGUID: Kw+cwZ9nRNmoQImvv7FKPg==
X-CSE-MsgGUID: bjeFwl9ETiCuHsD3QDNMfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113401022"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.21]) ([10.125.109.21])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 10:51:55 -0800
Message-ID: <cfa6e15f-3fe5-42bc-a877-fd46bb3c9f88@intel.com>
Date: Fri, 14 Feb 2025 10:51:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/12] x86/mm: use broadcast TLB flushing for page
 reclaim TLB flushing
To: Rik van Riel <riel@surriel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali Shukla <Manali.Shukla@amd.com>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-9-riel@surriel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250213161423.449435-9-riel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 08:13, Rik van Riel wrote:
> In the page reclaim code, we only track the CPU(s) where the TLB needs
> to be flushed, rather than all the individual mappings that may be getting
> invalidated.
> 
> Use broadcast TLB flushing when that is available.

The changelog here is a little light. This patch is doing a *ton* of stuff.

The existing code has two cases where it is doing a full TLB flush, not
a ranged flush.

	1. An actual IPI to some CPUs in batch->cpumask
	2. A local flush, no IPI

The change here eliminates both of those options, even the "common case"
which is not sending an IPI at all. So this replaces a CPU-local (aka. 1
logical CPU) TLB flush with a broadcast to the *ENTIRE* system. That's a
really really big change to not be noted. It's not something that's an
obvious win to me.

> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 3c29ef25dce4..de3f6e4ed16d 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -1316,7 +1316,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  	 * a local TLB flush is needed. Optimize this use-case by calling
>  	 * flush_tlb_func_local() directly in this case.
>  	 */
> -	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
> +	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
> +		invlpgb_flush_all_nonglobals();
> +	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
>  		flush_tlb_multi(&batch->cpumask, info);
>  	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
>  		lockdep_assert_irqs_enabled();

The structure of the code is also a bit off to me. O'd kinda prefer that
we stick the pattern of (logically):

	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
		invlpgb_...();
	} else {
		on_each_cpu*();
	}

This patch is going a couple of functions up in the call chain above the
on_each_cpu()'s.

It would be more consistent with the previous modifications in this
series if the X86_FEATURE_INVLPGB check was in native_flush_tlb_multi(),
instead.

Would that make sense here? It would also preserve the "common case"
optimization that's in arch_tlbbatch_flush().

