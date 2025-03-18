Return-Path: <linux-kernel+bounces-565461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E333CA668C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50A63AA2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8041AC892;
	Tue, 18 Mar 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPH5bKfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46F38FA6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742273753; cv=none; b=I7B4XDpMGCIbsnZvQ268oU+nIyBe8Ukij3PPQzyT8WyboYgIbJ1YdTDQtGmlP4EQQZJWe424gykTkx1ga0VBt/cHW9XIZhtJQiMQax5f75VpeNSAZ92I5UEivwm1J1vligNpimr1KTcqIYJ2SJOqWdbuH0ciPcywt8T9L8+Y5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742273753; c=relaxed/simple;
	bh=9ZrI25qH/EhVKqPNJZif0y8TMFqgMO6agzepFnceBCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbDaUfVbh6RjXeWFz5AQxZVXt7S/Ig9FxPQGaImVsSIhyQMxzz8OEbYoE4cUvCVEEu+fYDV/3lY8z9Eyv5jWDmDnEEJ0+vo7sypH0yxH5HaJZGYzBPC+vH8YJiQlVs/nOMYu76CIdKK2/MDrITiIsTn9MM5mB0PodvIg+/4RuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPH5bKfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4959FC4CEDD;
	Tue, 18 Mar 2025 04:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742273752;
	bh=9ZrI25qH/EhVKqPNJZif0y8TMFqgMO6agzepFnceBCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPH5bKfOojDaamWv2Mbt0MEqvFzVE3i6K6IR++3W6tDdUVRjicyyDFzbTIZu3t2qy
	 iQipP3thngW13EajaQ3bBTtKYa6XVP9nwSPUfs7dwBIlylcQGovgScIP61M+RsYcwc
	 dZ367V+1VDXqRVIIg9bD1VNXnWi9ckdmIzJIBIdzi+51odM3n+P+bGgxFj/+OhzZnk
	 3lMjBBJtEjedHtb+IRRbsgk6q6MOuyEZGw0KWroIs83vi1w/rAyfW33lEQs9deBy6b
	 +THDYqlVvvvy3FYwdqjf/iArzA5AeMtFFoxmUJF0cidY3HqV+8tWbvEe7JF94Id/5B
	 sDbIRpw1Q+7OA==
Date: Mon, 17 Mar 2025 21:55:49 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Brendan Jackman <jackmanb@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/13] objtool: Add CONFIG_OBJTOOL_WERROR
Message-ID: <an7pjo3yx4hkpvdz6di4t75c2jtpij23zumtqicqwqmt4abmhs@ajd4mlxmreq3>
References: <cover.1741975349.git.jpoimboe@kernel.org>
 <3e7c109313ff15da6c80788965cc7450115b0196.1741975349.git.jpoimboe@kernel.org>
 <Z9YeR20Vua8GQIiW@gmail.com>
 <isd5ptllbyya5rqzyr75w7b6vasnpyomnub22prdegr2jdodrv@75qx5eg5bppn>
 <Z9a8Uign6ZBmWtZQ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9a8Uign6ZBmWtZQ@gmail.com>

On Sun, Mar 16, 2025 at 12:56:02PM +0100, Ingo Molnar wrote:
>   # Included a fix for a false positive:
>   #
>   4e32645cd8f9 x86/smp: Fix mwait_play_dead() and acpi_processor_ffh_play_dead() noreturn behavior

A noreturn warning is (at least) a minor bug.  It means objtool doesn't
fully grok the CFG, which compromises the ORC generation.

Even if it's only a minor bug, and only due to objtool's confusion, it
still affects runtime.

Also, while unlikely, it could be hiding other warnings for frame
pointers, noinstr, uaccess, CPU mitigations.

>   # objtool poinpointed a problem that has no runtime effects,
>   # ie. it's a functional false positive and breaking the build
>   # for *that* would have been excessive:
>   #
>   73e8079be9e7 x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n

I hadn't seen that one.  But as PeterZ knows, making objtool happy is a
normal part of developing such "special" non-standard code.  Those
noinstr rules exist for a very good reason.

>   # Commit works around an objtool false positive found during development:
>   #
>   b815f6877d80 x86/bhi: Add BHI stubs

I don't know what false positive that was.  This is probably another
example of the "special"-ness of FineIBT+BHI.

>   # Commit works around what appears to be a objtool false positive
>   # about too aggressive code generation in function prologues:
>   # (An issue that does not seem to trigger in practice.)
>   #
>   4087e16b0331 x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()

If objtool saw it, this was a real frame pointer bug, not a theoretical
one.

> I literally tried to find the first *actual* bug that objtool prevented 
> and the first 4 appear to be struggles with objtool over false 
> positives or non-runtime-bugs.

Well, at least two of those are actual runtime-affecting bugs.  Maybe
nothing earth shattering, but they're not false positives either.  And
the BHI stuff is "special".

> At least in x86 architecture code a significant percentage of objtool 
> warnings isn't bugs - and to be fair that's maybe in part due to the 
> lockdep effect: developers notice warnings and prevent them, so only 
> traces of false positives trickle into the kernel.

That's definitely a big factor.  Objtool is very good at finding
compiler bugs, uaccess bugs, noinstr, IBT, retpoline, unintended UB,
etc.  Many of those are found surprisingly often, and tend to get fixed
during development if the user sees the warning and understands it.

Also there have been a lot of those noreturn warnings lately.  But again
I don't consider those false positives.  I do have some ideas on getting
rid of those altogether.

> But lockdep too tries to be rather benign and doesn't crash the
> kernel, it reports an issue and turns itself off.

But there's a key difference: objtool warnings happen at build time,
when something can be done to fix them, rather than runtime when it's
too late.

If there were a way to detect lockdep warnings at build time, that would
absolutely justify a build failure IMO.

Anyway, despite all that, I don't have any strong objection to disabling
it by default.  I was waffling on the default anyway.  Just having the
option is already a big improvement.

Though there are some "fatal" errors which are likely to cause boot
failures and other calamaties.  At some point those should be classified
as errors which *always* fail the build regardless of OBJTOOL_WERROR.
Similar to a compiler error.  I think that still needs some cleanup
though.

-- 
Josh

