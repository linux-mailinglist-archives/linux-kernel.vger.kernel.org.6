Return-Path: <linux-kernel+bounces-179238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B88C5DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E4A282BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE868182C89;
	Tue, 14 May 2024 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DFc2VAm9"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA171DDEE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726923; cv=none; b=Kr/Jm+Pt2mG/3weK4MuyFpoHgToOXiyzdKSqS3b495KS/3G0iE07X1Xp7QWVNCPB6fhkZ6nWJLye/WkE6JNYw9/3QbBfZUsbPovuvYhV82tGAgpt/aQcEYTXEb/z68DdO8U4qp0VX+8zdJaviKzopFxD1ZYZN/nwr2GEx7p25rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726923; c=relaxed/simple;
	bh=xAsPTjh9iculj9rWFx8wZw4jAVGATvCrl1of4gJeICg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwTOpR+Njo7cM2L+tDm7g9HCkfbC2jbbEt2L68Mb/WCAbNaDfXs8/t/RIgx888jN89H+GfzRgOrD/c2kP6c+Xniq4RX3SpTFO5+QPNQzA4U+0DujLAnpIJ+yy5H+IN0sxbERvsrnRUWHRXtdC59Y78eGuOkdD2RHKLfVm2kz5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DFc2VAm9; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e1c8692c2dso203956939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715726920; x=1716331720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUAFChk02m4+3W87yXDkaY8vskCwwtSGZtIR+vMWEYY=;
        b=DFc2VAm9Q9ehZvVckZ2+dEYbZr0YHxazqjXaVejGCTeJUpLVafCAjJt76IkPAXpzsw
         Cw0VaJLtf0IF4YAI7hwcwLQxM9BC3nRI7xJ042+LnxKI0EAd0XqElExY2AmyZZy5DJ0e
         BXz33BUFNE/zEpA7s3n+E3F3rKzxe3MLd1rks8myDCPTob99IPFKclTTcgWeGOYNC4Nu
         V40PpkdXBwD5dHwOOXY+aLjERdeAXAsY4mISTtz4VMDakAGOZO8wUilUZnmUY6OmvGuN
         aOTJd5q72HPNQICX3A6NyRIM8cxpArzZ17YIEJ5OKFHBwsZSESxsWUOIdiOWH2D6DWc1
         CY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715726920; x=1716331720;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUAFChk02m4+3W87yXDkaY8vskCwwtSGZtIR+vMWEYY=;
        b=fuNGNncmkfbeXPUG526iV2gARdMDpQKGojGI1ODAIfTQuK8ejAE8kKM7AaUGA9Obw3
         srKNEIoRgflN67edmCWjdcIzBfM2TjeewfxvVCyxFFORiK47Lt1yWWqHuK+JoWgJnMru
         +U/mAfhPrfVnii/+6oRfz5p2Ms5w+pUHtIox+NsSXFtV0joeRTl2Vz1LbZZVQ7da2K7K
         7XyThz8KOohe92elDJlSq8CXry9mTvyo3W/uV90BCMOjwHeYqp+UqsjLCiPs2Xyan13v
         BmxwW6B9vRSF7RKxALiCeC1a8SlVRZOrAlJ39LGoyQP/Re+RNhNSYBhlQM7nJcwBab87
         CzUA==
X-Forwarded-Encrypted: i=1; AJvYcCUIo33pZMWBKVYW8P1UxcOVKeZwiBradQXxcq/VmdtcEnp2/OcnTZiND6OVLcLJ+CMHuSZ6/hEFkXc9I4iC3LvalXGmU4FnoeeFgu3d
X-Gm-Message-State: AOJu0YyWh3sxfEkb0eq/QZQG5V0mII6SZdsXo1P02O2x9P8W+NKe5h5p
	qe/jJsMb7RHSxeyWQ+2KPIGUuU2NS3kjS0RgkYNalCeP1GbM0VIgiqkUdxbpKBc=
X-Google-Smtp-Source: AGHT+IGxl+aRJwqUl2LLDCJRlAxfDwUPh80qWe/i/xu9p2vDYsaNS6FSW8arY9lamf5k086jZ6KMFw==
X-Received: by 2002:a5d:8743:0:b0:7de:a725:e745 with SMTP id ca18e2360f4ac-7e1b520b303mr1920489539f.19.1715726920539;
        Tue, 14 May 2024 15:48:40 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.179])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e1c9eb8c80sm207174039f.38.2024.05.14.15.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 15:48:40 -0700 (PDT)
Message-ID: <c65023fd-5f35-40f0-947d-377088919af3@sifive.com>
Date: Tue, 14 May 2024 17:48:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: Do not select ARCH_HAS_KERNEL_FPU_SUPPORT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
 kernel test robot <lkp@intel.com>, Andrew Davis <afd@ti.com>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Eric DeVolder <eric.devolder@oracle.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240509013727.648600-1-samuel.holland@sifive.com>
 <CAMj1kXFfWKh-oM8q11eEF94mPOENHxW+fdvkYLSbUDs0ZG8Sow@mail.gmail.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <CAMj1kXFfWKh-oM8q11eEF94mPOENHxW+fdvkYLSbUDs0ZG8Sow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Ard,

On 2024-05-09 2:39 AM, Ard Biesheuvel wrote:
> On Thu, 9 May 2024 at 03:37, Samuel Holland <samuel.holland@sifive.com> wrote:
>>
>> On 32-bit ARM, conversions between `double` and `long long` require
>> runtime library support. Since the kernel does not currently provide
>> this library support, the amdgpu driver fails to build:
>>
>>   ERROR: modpost: "__aeabi_l2d" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>   ERROR: modpost: "__aeabi_d2ulz" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>
>> As Arnd reports, there are likely no 32-bit ARM platforms which can use
>> the amdgpu driver anyway, due to lack of features like 64-bit
>> prefetchable BARs. Since amdgpu is currently the only real user of
>> ARCH_HAS_KERNEL_FPU_SUPPORT, drop support for this option instead of
>> bothering to implement the library functions.
>>
>> Fixes: 12624fe2d707 ("ARM: implement ARCH_HAS_KERNEL_FPU_SUPPORT")
> 
> This commit is not in mainline yet. Could we just drop the original
> patch instead?

No, like I mentioned in the original thread, later patches in the series (for
example bbce5cac4f5a ("lib/raid6: use CC_FLAGS_FPU for NEON CFLAGS")) depend on
CC_FLAGS_FPU being defined for both arm and arm64.

arm can't select ARCH_HAS_KERNEL_FPU_SUPPORT because the contract of that option
is not fully implemented, but in my opinion it doesn't hurt to keep the part
that is implemented.

Regards,
Samuel

>> Reported-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
>> Closes: https://lore.kernel.org/lkml/87wmp4oo3y.fsf@linaro.org/
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202404042327.jRpt81kP-lkp@intel.com/
>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/arm/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index b1751c2cab87..b14aed3a17ab 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -15,7 +15,6 @@ config ARM
>>         select ARCH_HAS_FORTIFY_SOURCE
>>         select ARCH_HAS_KEEPINITRD
>>         select ARCH_HAS_KCOV
>> -       select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
>>         select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>         select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>         select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
>> --
>> 2.44.0
>>


