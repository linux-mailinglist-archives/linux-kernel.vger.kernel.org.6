Return-Path: <linux-kernel+bounces-235712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A68891D8B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB0D1F21903
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAFD7710E;
	Mon,  1 Jul 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="C3r0A2co"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493977406D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818118; cv=none; b=lNJzgkwdhDxnARabEa3UKQvKVL14BdNSOQY3Yy+tdXqWF0EVkl3ECplN6IE9j+oQuah1eTle514jaAjaQ8U9rprhLwKy0JI4IwBqm4MIw2AIVBFvp34Tb1DM1vzztmMxs7CNtcNThllisNA6w1Ug6tgxxlkdtgRkFxFfF/6bTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818118; c=relaxed/simple;
	bh=pUGnbmgT8PSO39DrhXDvbHFaLHIT4ZI9N9UeF4l3k6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffgYwnXW4eXCm5Jr2eIoGv6on6PP9+7L7ivCZhi7gNAJQFjz5ne44Heg7l9nmk9zZfD2T63GdmdddJ5FknuI3xbgbQpXgSHrXw7H8dFnAXjmnQm8ffil767mAvfTUbx8WS8YRLSV2jFjz/80dnXHDdRpMWBXVaYQEueWC7yivEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=C3r0A2co; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424a3d36c28so2173605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719818113; x=1720422913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VeQ0WXLl07NKq9f5p8mUnjZiEvy2m2C1+1ufISTpL0=;
        b=C3r0A2coBPyvhH7ENXy1EUNIBR/wXdj7xvpLwDZYCONZ2STXVgsipjL0KX/+GZL5x5
         tm6LUhc5lp+j0Q12rEKtqM78T/wJxsnz6sdu3CJeun+ifD990mWoS1HDWV+ukM/+gNyp
         03Z4Fg2wbNRkfFJv67Cquw0GJ8wZh7HkqQW4wHGOdEOZAZVGdvIi4DeTWrOwFvvvMRWZ
         zQFR5HWVOi8pH0LQL0g7LfqHsSUAuPRdJCSqDP8jkQi5ywHlXKRNOUcpkZZVazEcA9Do
         pRV4T9JD3SX74H0Mj8Wy4puYFt9E3ZBp7PbQgzU8wDjZf1iCeiuOFZiT+ovCZ8ZXJvjH
         AZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818113; x=1720422913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VeQ0WXLl07NKq9f5p8mUnjZiEvy2m2C1+1ufISTpL0=;
        b=Dv1+ZJgZtNhR+CGqUUUZIcLltOR7ugGzrbL3UIhyRf82n2xIZgiLsl32pT3Fr1JHcI
         oSTxyvMnbRl5TVd7KxHbQg/Be/PAvz15Ij7stcpnRz/WZAPrjj5Ayn3fwzPAxrPVMEnK
         LNqguZQgwbsl59yjiZXujrRDcZwSVLv4TQ6lEreoGNkwgs0oto59059ZmsOJWWA91z/j
         PQdnYvPmeVT6/hlpfmoNrD1uV0+w9Lb1z9u2xl+jxyLeruj2+1bCCgcjodtP//XZ8KNr
         7s3D6cP1KqoOtb2dDW3dyhpce5GzsSZZnMKNwMI171D5A4T4dfrXiu2g1ol5enEr/Tt0
         K/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUf50aE8TPrUKkhOjYr/Kr9OqqsDv+rSvosuUBxuX6t7oF+xMKjbihnaM12X0wvhjpQXBmNbskY9aygXsRMoLLgi/HrPqe+X5ITkNuU
X-Gm-Message-State: AOJu0YwCE/xAgVuzbTzyxZyZn1/3BMAcnrT17a9mwv+q/+69Xr8/rM6G
	utl+93WiOYbaip4rNWZNnHSk5lu2eMjmj4tjJFqCeqBPY16Ee+k8HzEqUuiG594=
X-Google-Smtp-Source: AGHT+IHZQaXlqpMGgKtZhm65KqVJc9Mgo9OwA0jLJuAG0EVNKbRgsOyXl69tB7SHa+Zq4VyZ50I3kQ==
X-Received: by 2002:a05:600c:3ba6:b0:425:6742:9942 with SMTP id 5b1f17b1804b1-4257a0405c5mr34411435e9.2.1719818113559;
        Mon, 01 Jul 2024 00:15:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55e61sm138652275e9.20.2024.07.01.00.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 00:15:12 -0700 (PDT)
Message-ID: <43941f48-9905-4b25-89ef-6ad75bf1a123@rivosinc.com>
Date: Mon, 1 Jul 2024 09:15:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] RISC-V: Check Zicclsm to set unaligned access
 speed
To: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
 Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Evan Green <evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu <andy.chiu@sifive.com>,
 Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240625005001.37901-1-jesse@rivosinc.com>
 <20240625005001.37901-5-jesse@rivosinc.com>
 <20240626-march-abreast-83414e844250@spud> <Zn3XrLRl/yazsoZe@ghost>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <Zn3XrLRl/yazsoZe@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/06/2024 23:20, Charlie Jenkins wrote:
> On Wed, Jun 26, 2024 at 03:39:14PM +0100, Conor Dooley wrote:
>> On Mon, Jun 24, 2024 at 08:49:57PM -0400, Jesse Taube wrote:
>>> Check for Zicclsm before checking for unaligned access speed. This will
>>> greatly reduce the boot up time as finding the access speed is no longer
>>> necessary.
>>>
>>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>>> ---
>>> V2 -> V3:
>>>  - New patch split from previous patch
>>> ---
>>>  arch/riscv/kernel/unaligned_access_speed.c | 26 ++++++++++++++--------
>>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>>> index a9a6bcb02acf..329fd289b5c8 100644
>>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>>> @@ -259,23 +259,31 @@ static int check_unaligned_access_speed_all_cpus(void)
>>>  	kfree(bufs);
>>>  	return 0;
>>>  }
>>> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
>>> +static int check_unaligned_access_speed_all_cpus(void)
>>> +{
>>> +	return 0;
>>> +}
>>> +#endif
>>>  
>>>  static int check_unaligned_access_all_cpus(void)
>>>  {
>>> -	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>>> +	bool all_cpus_emulated;
>>> +	int cpu;
>>> +
>>> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
>>> +		for_each_online_cpu(cpu) {
>>> +			per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
>>
>> - const: zicclsm
>>   description:
>>     The standard Zicclsm extension for misaligned support for all regular
>>     load and store instructions (including scalar and vector) but not AMOs
>>     or other specialized forms of memory access. Defined in the
>>     RISC-V RVA Profiles Specification. 
>>
>> Doesn't, unfortunately, say anywhere there that they're actually fast :(
> 
> Oh no! That is unfortunate that the ISA does not explicitly call that
> out, but I think that acceptable.
> 
> If a vendor puts Zicclsm in their isa string, they should expect
> software to take advantage of misaligned accesses. FAST is our signal to
> tell software that they should emit misaligned accesses.

AFAIK, Zicclsm is not even an ISA extension, simply a profile
specification which means that only the execution environment which
provides the profile support misaligned accesses (cf
https://lists.riscv.org/g/tech-profiles/message/56). I don't think we
can extrapolate that the misaligned accesses will be fast at all.

Thanks,

Clément

> 
> This allows for a generic kernel, like the one a distro would compile, to
> skip the probing when booting on a system that explicitly called out
> that the hardware supports misaligned accesses.
> 
> - Charlie
> 
>>
>> Thanks,
>> Conor.
>>
>>> +		}
>>> +		return 0;
>>> +	}
>>> +
>>> +	all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>>>  
>>>  	if (!all_cpus_emulated)
>>>  		return check_unaligned_access_speed_all_cpus();
>>>  
>>>  	return 0;
>>>  }
>>> -#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
>>> -static int check_unaligned_access_all_cpus(void)
>>> -{
>>> -	check_unaligned_access_emulated_all_cpus();
>>> -
>>> -	return 0;
>>> -}
>>> -#endif
>>>  
>>>  arch_initcall(check_unaligned_access_all_cpus);
>>> -- 
>>> 2.45.2
>>>
> 
> 

