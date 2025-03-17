Return-Path: <linux-kernel+bounces-563232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D0A63A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3527A27D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30B1474D3;
	Mon, 17 Mar 2025 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nsIWc+O/"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B153E23
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742175012; cv=none; b=hu1vOzCJe+rr3ApLaCscNGhZA9CHCpJQCBJ+d4ZDBhWnp2RyjmLFtD8esyDYG5RfJL7kBlSRZt2sgmMl2CWaJKMwMBPzUNN1UyoPclw/4tED7q6XMLA9AiHH+s826Hxo+Ao1qe4XfAQycQpmc16kPjJsMdWbkrIY+6v86Mcnaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742175012; c=relaxed/simple;
	bh=NpMOVBOS8yDuSZNKzTrt0KxgDiVsUGvJ2JbhENakTNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1ahggwEkTxWIBqGT8D9ee27s3PPtM7q8mC0e/xX1lYBh4ZtiKMKE7NR8lofovY7KXQVRgZE1VCO6sF5Nnl0aABXV28Pnsqe3GO+n+cCdah2+z6f5qn46hbU8r2EGOaBb4V3V6Zo4SNk858MRf/ZGSa8Y5SVFnaLvetqZK2z0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nsIWc+O/; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85afd2b9106so378271539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1742175009; x=1742779809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BgPqh2lb+Uwmfrt3ADGADV+FsUyp9TAnyh5DCYwF0A=;
        b=nsIWc+O/ppJ7J/pbLyPRpD1W8bBeIBxD+xARdZE9HgJoHY64QdMpzrp6rqO9TWODOR
         0DQbp5KVOI29hBfzxbAQ31dcrfg9YcPczk3CJxA1ijt6XNpUm4uvKleEwsZovXCQSN8V
         p5pi5lBt2gByZkLoL61XUb9hQuZjxFxpaNCvTSuwEdTLEzkRgLGgIsMnZICDnvwiauyL
         3jnu1LIHVRM19MtZu6TXbU2cMmOiQ4fo3QpD7PDFU3ttVfhVCox614lVyVB2pLrV8m+6
         XtDcPPBnDOKTOR5mJ+tat0bwpb55/ka6z0MmAWFcxpaMsFA12DZ5BNCwZXimF2SAlcQe
         bVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742175009; x=1742779809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BgPqh2lb+Uwmfrt3ADGADV+FsUyp9TAnyh5DCYwF0A=;
        b=xEctgqztsrogzRsGqsIsFaRK9oy+BYgs87yvt8DWCwb9y+x5+v/grZ1ZjP0t960yxd
         2j8Cv0U9sbxCWJeTgvMlR+wy10KmLyQkmhGE58fRbr8QxzT/DvJRn1a0jnuRo5ctvdCk
         ccz5fkY0MiWxoAGmU2P4Mxl6C7jB9sRI5oPQTAmj3rKj0VECRzhV7jACxuDsHj/5d48u
         I5+keGtx1BytzEpk89WfkYGnf4N4mrnmhq7L8KgP4oRnZl1Bl8Kbdh2sL4DmZQ3WqVuO
         DonJFP6+txbO8ENTsYWNuyb1INYfU4YI+JD4FdBHNQAnCECw78XzyYHkM7MOBoDyEKDH
         7OLg==
X-Forwarded-Encrypted: i=1; AJvYcCXSt89eSj36iiFAFV30+M3PIBAEz1riX/qGy65XW0KPYG0TRndskjcM22/9PiHHoNLGz06PXaNpnM+cjlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTeQ70SiZ7rcaYT2HUCB91J56Jk9+KghIGIUu+v5DKT2630vt0
	rW7VKCBowGhnMR/m0WwFwfnDvVdwoNlZBk9JW/c9/uHm3XiM0iBrlLDu5PQZJMOldIImSwoCfjV
	VchUwF8Wf/Fsn7SEJj0SkNhttyc9M5xVKX5HThg==
X-Gm-Gg: ASbGnctRIX49Nqr3A8sTMZv5ttOQPW0dF3CwmvOQNqB7qAJdZoswg2UDgi9PRcwvwcY
	InR8Ba6IxJEtq9qqV1VjLFuNWs1X2uq4JKi0Y754h8gc6XBFAIAsEw01X7MHWsjaUARIPWoB0vh
	5sdjRqjrDBVquUD8n+pAeVDa7sTlu2
X-Google-Smtp-Source: AGHT+IFIq9kkasXmtYBi1bOlasABayp5RTyarU6d4HJ+lY/VA6wq4Lo3I/SyszKkcRTrfrE4ClECajli89b3tva72eM=
X-Received: by 2002:a05:6602:3f09:b0:85d:a1c4:ee03 with SMTP id
 ca18e2360f4ac-85dc47d36b5mr1483188839f.7.1742175009124; Sun, 16 Mar 2025
 18:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com> <20250314-v5_user_cfi_series-v12-13-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-13-e51202b53138@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 17 Mar 2025 09:29:57 +0800
X-Gm-Features: AQ5f1JrP5j_jWeX4yoQDmxgHc7C_BW3_CH6nIyiVQO54RVQmiKVGFtDika6nCYk
Message-ID: <CANXhq0o2gxV462GY6h=_4GmBDcDf3oeh-L=WXzz=AsMCV=x2Kw@mail.gmail.com>
Subject: Re: [PATCH v12 13/28] prctl: arch-agnostic prctl for indirect branch tracking
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 6:51=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> Three architectures (x86, aarch64, riscv) have support for indirect branc=
h
> tracking feature in a very similar fashion. On a very high level, indirec=
t
> branch tracking is a CPU feature where CPU tracks branches which uses
> memory operand to perform control transfer in program. As part of this
> tracking on indirect branches, CPU goes in a state where it expects a
> landing pad instr on target and if not found then CPU raises some fault
> (architecture dependent)
>
> x86 landing pad instr - `ENDBRANCH`
> arch64 landing pad instr - `BTI`
> riscv landing instr - `lpad`
>
> Given that three major arches have support for indirect branch tracking,
> This patch makes `prctl` for indirect branch tracking arch agnostic.
>
> To allow userspace to enable this feature for itself, following prtcls ar=
e
> defined:
>  - PR_GET_INDIR_BR_LP_STATUS: Gets current configured status for indirect
>    branch tracking.
>  - PR_SET_INDIR_BR_LP_STATUS: Sets a configuration for indirect branch
>    tracking.
>    Following status options are allowed
>        - PR_INDIR_BR_LP_ENABLE: Enables indirect branch tracking on user
>          thread.
>        - PR_INDIR_BR_LP_DISABLE; Disables indirect branch tracking on use=
r
>          thread.
>  - PR_LOCK_INDIR_BR_LP_STATUS: Locks configured status for indirect branc=
h
>    tracking for user thread.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  include/linux/cpu.h        |  4 ++++
>  include/uapi/linux/prctl.h | 27 +++++++++++++++++++++++++++
>  kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
>
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 6a0a8f1c7c90..fb0c394430c6 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -204,4 +204,8 @@ static inline bool cpu_mitigations_auto_nosmt(void)
>  }
>  #endif
>
> +int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __u=
ser *status);
> +int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long sta=
tus);
> +int arch_lock_indir_br_lp_status(struct task_struct *t, unsigned long st=
atus);
> +
>  #endif /* _LINUX_CPU_H_ */
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 5c6080680cb2..6cd90460cbad 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -353,4 +353,31 @@ struct prctl_mm_map {
>   */
>  #define PR_LOCK_SHADOW_STACK_STATUS      76
>
> +/*
> + * Get the current indirect branch tracking configuration for the curren=
t
> + * thread, this will be the value configured via PR_SET_INDIR_BR_LP_STAT=
US.
> + */
> +#define PR_GET_INDIR_BR_LP_STATUS      77
> +
> +/*
> + * Set the indirect branch tracking configuration. PR_INDIR_BR_LP_ENABLE=
 will
> + * enable cpu feature for user thread, to track all indirect branches an=
d ensure
> + * they land on arch defined landing pad instruction.
> + * x86 - If enabled, an indirect branch must land on `ENDBRANCH` instruc=
tion.
> + * arch64 - If enabled, an indirect branch must land on `BTI` instructio=
n.
> + * riscv - If enabled, an indirect branch must land on `lpad` instructio=
n.
> + * PR_INDIR_BR_LP_DISABLE will disable feature for user thread and indir=
ect
> + * branches will no more be tracked by cpu to land on arch defined landi=
ng pad
> + * instruction.
> + */
> +#define PR_SET_INDIR_BR_LP_STATUS      78
> +# define PR_INDIR_BR_LP_ENABLE            (1UL << 0)
> +
> +/*
> + * Prevent further changes to the specified indirect branch tracking
> + * configuration.  All bits may be locked via this call, including
> + * undefined bits.
> + */
> +#define PR_LOCK_INDIR_BR_LP_STATUS      79
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index cb366ff8703a..f347f3518d0b 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2336,6 +2336,21 @@ int __weak arch_lock_shadow_stack_status(struct ta=
sk_struct *t, unsigned long st
>         return -EINVAL;
>  }
>
> +int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned l=
ong __user *status)
> +{
> +       return -EINVAL;
> +}
> +
> +int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned l=
ong status)
> +{
> +       return -EINVAL;
> +}
> +
> +int __weak arch_lock_indir_br_lp_status(struct task_struct *t, unsigned =
long status)
> +{
> +       return -EINVAL;
> +}
> +
>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>
>  #ifdef CONFIG_ANON_VMA_NAME
> @@ -2811,6 +2826,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error =3D arch_lock_shadow_stack_status(me, arg2);
>                 break;
> +       case PR_GET_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_get_indir_br_lp_status(me, (unsigned long =
__user *)arg2);
> +               break;
> +       case PR_SET_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_set_indir_br_lp_status(me, arg2);
> +               break;
> +       case PR_LOCK_INDIR_BR_LP_STATUS:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error =3D arch_lock_indir_br_lp_status(me, arg2);
> +               break;
>         default:
>                 trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>                 error =3D -EINVAL;
>

LGTM

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

