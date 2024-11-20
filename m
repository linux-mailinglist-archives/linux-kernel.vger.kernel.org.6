Return-Path: <linux-kernel+bounces-416178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD39D41BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B24EB20CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EF113D276;
	Wed, 20 Nov 2024 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T4qj+Gnk"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BE2F2A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125459; cv=none; b=hl5gDd0ybGtMW9i9dKakxAl9sGeGKouILJoMEvnXSxc6jEerSGutAOixXOf/cuMcHuW1NF8awrfQzBUBxujDk6obj7AQ3XlZ1IuwOkpPPIwsDF1y0AxHzXzL57phYTm0P1Z1zUJzahOYQqv/90s6AFOeFcKj/uGhnDsQ+K/8bW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125459; c=relaxed/simple;
	bh=IGgxfI0JGL5t5nQw8txm8BOydQxjHoWvWNO7zHKePD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJJtkJ74wezyQoN2uGn50pRK6+IoXQsbCsONjrU/cwTLkQp4Ou20LIq1BY/FDD578q2v7EgCVVkCDFZLafOpBZfyOBy8m2dJ36h4sJIrlVc+aKoIV7wxMpnY+LKO6MBftecifKPjo3wlsw+aZIshKvIRfeUiQOjePVyccyl26+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T4qj+Gnk; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71a6bfcb836so600404a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732125455; x=1732730255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG4erM9OrlR7kyzzMgcLyC7AMirvRrXnOw+SSxT3tjs=;
        b=T4qj+GnktZBzfHUAzpfgSiF8y1SHqxf3MNQ0V9TGJc7QbYhHPOAPYHu83nkQlDI2fz
         6qICoIBzhHLc4Ok6tafeEZ0AgwxY1oAXSj8kHY4ERyH6++XeCPsrSInsauDzhTetA2Ar
         zTfqb1MsstolGWObHM1YDDokvKTlXoEx1A5gXzXN3PhIQr4NcQDvll2PGUah1ZEu81WI
         cbWXlbU0PgGkBrhBGOS1NL3puYBuL41oPcmXzrtLqS57TH5Bm0YSmfTnmCAJ+ikLL6iR
         uiTL61iuRw4kxxQQaMpKlz/Bn/o9BezQ0AmDC9LsaFHe48t7DqBNn1RotVXyE6kbFB2g
         zMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732125455; x=1732730255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG4erM9OrlR7kyzzMgcLyC7AMirvRrXnOw+SSxT3tjs=;
        b=Jhw9BGq2CBfKakzrN75cpJFg8jb7yQvDvHdJRcD/DTmim3A2sSwpB3GL1bTlBXcl9o
         gLKmVhdlTFI3pDi1YTl/VTqEbPAWrc7qgHjL4+MG3oaKhaDbtwx7XQ7O9biI9/p7E7tl
         d/ecxByd4RtQLipez0/7it9X8Kv6WCAdIx/6ekNffDca0FE3ep8IpWKLeioT4raUYe+X
         GBAc6Bv1gav3NNI8Y67VJ3MgcAIsrvrOKqNczhYx7q6AKoXSXXMGs72eJ2Q6Hb12mrAw
         2s36DHFacRq44IGJ0cjFXALMBMc+A/sUOTEp1f+y1N8PiG3uK1Q6hZ1u2nYxhknrvD8q
         2XXA==
X-Gm-Message-State: AOJu0YxbbrcwkENznz05LOc/WaE3l+yJ1s+3N5kXhkgw4U9zwyNcirtX
	06hvANFNhVz+NYn7WDoLZjMTbdJ3VeyYBO6uFXR+Bmv3XuzDgaffRQSOKfSJUys=
X-Google-Smtp-Source: AGHT+IFb8O17tI3/q5jTjNqevyYc7lvkC6bXmxlQGhe90nuueonD1S3FNz4hFB2/gnseRoRBpsw5Ag==
X-Received: by 2002:a05:6830:10c6:b0:713:d159:ec with SMTP id 46e09a7af769-71b037cadd5mr223237a34.10.1732125455603;
        Wed, 20 Nov 2024 09:57:35 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a7813ffd5sm4116248a34.42.2024.11.20.09.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 09:57:35 -0800 (PST)
Message-ID: <6499c178-b34d-47f9-8b1e-c87852d8426e@baylibre.com>
Date: Wed, 20 Nov 2024 11:57:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] headers/cleanup.h: Fix if_not_guard() fragility
To: Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Borislav Petkov <bp@alien8.de>
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
 <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
 <Zz3Jsn7Vf8X9ICva@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Zz3Jsn7Vf8X9ICva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/20/24 5:36 AM, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Mon, 18 Nov 2024 at 01:03, Ingo Molnar <mingo@kernel.org> wrote:
>>>
>>>  - <linux/cleanup.h>:
>>>     - Add if_not_cond_guard() conditional guard helper (David Lechner)
>>
>> I've pulled this, but I'm unhappy.
>>
>> This macro generates actively wrong code if it happens to be inside an
>> if-statement or a loop without a block.
>>
>> IOW, code like this:
>>
>>     for (iterate-over-something)
>>         if_not_guard(a)
>>             return -BUSY;
>>
>> looks like will build fine, but will generate completely incorrect code.
>>
>> Honestly, just switching the order of the BUILD_BUG_ON() and the
>> CLASS() declaration looks like it would have fixed this (because then
>> the '_id' won't be in scope of the subsequent if-statement any more),
>> but I'm unhappy with how apparently nobody even bothered to think
>> about such a fundamental issue with macros.
>>
>> Macros that expand to statements absolutely *ALWAYS* need to deal with
>> "what if we're in a single-statement situation?"
> 
> How about the fix below?
> 
> Thanks,
> 
> 	Ingo
> 
> =======================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Wed, 20 Nov 2024 11:56:31 +0100
> Subject: [PATCH] headers/cleanup.h: Fix if_not_guard() fragility
> 
> Linus noticed that the new if_not_guard() definition is fragile:
> 
>    "This macro generates actively wrong code if it happens to be inside an
>     if-statement or a loop without a block.
> 
>     IOW, code like this:
> 
>       for (iterate-over-something)
>           if_not_guard(a)
>               return -BUSY;
> 
>     looks like will build fine, but will generate completely incorrect code."
> 
> The reason is that the __if_not_guard() macro is multi-statement, so 
> while most kernel developers expect macros to be simple or at least 
> compound statements - but for __if_not_guard() it is not so:
> 
>  #define __if_not_guard(_name, _id, args...)            \
>         BUILD_BUG_ON(!__is_cond_ptr(_name));            \
>         CLASS(_name, _id)(args);                        \
>         if (!__guard_ptr(_name)(&_id))
> 
> To add insult to injury, the placement of the BUILD_BUG_ON() line makes 
> the macro appear to compile fine, but it will generate incorrect code 
> as Linus reported, for example if used within iteration or conditional 
> statements that will use the first statement of a macro as a loop body 
> or conditional statement body.
> 
> While it doesn't appear to be possible to turn this macro into a robust 
> single or compound statement that could be used in single statements, 
> due to the necessity to define an auto scope variable with an open 
> scope and the necessity of it having to expand to a partial 'if' 
> statement with no body - we can at least make sure the macro won't 
> build if used in a single-statement construct: such as by making the 
> CLASS() line the first statement in the macro, followed by the other 
> statements, which would break the build, as the single statement would 
> close the scope.

Here is another option:

We could scrap this macro and try a different approach completely.
Instead we could create something that works a bit different but is
actually a single C statement.

Instead of this code...

	if_not_guard(mutex_intr, &st->lock)
		return -EINTR;

We could write this...

	int ret;
	
	cond_guard(mutex_intr, &st->lock, &ret);
	if (ret)
		return ret;

In this case, the cond_guard() macro would expand to a single statement,
namely a variable declaration statement.

This would also fix another thing that bugged me about the existing
scoped_cond_guard() that this is aiming to replace. scoped_cond_guard()
swallows the return value of the acquire function and just returns a
handle or NULL, possibly losing information.

In fact, mutex_lock_interruptible() that I used in this example can
return -EINTR, -EALREADY, or -EDEADLK. This means that patches like
[1] are actually unintentionally changing behavior because instead of
passing on the return value, they assume that only -EINTR could be
returned and hard-code that. This will cause bugs if anyone higher up
the call stack that is checking for a specific error code. If we want
to fix if_cond_guard() we should make it robust against this mistake
as well. But at this point, I think reverting my patch and going
back to the drawing board is the best option.

[1]: https://lore.kernel.org/all/20240904043104.1030257-2-dmitry.torokhov@gmail.com/


Note: We can't make the most obvious macro that works like this...

	ret = cond_guard(mutex_intr, &st->lock);

for the same reason that if_not_guard() is destined to be buggy - there
just isn't a way to do it in a single statement/expression while keeping
the cleanup variable declaration in the current scope. For this reason
I am proposing the next best thing where ret is an output parameter.

> 
> Do this.
> 
> To test this, I added an artificial if_not_guard() usecase within a 
> single statement:
> 
> Before:
> 
> 	$ make kernel/ptrace.o
> 	CC      kernel/ptrace.o
> 	$
> 
> After:
> 
> 	CC      kernel/ptrace.o
> 	In file included from ./include/linux/irqflags.h:17,
> 		       from ./arch/x86/include/asm/special_insns.h:10,
> 		       from ./arch/x86/include/asm/processor.h:25,
> 		       from ./include/linux/sched.h:13,
> 		       from kernel/ptrace.c:13:
> 	kernel/ptrace.c: In function ‘ptrace_attach’:
> 	./include/linux/cleanup.h:258:9: error: expected expression before ‘class_mutex_intr_t’
> 
> I'd also like to note that the original submission by David Lechner did 
> not contain the BUILD_BUG_ON() line, so it was safer than what we ended 
> up committing. Mea culpa.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Fixes: 36c2cf88808d cleanup: Add conditional guard helper
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/cleanup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index 966fcc5ff8ef..263f14085617 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -351,8 +351,8 @@ _label:									\
>  	__scoped_cond_guard(_name, _fail, __UNIQUE_ID(label), args)
>  
>  #define __if_not_guard(_name, _id, args...)		\
> -	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
>  	CLASS(_name, _id)(args);			\
> +	BUILD_BUG_ON(!__is_cond_ptr(_name));		\
>  	if (!__guard_ptr(_name)(&_id))
>  
>  #define if_not_guard(_name, args...) \



