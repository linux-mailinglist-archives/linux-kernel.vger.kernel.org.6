Return-Path: <linux-kernel+bounces-358600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B301998177
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2651C246B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60521BE22D;
	Thu, 10 Oct 2024 09:00:26 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C01BDAA0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550826; cv=none; b=W+/hkuJWBUJ4Wbogf8qVRjEHEPA7t6FuPIM5QGpnkfzd91j1JOzWjWzEgXdX7aHqQo2PkZRPDCWuVwArphDJzO1GjbOpA5Xl42nrAd/EuajLahbfeQYjzS8wX3JkGiC5m3kDXjrfbxaScgSWakKzAnHZKh/6GwOKQLneXoWF6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550826; c=relaxed/simple;
	bh=l9SzKVZfg59A2Gy9EKzokIi0Q9KBkco80LuOQXhnkLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASBB9UL3yohXJcyZ/PJKQ0CxhwIntVS8yGzxwP3cBAOuCPdiUDkfkPxuAVHVbqUK64+557BjXDTsCqoWXiGWRDCU3XadzV0mJU0/wuxiaL622ymsDrgIwazj7RKFpgXNa95pORzEyCw4YK7kPgUjr6g7RRpxJpObt4mucP1oyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XPNxx4D8Pz9sPd;
	Thu, 10 Oct 2024 11:00:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVlEZLE3DrkG; Thu, 10 Oct 2024 11:00:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XPNxr4lZMz9sS8;
	Thu, 10 Oct 2024 11:00:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 92CE18B79F;
	Thu, 10 Oct 2024 11:00:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DDueIiD9HNs4; Thu, 10 Oct 2024 11:00:16 +0200 (CEST)
Received: from [192.168.232.17] (unknown [192.168.232.17])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D984B8B79E;
	Thu, 10 Oct 2024 11:00:15 +0200 (CEST)
Message-ID: <0a3d0813-e44f-45be-8b9a-957c75aa26cb@csgroup.eu>
Date: Thu, 10 Oct 2024 11:00:15 +0200
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241010101449-007991a0-f7c7-4f76-a6cc-413c474b9219@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Le 10/10/2024 à 10:20, Thomas Weißschuh a écrit :
> On Wed, Oct 02, 2024 at 10:39:29AM +0200, Christophe Leroy wrote:
>> VDSO time functions do not call any other function, so they don't
>> need to save/restore LR. However, retrieving the address of VDSO data
>> page requires using LR hence saving then restoring it, which can be
>> heavy on some CPUs. On the other hand, VDSO functions on powerpc are
>> not standard functions and require a wrapper function to call C VDSO
>> functions. And that wrapper has to save and restore LR in order to
>> call the C VDSO function, so retrieving VDSO data page address in that
>> wrapper doesn't require additional save/restore of LR.
>>
>> For random VDSO functions it is a bit different. Because the function
>> calls __arch_chacha20_blocks_nostack(), it saves and restores LR.
>> Retrieving VDSO data page address can then be done there without
>> additional save/restore of LR.
>>
>> So lets implement __arch_get_vdso_rng_data() and simplify the wrapper.
>>
>> It starts paving the way for the day powerpc will implement a more
>> standard ABI for VDSO functions.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/vdso/getrandom.h | 15 +++++++++++++--
>>   arch/powerpc/kernel/asm-offsets.c         |  1 -
>>   arch/powerpc/kernel/vdso/getrandom.S      |  1 -
>>   arch/powerpc/kernel/vdso/vgetrandom.c     |  4 ++--
>>   4 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
>> index 501d6bb14e8a..4302e7c67aa5 100644
>> --- a/arch/powerpc/include/asm/vdso/getrandom.h
>> +++ b/arch/powerpc/include/asm/vdso/getrandom.h
>> @@ -7,6 +7,8 @@
>>   
>>   #ifndef __ASSEMBLY__
>>   
>> +#include <asm/vdso_datapage.h>
>> +
>>   static __always_inline int do_syscall_3(const unsigned long _r0, const unsigned long _r3,
>>   					const unsigned long _r4, const unsigned long _r5)
>>   {
>> @@ -43,11 +45,20 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
>>   
>>   static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
>>   {
>> -	return NULL;
>> +	struct vdso_arch_data *data;
>> +
>> +	asm(
>> +		"	bcl	20, 31, .+4\n"
>> +		"0:	mflr	%0\n"
>> +		"	addis	%0, %0, (_vdso_datapage - 0b)@ha\n"
>> +		"	addi	%0, %0, (_vdso_datapage - 0b)@l\n"
>> +	: "=r" (data) :: "lr");
>> +
>> +	return &data->rng_data;
>>   }
> 
> Did you also try something like this:
> 
> extern struct vdso_arch_data _vdso_datapage __attribute__((visibility("hidden")));
> 
> static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> {
>         return &_vdso_datapage.rng_data;
> }
> 
> Not knowing much about ppc asm the resulting assembly looks simpler.
> And it would be more in line with what other archs are doing.

Did you build it ?

I get :

   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
   VDSO32L arch/powerpc/kernel/vdso/vdso32.so.dbg
arch/powerpc/kernel/vdso/vdso32.so.dbg: dynamic relocations are not 
supported
make[2]: *** [arch/powerpc/kernel/vdso/Makefile:75: 
arch/powerpc/kernel/vdso/vdso32.so.dbg] Error 1

Current solution gives:

   24:	42 9f 00 05 	bcl     20,4*cr7+so,28 <__c_kernel_getrandom+0x28>
   28:	7e a8 02 a6 	mflr    r21
   2c:	3e b5 00 00 	addis   r21,r21,0
			2e: R_PPC_REL16_HA	_vdso_datapage+0x6
   30:	3a b5 00 00 	addi    r21,r21,0
			32: R_PPC_REL16_LO	_vdso_datapage+0xa


Your solution gives:

   60:	3e e0 00 00 	lis     r23,0
			62: R_PPC_ADDR16_HA	_vdso_datapage
   64:	3a f7 00 00 	addi    r23,r23,0
			66: R_PPC_ADDR16_LO	_vdso_datapage


So yes your solution looks simpler, but relies on absolute addresses set 
up through dynamic relocation which is not possible because different 
processes map the same VDSO datapage at different addresses.

Christophe

