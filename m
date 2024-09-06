Return-Path: <linux-kernel+bounces-318129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE8C96E8C5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB361F24E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2D5B216;
	Fri,  6 Sep 2024 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+CuUUfV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19745C1C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598389; cv=none; b=Dr3KTKhq6/4r8MYi6RIAfGlGM4Nk+F+rzfvbEMer9lWNK7NHyrWcVEwO2Ro3oirfZNFtKJ1KakW6YkGA0LZwbdtF+TpBQEMktnxAALG3g7Eh+9hVZA5pMVreKrCrl/OYitEwXTT12+ga7r1SiXYFf8kp67LUKPOjKW47DKwVhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598389; c=relaxed/simple;
	bh=ri54wwBhp8kr+j4vYBR/bLkN8NN09cMLtwwjKStsmcI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bnVxxMGXtpiDuIui8B4CEFf7cKBpKf9oaD1jYfRZfDUpXrsZeCvDhFBLXAZw5fiZDK1XMpDZwWQzvDGH7IO2Y16AX1iYgGqginTOMkqUIYi1E2a2EgbrLunOA3idvkrmKE6hbpAxTBF9VcGNqvN9/QL6BivsszjCS0G/4PF5eaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+CuUUfV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725598386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J2kNACofGpp46UqPlJuilTLGvadhsvSn/zlAh4yxEw=;
	b=K+CuUUfVl/b3yE5JEx924w1aTuUgj5Q5n5HDiXq9D9g4rrdYPm7AcWXmDhzZH39yP75ihB
	6TX17K2Op8Us2MuzfKCvpDKXqyO1hDhO4LwUDSDovnceCeOwTxAiw0lvBj1uBL7lIuXaSt
	JLDb/Qv9AlQRaMK5K3Vh4yNSGc9mjHk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-Z2gKZEz-N0278DLzc4uMtw-1; Fri, 06 Sep 2024 00:52:24 -0400
X-MC-Unique: Z2gKZEz-N0278DLzc4uMtw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so2150418a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725598344; x=1726203144;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1J2kNACofGpp46UqPlJuilTLGvadhsvSn/zlAh4yxEw=;
        b=DqGBpVxIEGioFZYYT5pSQkZZQtgFzI+J21s3J/3riNwyX9Vluc96/SRVf/xhZOlIED
         CJULFTnTAVYNw4H/jwM8qW0Z6QtvFENKd/UEZKmcgnoqks4QxcjIsDzElD7dso6Xb/7W
         qTdEuXWDBYwlpFs/nkQpZK1tv5J1LNd/E6MDyprOxOmwYO7ZmqXqiwdZ2iVkDbskyjKZ
         ctDCZWi443vDroUpmYMmhCWpEqWqtqVgmNAPVeojO5OCamEPseLzA1OjFiIyebXy98Hl
         GTsEwctSqFB2mRwj3RkaOgIn7HYNO5CITpkETlHJJaNVlXKkKUw8D1a3P2VYv84SvOsg
         dkFA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1d2UFoWw+jEBwK+k45rdfEepZrhP44QPzRAgfOYgxfMAyBWtQS3Kwtb2WvrZvPD3VmeLaKgT2eY2Fjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkE3q2WVx1AD4k3QiZW4CLSgHZNv/39sWDrabELT4cGFWFLql
	4AzuBPweTHRob88UfCuJVaIXoNnLD2zgDMGVkmogHlcO7CMDHbRB3Tw4687eeZbBSTKiUlM6uDQ
	/QgRBitebiUwnDWDY3zZSD2QE+8UGkpj0omSE5gzivyWgWk9eWHZ3MjVqwchVpA==
X-Received: by 2002:a05:6a20:c78d:b0:1cc:b22d:979f with SMTP id adf61e73a8af0-1cce0ff23f1mr28977451637.4.1725598343665;
        Thu, 05 Sep 2024 21:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsg1ucq1kG/70b3qiN995/bUjXNEpn0pEGf0o/wEi9dhUji9ZRG/nkvE5r9ZW86C8B4SepfA==
X-Received: by 2002:a05:6a20:c78d:b0:1cc:b22d:979f with SMTP id adf61e73a8af0-1cce0ff23f1mr28977421637.4.1725598343060;
        Thu, 05 Sep 2024 21:52:23 -0700 (PDT)
Received: from [192.168.68.54] ([103.210.27.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc04d7a4sm480945a91.29.2024.09.05.21.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 21:52:21 -0700 (PDT)
Message-ID: <9df7db0e-649f-4d19-b1bc-c1919d3d8c4c@redhat.com>
Date: Fri, 6 Sep 2024 14:52:12 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/19] arm64: rsi: Add support for checking whether an
 MMIO is protected
From: Gavin Shan <gshan@redhat.com>
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun <alpergun@google.com>
References: <20240819131924.372366-1-steven.price@arm.com>
 <20240819131924.372366-8-steven.price@arm.com>
 <fe3da777-c6de-451d-8a8a-19fdda8e82e5@redhat.com>
Content-Language: en-US
In-Reply-To: <fe3da777-c6de-451d-8a8a-19fdda8e82e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 2:32 PM, Gavin Shan wrote:
> On 8/19/24 11:19 PM, Steven Price wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> On Arm CCA, with RMM-v1.0, all MMIO regions are shared. However, in
>> the future, an Arm CCA-v1.0 compliant guest may be run in a lesser
>> privileged partition in the Realm World (with Arm CCA-v1.1 Planes
>> feature). In this case, some of the MMIO regions may be emulated
>> by a higher privileged component in the Realm world, i.e, protected.
>>
>> Thus the guest must decide today, whether a given MMIO region is shared
>> vs Protected and create the stage1 mapping accordingly. On Arm CCA, this
>> detection is based on the "IPA State" (RIPAS == RIPAS_IO). Provide a
>> helper to run this check on a given range of MMIO.
>>
>> Also, provide a arm64 helper which may be hooked in by other solutions.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> New patch for v5
>> ---
>>   arch/arm64/include/asm/io.h       |  8 ++++++++
>>   arch/arm64/include/asm/rsi.h      |  3 +++
>>   arch/arm64/include/asm/rsi_cmds.h | 21 +++++++++++++++++++++
>>   arch/arm64/kernel/rsi.c           | 26 ++++++++++++++++++++++++++
>>   4 files changed, 58 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> index 1ada23a6ec19..a6c551c5e44e 100644
>> --- a/arch/arm64/include/asm/io.h
>> +++ b/arch/arm64/include/asm/io.h
>> @@ -17,6 +17,7 @@
>>   #include <asm/early_ioremap.h>
>>   #include <asm/alternative.h>
>>   #include <asm/cpufeature.h>
>> +#include <asm/rsi.h>
>>   /*
>>    * Generic IO read/write.  These perform native-endian accesses.
>> @@ -318,4 +319,11 @@ extern bool arch_memremap_can_ram_remap(resource_size_t offset, size_t size,
>>                       unsigned long flags);
>>   #define arch_memremap_can_ram_remap arch_memremap_can_ram_remap
>> +static inline bool arm64_is_iomem_private(phys_addr_t phys_addr, size_t size)
>> +{
>> +    if (unlikely(is_realm_world()))
>> +        return arm64_rsi_is_protected_mmio(phys_addr, size);
>> +    return false;
>> +}
>> +
>>   #endif    /* __ASM_IO_H */
>> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
>> index 2bc013badbc3..e31231b50b6a 100644
>> --- a/arch/arm64/include/asm/rsi.h
>> +++ b/arch/arm64/include/asm/rsi.h
>> @@ -13,6 +13,9 @@ DECLARE_STATIC_KEY_FALSE(rsi_present);
>>   void __init arm64_rsi_init(void);
>>   void __init arm64_rsi_setup_memory(void);
>> +
>> +bool arm64_rsi_is_protected_mmio(phys_addr_t base, size_t size);
>> +
>>   static inline bool is_realm_world(void)
>>   {
>>       return static_branch_unlikely(&rsi_present);
>> diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
>> index 968b03f4e703..c2363f36d167 100644
>> --- a/arch/arm64/include/asm/rsi_cmds.h
>> +++ b/arch/arm64/include/asm/rsi_cmds.h
>> @@ -45,6 +45,27 @@ static inline unsigned long rsi_get_realm_config(struct realm_config *cfg)
>>       return res.a0;
>>   }
>> +static inline unsigned long rsi_ipa_state_get(phys_addr_t start,
>> +                          phys_addr_t end,
>> +                          enum ripas *state,
>> +                          phys_addr_t *top)
>> +{
>> +    struct arm_smccc_res res;
>> +
>> +    arm_smccc_smc(SMC_RSI_IPA_STATE_GET,
>> +              start, end, 0, 0, 0, 0, 0,
>> +              &res);
>> +
>> +    if (res.a0 == RSI_SUCCESS) {
>> +        if (top)
>> +            *top = res.a1;
>> +        if (state)
>> +            *state = res.a2;
>> +    }
>> +
>> +    return res.a0;
>> +}
>> +
>>   static inline unsigned long rsi_set_addr_range_state(phys_addr_t start,
>>                                phys_addr_t end,
>>                                enum ripas state,
>> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
>> index e968a5c9929e..381a5b9a5333 100644
>> --- a/arch/arm64/kernel/rsi.c
>> +++ b/arch/arm64/kernel/rsi.c
>> @@ -67,6 +67,32 @@ void __init arm64_rsi_setup_memory(void)
>>       }
>>   }
>> +bool arm64_rsi_is_protected_mmio(phys_addr_t base, size_t size)
>> +{
>> +    enum ripas ripas;
>> +    phys_addr_t end, top;
>> +
>> +    /* Overflow ? */
>> +    if (WARN_ON(base + size < base))
>> +        return false;
>> +
>> +    end = ALIGN(base + size, RSI_GRANULE_SIZE);
>> +    base = ALIGN_DOWN(base, RSI_GRANULE_SIZE);
>> +
>> +    while (base < end) {
>> +        if (WARN_ON(rsi_ipa_state_get(base, end, &ripas, &top)))
>> +            break;
>> +        if (WARN_ON(top <= base))
>> +            break;
>> +        if (ripas != RSI_RIPAS_IO)
>> +            break;
>> +        base = top;
>> +    }
>> +
>> +    return (size && base >= end);
>> +}
> 
> The unexpected calltrace is continuously observed with host/v4, guest/v5 and
> latest upstream tf-rmm on 'WARN_ON(top <= base)' because @top is never updated
> by the latest tf-rmm. The following call path indicates how SMC_RSI_IPA_STATE_GET
> is handled by tf-rmm. I don't see RSI_RIPAS_IO is defined there and @top is
> updated.
> 
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm64/kernel/rsi.c:103 arm64_rsi_is_protected_mmio+0xf0/0x110
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.11.0-rc1-gavin-g3527d001084e #1
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : arm64_rsi_is_protected_mmio+0xf0/0x110
> [    0.000000] lr : arm64_rsi_is_protected_mmio+0x80/0x110
> [    0.000000] sp : ffffcd7097053bf0
> [    0.000000] x29: ffffcd7097053c30 x28: 0000000000000000 x27: 0000000000000000
> [    0.000000] x26: 00000000000003d0 x25: 00000000ffffff8e x24: ffffcd7096831bd0
> [    0.000000] x23: ffffcd7097053c08 x22: 00000000c4000198 x21: 0000000000001000
> [    0.000000] x20: 0000000001001000 x19: 0000000001000000 x18: 0000000000000002
> [    0.000000] x17: 0000000000000000 x16: 0000000000000010 x15: 0001000080000000
> [    0.000000] x14: 0068000000000703 x13: ffffffffff5fe000 x12: ffffcd7097053ba4
> [    0.000000] x11: 00000000000003d0 x10: ffffcd7097053bc4 x9 : 0000000000000444
> [    0.000000] x8 : ffffffffff5fe000 x7 : 0000000000000000 x6 : 0000000000000000
> [    0.000000] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> [    0.000000] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    0.000000] Call trace:
> [    0.000000]  arm64_rsi_is_protected_mmio+0xf0/0x110
> [    0.000000]  set_fixmap_io+0x8c/0xd0
> [    0.000000]  of_setup_earlycon+0xa0/0x294
> [    0.000000]  early_init_dt_scan_chosen_stdout+0x104/0x1dc
> [    0.000000]  acpi_boot_table_init+0x1a4/0x2d8
> [    0.000000]  setup_arch+0x240/0x610
> [    0.000000]  start_kernel+0x6c/0x708
> [    0.000000]  __primary_switched+0x80/0x88
> 

I have local changes like below to avoid the unexpected calltrace.

diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
index 9cb3353e5cbf..3d132d45fd83 100644
--- a/arch/arm64/kernel/rsi.c
+++ b/arch/arm64/kernel/rsi.c
@@ -100,14 +100,15 @@ bool arm64_rsi_is_protected_mmio(phys_addr_t base, size_t size)
         while (base < end) {
                 if (WARN_ON(rsi_ipa_state_get(base, end, &ripas, &top)))
                         break;
-               if (WARN_ON(top <= base))
+               if (WARN_ON(top && top <= base))
                         break;
                 if (ripas != RSI_RIPAS_IO)
                         break;
-               base = top;
+
+               base = top ? top : end;
         }
  
-       return (size && base >= end);
+       return base >= end;

Thanks,
Gavin


