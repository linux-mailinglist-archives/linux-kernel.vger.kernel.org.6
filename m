Return-Path: <linux-kernel+bounces-259010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6395938FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A09BB21227
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7B816DC12;
	Mon, 22 Jul 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA7KAw6n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B716D9D4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655055; cv=none; b=EbOccyDbmBcAUipcnJN3OAFs141VmiyZkjtBzHCA4H4jUsWd+NNik92vsBIpQFbNqZJwQeaN0RIargBOb7qR0yqBngYBEnF6CJ/3GyZJQyjonNN4zH5NgihOmhGxqVEIt68YrSqGJAxLXc4FYXLCWgPe6Qbub8hA7iJQBTTjqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655055; c=relaxed/simple;
	bh=lIaaePxXmnbJj8vKYVGoFuDWtPcijK3hH3x0jKBHy2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0VWORQdgl90CQ9oV9YCOleDLoWlkkCuet04NcCdnE/SGLSzojsKqqFc0uHgK+cFlYf7nuddizQVkWbs/G29dRmasmgXEGJtesyL9K/81gHsR88D/WtjCW9rsCZ7CHoJcN+0J9qHEWrRtxdI2OyuZBx8J4v76suEzwbjnryi9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BA7KAw6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721655052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBbvFchsdGqDlenHLSJuaCBk6m+5EChCmdEPeRVzw5Y=;
	b=BA7KAw6n2CIZQDo2bKMMOCN3OvHzq7eh8AEgIEx580PWB6sqpSJubf9ohAycBYNJ/FCjsh
	BAleGl99Knt20QKM5XOfhbBjkmBdoOw8wPm8MKWScZS4zzsy+Cl+zaX3vfReVRz4duiQbb
	AGMnCMvwLU60mz1kU9B13/m3gZepwlo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-GJjFNYZ3N7W_nIqL4zMZtA-1; Mon,
 22 Jul 2024 09:30:48 -0400
X-MC-Unique: GJjFNYZ3N7W_nIqL4zMZtA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3CF41944A89;
	Mon, 22 Jul 2024 13:30:30 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.96.134.70])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 531171955D53;
	Mon, 22 Jul 2024 13:30:13 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 1/3] sched/deadline: Fix warning in migrate_enable for boosted tasks
Date: Mon, 22 Jul 2024 10:29:25 -0300
Message-ID: <20240722132935.14426-2-wander@redhat.com>
In-Reply-To: <20240722132935.14426-1-wander@redhat.com>
References: <20240722132935.14426-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When running the following command:

while true; do
    stress-ng --cyclic 30 --timeout 30s --minimize --quiet
done

a warning is eventually triggered:

WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
setup_new_dl_entity+0x13e/0x180
...
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1c4/0x2df
 ? enqueue_dl_entity+0x631/0x6e0
 ? setup_new_dl_entity+0x13e/0x180
 ? __warn+0x7e/0xd0
 ? report_bug+0x11a/0x1a0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 enqueue_dl_entity+0x631/0x6e0
 enqueue_task_dl+0x7d/0x120
 __do_set_cpus_allowed+0xe3/0x280
 __set_cpus_allowed_ptr_locked+0x140/0x1d0
 __set_cpus_allowed_ptr+0x54/0xa0
 migrate_enable+0x7e/0x150
 rt_spin_unlock+0x1c/0x90
 group_send_sig_info+0xf7/0x1a0
 ? kill_pid_info+0x1f/0x1d0
 kill_pid_info+0x78/0x1d0
 kill_proc_info+0x5b/0x110
 __x64_sys_kill+0x93/0xc0
 do_syscall_64+0x5c/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
 RIP: 0033:0x7f0dab31f92b

This warning occurs because set_cpus_allowed dequeues and enqueues tasks
with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
is triggered. A boosted task already had its parameters set by
rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
hence the WARN_ON call.

Check if we are requeueing a boosted task and avoid calling
setup_new_dl_entity if that's the case.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: 2279f540ea7d ("sched/deadline: Fix priority inheritance with multiple scheduling classes")

---

The initial idea for this fix was to introduce another ENQUEUE flag,
ENQUEUE_SET_CPUS_ALLOWED. When this flag was set, the deadline scheduler
would bypass the call to setup_new_dl_entity, regardless of whether the
task was boosted. However, this idea was abandoned due to the presence
of other DEQUEUE_SAVE/ENQUEUE_RESTORE pairs in the code. Ultimately, a
simpler approach was chosen, which achieves the same practical effects
without the need to create an additional flag for enqueue_task.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f59e5c19d944..312e8fa7ce94 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1753,6 +1753,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
+		   !is_dl_boosted(dl_se) &&
 		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);
 	}
-- 
2.45.2


