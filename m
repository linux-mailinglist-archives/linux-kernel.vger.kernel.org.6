Return-Path: <linux-kernel+bounces-521411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F32EA3BCD6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026D53ACE40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079E1D88D7;
	Wed, 19 Feb 2025 11:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfqovmXr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1D1B85CC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964682; cv=none; b=P6nm3GXeCHfNLxnk91zoKJYw/F2ukWwQ3YfZpE+5TidiS+19Ti570XWW/CQ0l+EVSz4TRP0bDfftNgZehBGKAt43zcashmePe28ZNEqLJe1mtMtI8J25wh424LnZq5jas2QL4WpTXd0aJHnAVofy02ziqhnDUE6f4nxp0pbb2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964682; c=relaxed/simple;
	bh=+//6NA7XDP5tKhkoYM8Vuhiv9qpbrwik9KoUBuFEgU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0fr7tGhJxemQNuP6LTJb2IOwZOjKzwQk/68ZQGsjIHldrvwoOrs+HHPwMkvAEWLgcqRma/KMRO/Pg8UuABN2L9Z3axqq6hcUTHLGFbtyjf9K0Y3grv6s8BGTayft1DgTIbvlWK8UVCnvVAsiPqwwe9SVjhBSk+YCZq9I7FGbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfqovmXr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739964679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ueHLJLogNn9uE4Gmx+o1XLW1LfIMOANKN8DNYLmRXTg=;
	b=TfqovmXrg/ydgIB9fPW73uyTdo+W/rpkfgFmYoNLcSo9Go9Dh0wDQcpiLmqeCxNP0X7Ry4
	cg0dqGXeAyBBSWIW+d8g666a4jwyUO6osLsuDVAkICy5sCAL4DJQbpIOFYWPnI4WxZN3eK
	LcC0uTV7mpcmqnGJNI7oYan4hlhkTH4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-_2O8dt7TOOi53OCHUfPosg-1; Wed,
 19 Feb 2025 06:31:16 -0500
X-MC-Unique: _2O8dt7TOOi53OCHUfPosg-1
X-Mimecast-MFC-AGG-ID: _2O8dt7TOOi53OCHUfPosg_1739964675
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A51061800877;
	Wed, 19 Feb 2025 11:31:14 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.122])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEFDB19560A3;
	Wed, 19 Feb 2025 11:31:11 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v7 0/2] sched: Restructure task_mm_cid_work for predictability
Date: Wed, 19 Feb 2025 12:31:06 +0100
Message-ID: <20250219113108.325545-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patchset moves the task_mm_cid_work to a preemptible and migratable
context. This reduces the impact of this work to the scheduling latency
of real time tasks.
The change makes the recurrence of the task a bit more predictable.

The behaviour causing latency was introduced in commit 223baf9d17f2
("sched: Fix performance regression introduced by mm_cid") which
introduced a task work tied to the scheduler tick.
That approach presents two possible issues:
* the task work runs before returning to user and causes, in fact, a
  scheduling latency (with order of magnitude significant in PREEMPT_RT)
* periodic tasks with short runtime are less likely to run during the
  tick, hence they might not run the task work at all

Patch 1 contains the main changes, removing the task_work on the
scheduler tick and using a work_struct scheduled more reliably during
__rseq_handle_notify_resume.

Patch 2 adds a selftest to validate the functionality of the
task_mm_cid_work (i.e. to compact the mm_cids). The test fails if patch
1 of V6 ("sched: Compact RSEQ concurrency IDs with reduced threads and
affinity", applied separately) is not applied and is flaky without patch
1 of this series. We expect it to always pass with both applied.

Changes since V6 [1]:
* Switch to a simple work_struct instead of a delayed work
* Schedule the work_struct in __rseq_handle_notify_resume
* Asynchronously disable the work but make sure mm is there while we run
* Remove first patch as merged independently
* Fix commit tag for test

Changes since V5:
* Punctuation

Changes since V4 [2]:
* Fixes on the selftest
    * Polished memory allocation and cleanup
    * Handle the test failure in main

Changes since V3 [3]:
* Fixes on the selftest
    * Minor style issues in comments and indentation
    * Use of perror where possible
    * Add a barrier to align threads execution
    * Improve test failure and error handling

Changes since V2 [4]:
* Change the order of the patches
* Merge patches changing the main delayed_work logic
* Improved self-test to spawn 1 less thread and use the main one instead

Changes since V1 [5]:
* Re-arm the delayed_work at each invocation
* Cancel the work synchronously at mmdrop
* Remove next scan fields and completely rely on the delayed_work
* Shrink mm_cid allocation with nr thread/affinity (Mathieu Desnoyers)
* Add self test

[1] - https://lore.kernel.org/lkml/20250210153253.460471-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250113074231.61638-4-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20241216130909.240042-1-gmonaco@redhat.com
[4] - https://lore.kernel.org/lkml/20241213095407.271357-1-gmonaco@redhat.com
[5] - https://lore.kernel.org/lkml/20241205083110.180134-2-gmonaco@redhat.com

To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>
To: Paul E. McKenney <paulmck@kernel.org>
To: Shuah Khan <shuah@kernel.org>

Gabriele Monaco (2):
  sched: Move task_mm_cid_work to mm work_struct
  selftests/rseq: Add test for mm_cid compaction

 include/linux/mm_types.h                      |   8 +
 include/linux/sched.h                         |   7 +-
 kernel/rseq.c                                 |   1 +
 kernel/sched/core.c                           |  33 ++-
 kernel/sched/sched.h                          |   2 -
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 200 ++++++++++++++++++
 8 files changed, 229 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c


base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
prerequisite-patch-id: 6888a889ab5dcd50c3874005018576fdced3a5e5
-- 
2.48.1


