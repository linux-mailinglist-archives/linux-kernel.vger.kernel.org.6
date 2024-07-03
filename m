Return-Path: <linux-kernel+bounces-240246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E6926ACF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6015DB278B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E41946B4;
	Wed,  3 Jul 2024 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hJAzNx77"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6F51946AD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043297; cv=none; b=OOlpTWlmT+dT7xezfiuwMmthMA8tZkYic4yCilADPcC5RKwEHtefqWDCXd7ij1UW05N10y8H8YSVDgEm7TZncJIk1ASKFV7W4GB5+b/k1/2cEb6U+XPcYkG1+Dz/RxYAthDjxQSZpscEGzUkGDAS/p6Gm0NDYgUR12s78cjqgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043297; c=relaxed/simple;
	bh=4WpLzNAdnUBqbQKVDh/5xq3MAYbsQ7zMlNdOex8iG+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7DExy17Z+7rWJNkVE17KUt8m3K+iq3JiavLt8PWPD2h7BKCLEzKdAii9vD7eq0TuAI0EJyW+PS95otCe2AcjSINfFJRFFbB2DpTXJ1b1Lohpci+cNcfX871o0o/6gXTvlhk5E0JyxSGlETPbuDcn9kCTVR+HTqdmJw+XT0Cinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hJAzNx77; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70aeb6e1908so29827b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720043295; x=1720648095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UChrIK89B9K7cuKgj8bOFdUeR8mLezBJok3MLp29Mcs=;
        b=hJAzNx77Z0gjkl6DerzMFW8/KvNhl35ocWe9DK8koWUorz4OZdr9PYWYcdecOC+rLV
         9BGrYuXQT/uKOZNhVpqt/j5WGdR1wWK04yT2EDzgDx7ht2+yjV/mJNR9DSBYPfzkGZlS
         uKScx/bBYGt44o2OcZ0B5xlHIV5FAJZ+k5k4S+jtUKmt25En+K2WYjvOXg31v3uMoQu6
         cEikujrcEYJxeOltmMQ+rhdLnuRoS+/edBrDU5bpVagLO3bIuvSrzvcAhxdEaDSv1Epk
         F/j2d7FpdAk6uMAIcw28zhGp9sQW9nLaG2IzlXPNypoqgDFFC+UClCB316MS8/UhCtnC
         JgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043295; x=1720648095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UChrIK89B9K7cuKgj8bOFdUeR8mLezBJok3MLp29Mcs=;
        b=GAbNUFwrtyiDdpXc54XbhDy26r3kJLAVmXMTwVBF+cTaNe6dT6CvkNJMUN/yGgeqk/
         SJNAcJMA2ggfr1g3Rz7QcBdQEP67/FPMGRajYUJLzf/ZGoiFRxHa8JKDl2X1m0bLUz1L
         79a71Og3HSM1MxEqjoCCq2xA+QK2ub0ol8kpI0plU0NUYKUl9/lOZH28/g4DzTOdjzuT
         9NdrU20kLpyf64IM9UYs4ox2a6aYRO92LQ5Q2vuWFfhP5CP6dP1Nq5M3biVP0eZDNPIl
         UikbZweIdf5LncdLibBvjKg14np1TRlFCMhO4xu5pXxJyZ8xUntHs180GN9WhLpuOePz
         dedA==
X-Forwarded-Encrypted: i=1; AJvYcCXcBR6UxHDRqI+Y3mJBr4t+II8NzmbFde2ybkzDGxS6CB0X0DrX2JnERQYXlXLBwnfLwhiygtiR18urjVdv7VgBN68YJGq4IG3LfJmE
X-Gm-Message-State: AOJu0YwR5hw9s9xUC3XuiJaUiwqAKAgeXYPvgGPEkewoKJC65T4AP9Y6
	3zQfOMfxHP6sx255d46AptVOsMJfIZ+pEtyOH3HWJ++8KHIHOJNGyJ7OxDO8oN0=
X-Google-Smtp-Source: AGHT+IGCFvZKLFgfmIruwOMYP5UweFpC7y18o0GWCxrjodbL6cekNPIX/dzwODmQX9gRejI2KQfg1g==
X-Received: by 2002:a05:6a00:2e18:b0:70a:f0a3:dbc2 with SMTP id d2e1a72fcca58-70af0a3dfc7mr2807543b3a.30.1720043294835;
        Wed, 03 Jul 2024 14:48:14 -0700 (PDT)
Received: from [10.4.10.38] (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70afa00122asm526367b3a.112.2024.07.03.14.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:48:14 -0700 (PDT)
Message-ID: <3da77593-bc22-46e6-9cff-dd7f8eb02cd9@rivosinc.com>
Date: Wed, 3 Jul 2024 17:47:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] RISC-V: Check Zicclsm to set unaligned access
 speed
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
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
 <43941f48-9905-4b25-89ef-6ad75bf1a123@rivosinc.com>
 <20240701-ajar-italicize-9e3d9b8a0264@spud>
 <ef639748-3979-4236-b48d-c0c44e2d5ad2@rivosinc.com> <ZoR9swwgsGuGbsTG@ghost>
 <af3152b6-adf7-40fa-b2a1-87e66eec45b0@rivosinc.com>
Content-Language: en-US
From: Jesse Taube <jesse@rivosinc.com>
In-Reply-To: <af3152b6-adf7-40fa-b2a1-87e66eec45b0@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/3/24 03:13, Clément Léger wrote:
> 
> 
> On 03/07/2024 00:22, Charlie Jenkins wrote:
>> On Mon, Jul 01, 2024 at 04:20:15PM +0200, Clément Léger wrote:
>>>
>>>
>>> On 01/07/2024 15:58, Conor Dooley wrote:
>>>> On Mon, Jul 01, 2024 at 09:15:09AM +0200, Clément Léger wrote:
>>>>>
>>>>>
>>>>> On 27/06/2024 23:20, Charlie Jenkins wrote:
>>>>>> On Wed, Jun 26, 2024 at 03:39:14PM +0100, Conor Dooley wrote:
>>>>>>> On Mon, Jun 24, 2024 at 08:49:57PM -0400, Jesse Taube wrote:
>>>>>>>> Check for Zicclsm before checking for unaligned access speed. This will
>>>>>>>> greatly reduce the boot up time as finding the access speed is no longer
>>>>>>>> necessary.
>>>>>>>>
>>>>>>>> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>>>>>>>> ---
>>>>>>>> V2 -> V3:
>>>>>>>>   - New patch split from previous patch
>>>>>>>> ---
>>>>>>>>   arch/riscv/kernel/unaligned_access_speed.c | 26 ++++++++++++++--------
>>>>>>>>   1 file changed, 17 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
>>>>>>>> index a9a6bcb02acf..329fd289b5c8 100644
>>>>>>>> --- a/arch/riscv/kernel/unaligned_access_speed.c
>>>>>>>> +++ b/arch/riscv/kernel/unaligned_access_speed.c
>>>>>>>> @@ -259,23 +259,31 @@ static int check_unaligned_access_speed_all_cpus(void)
>>>>>>>>   	kfree(bufs);
>>>>>>>>   	return 0;
>>>>>>>>   }
>>>>>>>> +#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
>>>>>>>> +static int check_unaligned_access_speed_all_cpus(void)
>>>>>>>> +{
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +#endif
>>>>>>>>   
>>>>>>>>   static int check_unaligned_access_all_cpus(void)
>>>>>>>>   {
>>>>>>>> -	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
>>>>>>>> +	bool all_cpus_emulated;
>>>>>>>> +	int cpu;
>>>>>>>> +
>>>>>>>> +	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICCLSM)) {
>>>>>>>> +		for_each_online_cpu(cpu) {
>>>>>>>> +			per_cpu(misaligned_access_speed, cpu) = RISCV_HWPROBE_MISALIGNED_FAST;
>>>>>>>
>>>>>>> - const: zicclsm
>>>>>>>    description:
>>>>>>>      The standard Zicclsm extension for misaligned support for all regular
>>>>>>>      load and store instructions (including scalar and vector) but not AMOs
>>>>>>>      or other specialized forms of memory access. Defined in the
>>>>>>>      RISC-V RVA Profiles Specification.
>>>>>>>
>>>>>>> Doesn't, unfortunately, say anywhere there that they're actually fast :(
>>>>>>
>>>>>> Oh no! That is unfortunate that the ISA does not explicitly call that
>>>>>> out, but I think that acceptable.
>>>>>>
>>>>>> If a vendor puts Zicclsm in their isa string, they should expect
>>>>>> software to take advantage of misaligned accesses. FAST is our signal to
>>>>>> tell software that they should emit misaligned accesses.
>>>>>
>>>>> AFAIK, Zicclsm is not even an ISA extension, simply a profile
>>>>> specification which means that only the execution environment which
>>>>> provides the profile support misaligned accesses (cf
>>>>> https://lists.riscv.org/g/tech-profiles/message/56).
>>>>
>>>> I dunno, the specification status page used to describe it as an
>>>> extension:
>>>> https://wiki.riscv.org/display/HOME/Specification+Status+-+Historical
>>>> My understanding was that these could be considered extensions, just
>>>> like we are considering svade to be one.
>>>>
>>>>> . I don't think we
>>>>> can extrapolate that the misaligned accesses will be fast at all.
>>>>
>>>> That is my opinion on it too. If it doesn't say "fast" and give a
>>>> definition for what that means in the binding, then we can't assume that
>>>> it is fast. I'm also wary of extending definitions of extensions in the
>>>> binding, because a) I am 90% sure that people writing devicetrees don't
>>>> care and b) it'd be a potential difference between DT and ACPI without a
>>>> real justification (unlike the zkr or svade/svadu situations).
>>>
>>> BTW, the profile spec [1] has a note that states the following for Zicclsm:
>>>
>>> "Even though mandated, misaligned loads and stores might execute
>>> extremely slowly. Standard software distributions should assume their
>>> existence only for correctness, not for performance."
>>>
>>> Which was also quoted in patch 1, so I guess that settles it.
>>
>> The intention here was to allow vendors to configure an option to skip
>> the probing. This extension does not seem useful as it is written! A way
>> around this would be to add a kernel arg to set the access speed but
>> maybe it doesn't matter. For the sake of this patch, it looks like we
>> should get rid of this Zicclsm check.
> 
> I think a parameter could be appropriate for vendors that want to skip
> the probing and gain a bit of time on boot time. Other options already
> exists to force specific settings so, why not !

Sounds like a good solution thanks for the idea Charlie!
I will drop this patch and send a separate patch to implement two kernel 
parameters for skipping(and setting the speed of) vector and scalar 
speed tests.

Thanks,
Jesse Taube

> 
> Thanks,
> 
> Clément
> 
>>
>> - Charlie
>>
>>>
>>> Thanks,
>>>
>>> Clément
>>>
>>> Link:
>>> https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc?plain=1#L524
>>> [1]
>>>
>>>>
>>>>>> This allows for a generic kernel, like the one a distro would compile, to
>>>>>> skip the probing when booting on a system that explicitly called out
>>>>>> that the hardware supports misaligned accesses.

