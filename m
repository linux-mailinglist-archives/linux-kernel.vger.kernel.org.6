Return-Path: <linux-kernel+bounces-413794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9C39D1ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49FE280339
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B89A1448DF;
	Tue, 19 Nov 2024 03:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="FxYezFSq"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A72B9A6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986868; cv=none; b=jPEEFBSl00wqafu4wxoWQwwqJSEbWwel5IjnWWFUD6Y8HnOTg1YsQbIZOkuWJzeTkKS1BRIwbH3vTI7C+F4cFFmTcMrox87s+DPKe2scZDWocu/6SmRhOEXUdXxg4aks53iJbs04IXjN7A9KsbMXcEDZ6Xlw6Z6h6Djf+DKDrSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986868; c=relaxed/simple;
	bh=WV/hcpZ5y57qrKHNwkKUd+BTbl4FHiCHJQ3S6X2sCHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9QvvFD5yF8qAeFgYs/F2MAP9CHBSHI3h28Ty5yLf+QmvLdPz3X2dGrqT9jarfb4Kljg+fyk0A+Nfr6od5RSbiHp1ROnhqymqjUkpSVZer4kRtILxT/MvVx8d84XOWAGIxYKfoe9QNXnB4hAiZ0b1FVh028rYcyV22fxpRRt4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=FxYezFSq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731986861;
	bh=Y/InxUQQ7tYIxZKtHZZnpkjMoI3GWN9si3qSB5sztRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FxYezFSqu4Z2+yPML76KnycCnPWSNxk7enQ/mkkSeV3P81wOjf131O21hWV9knaRA
	 nzAQKl9UVd4utpK38lcLmkVFZZQKJBMFO7oBNvaG5IpFUQErlFQnpf2G6XJoDQPLym
	 BGt6Nv4ohHDoNW7z7Buz7aJf07G13xGki7k/naS56bOtldqWRBfC1nakTm6bNytyuL
	 IinKS/x5VTvPOwhko9c83fxTYlqUs2UPCyOH/tAgbzRIsyjnNzw/ObbBzMKNYFNELy
	 yc695Ci/THzUSgYminpJJD5z6oh78PTRj/+plW0SI69uhh48Zh0Tqpbmm01dXq2Zjh
	 PRoBiYJHTghZg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xsqgc4FXmz4xfX;
	Tue, 19 Nov 2024 14:27:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de
Subject: Re: [RFC PATCH 02/10] powerpc/chrp: Remove various dead code
In-Reply-To: <c00a229c-9ced-4a28-9666-b4707f317c90@csgroup.eu>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241114131114.602234-2-mpe@ellerman.id.au>
 <c00a229c-9ced-4a28-9666-b4707f317c90@csgroup.eu>
Date: Tue, 19 Nov 2024 14:27:43 +1100
Message-ID: <874j43j428.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 14/11/2024 =C3=A0 14:11, Michael Ellerman a =C3=A9crit=C2=A0:
>> Remove various bits of code that are dead now that PPC_CHRP has been
>> removed.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   arch/powerpc/Kconfig                 |  5 +--
>>   arch/powerpc/boot/Makefile           |  1 -
>>   arch/powerpc/include/asm/processor.h |  6 ---
>>   arch/powerpc/kernel/head_book3s_32.S | 12 ------
>>   arch/powerpc/kernel/pci_32.c         |  2 +-
>>   arch/powerpc/kernel/prom_init.c      | 56 ----------------------------
>>   6 files changed, 3 insertions(+), 79 deletions(-)
>>=20
>
>> diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/=
head_book3s_32.S
>> index cb2bca76be53..c6e297fd36e2 100644
>> --- a/arch/powerpc/kernel/head_book3s_32.S
>> +++ b/arch/powerpc/kernel/head_book3s_32.S
>> @@ -256,20 +256,8 @@ __secondary_hold_acknowledge:
>>    */
>>   	START_EXCEPTION(INTERRUPT_MACHINE_CHECK, MachineCheck)
>>   	EXCEPTION_PROLOG_0
>> -#ifdef CONFIG_PPC_CHRP
>> -	mtspr	SPRN_SPRG_SCRATCH2,r1
>> -	mfspr	r1, SPRN_SPRG_THREAD
>> -	lwz	r1, RTAS_SP(r1)
>> -	cmpwi	cr1, r1, 0
>> -	bne	cr1, 7f
>> -	mfspr	r1, SPRN_SPRG_SCRATCH2
>> -#endif /* CONFIG_PPC_CHRP */
>>   	EXCEPTION_PROLOG_1
>>   7:	EXCEPTION_PROLOG_2 0x200 MachineCheck
>> -#ifdef CONFIG_PPC_CHRP
>> -	beq	cr1, 1f
>> -	twi	31, 0, 0
>> -#endif
>>   1:	prepare_transfer_to_handler
>>   	bl	machine_check_exception
>>   	b	interrupt_return
>
> Then it becomes a standard exception handler that can be set up with
>
> 	EXCEPTION(INTERRUPT_MACHINE_CHECK, MachineCheck, machine_check_exception)

Ack. And I checked the asm output is identical.

> And the comment from paulus voids.

Thanks.

cheers

