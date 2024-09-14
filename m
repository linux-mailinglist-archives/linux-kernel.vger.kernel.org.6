Return-Path: <linux-kernel+bounces-329246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E5978F16
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13B2B287B3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC5143725;
	Sat, 14 Sep 2024 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Ki7DP5Sm"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D913A89B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726302084; cv=none; b=TIHB4ljrMn66R/8zxvkTQsPNUm/lQP3gVdC5138+SFbr4j0e8dHYQOZbUwTZmnu8BO7VIaSwrN8hgkblIJ9F+ZGT++lu56zEMv/nRvS8OZsmB9mX96OPlFA8V0JBqAtQGXQD/AI2EKqvsq2TJr/gCkuiPC1z4euV/+DHeTdYI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726302084; c=relaxed/simple;
	bh=nd/TB/3T62gOj1lgfcvTdwRdPSEWwaqVpUhCLQGO3XQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=MSo5w//QDFvXLTFnT8IR9YgCtxYvZALhV76qZNlh04DR+ZFOpj5TVc7TyAqF8c9dxYJR6YgFvqfUqVkJx8JvYCnIDlXGV8nPAsTKMJ7RbHlqF9uP20xHDooTWBZxr319Th/Fn/6klXAnheeddXdvsiHOUX78LZ3sfw9rtAA+jyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Ki7DP5Sm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7191df6b5f5so2119728b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1726302082; x=1726906882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilH54TMFMO/532p4dSlQLHzGzRiiqRzXIJ2V4dFceb4=;
        b=Ki7DP5SmX4qqW/cmVqRq++x65mFfgibUIYv/6F84TisNtncJ4odkI/k0IiRhNLygz/
         KM/rZIg+6JjsTOCWw+mv3ovN7mSBg3pSRLJAJe9IIxoOe35TDNT7dhZiqmi0C8myJAeh
         bWSxVGX+CIqCTFVM2lcrUpp5TzfAbT+CpVQbYBsKbe6qfvBsBNrkt8njlg9SK1YEPg6p
         q1K6IruhDmUN7CI+Hjp0XnAFUlMAO59Wxu+drFSymLmryp2iSIQ+2xv/LRrgU6G3jgkC
         lfm1Lap+YLIljtfmM/pFIpZvvNpNMCD3jhHwlmjr3uJWTlnCChm0lCbV+76dLQEe00A6
         o0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726302082; x=1726906882;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilH54TMFMO/532p4dSlQLHzGzRiiqRzXIJ2V4dFceb4=;
        b=TOLlol4irUWtQQDuIF45BgZnCSKWKRjR3ztGy6Zq/jx05piNAEXqqaYjVLm8dvm2R0
         92XBlQzRXiwsD+XbSqNiqHELpIsLX6Qied9ODUH6BmUj4M2Wuwq46PXA7SWlPNxQh1Qb
         RTKKf9Y9UUx/3SjoY/HZ7JFuCq4BB2mmfwqaLpiqieY9oS2vMrzuBF1GbUPqHf2NS6C/
         mmT8hb2GaZBrB2fbC505iSYoVu6YfxRip5Lk9cMqvBtea+prtF2pmTAIKJwA8jcqVarS
         JzQze4Z0+TMbaHvXdEA2AhfZSYtHjlRT2ltl/Luz02GddyMycOCyDC70pZsVtswHZYCw
         +L9A==
X-Forwarded-Encrypted: i=1; AJvYcCWLv+09X0CyL5NY6kUUy02IGNMcEI6QDE3yotyxbit0TsRJwR9SYQBAsctUvjjpkhH/oWtqLxnCqD5fNU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydXnYYg8PzLjEbHAsgOni9etL4AUaNsRA6PVXHHYbmLHP+3vF0
	DA5Y3gRFcjNjkT3e1RNDzoZOvRBMAqYutSUmKvqthCOXkyWXfrEg9vaAYlzTCKU=
X-Google-Smtp-Source: AGHT+IFY/Xq42oMtYtCSkvz/SDjtv31829zY7yH+ltLYgM5AYj4y9hQ7+IK16DRGjjCfwmXF9YSEUA==
X-Received: by 2002:a05:6a00:9a0:b0:710:6f54:bc9c with SMTP id d2e1a72fcca58-7192606564cmr13283731b3a.2.1726302081853;
        Sat, 14 Sep 2024 01:21:21 -0700 (PDT)
Received: from localhost (guests-out.ms.mff.cuni.cz. [195.113.20.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bb97fesm617917b3a.183.2024.09.14.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 01:21:21 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:21:21 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2024 01:21:12 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: cmdline: Add support for 'memmap' parameter
In-Reply-To: <874j8hku51.fsf@gmail.com>
CC: cuiyunhui@bytedance.com, rppt@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, alexghiti@rivosinc.com, akpm@linux-foundation.org,
  bhe@redhat.com, dawei.li@shingroup.cn, jszhang@kernel.org, namcao@linutronix.de,
  chenjiahao16@huawei.com, Bjorn Topel <bjorn@rivosinc.com>, vishal.moola@gmail.com,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: punit.agrawal@bytedance.com
Message-ID: <mhng-7b39a06f-bf26-4bc0-beef-45bd4b5312e1@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 22 Jul 2024 14:13:14 PDT (-0700), punit.agrawal@bytedance.com wrote:
> Hi Palmer,
>
> Charlie Jenkins <charlie@rivosinc.com> writes:
>
>> On Mon, Jun 24, 2024 at 08:37:39PM +0800, Yunhui Cui wrote:
>>> Add parsing of 'memmap' to use or reserve a specific region of memory.
>>>
>>> Implement the following memmap variants:
>>> - memmap=nn[KMG]@ss[KMG]: force usage of a specific region of memory;
>>> - memmap=nn[KMG]$ss[KMG]: mark specified memory as reserved;
>>>
>>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>>> ---
>>>  arch/riscv/mm/init.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 46 insertions(+)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index e3405e4b99af..8e1d93ae5cb2 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -208,6 +208,52 @@ static int __init early_mem(char *p)
>>>  }
>>>  early_param("mem", early_mem);
>>>
>>> +static void __init parse_memmap_one(char *p)
>>> +{
>>> +	char *oldp;
>>> +	unsigned long start_at, mem_size;
>>> +
>>> +	if (!p)
>>> +		return;
>>> +
>>> +	oldp = p;
>>> +	mem_size = memparse(p, &p);
>>> +	if (p == oldp)
>>> +		return;
>>> +
>>> +	switch (*p) {
>>> +	case '@':
>>> +		start_at = memparse(p + 1, &p);
>>> +		memblock_add(start_at, mem_size);
>>> +		break;
>>> +
>>> +	case '$':
>>> +		start_at = memparse(p + 1, &p);
>>> +		memblock_reserve(start_at, mem_size);
>>> +		break;
>>> +
>>> +	default:
>>> +		pr_warn("Unrecognized memmap syntax: %s\n", p);
>>> +		break;
>>> +	}
>>> +}
>>> +
>>> +static int __init parse_memmap_opt(char *str)
>>> +{
>>> +	while (str) {
>>> +		char *k = strchr(str, ',');
>>> +
>>> +		if (k)
>>> +			*k++ = 0;
>>> +
>>> +		parse_memmap_one(str);
>>> +		str = k;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +early_param("memmap", parse_memmap_opt);
>>> +
>>>  static void __init setup_bootmem(void)
>>>  {
>>>  	phys_addr_t vmlinux_end = __pa_symbol(&_end);
>>> --
>>> 2.20.1
>>>
>>
>> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>
> Another patch that looks good to get merged if there are no further
> comments.
>
> Any chance this can be picked up for this cycle?

Sorry for being slow here, but I don't understand the use case for this: 
we already get the memory map from the firmware, it seems like 
overriding that is just asking for issues.

