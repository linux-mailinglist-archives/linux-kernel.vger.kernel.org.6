Return-Path: <linux-kernel+bounces-447367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96DE9F3142
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9FA1882A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269BF204C3A;
	Mon, 16 Dec 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+4iDg/x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E21119A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354566; cv=none; b=nOhJd8+rP720WFCrRWjkFsBzmolYR96cTwU677xRpe3ttaHaXSARM6veE8o4vFow1iWSR6+EJZu2dJUzrvSM8MTcms/ag9IzvAhKgQ7DQ07txILwGCErPRkCn8Eo4+Oeh5aoE79l1B9DPocnSaHqrWAHq8nkXEyZRiQjSAsfKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354566; c=relaxed/simple;
	bh=uxQ+ATw8Por9tupTulZ4Ei5eAIejcFPrLzmQIHFwAbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3bd8NcLOGbaU3SkkyjR5D9mIugVEIXdIRifzBITiKb17cWQEFBxcS1QG0YeJ7g4rSAWplRgiNE4FwvZEAlak04vvWty6pkY3r3nA/udePqtUcoOHvgF6EaR9NyLfPt1ik6yEkqHZNFVyzA4BfziXDwSh4KgSqxwnvJz7mjo9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+4iDg/x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734354563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=04gog9cLVPUqDpqBar7B+KaIa+GDp8QFjdCi5KnxDh4=;
	b=C+4iDg/xaqAsof+nwlxKEVS9kdtWRCi3RCi644zXNjmhMpZk39nvpL6higs3jTct1karHB
	bkakakkUFqVHNHcFUIm4DpT72JC2DLA/7QA1u9R1VGrgTZr3dNNq1yB+L9z+w65CuP5WxI
	zIeIUIE4BEYwQvscDpGO1Gbfyynkyms=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-M0bPoxt_NiKr1KnJnrKXFA-1; Mon,
 16 Dec 2024 08:09:18 -0500
X-MC-Unique: M0bPoxt_NiKr1KnJnrKXFA-1
X-Mimecast-MFC-AGG-ID: M0bPoxt_NiKr1KnJnrKXFA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0C4C19560B5;
	Mon, 16 Dec 2024 13:09:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.193.102])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02C441955F41;
	Mon, 16 Dec 2024 13:09:13 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v3 0/3] sched: Restructure task_mm_cid_work for predictability
Date: Mon, 16 Dec 2024 14:09:06 +0100
Message-ID: <20241216130909.240042-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patchset moves the task_mm_cid_work to a preemptible and migratable
context. This reduces the impact of this task to the scheduling latency
of real time tasks.
The change makes the recurrence of the task a bit more predictable.
We also add optimisation and fixes to make sure the task_mm_cid_work
works as intended.

The behaviour causing latency was introduced in commit 223baf9d17f2
("sched: Fix performance regression introduced by mm_cid") which
introduced a task work tied to the scheduler tick.
That approach presents two possible issues:
* the task work runs before returning to user and causes, in fact, a
  scheduling latency (with order of magnitude significant in PREEMPT_RT)
* periodic tasks with short runtime are less likely to run during the
  tick, hence they might not run the task work at all

Patch 1 allows the mm_cids to be actually compacted when a process
reduces its number of threads, which was not the case since the same
mm_cids were reused to improve cache locality, more details in [1].

Patch 2 contains the main changes, removing the task_work on the
scheduler tick and using a delayed_work instead.
Additionally, we terminate the call immediately if we see that no mm_cid
is actually active, which could happen on processes sleeping for long
time or which exited but whose mm has not been freed yet.

Patch 3 adds a selftest to validate the functionality of the
task_mm_cid_work (i.e. to compact the mm_cids), this test requires patch
3 to be applied.

Changes since V2 [1]:
* Change the order of the patches
* Merge patches changing the main delayed_work logic
* Improved self-test to spawn 1 less thread and use the main one instead

Changes since V1 [2]:
* Re-arm the delayed_work at each invocation
* Cancel the work synchronously at mmdrop
* Remove next scan fields and completely rely on the delayed_work
* Shrink mm_cid allocation with nr thread/affinity (Mathieu Desnoyers)
* Add self test

OVERHEAD COMPARISON

In this section, I'm going to refer to head as the current state
upstream without my patch applied, patch is the same head with these
patches applied. Likewise, I'm going to refer to task_mm_cid_work as
either the task or the function. The experiments are run on an aarch64
machine with 128 cores. The kernel has a bare configuration with
PREEMPT_RT enabled.

- Memory

The patch introduces some memory overhead:
* head uses a callback_head per thread (16 bytes)
* patch relies on a delayed work per mm but drops a long (80 bytes net)

Tasks with 5 threads or less have lower memory footprint with the
current approach.
Considering a task_struct can be 7-13 kB and an mm_struct is about 1.4
kB, the overhead should be acceptable.

- Boot time

I tested the patch booting a virtual machine with vng[3], both head and
patch get similar boot times (around 8s).

- Runtime

I run some rather demanding tests to show what could possibly be a worst
case in the approach introduced by this patch. The following tests are
running again in vng to have a plain system, running mostly the
stressors (if there). Unless differently specified, time is in us. All
tests run for 30s.
The stress-ng tests were run with 128 stressors, I will omit from the
table for clarity.

No load                       head           patch
running processes(threads):   12(12)         12(12)
duration(avg,max,sum):        75,426,987     2,42,45ms
invocations:                  13             20k

stress-ng --cpu-load 80       head           patch
running processes(threads):   129(129)       129(129)
duration(avg,max,sum):        20,2ms,740ms   7,774,280ms
invocations:                  36k            39k

stress-ng --fork              head           patch
running processes(threads):   3.6k(3.6k)     4k(4k)
duration(avg,max,sum):        34,41,720      19,457,880ms
invocations:                  21             46k

stress-ng --pthread-max 4     head           patch
running processes(threads):   129(4k)        129(4k)
duration(avg,max,sum):        31,195,41ms    21,1ms,830ms
invocations:                  1290           38k

It is important to note that some of those stressors run for a very
short period of time to just fork/create a thread, this heavily favours
head since the task won't simply run as often.
Moreover, the duration time needs to be read carefully, since the task
can now be preempted by threads, I tried to exclude that from the
computation, but to keep the probes simple, I didn't exclude
interference caused by interrupts.
On the same system while isolated, the task runs in about 30-35ms, it is
hence highly likely that much larger values are only due to
interruptions, rather than the function actually running that long.

I posted another email with the scripts used to retrieve the data and
more details about the runtime distribution in [1].

[1] - https://lore.kernel.org/linux-kernel/20241213095407.271357-1-gmonaco@redhat.com/
[2] - https://lore.kernel.org/linux-kernel/20241205083110.180134-2-gmonaco@redhat.com/
[3] - https://github.com/arighi/virtme-ng

Gabriele Monaco (2):
  sched: Move task_mm_cid_work to mm delayed work
  rseq/selftests: Add test for mm_cid compaction

Mathieu Desnoyers (1):
  sched: Compact RSEQ concurrency IDs with reduced threads and affinity

 include/linux/mm_types.h                      |  23 ++-
 include/linux/sched.h                         |   1 -
 kernel/sched/core.c                           |  66 +-----
 kernel/sched/sched.h                          |  32 ++-
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 190 ++++++++++++++++++
 7 files changed, 236 insertions(+), 79 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c


base-commit: 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
-- 
2.47.1


