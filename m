Return-Path: <linux-kernel+bounces-537096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A62A4880C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1168188BE10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9B25EF9C;
	Thu, 27 Feb 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="s4GkiV94"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716BB20409A;
	Thu, 27 Feb 2025 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681900; cv=none; b=GY4VVioRZLcM/iw708DCbVMJDHM+kbrgSUckHFv+stJQXReV/D++QIw5itWr4ExSEVW/QB6kRIc934wB+Tb9Pd33O9JGXmFXw8/uOpkrxZfQUFquNIVRzal40WwpEijUnMJT11wGNiibWzI1tiG+Gi6gMavtBLtJ9K3k+gQ18RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681900; c=relaxed/simple;
	bh=jPTjTgvjlrxaDcxejfvbSiaPv936H+Y8dBeB7m3EO0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4+FUBp4GROuKivEVPtOouIqFQLGt37IUlwXrMkmU8K8IdhEmIh6MyNEWZh9Te6CBLu+CnD4pvbLreWEggNU+zqPDfyBsiDhiWvLmO71bgz7L+x/pWRWQSstkmeFR/Ci6QUcXLIs7UgxcZ5Qq5NAab9f98N5qFzzf1w3wGp9nJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=s4GkiV94; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740681896; bh=jPTjTgvjlrxaDcxejfvbSiaPv936H+Y8dBeB7m3EO0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s4GkiV94SUr13UlmFx0h+q55GTEas139UlMO9uqpC9/ZUfBBZTcvjVbKpiNuH5zg4
	 Fsl/OnPe+fAWmNngvdLBJVBRQQRq5RIFDZ5J35RIMnvYnw70nyOLTJBSlFBSFNhvj5
	 iSShteSlWLxZ4toVyL+0tOLF6xH9/pe+DrhQ1iuo=
Received: from [IPV6:2001:8e0:207e:3500:4ab6:48fe:df57:b084] (2001-8e0-207e-3500-4ab6-48fe-df57-b084.ewm.ftth.ip6.as8758.net [IPv6:2001:8e0:207e:3500:4ab6:48fe:df57:b084])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id 870E22052A91;
	Thu, 27 Feb 2025 19:44:56 +0100 (CET)
Message-ID: <7d77b05f-393e-48d9-9f3f-31b80a64ae7a@ralfj.de>
Date: Thu, 27 Feb 2025 19:44:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Uecker <uecker@tugraz.at>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
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
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
 <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Ralf Jung <post@ralfj.de>
In-Reply-To: <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> So "safe rust" should generally not be impacted, and you can make the
> very true argument that safe rust can be optimized more aggressively
> and migth be faster than unsafe rust.
> 
> And I think that should be seen as a feature, and as a basic tenet of
> safe vs unsafe. A compiler *should* be able to do better when it
> understands the code fully.

That's not quite how it works in Rust. One basic tenet of unsafe is that unsafe 
does not impact program semantics at all. It would be very surprising to most 
Rust folks if adding or removing or changing the scope of an unsafe block could 
change what my program does (assuming the program still builds and passes the 
usual safety checks).

Now, is there an interesting design space for a language where the programmer 
somehow marks blocks of code where the semantics should be "more careful"? 
Absolutely, I think that is quite interesting. However, it's also not at all 
clear to me how that should actually be done, if you try to get down to it and 
write out the proper precise, ideally even formal, spec. Rust is not exploring 
that design space, at least not thus far. In fact, it is common in Rust to use 
`unsafe` to get better performance (e.g., by using a not-bounds-checked array 
access), and so it would be counter to the goals of those people if we then 
optimized their code less because it uses `unsafe`.

There's also the problem that quite a few optimizations rely on "universal 
properties" -- properties that are true everywhere in the program. If you allow 
even the smallest exception, that reasoning breaks down. Aliasing rules are an 
example of that: there's no point in saying "references are subject to strict 
aliasing requirements in safe code, but in unsafe blocks you are allowed to 
break that". That would be useless, then we might as well remove the aliasing 
requirements entirely (for the optimizer; we'd keep the borrow checker of 
course). The entire point of aliasing requirements is that when I optimize safe 
code with no unsafe code in sight, I can make assumptions about the code in the 
rest of the program. If I cannot make those assumptions any more, because some 
unsafe code somewhere might actually legally break the aliasing rules, then I 
cannot even optimize safe code any more. (I can still do the always-correct 
purely local aliasing analysis you mentioned, of course. But I can no longer use 
the Rust type system to provide any guidance, not even in entirely safe code.)

Kind regards,
Ralf

> 
>> There would certainly be opposition if this fundamentally
>> diverges from C++ because no compiler framework will seriously
>> consider implementing a completely different memory model
>> for C (or for Rust) than for C++.
> 
> Well, if the C++ peoiple end up working on some "safe C" model, I bet
> they'll face the same issues.
> 
>> I could also imagine that the problem here is that it is
>> actually very difficult for compilers to give the guarantess
>> you want, because they evolved from compilers
>> doing optimization for single threads and and one would
>> have to fix a lot of issues in the optimizers.  So the
>> actually problem here might be that nobody wants to pay
>> for fixing the compilers.
> 
> I actually suspect that most of the work has already been done in practice.
> 
> As mentioned, some time ago I checked the whole issue of
> rematerializing loads, and at least gcc doesn't rematerialize loads
> (and I just double-checked: bad_for_rematerialization_p() returns true
> for mem-ops)
> 
> I have this memory that people told me that clang similarly
> 
> And the C standards committee already made widening stores invalid due
> to threading issues.
> 
> Are there other issues? Sure. But remat of memory loads is at least
> one issue, and it's one that has been painful for the kernel - not
> because compilers do it, but because we *fear* compilers doing it so
> much.
> 
>             Linus


