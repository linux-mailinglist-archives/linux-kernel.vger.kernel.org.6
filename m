Return-Path: <linux-kernel+bounces-435189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DC29E7421
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391B71667F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBB1EC01B;
	Fri,  6 Dec 2024 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k5MFTr9W"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591C62171
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499115; cv=none; b=CQSj4W+F5VTiTkcJfzKlTyPBJmSPPe3VeZGhz8W1HNuhEG0cbg36SOdVgeONV/TQFm3x1rPx6QAp0WpNGoZp3px7lU7C3Gw8G5EWd/PdNUXim2AJ1MNm0Vu2UQfngWL5aSHtmYjSWWbPODvQ5b3NVTA9bLYjkifV+4tCHZmX8aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499115; c=relaxed/simple;
	bh=nX4H+YGS5Wg71GtE63HO3KTtPUpxps9jqHA5sEeboJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GnDyayigVmx650whKzZ4YvwcGxTp/dUnKkb8XNhwMvOtXvUwWVTZriGO0FF2/uTI/0JCYoa5PCmctjCuicVMIvNd1XHMfg/Q6MIb1xqGP86t78iVYjTiKEMXVXrDX/dl1D0oOKEIPgMJ8AX4BmpJ6aVMYK6L4qcnpiPepVPxaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k5MFTr9W; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-294ec8e1d8aso2113925fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733499111; x=1734103911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRz0tPuG7U0qBhhBbDglOv/HdUL+GvrHdhcZWdg7qSQ=;
        b=k5MFTr9Wg+WgUbyfuPh9PgcNXJJ126qmCFFF1OmKPc5Ew+KW3YE6ZaguO+t4XuQ1DO
         lAyk6NpFU9CD0Ocuq4FQg0E9wV9Fbr7igkigU8xWI6+IkoSIkAJB10NP86qFekQjMh4H
         64BsKpn8d9hxM0oXsiRe+d3FbdIeOpZKu5+oCgmi4sOgeYu6pYp3TaMBWvKeqvPII2Kj
         8mP1DSKX0ZR2QPMVEAP7IYady7IJrmkEjYT2iZj4ITcXixf7f2BQ5BICApARoPV3UTzI
         jte3WGGSc0ZFn8pbjjaoGYiWNDqyh4qP2kPGbVE3bdpxbZfjzrKgWSMD23oN5ZUNYLG3
         SmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499111; x=1734103911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRz0tPuG7U0qBhhBbDglOv/HdUL+GvrHdhcZWdg7qSQ=;
        b=QJdkx8JkBiMBBuznrXn/8R+nNo9sSpduoOTbXem29yQDY7Z1sjGafUVOHdGO4dqkEX
         EPrysKJ0nN2I/5eKntT/914a3TBo1XcUX9W6k7GJqQ3FjGBLoyDz3eVfA8pDba4x6A4Y
         mVcdlSkzsPscgLL1RTCnCUPThhUg1TJRJ/vIo0AwrfD8xnmhy41WZaegdyYUksl5gOPP
         Tk4Jsbk4lnzGBJqufzDKCJA5nl250AsWEteqFfcL02iEENo/mh0KItWfKniuydWg4UYS
         /RQSv4p+C2DbJPDwxkomfASXJiAkvTjMMXYbHraBN2czTyEIxhgEoAsfFDJiCK535k//
         AQpg==
X-Gm-Message-State: AOJu0Yw78XdLja3DUtTI7Cmh2lkl/6vTyJRuGS9aaYFZbZKaGx7iaW58
	9IVNzuV0U/3ty+PRWABeyxHv/jizQRSHMRd0LONXIlLp4v+QP0MFy08Q6Wzef0d8HROM9n2wnty
	G
X-Gm-Gg: ASbGncvVbU96u9ZF2OnK8Dt0Awwt6x97+rBmM/500Hb4+NsUMA2fz9kzDo86W7NB4zP
	avlzNdu7xi9h43MWeNAFw/RDbWBjVHPPRqGfMVqqXTu1sKPpEcCuFpFkD86JpAlEvQrd2rnSkPY
	ocuJeQIhibyTN92R04E/5ZKW1f6qBEj4mVBMR1nWICERxSCeGvqAB8iPu6cEYX2po8wcPns/KON
	DtmstRUgHrzU4sw6faQHlJq5G+hxSe0bZzSQAFLAK9j8bUisMBVgww635vfzlS7qv837HafmkDm
	Fzpku7BMq+A=
X-Google-Smtp-Source: AGHT+IF3hU/+5oPA+LVDNIF9L3M808YlplthE1AN3jMI+oopfCoiQk17fYD2CKQ1FMm6rxuP2gfauw==
X-Received: by 2002:a05:6870:d90d:b0:29e:559b:d694 with SMTP id 586e51a60fabf-29f73541205mr1561986fac.32.1733499111653;
        Fri, 06 Dec 2024 07:31:51 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc493b0fesm747838a34.5.2024.12.06.07.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:31:51 -0800 (PST)
Message-ID: <ffebd9e3-3b5b-4fad-94ad-8eb1e15cc63b@baylibre.com>
Date: Fri, 6 Dec 2024 09:31:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] headers/cleanup.h: Remove the if_not_guard() facility
To: Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Borislav Petkov <bp@alien8.de>
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
 <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
 <Zz3Jsn7Vf8X9ICva@gmail.com>
 <6499c178-b34d-47f9-8b1e-c87852d8426e@baylibre.com>
 <CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com>
 <Z1LBnX9TpZLR5Dkf@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Z1LBnX9TpZLR5Dkf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/24 3:19 AM, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> On Wed, 20 Nov 2024 at 09:57, David Lechner <dlechner@baylibre.com> wrote:
>>>
>>>         cond_guard(mutex_intr, &st->lock, &ret);
>>>         if (ret)
>>>                 return ret;
>>
>> I'm not convinced that improves on anything.
>>
>> You just replace one disgusting syntax with another, and force people
>> to have a variable that they may not want to have (even if they have
>> an error return variable, it might commonly be an error pointer, for
>> example)
>>
>> I really think the basic issue is that "cond_guard" itself is a pretty
>> broken concept. It simply doesn't work very well in the C syntax.
>>
>> I wish people just gave up on it entirely rather than try to work
>> around that fundamental fact.
>>
>> Not that long ago, Mathieu wanted to introduce "inactive guards" for
>> some similar reasons - kind of "conditional guards, except the
>> conditional is outside the guard". And I pointed out that the fix was
>> to rewrite the disgusting code so that THEY WEREN'T NEEDED in the
>> place he wanted to use them. Rewriting things to "Just Don't Do That,
>> Then" actually just improved code entirely:
>>
>>    https://lore.kernel.org/all/CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com/
>>
>> and honestly, I suspect the same is often true of this whole
>> "if_not_guard()" thing. It's not *hugely* often needed, and I strongly
>> suspect that the explicitly scoped version would be a *lot* safer.
>>
>> The "if_not_guard()" model may be great for mindless conversions of
>> existing code. But I'm not convinced it's a great interface in itself,
>> or that "mindless conversions" of conditional locking is actually a
>> good thing.
> 
> Ok, agreed - and to progress with fixing the bug & the fragility you 
> noticed, let's remove if_cond_guard() as a first step via the patch 
> below.
> 
> Thanks,
> 
> 	Ingo
> 
> =================================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Fri, 6 Dec 2024 10:13:32 +0100
> Subject: [PATCH] headers/cleanup.h: Remove the if_not_guard() facility
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
> It doesn't appear to be possible to turn this macro into a robust
> single or compound statement that could be used in single statements,
> due to the necessity to define an auto scope variable with an open
> scope and the necessity of it having to expand to a partial 'if'
> statement with no body.
> 
> Instead of trying to work around this fragility, just remove the
> construct before it gets used by code.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> ---
I agree this is the right thing to do. Thanks for writing up the patch.

Acked-by: David Lechner <dlechner@baylibre.com>

