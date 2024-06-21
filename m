Return-Path: <linux-kernel+bounces-225045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A833912B01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4AD1C217C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B873215F40C;
	Fri, 21 Jun 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNh61Zjd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66B757F8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986318; cv=none; b=m238pvYQLMqvL45GB3pV924poA+N2lbvZPL5IuVV3hKjcUgPBbc+Qz25v66GCxQnMhOeX5Wc16B5o4e5zCwbe83UfTX0IeN6xHReDq9SxopcsE9z2ixXZdiBMzVlOpDiLfqNEMnQbNaXtScvFgNGsiQ+t1LSwFjBI53BCJtBmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986318; c=relaxed/simple;
	bh=BUMfaAo/KwHaw6iSwPgLnlv+IyqhQhDWdAdRUyVOJXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL1PwM6ntsdmULjSh+J3w3kkcVUXrMd/sgtJkf7TkfnH8tG6SmqmEnYBbx8plnGA6G0UQQcJhQIIcwPqQ2vY+kZ8dGEhqVuyobUz0vGNUmbR4aR0RVYYN/RtpMmq+laUcSQLdE5t2zwnkwRHcvvgrkjbryHVYH1pBWBlSCeEEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNh61Zjd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718986317; x=1750522317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BUMfaAo/KwHaw6iSwPgLnlv+IyqhQhDWdAdRUyVOJXc=;
  b=FNh61Zjdy08giRwY1Z47p92TMgSM+HECkg5bv7WDzzV7kHXsYe5oAEBG
   nE1I5fwvW943SlqY/+pL6sg6RJfjXWAPUaIhSaUY5nlEgk8uCH/8xrKOx
   oohsO/zZQQ/qkYVbu9BoG+vkMKlNKbd/1xRiJhUD8s8r4USksTVuXFnte
   7nVpvSCj2IkSklgxx68rLiJ/QDlGXKOW9TTJqzbkVsm9aHIJHeQW2/cI6
   iQfK2+M5u2Ja/P0IVg+otfdQtLFVV+4Aw4xuogVtMV2QZGs2i0cpcR6EW
   eSEHk7C7fPkhn0i4yEUgiYRGq1dLKxYtmP/P0aSCyESMEXtA9B1s1Y+hX
   g==;
X-CSE-ConnectionGUID: W57KAt20SnWttUeXlaSI/Q==
X-CSE-MsgGUID: B+1z5/lESgyBRRR3hMn5kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19840020"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="19840020"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:11:56 -0700
X-CSE-ConnectionGUID: Vq656qevQCOneX+OEz/oVw==
X-CSE-MsgGUID: xTH7aQt2SYGS+mPlibylGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42598166"
Received: from bmurrell-mobl.amr.corp.intel.com (HELO [10.124.221.70]) ([10.124.221.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:11:56 -0700
Message-ID: <5daa82f5-b5ea-42d7-a074-122734ad99db@intel.com>
Date: Fri, 21 Jun 2024 09:11:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] mm/x86: Add missing pud helpers
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dave Jiang <dave.jiang@intel.com>,
 "Kirill A . Shutemov" <kirill@shutemov.name>, Ingo Molnar
 <mingo@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Dan Williams <dan.j.williams@intel.com>,
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
 <4fb4b087-cae2-4516-a34e-cb4c72be13eb@intel.com> <ZnWgG7WmZWS-xWJU@x1n>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <ZnWgG7WmZWS-xWJU@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 08:45, Peter Xu wrote:
> On Fri, Jun 21, 2024 at 07:51:26AM -0700, Dave Hansen wrote:
...
>> But, still, what if you take a Dirty=1,Write=1 pud and pud_modify() it
>> to make it Dirty=1,Write=0?  What prevents that from being
>> misinterpreted by the hardware as being a valid 1G shadow stack mapping?
> 
> Thanks for pointing that out.  I think I was thinking it will only take
> effect on VM_SHADOW_STACK first, so it's not?
> 
> I was indeed trying to find more information on shadow stack at that time
> but I can't find as much on the pgtable implications, on e.g. whether "D=1
> + W=0" globally will be recognized as shadow stack.  At least on SDM March
> 2024 version Vol3 Chap4 pgtable entries still don't explain these details,
> or maybe I missed it.  Please let me know if there's suggestion on what I
> can read before I post a v2.

It's in the "Determination of Access Rights" section.

	A linear address is a shadow-stack address if the following are
	true of the translation of the linear address: (1) the R/W flag
	(bit 1) is 0 and the dirty flag (bit 6) is 1 in the paging-
	structure entry that maps the page containing the linear
	address; and (2) the R/W flag is 1 in every other paging-
	structure entry controlling the translation of the linear
	address.

> So if it's globally taking effect, indeed we'll need to handle them in PUDs
> too.
> 
> Asides, not sure whether it's off-topic to ask here, but... why shadow
> stack doesn't reuse an old soft-bit to explicitly mark "this is shadow
> stack ptes" when designing the spec?  Now it consumed bit 58 anyway for
> caching dirty. IIUC we can avoid all these "move back and forth" issue on
> dirty bit if so.

The design accommodates "other" OSes that are using all the software
bits for other things.

For Linux, you're right, we just ended up consuming a software bit
_anyway_ so we got all the complexity of the goofy permissions *AND*
lost a bit in the end.  Lose, lose.

>>>  /*
>>>   * mprotect needs to preserve PAT and encryption bits when updating
>>>   * vm_page_prot
>>> @@ -1377,10 +1398,25 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>>  }
>>>  #endif
>>>  
>>> +static inline pud_t pudp_establish(struct vm_area_struct *vma,
>>> +		unsigned long address, pud_t *pudp, pud_t pud)
>>> +{
>>> +	if (IS_ENABLED(CONFIG_SMP)) {
>>> +		return xchg(pudp, pud);
>>> +	} else {
>>> +		pud_t old = *pudp;
>>> +		WRITE_ONCE(*pudp, pud);
>>> +		return old;
>>> +	}
>>> +}
>>
>> Why is there no:
>>
>> 	page_table_check_pud_set(vma->vm_mm, pudp, pud);
>>
>> ?  Sure, it doesn't _do_ anything today.  But the PMD code has it today.
>>  So leaving it out creates a divergence that honestly can only serve to
>> bite us in the future and will create a head-scratching delta for anyone
>> that is comparing PUD and PMD implementations in the future.
> 
> Good question, I really don't remember why I didn't have that, since I
> should have referenced the pmd helper.  I'll add them and see whether I'll
> hit something otherwise.
> 
> Thanks for the review.

One big thing I did in this review was make sure that the PMD and PUD
helpers were doing the same thing.  Would you mind circling back and
double-checking the same before you repost this?


