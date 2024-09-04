Return-Path: <linux-kernel+bounces-314030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F92E96ADEC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3026B20F11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FFF8479;
	Wed,  4 Sep 2024 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="F9lb2uk+"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A34A28
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413517; cv=none; b=KCNZSPV5iY5E9xC0wNRB84HTCIiMLscmAf1eWdCP+Y3MTaQW6xw5f3I9m8Ssdi98gJ8cHGohYOygAT5DyvfqM4krp5assp035kCxkSC/0XsBBFLE9nTuipkFffUYpt8M5Csz7HC4T6/fx2bHCFOl1QPo3Uy2vNfw4IIo3j3wXP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413517; c=relaxed/simple;
	bh=YJ/h5HbcMr+Pkc7bmLtAaxUSUqxzlMAvVZ2CKrCo1iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RMg/d4ja5Gdxc/yODlFeVMtyAVazacozji/42qfxQvptTw+aPhx/k3CNzrgpwfGDt+YPj5gSIwuM3Aiz1kYfJ2yGb7wdDZwEEkfaXDHMO9b/w4/DUHJdlDJrm8qMY8JwLkgv+hI0NrQoMYYgSPuV2oGTSDolFZ9tlEouHH0Y0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=F9lb2uk+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725413514;
	bh=YJ/h5HbcMr+Pkc7bmLtAaxUSUqxzlMAvVZ2CKrCo1iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=F9lb2uk+Oi3cb7VV8uZ6FwgvS9At5jtsGBUtkR2XpJWR+0tB7q2BHCqjGZxsCf5BF
	 QLBUwAIhDUtDSu7vrjXE8ApZSFPLuGuwIOIfU//PXbOeXDzp+Mod+Po32EV9DR4L6l
	 YXar7yIgb/JpaYBbaKq+zjJd+cDevsxEelKnZJg9gZLpy6UP0QgTWFwkvtfpqdkfiZ
	 B7FSV0ZjfG/d3R8/XB0Zljy09Tk29OP0agXAID9O3LAwQ4bpirH1MOQDhEiiODoe8i
	 YuOq/g1dodzcHYCmr9KQLPYn+OM/01M/XixauzkXiu+e3/YLOoEalvPMvRijVMsdkd
	 PxFOgEKTuiFHw==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wz4j61Sbqz1K8J;
	Tue,  3 Sep 2024 21:31:54 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH v1 0/1] sched: Improve cache locality of RSEQ concurrency IDs
Date: Tue,  3 Sep 2024 21:31:26 -0400
Message-Id: <20240904013127.75064-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intermittent workloads behaving in bursts spaced by more than 100ms
on each CPU exhibit bad cache locality and degraded performance compared
to purely per-cpu data indexing, because concurrency IDs are allocated
over various CPUs and cores, therefore losing cache locality of the
associated data.

This series addresses this shortcoming. I observed speedups up to 16.7x
compared to plain mm_cid indexing in benchmarks.

It applies on top of v6.10.6.

This deprecates the prior "sched: NUMA-aware per-memory-map concurrency
IDs" patch series with a simpler and more general approach.

Feedback is welcome!

Thanks,

Mathieu

Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Mathieu Desnoyers (1):
  sched: Improve cache locality of RSEQ concurrency IDs for intermittent
    workloads

 fs/exec.c                |  2 +-
 include/linux/mm_types.h | 75 +++++++++++++++++++++++++++++++++++-----
 kernel/fork.c            |  2 +-
 kernel/sched/core.c      |  7 ++--
 kernel/sched/sched.h     | 47 +++++++++++++++++--------
 5 files changed, 106 insertions(+), 27 deletions(-)

-- 
2.39.2

