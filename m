Return-Path: <linux-kernel+bounces-549102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCB7A54D54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38863A43D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C2155C8C;
	Thu,  6 Mar 2025 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hFwyi/WM"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294631465B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270510; cv=none; b=nGrcfvLiSlDMNb5EPT0U5lhbgQJeVOMkBqhiSfB4TDWoGYH3/77j4e9adwwL0eibGh0PF+OAdCqE/B7ZxASTGPcYNA/SYmqlwRCjcrJuPRdWGrisPVNGxSiG9U1GXkACbx3RO31opCfVcD+PVxIWgLHM3Yp6MzzrQsVTpPxKw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270510; c=relaxed/simple;
	bh=miTDBrPybomH7WkT1I2bzNaVEdYlqsmuhkAv2w5gJto=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aC7/aGXOuyQdX9O/X6Wn8fkmTt6YyWrDGNB9tAkAbrSMVmsksveOH2+j5D2sTouiY7jbdkdqtOSK0eIMEHRsLFyUrhDcgPA+XWloYcuPQmNYA21q8CtKQK/HwnZEMDBztk6XOKz+9+O/QyEbyI6hv5jdsRZhp6+sMNzKLrpSdBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hFwyi/WM; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 526EETLJ3958388
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 6 Mar 2025 06:14:30 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 526EETLJ3958388
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741270470;
	bh=WeehDnywaXguMXrvEnhus82DM0aNP1EJuMRnUv+8dNs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hFwyi/WMmmFq3Qy8UF1e7sAgoppQCALu8ReY2+dS8zoaECwIQQFlcG48Z2VAC6V4O
	 9mprVdVRBykuEAm3AeJxSC4q1yUdpidn1LHrB/sZm2fensBm6W44CVz4wxm0w+h/Mb
	 FP26WE1ftLAvEGIXtYcfDjxrgg2j0rEr+eiStaRJCoE9FrvWeV3wPx/jIwhrxRESQd
	 kG3tWnT1Glw/2ER4bhxx0Pgy5M0EJiHczBfL/GIme0e2dqpfRKBPSRODskE9HibGr2
	 o1h1kNJ3MNdcRjqvIKo8g5CcS8DXbmq6iJ8+NCbwiV7G969PTC1Uxp0kaxWEr953tI
	 MZH1BUQHuhzKw==
Date: Thu, 06 Mar 2025 06:14:27 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/kexec=3A_Merge_x86=5F32_a?=
 =?US-ASCII?Q?nd_x86=5F64_code_using_macros_from_asm=2Eh?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250305162649.130270-1-ubizjak@gmail.com>
References: <20250305162649.130270-1-ubizjak@gmail.com>
Message-ID: <1A02CCC5-8D03-44B0-A927-3BEC671C7744@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 5, 2025 8:26:37 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>Merge common x86_32 and x86_64 code in crash_setup_regs()
>using macros from asm/asm=2Eh=2E
>
>The compiled object files before and after the patch are unchanged=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@kernel=2Eorg>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
> arch/x86/include/asm/asm=2Eh   |  2 ++
> arch/x86/include/asm/kexec=2Eh | 44 +++++++++++++++---------------------
> 2 files changed, 20 insertions(+), 26 deletions(-)
>
>diff --git a/arch/x86/include/asm/asm=2Eh b/arch/x86/include/asm/asm=2Eh
>index 975ae7a9397e=2E=2E2bccc063d30b 100644
>--- a/arch/x86/include/asm/asm=2Eh
>+++ b/arch/x86/include/asm/asm=2Eh
>@@ -41,6 +41,8 @@
> #define _ASM_SUB	__ASM_SIZE(sub)
> #define _ASM_XADD	__ASM_SIZE(xadd)
> #define _ASM_MUL	__ASM_SIZE(mul)
>+#define _ASM_PUSHF	__ASM_SIZE(pushf)
>+#define _ASM_POP	__ASM_SIZE(pop)
>=20
> #define _ASM_AX		__ASM_REG(ax)
> #define _ASM_BX		__ASM_REG(bx)
>diff --git a/arch/x86/include/asm/kexec=2Eh b/arch/x86/include/asm/kexec=
=2Eh
>index 8ad187462b68=2E=2E56040ae6bda0 100644
>--- a/arch/x86/include/asm/kexec=2Eh
>+++ b/arch/x86/include/asm/kexec=2Eh
>@@ -18,6 +18,7 @@
> #include <linux/string=2Eh>
> #include <linux/kernel=2Eh>
>=20
>+#include <asm/asm=2Eh>
> #include <asm/page=2Eh>
> #include <asm/ptrace=2Eh>
>=20
>@@ -71,29 +72,15 @@ static inline void crash_setup_regs(struct pt_regs *n=
ewregs,
> 	if (oldregs) {
> 		memcpy(newregs, oldregs, sizeof(*newregs));
> 	} else {
>-#ifdef CONFIG_X86_32
>-		asm volatile("movl %%ebx,%0" : "=3Dm"(newregs->bx));
>-		asm volatile("movl %%ecx,%0" : "=3Dm"(newregs->cx));
>-		asm volatile("movl %%edx,%0" : "=3Dm"(newregs->dx));
>-		asm volatile("movl %%esi,%0" : "=3Dm"(newregs->si));
>-		asm volatile("movl %%edi,%0" : "=3Dm"(newregs->di));
>-		asm volatile("movl %%ebp,%0" : "=3Dm"(newregs->bp));
>-		asm volatile("movl %%eax,%0" : "=3Dm"(newregs->ax));
>-		asm volatile("movl %%esp,%0" : "=3Dm"(newregs->sp));
>-		asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
>-		asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
>-		asm volatile("movl %%ds, %%eax;" :"=3Da"(newregs->ds));
>-		asm volatile("movl %%es, %%eax;" :"=3Da"(newregs->es));
>-		asm volatile("pushfl; popl %0" :"=3Dm"(newregs->flags));
>-#else
>-		asm volatile("movq %%rbx,%0" : "=3Dm"(newregs->bx));
>-		asm volatile("movq %%rcx,%0" : "=3Dm"(newregs->cx));
>-		asm volatile("movq %%rdx,%0" : "=3Dm"(newregs->dx));
>-		asm volatile("movq %%rsi,%0" : "=3Dm"(newregs->si));
>-		asm volatile("movq %%rdi,%0" : "=3Dm"(newregs->di));
>-		asm volatile("movq %%rbp,%0" : "=3Dm"(newregs->bp));
>-		asm volatile("movq %%rax,%0" : "=3Dm"(newregs->ax));
>-		asm volatile("movq %%rsp,%0" : "=3Dm"(newregs->sp));
>+		asm volatile(_ASM_MOV " %%" _ASM_BX ",%0" : "=3Dm"(newregs->bx));
>+		asm volatile(_ASM_MOV " %%" _ASM_CX ",%0" : "=3Dm"(newregs->cx));
>+		asm volatile(_ASM_MOV " %%" _ASM_DX ",%0" : "=3Dm"(newregs->dx));
>+		asm volatile(_ASM_MOV " %%" _ASM_SI ",%0" : "=3Dm"(newregs->si));
>+		asm volatile(_ASM_MOV " %%" _ASM_DI ",%0" : "=3Dm"(newregs->di));
>+		asm volatile(_ASM_MOV " %%" _ASM_BP ",%0" : "=3Dm"(newregs->bp));
>+		asm volatile(_ASM_MOV " %%" _ASM_AX ",%0" : "=3Dm"(newregs->ax));
>+		asm volatile(_ASM_MOV " %%" _ASM_SP ",%0" : "=3Dm"(newregs->sp));
>+#ifdef CONFIG_X86_64
> 		asm volatile("movq %%r8,%0" : "=3Dm"(newregs->r8));
> 		asm volatile("movq %%r9,%0" : "=3Dm"(newregs->r9));
> 		asm volatile("movq %%r10,%0" : "=3Dm"(newregs->r10));
>@@ -102,10 +89,15 @@ static inline void crash_setup_regs(struct pt_regs *=
newregs,
> 		asm volatile("movq %%r13,%0" : "=3Dm"(newregs->r13));
> 		asm volatile("movq %%r14,%0" : "=3Dm"(newregs->r14));
> 		asm volatile("movq %%r15,%0" : "=3Dm"(newregs->r15));
>-		asm volatile("movl %%ss, %%eax;" :"=3Da"(newregs->ss));
>-		asm volatile("movl %%cs, %%eax;" :"=3Da"(newregs->cs));
>-		asm volatile("pushfq; popq %0" :"=3Dm"(newregs->flags));
> #endif
>+		asm volatile("movl %%ss,%k0" :"=3Da"(newregs->ss));
>+		asm volatile("movl %%cs,%k0" :"=3Da"(newregs->cs));
>+#ifdef CONFIG_X86_32
>+		asm volatile("movl %%ds,%k0" :"=3Da"(newregs->ds));
>+		asm volatile("movl %%es,%k0" :"=3Da"(newregs->es));
>+#endif
>+		asm volatile(_ASM_PUSHF "\n\t"
>+			     _ASM_POP " %0" : "=3Dm"(newregs->flags));
> 		newregs->ip =3D _THIS_IP_;
> 	}
> }

There is no reason to stick a size suffix on if it is unambiguous=2E Norma=
lly pushf/popf never are, since stack operations are promoted automatically=
=2E

