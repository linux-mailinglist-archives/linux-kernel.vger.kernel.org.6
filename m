Return-Path: <linux-kernel+bounces-542784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8681A4CDA5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E643A7702
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A7D1E5213;
	Mon,  3 Mar 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEQnq/VE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75678F3A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038457; cv=none; b=oMTdLauFWdJ4aU7aWJSKAZ2L1+oRkejy2lNDUvfaV+spZZU1kxwOoV8vP9ES9otQRXAbNniOMtP20WCjXHnI6dVIE33IoxuyOf5g7uT9N/I8/ItVzDa3Ehlp/dF6EPfUxjWz0wzFjXh8grzOP3yFDVnnUCrJgsGH0VnKr9HHT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038457; c=relaxed/simple;
	bh=pdRb9ZVXZGgjh88qCAHf+WPRbw8sSAg/7v68Q0Qw674=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=oaSC0VFKUqifEvQJKICKMMnWTtktQUSfLVgv4FTqKarLTCuDtRSvoJH9R2+E/JFWTenwM/goj7JKOrE9pWpdoezDjXg3r3NjYAX80WmfzMXGDkKxoWhdUK5j8MwblrGI9B3OyHpHALuX+cI77EnypocYzuy6aqTLhu4EPC8yADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEQnq/VE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741038454; x=1772574454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=pdRb9ZVXZGgjh88qCAHf+WPRbw8sSAg/7v68Q0Qw674=;
  b=fEQnq/VE3cVdJ/2LUR8TdpvNISZK05CbsirO/8e1Luz94qzKhSLbZ7zx
   0TKEo5w6HNFNxMb46GcBNoSYlVG4WN+r6DU5fVPn1suM+klIoU/Xgpanz
   i5Ft9MlEwcrgTGSUQB8jFphYGgxzTPM4N6bt8Llb7mSq56E1NKL4HIE8+
   wxhb72nlEnzgyzwKLgNlkP/o3suHJsRmq1WK2dvVyLLNOQ9ZSxd2YSb/Z
   nTXO9oJzvoOgLjy4vor8dd+DZfRR9rxnNN2atMjRM5kaMCbwJNCNMlEAG
   dS45uW5RKwMhVEqADBbGR+/AQ0rKi89PrOFS/8KWbCkmgHKP7CQIpFgtK
   g==;
X-CSE-ConnectionGUID: utsM8u/0S8W7qj6MaFP6BQ==
X-CSE-MsgGUID: WpzsakEnSBiI1Yg00vm6kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="29521125"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="29521125"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:47:25 -0800
X-CSE-ConnectionGUID: jvcTaXYSQVKMVU33Z2A5kQ==
X-CSE-MsgGUID: gTqbFCGjQpOseOLkKatpxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="122791960"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.109.13]) ([10.125.109.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:47:24 -0800
Content-Type: multipart/mixed; boundary="------------K9TSp6d7qYPhPlUmDQJurxbc"
Message-ID: <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>
Date: Mon, 3 Mar 2025 13:47:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
To: Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
 <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
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
In-Reply-To: <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>

This is a multi-part message in MIME format.
--------------K9TSp6d7qYPhPlUmDQJurxbc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/25 03:46, Borislav Petkov wrote:
> On Tue, Feb 25, 2025 at 10:00:46PM -0500, Rik van Riel wrote:
>> +static inline bool cpu_need_tlbsync(void)
>> +{
>> +	return this_cpu_read(cpu_tlbstate.need_tlbsync);
>> +}
>> +
>> +static inline void cpu_write_tlbsync(bool state)
> 
> That thing feels better like "cpu_set_tlbsync" in the code...
> 
>> +{
>> +	this_cpu_write(cpu_tlbstate.need_tlbsync, state);
>> +}
>>  #else
>>  static inline u16 mm_global_asid(struct mm_struct *mm)
>>  {
> 
> ...
> 
>> +static inline void tlbsync(void)
>> +{
>> +	if (!cpu_need_tlbsync())
>> +		return;
>> +	__tlbsync();
>> +	cpu_write_tlbsync(false);
>> +}
> 
> Easier to parse visually:
> 
> static inline void tlbsync(void)
> {
>         if (cpu_need_tlbsync()) {
>                 __tlbsync();
>                 cpu_write_tlbsync(false);
>         }
> }
> 
> Final:
> 
> From: Rik van Riel <riel@surriel.com>
> Date: Tue, 25 Feb 2025 22:00:46 -0500
> Subject: [PATCH] x86/mm: Do targeted broadcast flushing from tlbbatch code
> 
> Instead of doing a system-wide TLB flush from arch_tlbbatch_flush(), queue up
> asynchronous, targeted flushes from arch_tlbbatch_add_pending().
> 
> This also allows to avoid adding the CPUs of processes using broadcast
> flushing to the batch->cpumask, and will hopefully further reduce TLB flushing
> from the reclaim and compaction paths.
> 
>   [ bp:
>    - Massage
>    - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi ]
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20250226030129.530345-12-riel@surriel.com
> ---
>  arch/x86/include/asm/tlb.h      | 12 ++---
>  arch/x86/include/asm/tlbflush.h | 27 +++++++----
>  arch/x86/mm/tlb.c               | 79 +++++++++++++++++++++++++++++++--
>  3 files changed, 100 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index 04f2c6f4cee3..b5c2005725cf 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h
> @@ -102,16 +102,16 @@ static inline void __tlbsync(void) { }
>  #define INVLPGB_FINAL_ONLY		BIT(4)
>  #define INVLPGB_INCLUDE_NESTED		BIT(5)
>  
> -static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
> -						unsigned long addr,
> -						u16 nr,
> -						bool pmd_stride)
> +static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
> +						  unsigned long addr,
> +						  u16 nr,
> +						  bool pmd_stride)
>  {
>  	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
>  }
>  
>  /* Flush all mappings for a given PCID, not including globals. */
> -static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
> +static inline void __invlpgb_flush_single_pcid_nosync(unsigned long pcid)
>  {
>  	__invlpgb(0, pcid, 0, 1, 0, INVLPGB_PCID);
>  }
> @@ -131,7 +131,7 @@ static inline void invlpgb_flush_all(void)
>  }
>  
>  /* Flush addr, including globals, for all PCIDs. */
> -static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
> +static inline void __invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
>  {
>  	__invlpgb(0, 0, addr, nr, 0, INVLPGB_INCLUDE_GLOBAL);
>  }
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 8c21030269ff..cbdb86d58301 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -105,6 +105,9 @@ struct tlb_state {
>  	 * need to be invalidated.
>  	 */
>  	bool invalidate_other;
> +#ifdef CONFIG_BROADCAST_TLB_FLUSH
> +	bool need_tlbsync;
> +#endif
>  
>  #ifdef CONFIG_ADDRESS_MASKING
>  	/*
> @@ -292,11 +295,23 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm)
>  
>  	return mm && READ_ONCE(mm->context.asid_transition);
>  }
> +
> +static inline bool cpu_need_tlbsync(void)
> +{
> +	return this_cpu_read(cpu_tlbstate.need_tlbsync);
> +}
> +
> +static inline void cpu_set_tlbsync(bool state)
> +{
> +	this_cpu_write(cpu_tlbstate.need_tlbsync, state);
> +}
>  #else
>  static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
>  static inline void mm_init_global_asid(struct mm_struct *mm) { }
>  static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
>  static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
> +static inline bool cpu_need_tlbsync(void) { return false; }
> +static inline void cpu_set_tlbsync(bool state) { }
>  #endif /* CONFIG_BROADCAST_TLB_FLUSH */
>  
>  #ifdef CONFIG_PARAVIRT
> @@ -346,21 +361,15 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>  	return atomic64_inc_return(&mm->context.tlb_gen);
>  }
>  
> -static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> -					     struct mm_struct *mm,
> -					     unsigned long uaddr)
> -{
> -	inc_mm_tlb_gen(mm);
> -	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> -	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
> -}
> -
>  static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
>  {
>  	flush_tlb_mm(mm);
>  }
>  
>  extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> +extern void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +					     struct mm_struct *mm,
> +					     unsigned long uaddr);
>  
>  static inline bool pte_flags_need_flush(unsigned long oldflags,
>  					unsigned long newflags,
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 0efd99053c09..83ba6876adbf 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -492,6 +492,37 @@ static void finish_asid_transition(struct flush_tlb_info *info)
>  	mm_clear_asid_transition(mm);
>  }
>  
> +static inline void tlbsync(void)
> +{
> +	if (cpu_need_tlbsync()) {
> +		__tlbsync();
> +		cpu_set_tlbsync(false);
> +	}
> +}
> +
> +static inline void invlpgb_flush_user_nr_nosync(unsigned long pcid,
> +						unsigned long addr,
> +						u16 nr, bool pmd_stride)
> +{
> +	__invlpgb_flush_user_nr_nosync(pcid, addr, nr, pmd_stride);
> +	if (!cpu_need_tlbsync())
> +		cpu_set_tlbsync(true);
> +}
> +
> +static inline void invlpgb_flush_single_pcid_nosync(unsigned long pcid)
> +{
> +	__invlpgb_flush_single_pcid_nosync(pcid);
> +	if (!cpu_need_tlbsync())
> +		cpu_set_tlbsync(true);
> +}
> +
> +static inline void invlpgb_flush_addr_nosync(unsigned long addr, u16 nr)
> +{
> +	__invlpgb_flush_addr_nosync(addr, nr);
> +	if (!cpu_need_tlbsync())
> +		cpu_set_tlbsync(true);
> +}

One thought on these:

Instead of having three functions:

	1. A raw __invlpgb_*_nosync()
	2. A wrapper invlpgb_*_nosync() that flips cpu_set_tlbsync()
	3. A wrapper invlpgb_*()

Could we get away with just two?  For instance, what if we had *ALL*
__invlpgb()'s do cpu_set_tlbsync()? Then we'd universally call tlbsync().

static inline void invlpgb_flush_all_nonglobals(void)
{
        guard(preempt)();
        __invlpgb(0, 0, 0, 1, NO_STRIDE, INVLPGB_MODE_ALL_NONGLOBALS);
        tlbsync();
}

Then we wouldn't need any of those three new wrappers. The only downside
is that we'd end up with paths that logically do:

	__invlpgb()
	cpu_set_tlbsync(true);
	if (cpu_need_tlbsync()) { // always true
		__tlbsync();
		cpu_set_tlbsync(true);
	}

In other words, a possibly superfluous set/check/clear of the
"need_tlbsync" state. But I'd expect that to be a pittance compared to
the actual cost of INVLPGB/TLBSYNC.

>  static void broadcast_tlb_flush(struct flush_tlb_info *info)
>  {
>  	bool pmd = info->stride_shift == PMD_SHIFT;
> @@ -790,6 +821,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
>  	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
>  		WARN_ON_ONCE(!irqs_disabled());
>  
> +	tlbsync();

This one is in dire need of comments.

>  	/*
>  	 * Verify that CR3 is what we think it is.  This will catch
>  	 * hypothetical buggy code that directly switches to swapper_pg_dir
> @@ -966,6 +999,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
>   */
>  void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>  {
> +	tlbsync();

Ditto, *especially* if this hits the init_mm state. There really
shouldn't be any deferred flushes for the init_mm.

>  	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
>  		return;
>  
> @@ -1633,9 +1668,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  	 * a local TLB flush is needed. Optimize this use-case by calling
>  	 * flush_tlb_func_local() directly in this case.
>  	 */
> -	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
> -		invlpgb_flush_all_nonglobals();
> -	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
> +	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
>  		flush_tlb_multi(&batch->cpumask, info);
>  	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
>  		lockdep_assert_irqs_enabled();
> @@ -1644,12 +1677,52 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>  		local_irq_enable();
>  	}
>  
> +	/*
> +	 * If (asynchronous) INVLPGB flushes were issued, wait for them here.
> +	 * The cpumask above contains only CPUs that were running tasks
> +	 * not using broadcast TLB flushing.
> +	 */
> +	tlbsync();

I have a suggested comment in the attached fixups. This makes it sound
like tasks are either INVLPGB *or* in ->cpumask. Transitioning mms can
be both, I think.

>  	cpumask_clear(&batch->cpumask);
>  
>  	put_flush_tlb_info();
>  	put_cpu();
>  }
>  
> +void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +					     struct mm_struct *mm,
> +					     unsigned long uaddr)
> +{
> +	u16 asid = mm_global_asid(mm);
> +
> +	if (asid) {
> +		invlpgb_flush_user_nr_nosync(kern_pcid(asid), uaddr, 1, false);
> +		/* Do any CPUs supporting INVLPGB need PTI? */
> +		if (cpu_feature_enabled(X86_FEATURE_PTI))
> +			invlpgb_flush_user_nr_nosync(user_pcid(asid), uaddr, 1, false);
> +
> +		/*
> +		 * Some CPUs might still be using a local ASID for this
> +		 * process, and require IPIs, while others are using the
> +		 * global ASID.
> +		 *
> +		 * In this corner case, both broadcast TLB invalidation
> +		 * and IPIs need to be sent. The IPIs will help
> +		 * stragglers transition to the broadcast ASID.
> +		 */
> +		if (mm_in_asid_transition(mm))
> +			asid = 0;
> +	}
> +
> +	if (!asid) {
> +		inc_mm_tlb_gen(mm);
> +		cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> +	}
> +
> +	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
> +}

I stuck some better comments in the patch. I think this should both
mention that a later tlbsync() is required and *also* match teh two
cases better.

Also, the "if (asid)" isn't super nice naming. Let's please call it
"global_asid" because it's either a global ASID or 0.

--------------K9TSp6d7qYPhPlUmDQJurxbc
Content-Type: text/x-patch; charset=UTF-8; name="tlbbatch.patch"
Content-Disposition: attachment; filename="tlbbatch.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3RsYi5jIGIvYXJjaC94ODYvbW0vdGxiLmMKaW5k
ZXggOGU1OTZkZTk2M2E4Zi4uOGUxYWM4YmUxMjNiMiAxMDA2NDQKLS0tIGEvYXJjaC94ODYv
bW0vdGxiLmMKKysrIGIvYXJjaC94ODYvbW0vdGxiLmMKQEAgLTgyMSw2ICs4MjEsOSBAQCB2
b2lkIHN3aXRjaF9tbV9pcnFzX29mZihzdHJ1Y3QgbW1fc3RydWN0ICp1bnVzZWQsIHN0cnVj
dCBtbV9zdHJ1Y3QgKm5leHQsCiAJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BST1ZFX0xPQ0tJ
TkcpKQogCQlXQVJOX09OX09OQ0UoIWlycXNfZGlzYWJsZWQoKSk7CiAKKwkvLyBGSVhNRQor
CS8vIFRoaXMgaXMgdG90YWxseSB1bmV4cGxhaW5lZCBhbmQgbmVlZHMganVzdGlmaWNhdGlv
biBhbmQKKwkvLyBjb21tZW50aW5nCiAJdGxic3luYygpOwogCiAJLyoKQEAgLTE2NzgsOSAr
MTY4MSwxMCBAQCB2b2lkIGFyY2hfdGxiYmF0Y2hfZmx1c2goc3RydWN0IGFyY2hfdGxiZmx1
c2hfdW5tYXBfYmF0Y2ggKmJhdGNoKQogCX0KIAogCS8qCi0JICogSWYgKGFzeW5jaHJvbm91
cykgSU5WTFBHQiBmbHVzaGVzIHdlcmUgaXNzdWVkLCB3YWl0IGZvciB0aGVtIGhlcmUuCi0J
ICogVGhlIGNwdW1hc2sgYWJvdmUgY29udGFpbnMgb25seSBDUFVzIHRoYXQgd2VyZSBydW5u
aW5nIHRhc2tzCi0JICogbm90IHVzaW5nIGJyb2FkY2FzdCBUTEIgZmx1c2hpbmcuCisJICog
V2FpdCBmb3Igb3V0c3RhbmRpbmcgSU5WTFBHQiBmbHVzaGVzLiBiYXRjaC0+Y3B1bWFzayB3
aWxsCisJICogYmUgZW1wdHkgd2hlbiB0aGUgYmF0Y2ggd2FzIGhhbmRsZWQgY29tcGxldGVs
eSBieSBJTlZMUEdCLgorCSAqIE5vdGUgdGhhdCBtbV9pbl9hc2lkX3RyYW5zaXRpb24oKSBt
bSdzIG1heSB1c2UgSU5WTFBHQiBhbmQKKwkgKiB0aGUgZmx1c2hfdGxiX211bHRpKCkgSVBJ
cyBhdCB0aGUgc2FtZSB0aW1lLgogCSAqLwogCXRsYnN5bmMoKTsKIApAQCAtMTY5Myw5ICsx
Njk3LDE0IEBAIHZvaWQgYXJjaF90bGJiYXRjaF9mbHVzaChzdHJ1Y3QgYXJjaF90bGJmbHVz
aF91bm1hcF9iYXRjaCAqYmF0Y2gpCiB2b2lkIGFyY2hfdGxiYmF0Y2hfYWRkX3BlbmRpbmco
c3RydWN0IGFyY2hfdGxiZmx1c2hfdW5tYXBfYmF0Y2ggKmJhdGNoLAogCQkJICAgICAgIHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIHVhZGRyKQogewotCXUxNiBhc2lk
ID0gbW1fZ2xvYmFsX2FzaWQobW0pOworCXUxNiBnbG9iYWxfYXNpZCA9IG1tX2dsb2JhbF9h
c2lkKG1tKTsKIAotCWlmIChhc2lkKSB7CisJaWYgKGdsb2JhbF9hc2lkKSB7CisJCS8qCisJ
CSAqIEdsb2JhbCBBU0lEcyBjYW4gYmUgZmx1c2hlZCB3aXRoIElOVkxQR0IuIEZsdXNoCisJ
CSAqIG5vdyBpbnN0ZWFkIG9mIGJhdGNoaW5nIHRoZW0gZm9yIGxhdGVyLiBBIGxhdGVyCisJ
CSAqIHRsYnN5bmMoKSBpcyByZXF1aXJlZCB0byBlbnN1cmUgdGhlc2UgY29tcGxldGVkLgor
CQkgKi8KIAkJaW52bHBnYl9mbHVzaF91c2VyX25yX25vc3luYyhrZXJuX3BjaWQoYXNpZCks
IHVhZGRyLCAxLCBmYWxzZSk7CiAJCS8qIERvIGFueSBDUFVzIHN1cHBvcnRpbmcgSU5WTFBH
QiBuZWVkIFBUST8gKi8KIAkJaWYgKGNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVf
UFRJKSkKQEAgLTE3MTQsNyArMTcyMywxMSBAQCB2b2lkIGFyY2hfdGxiYmF0Y2hfYWRkX3Bl
bmRpbmcoc3RydWN0IGFyY2hfdGxiZmx1c2hfdW5tYXBfYmF0Y2ggKmJhdGNoLAogCQkJYXNp
ZCA9IDA7CiAJfQogCi0JaWYgKCFhc2lkKSB7CisJaWYgKCFnbG9iYWxfYXNpZCkgeworCQkv
KgorCQkgKiBNYXJrIHRoZSBtbSBhbmQgdGhlIENQVSBzbyB0aGF0CisJCSAqIHRoZSBUTEIg
Z2V0cyBmbHVzaGVkIGxhdGVyLgorCQkgKi8KIAkJaW5jX21tX3RsYl9nZW4obW0pOwogCQlj
cHVtYXNrX29yKCZiYXRjaC0+Y3B1bWFzaywgJmJhdGNoLT5jcHVtYXNrLCBtbV9jcHVtYXNr
KG1tKSk7CiAJfQo=

--------------K9TSp6d7qYPhPlUmDQJurxbc--

