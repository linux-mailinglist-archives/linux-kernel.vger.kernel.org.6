Return-Path: <linux-kernel+bounces-290421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6241A95539B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 01:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A92BB21B93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2250145A15;
	Fri, 16 Aug 2024 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FkadJqSY"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE21AC8B0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849463; cv=none; b=WShrrqGK42Go0OX+KFkJ/cta5lMm7B5XBBnV54InFteu10tItmHb/xJ6sEBQ7JZkVuUlCpU5HZcZBPiNGYAXA9+lBeFj12tBY7ZzaKzGAAfFlPatM0VNflQzq78zihkEAj7Ds7VPMQWzGZFkyqTj92FWtayFa348G/gPDGJqQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849463; c=relaxed/simple;
	bh=fQVYrUlt2cgVIY+Z4wc2LFPqyHUPqlgfvmjSTkqRwA4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Jecy1tmyCwx2aUgTClCfkJ3VukF6829d6RSBw+Lc6u3isyEqYLQhseHqdAyWUr/Q2QpN6gF3IAuRtQQIimSFYtavN3We5mdUp4p4dMhMw8e0N8hgt8JR98nzGE2+zXOOiMX2Qs3d83rRaMXV8v2bI72kQKWb3TIIwSgKm4gHlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FkadJqSY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47GN3qPj3565996
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 16 Aug 2024 16:03:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47GN3qPj3565996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723849433;
	bh=fQVYrUlt2cgVIY+Z4wc2LFPqyHUPqlgfvmjSTkqRwA4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FkadJqSY9Bidkw0cSm0KdTaxixLv2N11gJiwVXZCvOGkQKxPHY4E6KMVfdf/NjBUt
	 8meNKkvfSRYpqnQfm17Imjm9WiJfCsc7LxIZywFvlmU354r6t/HeR+CRkQNKDMaa+3
	 ByD/W7kTuxxRBCleFou261h3HTIju70gNY9ELRFYYu2qsm/O7DzCTxejpX9+Rcyw0R
	 8rIilsbwtpnsWyyYwSKQjmiRwXnSgCfbkNybS9YAFwYV5JJODte2+swZqoDXKGDReZ
	 oKwQrQQUms4zTu9Nv7b9lNaEXJa1LeAKjumZ1SMllh9kf0TYsn6DGlgiFXs11+MuAD
	 w5ZgLw5UG1SLA==
Date: Fri, 16 Aug 2024 16:03:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin@zytor.com>,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        seanjc@google.com, Juergen Gross <jgross@suse.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/3=5D_x86/msr=3A_Switch_between_WRM?=
 =?US-ASCII?Q?SRNS_and_WRMSR_with_the_alternatives_mechanism?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f0dfe1ee-accc-4202-8f26-574124f40e22@citrix.com>
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-3-xin@zytor.com> <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com> <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com> <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com> <4f7566b5-a743-4819-b221-88207c132f63@zytor.com> <dc7c6c55-23fa-4cb3-a6b4-7558c45bf1d0@citrix.com> <f0dfe1ee-accc-4202-8f26-574124f40e22@citrix.com>
Message-ID: <464A99E1-35B0-4306-9C95-2FA38463D9E2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 16, 2024 3:34:53 PM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=
=2Ecom> wrote:
>On 16/08/2024 11:27 pm, Andrew Cooper wrote:
>> On 16/08/2024 10:26 pm, H=2E Peter Anvin wrote:
>>> On 8/16/24 11:40, Andrew Cooper wrote:
>>>>> As the CALL instruction is 5-byte long, and we need to pad nop for b=
oth
>>>>> WRMSR and WRMSRNS, what about not using segment prefix at all?
>>> You can use up to 4 prefixes of any kind (which includes opcode
>>> prefixes before 0F) before most decoders start hurting, so we can pad
>>> it out to 5 bytes by doing 3f 3f =2E=2E =2E=2E =2E=2E
>>>
>>>> My suggestion, not that I've had time to experiment, was to change
>>>> paravirt to use a non-C ABI and have asm_xen_write_msr() recombine
>>>> edx:eax into rsi=2E=C2=A0 That way the top level wrmsr() retains sens=
ible
>>>> codegen for native even when paravirt is active=2E
>>>>
>>> I have attached what should be an "obvious" example=2E=2E=2E famous la=
st words=2E
>> Ah, now I see what you mean about Xen's #GP semantics=2E
>>
>> That's a neat way of doing it=2E=C2=A0 It means the faulting path will =
really
>> take 2 faults on Xen, but it's a faulting path anyway so speed is
>> already out of the window=2E
>>
>> Do you mind about teaching the #UD handler to deal with WRMSR like that=
?
>>
>> I ask, because I can't think of anything nicer=2E
>>
>> There are plenty of 3-byte instructions which #GP in PV guests (CPL3),
>> and LTR is my go-to for debugging purposes, as it's not emulated by Xen=
=2E
>>
>> Anything here (and it can't be an actual WRMSR) will be slightly
>> confusing to read in an OOPS, especially #UD for what is logically a #G=
P=2E
>>
>> But, a clear UD of some form in the disassembly is probably better than
>> a random other instruction unrelated to the operation=2E
>>
>> ~Andrew
>
>Oh, P=2ES=2E
>
>We can probably drop most of the register manipulation by making the new
>xen_do_write_msr be no_caller_saved_registers=2E=C2=A0 As we're intention=
ally
>not a C ABI to start with, we might as well not spill registers we don't
>use either=2E
>
>~Andrew

If you are willing to require a new enough gcc, certainly=2E

