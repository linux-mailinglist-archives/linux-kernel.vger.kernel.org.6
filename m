Return-Path: <linux-kernel+bounces-328581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC6A978616
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DD71C22ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CC61FEA;
	Fri, 13 Sep 2024 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3fJNUFU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492F2D052
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246065; cv=none; b=XGvsqAUEbfGxxHbOK9BE3d3Mz6VBFk+akhxlLNpT18oc20VkaOLzZns2YI7xYclCB+6wYB2ue7cpGBayBQJI6Tsu6vteijRse3kZc8VSdwQlOxfj3MmCRdI3xOy2TT/xFAc/yiQqrs3rtRkESNaXor6bowtc0tgjI6ozAtP3zrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246065; c=relaxed/simple;
	bh=KWwB4d88/prTk7vewmW+UJFmOZSzFgtQq/hT3DCdaSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4W/3PxO2DIExQ4bODWHSP491lomyVnOOowDq6X48zw1gqV5jrZILXoreSAsSqEOFLj5Xv/X5I4XCncJEWCi20boGmGuq+qaL56qswN9SEI+c5qLccA1/EN8gwbjxzxZk6C0N7QVzVlNzNKknqyxzI37X7bm9tusF/t/6ezBOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3fJNUFU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726246063; x=1757782063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KWwB4d88/prTk7vewmW+UJFmOZSzFgtQq/hT3DCdaSc=;
  b=B3fJNUFUNOy7AukCCBtnU7zjPTDU9xlidj8f6koglTm5m37gi44j/jbE
   TbmAb/+N5exDWWeE+5YqEfZOme2tcwlnNFPjOxkQoNor0kP8nKCzzHzJZ
   xOfr9HZ9J66XGCf1FuoiWtXrCxrZLNbzmVgeSdHv/VLriPBOYoW+D6MC6
   JDGTvN1/mReJxpvqxboGqhvAcQ2DyF1d/Lk+wfJg2y4JDadO1P8MKpfOl
   6oxmZ+HUypgonLdHPav7GC5mWyMCzoAd/V7zGncg2M92E8ZBZbtpKATUV
   oJzEJidv5HTu7D/TDKj2+v1O3xzIlFLaJKxGavEJSGp2+eurqcBDU3vdl
   A==;
X-CSE-ConnectionGUID: yE1b4GVlQmuz1zBPS1J08g==
X-CSE-MsgGUID: TI+xSfbZQdqgugTSZliFlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25353957"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25353957"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 09:47:43 -0700
X-CSE-ConnectionGUID: PVWQLBgTSXiwmHNFknENhQ==
X-CSE-MsgGUID: QHqfEzqeShGr0V2mZUWncQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="98970701"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.220.219]) ([10.124.220.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 09:47:41 -0700
Message-ID: <74fe44da-b99e-4fe6-b07c-43a146184e7c@intel.com>
Date: Fri, 13 Sep 2024 09:47:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] x86/tdx: Allow MMIO instructions from userspace
To: Sean Christopherson <seanjc@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>,
 Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, decui@microsoft.com,
 John.Starks@microsoft.com, Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1724837158.git.legion@kernel.org>
 <cover.1725622408.git.legion@kernel.org>
 <6c158a14-ba01-4146-9c6c-8e4c035dd055@intel.com>
 <ZttwkLP74TrQgVtL@google.com>
 <d3895e03-bdfc-4f2a-a1c4-b2c95a098fb5@intel.com>
 <ZuHC-G575S4A-S_m@google.com>
 <h5gp6dgcfazm2yk3lorwqms24c2y2z4saqyed6bnzkk2zhq5g2@rf3lj2a22omd>
 <039bc47c-9b5d-41f3-87da-4500731ad347@intel.com>
 <2v2egjmdpb2fzjriqc2ylvqns3heo5bpirtqm7cn32h3zsuwry@y5ejrbyniwxq>
 <c0d9ff5f-85d5-4df0-94a8-82e3bf6fe21f@intel.com>
 <ZuRoE6P3DxxK_3C9@google.com>
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
In-Reply-To: <ZuRoE6P3DxxK_3C9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/24 09:28, Sean Christopherson wrote:
>> because folks would update their kernel and old userspace would break.
>>
>> Or maybe we start enforcing things at >=SEV-SNP and TDX and just say
>> that security model has changed too much to allow the old userspace.
> Heh, that's an outright lie though.  Nothing relevant has changed between SEV-ES
> and SEV-SNP that makes old userspace any less secure, or makes it harder for the
> kernel to support decoding instructions on SNP vs. ES.

The trust model does change, though.

The VMM is still in the guest TCB for SEV-ES because there are *so* many
ways to leverage NPT to compromise a VM.  Yeah, the data isn't in plain
view of the VMM, but that doesn't mean the VMM is out of the TCB.

With SEV-ES, old crusty userspace is doing MMIO to a VMM in the TCB.

With SEV-SNP, old crusty userspace is talking to an untrusted VMM.

I think that's how the security model changes.

> I also don't know that this is for old userspace.  AFAIK, the most common case
> for userspace triggering emulated MMIO is when a device is passed to userspace
> via VFIO/IOMMUFD, e.g. a la DPDK.

Ahh, that would make sense.

It would be nice to hear from those folks _somewhere_ about what their
restrictions are and if they'd ever be able to enforce a subset of the
ISA for MMIO or even (for example) make system calls to do MMIO.

Does it matter to them if all of a sudden the NIC or the NVMe device on
the other side of VFIO is malicious?

