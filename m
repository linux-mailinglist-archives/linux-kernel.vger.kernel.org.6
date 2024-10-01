Return-Path: <linux-kernel+bounces-345769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FDB98BADC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4541C223C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1F1BF7FA;
	Tue,  1 Oct 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="PAX5vs21"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50921BF7E0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781608; cv=none; b=nOhtv1jM0OuZTFd5XTR8gEvLBYsPpjrwakMfJ5p/GXYwFzSxb/5KqTX/rw54iLaf0gWKDyTH/dGH7g/X1d5/7GLNjrNqOSTLyso6kOrjuuVJo4hXOZ9VBDusjfKUQ4SbtNm9qszxKc58cfGKG3euLLjC3I7QaMa03x9cJpeod0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781608; c=relaxed/simple;
	bh=0lJ8tGhQUvC0lDiNseeSWfZbFB5mEdDQwiZukR0m9KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwn5oDYQCRPlJ8jYoPzWwRNdPwCK2OO9kHCzorLoijtem2MpcHN+Sur20E2e4xL2ae95C9DAxHhMIetcQlhkBEGxdF8VZQz5GO8u8IVPe6ZlE8JANzQE6C50Y0ciXRtpUFbsotTIum4FGiW6iBjXGgP57Nhbd9494y3OGs+fQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=PAX5vs21; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93b2070e0cso651800066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1727781605; x=1728386405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mrTXiTq66Ww/zVqd8Z0PbCUEKMoA0jEVCGznKvT1aik=;
        b=PAX5vs21tIu5f3gLENJNI6d3Oa4rJUuE3FWjk6w1gyqdJTOtGvO2rJLJjZp+dd3faR
         pxqRkR8stBchKvIO1OxTmO1WvHgjlYZhJHQJw7oQTRtwgtTwmoJypIGnJKvHGak1FEQT
         hB2TL/HmeW2rACMyRHbQUADp2QcyWl6fNXFiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727781605; x=1728386405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrTXiTq66Ww/zVqd8Z0PbCUEKMoA0jEVCGznKvT1aik=;
        b=sW+28X17wxm0zHitFH4UIGzVdCS6wSItKr7VV/Prrnig1fDsiHkpgErFmskxqr3NnV
         3zSO5ESKPR/Tvtf0K0os0crHc0o5TM+55Qy11tZhHaVM/PirZqfLFaUZB+PpO20Cx346
         LdIhHXSsBMlytXc2PH/BWtbySLPnIyBJ5bsIvCG6/IBeo63wCttIP5MwXJi0bSozn9Zv
         zsidLZpx16t+Kr+ODyOrzsDJ+a5Sq+TSQ+BIGzTaSaECblIk4SkS+XowSM/ig6cmtYfC
         LutDT4DkViaZFFXUBspTJtQ6D4HG3v671va4ruKMHPjVp+q0Eb5+54f/z5WqsVMVjnGQ
         jQxg==
X-Forwarded-Encrypted: i=1; AJvYcCUz4fa2pt4FNfU8EPVZftWz+wL+KCb1xSCrcfM5PY8aCDu9rG2oxV2sgFnZ+ddVMCjBImlDayTxjf2UKOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyewINMVnThRe8+8cfT69csHFp5UPpwxe6z1b3PkupYNL5iBXQ/
	thcLl++95Dhcd9nIFf38CV4kJSOwFpCsKyIPLwLJ5k1t6ZbIRd3c+uu1ZoMDvkQ=
X-Google-Smtp-Source: AGHT+IErgGD0s93bEYP4KkRxMT8biQfI7RscfldWTtarYgSFFRnS/mKRfxJVOgvJ2ENU9xOK9mGS4A==
X-Received: by 2002:a17:906:4fc6:b0:a8d:6648:813f with SMTP id a640c23a62f3a-a93c48f14a8mr1773585466b.3.1727781605032;
        Tue, 01 Oct 2024 04:20:05 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2776d92sm688817266b.29.2024.10.01.04.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 04:20:04 -0700 (PDT)
Message-ID: <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com>
Date: Tue, 1 Oct 2024 12:20:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] x86: BHI stubs
To: Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
 scott.d.constable@intel.com, joao@overdrivepizza.com,
 jose.marchesi@oracle.com, hjl.tools@gmail.com, ndesaulniers@google.com,
 samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
 kees@kernel.org, alexei.starovoitov@gmail.com
References: <20240927194856.096003183@infradead.org>
 <20240927194925.707462984@infradead.org>
 <20240930213030.ixbsyzziy6frh62f@treble>
 <54d392d3-32b3-4832-89e1-d2ada1af22a8@citrix.com>
 <20240930223848.ulipiky3uw52ej56@treble>
 <20241001110310.GM5594@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241001110310.GM5594@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/10/2024 12:03 pm, Peter Zijlstra wrote:
> On Mon, Sep 30, 2024 at 03:38:48PM -0700, Josh Poimboeuf wrote:
>> On Mon, Sep 30, 2024 at 11:23:38PM +0100, Andrew Cooper wrote:
>>> On 30/09/2024 10:30 pm, Josh Poimboeuf wrote:
>>>> On Fri, Sep 27, 2024 at 09:49:09PM +0200, Peter Zijlstra wrote:
>>>>> +SYM_INNER_LABEL(__bhi_args_0, SYM_L_LOCAL)
>>>>> +	UNWIND_HINT_FUNC
>>>>> +	cmovne %r10, %rdi
>>>> IIUC, this works because if the "jz" in the CFI preamble mispredicts to
>>>> the __bhi_args_* code, "cmovne" will zero out the speculative value of
>>>> rdi.
>>>>
>>>> Why use %r10 instead of a literal $0?  Also how do you know %r10 is 0?
>>> There's no encoding for CMOVcc which takes an $imm.
>> Ah.
>>
>>> %r10 is guaranteed zero after the FineIBT prologue
>> If the "jz" in the FineIBT prologue mispredicts, isn't %r10 non-zero by
>> definition?
> Since I just wrote the comment...
>
>  * FineIBT-BHI:
>  *
>  * __cfi_foo:
>  *   endbr64
>  *   subl 0x12345678, %r10d
>  *   jz   foo-1
>  *   ud2
>  * foo-1:
>  *   call __bhi_args_XXX
>  * foo+4:
>  *   ... code here ...
>  *   ret
>  *
>  * direct caller:
>  *   call foo+4
>  *
>  * indirect caller:
>  *   lea foo(%rip), %r11
>  *   ...
>  *   movl $0x12345678, %r10d
>  *   subl $16, %r11

A compiler would normally spell this:

    lea foo-16(%rip), %r11

>  *   nop4
>  *   call *%r11
>
> And lets take a random bhi function:
>
> +       .align 16
> +SYM_INNER_LABEL(__bhi_args_0_1, SYM_L_LOCAL)
> +       UNWIND_HINT_FUNC
> +       cmovne %r10, %rdi
> +       cmovne %r10, %rsi
> +       ANNOTATE_UNRET_SAFE
> +       ret
> +       int3
>
> So the case you worry about is SUBL does *not* result in 0, but we
> speculate JZ true and end up in CALL, and do CMOVne.
>
> Since we speculated Z, we must then also not do the CMOV, so the value
> of R10 is irrelevant, it will not be used. The thing however is that
> CMOV will unconditionally put a store dependency on the target register
> (RDI, RSI in the above sequence) and as such any further speculative
> code trying to use those registers will stall.

How does that help?

The write dependency doesn't stop a dependent load from executing in the
shadow of a mispredicted branch.

This is why SLH forces the pointer to 0 on the bad speculation path.

~Andrew

