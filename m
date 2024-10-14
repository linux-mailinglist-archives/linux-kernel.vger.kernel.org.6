Return-Path: <linux-kernel+bounces-364078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9499CAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4C31C2096F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B91A76CF;
	Mon, 14 Oct 2024 13:01:53 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8EF19E806
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910912; cv=none; b=B8LDv/w82Sqd2FtLpce1euc+FLx4T4TP0KUgBNmllKMSimXWgS5qfY1FUwFHkeAhSn4EZbzNQZtU5Ta8VN6lRf1ZkWsvqjf/fPmORDiRminAslR/VsdP4tqdMaVKz1BpT1PVJzA7wRGTd1c04X7XAOtFztqzT9053NSTL1kX91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910912; c=relaxed/simple;
	bh=Dp138QMeF+vs8OZ9HyOzdwbwnPkbUZWzg2T8A18F78M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX56yNH2hv8QJZoduaiglzjnqNz/oeoKzIZgliPOCoRdvcUMEGS6fTFizopc6Mg//QLi1d7axxZDZ6haGbkI7BXo8YdvnF+AMAKASCARExgb/L81VpOfOnnUvH7YjkbXwLtKX7sSYfB3hfZWaMdjVT77LA1Wxev+Wfnp1JWF4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 53C7560005;
	Mon, 14 Oct 2024 13:01:39 +0000 (UTC)
Message-ID: <c05e09d0-d996-4712-a6e5-ef77f1f2ff0a@ghiti.fr>
Date: Mon, 14 Oct 2024 15:01:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to
 early_memremap
Content-Language: en-US
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, sunilvl@ventanamicro.com,
 ajones@ventanamicro.com, alexghiti@rivosinc.com,
 jeeheng.sia@starfivetech.com, haibo1.xu@intel.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241014094705.71775-1-cuiyunhui@bytedance.com>
 <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr>
 <CAEEQ3wk6K52RdCat+L91KvfNVkxbj1-3zxjubkn9xy89wK_-bA@mail.gmail.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAEEQ3wk6K52RdCat+L91KvfNVkxbj1-3zxjubkn9xy89wK_-bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 14/10/2024 14:30, yunhui cui wrote:
> Hi Alex,
>
> On Mon, Oct 14, 2024 at 8:12 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>> Hi Yunhui,
>>
>> On 14/10/2024 11:47, Yunhui Cui wrote:
>>> When SVPBMT is enabled, __acpi_map_table() will directly access the
>>> data in DDR through the IO attribute, rather than through hardware
>>> cache consistency, resulting in incorrect data in the obtained ACPI
>>> table.
>>>
>>> The log: ACPI: [ACPI:0x18] Invalid zero length.
>>>
>>> We do not assume whether the bootloader flushes or not. We should
>>> access in a cacheable way instead of maintaining cache consistency
>>> by software.
>>>
>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>> ---
>>>    arch/riscv/kernel/acpi.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
>>> index 6e0d333f57e5..3177c9af8764 100644
>>> --- a/arch/riscv/kernel/acpi.c
>>> +++ b/arch/riscv/kernel/acpi.c
>>> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
>>>        if (!size)
>>>                return NULL;
>>>
>>> -     return early_ioremap(phys, size);
>>> +     return early_memremap(phys, size);
>>>    }
>>>
>>>    void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>>
>> It makes sense to me since with this, we don't have to care about how
>> the firmware mapped the table. And it mimics all other architectures
>> (arm64, loongarch and x86).
>>
>> Here is the corresponding fixes tag:
>>
>> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in
>> different address space")
>>
>> With the corresponding fix in __acpi_unmap_table() as pointed by Sunil,
>> you can add:
>>
>> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>
>> And regarding the sparse error, I don't see any other architecture
>> casting to __iomem, so maybe that's not necessary anymore?
> OK. I will make the changes in v2. Regarding the sparse error, I will
> use another patch specifically to solve it. Is that okay?


If the second patch only consists in casting, I would not use another 
patch since the patch 2 would fix something introduced in patch 1.

But if patch 2 is more complicated,  it may make sense to do as you 
suggest, the goal is to merge patch 1 asap.

Thanks!

Alex


>
>> Thanks,
>>
>> Alex
>>
>>
> Thanks,
> Yunhui

