Return-Path: <linux-kernel+bounces-417750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574AF9D58BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F761F22EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C423156F3F;
	Fri, 22 Nov 2024 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OlD6moGX"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF32309AE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732247890; cv=none; b=ZoET5yA+O09d3HWqMkVFn0kXXsttKWfPt2TlshmfNoLdVlDSYtPEmuzfIUJqAsFSa7m7QSXj3yMLwMUx3CB6oFpdLuT5+4ETV5bgfy1dC2c1E5rCJlCLHxNc8wonJI3POrYFXLpVgDk3xe1SP1qMaan69IoUx8ciV9WNYGtfWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732247890; c=relaxed/simple;
	bh=T7dZ+j9doBwO/N2QGeeES6BOGVZrrOgu/WBe8RtJez0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+MAeo1DDyrri28QrFATPG5whpuXfO4GZTqaufuzxB1hYXm5+YO7RDS9qxf7q2YkPUI0yT53r9JIidPXXWwkzNBzSKWEbk9MGQnqVFmIMy+hD5YjfC69JixONKPkdkh+oE56c083jqI1d7K2XXL+/uo3jLVqF9Ntco0Q1YMEKk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OlD6moGX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d028003ba7so42858a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732247886; x=1732852686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V6jK6JTZsApLYkwhX3LQfF7Emba3DFSLtBoD9555N3I=;
        b=OlD6moGXUCK67aRs3OevF2fDKA/gMCae3+hRlr3kA4KcRYrKSpj1M1zjy4JsROESf1
         i42Oajb3TvjPGfGwqMgUzIx+O3l2ZFS2b0LW2UUt56YwBZ+pYZxGhFSdSUXJlE+UfliU
         jHtXjV1qspLmcl3+6dXGBPP6JzwWZfUof486A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732247886; x=1732852686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6jK6JTZsApLYkwhX3LQfF7Emba3DFSLtBoD9555N3I=;
        b=XoZKSHu+eKQkaEIurA0B5rKoEMAkP5tj4a7+8nCbUAQXkod5tPhoLcZtqeZ5V1w78d
         dN+mKBoUkG3xkmqU1T0z1cowoyjDsBX/pl1rygC1CSkkkBK3stfowe3a0iYAVFaWWYls
         RyBh9qlxcfJz7Mmylh7jZj9OS6KlxHjD2tGfbbOCSGJmzvYxs/vXKzLQKDSd25VbYj5m
         7RUqvMvlgdykIMuQyrfYFIfFZYIB2ePXEXoAarS+KYwB9AxiqWFJ5dkiiQYrLDz6d3wm
         qMoD8oLM43VRbWuG5Obc1bwtwMJTCSL3FIVMC+C4GJJ3MKSKWOvWA02guuSdzvmjp2uM
         G/ag==
X-Forwarded-Encrypted: i=1; AJvYcCVWwnYIdd0Y3KJTGd1QrDmTvw0X93p1sA9ZFX/GdKOhF1gYhe3O344APajJBQnNVmWV5ZzWhxaPQ8l6+Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLwwlKYYsKO/xomCvDEnayynYYk6+ZqtM3/B707WskFTr2lJT
	/p3Qfk+buGlLNNuH18p1XuNGMrRl+Vu8B4Yi9vUGdUoT8lYynQM0nS5WqiG/iZJewickpRdQZr0
	oavxNbA==
X-Gm-Gg: ASbGncuV/Ruba3o3/tbKM7IrIukxBQ7ugZm9Ec63Gy0owBa6dl6sJ5GP5loWtTfRzjp
	hIqF2LzrDx6ZQvsf4V9CSSrwEXfajvlHEag8h6wV0yZIDXUpJF9st3pMEOzx4ElqMJxHQqQQtfL
	RFxAxy/iZ5eVRU36MwzZc1lekbVgyocy4CewhHX5VI+rlaWLcFvaO2JTRgkgWRnaJdV4Dfr+P8g
	BSgJoufcB/Vd7bscbcTH24yvAljnTGShIiPDTvMI0KmghePJYuDee3YI8Cf28Iu63yZJ6KnOjJr
	YAZJOEc1i5Op7sXY8tHxqUGI
X-Google-Smtp-Source: AGHT+IGI/PIW3pUUIXVzIRUnqCRM5dyf6wP12nIfv/VBG5cUuaiEXzVOVaMijXXnuqLnfGj57F2QrQ==
X-Received: by 2002:a17:906:309b:b0:a9a:6847:e82c with SMTP id a640c23a62f3a-aa5099c24b4mr126305966b.15.1732247886289;
        Thu, 21 Nov 2024 19:58:06 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fb87sm44969466b.95.2024.11.21.19.58.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 19:58:05 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so234337566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:58:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXu5GUljIR1qWU3VM+V/e8O3XFDnY5MQpBdxUZtDRZoL1b/xFNI2Xwb3dlq9ODDjvTKCCVXVLEFtWsv8Nc=@vger.kernel.org
X-Received: by 2002:a17:907:7852:b0:a9a:a7fd:d840 with SMTP id
 a640c23a62f3a-aa509976333mr120569266b.1.1732247884246; Thu, 21 Nov 2024
 19:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe> <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe> <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
 <20241122001223.t4uywacusrplpefq@jpoimboe> <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
 <20241122031115.5aasuktqrp2sidfj@jpoimboe>
In-Reply-To: <20241122031115.5aasuktqrp2sidfj@jpoimboe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Nov 2024 19:57:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjJt49tgtmYv42bXU3h0Txb+mQZEOHseahA4EcK6s=BxA@mail.gmail.com>
Message-ID: <CAHk-=wjJt49tgtmYv42bXU3h0Txb+mQZEOHseahA4EcK6s=BxA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 19:11, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> On Thu, Nov 21, 2024 at 05:02:06PM -0800, Linus Torvalds wrote:
> > [ Time passes ]
> >
> > Ugh. I tried it. It looks like this:
> >
> > #define inlined_get_user(res, ptr) ({                           \
> >         __label__ fail2, fail1;                                 \
> >         __auto_type __up = (ptr);                               \
> >         int __ret = 0;                                          \
> >         if (can_do_masked_user_access())                        \
> >                 __up = masked_user_access_begin(__up);          \
> >         else if (!user_read_access_begin(__up, sizeof(*__up)))  \
> >                 goto fail1;                                     \
> >         unsafe_get_user(res, ptr, fail2);                       \

That 'ptr' needs to be '__up' of course.

Other than that it actually seems to work.

And by "seems to work" I mean "I replaced get_user() with this macro
instead, and my default kernel continued to build fine".

I didn't actually *test* the end result, although i did look at a few
more cases of code generation, and visually it looks sane enough.

> That actually doesn't seem so bad, it's easy enough to follow the logic.

I'm not loving the "if (0)" with the labels inside of it. But it's the
only way I can see to make a statement expression like this work,
since you can't have a "return"  inside of it.

> We could easily use that macro in size-specific inline functions
> selected by a macro with a sizeof(type) switch statement -- not so bad
> IMO if they improve code usage and generation.

The point of it being a macro is that then it doesn't need the
size-specific games at all, because it "just works" since the types
end up percolating inside the logic.

Of course, that depends on unsafe_get_user() itself having the
size-specific games in it, so that's a bit of a lie, but at least it
needs the games in just one place.

And yes, having inline wrappers anyway could then allow for the
compiler making the "inline or not" choice, but the compiler really
doesn't end up having any idea of whether something is more important
from a performance angle, so that wouldn't actually be a real
improvement.

> Then all the arches have to do is implement unsafe_*_user_{1,2,4,8} and
> the "one good implementation" idea comes together?

Yeah, except honestly, basically *none* of them do.

The list or architectures that actually implement the unsafe accessors
is sad: it's x86, powerpc, and arm64. That's it.

Which is - along with my bloat worry - what makes me go "it's not
worth fighting".

Also, honestly, it is *very* rare that "get_user()" and "put_user()"
is performance-critical or even noticeable. We have lots of important
user copies, and the path and argument copy (aka
"strncpy_from_user()") is very important, but very few other places
tend to be.

So I see "copy_from_user()" in profiles, and I see
"strncpy_from_user()", and I've seen a few special cases that I've
converted (look at get_sigset_argpack(), for example - it shows up on
some select-heavy loads).

And now you found another one in that futex code, and that is indeed special.

But honestly, most get_user() cases are really in things like random ioctls etc.

Which is why I suspect we'd be better off just doing the important
ones one by one.

And doing the important ones individually may sound really nasty, but
if they are important, it does kind of make sense.

For example, one place I suspect *is* worth looking at is the execve()
argument handling. But to optimize that isn't about inlining
get_user(). It's about doing more than one word for each user access,
particularly with CLAC/STAC being as slow as they often are.

So what you actually would want to do is to combine these two

                ret = -EFAULT;
                str = get_user_arg_ptr(argv, argc);
                if (IS_ERR(str))
                        goto out;

                len = strnlen_user(str, MAX_ARG_STRLEN);
                if (!len)
                        goto out;

into one thing, if you really cared enough. I've looked at it, and
always gone "I don't _quite_ care that much", even though argument
handling definitely shows up on some benchmarks (partly because it
mostly shows up on fairly artificial ones - the rest of execve is so
expensive that even when we waste some time on argument handling, it's
not noticeable enough to be worth spending huge amount of effort on).

But you could also look at the pure argv counting code (aka "count()"
in fs/exec.c). That *also* shows up quite a bit, and there batching
things migth be a much easier thing. But again, it's not about
inlining get_user(), it's about doing multiple accesses without
turning user accesses on and off all the time.

Anyway, that was a long way of saying: I really think we should just
special-case the (few) important cases that get reported. Because any
*big* improvements will come not from just inlining.

              Linus

