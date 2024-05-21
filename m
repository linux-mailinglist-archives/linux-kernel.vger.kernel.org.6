Return-Path: <linux-kernel+bounces-185132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0218D8CB0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ECE286758
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064067CF1D;
	Tue, 21 May 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gsog1FBG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K7VQIgFg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD27EF14
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303774; cv=none; b=EHjNAzyj7MCiykAOE0h3YkIrmNwbcJJEbhudl7AyzPGMmKu68pwTIcGsRLEclhxSahd52cZ84t3eLCXkZryCixAOMjoTeb0EUc+uL2sqdPOz0PGO3wi22xt7XI7gKxA8dNWoT43oqj4vA4+uQIYJuEGe4reChV9WtuLPN+52q3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303774; c=relaxed/simple;
	bh=p6SGd9WOw6MT1QXW4IFJph2T6KEZsv6XTgCZYoQ/+mU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=Qajtlh2z/kZ6mftnheIw38DgXmtj/i1Taj91X0CbdxJ6J2fg2FTMreq+aGLUres7r2p9fkqLs4QLK98N4Qge331TEMPJDoWaAftsUnIkrHrTYHwIvTB4FzTbAo0ITGFlQtjL6CkydyDHc/p/lnWoWHK3y2La3HxYzMWkt7EgsWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gsog1FBG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K7VQIgFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716303770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=tJn/S2av5LBb9gVksjvGB1QeFYo8gSkRuluBjoUu/rI=;
	b=Gsog1FBG1OayfK77M6qOsfp3xiAlSluQMv8GDzw83aQEU3fpfdeK6WgeSxbKEABcbKAaCi
	UtSwtz2lUZTbE0xQURXBeE+ARO9TtYeTlxbGd4c5rydkDJuWrNkvPz+WvcVluaAw03otnQ
	XuDTC/U1aH/FmF4IKhNT8amKf9SXH1XQlYjjW0y9eXRg69aiMtNje+68jTOO0dkvtp4FTD
	V5ORFTYedOjNyo9Md06Dn2mKvfJGuQ+ROWyS51o8F8nxf2YpFR4vWp7MvXM51TY7S04LKj
	xlWrBK3kCLpdmwcTgzk7DUX97fArtBf4gZJBipyqxUMIKhLK2PrekbySq3EepA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716303770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=tJn/S2av5LBb9gVksjvGB1QeFYo8gSkRuluBjoUu/rI=;
	b=K7VQIgFgMK9CDc/bFng6od8GjVnB35+Bfa2cgcq1/jJ1k/7AGnD/erK6+/Dv9MxmFp/b+w
	8DWALKYF/tae5sDA==
To: zhuqiuer1@huawei.com, anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org
Cc: zhuqiuer1@huawei.com
Subject: Re: Question: One-jiffy latency from the checking in
 run_local_timers()
In-Reply-To: <20240520132040.259477-1-zhuqiuer1@huawei.com>
Date: Tue, 21 May 2024 17:02:50 +0200
Message-ID: <871q5vi4x1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 20 2024 at 21:20, zhuqiuer1@huawei.com wrote:
> Hi there, the function "kernel/time/timer.c:run_local_timers" avoids
> raising a softirq when there are no timers set to expire at the
> current time.  It achieves this by comparing the current "jiffies"
> with "base->next_expiry".  However, when working with SMP, it is
> possible that a few CPUs are reading the jiffies while it is being
> incremented.  These CPUs may read the old-jiffies value in
> "run_local_timers" and fail to invoke expired timers at this jiffy.
> This results in a one-jiffy latency for the timers.

Sure, but one tick latency is not the end of the world. What is the real
world problem caused by that?

> Can we simply add 1 to the "jiffies" value when we compare it with
> next_expiry?  This may result in an unnecessary softirq being raised
> if a timer expires in the next jiffy, but can remove the one-jiffy
> latency.  Not sure if this is a positive trade-off.

What guarantees that the jiffies increment has happened when the soft
interrupt is invoked at the end of the tick interrupt?

Nothing, especially not in virtualized environments.

So I rather keep it simple unless there is a real world problem to be
solved.

Thanks,

        tglx

