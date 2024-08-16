Return-Path: <linux-kernel+bounces-290247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FF795514C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88F728417D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9F1C3789;
	Fri, 16 Aug 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Vett7mas"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8876F30D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835971; cv=none; b=BvcIUbRrW+988t1ci+hzSDM5Gni93ue9m+rFAzV3r9ApUXri7pTk55hyRQgUsFmEG4WQ4RqvQ4WCYoGpsFgliQSPwznQ1ixRb+bGoCUy7xEyMay2BcCnGmSusW+UDhzVjWVx4nRLVHN5OGnaraamrawHMDDw6i+SgwjKg3IEQuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835971; c=relaxed/simple;
	bh=y1D3AsSqN6QNcd35H1f60VEtRN1GEjzQ4SRN+t2Ou0M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=m6Gy/rEHZgjFpG2eC/TmAEcyqUuMS6o6co5TCoKQMf7NFMFPKkascev+gBr+tiAJ7SGLck49kSr2BNYyyEcab0cZVit3CeGruOr0eMGZXzZB8PYzFq4GEMVP6X7V3h7kJ6QXNhq9YgYwNjp5zHqK203haRkEMHu4w3BBWLfiN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Vett7mas; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47GJIo5Q3298463
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 16 Aug 2024 12:18:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47GJIo5Q3298463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723835931;
	bh=y1D3AsSqN6QNcd35H1f60VEtRN1GEjzQ4SRN+t2Ou0M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Vett7mashY9SoaZaG0cenjXhyvMNC1UhZvVkfPQFT5LRY+eqzuJk/YulmzSRMpE8M
	 K95TqO3c+OMGPHruKP1sFS8EPs2pVBBPSMWQyN0UK/gsAKTsb8cZMy/rK/Of77gncY
	 4xrD9T+68QvRfBwLqqe0aRLBFlthkRZIHH0ObUNtsV9495CxCCZ4+hbSVL24gd52E/
	 pajCwBGGGdSeYufZi2Z33/HF/UT+hpnXkOCEjjGzVU9eWTqVGWaa8RqjdXWH7zR2FQ
	 vcu4JjvOvZ2ZGcvqzyZiwkE1vflQKTds3xyJPJD9segSZer/KXJCUoUlK3ZxJIfa63
	 AQzbIAMU5PDeQ==
Date: Fri, 16 Aug 2024 12:18:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        seanjc@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/3=5D_x86/msr=3A_Switch_between_WRM?=
 =?US-ASCII?Q?SRNS_and_WRMSR_with_the_alternatives_mechanism?=
User-Agent: K-9 Mail for Android
In-Reply-To: <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com>
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-3-xin@zytor.com> <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com> <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com> <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com>
Message-ID: <2711BAB8-BC48-485A-9D86-BDDB63F31D3F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 16, 2024 11:40:05 AM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=
=2Ecom> wrote:
>On 16/08/2024 6:52 pm, Xin Li wrote:
>> On 8/9/2024 4:07 PM, Andrew Cooper wrote:
>>> On 07/08/2024 6:47 am, Xin Li (Intel) wrote:
>>>> From: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>>>> +/* Instruction opcode for WRMSRNS supported in binutils >=3D 2=2E40 =
*/
>>>> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
>>>> +
>>>> +/* Non-serializing WRMSR, when available=2E=C2=A0 Falls back to a
>>>> serializing WRMSR=2E */
>>>> =C2=A0 static __always_inline void wrmsrns(u32 msr, u64 val)
>>>> =C2=A0 {
>>>> -=C2=A0=C2=A0=C2=A0 __wrmsrns(msr, val, val >> 32);
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * WRMSR is 2 bytes=2E=C2=A0 WRMSRNS is 3 by=
tes=2E=C2=A0 Pad WRMSR with a
>>>> redundant
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * DS prefix to avoid a trailing NOP=2E
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0 asm volatile("1: "
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ALTERNATIVE("ds wrmsr",
>>>
>>> This isn't the version I presented, and there's no discussion of the
>>> alteration=2E
>>
>> I'm trying to implement wrmsr() as
>>
>> static __always_inline void wrmsr(u32 msr, u64 val)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0asm volatile("1: " ALTERNATIVE_2("wrmsr", WRMSR=
NS,
>> X86_FEATURE_WRMSRNS,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "call asm_xen_write_msr=
", X86_FEATURE_XENPV)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : : "c" (msr), "a" (val), "d" ((u32)(val >> 32)),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "D" (msr), "S" (val));
>> }
>>
>>
>> As the CALL instruction is 5-byte long, and we need to pad nop for both
>> WRMSR and WRMSRNS, what about not using segment prefix at all?
>
>The prefix was a minor optimisation to avoid having a trailing nop at
>the end=2E
>
>When combined with a call, you need 3 prefixes on WRMSR and 2 prefixes
>on WRMSRNS to make all options be 5 bytes long=2E
>
>That said, there's already a paravirt hook for this, and if you're
>looking to work around the code gen mess for that, then doing it like
>this by doubling up into rdi and rsi isn't great either=2E
>
>My suggestion, not that I've had time to experiment, was to change
>paravirt to use a non-C ABI and have asm_xen_write_msr() recombine
>edx:eax into rsi=2E=C2=A0 That way the top level wrmsr() retains sensible
>codegen for native even when paravirt is active=2E
>
>~Andrew

Heh, that was my suggestion, except that I suggested defining it so rax pa=
ss the full value; the generation of edx still is necessary but there is no=
 real reason to have to recombine them=2E (One could even add that code to =
the assembly pattern as the CALL instruction is longer=2E)

My biggest question is how the #GP on an invalid MSR access is handled wit=
h Xen=2E The rest is trivial=2E

