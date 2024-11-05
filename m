Return-Path: <linux-kernel+bounces-396940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3F9BD4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5051283DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25F1E8822;
	Tue,  5 Nov 2024 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="myKjc3r1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB71E3DF2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831704; cv=none; b=nEDSefxPbdED10+xjHP16heEIrbKRyJEax4owe6yx6es+rt0td6fQVFkOti9xBMgDOIC16luNiAQTJGoqUDy77M5vSL0ZK6THzuV193+QPFaskfChsVjW/vwWjOTL6pu42vvnTaMSi3CMPoO0XbTMSH1QY3cZbAKzfVRPFWwStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831704; c=relaxed/simple;
	bh=WoUMQftjCzIz6/IPy71E8xtMxGzqBsqQeoVHW+jNZxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbbyHwp+fgUI13cpz5K9JLj0D+IO8Xb747JENSqypocCkoyo/6MNeZTDA6145K1X3qHgVbzvCE3urx8o1XbibP4vg+VweZF9SP7WDRccLVIijGaxhOKr/2uyrK1Q5lN5MSn8J6J+EZKeIyC5/dOHxAEFss0TcWQPlHyScIbTxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=myKjc3r1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831702; x=1762367702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WoUMQftjCzIz6/IPy71E8xtMxGzqBsqQeoVHW+jNZxo=;
  b=myKjc3r1es6xGg14sAUBix0BzpNIplNCGPdbVcea1VQuEvLm1UIkB/En
   DxoXf1gxW7kK2Oeehwxy0ABPi0teGgYVkUiVh3QQXn58TXi3P/jzDhQmZ
   AdPgFlRMEJOBcJ3jCRsCnyDrfY8EQ6Bc2yfrnhrwof/0wK41ZAp7v/D4P
   ktTwDkNl1bEdUtBf5JZODnHpIagKkHV4gRKKC/SyhewST+CcOYLOGpZvy
   r5+PZaH6eyBW8LaD3TCAFBBidZj8qGoYe7KkGsJrE0eIKMyhWmGimjJri
   vRTfEnMjWtMU/ZAnLglDVQ9kB9FegS+B3o53AYsCX0oaBqRHSaNaBHd+w
   Q==;
X-CSE-ConnectionGUID: mmCbgydrRIGMCYTd/2Bejg==
X-CSE-MsgGUID: Dt3LvzL7TNSvU9UV9p/5kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30012333"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30012333"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:35:01 -0800
X-CSE-ConnectionGUID: IbaQUyzfSrOuLJeU/UGMQQ==
X-CSE-MsgGUID: x3+bZau4RsWRPmkijZtrJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88623583"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.124.221.212]) ([10.124.221.212])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:35:00 -0800
Message-ID: <702d9dbd-fb7d-44d0-a352-e78adf92254e@intel.com>
Date: Tue, 5 Nov 2024 10:34:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -V3 RESEND] x86, tdx, memory hotplug: Check whole
 hot-adding memory range for TDX
To: Huang Ying <ying.huang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Kai Huang <kai.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>
References: <20241031085151.186111-1-ying.huang@intel.com>
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
In-Reply-To: <20241031085151.186111-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

First and foremost, this touches x86 and core mm code, but it seem to
solidly lean on being an x86 thing.  If anyone thinks this isn't x86
tree material, please speak up.

On 10/31/24 01:51, Huang Ying wrote:
> Therefore, this patch checks the TDX compatibility of the whole

Please zap the "this patch" nomenclature.  It showed up in a couple of
places.  ChatGPT is actually pretty good at this kind of stuff and using
imperative voice.

> hot-adding memory range through a newly added architecture specific
> function (arch_check_hotplug_memory_range()).  If this patch rejects
> the memory hot-adding for TDX compatibility, it will output a kernel
> log message like below,
> 
>   virt/tdx: Reject hot-adding memory range: 0xXXXXXXXX-0xXXXXXXXX for TDX compatibility.

I think this is more clear and much more succinct:

  virt/tdx: Rejecting incompatible memory range: 0xXXXXXXXX-0xXXXXXXXX


> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index eba178996d84..6db5da34e4ba 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -116,11 +116,13 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
>  int tdx_cpu_enable(void);
>  int tdx_enable(void);
>  const char *tdx_dump_mce_info(struct mce *m);
> +int tdx_check_hotplug_memory_range(u64 start, u64 size);
>  #else
>  static inline void tdx_init(void) { }
>  static inline int tdx_cpu_enable(void) { return -ENODEV; }
>  static inline int tdx_enable(void)  { return -ENODEV; }
>  static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
> +static inline int tdx_check_hotplug_memory_range(u64 start, u64 size) { return 0; }
>  #endif	/* CONFIG_INTEL_TDX_HOST */
>  
>  #endif /* !__ASSEMBLY__ */
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ff253648706f..30a4ad4272ce 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -55,6 +55,7 @@
>  #include <asm/uv/uv.h>
>  #include <asm/setup.h>
>  #include <asm/ftrace.h>
> +#include <asm/tdx.h>
>  
>  #include "mm_internal.h"
>  
> @@ -974,6 +975,11 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>  	return ret;
>  }
>  
> +int arch_check_hotplug_memory_range(u64 start, u64 size)
> +{
> +	return tdx_check_hotplug_memory_range(start, size);
> +}
> +
>  int arch_add_memory(int nid, u64 start, u64 size,
>  		    struct mhp_params *params)
>  {
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 4e2b2e2ac9f9..f70b4ebe7cc5 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -1388,36 +1388,37 @@ static bool is_tdx_memory(unsigned long start_pfn, unsigned long end_pfn)
>  	return false;
>  }
>  
> -static int tdx_memory_notifier(struct notifier_block *nb, unsigned long action,
> -			       void *v)
> +/*
> + * We don't allow mixture of TDX and !TDX memory in the buddy so we
> + * won't run into trouble when launching encrypted VMs that really
> + * need TDX-capable memory.
> + */

No "we's" please.

I'd probably explain it like this:

/*
 * By convention, all RAM in the buddy must be TDX compatible whenever
 * TDX is enabled. This avoids having to do extra work later to find
 * TDX compatible memory to run VMs. Enforce that convention and reject
 * attempted hot-adds of any TDX-incompatible ranges.
 *
 * Returns 0 to pass the checks and allow the hot-add
 * Returns -ERRNO to fail the checks and reject the hot-add
 */

> +int tdx_check_hotplug_memory_range(u64 start, u64 size)
>  {
> -	struct memory_notify *mn = v;
> -
> -	if (action != MEM_GOING_ONLINE)
> -		return NOTIFY_OK;
> +	u64 start_pfn = PHYS_PFN(start);
> +	u64 end_pfn = PHYS_PFN(start + size);

Nit:                ^ please vertically align those

>  	/*
>  	 * Empty list means TDX isn't enabled.  Allow any memory
> -	 * to go online.
> +	 * to be hot-added.
>  	 */
>  	if (list_empty(&tdx_memlist))
> -		return NOTIFY_OK;
> +		return 0;

The changelog also needs _some_ discussion of why the locking context is
the same between the old and new uses of this function and why this
doesn't need any locking _here_.

>  	/*
>  	 * The TDX memory configuration is static and can not be
> -	 * changed.  Reject onlining any memory which is outside of
> +	 * changed.  Reject hot-adding any memory which is outside of
>  	 * the static configuration whether it supports TDX or not.
>  	 */
> -	if (is_tdx_memory(mn->start_pfn, mn->start_pfn + mn->nr_pages))
> -		return NOTIFY_OK;
> +	if (is_tdx_memory(start_pfn, end_pfn))
> +		return 0;
>  
> -	return NOTIFY_BAD;
> +	pr_info("Reject hot-adding memory range: %#llx-%#llx for TDX compatibility.\n",
> +		start, start + size);
> +
> +	return -EINVAL;
>  }

