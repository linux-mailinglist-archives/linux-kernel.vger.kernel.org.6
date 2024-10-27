Return-Path: <linux-kernel+bounces-383437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8654F9B1BA7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 02:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FBF281730
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F340849;
	Sun, 27 Oct 2024 01:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="oLFeMNrn"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70B3BBC1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729992269; cv=none; b=gfuzeTg4lyLfdHyKqkFhDjk3lW1KPl7x2shfg9qikDdYfZnrdHV5J/MaTwEXpcRL8ccB6VC8dxvIHmucT3X9Pv9OK49ltWfn9LGGjCjYoIHeYOHTWW37j6ksKabyg7ibVqE9Zfl9vu83HsBUmdCXiYafw/8D5JOi9ADdhx/redo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729992269; c=relaxed/simple;
	bh=jKr4ODhKFp/c80oiYmxnSHMw1njLd86g86+wvyz/FxE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ODFV8xTQNxNPJUTqbSQIVEtBE09CVrtZratSASD43DRel+702SKKPiC2hYRHt+ITa8gN+14LJo9BV2OhI+Z8BqBkUcC07GQfQgQ1uzU+XMuGL58zD6VX4p/kJeRXch2CHniMCM8DqmkwC6M73PxwxknQReYqpSFGNmHr/0WnFd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=oLFeMNrn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 49R1Nqob3102471
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 26 Oct 2024 18:23:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 49R1Nqob3102471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1729992233;
	bh=pkrEahnjqYiWXa6IGypW9ZVwmCDoq041MosKJIVAPYA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oLFeMNrnPrCc+XYKDdibaXZJWMAtcgVkeQaL29YJiPDaSiIdZR0q3NyhiUHtbjAl1
	 gfBiDxTXY1BncQ+awXLHDzSLkI3n+egZsL0SLl1/vuEwNWDzdBBE/RLnSOcQRu0Ecr
	 ZJVDJqFv+tfZGpxYWV5A0IJ0yNDNMyZnSBFBYP1hGtTvj7prb5qNBB1G+feZTSMmdr
	 WdfjiSN+yliykBwxQ5HmXO+qu+JKfiFb8HEmS20B3XIQfRCzWbLP/aJyvjDB0rSyfF
	 8LmYYlegP4ERqUY+TNB2C+8TeAPEa4xFaul5e7w1z9VsFOoO6orJ9lM3PccWhG8THL
	 82/ugj79tHr0A==
Message-ID: <8475003d-d15d-4b70-abdf-1138626739e4@zytor.com>
Date: Sat, 26 Oct 2024 18:23:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/ioperm: Use atomic64_inc_return() in ksys_ioperm()
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20241007083345.47215-1-ubizjak@gmail.com>
 <be62f9c4-eca2-46bb-b566-77c0cbe1f15b@intel.com>
 <CAFULd4Yux5FPvvuvzy6C5J_LTcWsLmPaMmttH2rPvjQG-ZPMVg@mail.gmail.com>
 <12E72F30-EF1D-4A1B-9D71-3A7FD5AF343C@zytor.com>
 <CAFULd4a5+er=7xk+oXOtOsJVUqg86ZWxxvX7jdtOEBcMX60fKg@mail.gmail.com>
 <77294ea6-480b-456e-8102-6c36ed4b7b96@zytor.com>
 <3f0da3c0-22e8-4a19-9537-ac9c92b03174@zytor.com>
Content-Language: en-US
In-Reply-To: <3f0da3c0-22e8-4a19-9537-ac9c92b03174@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/24 16:38, H. Peter Anvin wrote:
> On 10/26/24 16:28, H. Peter Anvin wrote:
>>
>> By any sane definition, the constraint should actually be an input 
>> constraint on the frame pointer itself; something like:
>>
>> #define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>>
>> ... except that "r" really should be a %rbp constraint, but %rbp 
>> doesn't seem to have a constraint letter. At least gcc 14.2 seems to 
>> do the right thing anyway, though: __builtin_frame_address(0) seems to 
>> force a frame pointer to have been created (even with -fomit-frame- 
>> pointer specified, and in a leaf function), and the value is always 
>> passed in %rbp (because why on Earth would it do it differently, when 
>> it is sitting right there?)
>>
> cl
> This also matches the "tell the compiler [and programmer] what we 
> actually mean" issue that you have mentioned in other contexts.
> 
> Anyway, here is a simple test case that can be used to verify that this 
> construct does indeed work; at least with gcc 14.2.1 and clang 18.1.8 
> (the ones I ran a very quick test on).
> 
> It's simple enough that it is pretty straightforward to mess around with 
> various modifications. So far I haven't been able to trip up the 
> compilers this way.
> 

I filed a gcc bug report asking to clarify the documentation to 
explicitly support this use case:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117311

	-hpa


