Return-Path: <linux-kernel+bounces-319012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF1E96F675
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436621C227FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C071D2787;
	Fri,  6 Sep 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cMpd6Fes"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968331D1F72
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632133; cv=none; b=BQDdoXDLKO+IJt69mkdHd+c89Yd6LJ715EwT9G9vupZnk4AhgHNp5jVWeDmb8fsHqUfZAzA91KF+9sTCxI8lua+Ic5Ha98/Bi0Pvx1L6OJ5rPy/V98Ls4q690rSVM4rrnFJYbsKZWs//u2eMUqOhm92avYUp3GGUHQ9iILgsf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632133; c=relaxed/simple;
	bh=y5MxjUMhzpEGLcAk+RQ1L1Eah2Fr5EnO8/enSmmZa6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L26A7+CnTv/K1LhA1730B/AmaoCMX5QDBb6YvQgX7Q4rNhJStxxed4sb0VXojPT2tkEsYlKhq1yrt+G8rQ/XHN9a1Fyp+LcQ3TRcp9D+3P5YeWqVJyT3JqNBo7ydzZo+kMBfWY9O78VmtfiNROTzt/uQjWGXSBtvWLXKOCr3yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cMpd6Fes; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82a32294b27so102326139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725632130; x=1726236930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDDzZwDYU4Gy6OtpP5FWKJoDHuwx4Dvh85vp17WCwo4=;
        b=cMpd6FesQLw4KQNv5rOhx8z80CKGeF0F42uvuBmhprQOHMJYukT0lks+ZR/hkiMPE0
         sAjHkDVZnTM1r9pol90a0am6kRqWO398EkBZoqRMLxwRo/ggRenMbYF3FytPYnjbdXHI
         QXrGJYUHZ/uVD0KJ3WO7nesaC4DIu3Q7IOK1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632130; x=1726236930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDDzZwDYU4Gy6OtpP5FWKJoDHuwx4Dvh85vp17WCwo4=;
        b=K/sH96CMECTTuXOflDdwjMrlRv7jOJtkxrO+YLZTz+zoT+fUaosTqvRpVzyfHJpvRs
         0USAaABLY9Q9OnmGFVuQFKo2f6w5JWWlbtcD9fbMwLhj6w49DKjOfzrtq58eYDKv8lru
         QIL2bpI7ymibvzybDqRSN5d9x2WeXn7JZEmgAqlWZPy2//HH8PtmxCTBkhu9FCCdGN9X
         hXx+tYR43kFCLVUdReNW3UVUq8YGvAiiZiF1yrKSYRsRAvq2QEsEQIkxLXN1tBYRZUGc
         GUri3dQLKQzhlrRSFDKdwNKpTgc6KUK7q2v0cdWqWjW9Kv/0d4ygrUYd0xRcFoVv8zq2
         dyFw==
X-Forwarded-Encrypted: i=1; AJvYcCVpomG8oe9WUIqmu9N5r0hHbKRbI8a3thCf564Z/HkBUH0pXDteHaHOT02CdAERkYfCZDU5QIttdk/qJ90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJf5J66y/q52NuAzGb8JnGbMwT8WX4yoUVjq3xRLi+6dGZGnSW
	yj7vqDUvFUgnPLUs2hFuzASVjPomCIxAeMccEGK2cQyc4cj8fAJd1ahxSj/rgp0=
X-Google-Smtp-Source: AGHT+IEqK3aHyVvIF5x9SIq59DQgu4GmB9tqUj2d49l/0SkuT/UStk0+VtWJJAOQEjuFzgu/WZZNlw==
X-Received: by 2002:a05:6e02:525:b0:39e:69bc:a7fe with SMTP id e9e14a558f8ab-39f797b23cdmr65602215ab.10.1725632130496;
        Fri, 06 Sep 2024 07:15:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de601csm4129939173.48.2024.09.06.07.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:15:30 -0700 (PDT)
Message-ID: <ae32280e-e3a2-418c-a148-c59956b6521c@linuxfoundation.org>
Date: Fri, 6 Sep 2024 08:15:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:resctrl: Fix build failure on archs without
 __cpuid_count()
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>, shuah@kernel.org,
 fenghua.yu@intel.com, reinette.chatre@intel.com,
 ilpo.jarvinen@linux.intel.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240905180231.20920-1-skhan@linuxfoundation.org>
 <ad3d035e-be82-44c4-a850-a33889fcf717@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ad3d035e-be82-44c4-a850-a33889fcf717@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 01:35, Muhammad Usama Anjum wrote:
> Hi Shuah,
> 
> Thank you for fixing it.
> 
> On 9/5/24 11:02 PM, Shuah Khan wrote:
>> When resctrl is built on architectures without __cpuid_count()
>> support, build fails. resctrl uses __cpuid_count() defined in
>> kselftest.h.
>>
>> Even though the problem is seen while building resctrl on aarch64,
>> this error can be seen on any platform that doesn't support CPUID.
>>
>> CPUID is a x86/x86-64 feature and code paths with CPUID asm commands
>> will fail to build on all other architectures.
>>
>> All others tests call __cpuid_count() do so from x86/x86_64 code paths
>> when _i386__ or __x86_64__ are defined. resctrl is an exception.
>>
>> Fix the problem by defining __cpuid_count() only when __i386__ or
>> __x86_64__ are defined in kselftest.h and changing resctrl to call
>> __cpuid_count() only when __i386__ or __x86_64__ are defined.
>>
>> In file included from resctrl.h:24,
>>                   from cat_test.c:11:
>> In function ‘arch_supports_noncont_cat’,
>>      inlined from ‘noncont_cat_run_test’ at cat_test.c:326:6:
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:304:17: note: in expansion of macro ‘__cpuid_count’
>>    304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
>> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>>        |         ^~~~~~~
>> cat_test.c:306:17: note: in expansion of macro ‘__cpuid_count’
>>    306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>
>> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> LGTM
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thank you for the review and finding the problem to begin with.
Much appreciated.

> 
> ...
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index 742782438ca3..ae3f0fa5390b 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -290,12 +290,12 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>   
>>   static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>   {
>> -	unsigned int eax, ebx, ecx, edx;
>> -
>>   	/* AMD always supports non-contiguous CBM. */
>>   	if (get_vendor() == ARCH_AMD)
>>   		return true;
>>   
>> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>> +	unsigned int eax, ebx, ecx, edx;
>>   	/* Intel support for non-contiguous CBM needs to be discovered. */
>>   	if (!strcmp(test->resource, "L3"))
>>   		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> @@ -305,6 +305,8 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>   		return false;
>>   
>>   	return ((ecx >> 3) & 1);
>> +#endif /* end arch */
>> +	return false;
> nit: empty line before return

Will do.

> 
>>   }
>>   
>>   static int noncont_cat_run_test(const struct resctrl_test *test,
> 

thanks,
-- Shuah

