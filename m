Return-Path: <linux-kernel+bounces-213706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4FA907901
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC4B286F38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92E149C47;
	Thu, 13 Jun 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Uk2tRYUZ"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6226AF0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297999; cv=none; b=ekfepID92Eii5j1ZFCixJd3INkmq10p4qsFwHhVtkISj9sRpy1ombEKe8ykjquJM8Pmw7xWEp6KKHVhdN2QxD8qNEEjktEemG097bvlQFLJewtEmCZ42UzqlQR30RtA7FGiTSsZD0Qik76papQsYmK9MdpB7DJ6b2S9C3Ta0YmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297999; c=relaxed/simple;
	bh=aPURT8O1M/SRbb3l7N8iGkMIR73SsXOdVvG94mX2fYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRX6E5qTV+k1w/wCkxE8fW+yuxjpv86cC0ny4GMO+C5ciaZVp0nCoc5k1xVzSFiXCnE2DU/Rn/xsF4hA5RnCIAG5qTpXaM11eF4GQmIQrjN8ct2Ws5VBge6ewZKxIUFQlaVz0r+VPfRyaKyWwGrNVZ4qevMSfTaLgiUMNW13y0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Uk2tRYUZ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7eb75c0d0a7so41820539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718297997; x=1718902797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCGT1G5c+EZwzbvL6QH+mOF0nck68vF2oKoSs0AcMhs=;
        b=Uk2tRYUZnVXU+dvKPfX566QCuIUrAYKFJV02zJPM3Q+1uu02O0PypsGEEDpbCDk6WI
         1DAme79BrMgfkzQx5kQ7PL9SvDkP+zTUZZ4aFYOCOPDZWshqsFYOecq6Zywq+UbZVw6a
         DxYRe+anYeoSWA/VYdzpHPW4NsO7ySbu6rPWISuyc2MY1diL8Z5JpOsYSTPb5mIB5M3b
         i80mik2v7zuynZ08VTL0zIy6P71C1zxNMVEh93UdfS1h5PCmKNJ7uvRjuCSEljWVtPnx
         LT92wAJRuEkPKWdfeTdhimtjNcM4tE+PaE39pEN1xbebYkGzV9DKvaotQ60JNW93UiLm
         uaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297997; x=1718902797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCGT1G5c+EZwzbvL6QH+mOF0nck68vF2oKoSs0AcMhs=;
        b=GPCCg+fqB4hYvRwc0wr8+KV8kXMbMTFf3p8PWo9Mwik2Kb7VKnnIKsEeSHMItkkluJ
         uoGboYIJVKCQHiQhOv1cRUDV2XEcdb5iIkmPgui0L61UnUZKurdqsCZd7Ef9RH0U+AwA
         0PH4JwFtgtgmjewGGAzMrBIH3XIe3cQdpbRrYXDv3C6AZuI8SQfv34ddAynbXFwekVf6
         iF1Z8/eG0Ro/HW0endaR+mzPnYvWYr6l1mv5SzZrXEyQyo7ITnsgyXBECDab9nfQH82g
         7i+SyMJwOZCIyrvjMLV1lpKoniAPBJsJ24QTqTdISKmn6LadR0WOrSCPQ5agXZ9UX86v
         PwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpEaPiObpJREFV/IKiVLFqPsmdo2FUJglpb539SdiTQtNsVoHadjJnQQwQxhGANSyX9M84vi8ncjiSqgWVuWlPSdeYzzKzv+DM6b8W
X-Gm-Message-State: AOJu0YyNi+YbDZD8jzex140fkflIk1GYCTBM0b4eU8nu94TNS+Gvf6fD
	bfePpdquxN8g/2wDs6xsouAQ3l79QiPiti5tfUokXpHTD9/ou50U3i+fC7GOk+rEgaErRuTsZe4
	e
X-Google-Smtp-Source: AGHT+IFpgRITYAvTReAUcbPjuR+2tcKYTAy7JUib7uknhSLvituuWoFpdavFlwghfs5OiLKEcbfCqw==
X-Received: by 2002:a05:6602:2dd1:b0:7eb:7f2e:5b33 with SMTP id ca18e2360f4ac-7ebeb4977c1mr9767039f.4.1718297997328;
        Thu, 13 Jun 2024 09:59:57 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9568dfb15sm452953173.18.2024.06.13.09.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:59:56 -0700 (PDT)
Message-ID: <d8575593-588d-406e-bcd3-eaec93e43e2c@sifive.com>
Date: Thu, 13 Jun 2024 11:59:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] riscv: Add support for per-thread envcfg CSR values
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240605205658.184399-1-samuel.holland@sifive.com>
 <20240605205658.184399-3-samuel.holland@sifive.com>
 <ZmOCpF5ACdQiSfcm@debug.ba.rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZmOCpF5ACdQiSfcm@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Deepak,

On 2024-06-07 4:59 PM, Deepak Gupta wrote:
> On Wed, Jun 05, 2024 at 01:56:46PM -0700, Samuel Holland wrote:
>> Some bits in the [ms]envcfg CSR, such as the CFI state and pointer
>> masking mode, need to be controlled on a per-thread basis. Support this
>> by keeping a copy of the CSR value in struct thread_struct and writing
>> it during context switches. It is safe to discard the old CSR value
>> during the context switch because the CSR is modified only by software,
>> so the CSR will remain in sync with the copy in thread_struct.
>>
>> Use ALTERNATIVE directly instead of riscv_has_extension_unlikely() to
>> minimize branchiness in the context switching code.
>>
>> Since thread_struct is copied during fork(), setting the value for the
>> init task sets the default value for all other threads.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>> arch/riscv/include/asm/processor.h | 1 +
>> arch/riscv/include/asm/switch_to.h | 8 ++++++++
>> arch/riscv/kernel/cpufeature.c     | 2 +-
>> 3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/processor.h
>> b/arch/riscv/include/asm/processor.h
>> index 68c3432dc6ea..0838922bd1c8 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -118,6 +118,7 @@ struct thread_struct {
>>     unsigned long s[12];    /* s[0]: frame pointer */
>>     struct __riscv_d_ext_state fstate;
>>     unsigned long bad_cause;
>> +    unsigned long envcfg;
>>     u32 riscv_v_flags;
>>     u32 vstate_ctrl;
>>     struct __riscv_v_ext_state vstate;
>> diff --git a/arch/riscv/include/asm/switch_to.h
>> b/arch/riscv/include/asm/switch_to.h
>> index 7594df37cc9f..9685cd85e57c 100644
>> --- a/arch/riscv/include/asm/switch_to.h
>> +++ b/arch/riscv/include/asm/switch_to.h
>> @@ -70,6 +70,13 @@ static __always_inline bool has_fpu(void) { return false; }
>> #define __switch_to_fpu(__prev, __next) do { } while (0)
>> #endif
>>
>> +static inline void __switch_to_envcfg(struct task_struct *next)
>> +{
>> +    asm volatile (ALTERNATIVE("nop", "csrw " __stringify(CSR_ENVCFG) ", %0",
>> +                  0, RISCV_ISA_EXT_XLINUXENVCFG, 1)
>> +            :: "r" (next->thread.envcfg) : "memory");
>> +}
>> +
>> extern struct task_struct *__switch_to(struct task_struct *,
>>                        struct task_struct *);
>>
>> @@ -103,6 +110,7 @@ do {                            \
>>         __switch_to_vector(__prev, __next);    \
>>     if (switch_to_should_flush_icache(__next))    \
>>         local_flush_icache_all();        \
>> +    __switch_to_envcfg(__next);            \
>>     ((last) = __switch_to(__prev, __next));        \
>> } while (0)
> 
> Suggestion:
> Probably make this patch 1
> 
>>
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 2879e26dbcd8..1153b96346ae 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -728,7 +728,7 @@ unsigned long riscv_get_elf_hwcap(void)
>> void riscv_user_isa_enable(void)
>> {
>>     if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>> -        csr_set(CSR_ENVCFG, ENVCFG_CBZE);
>> +        current->thread.envcfg |= ENVCFG_CBZE;
> 
> Suggestion:
> Squash this with current patch 1 and call it patch 2.

This reorganization doesn't work. If I add __switch_to_envcfg() first without
this change, then the CSR would get zeroed out during the first context switch,
so userspace cbo.zero would be broken after the first patch.

Regards,
Samuel

>>     else if (any_cpu_has_zicboz)
>>         pr_warn_once("Zicboz disabled as it is unavailable on some harts\n");
>> }
>> -- 
>> 2.44.1
>>


