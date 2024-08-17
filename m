Return-Path: <linux-kernel+bounces-290840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7AF955960
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777892821D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FAB14F115;
	Sat, 17 Aug 2024 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A4ascoyP"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB282B9B0
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723922604; cv=none; b=ZtPFG4pUKee6ec2ps+KL6wDT9vH0rhITBP3foFFQmzEwnFh7mXhPFE1zpgcZjiZuWxC22vMkUIlKrI6zI6WPSdvPeBfKJj36KMraiAhstjwjc5tbUVvtr/KN5HIFR3Yf1oR/j+MDF2Wjq2D2tS6n9OfUZ3QanPT+0O7i/b+Piuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723922604; c=relaxed/simple;
	bh=bJXmI8pebUaDkoU4aMq1GTHJic2gNbeF/2Fyq4fW6Bs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=luuECYVC0LlG/es5al1zghb8oJtlq3LiFPahiVUSGf9cyGsWGEalNXiiWkeBq0HZU/+SXftMM4zQCgW+AGCZ5bb6LhRaARtaidnBb1WY+7S+7yrWde4T3EGa6Yc4DN63tm5J+sqkmcgM1e+SN70+Ic2SpNPxjcSdsdCtjl2fvYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=A4ascoyP; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47HJMwTx071220
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 Aug 2024 12:22:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47HJMwTx071220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723922579;
	bh=R+B6hPDx9Wrld+dfV+qVsGadl1I+kv4ReRkR897IY70=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=A4ascoyPye+Ole4Bs8kD1zWazii/OgbZdM7vE2y3yOJyGiqK3hit+pqY1lUX/8DLg
	 lELv9Mi1w2c+YCrRMjh+T4waVOPsU7Np44Aw2EyloCn/WWrx4Dpxuys2VsNI0MWA9u
	 AIIVbx+WI1do5TBMwCMzhBAd8AGzxVulFRAMRS+N6EP+xiATCEQVmG/weD47VP18ab
	 o+amQIJTJ5lMDM/pM/NEjl4rX9StMHlN8a+TVqdiuk6S/xkv/GHaeMcCq65GE3uqx8
	 dgm5a0/e4h64XvybeIbGqNKPMnlCtBBkJWA+SY1fXwcShEGyr0UUtyHUUnFx4LX2M1
	 pGBu36n4NMqJg==
Date: Sat, 17 Aug 2024 12:22:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterz@infradead.org, seanjc@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/3=5D_x86/msr=3A_Switch_between_WRM?=
 =?US-ASCII?Q?SRNS_and_WRMSR_with_the_alternatives_mechanism?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240817144316.GAZsC3BOm7anUPdJGe@fat_crate.local>
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-3-xin@zytor.com> <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com> <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com> <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de> <20240817144316.GAZsC3BOm7anUPdJGe@fat_crate.local>
Message-ID: <46CAFA22-2EB9-457B-BD14-864CFD71ADBF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 17, 2024 7:43:16 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sat, Aug 17, 2024 at 05:23:07PM +0300, Borislav Petkov wrote:
>> >static __always_inline void wrmsr(u32 msr, u64 val)
>> >{
>> >	asm volatile("1: " ALTERNATIVE_2("wrmsr", WRMSRNS, X86_FEATURE_WRMSRN=
S,
>> >					 "call asm_xen_write_msr", X86_FEATURE_XENPV)
>> >		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>> >		     : : "c" (msr), "a" (val), "d" ((u32)(val >> 32)),
>> >		     "D" (msr), "S" (val));
>> >}
>> >
>> >
>> >As the CALL instruction is 5-byte long, and we need to pad nop for bot=
h
>> >WRMSR and WRMSRNS, what about not using segment prefix at all?
>>=20
>> The alternatives macros can handle arbitrary insn sizes - no need for a=
ny padding=2E
>
>What you cannot do is have a CALL insn in only one of the alternative
>insn groups because the compiler is free to clobber callee regs and
>those might be live where you place the alternative and thus will have
>a nice lovely corruption=2E
>

Only if the call goes to a C function=2E

