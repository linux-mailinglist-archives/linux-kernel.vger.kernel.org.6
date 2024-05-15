Return-Path: <linux-kernel+bounces-179920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F48C6774
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4EB281348
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C7A8627C;
	Wed, 15 May 2024 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjsGcw/6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D65A110
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715780233; cv=none; b=uzwxYn1EVgb0atd46/x/hv+PejEELljFsQOcXl9Y4GxPpURB/kKvgN5ju+36yj4NT/aePijWlKo3Yr222qUEf9s4ViecTuRMKJaq094zIPY0PikfzzL2h6u1wgEMolryp0/2cPg4hNZy/gsAhGo2gfu+7DGNW8lfpmomevgBkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715780233; c=relaxed/simple;
	bh=RsqRRc6Wt+CMqhSQLy6K6PVMEVgsI4eCqXnrxOJ6uCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=Y98WoQbtwxv9rcfNiJHii3CI+lvVa2mfp7sE7JYO00iWc8idP7jTX4kqtyVC85boFzynMDxhlSUvgGp+yY61zgblYuA1+DEZVovVVG6YTIm3E0lMQT3+paP/TIe/+PPeH2BI8sCXDPOP375dZ5tlgL3bOt8HZ/rdU6mB5ossrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UjsGcw/6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715780230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UgKDKXX7vsPnb3EIpMpZvDmyXxGDZTOySnWlU80+dwU=;
	b=UjsGcw/67rgiVfLjJ7B7OJUdXCLnSbgy6DqQLtwuAqSJrFcEGtHVcOdItn5DBg0Cumggaz
	1AaGsiY62ONb3tyKUH5lqUZqgpITDAi97BJCvPCmaf7hTbaJtNof4EFLS34fMspwLQD6Fo
	ScsF82YCy9LIGUynNWjvLtz1XeJ6gc8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-YkdP7gDoM2GwaVBRzoLv8A-1; Wed,
 15 May 2024 09:37:07 -0400
X-MC-Unique: YkdP7gDoM2GwaVBRzoLv8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A86A29AA399;
	Wed, 15 May 2024 13:37:06 +0000 (UTC)
Received: from pauld.bos.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A0712026D68;
	Wed, 15 May 2024 13:37:06 +0000 (UTC)
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Segall <bsegall@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched: remove HZ_BW feature hedge
Date: Wed, 15 May 2024 09:37:05 -0400
Message-Id: <20240515133705.3632915-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

As a hedge against unexpected user issues commit 88c56cfeaec4
("sched/fair: Block nohz tick_stop when cfs bandwidth in use")
included a scheduler feature to disable the new functionality.
It's been a few releases (v6.6) and no screams, so remove it.

Signed-off-by: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/core.c     | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/features.h | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..d7afcee8e2ae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1269,7 +1269,7 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * dequeued by migrating while the constrained task continues to run.
 	 * E.g. going from 2->1 without going through pick_next_task().
 	 */
-	if (sched_feat(HZ_BW) && __need_bw_check(rq, rq->curr)) {
+	if (__need_bw_check(rq, rq->curr)) {
 		if (cfs_task_bw_constrained(rq->curr))
 			return false;
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c62805dbd608..06e026f10cb4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6549,7 +6549,7 @@ static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
 {
 	int cpu = cpu_of(rq);
 
-	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
+	if (!cfs_bandwidth_used())
 		return;
 
 	if (!tick_nohz_full_cpu(cpu))
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 143f55df890b..929021fd6bc4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,5 +85,3 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
-
-SCHED_FEAT(HZ_BW, true)
-- 
2.39.3


