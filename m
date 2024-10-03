Return-Path: <linux-kernel+bounces-349416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D77C98F59A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B66283411
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9901AAE38;
	Thu,  3 Oct 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EbW/ZnXp"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434DD38DD1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978045; cv=none; b=EjALkL+ESZAEB4CbrVC7zctGgxNkwqdNSXRq5S9f/pAP6/9BB6WJB9Ylsn8swBifxFZiGNsTkN5rx9IAh49UPr8WGBwAqLY9toAm9MsQhHTlhdqeGXfqlwyFG1hCi9TSAbbK0ZcIoqpMby4ZIuw7YEi6/X3GlSxXKhVJ/WlQDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978045; c=relaxed/simple;
	bh=YgpO6R19J3iY1iXIhWHqZBQnZmAYEP9On3A9b8aBruM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmPxSo4NN9O74xyITSX51Ao7C8iJD4/zJCFGRQ21goIHkHnMxSB3BFav6O36xsSAbdXaegQ1mQKBdFsqoinhNUF+Tvj3uUKkRWZoorHiggGiaH+mPDvOJdiboBAYwtj8RbzHK8eRZ2qyINVUfnIoW60W1wHEgulzoe3xZlRimNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EbW/ZnXp; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727978042;
	bh=YgpO6R19J3iY1iXIhWHqZBQnZmAYEP9On3A9b8aBruM=;
	h=From:To:Cc:Subject:Date:From;
	b=EbW/ZnXpQhIM99xvqPYnlSiPjeFA/CaV58I+sUcAwiE2Y0z5lVjscf+MF+a8bCv+h
	 3+L4rzwS8BBrUFCzpLKOpty+MFvUMjtZabcOL0VKOp7J+YuwpdU3srzOieZEKIaXMh
	 gRdqYaN764fTepnPJonFI5V1fn9Z0B2nHJ/YRUl5CpVXBzEJmriezyIrMjB7L8o7Wi
	 XfQSxZ13KNpkXJQ3f50yrhrFG154nOc7DmYzm5hjnLmbXwsxtbuxxcGULTjr0vPcaf
	 tk8sPXjr9ovHl4oiEGocLxF+kdFAkcDkzvtRzuMMCMHT9t8NYpD0cc6XuniLAqjFH7
	 ZTkJFQ2FDp1xA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XKK6x5DdYz7Zh;
	Thu,  3 Oct 2024 13:54:01 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/2] RSEQ updates for 6.12
Date: Thu,  3 Oct 2024 13:51:55 -0400
Message-Id: <20241003175157.1634301-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Peter,

This series contains my rseq updates for 6.12.

It is based on tag v6.12-rc1.

Can you pick it up through the tip tree ?

Thanks,

Mathieu

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Mathieu Desnoyers (2):
  sched: Improve cache locality of RSEQ concurrency IDs for intermittent
    workloads
  selftests/rseq: Adapt to glibc __rseq_size feature detection

 fs/exec.c                           |   2 +-
 include/linux/mm_types.h            |  72 +++++++++++++++---
 kernel/fork.c                       |   2 +-
 kernel/sched/core.c                 |  22 +++---
 kernel/sched/sched.h                |  47 ++++++++----
 tools/testing/selftests/rseq/rseq.c | 109 +++++++++++++++++++---------
 tools/testing/selftests/rseq/rseq.h |  10 +--
 7 files changed, 187 insertions(+), 77 deletions(-)

-- 
2.39.2

