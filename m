Return-Path: <linux-kernel+bounces-441536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794369ECFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9CF163183
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531BC1C5CC7;
	Wed, 11 Dec 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaksvJYn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A931A4E9E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931524; cv=none; b=F47f7+sHw1SkESDDNb9i4ZMkBoV9VWiHjlDbi+t7Kr7t5LFYQI8YHDj/3z8NJJIMWGmRaiaeOs5mqduv38DptwTQXhvfSKEgI3484WillbN7kmKIxmgx2Hy6yJ0nIOYr0Z6VHt5q0AjW42h0lBBoMgNOVQdNVaPhzpWyQIE2uTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931524; c=relaxed/simple;
	bh=9rg3aqLlSI0eKt0CZdNbjCfE+IwjwdCxW3GhWjYdHoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mP6r3C+ZmxP6leHd/LuHtLnnx/Xt0BaTFdJ/ZqQ7AwopNfgovkp6zUWyYV0IDyee8Xk+JSPM3D8NdW+SJcIexz1dRbnCP8knkyekgGlAbUfkNQbQqWOD2gUJkrm5G0nQlZhF45RsNMbRobJnR5KdQMKUsQhb4tMTuZKulOQ6Ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaksvJYn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21636268e43so48475405ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733931521; x=1734536321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18e2v39B/bPfaKlPN/TzoeLdxl2IwZlzeUqyUF3qyhY=;
        b=GaksvJYnjQxSWt11fK/MD6O+OAjTAFUPhpftCpawgPBOsah9cZxKg+o7reSoArpJwD
         4xUMECZZSeMStxZy0LfFLemjiXWlVuQTPdaYOZ8S2eTpe/16+cYS7acarB6zp5279jb8
         JDxOPAkK1tO9P8jMf31lCmKA6ZaDrpBdpjEuq9HHTH0bwwM/CTJfcXMsMXKX14Zrf0gt
         i2yqCO1k84JkhpaKbyukq4plLC1lf0BpcyOdmddiuv+FJyPz0jpIgbOCMRhr5ECRHffS
         xGnFqOZ6vhyeYNyTdY7zmw+CaF8rf5c+i/GmZfhtuLXGVRweP3Kvl9SwBhkW9RESBu50
         NTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931521; x=1734536321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18e2v39B/bPfaKlPN/TzoeLdxl2IwZlzeUqyUF3qyhY=;
        b=Po4Q1485rHyKuI1SsxEMC52mwSFopS+n48ezOt3JbAzJud6c+Xem2JZC0W9yH4EFQn
         A2yUEOdsvdaW0naLp/1rpKqCw2ZOwB4FR/kejxsI4XkEONbJLe5LTFMHz5zzjgxOTHk2
         +HgBkPTBKcR4IthZFWawhbLYPJL4ouYmIcS+ac29DyFT38FZiz78ADlnWWd7aLpKSYFm
         +TnBLkPW8lbHqNNvmAbJEHkqFGhV9fsMmbSdINAn+iMvs+pCJ0b11xJ3wik3S/HtOz9N
         n1BjQeSa38xcMSnpHVhTBZwALHIJodcQBMjup6Up6GJIDKnyvSkf2VIdaQoBkSk5DEKp
         P18w==
X-Forwarded-Encrypted: i=1; AJvYcCW3H9iVs337VDHk8Y/x4hWcWzanekuaG1y9AIZjpeinG1a6EZCTMDbYeViVtqHyrEd+gZdZdCseoOEv/ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx9EjtVJsm38UeT/nX9jlisWVj1C+gMvgI1bK7vyBZH9FqXqBR
	MPrGxFHSxns6z9UhaDHAcH78GPr966XoaPdDmqZeuumJnXpUzH4SbzGtmksX+7OxaY25xMmYKCq
	4YAOkm0Puoi7IlLHKN4uX70tGcbI=
X-Gm-Gg: ASbGncuPxih8HL1mvdqjFTPYSwmyjlHOT5/NRIcNW20W/iLaREfdgBxsfecHW3xy02o
	eKK8XxhOmQRCQwJWI/ox15pvw1I7nFt9d
X-Google-Smtp-Source: AGHT+IEq0jYPTX3+n9BZVBCd0Bm5hwAq42ViV4hXY2XE8GFJW3Hbww3znuQj55n/BAPeP3l9fyVPrbBKc676oLk7KyI=
X-Received: by 2002:a17:90b:3b49:b0:2ee:8a5d:d520 with SMTP id
 98e67ed59e1d1-2f12802cf76mr4200747a91.23.1733931521209; Wed, 11 Dec 2024
 07:38:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127172908.17149-1-andybnac@gmail.com> <62f06687-a20d-4f55-b22d-52af707b528a@yadro.com>
In-Reply-To: <62f06687-a20d-4f55-b22d-52af707b528a@yadro.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Wed, 11 Dec 2024 23:38:30 +0800
Message-ID: <CAFTtA3OLkteZq1G0bi7La3r1RDc7K9fZvnApYdwqcs+9pMfs4g@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt improvements
To: Evgenii Shatokhin <e.shatokhin@yadro.com>
Cc: Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev, bjorn@rivosinc.com, 
	puranjay12@gmail.com, alexghiti@rivosinc.com, yongxuan.wang@sifive.com, 
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com, 
	tommy.wu@sifive.com, eric.lin@sifive.com, viccent.chen@sifive.com, 
	zong.li@sifive.com, samuel.holland@sifive.com, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Evgenii,

Evgenii Shatokhin <e.shatokhin@yadro.com> =E6=96=BC 2024=E5=B9=B412=E6=9C=
=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:58=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> On 27.11.2024 20:29, Andy Chiu wrote:
> > This series makes atmoic code patching possible in riscv ftrace. A
> > direct benefit of this is that we can get rid of stop_machine() when
> > patching function entries. This also makes it possible to run ftrace
> > with full kernel preemption. Before this series, the kernel initializes
> > patchable function entries to NOP4 + NOP4. To start tracing, it updates
> > entries to AUIPC + JALR while holding other cores in stop_machine.
> > stop_machine() is required because it is impossible to update 2
> > instructions, and be seen atomically. And preemption must have to be
> > prevented, as kernel preemption allows process to be scheduled out whil=
e
> > executing on one of these instruction pairs.
> >
> > This series addresses the problem by initializing the first NOP4 to
> > AUIPC. So, atmoic patching is possible because the kernel only has to
> > update one instruction. As long as the instruction is naturally aligned=
,
> > then it is expected to be updated atomically.
> >
> > However, the address range of the ftrace trampoline is limited to +-2K
> > from ftrace_caller after appplying this series. This issue is expected
> > to be solved by Puranjay's CALL_OPS, where it adds 8B naturally align
> > data in front of pacthable functions and can  use it to direct executio=
n
> > out to any custom trampolines.
> >
> > The series is composed by three parts. The first part cleans up the
> > existing issues when the kernel is compiled with clang.The second part
> > modifies the ftrace code patching mechanism (2-4) as mentioned above.
> > Then prepare ftrace to be able to run with kernel preemption (5,6)
> >
> > An ongoing fix:
> >
> > Since there is no room for marking *kernel_text_address as notrace[1] a=
t
> > source code level, there is a significant performance regression when
> > using function_graph with TRACE_IRQFLAGS enabled. There can be as much =
as
> > 8 graph handler being called in each function-entry. The current
> > workaround requires us echo "*kernel_text_address" into
> > set_ftrace_notrace before starting the trace. However, we observed that
> > the kernel still enables the patch site in some cases even with
> > *kernel_text_address properly added in the file While the root cause is
> > still under investagtion, we consider that it should not be the reason
> > for holding back the code patching, in order to unblock the call_ops
> > part.
> >
> > [1]: https://lore.kernel.org/linux-riscv/20240613093233.0b349ed0@rorsch=
ach.local.home/
> >
> > Changes in v3:
> > - Add a fix tag for patch 1
> > - Add a data fence before sending out remote fence.i (6)
> > - Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace=
-v4-v2-0-1e5f4cb1f049@sifive.com/
> >
> > Changes in v2:
> > - Drop patch 1 as it is merged through fixes.
> > - Drop patch 2, which converts kernel_text_address into notrace. As
> >    users can prevent tracing it by configuring the tracefs.
> > - Use a more generic way in kconfig to align functions.
> > - Link to v1: https://lore.kernel.org/r/20240613-dev-andyc-dyn-ftrace-v=
4-v1-0-1a538e12c01e@sifive.com
> >
> >
> > Andy Chiu (7):
> >    riscv: ftrace: support fastcc in Clang for WITH_ARGS
> >    riscv: ftrace: align patchable functions to 4 Byte boundary
> >    riscv: ftrace: prepare ftrace for atomic code patching
> >    riscv: ftrace: do not use stop_machine to update code
> >    riscv: vector: Support calling schedule() for preemptible Vector
> >    riscv: add a data fence for CMODX in the kernel mode
> >    riscv: ftrace: support PREEMPT
> >
> >   arch/riscv/Kconfig                 |   4 +-
> >   arch/riscv/include/asm/ftrace.h    |  11 +++
> >   arch/riscv/include/asm/processor.h |   5 ++
> >   arch/riscv/include/asm/vector.h    |  22 ++++-
> >   arch/riscv/kernel/asm-offsets.c    |   7 ++
> >   arch/riscv/kernel/ftrace.c         | 133 ++++++++++++----------------=
-
> >   arch/riscv/kernel/mcount-dyn.S     |  25 ++++--
> >   arch/riscv/mm/cacheflush.c         |  15 +++-
> >   8 files changed, 135 insertions(+), 87 deletions(-)
> > ---
> > base-commit: 0eb512779d642b21ced83778287a0f7a3ca8f2a1
> > --
> > 2.39.3 (Apple Git-145)
>
> I have tested this series in a QEMU VM (-machine virt) with the
> preemptible kernels, CONFIG_PREEMPT=3Dy.
>
> No issues have been revealed so far.
>
> One of the kernels was built by GCC 13.2.0 (with the patch for minimum
> alignment added on top of it), the other - with LLVM 17.0.6.
>
> In both cases, the basic boottime tests for Ftrace passed.
>
> Switching tracers between nop, function, function_graph and blk in a
> loop in parallel with stress-ng and with network load for several hours
> did not reveal any problems either. Kernel crashes happened in this
> scenario a year ago, but now it runs clean, good!
>
> Function redirection via Ftrace seems to work OK too.
>
> The size of .text section increased slightly after this series, by 0.35%
> - 0.38%, probably because of function alignment:
> * 12075 KB =3D> 12121 KB (GCC)
> * 12167 KB =3D> 12209 KB (LLVM/clang)
>
> Not sure, how to test the vector-related part though, "[PATCH v3 5/7]
> riscv: vector: Support calling schedule() for preemptible Vector"

This should be tested as long as both the kernel is compiled with
RISCV_ISA_V and PREEMPT, and the hardware supports v.

And thanks for the extensive testing

>
> For all other patches in the series:
> Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
>
> Regards,
> Evgenii

