Return-Path: <linux-kernel+bounces-326568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A3976A30
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240431C23608
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C71A76A4;
	Thu, 12 Sep 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="c6dvfLXD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FF1A7061
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146793; cv=none; b=mIW24Hy+MIhTh5Wt3xy+5LJwboE5mDQCyHHOZhQuHlsLzsBb1LevyGitkPanDwP7CRzJxCNAG3rfiFItRik2WQJUFu57DtZTPIW/HJ50A1/g0F0XkCkBar+F/eF5iBGtBGnsFtLMJKFZaAkrV4/TIMbJ5HpIpG/U6bddWo66/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146793; c=relaxed/simple;
	bh=4+7eZ70TRmzASDW1zhj5ubGF6PkABNVC+DSVigxTwNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqYCNYPX31QbbBlIVvZo9aXDzP8eQradJXCTWZBjwiAHsb0N6xzAoexZ63zpVUsKmEQFqezC/BJlsaq3OqW8UyBFC8j/l23iRh/U+yhcpdWEcUX33Y/wT0x2FLqaxtz1yNcNTIFNVI1iZEk83qUl81CSiDiqQUMaCtxZDGlhr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=c6dvfLXD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e663fso1099825a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1726146789; x=1726751589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4+7eZ70TRmzASDW1zhj5ubGF6PkABNVC+DSVigxTwNM=;
        b=c6dvfLXDm5jWuKbP+ug/MW/Mja7LaYyYrUYef5K+sUPRBWGaRKb8F+vINpEH3PGdFO
         P9W+GOZbodVHRnfFUGkZxDzeNYa3Hh7V0WfAugTSu62zWTGPueXgEBIuvq2kOFE0dc0z
         KMOea5Q6Pk+0z2e2ZY0E3r24fRNuTDh7J7nhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726146789; x=1726751589;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+7eZ70TRmzASDW1zhj5ubGF6PkABNVC+DSVigxTwNM=;
        b=WvwIqaO4tgI3vk9Y4CdRyViNAHI49uCQ31FABgVjqoq9wlNXTU5wp35pgEHlPyo8qc
         NhFsBh+Kb8+mmicK2fvT213fctdvjn3UZ1L0VvByNUIgGyj+4CXN1QLgvd/a08L62fE9
         wr9MmqsuTvHhe5AzEJqZcsd6oV2RTiux6BPF4PK5IGFFDGRmB4GaxcERScXLh3k8UZ4N
         3kVBFPuAwxE4Zru1mcEKOwsEYNSUHoQxwqGynJwRvVJcOIM4XQK3MXxV5VdMILCoAnbh
         6ALjTm/FHQD97oh4jCgJp9cmbCTulfXbqTFtjR9Q8iE5m7bmlCERbZnR/BbDGZN6Y0PY
         G9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVL+VZ0H4D+ucXPRUf4/w1hpO/IT5GAw6+xJvMJHUlvQL1WfvBRmuOOcu1MgYiiiRIguNfBQafn+Pf+XbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDLVetnSjDJJJKfAA6UBPI+oAZ55Id4EHG/cSpMg/Y8yluc1jN
	FhL4g+cnRK4CfFPPD6UUtCJYDWv61/vzwnObVHRUCANmKuxOd78e+0D2yFiNTVezoQwXrGA8hPb
	E
X-Google-Smtp-Source: AGHT+IEGKNjoO+cEr/aUpYt+VOilbB1ausyOk8IHkyVIOxwe4xjEEivouHdmZ4YLFcRSn6yw+6Y69g==
X-Received: by 2002:a17:907:d859:b0:a8d:555f:eeda with SMTP id a640c23a62f3a-a90294a9cedmr300875566b.8.1726146789173;
        Thu, 12 Sep 2024 06:13:09 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c80a24sm746873166b.137.2024.09.12.06.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 06:13:08 -0700 (PDT)
Message-ID: <8f0bd469-ebd7-4487-9518-1e93368e5318@citrix.com>
Date: Thu, 12 Sep 2024 14:13:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Clear the WFE bit in missing-ENDBRANCH
 #CP
To: Xin Li <xin@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org
References: <20240911231929.2632698-1-xin@zytor.com>
 <3328e53d-b0f2-4516-a6a6-51ca33642683@intel.com>
 <676eb52a-5d9f-4204-9e79-15c1d7dc2b08@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <676eb52a-5d9f-4204-9e79-15c1d7dc2b08@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/09/2024 9:53 am, Xin Li wrote:
> On 9/11/2024 5:22 PM, Dave Hansen wrote:
>> On 9/11/24 16:19, Xin Li (Intel) wrote:
>>> +/*
>>> + * The WFE (WAIT_FOR_ENDBRANCH) bit in the augmented CS of FRED
>>> stack frame is
>>> + * set to 1 in missing-ENDBRANCH #CP exceptions.
>>
>> I think there's a bit of relatively irrelevant info in there.  For
>> instance, I don't think it's super important to mention that FRED is
>> involved and where the WFE bit is in memory.
>>
>> FRED's involvement is kinda a no-brainer from the whole X86_FEATURE_FRED
>> thing, and if you're reading exception handler code and don't know that
>> 'regs' is on the stack, this probably isn't the place to explain that.
>
> I often find myself in a dilemma, should I mention some technical
> background which sometimes could also be distracting :(
>
> Based on your feedback, maybe the following is better?
>
> static void ibt_clear_fred_wfe(struct pt_regs *regs)
> {
>     if (regs->fred_cs.wfe)
>         regs->fred_cs.wfe = 0;
> }

static void ibt_clear_fred_wfe(struct pt_regs *regs)
{
        regs->fred_cs.wfe = 0;
}

would be better.  With any luck, the compiler would drop the if() on
your behalf, but it would still be better not to have it to start with.

>
> And we know only FRED hardware will set the WFE bit.
>
>>
>>> + * If the WFE bit is left as 1, the CPU will generate another
>>> missing-ENDBRANCH
>>> + * #CP because the indirect branch tracker will be set in the
>>> WAIT_FOR_ENDBRANCH
>>> + * state upon completion of the following ERETS instruction and the
>>> CPU will
>>> + * restart from the IP that just caused a previous
>>> missing-ENDBRANCH #CP.
>>> + *
>>> + * Clear the WFE bit to avoid dead looping due to the above reason.
>>> + */
>>> +static void ibt_clear_fred_wfe(struct pt_regs *regs)
>>> +{
>>> +    if (cpu_feature_enabled(X86_FEATURE_FRED))
>>> +        regs->fred_cs.wfe = 0;
>>> +}
>>
>> Can I suggest a slightly different comment?
>>
>> /*
>>   * WFE==1 (WAIT_FOR_ENDBRANCH) means that the CPU expects the next
>> ERETS
>>   * to jump to an ENDBR instruction. If the ENDBR is missing, the CPU
>>   * raises a #CP.
>>   *
>>   * Clear WFE to avoid that #CP.
>>   *
>>   * Use this function in a #CP handler to effectively give the next
>>   * ERETS a free pass to ignore IBT for a single instruction.
>>   */
>>
>> I think original comment really needs a "How do I use this?" sentence or
>> two.
>>
>> A comment at the call site also wouldn't hurt:
>>
>>       if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)){
>>           regs->ax = 0;
>> +        /* Disable IBT enforcement for one exception return: */
>> +        ibt_clear_fred_wfe(regs);
>>           return;
>>       }
>>
>> I'm finding it kinda hard to concisely differentiate between the
>> "disable IBT at one ERETS" and "disable IBT forever", but I hope this
>> sounds good to folks.
>>
>
> My understanding is that a missing-ENDBRANCH #CP is triggered in two
> steps:
>
>     1) Upon completion of an indirect call/jmp, or an event return
>        instruction, the CPU indirect branch tracker is put in the
>        WAIT_FOR_ENDBRANCH state.
>
>     2) As the CPU is in WAIT_FOR_ENDBRANCH state, if the instruction to
>        be executed is ENDBR, the CPU indirect branch tracker exits
>        WAIT_FOR_ENDBRANCH state, otherwise a #CP is generated.
>
> So this is more of "preserve WAIT_FOR_ENDBRANCH state" or not.
>
> IDT is unable to preserve WAIT_FOR_ENDBRANCH state when returning from
> event handling, which as Andrew mentioned is a security hole.

I just said hole, but that was the subtext :)


But yes - mentioning ERETS is unhelpful; it's not relevant, and it
confuses how this works.

In a FRED world, WFE will be restored for the interrupted context.  Then
there's an instruction boundary (normal #RESET/MC/INIT/INTR processing),
and only on decoding the next instruction might a #CP[endbr] be raised.

WFE is a state that crosses an instruction boundary.  It is very similar
to EFLAGS.RF, existing to alter the behaviour of the *next* instruction.

~Andrew

