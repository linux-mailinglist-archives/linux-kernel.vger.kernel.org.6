Return-Path: <linux-kernel+bounces-353473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89287992E4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312621F2458B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48F1D54EF;
	Mon,  7 Oct 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5PVbxDd"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FEE1D4159;
	Mon,  7 Oct 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310008; cv=none; b=HH2ZcAaUKqKzp1abMYrecbgtnNVo4ITWnuQu/8UP0KE8e4LqGeTFVxLIY3ZEgi2WVTXVIVtTfDQ913z2gQ1s9Uj626vIghbQ1grMv5TBc4rahpgSlffF2dW8Y+yDg7/tM/1sFgxC9NYO2MQmHjqttNAy5YqhMJ/ZcTorbxreW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310008; c=relaxed/simple;
	bh=OIh91yziIpHaBiPPYMsEELwdvk2Wd9ylaZsu+/uRM7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5nkChZTgSkW0m15IaQdPnH43toIXNdcLfvS3/ZKqyfweP/3sgPdFiaTh4KQtm1UbAInZLupe/afSiPk0z/6m9iIPz+Odk7eXPCimFTKeRFQHvwAwtyV5PquOpIHuh9BJRuxpdEorrK+f7ArKiF0xxelYlsvNL4yewg01jBVQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5PVbxDd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so5660520a12.1;
        Mon, 07 Oct 2024 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310005; x=1728914805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MdQ4yGHqhJQxjQ94zkFj9YscA03Tg1UyYYIoS94UNGE=;
        b=M5PVbxDdHREjBiNsw7rmrwvE5p367QIOxFoizmtoCCj841EUHyGGo8QEzNS2ZTniKN
         /+HeE215skteQ7gvHxe4BccsBdzDQh7wY1VAAbsmeANzhg1uaIKHrqikEwnWCqokBoZu
         FpVc90EDHYf1cBw9TlgkWozDGtFIyqHv9719EmRzOnqtc4lHLBq0yxLI69lGLqeCa4ow
         5qrdR7SGntZ9V1njGD2fM7+qU7nIKOmF4Nm4/plpYGC73++l5g4yoWW/XsHL5lVqUT/L
         5O27j81AvYNPacHKzHo/sBFwu7z9pA5PLVEGQj2BT+ST/tqS3KPe94TTidhwN/7lJpc/
         a6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310005; x=1728914805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdQ4yGHqhJQxjQ94zkFj9YscA03Tg1UyYYIoS94UNGE=;
        b=mSmjLzhGf5Oi7UBNITpyGZBMTIT3pExVRGWVZFZZZyMBDBL3rOVrGdtgneNA44Gpom
         MKRIAvA+nGQzvgYaXkQUVnMCZ7736fLfTFvS47sPqnMNyGhEAleRpGkdBdCCbMcXFaYE
         TQcRyP3XW6Qhc8jQSbo5zhKZkYlRiq5ktVg1KaR4ZXcolVMppBWwj1jakQ0MGjPVp6vN
         W8gk0mXdui2AuaXPl6QLqOwBvAW1iKlPTAXMN0hAo6ivuzgcRa0M2JEVp2uxUgO/WUBa
         kctZnc88f6bHps0yxNOdfpEglVNJzeuJJrCuxuJp9jMNo92X2L/tSNmI5MX5JDEqxHgC
         Qsgg==
X-Forwarded-Encrypted: i=1; AJvYcCVaTOHHJ5ZAFl1mYuF8BxuWCsrLcqEdRWkvAvyT5SeXDsUhvFYCKR5bOzbEcMhrqVuCasVm9P+o0GcT@vger.kernel.org, AJvYcCXh+bvAau5O9wcmz2n1dMk9UtP6k/+wrbcExiknoCkxrOeYa+FRMLKLGXM/dr1yCZg0H9hSRoaEob+a/5Ay@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7UUjGEtmB40CL4AV5LcKuQPiEG9ultrzj385YgzKgdZV+SYX
	8HrjmHKsfZaUPkFJsqlcbkdG4GC6VHp7yMK+5EfG+c5rf+53krqn5MeyIw==
X-Google-Smtp-Source: AGHT+IHzTf9/mOydaRIHtAD1WG+qTiC3dn2gaVfrhGsXeLY2d2YXJzxhT6uT0jaK87guDPp/jNDboQ==
X-Received: by 2002:a17:907:972a:b0:a8d:555f:eeda with SMTP id a640c23a62f3a-a991bce5aecmr1377640066b.8.1728310005084;
        Mon, 07 Oct 2024 07:06:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:3232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f74e13csm187218766b.164.2024.10.07.07.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:06:44 -0700 (PDT)
Message-ID: <d3d90f10-1ccd-4557-843c-5b546d3b913c@gmail.com>
Date: Mon, 7 Oct 2024 15:06:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
 catalin.marinas@arm.com, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <20241004000316.GA1910499-robh@kernel.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20241004000316.GA1910499-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/10/2024 01:03, Rob Herring wrote:
> On Thu, Oct 03, 2024 at 12:38:40PM +0100, Usama Arif wrote:
>>  __pa() is only intended to be used for linear map addresses and using
>> it for initial_boot_params which is in fixmap for arm64 will give an
>> incorrect value. Hence stash the physical address when it is known at
>> boot time and use it at kexec time instead of converting the virtual
>> address using __pa().
>>
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
>> ---
>>  arch/arm64/kernel/setup.c | 8 ++++++++
>>  drivers/of/fdt.c          | 6 ++++++
>>  drivers/of/kexec.c        | 8 ++++++--
>>  include/linux/of_fdt.h    | 2 ++
>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index b22d28ec8028..a4d96f5e2e05 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>  	/* Early fixups are done, map the FDT as read-only now */
>>  	fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>>  
>> +	/*
>> +	 * Save dt_phys address so that it can be used later for kexec. This
>> +	 * is done as __pa() is only intended to be used for linear map addresses
>> +	 * and using it for initial_boot_params which is in fixmap will give an
>> +	 * incorrect value.
>> +	 */
>> +	set_initial_boot_params_pa(dt_phys);
> 
> No new arch->dt functions please. If we need to save off the PA, then do 
> that when we set initial_boot_params.
> 
> Rob


initial_boot_params is set in early_init_dt_verify, called by early_init_dt_scan.
This is done in setup_machine_fdt in arm64 where the PA is available,
but in other functions in other architectures, where the PA is not available.
So it makes it quite messy to set it in the same place as initial_boot_params.
Its only needed for arm64 and making a change in all archs probably isnt a good idea?

Any reason to not add a new function to make arch -> of/fdt call?

Thanks,
Usama




