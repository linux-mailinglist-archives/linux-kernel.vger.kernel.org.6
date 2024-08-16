Return-Path: <linux-kernel+bounces-290226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7A89550F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15F11F2277F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F31C37B4;
	Fri, 16 Aug 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BLmCyobg"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B4E7DA90
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833612; cv=none; b=kcCpQXylcgCASWBbgWsMZP6TfZCj0bPnNHLy5WjkW5hXoETxs25bhUcrpTaa/SXl9JFOMViEzwsCyauXQz/ib+h5SLYt9yDKV6mcTvaMBbjcIM21RBNnFHqD5jsoB0F4bDk5hrwC+7FFXhM0KQ9b85xsxWuPEuTMBzB2W7PKqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833612; c=relaxed/simple;
	bh=gDHYEQT8Cqhj6IeZ2Y1cCI9cD5rvx4Ka+myG+mT3dfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nx6oywaGlBJjs5l1euS1nZL3UICW7k/dGfnNTcRGc2+HnB+A93hIkQClBoCVA727YHzsM7jY00PLa/SrOYaUbHr17yhAmnSA5ZJ6widLGfCY902OFgocYhSRbZTBaeQ/znp8E4ibHxndrq/v+n43o5eMOVXqFrKh9qoLhkqVpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=BLmCyobg; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d608060241so1403517eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1723833609; x=1724438409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gDHYEQT8Cqhj6IeZ2Y1cCI9cD5rvx4Ka+myG+mT3dfw=;
        b=BLmCyobgaNG0QiftBg0wwzGlX4D1Akp7DcYbOTOYZ57ZO9iKhIm46kexLtvqfuFoxv
         SdFLMpOHuu7FCYZ2qxEP6jJwj8P5FHNt1TJ1SxsavCs1Nr7is2+BQRN98Zub+Zz5qYTz
         tBbM6w5UcAjqfWdoQWoPEGmqGLcs/V70CYcfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833609; x=1724438409;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDHYEQT8Cqhj6IeZ2Y1cCI9cD5rvx4Ka+myG+mT3dfw=;
        b=dDIEPtlJKAjw1e0oPOhT1bvqfchgX9ssYlI+0cvnnrSiVDmVds0Kl41C8PUGI1vFhN
         fjxpolPHtv55raZlakzdy0kC8i+mfJIUP96lDRq5U9MunKsBdz/9d83kXR9eykSAlmR9
         SqdqsWguJl/tXx/zwqQhurUPoOfyX9qmDluuK0E1+lJgC512C4131WS8EX9X9Y9dyQ/O
         v9ia/ynkta/bi0NB24sU3ysMwxgIhAaVteCHBGX7Lf9NdmViRnmiolWfdNvYr1GgOZ1x
         34n375a5CckxBsDQvf7+xAOz1tTeDM6nb0Lx5/3trTx749bm1ewyiqQWH96i/h84Guk/
         U/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHfE9XsDtXOn5xzivtsSQhkIalofBCi/t8Xni0au54j0mcjW/EAyF8iVPq3cKkJkLo1w3st6Gp1DO0u8kpWCfFEP28oETTZDyN3OVp
X-Gm-Message-State: AOJu0YwitK4ZCK2t4euP12XPQfnXHiNVpfVXO5tzz0ZVB9ibh5aMV0wh
	gvmXOL3B940XCawGhXqQJNSSP9TPQvzomtIOZu2QTz6j1RH6mCDTgRGEkR7zNoU=
X-Google-Smtp-Source: AGHT+IHSBX2ozm68XCTxX41BIZlnF5f1sgB55Xdd1xkM4giwsU6lnyS61sBSkN/jIkgvA27cudZvpg==
X-Received: by 2002:a05:6358:528a:b0:1b1:acf1:3272 with SMTP id e5c5f4694b2df-1b3931c0ce6mr515687355d.18.1723833608731;
        Fri, 16 Aug 2024 11:40:08 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm203323285a.74.2024.08.16.11.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 11:40:07 -0700 (PDT)
Message-ID: <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com>
Date: Fri, 16 Aug 2024 19:40:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, seanjc@google.com
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/08/2024 6:52 pm, Xin Li wrote:
> On 8/9/2024 4:07 PM, Andrew Cooper wrote:
>> On 07/08/2024 6:47 am, Xin Li (Intel) wrote:
>>> From: Andrew Cooper <andrew.cooper3@citrix.com>
>>> +/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
>>> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
>>> +
>>> +/* Non-serializing WRMSR, when available.  Falls back to a
>>> serializing WRMSR. */
>>>   static __always_inline void wrmsrns(u32 msr, u64 val)
>>>   {
>>> -    __wrmsrns(msr, val, val >> 32);
>>> +    /*
>>> +     * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a
>>> redundant
>>> +     * DS prefix to avoid a trailing NOP.
>>> +     */
>>> +    asm volatile("1: "
>>> +             ALTERNATIVE("ds wrmsr",
>>
>> This isn't the version I presented, and there's no discussion of the
>> alteration.
>
> I'm trying to implement wrmsr() as
>
> static __always_inline void wrmsr(u32 msr, u64 val)
> {
>     asm volatile("1: " ALTERNATIVE_2("wrmsr", WRMSRNS,
> X86_FEATURE_WRMSRNS,
>                      "call asm_xen_write_msr", X86_FEATURE_XENPV)
>              "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
>              : : "c" (msr), "a" (val), "d" ((u32)(val >> 32)),
>              "D" (msr), "S" (val));
> }
>
>
> As the CALL instruction is 5-byte long, and we need to pad nop for both
> WRMSR and WRMSRNS, what about not using segment prefix at all?

The prefix was a minor optimisation to avoid having a trailing nop at
the end.

When combined with a call, you need 3 prefixes on WRMSR and 2 prefixes
on WRMSRNS to make all options be 5 bytes long.

That said, there's already a paravirt hook for this, and if you're
looking to work around the code gen mess for that, then doing it like
this by doubling up into rdi and rsi isn't great either.

My suggestion, not that I've had time to experiment, was to change
paravirt to use a non-C ABI and have asm_xen_write_msr() recombine
edx:eax into rsi.  That way the top level wrmsr() retains sensible
codegen for native even when paravirt is active.

~Andrew

