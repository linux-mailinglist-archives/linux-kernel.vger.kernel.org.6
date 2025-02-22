Return-Path: <linux-kernel+bounces-527474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAA7A40B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7956D7AD28F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71920371C;
	Sat, 22 Feb 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hzvN6XoC"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F6202C39;
	Sat, 22 Feb 2025 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740257701; cv=none; b=Ka6R5hW0UR0NMj5U5KJzgJTDQs1BLtxYBRNMlDruLIXEUIeuGG9fFWrdoFHv6lBFxPfOrIPjMkI/lJoh3u1o3GvnMQeuco9PGenqVKfypRcDyhxgAL+v4dk9Apd4fDpjTRGIzD25PcFMlWMpP9pHqT3L7jvd1J/ssDtOSIRxw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740257701; c=relaxed/simple;
	bh=iyj/RWNW0z1QisL95Uk/XOY7VdhZ8WzFbkNS2sGCmtM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Mlk4dIpltk95rQpQ7mXDUeNhPRVLaXO8VCCB5lNRZV3kfJXAJSq9ARbtd98k+llNSaBMVu3iP017QzhbAGdaIJeEY+4xc0GFO2o/77ZrJYehch2q/A5/kMARz09A1o93j9SzHYM7mVcH8f3xMPtUMZ/H2y5Z+FdXZ6TGNZ8yozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=hzvN6XoC; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51MKsVvb3810618
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 22 Feb 2025 12:54:31 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51MKsVvb3810618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740257672;
	bh=iyj/RWNW0z1QisL95Uk/XOY7VdhZ8WzFbkNS2sGCmtM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hzvN6XoC8+bbRgrhLeh8EDDTRyv+650KdHpz+DbBFhXVDD26AMcu3IsRg4CTNtMON
	 gZbSLfkbY+vZ6DqGnKF8ssHNV24zR0ys/DGxj0ekSE1TdJaIKeAHwqKx3a+IGpKYKt
	 B5o+x+SHHKu+igr8Ny8Es7vH6O6AhvFQlXzwNZB1gmf36ToTa6C63QXF+4CNry2J3J
	 swu+zKzy/sdCWYYJTeInIJ6yZsnJRj+4xXUyZtMgz6ji5+GzttFSwGA/ZaUFkR2lMG
	 X7dqOP8uPZlb3UvKm0tk/9x4NJChFCZ4zhMkwum9SR9zKsN5/Ez4RywnFMieGpA8ty
	 c/It6vQwxzGVg==
Date: Sat, 22 Feb 2025 12:54:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>,
        airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
        ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org,
        ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
        miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
User-Agent: K-9 Mail for Android
In-Reply-To: <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft>
Message-ID: <6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 22, 2025 12:00:04 PM PST, Kent Overstreet <kent=2Eoverstreet@li=
nux=2Edev> wrote:
>On Sat, Feb 22, 2025 at 11:18:33AM -0800, Linus Torvalds wrote:
>> On Sat, 22 Feb 2025 at 10:54, Kent Overstreet <kent=2Eoverstreet@linux=
=2Edev> wrote:
>> >
>> > If that work is successful it could lead to significant improvements =
in
>> > code generation, since aliasing causes a lot of unnecessary spills an=
d
>> > reloads - VLIW could finally become practical=2E
>>=20
>> No=2E
>>=20
>> Compiler people think aliasing matters=2E It very seldom does=2E And VL=
IW
>> will never become practical for entirely unrelated reasons (read: OoO
>> is fundamentally superior to VLIW in general purpose computing)=2E
>
>OoO and VLIW are orthogonal, not exclusive, and we always want to go
>wider, if we can=2E Separately, neverending gift that is Spectre should b=
e
>making everyone reconsider how reliant we've become on OoO=2E
>
>We'll never get rid of OoO, I agree on that point=2E But I think it's
>worth some thought experiments about how many branches actually need to
>be there vs=2E how many are there because everyone's assumed "branches ar=
e
>cheap! (so it's totally fine if the CPU sucks at the alternatives)" on
>both the hardware and software side=2E
>
>e=2Eg=2E cmov historically sucked (and may still, I don't know), but a _l=
ot_
>of branches should just be dumb ALU ops=2E I wince at a lot of the
>assembly I see gcc generate for e=2Eg=2E short multiword integer
>comparisons, there are a ton of places where it'll emit 3 or 5 branches
>where 1 is all you need if we had better ALU primitives=2E
>
>> Aliasing is one of those bug-bears where compiler people can make
>> trivial code optimizations that look really impressive=2E So compiler
>> people *love* having simplistic aliasing rules that don't require real
>> analysis, because the real analysis is hard (not just expensive, but
>> basically unsolvable)=2E
>
>I don't think crazy compiler experiments from crazy C people have much
>relevance, here=2E I'm talking about if/when Rust is able to get this
>right=2E
>
>> The C standards body has been much too eager to embrace "undefined beha=
vior"=2E
>
>Agree on C, but for the rest I think you're just failing to imagine what
>we could have if everything wasn't tied to a language with
>broken/missing semantics w=2Er=2Et=2E aliasing=2E
>
>Yes, C will never get a memory model that gets rid of the spills and
>reloads=2E But Rust just might=2E It's got the right model at the referen=
ce
>level, we just need to see if they can push that down to raw pointers in
>unsafe code=2E
>
>But consider what the world would look like if Rust fixes aliasing and
>we get a microarchitecture that's able to take advantage of it=2E Do a
>microarchitecture that focuses some on ALU ops to get rid of as many
>branches as possible (e=2Eg=2E min/max, all your range checks that don't
>trap), get rid of loads and spills from aliasing so you're primarily
>running out of registers - and now you _do_ have enough instructions in
>a basic block, with fixed latency, that you can schedule at compile time
>to make VLIW worth it=2E
>
>I don't think it's that big of a leap=2E Lack of cooperation between
>hardware and compiler folks (and the fact that what the hardware people
>wanted was impossible at the time) was what killed Itanium, so if you
>fix those two things=2E=2E=2E
>
>> The kernel basically turns all that off, as much as possible=2E Overflo=
w
>> isn't undefined in the kernel=2E Aliasing isn't undefined in the kernel=
=2E
>> Things like that=2E
>
>Yeah, the religion of undefined behaviour in C has been an absolute
>nightmare=2E
>
>It's not just the compiler folks though, that way of thinking has
>infected entirely too many people people in kernel and userspace -
>"performance is the holy grail and all that matters and thou shalt shave
>every single damn instruction"=2E
>
>Where this really comes up for me is assertions, because we're not
>giving great guidance there=2E It's always better to hit an assertion tha=
n
>walk off into undefined behaviour la la land, but people see "thou shalt
>not crash the kernel" as a reason not to use BUG_ON() when it _should_
>just mean "always handle the error if you can't prove that it can't
>happen"=2E
>
>> When 'integer overflow' means that you can _sometimes_ remove one
>> single ALU operation in *some* loops, but the cost of it is that you
>> potentially introduced some seriously subtle security bugs, I think we
>> know it was the wrong thing to do=2E
>
>And those branches just _do not matter_ in practice, since if one side
>leads to a trap they're perfectly predicted and to a first approximation
>we're always bottlenecked on memory=2E
>

VLIW and OoO might seem orthogonal, but they aren't =E2=80=93 because they=
 are trying to solve the same problem, combining them either means the OoO =
engine can't do a very good job because of false dependencies (if you are s=
cheduling molecules) or you have to break them instructions down into atoms=
, at which point it is just a (often quite inefficient) RISC encoding=2E In=
 short, VLIW *might* make sense when you are statically scheduling a known =
pipeline, but it is basically a dead end for evolution =E2=80=93 so unless =
you can JIT your code for each new chip generation=2E=2E=2E

But OoO still is more powerful, because it can do *dynamic* scheduling=2E =
A cache miss doesn't necessarily mean that you have to stop the entire mach=
ine, for example=2E

