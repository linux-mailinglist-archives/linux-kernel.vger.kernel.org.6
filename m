Return-Path: <linux-kernel+bounces-362917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B6699BB2E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814281C20EDA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6F148302;
	Sun, 13 Oct 2024 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPbanFlY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xrN0snCj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F8126BF2
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728846141; cv=none; b=FhRhPGq4J9jNy3mUHM3Y6uHMtOD8T/PKvQiWDrxZpUYciSxF0jH4nqDc5L8L9UO5cAN8+hoBGGynKQdYiB1RsgR2h2wDyKmghthTHEyQKXuqr/oR5nvEY+kkjHI3VHceqg4LrWcbB8KayYbuZI5UpTeQK1x5yJyDPoV7KKSEHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728846141; c=relaxed/simple;
	bh=nOinyig7KnokC/BQbob8LbgmeMITg2b9nmE/OTGMSIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HchKQTrYGs0cjEszhHhpypszuaV8Ks3pd7IQY3PbRTwH4D7OJzwhO9wMsJCowP0fpsPCoIVTjuGPUD0dDRMxTn+ZUbHx6a6znAfCEp6ya6hf7jKLzrOxchevliSlos6uU61nrVUN+YNx9y29dCwrYFKrqD97MuboP+RUxyu1ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPbanFlY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xrN0snCj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728846137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJX6KrnrJtu42HEdJXarSbGs/RtOSlZ6fSizcPT7CKM=;
	b=nPbanFlYHBBgTZ9bRpN8MBV4dnggJt/7KjWbDcXY0bICS+guJ8EcwWvag6VnLfa8/teo+8
	PLGXTdBQqHHI0rsA0inlXJUOf2ENs8XDl55VK3nLutlSpbtb5bK2xbPkrF+9D4XEE660zu
	ra7NSKpSLIc9l66Fbiair9O+JjZZpwbLUeshBu8ygGEfQv775c+QiWz4YypP3lR2iVXZc3
	QFf8qvIgawgfkRNhW0GduMJvKB4O+yBGKirGM+KkIRHRnHpwfpJpN49xzSZSa7J7U+G2Hs
	Nv8QyBJs+TnvifSFLGwlLsJl8aHnudUB2tevjQwQUO+JXKPZjpjQY5F+fGKADQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728846137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJX6KrnrJtu42HEdJXarSbGs/RtOSlZ6fSizcPT7CKM=;
	b=xrN0snCjtW4MtBzPmyAZh/jAT5pYhRHv0ec94fpMZAzQCGpK3OUtfA6zIGeEod9WT28ETK
	JjvnFr7ZWk+WxYCw==
To: David Laight <David.Laight@ACULAB.COM>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>,
 "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "juri.lelli@redhat.com"
 <juri.lelli@redhat.com>, "vincent.guittot@linaro.org"
 <vincent.guittot@linaro.org>, "dietmar.eggemann@arm.com"
 <dietmar.eggemann@arm.com>, "bsegall@google.com" <bsegall@google.com>,
 "mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
 <vschneid@redhat.com>, "efault@gmx.de" <efault@gmx.de>
Subject: RE: [PATCH 0/5] sched: Lazy preemption muck
In-Reply-To: <ea496d1ea02049e88a701f984b0f2a6b@AcuMS.aculab.com>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home> <87ed4pq953.ffs@tglx>
 <ea496d1ea02049e88a701f984b0f2a6b@AcuMS.aculab.com>
Date: Sun, 13 Oct 2024 21:02:17 +0200
Message-ID: <878qurhlmu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 10:23, David Laight wrote:
> ...
>> And once all the problems with LAZY are sorted then this cond_resched()
>> line just goes away and the loop looks like this:
>> 
>>     while ($cond) {
>>           spin_lock(L);
>>           do_stuff();
>>           spin_unlock(L);
>>     }
>
> The problem with that pattern is the cost of the atomics.
> Thay can easily be significant especially if there are
> a lot of iterations and do_stuff() is cheap;
>
> If $cond needs the lock, the code is really:
> 	spin_lock(L);
> 	while ($cond) {
> 		do_stuff();
> 		spin_unlock(L);
> 		spin_lock(L);
> 	}
> 	spin_unlock(L);
>
> which make it even more obvious that you need a cheap
> test to optimise away the unlock/lock pair.

You cannot optimize the unlock/lock pair away for a large number of
iterations because then you bring back the problem of extended
latencies.

It does not matter whether $cond is cheap and do_stuff() is cheap. If
you have enough iterations then even a cheap do_stuff() causes massive
latencies, unless you keep the horrible cond_resched() mess, which we
are trying to remove.

What you are proposing is a programming antipattern and the lock/unlock
around do_stuff() in the clean loop I outlined is mostly free when there
is no contention, unless you use a pointless micro benchmark which has
an empty (or almost empty) do_stuff() implementation. We are not
optimizing for completely irrelevant theoretical nonsense.

Thanks,

        tglx



