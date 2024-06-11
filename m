Return-Path: <linux-kernel+bounces-209289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D585903157
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0C7B25594
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A756170854;
	Tue, 11 Jun 2024 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OIhGMK4P"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B17170842
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084086; cv=none; b=FxsU0869G4C1fbEjBWNIllwhrRIZb4RoyNToQPmCdoeaZiBIyvbNvWDTUN2vsXR+gMYr5TlU7esRP7Z+UP96sLafyOB/eIUZuFLIkf1RqPHs+S8ieM7UjlnmKcGhat/VYUrA3CCEf4kXRcjjdAQt2lU+uJskB0l1L9a3mm/uwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084086; c=relaxed/simple;
	bh=9J7IXL2tR/HWJAYeIeighdUWzQYTWvM0VZ7G825aOVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WP3PD4CHFXy31+v+Gn5fgD1TsnuSU4naA4AZI+39zkdERhYril+WA/nBseA2EbxlZmR8qNetqFYzudd+R0C/1dwGthZ1877SVFJviZI5qGQQbX4kNFZrymOZ/l4VFFx0zrOHqkHQoz/uaPfaUSAH36CRDd8TftkG1KMLBqQ0ohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=OIhGMK4P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62ce4752da4so27036717b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718084084; x=1718688884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cotibSR88KSJRDSISnN+uzectoJVXRRFz4iGDTSfjtY=;
        b=OIhGMK4PHLRwUkjbkvod5iW++LJRpcNrvmkgdkRO2R6ObvAYygReHPQrGJQI5ZlHHY
         YleKub9SgIDUr9kYWWv762NXaQMig2WmmHduyyd3qy+QK3piKBbv5PR91PGnEbg1tPvL
         UA8qPJYVh72vwrKwk36/2jS37NNClPH3zcQ+xv7of0d5c3fSsoST7Dp12PqghbwxcTni
         1oJw2yuDdcKWTqtLpumJY/OYRUQEkeB2WyGnLnyVyaA7IPg99VZx+Ucr8N0/zmguZyMe
         5N6wxg71/vlUmHLhNgqo0O/oF8GTE66ugMM9bQ/VXnDB2VU5qWZpidbjtYd8OVQ51kWr
         XKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718084084; x=1718688884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cotibSR88KSJRDSISnN+uzectoJVXRRFz4iGDTSfjtY=;
        b=N6g81eQTNF8FAkHGCbMiHsBPjIOk1UMBkkSG6qberxp/lObrwwwedkOERivm0qhgMl
         yol9S9Rmp9PBdFp+25nMLnWlaEhv47duyIlShxIZkz1+x8jEsdVnBlF6HaPyVuCl1RjJ
         FLYGrRGpU8fsUCOn4G+7cUeALaPhohiaCQWa0YgFBJJ/vtGtQBud89Kbiu4Lpy/ZSCpO
         hRsb565eW5ulcI+u27RA7ENm9R9pG9+b/a26RLW6bjtWQPbrnWHjHNYINFPlQTFjhal5
         2XEayOlqb4HJ+G8SYy3jvCneva0QPSK9XonIuEnqmurzb2Yj6CIWIvrin2KG3C3GkNS9
         +tzw==
X-Forwarded-Encrypted: i=1; AJvYcCXyP6oNh6aF+BiapHip2PgNcgLWEAPK8zdszKvHTDQJRZQGS+P0dSzIhSKXRCN11ur8aKX1KrlBbM3AJUlwye4bpY82cIeFspcZm02p
X-Gm-Message-State: AOJu0YzrOUJvpYd0CGHkH8SqT/yuoSV5bm9qfDJjhmVBmcE6kf5Xs5MU
	PsfMH01ZZV/YFi619WBwUkeJ7i+6JdNTpHcSZdpaNym7EXqeU7X+g4XBICXoW5p+BYjXN+AhdRo
	mnuFY25QCcDXXtBt8CO9EgqjXgjMNFs2E7N16vw==
X-Google-Smtp-Source: AGHT+IFrvo12EQWYRkJlI/38/OsH77Ne92FxFgTHcxuhUmxYnBkzA+n/nTJVBal2Aef0Wvqa2QUYKpcoXkumR6u+W3c=
X-Received: by 2002:a05:690c:d95:b0:62f:206e:c056 with SMTP id
 00721157ae682-62f206ec3eemr544897b3.5.1718084083681; Mon, 10 Jun 2024
 22:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530001733.1407654-1-samuel.holland@sifive.com> <20240530001733.1407654-4-samuel.holland@sifive.com>
In-Reply-To: <20240530001733.1407654-4-samuel.holland@sifive.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Tue, 11 Jun 2024 13:34:32 +0800
Message-ID: <CABgGipXz77=nyXv9uQ7DKqYH1HkMxxFTbK2qHE202AeXq7Mm-g@mail.gmail.com>
Subject: Re: [PATCH 3/4] riscv: entry: Do not clobber the frame pointer
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Matthew Bystrin <dev.mbstr@gmail.com>, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Thu, May 30, 2024 at 8:17=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> s0 is reserved for the frame pointer, so it should not be used as a
> temporary register. Clobbering the frame pointer breaks stack traces.
>
> - In handle_exception() and ret_from_exception(), use a2 for the saved
>   stack pointer. a2 is chosen because r2 is the stack pointer register.
> - In ret_from_exception(), use s1 for the saved status CSR value. Avoid
>   clobbering s1 in the privilege mode check so it does not need to be
>   reloaded later in the function.
> - Use s1 and s2 in ret_from_fork() instead of s0 and s1. The entire
>   p->thread.s array is zeroed at the beginning of copy_thread(), so the
>   registers do not need to be zeroed separately for kernel threads.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>  arch/riscv/kernel/entry.S   | 29 ++++++++++++++---------------
>  arch/riscv/kernel/process.c |  5 ++---
>  2 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index d13d1aad7649..bd1c5621df45 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -58,13 +58,13 @@ SYM_CODE_START(handle_exception)
>          */
>         li t0, SR_SUM | SR_FS_VS
>
> -       REG_L s0, TASK_TI_USER_SP(tp)
> +       REG_L a2, TASK_TI_USER_SP(tp)
>         csrrc s1, CSR_STATUS, t0
>         csrr s2, CSR_EPC
>         csrr s3, CSR_TVAL
>         csrr s4, CSR_CAUSE
>         csrr s5, CSR_SCRATCH
> -       REG_S s0, PT_SP(sp)
> +       REG_S a2, PT_SP(sp)
>         REG_S s1, PT_STATUS(sp)
>         REG_S s2, PT_EPC(sp)
>         REG_S s3, PT_BADADDR(sp)
> @@ -125,19 +125,19 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>         call riscv_v_context_nesting_end
>  #endif
>
> -       REG_L s0, PT_STATUS(sp)
> +       REG_L s1, PT_STATUS(sp)
>  #ifdef CONFIG_RISCV_M_MODE
>         /* the MPP value is too large to be used as an immediate arg for =
addi */
>         li t0, SR_MPP
> -       and s0, s0, t0
> +       and t0, s1, t0
>  #else
> -       andi s0, s0, SR_SPP
> +       andi t0, s1, SR_SPP
>  #endif
> -       bnez s0, 1f
> +       bnez t0, 1f
>
>         /* Save unwound kernel stack pointer in thread_info */
> -       addi s0, sp, PT_SIZE_ON_STACK
> -       REG_S s0, TASK_TI_KERNEL_SP(tp)
> +       addi t0, sp, PT_SIZE_ON_STACK
> +       REG_S t0, TASK_TI_KERNEL_SP(tp)
>
>         /* Save the kernel shadow call stack pointer */
>         scs_save_current
> @@ -148,7 +148,6 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>          */
>         csrw CSR_SCRATCH, tp
>  1:
> -       REG_L a0, PT_STATUS(sp)
>         /*
>          * The current load reservation is effectively part of the proces=
sor's
>          * state, in the sense that load reservations cannot be shared be=
tween
> @@ -169,7 +168,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>         REG_L  a2, PT_EPC(sp)
>         REG_SC x0, a2, PT_EPC(sp)
>
> -       csrw CSR_STATUS, a0
> +       csrw CSR_STATUS, s1
>         csrw CSR_EPC, a2
>
>         REG_L x1,  PT_RA(sp)
> @@ -207,13 +206,13 @@ SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
>         REG_S x5,  PT_T0(sp)
>         save_from_x6_to_x31
>
> -       REG_L s0, TASK_TI_KERNEL_SP(tp)
> +       REG_L a2, TASK_TI_KERNEL_SP(tp)
>         csrr s1, CSR_STATUS
>         csrr s2, CSR_EPC
>         csrr s3, CSR_TVAL
>         csrr s4, CSR_CAUSE
>         csrr s5, CSR_SCRATCH
> -       REG_S s0, PT_SP(sp)
> +       REG_S a2, PT_SP(sp)
>         REG_S s1, PT_STATUS(sp)
>         REG_S s2, PT_EPC(sp)
>         REG_S s3, PT_BADADDR(sp)
> @@ -227,10 +226,10 @@ ASM_NOKPROBE(handle_kernel_stack_overflow)
>
>  SYM_CODE_START(ret_from_fork)
>         call schedule_tail
> -       beqz s0, 1f     /* not from kernel thread */
> +       beqz s1, 1f     /* not from kernel thread */
>         /* Call fn(arg) */
> -       move a0, s1
> -       jalr s0
> +       move a0, s2
> +       jalr s1
>  1:
>         move a0, sp /* pt_regs */
>         la ra, ret_from_exception
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index e4bc61c4e58a..5512c31e1256 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -208,8 +208,8 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>                 /* Supervisor/Machine, irqs on: */
>                 childregs->status =3D SR_PP | SR_PIE;
>
> -               p->thread.s[0] =3D (unsigned long)args->fn;
> -               p->thread.s[1] =3D (unsigned long)args->fn_arg;
> +               p->thread.s[1] =3D (unsigned long)args->fn;
> +               p->thread.s[2] =3D (unsigned long)args->fn_arg;
>         } else {
>                 *childregs =3D *(current_pt_regs());
>                 /* Turn off status.VS */
> @@ -219,7 +219,6 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>                 if (clone_flags & CLONE_SETTLS)
>                         childregs->tp =3D tls;
>                 childregs->a0 =3D 0; /* Return value of fork() */
> -               p->thread.s[0] =3D 0;
>         }
>         p->thread.riscv_v_flags =3D 0;
>         if (has_vector())
> --
> 2.44.1
>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

Cheers,
Andy

