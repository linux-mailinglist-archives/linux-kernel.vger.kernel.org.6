Return-Path: <linux-kernel+bounces-384680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777909B2D27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E48E1F229E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD51D54D1;
	Mon, 28 Oct 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nkv1DdEp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHdXiOkR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC8D1D54C1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112224; cv=none; b=dy1pe70DvN0AOqW5XOrjSnQktCf7z5Ov9U5S5BBe1MTghyYom1rBP9kkcg8x0qn30Or4FkNG9+mV/p1z8w7dVfJFzfSiCEoEmUVh+f3onE0hz/VfhoI8uuaWZvwZcignk4KhaMIVl0mneJIrBCjnE4XKddlzEHEhfD2KcFjdl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112224; c=relaxed/simple;
	bh=TVVoa6zValIpm2R83qLfqDTHFUKv0QrZFO8km4fmR/E=;
	h=Message-ID:From:To:Cc:Subject:Date; b=UWcRyRyD67m80Nl4klkzdP8n0Ny2sMzNLcg/oQkULjxWWyeOVgn7n1ixKm7wxuwGhvgQB7UOmfG7QO7D+hXenj9rMqBcDxTCRMCmQOzNzgGkfftcse8l5cdXNkJy/nJ57L+xq73d45apiMazx0cXysIiD4WVIMdpifIQ1FwqyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nkv1DdEp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHdXiOkR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241028103006.008053168@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730112221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=6sj0JEZY3BM0xvsQ1KegsWwPKQ86j0SrdNkdVLgM0/E=;
	b=Nkv1DdEpp5p3vdHjQliX4o7c28GWmrAqHNayZZo5yhH25uheLFB2Ltr2iaK5Ta49W4IR4c
	8xuyrUZkfsVMCKMBex0HLaYSGVMucbeA3qVIWU2YF+3E5hUm1XyTck4/P1lJixJ2YufN7b
	w88oHOrFvo1wUqlPvcUfLsPSkpNY8QdUNvOxuGApCJBPpyycYLArT3+mJA15ix8XbU1ZLP
	NUS3qgUtaSCJZZQcXmqTDbfL/09ETGczvM6YJnHmUmiTYFHcOvE+1i5MTEE6I8BYEnIzBx
	Vf8mSbqNCCh3TGLVnmiTOpPDnl6P71rtNVzTlrgkaM6joyTmQ6HZ4xXk2rpIEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730112221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=6sj0JEZY3BM0xvsQ1KegsWwPKQ86j0SrdNkdVLgM0/E=;
	b=GHdXiOkRo7+DeyO7KHAxW1mWiRk/Ge24oadELmdFkj2iq9BHre3NW0bIYDqbqvq9sb28OC
	S4WTQLmDq7EfRTBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>,
 Ingo Molnar <mingo@kernel.org.com>
Subject: [patch 0/2] sched: Cleanup idle task double initialization
Date: Mon, 28 Oct 2024 11:43:40 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Idle tasks are initialized via __sched_fork() twice, which can be trivially
avoided as pointed out here:

    https://lore.kernel.org/all/8734p4ymqj.ffs@tglx

As this got ignored, the tasteless hack in init_scx_entity() to work around
it stayed and found it's way into mainline.

Mop it up after the fact to not further proliferate technical debt.

Thanks,

	tglx
---
 core.c |   13 ++++---------
 ext.c  |    7 +------
 2 files changed, 5 insertions(+), 15 deletions(-)



