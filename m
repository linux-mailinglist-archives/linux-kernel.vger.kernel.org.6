Return-Path: <linux-kernel+bounces-182634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D838C8D91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9146F1F22C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34C1411EB;
	Fri, 17 May 2024 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k2LUksB3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C801411D0
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980505; cv=none; b=aUPNLQu1oudufYxF6DHN5JXD65ddZ4MeMvNj1cf4/2Ghj7Xrqni6MnPw3tYzCmxoT/CsteRugnEfFTbu82jhbRUy94qn4VRitUivUUmR1GmfBAuz652W1CmjELU3OTGXc4DvoTrpfslhNWikjfsuVnRFJ7FNq+5BHxnc1BMWAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980505; c=relaxed/simple;
	bh=mD/KumOF6xJOrXdrXUF2ZE4OvGpSMspkcjoU/w1zKc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjJplzcaegK1pMbFXxwPGTwNPqdfCbUVbgcyA4L2L2rSj3yMBGpQwFmQD5sFXovnofUt0IzW9BtZAQZxykhoM2bA5lcXxvIvfF3bJRWxFJScsw2fWP/0drMeWdYzxho/r0XO9ZdZg226U3kj4NJTd6xrqEr94z7VaAei/c4jx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k2LUksB3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1edfc57ac0cso21391255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715980503; x=1716585303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwsbsmYbbDKnC5BT3KwLmoyUvx5LBcv4lPLoAGZmpdk=;
        b=k2LUksB34tj+bhZx0fdJZQCb23tgoQvDSWXv9PgZDfqBgw/hA1LVnmVlkc4ZuqJ2b3
         A6s9AEIfNxgqdiispWaceWpVJF1zRnoSTT+n5I8peur5dvO7M8WKc/grE6m8zvNX5AtG
         AW6uy1INtiVl+pfhY6CiFFqAb8hdL4BDd7BRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980503; x=1716585303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwsbsmYbbDKnC5BT3KwLmoyUvx5LBcv4lPLoAGZmpdk=;
        b=Gcxh+ZLKQB/9nt7VKeJgKf+yqpMjFDi9PUCKl4/oRj4DuP9GVYmbCF1AG2w3okWl2K
         lOlP8zCsQQJwRPDbHo0QJ9Asiad7Gj8U3dDooN0hRraDZJRpWrEDHZiggrg+4pr9uZjO
         rg8jtZnUSBZEqS6dkyScWZgmtpmkOt/IldE0YrX3pPgLDSm8zwLQY0+cWl4YN0MuZzTz
         ExL43nRAQPvQWOPiWEKN4I/zAJ8zR+ER8izAIImA5syh4VXj70Id9DE0wd0BcddnKuxb
         w6dYmKEb120D08QG/56hIl+av4/rQywpGrrMki3pnRGJnUaW0n5wqhlgoYvoGYy6J871
         BysA==
X-Forwarded-Encrypted: i=1; AJvYcCXGwvD5KrYWfsKZZ7+QJh2aHh0rSa2mQ+bRv11TdGuI2vG72a/CoYmv/kYnsAq/WvSwlf2lC5Ap51S9URWryAyEx6L4He2FKD0pRdIp
X-Gm-Message-State: AOJu0YzZK5WpzxlwgJ3ADBZerFQGyRBcJHSNP2X72CqZjwRyY9do8Q3w
	NT6fgJCvfOVCppeVzU9yUQOX4Y8J+lIMKv2gtFITWsJHrpilhxhwTUXUwwe+0Zr45JuHG/994XY
	=
X-Google-Smtp-Source: AGHT+IHIzu7juLKRK4wQDKZxcEVDWqSSXb79G8PTTEseVZvkiTBbeumQWCYKWtOuDU3JqCgeVqysCg==
X-Received: by 2002:a17:902:ea10:b0:1f0:84e3:a619 with SMTP id d9443c01a7336-1f084e3a955mr147911465ad.14.1715980503633;
        Fri, 17 May 2024 14:15:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f09363ac7dsm57168635ad.93.2024.05.17.14.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:15:02 -0700 (PDT)
Date: Fri, 17 May 2024 14:15:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
Message-ID: <202405171329.019F2F566C@keescook>
References: <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook>
 <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook>
 <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <20240515073636.GY40213@noisy.programming.kicks-ass.net>
 <25882715-FE44-44C0-BB9B-57F2E7D1F0F9@kernel.org>
 <20240516140951.GK22557@noisy.programming.kicks-ass.net>
 <CAFhGd8qCCCrccQ2z5bjBD5YcMWHkym9aVz_qYkyyj662XEeHvA@mail.gmail.com>
 <20240516205134.GC287325@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516205134.GC287325@mit.edu>

On Thu, May 16, 2024 at 02:51:34PM -0600, Theodore Ts'o wrote:
> On Thu, May 16, 2024 at 12:48:47PM -0700, Justin Stitt wrote:
> > 
> > It is incredibly important that the exact opposite approach is taken;
> > we need to be annotating (or adding type qualifiers to) the _expected_
> > overflow cases. The omniscience required to go and properly annotate
> > all the spots that will cause problems would suggest that we should
> > just fix the bug outright. If only it was that easy.
> 
> It certainly isn't easy, yes.  But the problem is when you dump a huge
> amount of work and pain onto kernel developers, when they haven't
> signed up for it, when they don't necessarily have the time to do all
> of the work themselves, and when their corporate overlords won't given
> them the headcount to handle unfunded mandates which folks who are
> looking for a bright new wonderful future --- don't be surprised if
> kernel developers push back hard.

I never claimed this to be some kind of "everyone has to stop and make
these changes" event. I even talked about how it would be gradual and
not break existing code (all "WARN and continue anyway"). This is what
we've been doing with the array bounds work. Lots of people are helping
with that, but a lot of those patches have been from Gustavo and me; we
tried to keep the burden away from other developers as much as we could.

> One of the big problems that we've seen with many of these security
> initiatives is that the teams create these unfunded mandates get their
> performance reviews based on how many "bug reports" that they file,
> regardless of whether they are real problems or not.  This has been a
> problem with syzkaller, and with clusterfuzz.  Let's not make this
> problem worse with new and fancy sanitizers, please.

Are you talking about *my* security initiatives? I've been doing this
kind work in the kernel for 10 years, and at no time has "bug report
count" been a metric. In fact, the whole goal is making it _impossible_
to have a bug. (e.g. VLA removal, switch fallthrough, etc). My drive has
been to kill entire classes of bugs.

The use of sanitizers isn't to just bolster fuzzers (though they're
helpful for finding false positives). It's to use the sanitizers _in
production_, to stop flaws from being exploitable. Android has enabled
the array bounds sanitizer in trap mode for at least 2 years now. We
want the kernel to be self-protective; pro-actively catching flaws.

> Unfortunately, I don't get funding from my employer to clear these
> kinds of reports, so when I do the work, it happens on the weekends or
> late at night, on my own time, which is probably why I am so grumpy

As for the work itself, like I mentioned before, most of these get fixed
my Gustavo, me, and now Justin too. And many other folks step up to help
out, which is great. Some get complex and other maintainers get involved
too, but it's slow and steady. We're trying to reduce the frequency of
the "fires" people have to scramble to deal with.

The "not getting paid by Google to [fix syzkaller bugs]" part, I'm
surprised by. A big part of my Google job role is the upstream work I do
not only on security hardening but also on seccomp, pstore, execve/binfmt,
strings, etc. I'll reach out offline to find out more details.

> about this.  Whether you call this "sharpening our focus", or "year of
> efficiency", or pick your corporate buzzwords, it really doesn't
> matter.  The important thing is that the figure of merit must NOT be
> "how many security bugs that are found", but how much bullsh*t noise
> do these security features create, and how do you decrease overhead by
> upstream developers to deal with the fuzzing/ubsan/security tools
> find.

I guess I *do* worry about bug counts, but only in that I want them to
be _zero_. I know other folks aren't as adamant about eliminating bug
classes, but it's really not hyperbole that bugs in Linux kill people.
If you think I'm engaging in corporate buzzword shenanigans, then I have
a lot more work to do on explaining the rationale behind the security
hardening efforts.

All this said, yes, I hear what you (and Linus and others) have been
saying about minimizing the burden on other developers. I have tried my
best to keep it limited, but some things are more front-and-center (like
unexpected integer overflows), so that's why I wanted to get feedback on
how to roll it out -- I didn't see a way to make these changes in a way
that would be as unintrusive(?) as our prior efforts.

It has felt like the biggest pain point has been helping developers
shift their perspective about C: it has been more than a fancy assembler
for several decades, and we can lean on those features (and create new
ones) that shift the burden of correctness to the compiler from the
human. This does mean we need to change some styles to be more
"observable" (and unambiguous) for the compiler, though.

I think a great example recently was Peter's work creating "cleanup.h".
This feature totally changes how people have to read a function (increase
in burden), leans heavily on compiler behaviors, and shifts the burden
of correctness away from the human. It's great! But it's also _very
different_ from traditional/old-school C.

-Kees

-- 
Kees Cook

