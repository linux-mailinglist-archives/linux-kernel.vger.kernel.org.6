Return-Path: <linux-kernel+bounces-517495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B9BA38198
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECD516E020
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4370217727;
	Mon, 17 Feb 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfUKi6lc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5D2135C7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791414; cv=none; b=GcluwQSHQihHqiR6aE3vJ+9dtetnCqF3/21cY/iuu2viLcP3EqSX2UZDDSi5eGVBhLBgFKgyCw7VQALtLJB/5PgGXVm2E0qswV4Y+pi6YzIxZ2IoIz0zPYeYQECKJhLw9dcdl28Ywy53Tkwk1zzc4kbiIKvS3ZirnAiQulwhmHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791414; c=relaxed/simple;
	bh=cG5/4LhUXL1KmyN8SEsSL267knkaBA3yLG8JdtFOK8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2E279zznTD2hVO4tPECjHGTNnZ5rG0sOz1OQbOZEt0wzgiDe0pBVHLrgopqljjVMgkwUPd0AnAmMyqa5knkvaBUuSlCfFiW+uEugMvXje+vlgd1K5Wb5LtlS2nNMhn8VUQoa9COSj0SajDEqBij/Nb2mx8LiNx5pfVFeJWu3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfUKi6lc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739791411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=97rZuEcXoWRF4t0B/H3Zen64/NE+in9XVwWhucoqN6w=;
	b=bfUKi6lcz850oiHmgKnaMi3gQKKdOrhXm5VJ8K+ubd3PIhktYoBc58427Q+v2XG97H0t/o
	ppjk+cNHmd1RkBfSu7+8GhZ/E5qp+Y/8mNKUdq5UyJG0kfz1Qv2FAmsyzyTE/gQSBuKdmU
	n7Olc/4rq7u8BfWWvSmwNTLnglhwPUY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-H9qTSzviNPiBjjxNlB3DQg-1; Mon,
 17 Feb 2025 06:23:26 -0500
X-MC-Unique: H9qTSzviNPiBjjxNlB3DQg-1
X-Mimecast-MFC-AGG-ID: H9qTSzviNPiBjjxNlB3DQg_1739791405
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1136319783B8;
	Mon, 17 Feb 2025 11:23:25 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.190])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FEB51955BCB;
	Mon, 17 Feb 2025 11:23:21 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 0/2] sched: Run task_mm_cid_work in batches to lower latency
Date: Mon, 17 Feb 2025 12:23:15 +0100
Message-ID: <20250217112317.258716-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patchset is a continuation of [1] but using a simpler approach.
The task_mm_cid_work runs as a task_work returning to userspace and
causes a non-negligible scheduling latency, mostly due to its iterations
over all cores.

Split the work into several batches, each call to task_mm_cid_work will
not run for all cpus but just for a configurable number of cpus. Next
runs will pick up where the previous left off.
The mechanism that avoids running too frequently (100ms) is enforced
only when we finish all cpus, that is when we start from 0.

Patch 1 implements the logic behind the change

Patch 2 implements a test to validate mm_cids are compacted, since this
patchset doesn't address the fact processes running in bursts are less
likely to run the task_work, we add a busy loop in the test to make sure
the mm_cid runs during the test duration (not necessary in [1]). The
test would of course fail if the mm_cid compaction mechanism is broken.

This patchset is based on 1/3 of [1] ("sched: Compact RSEQ concurrency
IDs with reduced threads and affinity"), which will be merged separately,
lacking that commit might have the test in patch 2 fail.

[1] - https://lore.kernel.org/lkml/20250210153253.460471-1-gmonaco@redhat.com/

To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
To: Paul E. McKenney <paulmck@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>

Gabriele Monaco (2):
  sched: Compact RSEQ concurrency IDs in batches
  rseq/selftests: Add test for mm_cid compaction

 include/linux/mm_types.h                      |   8 +
 init/Kconfig                                  |  12 +
 kernel/sched/core.c                           |  27 ++-
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 208 ++++++++++++++++++
 6 files changed, 254 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c

-- 
2.48.1


