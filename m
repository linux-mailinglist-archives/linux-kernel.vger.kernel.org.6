Return-Path: <linux-kernel+bounces-534766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD44A46AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08FE3A95AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AC7239561;
	Wed, 26 Feb 2025 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="1OJlMOyk"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0B16F288;
	Wed, 26 Feb 2025 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597807; cv=none; b=URx7dnRzH7lnLmJGOVuYD+5bX2SGMXqmFCp8EUqxhNExLUCkmsEsdXD9QNtpfkNrQNUleoQU7T2cOHG5QITvlOYbe3ljKVFTK5Bp0gTYfNPg0ozTkyVn5XPIdQaxIXYfAjo+TwiYy0nVsuORZ0S6d/4JpjhfXHthFOTqgDm/U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597807; c=relaxed/simple;
	bh=3IN59cPXZwNSscE3F3sLKehphuwhuJgUt1GPDijP35Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZ4tz9i1EZ52D3oy9A3v4yELyZtRcS7ZUtd32gzfJthp+KWrCKtArJXz0RPtnFZ3LByU14uN0K+ko8x7xNoZdgVk9Y4EpaFF7GC1lDNTluyHWAiwdRJ6JgcYDDNKein/2nITsYjRk/6f1jEoUF+PkpWtv00zlxEVAaUPOajavNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=1OJlMOyk; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740597803; bh=3IN59cPXZwNSscE3F3sLKehphuwhuJgUt1GPDijP35Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=1OJlMOykW0FTQejaDIyV6pkW1L5gxZlRl6EFXLqxc9w3ICUtsfGgxj2TUgs0tC44f
	 Bm7cJAYImzNytbhHqmwwW8G0JGf4sFWv67AV9wGlWfwUzE694nVzZwXuJtw0RP5Mj1
	 14FYNpIC8x5miJ+oH9W94MdBFqKoIGef8QRy6aC4=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 694792052D08;
	Wed, 26 Feb 2025 20:23:23 +0100 (CET)
Message-ID: <5f30546a-278d-4e99-9b2a-3cb7a6c45f89@ralfj.de>
Date: Wed, 26 Feb 2025 20:23:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Martin Uecker <uecker@tugraz.at>, Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>,
 torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <dd28fe6e2c174f605a104723a5ab8d5445fe8002.camel@tugraz.at>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <dd28fe6e2c174f605a104723a5ab8d5445fe8002.camel@tugraz.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

>>> But it is much more significant for Rust than for C, at least in
>>> regards to C's "restrict", since "restrict" is rarely used in C, while
>>> aliasing optimizations are pervasive in Rust. For C's "strict aliasing",
>>> I think you have a good point, but "strict aliasing" is still easier to
>>> reason about in my opinion than C's "restrict". Especially if you
>>> never have any type casts of any kind nor union type punning.
>>
>> Is it easier to reason about? At least GCC got it wrong, making no-aliasing
>> assumptions that are not justified by most people's interpretation of the model:
>> https://bugs.llvm.org/show_bug.cgi?id=21725
>> (But yes that does involve unions.)
> 
> Did you mean to say LLVM got this wrong?   As far as I know,
> the GCC TBBA code is more correct than LLVMs.  It gets
> type-changing stores correct that LLVM does not implement.

Oh sorry, yes that is an LLVM bug link. I mixed something up. I could have sworn 
there was a GCC bug, but I only found 
<https://gcc.gnu.org/bugzilla/show_bug.cgi?id=57359> which has been fixed.
There was some problem with strong updates, i.e. the standard permits writes 
through a `float*` pointer to memory that aliases an `int*`. The C aliasing 
model only says it is UB to read data at the wrong type, but does not talk about 
writes changing the type of memory.
Martin, maybe you remember better than me what that issue was / whether it is 
still a problem?

>>>> So, the situation for Rust here is a lot better than it is in C. Unfortunately,
>>>> running kernel code in Miri is not currently possible; figuring out how to
>>>> improve that could be an interesting collaboration.
>>>
>>> I do not believe that you are correct when you write:
>>>
>>>       "Unlike sanitizers, Miri can actually catch everything."
>>>
>>> Critically and very importantly, unless I am mistaken about MIRI, and
>>> similar to sanitizers, MIRI only checks with runtime tests. That means
>>> that MIRI will not catch any undefined behavior that a test does
>>> not encounter. If a project's test coverage is poor, MIRI will not
>>> check a lot of the code when run with those tests. Please do
>>> correct me if I am mistaken about this. I am guessing that you
>>> meant this as well, but I do not get the impression that it is
>>> clear from your post.
>>
>> Okay, I may have misunderstood what you mean by "catch everything". All
>> sanitizers miss some UB that actually occurs in the given execution. This is
>> because they are inserted in the pipeline after a bunch of compiler-specific
>> choices have already been made, potentially masking some UB. I'm not aware of a
>> sanitizer for sequence point violations. I am not aware of a sanitizer for
>> strict aliasing or restrict. I am not aware of a sanitizer that detects UB due
>> to out-of-bounds pointer arithmetic (I am not talking about OOB accesses; just
>> the arithmetic is already UB), or UB due to violations of "pointer lifetime end
>> zapping", or UB due to comparing pointers derived from different allocations. Is
>> there a sanitizer that correctly models what exactly happens when a struct with
>> padding gets copied? The padding must be reset to be considered "uninitialized",
>> even if the entire struct was zero-initialized before. Most compilers implement
>> such a copy as memcpy; a sanitizer would then miss this UB.
> 
> Note that reading padding bytes in C is not UB. Regarding
> uninitialized variables, only automatic variables whose address
> is not taken is UB in C.   Although I suspect that compilers
> have compliance isues here.

Hm, now I am wondering how clang is compliant here. To my knowledge, padding is 
effectively reset to poison or undef on a copy (due to SROA), and clang marks 
most integer types as "noundef", thus making it UB to ever have undef/poison in 
such a value.

Kind regards,
Ralf

> 
> But yes, it sanitizers are still rather poor.



> 
> Martin
> 
>>
>> In contrast, Miri checks for all the UB that is used anywhere in the Rust
>> compiler -- everything else would be a critical bug in either Miri or the compiler.
>> But yes, it only does so on the code paths you are actually testing. And yes, it
>> is very slow.
>>
>> Kind regards,
>> Ralf
>>
> 


