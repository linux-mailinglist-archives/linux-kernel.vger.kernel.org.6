Return-Path: <linux-kernel+bounces-520777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED09A3AF15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E3173757
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15216137C35;
	Wed, 19 Feb 2025 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xQkuOlOf"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB5418E1A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739929581; cv=none; b=P6R3QvtNpjvuXfcuXsF3aZYWee/dbxBQaRSmuwrM2l+U2jc+tWC8XOVHUw73t53AjSq8bC9PUJnhdw3bkvGDyavpP8yGE5Ebpgq2vEksHyjUW8Mx64IHSM/IJZ8qj9OoOrn0bhpC+M1eXWMs8jHzyyzJ6aE0xkx3QHzXQi3gHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739929581; c=relaxed/simple;
	bh=o4XLmIEKjRffIiKZmXPhACWopK/BLR1j11LCFZSydh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVOZGqXQZciVH2SMyP5F8cpdG4eS+FMdjfMFEPbGSEbOyVues88QKmtsvCTiZzSCXW2Ifisg8gw6j2NBZ5UvhEVI1TOTZ919q6zOuFeq+W6H2xRfg/BHnjpq/QmEAYM9kLjXgA05tlZQmo72KzidvIRTeoDdW6iwKLLXwYGwWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xQkuOlOf; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Feb 2025 01:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739929576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AKmhfFcxXVuJp7LOFK6fPKPUccc9ndXGwrERNozYUpE=;
	b=xQkuOlOfS9i7vpsZbh9HlQ7rxQKmBxSKYBa/zm9IJw8T8ufR95Cq3i1Wyr2oyPpPUxwCaf
	l6T07kIRFrsTQHITwkyUV34UeZC20CGkjzfX68wkRvN7jQL3usue4A7h8vmC1BrtCdEHFH
	fX7gQyhQFxl5aLtNvhnPRO/PWD3gM/Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rik van Riel <riel@surriel.com>, Peter Zijlstra <peterz@infradead.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: Re: [PATCH v11 06/12] x86/mm: use INVLPGB for kernel TLB flushes
Message-ID: <Z7U34nmLBECDIxlK@google.com>
References: <20250213161423.449435-1-riel@surriel.com>
 <20250213161423.449435-7-riel@surriel.com>
 <ab55a809-e0d2-4364-84ce-917a40ee299a@intel.com>
 <20250214194013.GA2198@noisy.programming.kicks-ass.net>
 <c42c314c-3c1b-4e4a-803a-ecf31685d4cc@intel.com>
 <3e26626aa1c01aaa5d1e7b42d3ffbd632c3264fb.camel@surriel.com>
 <Z6_3O75TzANMFrKN@google.com>
 <724d17ce3fbe07d1d9404f8f32ba518071bcfa4a.camel@surriel.com>
 <5f4d58fe-4fa1-4b59-81a7-e8c8d3030d0a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f4d58fe-4fa1-4b59-81a7-e8c8d3030d0a@intel.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 18, 2025 at 02:27:31PM -0800, Dave Hansen wrote:
> On 2/18/25 10:00, Rik van Riel wrote:
> > On Sat, 2025-02-15 at 02:08 +0000, Yosry Ahmed wrote:
> >> So I think what Dave wants (and I agree) is:
> >> 	if (!broadcast_kernel_range_flush(info))
> >> 		ipi_kernel_range_flush(info)
> >>
> >> Where ipi_kernel_range_flush() contains old_thing1() and oldthing2().
> 
> That's OK-ish. But it still smells of hacking in the new concept without
> refactoring things properly.
> 
> Let's logically inline the code that we've got.  I think it actually
> ends up looking something like this:
> 
> 	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
> 		if (info->end == TLB_FLUSH_ALL) {
> 			invlpgb_flush_all();
> 		} else {
> 			for_each(addr)
> 				invlpgb_flush_addr_nosync(addr, nr);
> 		}
> 	} else {
> 		if (info->end == TLB_FLUSH_ALL)
>  			on_each_cpu(do_flush_tlb_all, NULL, 1);
> 	 	else
>  			on_each_cpu(do_kernel_range_flush, info, 1);
> 	}
> 
> Where we've got two inputs:
> 
> 	1. INVLPGB support (or not)
> 	2. TLB_FLUSH_ALL (basically ranged or full flush)
> 
> So I think we should group by *one* of those. The above groups by
> INVLPGB support and this groups by TLB_FLUSH_ALL:
> 
> 	if (info->end == TLB_FLUSH_ALL) {
> 		if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
> 			invlpgb_flush_all();
> 		} else {
> 			on_each_cpu(do_flush_tlb_all, NULL, 1);
> 		}
> 	} else {
> 		if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
>  			for_each(addr)
> 				invlpgb_flush_addr_nosync(addr, nr);
> 	 	else
>  			on_each_cpu(do_kernel_range_flush, info, 1);
> 	}

Yeah an if/else structure is better than using the invlpgb helper and
falling back to IPIs if it returns false, and I also prefer grouping by
the flush scope (range/flush).

Thanks for the illustrations :)

> 
> So, if we create some helpers that give some consistent naming:
> 
> static tlb_flush_all_ipi(...)
> {
> 	on_each_cpu(do_flush_tlb_all, NULL, 1);
> }
> 
> static tlb_flush_all(...)
> {
> 	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
> 		invlpgb_flush_all(...);
> 	else
> 		tlb_flush_all_ipi(...);
> }
> 
> and then also create the ranged equivalents (which internally have the
> same cpu_feature_enabled() check):
> 
> 	tlb_flush_range_ipi(...)
> 	invlpgb_flush_range(...)
> 
> Then we can have the top-level code be:
> 
> 	if (info->end == TLB_FLUSH_ALL)
> 		tlb_flush_all(info);
> 	else
> 		tlb_flush_range(info);
> 
> That actually looks way nicer than what we have today. For bonus points,
> if a third way of flushing the TLB showed up, it would slot right in:
> 
>  static tlb_flush_all(...)
>  {
> 	if (cpu_feature_enabled(X86_FEATURE_INVLPGB))
> 		invlpgb_flush_all(...);
> +	else if cpu_feature_enabled(X86_FEATURE_RAR))
> +		rar_flush_all(...);
> 	else
> 		tlb_flush_all_ipi(...);
>  }
> 
> That's *exactly* the way we want the code to read. At the higher level,
> it's deciding based on the generic thing that *everybody* cares about:
> ranged or full flush. Then, at the lower level, it's deciding how to
> implement that high-level flush concept.
> 

