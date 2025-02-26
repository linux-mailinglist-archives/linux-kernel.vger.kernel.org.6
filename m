Return-Path: <linux-kernel+bounces-533154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00BA45636
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE1516D2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C3A26BDA4;
	Wed, 26 Feb 2025 07:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVMIuVl2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30E26B2A6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553346; cv=none; b=m6tvT0qZRF/Y+QtEeHb/s3wbcZUhj9hridHkl0Vi66L6kAYV3hH92mhVYhwzpLXDxQwlvRO5xkDRx/jBTm+hvD254X2xHnbZws/FIM5Rt+uY8UUoX9BNy8WfnVdKCwZsps8KITCF58qKK9UMMMLD7HS6EGvIrWXTZuzsBb0aLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553346; c=relaxed/simple;
	bh=VSoIHMw4or33tjTxaG+pvxLxxyLI940+84D15bLgmw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHGnQiUpmbs47BxK3+1fEgHroyZQquKt6/+2j8IWmD8YC3G+Mlrgb/tf5gMsBPLS+06aalvMtynb2JIJi2prdkI2412wysk+zxJwt3WzJrcdokw+kGcOIFjnJBLOygVFGWt2vhFDJ8k8G3q35OJ5lxFGsc7KaFTzKW1uP9KT4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVMIuVl2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740553343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BY5iwKLO1QRO6Zhm/z1+JAYHfdZ9ZSUnGWORRWVYd8o=;
	b=CVMIuVl2knktycV06QcUnO26OwzvuO9LW6Sclz+WCRKDnSGLrag1P/hSKUXGaNrQwI2Sz4
	V9wZvOkrwp9KHjtjyxjOP1wo1LDhB4pfJWTUsLB7NNOPeUz0mE+0IXXHY+ILmFN/vgbooj
	ygoz1shaLSSPdWJ0Dz+cOFyl4NWpdPQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-j9HYI0hVMSC-I33m91Nzjg-1; Wed,
 26 Feb 2025 02:02:17 -0500
X-MC-Unique: j9HYI0hVMSC-I33m91Nzjg-1
X-Mimecast-MFC-AGG-ID: j9HYI0hVMSC-I33m91Nzjg_1740553336
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94ADF18D9594;
	Wed, 26 Feb 2025 07:02:16 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.200])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94BBA19560AB;
	Wed, 26 Feb 2025 07:02:13 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v10 1/3] sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
Date: Wed, 26 Feb 2025 08:01:58 +0100
Message-ID: <20250226070202.95062-2-gmonaco@redhat.com>
In-Reply-To: <20250226070202.95062-1-gmonaco@redhat.com>
References: <20250226070202.95062-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The fair scheduling class relies on prev_sum_exec_runtime to compute the
duration of the task's runtime since it was last scheduled. This value
is currently not required by other scheduling classes but can be useful
to understand long running tasks and take certain actions (e.g. during a
scheduler tick).

Add support for prev_sum_exec_runtime to the RT, deadline and sched_ext
classes by simply assigning the sum_exec_runtime at each set_next_task.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/ext.c      | 1 +
 kernel/sched/rt.c       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af7..438b3a953d6c7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2391,6 +2391,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_dl_rq(&p->dl))
 		update_stats_wait_end_dl(dl_rq, dl_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5a81d9a1e31f2..feaed0459eb92 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2974,6 +2974,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b12..1ea272e4dae71 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1684,6 +1684,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
-- 
2.48.1


