Return-Path: <linux-kernel+bounces-321677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC4971DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AFA1F22104
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE3244375;
	Mon,  9 Sep 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bfLtocLI"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338F2C87C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895189; cv=none; b=CUJXZ5fY/91qvgfkLZyc2LRapdFRCytMXkyOW6IOU3wUnixH/DGNorleHphYcGZ2Fv3CV0nhkqcOznIe3wwCygTB2GdfDKXpL/wNwYzOBEwZwpxRobJvU8dEIcbglyzQAETkmI5taL4pawb/wMINE0bGmhv1/xqmAR0V8WOdi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895189; c=relaxed/simple;
	bh=ILpGsLfEUe+Yv1pno802hm6mAEDTtVmP4Zt3npm0RVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FeI58yCXweAztYRZ4ZLd3GzPgonOLWQJcS/48Y+065nUoPax4JFwxA//uekw2A5x2MX8l0NxuJtcacy8ztiOz/dx3SxNIaKWCROA0I9WRa+INDL472u4e9FmUJbup6qU6QPNGcYnsBQk69FI0Iv71sMGpQuPeUEJt/aOjfkhDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bfLtocLI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1B6DC20B7D77;
	Mon,  9 Sep 2024 08:19:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B6DC20B7D77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725895187;
	bh=iUB+v98pbgUWzIXU0TJKVBlGZxBw0YzooAS6zqs5tl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfLtocLI7lo3kTZ1k2vVA/UXZw9iOkJKrXS+BFyd7w0H2xPc8zALRmgJ0r9nMdlG7
	 EESEFVzngsSWmUvc6vw1W3n13ejsfyr3oPePkwKLcDZgOrBT3Uz6p2uepfRh8/gc8n
	 Hmik/8eRug+qIuXcqLO8jUUGIICpwjX5beQ3iJBo=
From: Roman Kisel <romank@linux.microsoft.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	apais@microsoft.com,
	benhill@microsoft.com,
	ebiederm@xmission.com,
	linux-kernel@vger.kernel.org,
	romank@linux.microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	torvalds@linux-foundation.org,
	vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
Date: Mon,  9 Sep 2024 08:19:46 -0700
Message-Id: <20240909151946.1108962-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240908140838.GB21236@redhat.com>
References: <20240908140838.GB21236@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/8/2024, Oleg Nesterov wrote:

> On 09/06, Roman Kisel wrote:
> >
> > On 9/6/2024 1:55 PM, Oleg Nesterov wrote:
> > >
> > >Not that I think this is a good idea, but std::breakpoint_if_debugging()
> > >looks even more strange to me...
> > Can't speak for everyone obviously, I've found that convenient
> > when making sense of large (unknown) codebases instead of setting
> > up breakpoints and adding prints/logs, and when the process
> > can't/doesn't fault when it encounters a fatal error.
>
> Sorry, I don't understand.
>
> I fail to understand how/why people can use std::breakpoint_if_debugging().
> To me it doesn't look useful at all.
>
> But you can safely ignore me, I do not pretend I understand the userspace's
> needs.
>
> And I guess people will use it anyway, so I won't argue with, say, a trivial
> patch which just adds
> 
> case PR_GET_PTRACED:
>     error = !!current->ptrace;
>     break;
>
> into sys_prctl(), even if I agree that this probably just makes bad behavior
> easier.

Very kind of you trying to build a longer table rather than a taller fence,
I appreciate that very much! Your aproach looks very neat indeed, I've learned
a lot from all sugestions you have shared.

>
> But you need to convince Linus.

No new evidence, I rest my case. The difference seems to be a
matter of on which which set of axioms one builds the theorems,
and these sets come across as non-compatible. It might be prudent
to repack these to give this some final thoughts and move on.
Hoping this might be interesting to folks whose service to humanity
requires wearing kernel-tinted glasses.

I brought up evidence-based arguments of the change providing
benefits for the user space, and these were countered with "bad
behavior" on the grounds that changing program's behavior under
debugger is bad. Well, if it's bad for you, you won't do that.
The very notion of convincing becomes devoid of sense in this
situation.

Good for us to land in the debugger at the point of panic without
fiddling with the breakpoints; we're going to continue enjoying that.
Also good to slip in `std::breakpoint_if_debugging` in some obscure
function in someone's library to see how the execution gets there
instead of figuring out through which pointers it is called and what
full name like  `A::B::C::X::Y::Z::func::{impl #12}()` needs to be
used for the breakpoint. Not having to use/know the trap instruction
mnemonic for the target architecture feels not all that bad in the
user space.

That all is very different for the kernel: one C aka portable assembly
codebase that runs the world and where change might be hard, no deadline
or time-to-market as no one sells the kernel as a commodity. Producing
more software faster requires farming things off to the toolchain
(like memory management) or to the 3rd party libraries (to be as general
as possible they use abstractions of abstractions of abstractions cooked
on vtabless, generics and traits), and these present a complication when
debugging. Sure can use a demangled name for the "fatal()" function,
then again why bother and learn the name of that function and making that
into a hard dependency?

Gdb has got aids to land at the `main` function (the `start` command),
why so much ink is being spent of the aids for panic?

It was told in the discussion that all these problems had been solved
before Linux existed. I dare to say the more precise statement would
be that they were solved for a different world. Some 40-30 years
after we live in the world eaten by the software and automation and
figuring out where the bug is can be helped by different means better.

Besides bugs in the patch, why would the kernel even _care_ if/how
the user land uses that tracer PID? That is not sensitive data, and
the user land has access to that already, and uses it in numeruous
large libraries (not just some scrawny pet project of mine) but only
via proc FS and parsing the "/proc/self/status" text pseudo-file.

The kernel could be like "dear user land, here is your sweet one liner
for getting the tracer PID, go knock yourself out reading the tracer
PIDs all day long". And the user land be like "oh, thank you, dear
kernel, one can always count on you!". Win-win. Easy. Joyous.

If folks are still reading or jumped over this long wall of text to
the last paragraph, color me clueless as to why providing a simpler
interface for such an inconsequntial thing as the tracer PID instead
of the existing convoluted one (nailed to proc FS, too) needs to be
resolved by the project's BDFL. Excuse my sudden loss of eloquence
but LOL WUT!

>
> Oleg.

Roman

