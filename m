Return-Path: <linux-kernel+bounces-523703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C19A3DA27
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811E43A565F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DF71F4606;
	Thu, 20 Feb 2025 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOAtIG6F"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1C17BD9;
	Thu, 20 Feb 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740054837; cv=none; b=maK1sf4nm80vTgY1IPW4+72c+Pe+N0WOmVdnaMiEdGtOqKzI/CkJE0/1cSSxKm9Rkj7hIrzJZ1MBFdEXplVwiIngbGLGOK+fPqOQIYPTz4dLX/Khe2mOJKR3QomSj7sl2ogQy4R3l3suy/NkLpJaNCZRJLjhneCDystdT4VxC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740054837; c=relaxed/simple;
	bh=ozvWNiGMPxz4w/NIo01gkSBXnD92ZLlJm8J6GPXIAs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=IfLU+w/VtIVH1i+xK2JxJEzzLqV5ToKf6UNRoxeZWrKmz27pjcoV2QZ46Tr0oudwQAL3swzTkMeEcKBr+RoI6ZI4/yU+02AWV1TkSV9Bm93CCVYf9GRkh7zI878aZi1gLvUJH8CzTvj1dO5Uc+iKdD4aK2v8MpCU4jr4dS5wZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOAtIG6F; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5461a485aa2so838486e87.2;
        Thu, 20 Feb 2025 04:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740054834; x=1740659634; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYAXPliVGAauLvqXilBmcpYtEXaT1hnaJVJeOg5HwD0=;
        b=WOAtIG6FJiqOLB/kCIJce6QcZdq8R5vHm/3Ty+HBOJ/xp8y23rS0e1wts6Okh3m0Xl
         4r7XaLj0Y3O6NL+v3cDSE+W1hul+dAvQBJ1+dq/AcMb5r1VU6iLaZ+LbBVleNSF4Yvnr
         /SqU6pqccq7ZAlO3Z3a3niov+nKzjC90Qr191l3EHrArVGVonouxHKEQFLpOpbF0zPF1
         TpwyqSfrmVONfHUL1nKFMPgNrSS/7Tec+kXTKnsdxtvTTGwn5OHfMwIGCEYLyYCF0W0K
         pkqgBVikKr1eOhtJzInKB9hE1gMAtLQHs6Z4g55FIigSoZUC+tx9xCrYcP+az8B0dbTY
         GH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054834; x=1740659634;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nYAXPliVGAauLvqXilBmcpYtEXaT1hnaJVJeOg5HwD0=;
        b=d+oO9WqCQDovd9mXwQ5dWdfSi6LnY0TNNWW4ICu3pSaI/nZkK57YQGbg5fINdt+ZIS
         TirjHPGOCEwSACjBgv+q0Iz8xXSSvWOcgVqxNSuGtVTDQR0tq2g8nVGZVnbYglh0kDY4
         Sk8JoOUTOS9W90bveb690s96NwzIsJqe0jrjOBTaMF3n4qxXuTzVLMg/tJFoOkFhizjw
         azZEMve89NQumlAuKz9Ni2tjoBIWUgyPRxZAc7hOqRShDMjEO88MpGyhPl0Wzhn3lu2D
         1jGyVcjR2/wyx1xxrQKdCIm38iOd2zKULRzXEwfO7XJktXDuQp+Brfcl09CBELOn9fMF
         EyFg==
X-Forwarded-Encrypted: i=1; AJvYcCW0qMqUhhs8+0BuMzJ0E6dICJ6jNViILnhQmkoe4BkU4V16ZcjvDagHE3y4xpTSfgYRJ+x1xQJgfPvAO6Y=@vger.kernel.org, AJvYcCX+VgzfwSjClrC3VfFse8CAf0JD/QDDZ9Ug+9e/d3uxDK+ezgz0e1wDcW3qmVdTuG/I7Kh81Wj3GJ3W5cfQB84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v1LWSzVsmlU7F+ipssGfssk6WIzwbdJZTBQHr0j9CoG9Atyr
	+1RBqSyvG3++rl9YpDdPnR4DmlYot08Aftatq6kpa4mdq8i/nLIu
X-Gm-Gg: ASbGncu4YlCHtZyjmfbAJebAJh2H4GiCsmNGfdT+IIfMc+S5gY0UXukitNMsxr56SJH
	zlGB0lgZhqcIyRIDejq0uHb7d9eyJqZ8r0PlGL9YX8uJM+6HFSaHnRw+JzBXGz6OIU62Zx9hgMM
	607oaRk9mTjkzrfhGyHRds7aGWOr4onh8RqRCmHnro3chSK9MCSPFBP9WKoCI9dnk+VMj99L4fI
	XevEq/ylE9hOdQ7rPiSicMvguy2jzha1JeZ1HzsKW1iDpzR6tqEWh9tEBE8fZC8OLr9dvfc5GUD
	oul7FsJcHWkBxYu4RQS9V5MOWzYxD/tjFFsTinySi2g70tEtP/NjJkixmVPJh86ZiCXYaw==
X-Google-Smtp-Source: AGHT+IH1ejzRcUGwQ7tpWDXI2tDssHtf/tFe624MSGF77jilBq2ScDfgvkViwEk7KHUfCCFbU4aYJw==
X-Received: by 2002:a05:6512:3e2a:b0:545:e2e:8443 with SMTP id 2adb3069b0e04-5462ef1c5femr3742717e87.32.1740054833155;
        Thu, 20 Feb 2025 04:33:53 -0800 (PST)
Received: from NB-1741-LNX.corp.1440.space (broadband-5-228-81-61.ip.moscow.rt.ru. [5.228.81.61])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54527f929e7sm2096560e87.44.2025.02.20.04.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 04:33:52 -0800 (PST)
Message-ID: <757c92b484bb13172426644b5b5193bca391d14e.camel@gmail.com>
Subject: Re: Rust kernel policy
From: vpotach@gmail.com
To: hpa@zytor.com
Cc: airlied@gmail.com, gregkh@linuxfoundation.org, hch@infradead.org, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org, 
	torvalds@linux-foundation.org
Date: Thu, 20 Feb 2025 15:33:51 +0300
In-Reply-To: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>On February 18, 2025 10:46:29 AM PST, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>>On Tue, Feb 18, 2025 at 5:08=E2=80=AFPM Christoph Hellwig <hch@infradead.=
org>
wrote:
>>>
>>> I don't think having a web page in any form is useful.  If you want
it
>>> to be valid it has to be in the kernel tree and widely agreed on.
>>
>>Please let me reply with what I said a couple days ago in another
thread:
>>
>>    Very happy to do so if others are happy with it.
>>
>>    I published it in the website because it is not a document the
overall
>>    kernel community signed on so far. Again, we do not have that
>>    authority as far as I understand.
>>
>>    The idea was to clarify the main points, and gather consensus.
The
>>    FOSDEM 2025 keynote quotes were also intended in a similar way:
>>
>>      =20
https://fosdem.org/2025/events/attachments/fosdem-2025-6507-rust-for-linux/=
slides/236835/2025-02-0_iwSaMYM.pdf
>>
>>https://lore.kernel.org/rust-for-linux/CANiq72mFKNWfGmc5J_9apQaJMgRm6M7tv=
VFG8xK+ZjJY+6d6Vg@mail.gmail.com/
>>
>>> It also states factually incorrect information.  E.g.
>>>
>>> "Some subsystems may decide they do not want to have Rust code for
the
>>> time being, typically for bandwidth reasons. This is fine and
expected."
>>>
>>> while Linus in private said that he absolutely is going to merge
Rust
>>> code over a maintainers objection.  (He did so in private in case
you
>>> are looking for a reference).
>>
>>The document does not claim Linus cannot override maintainers
anymore.
>>That can happen for anything, as you very well know. But I think
>>everyone agrees that it shouldn't come to that -- at least I hope so.
>>
>>The document just says that subsystems are asked about it, and decide
>>whether they want to handle Rust code or not.
>>
>>For some maintainers, that is the end of the discussion -- and a few
>>subsystems have indeed rejected getting involved with Rust so far.
>>
>>For others, like your case, flexibility is needed, because otherwise
>>the entire thing is blocked.
>>
>>You were in the meeting that the document mentions in the next
>>paragraph, so I am not sure why you bring this point up again. I know
>>you have raised your concerns about Rust before; and, as we talked in
>>private, I understand your reasoning, and I agree with part of it.
But
>>I still do not understand what you expect us to do -- we still think
>>that, today, Rust is worth the tradeoffs for Linux.
>>
>>If the only option you are offering is dropping Rust completely, that
>>is fine and something that a reasonable person could argue, but it is
>>not on our plate to decide.
>>
>>What we hope is that you would accept someone else to take the bulk
of
>>the work from you, so that you don't have to "deal" with Rust, even
if
>>that means breaking the Rust side from time to time because you don't
>>have time etc. Or perhaps someone to get you up to speed with Rust --
>>in your case, I suspect it wouldn't take long.
>>
>>If there is anything that can be done, please tell us.
>>
>>> So as of now, as a Linux developer or maintainer you must deal with
>>> Rust if you want to or not.
>>
>>It only affects those that maintain APIs that are needed by a Rust
>>user, not every single developer.
>>
>>For the time being, it is a small subset of the hundreds of
>>maintainers Linux has.
>>
>>Of course, it affects more those maintainers that maintain key
>>infrastructure or APIs. Others that already helped us can perhaps can
>>tell you their experience and how much the workload has been.
>>
>>And, of course, over time, if Rust keeps growing, then it means more
>>and more developers and maintainers will be affected. It is what it
>>is...
>>
>>> Where Rust code doesn't just mean Rust code [1] - the bindings look
>>> nothing like idiomatic Rust code, they are very different kind of
beast
>>
>>I mean, hopefully it is idiomatic unsafe Rust for FFI! :)
>>
>>Anyway, yes, we have always said the safe abstractions are the
hardest
>>part of this whole effort, and they are indeed a different kind of
>>beast than "normal safe Rust". That is partly why we want to have
more
>>Rust experts around.
>>
>>But that is the point of that "beast": we are encoding in the type
>>system a lot of things that are not there in C, so that then we can
>>write safe Rust code in every user, e.g. drivers. So you should be
>>able to write something way closer to userspace, safe, idiomatic Rust
>>in the users than what you see in the abstractions.
>>
>>> So we'll have these bindings creep everywhere like a cancer and are
>>> very quickly moving from a software project that allows for and
strives
>>> for global changes that improve the overall project to increasing
>>> compartmentalization [2].  This turns Linux into a project written
in
>>> multiple languages with no clear guidelines what language is to be
used
>>> for where [3].  Even outside the bindings a lot of code isn't going
to
>>> be very idiomatic Rust due to kernel data structures that intrusive
and
>>> self referencing data structures like the ubiquitous linked lists.
>>> Aren't we doing a disservice both to those trying to bring the
existing
>>> codebase into a better safer space and people doing systems
programming
>>> in Rust?
>>
>>We strive for idiomatic Rust for callers/users -- for instance, see
>>the examples in our `RBTree` documentation:
>>
>>    https://rust.docs.kernel.org/kernel/rbtree/struct.RBTree.html
>>
>>> I'd like to understand what the goal of this Rust "experiment" is:
If
>>> we want to fix existing issues with memory safety we need to do
that for
>>> existing code and find ways to retrofit it.  A lot of work went
into that
>>> recently and we need much more.  But that also shows how core
maintainers
>>> are put off by trivial things like checking for integer overflows
or
>>> compiler enforced synchronization (as in the clang thread
sanitizer).
>>
>>As I replied to you privately in the other thread, I agree we need to
>>keep improving all the C code we have, and I support all those kinds
>>of efforts (including the overflow checks).
>>
>>But even if we do all that, the gap with Rust would still be big.
>>
>>And, yes, if C (or at least GCC/Clang) gives us something close to
>>Rust, great (I have supported doing something like that within the C
>>committee for as long as I started Rust for Linux).
>>
>>But even if that happened, we would still need to rework our existing
>>code, convince everyone that all this extra stuff is worth it, have
>>them learn it, and so on. Sounds familiar... And we wouldn't get the
>>other advantages of Rust.
>>
>>> How are we're going to bridge the gap between a part of the kernel
that
>>> is not even accepting relatively easy rules for improving safety vs
>>> another one that enforces even strong rules.
>>
>>Well, that was part of the goal of the "experiment": can we actually
>>enforce this sort of thing? Is it useful? etc.
>>
>>And, so far, it looks we can do it, and it is definitely useful, from
>>the past experiences of those using the Rust support.
>>
>>> So I don't think this policy document is very useful.  Right now
the
>>> rules is Linus can force you whatever he wants (it's his project
>>> obviously) and I think he needs to spell that out including the
>>> expectations for contributors very clearly.
>>
>>I can support that.
>>
>>> For myself I can and do deal with Rust itself fine, I'd love
bringing
>>> the kernel into a more memory safe world, but dealing with an
uncontrolled
>>> multi-language codebase is a pretty sure way to get me to spend my
>>> spare time on something else.  I've heard a few other folks mumble
>>> something similar, but not everyone is quite as outspoken.
>>
>>I appreciate that you tell us all this in a frank way.
>>
>>But it is also true that there are kernel maintainers saying publicly
>>that they want to proceed with this. Even someone with 20 years of
>>experience saying "I don't ever want to go back to C based
development
>>again". Please see the slides above for the quotes.
>>
>>We also have a bunch of groups and companies waiting to use Rust.
>>
>>Cheers,
>>Miguel

>I have a few issues with Rust in the kernel:=20
>1. It seems to be held to a *completely* different and much lower
standard than the C code as far as stability. For C code we typically
require that it can compile with a 10-year-old version of gcc, but from
what I have seen there have been cases where Rust level code required
not the latest bleeding edge compiler, not even a release version.
>2. Does Rust even support all the targets for Linux?=20
>3. I still feel that we should consider whether it would make sense to
compile the *entire* kernel with a C++ compiler. I know there is a huge
amount of hatred against C++, and I agree with a lot of it =E2=80=93 *but* =
I
feel that the last few C++ releases (C++14 at a minimum to be specific,
with C++17 a strong want) actually resolved what I personally consider
to have been the worst problems.
>As far as I understand, Rust-style memory safety is being worked on
for C++; I don't know if that will require changes to the core language
or if it is implementable in library code.=20
>David Howells did a patch set in 2018 (I believe) to clean up the C
code in the kernel so it could be compiled with either C or C++; the
patchset wasn't particularly big and mostly mechanical in nature,
something that would be impossible with Rust. Even without moving away
from the common subset of C and C++ we would immediately gain things
like type safe linkage.=20
>Once again, let me emphasize that I do *not* suggest that the kernel
code should use STL, RTTI, virtual functions, closures, or C++
exceptions. However, there are a *lot* of things that we do with really
ugly macro code and GNU C extensions today that would be much cleaner =E2=
=80=93
and safer =E2=80=93 to implement as templates. I know ... I wrote a lot of =
it
:)
>One particular thing that we could do with C++ would be to enforce
user pointer safety.

why there is can't simplify kernel development by c++ without use std
and others overhead features. C++ have ideal C binding, why not

