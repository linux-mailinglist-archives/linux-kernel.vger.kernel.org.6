Return-Path: <linux-kernel+bounces-522343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89210A3C8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E5217BB35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A9D22E3FA;
	Wed, 19 Feb 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WVNhvVUB"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0F22B8A2;
	Wed, 19 Feb 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993650; cv=none; b=tZsUdgt0wOgpWz6hDQDRvN0osXQEaLuZz2wa3KSa9SsfbZwhwV2DJ/oL16biJc4Rv6GWQmChUKoni1HaFL7NxZMFHDELPPuRe7EUSvz5+827e+vlkE8/Amd3g3TBN5XmYZKB6CjQcVdGPnnRuwcffExWZTnt1rliHsZAZeOrbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993650; c=relaxed/simple;
	bh=XlIf9FH7eU5x/gC5hcPZv4iP+c96kNd0sEyC8JE8+XM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=i/TgWU/Lyjdxz/Bf+g4J5qghaiTGcPA85zbRtSFZdjPjwjblJoQx/gnCB32ZJni1YEkVJKBWMnf/l2XerVap3FnbCjIf3P++uym7b8KKmLWmKxmlhHoGjAnCCxYhY+RmI5mN0VnnQzPpYctzNPgUhiiQg8TsGU2cjZZX2G9Luf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WVNhvVUB; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51JJXwMZ1903967
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 19 Feb 2025 11:33:58 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51JJXwMZ1903967
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1739993639;
	bh=CtgrdbzIhxbWzyFyksMQafZIrEzN/ovIGMP9JbUYNmo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WVNhvVUBIzEExfK6SoJNy/Bo0j0PYetaoI2jwI7offXONeH1cCiwigS9SFWU8/a90
	 LsdoGmb7ewDEvC+mLLDJUgAJbSa1MENXUSOIeB4sSIqCqXhvaNCYR5CXL3+LwxQG8e
	 Jtf4IEyE8pmCLXakkHZjnzvvLZbbhS3ONYT45CI1UZU7Y62/sptaO8EM5HXxe1jbTT
	 za3n/a8aGhL5SUKbOciTTa3vydlW/KxAxHqbWdjc4GCwoZD33V8HRU5iaU14utkyAw
	 B/zFxFc6LbMwUoqpuM08/69kC6Pahy89u0FwFJBBUQ5zwUrXEvA6orMBGivLYJhrGh
	 YJy91u1S0q78A==
Date: Wed, 19 Feb 2025 11:33:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kees Cook <kees@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
User-Agent: K-9 Mail for Android
In-Reply-To: <202502191026.8B6FD47A1@keescook>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <202502191026.8B6FD47A1@keescook>
Message-ID: <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 19, 2025 10:52:37 AM PST, Kees Cook <kees@kernel=2Eorg> wrote:
>On Tue, Feb 18, 2025 at 07:46:29PM +0100, Miguel Ojeda wrote:
>> On Tue, Feb 18, 2025 at 5:08=E2=80=AFPM Christoph Hellwig <hch@infradea=
d=2Eorg> wrote:
>> > I'd like to understand what the goal of this Rust "experiment" is:  I=
f
>> > we want to fix existing issues with memory safety we need to do that =
for
>> > existing code and find ways to retrofit it=2E  A lot of work went int=
o that
>> > recently and we need much more=2E  But that also shows how core maint=
ainers
>> > are put off by trivial things like checking for integer overflows or
>> > compiler enforced synchronization (as in the clang thread sanitizer)=
=2E
>>=20
>> As I replied to you privately in the other thread, I agree we need to
>> keep improving all the C code we have, and I support all those kinds
>> of efforts (including the overflow checks)=2E
>>=20
>> But even if we do all that, the gap with Rust would still be big=2E
>>=20
>> And, yes, if C (or at least GCC/Clang) gives us something close to
>> Rust, great (I have supported doing something like that within the C
>> committee for as long as I started Rust for Linux)=2E
>>=20
>> But even if that happened, we would still need to rework our existing
>> code, convince everyone that all this extra stuff is worth it, have
>> them learn it, and so on=2E Sounds familiar=2E=2E=2E And we wouldn't ge=
t the
>> other advantages of Rust=2E
>
>Speaking to the "what is the goal" question, I think Greg talks about it
>a bit[1], but I see the goal as eliminating memory safety issues in new
>drivers and subsystems=2E The pattern we've seen in Linux (via syzkaller,
>researchers, in-the-wild exploits, etc) with security flaws is that
>the majority appear in new code=2E Focusing on getting new code written
>in Rust puts a stop to these kinds of flaws, and it has an exponential
>impact, as Android and Usenix have found[2] (i=2Ee=2E vulnerabilities dec=
ay
>exponentially)=2E
>
>In other words, I don't see any reason to focus on replacing existing
>code -- doing so would actually carry a lot of risk=2E But writing *new*
>stuff in Rust is very effective=2E Old code is more stable and has fewer
>bugs already, and yet, we're still going to continue the work of hardenin=
g
>C, because we still need to shake those bugs out=2E But *new* code can be
>written in Rust, and not have any of these classes of bugs at all from
>day one=2E
>
>The other driving force is increased speed of development, as most of
>the common bug sources just vanish, so a developer has to spend much
>less time debugging (i=2Ee=2E the "90/90 rules" fades)=2E Asahi Lina disc=
ussed
>this a bit while writing the M1 GPU driver[3], "You end up reducing the
>amount of possible bugs to worry about to a tiny number"
>
>So I think the goal is simply "better code quality", which has two primar=
y
>outputs: exponentially fewer security flaws and faster development speed=
=2E
>
>-Kees
>
>[1] https://lore=2Ekernel=2Eorg/all/2025021954-flaccid-pucker-f7d9@gregkh
>[2] https://security=2Egoogleblog=2Ecom/2024/09/eliminating-memory-safety=
-vulnerabilities-Android=2Ehtml
>[3] https://asahilinux=2Eorg/2022/11/tales-of-the-m1-gpu/
>

Let me clarify, because I did the bad thing of mixing not just two, but fo=
ur separate topics:

a=2E The apparent vast gap in maturity required of Rust versus C=2E What i=
s our maturity policy going to be? Otherwise we are putting a lot of burden=
 on C maintainers which is effectively wasted of the kernel configuration p=
ulls in even one line of Rust=2E

This is particularly toxic given the "no parallel code" claimed in this po=
licy document (which really needs references if it is to be taken seriously=
; as written, it looks like a specific opinion=2E)

b=2E Can we use existing mature tools, such as C++, to *immediately* impro=
ve the quality (not just memory safety!) of our 37-year-old, 35-million lin=
e code base and allow for further centralized improvements without the majo=
r lag required for compiler extensions to be requested and implemented in g=
cc (and clang) *and* dealing with the maturity issue?

Anyone willing to take bets that the kernel will still have plenty of C co=
de in 2050?

c=2E The desirability of being able to get new code written in a better wa=
y=2E This is most definitely something Rust can do, although the maturity i=
ssue and the syntactic gap (making it harder for reviewers used to C to rev=
iew code without missing details) are genuine problems=2E One is technical-=
procedural, the other is more training-aestetics=2E

d=2E Any upcoming extensions to C or C++ that can provide increased memory=
 safety for the existing code base, or vice that due to (a) or author/maint=
ainer preference cannot be written in Rust=2E

-----

Now, moving on:

A "safe C" *would* require compiler changes, and I don't believe such a pr=
oposal has even been fielded=2E C++, as far as I am concerned, lets us (at =
least to some extent) decouple that and many other things we rely on with s=
ome *really* fuggly combinations of macros and compiler extensions=2E

Rust code, too, would benefit here,  because it would reduce the sematic g=
ap *and* it would carry more information that would make the bindings both =
more natural and more likely to be possible to automate=2E

So I didn't intend to present this as much of an either/or as it came acro=
ss (which was entirely my fault=2E) But I do think it is foolish to ignore =
the existing 35 million lines of code and expect them to go away=2E=20

