Return-Path: <linux-kernel+bounces-551138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5DBA56896
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D5C3B2977
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E919F21A452;
	Fri,  7 Mar 2025 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hcAhH0B4"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DF21A451
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353236; cv=none; b=A2FzSswG9i06QyA8KkxXQrfJvyGOTsx6k2lGt/oHejWAhqnZUC/rQfJpZor4dd0OTrx+3nDGf96PwRzYZiiOJ8+afDM+ZZqx/fMxZglJcIYb5jI6DU5K90Xa3mgRu5MC5W0unDFki53BCigE+cITiaDtIouRpk0req+VCzCGui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353236; c=relaxed/simple;
	bh=HDEhaHuPewSpiRG7U5iiiutyWevnX9rWtyV9/LS3zxI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=C9hZzZD5rf/kRQ8kDipL5eR4Pcfp/M0TuFOSlMAYs2yKnu6lxqDLIiaK6duzODkE1PZiV/CW4xKHxXcAlgvbafF0yS42/zsqG0XKpVzuVeCBwz8Knmcy5kez5RkN7NeUOv/zKK3/hy8AL3DocUNSu8rawx/S3ialdQoz94IVh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hcAhH0B4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527DDS0p237451
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 05:13:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527DDS0p237451
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741353209;
	bh=iaTkxDBCZ5V/IhHlwyZkZzK8j/J/8RUvbNBgrlF/qCQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hcAhH0B4FFKmoBjBnIXmdcDnD7fD08nXTCGmKqenGZRoiFS1q+fL+eFNue+q8naWw
	 QFr58zbNXPEdJtwd+y1EDlCjDdJ3vANNHehP6VLmnYbe8/DbG3NHMOzrZUzHc2yKFS
	 e36VkRLEC3cAyH5hxMOGxpe5O/6LrXEndpkMqhSryXNKAUq44Ow+LOszHoI8/FYXqq
	 oh9JuSK0vAXvf/Yp4lnZToETnGlov8grlfx92tYQ3fnPBaouFUXbbGlln55Ih5w3Tg
	 4qYEshh2NRZroJuyprOKCmvOLMeyn17Q2QlCm70R+FaZi8XgRq0Pu7eZu2FcxpzDA0
	 JqJXBn+rZG1fw==
Date: Fri, 07 Mar 2025 05:13:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
CC: x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/boot=3A_Do_not_test_if_AC?=
 =?US-ASCII?Q?_and_ID_eflags_are_changeable_on_x86=5F64?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com>
References: <20250307091022.181136-1-ubizjak@gmail.com> <DC668A65-3173-4A0C-BF78-1CECF60D300B@zytor.com> <CAFULd4aMkxYp6L=grE7TrvvfdX7gTGOTAJgojJ=mjHfDLJ=kVQ@mail.gmail.com>
Message-ID: <E3E112F8-CC41-4933-9FEC-B53D6A0AFA7A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 7, 2025 4:15:42 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrote:
>On Fri, Mar 7, 2025 at 12:58=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ecom=
> wrote:
>>
>> On March 7, 2025 1:10:03 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrot=
e:
>> >The test for the changeabitily of AC and ID eflags is used to
>> >distinguish between i386 and i486 processors (AC) and to test
>> >for cpuid instruction support (ID)=2E
>> >
>> >Skip these tests on x86_64 processors as they always supports cpuid=2E
>> >
>> >Also change the return type of has_eflag() to bool=2E
>> >
>> >Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>> >Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> >Cc: Ingo Molnar <mingo@kernel=2Eorg>
>> >Cc: Borislav Petkov <bp@alien8=2Ede>
>> >Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> >Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> >---
>> > arch/x86/boot/cpuflags=2Ec | 26 +++++++++-----------------
>> > arch/x86/boot/cpuflags=2Eh |  6 +++++-
>> > 2 files changed, 14 insertions(+), 18 deletions(-)
>> >
>> >diff --git a/arch/x86/boot/cpuflags=2Ec b/arch/x86/boot/cpuflags=2Ec
>> >index d75237ba7ce9=2E=2E2150a016176f 100644
>> >--- a/arch/x86/boot/cpuflags=2Ec
>> >+++ b/arch/x86/boot/cpuflags=2Ec
>> >@@ -29,40 +29,32 @@ static int has_fpu(void)
>> >       return fsw =3D=3D 0 && (fcw & 0x103f) =3D=3D 0x003f;
>> > }
>> >
>> >+#ifdef CONFIG_X86_32
>> > /*
>> >  * For building the 16-bit code we want to explicitly specify 32-bit
>> >  * push/pop operations, rather than just saying 'pushf' or 'popf' and
>> >- * letting the compiler choose=2E But this is also included from the
>> >- * compressed/ directory where it may be 64-bit code, and thus needs
>> >- * to be 'pushfq' or 'popfq' in that case=2E
>> >+ * letting the compiler choose=2E
>> >  */
>> >-#ifdef __x86_64__
>> >-#define PUSHF "pushfq"
>> >-#define POPF "popfq"
>> >-#else
>> >-#define PUSHF "pushfl"
>> >-#define POPF "popfl"
>> >-#endif
>> >-
>> >-int has_eflag(unsigned long mask)
>> >+bool has_eflag(unsigned long mask)
>> > {
>> >       unsigned long f0, f1;
>> >
>> >-      asm volatile(PUSHF "    \n\t"
>> >-                   PUSHF "    \n\t"
>> >+      asm volatile("pushfl    \n\t"
>> >+                   "pushfl    \n\t"
>> >                    "pop %0    \n\t"
>> >                    "mov %0,%1 \n\t"
>> >                    "xor %2,%1 \n\t"
>> >                    "push %1   \n\t"
>> >-                   POPF "     \n\t"
>> >-                   PUSHF "    \n\t"
>> >+                   "popfl     \n\t"
>> >+                   "pushfl    \n\t"
>> >                    "pop %1    \n\t"
>> >-                   POPF
>> >+                   "popfl"
>> >                    : "=3D&r" (f0), "=3D&r" (f1)
>> >                    : "ri" (mask));
>> >
>> >       return !!((f0^f1) & mask);
>> > }
>> >+#endif
>> >
>> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d)
>> > {
>> >diff --git a/arch/x86/boot/cpuflags=2Eh b/arch/x86/boot/cpuflags=2Eh
>> >index fdcc2aa4c3c4=2E=2Ea398d9204ad0 100644
>> >--- a/arch/x86/boot/cpuflags=2Eh
>> >+++ b/arch/x86/boot/cpuflags=2Eh
>> >@@ -15,7 +15,11 @@ struct cpu_features {
>> > extern struct cpu_features cpu;
>> > extern u32 cpu_vendor[3];
>> >
>> >-int has_eflag(unsigned long mask);
>> >+#ifdef CONFIG_X86_32
>> >+bool has_eflag(unsigned long mask);
>> >+#else
>> >+static inline bool has_eflag(unsigned long mask) { return true; }
>> >+#endif
>> > void get_cpuflags(void);
>> > void cpuid_count(u32 id, u32 count, u32 *a, u32 *b, u32 *c, u32 *d);
>> > bool has_cpuflag(int flag);
>>
>> PUSF et al =E2=86=92 pushf
>>
>> The -l and -q suffixes have been optional for a long time=2E
>
>No, not in this case=2E Please see the comment:
>
>/*
>* For building the 16-bit code we want to explicitly specify 32-bit
>* push/pop operations, rather than just saying 'pushf' or 'popf' and
>* letting the compiler choose=2E
>*/
>
>We are building 16-bit code here, and we want PUSHFL, the one with
>operand size prefix 0x66=2E
>
>Please consider the following code:
>
>    =2Ecode16
>    pushf
>    pushfl
>
>as -o push=2Eo push=2Es
>
>objdump -dr -Mdata16 push=2Eo
>
>0000000000000000 <=2Etext>:
>  0:   9c                      pushf
>  1:   66 9c                   pushfl
>
>Uros=2E
>

*plonk* I should have remembered (=2Ecode16gcc is different then =2Ecode16=
 though=2E) I wrote the damned things after all=2E=2E=2E

