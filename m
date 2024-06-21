Return-Path: <linux-kernel+bounces-224906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2591287E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF771F29FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067BB328DB;
	Fri, 21 Jun 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM8KWOUz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A62374FF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981490; cv=none; b=SgO3ICRODJY/sgLFhLflOpwYxYpeAb5Za0+A1CMk0Qusa4Q9J1Vb0L7rFrHLfEMD/VhS9MNH+QwzKV0ymtTutL9IO+TXKP4RmaBdPVyVEvbCKMD1lnDxMMwp9XXSmWYorY3DH+Dg+bP3GYuSMqxpagER/mwLcDAqOp6KV7F7ID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981490; c=relaxed/simple;
	bh=YRtouFPaW9U4NGyXBKaaDVSlzBvVKpAVa50I1FhWngU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlsQM6lCYAI5cTmX03K0jY5iFOWXOByPlyQ7Hr07RQbJH8kxYpRJ3YjhntxJmMLE3fBPh/kcV0jG+UqwcWyRZkCLzJn2QSyXy47pP+RXONnjfd6o8InppM7K8Qwg7CwSg/4evUCYNmkJ2L7SDZ8nI51r54A2D0OcJ68Aq+Z3PzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM8KWOUz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718981488; x=1750517488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YRtouFPaW9U4NGyXBKaaDVSlzBvVKpAVa50I1FhWngU=;
  b=fM8KWOUz3Y22LvKOdcwmuENiC9Z3M1NU1x1Q3wki3knt4XiPsmABMZyt
   96+aZi84pGuzd4Gp/MeqV3OBrc/7Ke0gyZu6CyyxuyTprfM+kjAkeRu7B
   s/lzGOa/V8DQnw+OiHMw+q2eJtg3qGVF8u5zPNGjD+rqjFGdW2x75IUU3
   OVYKmv4tqwvuqcCVy+uV586n8yxLI3R1TNmGqCw/FrCdEMgkDz1O9IJa2
   j7i+TQ3orr2HMzAddj2kA278WB4DAqj0CNflcnirbtonY4r3wpjISyuw4
   oWPFkXAptOGmdE6dNdVvMj9fAe7A3V/Om9FA3fbT/lDDU1gXYrEFNL9JB
   Q==;
X-CSE-ConnectionGUID: TSBvV/zuRL+KumS0em/v+Q==
X-CSE-MsgGUID: HSPkYuP6TkmWt8FhF7za/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="15992028"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="15992028"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 07:51:27 -0700
X-CSE-ConnectionGUID: 9SR3JPeSS4SAMcyi1qiFXA==
X-CSE-MsgGUID: QbFqJJkySc6MGHPzAp0EjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="47798662"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.124.221.70]) ([10.124.221.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 07:51:26 -0700
Message-ID: <4fb4b087-cae2-4516-a34e-cb4c72be13eb@intel.com>
Date: Fri, 21 Jun 2024 07:51:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mm/x86: Add missing pud helpers
To: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
 Dave Jiang <dave.jiang@intel.com>, "Kirill A . Shutemov"
 <kirill@shutemov.name>, Ingo Molnar <mingo@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Vlastimil Babka <vbabka@suse.cz>, Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Rik van Riel <riel@surriel.com>, Mel Gorman <mgorman@techsingularity.net>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20240621142504.1940209-1-peterx@redhat.com>
 <20240621142504.1940209-7-peterx@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240621142504.1940209-7-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 07:25, Peter Xu wrote:
> These new helpers will be needed for pud entry updates soon.  Namely:
> 
> - pudp_invalidate()
> - pud_modify()

I think it's also definitely worth noting where you got this code from.
Presumably you copied, pasted and modified the PMD code.  That's fine,
but it should be called out.

...
> +static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
> +{
> +	pudval_t val = pud_val(pud), oldval = val;
> +
> +	/*
> +	 * NOTE: no need to consider shadow stack complexities because it
> +	 * doesn't support 1G mappings.
> +	 */
> +	val &= _HPAGE_CHG_MASK;
> +	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
> +	val = flip_protnone_guard(oldval, val, PHYSICAL_PUD_PAGE_MASK);
> +
> +	return __pud(val);
> +}

First of all, the comment to explain what you didn't do here is as many
lines as the code to _actually_ implement it.

Second, I believe this might have missed the purpose of the "shadow
stack complexities".  The pmd/pte code is there not to support modifying
shadow stack mappings, it's there to avoid inadvertent shadow stack
mapping creation.

That "NOTE:" is ambiguous as to whether the shadow stacks aren't
supported on 1G mappings in Linux or the hardware (I just checked the
hardware docs and don't see anything making 1G mappings special, btw).

But, still, what if you take a Dirty=1,Write=1 pud and pud_modify() it
to make it Dirty=1,Write=0?  What prevents that from being
misinterpreted by the hardware as being a valid 1G shadow stack mapping?

>  /*
>   * mprotect needs to preserve PAT and encryption bits when updating
>   * vm_page_prot
> @@ -1377,10 +1398,25 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +static inline pud_t pudp_establish(struct vm_area_struct *vma,
> +		unsigned long address, pud_t *pudp, pud_t pud)
> +{
> +	if (IS_ENABLED(CONFIG_SMP)) {
> +		return xchg(pudp, pud);
> +	} else {
> +		pud_t old = *pudp;
> +		WRITE_ONCE(*pudp, pud);
> +		return old;
> +	}
> +}

Why is there no:

	page_table_check_pud_set(vma->vm_mm, pudp, pud);

?  Sure, it doesn't _do_ anything today.  But the PMD code has it today.
 So leaving it out creates a divergence that honestly can only serve to
bite us in the future and will create a head-scratching delta for anyone
that is comparing PUD and PMD implementations in the future.

