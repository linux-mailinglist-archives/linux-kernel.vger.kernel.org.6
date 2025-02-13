Return-Path: <linux-kernel+bounces-514043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57991A351A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370741882BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096F2753EC;
	Thu, 13 Feb 2025 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYpCm9iJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731F2753E8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487164; cv=none; b=pPYhNQHg1fjSqcFpfW/Nd12PU+pCyySfd65YG9BhlhftHdv14xwD6sN1hk3+cApeGIhyQ4QshGyavFDsXux4NpPUqh0opV8hwvLDY+o8wFmY3XU9Kd5zUvaA/mOpmSqVAVFLOuZqtpPiQpd6oMd6EP+gHHXhx3UGR54SGBuS/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487164; c=relaxed/simple;
	bh=ZdAaRSQBdHLvutJUD7iiNJZZ+fgTiSlLTbKntKkz7V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tu3GF8MqvLrHusjGKCnmOcYCaaCtfK8GefzsIU18iXmAx+eB+qBEiTV4Z72AagSiMUC2NgRjV5YRHe7LpcKr/5usIQOcVfqUYCAwUthvFMkJyGR73Zq3QzwGM7todybNj3fa3zUiLA5Lo+ufF6LkRq/VaS+oo0j6spqZIjClxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYpCm9iJ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739487162; x=1771023162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZdAaRSQBdHLvutJUD7iiNJZZ+fgTiSlLTbKntKkz7V0=;
  b=DYpCm9iJbEMP9VV3CSirv+NgwsfIdOPyih5S7EImXX3cZKgYWUZPLJL+
   ma8fyYao2YSbc0JKQ2aYRHJUbwXBvH5S504fABmATJQc84pS5ZS/95u+O
   R2vJRC2ZHQhSshQeaO1tCgG09znWgmPrdXt4ojA9JqXnniJrD8I9XhyMA
   PTB/qATGEb/ytjo/uMCe+w0TIDDsTMjQoar3z75luLhCtB2nNwsA/WhEU
   vvszYa1/ymCmEBSlnfjwRXtDtgOb2lb6fjYPycZaQIbgYD5grZ0ZktAWJ
   3Bjde0kechRpszdKRG/nH1iG/Sj2ECC1R2Ym+htf5RhYDchn19JrNg28R
   g==;
X-CSE-ConnectionGUID: yXpAlbY+TEW8tkQtVEg+MQ==
X-CSE-MsgGUID: BP7NsZk2T6yjRrIuxgTbyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50842165"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="50842165"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:52:42 -0800
X-CSE-ConnectionGUID: nO8NP5xVRum/6p8UR7u41w==
X-CSE-MsgGUID: to+9fr9RTWugbrVZwm1FDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150459322"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:52:42 -0800
Message-ID: <87194c62-7e97-41d3-98bd-14288e8bde8f@intel.com>
Date: Thu, 13 Feb 2025 14:52:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 2/2] x86/locking: Use asm_inline for
 {,try_}cmpxchg{64,128} emulations
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20250213191457.12377-1-ubizjak@gmail.com>
 <20250213191457.12377-2-ubizjak@gmail.com>
 <62965669-bf1d-461f-9401-20e303c6d619@intel.com>
 <CAFULd4ZyCNy3MaCLqcuqyJKABMvbiToA5aZxfEt3iMgdRuLuYg@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CAFULd4ZyCNy3MaCLqcuqyJKABMvbiToA5aZxfEt3iMgdRuLuYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 14:13, Uros Bizjak wrote:
> On Thu, Feb 13, 2025 at 9:48 PM Dave Hansen <dave.hansen@intel.com> wrote:
>> On 2/13/25 11:14, Uros Bizjak wrote:
>>> According to [1], the usage of asm pseudo directives in the asm template
>>> can confuse the compiler to wrongly estimate the size of the generated
>>> code. ALTERNATIVE macro expands to several asm pseudo directives, so
>>> its usage in {,try_}cmpxchg{64,128} causes instruction length estimate
>>> to fail by an order of magnitude (the compiler estimates the length of
>>> an asm to be more than 20 instructions).
>>
>> Just curious, but how did you come up with the "20 instructions" number?
> 
> Currently, a patched GCC compiler is needed (please see
> asm_insn_count() and asm_str_count() functions in gcc/final.cc on how
> the asm length is calculated) to report the length. For historic
> reasons, the length of asm is not printed in asm dumps, but recently a
> GCC PR was filled with a request to change this).

So, that's also good info to add. You can  even do it in the changelog
with little more space than the existing changelog:

	... fail by an order of magnitude (a hacked-up gcc shows that it
	estimates the length of an asm to be more than 20 instructions).

...
>> Is any of this measurable? Is there any objective data to support that
>> this change is a good one?
> 
> Actually, "asm inline" was added to the GCC compiler just for this
> purpose by request from the linux community [1].

Wow, that's really important important information. Shouldn't the fact
that this is leveraging a new feature that we asked for specifically get
called out somewhere?

Who asked for it? Are they on cc? Do they agree that this feature fills
the gap they wanted filled?

> My patch follows the
> example of other similar macros (e.g. arch/x86/include/alternative.h)
> and adds the same cure to asms that will undoubtedly result in a
> single instruction [*].  The benefit is much more precise length
> estimation, so compiler heuristic is able to correctly estimate the
> benefit of inlining, not being skewed by excessive use of
> __always_inline directive. OTOH, it is hard to back up compiler
> decisions by objective data, as inlining decisions depend on several
> factors besides function size (e.g. how hot/cold is function), so a
> simple comparison of kernel sizes does not present the full picture.

Yes, the world is complicated. But, honestly, one data point is a
billion times better than zero. Right now, we're at zero.

>> It's quite possible that someone did the "asm" on purpose because
>> over-estimating the size was a good thing.
> 
> I doubt this would be the case, and I would consider the code that
> depends on this detail defective. The code that results in one asm
> instruction should be accounted as such, no matter what internal
> details are exposed in the instruction asm template.

Yeah, but defective or not, if this causes a regression, it's either not
getting applied to gets reverted.

All that I'm asking here is that someone look at the kernel after the
patch gets applied and sanity check it. Absolutely basic scientific
method stuff. Make a hypothesis about what it will do:

	1. Inline these locking functions
	2. Make the kernel go faster for _something_

and if it doesn't match the hypothesis, then try and figure out why. You
don't have to do every config or every compiler. Just do one config and
one modern compiler.

Right now, this patch is saying:

	1. gcc appears to have done something that might be suboptimal
	2. gcc has a new feature that might make it less suboptimal
	3. here's a patch that should optimize things
	...

but then it leaves us hanging.  There's a lot of "mights" and "shoulds"
in there, but nothing that shows that this actually does anything
positive in practice.

Maybe I'm just a dummy and this is just an obvious improvement that I
can't grasp. If so, sorry for being so dense, but I'm going to need a
little more education before this gets applied.

