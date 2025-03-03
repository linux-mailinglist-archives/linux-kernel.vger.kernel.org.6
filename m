Return-Path: <linux-kernel+bounces-542716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8168BA4CCCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D611893285
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C07235362;
	Mon,  3 Mar 2025 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5geYHre"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA81F3B97
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034344; cv=none; b=eWkY+XTcBjjIq1okNwaj6FTkC4PQ3gcDJ8qlDu2GxvORJW7YlC0w6VgdV8lGnQ1Jg+dyUGsO1wb9SM80BdhEGWe9i2d3ZBNVNBbxjl6kfZ7ZTYgS45LxmMWberWPnndLwIIf3NgIb9IeSY87r4AHPbDe5R5WGYcJK4QX5F0LI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034344; c=relaxed/simple;
	bh=FKAENEmdxRxO0niyYat4E6UU2NzH/B8FWEUJNxcOZXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHbyM4YiZV+rMmoATh3qccijO0FdkFd5qz/9xSdHYoF69/ABfQDrd3WoNHZjc7c2GKk8ntgFK/KCsxU62cxbphxcb0y+quSXEk946IkNhVZbtdQOIlduzOm/Cgb3M6zMH6qbmPqxbB+IsNtbiyRB40hUlUdKvYJd2aWaJIkJgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5geYHre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CE8C4CED6;
	Mon,  3 Mar 2025 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741034343;
	bh=FKAENEmdxRxO0niyYat4E6UU2NzH/B8FWEUJNxcOZXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5geYHremFVRHjmjiqtTuFyBmo5uHhb2y2SVrAcPjJfno6mPsvjtcHv+5gt94fK6o
	 q0oTl18wifT2E+j8cQ9f3Dgrgi0OSrsH4cLzOSqRwfkKq0Vkc/xNuhDutCX8wimNlf
	 MLD660xKZRX62DS0JohYmuVqR1XOfuPKc7N7Yi18BN+RpP9MYzThWhc5bpGgK3Jd05
	 iutjxVoZmZYh1qNVK5120feERnMi0bjLyAjUIvwKJPZSVChO82cdZqn8TexcdUeipI
	 cqfonDSYID9sinn2uMIca3iR43c7ZVcvXfG175n5tgPX8AAlqQ2PywhIGv41mFU0cv
	 +N5ICzmh52G+w==
Date: Mon, 3 Mar 2025 21:38:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
Message-ID: <Z8YTYWs-DeDHal1Q@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> Add a new percpu subsection for data that is frequently accessed and
> exclusive to each processor.  This replaces the pcpu_hot struct on x86,
> and is available to all architectures and the core kernel.
> 
> ffffffff834f5000 D __per_cpu_hot_start
> ffffffff834f5000 D hardirq_stack_ptr
> ffffffff834f5008 D __ref_stack_chk_guard
> ffffffff834f5008 D __stack_chk_guard
> ffffffff834f5010 D const_cpu_current_top_of_stack
> ffffffff834f5010 D cpu_current_top_of_stack
> ffffffff834f5018 D const_current_task
> ffffffff834f5018 D current_task
> ffffffff834f5020 D __x86_call_depth
> ffffffff834f5028 D this_cpu_off
> ffffffff834f5030 D __preempt_count
> ffffffff834f5034 D cpu_number
> ffffffff834f5038 D __softirq_pending
> ffffffff834f503a D hardirq_stack_inuse
> ffffffff834f503b D __per_cpu_hot_pad
> ffffffff834f5040 D __per_cpu_hot_end
> 
> This applies to the tip/x86/asm branch.
> 
> Changes in v3:
> - Fix typo of CACHE_HOT_DATA()
> - Move hardirq_stack_inuse to irq_64.c
> - Add __per_cpu_hot_pad to show the end of the actual data
> 
> Brian Gerst (11):
>   percpu: Introduce percpu hot section
>   x86/percpu: Move pcpu_hot to percpu hot section
>   x86/preempt: Move preempt count to percpu hot section
>   x86/smp: Move cpu number to percpu hot section
>   x86/retbleed: Move call depth to percpu hot section
>   x86/softirq: Move softirq_pending to percpu hot section
>   x86/irq: Move irq stacks to percpu hot section
>   x86/percpu: Move top_of_stack to percpu hot section
>   x86/percpu: Move current_task to percpu hot section
>   x86/stackprotector: Move __stack_chk_guard to percpu hot section
>   x86/smp: Move this_cpu_off to percpu hot section

>  31 files changed, 146 insertions(+), 111 deletions(-)

Yeah, so the result is that on x86-64 allmodconfig we now get:

  ld: percpu cache hot section too large

See the relevant .tmp_vmlinux1.map below.

Which is due to:

   CONFIG_X86_INTERNODE_CACHE_SHIFT=12

Increasing 'cache alignment' to 4096 bytes:

        PERCPU_SECTION(INTERNODE_CACHE_BYTES)

... because of the vSMP muck:

  config X86_INTERNODE_CACHE_SHIFT
        int
        default "12" if X86_VSMP
        default X86_L1_CACHE_SHIFT

The workaround would be to use L1_CACHE_BYTES in, but I really dislike 
what vSMP is doing here.

Anyway, I applied the short-term fix to patch 02/11, but I'm not sure 
it's the right fix.

Thanks,

	Ingo

=====================>
                0xffffffff8664f000                . = ALIGN (0x1000)
                0xffffffff8664f000                __per_cpu_hot_start = .
 *(SORT_BY_ALIGNMENT(.data..percpu..hot.*))
 .data..percpu..hot..hardirq_stack_ptr
                0xffffffff8664f000        0x8 vmlinux.o
                0xffffffff8664f000                hardirq_stack_ptr
 .data..percpu..hot..__stack_chk_guard
                0xffffffff8664f008        0x8 vmlinux.o
                0xffffffff8664f008                __stack_chk_guard
 .data..percpu..hot..cpu_current_top_of_stack
                0xffffffff8664f010        0x8 vmlinux.o
                0xffffffff8664f010                cpu_current_top_of_stack
 .data..percpu..hot..current_task
                0xffffffff8664f018        0x8 vmlinux.o
                0xffffffff8664f018                current_task
 .data..percpu..hot..__x86_call_depth
                0xffffffff8664f020        0x8 vmlinux.o
                0xffffffff8664f020                __x86_call_depth
 .data..percpu..hot..this_cpu_off
                0xffffffff8664f028        0x8 vmlinux.o
                0xffffffff8664f028                this_cpu_off
 .data..percpu..hot..__preempt_count
                0xffffffff8664f030        0x4 vmlinux.o
                0xffffffff8664f030                __preempt_count
 .data..percpu..hot..cpu_number
                0xffffffff8664f034        0x4 vmlinux.o
                0xffffffff8664f034                cpu_number
 .data..percpu..hot..__softirq_pending
                0xffffffff8664f038        0x2 vmlinux.o
                0xffffffff8664f038                __softirq_pending
 .data..percpu..hot..hardirq_stack_inuse
                0xffffffff8664f03a        0x1 vmlinux.o
                0xffffffff8664f03a                hardirq_stack_inuse
                0xffffffff8664f03b                __per_cpu_hot_pad = .
                0xffffffff86650000                . = ALIGN (0x1000)
 *fill*         0xffffffff8664f03b      0xfc5 
                0xffffffff86650000                __per_cpu_hot_end = .
 *(.data..percpu..read_mostly)
 .data..percpu..read_mostly
                0xffffffff86650000      0xa30 vmlinux.o

=================>

 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9ac6b42701fa..31f9102b107f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -330,7 +330,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
+	PERCPU_SECTION(L1_CACHE_BYTES)
 	ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <= 64, "percpu cache hot section too large")
 
 	RUNTIME_CONST_VARIABLES


