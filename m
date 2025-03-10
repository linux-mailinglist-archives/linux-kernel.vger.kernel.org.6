Return-Path: <linux-kernel+bounces-553810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13BA58F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE8F188FA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE2C22489A;
	Mon, 10 Mar 2025 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZh/ojJg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325C1BD9CE;
	Mon, 10 Mar 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597906; cv=none; b=dLnr1JLGMCd0YS+s11jGBKLBUoUUGSE12fOdDABcevHOOTfj6BcfwWcNMr1X0XKZQqE24gzu2JwMjcspXUWaduNfZ3c+JNOTzsW7M2Bep1/t+Up4UYg4yROnAoV1aBARj+iaZokosqEMZtmT/JHVNqbKKMzdBYyAfOhOMgcx7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597906; c=relaxed/simple;
	bh=VA7r2H9AqBaT7O6rpvl2k71MrU3oMucjddtf+mBEHhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DsMCVK6tMQb5lWbFqiq3PorAkP/lLKZwtiF2wrsqh+MdK/a5B/5CmdPeC5G86Z4z+sQFmVLwkKXtMKdOUpm6+zJydp5ToXJsIHsQdst0Ly7ZF2wYQQHD3Oat8GbjrTFvhn+CC+HcHSmhUUyFS0IPrRBFdVOsmDxfJLckdBSwems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZh/ojJg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22398e09e39so68732905ad.3;
        Mon, 10 Mar 2025 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741597905; x=1742202705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fm6hWuXGFYKKWKnUGyn4XNWX4BFtrfo8ZIfOir4zu/o=;
        b=DZh/ojJgSSxThheJPWc7e8qZkyyt+zn8b3vpqPwjP+PtQ2J+LVjxpCAjUFfrOu59Xo
         PE4ZoHVtbGJwwuf8inV0fKfUvJ1Bv6KY5VsX+fkrFt1/CiFD9PeYW6XMIwgQ1u54JYAW
         kxWDb0F2FEtdjeRNb+ulbDn0irgYKfer4COtZffaLEFiJDay8dBqAdsJEgw4X5YPKyT7
         y+ID6tyG8obFovwWilyc9tkHsWVgfxnsMEam+fVB7K9ns6PB0gv4Hq716BZupboyqxv2
         dbjRrJYEMGe/KiuCe/EowAIjVDdxscoNsgZdRaV0ZVguQtgGROx1cQw+v77FJZ5af4Ja
         OJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741597905; x=1742202705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fm6hWuXGFYKKWKnUGyn4XNWX4BFtrfo8ZIfOir4zu/o=;
        b=P2y2liXCb7kRvG14iEDCe788nP8HM91bJS+sA8/Fq5SvJ/fk16oA2WlNzWDhGCanFN
         ey7lDSyw9OV1+6e02c4KDKPriULwHuzd/AqKRo4aGgY/iIiTcXI6YMriMg8sVfrE/4wM
         U+EmhDrWUBshFX+jcCn1nnUlms+KcBIdzf7XxSr2RIxWT3q9G4S2p8qvyijjlPNH/Jf9
         9CUCVQ46uMp08WqjSl+mORCFVoZcrVFUUjJ7V6xPBARIhVM/mGsAaFIzq3EzzDiEtL6V
         D5En7Wfiz/7v+crmUA+XGfde7pnjNnPfWPy/O4sgZY0sAAGHNYYmLM1oOw5VZ+2MlFLu
         iIrw==
X-Forwarded-Encrypted: i=1; AJvYcCU7tiOjXE8g6TLOggcmiVGgPditdgn+gQVsOCrTiww4kYbt3CNKLBiyETSgcfJtIDnCRvmLNDJgqEZPb+n1@vger.kernel.org, AJvYcCX0dL5ZYvTLG5joZI4yES+lrAe0tWBrM1RXWwuPGrJEYupc7zLGn1cc2c+BfQCXcwmQCxRpA7u7+pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkTH1sM2Fq6dOjKGUD1OmNwLj8N853fl51gCw73hfI7l9mCMk
	aLxA6/QLkbvs39oPwiWx+ziCp79GHLfUeRQkcInytvMBhqDzuR+QGeI34g==
X-Gm-Gg: ASbGnctWfZYbCmyGSbMBmi6IRiaLOSdMxJGdhZStcQTbYZ0qMpGwt+Hbfr89EM0+uOI
	Mto/cGKCwkxja7UL33lDeWyxZE4PHUI5DjK7V6TeAgLv7aHZb69uA+06EDPGDHiRYP5cSo5o1ff
	7eS2iT7T8hJpfY0RG7rTJGsHnumL/hkeRGCja6qkqlqr2/gXzTUFAYRAYkDqjv8YVciyGqE2GJW
	sZc5ZkF1P1EoUxoCk5GbSKMHJM6p9NNRAVYwquTR8WpY127ItUJ9/vmG7WefZIAMPaYHxWK3tQx
	+0u1Zlv6YkIE85OoJUrL+9M/w3mgLHwOn/zaxNVcGU70OOfydS82Oia9wfxMqZLoNf7JkH+Qi0N
	Ytjcdq2M76nHnfzE=
X-Google-Smtp-Source: AGHT+IH5elbK7dNlWXUrMJbcM2L847LSTGg73MJdno5EXNdGfPoCCpIXJE2aMTIxMN7oF5EfhpiFfA==
X-Received: by 2002:a17:902:f70d:b0:224:c46:d162 with SMTP id d9443c01a7336-22428a97f00mr191149485ad.20.1741597904636;
        Mon, 10 Mar 2025 02:11:44 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91971sm72692835ad.165.2025.03.10.02.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:11:44 -0700 (PDT)
Message-ID: <662656aa-c25b-4f83-8131-eb39a6a42917@gmail.com>
Date: Mon, 10 Mar 2025 18:11:41 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] cpumask: Fix kernel-doc formatting errors in
 cpumask.h
To: Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <cover.1741332579.git.viresh.kumar@linaro.org>
 <f4ad81150eaa00b43c161f0d1f811f8ecfe21889.1741332579.git.viresh.kumar@linaro.org>
 <Z8snakYmzhaavkKN@thinkpad> <20250310061540.zpfyisvchyua2cuv@vireshk-i7>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250310061540.zpfyisvchyua2cuv@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Viresh Kumar wrote:
> On 07-03-25, 12:05, Yury Norov wrote:
>> On Fri, Mar 07, 2025 at 01:04:51PM +0530, Viresh Kumar wrote:
>>>  /**
>>> - * cpumask_next_and - get the next cpu in *src1p & *src2p
>>> + * cpumask_next_and - get the next cpu in *@src1p & *@src2p
>>>   * @n: the cpu prior to the place to search (i.e. return will be > @n)
>>>   * @src1p: the first cpumask pointer
>>>   * @src2p: the second cpumask pointer
>>
>> So the question: if some word in this particular comment block is
>> prefixed with @ symbol, can we teach kernel-doc to consider every
>> occurrence of this word as a variable?

That is not impossible, I would say.

>>
>> Why I'm asking: before the "*src1p & *src2p" was a line of C code.
>> And because we are all C programmers here, it's really simple to ident
>> it and decode. After it looks like something weird, and I think many
>> of us will just mentally skip it.
>>
>> I like kernel-docs and everything, but again, kernel sources should
>> stay readable, and particularly comments should stay human-readable.
> 
> Jonathan / Akira, can you please answer this one ?

I was not around when transition to Sphinx was made in 2016, and I don't
know much of kernel-doc (or its predecessor doc-book) comment format.

So below is my wild guesses.

Current Documentation/doc-guide/kernel-doc.rst has no mention of "*" WRT
where it is allowed or disallowed, which results in occasional complaints
from Sphinx on unmatched start/end of emphasis.

However, the use of "*" is indicated for itemized list, which directly
employs reST format.

It doesn't say anything about literal/code blocks, either.

So I have to say that current kernel-doc has quite a few of undefined
things on reST output.

kernel-doc in python3 might help untangle the mess.

This all need some consensus on kenrel-doc behavior to be reached, and
update/enhance of kernel-doc (script).

So my suggestion would be to hold these changes for the time being.

> 
>>> @@ -334,7 +334,8 @@ unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int sta
>>>   * @mask1: the first cpumask pointer
>>>   * @mask2: the second cpumask pointer
>>>   *
>>> - * This saves a temporary CPU mask in many places.  It is equivalent to:
>>> + * This saves a temporary CPU mask in many places.  It is equivalent to::
>>> + *
>>
>> I'm OK with extra line, but this double-colon. What for and what does
>> it mean?
> 
> Without this we get: "ERROR: Unexpected indentation", for the last
> line of the code block that contains: "        ...".
> 
> The double-colon creates a code-block for the below code and gets rid
> of the warning.
>>
>>>  /**
>>> - * cpumask_weight - Count of bits in *srcp
>>> + * cpumask_weight - Count of bits in *@srcp
>>>   * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
>>
>> Here nr_cpu_ids is also a variable. Why you don't prefix it with @?
> 
> I was only looking to fix the build warnings / errors for now, and did
> not look into detail for such issues. Yes, it should be marked with @.
> I will try to go through all the comments now and fix such issues.
>

Provided the brokenness of kernel-doc spec & script, I think you can
wait until it is properly fixed/enhanced.

The problem is: Is there somebody who would be interested enough to do
such an improvement?

        Thanks, Akira


