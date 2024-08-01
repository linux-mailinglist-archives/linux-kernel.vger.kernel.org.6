Return-Path: <linux-kernel+bounces-271762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276DF9452FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DC3287932
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AFE14600B;
	Thu,  1 Aug 2024 18:48:48 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1391EB489
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538128; cv=none; b=b3bcgOT5TWVqXfn1uPrW8uY0AFeu2HPPUCIHedqr2aF674fAs2tHoKcNn9FNtzc6BtOtgfLofCfbEeEpe4pO1r7Ec8yiX198PNV6uMnFDGwjJfaxbLMt2Huv8eEA9//4jwxoRgNKjVmbdeJBZy6w3HbQ8+TnO5D+hxE1MQ73+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538128; c=relaxed/simple;
	bh=Q4IDNYAoVPHdtMUoYWlNCd2U/j3Ft3P/eDVj4MJE1Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eWkMrF19ZURxX5oktCV0252A78c3dMqPXoxfgSv5PP14BNDpJi7FlAVsUWhom4yf7yrPSyOPcnO6xj0Uu88oKA+1lbCwvyoLl4pv+kMm0B+sDAVQLydyILBJFnnpO/aid4QciBPjPp6NInCqW4gSGq1AMRA1dlgan9wOVkkofTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D3851C0002;
	Thu,  1 Aug 2024 18:48:36 +0000 (UTC)
Message-ID: <032452c1-321a-486d-ae7b-46d7fb48578b@ghiti.fr>
Date: Thu, 1 Aug 2024 20:48:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Re-introduce global icache flush in
 patch_text_XXX()
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240730135921.156508-1-alexghiti@rivosinc.com>
 <0719e155-0a07-4878-87e3-cd96fed7a1dd@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <0719e155-0a07-4878-87e3-cd96fed7a1dd@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 01/08/2024 19:32, Samuel Holland wrote:
> Hi Alex,
>
> On 2024-07-30 8:59 AM, Alexandre Ghiti wrote:
>> commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
>> patching to avoid illegal insns") mistakenly removed the global icache
>> flush in patch_text_nosync() and patch_text_set_nosync() functions, so
>> reintroduce them.
>>
>> Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
>> Reported-by: Samuel Holland <samuel.holland@sifive.com>
>> Closes: https://lore.kernel.org/linux-riscv/CAHVXubh8Adb4=-vN4cSh0FrZ16TeOKJbLj4AF09QC241bRk1Jg@mail.gmail.com/T/#m800757c26f72a1d45c240cb815650430166c82ea
> Shouldn't this use the permalink for the specific message, not the thread?


I never paid attention to that, but the permalink is shorter so I'll 
change that, thanks


>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/riscv/kernel/patch.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
>> index ab03732d06c4..91edfd764ed9 100644
>> --- a/arch/riscv/kernel/patch.c
>> +++ b/arch/riscv/kernel/patch.c
>> @@ -205,6 +205,9 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>>   
>>   	ret = patch_insn_set(tp, c, len);
>>   
>> +	if (!ret)
>> +		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
> This patch was based on an old tree from before
> https://git.kernel.org/riscv/c/47742484ee16 removed the "tp" variable. While it
> still compiles because flush_icache_range() is a macro that discards its
> arguments, it will be confusing to anyone reading the code.


Hmmm not the first time I hear this :) Sorry, I prepared the patch a 
couple of weeks ago and the rebase on 6.11-rc1 did not complain, I do 
that right now and send a new version tomorrow.

Thanks,

Alex


>
> Regards,
> Samuel
>
>> +
>>   	return ret;
>>   }
>>   NOKPROBE_SYMBOL(patch_text_set_nosync);
>> @@ -237,6 +240,9 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>>   
>>   	ret = patch_insn_write(tp, insns, len);
>>   
>> +	if (!ret)
>> +		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
>> +
>>   	return ret;
>>   }
>>   NOKPROBE_SYMBOL(patch_text_nosync);
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

