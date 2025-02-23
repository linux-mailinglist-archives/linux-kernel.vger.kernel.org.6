Return-Path: <linux-kernel+bounces-527649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC87A40DBB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7153D3B0A2F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD3E200100;
	Sun, 23 Feb 2025 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBoMW915"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF01DA628
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740303429; cv=none; b=NiFNW3JAVUM6y7bSU7/F+SEMwzXNHDJW4IvnzH57k9e8w1sdAYiiNo4Z5QcjM5IqXknyx40UoqlImeIVD3nQvTV04a/xBnYTfWkEnQL9nDQVwoRPH2KP+83QoEj8/f85MpQWp4JzF+PsE73OK4eoXVWiq0rrYOulh5rGD9Fdxaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740303429; c=relaxed/simple;
	bh=l1ExUI7O56Kxx4UjR9nwuyY0NkPY6g0ZZU7cdjnQ1t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDtqWCcdats+Ypy6Olgg1ZfpdzbY7yKWQqigmKEICqaISb0GFr9QyWlduqU5AIVd8Uwz+RVTUSk6R/CEaN5Zo7GGQfAFVqY4TWf9I/pPjUHraSNt3NZyZVErJfvA6dHMGHb0PbrhfxRtRNsN676/UK0C3+QF10GaJ6x5szYo7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBoMW915; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7C3C4CEDD;
	Sun, 23 Feb 2025 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740303428;
	bh=l1ExUI7O56Kxx4UjR9nwuyY0NkPY6g0ZZU7cdjnQ1t8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBoMW915+egPxUBDnVmUfZ+Fnlc+nhrfVdUjJ1sNiI7T9aTPvGHn7Z3bb43TJB2Uq
	 6RDx6jXXuJaCpmlaMu04Zm+sUaVSapUl+PK4QhwMSU/A+Hrf2t+oCAZV8VyvMuWXV+
	 DA5rFrPBAy0VW2aG2i1ey73Kgq2BtI4QFqSGoh4wm392ZTjno5f6hIbpkM1RO6bJcF
	 hqucNjsISE6yBdV1pwnTOd5GvWBT5wJ1BrgyFE9ToA+qltyhrs7RGN9KjpNzstkaX5
	 CQpOTJZnVcCfo2C/XE7dZdX97MC8jLr267CM6flWZHSocR3bLfofReWowWZ+8Wkl6B
	 mYJKR8ARkfKRA==
Date: Sun, 23 Feb 2025 10:36:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 00/11] Add a percpu subsection for hot data
Message-ID: <Z7rsOVaxhfCJdn2P@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> Add a new percpu subsection for data that is frequently accessed and
> exclusive to each processor.  This is intended to replace the pcpu_hot
> struct on X86, and is available to all architectures.
> 
> The one caveat with this approach is that it depends on the linker to
> effeciently pack data that is smaller than machine word size.  The
> binutils linker does this properly:
> 
> ffffffff842f6000 D __per_cpu_hot_start
> ffffffff842f6000 D softirq_pending
> ffffffff842f6002 D hardirq_stack_inuse
> ffffffff842f6008 D hardirq_stack_ptr
> ffffffff842f6010 D __ref_stack_chk_guard
> ffffffff842f6010 D __stack_chk_guard
> ffffffff842f6018 D const_cpu_current_top_of_stack
> ffffffff842f6018 D cpu_current_top_of_stack
> ffffffff842f6020 D const_current_task
> ffffffff842f6020 D current_task
> ffffffff842f6028 D __preempt_count
> ffffffff842f602c D cpu_number
> ffffffff842f6030 D this_cpu_off
> ffffffff842f6038 D __x86_call_depth
> ffffffff842f6040 D __per_cpu_hot_end
> 
> The LLVM linker doesn't do as well with packing smaller data objects,
> causing it to spill over into a second cacheline.

Ok, so I like it how it decentralizes the decision about what is 'hot' 
and what is not:

  --- a/arch/x86/kernel/irq.c
  +++ b/arch/x86/kernel/irq.c

  DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
  EXPORT_PER_CPU_SYMBOL(irq_stat);

  +DEFINE_PER_CPU_HOT(u16, softirq_pending);

This can also be a drawback if it's abused by random driver code - so I 
think it should at minimum be documented to be used by core & arch 
code. Maybe add a build #error too if it's defined in modular code?

Other variants like DEFINE_PER_CPU_SHARED_ALIGNED aren't being abused 
really AFAICS, so maybe this isn't too much of a concern.

One potential drawback would be that previously the section was 
hand-ordered:

 struct pcpu_hot {
        union {
                struct {
                        struct task_struct      *current_task;
                        int                     preempt_count;
                        int                     cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
                        u64                     call_depth;
 #endif
                        unsigned long           top_of_stack;
                        void                    *hardirq_stack_ptr;
                        u16                     softirq_pending;
 #ifdef CONFIG_X86_64
                        bool                    hardirq_stack_inuse;
 #else
                        void                    *softirq_stack_ptr;
 #endif
                };
                u8      pad[64];
        };
 };

... while now it's linker-ordered. But on the other hand that can be an 
advantage too: the linker will try to (or at least has a chance to) 
order the fields optimally for cache density, while the hand-packing 
always has the potential to bitrot without much of an outside, 
actionable indicator for the bitrot.

One naming suggestion, wouldn't it be better to make it explicit that 
the 'hot' qualifier is about cache locality:

  +DEFINE_PER_CPU_CACHE_HOT(u16, softirq_pending);

Makes it more of a mouthful to write definitions/declarations, but the 
actual per-cpu usage sites are unaffected as this too is otherwise part 
of the generic percpu namespace.

... and yes, DEFINE_PER_CPU_ALIGNED should probably have been named 
DEFINE_PER_CPU_CACHE_ALIGNED too. (Because 'aligned' often means 
machine word unit, so the naming is a bit ambiguous.)

I.e. in an ideal world the complete set of DEFINE_PER_CPU_XXX 
attributes should be something like:

 DEFINE_PER_CPU_CACHE_HOT
 DEFINE_PER_CPU_CACHE_ALIGNED		# was: DEFINE_PER_CPU_ALIGNED
 DEFINE_PER_CPU_CACHE_ALIGNED_SHARED	# was: DEFINE_PER_CPU_SHARED_ALIGNED

 DEFINE_PER_CPU_PAGE_ALIGNED

 DEFINE_PER_CPU_READ_MOSTLY
 DEFINE_PER_CPU_DECRYPTED

But I digress...

Anyway, I've Cc:-ed various potentially interested parties, please 
speak up now or forever hold your peace. ;-)

Thanks,

	Ingo

