Return-Path: <linux-kernel+bounces-566295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3536CA67606
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FBD883051
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AEB20E009;
	Tue, 18 Mar 2025 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kbcBOGrc"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE84D20E002
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307012; cv=none; b=Kh1ttOntr6vJLVTHtqTYNx0UliCfGJIjaEXAaY5A+E3D+Qd5hKY+ZSLXEgBpLPSf2xrzuDN7IMwOTXVx/gh9Rz87oPu8g4oOZE0HKc3te4vPATZWJAxbEftX6aWyGery8vPvz0Eqy+aS6xtFqk/Dl85BDIR9bDfyNQsi5V6uWro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307012; c=relaxed/simple;
	bh=XePCahPsZSpbQWsXf0CcR37O6zVZm17Sm32cogwHUok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewqumWkG4sNvDvy5LZSnPjLvn+lBLyvKRInCHuEoAq+7EPcS/lJ9CbjUY/R959LkDJWhqyoVZT0KpRp2JrsStZXQM4EQAZ9iS50uLKNAU6As8jJh/xXz/ZzME3zdiawmcDt8HnYkYYVN0c0QON/lNqbljOR0QAMVS2pfus4DPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kbcBOGrc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22401f4d35aso106374555ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742307009; x=1742911809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJlfQbKkZaT5zgjtlKURf8XEWEevxg5b6NR+MnbaBy4=;
        b=kbcBOGrce+CNPiDcNYIkAHJC6SpRp2Y70bns6JT9LUszlXxzIufB7Hndh1EFQgqpBG
         1Qsgr2uLVwk/GOjyz1Wmfb/+EvieZPFUyTJpFOf9gTqJdXXGhWTDzUjVxvmtfTAsa9Lr
         hk3nZ2tL+8ca2KfHfxaVV/kMovok36W5enjXLK5xT4yUWjyZczlIXkMVaf5D+G8hg0B+
         NW+G6mKGFXqVQ0C0hnBRLnzPvpIuCYtTkyD5eFbzuv34NxOfV/5+NdDYkeFlpFVmQxq4
         zBI7oncawDZ+xFRRApRMIcn9rvblbRRCXuWoPHsPSf20Fbqk39NAc32jjVmvrvi9UtVb
         ibkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307009; x=1742911809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJlfQbKkZaT5zgjtlKURf8XEWEevxg5b6NR+MnbaBy4=;
        b=QM+avkblxnErLRJyAzyzACjuMLwkr8oDpMZtMfpW9l+RQenm7qBFIRSzfZFMNLFO67
         8Q5Qpw14EAwfe7Z0pERzZjMCRhOReKkvy9Szl9x5xOvJLHqkKeRMCAPLfpH1e2EdlrSv
         l7Xqd+EE9cvPveW3QUD540+rIl1Tk0CkPraITPubH0bGwwWlol1HJwXXkeBRZpTnjC3h
         DBjO/28BGLn0FhJdPQx2UeDE5UJ51e988dPleYJe7satOkbE1819kCgrQhhtEkLTULW/
         C3DedEO3LDsEcQMeHQWwYepY45qrJXyHcRywixPp+yFmzmzmEjyaWpnP5ekP/gtAg/ey
         WXXg==
X-Forwarded-Encrypted: i=1; AJvYcCWOP1XWwHv26IpLYzOUaoZcbhJkKXAfg6a0oADt6onV1R8jegNl01Y6yn9Jw0DuczvlA8gU3BQruKE/Sew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvsBf94GO1mh3mDObIJqaQXO1R1U8Pkxe1oX3D7125PdV9nrz
	89/uDwlc9i/noJM1GP+t9Z+fcDXjegk6EMuzPNqb86FJG64Y0CKZ2RMj5koHH0A=
X-Gm-Gg: ASbGnctGW0QttRB9T0CnTiF3MANklvKAnk200rLv31ukELTBFkS/2ahKwfCA+k9ws35
	RTi0Lrk3hdtEz+bB3GiQjCFRAvGkBD19KHncnEUf2L4aPRyRnTxoelFZybsUOe0rMtmMNctR37+
	t52d3LKvABR2KREx/h7hZ6SahCKwoigHquW0QlUauKA+jz4V2S25a5bbafANj1iKn7FgI7n43F1
	U7syFKAcGyUY/HYthqrP2CWFgtSqNb2xKkeHBKvtfk8bGAmCsDTv/411IwWsYVl/Q0VDw8wt72F
	ui/lS8tvWEOC7fVBeUOmi2bn3xlWBi7bp8Ee5rbU4SU7tCKeGn1OdlvCF8f7rrieTN6NG81ZhBq
	gGXv24vzsqQRN/BWJUF2IcQlw
X-Google-Smtp-Source: AGHT+IFUuNSszPzOvVIhdNPMgT9jchMGQU0sWHBhn3LDIjOpNzyeuRpJ5c0eiUiE0ijqUFJKnU7/7A==
X-Received: by 2002:a17:902:ecc3:b0:223:325c:89f6 with SMTP id d9443c01a7336-2262c51bc89mr46644695ad.10.1742307008987;
        Tue, 18 Mar 2025 07:10:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6f2dsm94391105ad.140.2025.03.18.07.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:10:07 -0700 (PDT)
Message-ID: <ee650a6c-eed8-4a2b-82ee-868a784f26b3@rivosinc.com>
Date: Tue, 18 Mar 2025 15:09:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
To: Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 charlie@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, corbet@lwn.net
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
 <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
 <20250318-1b03e58fe508b077e5d38233@orel>
 <20250318-61be6a5455ea164b45d6dc64@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250318-61be6a5455ea164b45d6dc64@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/03/2025 10:00, Andrew Jones wrote:
> On Tue, Mar 18, 2025 at 09:48:21AM +0100, Andrew Jones wrote:
>> On Mon, Mar 17, 2025 at 03:39:01PM +0100, Alexandre Ghiti wrote:
>>> Hi Drew,
>>>
>>> On 04/03/2025 13:00, Andrew Jones wrote:
>>>> Allow skipping scalar and vector unaligned access speed tests. This
>>>> is useful for testing alternative code paths and to skip the tests in
>>>> environments where they run too slowly. All CPUs must have the same
>>>> unaligned access speed.
>>>
>>> I'm not a big fan of the command line parameter, this is not where we should
>>> push uarch decisions because there could be many other in the future, the
>>> best solution to me should be in DT/ACPI and since the DT folks, according
>>> to Palmer, shut down this solution, it remains using an extension.
>>>
>>> I have been reading a bit about unaligned accesses. Zicclsm was described as
>>> "Even though mandated, misaligned loads and stores might execute extremely
>>> slowly. Standard software distributions should assume their existence only
>>> for correctness, not for performance." in rva20/22 but *not* in rva23. So
>>> what about using this "hole" and consider that a platform that *advertises*
>>> Zicclsm means its unaligned accesses are fast? After internal discussion, It
>>> actually does not make sense to advertise Zicclsm if the platform accesses
>>> are slow right?
>>
>> This topic pops up every so often, including in yesterday's server
>> platform TG call. In that call, and, afaict, every other time it has
>> popped up, the result is to reiterate that ISA extensions never say
>> anything about performance. So, Zicclsm will never mean fast and we
>> won't likely be able to add any extension that does.
>>
>>>
>>> arm64 for example considers that armv8 has fast unaligned accesses and can
>>> then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even though some
>>> uarchs are slow. Distros will very likely use rva23 as baseline so they will
>>> enable Zicclsm which would allow us to take advantage of this too, without
>>> this, we lose a lot of perf improvement in the kernel, see
>>> https://lore.kernel.org/lkml/20231225044207.3821-1-jszhang@kernel.org/.
>>>
>>> Or we could have a new named feature for this, even though it's weird to
>>> have a named feature which would basically  mean "Zicclsm is fast". We don't
>>> have, for example, a named feature to say "Zicboz is fast" but given the
>>> vague wording in the profile spec, maybe we can ask for one in that case?
>>>
>>> Sorry for the late review and for triggering this debate...
>>
>> No problem, let's try to pick the best option. I'll try listing all the
>> options and there pros/cons.
>>
>> 1. Leave as is, which is to always probe
>>    pro: Nothing to do
>>    con: Not ideal in all environments
>>
>> 2. New DT/ACPI description
>>    pro: Describing whether or not misaligned accesses are implemented in
>>         HW (which presumably means fast) is something that should be done
>> 	in HW descriptions
>>    con: We'll need to live with probing until we can get the descriptions
>>         defined, which may be never if there's too much opposition
>>
>> 3. Command line
>>    pro: Easy and serves its purpose, which is to skip probing in the
>>         environments where probing is not desired
>>    con: Yet another command line option (which we may want to deprecate
>>         someday)
>>
>> 4. New ISA extension
>>    pro: Easy to add to HW descriptions
>>    con: Not likely to get it through ratification
>>
>> 5. New SBI FWFT feature
>>    pro: Probably easier to get through ratification than an ISA extension
>>    con: Instead of probing, kernel would have to ask SBI -- would that
>>         even be faster? Will all the environments that want to skip
>> 	probing even have a complete SBI?

Hi Andrew

FWFT is not really meant to "query" information from the firmware,
fwft_set() wouldn't have anything to actually set. The problem would
also just be pushed away from Linux but would probably still require
specification anyway.

>>
>> 6. ??
> 
> I forgot one, which was v1 of this series and already rejected,
> 
>  6. Use ID registers
>     pro: None of the above cons, including the main con with the command
>          line, which is that there could be many other decisions in the
> 	 future, implying we could need many more command line options.
>     con: A slippery slope. We don't want to open the door to
>          features-by-idregs. (However, we can at least always close the
> 	 door again if better mechanisms become available. Command
> 	 lines would need to be deprecated, but feature-by-idreg code
> 	 can just be deleted.)

My preferred option would have been option 2. BTW, what are the
arguments to push away the description of misaligned access speed out of
device-tree ? that's almost exactly what the device-tree is meant to do,
ie describe hardware.

As a last resort solution, I'm for option 3. There already exists a
command line option to preset the jiffies. This is almost the same use
case that we have, ie have a faster boot time by presetting the
misaligned access probing.

IMHO, skipping misaligned access probing speed is orthogonal to
EFFICIENT_UNALIGNED_ACCESS. one is done at runtime and allows the
userspace to know the speed of misaligned accesses, the other one at
compile time to improve kernel speed. Depending on which system we want
to support, we might need to enable EFFICIENT_UNALIGNED_ACCESS as a
default, allowing for the most Linux "capable" chips to have full
performances.

Thanks,

Clément

> 
> Thanks,
> drew
> 
>>
>> I'm voting for (3), which is why I posted this patchset, but I'm happy
>> to hear other votes or other proposals and discuss.
>>
>> Thanks,
>> drew


