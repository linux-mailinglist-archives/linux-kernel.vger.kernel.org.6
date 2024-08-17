Return-Path: <linux-kernel+bounces-290763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9522955854
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4C11F2270B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71F91537DA;
	Sat, 17 Aug 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FrKziesH"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC594146596
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904619; cv=none; b=TPLZsWvHL4D1A+dmqgv/ivZ1wcrhaBt1ygcGKfYYzPXQwknPU60T9oho8MgBU+gli7psc80weYP2NJ6GWEG6kT9HzpXUar1Aup1TV8fQu2TEejzgSwpUftTINi7Ri/1ns5o/8y6rqvMkePXpBlgtDkC9meaKWP3MVQvlRK0jmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904619; c=relaxed/simple;
	bh=1WNq7AvgOXNOmLrjc7B9J/lr4eVm5lx6WN0LJ22S99Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Mm1sLvD9ByxELB0fJ57UaEGJy1B32ssvOKUwYtMwf3Rl+ke8uFjd1FU7FwFUFXrhgtdGEn3wiwKARgN9ZyvKpJBzWStjd1e5C9fHw/RpjqEpknMnSWUocpy23J+Gllxm1ZRRPpS4r1pwflj4dh+E4fEr1da4WT4yBeiqzBKNkoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FrKziesH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9026740E0185;
	Sat, 17 Aug 2024 14:23:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id y0Yo8jPL-mfA; Sat, 17 Aug 2024 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1723904601; bh=hflZYG0Z3hxFWuu5ybzu64zu0poV38eCOggvex7Gvsg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FrKziesHsvP+aqIdQEu0VfXe5u9jP0UcA7X+9yAV/36S9aBQoXdLm8R8StIDuPO0w
	 L4yDYe8jezz3VSceAHlWYbnLzfTY36/6O0TLFuxWglRNWsPUl0g744PP3r7CgqRb79
	 tAhLIURYyLQ1ulBuSNl9N8dvhcOta6b7l7J5irOil8Pg8bTz3gQ/u2SrJZ55EswGiE
	 fzU6s7bwxmSjhfJT08YS3Ed5GhtgriR8d0L8ONJgZmTrZ6mDBk8RiQ4L5qpQ2eNWuu
	 oeHfJwQVp717cCXJjAJpowrqYgzGT8mKLjENVGIYPuk0s+zcQhSB6mLJMS/QlqseKa
	 97tPA9ssql2Te3ocaQFeqAdOyWfqnHz0t2Ij8s20dbilY+oBu4sn1xeudu4+zGp8z5
	 fWxnTWH2LMzhNzumwipGRZXok21tDwPgsoMc4HEg/IOchvNYvDIocY1M7/+cuB1H7m
	 N4YSG0lL10mNyGXxhysIJoioHf1kNCidECaYcQF73d1yeBFV0tgt8yCPWqInlttPV4
	 Kbjfw3t8XOcUxLEFJFY4vEEE3yxB/G8rvZdBnoFHguqC0QeY+dhlT798KLdFnl69eA
	 0zWPcx3Z8eJiMGoq1kbx1Rz7RXul4MMYn1zXXIAdq+Qn04x5VSRJ5aEj5+FTBek209
	 s3exDm5KiKCKhLbouqZLhTkc=
Received: from [127.0.0.1] (unknown [87.120.165.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8172740E016A;
	Sat, 17 Aug 2024 14:23:11 +0000 (UTC)
Date: Sat, 17 Aug 2024 17:23:07 +0300
From: Borislav Petkov <bp@alien8.de>
To: Xin Li <xin@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org, seanjc@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/3=5D_x86/msr=3A_Switch_between_WRM?=
 =?US-ASCII?Q?SRNS_and_WRMSR_with_the_alternatives_mechanism?=
User-Agent: K-9 Mail for Android
In-Reply-To: <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-3-xin@zytor.com> <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com> <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
Message-ID: <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 16, 2024 8:52:51 PM GMT+03:00, Xin Li <xin@zytor=2Ecom> wrote:
>On 8/9/2024 4:07 PM, Andrew Cooper wrote:
>> On 07/08/2024 6:47 am, Xin Li (Intel) wrote:
>>> From: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>>> +/* Instruction opcode for WRMSRNS supported in binutils >=3D 2=2E40 *=
/
>>> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
>>> +
>>> +/* Non-serializing WRMSR, when available=2E  Falls back to a serializ=
ing WRMSR=2E */
>>>   static __always_inline void wrmsrns(u32 msr, u64 val)
>>>   {
>>> -	__wrmsrns(msr, val, val >> 32);
>>> +	/*
>>> +	 * WRMSR is 2 bytes=2E  WRMSRNS is 3 bytes=2E  Pad WRMSR with a redu=
ndant
>>> +	 * DS prefix to avoid a trailing NOP=2E
>>> +	 */
>>> +	asm volatile("1: "
>>> +		     ALTERNATIVE("ds wrmsr",
>>=20
>> This isn't the version I presented, and there's no discussion of the
>> alteration=2E
>
>I'm trying to implement wrmsr() as
>
>static __always_inline void wrmsr(u32 msr, u64 val)
>{
>	asm volatile("1: " ALTERNATIVE_2("wrmsr", WRMSRNS, X86_FEATURE_WRMSRNS,
>					 "call asm_xen_write_msr", X86_FEATURE_XENPV)
>		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>		     : : "c" (msr), "a" (val), "d" ((u32)(val >> 32)),
>		     "D" (msr), "S" (val));
>}
>
>
>As the CALL instruction is 5-byte long, and we need to pad nop for both
>WRMSR and WRMSRNS, what about not using segment prefix at all?

The alternatives macros can handle arbitrary insn sizes - no need for any =
padding=2E


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

