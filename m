Return-Path: <linux-kernel+bounces-509939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FDEA31651
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227F63A2CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B6262D3D;
	Tue, 11 Feb 2025 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV4Cnzcg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1F264F8E;
	Tue, 11 Feb 2025 19:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303962; cv=none; b=BsZqYnhB+CZPHgm0lEl61BJatV72hMlU/U/+wyrkN2a4ecEzZRZ/1HdKH6wxAey1wzaOoSRYHFzR8LryFL+3tyalj/+zl6qEEMDEyOSSJZ9J/QpSwBdrQuTwpkN21tHDQrwkME/HmmiDNh4/pRlm/FXTd0j2owXyNK7ybdFrDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303962; c=relaxed/simple;
	bh=EZK5iCn0AJDuDPnbI9PCvoAule1opEGrI+Q176VJ/nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFvSWWvy2QV4ZQiV4yjpgGddDQTlVfluCrMXBC32ctnn+MUhlkY3i/F+D9VrjLk4p2qdl3k6O35iyKsi/BBVaavmddkvJ1+GdkMLi+ZmV5zDNYn93hc3Yk61rsCeJEn4lPXpKg3VLrY4Q2foupud+vPTpfCHPJdtCSia2ho11DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV4Cnzcg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303961; x=1770839961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EZK5iCn0AJDuDPnbI9PCvoAule1opEGrI+Q176VJ/nQ=;
  b=kV4CnzcgUFAcP3AvQwN+GDEg4/N7GIaKF9NwOU+iqynHMzph4pLQdgwj
   /QLufWQ5CQAPM0Km/JfDtTtEpGVCjcxmphrId2WceJj2VzQmLSBVHbcHM
   xWxSL2tStmeACLKvq0yogUxnIpe2n/QNbG5oOzaKKhidnj1GWM7bsVXMc
   BbUISaIEtC++PITl128hD1TZdhuiakP+G1uDTyeV7/vtHrphtJ933cj2X
   AMo3HxG5zSvXyZyd0PlGbfIORgNm0X3TPbPAZPeLXUYSTIHB5MdeXjXfC
   /UE+275vUiw7hiBb/5e401fdoJHMelQmg9cHkQRjfIVRv7RM9cwXHyBbC
   g==;
X-CSE-ConnectionGUID: 3vtdIgeIRfSNV4WLn7tfng==
X-CSE-MsgGUID: PChojoqoSjeoc03CMaXWQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="42786424"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="42786424"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:59:20 -0800
X-CSE-ConnectionGUID: O9AWFUy3RJO+9tb/yFTjLQ==
X-CSE-MsgGUID: wP1KLtz+QiSuzJuh+2GpBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112826024"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.48]) ([10.125.108.48])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:59:16 -0800
Message-ID: <3d750b58-d911-4f24-93e4-b84213849071@intel.com>
Date: Tue, 11 Feb 2025 11:59:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] x86: Physical address comparisons in fill_p*d/pte
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc: luto@kernel.org, xin@zytor.com, kirill.shutemov@linux.intel.com,
 palmer@dabbelt.com, tj@kernel.org, andreyknvl@gmail.com, brgerst@gmail.com,
 ardb@kernel.org, dave.hansen@linux.intel.com, jgross@suse.com,
 will@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, corbet@lwn.net,
 dvyukov@google.com, richard.weiyang@gmail.com, ytcoode@gmail.com,
 tglx@linutronix.de, hpa@zytor.com, seanjc@google.com,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu, justinstitt@google.com,
 jason.andryuk@amd.com, glider@google.com, ubizjak@gmail.com,
 jannh@google.com, bhe@redhat.com, vincenzo.frascino@arm.com,
 rafael.j.wysocki@intel.com, ndesaulniers@google.com, mingo@redhat.com,
 catalin.marinas@arm.com, junichi.nomura@nec.com, nathan@kernel.org,
 ryabinin.a.a@gmail.com, dennis@kernel.org, bp@alien8.de,
 kevinloughlin@google.com, morbo@google.com, dan.j.williams@intel.com,
 julian.stecklina@cyberus-technology.de, peterz@infradead.org, cl@linux.com,
 kees@kernel.org, kasan-dev@googlegroups.com, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev,
 linux-doc@vger.kernel.org
References: <cover.1738686764.git.maciej.wieczor-retman@intel.com>
 <2c2a71ec844db597f30754dd79faf87c9de0b21f.1738686764.git.maciej.wieczor-retman@intel.com>
 <c344dfaa-7e79-498f-89d7-44631140d0f4@intel.com>
 <lm5dg55q4vhhlsbsrvtskpz2hhdxa25pieq4gmf62ogtr4b4tw@xsq7ua7i5lto>
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
In-Reply-To: <lm5dg55q4vhhlsbsrvtskpz2hhdxa25pieq4gmf62ogtr4b4tw@xsq7ua7i5lto>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 08:37, Maciej Wieczor-Retman wrote:
> @@ -287,7 +290,7 @@ static pte_t *fill_pte(pmd_t *pmd, unsigned long vaddr)
>  	if (pmd_none(*pmd)) {
>  		pte_t *pte = (pte_t *) spp_getpage();
>  		pmd_populate_kernel(&init_mm, pmd, pte);
> -		if (pte != pte_offset_kernel(pmd, 0))
> +		if (__pa(pte) != (pmd_val(*pmd) & pmd_pfn_mask(*pmd)))
>  			printk(KERN_ERR "PAGETABLE BUG #03!\n");
>  	}
>  	return pte_offset_kernel(pmd, vaddr);

Open coding it like this is fine with me.  The p*_offset_kernel(p*,0)
thing is arguably even harder to parse.

