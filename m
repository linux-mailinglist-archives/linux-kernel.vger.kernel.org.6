Return-Path: <linux-kernel+bounces-527250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED36AA408D8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC9917B06E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636D70830;
	Sat, 22 Feb 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWTMZJEu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB42F37
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232866; cv=none; b=mcIVdeqzpxVuo/vxJbX8XlErwQYPz4jFDNQeT14DmNaURBWPOMZrBMmctIPpWbDFgdg+AcWlM9KMvouDNIX3BQ/iE3LiB2H9+WQMDX32WZLA3ZA4VKQ27e3Xn2IP/LoTD2O+9oGqoQc5/mH1+0s9Z/hs3gQ4qhzJujzM8HqRID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232866; c=relaxed/simple;
	bh=4g+UB8t/vNZutuv2bsrwapQvJRkxtxT+9ohAE+fjAKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IXQzZ4RqxguWMPIzqI8/PA7mLGejTVwRoq1q3p69y0AuskboGWlrc2F9Zu05+Z/tSm7KG4oC31PAzF8BQzI/0Svd7WN0mcKenkjVGWOkZPPDP0+G80qjZAcpaPf4zBL9kR0Yb++86SPVasriaL6nELo6wfe2s71xu9s+ctATugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWTMZJEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0150BC4CED1;
	Sat, 22 Feb 2025 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740232866;
	bh=4g+UB8t/vNZutuv2bsrwapQvJRkxtxT+9ohAE+fjAKA=;
	h=Date:From:To:Cc:Subject:From;
	b=VWTMZJEuldKMuHoTm19uMXMCALEksh/TuctEMqKNLAlpvb8vJKKpiq9EGFrCR7TBa
	 kJTVIC7pVEg4i8Y/dcVVKnPYo5QueYwlALZfVp9a06F+ItJBcNBM/st+n4n+8zofpt
	 oaoldTbAtGC0KvSgMorqZpH6irKvRuEvYJC1ZInKfAoqaaPHGWGeRBt2rzrYkfNOM5
	 XjaolV3en8kifQLmld27z4bh9amq46c5M2l34eTuz4PV26d6/zscLjYiz5MAJODiQs
	 Hv6xSr9bKfufW6ndLy04jIGU39tnBSJyCJ2+EIt20budoznn2++p1lgEck6IaYd2A7
	 I1YYz3cgA79yQ==
Date: Sat, 22 Feb 2025 15:00:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] scheduler fixes
Message-ID: <Z7nYl38LL0fvgPql@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest sched/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-02-22

   # HEAD: dc0a241ceaf3b7df6f1a7658b020c92682b75bfc rseq: Fix rseq registration with CONFIG_DEBUG_RSEQ

Two RSEQ fixes:

 - Fix overly spread-out RSEQ concurrency ID allocation pattern that
   regressed certain workloads.

 - Fix RSEQ registration syscall behavior on -EFAULT errors when
   CONFIG_DEBUG_RSEQ=y. (This debug option is disabled on most
   distributions.)

 Thanks,

	Ingo

------------------>
Mathieu Desnoyers (1):
      sched: Compact RSEQ concurrency IDs with reduced threads and affinity

Michael Jeanson (1):
      rseq: Fix rseq registration with CONFIG_DEBUG_RSEQ


 include/linux/mm_types.h |  7 ++++---
 kernel/rseq.c            | 11 ++++++++---
 kernel/sched/sched.h     | 25 ++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 9 deletions(-)

