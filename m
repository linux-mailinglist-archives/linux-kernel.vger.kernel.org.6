Return-Path: <linux-kernel+bounces-520546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BEEA3AB53
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB9F173E08
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13C61D63EF;
	Tue, 18 Feb 2025 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="szvIeAr8"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3F1B85CC;
	Tue, 18 Feb 2025 21:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915359; cv=none; b=S1XY+p9qJ/7aUcRMa6LGNU777mTf+o85BfosDjuhFObrMNcZYfuJAQuJd46U6UDXprUyo2RLmINuDfZSKo7dLWgspacGXiMgGoX4p4KpVeB5v56uyPvVY6Kq9kBz/SFID/j62ujh9ifnmclQVqTO8V9JGIZ6ugs1vvNNPS4adcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915359; c=relaxed/simple;
	bh=gBe4EQvSYKuXrBLLtMqzm3SMZrqaVoWtyvZIhLDsUYE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WGDHu32t5E4CxLqNA3f3XQenzmMrN0tACF6v64nXI10J+AZk1a/vmTS8Obw7+xk7fiVb2YVuNIvcr704sw9s1wKum9156DJvh6ivf1/FdiLblsCFMSWatwY++ce6iYtt9GRLheXMEeHGlrF7o8znZ1KFXuGXcDJmir1OLd2JfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=szvIeAr8; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51ILn2os1489992
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Feb 2025 13:49:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51ILn2os1489992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1739915343;
	bh=U3oKIXD1QEyio5CAspYZGBsXVhm3ZyQR37Cdxvzdk8A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=szvIeAr86LR8sujx7NtH/oeZO3I95V7A/72VcbjzXIMOsqnMdkKTaNOHLEtLaMTql
	 lvdD18NQ3jX7q5IqwquGzz+t2cfQxkR6gKQxqFbAA7KuKvaXFQieNyjtmyCkafJ5kU
	 FjXZNXqK/VxWVMz0KcNEZsvH1NKxyWrxXwoBNcke8zPm2KeYUaElFv/zwbKB3fKwg9
	 vE/kNT1cgQifvOzfQlGVYr3rwVO1AJGkKGHKDyNWEDKbUcEFBKlcO6MaExFaTxscSe
	 CUOe7a0Pwoz+tFffvOaWMGQsfkpkAlDCcFLlv+cY6UVLvnEU37GntVDQxoBHjjurgh
	 RwylT+NU/qUtw==
Date: Tue, 18 Feb 2025 13:49:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
CC: rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
User-Agent: K-9 Mail for Android
In-Reply-To: <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
Message-ID: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 18, 2025 10:46:29 AM PST, Miguel Ojeda <miguel=2Eojeda=2Esandon=
is@gmail=2Ecom> wrote:
>On Tue, Feb 18, 2025 at 5:08=E2=80=AFPM Christoph Hellwig <hch@infradead=
=2Eorg> wrote:
>>
>> I don't think having a web page in any form is useful=2E  If you want i=
t
>> to be valid it has to be in the kernel tree and widely agreed on=2E
>
>Please let me reply with what I said a couple days ago in another thread:
>
>    Very happy to do so if others are happy with it=2E
>
>    I published it in the website because it is not a document the overal=
l
>    kernel community signed on so far=2E Again, we do not have that
>    authority as far as I understand=2E
>
>    The idea was to clarify the main points, and gather consensus=2E The
>    FOSDEM 2025 keynote quotes were also intended in a similar way:
>
>        https://fosdem=2Eorg/2025/events/attachments/fosdem-2025-6507-rus=
t-for-linux/slides/236835/2025-02-0_iwSaMYM=2Epdf
>
>https://lore=2Ekernel=2Eorg/rust-for-linux/CANiq72mFKNWfGmc5J_9apQaJMgRm6=
M7tvVFG8xK+ZjJY+6d6Vg@mail=2Egmail=2Ecom/
>
>> It also states factually incorrect information=2E  E=2Eg=2E
>>
>> "Some subsystems may decide they do not want to have Rust code for the
>> time being, typically for bandwidth reasons=2E This is fine and expecte=
d=2E"
>>
>> while Linus in private said that he absolutely is going to merge Rust
>> code over a maintainers objection=2E  (He did so in private in case you
>> are looking for a reference)=2E
>
>The document does not claim Linus cannot override maintainers anymore=2E
>That can happen for anything, as you very well know=2E But I think
>everyone agrees that it shouldn't come to that -- at least I hope so=2E
>
>The document just says that subsystems are asked about it, and decide
>whether they want to handle Rust code or not=2E
>
>For some maintainers, that is the end of the discussion -- and a few
>subsystems have indeed rejected getting involved with Rust so far=2E
>
>For others, like your case, flexibility is needed, because otherwise
>the entire thing is blocked=2E
>
>You were in the meeting that the document mentions in the next
>paragraph, so I am not sure why you bring this point up again=2E I know
>you have raised your concerns about Rust before; and, as we talked in
>private, I understand your reasoning, and I agree with part of it=2E But
>I still do not understand what you expect us to do -- we still think
>that, today, Rust is worth the tradeoffs for Linux=2E
>
>If the only option you are offering is dropping Rust completely, that
>is fine and something that a reasonable person could argue, but it is
>not on our plate to decide=2E
>
>What we hope is that you would accept someone else to take the bulk of
>the work from you, so that you don't have to "deal" with Rust, even if
>that means breaking the Rust side from time to time because you don't
>have time etc=2E Or perhaps someone to get you up to speed with Rust --
>in your case, I suspect it wouldn't take long=2E
>
>If there is anything that can be done, please tell us=2E
>
>> So as of now, as a Linux developer or maintainer you must deal with
>> Rust if you want to or not=2E
>
>It only affects those that maintain APIs that are needed by a Rust
>user, not every single developer=2E
>
>For the time being, it is a small subset of the hundreds of
>maintainers Linux has=2E
>
>Of course, it affects more those maintainers that maintain key
>infrastructure or APIs=2E Others that already helped us can perhaps can
>tell you their experience and how much the workload has been=2E
>
>And, of course, over time, if Rust keeps growing, then it means more
>and more developers and maintainers will be affected=2E It is what it
>is=2E=2E=2E
>
>> Where Rust code doesn't just mean Rust code [1] - the bindings look
>> nothing like idiomatic Rust code, they are very different kind of beast
>
>I mean, hopefully it is idiomatic unsafe Rust for FFI! :)
>
>Anyway, yes, we have always said the safe abstractions are the hardest
>part of this whole effort, and they are indeed a different kind of
>beast than "normal safe Rust"=2E That is partly why we want to have more
>Rust experts around=2E
>
>But that is the point of that "beast": we are encoding in the type
>system a lot of things that are not there in C, so that then we can
>write safe Rust code in every user, e=2Eg=2E drivers=2E So you should be
>able to write something way closer to userspace, safe, idiomatic Rust
>in the users than what you see in the abstractions=2E
>
>> So we'll have these bindings creep everywhere like a cancer and are
>> very quickly moving from a software project that allows for and strives
>> for global changes that improve the overall project to increasing
>> compartmentalization [2]=2E  This turns Linux into a project written in
>> multiple languages with no clear guidelines what language is to be used
>> for where [3]=2E  Even outside the bindings a lot of code isn't going t=
o
>> be very idiomatic Rust due to kernel data structures that intrusive and
>> self referencing data structures like the ubiquitous linked lists=2E
>> Aren't we doing a disservice both to those trying to bring the existing
>> codebase into a better safer space and people doing systems programming
>> in Rust?
>
>We strive for idiomatic Rust for callers/users -- for instance, see
>the examples in our `RBTree` documentation:
>
>    https://rust=2Edocs=2Ekernel=2Eorg/kernel/rbtree/struct=2ERBTree=2Eht=
ml
>
>> I'd like to understand what the goal of this Rust "experiment" is:  If
>> we want to fix existing issues with memory safety we need to do that fo=
r
>> existing code and find ways to retrofit it=2E  A lot of work went into =
that
>> recently and we need much more=2E  But that also shows how core maintai=
ners
>> are put off by trivial things like checking for integer overflows or
>> compiler enforced synchronization (as in the clang thread sanitizer)=2E
>
>As I replied to you privately in the other thread, I agree we need to
>keep improving all the C code we have, and I support all those kinds
>of efforts (including the overflow checks)=2E
>
>But even if we do all that, the gap with Rust would still be big=2E
>
>And, yes, if C (or at least GCC/Clang) gives us something close to
>Rust, great (I have supported doing something like that within the C
>committee for as long as I started Rust for Linux)=2E
>
>But even if that happened, we would still need to rework our existing
>code, convince everyone that all this extra stuff is worth it, have
>them learn it, and so on=2E Sounds familiar=2E=2E=2E And we wouldn't get =
the
>other advantages of Rust=2E
>
>> How are we're going to bridge the gap between a part of the kernel that
>> is not even accepting relatively easy rules for improving safety vs
>> another one that enforces even strong rules=2E
>
>Well, that was part of the goal of the "experiment": can we actually
>enforce this sort of thing? Is it useful? etc=2E
>
>And, so far, it looks we can do it, and it is definitely useful, from
>the past experiences of those using the Rust support=2E
>
>> So I don't think this policy document is very useful=2E  Right now the
>> rules is Linus can force you whatever he wants (it's his project
>> obviously) and I think he needs to spell that out including the
>> expectations for contributors very clearly=2E
>
>I can support that=2E
>
>> For myself I can and do deal with Rust itself fine, I'd love bringing
>> the kernel into a more memory safe world, but dealing with an uncontrol=
led
>> multi-language codebase is a pretty sure way to get me to spend my
>> spare time on something else=2E  I've heard a few other folks mumble
>> something similar, but not everyone is quite as outspoken=2E
>
>I appreciate that you tell us all this in a frank way=2E
>
>But it is also true that there are kernel maintainers saying publicly
>that they want to proceed with this=2E Even someone with 20 years of
>experience saying "I don't ever want to go back to C based development
>again"=2E Please see the slides above for the quotes=2E
>
>We also have a bunch of groups and companies waiting to use Rust=2E
>
>Cheers,
>Miguel
>
>

I have a few issues with Rust in the kernel:=20

1=2E It seems to be held to a *completely* different and much lower standa=
rd than the C code as far as stability=2E For C code we typically require t=
hat it can compile with a 10-year-old version of gcc, but from what I have =
seen there have been cases where Rust level code required not the latest bl=
eeding edge compiler, not even a release version=2E

2=2E Does Rust even support all the targets for Linux?=20

3=2E I still feel that we should consider whether it would make sense to c=
ompile the *entire* kernel with a C++ compiler=2E I know there is a huge am=
ount of hatred against C++, and I agree with a lot of it =E2=80=93 *but* I =
feel that the last few C++ releases (C++14 at a minimum to be specific, wit=
h C++17 a strong want) actually resolved what I personally consider to have=
 been the worst problems=2E

As far as I understand, Rust-style memory safety is being worked on for C+=
+; I don't know if that will require changes to the core language or if it =
is implementable in library code=2E=20

David Howells did a patch set in 2018 (I believe) to clean up the C code i=
n the kernel so it could be compiled with either C or C++; the patchset was=
n't particularly big and mostly mechanical in nature, something that would =
be impossible with Rust=2E Even without moving away from the common subset =
of C and C++ we would immediately gain things like type safe linkage=2E=20

Once again, let me emphasize that I do *not* suggest that the kernel code =
should use STL, RTTI, virtual functions, closures, or C++ exceptions=2E How=
ever, there are a *lot* of things that we do with really ugly macro code an=
d GNU C extensions today that would be much cleaner =E2=80=93 and safer =E2=
=80=93 to implement as templates=2E I know =2E=2E=2E I wrote a lot of it :)

One particular thing that we could do with C++ would be to enforce user po=
inter safety=2E

