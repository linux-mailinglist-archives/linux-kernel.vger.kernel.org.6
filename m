Return-Path: <linux-kernel+bounces-545267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13965A4EB72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E40C3B5A94
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5415128FFD4;
	Tue,  4 Mar 2025 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hG5c89HJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46792E336E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110718; cv=none; b=cZuvpuAAmxwQunzMm+GhH8vE84rcCHowF8tdhgdQjKs+tWOrn970svobpJm4sZsHSYPRuEx3dl08S0RSb4LcsbqTALOkSRvpSHAro+eRlLj1mD4X+Uh7oyiE1uv2mLkCQSXLGdmUQBDgwxoluWk6QXbtuGbPXmg9QgfOTSK4B4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110718; c=relaxed/simple;
	bh=TUZ1PEKuDlaVu2H/sWtLP74hzoT82EHUfDQolb2ZQtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ev49tzDtGQNraM6dmvjP0PNinWn44maCpV2ep0TBff1uLmuJqHw8/0qbqYb0/pbxF+miZfEDjRNCbwvI6dzGrsl88v28q6hVT0/ZR6P9gZboAQh6mrpTwN+iMVHgsBPREEsqWytCkimC0frZdDamL5bLqUaiQno+cpdReMHgMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hG5c89HJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741110717; x=1772646717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TUZ1PEKuDlaVu2H/sWtLP74hzoT82EHUfDQolb2ZQtA=;
  b=hG5c89HJX558rPBXYTyJ7ugkEcE3lIdf2yb5SqRMrsE3+7MGv++j0d1j
   Qs6Mg1eO1J39NZcxdFJMstw5JTm4Y4yKIxd5v85cjeI3cQrgf+AXFAuuF
   7k4FPdlYtJYjEiSsJ3ts8vV7rw7Q9n6vyyf9Cwe3z0QHn/yZoFfXpsV9U
   E5QhO8ohq+us0pvr9nlUQvEL3quDOEDGXRjm1uyO6Ytn/2sQCo8bSHC5u
   qzyEafwBT2zB3iH7ADeH7+gbdt0iRA8BpEuJ7WYIeH5Pk8eGv+lS0sZUv
   UUhIfjfIGwZL58n4sQL4pasGcs0JYGHkkML/qoyRAT1A6Hc77zckZF3q3
   g==;
X-CSE-ConnectionGUID: cHMqowuvRTWpQUh/OU97Qw==
X-CSE-MsgGUID: OMyzX4aZS3uiAyy0JWuO+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45694100"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="45694100"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:51:30 -0800
X-CSE-ConnectionGUID: JNDFc07+RKqO30qmaDOe2g==
X-CSE-MsgGUID: hQgU/ItRTCKMx3iawgtrFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118956267"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.109.94]) ([10.125.109.94])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 09:51:30 -0800
Message-ID: <f5fab528-c8fd-47ea-ba25-6d59ff517b03@intel.com>
Date: Tue, 4 Mar 2025 09:51:48 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/13] x86/mm: do targeted broadcast flushing from
 tlbbatch code
To: Brendan Jackman <jackmanb@google.com>, Borislav Petkov <bp@alien8.de>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com,
 mhklinux@outlook.com, andrew.cooper3@citrix.com, Manali.Shukla@amd.com,
 mingo@kernel.org
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-12-riel@surriel.com>
 <20250303114618.GBZ8WWihMDjf-oy8P0@fat_crate.local>
 <7e1ca8c7-6f3e-44dc-9dd8-bd273a03a83e@intel.com>
 <Z8b3n85dpkz_-2ci@google.com>
 <20250304141134.GIZ8cKFom3W0ChHiXk@fat_crate.local>
 <Z8cdQwVnx8dmFDLA@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <Z8cdQwVnx8dmFDLA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/25 07:33, Brendan Jackman wrote:
> On Tue, Mar 04, 2025 at 03:11:34PM +0100, Borislav Petkov wrote:
>> On Tue, Mar 04, 2025 at 12:52:47PM +0000, Brendan Jackman wrote:
>>> https://lore.kernel.org/all/CA+i-1C31TrceZiizC_tng_cc-zcvKsfXLAZD_XDftXnp9B2Tdw@mail.gmail.com/
>>
>> Lemme try to understand what you're suggesting on that subthread:
>>
>>> static inline void arch_start_context_switch(struct task_struct *prev)
>>> {
>>>     arch_paravirt_start_context_switch(prev);
>>>     tlb_start_context_switch(prev);
>>> }
>>
>> This kinda makes sense to me...
> 
> Yeah so basically my concern here is that we are doing something
> that's about context switching, but we're doing it in mm-switching
> code, entangling an assumption that "context_switch() must either call
> this function or that function". Whereas if we just call it explicitly
> from context_switch() it will be much clearer.

I was coming to a similar conclusion. All of the nastiness here would
come from an operation like:

	INVLPGB
	=> get scheduled on another CPU
	TLBSYNC

But there's no nastiness with:

	INVLPGB
	=> switch to init_mm
	TLBSYNC

at *all*. Because the TLBSYNC still works just fine. In fact, it *has*
to work just fine because you can get an TLB flush IPI in that window
already.

>>> Now I think about it... if we always tlbsync() before a context switch, is the
>>> cant_migrate() above actually required? I think with that, even if we migrated
>>> in the middle of e.g.  broadcast_kernel_range_flush(), we'd be fine? (At
>>> least, from the specific perspective of the invplgb code, presumably having
>>> preemption on there would break things horribly in other ways).
>>
>> I think we still need it because you need to TLBSYNC on the same CPU you've
>> issued the INVLPGB and actually, you want all TLBs to have been synched
>> system-wide.
>>
>> Or am I misunderstanding it?
> 
> Er, I might be exposing my own ignorance here. I was thinking that you
> always go through context_switch() before you get migrated, but I
> might not understand hwo migration happens.

Let's take a step back. Most of our IPI-based TLB flushes end up in this
code:

        preempt_disable();
        smp_call_function_many_cond(...);
        preempt_enable();

We don't have any fanciness around to keep the initiating thread on the
same CPU or check for pending TLB flushes at context switch time or lazy
tlb entry. We don't send asynchronous IPIs from the tlbbatch code and
then check for completion at batch finish time.

There's a lot of complexity to stuffing these TLB flushes into a
microarchitectural buffer and making *sure* they are flushed out.
INVLPGB is not free. It's not clear at all to me that doing loads of
them in reclaim code is superior to doing loads of:

	inc_mm_tlb_gen(mm);
	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));

and then just zapping the whole TLB on the next context switch.

I think we should defer this for now. Let's look at it again when there
are some performance numbers to justify it.

