Return-Path: <linux-kernel+bounces-222642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B40910538
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B9D2870A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EF1B9AB5;
	Thu, 20 Jun 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgpISAPc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09C1ACE85
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888207; cv=none; b=RsZ/CtFmHNODMenUIr73Xa+k0M1E/AGmH50ek6AeCzDCwRqZ6x5BjFSYoJHHOVjEjHQhPYzQqYiG6iFpPna0F9abYlo7OXLcdkNtMX+J4vFfGDrTVZjorCzuobIqxfLZn1FyRHKh8RC5tFnLHQS+wosgu5P714NVGII9TCjeZGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888207; c=relaxed/simple;
	bh=Wv3QDohn8xZmsuV7l+6O1mJDCkvg+7iAp5j34+pgy8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpWtrIqp5zhXVHOvol0Sza4Lqm2EwSI/1gc7a0sT3e8lnPcEj/Id8tg7ON51zZo80fnUaLmkSugxTgY12bKxjCCFtBTbdoMHTFZx5iujJ6lrSisETrBdlFk7Zu8rtRCCA4p3DjDtjG3czuWwRtZy6ItSKaIOiVBUVceDj3UpFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgpISAPc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718888205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6hsYEXHWYnbKPV/2Gxb8scN2oJtac1rqFPLaeM8+ab8=;
	b=DgpISAPcz54PYvOgIjO1Yb6YCRDQNu8tuKZjgjF47OIYEMeKEtB6Hi/xuQ5WYBGj2rnoEL
	FN0fMvFc77tElNGd8ebjQtETeZGOoTuvtk8wC6Q8uRh/Mb+QEH1b4tFGAjBjtlfYucdx1v
	OBPGCA57+/tdtyM1n7bId3aeMbm3o6A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-jP7-U_j-PhmfsvtN1XP7TA-1; Thu,
 20 Jun 2024 08:56:40 -0400
X-MC-Unique: jP7-U_j-PhmfsvtN1XP7TA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 765891956067;
	Thu, 20 Jun 2024 12:56:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.16.166])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F3C119560B3;
	Thu, 20 Jun 2024 12:56:31 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: rrendec@redhat.com,
	Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v2] sched/deadline: fix task_struct reference leak
Date: Thu, 20 Jun 2024 09:56:17 -0300
Message-ID: <20240620125618.11419-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

During the execution of the following stress test with linux-rt:

stress-ng --cyclic 30 --timeout 30 --minimize --quiet

kmemleak frequently reported a memory leak concerning the task_struct:

unreferenced object 0xffff8881305b8000 (size 16136):
  comm "stress-ng", pid 614, jiffies 4294883961 (age 286.412s)
  object hex dump (first 32 bytes):
    02 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .@..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  debug hex dump (first 16 bytes):
    53 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00  S...............
  backtrace:
    [<00000000046b6790>] dup_task_struct+0x30/0x540
    [<00000000c5ca0f0b>] copy_process+0x3d9/0x50e0
    [<00000000ced59777>] kernel_clone+0xb0/0x770
    [<00000000a50befdc>] __do_sys_clone+0xb6/0xf0
    [<000000001dbf2008>] do_syscall_64+0x5d/0xf0
    [<00000000552900ff>] entry_SYSCALL_64_after_hwframe+0x6e/0x76

The issue occurs in start_dl_timer(), which increments the task_struct
reference count and sets a timer. The timer callback, dl_task_timer,
is supposed to decrement the reference count upon expiration. However,
if enqueue_task_dl() is called before the timer expires and cancels it,
the reference count is not decremented, leading to the leak.

This patch fixes the reference leak by ensuring the task_struct
reference count is properly decremented when the timer is canceled.

---

Changelog:

v2:
* Add the fixes tag
* Add a comment about canceling the timer while the callback was running

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: feff2e65efd8 ("sched/deadline: Unthrottle PI boosted threads while enqueuing")
---
 kernel/sched/deadline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c75d1307d86d..9bedd148f007 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1804,8 +1804,13 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 			 * The replenish timer needs to be canceled. No
 			 * problem if it fires concurrently: boosted threads
 			 * are ignored in dl_task_timer().
+			 *
+			 * If the timer callback was running (hrtimer_try_to_cancel == -1),
+			 * it will eventually call put_task_struct().
 			 */
-			hrtimer_try_to_cancel(&p->dl.dl_timer);
+			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
+			    !dl_server(&p->dl))
+				put_task_struct(p);
 			p->dl.dl_throttled = 0;
 		}
 	} else if (!dl_prio(p->normal_prio)) {
-- 
2.45.2


