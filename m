Return-Path: <linux-kernel+bounces-321850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30025972058
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A553F1F24566
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA4175D34;
	Mon,  9 Sep 2024 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SCbB9KIK"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4016BE0D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902532; cv=none; b=nC20/AwASKNmDH7/laRryNFYdrUQKX1r/S1/pBHkV8rPpFqYOlDHp4CSjHwLYmJ5jf9e9ivXIdBFVHuZsZ6J/eBjctpDREzOOjm6HwlX+C5qRjOBsFHZSt0xkkMVIV87AIfRSXehxoGqNvzj45hstkyPCV9NZn/g/az8cu5r17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902532; c=relaxed/simple;
	bh=6FQaxn46EwsSZOKjM4ZkkoQdqVrRILhdk0emY5OYN3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZL3c9hb8JgdCcizMYnMWinKel6rLCyzfh6aOkMHKqjmRlR0UTxH8+UFRceLU1qS19u+5kRJy6dBgv1iSok8lYyqTzYyRc7HicKN6NhO9HE1L8kylUvWxv6pT8VW5lO+77ZTjTr11aPj8U+On8zR7wD8FYVZpSaH9w0UyJF3YO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SCbB9KIK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8C39420B7D7F;
	Mon,  9 Sep 2024 10:22:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C39420B7D7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725902530;
	bh=7WYhILwU4beH56tsdRfuJ+hGUP/FGyg2t4cCaZiEzps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCbB9KIKUq/GTqbIYldk7vgv9jxSyR0EG+X3WoHmMvv3TGSQzBTM0CgT+yBoel5RX
	 eKubGCA9SoG+eT9Un09EoA5m5RxnZfztI0c9rnHB+zDnhOZne8u1nQyioQOq1qXjNh
	 BlSTwS2d3tHETR6aFAGggNtIXfcOurB4lGQhzVO0=
From: Roman Kisel <romank@linux.microsoft.com>
To: ebiederm@xmission.com
Cc: akpm@linux-foundation.org,
	apais@microsoft.com,
	benhill@microsoft.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	romank@linux.microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	torvalds@linux-foundation.org,
	vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
Date: Mon,  9 Sep 2024 10:22:10 -0700
Message-Id: <20240909172210.1116122-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87ed5ser6i.fsf@email.froward.int.ebiederm.org>
References: <87ed5ser6i.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/9/2024, Eric wrote:

> > On 9/6/2024 1:26 PM, Linus Torvalds wrote:
> >> On Fri, 6 Sept 2024 at 13:08, Roman Kisel <romank@linux.microsoft.com> wrote:
> >>>
> >>> When the process has run into a fatal error and is about to exit, having
> >>> a way to break into the debugger at this exact moment wouldn't change
> >>> anything about the logic of the data processing happening in the process.
> >>> What's so horrible in that to have a way to land in the debugger to see
> >>> what exactly is going on?
> >> I don't buy it.
> >> If you want to debug some fatal behavior, and a debugger *isn't*
> >> attached, you want it to create a core-dump.
> >> And if a debugger *is* attached, it will catch that.
> >> This is basically how abort() has always worked, and it very much is
> >> *not* doing some "let's check if we're being debugged" stuff. Exactly
> >> because that would be a bad idea and an anti-pattern.
> >> The other very traditional model - for example if you do *not* want to
> >> do core-dumps for some reason, and just exit with an error message -
> >> is to just put a breakpoint on the "fatal()" function (or whatever
> >> your "fatal error happened" situation is) using the debugger.
> >> Then the target will behave differently depending on whether it is
> >> being debugged or not BECAUSE THE DEBUGGER ASKED FOR IT, not because
> >> the program decided to act differently when debugged.
> >> In other words, this is a long-solved problem with solid solutions
> >> from before Linux even existed.
> >
> >
> > Writing a core-dump might not be an option as you have pointed out
> > hence the "fatal()" function might not be permitted to fault.
> 
> For that you just need to set core file size rlimit to 0.
> Then you can safely raise SIGABRT to terminate your process.
> 
> A debugger can also stop at PTRACE_EVENT_EXIT.  The process
> is still available (not cleaned up), but already fatally dead.
> 
> So I think the scenario of a process exiting is safely handled.
> 
> So if that is the case you care about I would say please look at
> PTRACE_EVENT_EXIT.
> 
> > Breaking into the debugger if it is attached saves a step of setting
> > a breakpoint and doesn't require the knowledge of the guts of the
> > standard library and/or the journey of the trap exception from the
> > CPU to the debugger. The very name of the "fatal()" function is a
> > tight contract, and something akin to the onion in the varnish for
> > the uninitiated.
> >
> > Libraries like Google Breakpad, Boost.Test, C++ std, AWS C SDK,
> > Unreal Engine have that "breakpoint_if_debugging" facility, folks
> > find that useful. They all read and parse the "/proc/self/status" file,
> > where as it may seem, just the ptrace syscall one liner could save
> > the trouble of that. The kernel helps the user space do work as I
> > understand, why police it? There is "fork()", and threads can deadlock.
> > Quite horrible, still the user space has access to that. Here,
> > there is evidence folks do want to detect if a debugger is present,
> > there is evidence how the kernel can help the user space compute that
> > with so much less effort, the patch is trivial. Why don't let the
> > userspace burn less electricity?
> 
> If you want more than just stopping at when a process exits, such as the
> not yet standardized std:is_debugger_present and
> std:breakpoint_if_debugging calls.  Then a real world justification
> needs to be shown why the kernel should optimize for the uncommon case.
> 
> Especially because it will take time and energy and maintenance to keep
> that going, all for to support a set of facilities that seem highly
> dubious.
> 
> I suspect the best way to support breakpoint_if_debugging (in the
> general case) is to make them nop functions, and then have something
> scan the source code collect those locations, and feed those locations
> into the debugger as break points.  Perhaps the compiler can be that
> scanner and record the list of suggest break points somewhere that
> a debugger can read.
> 
> As for std:is_debugger_present I suspect the best way to handle that
> is to keep the current implementation, making it expensive to use so
> people won't use it unthinkingly.  If people are using this facility
> enough that they are wasting electricity, an expensive operation at
> least has the potential to make people to stop and think about what they
> are doing.
> 
> From a don't introduce heisenbug's perspective I think optimizing any of
> this in the kernel looks like a bad idea.
> 
> Am I missing something?

This part "people won't use it unthinkingly" does not look too convincing
to me: why not add an expensive spin loop or a 1 second wait to all parts
of the kernel that must be used with caution? I am imagining flashing
L.E.D.s in the modern smartphone, sorry, couldn't help but imagine that :D.
I believe that's a matter of documentation and perfromance evaluation.

I see that the vote has been 3:1 in favor of not merging anything like that,
and no new ideas have surfaced so far to change this. Looks like could close
on this. Appreciate helping me see your points!

> 
> Eric

Roman

