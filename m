Return-Path: <linux-kernel+bounces-534234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD5A4647A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5227A7148
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8C224887;
	Wed, 26 Feb 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L1sM9q/X"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C5922157E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583376; cv=none; b=FFKi0OS5qlaIxIcJC/WlCbvh1HXOhKxfKV1jjFCFpgT/9aS89OKV1audwena4JW95pfT7yf+OHJ5RkwVktEsbpCA76mB/jxNvmOWlvDX2hGjajsI36GuvrC6YOqvQ4JgAyp2v9mjqt1bo14PWIAKDP0RUf+cMuOrA4PnoDinyvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583376; c=relaxed/simple;
	bh=qXUkSBWqIXjyHNE+1PdUrwHzhW39aWdQa5SBkLY+AQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVk+4/jzKJfo6qQ1vZJMGN3moA2RHmlNRGC30ITWcbljFlkk6BVdl+7hsZ9tvEcxiilOtpZqxvlaIRHluhPUKnqbAXDDAxJ62RLAtMWgloXu9azD1MYx9CGq5xVvjRtrjtCtfOf/0estOfU/jo2b3sZ8QNrVwiF2OULnTS46dTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L1sM9q/X; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-855923e7f53so489798039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1740583373; x=1741188173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJcEK4sOf8nkoSH+sJw+bKRznJ9CM5hAQnbFbGBpuK0=;
        b=L1sM9q/XuizxVua0lIcokcExSjDg1lBMDID/FGvwvGDPN2zdSIc/v6aL/nUr4ViIHj
         NuTmuE4bEZoD5omXIW7q1G8yXirK79ayNpOGRaubmQacR42H40koVrQE6Rdkj9as+rD3
         OpeSs3163tSqtXJVsMwlcOdyykLax+kmdskmqquD8DRziAM/FPFmq7MhrdNVbxUPDIvH
         hezrfi5KC9Xh8J7VpPKAWeVd3WvDfZHTTM1temTovibLafqnFyLm1ztnYA8XGbtxgcgi
         PTWyWQ2KU2pLQRFQDFi/jrglkW/XXIR1v2iqNf3qDXkvQi1PYBAv1Vj0OS11INUYvX2M
         bETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583373; x=1741188173;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJcEK4sOf8nkoSH+sJw+bKRznJ9CM5hAQnbFbGBpuK0=;
        b=Z5JiXLxbhhD1yzq3NEm8moF5b13ZdZLoUY/qVu6hlBqyAe24cVtDSKsbLd1mrdVUv2
         VhSl3182o/gkRcTHmEMir3LffCME27OUEujhhqPTomrFt/GPh3mo+NGranKm7nAa+iz4
         UUhreWMOtuzvDQnnPXWXqOLtaUcSZZ8iryjpKw8dsv0w/zohF6QVvYx6ptUE/j8p1AE/
         cLCeK0NrJqmxrg+mlobhTX7Erwa9Y7i4ZVR3V5+LkODEDp8nogf6yHmzq5B8dyI/hCCg
         ycDKFsgszty7f3wn4s0sjNWOTnBEmgiOTPNkydD53Oz7jxmcA5/rruXJhYRT6bhpb9ml
         rWtg==
X-Gm-Message-State: AOJu0Yz+j8k6nIYLp/y+J7TbZ7SX9+t2uUdowJFvypFI8QftUhtyUGBZ
	e7h0lCrrWgoKKVsj1yUV6aMwCVbVWwVmPgKjumpBj+zj6qjlVkY/cSqceZGEI0Y=
X-Gm-Gg: ASbGnctMS5V7It1oLKK0D7F+CUrUIoO8RcT1CVnA2l8h56Wy+GWclYgYrGuaHt/xF0H
	/YKfvM+XgI0+joB8dj2X82dqizGaNIH3wPSXDrG/VJtG1Ggmbdsjg/jEdtYjApPXR1kxywHkj4G
	wqagJ+RswzTM/Hf57pZ0qxjcfukRbQdAyRNPDzDgxrj/Qr8mogEaTlZrPDYzdjGJr1ytxyPYb9U
	/iiCHcWJOgFo+RGVzORXGC9lzhUgh4rcqfyouEem0GcdMOnVDRE/6nbV/W9y93vx173W+edKR2o
	IdtatICn9rxCUK7itL/VVJ7zEeUQM40gVod/cegM+9nVlmPZpQ==
X-Google-Smtp-Source: AGHT+IH3JGSazN4a7DLB5z3B9JItdUDgi5/0Ituv+SUpjy9S1mPfOmAWS57i2QTwFrEPGyFnUtPTMA==
X-Received: by 2002:a05:6602:1693:b0:855:c476:8b95 with SMTP id ca18e2360f4ac-856203c36b3mr919158839f.12.1740583373401;
        Wed, 26 Feb 2025 07:22:53 -0800 (PST)
Received: from [100.64.0.1] ([165.188.116.9])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f04753070esm941666173.120.2025.02.26.07.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 07:22:53 -0800 (PST)
Message-ID: <60900b42-298c-4b9f-86cf-af31aa5a02d3@sifive.com>
Date: Wed, 26 Feb 2025 09:22:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] riscv: Relocatable NOMMU kernels
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 alexghiti@rivosinc.com
References: <mhng-25ab7f97-42b6-40a8-b96d-d387cbf54ad1@palmer-ri-x1c9>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <mhng-25ab7f97-42b6-40a8-b96d-d387cbf54ad1@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Palmer,

On 2025-02-13 8:17 AM, Palmer Dabbelt wrote:
> On Sat, 26 Oct 2024 10:13:52 PDT (-0700), samuel.holland@sifive.com wrote:
>> Currently, RISC-V NOMMU kernels are linked at CONFIG_PAGE_OFFSET, and
>> since they are not relocatable, must be loaded at this address as well.
>> CONFIG_PAGE_OFFSET is not a user-visible Kconfig option, so its value is
>> not obvious, and users must patch the kernel source if they want to load
>> it at a different address.
>>
>> Make NOMMU kernels more portable by making them relocatable by default.
>> This allows a single kernel binary to work when loaded at any address.
>>
>>
>> Samuel Holland (6):
>>   riscv: Remove duplicate CONFIG_PAGE_OFFSET definition
>>   riscv: Allow NOMMU kernels to access all of RAM
>>   riscv: Support CONFIG_RELOCATABLE on NOMMU
>>   asm-generic: Always define Elf_Rel and Elf_Rela
>>   riscv: Support CONFIG_RELOCATABLE on riscv32
>>   riscv: Remove CONFIG_PAGE_OFFSET
>>
>>  arch/riscv/Kconfig               | 10 +---
>>  arch/riscv/Makefile              |  1 -
>>  arch/riscv/include/asm/page.h    | 27 ++++-----
>>  arch/riscv/include/asm/pgtable.h |  6 +-
>>  arch/riscv/mm/init.c             | 97 ++++++++++++++++----------------
>>  include/asm-generic/module.h     |  8 ---
>>  6 files changed, 68 insertions(+), 81 deletions(-)
> 
> I'm getting some build failures
> 
> riscv64-unknown-linux-gnu-ld: arch/riscv/errata/sifive/errata.o: relocation
> R_RISCV_HI20 against `tlb_flush_all_threshold' can not be used when making a
> shared object; recompile with -fPIC
> riscv64-unknown-linux-gnu-ld: arch/riscv/errata/thead/errata.o: relocation
> R_RISCV_HI20 against `riscv_cbom_block_size' can not be used when making a
> shared object; recompile with -fPIC

What toolchain and config do you see failures with? I have tried building this
series on top of v6.14-rc4 with GCC 14.2.1 and
 * defconfig
 * defconfig + NOMMU + S-mode
 * defconfig + NOMMU + M-mode
 * defconfig + 32-bit
 * defconfig + 32-bit + NOMMU + S-mode
 * defconfig + 32-bit + NOMMU + M-Mode
 * nommu_k210_defconfig
 * nommu_k210_sdcard_defconfig
 * nommu_virt_defconfig
and all succeed.

Regards,
Samuel


