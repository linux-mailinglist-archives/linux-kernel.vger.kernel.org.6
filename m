Return-Path: <linux-kernel+bounces-176459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BC8C303C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C81C2113D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 08:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C15D2A8C1;
	Sat, 11 May 2024 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="1eLdPqRR"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFB1C01
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715416056; cv=none; b=fZQ13dogK12oZXf9qTAOY55CLSlSiLlIRIJSHArpX1VmP56/IJ85t1SJO/CcvqDc26lzdJ9w7guKd+iPgBRTEQObLtZ+XwwhiUHl0QbWaQKw3yAl7wlY76lj0JeQbEfvP7FscKdPg07yDv6rJzSee+Qh+ATSxlNPvbN5lAIlD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715416056; c=relaxed/simple;
	bh=83UpJ5Zhk5PvCmvJGgl7nEw8/uHJWvS/0BmhP4YDNkE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IQ8K0SrUcuELK72gq6p9NQb91QHcoI4ez7K6N8CoRYGfgrxa9MIUKb0t5LK9GGC2n4XZUPPXQ8iUfWSE4u0oSVhrPNsi7cc/53kNRaYCLMiXhvaixXxi+N+gJoZ2H/rtVCPv7lv47MlsBzcN5XwHwNeO0tYOBKUBsbYGrTtrk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=1eLdPqRR; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DxBG/orFoYpCR8vQjvQL1eErtkm521lcXo/pnJeJvHI=; b=1eLdPqRRGaIlL+iagGcTNCenif
	Bx1CW2Gx4l1+9s2KHoK6lsMZKZ6aQqLPsXKOeg9zqAEwTW8M5p/lmOme/rtYp2vT3VV3zqjpIPqhq
	eIvpu200/wpw08fxPTCDObbpCQzhx9p8L0GgAmR3pQtYKXYUEDz1EuSJ9hinTWQBkV9BwWQLvzpY7
	D32U1bLMaJctc+b/6nbQv/VpCpbB1cVazpRSOgL+Yl8Monkd4WDP1Dyh/iZEwe2aSpwBvMEUY8I1J
	KiKtxUK2Kbd9zS78erQk49FApo92RMpBFMXQZmxsHoxG9NRu0L8+h/toaRUP7U5k91Ny1EqtiHbOG
	G09XO+RQ==;
Received: from host51-14-47-56.range51-14.btcentralplus.com ([51.14.47.56] helo=Pauls-MBP.localdomain)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s5i48-001eJy-0Q; Sat, 11 May 2024 09:26:48 +0100
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
Cc: Paul Sherwood <paul.sherwood@codethink.co.uk>
Subject: [PATCH] sched/deadline: Fix grammar and typos in comments
Date: Sat, 11 May 2024 09:26:44 +0100
Message-Id: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: paul.sherwood@codethink.co.uk

- conjugate verb to match subject of sentence
- s/a entity/an entity/g
- s/this misbehave/this misbehaviour/
- a few typos

Signed-off-by: Paul Sherwood <paul.sherwood@codethink.co.uk>
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


