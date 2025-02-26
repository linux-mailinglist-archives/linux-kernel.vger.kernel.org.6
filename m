Return-Path: <linux-kernel+bounces-534003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74DA4615C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E18B7A49DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF421E0BD;
	Wed, 26 Feb 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="Ra7wF8bl"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58421D5A9;
	Wed, 26 Feb 2025 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578056; cv=none; b=D2dThYK8MZjQlNxH3vsOGMNxVvtiPYkfslTKI3P4tozP+zGN8lwepNepBd1GOB6wBuUuOx0TLOE7dbxTDKs0VWoRa3+OhOMgz7YlgGtNkNNI2HDaXdCafcY9rdSi5NrbzBZ/Wbwu2oc1kScmbZyaUZYqIUE79kzdihgx9WF4VBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578056; c=relaxed/simple;
	bh=gQX2EhjQCZh2IUd+WAcw3BaScS2Oq6g/34BKi5te1Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRzRwba+/GR5YMen2tH/basGCJIWgNUN3TmH2Q06BpVNS++8iuPtIs7B5BvYw0hH/6EVMVhwZMZ/ca5UaR8wrx4t353F2ogQxDASpCIkpHu9vn+YhXF02eOj7VZ8rsJmSe8aDw86RyqUn/mQvwkj9sOVPs+BuRHYRKKwEKoELbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=Ra7wF8bl; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740578051; bh=gQX2EhjQCZh2IUd+WAcw3BaScS2Oq6g/34BKi5te1Fg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ra7wF8blWjFG5eByeU+PrWfiqYyK1J8o0cT+USD9rgOelUAjeD3HcM1FTuKNbcUQR
	 mfAgeuYxPyNLz0ZFutVawMwOApntWXkcAT41rdn1F7a6rQ50HxY3efhYccxYdRlHa/
	 ZUgLlJTHg9p7k4Z3t5edG74Ooepm4LZWdKBYWtyw=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 83F4E2052D08;
	Wed, 26 Feb 2025 14:54:11 +0100 (CET)
Message-ID: <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
Date: Wed, 26 Feb 2025 14:54:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Ventura Jack <venturajack85@gmail.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

>> I think all of this worrying about Rust not having defined its
>> aliasing model is way overblown. Ultimately, the status quo is that
>> each unsafe operation that has to do with aliasing falls into one of
>> three categories:
>>
>> * This is definitely allowed.
>> * This is definitely UB.
>> * We don't know whether we want to allow this yet.
> 
> Side note: can I please ask that the Rust people avoid the "UD" model
> as much as humanly possible?
> 
> In particular, if there is something that is undefined behavior - even
> if it's in some "unsafe" mode, please please please make the rule be
> that
> 
>   (a) either the compiler ends up being constrained to doing things in
> some "naive" code generation
> 
> or it's a clear UB situation, and
> 
>   (b) the compiler will warn about it

That would be lovely, wouldn't it?

Sadly, if you try to apply this principle at scale in a compiler that does 
non-trivial optimizations, it is very unclear what this would even mean. I am 
not aware of any systematic/rigorous description of compiler correctness in the 
terms you are suggesting here. The only approach we know that we can actually 
pull through systematically (in the sense of "at least in principle, we can 
formally prove this correct") is to define the "visible behavior" of the source 
program, the "visible behavior" of the generated assembly, and promise that they 
are the same. (Or, more precisely, that the latter is a refinement of the 
former.) So the Rust compiler promises nothing about the shape of the assembly 
you will get, only about its "visible" behavior (and which exact memory access 
occurs when is generally not considered "visible").
There is a *long* list of caveats here for things like FFI, volatile accesses, 
and inline assembly. It is possible to deal with them systematically in this 
framework, but spelling this out here would take too long. ;)

Once you are at a level of "visible behavior", there are a bunch of cases where 
UB is the only option. The most obvious ones are out-of-bounds writes, and 
calling a function pointer that doesn't point to valid code with the right ABI 
and signature. There's just no way to constrain the effect on program behavior 
that such an operation can have.

We also *do* want to let programmers explicitly tell the compiler "this code 
path is unreachable, please just trust me on this and use that information for 
your optimizations". This is a pretty powerful and useful primitive and gives 
rise to things like unwrap_unchecked in Rust.

So our general stance in Rust is that we minimize as much as we can the cases 
where there is UB. We avoid gratuitous UB e.g. for integer overflow or sequence 
point violations. We guarantee there is no UB in entirely safe code. We provide 
tooling, documentation, and diagnostics to inform programmers about UB and help 
them understand what is and is not UB. (We're always open to suggestions for 
better diagnostics.)
But if a program does have UB, then all bets are indeed off. We see UB as a 
binding contract between programmer and compiler: the programmer promises to 
never cause UB, the compiler in return promises to generate code whose "visible 
behavior" matches that of the source program. There's a very pragmatic reason 
for that (it's how LLVM works, and Rust wouldn't be where it is without LLVM 
proving that it can compete with C/C++ on performance), but there's also the 
reason mentioned above that it is not at all clear what the alternative would 
actually look like, once you dig into it systematically (short of "don't 
optimize unsafe code", which most people using unsafe for better performance 
would dislike very much -- and "better performance" is one of the primary 
reasons people reach for unsafe Rust).

In other words, in my view it's not the "unconstrained UB" model that is wrong 
with C, it is *how easy* it is to accidentally make a promise to the compiler 
that you cannot actually uphold. Having every single (signed) addition be a 
binding promise is a disaster, of course nobody can keep up with all those 
promises. Having an explicit "add_unchecked" be a promise is entirely fine and 
there are cases where this can help generate a lot better code.
Having the use of an "&mut T" or "&T" reference be a promise is certainly more 
subtle, and maybe too subtle, but my understanding is that the performance wins 
from those assumptions even just on the Rust compiler itself are substantial.

Kind regards,
Ralf

> 
> IOW, *please* avoid the C model of "Oh, I'll generate code that
> silently takes advantage of the fact that if I'm wrong, this case is
> undefined".
> 
> And BTW, I think this is _particularly_ true for unsafe rust. Yes,
> it's "unsafe", but at the same time, the unsafe parts are the fragile
> parts and hopefully not _so_ hugely performance-critical that you need
> to do wild optimizations.
> 
> So the cases I'm talking about is literally re-ordering accesses past
> each other ("Hey, I don't know if these alias or not, but based on
> some paper standard - rather than the source code - I will assume they
> do not"), and things like integer overflow behavior ("Oh, maybe this
> overflows and gives a different answer than the naive case that the
> source code implies, but overflow is undefined so I can screw it up").
> 
> I'd just like to point to one case where the C standards body seems to
> have actually at least consider improving on undefined behavior (so
> credit where credit is due, since I often complain about the C
> standards body):
> 
>     https://www9.open-std.org/JTC1/SC22/WG14/www/docs/n3203.htm
> 
> where the original "this is undefined" came from the fact that
> compilers were simple and restricting things like evaluation order
> caused lots of problems. These days, a weak ordering definition causes
> *many* more problems, and compilers are much smarter, and just saying
> that the code has to act as if there was a strict ordering of
> operations still allows almost all the normal optimizations in
> practice.
> 
> This is just a general "please avoid the idiocies of the past". The
> potential code generation improvements are not worth the pain.
> 
>                Linus
> 


