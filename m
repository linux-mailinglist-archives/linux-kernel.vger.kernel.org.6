Return-Path: <linux-kernel+bounces-300897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B695EA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF049B209D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555DB12C80F;
	Mon, 26 Aug 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RoARceJV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CAD85260
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656813; cv=none; b=BwTfwPk95m7ggHys3qNkFTLFAJoBgvC8qxmU9/YVbeTkx4Fx7Qe9L1rRYwHCQGRxHY5EkM+RCmsJTYTs4sSwP/dZlHBvkG7pcTq+tlAgd/XKWWOm1NBebHU4et/+36E03OJNvTZ2bV8UTrZMJSJyjdBl02hesm7zzZMnjNqfHCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656813; c=relaxed/simple;
	bh=T1336E7cVpUCrR3+tpvcbqJ7mz1A0cXcYu7auU083T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWlL9hVN5nAk8qIDZH1Tb3jsqvGXhkx9xs1dUS0LpAqB2FcajLFrNWmOiuT4rqH8oEy1ay0gpOUX7RubBEwGnmblRBzw+wv4cWq9Oq08yFdoODCRdjn5T5KfPyaVDP67EaBOhwTreAgFxYy5xEkMozRZ3CsNgd/kJYIP3P75rY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RoARceJV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-428e3129851so35481385e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724656808; x=1725261608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9f/Uu+DkKJiET7sozQNTkmkP72NpT2vE2dSLgjRAD1A=;
        b=RoARceJVqB+pcPRI3CQdcPffcAMaPwcyVPeI+WKrzXaLllhVsaYyGDqQXXuz+Q44i9
         sP4PbkO+6wY69bU5WYn0laTelzEPDkebQf0x3EdnD6QyX2x6Y6YQ2D59TbZJtBDI0WGl
         JJMmMAixKUG+TlNFKkrId3XKic6KgpmLAeo8qQmA7b3ndYtwA8+Qia3dkZLLYtO4VYQq
         YMwHvyvFpvwjVox1E5kAAY+e2KqZhFfXEqfNE9zsoIr/Hr+MzN6X8eQsGgeM8t4Usrm/
         68gDxnz1+riBtjwqAwhlJct06p3M6nTmP2PUhHVujfHCZmT+CnSzokTW7NvXMnQBZAfl
         SbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724656808; x=1725261608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9f/Uu+DkKJiET7sozQNTkmkP72NpT2vE2dSLgjRAD1A=;
        b=eaPYoIO190iDVCPqaWv4j1hj957URib1suODcdTbyiwGpTdtwPWQdP1VvXEHyR4Qii
         JPEhb1Fsqr4dV3ZJctqzzWaxKqJim16DiM4tyFdJUNHoiDv063B/pQaRaOBNF+tFX0VI
         FR/EEHueGRLMMV2X4UurVYc/CUk9Fogsr+8Mr5VN+fB2T0wl8PryrVKtNKSYrkDfS8fz
         cWg1DHMA7QksQvV6FCAe6VMSZWjIzfdU0U4kDjXnWuGrdbJFNk7KT1sO7pbUIMcsA2dl
         HnZ669Rc/mq5V8gl3w5HJnv67YALAZt0vMTE042FBrfzaNCiNXaay/kkB3TYzXV7+7i1
         buhg==
X-Forwarded-Encrypted: i=1; AJvYcCVGxG0gJkuuB/d6EBcQyyRVSXeBgpCHSFZu3Utmn0duu2SBXEDrW903wJlwy72+Gi8n5P8TH96E8XTzJrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfs164oND2rd/LtIOYqpJVMtfSMjk5UUQjEJe/md5dGXuCGiWC
	hNylnM3Me+ibem6I2/MdYjtdDHH/xqxLqRc1h9qSbWb3vJD3sQoz3aR1eosmX9tKwTPjJpHdS+P
	xcY4=
X-Google-Smtp-Source: AGHT+IGGKWMJKcRV71NJLebmInIF+DDQiEwfWQ1N+2q9OU+9Oj1IF/Kfj5SxvQ6tTCRtfASJOtVWOw==
X-Received: by 2002:adf:e50c:0:b0:368:6598:131e with SMTP id ffacd0b85a97d-373118d228amr6056072f8f.38.1724656808090;
        Mon, 26 Aug 2024 00:20:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5159555sm143096845e9.18.2024.08.26.00.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 00:20:07 -0700 (PDT)
Message-ID: <5042c5ca-137c-4639-bd1a-12c836deabd0@rivosinc.com>
Date: Mon, 26 Aug 2024 09:20:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Fix MASK_VAL() usage
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20240715153336.3720653-1-cleger@rivosinc.com>
 <CAJZ5v0g5eAxJiiC6hY3BLKcuTyG1sZxgV5g=Zx4xu02UFfuwMA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAJZ5v0g5eAxJiiC6hY3BLKcuTyG1sZxgV5g=Zx4xu02UFfuwMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 02/08/2024 17:13, Rafael J. Wysocki wrote:
> On Mon, Jul 15, 2024 at 5:33 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> MASK_VAL() was added a way to handle bit_offset and bit_width for
>> registers located in system memory address space. However, while suited
>> for reading, it does not work for writing and result in corrupted
>> registers when writing values with bit_offset > 0. Moreover, when a
>> register is collocated with another one at the same address but with a
>> different mask, the current code results in the other registers being
>> overwritten with 0s. The write procedure for SYSTEM_MEMORY registers
>> should actually read the value, mask it, update it and write it with the
>> updated value. Moreover, since registers can be located in the same
>> word, we must take care of locking the access before doing it. We should
>> potentially use a global lock since we don't know in if register
>> addresses aren't shared with another _CPC package but better not
>> encourage vendors to do so. Assume that registers can use the same word
>> inside a _CPC package and thus, use a per _CPC package lock.
>>
>> Fixes: 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>  drivers/acpi/cppc_acpi.c | 44 ++++++++++++++++++++++++++++++++++++----
>>  include/acpi/cppc_acpi.h |  2 ++
>>  2 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 1d857978f5f4..2e99cf1842ee 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -170,8 +170,11 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>>  #define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_width - 1)) : (reg)->bit_width)
>>
>>  /* Shift and apply the mask for CPC reads/writes */
>> -#define MASK_VAL(reg, val) (((val) >> (reg)->bit_offset) &                     \
>> +#define MASK_VAL_READ(reg, val) (((val) >> (reg)->bit_offset) &                                \
>>                                         GENMASK(((reg)->bit_width) - 1, 0))
>> +#define MASK_VAL_WRITE(reg, prev_val, val)                                             \
>> +       ((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |          \
>> +       ((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))      \
>>
>>  static ssize_t show_feedback_ctrs(struct kobject *kobj,
>>                 struct kobj_attribute *attr, char *buf)
>> @@ -857,6 +860,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>>
>>         /* Store CPU Logical ID */
>>         cpc_ptr->cpu_id = pr->id;
>> +       spin_lock_init(&cpc_ptr->rmw_lock);
>>
>>         /* Parse PSD data for this CPU */
>>         ret = acpi_get_psd(cpc_ptr, handle);
>> @@ -1062,7 +1066,7 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>>         }
>>
>>         if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>> -               *val = MASK_VAL(reg, *val);
>> +               *val = MASK_VAL_READ(reg, *val);
>>
>>         return 0;
>>  }
>> @@ -1071,9 +1075,11 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>  {
>>         int ret_val = 0;
>>         int size;
>> +       u64 prev_val;
>>         void __iomem *vaddr = NULL;
>>         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>>         struct cpc_reg *reg = &reg_res->cpc_entry.reg;
>> +       struct cpc_desc *cpc_desc;
>>
>>         size = GET_BIT_WIDTH(reg);
>>
>> @@ -1106,8 +1112,34 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>                 return acpi_os_write_memory((acpi_physical_address)reg->address,
>>                                 val, size);
>>
>> -       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>> -               val = MASK_VAL(reg, val);
>> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> +               cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +               if (!cpc_desc) {
>> +                       pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +                       return -ENODEV;
>> +               }
>> +
>> +               spin_lock(&cpc_desc->rmw_lock);
>> +               switch (size) {
>> +               case 8:
>> +                       prev_val = readb_relaxed(vaddr);
>> +                       break;
>> +               case 16:
>> +                       prev_val = readw_relaxed(vaddr);
>> +                       break;
>> +               case 32:
>> +                       prev_val = readl_relaxed(vaddr);
>> +                       break;
>> +               case 64:
>> +                       prev_val = readq_relaxed(vaddr);
>> +                       break;
>> +               default:
>> +                       ret_val = -EFAULT;
>> +                       goto out_unlock;
> 
> I would do
> 
>                       spin_unlock(&cpc_desc->rmw_lock);
>                       return -EFAUL;
> 
> here to avoid the check below which is redundant in this path and the
> label would not be necessary then.

Acked, I'll send a V2 with these modifications.

Thanks,

Clément

> 
> LGTM otherwise.
> 
>> +               };
>> +               val = MASK_VAL_WRITE(reg, prev_val, val);
>> +               val |= prev_val;
>> +       }
>>
>>         switch (size) {
>>         case 8:
>> @@ -1134,6 +1166,10 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>>                 break;
>>         }
>>
>> +out_unlock:
>> +       if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
>> +               spin_unlock(&cpc_desc->rmw_lock);
>> +
>>         return ret_val;
>>  }
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 930b6afba6f4..e1720d930666 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -64,6 +64,8 @@ struct cpc_desc {
>>         int cpu_id;
>>         int write_cmd_status;
>>         int write_cmd_id;
>> +       /* Lock used for RMW operations in cpc_write() */
>> +       spinlock_t rmw_lock;
>>         struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>>         struct acpi_psd_package domain_info;
>>         struct kobject kobj;
>> --
>> 2.45.2
>>

