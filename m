Return-Path: <linux-kernel+bounces-368528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C89A10F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AEF1F21DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC219210C39;
	Wed, 16 Oct 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IhJc8yRA"
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6271F18BC23
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101041; cv=none; b=hcpW61ezgUwHJNbEKbdg40xOTDH6V7cMjQ3rE/oPiMequyE8vzsVz/PtiC5+6cyhb4PajaJDFH+9OxW4btizhznAyNIMKaMxtPlH0L5p+WVigGbuNnhkEBwPLOOUXkKmAWWU5FZfmiuIHgNv2VGLdWPkuEeMo6aV7hlAJn2ih5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101041; c=relaxed/simple;
	bh=eg4hX38TdcUFO5o+WLkV7feOE8NhJ4jv5UMNtSrIzUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzN1h5HQhIaHpOmm3yBnIEeY3f/t7ETleqf5ZqnLJhs7HBIgWS7qjHocBz9GI3QVxQAU1k0hFXQfE0xN/IqtmKiG+O8VeQxWl9a5P0laFMqK/7Cs42FZZcM2D0D7OX85HVKBN00E31iFftJ54lfsZGDWJBv+atJEttYgLK2akyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IhJc8yRA; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-5e988c5813aso91928eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729101037; x=1729705837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCcgXYhcr1eYAzXAtgbojySY9FznxIOauj/4HQBvgNM=;
        b=IhJc8yRAx4Dpel48dgT30+xhaW6eL3RweqvSxRQm9aS7HvLe0kiHJzf7SugSovueGm
         g0E27Apv7XvDXDcQkofrms/LNqAJFvqmU1IgzibMrJTo37G7+IZ9f+Zn0bx9g+Xc8NuJ
         ueLjXYgm52WT67RXCAcQV3ftgOtUQo10Z5Xa/PWJ4xluKtjp2BVNu3DoymGjKlh1xDni
         cTMWJ5Xs/RoTOx/u9jBn+ukAE+BIn9/TjYUXsYW16Qj54mSY+MnKbQh52FlynJ0YZEmv
         VU9P2Rw+eeuGzgnq+JVyXgNG25xmGYmmD/oNHapXj7rHWpKI+v7h69ORSrXBtCeeQgiB
         WDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729101037; x=1729705837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCcgXYhcr1eYAzXAtgbojySY9FznxIOauj/4HQBvgNM=;
        b=lqCPEwAX64roruYmJ8vvah4AOk7ZdeSz5HYBc7tr1h3FkjCzdhFHQj0MfxJzvy/U7+
         xgZmL3lyVHkcUA9sEPlbV3IxLmxdbmLhK34Pq6HIsRvr7CWnbpaNCRUZ4m37DIfq0Q4A
         4w859jHiTroSlcW8j51f+gc3vpDSJvgns9MPHOrx430mH8Q9dPWomYjdce6WXCDFTj01
         aROTQ1bKgZ7ZZ6Y8KkAskpSnsgMiIv+TGefUNPexJbTWa9S39P+Zk2TXy0reHeR2m9jm
         Vws/FfmNu/kFlNuouHpp9u0I4xUSQd6pPcZrivEeIRZ4/kaCFECebsJnqsGTNHxgs24E
         ZEzA==
X-Forwarded-Encrypted: i=1; AJvYcCWExSb+2uO0UQxLAJeZN+km6Xa82GdHqVOesPVi+hoVL3fFh3plGXKHN7kt+R+VEBTG63SoXFl6cBL61zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdwbFgfUDdQskn0DR6SayR/Eu2oiCgItgkNFQ4r0AkrBF1BkM
	rR3LoSTIsqPacelaFKikc5xaYRj64ymxXT70w+RpY1Smm3qZEJ7r3Mz/Yau+IHU=
X-Google-Smtp-Source: AGHT+IEf67VIalr0j/WhSRDBXq34/L7p37bnPDz/zkchcrv8dP9aBwLxPOYp06Fr1fQrz3FrmybhpA==
X-Received: by 2002:a05:6820:2212:b0:5e7:cb2e:e01c with SMTP id 006d021491bc7-5eb1a2da0f0mr11488027eaf.7.1729101036963;
        Wed, 16 Oct 2024 10:50:36 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eb4edbcf06sm802586eaf.2.2024.10.16.10.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 10:50:36 -0700 (PDT)
Message-ID: <2e25597c-6278-4bc6-a0c2-3826841c2ac0@sifive.com>
Date: Wed, 16 Oct 2024 12:50:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] riscv: Allow ptrace control of the tagged
 address ABI
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
 Atish Patra <atishp@atishpatra.org>, Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
 <20240829010151.2813377-7-samuel.holland@sifive.com> <ZuOoqTfKs/7G075O@ghost>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZuOoqTfKs/7G075O@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Charlie,

On 2024-09-12 9:51 PM, Charlie Jenkins wrote:
> On Wed, Aug 28, 2024 at 06:01:28PM -0700, Samuel Holland wrote:
>> This allows a tracer to control the ABI of the tracee, as on arm64.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
> 
> Since this code is identical to the arm64 port, could it be extracted
> out into the generic ptrace.c and ifdef on either CONFIG_RISCV_ISA_SUPM
> or CONFIG_ARM64_TAGGED_ADDR_ABI by adding some generic flag like
> CONFIG_HAVE_ARCH_TAGGED_ADDR_ABI?

Yes, it could be factored out, though I don't know if it is worth the overhead
for these two trivial functions. I don't see any other code like this outside of
arch/.

Regards,
Samuel

>>
>> (no changes since v1)
>>
>>  arch/riscv/kernel/ptrace.c | 42 ++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/elf.h   |  1 +
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
>> index 92731ff8c79a..ea67e9fb7a58 100644
>> --- a/arch/riscv/kernel/ptrace.c
>> +++ b/arch/riscv/kernel/ptrace.c
>> @@ -28,6 +28,9 @@ enum riscv_regset {
>>  #ifdef CONFIG_RISCV_ISA_V
>>  	REGSET_V,
>>  #endif
>> +#ifdef CONFIG_RISCV_ISA_SUPM
>> +	REGSET_TAGGED_ADDR_CTRL,
>> +#endif
>>  };
>>  
>>  static int riscv_gpr_get(struct task_struct *target,
>> @@ -152,6 +155,35 @@ static int riscv_vr_set(struct task_struct *target,
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_RISCV_ISA_SUPM
>> +static int tagged_addr_ctrl_get(struct task_struct *target,
>> +				const struct user_regset *regset,
>> +				struct membuf to)
>> +{
>> +	long ctrl = get_tagged_addr_ctrl(target);
>> +
>> +	if (IS_ERR_VALUE(ctrl))
>> +		return ctrl;
>> +
>> +	return membuf_write(&to, &ctrl, sizeof(ctrl));
>> +}
>> +
>> +static int tagged_addr_ctrl_set(struct task_struct *target,
>> +				const struct user_regset *regset,
>> +				unsigned int pos, unsigned int count,
>> +				const void *kbuf, const void __user *ubuf)
>> +{
>> +	int ret;
>> +	long ctrl;
>> +
>> +	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl, 0, -1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return set_tagged_addr_ctrl(target, ctrl);
>> +}
>> +#endif
>> +
>>  static const struct user_regset riscv_user_regset[] = {
>>  	[REGSET_X] = {
>>  		.core_note_type = NT_PRSTATUS,
>> @@ -182,6 +214,16 @@ static const struct user_regset riscv_user_regset[] = {
>>  		.set = riscv_vr_set,
>>  	},
>>  #endif
>> +#ifdef CONFIG_RISCV_ISA_SUPM
>> +	[REGSET_TAGGED_ADDR_CTRL] = {
>> +		.core_note_type = NT_RISCV_TAGGED_ADDR_CTRL,
>> +		.n = 1,
>> +		.size = sizeof(long),
>> +		.align = sizeof(long),
>> +		.regset_get = tagged_addr_ctrl_get,
>> +		.set = tagged_addr_ctrl_set,
>> +	},
>> +#endif
>>  };
>>  
>>  static const struct user_regset_view riscv_user_native_view = {
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index b54b313bcf07..9a32532d7264 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -448,6 +448,7 @@ typedef struct elf64_shdr {
>>  #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
>>  #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
>>  #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
>> +#define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
>>  #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
>>  #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
>>  #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
>> -- 
>> 2.45.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv


