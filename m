Return-Path: <linux-kernel+bounces-299510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FE895D5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F6D1F23258
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B4191F8F;
	Fri, 23 Aug 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DXTDm14o"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455A913A41A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724439648; cv=none; b=TzkHM2OvkmgIU7P1LZPipVvvsb4OY+MWtyE3nmn3IVvgmxg1ZjTwhfrHbqNaehaO40qn9iAXTy0swDDtv1bJr6ib2gUkYTrqBR7/hNsgCywyc9HFgbmHYmnT6pxMunFafyBzgAuFgngRj9QtnCzdv+7sNSWwrWXnoiakwNz8G1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724439648; c=relaxed/simple;
	bh=W+5VmIikTKi6G06raMu37WIu8vfdB5bKtHFw5m06HzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nFz8JPeruUFXilja2arYXwBu0rpwQjxFS0y3TyUaQj5vAkHcQLmDJ3nbv0YYV5I92lQ8YSx6d+ck9nJi1FckC55PpGU072U3YVpAw+b2GXnlbh5wAA51VD0oUGibqoOiEC4UDcC7+CS/GZ6npU79xSnvYEXXMMe+5uDNP+TvF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DXTDm14o; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724439621;
	bh=W+5VmIikTKi6G06raMu37WIu8vfdB5bKtHFw5m06HzU=;
	h=From:To:Cc:Subject:Date:From;
	b=DXTDm14o08zOw6811vX2MtW8gLefO4lC/MShbkDXvdLTzE17lDh4aCFwoqrr6qfJU
	 W+fLA4Y55zF/jk+N8TJkNdgQnid7V7KX5IjnKY05M/d3/By3Gy1+BqDItC0r+pYGMk
	 5/dPuczzhC9RBKnX2EpfIzSrw3KjuyQwMJBryLsjUenlyt6y+pCpIgRIgBWar4uNpb
	 TAQ/wmnkeHsFZ7c8rzj8NDMDvpW2nNyWA3RfjeGbUh625PSgIHxtQgghObcDXq/J2b
	 eC9RxM3qfBVXI+9PTFmvikGwjvC7X7r1l2d3nc/aP5hyXMPgvZUTGyDX3GVv1W0QGZ
	 xj/O/MydetB7Q==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:b243:804e:3bbd:91c9])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wr8XP4Sytz1Hbk;
	Fri, 23 Aug 2024 15:00:21 -0400 (EDT)
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
Subject: [RFC PATCH v1 0/6] sched: NUMA-aware concurrency IDs
Date: Fri, 23 Aug 2024 14:59:40 -0400
Message-Id: <20240823185946.418340-1-mathieu.desnoyers@efficios.com>
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

This series applies on top of v6.10.6.

Changes since v0: applied the changes requested by Yury Norov, and added
Reviewed-by tag from Shuah Khan for selftests changes. Rebased on
v6.10.6.

Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Shuah Khan <skhan@linuxfoundation.org>

Mathieu Desnoyers (6):
  lib: Clarify comment on top of find_next_andnot_bit
  lib: Implement find_{first,next,nth}_nor_bit, find_first_andnot_bit
  cpumask: Implement cpumask_{first,next}_{nor,andnot}
  sched: NUMA-aware per-memory-map concurrency IDs
  selftests/rseq: x86: Implement rseq_load_u32_u32
  selftests/rseq: Implement NUMA node id vs mm_cid invariant test

 include/linux/cpumask.h                       |  60 ++++++++
 include/linux/find.h                          | 119 ++++++++++++++-
 include/linux/mm_types.h                      |  57 ++++++-
 kernel/sched/core.c                           |  10 +-
 kernel/sched/sched.h                          | 139 +++++++++++++++--
 lib/find_bit.c                                |  36 +++++
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../testing/selftests/rseq/basic_numa_test.c  | 144 ++++++++++++++++++
 tools/testing/selftests/rseq/rseq-x86-bits.h  |  43 ++++++
 tools/testing/selftests/rseq/rseq.h           |  14 ++
 11 files changed, 604 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c

-- 
2.39.2

