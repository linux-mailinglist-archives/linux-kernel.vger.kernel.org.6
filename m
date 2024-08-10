Return-Path: <linux-kernel+bounces-281655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABC094D964
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A511C21636
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E961799F;
	Sat, 10 Aug 2024 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="c3gCXSl+"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A0441F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723249548; cv=none; b=b5jAJfOXtvjeeZBZgMY5U1qx+CTiWZxjzAtrmbfBw54BYl3edqbm1VyuPBu3TaO4AfS5Szlwjf5HAmazG1g5078ZIaz5/420LxE9UbFK8LEFJHLoOGsILHoxzr31oZ3oLXUCadmXhQqpuQc3COYuJeGiB20A7lZEaO+2AuXiEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723249548; c=relaxed/simple;
	bh=9dbTp/60ijsNlmekXHkBPx8vrIXlgbHzJ+4PUJuVwGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtCo36FvoJ3e7wd+pWwyVBwHueV9sKuGm5QnorzBSTRa+I+964ziLjLpaPl7rqBCC7OL7AC1aAfgttcZ/XHhFW25dTwA07BEVf7BDBZK4TNgHdlYF5oEMrukWTsIRC2L+XqD3toq2ycRbW61dJICnfm6nfC5xrVJh1aJ1RTT7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=c3gCXSl+; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428e3129851so18535435e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1723249545; x=1723854345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A3e8YAZ7yPkxGdWrwde5O4IvdIEX+j8GB2gOQyDAPBE=;
        b=c3gCXSl+8M5j1ikHBg42cdCT6GuEsyxN5DYSOQ398HEbKskc5apS5jREmus0VEleZn
         s4Q7tsM8wGQlWn4/IKisCD7khBbWa2liJM/vVzg7i19zp/4+dzfz/V73aAFl8vk1YHQq
         W3Tq+wKRtDaK0u/lopKsEMgV6A01jHSkPZPN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723249545; x=1723854345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3e8YAZ7yPkxGdWrwde5O4IvdIEX+j8GB2gOQyDAPBE=;
        b=ZPh8Vh1+xF5Wz6ss2dBtR4x7HzbHEeFAryXJFNp+A9DMdKfNMCYlUmd9LlcqVET6F3
         zW65kcj3SfFqzDdnRy7bKsWAe6rOqvi0aeXMwGonqfqyEoRzxjULd0tVbYDeE5GpfukY
         gSN5E4XWCz1KQxzVNLbgD9zQ1EYdXm/9tgi2t7KyUqAgNz5tTrcffjaAh1Pdq8BIrFtc
         gpTClPTEzN/0Y/Ad2cOsoO1KIxxWaZ8TZ5XfMfmBFCcgQdOm5Ggf27dyrNpYWsel6rH+
         zQY9Ed/cRBOX02hlwmIbvDAmAe3AmuzsxeaRSfDzJgvJ/+lmiyglxgVGwjme1yS3fq/X
         dWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo430AKfKzFSFWX2sN/7bcaECBjENmhRZr3/BkLPHzFphyDMb9mjKT8ISnYeufUdWqYB1xP3ycGB5VOkZfmXDH8GXy1G64ciQCwnPW
X-Gm-Message-State: AOJu0Yw+ikyTuHT85toSsFQJEladgclrQl9/hxpw3Q57yIhvFZaElP2m
	ZyER0AUr7tt7+ivysGrKM9o9AKJQOM4Ny3Y7qkCEUBnSuLYSRfsoS3pFl7p396I=
X-Google-Smtp-Source: AGHT+IG1DlgjtmjyHCM/KXF5qUp3RH+TjYrTlE4X7JkPdmMUi1e5x5V1LBcno8KF3x695ID6qZL5og==
X-Received: by 2002:a05:600c:1392:b0:426:6960:34b0 with SMTP id 5b1f17b1804b1-429c3a1c3d0mr18951565e9.14.1723249544571;
        Fri, 09 Aug 2024 17:25:44 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c779d1csm92733185e9.34.2024.08.09.17.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 17:25:44 -0700 (PDT)
Message-ID: <edb22f52-0160-412b-8230-61a85fd62fa9@citrix.com>
Date: Sat, 10 Aug 2024 01:25:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
To: "H. Peter Anvin" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
 seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <81CE6282-4791-42AB-9A51-4535E094D67C@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <81CE6282-4791-42AB-9A51-4535E094D67C@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/08/2024 1:01 am, H. Peter Anvin wrote:
> On August 9, 2024 4:07:35 PM PDT, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> On 07/08/2024 6:47 am, Xin Li (Intel) wrote:
>>> From: Andrew Cooper <andrew.cooper3@citrix.com>
>>>
>>> Per the discussion about FRED MSR writes with WRMSRNS instruction [1],
>>> use the alternatives mechanism to choose WRMSRNS when it's available,
>>> otherwise fallback to WRMSR.
>>>
>>> [1] https://lore.kernel.org/lkml/15f56e6a-6edd-43d0-8e83-bb6430096514@citrix.com/
>>>
>>> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
>>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>>> ---
>>>  arch/x86/include/asm/msr.h | 28 ++++++++++++++--------------
>>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
>>> index d642037f9ed5..3e402d717815 100644
>>> --- a/arch/x86/include/asm/msr.h
>>> +++ b/arch/x86/include/asm/msr.h
>>> @@ -99,19 +99,6 @@ static __always_inline void __wrmsr(unsigned int msr, u32 low, u32 high)
>>>  		     : : "c" (msr), "a"(low), "d" (high) : "memory");
>>>  }
>>>  
>>> -/*
>>> - * WRMSRNS behaves exactly like WRMSR with the only difference being
>>> - * that it is not a serializing instruction by default.
>>> - */
>>> -static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
>>> -{
>>> -	/* Instruction opcode for WRMSRNS; supported in binutils >= 2.40. */
>>> -	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
>>> -		     "2:\n"
>>> -		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>>> -		     : : "c" (msr), "a"(low), "d" (high));
>>> -}
>>> -
>>>  #define native_rdmsr(msr, val1, val2)			\
>>>  do {							\
>>>  	u64 __val = __rdmsr((msr));			\
>>> @@ -312,9 +299,22 @@ do {							\
>>>  
>>>  #endif	/* !CONFIG_PARAVIRT_XXL */
>>>  
>>> +/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
>>> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
>>> +
>>> +/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
>>>  static __always_inline void wrmsrns(u32 msr, u64 val)
>>>  {
>>> -	__wrmsrns(msr, val, val >> 32);
>>> +	/*
>>> +	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
>>> +	 * DS prefix to avoid a trailing NOP.
>>> +	 */
>>> +	asm volatile("1: "
>>> +		     ALTERNATIVE("ds wrmsr",
>> This isn't the version I presented, and there's no discussion of the
>> alteration.
>>
>> The choice of CS over DS was deliberate, and came from Intel:
>>
>> https://www.intel.com/content/dam/support/us/en/documents/processors/mitigations-jump-conditional-code-erratum.pdf
>>
>> So unless Intel want to retract that whitepaper, and all the binutils
>> work with it, I'd suggest keeping it as CS like we use elsewhere, and as
>> explicitly instructed by Intel.
>>
>> ~Andrew
> I looked around the kernel, and I believe we are inconsistent. I see both 0x2e (CS) and 0x3e (DS) prefixes used for padding where open-coded.
>
> We can't use cs in all cases, since you can't do a store to the code segment (always readonly) so we use 0x3e (DS) to patch out LOCK.
>
> In the paper you describe, it only mentions 0x2e as a "benign prefix" in a specific example, not as any kind of specific recommendation. It is particularly irrelevant when it comes to padding a two instructions to the same length as the paper deals with assignment. 
>
> If you want, I'm perfectly happy to go and ask if there is any general recommendation (except for direct conditional branch hints, of course.)

It would be lovely if there could be a single coherent statement.

In addition to store semantics, off the top of my head:

* CS is the P4 hint-not-taken (presumably Jcc only), ignored now.

* DS is both the P4 hint-taken (presumably Jcc only), newly reintroduced
in Redwood Cove with tweaked semantics (definitely Jcc only), and the
CET notrack prefix (JMP/CALL *IND only).

Plus whatever else I've missed[1].

~Andrew

[1] I'm ignoring XuCode mode memory operand semantics as not relevant to
CPL0 software (where AIUI unprefixed is physical and DS prefixed is
virtual) but I'm noting it here to highlight that there's definitely
extra complexity beyond what is in SDM Vol2.

