Return-Path: <linux-kernel+bounces-544680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A0A4E3E7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348531726D3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5979284B31;
	Tue,  4 Mar 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuAPY9hh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB02836AE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101876; cv=none; b=RMn5Q1ERoPT9tyBoBlKCM1Ewbi9cw76PsShA2/N7lEVorgZN//swrRe2YEzH29Y7vjEm6If6pg215xNFZwSVcy74NZTawz6Ot9voB+owZpentEtoxUxfFYY/xkT2BEuGqMGoBUpNA7U9XglezZtrarJLnfSVX8PbJynbjY09j2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101876; c=relaxed/simple;
	bh=EVE+06mxpmAtoUS5j5VcPkSNPsMn6GA7lVmP7UBqXI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TwE008dY76jRyyIP83LEOP/mUYQK9MK/yN2b84MyyEBmLNOqSfmTNuHIR4Siyc3E7bM5otT9zQ1uLFo1dIgLHSG2T7gs8o5Ie4hvbCcI4AUZREfym11GfZ/T4oGp7PMlbr8WG+GeBaNJzL0cn787Oc/pM80w1+BUIGYUhy2g+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuAPY9hh; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741101875; x=1772637875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EVE+06mxpmAtoUS5j5VcPkSNPsMn6GA7lVmP7UBqXI0=;
  b=BuAPY9hhfAPOEQ8M97/x+AM55t7Lw757YzxDUI+IQbX/bxhGo5WbYp4G
   jf5Ups/7rpyeyV7EnGl8OKx3Tj9pL9xlImE02MA2OXlvCvDEA414dD66q
   G0u0PO3vZVV1zkSWVICU78sGifZnUISxqk4nnEikrfTt8qYT6l+1qNVsD
   QtPGPIWPg0CMK9lJ77/86ZuFeVBnXn+xZ2w20xjXjxxW9hVbQqQMCSwdQ
   a8+JKtGrQls4RK1JuSJEXoXA+rB8vIt+fED1ho3pUPUKuRB6VthWbF5Wp
   +XXSTv3W4fuVhPEX8/KINF8tXwL0OHq/Djqh60zvJRmxv58ec9CLgpP0r
   w==;
X-CSE-ConnectionGUID: aY8svbsLRA2D/5IMKA8XyA==
X-CSE-MsgGUID: WrFCTmKyTgu7nl6pDiPR5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41273573"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41273573"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:24:34 -0800
X-CSE-ConnectionGUID: mdKDqChQTJqGu5Eny0WrvA==
X-CSE-MsgGUID: adTTfgKcQEaR1dxZeWjN9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="123527461"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.109.94]) ([10.125.109.94])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:24:33 -0800
Message-ID: <c0a8f6c0-463d-46a0-849f-25f433c81aeb@intel.com>
Date: Tue, 4 Mar 2025 07:24:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
To: Borislav Petkov <bp@alien8.de>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
 <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
 <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>
 <20250304115207.GFZ8bpZ83u7L9x43Rq@fat_crate.local>
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
In-Reply-To: <20250304115207.GFZ8bpZ83u7L9x43Rq@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 03:52, Borislav Petkov wrote:
> On Mon, Mar 03, 2025 at 01:47:42PM -0800, Dave Hansen wrote:
...
> IOW, this:
> 
> /* Flush all mappings for a given PCID, not including globals. */
> static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
> {
>         __invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
>         cpu_set_tlbsync(true);
> }
> 
> Right?

Yep, that works.

Optimizing out the writes like the old code did is certainly a good
thought. But I suspect the cacheline is hot the majority of the time.

>>>  static void broadcast_tlb_flush(struct flush_tlb_info *info)
>>>  {
>>>  	bool pmd = info->stride_shift == PMD_SHIFT;
>>> @@ -790,6 +821,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
>>>  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
>>>  		WARN_ON_ONCE(!irqs_disabled());
>>>  
>>> +	tlbsync();
>>
>> This one is in dire need of comments.
> 
> Maybe this:
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 08672350536f..b97249ffff1f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -822,6 +822,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
>         if (IS_ENABLED(CONFIG_PROVE_LOCKING))
>                 WARN_ON_ONCE(!irqs_disabled());
>  
> +       /*
> +        * Finish any remote TLB flushes pending from this CPU:
> +        */
>         tlbsync();

That's a prototypical "what" comment and not "why", though. It makes a
lot of sense that any flushes that the old task did should complete
before a new gets activated. But I honestly can't think of a _specific_
problem that it causes.

I don't doubt that this does _some_ good, but I just don't know what
good it does. ;)


