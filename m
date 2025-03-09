Return-Path: <linux-kernel+bounces-552865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16825A5800B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 01:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D9616BD7B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 00:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50B8BE8;
	Sun,  9 Mar 2025 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Plxp/CH3"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76E2595
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 00:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741480468; cv=none; b=LZVk4bW3Ov0hRUm9LWZSbN73I2Yv0vo8chPhOV1Ngcae/Gfv52dnU3GmaYqZiCyTG8aXDdEK+OAJVbILZiN0yaD+5d4X14IowT7+JeT4A7RJskPCF/yWIKhWo7NTqU6UAr5U2YEpwfnTzzbXKL2jBNM5xsNs4T2nshUZj6xqWWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741480468; c=relaxed/simple;
	bh=24OafdFYqrCM4AXZxvh81iR0d0fQffoZA6fe3MfXydA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XhaOydi1DKEhElXUcI3cSdzDvTfSblDqp9k9bTJ/DbcSq6pXrnWHknjWeYvtBCLhc+XmnOng9FJob2v1YjM0B4GEe0U5wvK4U2LnyLb7CnlIvdIZAnUyhPfO9YnISKnYa3GrAC6qpHWKN8pbd8Xm2BJPUExPLq6mPBqxdcp0LwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Plxp/CH3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5290XsS21011125
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 8 Mar 2025 16:33:54 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5290XsS21011125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741480435;
	bh=jwnQgl2F6vbcYgAdVpb0tXv9ro3+wkJbF5qFpvC8dkw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Plxp/CH3YewiEd6j65IKC3tqnjdl8qp1LDpSLdefG9mHdn467pI3d196pyn8eIJTI
	 l4iH7qoHIKyLo8+RpuT1BgWuQPnL4iRsGbioL0Iesf0pNYKzOE25toIKfZMznhRLVC
	 yoMzK0dLxMcI/LYDhBlihfZptkTSezbKp03DxjD8t4ovEO76s90aW8xNgzkqao5xWb
	 Q3AZD4msexPkvlXTivyBhnVWlq4avbe1Unmp3yd/OzX0kJ78PBZRiftnmolrj1jd7k
	 el3AhtzsxEuMbGWt6RQCvgCcyYS78GBfcqSLXKtg7AZEWtzGpbBuX8FWYCNSmuSMDe
	 f3CamK87Vy6og==
Date: Sat, 08 Mar 2025 16:33:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>
CC: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_Do_not_test_if_AC?=
 =?US-ASCII?Q?_and_ID_eflags_are_changeable_on_x86=5F64?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z8yb2f8nqvN_K-PA@gmail.com>
References: <20250307091022.181136-1-ubizjak@gmail.com> <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com> <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com> <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com> <Z8yb2f8nqvN_K-PA@gmail.com>
Message-ID: <8A6A51C0-E575-47FC-9E5D-3EE82854034D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 8, 2025 11:34:49 AM PST, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>
>> On March 7, 2025 4:15:42 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrot=
e:
>> >On Fri, Mar 7, 2025 at 12:58=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2E=
com> wrote:
>> >>
>> >> On March 7, 2025 1:10:03 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> w=
rote:
>> >> >The test for the changeabitily of AC and ID eflags is used to
>> >> >distinguish between i386 and i486 processors (AC) and to test
>> >> >for cpuid instruction support (ID)=2E
>> >> >
>> >> >Skip these tests on x86_64 processors as they always supports cpuid=
=2E
>> >> >
>> >> >Also change the return type of has_eflag() to bool=2E
>> >> >
>> >> >Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >> >Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> >> >Cc: Ingo Molnar <mingo@kernel=2Eorg>
>> >> >Cc: Borislav Petkov <bp@alien8=2Ede>
>> >> >Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> >> >Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> >> >---
>> >> > arch/x86/boot/cpuflags=2Ec | 26 +++++++++-----------------
>> >> > arch/x86/boot/cpuflags=2Eh |  6 +++++-
>> >> > 2 files changed, 14 insertions(+), 18 deletions(-)
>> >> >
>> >> >diff --git a/arch/x86/boot/cpuflags=2Ec b/arch/x86/boot/cpuflags=2E=
c
>> >> >index d75237ba7ce9=2E=2E2150a016176f 100644
>> >> >--- a/arch/x86/boot/cpuflags=2Ec
>> >> >+++ b/arch/x86/boot/cpuflags=2Ec
>> >> >@@ -29,40 +29,32 @@ static int has_fpu(void)
>> >> >       return fsw =3D=3D 0 && (fcw & 0x103f) =3D=3D 0x003f;
>> >> > }
>> >> >
>> >> >+#ifdef CONFIG_X86_32
>> >> > /*
>> >> >  * For building the 16-bit code we want to explicitly specify 32-b=
it
>> >> >  * push/pop operations, rather than just saying 'pushf' or 'popf' =
and
>> >> >- * letting the compiler choose=2E But this is also included from t=
he
>> >> >- * compressed/ directory where it may be 64-bit code, and thus nee=
ds
>> >> >- * to be 'pushfq' or 'popfq' in that case=2E
>> >> >+ * letting the compiler choose=2E
>> >> >  */
>> >> >-#ifdef __x86_64__
>> >> >-#define PUSHF "pushfq"
>> >> >-#define POPF "popfq"
>> >> >-#else
>> >> >-#define PUSHF "pushfl"
>> >> >-#define POPF "popfl"
>> >> >-#endif
>> >> >-
>> >> >-int has_eflag(unsigned long mask)
>> >> >+bool has_eflag(unsigned long mask)
>> >> > {
>> >> >       unsigned long f0, f1;
>> >> >
>> >> >-      asm volatile(PUSHF "    \n\t"
>> >> >-                   PUSHF "    \n\t"
>> >> >+      asm volatile("pushfl    \n\t"
>> >> >+                   "pushfl    \n\t"
>> >> >                    "pop %0    \n\t"
>> >> >                    "mov %0,%1 \n\t"
>> >> >                    "xor %2,%1 \n\t"
>> >> >                    "push %1   \n\t"
>> >> >-                   POPF "     \n\t"
>> >> >-                   PUSHF "    \n\t"
>> >> >+                   "popfl     \n\t"
>> >> >+                   "pushfl    \n\t"
>> >> >                    "pop %1    \n\t"
>> >> >-                   POPF
>> >> >+                   "popfl"
>> >> >                    : "=3D&r" (f0), "=3D&r" (f1)
>> >> >                    : "ri" (mask));
>> >> >
>> >> >       return !!((f0^f1) & mask);
>> >> > }
>> >> >+#endif
>> >> >
>> >> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d=
)
>> >> > {
>> >> >diff --git a/arch/x86/boot/cpuflags=2Eh b/arch/x86/boot/cpuflags=2E=
h
>> >> >index fdcc2aa4c3c4=2E=2Ea398d9204ad0 100644
>> >> >--- a/arch/x86/boot/cpuflags=2Eh
>> >> >+++ b/arch/x86/boot/cpuflags=2Eh
>> >> >@@ -15,7 +15,11 @@ struct cpu_features {
>> >> > extern struct cpu_features cpu;
>> >> > extern u32 cpu_vendor[3];
>> >> >
>> >> >-int has_eflag(unsigned long mask);
>> >> >+#ifdef CONFIG_X86_32
>> >> >+bool has_eflag(unsigned long mask);
>> >> >+#else
>> >> >+static inline bool has_eflag(unsigned long mask) { return true; }
>> >> >+#endif
>> >> > void get_cpuflags(void);
>> >> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d=
);
>> >> > bool has_cpuflag(int flag);
>> >>
>> >> PUSF et al =E2=86=92 pushf
>> >>
>> >> The -l and -q suffixes have been optional for a long time=2E
>> >
>> >No, not in this case=2E Please see the comment:
>> >
>> >/*
>> >* For building the 16-bit code we want to explicitly specify 32-bit
>> >* push/pop operations, rather than just saying 'pushf' or 'popf' and
>> >* letting the compiler choose=2E
>> >*/
>> >
>> >We are building 16-bit code here, and we want PUSHFL, the one with
>> >operand size prefix 0x66=2E
>> >
>> >Please consider the following code:
>> >
>> >    =2Ecode16
>> >    pushf
>> >    pushfl
>> >
>> >as -o push=2Eo push=2Es
>> >
>> >objdump -dr -Mdata16 push=2Eo
>> >
>> >0000000000000000 <=2Etext>:
>> >  0:   9c                      pushf
>> >  1:   66 9c                   pushfl
>> >
>> >Uros=2E
>> >
>>=20
>> *plonk* I should have remembered (=2Ecode16gcc is different then=20
>> =2Ecode16 though=2E) I wrote the damned things after all=2E=2E=2E
>
>So I'll read this as a tentative:
>
>  Acked-by: H=2E Peter Anvin <hpa@zytor=2Ecom>
>
>Let me know if I'm not reading the room right=2E :-)
>
>	Ingo

Indeed=2E

