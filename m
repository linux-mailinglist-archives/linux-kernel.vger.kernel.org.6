Return-Path: <linux-kernel+bounces-569696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D5BA6A63F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E73AFBCB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BA422068D;
	Thu, 20 Mar 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SS7HUKj5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C470E21D3ED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742473566; cv=none; b=tvmYDF/g870IFzN26ENxPhH1gjvamC3zlXA/stkACbcfEiATT/Gm2mO4Pnod6J7Jbta5/F/NL/m/fISiKYi5o0zjBl1rTiP9U+8o9sbl61P7ILih9HWvBKrkufF1dMDi/ZRYfj5QMk7FTDyRCVGVB/+qfq8dOVgjBxiQih99OPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742473566; c=relaxed/simple;
	bh=hyJJNpohcdAU4yMBA4YOg2G2u7d26Sa45nVB2rMFA9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aI7lHCPLXYFycTvm8kNxHh/tY7WtUFTQdKW5uB1xmeM9wxGCJXdK/Jt4/elPBzF5sq0sozmBZHk2hC+o+G0RLuLfFcNdBNBGoBsaBV1jf6hHshDSJbhLazUs5AcIeLAVwKtTx8MMyRiilvuHA0VSdl76FAlcQqse26naYyQfRp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SS7HUKj5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so3267515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742473562; x=1743078362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8ZNXPFVzOU94mt6m9mbPGIBWqdibsgDwCTGYVYUKFE=;
        b=SS7HUKj5ls7TrZWTIGWB8yE6kLVyXKJOmDdCSehJneP9pzwpETTuSYcQikm+zqiNV8
         SmSWHts+OTeMegyGhr0A7sxnoHD8MWDbPnkzRZ0KFQAHMgm4xFrhzJDAB3hi15l9nOQN
         FZPO4V2ZPRTkakDE1zQ7g/xErixxXpb48K9NG2Ix5/f1Qkv96pJUKWRCval4YTyi/x7J
         JnJeGTbyeeu9CBVE8FetZ4PeQDCIYlI19uJl230j9Z9BZOL0W/pjqEg4Et3kaBj2t9RO
         44dmjluhDaAUs++Nz7VcPByRe4nnzJR9qKLfRuJsHCTkwWCIgusB9KX85mCLQv7yAZhT
         mNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742473562; x=1743078362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8ZNXPFVzOU94mt6m9mbPGIBWqdibsgDwCTGYVYUKFE=;
        b=TPMzFMW+MLPTNSMhZEf7MXGMwEpScHm4H7rPukVioZ3/lW9GS+eLtnAQNUdhKJzvqb
         pvlTek/CMCdZ81h0I4CqqByEh4Xnsmynw/PSTWQWjH4msycq/SDVoS7+6smfrbD2HYt0
         zWl8j2/A1BQXh+muuc348pGyCucYXpOOVxcZ1YPqtBkMh/MgPdcy8CQQELUC6ZQDq2H3
         8z1LwGnCf1OgmoDG1CL1q5Pu4wT/4Ll1jAet6dNPMZBR9JRrb1Mqb5deifZv77JATxQf
         unp4VZi3Zc4g1fqUZUNi56bHq0FgOkAonsyT/8Zx4Q29qAzVCojEJ8ZKWHKNioc+ZdJ8
         VHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRv/n7b/JGhitDF/nPO6Zq5vXEljRnkdoXY8VPaNfHny5bmNRAVs3AnRqOpFlTx5bgy09OKsgQO9EO5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUk+YFpjkTbRPbIhPgqKFbk2Sux9WH2ua4Sie/c02rJz2qX4T5
	aSQQu8F31SK+zZM3yL/5LKeZ3B1e4Tbmrl9lk9iY1xiZIcIvi8BtyMkF6ebHaXk=
X-Gm-Gg: ASbGncvTBOx5ZL267YVIXQLRsqkwFKhjk/p6f8QQBXbiCNzz+41A+S1y18FTsW/7mkE
	++89oXJwO1S9mbgPVTEcK0l6yLg1kWQeT+UQpXX9tttYpu6xKP+FQ7YECJvo4xbjsAQpALMt0ni
	qvpS8bUU/AbGyZKZudMlMqZJo2Md65e57y8WF8jqHhqJjh17LazbQEWYkdE/AuLMTZvhQvGQci7
	VHPN5aD4F3xlqvH10hFPnRnLEqPWX4PXU3lz+4+1OtHYV9kslHToZJhXGzkaj32Rl/1EVHCGsR6
	s6lmLXXIn0M3O+NTuSuBmOPKN9fCeTYGg7D/0+UE7XmJRt/he74J7H8lD2IHZI4d/nK+/Mm4z5U
	LFEU5hz7AbyTXMw==
X-Google-Smtp-Source: AGHT+IFnoeXcjNAxgR/nncQsW47FJFX+8xYUDmI97yV8HuiwXCeccO5v+DsUKuiyYhZi6nrc3nxEYg==
X-Received: by 2002:a05:600c:4503:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-43d437c330fmr74088995e9.15.1742473561773;
        Thu, 20 Mar 2025 05:26:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35ecsm23914546f8f.16.2025.03.20.05.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:26:01 -0700 (PDT)
Message-ID: <8115698f-3cf7-4a6a-83cf-9dc288c84ee0@rivosinc.com>
Date: Thu, 20 Mar 2025 13:26:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] riscv: add support for SBI Supervisor Software
 Events extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>
References: <20241206163102.843505-1-cleger@rivosinc.com>
 <20241206163102.843505-3-cleger@rivosinc.com>
 <20250319-46b625cf8b771616d4c7c053@orel>
 <b3fbd730-295f-4491-b0d6-d4e258941ae5@rivosinc.com>
 <20250320-5f9612f1b503c79c9b185b10@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250320-5f9612f1b503c79c9b185b10@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/03/2025 12:52, Andrew Jones wrote:
> On Thu, Mar 20, 2025 at 09:16:07AM +0100, Clément Léger wrote:
>>
>>
>> On 19/03/2025 18:08, Andrew Jones wrote:
>>> On Fri, Dec 06, 2024 at 05:30:58PM +0100, Clément Léger wrote:
>>> ...
>>>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cpu)
>>>> +{
>>>> +	void *stack;
>>>> +
>>>> +	arch_evt->evt_id = evt_id;
>>>> +	stack = sse_stack_alloc(cpu, SSE_STACK_SIZE);
>>>> +	if (!stack)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	arch_evt->stack = stack + SSE_STACK_SIZE;
>>>> +
>>>> +	if (sse_init_scs(cpu, arch_evt))
>>>> +		goto free_stack;
>>>> +
>>>> +	if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
>>>> +		arch_evt->interrupted_state_phys =
>>>> +				per_cpu_ptr_to_phys(&arch_evt->interrupted);
>>>> +	} else {
>>>> +		arch_evt->interrupted_state_phys =
>>>> +				virt_to_phys(&arch_evt->interrupted);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>
>>> Hi Clément,
>>>
>>> Testing SSE support with tools/testing/selftests/kvm/riscv/sbi_pmu_test
>>> led to an opensbi sbi_trap_error because the output_phys_lo address passed
>>> to sbi_sse_read_attrs() wasn't a physical address. The reason is that
>>> is_kernel_percpu_address() can only be used on static percpu addresses,
>>> but local sse events get their percpu addresses with alloc_percpu(), so
>>> is_kernel_percpu_address() was returning false even for local events. I
>>> made the following changes to get things working.
>>
>> Hi Andrew,
>>
>> Did something changed recently ? Because I tested that when it was send
>> (PMU + some kernel internal testsuite) and didn't saw that. Anyway, I'll
>> respin it with your changes as well.
> 
> It depends on the kernel config. Configs that don't have many
> alloc_percpu() calls prior to the one made by sse can work, because,
> iiuc, alloc_percpu() will get its allocation from the percpu allocator's
> first chunk until that chunck fills up. The first chunck is shared with
> the static allocations.

Makes sense ! Thanks, I'll look at it.

> 
> Thanks,
> drew
> 
>>
>> Thanks !
>>
>> Clément
>>
>>>
>>> Thanks,
>>> drew
>>>
>>> diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
>>> index b48ae69dad8d..f46893946086 100644
>>> --- a/arch/riscv/kernel/sse.c
>>> +++ b/arch/riscv/kernel/sse.c
>>> @@ -100,12 +100,12 @@ int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cp
>>>         if (sse_init_scs(cpu, arch_evt))
>>>                 goto free_stack;
>>>
>>> -       if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
>>> +       if (sse_event_is_global(evt_id)) {
>>>                 arch_evt->interrupted_state_phys =
>>> -                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
>>> +                               virt_to_phys(&arch_evt->interrupted);
>>>         } else {
>>>                 arch_evt->interrupted_state_phys =
>>> -                               virt_to_phys(&arch_evt->interrupted);
>>> +                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
>>>         }
>>>
>>>         return 0;
>>> diff --git a/drivers/firmware/riscv/riscv_sse.c b/drivers/firmware/riscv/riscv_sse.c
>>> index 511db9ad7a9e..fef375046f75 100644
>>> --- a/drivers/firmware/riscv/riscv_sse.c
>>> +++ b/drivers/firmware/riscv/riscv_sse.c
>>> @@ -62,11 +62,6 @@ void sse_handle_event(struct sse_event_arch_data *arch_event,
>>>                         ret);
>>>  }
>>>
>>> -static bool sse_event_is_global(u32 evt)
>>> -{
>>> -       return !!(evt & SBI_SSE_EVENT_GLOBAL);
>>> -}
>>> -
>>>  static
>>>  struct sse_event *sse_event_get(u32 evt)
>>>  {
>>> diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
>>> index 16700677f1e8..06b757b036b0 100644
>>> --- a/include/linux/riscv_sse.h
>>> +++ b/include/linux/riscv_sse.h
>>> @@ -8,6 +8,7 @@
>>>
>>>  #include <linux/types.h>
>>>  #include <linux/linkage.h>
>>> +#include <asm/sbi.h>
>>>
>>>  struct sse_event;
>>>  struct pt_regs;
>>> @@ -16,6 +17,11 @@ struct ghes;
>>>
>>>  typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);
>>>
>>> +static inline bool sse_event_is_global(u32 evt)
>>> +{
>>> +       return !!(evt & SBI_SSE_EVENT_GLOBAL);
>>> +}
>>> +
>>>  #ifdef CONFIG_RISCV_SSE
>>>
>>>  struct sse_event *sse_event_register(u32 event_num, u32 priority,
>>


