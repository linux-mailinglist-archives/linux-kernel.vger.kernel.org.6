Return-Path: <linux-kernel+bounces-552760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9329A57DCC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2055A16D78C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1E1B424E;
	Sat,  8 Mar 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMOQ2siz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A22A8C1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741462494; cv=none; b=pQzTfmVnhXw9k8QTueSk+rSv6bJ4JfasbclQfRUiD37JYeUkUxzsUj9xFpVhOVl7g5r1DPVwP+hjPQLUKMvSRairzKjtC7liXhECA6m9FIOyrQomIb5g10b+j0ZVcfnM8giU0Dc3UO029Tua79+QyJuEmqSdSHnZ4GYRx/n58UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741462494; c=relaxed/simple;
	bh=XNbvfbl9PP9G8yGmtpy35qtIz7wmhgMPojP/eFF63yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OScS7+gEww9f2RI+WPZu0cOqbptmW0rTaK7Up3/5R7Zd1D1899WSRwu/738oEKmCPL22qQytj5+CdZMeVzcsBd1KxNtnYg8NdnZBC4A8/vqOQHr0OkqVj1XF7DcmQDZEqMmxXgMXWBDh/LN5sHpz8soVKfZRjwtawAaC6lVPNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMOQ2siz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB1C4CEE0;
	Sat,  8 Mar 2025 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741462494;
	bh=XNbvfbl9PP9G8yGmtpy35qtIz7wmhgMPojP/eFF63yA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMOQ2sizIB2deF+OKEMldRWVQSjPOpFR6hdO69rNpUD8l3bA99jg+QLlIOsNQDPQA
	 RO1DALt0WGDCTmYLlYr6j8kaBhxIFTt/De3fO20Y5wD1ae5GFxb61SOHtrPRMleXfR
	 e3/JFYZFwFmwInASfetXZh1NCi/p6yU2srloG16+MeOiGJubVfStxijRle5oVGZ0A/
	 kcA/J4uYB8ghk3LCVhy8cMQIo5jCFiKxYHBJKOg8f3545Qo9M9FDNSBL77iVA2Iql9
	 75hy2qak03EPRXvG8Jo/T0jtt5u0b/ZXZfR5+QKDemFnL5fUiHj+VUUmLU7UM6918c
	 n5h5EWXLbnPnA==
Date: Sat, 8 Mar 2025 20:34:49 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/boot: Do not test if AC and ID eflags are changeable
 on x86_64
Message-ID: <Z8yb2f8nqvN_K-PA@gmail.com>
References: <20250307091022.181136-1-ubizjak@gmail.com>
 <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com>
 <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com>
 <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com>


* H. Peter Anvin <hpa@zytor.com> wrote:

> On March 7, 2025 4:15:42 AM PST, Uros Bizjak <ubizjak@gmail.com> wrote:
> >On Fri, Mar 7, 2025 at 12:58 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> On March 7, 2025 1:10:03 AM PST, Uros Bizjak <ubizjak@gmail.com> wrote:
> >> >The test for the changeabitily of AC and ID eflags is used to
> >> >distinguish between i386 and i486 processors (AC) and to test
> >> >for cpuid instruction support (ID).
> >> >
> >> >Skip these tests on x86_64 processors as they always supports cpuid.
> >> >
> >> >Also change the return type of has_eflag() to bool.
> >> >
> >> >Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> >> >Cc: Thomas Gleixner <tglx@linutronix.de>
> >> >Cc: Ingo Molnar <mingo@kernel.org>
> >> >Cc: Borislav Petkov <bp@alien8.de>
> >> >Cc: Dave Hansen <dave.hansen@linux.intel.com>
> >> >Cc: "H. Peter Anvin" <hpa@zytor.com>
> >> >---
> >> > arch/x86/boot/cpuflags.c | 26 +++++++++-----------------
> >> > arch/x86/boot/cpuflags.h |  6 +++++-
> >> > 2 files changed, 14 insertions(+), 18 deletions(-)
> >> >
> >> >diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> >> >index d75237ba7ce9..2150a016176f 100644
> >> >--- a/arch/x86/boot/cpuflags.c
> >> >+++ b/arch/x86/boot/cpuflags.c
> >> >@@ -29,40 +29,32 @@ static int has_fpu(void)
> >> >       return fsw == 0 && (fcw & 0x103f) == 0x003f;
> >> > }
> >> >
> >> >+#ifdef CONFIG_X86_32
> >> > /*
> >> >  * For building the 16-bit code we want to explicitly specify 32-bit
> >> >  * push/pop operations, rather than just saying 'pushf' or 'popf' and
> >> >- * letting the compiler choose. But this is also included from the
> >> >- * compressed/ directory where it may be 64-bit code, and thus needs
> >> >- * to be 'pushfq' or 'popfq' in that case.
> >> >+ * letting the compiler choose.
> >> >  */
> >> >-#ifdef __x86_64__
> >> >-#define PUSHF "pushfq"
> >> >-#define POPF "popfq"
> >> >-#else
> >> >-#define PUSHF "pushfl"
> >> >-#define POPF "popfl"
> >> >-#endif
> >> >-
> >> >-int has_eflag(unsigned long mask)
> >> >+bool has_eflag(unsigned long mask)
> >> > {
> >> >       unsigned long f0, f1;
> >> >
> >> >-      asm volatile(PUSHF "    \n\t"
> >> >-                   PUSHF "    \n\t"
> >> >+      asm volatile("pushfl    \n\t"
> >> >+                   "pushfl    \n\t"
> >> >                    "pop %0    \n\t"
> >> >                    "mov %0,%1 \n\t"
> >> >                    "xor %2,%1 \n\t"
> >> >                    "push %1   \n\t"
> >> >-                   POPF "     \n\t"
> >> >-                   PUSHF "    \n\t"
> >> >+                   "popfl     \n\t"
> >> >+                   "pushfl    \n\t"
> >> >                    "pop %1    \n\t"
> >> >-                   POPF
> >> >+                   "popfl"
> >> >                    : "=&r" (f0), "=&r" (f1)
> >> >                    : "ri" (mask));
> >> >
> >> >       return !!((f0^f1) & mask);
> >> > }
> >> >+#endif
> >> >
> >> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
> >> > {
> >> >diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
> >> >index fdcc2aa4c3c4..a398d9204ad0 100644
> >> >--- a/arch/x86/boot/cpuflags.h
> >> >+++ b/arch/x86/boot/cpuflags.h
> >> >@@ -15,7 +15,11 @@ struct cpu_features {
> >> > extern struct cpu_features cpu;
> >> > extern u32 cpu_vendor[3];
> >> >
> >> >-int has_eflag(unsigned long mask);
> >> >+#ifdef CONFIG_X86_32
> >> >+bool has_eflag(unsigned long mask);
> >> >+#else
> >> >+static inline bool has_eflag(unsigned long mask) { return true; }
> >> >+#endif
> >> > void get_cpuflags(void);
> >> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
> >> > bool has_cpuflag(int flag);
> >>
> >> PUSF et al → pushf
> >>
> >> The -l and -q suffixes have been optional for a long time.
> >
> >No, not in this case. Please see the comment:
> >
> >/*
> >* For building the 16-bit code we want to explicitly specify 32-bit
> >* push/pop operations, rather than just saying 'pushf' or 'popf' and
> >* letting the compiler choose.
> >*/
> >
> >We are building 16-bit code here, and we want PUSHFL, the one with
> >operand size prefix 0x66.
> >
> >Please consider the following code:
> >
> >    .code16
> >    pushf
> >    pushfl
> >
> >as -o push.o push.s
> >
> >objdump -dr -Mdata16 push.o
> >
> >0000000000000000 <.text>:
> >  0:   9c                      pushf
> >  1:   66 9c                   pushfl
> >
> >Uros.
> >
> 
> *plonk* I should have remembered (.code16gcc is different then 
> .code16 though.) I wrote the damned things after all...

So I'll read this as a tentative:

  Acked-by: H. Peter Anvin <hpa@zytor.com>

Let me know if I'm not reading the room right. :-)

	Ingo

