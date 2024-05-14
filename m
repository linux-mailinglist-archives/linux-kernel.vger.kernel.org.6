Return-Path: <linux-kernel+bounces-178474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06BD8C4E33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5735B284669
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42723774;
	Tue, 14 May 2024 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="oBSfBvnT"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280B1D54D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676832; cv=none; b=c9eCZ6IxuznwuQgsm3T5TY+q4OTn/+J77R7QLcnaB6A3ihWlb8MebMP3sUKDNrwYxIS6Zs226+Tojm8GwDGoENFi6675StJMPN2NNSSUGHUI0j5Ccxu6zt+mBJc0CI/rTf3NPWABzZWqhRJPxob9Ap5g5lmwjF56pZvDM79OvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676832; c=relaxed/simple;
	bh=u490sMsjGbV8jE3M33NlqVKqtAFganfRrAmRY8YSR1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GU3w7zlry6XYf1BJHubZ7UpYFvlTHCM89cFwghpeUTdZxjaw4waLwnN+QFPNdf7IFJBBUjtPIbNjG98dRME8u2UC8CF8X+1QnM+Vib4phsBDXsobF87q3Oxhlb4NHU8/L9pzKvL+okVS2JRrcOrMoGzuSXI2lQAeh7dtYyuSToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=oBSfBvnT; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9skQDCElW1f0fe5e3g4m2gYCa6PmukWW4OcftFfvfL4=; b=oBSfBvnT0l4rT5IsMRkgGm8vf7
	gN09yabuyRJizlR2yBHlU/PfOyJsDtq3/dk2nuQKm/q880WsxpnRFc07vOeG77/jl0Zt9SBz6d3mI
	UcQIbITqSg3zNoIK2l9ewg91qruNshvcm1WEs+IRE3y9tVZBq4qPSr7cRB5OnFzUUnGSQnuLN2PBi
	2PziMr43gMyzoeW/LsNk8N8fxavbVmjrsENDwSfJWM0QdRgHXdSA7y2/ytFT1p2fmXnvxuAYV2dxB
	YDDefkmJyIpVZ/3KYxTP01+WyTGj8Ro0SLVkbY+U0SpX/ArdmyA1JmXiFYNYtJGuc/eB25WSj6kJb
	omNY8gNw==;
Received: from [167.98.27.226] (helo=Pauls-MBP-2.office.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s6nuh-003Crb-GL; Tue, 14 May 2024 09:53:36 +0100
From: Paul Sherwood <paul.sherwood@codethink.co.uk>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: Paul Sherwood <paul.sherwood@codethink.co.uk>,
	Phil Auld <pauld@redhat.com>
Subject: [PATCH v2] sched/deadline: Fix grammar and typos in comments
Date: Tue, 14 May 2024 09:52:40 +0100
Message-Id: <20240514085240.54199-1-paul.sherwood@codethink.co.uk>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: paul.sherwood@codethink.co.uk

Fix some typos and grammar issues in sched deadline comments:

- conjugate verb to match subject of sentence
- s/a entity/an entity/g
- s/this misbehave/this misbehaviour/
- a few typos

Signed-off-by: Paul Sherwood <paul.sherwood@codethink.co.uk>
Reviewed-by: Phil Auld <pauld@redhat.com>
---
 kernel/sched/deadline.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..e9334b11edde 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -4,9 +4,9 @@
  *
  * Earliest Deadline First (EDF) + Constant Bandwidth Server (CBS).
  *
- * Tasks that periodically executes their instances for less than their
+ * Tasks that periodically execute their instances for less than their
  * runtime won't miss any of their deadlines.
- * Tasks that are not periodic or sporadic or that tries to execute more
+ * Tasks that are not periodic or sporadic or that try to execute more
  * than their reserved bandwidth will be slowed down (and may potentially
  * miss some of their deadlines), and won't affect any other task.
  *
@@ -816,16 +816,16 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
  * exhausting its runtime.
  *
  * Here we are interested in making runtime overrun possible, but we do
- * not want a entity which is misbehaving to affect the scheduling of all
+ * not want an entity which is misbehaving to affect the scheduling of all
  * other entities.
  * Therefore, a budgeting strategy called Constant Bandwidth Server (CBS)
  * is used, in order to confine each entity within its own bandwidth.
  *
  * This function deals exactly with that, and ensures that when the runtime
- * of a entity is replenished, its deadline is also postponed. That ensures
+ * of an entity is replenished, its deadline is also postponed. That ensures
  * the overrunning entity can't interfere with other entity in the system and
- * can't make them miss their deadlines. Reasons why this kind of overruns
- * could happen are, typically, a entity voluntarily trying to overcome its
+ * can't make them miss their deadlines. Reasons why this kind of overrun
+ * could happen are, typically, an entity voluntarily trying to overcome its
  * runtime, or it just underestimated it during sched_setattr().
  */
 static void replenish_dl_entity(struct sched_dl_entity *dl_se)
@@ -860,7 +860,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * At this point, the deadline really should be "in
 	 * the future" with respect to rq->clock. If it's
 	 * not, we are, for some reason, lagging too much!
-	 * Anyway, after having warn userspace abut that,
+	 * Anyway, after having warned userspace about that,
 	 * we still try to keep the things running by
 	 * resetting the deadline and the budget of the
 	 * entity.
@@ -896,8 +896,8 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
  *
  * IOW we can't recycle current parameters.
  *
- * Notice that the bandwidth check is done against the deadline. For
- * task with deadline equal to period this is the same of using
+ * Notice that the bandwidth check is done against the deadline. For a
+ * task with deadline equal to period this is the same as using
  * dl_period instead of dl_deadline in the equation above.
  */
 static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
@@ -930,8 +930,8 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
 }
 
 /*
- * Revised wakeup rule [1]: For self-suspending tasks, rather then
- * re-initializing task's runtime and deadline, the revised wakeup
+ * Revised wakeup rule [1]: For self-suspending tasks, rather than
+ * re-initializing the task's runtime and deadline, the revised wakeup
  * rule adjusts the task's runtime to avoid the task to overrun its
  * density.
  *
@@ -941,7 +941,7 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
  * Therefore, runtime can be adjusted to:
  *     runtime = (dl_runtime / dl_deadline) * (deadline - t)
  *
- * In such way that runtime will be equal to the maximum density
+ * This way the runtime will be equal to the maximum density
  * the task can use without breaking any rule.
  *
  * [1] Luca Abeni, Giuseppe Lipari, and Juri Lelli. 2015. Constant
@@ -987,9 +987,9 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
  * When the task is starting a new period, the Original CBS is used. In this
  * case, the runtime is replenished and a new absolute deadline is set.
  *
- * When a task is queued before the begin of the next period, using the
- * remaining runtime and deadline could make the entity to overflow, see
- * dl_entity_overflow() to find more about runtime overflow. When such case
+ * When a task is queued before the beginning of the next period, using the
+ * remaining runtime and deadline could make the entity overflow, see
+ * dl_entity_overflow() to find more about runtime overflow. When such a case
  * is detected, the runtime and deadline need to be updated.
  *
  * If the task has an implicit deadline, i.e., deadline == period, the Original
@@ -1002,7 +1002,7 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
  * runtime/deadline in a period. With deadline < period, the task would
  * overrun the runtime/period allowed bandwidth, breaking the admission test.
  *
- * In order to prevent this misbehave, the Revisited CBS is used for
+ * In order to prevent this misbehaviour, the Revisited CBS is used for
  * constrained deadline tasks when a runtime overflow is detected. In the
  * Revisited CBS, rather than replenishing & setting a new absolute deadline,
  * the remaining runtime of the task is reduced to avoid runtime overflow.
-- 
2.33.0


