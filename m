Return-Path: <linux-kernel+bounces-349102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F998F0E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF44B21193
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB719CC3D;
	Thu,  3 Oct 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="B6N4RNbI"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C51547DC
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963958; cv=none; b=XrDfumxIvnybifmpI6U8rbYWE0/+RpPXkjf+Ts4S6uI57wb7buzz7Sn0HmKBA+pI3bIDyTiGIKJ2h3TEWl/pjsgMNUes9DmWuK4TiNG9RAyJ0PATSejyWvPvsPDvTiy3P0x2QDgsoIYEq/fGC6rvWlaLSNeeYlD1NhcGpjis3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963958; c=relaxed/simple;
	bh=johZ1kr0oOFaMvRWVYRpgrJTdMlrLHwxp9R/FUa4lRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fusEuQXY/M+HaucsnlDTy97SMWnhVF9+E6zn6wTKHKv6UG5jiQ73kp+Rx7ffS9wVk5oCbf68nP/mgHw3pzNi0bd7LhF/Easdd/R+S37cvVeh85aDngKoRMW0onPlBxHm/Fkp0VzYU5aXNZc10avxvVn56NU/lmjk8HsUdbLm1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=B6N4RNbI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a90349aa7e5so140199666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1727963954; x=1728568754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9BStxq1Hl17yI8hR103d1fCQk0YmZDlfuS5gAmx6XRQ=;
        b=B6N4RNbIDgTnjKWQaXOyQ55sZeHM648GSLJggJTQg2pfqpFCGnbFhea1fonAKLrpdb
         sAkS9VPyMQ25RQ5DznsnHMYnsaaQXIqYFYL2PZ4TKSNv+lzWQFWXyUI648u0dQbtu1lp
         Np1lebImhTxNZpdzFzXPW5athGi8SuZJittmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727963954; x=1728568754;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BStxq1Hl17yI8hR103d1fCQk0YmZDlfuS5gAmx6XRQ=;
        b=XXi19Ofx9eFd7nCzqu/moqORrzLqcqlwy61uqb9E+foOdwZlnADQVm2fY6+jxsvfEw
         DqwjqpNnlb75W8h6YuTLmpADqBgNpW0bVcQzPXR9AZiXnEU2S99i4suqOGDoJsf5YJj8
         7JIMY30YjLKHqMjBP7PiD1RUhBXejiMNETfh4i4CqAwzB5o1Y1Tt2H6aFwtidywTdh/R
         wYE8wM1RN/ayTsdN5VP9DOByr8ILLR83bNes+rb+6HWWA8g60hBw23KYQRZ7DWCAXll7
         ABjs/yjXXFGSfhhakxK7tit3IVTLMzA9/JxMDYteDC3DQdMLMfnxfvZnzJecOKeCBCCN
         LXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPfTjDpPSeJzaRa3mJGnBk++dQFH39IxgFl6hpTQsIZPzDXkCBVOuOsFO29KvW/g0baumF/5i2EcosPVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUE7dEiMyt16F8BjGJwVpTBPIrjGzVktTlDE5GH/AkkHcR8HU
	N4WPbNQnHORWKqIZqB+2jXCUDh/fvZGbXhB0k6DXOOxginC/uTmJrQrWYp6vZCU=
X-Google-Smtp-Source: AGHT+IG1ZYBlgghv7z77rMXtSVWp3JvNzg+QlF7hnZHAeezQl0NHMuChRaHcYpb7YVV6rFIWnFl6MQ==
X-Received: by 2002:a17:907:5087:b0:a99:ef:468d with SMTP id a640c23a62f3a-a9900ef5101mr380500466b.44.1727963954481;
        Thu, 03 Oct 2024 06:59:14 -0700 (PDT)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104739c0sm88923666b.168.2024.10.03.06.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 06:59:13 -0700 (PDT)
Message-ID: <630467e0-6cd4-441d-a2cd-070a002c6f95@citrix.com>
Date: Thu, 3 Oct 2024 14:59:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] x86: BHI stubs
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
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
 <a7912ce1-131e-4b30-bed4-2576441c6212@citrix.com>
 <20241003121739.GB17263@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241003121739.GB17263@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/10/2024 1:17 pm, Peter Zijlstra wrote:
> On Tue, Oct 01, 2024 at 12:20:02PM +0100, Andrew Cooper wrote:
>> On 01/10/2024 12:03 pm, Peter Zijlstra wrote:
>>>  *   nop4
>>>  *   call *%r11
>>>
>>> And lets take a random bhi function:
>>>
>>> +       .align 16
>>> +SYM_INNER_LABEL(__bhi_args_0_1, SYM_L_LOCAL)
>>> +       UNWIND_HINT_FUNC
>>> +       cmovne %r10, %rdi
>>> +       cmovne %r10, %rsi
>>> +       ANNOTATE_UNRET_SAFE
>>> +       ret
>>> +       int3
>>>
>>> So the case you worry about is SUBL does *not* result in 0, but we
>>> speculate JZ true and end up in CALL, and do CMOVne.
>>>
>>> Since we speculated Z, we must then also not do the CMOV, so the value
>>> of R10 is irrelevant, it will not be used. The thing however is that
>>> CMOV will unconditionally put a store dependency on the target register
>>> (RDI, RSI in the above sequence) and as such any further speculative
>>> code trying to use those registers will stall.
>> How does that help?
>>
>> The write dependency doesn't stop a dependent load from executing in the
>> shadow of a mispredicted branch.
> I've been given to understand CMOVcc will kill any further speculation
> using the target register. So by 'poisoning' all argument registers that
> are involved with loads, we avoid any such load from happening during
> speculation.

IANAPA (I am not a pipeline architect), but AIUI,

CMOVcc establishes a data dependency between flags and the destination
register that doesn't exist in the pipeline if you'd used a conditional
branch instead.

It does prevent a dependent load from executing before the CMOVcc has
executed.  But it does not stop that load from executing speculatively
eventually.

So, given the following case:

* SUB is/will results nonzero (ZF=0, %r10=nonzero)
* JZ predicted taken, despite (ZF=0)

we call __bhi_args_XXX wherein:

* CMOVNZ blocks until SUB executes (flags dependency)
* CMOVNZ eventually executes, and because ZF=0, it really does write
%r10 over the target registers

and then we enter the function with all pointers containing the nonzero
residual from the hash check.

Now, because it's a SUBL, the result is < 2^32, a straight deference of
one of these pointers will be blocked by SMAP (noone cares about 32bit,
or pre-SMAP hardware, right?)

Forward references from the pointers will be safe (assuming SIB doesn't
reach the canonical boundary), but backward references may wrap around
back into the kernel space.  These will not be blocked by SMAP and will
spill their secrets if suitably provoked.

~Andrew

