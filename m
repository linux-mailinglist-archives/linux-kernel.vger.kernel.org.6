Return-Path: <linux-kernel+bounces-515283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A127BA362E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D230316A55E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30FF2676EF;
	Fri, 14 Feb 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iz/S5g44"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9F20B7ED
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550007; cv=none; b=Tul4nlH9IBmdFbv9Hd4WxNwyThfBWWoTU9Ah52U2/FbuRzC4N2ddQIIY3i9LlI52OLNz/ZiOPYepC5qQFITgBnkHjSbTH+xrF/I4EN6iNXXI2y3Z8fuheHwva28zNrEy47FbDukikWiyg1v2U1LWKXsTSCqEaM4knwbgmMdB/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550007; c=relaxed/simple;
	bh=/CxnacnZ64DLjO3K7djuU0Qm7UPulYo/6rqJ4nbs2O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0mXvyGcw8td4XmVZN1Qh/gvXRM9970QCUd26aEZ4FduQdHLrkJcEtJ4sBKtKbhqWwiswMgI7oaPa6ZiDaxAP54Ipfn7d95iBIUjVw1BmzQoD5Xh69CVHwdHzLUPrn6PPwVzQhLJEgmo3uUo36v1ZhsLuMk4RR/i5HnmYCbz8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iz/S5g44; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739550005; x=1771086005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/CxnacnZ64DLjO3K7djuU0Qm7UPulYo/6rqJ4nbs2O4=;
  b=Iz/S5g44K7yCE/pkSzd61P56pdciXl8uF1rL7nbvvTzcei35s2GpIopM
   H4UXMA71C0WTQhW7nNwDGkcVgP35FtymXL9ui5yy+r2S/n1PZSZAhf6wu
   7YNFefSXjP1wuqvvLI450xgouzVkjDQJEjcJwmgn8dV7El42NDT06NHCB
   cLaR1dMdOhIVXYrxz9QPUEoCdjcWzK/+/6ppSMa6EcuNyFAl8KGRt8TkE
   PyiHdezIhYtNwDqKQJL3uxW8XvdJp509RXwLS8qTcYWF3OQxC/jpeoNFT
   98dC/nVbvrKr43MaSUX/87ZfltCvGiFQcpPsrs8BNsxYyyapwuH95i8iN
   g==;
X-CSE-ConnectionGUID: oTiSkl17Sw+ZQBHR/kWeNA==
X-CSE-MsgGUID: FPeYEauFQR24ZrLpllPhSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43142302"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43142302"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:20:04 -0800
X-CSE-ConnectionGUID: 4HBR2OMeQY2V4z452kg0iA==
X-CSE-MsgGUID: S3b5qtvvTuuEzX23BzZ32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118426787"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.109.21]) ([10.125.109.21])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:20:05 -0800
Message-ID: <4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
Date: Fri, 14 Feb 2025 08:20:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, akpm@linux-foundation.org,
 kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org,
 rick.p.edgecombe@intel.com, security@kernel.org
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
 <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
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
In-Reply-To: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 05:46, Kirill A. Shutemov wrote:
>> It sounds like you're advocating for the "slow guest boot" option.
>> Kirill, can you remind us how fast a guest boots to the shell for
>> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
>> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.
> I only have 128GB machine readily available and posted some number on
> other thread[1]:
> 
>   On single vCPU it takes about a minute to accept 90GiB of memory.
> 
>   It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
>   it doesn't scale past that in my setup.
> 
> I've mentioned it before in other thread:
> 
> [1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm

Oh, wow, from that other thread, you've been trying to get this crash
fix accepted since November?

From the looks of it, Eric stopped responding to that thread. I _think_
you gave a reasonable explanation of why memory acceptance is slow. He
then popped back up last month raising security concerns. But I don't
see anyone that shares those concerns.

The unaccepted memory stuff is also _already_ touching the page
allocator. If it's a dumb idea, then we should be gleefully ripping it
out of the page allocator, not rejecting a 2-line kexec patch.

Baoquan has also said this looks good to him.

I'm happy to give Eric another week to respond in case he's on vacation
or something, but I'm honestly not seeing a good reason to hold this bug
fix up.

Andrew, is this the kind of thing you can stick into mm and hold on to
for a bit while we give Eric time to respond?

