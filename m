Return-Path: <linux-kernel+bounces-569289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E503A6A101
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEB37AD9CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527FB1F4179;
	Thu, 20 Mar 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uC39ZvSY"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5731DF248
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458572; cv=none; b=gxrEY7bfsw1fH4ip4MTBt2QCCKrMu2T1uK4G+l7AXZx3genB5LCITWomaOwB4XXA2lmIcEhRB9wGbv4gDYYfpIo4OJB66znxQP10ZzXDaIsUICUPkwUHDqVM6woRMisL9J3d9K4ntJxoOWCtHgkimbOsreJ4mfcRAr1jP1OSGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458572; c=relaxed/simple;
	bh=J9ceOGtoVxRQ2f0m0UJNvDgHvszsBAF00SVyWyu/cLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThlC7Mxk4hYTZkCuDhE+i89KaHp/uh4U/oZImpDcu6FRNV1AMZtzNnf5/JJPXgxfOjgDL4v8oWVBkQ1dV7/zx5Mi5psBe7MGMi6eO5WrUzF2sysUobFyAPtNwcIOSOVbMyneHQ2VKWhtheSA3UslGKpvIIMl7fgEPdV2OInEl7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uC39ZvSY; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so3398805e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742458569; x=1743063369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1X6HiCNhqQpbU8h+HCa0tdn7ioFvop7dl7Gz/vECDs=;
        b=uC39ZvSY1NpxTR/qg3Jw2yHlslNrqdZfWT2AmpOPrN02xat1lQhVPLp1C9i2dcegud
         mTPYlYdJx4f0WKkYVzrVHEo6dCxPAtu2lhigPDEQvg/nwvReQ3PE3beLNnbxk/QpH4qm
         S/PvpEKy3jCDCWHOcoLVLcS1COwwMSQAPzkw/7ylWJpUWGzN9fzMPUjJD/8S6GQOYuy/
         Onl0ykEcwj0VBJ4pVWHPtjATp6xw2t4bmzyPyomuIBuvE+eXlL6IfMbMGcMkOzCyl5mK
         4vclsuJ9Mu6QH75cMhZBZkEfElg/Xn9Z7MhMuWoQge3UTsjB0G6fpg6XYBbe1c2aVQbN
         A5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458569; x=1743063369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1X6HiCNhqQpbU8h+HCa0tdn7ioFvop7dl7Gz/vECDs=;
        b=YBRFVxj0zRY0KM82eOXm4i4/Xy0OE+s2zlwIvuIf2PnDbIn5NKMN1jNuboX2zXAugT
         qdmXid2RUnT+uAa7rw01rH2kYwaSzj8QQxiQKa/WjppmlfeAFbOnwQcWA7lQp8m3ziZG
         KDrcRgFgnivkLoHq3EWj/Z4Z380+76z2q96kr3hbByR3fLzrS4Ak+G1+XUeKqZJ+K6DZ
         wXyavUP5NMPn2CKA7Ey0NHHMX0NtGmmsTEqwqC7EduCgPrLSbyAa/c0gGMHH1OJZW2A7
         +ChbHzxI3rSlV2Mm5TVJR8mMJYUZGcPwmOss2iNPeNERcV5UNfTzWDNyuxnuPCNwbpBU
         VB0g==
X-Forwarded-Encrypted: i=1; AJvYcCX0vlzhNqzth0Vize6jiqxAY4MI4+9CaXv1cXsHzeVNa7T6nvghuj3wXoZS76mDFYofd1U6geUQCpNsY4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLcRy14MgxjvA2CHPZq5t5i2C2XsRTXlU1wIVMrdfbJUQbaW7
	LS0SJTfYeLRB0InIW2+6uDAuDW8AQYLqfjPGFwp3rVExRH0g44vsp7Y2By396z4=
X-Gm-Gg: ASbGncusHSvt/GLx8SLEexrnw0lQcpN0dheN1kVqoy4dOllzvLEbtcXUQ8SF56MALjX
	eMma0hnL0hKShG69lU0Gnh9DBJDb62mblzGx1diALDb1aFtCbi/5J3ye5/RtbVsvBJi5zs2Jmwz
	RvwllB1r49K/4ILHts3ftSaqLj4tcnmngO622RWNddHUHqPTTRc26URUAM5qTcGxs2RMff3jbrF
	kCbccCtWLMOTuMNrEoSsosij4KwLgcnRMNla9G+4cgHlbebphJx3Ik4JLxYgIfHiOrF9AO60Nn9
	QdQXQDdZ/uPHUSYd5f8ix6cWlxknZY2zmS9gn8h/3gbXsMEm8368Ab2xdU0mGmAvXyzgm9lSyaJ
	rlvv73JtsxCx1TLACcuWwLa2f
X-Google-Smtp-Source: AGHT+IHYWdVATok5OeQt7CfFPf3qhSrzissvd7+Tw9VxEB8HsbKeIOWAY9VTxxUIqbY9hRBee5DGgw==
X-Received: by 2002:a05:600c:1e0b:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-43d437a9655mr50996955e9.13.1742458568551;
        Thu, 20 Mar 2025 01:16:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39973c9d93bsm4176927f8f.65.2025.03.20.01.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 01:16:08 -0700 (PDT)
Message-ID: <b3fbd730-295f-4491-b0d6-d4e258941ae5@rivosinc.com>
Date: Thu, 20 Mar 2025 09:16:07 +0100
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
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250319-46b625cf8b771616d4c7c053@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/03/2025 18:08, Andrew Jones wrote:
> On Fri, Dec 06, 2024 at 05:30:58PM +0100, Clément Léger wrote:
> ...
>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cpu)
>> +{
>> +	void *stack;
>> +
>> +	arch_evt->evt_id = evt_id;
>> +	stack = sse_stack_alloc(cpu, SSE_STACK_SIZE);
>> +	if (!stack)
>> +		return -ENOMEM;
>> +
>> +	arch_evt->stack = stack + SSE_STACK_SIZE;
>> +
>> +	if (sse_init_scs(cpu, arch_evt))
>> +		goto free_stack;
>> +
>> +	if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
>> +		arch_evt->interrupted_state_phys =
>> +				per_cpu_ptr_to_phys(&arch_evt->interrupted);
>> +	} else {
>> +		arch_evt->interrupted_state_phys =
>> +				virt_to_phys(&arch_evt->interrupted);
>> +	}
>> +
>> +	return 0;
> 
> Hi Clément,
> 
> Testing SSE support with tools/testing/selftests/kvm/riscv/sbi_pmu_test
> led to an opensbi sbi_trap_error because the output_phys_lo address passed
> to sbi_sse_read_attrs() wasn't a physical address. The reason is that
> is_kernel_percpu_address() can only be used on static percpu addresses,
> but local sse events get their percpu addresses with alloc_percpu(), so
> is_kernel_percpu_address() was returning false even for local events. I
> made the following changes to get things working.

Hi Andrew,

Did something changed recently ? Because I tested that when it was send
(PMU + some kernel internal testsuite) and didn't saw that. Anyway, I'll
respin it with your changes as well.

Thanks !

Clément

> 
> Thanks,
> drew
> 
> diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
> index b48ae69dad8d..f46893946086 100644
> --- a/arch/riscv/kernel/sse.c
> +++ b/arch/riscv/kernel/sse.c
> @@ -100,12 +100,12 @@ int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cp
>         if (sse_init_scs(cpu, arch_evt))
>                 goto free_stack;
> 
> -       if (is_kernel_percpu_address((unsigned long)&arch_evt->interrupted)) {
> +       if (sse_event_is_global(evt_id)) {
>                 arch_evt->interrupted_state_phys =
> -                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
> +                               virt_to_phys(&arch_evt->interrupted);
>         } else {
>                 arch_evt->interrupted_state_phys =
> -                               virt_to_phys(&arch_evt->interrupted);
> +                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
>         }
> 
>         return 0;
> diff --git a/drivers/firmware/riscv/riscv_sse.c b/drivers/firmware/riscv/riscv_sse.c
> index 511db9ad7a9e..fef375046f75 100644
> --- a/drivers/firmware/riscv/riscv_sse.c
> +++ b/drivers/firmware/riscv/riscv_sse.c
> @@ -62,11 +62,6 @@ void sse_handle_event(struct sse_event_arch_data *arch_event,
>                         ret);
>  }
> 
> -static bool sse_event_is_global(u32 evt)
> -{
> -       return !!(evt & SBI_SSE_EVENT_GLOBAL);
> -}
> -
>  static
>  struct sse_event *sse_event_get(u32 evt)
>  {
> diff --git a/include/linux/riscv_sse.h b/include/linux/riscv_sse.h
> index 16700677f1e8..06b757b036b0 100644
> --- a/include/linux/riscv_sse.h
> +++ b/include/linux/riscv_sse.h
> @@ -8,6 +8,7 @@
> 
>  #include <linux/types.h>
>  #include <linux/linkage.h>
> +#include <asm/sbi.h>
> 
>  struct sse_event;
>  struct pt_regs;
> @@ -16,6 +17,11 @@ struct ghes;
> 
>  typedef int (sse_event_handler)(u32 event_num, void *arg, struct pt_regs *regs);
> 
> +static inline bool sse_event_is_global(u32 evt)
> +{
> +       return !!(evt & SBI_SSE_EVENT_GLOBAL);
> +}
> +
>  #ifdef CONFIG_RISCV_SSE
> 
>  struct sse_event *sse_event_register(u32 event_num, u32 priority,


