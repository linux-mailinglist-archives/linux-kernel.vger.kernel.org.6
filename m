Return-Path: <linux-kernel+bounces-358664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9201E998224
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2948F28476D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2E1A072A;
	Thu, 10 Oct 2024 09:28:22 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDF19AD73
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552502; cv=none; b=sL7tsEJB59i4eHJ4C60/SsleglryEUeoJcrMGi2pUxC6EzSt6/fh8aAPh1rm6/luFIORSCRIRqo1HLKs56D/+i7x182C/YwdOQmN4ONdMjykgCwto9rY5nwaUGS90yy3HNaGFsFNo5R6Nx1XiGQSo0nKp6XK0tm+gwowFUO+WqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552502; c=relaxed/simple;
	bh=rpeC736wxyOrAbTYWx0udxFwoudDCkmoVNqYDxM3Vko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TeJ5bkzHsoOykTANCpfYruwVh7x6HmB99tywss0GvJDUw7hIQRZTIWJdzDaWtFgsj60HgOaavbV4ZjJaBUdLDI3X48MNep7RrQSU86x6VJat6VsXMDLEHeaVrVe+LZyz/xorL7pOQ8PP+GOMpxES3jN4a1QZESRM7RTX/FWMP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XPPZ94rcBz9sPd;
	Thu, 10 Oct 2024 11:28:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hJ25TvIlnF2; Thu, 10 Oct 2024 11:28:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XPPZ93yCWz9rvV;
	Thu, 10 Oct 2024 11:28:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 784408B79F;
	Thu, 10 Oct 2024 11:28:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id OfFuMDoeSSs8; Thu, 10 Oct 2024 11:28:17 +0200 (CEST)
Received: from [192.168.232.19] (unknown [192.168.232.19])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D02498B79E;
	Thu, 10 Oct 2024 11:28:16 +0200 (CEST)
Message-ID: <7c8231ad-683e-4df6-a63f-26985d46316f@csgroup.eu>
Date: Thu, 10 Oct 2024 11:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jason@zx2c4.com
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
 <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>
 <20241010101449-007991a0-f7c7-4f76-a6cc-413c474b9219@linutronix.de>
 <0a3d0813-e44f-45be-8b9a-957c75aa26cb@csgroup.eu>
 <20241010110927-9688b27e-6048-48ac-a908-5b80ba8da63e@linutronix.de>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241010110927-9688b27e-6048-48ac-a908-5b80ba8da63e@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/10/2024 à 11:12, Thomas Weißschuh a écrit :
> On Thu, Oct 10, 2024 at 11:00:15AM +0200, Christophe Leroy wrote:
>> Hi Thomas,
>>
>> Le 10/10/2024 à 10:20, Thomas Weißschuh a écrit :
>>> On Wed, Oct 02, 2024 at 10:39:29AM +0200, Christophe Leroy wrote:
>>>> VDSO time functions do not call any other function, so they don't
>>>> need to save/restore LR. However, retrieving the address of VDSO data
>>>> page requires using LR hence saving then restoring it, which can be
>>>> heavy on some CPUs. On the other hand, VDSO functions on powerpc are
>>>> not standard functions and require a wrapper function to call C VDSO
>>>> functions. And that wrapper has to save and restore LR in order to
>>>> call the C VDSO function, so retrieving VDSO data page address in that
>>>> wrapper doesn't require additional save/restore of LR.
>>>>
>>>> For random VDSO functions it is a bit different. Because the function
>>>> calls __arch_chacha20_blocks_nostack(), it saves and restores LR.
>>>> Retrieving VDSO data page address can then be done there without
>>>> additional save/restore of LR.
>>>>
>>>> So lets implement __arch_get_vdso_rng_data() and simplify the wrapper.
>>>>
>>>> It starts paving the way for the day powerpc will implement a more
>>>> standard ABI for VDSO functions.
>>>>
>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>> ---
>>>>    arch/powerpc/include/asm/vdso/getrandom.h | 15 +++++++++++++--
>>>>    arch/powerpc/kernel/asm-offsets.c         |  1 -
>>>>    arch/powerpc/kernel/vdso/getrandom.S      |  1 -
>>>>    arch/powerpc/kernel/vdso/vgetrandom.c     |  4 ++--
>>>>    4 files changed, 15 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
>>>> index 501d6bb14e8a..4302e7c67aa5 100644
>>>> --- a/arch/powerpc/include/asm/vdso/getrandom.h
>>>> +++ b/arch/powerpc/include/asm/vdso/getrandom.h
>>>> @@ -7,6 +7,8 @@
>>>>    #ifndef __ASSEMBLY__
>>>> +#include <asm/vdso_datapage.h>
>>>> +
>>>>    static __always_inline int do_syscall_3(const unsigned long _r0, const unsigned long _r3,
>>>>    					const unsigned long _r4, const unsigned long _r5)
>>>>    {
>>>> @@ -43,11 +45,20 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
>>>>    static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
>>>>    {
>>>> -	return NULL;
>>>> +	struct vdso_arch_data *data;
>>>> +
>>>> +	asm(
>>>> +		"	bcl	20, 31, .+4\n"
>>>> +		"0:	mflr	%0\n"
>>>> +		"	addis	%0, %0, (_vdso_datapage - 0b)@ha\n"
>>>> +		"	addi	%0, %0, (_vdso_datapage - 0b)@l\n"
>>>> +	: "=r" (data) :: "lr");
>>>> +
>>>> +	return &data->rng_data;
>>>>    }
>>>
>>> Did you also try something like this:
>>>
>>> extern struct vdso_arch_data _vdso_datapage __attribute__((visibility("hidden")));
>>>
>>> static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
>>> {
>>>          return &_vdso_datapage.rng_data;
>>> }
>>>
>>> Not knowing much about ppc asm the resulting assembly looks simpler.
>>> And it would be more in line with what other archs are doing.
>>
>> Did you build it ?
> 
> Yes, I couldn't have looked at the asm otherwise.
> 
>> I get :
>>
>>    VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
>>    VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
>> arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not
>> supported
>> make[2]: *** [arch/powerpc/kernel/vdso/Makefile:75:
>> arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1
> 
> I forgot to enable CONFIG_COMPAT.
> It's only broken for the 32 bit case.
> 
>> Current solution gives:
>>
>>    24:	42 9f 00 05 	bcl     20,4*cr7+so,28 <__c_kernel_getrandom+0x28>
>>    28:	7e a8 02 a6 	mflr    r21
>>    2c:	3e b5 00 00 	addis   r21,r21,0
>> 			2e: R_PPC_REL16_HA	_vdso_datapage+0x6
>>    30:	3a b5 00 00 	addi    r21,r21,0
>> 			32: R_PPC_REL16_LO	_vdso_datapage+0xa
>>
>>
>> Your solution gives:
>>
>>    60:	3e e0 00 00 	lis     r23,0
>> 			62: R_PPC_ADDR16_HA	_vdso_datapage
>>    64:	3a f7 00 00 	addi    r23,r23,0
>> 			66: R_PPC_ADDR16_LO	_vdso_datapage
>>
>>
>> So yes your solution looks simpler, but relies on absolute addresses set up
>> through dynamic relocation which is not possible because different processes
>> map the same VDSO datapage at different addresses.
> 
> Due to visibility("hidden"), the compiler should not emit absolute
> references but PC-relative ones.
> This is how it works for most other architectures, see
> include/vdso/datapage.h.
> 
> I'll try to see why this doesn't work for ppc32.

PC-rel instructions only exist on very very recent powerpc CPUs (power10 ?)

On PPC64, ELF ABI v2 requires caller to put called function address in 
r12 and it looks like GCC uses that:

0000000000000000 <__c_kernel_getrandom>:
    0:	3c 4c 00 00 	addis   r2,r12,0
			2: R_PPC64_REL16_HA	.TOC.+0x2
    4:	38 42 00 00 	addi    r2,r2,0
			6: R_PPC64_REL16_LO	.TOC.+0x6
...
   64:	3d 22 00 00 	addis   r9,r2,0
			66: R_PPC64_TOC16_HA	_vdso_datapage+0x100
   68:	89 29 00 00 	lbz     r9,0(r9)
			6a: R_PPC64_TOC16_LO	_vdso_datapage+0x100

Which after final link results in:

0000000000001060 <__c_kernel_getrandom>:
     1060:	3c 4c 00 01 	addis   r2,r12,1
     1064:	38 42 8e a0 	addi    r2,r2,-29024
...
     10c4:	3d 22 ff fc 	addis   r9,r2,-4
     10c8:	89 29 62 00 	lbz     r9,25088(r9)

We don't have such a convention in the 32 bits ABI and GCC doesn't seem 
to generate necessary code for it unless you use -fPIC. But fPIC is 
another story.

Christophe

