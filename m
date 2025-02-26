Return-Path: <linux-kernel+bounces-534866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3753A46C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176173B3BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E332755F6;
	Wed, 26 Feb 2025 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBzra++V"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFC02755F0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600498; cv=none; b=fq9Q+MaOw63x0sYzQv49aivVpiM+ewmeI14jcVv/oeO5XgURAsjQR8og5PlHYVWKoGc4HL4KFHtTrz7D+4kpu0SRUw/sV6sBx3M7vwuUOB/kCgPI8YTFK8lMVH/zdGABmA9bLsZDVwbQy1bkuxkV+b699tZoUwLAhJJ6+hKwmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600498; c=relaxed/simple;
	bh=VqyBoVnbdYoDVanLk+Pb9vBV+DONTnFvxhCnDC7ri8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6LugQ7hdpc9ezOn/yk1rychEaA/nSUODB9Rygx+bKBohtVItz5AbxtkwrF/3mzGl4E/q0QlHJ1vE/i35vBjLWgPZKhKbhfMDXAgFbNqwktoOW3p4zvdvWdL+206g1O7Z9/DnvqJWkQnhNCbfvfe8ezM8Xcw6H3c+vElyrgwPek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBzra++V; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-307c13298eeso3140641fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600495; x=1741205295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD5wMmXhknkXEjEekUf2HCsGMo+y7LLTruXjjEmauLE=;
        b=TBzra++Vfw5wcKxDEZs5F6CdnDP6dkynYuZw5JCLvbDX7yw83AzBYilF07+pWuNYXI
         u0wKGINRWO3db5Lkv9UWHrxRSf7WeIQE8IIvR0zGnfTr+a32WjUIbtWmzzM+NhfL19on
         OGmhPVXKqbY6BOeOYsxi3EqhEyRUvxYKONVkNft/Ispdm/UaBGAv9tiNvRxsECHVg/mN
         BbBgPrIIFEJT3zXRheLdmwy0iJlvMIbyF1qMeh9oXfIsGNwXnZymU9sx6Is2vtlFgGsG
         NL+YMvMgI1Y8sjayrStVH5rXnsyjdo07cDPyBn297brzmn8xKFDMk+1CwjEZdWAP7gQL
         IKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600495; x=1741205295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD5wMmXhknkXEjEekUf2HCsGMo+y7LLTruXjjEmauLE=;
        b=V40JNrTmUjXV2STj9AE56LtLikcNm9y85tROf6vMNnSCYSWxebRZESZwITCqOlpVXm
         VR48pz6ScpaIqVPoJUtQ0MYtYUrUESIDLifbMPtaZsnWBcW2bhclF99eDUMhsAs9Sm6c
         aMUkr8W7iRuzi6k6LNTpUrYwAggw43p/pu75pUbjdMzIBPWT66wB9VtqNItvzZgI8dzK
         eJUprLJCTtMIhq5m+HhDFK+fvLng751SIO1y2XSsr5Vu1TaepdB2KdqKwI3rcBo4F+2J
         ewUPQ2b69mpnU0WIFBaiTnl3myPde7hUa2Rh7foDcMRPJvLn2RNqxCpMU4ptlJDoLbNh
         wj7Q==
X-Gm-Message-State: AOJu0YyW5IsQwN11DteWY44mJdbzBAtORITCS+npIsTmOoEDGkJ35kkl
	daptp4KbUKHASmlbXHt6Bg8bNlg41oaqth0fSVngcSevgb/sZSGlNr5OmgJ3Wk39wwPLBNCRDQR
	AaPtDNH7AZ/DmaZf3F36Cz/ZxyRM=
X-Gm-Gg: ASbGncsYx7mFUF6cuiDYBHnpgzrE0onKUzIK8DpiWhnbeNnuzxvfrCZuG56IvhmbGad
	KA70zNcnl6T5PtUk8wMedNUu+nrONkxtoDThtR18eyHt0fHiHG3+104vy5ediKU2hxg1UPkfn0o
	Ri+/4H5BI=
X-Google-Smtp-Source: AGHT+IFRiJ0qNVfah6Zvym9h2cD+hwf82GeX4SkBF3w5Skjf8pSRJaV1g4sFKzfRxMSJb27GJIOfAjjq57Did7PWE9k=
X-Received: by 2002:a2e:ad0b:0:b0:309:2999:77d4 with SMTP id
 38308e7fff4ca-30b84650d3dmr3263481fa.6.1740600494454; Wed, 26 Feb 2025
 12:08:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226180531.1242429-1-brgerst@gmail.com> <20250226180531.1242429-9-brgerst@gmail.com>
In-Reply-To: <20250226180531.1242429-9-brgerst@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Feb 2025 21:08:02 +0100
X-Gm-Features: AQ5f1JqJrMZ52eZTlZhMhcHdBQnM1PRTSkVUBJPdgOFfMEZF4t_eSVGF4M3iOrU
Message-ID: <CAFULd4Z3o18zRebbqTgNH9QrPkoSLtbS=_mZGfheJYoeMawUaw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] x86/percpu: Move top_of_stack to percpu hot section
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:06=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> No functional change.
>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/entry/entry_32.S        | 4 ++--
>  arch/x86/entry/entry_64.S        | 6 +++---
>  arch/x86/entry/entry_64_compat.S | 4 ++--
>  arch/x86/include/asm/current.h   | 1 -
>  arch/x86/include/asm/percpu.h    | 2 +-
>  arch/x86/include/asm/processor.h | 8 ++++++--
>  arch/x86/kernel/asm-offsets.c    | 1 -
>  arch/x86/kernel/cpu/common.c     | 3 ++-
>  arch/x86/kernel/process_32.c     | 4 ++--
>  arch/x86/kernel/process_64.c     | 2 +-
>  arch/x86/kernel/smpboot.c        | 2 +-
>  arch/x86/kernel/vmlinux.lds.S    | 1 +
>  12 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 20be5758c2d2..92c0b4a94e0a 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1153,7 +1153,7 @@ SYM_CODE_START(asm_exc_nmi)
>          * is using the thread stack right now, so it's safe for us to us=
e it.
>          */
>         movl    %esp, %ebx
> -       movl    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esp
> +       movl    PER_CPU_VAR(cpu_current_top_of_stack), %esp
>         call    exc_nmi
>         movl    %ebx, %esp
>
> @@ -1217,7 +1217,7 @@ SYM_CODE_START(rewind_stack_and_make_dead)
>         /* Prevent any naive code from trying to unwind to our caller. */
>         xorl    %ebp, %ebp
>
> -       movl    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %esi
> +       movl    PER_CPU_VAR(cpu_current_top_of_stack), %esi
>         leal    -TOP_OF_KERNEL_STACK_PADDING-PTREGS_SIZE(%esi), %esp
>
>         call    make_task_dead
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 33a955aa01d8..9baf32a7a118 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -92,7 +92,7 @@ SYM_CODE_START(entry_SYSCALL_64)
>         /* tss.sp2 is scratch space. */
>         movq    %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
>         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rsp
> -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>
>  SYM_INNER_LABEL(entry_SYSCALL_64_safe_stack, SYM_L_GLOBAL)
>         ANNOTATE_NOENDBR
> @@ -1166,7 +1166,7 @@ SYM_CODE_START(asm_exc_nmi)
>         FENCE_SWAPGS_USER_ENTRY
>         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rdx
>         movq    %rsp, %rdx
> -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>         UNWIND_HINT_IRET_REGS base=3D%rdx offset=3D8
>         pushq   5*8(%rdx)       /* pt_regs->ss */
>         pushq   4*8(%rdx)       /* pt_regs->rsp */
> @@ -1484,7 +1484,7 @@ SYM_CODE_START_NOALIGN(rewind_stack_and_make_dead)
>         /* Prevent any naive code from trying to unwind to our caller. */
>         xorl    %ebp, %ebp
>
> -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rax
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rax
>         leaq    -PTREGS_SIZE(%rax), %rsp
>         UNWIND_HINT_REGS
>
> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_c=
ompat.S
> index ed0a5f2dc129..a45e1125fc6c 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -57,7 +57,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
>         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rax
>         popq    %rax
>
> -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>
>         /* Construct struct pt_regs on stack */
>         pushq   $__USER_DS              /* pt_regs->ss */
> @@ -193,7 +193,7 @@ SYM_CODE_START(entry_SYSCALL_compat)
>         SWITCH_TO_KERNEL_CR3 scratch_reg=3D%rsp
>
>         /* Switch to the kernel stack */
> -       movq    PER_CPU_VAR(pcpu_hot + X86_top_of_stack), %rsp
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>
>  SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
>         ANNOTATE_NOENDBR
> diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/curren=
t.h
> index 6fad5a4c21d7..3d1b123c2ee3 100644
> --- a/arch/x86/include/asm/current.h
> +++ b/arch/x86/include/asm/current.h
> @@ -14,7 +14,6 @@ struct task_struct;
>
>  struct pcpu_hot {
>         struct task_struct      *current_task;
> -       unsigned long           top_of_stack;
>  };
>
>  DECLARE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot);
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.=
h
> index 7cb4f64b2e60..044410462d36 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -554,7 +554,7 @@ do {                                                 =
                       \
>   * it is accessed while this_cpu_read_stable() allows the value to be ca=
ched.
>   * this_cpu_read_stable() is more efficient and can be used if its value
>   * is guaranteed to be valid across CPUs.  The current users include
> - * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
> + * pcpu_hot.current_task and cpu_current_top_of_stack, both of which are
>   * actually per-thread variables implemented as per-CPU variables and
>   * thus stable for the duration of the respective task.
>   */
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 54fce8d7504d..b4d51de071f2 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -427,6 +427,10 @@ DECLARE_PER_CPU_CACHE_HOT(bool, hardirq_stack_inuse)=
;
>  DECLARE_PER_CPU_CACHE_HOT(struct irq_stack *, softirq_stack_ptr);
>  #endif
>
> +DECLARE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack);
> +/* const-qualified alias provided by the linker. */
> +DECLARE_PER_CPU_CACHE_HOT(const unsigned long __percpu_seg_override, con=
st_cpu_current_top_of_stack);

Please split the above line, like you did with const_current_task declarati=
on.

Uros.

