Return-Path: <linux-kernel+bounces-384995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B399B312D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EE01C20D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F81DC734;
	Mon, 28 Oct 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPgJyp59";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRQCp11g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AAC1DC06D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120344; cv=none; b=mpJuS1uoslSEg5xZPkjyEw9mP0/LZlzmnNgdZScbAh/Og71NQrfmkAOlfEwSGiOCJUqrgQlSri+oPDu84Q1WdwInD5L9NYzEQ0pV+3TX/uuD3iMgEezBf58mmgn9oWhJ+AyRR1Ohuulls4uTycNXF5Z5224bW1vakd8FRSw3GAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120344; c=relaxed/simple;
	bh=GBwzUa80hKFdlYc9gRAuSwET+9i6RcIOKAJSCnhxQ6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BnksR2KoDVnjJzRfsoUJ7xPnGuPWwr2MIWHEjtVREz/iuAaiipszrWkBszxTYlkzMSJTZ7ugsaqGTBmqE6JEZNb/2aFiOXG+/tWL5a86t0y8MWV/7pqyZ6RbhX22joiqnS8ItZNZnG8VUY6LFTSypiznYu77jr5kpyPgB5IqPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rPgJyp59; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRQCp11g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730120340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64T6fFDD8Zzyl79UA472G3KLLbXRapBRFe/GCMvgq0c=;
	b=rPgJyp59zl8BKPXPoz1vLhm6crhHRteERSiKw27+6bkvqBm2gfRHe0YnvelLiVUr/Bpwid
	BX6CIgh7BWCdnZH7df4HD4gPViyHxcYrvrioC8jyDVJ9i0eJBVAs49SCwOhpKUL1nnaxtO
	tULgzrqKFGFAWq5wJH3ZjZqjxcmjw4TsYb473fhczZfejV285h6TCiWa77XDLr/6mzvohZ
	fOfvifdqfrp38oJ0Ou+jbJ0Zu84naZr5wmrKaYOTXSqH+u4g/uAkmpZxB8LrKG6e8mAsOb
	2zLfmzHQdhWWwrX6qLWD4vYY6NOJ/S9NYkdwcpu5HsEnIQkBAwTU0y0eCTMcrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730120340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=64T6fFDD8Zzyl79UA472G3KLLbXRapBRFe/GCMvgq0c=;
	b=wRQCp11geHD5MURGDShfeV0BRxMhXCDnoo1ISCfNeXgUsOAvdHr5Tvx++M9wUSHucLb/4R
	Sq2CS/dRLDyaISAQ==
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, David Vernet
 <void@manifault.com>, Ingo Molnar <mingo@kernel.org.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [patch 2/2] sched/ext: Remove sched_fork() hack
In-Reply-To: <87zfmojtpk.fsf@prevas.dk>
References: <20241028103006.008053168@linutronix.de>
 <20241028103142.423153706@linutronix.de> <87zfmojtpk.fsf@prevas.dk>
Date: Mon, 28 Oct 2024 13:58:59 +0100
Message-ID: <87o7342xkc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 13:30, Rasmus Villemoes wrote:
>> +	memset(scx, 0, sizeof(*scx));
>>  	INIT_LIST_HEAD(&scx->dsq_list.node);
>>  	RB_CLEAR_NODE(&scx->dsq_priq);
>>  	scx->sticky_cpu = -1;
>
> Should the "must be the last" comment in include/linux/sched/ext.h also
> be removed?

Oh. Indeed. I missed that one.

Thanks for pointing it out.

       tglx

