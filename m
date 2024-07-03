Return-Path: <linux-kernel+bounces-239828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0574C9265D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294C21C21831
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E4181CEB;
	Wed,  3 Jul 2024 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Zu3I/VYo"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3A15B54A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023511; cv=none; b=abAFou+nt38LLiJprMSIcwT2PRPIx6bzfTsAA2sJnno19b2PdYiO3cqKamez2G5Z0Pluip2HO+JZ5ty/ArsmyXJGOu4LQ28UyjyzRiRq7jc2QD9d9PGE2AqBuM9xuIyFaJcCeZB2iq0GI0dsUn/diqGGPxRCUh4su6cIDKf7gyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023511; c=relaxed/simple;
	bh=wRzQdtHQ2GH075TAFpjh+hhxENB4+JymjYxdAKcwJ+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3GToWbqc9RkFfg/e7EKqlktmz8X8umjNcxq6YC4eezdHoRtmS2qCcYWQrxmis8Ri4BV7Iy0zAchp8etQXJs6UFBQrfgMBFeAQ+XkNbZq7uJwdv9hTXU9cqhVB9C64Uz/mZLar+mbUgZ19poKbdW+clmAMCwYy65mIdIhwhZWnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=Zu3I/VYo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c05c19261so327636985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1720023509; x=1720628309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3n2iUFhLhUbZmzmfAMb3RaI/QxJffyFxVoypOZ8Es98=;
        b=Zu3I/VYoTaPw4eUSi8Wer/l7aLmHceoOdFarCKeL7mLR3Fq525FHyg5pd5F2q914c0
         ZF1pgblzgjzxEef6ojMkQYQCDe06N1Ajtw68gyaLOQo+x3KA0Ai4/iBJ3vuqu8oQwFj7
         25Yz22kLHrCAaQuaViZIwsAfSxeDA7kyZ6eSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023509; x=1720628309;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n2iUFhLhUbZmzmfAMb3RaI/QxJffyFxVoypOZ8Es98=;
        b=OTq8z3BOf3NsaeTTQPisyepxqnWwM5SE0HIJI+hIrqym+UshUozuK2HtpJvIH0+khS
         m74q3/8amj2nZiT1/9Pko2p95+pUMPtwf1venNUmQwBWAen4Cc/5t3sES9Zy1J4BV2Np
         eb2Ae1yM5iS6nYs4fSP1zzNaLMlRr+aXLZT6ke4DZqyl4YIs3w3Jxa/YYH22vcLasbNA
         VgbtsZJQbkena3k5F+dPRdp4H7OVQpIAs2OOuOI8S1A0ujH+/nJApW4+EcHWLMod9el1
         ApJ1SMxLh5929LH/WZXq2zOqe/Q/ljratUZa4aEPKPWyMhTvPigt2MuMynuha8oMBDJ3
         qSrg==
X-Forwarded-Encrypted: i=1; AJvYcCV85MC/VisMkeykzft75c4LR2DsDdHz/J35FaQyMk0ZXHtSNtfekOzHCrHbMSSESuL9TqpUh7bevO9FLi7NWxyeOgqqFZulrJ37oNZo
X-Gm-Message-State: AOJu0Yw+3SF5AOS3q7ZQF3GTg/mO+GJUKMHDlLfxN28uDEnQ8Y+LdTN8
	64/GEt9INE7Au4IOCyggZwX/Ky1TOnKM2YLWdSa+se8WEqzFvE3+6HKeTIC7NeY=
X-Google-Smtp-Source: AGHT+IHD5yP7vgFQBi0e61QPiXdLtqtfXLfVTA+H2lyd95I8IHueVfmwljbX4VCSJOKSxnYrPV1Z/g==
X-Received: by 2002:ae9:e512:0:b0:79d:7473:f976 with SMTP id af79cd13be357-79d7b9de421mr1231082285a.23.1720023508908;
        Wed, 03 Jul 2024 09:18:28 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69308bd1sm580275585a.120.2024.07.03.09.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 09:18:27 -0700 (PDT)
Message-ID: <56909a1e-b360-4090-945e-cf6ec623cccc@citrix.com>
Date: Wed, 3 Jul 2024 17:18:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] x86/fred: Write to FRED MSRs with wrmsrns()
To: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
 dave.hansen@intel.com
Cc: xin@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 peterz@infradead.org, nik.borisov@suse.com, houwenlong.hwl@antgroup.com
References: <9063b0fe-e8f3-44ff-b323-b2b6c338690f@intel.com>
 <172002205406.3280081.14523962650685954182@Ubuntu-2204-jammy-amd64-base>
 <15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com>
 <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <AD99CE51-62B3-494D-9107-7C9093126138@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/07/2024 5:06 pm, H. Peter Anvin wrote:
> On July 3, 2024 9:00:53 AM PDT, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 03/07/2024 4:54 pm, Borislav Petkov wrote:
>>> Dave Hansen <dave.hansen@intel.com> wrote:
>>>> On 7/3/24 01:54, Xin Li (Intel) wrote:
>>>> &gt; Do FRED MSR writes with wrmsrns() rather than wrmsrl().
>>>>
>>>> A longer changelog would be appreciated here.  The wrmsrns() is
>>>> presumably to avoid the WRMSR serialization overhead and the CR4 write
>>>> provides all of the serialization that we need.
>>> Also, all those wrmsrns() writes better be behind a CPUID check.
>> They're not, in Linux.
>>
>> For the $N'th time, here is the primitive that Linux wants to stea^w
>> borrow for this to be sane.
>>
>> /* Non-serialising WRMSR, when available.  Falls back to a serialising
>> WRMSR. */
>> static inline void wrmsrns(uint32_t msr, uint32_t lo, uint32_t hi)
>> {
>>     /*
>>      * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant CS
>>      * prefix to avoid a trailing NOP.
>>      */
>>     alternative_input(".byte 0x2e; wrmsr",
>>                       ".byte 0x0f,0x01,0xc6", X86_FEATURE_WRMSRNS,
>>                       "c" (msr), "a" (lo), "d" (hi));
>> }
>>
>> ~Andrew
> I believe tglx declared to use them unconditionally since FRED depends on WRMSRNS (and the kernel enforces that.)

I know that Linux has chosen to have this as a software-enforced
requirement.

The dependency does not exist architecturally, and just because it
happens to be true on Intel processors doesn't mean it's true of other
implementations.

~Andrew

