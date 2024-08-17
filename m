Return-Path: <linux-kernel+bounces-290839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65895595F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 21:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D762826FA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564EB15534D;
	Sat, 17 Aug 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KVzloF14"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E752B9B0
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723922590; cv=none; b=JP7HfP8iOOeqPgqKBexoFGYgkye5J2wK7tA3m6X8GA6/JDUJzeo24zt+fG6lsdPDV3yL+qHsa0gN41ipyPQaEfWI007lcGOsnIkIORtoHtsXJy792IfxH1v0+MLq1iX7/ZF1iIdADPpui00zhiqhicHdPONlMyq38TUNl8XKZgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723922590; c=relaxed/simple;
	bh=CKg9Lo7sS0awaIbZpl6Pq/Ha7lM+bkIVkCD1SC814CE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E/ygfAJux3vxPjuluAG/MHuRxtQWM8qM2yanBLOBmbTcJX06edaYEPHoIyURbeWaSu6vWzXY4WGioEA/oBpOvi/eiJETAaOLR4w/3Ys03hscNA2M+uo8D0a8o7rxCyIg9XHqIV4tMngrA3phkkNc1XeNXXI0ttLBHIpTdlAU+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KVzloF14; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47HJMPJT071118
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 17 Aug 2024 12:22:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47HJMPJT071118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024071601; t=1723922546;
	bh=/lgBsjICl4ZushUpXnlVv//YCSdJn/xdhHuTMgO4tzM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KVzloF149Nrns5M6AulW5HrykXwJRJUynH+r+fUBLoSRSZvbWk9Z6lzHYr4kV3sDz
	 cUi4dTqoV6V+3MqnM7mShGrrJn8qmn9xJe3jjjY6q2K/DIQ2h065eNTSwfhol56rR5
	 DkIktDXOg3XjcyhQo917SA/ynoc2P44+AFW9Nl0f9GzFNUzmo/8b0RQZRsmG1zOzxS
	 2VUJpoyHdWxLovCJ+EKtZMHfpvPtl7uGvbDupJWdSxALUQ5Vc76tvMjJpo8mLWehzh
	 CgTFvHmeGnRLBMyIoNwCcrOirWUOvaCCofG6clNG1fEsQYEr0SJmneDvB3CP0DgpT8
	 onyygcgnCgjIA==
Date: Sat, 17 Aug 2024 12:22:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterz@infradead.org, seanjc@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_2/3=5D_x86/msr=3A_Switch_between_WRM?=
 =?US-ASCII?Q?SRNS_and_WRMSR_with_the_alternatives_mechanism?=
User-Agent: K-9 Mail for Android
In-Reply-To: <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
References: <20240807054722.682375-1-xin@zytor.com> <20240807054722.682375-3-xin@zytor.com> <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com> <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com> <DAC74A8B-DDE4-450E-93A1-EFD7D47B25F7@alien8.de>
Message-ID: <CC9FA68B-551A-4357-9088-D199C5859356@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 17, 2024 7:23:07 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On August 16, 2024 8:52:51 PM GMT+03:00, Xin Li <xin@zytor=2Ecom> wrote:
>>On 8/9/2024 4:07 PM, Andrew Cooper wrote:
>>> On 07/08/2024 6:47 am, Xin Li (Intel) wrote:
>>>> From: Andrew Cooper <andrew=2Ecooper3@citrix=2Ecom>
>>>> +/* Instruction opcode for WRMSRNS supported in binutils >=3D 2=2E40 =
*/
>>>> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
>>>> +
>>>> +/* Non-serializing WRMSR, when available=2E  Falls back to a seriali=
zing WRMSR=2E */
>>>>   static __always_inline void wrmsrns(u32 msr, u64 val)
>>>>   {
>>>> -	__wrmsrns(msr, val, val >> 32);
>>>> +	/*
>>>> +	 * WRMSR is 2 bytes=2E  WRMSRNS is 3 bytes=2E  Pad WRMSR with a red=
undant
>>>> +	 * DS prefix to avoid a trailing NOP=2E
>>>> +	 */
>>>> +	asm volatile("1: "
>>>> +		     ALTERNATIVE("ds wrmsr",
>>>=20
>>> This isn't the version I presented, and there's no discussion of the
>>> alteration=2E
>>
>>I'm trying to implement wrmsr() as
>>
>>static __always_inline void wrmsr(u32 msr, u64 val)
>>{
>>	asm volatile("1: " ALTERNATIVE_2("wrmsr", WRMSRNS, X86_FEATURE_WRMSRNS,
>>					 "call asm_xen_write_msr", X86_FEATURE_XENPV)
>>		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>>		     : : "c" (msr), "a" (val), "d" ((u32)(val >> 32)),
>>		     "D" (msr), "S" (val));
>>}
>>
>>
>>As the CALL instruction is 5-byte long, and we need to pad nop for both
>>WRMSR and WRMSRNS, what about not using segment prefix at all?
>
>The alternatives macros can handle arbitrary insn sizes - no need for any=
 padding=2E
>
>

The padding avoids unnecessary NOPs=2E

