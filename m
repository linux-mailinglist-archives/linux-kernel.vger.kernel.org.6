Return-Path: <linux-kernel+bounces-321795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB4A971F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25C71F23A19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29FD1531E6;
	Mon,  9 Sep 2024 16:46:17 +0000 (UTC)
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBFF1CF9B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900377; cv=none; b=P/nzAbz+uxAHVDtpZSuj3lBg7DCplAjw7HW2tlZfdTnLGHLN1ZG27fFZzy6vkg12Gb05g7jUhDXpb7pjvz1P58pOKV8etdC90rEZBTu8s+79WuND8Hk1UarA75TV8H4f/4HtHYLApdIswgfF2zJLxfz0sJl7ISGPUwHAtEW3rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900377; c=relaxed/simple;
	bh=6KXvUs11U+Sd/Hq0GeXCXRcRZsiM0D+SehEygOviWEI=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=Q314rVkmYcWA6VdEo9WnAr+7pgUF6rzril7f4N6tQBz0dRBT/Hf0g6l6FKzlb14iX9Ucak0hKQZqQJuYmJ6B8kbLAWvkJP/LXnVgpiCsuQfLatNp7zI5Bh9uUKjcTCFKypal92sJELZaIrow/JuBjm2LI5q909FTfgBU6NnFYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:43700)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1snh6m-006mPb-Iv; Mon, 09 Sep 2024 10:19:20 -0600
Received: from ip68-227-165-127.om.om.cox.net ([68.227.165.127]:47246 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1snh6l-002lhR-Gl; Mon, 09 Sep 2024 10:19:20 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  Oleg Nesterov
 <oleg@redhat.com>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  apais@microsoft.com,
  benhill@microsoft.com,  ssengar@microsoft.com,  sunilmut@microsoft.com,
  vdso@hexbites.dev
References: <20240905212741.143626-1-romank@linux.microsoft.com>
	<20240905212741.143626-2-romank@linux.microsoft.com>
	<20240906112345.GA17874@redhat.com>
	<CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
	<da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
	<CAHk-=wiSN1NWzG2W1KCQKoG7mM+RmP+dZ0nWNfEagTwPPiDxXQ@mail.gmail.com>
	<61713c72-bd86-4694-9c06-49579a33d8f3@linux.microsoft.com>
Date: Mon, 09 Sep 2024 11:18:45 -0500
In-Reply-To: <61713c72-bd86-4694-9c06-49579a33d8f3@linux.microsoft.com> (Roman
	Kisel's message of "Fri, 6 Sep 2024 14:15:33 -0700")
Message-ID: <87ed5ser6i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1snh6l-002lhR-Gl;;;mid=<87ed5ser6i.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.165.127;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX189w2wNJ7oT/2B+HQC/+ZH9aAC46M1qiNk=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4872]
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Roman Kisel <romank@linux.microsoft.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 472 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 15 (3.1%), b_tie_ro: 13 (2.7%), parse: 1.10
	(0.2%), extract_message_metadata: 5 (1.2%), get_uri_detail_list: 2.9
	(0.6%), tests_pri_-2000: 3.9 (0.8%), tests_pri_-1000: 2.4 (0.5%),
	tests_pri_-950: 1.39 (0.3%), tests_pri_-900: 1.16 (0.2%),
	tests_pri_-90: 101 (21.5%), check_bayes: 99 (20.9%), b_tokenize: 10
	(2.1%), b_tok_get_all: 13 (2.7%), b_comp_prob: 4.3 (0.9%),
	b_tok_touch_all: 65 (13.9%), b_finish: 1.49 (0.3%), tests_pri_0: 320
	(67.9%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 3.9
	(0.8%), poll_dns_idle: 1.97 (0.4%), tests_pri_10: 2.3 (0.5%),
	tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: vdso@hexbites.dev, sunilmut@microsoft.com, ssengar@microsoft.com, benhill@microsoft.com, apais@microsoft.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, oleg@redhat.com, torvalds@linux-foundation.org, romank@linux.microsoft.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Roman Kisel <romank@linux.microsoft.com> writes:

> On 9/6/2024 1:26 PM, Linus Torvalds wrote:
>> On Fri, 6 Sept 2024 at 13:08, Roman Kisel <romank@linux.microsoft.com> wrote:
>>>
>>> When the process has run into a fatal error and is about to exit, having
>>> a way to break into the debugger at this exact moment wouldn't change
>>> anything about the logic of the data processing happening in the process.
>>> What's so horrible in that to have a way to land in the debugger to see
>>> what exactly is going on?
>> I don't buy it.
>> If you want to debug some fatal behavior, and a debugger *isn't*
>> attached, you want it to create a core-dump.
>> And if a debugger *is* attached, it will catch that.
>> This is basically how abort() has always worked, and it very much is
>> *not* doing some "let's check if we're being debugged" stuff. Exactly
>> because that would be a bad idea and an anti-pattern.
>> The other very traditional model - for example if you do *not* want to
>> do core-dumps for some reason, and just exit with an error message -
>> is to just put a breakpoint on the "fatal()" function (or whatever
>> your "fatal error happened" situation is) using the debugger.
>> Then the target will behave differently depending on whether it is
>> being debugged or not BECAUSE THE DEBUGGER ASKED FOR IT, not because
>> the program decided to act differently when debugged.
>> In other words, this is a long-solved problem with solid solutions
>> from before Linux even existed.
>
>
> Writing a core-dump might not be an option as you have pointed out
> hence the "fatal()" function might not be permitted to fault.

For that you just need to set core file size rlimit to 0.
Then you can safely raise SIGABRT to terminate your process.

A debugger can also stop at PTRACE_EVENT_EXIT.  The process
is still available (not cleaned up), but already fatally dead.

So I think the scenario of a process exiting is safely handled.

So if that is the case you care about I would say please look at
PTRACE_EVENT_EXIT.

> Breaking into the debugger if it is attached saves a step of setting
> a breakpoint and doesn't require the knowledge of the guts of the
> standard library and/or the journey of the trap exception from the
> CPU to the debugger. The very name of the "fatal()" function is a
> tight contract, and something akin to the onion in the varnish for
> the uninitiated.
>
> Libraries like Google Breakpad, Boost.Test, C++ std, AWS C SDK,
> Unreal Engine have that "breakpoint_if_debugging" facility, folks
> find that useful. They all read and parse the "/proc/self/status" file,
> where as it may seem, just the ptrace syscall one liner could save
> the trouble of that. The kernel helps the user space do work as I
> understand, why police it? There is "fork()", and threads can deadlock.
> Quite horrible, still the user space has access to that. Here,
> there is evidence folks do want to detect if a debugger is present,
> there is evidence how the kernel can help the user space compute that
> with so much less effort, the patch is trivial. Why don't let the
> userspace burn less electricity?

If you want more than just stopping at when a process exits, such as the
not yet standardized std:is_debugger_present and
std:breakpoint_if_debugging calls.  Then a real world justification
needs to be shown why the kernel should optimize for the uncommon case.

Especially because it will take time and energy and maintenance to keep
that going, all for to support a set of facilities that seem highly
dubious.

I suspect the best way to support breakpoint_if_debugging (in the
general case) is to make them nop functions, and then have something
scan the source code collect those locations, and feed those locations
into the debugger as break points.  Perhaps the compiler can be that
scanner and record the list of suggest break points somewhere that
a debugger can read.

As for std:is_debugger_present I suspect the best way to handle that
is to keep the current implementation, making it expensive to use so
people won't use it unthinkingly.  If people are using this facility
enough that they are wasting electricity, an expensive operation at
least has the potential to make people to stop and think about what they
are doing.

From a don't introduce heisenbug's perspective I think optimizing any of
this in the kernel looks like a bad idea.

Am I missing something?

Eric

