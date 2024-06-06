Return-Path: <linux-kernel+bounces-203828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A748FE0F9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877231C23827
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AEF13C690;
	Thu,  6 Jun 2024 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLJukwDZ"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E89C1DDF5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662666; cv=none; b=enpR0rVSLTF92P5BuLOC6tbcSLyt1oE8ES+AkI1RyFBDpVRmVOHo06lxPntAxFLvfwC1H5oDNAeVEVPOh4Y0gbbV6kscN5kT0/jVoIS4EAIfVFf3vtaTgYXS/10pLl04Ig9hI4pM5gHM+KFr2SRui3GXUWs6GpOMfa2gOyWVQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662666; c=relaxed/simple;
	bh=3JRhOtjQp6XWQBITHCADEEQ3bdyOEsXbCaposfdMkYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrT3989+kF8dwX3TOPTOm6CAsKgpzU3NKo4emW4lmJe3dICbAfiSXoKwM+g5Fw7wZfjV6M/kGNC2Gz5yvuMk+Kl0ngDiMemn+fL9LQ9ozjx9DpQq2l96OTEDtJBHDkYd4YhEBZjrxurBJ7H36tOtEhpS7D2UYlIn1X1ZDjmEL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLJukwDZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35ef3a037a0so311466f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717662662; x=1718267462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvPjvPVzmHEuJP2lMNchMySQh4QTQAmKpk+Itak28sU=;
        b=gLJukwDZ4kK0t2FgGVXrwynwBLycWxpnolEzMyZoM/TtTPw0K8/4QaNWHh3nxlBKnm
         C5JEUVvRIUprNIDHJ/hSpKQSCr2vUqg+4iLci53fYAlJm+jcVBX77bv1g8TP9E3SEPlI
         F9AxtBBvO5giTHpUmRqxA1aXTT5Vg5DlLVjbDN1Ohrubk/z0rbEzcWCv9Gx1Yr/wK+Ae
         ZW7/aBDjToV25U0IGfhUnnPrXdgeJyjLyh9/f9EYOnj3LoAgxJ1TaeGO4cMUSqyjABvx
         lJwANdiUt7Hu6o2ur/Pi1jCI4W/Q25Uqkpf82l8zbzXVM8r5id4uoQSjvKL4sN+5O60t
         LLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662662; x=1718267462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvPjvPVzmHEuJP2lMNchMySQh4QTQAmKpk+Itak28sU=;
        b=fazbH15AkR+aE0hKtu4JOfHM2y6LD+FxKfN3ANadJhcrPMqpgXDJPRAMU+ZZuaBeCO
         xx3efCN8t8JpAafMoNOU1HXVLSSXgVcJCXum8FAQ/H1uBSC3KqoZSjyApmQum8frh2Hc
         zMSMr3Fq1ebAUusuiGqLIpz64jGoBDULHNLVKKYQ60kQPeQyGR2WiIbb5m5F4axQhPcz
         jhwvdk7np9SNtuLIjNLa0jV9u6pBh9TBn9VevKjMy9CLZXrbuHG52xxcEjatHcdrgUW1
         KEYvJC16tabuP6tjLRGORT8oDavbTPHUA3tZ5wWTheBQwIMKbNRJZbIyw6vp1hheHKEt
         0YfA==
X-Forwarded-Encrypted: i=1; AJvYcCUtnEj75EZwOBCYWNPgGjcf9vLuzafxXMAOe4vPtbvS4K9OM8FHvAI3K771mR4/4DZQ4Q7Ayw0ndBzWgQg9/NnpfH1PfA0W0KyaqoXb
X-Gm-Message-State: AOJu0Yw/Ng2g7aN0OPEN7kHKerklF0KuL+D84hNUAnAQtWtprQvMno2h
	VjGC0nyG4FdRHbXDjjTr50SMSaUlGHitK1qWJzt9xBqNIKrSsjWDbjevcrzV
X-Google-Smtp-Source: AGHT+IF3owUHIv+1XwNKtIBJAiuBSCg78musHqrkBVmraK1LmrG+rLKezT9jR5bBKvyz15YTiZ5iCA==
X-Received: by 2002:adf:ce85:0:b0:35e:4d47:b5b8 with SMTP id ffacd0b85a97d-35ef0dc9b35mr1638144f8f.27.1717662662015;
        Thu, 06 Jun 2024 01:31:02 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4216008bceesm1361125e9.1.2024.06.06.01.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:31:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 6 Jun 2024 10:30:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 3/3, v4] x86/fpu: Remove init_task FPU state dependencies,
 add debugging warning for PF_KTHREAD tasks
Message-ID: <ZmFziN0i10sILaIo@gmail.com>
References: <20240605083557.2051480-1-mingo@kernel.org>
 <20240605083557.2051480-4-mingo@kernel.org>
 <20240605141733.GC25006@redhat.com>
 <CAHk-=wi4773Ls82kqVbPmM1deghS2NXkHNCCzWPc270kcByXPA@mail.gmail.com>
 <20240605162610.GF25006@redhat.com>
 <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2zJgy69j8n6C9T4YARkxcJ09SFkpMiqrCqhChf0s3NQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 5 Jun 2024 at 09:27, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Yes, but kernel_fpu_begin() never does save_fpregs_to_fpstate() if
> > current->flags & PF_KTHREAD ?
> 
> Ahh, and init_thread does have PF_KTHREAD.
> 
> Ok, looks fine to me, except I think the commit message should be cleared up.
> 
> The whole sentence about
> 
>  "But the init task isn't supposed to be using the FPU in any case ..."
> 
> is just simply not true.
>
> It should be more along the lines of "kernel threads don't need an FPU
> save area, because their FPU use is not preemptible or reentrant and
> they don't return to user space".

Indeed - I fixed & clarified the changelog accordingly - see the new patch 
further below.

I changed the debug check to test for PF_KTHREAD, and to return NULL:

+#ifdef CONFIG_X86_DEBUG_FPU
+struct fpu *x86_task_fpu(struct task_struct *task)
+{
+	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
+		return NULL;
+
+	return (void *)task + sizeof(*task);
+}
+#endif

... and the NULL we return will likely crash & exit any kthreads attempting 
to use the FPU context area - which I think is preferable to returning 
invalid memory that may then be corrupted.

Hopefully this remains a hypothethical concern. :-)

Alternatively, this may be one of the very few cases where a BUG_ON() might 
be justified? This condition is not recoverable in any sane fashion IMO.

Thanks,

	Ingo

============================>
From: Ingo Molnar <mingo@kernel.org>
Date: Wed, 5 Jun 2024 10:35:57 +0200
Subject: [PATCH] x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks

init_task's FPU state initialization was a bit of a hack:

		__x86_init_fpu_begin = .;
		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
		__x86_init_fpu_end = .;

But the init task isn't supposed to be using the FPU context
in any case, so remove the hack and add in some debug warnings.

As Linus noted in the discussion, the init task (and other
PF_KTHREAD tasks) *can* use the FPU via kernel_fpu_begin()/_end(),
but they don't need the context area because their FPU use is not
preemptible or reentrant, and they don't return to user-space.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20240605083557.2051480-4-mingo@kernel.org
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/fpu/core.c       | 13 ++++++++++---
 arch/x86/kernel/fpu/init.c       |  5 ++---
 arch/x86/kernel/fpu/xstate.c     |  3 ---
 arch/x86/kernel/vmlinux.lds.S    |  4 ----
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 249c5fa20de4..ed8981866f4d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -504,7 +504,11 @@ struct thread_struct {
 #endif
 };
 
-#define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
+#ifdef CONFIG_X86_DEBUG_FPU
+extern struct fpu *x86_task_fpu(struct task_struct *task);
+#else
+# define x86_task_fpu(task) ((struct fpu *)((void *)task + sizeof(*task)))
+#endif
 
 /*
  * X86 doesn't need any embedded-FPU-struct quirks:
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 0ccabcd3bf62..d9ff8ca5b32d 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -51,6 +51,16 @@ static DEFINE_PER_CPU(bool, in_kernel_fpu);
  */
 DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
+#ifdef CONFIG_X86_DEBUG_FPU
+struct fpu *x86_task_fpu(struct task_struct *task)
+{
+	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
+		return NULL;
+
+	return (void *)task + sizeof(*task);
+}
+#endif
+
 /*
  * Can we use the FPU in kernel mode with the
  * whole "kernel_fpu_begin/end()" sequence?
@@ -591,10 +601,8 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	 * This is safe because task_struct size is a multiple of cacheline size.
 	 */
 	struct fpu *dst_fpu = (void *)dst + sizeof(*dst);
-	struct fpu *src_fpu = x86_task_fpu(current);
 
 	BUILD_BUG_ON(sizeof(*dst) % SMP_CACHE_BYTES != 0);
-	BUG_ON(!src_fpu);
 
 	/* The new task's FPU state cannot be valid in the hardware. */
 	dst_fpu->last_cpu = -1;
@@ -657,7 +665,6 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
 	if (update_fpu_shstk(dst, ssp))
 		return 1;
 
-	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
 	return 0;
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 11aa31410df2..53580e59e5db 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
 	/* Flush out any pending x87 state: */
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU))
-		fpstate_init_soft(&x86_task_fpu(current)->fpstate->regs.soft);
+		;
 	else
 #endif
 		asm volatile ("fninit");
@@ -164,7 +164,7 @@ static void __init fpu__init_task_struct_size(void)
 	 * Subtract off the static size of the register state.
 	 * It potentially has a bunch of padding.
 	 */
-	task_size -= sizeof(x86_task_fpu(current)->__fpstate.regs);
+	task_size -= sizeof(union fpregs_state);
 
 	/*
 	 * Add back the dynamically-calculated register state
@@ -209,7 +209,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpu_kernel_cfg.default_size = size;
 	fpu_user_cfg.max_size = size;
 	fpu_user_cfg.default_size = size;
-	fpstate_reset(x86_task_fpu(current));
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 90b11671e943..1f37da22ddbe 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -844,9 +844,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	if (err)
 		goto out_disable;
 
-	/* Reset the state for the current task */
-	fpstate_reset(x86_task_fpu(current));
-
 	/*
 	 * Update info used for ptrace frames; use standard-format size and no
 	 * supervisor xstates:
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 226244a894da..3509afc6a672 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -170,10 +170,6 @@ SECTIONS
 		/* equivalent to task_pt_regs(&init_task) */
 		__top_init_kernel_stack = __end_init_stack - TOP_OF_KERNEL_STACK_PADDING - PTREGS_SIZE;
 
-		__x86_init_fpu_begin = .;
-		. = __x86_init_fpu_begin + 128*PAGE_SIZE;
-		__x86_init_fpu_end = .;
-
 #ifdef CONFIG_X86_32
 		/* 32 bit has nosave before _edata */
 		NOSAVE_DATA

