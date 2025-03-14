Return-Path: <linux-kernel+bounces-561356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42721A6106B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6426388458E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC441FDE31;
	Fri, 14 Mar 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kFbnH+qA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C71FDE14
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952967; cv=none; b=CjONCQ1SkvnWy4sYDqmbyrn4KuDeqgOiA29pd6KObyu+WlpKMb/VTOPlktVGhKdiVCmSrWJX1cmgoUHhakGw+Xej+tCvhdqcwZ33YOcKmkx7gLkeC8m+rH8Dvmi+CB2X48a9QfexbpW1sCuLIUtDu2ymBQFhtcPzMxZ1Drx1hoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952967; c=relaxed/simple;
	bh=aamCCkAiQoyGFWFnn+8tRK/vXlHXvoWzeYY4i496NBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E58t/CsMJvCFHxHUzKnzbbVFc300F2r54U2TycfmkHCokSn08cYXPyULrqfpX3O2s16Gh05xiO+vvTVVFlaQyPC8kvxcm/H9lAHLLDJmZCbMrBVUFmbTkf9a+urhLw5xq9F5LRapAiDX3IjnwdxK/uDdlrC6ixiGU7tDN2nPbiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kFbnH+qA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso13455755e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741952964; x=1742557764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnZSC151vp8qwLt12oXOY4820tmPnxSjOaRjWV8Cing=;
        b=kFbnH+qA0gx7QtfcD2ZjmMe3oO+chE9EhFCrdWUZhxnqKv19/bCQFaep9wbXgWz4vt
         lfEDCu/W3hrE7xk7dqrA8M0eBGj6J9U9MmwYqBDJFtpxmp0I3TRJDm3+3BqSom7UBKtV
         MjLeekpd8Azqu/ZBN60HUiVvIdSSABejskk6batE3j3aezELD2pc0E29XiKQAg/JfmzM
         9S4A0Ezy5ryco3WV6r/cDFB7iq9qwcSHiDPUVDQjmz5d5gsflcfam4//Oz4y4iB0UkdZ
         DL40QvVEyqNtI6rpydYmd0JK5hdYYBdEwveHgk3XfymZRcYo21tfcb2yCbr/W2SDahtU
         7HCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952964; x=1742557764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnZSC151vp8qwLt12oXOY4820tmPnxSjOaRjWV8Cing=;
        b=cFGR8/ympU2n0QA2z9PmCY4qJ0ipgz0WSAOPG0ouC2lax8OJaUJ9xd85J2wdPQoBKt
         D/BX96+kqKnDwCFOKFcMqVH/g9KcM9SLMY5BSOA/ZIu5vZgYz5ouhCkU+zXjldZtFQi3
         h6gNc4Y5GT01u9zau67b965j2x3YyX7MAeJz838v+GUpeNizzce/mBcX8N5S/NRnq+ub
         1C1dZ4ZNAu8BE8KsO4jne9vJRg1rnrSLgr0sbt1/p4rxWhDyYsC9sxsEzGY/Sxl+ECqt
         EEgNZrukfd3l+nSGGUF20jYkHjYb9UEIGXwZ0VDAk/HlDfM7pk+YDXiv/V+jHGqI0++q
         AE0A==
X-Forwarded-Encrypted: i=1; AJvYcCXEHP/VvMkx/M+x94BSxK9b2LZNnI5ltDlOZrGpGd3p9MFs+qvKgK12YD6XI6/6xcla7n3BFNeTw5/EV4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaxd3USoGywm4UJSI+c9ba6EMtFVkucjCUyTdk/11xRCVRUS/8
	Yk4zvhZEK3p8J7+OMrLxpJxBoxRJId87BRl6c+pKB8O+/c+oMZ3MnXS7EGru7XY=
X-Gm-Gg: ASbGnctX+HCw+VWPKEchXrqEEOEFcsrhH/CxgOgmjBjg7ADKYzvQlDVCsmtzu2t+4Vd
	FGFcHwApy9V9Hzl8m1fDSPe21oUcLpMN3bmEAsvUjsdI4En7oHHLnW/UbEFcClWYLgI/oxJr62O
	hGlAiF418LZt6CUcbQBKoYT7Vip2IfatGMlHEeLXO+2kmAyOzhB1wmoouQyYWFP1pDOC8b6WRNf
	ZVQF7yNs2m0NAyoSmYIt3uuT9wysamPKyy7bUSgWAyiXMLyuPON+3alr2mPeVBBu3sv1dIGGWz+
	gB6tyNdjKTtaog79Iv/5s8qAJuZwaRRDeBIgr0V1wtn8ty4RmTQyBm29m2eif603t3kquUYO8Ds
	OPkirAEFQZHS0Sw==
X-Google-Smtp-Source: AGHT+IFooexJGdlE71HjFHejmIN5yPGDOB48jansbCISOaAARNem81Cu631A445Q7st6CHhGvoNF9A==
X-Received: by 2002:a05:600c:5105:b0:439:8e95:796a with SMTP id 5b1f17b1804b1-43d225b23e7mr10331325e9.13.1741952963792;
        Fri, 14 Mar 2025 04:49:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb92csm5408510f8f.91.2025.03.14.04.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:49:23 -0700 (PDT)
Message-ID: <7073c4de-4735-429b-b520-f18c33ecaab7@rivosinc.com>
Date: Fri, 14 Mar 2025 12:49:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] riscv: misaligned: add a function to check
 misalign trap delegability
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-9-cleger@rivosinc.com>
 <20250313-4bea400c5770a5a5d3d70b38@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250313-4bea400c5770a5a5d3d70b38@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/2025 14:19, Andrew Jones wrote:
> On Mon, Mar 10, 2025 at 04:12:15PM +0100, Clément Léger wrote:
>> Checking for the delegability of the misaligned access trap is needed
>> for the KVM FWFT extension implementation. Add a function to get the
>> delegability of the misaligned trap exception.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/cpufeature.h  |  5 +++++
>>  arch/riscv/kernel/traps_misaligned.c | 17 +++++++++++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>> index ad7d26788e6a..8b97cba99fc3 100644
>> --- a/arch/riscv/include/asm/cpufeature.h
>> +++ b/arch/riscv/include/asm/cpufeature.h
>> @@ -69,12 +69,17 @@ int cpu_online_unaligned_access_init(unsigned int cpu);
>>  #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
>>  void unaligned_emulation_finish(void);
>>  bool unaligned_ctl_available(void);
>> +bool misaligned_traps_can_delegate(void);
>>  DECLARE_PER_CPU(long, misaligned_access_speed);
>>  #else
>>  static inline bool unaligned_ctl_available(void)
>>  {
>>  	return false;
>>  }
>> +static inline bool misaligned_traps_can_delegate(void)
>> +{
>> +	return false;
>> +}
>>  #endif
>>  
>>  bool check_vector_unaligned_access_emulated_all_cpus(void);
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index db31966a834e..a67a6e709a06 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -716,10 +716,10 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
>>  }
>>  #endif
>>  
>> -#ifdef CONFIG_RISCV_SBI
>> -
>>  static bool misaligned_traps_delegated;
>>  
>> +#ifdef CONFIG_RISCV_SBI
>> +
>>  static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
>>  {
>>  	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
>> @@ -761,6 +761,7 @@ static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
>>  {
>>  	return 0;
>>  }
>> +
>>  #endif
>>  
>>  int cpu_online_unaligned_access_init(unsigned int cpu)
>> @@ -773,3 +774,15 @@ int cpu_online_unaligned_access_init(unsigned int cpu)
>>  
>>  	return cpu_online_check_unaligned_access_emulated(cpu);
>>  }
>> +
>> +bool misaligned_traps_can_delegate(void)
>> +{
>> +	/*
>> +	 * Either we successfully requested misaligned traps delegation for all
>> +	 * CPUS or the SBI does not implemented FWFT extension but delegated the
>> +	 * exception by default.
>> +	 */
>> +	return misaligned_traps_delegated ||
>> +	       all_cpus_unaligned_scalar_access_emulated();
>> +}
>> +EXPORT_SYMBOL_GPL(misaligned_traps_can_delegate);
>> \ No newline at end of file
> 
> Check your editor settings.

I just enabled EditorConfig as well as clang-format so hopefully that
will be ok in the next series.

Thanks,

Clément

> 
>> -- 
>> 2.47.2
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


