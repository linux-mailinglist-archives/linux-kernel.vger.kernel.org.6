Return-Path: <linux-kernel+bounces-290393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D01955346
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900B0B2215A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F30145A0A;
	Fri, 16 Aug 2024 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="uC++37Nt"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE811448E0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847280; cv=none; b=b+nA2KDo0mbxbtC7flw8AN3jN/Upuc2LttHonAocX9F0J9in9KKauL+RcgmB2sq+IDxjuR07AQibAgDkEKL8p8UcoHqL5ihvTB5aDQ/SmVHLZpNh6DyPoRBp7wkFkkImQm/02FCc08ZmhnL4/3pX9R2vrTYiDKSASow5HAKUrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847280; c=relaxed/simple;
	bh=Smsq90xGaDCscju+VLFz1ZHw0UWCdM+pJ8HVbh/e8FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlhJEm/+53/fIwzLE5hOhemRzKYo16K7A8lO35tSqLeyMcBDg+wjnYYELhoVuevzCtRhA5LcZv6B9cl69IX3c3d48QVG5ktFJnTy97a/r4+cvNDGRlHYeVP7vVHPCdUuIenc0c2tV0Q6WnfrZ8ytwEUba6tkdPMaN9oMKPIRQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=uC++37Nt; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-842ef41238fso808092241.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1723847277; x=1724452077; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Smsq90xGaDCscju+VLFz1ZHw0UWCdM+pJ8HVbh/e8FQ=;
        b=uC++37NtFa4W0B4MG8TXkSyBqzoGBpuqaPNAPjHpXrrP1BdutjHCzcPyXTFcFo2Qpx
         F5mLLTyvPzr5zn9OenQoUNJJsqOHTL8XQIyufid2jxjeiShGpTYuzFvM8o+4fQhEP+pX
         OGzZem+9D69KPzed6nXnEO7/1HNJt597nQpMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723847277; x=1724452077;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Smsq90xGaDCscju+VLFz1ZHw0UWCdM+pJ8HVbh/e8FQ=;
        b=UJttL5A/ScYGn1tN2Lp0FksBv2b0oR+cf4K3UI2rk9/TGw5vZT1q/sERvBu/Xa0QeF
         rdFD2yqc6OFBVldNXl9wrBuVL/A/N7MUUEH+5ockU1istd7mcKESykVBtc/jfyiUyNTh
         gxsTnGVAralTEtORpjJbuieyqaE7rsFsDuxw82JzRhaMRtgYK+G+AnjJSIdrXsW/PUkE
         oofr+cOHE7azbIdjRdJG+iQL3cCsgByU3KIGlEsATKRJIWJ9HNuyfRCkovBVedKI/KQV
         2BHr2d+rqB2DKSilAqV6OBnpAvSrPVfuWoWUuHppmuQaT6814NotS9G+oOIzWISMf42Q
         3CRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV7PqaD34Rl2eZUYjFTir8/zQraCzYeD8AhfUGtKMunuYMGiJh5+AboDZyLOUOTe2bU159VcQI8Cl9c9e7AySE2B5uGRuhXVrX1o7L
X-Gm-Message-State: AOJu0YyzbWRA1CTJsn8M5MoA6EBuEp6W8S1qEJcZMIoOZHr19DXzzOJB
	IPiCNOo5nQVfaC8f024vEAJRsHy4idyuoXNFBuedwgqQLKl7tKB3AguFvHSmrrI=
X-Google-Smtp-Source: AGHT+IFTDO7UMKJRzA6r2xwd+ef0u9M8iipvkE4x1sBe9X/B5jULKngbKdfbIRRqoTRrYdP4DSWnQQ==
X-Received: by 2002:a05:6102:b0a:b0:497:5f78:690a with SMTP id ada2fe7eead31-497798998b3mr4885451137.2.1723847277129;
        Fri, 16 Aug 2024 15:27:57 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4fef0046fsm223808085a.0.2024.08.16.15.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 15:27:55 -0700 (PDT)
Message-ID: <dc7c6c55-23fa-4cb3-a6b4-7558c45bf1d0@citrix.com>
Date: Fri, 16 Aug 2024 23:27:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with the
 alternatives mechanism
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
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <4f7566b5-a743-4819-b221-88207c132f63@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/08/2024 10:26 pm, H. Peter Anvin wrote:
> On 8/16/24 11:40, Andrew Cooper wrote:
>>>
>>> As the CALL instruction is 5-byte long, and we need to pad nop for both
>>> WRMSR and WRMSRNS, what about not using segment prefix at all?
>>
>
> You can use up to 4 prefixes of any kind (which includes opcode
> prefixes before 0F) before most decoders start hurting, so we can pad
> it out to 5 bytes by doing 3f 3f .. .. ..
>
>>
>> My suggestion, not that I've had time to experiment, was to change
>> paravirt to use a non-C ABI and have asm_xen_write_msr() recombine
>> edx:eax into rsi.  That way the top level wrmsr() retains sensible
>> codegen for native even when paravirt is active.
>>
>
> I have attached what should be an "obvious" example... famous last words.

Ah, now I see what you mean about Xen's #GP semantics.

That's a neat way of doing it.  It means the faulting path will really
take 2 faults on Xen, but it's a faulting path anyway so speed is
already out of the window.

Do you mind about teaching the #UD handler to deal with WRMSR like that?

I ask, because I can't think of anything nicer.

There are plenty of 3-byte instructions which #GP in PV guests (CPL3),
and LTR is my go-to for debugging purposes, as it's not emulated by Xen.

Anything here (and it can't be an actual WRMSR) will be slightly
confusing to read in an OOPS, especially #UD for what is logically a #GP.

But, a clear UD of some form in the disassembly is probably better than
a random other instruction unrelated to the operation.

~Andrew

