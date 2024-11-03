Return-Path: <linux-kernel+bounces-393760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A279BA4E6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 10:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC5C1F21705
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A189156875;
	Sun,  3 Nov 2024 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJRR5anK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkS1VDy/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE575142633
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730627080; cv=none; b=t1Wg4VCrg+dg35+FhAVobLzlVz9q7oYGlIH092ZLLdDu1GAnqW1WIqAmBBHX9qGqjSP2//DLfsIY8q/38jgqGsVaH/wB/91APQFy9nXqJOhB8Jw4YQqHt2yizkX8420TexuwX9spxhbZMqeC+S3tQ06ISWX/UuY2yvFz2sYA2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730627080; c=relaxed/simple;
	bh=MabOXA8PLhaY023Z3OE+GxWpGEvsRKmSFkM4QI/Kv0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWJe/2+NeVMF/iLhpIw45IFB8vUydi5SytuSV06cm6B2sx1kGJABzLxEbvpwVVo8rIy7Kl8csFg4oRVqDZylmMNO3w/ppd5k5cjWTG22/d3XbdsAuANFcASlTWyPtxgCHsOJEez52pahscBxqJ9tbEZC+6w9py5bsQW86TfIeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJRR5anK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkS1VDy/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730627076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0zYE2C8QMUz0YmfC3+o9SzRRMfjRdeq1QN8YlcCobU=;
	b=WJRR5anK1mMSqjX1jS15PWQqWUwYJ0ZKR4DooGEScl85tGOG/Dh4yEb3INs22pvVPhYfNi
	AMcYdvQQiVyTk93lHjgRsAVLp/dJAdQJJm98CldiFGL10enqrjwNpvHfuAkjZnWG5r1Jwp
	2xJKHGVVbIuUBAdqW3oE60SxpGr8o3CSQ9xCbzAevERB9GkWKNsyMvTo3mxIcDnyynVkhB
	KJJPRRiVW2Mo+lyD21uGNbcyCEpkG19OjepRQfiPrcpwOC1ReJ7o6lm8UhYbQnEkaD8gz/
	lYqrn6+hjpbi2Iat1x3VYFh17DPjUdawuOr3PQSQT4mhnTZjOf2BnCBqQ3wX1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730627076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J0zYE2C8QMUz0YmfC3+o9SzRRMfjRdeq1QN8YlcCobU=;
	b=OkS1VDy/HDQAewF6RIjtlcwnxnaQQ9VB7/a92dItTI1tffQS1iVE5QopeViNZkG+BkaYxj
	5wkEU3ag334oBjDQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen
 Boyd <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Oleg
 Nesterov <oleg@redhat.com>
Subject: Re: [patch v6 17/20] signal: Queue ignored posixtimers on ignore list
In-Reply-To: <Zya5wy9UyVo2cRvq@pavilion.home>
References: <20241031151625.361697424@linutronix.de>
 <20241031154425.624061922@linutronix.de>
 <ZyTj2W8Jndv0nzga@localhost.localdomain> <871pzuvfzg.ffs@tglx>
 <Zya5wy9UyVo2cRvq@pavilion.home>
Date: Sun, 03 Nov 2024 10:44:35 +0100
Message-ID: <871pzsr6rg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 03 2024 at 00:46, Frederic Weisbecker wrote:
> And what about the other callers of flush_sigqueue_mask()? Such as SIGCONT
> removed when SIGSTOP arrives? And the reverse as well? This moves the pending
> timers signals to the ignore list until the signal is unignored, but in that
> case SIGCONT is not ignored? Or perhaps SIGCONT and SIGSTOP can't be set for
> posix timers?

You can set SIGSTOP/CONT on a posix timer. Whether that makes sense or
not is a different question :)

Even on current mainline the behaviour is pretty much unspecified. Some
combinations "work", some not. I just tried out of morbid curiousity. :)

Thanks,

        tglx



