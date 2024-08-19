Return-Path: <linux-kernel+bounces-292275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214DC956D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543231C2381B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AEF175D20;
	Mon, 19 Aug 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Evejkv+7"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E716BE23
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077933; cv=none; b=jJ3B8PYOkinwghnngIvFXa4FCPP244FVqUAwoOJdPws+TWx7ORUCKSGFUa9xAIIz6pvEupGfBo745XPCgHW4mgWDMQGvjzKoT/zBlbzB6WG/dHTv6E4gStB+KFNf2VU9LCNBCgkwDzTd9oU/M4GBorQvUDgcdN122/1j8bwEmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077933; c=relaxed/simple;
	bh=TiVdyzNEkM6+tVczXMOiTjp/nV4qc8PqqbF0CNqyKIs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k4EaTvxByzig1f79P2nBGjzWSv1SQtyUdgEXnqm+T6mcLRuQtpo1Fh81oy+IzqFwWQ7tUW6coGsXaxnRhoMJ3+mlTmy+JIpT1MwT8IMQp+JcWM8XfnZgS3bwSEZp4BnjZ/WEkyIDig6dFGV1tBeLqhR/ummU378R1Dj+xWaHgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Evejkv+7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724077471;
	bh=TiVdyzNEkM6+tVczXMOiTjp/nV4qc8PqqbF0CNqyKIs=;
	h=From:To:Cc:Subject:Date:From;
	b=Evejkv+7ownZyLEGLIgaHTy+O65EDh15rlynU2H84+LbCkuVyIHndadvx+2hHS3ns
	 fy0ymYYmdioJ9YqWoTW5OEVLrj7n50GVswbYd+cVhiAGn3kJq0b/nKhJTEauG0r9XN
	 Jh24mSaTiJT/Ycj6CwTZpT3IlaZy7nyb0SWPU3IkpVpxu9pqR/aIhB9ZhZYOmV+OLg
	 /BqGinBvfrSyu7pmCCFWr0LGiFLRiYqGZNPUe3cYMYC8DrGXAQtXKgvK51ltqGNG02
	 h6kZses/bCQs10uqDys3JvWVOZI5xMknEEZzkhqUGRsHEbbG39AM/J0X1KaTFHbHkJ
	 lMG7i0MsmsFWQ==
Received: from thinkos.internal.efficios.com (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WnZbx0JfZz1Hrw;
	Mon, 19 Aug 2024 10:24:28 -0400 (EDT)
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
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [RFC PATCH 0/5] sched: NUMA-aware concurrency IDs
Date: Mon, 19 Aug 2024 16:24:01 +0200
Message-Id: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue addressed by this series is the non-locality of NUMA accesses
to data structures indexed by concurrency IDs: for example, in a
scenario where a process has two threads, and they periodically run one
after the other on different NUMA nodes, each will be assigned mm_cid=0.
As a consequence, they will end up accessing the same pages, and thus at
least one of the threads will need to perform remote NUMA accesses,
which is inefficient.

Solve this by making the rseq concurrency ID (mm_cid) NUMA-aware. On
NUMA systems, when a NUMA-aware concurrency ID is observed by user-space
to be associated with a NUMA node, guarantee that it never changes NUMA
node unless either a kernel-level NUMA configuration change happens, or
scheduler migrations end up migrating tasks across NUMA nodes.

There is a tradeoff between NUMA locality and compactness of the
concurrency ID allocation. Favor compactness over NUMA locality when
the scheduler migrates tasks across NUMA nodes, as this does not cause
the frequent remote NUMA accesses behavior. This is done by limiting the
concurrency ID range to minimum between the number of threads belonging
to the process and the number of allowed CPUs.

This series applies on top of v6.10.3.

Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Shuah Khan <skhan@linuxfoundation.org>

Mathieu Desnoyers (5):
  lib: Implement find_{first,next,nth}_notandnot_bit,
    find_first_andnot_bit
  cpumask: Implement cpumask_{first,next}_{not,}andnot
  sched: NUMA-aware per-memory-map concurrency IDs
  selftests/rseq: x86: Implement rseq_load_u32_u32
  selftests/rseq: Implement NUMA node id vs mm_cid invariant test

 include/linux/cpumask.h                       |  60 ++++++++
 include/linux/find.h                          | 122 ++++++++++++++-
 include/linux/mm_types.h                      |  57 ++++++-
 kernel/sched/core.c                           |  10 +-
 kernel/sched/sched.h                          | 139 +++++++++++++++--
 lib/find_bit.c                                |  42 +++++
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../testing/selftests/rseq/basic_numa_test.c  | 144 ++++++++++++++++++
 tools/testing/selftests/rseq/rseq-x86-bits.h  |  43 ++++++
 tools/testing/selftests/rseq/rseq.h           |  14 ++
 11 files changed, 613 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c

-- 
2.39.2

