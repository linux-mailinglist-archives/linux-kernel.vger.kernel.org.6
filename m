Return-Path: <linux-kernel+bounces-290402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F76395535B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA711F21CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9DD145320;
	Fri, 16 Aug 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="iwRJWj0D"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488EBBA33
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847700; cv=none; b=qkc0m4nysfVM0V9bStUZRCzgbTJbQEs2KdGANW0Rvv3qxbJkIecc11QyCzj0+DSXYFJdsyfRU5ss5p5+sOG/fhL2yIHT5+JflQhPf63MWL82EmlVtEd6MpFTKzs/S617YULS+rzcR1yJ3fz2yk276exIYsU9hu27Ct4TQ7gcm2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847700; c=relaxed/simple;
	bh=X+MBtXDwq1Y6qDxs6ebx3T80U3KpkL8iH2MTl4FNndc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ApDhwKWyHLbYh5R5DCt5/9MF7NeDZp90+StP7UUI/ImsKX9feA10cN5lQe29A+0mJWwniKA3oUZLIyUzX9Ynv6SABYrSORSqhy/GD7VVSsuH6p2zvXpL50z9b+QDzCJph7eYMBQfulY6pwqsPJsaD7HWt/UoAIyb9sSMZtun2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=iwRJWj0D; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso906708a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1723847696; x=1724452496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X+MBtXDwq1Y6qDxs6ebx3T80U3KpkL8iH2MTl4FNndc=;
        b=iwRJWj0D5e4opeDJD4dqaShvXKCzUUfXp8y+kVA5ZJP6wEf44Ds0TkQEAfvjNyjdxA
         nZEhxQHZIGf1vrD896pA7vW7wWXVpviwCVYqBgAwGlYy0n0OXNsYS3vRUMjAM84A8ERY
         6/QiakMvHXj3sP+TUJ40EDgHvceLVnFFsPmX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723847696; x=1724452496;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+MBtXDwq1Y6qDxs6ebx3T80U3KpkL8iH2MTl4FNndc=;
        b=boMdZ4wDgnYuJ1gkw3mT6Jqy40WH151nbzzNFefGMlI9BPwAFz4BrBFRE3qqC1Jtxi
         T9jkXuIPYzntB/KZQSC/jCCSS97cXqQxqjls3M40m/Ro04t2G98hZNZPFBNOMKgc2YHe
         h2qkynPnDW0OGEIY4ueAhOk0zOJh7P+JyXx8cF3xlbb6nzGt/0/E/nmFWMFQaccj4JGp
         08kARy8ScKWo7leos6HISgHg0zuqU6PBLG3MpNLHpaYwydlwwtY9NCeG24wGkAFXgR0z
         LBAzOoTCr0iw2WfQgXjknbEh8g50xxuw+uu1dtNUI3i/IgbMjxUSEMB1U/acCWUbwMIx
         OSmw==
X-Forwarded-Encrypted: i=1; AJvYcCXAtg6bd/8MqGs9oxO8QxDwOMLcql/EXL8jGSmGl9grbfzJdkHUxA/jlMotUKBxRKIdqvBTEA3/OUPtHB/yJWmXtIDQhAO+h5ufAQN3
X-Gm-Message-State: AOJu0YxnPpRD+skFGD8ODvCY5bt9jUVEySqpoAYJkP4k4o8xYAZ70j5t
	0QE/oF5rCuDwiEZIvSsdqs69aycHzgB/sRMLYzwrqB3qirJP3orfimiIe/j1O6c=
X-Google-Smtp-Source: AGHT+IFbuTMyVPWD+zE+0goP0+VZZ5KtvAtxOQpWTVHlpx1ZkOOEMTFlpYvSUihPEfLEsl3foTTJmA==
X-Received: by 2002:a50:ee86:0:b0:5a3:d140:1a46 with SMTP id 4fb4d7f45d1cf-5beca76e1d1mr2897086a12.23.1723847696140;
        Fri, 16 Aug 2024 15:34:56 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5becd9d53e2sm1500362a12.38.2024.08.16.15.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 15:34:54 -0700 (PDT)
Message-ID: <f0dfe1ee-accc-4202-8f26-574124f40e22@citrix.com>
Date: Fri, 16 Aug 2024 23:34:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: "H. Peter Anvin" <hpa@zytor.com>, Xin Li <xin@zytor.com>,
 linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
 seanjc@google.com, Juergen Gross <jgross@suse.com>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
 <e18cd005-24ef-497d-b39c-74a54d89a969@citrix.com>
 <7c09d124-08f1-40b4-813c-f0f74e19497a@zytor.com>
 <25200a9d-e222-4c40-9c97-b5e5e532db8c@citrix.com>
 <4f7566b5-a743-4819-b221-88207c132f63@zytor.com>
 <dc7c6c55-23fa-4cb3-a6b4-7558c45bf1d0@citrix.com>
Content-Language: en-GB
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <dc7c6c55-23fa-4cb3-a6b4-7558c45bf1d0@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/08/2024 11:27 pm, Andrew Cooper wrote:
> On 16/08/2024 10:26 pm, H. Peter Anvin wrote:
>> On 8/16/24 11:40, Andrew Cooper wrote:
>>>> As the CALL instruction is 5-byte long, and we need to pad nop for both
>>>> WRMSR and WRMSRNS, what about not using segment prefix at all?
>> You can use up to 4 prefixes of any kind (which includes opcode
>> prefixes before 0F) before most decoders start hurting, so we can pad
>> it out to 5 bytes by doing 3f 3f .. .. ..
>>
>>> My suggestion, not that I've had time to experiment, was to change
>>> paravirt to use a non-C ABI and have asm_xen_write_msr() recombine
>>> edx:eax into rsi.  That way the top level wrmsr() retains sensible
>>> codegen for native even when paravirt is active.
>>>
>> I have attached what should be an "obvious" example... famous last words.
> Ah, now I see what you mean about Xen's #GP semantics.
>
> That's a neat way of doing it.  It means the faulting path will really
> take 2 faults on Xen, but it's a faulting path anyway so speed is
> already out of the window.
>
> Do you mind about teaching the #UD handler to deal with WRMSR like that?
>
> I ask, because I can't think of anything nicer.
>
> There are plenty of 3-byte instructions which #GP in PV guests (CPL3),
> and LTR is my go-to for debugging purposes, as it's not emulated by Xen.
>
> Anything here (and it can't be an actual WRMSR) will be slightly
> confusing to read in an OOPS, especially #UD for what is logically a #GP.
>
> But, a clear UD of some form in the disassembly is probably better than
> a random other instruction unrelated to the operation.
>
> ~Andrew

Oh, P.S.

We can probably drop most of the register manipulation by making the new
xen_do_write_msr be no_caller_saved_registers.  As we're intentionally
not a C ABI to start with, we might as well not spill registers we don't
use either.

~Andrew

