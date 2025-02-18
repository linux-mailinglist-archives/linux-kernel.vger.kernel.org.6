Return-Path: <linux-kernel+bounces-520126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BC8A3A5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536353A454B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1271EB5CF;
	Tue, 18 Feb 2025 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9+SW2sX"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC67171092;
	Tue, 18 Feb 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904405; cv=none; b=NmvDuRkRFdpwT+1JH4qORw7731B63mhhKgD302svlZEoCvPXEFTlpJramvUEANMeMqTql7L2dogT6cfiRR5HKlWe1XHIE0V+pz3Pr8x6zZQapSgFH7pZQ1ty1GW+0KeUC4aTkYWE2psr8xqxZbP5DRntit4vq86jLazdkRlGo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904405; c=relaxed/simple;
	bh=aVAZxhsnJu333d4k4/6dmFYzKcfHQLmsdQHJVTE9Sg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQAeGGR0rdM+vei0BLPi/+Bwv8qdQ1v4OajJFBNKuuFEKRXsChy/UfoPbEopVh+Fmy/vfaJiCsifRMQeqAE0mxujAnrNh1gWDOdAqpp10THVTlLqByGrkCK+oDR3tdurfmcekTkPMqAPFZS7l70XhavLCLJ6YMiW4F1s18T8jzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9+SW2sX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbfe16cbf5so1341897a91.0;
        Tue, 18 Feb 2025 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739904403; x=1740509203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/2FaVo/lBOXzWm3jlnjb2HcUKGZtC12S0KJcpOSk/A=;
        b=F9+SW2sXtf5cEPAUcwevf5hJK6ToeSc9IkBHA60Wv5avLgs9dadif7exth1eW0wjeJ
         YSS+WNrSorKHN4W+dAhuU00sMuQLFfxA7TvIY72/7Sh1lO1P9YhP+qDAsMhWFdaWBbbn
         QKKG4ABvUDRJAx8cALAfBMrNLYLWCVeEwvSJFS3EZKxrP/DDN3bE8ivz0kwGOdcSyPH0
         Tb2HD/4FHR0o2kwSJxo5ycUFOvf5PxfqhhWWON7SwXIYCZaDPS+BlLdYsqoPNIUAVxUa
         WVVm5PM90EA3BY3JVuu4AxmuKZzep6cWOHXbTOLqZtvofltWn7vLZLdafS4lhH6kUIql
         heMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739904403; x=1740509203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/2FaVo/lBOXzWm3jlnjb2HcUKGZtC12S0KJcpOSk/A=;
        b=uPu1WQ3Bk9WTNRcWgKZrX56z59SYqpY7D8+PwKTHy5y/xwGbbaEUMftxiBuOQAwcp/
         WxRDyLvgjWLVa3jKWGGSbqsudrq03+9srM5JMKDQHomjxAGiZ0PB97AO7/adZF7e5eeA
         8c3xDrbwqN537WhZ+4J40Y+bUjUX8Le3l7aSXYJHri/Jcwotxoz152ubcw8ouvOu46mp
         1sXJdSxdttxrYKQNC7zd10W2nS0FCRlNo5YJ3b/146aSxfsuQKrn8lYaEzhdDUYIL+cF
         /AVhhX9dEhkHzVa3dK4Jv6UkCZBIoIGbvDoyysz/BvC/dZ42fDu+IYd5yUrt459AiUXl
         NF5w==
X-Forwarded-Encrypted: i=1; AJvYcCU8zT8Yz1PEbYe2VIln1KFU/rttphjTYIhn6ca/QvGevoj0RU1VSAR5abqCcMueZADk2ocwSGxX5xTvTCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUHvzsZY+TIsgM3TLQp6t/sh2lcueEkruB6X29gzIcvL6ilqP
	5Lav70yPLbt05Na2+bj/Pa/g8pD/5nBEFhc1KuLDomOVRENbwcN9rw6Gieo2Vfidu8sFWgq4v5R
	oDpfpLkF4v7QOrtSJTrLR9Q8+IXA=
X-Gm-Gg: ASbGncuHBOne7C+wNuQXJSG2lIjfm5O5pIcIh2qBzUntLW+SE+mp/tPODwkB8xAkeTt
	i0kz+cJOpqadrdC1wedfwtL+G5pyQOhQY4Ztvg8d2l6qB8OZfDiLHvdU7UXrITQWh3r+svGhm
X-Google-Smtp-Source: AGHT+IF0uREqdEwjx0ag6aWBRPeRbJ+z2sBuaH3Hr0Bl3fQW+MOfsusihzJxFqrj17iysZCqUjqnt9OECmNXXsukHXM=
X-Received: by 2002:a05:6a00:3e0c:b0:72a:a7a4:99ca with SMTP id
 d2e1a72fcca58-73261778caamr9426371b3a.2.1739904402591; Tue, 18 Feb 2025
 10:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
In-Reply-To: <Z7SwcnUzjZYfuJ4-@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 18 Feb 2025 19:46:29 +0100
X-Gm-Features: AWEUYZmxNAFnhlaD5ZcP1ltN0pNWFBk7GAc-H-kiQgaZsTPLc53MmCd-J1pCZZw
Message-ID: <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Christoph Hellwig <hch@infradead.org>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 5:08=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> I don't think having a web page in any form is useful.  If you want it
> to be valid it has to be in the kernel tree and widely agreed on.

Please let me reply with what I said a couple days ago in another thread:

    Very happy to do so if others are happy with it.

    I published it in the website because it is not a document the overall
    kernel community signed on so far. Again, we do not have that
    authority as far as I understand.

    The idea was to clarify the main points, and gather consensus. The
    FOSDEM 2025 keynote quotes were also intended in a similar way:

        https://fosdem.org/2025/events/attachments/fosdem-2025-6507-rust-fo=
r-linux/slides/236835/2025-02-0_iwSaMYM.pdf

https://lore.kernel.org/rust-for-linux/CANiq72mFKNWfGmc5J_9apQaJMgRm6M7tvVF=
G8xK+ZjJY+6d6Vg@mail.gmail.com/

> It also states factually incorrect information.  E.g.
>
> "Some subsystems may decide they do not want to have Rust code for the
> time being, typically for bandwidth reasons. This is fine and expected."
>
> while Linus in private said that he absolutely is going to merge Rust
> code over a maintainers objection.  (He did so in private in case you
> are looking for a reference).

The document does not claim Linus cannot override maintainers anymore.
That can happen for anything, as you very well know. But I think
everyone agrees that it shouldn't come to that -- at least I hope so.

The document just says that subsystems are asked about it, and decide
whether they want to handle Rust code or not.

For some maintainers, that is the end of the discussion -- and a few
subsystems have indeed rejected getting involved with Rust so far.

For others, like your case, flexibility is needed, because otherwise
the entire thing is blocked.

You were in the meeting that the document mentions in the next
paragraph, so I am not sure why you bring this point up again. I know
you have raised your concerns about Rust before; and, as we talked in
private, I understand your reasoning, and I agree with part of it. But
I still do not understand what you expect us to do -- we still think
that, today, Rust is worth the tradeoffs for Linux.

If the only option you are offering is dropping Rust completely, that
is fine and something that a reasonable person could argue, but it is
not on our plate to decide.

What we hope is that you would accept someone else to take the bulk of
the work from you, so that you don't have to "deal" with Rust, even if
that means breaking the Rust side from time to time because you don't
have time etc. Or perhaps someone to get you up to speed with Rust --
in your case, I suspect it wouldn't take long.

If there is anything that can be done, please tell us.

> So as of now, as a Linux developer or maintainer you must deal with
> Rust if you want to or not.

It only affects those that maintain APIs that are needed by a Rust
user, not every single developer.

For the time being, it is a small subset of the hundreds of
maintainers Linux has.

Of course, it affects more those maintainers that maintain key
infrastructure or APIs. Others that already helped us can perhaps can
tell you their experience and how much the workload has been.

And, of course, over time, if Rust keeps growing, then it means more
and more developers and maintainers will be affected. It is what it
is...

> Where Rust code doesn't just mean Rust code [1] - the bindings look
> nothing like idiomatic Rust code, they are very different kind of beast

I mean, hopefully it is idiomatic unsafe Rust for FFI! :)

Anyway, yes, we have always said the safe abstractions are the hardest
part of this whole effort, and they are indeed a different kind of
beast than "normal safe Rust". That is partly why we want to have more
Rust experts around.

But that is the point of that "beast": we are encoding in the type
system a lot of things that are not there in C, so that then we can
write safe Rust code in every user, e.g. drivers. So you should be
able to write something way closer to userspace, safe, idiomatic Rust
in the users than what you see in the abstractions.

> So we'll have these bindings creep everywhere like a cancer and are
> very quickly moving from a software project that allows for and strives
> for global changes that improve the overall project to increasing
> compartmentalization [2].  This turns Linux into a project written in
> multiple languages with no clear guidelines what language is to be used
> for where [3].  Even outside the bindings a lot of code isn't going to
> be very idiomatic Rust due to kernel data structures that intrusive and
> self referencing data structures like the ubiquitous linked lists.
> Aren't we doing a disservice both to those trying to bring the existing
> codebase into a better safer space and people doing systems programming
> in Rust?

We strive for idiomatic Rust for callers/users -- for instance, see
the examples in our `RBTree` documentation:

    https://rust.docs.kernel.org/kernel/rbtree/struct.RBTree.html

> I'd like to understand what the goal of this Rust "experiment" is:  If
> we want to fix existing issues with memory safety we need to do that for
> existing code and find ways to retrofit it.  A lot of work went into that
> recently and we need much more.  But that also shows how core maintainers
> are put off by trivial things like checking for integer overflows or
> compiler enforced synchronization (as in the clang thread sanitizer).

As I replied to you privately in the other thread, I agree we need to
keep improving all the C code we have, and I support all those kinds
of efforts (including the overflow checks).

But even if we do all that, the gap with Rust would still be big.

And, yes, if C (or at least GCC/Clang) gives us something close to
Rust, great (I have supported doing something like that within the C
committee for as long as I started Rust for Linux).

But even if that happened, we would still need to rework our existing
code, convince everyone that all this extra stuff is worth it, have
them learn it, and so on. Sounds familiar... And we wouldn't get the
other advantages of Rust.

> How are we're going to bridge the gap between a part of the kernel that
> is not even accepting relatively easy rules for improving safety vs
> another one that enforces even strong rules.

Well, that was part of the goal of the "experiment": can we actually
enforce this sort of thing? Is it useful? etc.

And, so far, it looks we can do it, and it is definitely useful, from
the past experiences of those using the Rust support.

> So I don't think this policy document is very useful.  Right now the
> rules is Linus can force you whatever he wants (it's his project
> obviously) and I think he needs to spell that out including the
> expectations for contributors very clearly.

I can support that.

> For myself I can and do deal with Rust itself fine, I'd love bringing
> the kernel into a more memory safe world, but dealing with an uncontrolle=
d
> multi-language codebase is a pretty sure way to get me to spend my
> spare time on something else.  I've heard a few other folks mumble
> something similar, but not everyone is quite as outspoken.

I appreciate that you tell us all this in a frank way.

But it is also true that there are kernel maintainers saying publicly
that they want to proceed with this. Even someone with 20 years of
experience saying "I don't ever want to go back to C based development
again". Please see the slides above for the quotes.

We also have a bunch of groups and companies waiting to use Rust.

Cheers,
Miguel

