Return-Path: <linux-kernel+bounces-305409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8F962E42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316E11C215BD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3481A4F39;
	Wed, 28 Aug 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NMZ1+rI/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B61A38E0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865240; cv=none; b=dwlPZI0QOOhzHokGIiRafLdOkf79cvc2UMUd8l2Oj8nG7fACGhRP7Tr4JZfCbSLPLEu6xuVAb8B96zdNT/GkvF2p/VAlt/3AsPQv0QE5QyFFXVVzUo9o6St6Os6Xu57fRsVRLYPPHzAJ1Qg/2QWZX7HHeWc3pcuOxFN+kjwVMaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865240; c=relaxed/simple;
	bh=hd5vKsVeROxJPpd02kgwusoFIbYzWTmwOPB4TPBya2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSB6k2N8jx08Vkj9f9oY9pfqAnheMCtBuyxJxUTZlOQIPFDQADgq4PE09do/tLyZLcB41J5IVG1HpbS3jg0OPduWwdUFb4BGAV0HvqW6AkNs8roK+ZwIfc7gwVWrei8y2j13HfyedgCOnsdTYVug2RIQwCaf/UD2GxvUbyhtP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NMZ1+rI/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714186ce2f2so5516506b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724865237; x=1725470037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZcWjsx2GFVbGR3sFLDnaT6Mg3/3VJFqnuVHgVecU75g=;
        b=NMZ1+rI/NzsiVKftfl2w6cLg0xjB7E3V2ejhcIcqlTVq+b4Lk7el07hG559y33x1ou
         ykZjgP5Jg9QG2jq1SheBnnqkS6p+2XwJfybATc7givAgF4g9HBDCrGuBSgut28uWSpR8
         kdxUqiSMMN1m2QHR3hGMGfvi4DU8fetuA0lecjiBGb4wycjGjMdKngVvGohdfIgstkUz
         pqE19LjHpAW+nSkIakpBb+PYEx+8r0m5YRJWmHKAKZNRdE/FpS9c1dp35bjErX09xlP1
         30QzcmNKJPNzwAEyIt1zc38b9OaTeoKqW6pwMocvAUlL+TUA0X+cHy3jTLyltVTln6IB
         EkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724865237; x=1725470037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcWjsx2GFVbGR3sFLDnaT6Mg3/3VJFqnuVHgVecU75g=;
        b=dQJHG5GdYW5bYVuYLdKMNayemRmY6RRW+AFOjVd5p/vT74LZQCrTHdda6L2hhZh+oo
         DdfhiTZPsj75wfzH3w5Zm624DqkaznE7RLE+dMGqZDlwYYY/Z7i0+7xM05SBwdO1ELM3
         ugufGsr+eGPLMtNKfun3lj2KggGUss73OwGeqlayZCU4TH+XjUqBsqrc5iEwsTmSc0aE
         GFHheAkBGMJ3Fcfe/9bG7hJ55jrGD8cvTidgqKZ9zzoEq6uznChSYl1Ol1qciZ/GCcZB
         nfPWo2rdrvjB2ngAzchTrrYMgIVbCEubk61iLUgGfAov1GNjD6IoFPErWHhBL5VaD07V
         YAFg==
X-Forwarded-Encrypted: i=1; AJvYcCWM9Q0dajLhISCL5rC4M8Dc8j2RWTcVIuHJrfnpStUuRqYqdypx7eSpWvXyJepUAJUJQku3mYI0z+z3FME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIKzmqu8JmXhScoJReGYI42XvZB9ErNaAuOPLNFUJvGgSlmSa
	4pM0/iFcoJD8PT2EVNNZlxAJ5G2VpPJnpQvv2wgmssurEcXgQDdBy9v4TVw5jRE=
X-Google-Smtp-Source: AGHT+IG95WpJ3Jo/yJiFE1+k5pgv7fknE0kbuwHFJ+rJt/S10BTiSVq+7xHMaRQYqpPuPYgiaBY1xg==
X-Received: by 2002:aa7:88c5:0:b0:70d:3777:da8b with SMTP id d2e1a72fcca58-715dfc43e15mr166538b3a.25.1724865237485;
        Wed, 28 Aug 2024 10:13:57 -0700 (PDT)
Received: from [192.168.1.74] (c-73-42-218-101.hsd1.wa.comcast.net. [73.42.218.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e2c83sm10342909b3a.133.2024.08.28.10.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:13:57 -0700 (PDT)
Message-ID: <526b1130-afec-4c75-8d86-74c5b7e272fe@rivosinc.com>
Date: Wed, 28 Aug 2024 10:13:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Mark Rutland <mark.rutland@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nam Cao <namcao@linutronix.de>
References: <20240826165210.124696-1-alexghiti@rivosinc.com>
 <20240827125335.GD4772@willie-the-truck>
 <CAHVXubiwHe+5nD0kftRwnNdqAhP1ofSoaUzk4vhDKPrYXVz88g@mail.gmail.com>
Content-Language: en-US
From: Atish Patra <atishp@rivosinc.com>
In-Reply-To: <CAHVXubiwHe+5nD0kftRwnNdqAhP1ofSoaUzk4vhDKPrYXVz88g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/28/24 5:36 AM, Alexandre Ghiti wrote:
> Hi Will,
> 
> On Tue, Aug 27, 2024 at 2:53 PM Will Deacon <will@kernel.org> wrote:
>>
>> On Mon, Aug 26, 2024 at 06:52:10PM +0200, Alexandre Ghiti wrote:
>>> As reported in [1], the use of smp_processor_id() in
>>> pmu_sbi_device_probe() must be protected by disabling the preemption, so
>>> simple use get_cpu()/put_cpu() instead.
>>>
>>> Reported-by: Nam Cao <namcao@linutronix.de>
>>> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>   drivers/perf/riscv_pmu_sbi.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>>> index 31a17a56eb3b..25b1b699b3e2 100644
>>> --- a/drivers/perf/riscv_pmu_sbi.c
>>> +++ b/drivers/perf/riscv_pmu_sbi.c
>>> @@ -1373,11 +1373,15 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>>
>>>        /* SBI PMU Snapsphot is only available in SBI v2.0 */
>>>        if (sbi_v2_available) {
>>> +             int cpu;
>>> +
>>>                ret = pmu_sbi_snapshot_alloc(pmu);
>>>                if (ret)
>>>                        goto out_unregister;
>>>
>>> -             ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
>>> +             cpu = get_cpu();
>>> +
>>> +             ret = pmu_sbi_snapshot_setup(pmu, cpu);
>>>                if (ret) {
>>>                        /* Snapshot is an optional feature. Continue if not available */
>>>                        pmu_sbi_snapshot_free(pmu);
>>> @@ -1391,6 +1395,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>>                         */
>>>                        static_branch_enable(&sbi_pmu_snapshot_available);
>>>                }
>>> +             put_cpu();
>>
>> Are you sure it's safe to enable the static key with preemption disabled?
>> I thought that could block on a mutex.
> 

Thanks Will for pointing that out.

> Yep, it seems you're right, thanks for jumping in.
> 
> I'm discussing with Atish how to fix that differently, I'll be back
> with another version very soon.
> 

Looking at the driver core framework code, I am wondering if a probe 
function can be preempted to run on a different cpu. If it can only be 
preempted by higher priority kernel threads or interrupts but is 
guaranteed to run on the same cpu again, we can just use the 
raw_smp_processor_id.

However, if there is no guarantee then we can just invoke 
get_cpu/put_cpu around pmu_sbi_snapshot_setup.

> Thanks again,
> 
> Alex
> 
>>
>> Will
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


