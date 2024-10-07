Return-Path: <linux-kernel+bounces-353443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99D9992DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0E71F221D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5F1D460B;
	Mon,  7 Oct 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsFHBI6T"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3A1D4332;
	Mon,  7 Oct 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309252; cv=none; b=m8IsjgGtI34Min0ALraNdvUJpgazmT6WpeDwwB7fWQ07lrP/ywRvG2Sx+KpV/Boil7JpnKWYB2+TL/sOLs3XpXgMUuory/7wlfxg2QnG0/iJR2NWbGRsDainKW26dT7Jj2FrfWAnLYhIpRyGHYY30OMJkoAJVbO54jh9x3g/+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309252; c=relaxed/simple;
	bh=TB+8AkT+B3SLZZ3seAnOqaE1fK2V59sHpNjrU0JCHfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYVqFtM3TYGFk0dAZH28jomdzoBH0KE2lJMG5qYv79VXhfxkz+O/X4dJSmh79DdQFzaRf8lZ90ZftTlXxpLr3dbS/wexMpVtQmQ7HSPMEocw+oJPDxloye2h2J46rIo/O15LEIWkKGr5+OuAQ+MihDplecH70wZj74cjJ4//1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsFHBI6T; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99650da839so6543166b.2;
        Mon, 07 Oct 2024 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728309249; x=1728914049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNiHRpWauHu9OcSIyJvokmcQHWfA46j89wHk+iMIBZs=;
        b=JsFHBI6Tjp3e0iERYGhzWFlzPxWa0v/Vr/Zskc1P0Vgabr84qTEfZgi588mR7Nz3gD
         LL7jZ+g1URFKwM7NAxi1eaiv5eNHF0yPH9oMBC/P0Oldh+yQX2Z5/cs0PFLkIcLgIYIc
         o8tC+ylnG7YscDZXwGO9iT2YK+zocAWk4onrB7da4myfdg/MN8++5Kkd4Lop0uZw+YtV
         URlwLiqQOMZqzZwKC1uKNjjwVbAKaW0ygojwM+imoX5OPtGWvaU4HZrhsVlIhHpTADG4
         Xi7BqR+vfUzJWcPo7H8sLeZP5J3Qh3fCx6OhnkDYDHH2ZxgNFgXT0vEYvsVXF0hLczKI
         /JVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309249; x=1728914049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNiHRpWauHu9OcSIyJvokmcQHWfA46j89wHk+iMIBZs=;
        b=P8UzO75J2CMAoKwLByKwu/iErhQzyxMZp3WizVKhbSGLakVkr9Z6TMX3uzi1qnsPA8
         WUnGmwT+bU4mOFEGR27yeY9Lgg0+oC02113DuSf2nwz6i6hAnvbn9NChCz1In8F18EqK
         5vYKU1GJJ7Ze9nN9cBRKW++yr/81o4XmAE6vjz34sM2uixTqEPE1NGgHg+oxgCeV5n5k
         7QGujfmDM4WUqM34nYWLZC/R957yEeDwY+lnjm6d8yj0gNrMmGnHVJekwWmJswg7obEO
         ufY2GNjG/QmkV60L+E+oGjsAB3dUZLs9ZVD41ZAEFWVs08POHNpX3VtgZQXBj5ua73Lx
         0R/A==
X-Forwarded-Encrypted: i=1; AJvYcCU50w/VFIn6kKBxy4lXzhdr95lKxio7Au+pRxZMTXBlCgqSZbRbx5CdVHd8A4vMCnfFd/N228qWFTIj3PX7@vger.kernel.org, AJvYcCUZde79e1k8E66PHuBXdqh30l29gzqdPVLJL+/3F7e6uBQ4MqNh8tNE8AU3TgzpB9HOBLY3uTYvCjHa@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHhPFQCJAG95K44kVBuKd16SnRFfOPMggTzIprGNGgH/LNh9J
	UYWS2hbbIYadb0/I7w8vJ4j5MHxGe9aAiBWvlPjjGlVSdcQMLyOd0YwjFw==
X-Google-Smtp-Source: AGHT+IHgrGUczMQa3+R9ilrZq3kW3bNhNLENKx/l2whAtuGxXcGTe19KE/m40/AM1uUuiHqPJkvYkw==
X-Received: by 2002:a17:907:368a:b0:a8d:2b7a:ff44 with SMTP id a640c23a62f3a-a991bd7a0bcmr1209519566b.32.1728309248865;
        Mon, 07 Oct 2024 06:54:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:eb:d0d0:c7fd:c82c? ([2620:10d:c092:500::4:3232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995138f458sm169603066b.209.2024.10.07.06.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 06:54:08 -0700 (PDT)
Message-ID: <b14ac6d4-9d29-4193-ac2f-7e7d7ae3a60a@gmail.com>
Date: Mon, 7 Oct 2024 14:54:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of/kexec: save pa of initial_boot_params for arm64 and
 use it at kexec
To: Saravana Kannan <saravanak@google.com>
Cc: mark.rutland@arm.com, will@kernel.org, leitao@debian.org,
 catalin.marinas@arm.com, robh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org
References: <20241003113840.2972416-1-usamaarif642@gmail.com>
 <CAGETcx9r+VwMBt=Ra-+-ZFgO66DK1LGjbT8cXFZ7v-c-N20qTQ@mail.gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CAGETcx9r+VwMBt=Ra-+-ZFgO66DK1LGjbT8cXFZ7v-c-N20qTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 03/10/2024 21:20, Saravana Kannan wrote:
> On Thu, Oct 3, 2024 at 4:38 AM Usama Arif <usamaarif642@gmail.com> wrote:
>>
>>  __pa() is only intended to be used for linear map addresses and using
>> it for initial_boot_params which is in fixmap for arm64 will give an
>> incorrect value. Hence stash the physical address when it is known at
>> boot time and use it at kexec time instead of converting the virtual
>> address using __pa().
>>
>> Reported-by: Breno Leitao <leitao@debian.org>
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
>> ---
>>  arch/arm64/kernel/setup.c | 8 ++++++++
>>  drivers/of/fdt.c          | 6 ++++++
>>  drivers/of/kexec.c        | 8 ++++++--
>>  include/linux/of_fdt.h    | 2 ++
>>  4 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index b22d28ec8028..a4d96f5e2e05 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -194,6 +194,14 @@ static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>         /* Early fixups are done, map the FDT as read-only now */
>>         fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL_RO);
>>
>> +       /*
>> +        * Save dt_phys address so that it can be used later for kexec. This
>> +        * is done as __pa() is only intended to be used for linear map addresses
>> +        * and using it for initial_boot_params which is in fixmap will give an
>> +        * incorrect value.
>> +        */
>> +       set_initial_boot_params_pa(dt_phys);
>> +
>>         name = of_flat_dt_get_machine_name();
>>         if (!name)
>>                 return;
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 4d528c10df3a..9e312b7c246e 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -457,6 +457,7 @@ int __initdata dt_root_addr_cells;
>>  int __initdata dt_root_size_cells;
>>
>>  void *initial_boot_params __ro_after_init;
>> +phys_addr_t initial_boot_params_pa __ro_after_init;
>>
>>  #ifdef CONFIG_OF_EARLY_FLATTREE
>>
>> @@ -1185,6 +1186,11 @@ bool __init early_init_dt_scan(void *params)
>>         return true;
>>  }
>>
>> +void __init set_initial_boot_params_pa(phys_addr_t params)
>> +{
>> +       initial_boot_params_pa = params;
>> +}
>> +
>>  static void *__init copy_device_tree(void *fdt)
>>  {
>>         int size;
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index 9ccde2fd77cb..ca9f27b27f71 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -300,8 +300,12 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>>                 goto out;
>>         }
>>
>> -       /* Remove memory reservation for the current device tree. */
>> -       ret = fdt_find_and_del_mem_rsv(fdt, __pa(initial_boot_params),
>> +       /* Remove memory reservation for the current device tree.
>> +        * For arm64, initial_boot_params is a fixmap address, hence __pa(),
>> +        * can't be used to get the physical address.
>> +        */
>> +       ret = fdt_find_and_del_mem_rsv(fdt, IS_ENABLED(CONFIG_ARM64) ?
>> +                                      initial_boot_params_pa : __pa(initial_boot_params),
>>                                        fdt_totalsize(initial_boot_params));
> 
> Not sure about the correctness of the patch (not a kexec expert) but
> no need to do all of this inside a function parameter. Just create a
> variable and use it here.
> 
> -Saravana
> 

Thanks, will do in the next revision.


