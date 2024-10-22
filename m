Return-Path: <linux-kernel+bounces-376900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C39AB734
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35491C22FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA51E1CC8AA;
	Tue, 22 Oct 2024 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVlp0raE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347111CC88A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626786; cv=none; b=Zp/KwziM5CPpGXgA3FrebS5dgo4FsX1AiF+eRSLXJ03cpGxi94sTFSyITDdy6Hu9srzeGeY963BOHLIdudfL01SGhxQWhBdOK/8lW6Ftlz+uRbroTOLZ7nFOn8CJX6KSz8Z7mtYrZfmXj4O/nL0171j0UgRU8syz93gjUaQCYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626786; c=relaxed/simple;
	bh=l59kMDJ7z7CBbNaq+JQ03dLdRv75DZd2iKraotg/SJI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Qx83NI8oMdJOLh7CECLb7EpujlGrEJ89lVWLj/WgD0qCrSd/kasXd65mNjD7bkTooQpZt9DZ0xglApldanzeVI5UczGf0BaxYguk+XWIh/1ttagX2011IGuqC1AcHyEWSNV/gjOIdJFo8FYdgQSlar1WqmGCpzycdJhLQi7+I7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVlp0raE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729626785; x=1761162785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=l59kMDJ7z7CBbNaq+JQ03dLdRv75DZd2iKraotg/SJI=;
  b=MVlp0raEAmDxikwo3wrzdodRP1h1R9TaB/2N8qr+kLQ4xhpPjePkTmFW
   9lGuApTQ96AMGNMx9PEDzbBAO235eno/qu5i7LGvWMiEXDOM26oz6Htx4
   6iN3L5hL3sEMcnlO5Ny5dRIwxPgQZytr6OBAqZ0L9/ILbepzXrma9oxfN
   gYAjqpmNnlvfz+G1NpJ3cqpsQTnrASEghk1gHhkaCT1uAkjnGK9d5JG8+
   BDO96uiPV4clq6LoBGU6RBKx4Z9xNGoPgfNrBEtO6NuUw6xxj0QMkXq4a
   hhK0jZ24RallCsGkyxFXSypeZsjyvRLMYYM8YbYx366ghZvss+kbI/cb/
   w==;
X-CSE-ConnectionGUID: 5WqI9VUURUOXIqfaKn94NQ==
X-CSE-MsgGUID: AXuoceVDRc+dX6oZ4yUE7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46649638"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208,223";a="46649638"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:53:04 -0700
X-CSE-ConnectionGUID: MOcBCYwvRueFsoI/3ONyhw==
X-CSE-MsgGUID: uOtSnfJHQWO+VpxuGMhvmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208,223";a="79912497"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.220.121]) ([10.124.220.121])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 12:53:03 -0700
Content-Type: multipart/mixed; boundary="------------j7icfEkLOSMelbrpKGR8X0pv"
Message-ID: <c22fd9c5-6727-46c2-a811-784315edf7cb@intel.com>
Date: Tue, 22 Oct 2024 12:53:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when
 comparing in percpu_add_op()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
 <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
 <20241016192011.GY17263@noisy.programming.kicks-ass.net>
 <de705cdf-ccce-460f-846e-dfc63c63af1a@intel.com>
 <20241017181859.GB17263@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20241017181859.GB17263@noisy.programming.kicks-ass.net>

This is a multi-part message in MIME format.
--------------j7icfEkLOSMelbrpKGR8X0pv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/17/24 11:18, Peter Zijlstra wrote:
> On Wed, Oct 16, 2024 at 12:44:18PM -0700, Dave Hansen wrote:
> 
>> Would anybody hate if we broke this up a bit, like:
>>
>>         const typeof(var) _val = val;
>>         const int paoconst = __builtin_constant_p(val);
>>         const int paoinc   = paoconst && ((_val) == 1);
>>         const int paodec   = paoconst && ((_val) == (typeof(var))-1);
>>
>> and then did
>>
>> 	if (paoinc)
>> 		percpu_unary_op(size, qual, "inc", var);
>> 	...
> I think that is an overall improvement. Proceed! 🙂

I poked at this a bit:

> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/commit/?h=testme&id=30e0899c6ab7fe1134e4b96db963f0be89b1dd5a

I believe it functions fine.  But it surprised me with a few things.
Here's one.  I assumed that doing an add((unsigned)-1) would be rare.
It's not.  It's actually pretty common because this:

#define this_cpu_sub(pcp, val)  this_cpu_add(pcp, -(typeof(pcp))(val))

ends up causing problems when 'pcp' is an unsigned type.  For example,
in this chain:

	mem_cgroup_exit ->
	obj_cgroup_put ->
	percpu_ref_put ->
	percpu_ref_put_many(ref, 1) ->
	this_cpu_sub

the compiler can see the '1' constant.  It effectively expands to:

	this_cpu_add(pcp, -(unsigned long)(1))

With the old code, gcc manages to generate a 'dec'.  Clang generates an
'add'.  With my hack above both compilers generate an 'add'.  This
actually matters in some code that seems potentially rather performance
sensitive:

add/remove: 0/0 grow/shrink: 219/9 up/down: 755/-141 (614)
Function                                     old     new   delta
flush_end_io                                 905    1070    +165
x86_pmu_cancel_txn                           242     338     +96
lru_add                                      554     594     +40
mlock_folio_batch                           3264    3300     +36
compaction_alloc                            3813    3838     +25
tcp_leave_memory_pressure                     86     110     +24
account_guest_time                           270     287     +17
...

So I think Peter's version was the best.  It shuts up clang and also
preserves the existing (good) gcc 'sub' behavior.  I'll send it out for
real in a bit, but I'm thinking of something like the attached patch.


--------------j7icfEkLOSMelbrpKGR8X0pv
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-percpu-Avoid-comparing-unsigned-types-to-1.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-percpu-Avoid-comparing-unsigned-types-to-1.patch"
Content-Transfer-Encoding: base64

RnJvbSBkNjNiY2QzNTBlMWEzYmE2MTk2ZGFkYjI2Y2IyZjM2ZjBiYTFlMTgyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXgu
aW50ZWwuY29tPgpEYXRlOiBGcmksIDE4IE9jdCAyMDI0IDExOjA3OjQ3IC0wNzAwClN1Ympl
Y3Q6IFtQQVRDSF0geDg2L3BlcmNwdTogQXZvaWQgY29tcGFyaW5nIHVuc2lnbmVkIHR5cGVz
IHRvIC0xCgpjbGFuZyB3YXJucyB3aGVuIGNvbXBhcmluZyBhbiB1bnNpbmdlZCB0eXBlIHRv
IC0xIHNpbmNlIHRoZSBjb21wYXJpc29uCmlzIGFsd2F5cyBmYWxzZS4KClRoaXMgY2FuIGJl
IHF1aWNrbHkgcmVwcm9kdWNlZCBieSBzZXR0aW5nIENPTkZJR19XRVJST1I9eSBhbmQgcnVu
bmluZzoKCgltYWtlIFc9MSBDQz1jbGFuZy0xNCBuZXQvaXB2NC90Y3Bfb3V0cHV0Lm8KCm5l
dC9pcHY0L3RjcF9vdXRwdXQuYzoxODc6MzogZXJyb3I6IHJlc3VsdCBvZiBjb21wYXJpc29u
IG9mIGNvbnN0YW50IC0xIHdpdGggZXhwcmVzc2lvbiBvZiB0eXBlICd1OCcgKGFrYSAndW5z
aWduZWQgY2hhcicpIGlzIGFsd2F5cyBmYWxzZSBbLVdlcnJvciwtV3RhdXRvbG9naWNhbC1j
b25zdGFudC1vdXQtb2YtcmFuZ2UtY29tcGFyZV0KICAxODcgfCAgICAgICAgICAgICAgICAg
TkVUX0FERF9TVEFUUyhzb2NrX25ldChzayksIExJTlVYX01JQl9UQ1BBQ0tDT01QUkVTU0VE
LAogICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgMTg4IHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdHAtPmNvbXByZXNzZWRfYWNrKTsKICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+Ci4uLgphcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZXJjcHUuaDoyMzg6MzE6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ3Bl
cmNwdV9hZGRfb3AnCiAgMjM4IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh2
YWwpID09IDEgfHwgKHZhbCkgPT0gLTEpKSA/ICAgICAgICAgICAgXAogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+IF4gIH5+CgpG
aXggdGhpcyBieSBhdm9pZGluZyBhIGNvbXBhcmlzb24gb2YgYW4gdW5jYXN0IC0xIHRvICd2
YWwnLgoKRG9pbmcgdGhpcyBpbiBhZGRpdGlvbiB0byB0aGUgZXhpc3RpbmcgJ3Bhb19JRF9f
JyBjYWxjdWxhdGlvbiB3b3VsZCBtYWtlIGl0CmV2ZW4gbW9yZSB1bnJlYWRhYmxlLiBSZW1v
dmUgJ3Bhb19JRF9fJyBhbmQgcmVwbGFjZSBpdCB3aXRoIHRoZSB0aHJlZQpjb21wb25lbnRz
IG9mIGl0cyBjYWxjdWxhdGlvbi4KClRoaXMgcHJlc2VydmVzIHNvbWUgdW5pbnR1aXRpdmUg
YnV0IHVzZWZ1bCBiZWhhdmlvci4gIEZvciBpbnN0YW5jZSwgZ2NjIHNlZXM6CgoJcGVyY3B1
X2FkZF9vcCguLi4sIHZhciwgKHU4KS0xKTsKCmFuZCBjYW4gdHJhbnNmb3JtIHRoYXQgaW50
byBhICJkZWMiLiAgQ2xhbmcsIG9uIHRoZSBvdGhlciBoYW5kLCBzZWVzIHRoZSAndTgnCnR5
cGUgYW5kIGFzc3VtZXMgdGhhdCAiKHZhbCkgPT0gLTEiIGlzIGZhbHNlLCB3aGljaCB3YXMg
dGhlIHJvb3Qgb2YgdGhlCndhcm5pbmcuCgpUaGlzIGlzIHVzZWZ1bCBnY2MgYmVoYXZpb3Ig
YmVjYXVzZToKCgkjZGVmaW5lIHRoaXNfY3B1X3N1YihwY3AsIHZhbCkgIHRoaXNfY3B1X2Fk
ZChwY3AsIC0odHlwZW9mKHBjcCkpKHZhbCkpCgpzbyBhbnkgY29kZSB0aGF0IGRvZXM6CgoJ
dGhpc19jcHVfc3ViKEEsIDEpCgp3aGVyZSAnQScgaXMgYW4gdW5zaWduZWQgdHlwZSBnZW5l
cmF0ZXMgYSAiZGVjIi4gIENsYW5nLCBvbiB0aGUgb3RoZXIKaGFuZCBnZW5lcmF0ZXMgYSBs
ZXNzLWVmZmljaWVudCAiYWRkIi4KClJlcG9ydGVkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogRGF2ZSBI
YW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZXJjcHUuaCB8IDExICsrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGVyY3B1LmgKaW5k
ZXggYzU1YTc5ZDVmZWFlLi41N2Q5NzU5YzY5MmUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5o
CkBAIC0yMzQsMTggKzIzNCwxOSBAQCBkbyB7CQkJCQkJCQkJXAogICovCiAjZGVmaW5lIHBl
cmNwdV9hZGRfb3Aoc2l6ZSwgcXVhbCwgdmFyLCB2YWwpCQkJCVwKIGRvIHsJCQkJCQkJCQlc
Ci0JY29uc3QgaW50IHBhb19JRF9fID0gKF9fYnVpbHRpbl9jb25zdGFudF9wKHZhbCkgJiYJ
CVwKLQkJCSAgICAgICgodmFsKSA9PSAxIHx8ICh2YWwpID09IC0xKSkgPwkJXAotCQkJCShp
bnQpKHZhbCkgOiAwOwkJCQlcCisJY29uc3QgaW50IHBhb19jb25zdF9fID0gX19idWlsdGlu
X2NvbnN0YW50X3AodmFsKTsJCVwKKwljb25zdCBpbnQgcGFvX2luY19fICAgPSAodmFsKSA9
PSAxOwkJCQlcCisJY29uc3QgaW50IHBhb19kZWNfXyAgID0gKHR5cGVvZih2YXIpKSh2YWwp
ID09CQkJXAorCQkJCSh0eXBlb2YodmFyKSktMTsJCQlcCiAJCQkJCQkJCQlcCiAJaWYgKDAp
IHsJCQkJCQkJXAogCQl0eXBlb2YodmFyKSBwYW9fdG1wX187CQkJCQlcCiAJCXBhb190bXBf
XyA9ICh2YWwpOwkJCQkJXAogCQkodm9pZClwYW9fdG1wX187CQkJCQlcCiAJfQkJCQkJCQkJ
XAotCWlmIChwYW9fSURfXyA9PSAxKQkJCQkJCVwKKwlpZiAocGFvX2NvbnN0X18gJiYgcGFv
X2luY19fKQkJCQkJXAogCQlwZXJjcHVfdW5hcnlfb3Aoc2l6ZSwgcXVhbCwgImluYyIsIHZh
cik7CQlcCi0JZWxzZSBpZiAocGFvX0lEX18gPT0gLTEpCQkJCQlcCisJZWxzZSBpZiAocGFv
X2NvbnN0X18gJiYgcGFvX2RlY19fKQkJCQlcCiAJCXBlcmNwdV91bmFyeV9vcChzaXplLCBx
dWFsLCAiZGVjIiwgdmFyKTsJCVwKIAllbHNlCQkJCQkJCQlcCiAJCXBlcmNwdV9iaW5hcnlf
b3Aoc2l6ZSwgcXVhbCwgImFkZCIsIHZhciwgdmFsKTsJCVwKLS0gCjIuMzQuMQoK

--------------j7icfEkLOSMelbrpKGR8X0pv--

