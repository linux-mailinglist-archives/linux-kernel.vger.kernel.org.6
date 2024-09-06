Return-Path: <linux-kernel+bounces-319479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8796FD2E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29872841BF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8445146588;
	Fri,  6 Sep 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NUGNy1TQ"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B91B85F3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657334; cv=none; b=EPAmHfMESmwvOeYcZWknDZcCVGkiCTyPbdLoX/ypJI+AvWKhwrD+YogNCHQjyQ2wwYYN7aWxh9uYJRYnLwtpcZfaaibJl0frQUHKOMjV1LALOqhYoteGa7F3MZBg7Zq6ikmR3uTDcmOJ5n/UsiZZRN+r2AM/GVCchU8c/h2jvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657334; c=relaxed/simple;
	bh=l+0yeSacAL3zv8lep9C92F5OVmcgi/IPFluSvzfXBtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTP/iQ6G5d8I5FnzaLr/FLg9ccFX9eK7RELEKnYoYwRh8C85NJhj00R6qVsUTPPAoujNq63+elJzXg2ScBu7Rz9tAGatqqHfAEAN5v3LLQdckgG7gct6BzIjGFFeyVpg8OhzoKtF9bZ5K/66uZ7lgefQ/IGAAxiIHy/E98PWXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NUGNy1TQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2E10120B7436;
	Fri,  6 Sep 2024 14:15:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2E10120B7436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725657332;
	bh=F3oZzOF/ypfBSnYIzXfchELhRH8BmGaOrLYbG3ZZEr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NUGNy1TQDidAgIM/nvanGZJAFF5xC8ul4phQPa4EnffgL4o6bkEoHuaKII+TpDrTJ
	 bGgprXkcv7JYQ3kTswVuyypXBefj357yfwU+FGF/bwYrG3gEfgxRMiIz0GevkVW/m7
	 s/17oRZGz1S1Ohldam6eYjBmCucJ8C7hhzt5fqH0=
Message-ID: <61713c72-bd86-4694-9c06-49579a33d8f3@linux.microsoft.com>
Date: Fri, 6 Sep 2024 14:15:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, apais@microsoft.com, benhill@microsoft.com,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
 <20240906112345.GA17874@redhat.com>
 <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
 <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
 <CAHk-=wiSN1NWzG2W1KCQKoG7mM+RmP+dZ0nWNfEagTwPPiDxXQ@mail.gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <CAHk-=wiSN1NWzG2W1KCQKoG7mM+RmP+dZ0nWNfEagTwPPiDxXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/6/2024 1:26 PM, Linus Torvalds wrote:
> On Fri, 6 Sept 2024 at 13:08, Roman Kisel <romank@linux.microsoft.com> wrote:
>>
>> When the process has run into a fatal error and is about to exit, having
>> a way to break into the debugger at this exact moment wouldn't change
>> anything about the logic of the data processing happening in the process.
>> What's so horrible in that to have a way to land in the debugger to see
>> what exactly is going on?
> 
> I don't buy it.
> 
> If you want to debug some fatal behavior, and a debugger *isn't*
> attached, you want it to create a core-dump.
> 
> And if a debugger *is* attached, it will catch that.
> 
> This is basically how abort() has always worked, and it very much is
> *not* doing some "let's check if we're being debugged" stuff. Exactly
> because that would be a bad idea and an anti-pattern.
> 
> The other very traditional model - for example if you do *not* want to
> do core-dumps for some reason, and just exit with an error message -
> is to just put a breakpoint on the "fatal()" function (or whatever
> your "fatal error happened" situation is) using the debugger.
> 
> Then the target will behave differently depending on whether it is
> being debugged or not BECAUSE THE DEBUGGER ASKED FOR IT, not because
> the program decided to act differently when debugged.
> 
> In other words, this is a long-solved problem with solid solutions
> from before Linux even existed.


Writing a core-dump might not be an option as you have pointed out
hence the "fatal()" function might not be permitted to fault.

Breaking into the debugger if it is attached saves a step of setting
a breakpoint and doesn't require the knowledge of the guts of the
standard library and/or the journey of the trap exception from the
CPU to the debugger. The very name of the "fatal()" function is a
tight contract, and something akin to the onion in the varnish for
the uninitiated.

Libraries like Google Breakpad, Boost.Test, C++ std, AWS C SDK,
Unreal Engine have that "breakpoint_if_debugging" facility, folks
find that useful. They all read and parse the "/proc/self/status" file,
where as it may seem, just the ptrace syscall one liner could save
the trouble of that. The kernel helps the user space do work as I
understand, why police it? There is "fork()", and threads can deadlock.
Quite horrible, still the user space has access to that. Here,
there is evidence folks do want to detect if a debugger is present,
there is evidence how the kernel can help the user space compute that
with so much less effort, the patch is trivial. Why don't let the
userspace burn less electricity?

> 
>                Linus

-- 
Thank you,
Roman


