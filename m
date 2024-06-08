Return-Path: <linux-kernel+bounces-207050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5CE9011C4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34DE1C20F08
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B317A926;
	Sat,  8 Jun 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK6JmMcY"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4B179953;
	Sat,  8 Jun 2024 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717855060; cv=none; b=Vl1pwmKN3PN+jNXzJxqRt5v9+3v04TLpZXjDnmFJsXASl7W05r46rhXKrkC/j03FVQamx8DB1CcLWwtFMFQqFDPHDbMpmEK5P6LfFMXmxHVHjfKiB8xEytCgdvAN+somT18DNNd6h028kz/MXhlk5wtctDyXPBjDLt8RGLV0l14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717855060; c=relaxed/simple;
	bh=2UM4TkAgmyxv6SDb5F+kaL1JQiFce8cl1rLs6OODL04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYKGWTSJtiLs7MauF4+yUpOxLu4/eRh+S6H/w5rjfZwOaFC4fOAcR9lChY4QPUMkv4xAtt/N1rezMNSjuOI60jlYFodvir0aGDHlie1geHcbf3rCq9viV1j3E8DtiePHQevCKob1yd1k8Q0cZ2nXSuVsYLDEKaHiHNdY5r5qw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CK6JmMcY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c5920ed3bso1361272a12.2;
        Sat, 08 Jun 2024 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717855058; x=1718459858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATHWp/dx9XNWFfxqyNzwyLWvmPFO9JtEj/8KGLy30MQ=;
        b=CK6JmMcY6G1IUJkxdD5nja9MTv9JGjXzqp25xJKS18ljXbSt04Q33eOXm+kLBdGE3c
         Mha6Miaujkoc54ZoikMKqS1rl8JozI32iH24hHlM1TeiL3MCvsF+6bkDfLBX+ST/I9rW
         ZL6LzQIY9v9o+rJ2lUMDbauBCWk2VRRpM4WGYtczqj8AlmShfmTdoVRmqN2JxxUJdOEG
         tIPVJsHRse3wNj7Cypo+tgWZ7aIKE3iC7D4jYvpECv88uDNIPPzohJN2kQWID24s6HuN
         IC8KQDWcMqbJknyZPxDW8Nc2KqoVIM6ccE8PyLoUPhu2xcFB8DyOxVP61fxK8DCCBAjP
         Mteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717855058; x=1718459858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATHWp/dx9XNWFfxqyNzwyLWvmPFO9JtEj/8KGLy30MQ=;
        b=RupLXrBfF+TJ3mtfFPjd3HE83ju5m7vxsGYZp7OHzhXb3JfI5Ci59gRQQ9xKZF41lZ
         Faw3H0V+8URkOU15OlKXk7tQfrqzJCTqVlCVe69T3njtlepXpcVcnAY9k1kpeBonF9uk
         A7TXrDADNf3Xt3OMlyIzEHGo7bWwREvnR6pNs1whZqUWVe58mYDzNzvaQEtmFWV0HIfT
         TJWQsnjWiQ6SECP1P5rXrQ2YQXQZRO4QTwYr5+v3iQgpwniyjBo51ekBKMfWapOSToYN
         IpnKVu7Wb1tKeYUW9G7G1G8YmFl7C8zR/sr2L+G29CuLP0+jcIf2fkabobaGY05if4TF
         7lQw==
X-Forwarded-Encrypted: i=1; AJvYcCXrH3eLHIvURXTTGUlYoauk5kGE5HsN0K04cTcTcCDTs729zW28H+WOEf2eVvPYI7V4NMVftBJhBoJ253TKKCEsisGuKzC8cZJTeWnbBg8=
X-Gm-Message-State: AOJu0YxtzP455vjQKc1Epl6PCJpl9QGZQKXE3CGp2SivMRNBO5FZzNyT
	UMgzFgRNLSpbIKnYRz/IR1IMmngtkNZa4mcwpgtO5GovmvOXAwgk
X-Google-Smtp-Source: AGHT+IHu1PowfDXRPVKxaC2rG5ito/4e7ETPFqVb1Wv2SDwuvHewQVtdPwJZiBgS6ziT6RxESzzQ7A==
X-Received: by 2002:a50:d50e:0:b0:579:ca97:da1b with SMTP id 4fb4d7f45d1cf-57c5084e0damr2882721a12.6.1717855057289;
        Sat, 08 Jun 2024 06:57:37 -0700 (PDT)
Received: from [10.5.1.156] (188-22-218-164.adsl.highway.telekom.at. [188.22.218.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae12ce21sm4292594a12.49.2024.06.08.06.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 06:57:37 -0700 (PDT)
Message-ID: <0a45a87f-84d1-4fb7-adaf-c612af68cd40@gmail.com>
Date: Sat, 8 Jun 2024 15:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: rust: Enable Rust support for ARMv7
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Jamie Cunliffe <jamie.cunliffe@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Sven Van Asbroeck <thesven73@gmail.com>
References: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
 <CANiq72kaVw_t=hCJ-qEr=9ybuOngAR6isnCK717dBEm7CFm2NQ@mail.gmail.com>
Content-Language: en-US
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <CANiq72kaVw_t=hCJ-qEr=9ybuOngAR6isnCK717dBEm7CFm2NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08.06.24 2:16 PM, Miguel Ojeda wrote:
> On Sat, Jun 8, 2024 at 12:30 AM Christian Schrefl
> <chrisi.schrefl@gmail.com> wrote:
>>
>> This is based on the code by Sven Van Asbroeck from the original
>> rust branch and inspired by the AArch version by Jamie Cunliffe.
> 
> Thanks for mentioning that!
> 
> (AArch64 perhaps?)

Ah yes I meant AArch64. Fixed it locally.

>> I have tested the rust samples and a custom simple MMIO module
>> on on hardware (De1SoC FPGA + Arm A9 CPU).
> 
> Very nice to have tested it in real hardware, thanks!
> 
> (Duplicate "on on").

I fixed that locally, but forgot to run format-patch again, sorry! 

>> +``arm``        Maintained        ARMv7 Little Endian only.
> 
> How hard would it be to test and maintain other versions, eventually?
> I met Jamie recently, he may have some ideas here.

I think it would just be setting the correct rust target,
but I have no hardware to test it and I think its best to
only do v7 for the initial support.

>> -BINDGEN_TARGET_arm64   := aarch64-linux-gnu
>> +BINDGEN_TARGET_arm64:= aarch64-linux-gnu
> 
> Spurious change?

I've changed that so the := aligns with the others, but I can
remove that for v2 if you want

>> +# Depending on how the architecute defines ARCH_SLAB_MINALIGN, bindgen might generate a binding.
>> +# Disable this here as there is a const that will always be generated in bindings_helper.c
> 
> Typo in "architecute". Also, I guess you mean `.h` instead. Please use
> Markdown formatting for consistency with the rest of the file.

Fixed.

>> +        panic!("arm uses the builtin rustc target");
> 
> Since ARM64 puts the name of the target in the message, it would be
> nice to do the same (or perhaps it can be removed from the ARM64 one
> otherwise).

I can add the target here but then the message would have to depend
on the sub architecture if we support v6 in the future. 

> Cheers,
> Miguel

