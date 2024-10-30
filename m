Return-Path: <linux-kernel+bounces-389542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66C9B6E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E121F2235E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92D1EF94E;
	Wed, 30 Oct 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RnhZis4T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YA3BnQAA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2019CC24
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321897; cv=none; b=oPtUlgzF+Hdh/9pFr8QH2VcEqwNSnoTx+jsEIgD91yY87gMj42PlUje3ShmbuDz8JDStxN4B1LPX0loY9EWgrrdD+bgoXfDdSQsiRzHXdPaz/F2wou6J/SGFoNtCtovu6wIBZal//LLZcqReWe18EQEX0RkhlR5LsbgHayDi4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321897; c=relaxed/simple;
	bh=7CvZ/D3Zc1AaWnnTJWO9eSgzEj9wrOvsYrbhe/uQtnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yk1p/j3J4Hhr5dxUGqogOxpgzEYNkYVcQzON6pA0B/3/3kLy3rdn1p7CMApCDjFeB2PVz2LsVguBJgsEwg0JefY3ICg0FlzYEi91J9swgATl6Bp6vkIRSZvZEHefEcjN0sMuVMo75gPEY0n02hbnwVy7UH6EVlQpqXsy1hMMmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RnhZis4T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YA3BnQAA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730321892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ou72sFLEXEOklBn6KdmUNlb/rO2M9p5I3/bFuUM6Q8=;
	b=RnhZis4Te5GgQfHS7mfs1EawRLYcnoyQ917KGEZD67wbpEFN1BPXdUumuupq/NBuB1Cepv
	Ifs7cfTx47U1xGYGT8ZN0W+9CjBZzgGi8ztQMH97NeLoyDTWOProMHnbSLPDFlDDgIRqqP
	tx620Ai8W1BImHT9Yx4BkGro6LpQ5+/OEDLR2FEW2wYrDTBHchJOAe+lI0MDx2R+Iq0Zrk
	M/KNTtInNC6uhMaYgUUNytJxbJ6bgdnnSQ+ho9iJfiwZ8/8/vfkKJsS/Jya6PrKxUZ9vzw
	jXpKWdvQ7Tzbe5AmtmdiphfeR2KuyfFL8cihkKhhVcC2gia7YRLaaHPm8Wul/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730321892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ou72sFLEXEOklBn6KdmUNlb/rO2M9p5I3/bFuUM6Q8=;
	b=YA3BnQAA1BkKK0MOrw3411eWjb8V1SWlH23giTk7GpT4DE7d/9SYnPtHHQatTjTehFT3C1
	9XNGaEDZd691grBg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch V5 21/26] posix-timers: Handle ignored list on delete
 and exit
In-Reply-To: <87ikt9xznu.ffs@tglx>
References: <20241001083138.922192481@linutronix.de>
 <20241001083836.514196709@linutronix.de>
 <ZyJng49tJutCM62d@localhost.localdomain> <87ikt9xznu.ffs@tglx>
Date: Wed, 30 Oct 2024 21:58:11 +0100
Message-ID: <87bjz1xq8s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 30 2024 at 18:34, Thomas Gleixner wrote:

> On Wed, Oct 30 2024 at 18:06, Frederic Weisbecker wrote:
>>> +
>>> +	/* Mop up timers which are on the ignored list */
>>> +	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
>>> +	while (!hlist_empty(&timers))
>>> +		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer, list));
>>
>> The ignored timers should have all been removed on timer_delete() and
>> itimer_delete(), right?
>>
>> So should it be instead:
>>
>>    WARN_ON_ONCE(!hlist_empty(&tsk->signal->ignored_posix_timers))
>
> Except for those which have not been removed by the application on
> exit() or in a case where the kernel kills the task. Then the exit
> cleanup has to mop up for them :)

Bah. I'm an idiot. Of course they are already mopped up...

