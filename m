Return-Path: <linux-kernel+bounces-526326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721EBA3FD39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47AA17BFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1A921B9EA;
	Fri, 21 Feb 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQ3gSOf/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F024F58E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740158247; cv=none; b=h/DK+j54iRH4Y2aP5mn/dAzuOB7/3lCeavKp+V4W4szVTLWL8s4NKIJCmxSVZ+uG4Yj+M8mOrU6GJ5TXYCNd7haLMLcMuFglVPTL0zH15BQtZFqtDmUALdMNFlILOd1XrqZkyALj9dbPCjmSsirR3rj9ATgmGGHqygl3AdSsdpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740158247; c=relaxed/simple;
	bh=MDfzAUMKryuV15YAAh1iVXakgE0hLgot6RuOnyiVcqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtkEBYlEienwVN6/fEdd+p2wKnNGYzav7h5hHtwQ5yX2/m2QcFTlH5J2lxP6dzv3uTkI3kVoMEsuVNtf031DeiL7E3OXyrJKfMmEmNtkYZIzvFb+WQ2slsqRgVwpDC/lXke7h7bgf7naHq2CnUSBgI1nzHCJN096YNn1x77NH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQ3gSOf/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740158246; x=1771694246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MDfzAUMKryuV15YAAh1iVXakgE0hLgot6RuOnyiVcqk=;
  b=MQ3gSOf/a80Arr1qlpPMIJBehM4QvUkBFqbbiJPcwkiALIqLNWRAD4SO
   LO6BAeGCMpkxnZkQ8UrxqusxRi8vPCYahIUZV6aO8yx1JwPgSNVVR4wUR
   YzvBO9VX/6hpC/n1EdU9AuP1nl/VIgGc/kiQGb5pPqdLsNLKV2pzXSnPZ
   Njh4Q50dXgNyD9ma7C0GF3Gl2qWky64gQ4PT5quVOsOPcLRAtgH7cEvqK
   xC5Jc2/qSPhog0ueIzXi438cZUZMCYryEibEF0nr9R0+DbQXcEDIhf0PX
   WjPPgFOeyI/90vqYgheBRnUWXcTHEcgspxYu04hx8z/J2374vLg7EYQAN
   Q==;
X-CSE-ConnectionGUID: AxcuYFyETlWVaQPW1FHKuA==
X-CSE-MsgGUID: oTE/A1s6T2KhK+Lv9YsacA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="58395440"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="58395440"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:17:25 -0800
X-CSE-ConnectionGUID: 4cUEoefjSP2u7rYGcvY4lg==
X-CSE-MsgGUID: f+84b3D+TEi80SrI30yPqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120404085"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.110.177]) ([10.125.110.177])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:17:25 -0800
Message-ID: <81d94ec3-16af-45a7-87c6-ef76570953f8@intel.com>
Date: Fri, 21 Feb 2025 09:17:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
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
In-Reply-To: <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 03:07, Dmitry Vyukov wrote:
>  
>  error:
> +	/*
> +	 * If the application registers rseq, and ever switches to another
> +	 * pkey protection (such that the rseq becomes inaccessible), then
> +	 * any context switch will cause failure here attempting to read/write
> +	 * struct rseq and/or rseq_cs. Since context switches are
> +	 * asynchronous and are outside of the application control
> +	 * (not part of the restricted code scope), we temporarily switch
> +	 * to premissive pkey register to read/write rseq/rseq_cs,
> +	 * similarly to signal delivery accesses to altstack.
> +	 *
> +	 * We don't bother to check if the failure really happened due to
> +	 * pkeys or not, since it does not matter (performance-wise and
> +	 * otherwise).
> +	 *
> +	 * If the restricted code installs rseq_cs in inaccessible to it
> +	 * due to pkeys memory, we still let this function read the rseq_cs.
> +	 * It's unclear what benefits the resticted code gets by doing this
> +	 * (it probably already hijacked control flow at this point), and
> +	 * presumably any sane sandbox should prohibit restricted code
> +	 * from accessing struct rseq, and this is still better than
> +	 * terminating the app unconditionally (it always has a choice
> +	 * of not using rseq and pkeys together).
> +	 */

I would trim this comment down. I'd keep the discussion more in the
changelog than in here. I'd also suggest breaking out the spell checker.

Also, as usual, changing this to imperative voice makes it more compact too:

	Don't bother to check if the failure really happened due to
	pkeys or not, since it does not matter (performance-wise and
	otherwise).

Basically, zap the "we's".

> +	if (!switched_pkey_reg) {
> +		switched_pkey_reg = true;
> +		saved = switch_to_permissive_pkey_reg();
> +		goto retry;
> +	} else {
> +		write_pkey_reg(saved);
> +	}

This code flow is a bit hard to follow with the retry and all.

I think the assumption here is that overwriting the pkey register is too
slow for the fast path. Instead, in the slow error path, there is a
one-time operation to make the register permissive and retry.

I guess it's your rseq code. But I'd probably just put the
switch_to_permissive_pkey_reg()/write_pkey_reg() in the fast/common path
for simplicity unless I knew it was causing a measurable performance
problem.

In either case, it would be great to comment that design choice in the
changelog.

Oh, and cover letters are most appreciated for these kinds of things.
I'd normally reply to the cover letter and say this, but I'll put it
here instead:

The series overall looks fine. It just needs a few cosmetic tweaks.

I don't see any Cc:stable@ or Fixes: tags. Is this a bug fix that you
want backported? If so, those tags would be appropriate and it woudl be
appreciated if you could dig out what it actually fixes.

