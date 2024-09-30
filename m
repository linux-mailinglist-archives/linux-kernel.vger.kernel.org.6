Return-Path: <linux-kernel+bounces-344663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7531C98AC79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F79283D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C5199236;
	Mon, 30 Sep 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EuIGvJ/0"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1B14A611
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722896; cv=none; b=ejRINLxq7ze7W5uUvWIrv0TEQvwLHVH3Y0eQJXIJxGi74QklGgP0q+kTyNdIDehnErBPeNNi1oJgYYMbL9AK+gDSJf9G1JsOWy95lwMm8xlsVLZlpk/h30W9nrNebHrAxGWnrZa5GYTFyltAVxtW5vhWYXgt2eodfA9uowEW3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722896; c=relaxed/simple;
	bh=CHCL+KzJhNC++K4yhkE6Ed183eMo9tT+xQyz/a7VknE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YxKxr9yybIGWPe97cZrUgGcBFXDg1DAem+1FIwXudRe8SWxkt6K4HlkBrVLvFYlRUT2IJowaPUkqlm/SaOx8hyr8DVuFH1hUNVsBgNmr4k2nioihzPC3ZQyN/SIFt+vzMKchnhfDj9n1I5D7+T7NqcmT+pPGuuDQ8St5mvyLfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EuIGvJ/0; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727722887;
	bh=CHCL+KzJhNC++K4yhkE6Ed183eMo9tT+xQyz/a7VknE=;
	h=From:To:Cc:Subject:Date:From;
	b=EuIGvJ/0vvV7vb9WrrcGqpckmsE6DcKYuqb2vRlavRek/Z/uoRk9g1mH6uUsRbyvG
	 w2xlkKJ3CWHnXXnwtqnRLoVVuewCQfoXGkaw7Dmkin2CWZ7II5JNrGxRxlGNTKD+hy
	 C0r0r5MSiALbGDRFna7Y8ymveKN2yScXH5wqGk8Qg7EceMtxXJWlthlGQzlPqTSKAn
	 l64j91L3kFmj+PsPaw4zxZisRNnclTfDDnmza0W2ROqaN+CMUwwHOeJmd1F9Rsn/LS
	 7EaxJGQvacE5FxUH0UnUksECrLztl7KhNMWGJhWjm1cYJFHlS7rVmIMs2jSQ36vgN0
	 H7k0mCGd5f1RQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XHVm70L5ZzPwB;
	Mon, 30 Sep 2024 15:01:27 -0400 (EDT)
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
Subject: [PATCH v2 0/1] sched: Improve cache locality of RSEQ concurrency IDs
Date: Mon, 30 Sep 2024 14:59:19 -0400
Message-Id: <20240930185920.1149002-1-mathieu.desnoyers@efficios.com>
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

It is based on tag v6.11.1.

This deprecates the prior "sched: NUMA-aware per-memory-map concurrency
IDs" patch series with a simpler and more general approach.

Peter, can you pick it up through the tip tree ?

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
 include/linux/mm_types.h | 72 +++++++++++++++++++++++++++++++++++-----
 kernel/fork.c            |  2 +-
 kernel/sched/core.c      | 22 +++++++-----
 kernel/sched/sched.h     | 47 ++++++++++++++++++--------
 5 files changed, 111 insertions(+), 34 deletions(-)

-- 
2.39.2

