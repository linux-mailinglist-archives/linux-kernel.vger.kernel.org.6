Return-Path: <linux-kernel+bounces-430902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE719E36FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B94286F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03A1AC448;
	Wed,  4 Dec 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8VuUgo5"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE501AA7A5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306393; cv=none; b=XWcKVDVPKwMlG9EJgrOQjuQshQJxs383n2ZCbprD9+wUl7P+D8uYAADvhKXPhp+jn4j5XWgs8lLEfDtjLvCNnq/Yfmallo+/lRi603LdL+JY7baKEkSIwFwPzZNr+tMXDqwSFf6eVatkprLkgO8xxqxeruPr1NManVKDe4PUtjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306393; c=relaxed/simple;
	bh=byZXgeZ2ivwY8dQMLRKWWL+jQ2EnfPchXyu1tYJxbc8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pZU9nF9bs2yeQIccjcab1oRBHiX0o+G/5htJ7+oroeIGAVo4RPdoaPvAxWhIaf/78WbJ2lw5fCPplaI2D3OMz23k1ktIRQgQZ+IDrafMXq9ZlidzY+ieZsnkGMRf9xHu81okc5MOKTe8LRFzPYcu0w8iH+fW3cEuDlFvzGkxeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8VuUgo5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e1f3f2a6so3181464f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733306388; x=1733911188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3JAePphPcnp1eAgPvdLOuOSkuEbV5V4trB4aVsssHkQ=;
        b=I8VuUgo506MxsZSw1aQZcoEpgJ1oZZJBOqM+faHYmNIf44lpwD+NUdFFKdj02bNsTB
         pcEb/sKZT1JlkLRFTNRM7/HtEbM0mHy/iSZBL1yW+8Ij4Al48UKEOsWk7MvsdKS1WBUx
         NI6mkbOcjVnCIENUEIbe6Q7KiH8DdB5PGVw2oNUYdlGVk34lxxgIeZP46duNs6mhsakU
         FZeEytOyzY4CX8vcCSDDqunz7D/+moCuSrZjXCiDLQn/SuWRt5u3GfexSx+xy6jyVM2c
         je9B0d2q/tTeVBPwx9MvLLKcnPatih1RgKu85CQgvn3cr8EwR5qSDhNHFneu1Kgf4wTL
         Itpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306388; x=1733911188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JAePphPcnp1eAgPvdLOuOSkuEbV5V4trB4aVsssHkQ=;
        b=qmSjPaKMm6l89Vm/jQkEKL+HEBqV9DJnnd1GKfihZkaleSrz/2VMlZwOuYKtA+Wcw6
         6YPlj/aAFtq5dOVPuIiZhO+7wAXsFe/vgi2E0yCXqQvxBb0nBHulgc5hz5bb+DyJUffT
         H9+0xgqQgb9vmVb6n9WH0qUqTdJCODSJ40VjtKZAHdzg7DZhrHdEXapNKp734+JjdoPx
         LEP9i0HB2c/3moCsnOlIgItPHE8wlgsDq82+lenLHlnuWWQCkcUxhDF4opUlp53nPjgb
         RDP7doTT1JlcEOPRIGusuWadbm2937JWX/KPRmL/DGkrqQYzQs0cq/zZY43+E5a+BIpt
         wafQ==
X-Forwarded-Encrypted: i=1; AJvYcCW53LI2f6M/3FCSxd17HeNZnd9kfiur2ZETnEQ1SPfTEjT1gUQRwQFbOfjVEO4noBs9Roy/RX4/J1cWbIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVQhBmmnBOZHYNzIOu2fIra5mWwAOd/C2vP8Ix9kBaQWITqPW
	YLQKLGC8EkG61gslx2b1px/83Xn12MiyeVp41fII0DkKAeapww7ngtM4Or7TO8s=
X-Gm-Gg: ASbGncuTC3TF/YMNNAR7ztVI/IT7gtZujYYhZV+AjKpOJSibLDa0tYIRgpuCRTiqJMw
	UEMsclKE2I4BsNd73osdalGPG3UMOe9n1KO+hUQTp3BNQfFRRgTas12vYrvpDlrYRndJFA2JfwF
	kfAmEBZPxz+bdXIcQc6Ib/o+oHKyspVA7qpPehRmHoOmCYE3sRlGeTfPO85dzskAOIiUJImoFbT
	Z4MJRIlZPWaoPlFQUOJq46yxT+n1nlJ26htvQUezITNN9uTBqCKnfrH8KY2lw==
X-Google-Smtp-Source: AGHT+IGidQDLyHMD3KI1jIdL4LmanrH/fT/0s6EUXalZdsQ7+VfmdI1b9R90aH/W7GH8cFt9sBHQTQ==
X-Received: by 2002:a5d:588f:0:b0:385:f062:c2df with SMTP id ffacd0b85a97d-385fd3ccda2mr5610676f8f.11.1733306388380;
        Wed, 04 Dec 2024 01:59:48 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ea17f78esm10836309f8f.64.2024.12.04.01.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:59:47 -0800 (PST)
Message-ID: <38205401-3fdc-4b3d-a018-bb5a569fdc12@linaro.org>
Date: Wed, 4 Dec 2024 09:59:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] perf tools: Fix build error on
 generated/fs_at_flags_array.c
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20241203035349.1901262-1-namhyung@kernel.org>
 <20241203035349.1901262-12-namhyung@kernel.org>
 <981436ce-2d41-4c3e-b77e-63e4c200cd0e@linaro.org>
 <Z09-GGWh87_wrslp@google.com>
 <3fae886d-baa6-4670-8418-a57c02572f78@linaro.org>
Content-Language: en-US
In-Reply-To: <3fae886d-baa6-4670-8418-a57c02572f78@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/12/2024 9:39 am, James Clark wrote:
> 
> 
> On 03/12/2024 9:54 pm, Namhyung Kim wrote:
>> Hello,
>>
>> On Tue, Dec 03, 2024 at 04:43:44PM +0000, James Clark wrote:
>>>
>>>
>>> On 03/12/2024 3:53 am, Namhyung Kim wrote:
>>>> It should only have generic flags in the array but the recent header
>>>> sync brought a new flags to fcntl.h and caused a build error.  Let's
>>>> update the shell script to exclude flags specific to 
>>>> name_to_handle_at().
>>>>
>>>>       CC      trace/beauty/fs_at_flags.o
>>>>     In file included from trace/beauty/fs_at_flags.c:21:
>>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: 
>>>> error: initialized field overwritten [-Werror=override-init]
>>>>        13 |         [ilog2(0x002) + 1] = "HANDLE_CONNECTABLE",
>>>>           |                              ^~~~~~~~~~~~~~~~~~~~
>>>>     tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: 
>>>> note: (near initialization for ‘fs_at_flags[2]’)
>>>>
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>
>>> Hi Namhyung,
>>>
>>> Is it possible to fix this before the updates to keep it buildable? 
>>> Maybe
>>> it's not feasible, I didn't check.
>>>
>>> I did notice a build issue in the kvm tests after this update:
>>>
>>> $ make O=../build/local/ summary=1 TARGETS=kvm kselftest
>>>
>>> In file included from aarch64/aarch32_id_regs.c:14:
>>> include/aarch64/processor.h:15:10: fatal error: asm/brk-imm.h: No 
>>> such file
>>> or directory
>>>     15 | #include <asm/brk-imm.h>
>>>
>>> But I tried the same on v6.13-rc1 and got a different error, so I 
>>> don't know
>>> if it's any worse.
>>
>> I suspect it's an unrelated issue.  This fix is about generating
>> descriptions of the flags for perf trace beautifier.
>>
>> The below is the only change I made in this series for arm64.
>>
>> Thanks,
>> Namhyung
>>
> 
> I'll take a look
> 

Looked like some kind of stale build issue. A clean fixed it but I 
wasn't able to reproduce it.

>>
>> ---8<---
>> diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/ 
>> arm64/include/uapi/asm/kvm.h
>> index 964df31da9751c96..66736ff04011e0fa 100644
>> --- a/tools/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/tools/arch/arm64/include/uapi/asm/kvm.h
>> @@ -484,6 +484,12 @@ enum {
>>    */
>>   #define KVM_SYSTEM_EVENT_RESET_FLAG_PSCI_RESET2        (1ULL << 0)
>> +/*
>> + * Shutdown caused by a PSCI v1.3 SYSTEM_OFF2 call.
>> + * Valid only when the system event has a type of 
>> KVM_SYSTEM_EVENT_SHUTDOWN.
>> + */
>> +#define KVM_SYSTEM_EVENT_SHUTDOWN_FLAG_PSCI_OFF2       (1ULL << 0)
>> +
>>   /* run->fail_entry.hardware_entry_failure_reason codes. */
>>   #define KVM_EXIT_FAIL_ENTRY_CPU_UNSUPPORTED    (1ULL << 0)
> 


