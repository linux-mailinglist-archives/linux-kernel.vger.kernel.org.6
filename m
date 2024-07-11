Return-Path: <linux-kernel+bounces-249247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E8192E8D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BEF1C20F44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD99166313;
	Thu, 11 Jul 2024 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqcmA5f6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DF715AAD3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702905; cv=none; b=Zq7qDuo6V39wr4FCft3gckzYW75milXTGo7N3DkoCH5x8S5j9Q7uGkS329GmVdfEbLYawlCuypwgEKn+8XkSP9yvqikw+2WJiJVzdfWFZKXJzs9opejO4RPOCQk77nfklQ+nTMe8b5ewUftWOPGaz56Ugt9xDacfpPJEZWnVZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702905; c=relaxed/simple;
	bh=3hQTshq3j/pEAuKohadW5LUjN4RXbzUfNWbS/gaH5rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHXqYvhRg1dkg0jjCvgSqspEGAnEAg9xV9KPyAsAfDPLAgzLrxNr8vu8k4BuECUG0vFXZUSKyQzkEKAXN0wySO2epWQOv5gC65W10Y54GLhCfecmJ01+l7HTjeL4SPF62e//Va+MCzBesgg6NtMCSxSFI3WI1ml/kMfjIu4omjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqcmA5f6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720702903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ8G2jooOuhKMZEVaAQ+rNv5KFn8ERDELUo5S05OR5Q=;
	b=fqcmA5f6RvvBvkDtT/JJqxGrD+s9ry7EccqXcT9QadHP7jcua9x1jZbP/4JyHPqqhXjusF
	t408dtKl/yez85AkilfxMVOkbAV/kS5kIsdNz4/8HZ3rkCdRwCR27To9Tr9qJmrtBlJc+e
	HOQUWFd+c7nTs1f7rdLqfnKuFIKINws=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-6BOpIVidMVuPnBl-0JpA5w-1; Thu,
 11 Jul 2024 09:01:40 -0400
X-MC-Unique: 6BOpIVidMVuPnBl-0JpA5w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E81F1944B3E;
	Thu, 11 Jul 2024 13:01:33 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.192.211])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23CF61956066;
	Thu, 11 Jul 2024 13:01:25 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH v3 07/10] sched/fair: Prepare task_change_group_fair() for per-task throttling
Date: Thu, 11 Jul 2024 15:00:01 +0200
Message-ID: <20240711130004.2157737-8-vschneid@redhat.com>
In-Reply-To: <20240711130004.2157737-1-vschneid@redhat.com>
References: <20240711130004.2157737-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Later commits will change CFS bandwidth control throttling from a
per-cfs_rq basis to a per-task basis. This means special care needs to be
taken around any transition a task can have into and out of a cfs_rq.

To ease reviewing, the transitions are patched with dummy-helpers that are
implemented later on.

Add helpers to task_change_group_fair() to cover CPU cgroup
migration. If changing to a throttled taskgroup/cfs_rq, the task needs to
be throttled. Conversely, if the task is already throttled but changing to
a taskgroup/cfs_rq that still has some runtime, the task must be unthrottled.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index acac0829c71f3..ec4cf7308a586 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12935,6 +12935,14 @@ static void task_change_group_fair(struct task_struct *p)
 #endif
 	set_task_rq(p, task_cpu(p));
 	attach_task_cfs_rq(p);
+
+	if (!cfs_bandwidth_used())
+		return;
+
+	if (task_needs_throttling(p))
+		task_throttle_setup(p);
+	else
+		task_throttle_cancel(p);
 }
 
 void free_fair_sched_group(struct task_group *tg)
-- 
2.43.0


