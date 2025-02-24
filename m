Return-Path: <linux-kernel+bounces-529174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE63A420A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93262189C208
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDF1B041E;
	Mon, 24 Feb 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkB1Ovxu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB242192EB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403822; cv=none; b=aO3FHQHNQZ8HsMG3twTTFjq9YXgY8UsxAn3pUe3kXH8mpxZHvts9sayOmV1EfvLBynJG06CIqVUqOHSHW93r7xYYdVUqYfyWPy6F6s/unIQ2Gof15KDVCpKqDBuAH6nWM/b1BxrSq+ddOAXgAIvYJ37/jXAZQI5Xu5PPeE0aP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403822; c=relaxed/simple;
	bh=s6SXgk6edeyiXy+VdJO48htCnjk1RNWyS5jovcOTAGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4dZOEAmIA75HPwZNTnVbvkrXyu3JQlDIZ1p1MdSI9Kwei8cAksfPWXAgFFXS9nDqYtgOZOG5xRXeQ+LSLcmIj3xBVG2O+JArHmn1Ua24apKC0IaVxvEwa0MIJ4BxOW4wYtbY3ZtNiul7CPi7fD5fcPFk7h6clWG6tgHwfQgsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkB1Ovxu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740403819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kF0mtbZi5PCeZW3q0E/GxxqP9VBPDymI5zE24QYiKus=;
	b=bkB1OvxuTbaAfy//BmrxeQ9QBVGH8eRHAsTTqqmByBMvkXBwQUX6Aod3mvCeqA18FCIYvG
	8qy/onDrxLRph/H98HmqPJh9gAdvBNrB0peU7JKT3hTt3EVc5ucTiorcpmvHGvgmguJCV8
	UTvsCBp6yoJ6hREXjtVluGneKXS+u5E=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-NLdBPH9LOtSJKEwJivjAjg-1; Mon,
 24 Feb 2025 08:30:15 -0500
X-MC-Unique: NLdBPH9LOtSJKEwJivjAjg-1
X-Mimecast-MFC-AGG-ID: NLdBPH9LOtSJKEwJivjAjg_1740403814
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B2491903085;
	Mon, 24 Feb 2025 13:30:14 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.226.36])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A9871956094;
	Mon, 24 Feb 2025 13:30:09 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v9 0/3] sched: Restructure task_mm_cid_work for predictability
Date: Mon, 24 Feb 2025 14:28:32 +0100
Message-ID: <20250224132836.383041-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Patch 1 add support for prev_sum_exec_runtime to the RT, deadline and
sched_ext classes as it is supported by fair, this is required to avoid
calling rseq_preempt on tick if the runtime is below a threshold.

Patch 2 contains the main changes, removing the task_work on the
scheduler tick and using a work_struct scheduled more reliably during
__rseq_handle_notify_resume.

Patch 3 adds a selftest to validate the functionality of the
task_mm_cid_work (i.e. to compact the mm_cids).

Changes since V8 [1]:
* Add support for prev_sum_exec_runtime to RT, deadline and sched_ext
* Avoid rseq_preempt on ticks unless executing for more than 100ms
* Queue the work on the unbound workqueue

Changes since V7:
* Schedule mm_cid compaction and update at every tick too
* mmgrab before scheduling the work

Changes since V6 [2]:
* Switch to a simple work_struct instead of a delayed work
* Schedule the work_struct in __rseq_handle_notify_resume
* Asynchronously disable the work but make sure mm is there while we run
* Remove first patch as merged independently
* Fix commit tag for test

Changes since V5:
* Punctuation

Changes since V4 [3]:
* Fixes on the selftest
    * Polished memory allocation and cleanup
    * Handle the test failure in main

Changes since V3 [4]:
* Fixes on the selftest
    * Minor style issues in comments and indentation
    * Use of perror where possible
    * Add a barrier to align threads execution
    * Improve test failure and error handling

Changes since V2 [5]:
* Change the order of the patches
* Merge patches changing the main delayed_work logic
* Improved self-test to spawn 1 less thread and use the main one instead

Changes since V1 [6]:
* Re-arm the delayed_work at each invocation
* Cancel the work synchronously at mmdrop
* Remove next scan fields and completely rely on the delayed_work
* Shrink mm_cid allocation with nr thread/affinity (Mathieu Desnoyers)
* Add self test

[1] - https://lore.kernel.org/lkml/20250220102639.141314-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250210153253.460471-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20250113074231.61638-4-gmonaco@redhat.com
[4] - https://lore.kernel.org/lkml/20241216130909.240042-1-gmonaco@redhat.com
[5] - https://lore.kernel.org/lkml/20241213095407.271357-1-gmonaco@redhat.com
[6] - https://lore.kernel.org/lkml/20241205083110.180134-2-gmonaco@redhat.com

To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.org>
To: Paul E. McKenney <paulmck@kernel.org>
To: Shuah Khan <shuah@kernel.org>

Gabriele Monaco (3):
  sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
  sched: Move task_mm_cid_work to mm work_struct
  selftests/rseq: Add test for mm_cid compaction

 include/linux/mm_types.h                      |   8 +
 include/linux/rseq.h                          |   2 +
 include/linux/sched.h                         |   7 +-
 kernel/rseq.c                                 |   1 +
 kernel/sched/core.c                           |  42 ++--
 kernel/sched/deadline.c                       |   1 +
 kernel/sched/ext.c                            |   1 +
 kernel/sched/rt.c                             |   1 +
 kernel/sched/sched.h                          |   2 -
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 200 ++++++++++++++++++
 12 files changed, 241 insertions(+), 27 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.48.1


