Return-Path: <linux-kernel+bounces-402374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903F9C26D7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B48C1C22D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481C1DB346;
	Fri,  8 Nov 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="X+G4mtjS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8117A5BE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731099212; cv=none; b=s4p2FKrJrVUk8P0RkuQZTCHqeqNCMEIDwZ9+f3+QDAm8Iz/vKaD3LMnfowRKv20yTYcGIk1q2IGZSdsobN+1CelTLSGwfJdNOfMcRKfVcWme9hjOMapWASEP6uZe7tlZATvDHNhqALGP9UNwmWH2ixqgZSB8Ec+lkMmXAiaVNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731099212; c=relaxed/simple;
	bh=Net7dRT/9hfiZuwUCbYc4ll6VWS/hK7FGMJxbH8eg5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecpgiNWf1s+1sN9c9nrIYONFbtM01Ag2j6Zw4ZYj/mWibw7d3b3EyzPsi0UwSyKBJDTlCoceNVS8q8lfHWVfCCDyH0DBKDSlQKkN/kxIcKoysSSxIoubf7TyvNjXKOvK1byQFsAFIgv3SKIY3q5L6jKG6PesJ99UbwOC/kfNIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=X+G4mtjS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so21038935e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1731099209; x=1731704009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Net7dRT/9hfiZuwUCbYc4ll6VWS/hK7FGMJxbH8eg5M=;
        b=X+G4mtjSa3TFQ3W5gDQuBWVYJ0aVWYSWbEzyIbtFotgGFrgUkXaskDNin8U8vT8uIO
         KzcvR7NJRxEg3q2wLl/xCrEconeXSFcmXdHZ8EXEfIWQLys0uTaRXn/DpqzhHwhdUNc+
         9xFg6dP4zXiynHfxKPLcvOwL5LqEAKwiC3efU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731099209; x=1731704009;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Net7dRT/9hfiZuwUCbYc4ll6VWS/hK7FGMJxbH8eg5M=;
        b=cpd8ceMVxKsuVogxz/HLlGHgkbr5YqQvEZbxMQ+UPN9AGqQEJKzst4CowJ4voSfDkE
         oarQ2ioYLLMTRRCjW8vApBci0vLjNCsWlRJH+UccpNAI7A0BTKIqjNjEgZjNq23y3qmt
         BYBhf4l+mhUbJjpZ+nxlcAOK4Je86LDcVC4gEvOgIjGtBqfDMnaMVezNMv28WEmSZ6l8
         iZCnALrQl4uyMNLaJkwXPreXi6EtnNDrdIAM73r+49YY10rGyS/wd95AFFleKx6gNV1E
         0t4qzN9MnX2EjQYWrO0kPoFAChwpmgz+mVAilpTGtBVQObawearGW5XeW4v7F8J4rJEm
         h8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWzBHjsTpmv4C8vY0YNQ8RJXS7nXvJO2htQS8+oy9uKBz9mkZ3q2t0dIjhvwCxKkNTIGq6D6afyW5QIbOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/6AUzktykvA3Qln1ab1jQgOLfYilC9gklAYE8KKF1xAGokjxL
	rKssC2Um0r7yhz8t4tuyikpqt9EC/rqeqlINEhk6Rv8sXox0kppmRdL22f+I9EA=
X-Google-Smtp-Source: AGHT+IFEhS6N3uXRQFuDiQTTbr/PuTt9cxH72WenR7Ba6nrfqyLkBWRBtLi/LNJU6ET3r2QyhI2ObA==
X-Received: by 2002:a05:600c:3514:b0:431:52b7:a485 with SMTP id 5b1f17b1804b1-432b7508b3dmr37389445e9.19.1731099209079;
        Fri, 08 Nov 2024 12:53:29 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5e8dsm125222755e9.6.2024.11.08.12.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 12:53:26 -0800 (PST)
Message-ID: <473f9dae-b711-4d96-8804-209275b963a2@citrix.com>
Date: Fri, 8 Nov 2024 20:53:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org
References: <20240916181000.416513-1-xin@zytor.com>
 <49b6c23b-dfd8-4874-bd6e-998dd039ed1a@zytor.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <49b6c23b-dfd8-4874-bd6e-998dd039ed1a@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/11/2024 6:54 pm, Xin Li wrote:
> On 9/16/2024 11:10 AM, Xin Li (Intel) wrote:
>> The WFE, i.e., WAIT_FOR_ENDBRANCH, bit in the augmented CS of FRED
>> stack frame is set to 1 in missing-ENDBRANCH #CP exceptions.
>>
>> The CPU will generate another missing-ENDBRANCH #CP if the WFE bit
>> is left set, because the CPU IBT will be set in the WFE state upon
>> completion of the following ERETS instruction and then the CPU will
>> resume from the instruction that just caused the previous #CP.
>>
>> Clear WFE to avoid dead looping in missing-ENDBRANCH #CPs.
>>
>> Describe the IBT story in the comment of ibt_clear_fred_wfe() using
>> Andrew Cooper's write-up.
>>
>> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
>> ---
>>
>> Changes since v1:
>> * Rewrite the comment of ibt_clear_fred_wfe() using Andrew Cooper's
>>    write-up (Andrew Cooper).
>> * Unconditionally clear WFE in missing-ENDBRANCH #CPs (Peter Zijlstra).
>> * Don't check X86_FEATURE_FRED in ibt_clear_fred_wfe() (Dave Hansen &
>>    Andrew Cooper).
>> ---
>>   arch/x86/kernel/cet.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
>> index d2c732a34e5d..d2cf6ee0d9a0 100644
>> --- a/arch/x86/kernel/cet.c
>> +++ b/arch/x86/kernel/cet.c
>> @@ -81,6 +81,36 @@ static void do_user_cp_fault(struct pt_regs *regs,
>> unsigned long error_code)
>>     static __ro_after_init bool ibt_fatal = true;
>>   +/*
>> + * By definition, all missing-ENDBRANCH #CPs are a result of WFE &&
>> !ENDBR.
>> + *
>> + * But, in original CET under IDT delivery, any transfer for
>> + * interrupt/exception/etc that does not change privilege will
>> clobber the
>> + * WFE state because MSR_{U,S}_CET.WFE is intentionally set by
>> microcode so
>> + * as to expect to find an ENDBR at the interrupt/exception/syscall
>> entrypoint.
>> + *
>> + * In practice, this means interrupts and exceptions hitting the
>> kernel, or
>> + * user interrupts, lose the WFE state of the interrupted context.  And
>> + * yes, this means that a well timed interrupt (to the precise
>> instruction
>> + * boundary) will let an attacker sneak a bad function pointer past the
>> + * CET-IBT enforcement.
>> + *
>> + * In FRED, the WFE state of the interrupted context (even if it is the
>> + * same privilege) is preserved and restored, in order to close this
>> hole.
>> + *
>> + * Therefore, the missing-ENDBRANCH #CP handler needs to clear WFE
>> to avoid
>> + * dead looping, now that FRED is causing the state not to get
>> lost.  Otherwise
>> + * if the WFE bit is left set in an intentional ibt selftest or when
>> !ibt_fatal,
>> + * the CPU will generate another missing-ENDBRANCH #CP because the
>> IBT will be
>> + * set in the WFE state upon completion of the following ERETS
>> instruction and
>> + * then the CPU will resume from the instruction that just caused
>> the previous
>> + * missing-ENDBRANCH #CP.
>> + */
>> +static void ibt_clear_fred_wfe(struct pt_regs *regs)
>> +{
>> +    regs->fred_cs.wfe = 0;
>> +}
>> +
>>   static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long
>> error_code)
>>   {
>>       if ((error_code & CP_EC) != CP_ENDBR) {
>> @@ -88,6 +118,8 @@ static void do_kernel_cp_fault(struct pt_regs
>> *regs, unsigned long error_code)
>>           return;
>>       }
>>   +    ibt_clear_fred_wfe(regs);
>> +
>>       if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
>>           regs->ax = 0;
>>           return;
>>
>> base-commit: fe85ee391966c4cf3bfe1c405314e894c951f521
>
>
> Andrew,
>
> can you please take another look?

After discussing with Dave on IRC, the ibt_clear_fred_wfe(regs); really
needs to be inside the ibt_selftest_noendbr path.

It's a selftest where we're deliberately trying to trigger #CP, and in
the one case where we're happy should we say "yeah, safe to clobber WFE
in the interrupted context" to let execution continue.

Clobbering WFE in any other circumstance is a security-relevant bug.

~Andrew

