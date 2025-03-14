Return-Path: <linux-kernel+bounces-560970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA70BA60BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B0116ECC7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0350A1ACEC6;
	Fri, 14 Mar 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KBOMhYhu"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB61ACEA5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941265; cv=none; b=kE9vbEKKnxs4DCh1zs/f/YAwM5hzSarXA0jCnhcrXsINQnbU0s0B+oE4iRycc7X8kL3nXqBIB5xKwcjzbMTff5xYeGcgCp0MujgyhAxhTZjtilFXStc7pOSWuZbheDE7acESZsgb83A7zLxWfLktiqMbK9Szdz5G9V9R5EpqKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941265; c=relaxed/simple;
	bh=KRAh+gAuvRK7Rbdfim41PFrn9f1UuaYcgcXxYVTHYGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBsYUdLrn+msUwzJEu8unIuMUMna4KCM3JCaBOqWUkxdL49wV3I6ccP25zE5Ghax8Ge5gZFGuiho+KXdjK0AQHRqt7GZMOp1DVB/rJEsppOGRd4MGASjPhAi9V2Gvt6GJMqrSNgjc6oUJnXnIni+QG0S4wAD8QyHSpps77fkbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KBOMhYhu; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85db872dd80so40595439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741941262; x=1742546062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iX3HNdGAyavSd81H2hduaaeN8aF6ISRjVvfsb1XI+c=;
        b=KBOMhYhuBb0iN3eM3unI2DHd7mDRGLbYM7kisp53DkIB1B9Ab2GTVnRtacwFRI8UF6
         CzZ3XhuGN0ojdJ4+b+G9lxLw/MaY2mGZJ6vRJBea6SlOMoZNgGzBEM0Z0b+4dj1KimYU
         N+KZrwKVYp3Q93p2ZWxW3SjlR/CwOYKAWjfPWpXHHpgL4pV1Bno9SetLgQEnrY9ArdOI
         mtHmfp3aRqrrr/2JwOGuvnzdMNkY1GQ7AYAs1NGJi264MLJ1BIPNfKkEt6Dcjsw6Unw/
         aM53lH7Lt4KZ9Bl7gIxExC5HdJ5nBEuVQFFXxnCFn7Qfe/qg0YoPJ6N0nxoUqgm8VjR9
         Qkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941262; x=1742546062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iX3HNdGAyavSd81H2hduaaeN8aF6ISRjVvfsb1XI+c=;
        b=B2ZhJYgK96RBEcIwUGB6vhKoIc9E4PygV3P9Np/ZYDrWeupNCRdhlipFYJFAsOhHpR
         wawzx9xGczrmtSvOfHqYVMEnqOZf+ELMEQpJzVJm/00BaI+dFrOxt7J8z18KhcMJL9iZ
         YStXB50ygwFlrUW8gcBOEwf+Ar7EgTmajmq4xw6mrgmA0haTxP05Udjw8c9o8sxhJaHs
         +t7RYvnVqf8Q2n9LJqTM3VTKKkUjnWCAFYSN5vAd2H+PROpdULIF1Vnef/wK/kbzxLlL
         pY4rcodVIeqC7QM2qvepUGcqXfQJeuqcJVHTPcV956oFzA8XUDyQExmA9hniwrf77x6/
         QeZg==
X-Forwarded-Encrypted: i=1; AJvYcCU7wRUQSefj4jXr4qujMMqAbU1Dm9P1VQ15d4bLCqrNphKGC9OIM0IjA2vnTYGQNV9yWROkpxBPxEhHtmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIH45bYwxzx4aOWHEPnp5kc8vE+eaUUoL+AX2ZRrrywVTcvg3q
	n7LBky14YA5VbYV5Qifj76cGRlImajxpPN0B6I7KOXFVYTFm/AHhJggHEaQsRBYk74YvTAybr5y
	re/G4OXqv4rek1QfsWqj+EKUmqiDZZXNYBrJgFw==
X-Gm-Gg: ASbGnct0KjCxYP2Yu/ffRAWAIi7qW87z5dHKyFqu2QNqg8R7ibmx3lN55cTSN4JvPSV
	+s30PyzTS2Hp3nOv/JtxryXF5oZ1TJBcjGx1NAFLhz15QWCezCyyCq/v7EpvkBhv7a1c9zsR8aD
	Le58mGX76PLmw7SnDA4htNPq84C2M=
X-Google-Smtp-Source: AGHT+IFME8iCFHQ4xqD2/WWFrTRPOU1/5Sslq5ZEgutz88HkOy5WNMIQDAQr6rDnrqf7KpiIgv+a/574qkZnFTRQaKQ=
X-Received: by 2002:a92:c264:0:b0:3d3:f775:cec0 with SMTP id
 e9e14a558f8ab-3d483a8a586mr13610575ab.22.1741941261616; Fri, 14 Mar 2025
 01:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-26-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-26-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:34:09 +0800
X-Gm-Features: AQ5f1Jp8Q3U18WuKV3ZW8T-JMN0pM5rQRGCfXRWh0Hd6bXSFmFWjBm-HCCbZo7Q
Message-ID: <CANXhq0oMwxAPFqBdppVriNfjzRYjKrqLVDYvXsiDnCvvLtPcaQ@mail.gmail.com>
Subject: Re: [PATCH v11 26/27] riscv: Documentation for shadow stack on riscv
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

On Mon, Mar 10, 2025 at 11:44=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> Adding documentation on shadow stack for user mode on riscv and kernel
> interfaces exposed so that user tasks can enable it.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  Documentation/arch/riscv/index.rst   |   1 +
>  Documentation/arch/riscv/zicfiss.rst | 176 +++++++++++++++++++++++++++++=
++++++
>  2 files changed, 177 insertions(+)
>
> diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/risc=
v/index.rst
> index be7237b69682..e240eb0ceb70 100644
> --- a/Documentation/arch/riscv/index.rst
> +++ b/Documentation/arch/riscv/index.rst
> @@ -15,6 +15,7 @@ RISC-V architecture
>      vector
>      cmodx
>      zicfilp
> +    zicfiss
>
>      features
>
> diff --git a/Documentation/arch/riscv/zicfiss.rst b/Documentation/arch/ri=
scv/zicfiss.rst
> new file mode 100644
> index 000000000000..5ba389f15b3f
> --- /dev/null
> +++ b/Documentation/arch/riscv/zicfiss.rst
> @@ -0,0 +1,176 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Deepak Gupta <debug@rivosinc.com>
> +:Date:   12 January 2024
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Shadow stack to protect function returns on RISC-V Linux
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document briefly describes the interface provided to userspace by L=
inux
> +to enable shadow stack for user mode applications on RISV-V
> +
> +1. Feature Overview
> +--------------------
> +
> +Memory corruption issues usually result in to crashes, however when in h=
ands of
> +an adversary and if used creatively can result into variety security iss=
ues.
> +
> +One of those security issues can be code re-use attacks on program where
> +adversary can use corrupt return addresses present on stack and chain th=
em
> +together to perform return oriented programming (ROP) and thus compromis=
ing
> +control flow integrity (CFI) of the program.
> +
> +Return addresses live on stack and thus in read-write memory and thus ar=
e
> +susceptible to corruption and allows an adversary to reach any program c=
ounter
> +(PC) in address space. On RISC-V ``zicfiss`` extension provides an alter=
nate
> +stack termed as shadow stack on which return addresses can be safely pla=
ced in
> +prolog of the function and retrieved in epilog. ``zicfiss`` extension ma=
kes
> +following changes:
> +
> +- PTE encodings for shadow stack virtual memory
> +  An earlier reserved encoding in first stage translation i.e.
> +  PTE.R=3D0, PTE.W=3D1, PTE.X=3D0  becomes PTE encoding for shadow stack=
 pages.
> +
> +- ``sspush x1/x5`` instruction pushes (stores) ``x1/x5`` to shadow stack=
.
> +
> +- ``sspopchk x1/x5`` instruction pops (loads) from shadow stack and comp=
ares
> +  with ``x1/x5`` and if un-equal, CPU raises ``software check exception`=
` with
> +  ``*tval =3D 3``
> +
> +Compiler toolchain makes sure that function prologue have ``sspush x1/x5=
`` to
> +save return address on shadow stack in addition to regular stack. Simila=
rly
> +function epilogs have ``ld x5, offset(x2)`` followed by ``sspopchk x5`` =
to
> +ensure that popped value from regular stack matches with popped value fr=
om
> +shadow stack.
> +
> +2. Shadow stack protections and linux memory manager
> +-----------------------------------------------------
> +
> +As mentioned earlier, shadow stack get new page table encodings and thus=
 have
> +some special properties assigned to them and instructions that operate o=
n them
> +as below:
> +
> +- Regular stores to shadow stack memory raises access store faults. This=
 way
> +  shadow stack memory is protected from stray inadvertant writes.
> +
> +- Regular loads to shadow stack memory are allowed. This allows stack tr=
ace
> +  utilities or backtrace functions to read true callstack (not tampered)=
.
> +
> +- Only shadow stack instructions can generate shadow stack load or shado=
w stack
> +  store.
> +
> +- Shadow stack load / shadow stack store on read-only memory raises AMO/=
store
> +  page fault. Thus both ``sspush x1/x5`` and ``sspopchk x1/x5`` will rai=
se AMO/
> +  store page fault. This simplies COW handling in kernel During fork, ke=
rnel
> +  can convert shadow stack pages into read-only memory (as it does for r=
egular
> +  read-write memory) and as soon as subsequent ``sspush`` or ``sspopchk`=
` in
> +  userspace is encountered, then kernel can perform COW.
> +
> +- Shadow stack load / shadow stack store on read-write, read-write-execu=
te
> +  memory raises an access fault. This is a fatal condition because shado=
w stack
> +  should never be operating on read-write, read-write-execute memory.
> +
> +3. ELF and psABI
> +-----------------
> +
> +Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_BCFI` for prope=
rty
> +:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the obje=
ct file.
> +
> +4. Linux enabling
> +------------------
> +
> +User space programs can have multiple shared objects loaded in its addre=
ss space
> +and it's a difficult task to make sure all the dependencies have been co=
mpiled
> +with support of shadow stack. Thus it's left to dynamic loader to enable
> +shadow stack for the program.
> +
> +5. prctl() enabling
> +--------------------
> +
> +:c:macro:`PR_SET_SHADOW_STACK_STATUS` / :c:macro:`PR_GET_SHADOW_STACK_ST=
ATUS` /
> +:c:macro:`PR_LOCK_SHADOW_STACK_STATUS` are three prctls added to manage =
shadow
> +stack enabling for tasks. prctls are arch agnostic and returns -EINVAL o=
n other
> +arches.
> +
> +* prctl(PR_SET_SHADOW_STACK_STATUS, unsigned long arg)
> +
> +If arg1 :c:macro:`PR_SHADOW_STACK_ENABLE` and if CPU supports ``zicfiss`=
` then
> +kernel will enable shadow stack for the task. Dynamic loader can issue t=
his
> +:c:macro:`prctl` once it has determined that all the objects loaded in a=
ddress
> +space have support for shadow stack. Additionally if there is a
> +:c:macro:`dlopen` to an object which wasn't compiled with ``zicfiss``, d=
ynamic
> +loader can issue this prctl with arg1 set to 0 (i.e.
> +:c:macro:`PR_SHADOW_STACK_ENABLE` being clear)
> +
> +* prctl(PR_GET_SHADOW_STACK_STATUS, unsigned long *arg)
> +
> +Returns current status of indirect branch tracking. If enabled it'll ret=
urn
> +:c:macro:`PR_SHADOW_STACK_ENABLE`.
> +
> +* prctl(PR_LOCK_SHADOW_STACK_STATUS, unsigned long arg)
> +
> +Locks current status of shadow stack enabling on the task. User space ma=
y want
> +to run with strict security posture and wouldn't want loading of objects
> +without ``zicfiss`` support in it and thus would want to disallow disabl=
ing of
> +shadow stack on current task. In that case user space can use this prctl=
 to
> +lock current settings.
> +
> +5. violations related to returns with shadow stack enabled
> +-----------------------------------------------------------
> +
> +Pertaining to shadow stack, CPU raises software check exception in follo=
wing
> +condition:
> +
> +- On execution of ``sspopchk x1/x5``, ``x1/x5`` didn't match top of shad=
ow
> +  stack. If mismatch happens then cpu does ``*tval =3D 3`` and raise sof=
tware
> +  check exception.
> +
> +Linux kernel will treat this as :c:macro:`SIGSEV`` with code =3D
> +:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.
> +
> +6. Shadow stack tokens
> +-----------------------
> +Regular stores on shadow stacks are not allowed and thus can't be tamper=
ed
> +with via arbitrary stray writes due to bugs. Method of pivoting / switch=
ing to
> +shadow stack is simply writing to csr ``CSR_SSP`` changes active shadow =
stack.
> +This can be problematic because usually value to be written to ``CSR_SSP=
`` will
> +be loaded somewhere in writeable memory and thus allows an adversary to
> +corruption bug in software to pivot to an any address in shadow stack ra=
nge.
> +Shadow stack tokens can help mitigate this problem by making sure that:
> +
> +- When software is switching away from a shadow stack, shadow stack poin=
ter
> +  should be saved on shadow stack itself and call it ``shadow stack toke=
n``
> +
> +- When software is switching to a shadow stack, it should read the
> +  ``shadow stack token`` from shadow stack pointer and verify that
> +  ``shadow stack token`` itself is pointer to shadow stack itself.
> +
> +- Once the token verification is done, software can perform the write to
> +  ``CSR_SSP`` to switch shadow stack.
> +
> +Here software can be user mode task runtime itself which is managing var=
ious
> +contexts as part of single thread. Software can be kernel as well when k=
ernel
> +has to deliver a signal to user task and must save shadow stack pointer.=
 Kernel
> +can perform similar procedure by saving a token on user shadow stack its=
elf.
> +This way whenever :c:macro:`sigreturn` happens, kernel can read the toke=
n and
> +verify the token and then switch to shadow stack. Using this mechanism, =
kernel
> +helps user task so that any corruption issue in user task is not exploit=
ed by
> +adversary by arbitrarily using :c:macro:`sigreturn`. Adversary will have=
 to
> +make sure that there is a ``shadow stack token`` in addition to invoking
> +:c:macro:`sigreturn`
> +
> +7. Signal shadow stack
> +-----------------------
> +Following structure has been added to sigcontext for RISC-V::
> +
> +    struct __sc_riscv_cfi_state {
> +        unsigned long ss_ptr;
> +    };
> +
> +As part of signal delivery, shadow stack token is saved on current shado=
w stack
> +itself and updated pointer is saved away in :c:macro:`ss_ptr` field in
> +:c:macro:`__sc_riscv_cfi_state` under :c:macro:`sigcontext`. Existing sh=
adow
> +stack allocation is used for signal delivery. During :c:macro:`sigreturn=
`,
> +kernel will obtain :c:macro:`ss_ptr` from :c:macro:`sigcontext` and veri=
fy the
> +saved token on shadow stack itself and switch shadow stack.
>

LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>

> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

