Return-Path: <linux-kernel+bounces-542997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1480CA4D057
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191CF3A899E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC23BBC9;
	Tue,  4 Mar 2025 00:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BVMrPc9c"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AED2AE97
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048978; cv=none; b=XSjDbYyx951lwzxkM6le3bjHp5tU4X9gA/NczmgsiUOQx29ufltZWvqu99GZ6C7rgQ4HFl/wazEH6/M5Bj8zuFqAFiYVQSCv9WaYsBcKdwnHfRjxGUSTM+8An/GBEeN7lkshq4+gkAtCAI80hhV00N2oQ0H0CB8XVQ1YRefT+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048978; c=relaxed/simple;
	bh=kK93hzx+Jp9MaGwkTF3z7uDf6omLMmKu7tKji9PC424=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=f9zetusZpzl6m3abhlH28vDHu/Oybe9ALb5i2wQySS21IzXNw68ZJv6pfj9C266pIKYrsVZrO+IIiPhOofi8XKqRc78HkYsmcJWspmahRFBaY4HKia6O/TpEh/At7wX89QpxxLFL5LYHvcMkKZX9Zb8nHDSR1m8LScoaOW5i8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BVMrPc9c; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5240gX9C1830056
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 3 Mar 2025 16:42:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5240gX9C1830056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741048953;
	bh=3X0NhR31NcEZKG9MSGxkXXSaLk1FSYUAb8qUSre46Pc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BVMrPc9co6sQSLX1si2dQGjfhTcO4Fr+IZzSTYAdckkY3t5ENdE9fuvGlBqhHdw5/
	 x1vpPvndbtQ6p4887I+klL8P6hpM8OXJ3WEN3SAAJnNvMMobUB6BQFsyQf5rlJLWB2
	 kvwkYUirNSLocRW+0NaNWHLwZxctnf42yFWdumwFN3in1zV9eH/9ehAuFhzdx/aYve
	 rwjBlTZTaaHbPb+rICzrE1MrQUpXx2o7qT+tXKLsLjj+/eWnlTBPVWzcA1vs7BE4j3
	 b0BeP8uvoRTo526ZPLt5lSW8YBtMH1qWPvEwCBbB2s3gSUo6iuhHrpWhWwOkEyv/cw
	 0MO1qLs5ezOFQ==
Date: Mon, 03 Mar 2025 16:42:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Brian Gerst <brgerst@gmail.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/asm: Merge KSTK_ESP() implementations
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2jjcBtr73iuw8QaJ6MQxnnSRzr2SqDDKhfyDVnRETzLPg@mail.gmail.com>
References: <20250303183111.2245129-1-brgerst@gmail.com> <9FC474C9-284D-4EB5-BF8A-7B938247E577@zytor.com> <CAMzpN2jjcBtr73iuw8QaJ6MQxnnSRzr2SqDDKhfyDVnRETzLPg@mail.gmail.com>
Message-ID: <AE2B4950-6F26-4FF8-BB61-30EC8C2619E0@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 3, 2025 4:25:06 PM PST, Brian Gerst <brgerst@gmail=2Ecom> wrote:
>On Mon, Mar 3, 2025 at 7:01=E2=80=AFPM H=2E Peter Anvin <hpa@zytor=2Ecom>=
 wrote:
>>
>> On March 3, 2025 10:31:11 AM PST, Brian Gerst <brgerst@gmail=2Ecom> wro=
te:
>> >Commit 263042e4630a ("Save user RSP in pt_regs->sp on SYSCALL64
>> >fastpath") simplified the 64-bit implementation of KSTK_ESP() which is
>> >now identical to 32-bit=2E  Merge them into a common definition=2E
>> >
>> >No functional change=2E
>> >
>> >Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>> >---
>> > arch/x86/include/asm/processor=2Eh | 5 +----
>> > arch/x86/kernel/process_64=2Ec     | 5 -----
>> > 2 files changed, 1 insertion(+), 9 deletions(-)
>> >
>> >diff --git a/arch/x86/include/asm/processor=2Eh b/arch/x86/include/asm=
/processor=2Eh
>> >index a969bea1ed07=2E=2E55f0e48413b0 100644
>> >--- a/arch/x86/include/asm/processor=2Eh
>> >+++ b/arch/x86/include/asm/processor=2Eh
>> >@@ -652,8 +652,6 @@ static __always_inline void prefetchw(const void *=
x)
>> >       =2Esysenter_cs            =3D __KERNEL_CS,                     =
       \
>> > }
>> >
>> >-#define KSTK_ESP(task)                (task_pt_regs(task)->sp)
>> >-
>> > #else
>> > extern unsigned long __top_init_kernel_stack[];
>> >
>> >@@ -661,8 +659,6 @@ extern unsigned long __top_init_kernel_stack[];
>> >       =2Esp     =3D (unsigned long)&__top_init_kernel_stack,         =
     \
>> > }
>> >
>> >-extern unsigned long KSTK_ESP(struct task_struct *task);
>> >-
>> > #endif /* CONFIG_X86_64 */
>> >
>> > extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
>> >@@ -676,6 +672,7 @@ extern void start_thread(struct pt_regs *regs, uns=
igned long new_ip,
>> > #define TASK_UNMAPPED_BASE            __TASK_UNMAPPED_BASE(TASK_SIZE_=
LOW)
>> >
>> > #define KSTK_EIP(task)                (task_pt_regs(task)->ip)
>> >+#define KSTK_ESP(task)                (task_pt_regs(task)->sp)
>> >
>> > /* Get/set a process' ability to use the timestamp counter instructio=
n */
>> > #define GET_TSC_CTL(adr)      get_tsc_mode((adr))
>> >diff --git a/arch/x86/kernel/process_64=2Ec b/arch/x86/kernel/process_=
64=2Ec
>> >index 4ca73ddfb30b=2E=2Ef983d2a57ac3 100644
>> >--- a/arch/x86/kernel/process_64=2Ec
>> >+++ b/arch/x86/kernel/process_64=2Ec
>> >@@ -979,8 +979,3 @@ long do_arch_prctl_64(struct task_struct *task, in=
t option, unsigned long arg2)
>> >
>> >       return ret;
>> > }
>> >-
>> >-unsigned long KSTK_ESP(struct task_struct *task)
>> >-{
>> >-      return task_pt_regs(task)->sp;
>> >-}
>> >
>> >base-commit: 693c8502970a533363e9ece482c80bb6db0c12a5
>>
>> Why using the macro version?
>
>Why call an out-of-line function?  I guess it could be an inline
>function (along with KSK_EIP())=2E
>
>
>Brian Gerst
>

Ah yes, not out of line obviously=2E

