Return-Path: <linux-kernel+bounces-281650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A494D957
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D77282504
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309A3C13C;
	Sat, 10 Aug 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Pea0Te1b"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7A8BE0
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723248105; cv=none; b=NwfOrG83ycAXzR5xZNVw3idnOMsS9TMwucxVAXzsWiOCFR+dhTdIN8hh07dKr4RKZnOdTq2k5QH8pMOPLxEr2Vsj6txNZT5uwi1TeNnniAFI4zUU0Ku/uB0YfIN+vFzSzopF9FZ0PInxAqxl1Pnxbz5IvCll6WCTkEjoGNnqqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723248105; c=relaxed/simple;
	bh=QxSEIOusEi+oao13s+ZbIMHvHKKwAOmE+kHzE4TDFjY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=opaHlXcBgsUJ7YUcc+N+8TdXs6STZ8wIntN9hTMnbzF4cPI/pO9PiaW1LXyiP3dVpKpfcLSC2jAR/Ca+muv47z97PJatCsH+eCWY7bI+m4onqI8AQRmuzkxk7KPHczlEG7bf4g4GTd93fQvbgGhu6cnt8/RALyPvvPKHrMHxFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Pea0Te1b; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47A018PN1960292
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 9 Aug 2024 17:01:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47A018PN1960292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723248071;
	bh=cRmBgKVxsd+EUI1weZ+0PW9UCdNNgqE+aBL3mNIwz0s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Pea0Te1bJZAqI3XbpgNU524uyz5Gz0KkGUewIwRCpE3a4XhujPKR484mN3ZwiO5+f
	 CU4YYQV4G1QX77TLWvb2g56HlAIB9zdmc+0BnfkIv4YWfHunx0jUDE84oDIsP7XrKw
	 nigsca+QxvyE5uL3+ymTQkq8k5r0tcWvyo+jpnwzE+huRafaYtFioMOnxJ8mOLIBqm
	 +PtS7ynzC2S7WoYZRo68prsP7H2QEcqop/T8+epmlMZ5v7AhuI34un1Mq6y1GAnkUw
	 EXiBH1BAVponzarZC5wjkSanRT+FVlKF+Oq2ZUCRvdFXt3em0qlPTGadc16Sh+7dTS
	 ctPRXeeWeikfA==
Date: Fri, 09 Aug 2024 17:01:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        seanjc@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/3=5D_x86/msr=3A_Switch_between_WRM?=
 =?US-ASCII?Q?SRNS_and_WRMSR_with_the_alternatives_mechanism?=
User-Agent: K-9 Mail for Android
In-Reply-To: <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-3-xin@zytor.com> <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
Message-ID: <81CE6282-4791-42AB-9A51-4535E094D67C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 9, 2024 4:07:35 PM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2E=
com> wrote:
>On 07/08/2024 6:47 am, Xin Li (Intel) wrote:
>> From: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>>
>> Per the discussion about FRED MSR writes with WRMSRNS instruction [1],
>> use the alternatives mechanism to choose WRMSRNS when it's available,
>> otherwise fallback to WRMSR=2E
>>
>> [1] https://lore=2Ekernel=2Eorg/lkml/15f56e6a-6edd-43d0-8e83-bb64300965=
14@citrix=2Ecom/
>>
>> Signed-off-by: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>> Signed-off-by: Xin Li (Intel) <xin@zytor=2Ecom>
>> ---
>>  arch/x86/include/asm/msr=2Eh | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/msr=2Eh b/arch/x86/include/asm/msr=2E=
h
>> index d642037f9ed5=2E=2E3e402d717815 100644
>> --- a/arch/x86/include/asm/msr=2Eh
>> +++ b/arch/x86/include/asm/msr=2Eh
>> @@ -99,19 +99,6 @@ static __always_inline void __wrmsr(unsigned int msr=
, u32 low, u32 high)
>>  		     : : "c" (msr), "a"(low), "d" (high) : "memory");
>>  }
>> =20
>> -/*
>> - * WRMSRNS behaves exactly like WRMSR with the only difference being
>> - * that it is not a serializing instruction by default=2E
>> - */
>> -static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
>> -{
>> -	/* Instruction opcode for WRMSRNS; supported in binutils >=3D 2=2E40=
=2E */
>> -	asm volatile("1: =2Ebyte 0x0f,0x01,0xc6\n"
>> -		     "2:\n"
>> -		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>> -		     : : "c" (msr), "a"(low), "d" (high));
>> -}
>> -
>>  #define native_rdmsr(msr, val1, val2)			\
>>  do {							\
>>  	u64 __val =3D __rdmsr((msr));			\
>> @@ -312,9 +299,22 @@ do {							\
>> =20
>>  #endif	/* !CONFIG_PARAVIRT_XXL */
>> =20
>> +/* Instruction opcode for WRMSRNS supported in binutils >=3D 2=2E40 */
>> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
>> +
>> +/* Non-serializing WRMSR, when available=2E  Falls back to a serializi=
ng WRMSR=2E */
>>  static __always_inline void wrmsrns(u32 msr, u64 val)
>>  {
>> -	__wrmsrns(msr, val, val >> 32);
>> +	/*
>> +	 * WRMSR is 2 bytes=2E  WRMSRNS is 3 bytes=2E  Pad WRMSR with a redun=
dant
>> +	 * DS prefix to avoid a trailing NOP=2E
>> +	 */
>> +	asm volatile("1: "
>> +		     ALTERNATIVE("ds wrmsr",
>
>This isn't the version I presented, and there's no discussion of the
>alteration=2E
>
>The choice of CS over DS was deliberate, and came from Intel:
>
>https://www=2Eintel=2Ecom/content/dam/support/us/en/documents/processors/=
mitigations-jump-conditional-code-erratum=2Epdf
>
>So unless Intel want to retract that whitepaper, and all the binutils
>work with it, I'd suggest keeping it as CS like we use elsewhere, and as
>explicitly instructed by Intel=2E
>
>~Andrew

I looked around the kernel, and I believe we are inconsistent=2E I see bot=
h 0x2e (CS) and 0x3e (DS) prefixes used for padding where open-coded=2E

We can't use cs in all cases, since you can't do a store to the code segme=
nt (always readonly) so we use 0x3e (DS) to patch out LOCK=2E

In the paper you describe, it only mentions 0x2e as a "benign prefix" in a=
 specific example, not as any kind of specific recommendation=2E It is part=
icularly irrelevant when it comes to padding a two instructions to the same=
 length as the paper deals with assignment=2E=20

If you want, I'm perfectly happy to go and ask if there is any general rec=
ommendation (except for direct conditional branch hints, of course=2E)

