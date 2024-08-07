Return-Path: <linux-kernel+bounces-278673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087A94B35D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAC11F22DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49AE155399;
	Wed,  7 Aug 2024 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFHyzyEv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e90cqsiK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866B364A0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071856; cv=none; b=bRbIIm0g1QePtycdaDC7yHFECkMbKZ/o9+0YTw8x+rt4U4KkRwPsUqW2sCncNG9djtcGDGQpVOWhiSFApxLisiGilJnY1uMs/t/XTl7EfN3hZUuCviLJAXu2VGzns6BhhRhOX0BVxhbhcWyjV0kTvFfXFlhrpi3v+Lle2oU/Koc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071856; c=relaxed/simple;
	bh=DvotnVNRpC53HHo6QdSp7HIY7GEENlTOH5k3EOxGJPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UwvvA4xu9rWNXCdlxKlbx7kchX1OY8ZPtdKzXY1KWp5mKOVbG+YBwjGdRPE91nSmrxiUaUbrxvmLhTqmg6blEsmrfeC4t9oXgO0Ml91QPG7hEu9dx5caNh0TM628hvIWWFJhsaGs3ODf0oE0Kc00uHmCBk3fNgdO7hOI+OY8zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFHyzyEv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e90cqsiK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723071852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0f9bf1prQA1Y9jXobLM8llAEzyIVIMzppaXP63X9KQ=;
	b=cFHyzyEvvptLG+dja8hZPBwuViLLR1s8VtuuJdXLmDTHIlZm864siIyPahG5m/oavLhOJy
	UGw2maeMOO9GfdykQUyAB/ijY6mEEFSfUvkXgShTLnNKQuDtO+bLxJ8UHJ+GuFQOZRRJGQ
	cQivi8ASYtmGXe+Q0BYZR89Zx+DajQzfL/60AjvxHE2VjAxvYIZpARv4jUb6BbqmpYoIKR
	27RzFb+bAj5aLUI1ZxqgySnEgmX+sz5AVhgdAoShiWgcyBrCbMB1tTJTz8Q999rqH7/b0v
	xPyHOWHBQ6UpUbWvQ3xmYCogvDXOrHsRvrZ0WQ+axN/HHNMyXdKoHP0McLKcCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723071852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h0f9bf1prQA1Y9jXobLM8llAEzyIVIMzppaXP63X9KQ=;
	b=e90cqsiKUVkmQ1w7kXESTEd7UiFDPuJsCjR+NlFn6NunTL1Qz1wk/HSZnIJmNTgmNZ+gIv
	+Q+nL8SWdySPgSAw==
To: Sean Christopherson <seanjc@google.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
 andrew.cooper3@citrix.com
Subject: Re: [PATCH v1 3/3] x86/entry: Set FRED RSP0 on return to userspace
 instead of context switch
In-Reply-To: <ZrPtOTHBfZ2e6RfV@google.com>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-4-xin@zytor.com> <87ttfw18jy.ffs@tglx>
 <ZrPtOTHBfZ2e6RfV@google.com>
Date: Thu, 08 Aug 2024 01:04:11 +0200
Message-ID: <8734ng0wb8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 07 2024 at 14:55, Sean Christopherson wrote:
> On Wed, Aug 07, 2024, Thomas Gleixner wrote:
>> Though I wonder if this should not have a per CPU cache for that.
>> 
>>         if (cpu_feature_enabled(X86_FEATURE_FRED) {
>>         	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;
>> 
>> 		if (__this_cpu_read(cpu_fred_rsp0) != rsp0) {
>> 			wrmsrns(MSR_IA32_FRED_RSP0, fred_rsp0);
>>                         this_cpu_write(cpu_fred_rsp0, rsp0);
>>                 }
>>         }	
>> 
>> Hmm?
>
> A per-CPU cache would work for KVM too, KVM would just need to stuff the cache
> with the guest's value instead of setting _TIF_LOAD_USER_STATES.

There are two options vs. the cache:

1) Use a cache only

static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
						  unsigned long ti_work)
{
	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
		arch_exit_work(ti_work);

        fred_rsp0_magic();

2) Use both the TIF bit and the cache

static inline void arch_exit_work(unsigned long ti_work)
{
        if (....)
        ...
        fred_rsp0_magic();
}

#1 has the charm that it avoids arch_exit_work() completely when ti_work
   is 0, but has the unconditional check on the per CPU cache variable
   and the extra conditional on every return

#2 has the charm that it avoids touching the per CPU cache variable on
   return when the TIF bit is not set, but comes with the downside of
   going through the ti_work chain to update RSP0

I'm inclined to claim that #1 wins. Why?

The probability for a RSP0 update is higher than the probability for
ti_work != 0, and for syscall heavy workloads the extra per CPU read and
the conditional is not really relevant when we stick this into struct
pcpu_hot. That cacheline is hot anyway in that code path due to
'current' and other members there.

But that's a problem for micro benchmark experts to figure out. I'm not
one of them :)

In any case the cache should be a win over an unconditionl MSR write
independent of MRMSRNS.

Thanks,

        tglx

