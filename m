Return-Path: <linux-kernel+bounces-181134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5028C77DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC13E2855F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BEE147C6D;
	Thu, 16 May 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="l24/JPA3"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFF1474AA
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715866940; cv=none; b=fdQJt3sgcL99pV/+1OZRrSg5SqPYVtHb4RMOV0eyzxx5I9c/G4lq8Kc3HyQw+Y8+M8/wpImxLQmA6KPR8hHJ2oR/xcNBHtT3Umr4pJZswkOaudkAJoXgUNpYBK4I0SfMopqTo6UnrpkysMS0Iq+0k2X1Os9x3WwfZZYqa+G1fPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715866940; c=relaxed/simple;
	bh=151v6rdvho1G17EjfT9Y0O8i7FboV1qw+Oer60H+nIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8ERzkPAgYS4YNm7JzZdwycf7WWcpDYGTeYbuIPltV77DAe1qp5GlCS3fBMSaQLqUKKzkWcshMkcVJK7p2zzfzjXHL+LsY372HNC0nrjsv94xlbZot1wHpKtMytvqEBaeKEHSGV2+5GjgxZ7O0t9WXXCGUXkhvoR0i2UdTkJJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=l24/JPA3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e428242a38so10227791fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1715866936; x=1716471736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiFTd9vLC+WBmXaWz0Ro0gtEC5QRTIQUDbpfIDLM78A=;
        b=l24/JPA36AGbCxTwroMK+zy079h2G60NtDl6QwrmwU/TrOapfKcvECCuEWDmRAjsyX
         0VLngo78cN+iC3+atwtWfJJzg0TihKgLBEdbk+IcJnDpCT24G5gcmRgZl+4HiGGGAvzV
         dZlbk5nEK6nyEM55gn8YvpwFN/UQMC1AqSNrMD8u4VuS4JX26OUXbhhd74YjQw1gsJ4T
         97f6GJpT4GWX7522ggexMfhILpXXCRec0AxhLJ1sQL607Fh0Z/teEU2CmLUfI6wGnd0j
         Qe4YAPsw19qQZiLtXnYbFZC1pXjBM2ko4htKdz5pITYNCsFfr4ry35Z3ZqIkCKmqw0/T
         KAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715866936; x=1716471736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiFTd9vLC+WBmXaWz0Ro0gtEC5QRTIQUDbpfIDLM78A=;
        b=t0b0IxOx7lIO9mVqXaF6IMwBqoFYi9euaZNJ8ky+7zdHRZijbICXeh5I/7lLXbG/cj
         7sBltpbhVS68EEVI5Qzra9EJ0aS4amlJYlIo5cA+YAht+dh+TppnHV0hG2hGL/raOumW
         kPq9+naMWpoonLSzDdmgFuX5oEC/P12M9jCyBxrQw8DO0M8zY5A9cluwtZhs6Opjr5QR
         cwvKgGd6SMHFZ3xUyIO4uUxEM+muA7WDzKMllLQMRDCEIBwT7t4RHcgmHYnNTWoq0f7V
         s/5Q0nH8MkF74vAn+OK/MwPFaGbU1qWKI5Q2KSXjXBxV6gns6ccvp4QjanviiB4sLztg
         GKlA==
X-Forwarded-Encrypted: i=1; AJvYcCW08ODCRXCNRjSmzBaAVhJFSojEBVlmkcBDyLgq4B772Pk/IVvW03MTBvBvSST6LeXKWfz4ynfq7m9yxU/lfvWzw/0Y0xFmvxff49w0
X-Gm-Message-State: AOJu0Yy8dVw5L0Rb3TPQHGBv06li26U/RdYurtufvAJoFN6adBZ4IAWG
	lwa8b7WG36FO21jKB6TRg8YOyEqaeIooVzU4VjUakM2a6PDF8cN9x2kd7rtCIyY=
X-Google-Smtp-Source: AGHT+IHMVWL5FCeucAox6jSM5BC3F6ELEMd53V+fH6IyH7uugBQxemkHfOIOLVukBEROZInnopv+QA==
X-Received: by 2002:a05:6512:234f:b0:51f:2f5a:54ae with SMTP id 2adb3069b0e04-5220fc7c5e0mr22121911e87.7.1715866936263;
        Thu, 16 May 2024 06:42:16 -0700 (PDT)
Received: from [10.0.1.129] (c-922370d5.012-252-67626723.bbcust.telenor.se. [213.112.35.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52399de9832sm658502e87.7.2024.05.16.06.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 06:42:16 -0700 (PDT)
Message-ID: <bea0a088-f9f0-4fc8-8235-ebc0ee42ad16@cryptogams.org>
Date: Thu, 16 May 2024 15:42:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: X25519 low-level primitives for ppc64le.
To: Michael Ellerman <mpe@ellerman.id.au>, Danny Tsen <dtsen@linux.ibm.com>,
 linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
 <20240514173835.4814-2-dtsen@linux.ibm.com> <87a5kqwe59.fsf@mail.lhotse>
 <89e7b4b0-9804-41be-b9b1-aeba57cd3cc6@cryptogams.org>
 <875xvevu3h.fsf@mail.lhotse>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <875xvevu3h.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>>>> +.abiversion	2
>>>
>>> I'd prefer that was left to the compiler flags.
>>
>> Problem is that it's the compiler that is responsible for providing this
>> directive in the intermediate .s prior invoking the assembler. And there
>> is no assembler flag to pass through -Wa.
> 
> Hmm, right. But none of our existing .S files include .abiversion
> directives.
> 
> We build .S files with gcc, passing -mabi=elfv2, but it seems to have no
> effect.
> 
> So all the intermediate .o's generated from .S files are not ELFv2:
> 
>    $ find .build/ -name '*.o' | xargs file | grep Unspecified
>    .build/arch/powerpc/kernel/vdso/note-64.o:                        ELF 64-bit LSB relocatable, 64-bit PowerPC or cisco 7500, Unspecified or Power ELF V1 ABI, version 1 (SYSV), not stripped

I would guess that contemporary linker is more forgiving than it was 
back then when the .abiversion directive was added. If it works now, 
then it of course can be omitted. I suppose my original remark should be 
viewed rather as "you can't replace it with a command line option" than 
"you can't make it work without it." :-)

> But the actual code follows ELFv2, because we wrote it that way, and I
> guess the linker doesn't look at the actual ABI version of the .o ?
> 
> So it currently works. But it's kind of gross that those .o files are
> not ELFv2 for an ELFv2 build.

Well, as far as passing base types and pointers to/from assembly goes, 
there are no differences between the versions. Then it's a question of 
meaning assigned to r2 and r13, but as long as you don't touch them, you 
can freely reuse the code with either ABI. With this in mind the 
abiversion directive is effectively reduced to just a marker in the .o 
file. In other words the instruction sequences by themselves are 
customarily ABI-neutral, at least in "general calculation" modules such 
as the suggested one, so that if it works 100% without the .abiversion 
directive, then it can be safely omitted.

Cheers.


