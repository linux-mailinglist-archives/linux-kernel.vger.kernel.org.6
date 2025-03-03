Return-Path: <linux-kernel+bounces-542741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A42A4CD12
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD473AB7AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0F9230278;
	Mon,  3 Mar 2025 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1ATg9Qu"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163B215041
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035374; cv=none; b=BThXQ43b9JQnHSK3t8lyp8T5aF4nq224N2NrolwJVOkH+U8eflyGYM6ndfJr/k6nDX/Opk1VAbCfQusXUn/qZrU1eZVWDgDx+ck79OVYZD8h/tvrHmORjnDPl9xDRB+adot81Pb3uoUWZseXJRmddW0lR2v0sQWgpH30/1GiJdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035374; c=relaxed/simple;
	bh=HD5NOqvB+JGq3p8zyxw67fGIB9cC5A6IPV4cnjsInF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSSTKMuqN9N27S1DxREH6JPvqa4wxvY3ZDK9epBZDJChZ64K0Z1tdTGNKI5WYdpyz11/8PtojLBPufTYDlT28ENmTcnI+4qbmjCp50KbK2VTzhc7PxiTVElRZxKXyUbK2mGknK4X9K0jWLOm6fSvXDL8MrN8S/MnorauDjONCbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1ATg9Qu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30b83290b7bso56388001fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 12:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741035370; x=1741640170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oj7uqsUmIrhhsBT8se1tKctYkmeydR6BflUuPJLQ5yU=;
        b=a1ATg9QuvEOvAAHjsM8mTTJfStcAocgAlU0iHfmReUDVaFJKycmzUgHeC8pY30b4fx
         CZCVVGwpJZOh1N+Qj0ql/MnJvrRFC8OIpJWCXruj+6h9BTV1qipHhHVS43LiD6YOMcME
         zpBmefAsW1x/deqawsdnC5NWue5GBy3KkK5XxSqWvc/wMo17h46d17tQFBqf8ilUNps5
         G5OYCFUuG6g7nsMx8rbqjsqa2rg2fDOFXsCCI4DlhO89igbMjFtXv4hEmDA076UtrBmF
         afZX9eOp3qlYmHZoh7b1OeRkh3zNKFyUgBMUeoC9IGbB4s7wV0Gl04Zg+hm7igwuzyCP
         mZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741035370; x=1741640170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oj7uqsUmIrhhsBT8se1tKctYkmeydR6BflUuPJLQ5yU=;
        b=GRqYmQ65Crk7eqbwltamzforsJDzR3l9bE0N7BZvPmr4l39KeTlziPNSBqlJ3l9MmK
         yNz/DbdzpXqXOd8EFmCYAsF/c6qr9lpX9PL4kAMIFHMSVfffNvrytDwuap+NZecZf1tk
         IGYGHIUZU9+rhm338sA+llaxFT/bzfFhBuBMn1weSNiSF6MXUqzxy4tDuagxKhDi/Xaq
         iXWk6qEtxVKxYvKqhzQwQYMtIZFgdJxiAzDHgMU+P5ug4ELyNY/NjtapL+yJ+YuwirVN
         t2qltXj5RkLD8BAx9fEhI2bUgX9AJc/JK/xxmKwvfssN2rn90pKTlqRngzl82YR22gri
         VtDA==
X-Gm-Message-State: AOJu0Yz9Rtp6+lTlnR5EwhXqHLPH4tXvBMcYYbtuONJP3WyTtvDhtPNa
	nUe01cdjMk9YjFCh41K7NzcSP8FmObtVw2CqouZLE0UkwfojuXlWiE0TJJahh/iZRID83+NWE0m
	B88MNNaZuEhbnBcU3MD7MADVo4A==
X-Gm-Gg: ASbGncudL4x2RYfp74+dlMT2eK7ATeYI7Qb1hWDH9ixLBFbH8Eb1dCnQYgaqOpWcZmF
	DPS8o9gMdQSDCBVCHyJ6D68BrRGpuAA/mmZcT6g95xmOyA4v9GV0456QgFv0A6iNPdPmOuipDt3
	YWsoTF15Yyo/c7YANtZSyf/K9aAjADvNjGpI6Zw8B2
X-Google-Smtp-Source: AGHT+IG+G93f9ERwv16+hwMoPpYJSjRNaRiMdu3wxCZBO91+UmH472Xou7szPcKpxjm8U9/kx0Wo6LfPKVVQDdVVwXg=
X-Received: by 2002:a2e:be1f:0:b0:30b:aabf:fc4 with SMTP id
 38308e7fff4ca-30baabf195fmr35519801fa.21.1741035370302; Mon, 03 Mar 2025
 12:56:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303165246.2175811-1-brgerst@gmail.com> <Z8YTYWs-DeDHal1Q@gmail.com>
In-Reply-To: <Z8YTYWs-DeDHal1Q@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 3 Mar 2025 15:55:57 -0500
X-Gm-Features: AQ5f1JrX8DT97KptVi0vEFfZsh17jOkL8ThyQyjEpUtdWTsMIQvLVxUELHEv-6I
Message-ID: <CAMzpN2iB4Gv0Fq1pNtk7bpa2z6eYwQGYXT0=p=_wWDBE9Uxa7w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Add a percpu subsection for cache hot data
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 3:39=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Brian Gerst <brgerst@gmail.com> wrote:
>
> > Add a new percpu subsection for data that is frequently accessed and
> > exclusive to each processor.  This replaces the pcpu_hot struct on x86,
> > and is available to all architectures and the core kernel.
> >
> > ffffffff834f5000 D __per_cpu_hot_start
> > ffffffff834f5000 D hardirq_stack_ptr
> > ffffffff834f5008 D __ref_stack_chk_guard
> > ffffffff834f5008 D __stack_chk_guard
> > ffffffff834f5010 D const_cpu_current_top_of_stack
> > ffffffff834f5010 D cpu_current_top_of_stack
> > ffffffff834f5018 D const_current_task
> > ffffffff834f5018 D current_task
> > ffffffff834f5020 D __x86_call_depth
> > ffffffff834f5028 D this_cpu_off
> > ffffffff834f5030 D __preempt_count
> > ffffffff834f5034 D cpu_number
> > ffffffff834f5038 D __softirq_pending
> > ffffffff834f503a D hardirq_stack_inuse
> > ffffffff834f503b D __per_cpu_hot_pad
> > ffffffff834f5040 D __per_cpu_hot_end
> >
> > This applies to the tip/x86/asm branch.
> >
> > Changes in v3:
> > - Fix typo of CACHE_HOT_DATA()
> > - Move hardirq_stack_inuse to irq_64.c
> > - Add __per_cpu_hot_pad to show the end of the actual data
> >
> > Brian Gerst (11):
> >   percpu: Introduce percpu hot section
> >   x86/percpu: Move pcpu_hot to percpu hot section
> >   x86/preempt: Move preempt count to percpu hot section
> >   x86/smp: Move cpu number to percpu hot section
> >   x86/retbleed: Move call depth to percpu hot section
> >   x86/softirq: Move softirq_pending to percpu hot section
> >   x86/irq: Move irq stacks to percpu hot section
> >   x86/percpu: Move top_of_stack to percpu hot section
> >   x86/percpu: Move current_task to percpu hot section
> >   x86/stackprotector: Move __stack_chk_guard to percpu hot section
> >   x86/smp: Move this_cpu_off to percpu hot section
>
> >  31 files changed, 146 insertions(+), 111 deletions(-)
>
> Yeah, so the result is that on x86-64 allmodconfig we now get:
>
>   ld: percpu cache hot section too large
>
> See the relevant .tmp_vmlinux1.map below.
>
> Which is due to:
>
>    CONFIG_X86_INTERNODE_CACHE_SHIFT=3D12
>
> Increasing 'cache alignment' to 4096 bytes:
>
>         PERCPU_SECTION(INTERNODE_CACHE_BYTES)
>
> ... because of the vSMP muck:
>
>   config X86_INTERNODE_CACHE_SHIFT
>         int
>         default "12" if X86_VSMP
>         default X86_L1_CACHE_SHIFT
>
> The workaround would be to use L1_CACHE_BYTES in, but I really dislike
> what vSMP is doing here.
>
> Anyway, I applied the short-term fix to patch 02/11, but I'm not sure
> it's the right fix.
>
> Thanks,
>
>         Ingo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>                 0xffffffff8664f000                . =3D ALIGN (0x1000)
>                 0xffffffff8664f000                __per_cpu_hot_start =3D=
 .
>  *(SORT_BY_ALIGNMENT(.data..percpu..hot.*))
>  .data..percpu..hot..hardirq_stack_ptr
>                 0xffffffff8664f000        0x8 vmlinux.o
>                 0xffffffff8664f000                hardirq_stack_ptr
>  .data..percpu..hot..__stack_chk_guard
>                 0xffffffff8664f008        0x8 vmlinux.o
>                 0xffffffff8664f008                __stack_chk_guard
>  .data..percpu..hot..cpu_current_top_of_stack
>                 0xffffffff8664f010        0x8 vmlinux.o
>                 0xffffffff8664f010                cpu_current_top_of_stac=
k
>  .data..percpu..hot..current_task
>                 0xffffffff8664f018        0x8 vmlinux.o
>                 0xffffffff8664f018                current_task
>  .data..percpu..hot..__x86_call_depth
>                 0xffffffff8664f020        0x8 vmlinux.o
>                 0xffffffff8664f020                __x86_call_depth
>  .data..percpu..hot..this_cpu_off
>                 0xffffffff8664f028        0x8 vmlinux.o
>                 0xffffffff8664f028                this_cpu_off
>  .data..percpu..hot..__preempt_count
>                 0xffffffff8664f030        0x4 vmlinux.o
>                 0xffffffff8664f030                __preempt_count
>  .data..percpu..hot..cpu_number
>                 0xffffffff8664f034        0x4 vmlinux.o
>                 0xffffffff8664f034                cpu_number
>  .data..percpu..hot..__softirq_pending
>                 0xffffffff8664f038        0x2 vmlinux.o
>                 0xffffffff8664f038                __softirq_pending
>  .data..percpu..hot..hardirq_stack_inuse
>                 0xffffffff8664f03a        0x1 vmlinux.o
>                 0xffffffff8664f03a                hardirq_stack_inuse
>                 0xffffffff8664f03b                __per_cpu_hot_pad =3D .
>                 0xffffffff86650000                . =3D ALIGN (0x1000)
>  *fill*         0xffffffff8664f03b      0xfc5
>                 0xffffffff86650000                __per_cpu_hot_end =3D .
>  *(.data..percpu..read_mostly)
>  .data..percpu..read_mostly
>                 0xffffffff86650000      0xa30 vmlinux.o
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>
>  arch/x86/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.=
S
> index 9ac6b42701fa..31f9102b107f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -330,7 +330,7 @@ SECTIONS
>                 EXIT_DATA
>         }
>
> -       PERCPU_SECTION(INTERNODE_CACHE_BYTES)
> +       PERCPU_SECTION(L1_CACHE_BYTES)
>         ASSERT(__per_cpu_hot_end - __per_cpu_hot_start <=3D 64, "percpu c=
ache hot section too large")
>
>         RUNTIME_CONST_VARIABLES
>

That is probably the right call.  The initial percpu section is just
used by the boot cpu early and as a template for the dynamically
allocated percpu memory, which should account for the proper alignment
for NUMA.


Brian Gerst

