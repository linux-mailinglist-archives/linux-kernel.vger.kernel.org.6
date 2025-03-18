Return-Path: <linux-kernel+bounces-566263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E62BAA6759F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22781887B36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4820D518;
	Tue, 18 Mar 2025 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrx7suA/"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375B41527B4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306018; cv=none; b=KjI3U3S7KTlBm93Q0kC/UPpaVZXJnQuBcFHUuVmxWYFXJlsc240HOV0D0p7Ry9T/fgVq2uH6NeLYgvBAgXe0YhrvdU+wmwY0/4wNXPJuTBXPJ2ZOUU7lxLbU6x8CeAR+WUrJyTsNCq8Ykt2SL7G7iXXmna934uOOLg6nMZuAMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306018; c=relaxed/simple;
	bh=BmiUjOIHW0LetIf+bhPGsNHhIFp5NJ5Nkx+CxqmO82U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTj1hz2Hdt7IP5vzdLel9cxY+ay0PYQbo0eAqNODMHjzLcmhI4WqThQG9q3SNlOGYk7yWWuwm6/jK9LJl/YKlhz3G/7egCW0BrCek3F4/MEngsOUj66taYyI1MzoUXK5ZbIElL9/e9OZGQh1O08aSF98SHICFskVWKTNr1Zl8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrx7suA/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c44a87b9cso49567831fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742306014; x=1742910814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeTDU7riPnthYlfxZg8J93Ols2F1vElq1Ehvnp4WS0A=;
        b=jrx7suA/NAIB3dPwsWpPdxwXH9B/0gv7MA4JPlVOkn+0aQY+s9NchDCIWt3PIRHhmA
         ApBBstRX1JkzehQ6HMOoS84wHqNXfc0T9vZGA9Y0Q2qqaGHBwzDxWkT4h8chJPz1UScm
         BidIazjPinoBRlh3w2uEpmVOnf6eRh5x4bQEfXTFC3mAZCnlEOMrmVMNHKos0eyY4aCM
         JJZdOb7hgclHxXcPyYcDrPDfV7tGot5cbRxYphqfh+eWgvB0EzRkckLLnHOk2CcBEW7e
         oHvxzwe5pvXF1oNZwleW1sNDaJ+yWfhadkNepHGaxHX5YsfUd1yNen2PjDHljSuSMCrQ
         YkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306014; x=1742910814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeTDU7riPnthYlfxZg8J93Ols2F1vElq1Ehvnp4WS0A=;
        b=VON7KbP5HlN811KKjQjdj5qjXGwcpGRvHzmRzQoHz5Z9ldW98Xzin9IlYL3RLZmE3z
         +XhJ9G/bH9Xb4D2kzyZHUUzcdgNT/SzOfUimwWLcbueYRxEGe2M+d7iIA4U3g8XjUVMC
         1YRlkAPk+nGYZSh2iKOKkR8z+fnFVGtNqRITBX99FuBeOPckVqAdypuLR3EjJRaKY/um
         6GoB9Y7Hc2WlnG1De0UEesh2jR00N1ZJ1URK5OWfqPwL1FmCQoMP5Qx4iqoBUv7u7KIg
         hFQFhKejTJr/sqxpZX8xThs2KjqTgwhq71Ce+QXHVjW8OVFxbSue0LsEelQljbVBAxNH
         q4Og==
X-Gm-Message-State: AOJu0YwR6Ali/phF1kXMRl11PH9ZLCro0JyZksrWvCx52r9+n8BH1ImM
	QEp6AU8G8x5XvXMDPSWMLyjH1sUqfPbtdbesBc0sgJJCSQIDcMBhnxeQ9WcYg4WkteJTB3dtxio
	Csb5y1DaHjlcr0ZYySoKns5f38Q==
X-Gm-Gg: ASbGncs4yRfvF4iixirD5pw5OrRBDzsXOZbFW5WdJlUaYuo2As1iByFAKum3XGHDwiT
	DXo4ZZQeCTrUBzZiGJQtl3/FZ81gVk0reqga/Ln5mCHkOL1Pfg3p0w1KY0GB2DyS8CqxRp6dukx
	zX+zVqqumkdOQwb6yxuEoxNV1PlBwjutewR4/mAnBl
X-Google-Smtp-Source: AGHT+IFquQxzG0E/aV9Mol2sPTxcTDJYrTB9GiZ/nVBhEuMaPSXynSER9UC1YBO2WG4It0ztjtuOyNa4cnSTv7U0Okw=
X-Received: by 2002:a2e:a7ca:0:b0:30b:f23e:77fb with SMTP id
 38308e7fff4ca-30c4a8761ffmr90357521fa.21.1742306013875; Tue, 18 Mar 2025
 06:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318071947.907364-1-xin@zytor.com> <20250318071947.907364-2-xin@zytor.com>
In-Reply-To: <20250318071947.907364-2-xin@zytor.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Tue, 18 Mar 2025 09:53:22 -0400
X-Gm-Features: AQ5f1Jra05JVv5odDdF_jYPI9LS2Ws6sVNdUoXEhcd7QK9HVfeCIyaUiTTS09TU
Message-ID: <CAMzpN2iOGKLN99MC6zgzLumysnR5q-M-jZ3y14cp5TYCW1mQWg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/3] x86/fred: Allow variable-sized event frame
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de, 
	mingo@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 3:20=E2=80=AFAM Xin Li (Intel) <xin@zytor.com> wrot=
e:
>
> A FRED event frame could contain different amount of information for
> different event types, or perhaps even for different instances of the
> same event type. Thus the size of an event frame pushed by a FRED CPU
> is not fixed and the address of the pt_regs structure that is used to
> save a user level context of current task is not at a fixed offset
> from top of current task kernel stack.
>
> Add a new field named 'user_pt_regs' in the thread_info structure to
> save the address of user level context pt_regs structure, thus to
> eliminate the need of any advance information of event frame size
> and allow a FRED CPU to push variable-sized event frame.
>
> For IDT user level event delivery, a pt_regs structure is pushed by
> hardware and software _always_ at a fixed offset from top of current
> task kernel stack, so simply initialize user_pt_regs to point to the
> pt_regs structure no matter whether one is pushed or not.
>
> While for FRED user level event delivery, user_pt_regs is updated with
> a pt_regs structure pointer generated in asm_fred_entrypoint_user().
>
> Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>  arch/x86/entry/entry_fred.c        | 10 ++++++++++
>  arch/x86/include/asm/processor.h   | 12 ++++++------
>  arch/x86/include/asm/thread_info.h |  9 ++++++---
>  arch/x86/kernel/process.c          | 22 ++++++++++++++++++++++
>  include/linux/thread_info.h        |  1 +
>  kernel/fork.c                      |  6 ++++++
>  6 files changed, 51 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
> index f004a4dc74c2..a5f5bdd16ad8 100644
> --- a/arch/x86/entry/entry_fred.c
> +++ b/arch/x86/entry/entry_fred.c
> @@ -228,6 +228,16 @@ __visible noinstr void fred_entry_from_user(struct p=
t_regs *regs)
>         /* Invalidate orig_ax so that syscall_get_nr() works correctly */
>         regs->orig_ax =3D -1;
>
> +       /*
> +        * A FRED event frame could contain different amount of informati=
on
> +        * for different event types, or perhaps even for different insta=
nces
> +        * of the same event type. Thus the size of an event frame pushed=
 by
> +        * a FRED CPU is not fixed and the address of the pt_regs structu=
re
> +        * that is used to save a user level context of current task is n=
ot
> +        * at a fixed offset from top of current task stack.
> +        */
> +       current->thread_info.user_pt_regs =3D regs;
> +
>         switch (regs->fred_ss.type) {
>         case EVENT_TYPE_EXTINT:
>                 return fred_extint(regs);
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index 5d2f7e5aff26..7ff3443eb57d 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -646,12 +646,12 @@ static __always_inline void prefetchw(const void *x=
)
>
>  #define task_top_of_stack(task) ((unsigned long)(task_pt_regs(task) + 1)=
)
>
> -#define task_pt_regs(task) \
> -({                                                                     \
> -       unsigned long __ptr =3D (unsigned long)task_stack_page(task);    =
 \
> -       __ptr +=3D THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;            =
 \
> -       ((struct pt_regs *)__ptr) - 1;                                  \
> -})
> +/*
> + * Note, this can't be converted to an inline function as this header
> + * file defines 'struct thread_struct' which is used in the task_struct
> + * structure definition.
> + */
> +#define task_pt_regs(task) ((task)->thread_info.user_pt_regs)
>
>  #ifdef CONFIG_X86_32
>  #define INIT_THREAD  {                                                  =
 \
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/th=
read_info.h
> index 9282465eea21..4372f171c65f 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -56,6 +56,7 @@
>   */
>  #ifndef __ASSEMBLER__
>  struct task_struct;
> +struct pt_regs;
>  #include <asm/cpufeature.h>
>  #include <linux/atomic.h>
>
> @@ -66,11 +67,13 @@ struct thread_info {
>  #ifdef CONFIG_SMP
>         u32                     cpu;            /* current CPU */
>  #endif
> +       struct pt_regs          *user_pt_regs;
>  };
>
> -#define INIT_THREAD_INFO(tsk)                  \
> -{                                              \
> -       .flags          =3D 0,                    \
> +#define INIT_THREAD_INFO(tsk)                                          \
> +{                                                                      \
> +       .flags          =3D 0,                                           =
 \
> +       .user_pt_regs   =3D (struct pt_regs *)TOP_OF_INIT_STACK - 1,     =
 \

Use __top_init_kernel_stack here.

>  }
>
>  #else /* !__ASSEMBLER__ */
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 91f6ff618852..58c1cd4ca60a 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -108,6 +108,28 @@ int arch_dup_task_struct(struct task_struct *dst, st=
ruct task_struct *src)
>         return 0;
>  }
>
> +/*
> + * Initialize thread_info.user_pt_regs for IDT event delivery.
> + *
> + * For IDT user level event delivery, a pt_regs structure is pushed by b=
oth
> + * hardware and software and always resides at a fixed offset from top o=
f
> + * current task kernel stack, thus thread_info.user_pt_regs is a per-tas=
k
> + * constant and NEVER changes after initialization.
> + *
> + * While for FRED user level event delivery, user_pt_regs is updated in
> + * fred_entry_from_user() immediately after user level event delivery.
> + *
> + * Note: thread_info.user_pt_regs of the init task is initialized at bui=
ld
> + * time.
> + */
> +void arch_init_user_pt_regs(struct task_struct *tsk)
> +{
> +       unsigned long top_of_stack =3D (unsigned long)task_stack_page(tsk=
) + THREAD_SIZE;
> +
> +       top_of_stack -=3D TOP_OF_KERNEL_STACK_PADDING;
> +       tsk->thread_info.user_pt_regs =3D (struct pt_regs *)top_of_stack =
- 1;
> +}

Can this be put into arch_dup_task_struct() instead of creating another hoo=
k?


Brian Gerst

