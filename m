Return-Path: <linux-kernel+bounces-545804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A24A4F1BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A900E188C4F6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3B324EAA8;
	Tue,  4 Mar 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TMoN8n6D"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504FBA2D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131927; cv=none; b=oAcc7egwStH0b+EcU9rHg2HehzRX3cdTs6bY+CAV0TpxIZFWw1Gy2tRRR9lcNw7e7AJbR8/Y3RSWy/UVVESFRGDB3/OfTPa1GGTXMZVkKv4vJ3wHUkrpvJ/8/dGK/c965uCqf7ra3kz8oM1ESM+EIM5pxtbUmsHUTZb1grmMFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131927; c=relaxed/simple;
	bh=QqhJlTNnMoAeVLhqzPLAoY0nmNxjc32pntxc2kXlZWA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GC2y9ertfT3lbfVh50tP8CMGsZq3sFLiH8HLrVc6nw8yvOSlaE3fgdfOR9ZkQx80hPkBSov6OFsfzQkpV/c5Z/Zual4YXbp9/qTOtsVPBr3DT6xEJ4xHwYDzEZ1HBUaRFHC71W1JNfXcCqysAjRMu9ZHbOQjBLBiM3Ew8hAzWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=TMoN8n6D; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 524Nin1D2696278
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 4 Mar 2025 15:44:49 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 524Nin1D2696278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741131890;
	bh=iK6Bh3n2sEyZmKvIXWrYnLSJrvYOsJRs96K0ZZ9Vtg0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=TMoN8n6DQAV7HRt4bBwuPff4zjK3Vy7GEF+zgsjhsSyPkbX99Vh6OgwdJf4jQn5uW
	 LMJdQKbbPSgrNdwADhdyDjph6k37JEAWm3oFyu1oeeiN15npQky5l+mkgOod3V0qx/
	 GUBEAN51zxxiY2fzk/hsAjiq5zHuTrWiEqK75vWXWPbkptgpF1wAoGWKFKtq5RJ/Yw
	 ibv2h1keE2LlcB1BZIVG86n290nuO21wH4rqF3FMMq66PbXciIs0xJDxkzM8oAyJqr
	 bRFv02CNfp43HDia34+05ffoPFcoiHipdPZaAQIF3jFL/xJTG+nWhknEQH1vS+FjIC
	 0GsK85ZplBVZw==
Date: Tue, 04 Mar 2025 15:44:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Mateusz Guzik <mjguzik@gmail.com>, Brian Gerst <brgerst@gmail.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_04/15=5D_x86/pvh=3A_Use_fi?=
 =?US-ASCII?Q?xed=5Fpercpu=5Fdata_for_early_boot_GSBASE?=
User-Agent: K-9 Mail for Android
In-Reply-To: <tns2rrzk7vs3linnjevr24qyg4sm6hakndsgqvqsowqwwlrdcj@zus5wu6u3ju3>
References: <20250123190747.745588-1-brgerst@gmail.com> <20250123190747.745588-5-brgerst@gmail.com> <tns2rrzk7vs3linnjevr24qyg4sm6hakndsgqvqsowqwwlrdcj@zus5wu6u3ju3>
Message-ID: <56A91DC4-1A8C-4134-976E-BBCBF9BC784F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 4, 2025 2:26:20 PM PST, Mateusz Guzik <mjguzik@gmail=2Ecom> wrote:
>On Thu, Jan 23, 2025 at 02:07:36PM -0500, Brian Gerst wrote:
>> Instead of having a private area for the stack canary, use
>> fixed_percpu_data for GSBASE like the native kernel=2E
>>=20
>> Signed-off-by: Brian Gerst <brgerst@gmail=2Ecom>
>> Reviewed-by: Ard Biesheuvel <ardb@kernel=2Eorg>
>> ---
>>  arch/x86/platform/pvh/head=2ES | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/x86/platform/pvh/head=2ES b/arch/x86/platform/pvh/hea=
d=2ES
>> index 4733a5f467b8=2E=2Efa0072e0ca43 100644
>> --- a/arch/x86/platform/pvh/head=2ES
>> +++ b/arch/x86/platform/pvh/head=2ES
>> @@ -173,10 +173,15 @@ SYM_CODE_START(pvh_start_xen)
>>  1:
>>  	UNWIND_HINT_END_OF_STACK
>> =20
>> -	/* Set base address in stack canary descriptor=2E */
>> -	mov $MSR_GS_BASE,%ecx
>> -	leal canary(%rip), %eax
>> -	xor %edx, %edx
>> +	/*
>> +	 * Set up GSBASE=2E
>> +	 * Note that, on SMP, the boot cpu uses init data section until
>> +	 * the per cpu areas are set up=2E
>> +	 */
>> +	movl $MSR_GS_BASE,%ecx
>> +	leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
>> +	movq %edx, %eax
>
>	movl
>
>I'm bisecting perf breakage and landing on this commit breaks the build=
=2E

Breaks the build how?

