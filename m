Return-Path: <linux-kernel+bounces-430086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E1A9E2D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 21:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AD4B3A5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A229205ACD;
	Tue,  3 Dec 2024 19:53:49 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8B61FA272
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255628; cv=none; b=Gl4GUPKanPhDl6S0NdXDLr45T/ptcUrJ8ryg3zKthufyPfrkqYeNtwFd6PYr6TrpPsLnXI9nupwWSGoZojEZh4R/vMficwh+LswT9/cs0Nr7YY0+0qlSyEmHFI2sWr8HrizEDsOZNmu+Ls4BaLFuON79PUjCwnp+LhwHnzTQyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255628; c=relaxed/simple;
	bh=jLF7yX8YEBZ0IGriEwDu860hLvVyxOEV6A6LU9WxgPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YAXrZnaKMCLqCcTeMSoi9U+Phoz63IJw9FvEq0H3eymXjzJPlgyzAJjJcG+NWUoDhHxMwT/nHb01XD6/D1TiUdrEtdEhmWQtegBez6EIihF+ctaGXO3y6Dne7ACZ+Pis08YQHPJuItgA+cDY2n6E90bHjs6MEQilyrTQhxwreD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y2rtx34wrz9stR;
	Tue,  3 Dec 2024 20:53:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zs1iyu-MUpRl; Tue,  3 Dec 2024 20:53:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y2rtx1qpPz9stQ;
	Tue,  3 Dec 2024 20:53:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 301298B767;
	Tue,  3 Dec 2024 20:53:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3-0Y2_s9E4jO; Tue,  3 Dec 2024 20:53:45 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 997728B763;
	Tue,  3 Dec 2024 20:53:44 +0100 (CET)
Message-ID: <d736a5cc-d976-49fd-9f86-0151d4b0a050@csgroup.eu>
Date: Tue, 3 Dec 2024 20:53:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc: support dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-3-sshegde@linux.ibm.com>
 <5089fd16-bc8c-4231-a89b-2658445e04b7@csgroup.eu>
 <ff4c586b-7be7-4c31-8b8c-5846ded486de@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ff4c586b-7be7-4c31-8b8c-5846ded486de@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/12/2024 à 20:45, Shrikanth Hegde a écrit :
> 
> 
> On 11/27/24 12:14, Christophe Leroy wrote:
>>
>>
>> Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
>>> Once the lazy preemption is supported, it would be desirable to change
>>> the preemption models at runtime. So this change adds support for 
>>> dynamic
>>> preemption using DYNAMIC_KEY.
>>>
>>> In irq-exit to kernel path, use preempt_model_preemptible for decision.
>>> Other way would be using static key based decision. Keeping it
>>> simpler since key based change didn't show performance improvement.
>>
>> What about static_call, wouldn't it improve performance ?
>>
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 6d6bbd93abab..01c58f5258c9 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -270,6 +270,7 @@ config PPC
>>>       select HAVE_PERF_EVENTS_NMI        if PPC64
>>>       select HAVE_PERF_REGS
>>>       select HAVE_PERF_USER_STACK_DUMP
>>> +    select HAVE_PREEMPT_DYNAMIC_KEY
>>
>> Can you use HAVE_PREEPT_DYNAMIC_CALL instead ? That should be more 
>> performant.
>>
>> I know static calls are not in for PPC64 yet, you can restart from 
>> https://eur01.safelinks.protection.outlook.com/? 
>> url=http%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Flinuxppc- 
>> dev%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C696bf56dcb544f3e49a408dd1240c477%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638686791595217076%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=iUwKXhmoU3YgqNI%2Bi7vwi%2Fz4obxMXD0au%2Fclo1m23ng%3D&reserved=0 cover/20221010002957.128276-1-bgray@linux.ibm.com/ and https:// github.com/linuxppc/issues/issues/416
>>
> 
> Thanks Christophe, I will take a look and understand.
> 
> May be stupid question, do the concerns of arm still valid for ppc64/ 
> ppc32 out-line static calls?

Not sure. Don't know what they call landing pad.

Limited branch range is a limitation for sure, but whatever the method 
when the called function is too far indirect call is required. And on 
powerpc the max distance is 32 Mb which is quite big for a standard 
kernel. Only modules should be concerned, but do we have scheduling code 
in modules ?

CFI I don't know.

Anyway, I resurected the series I sent to implement inline static calls 
on PPC32. I'm sure we can then amplify it to PPC64.


> https://eur01.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220214165216.2231574-6- 
> mark.rutland%40arm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C696bf56dcb544f3e49a408dd1240c477%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638686791595233955%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8jT7JHp7HgNIwVEEL7gAI8JiDvCFDShI1eIeARWwbVo%3D&reserved=0
> 
> As I understood, that is the reason they went ahead with DYNAMIC_KEY.

In their commit they have comparisons of assembly code. Can you do the 
same for powerpc to get a better picture of what we are talking about ?


Christophe

