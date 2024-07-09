Return-Path: <linux-kernel+bounces-245039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2865E92AD75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A14282974
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7E929CEA;
	Tue,  9 Jul 2024 00:58:12 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AEF374EA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486692; cv=none; b=ioni3UxXHhOgtHm1SEELeyICScel55cefTKruj9jBp4RfqTYIlBg1Ip4iwPNzG9EhDyBnsTVa1fcVioNRXI9wFIWSIXtDAFl85hGYpkQbjAvn6Lw2gUazBm4EXRwQ12Rvg9uwSrlBtpyculEguBSCoNUcnq1Ybkn5N4bIv/cKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486692; c=relaxed/simple;
	bh=GNI38pCAIw/mgTfyEWaKect+FEbkxtnjrrpW/eCbt9E=;
	h=Date:Message-ID:Mime-Version:From:To:Subject:Content-Type; b=VU0RvmEOcK0zEqF+T9nZO+p7orLK+EC7Z6eawAu29ZZExVfquGlFtqZpSkr+805AFsT2FYLT4onhWfvZcORDchYX8vO58UzYbDsbznNg6jCXvcmSsfI1j7pwCsgKDJCiIy2GmbWgRm7bXRXMHyowXRqlzVtjXlfmF1+qCiEpH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4WJ2fL1CDDz5B1Jb;
	Tue,  9 Jul 2024 08:58:02 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 4690vw7l036219;
	Tue, 9 Jul 2024 08:57:58 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 9 Jul 2024 08:57:59 +0800 (CST)
Date: Tue, 9 Jul 2024 08:57:59 +0800 (CST)
X-Zmail-TransId: 2afa668c8b174d8-a1077
X-Mailer: Zmail v1.0
Message-ID: <20240709085759651a9uzGqelMTphJR2RrB4lI@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <peterz@infradead.org>, <bsegall@google.com>, <dietmar.eggemann@arm.com>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <liu.chun2@zte.com.cn>, <mgorman@suse.de>, <mingo@redhat.com>,
        <rostedt@goodmis.org>, <tu.qiang35@zte.com.cn>,
        <vincent.guittot@linaro.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjNdIHNjaGVkL2NvcmU6IEFkZCBXQVJOX09OX09OQ0UoKSB0byBjaGVjayBvdmVyZmxvdyBmb3IgbWlncmF0ZV9kaXNhYmxl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 4690vw7l036219
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 668C8B1A.000/4WJ2fL1CDDz5B1Jb

From: Peilin He <he.peilin@zte.com.cn>

Background
==========
When repeated migrate_disable() calls are made with missing the
corresponding migrate_enable() calls, there is a risk of
'migration_disabled' going upper overflow because
'migration_disabled' is a type of unsigned short whose max value is
65535.

In PREEMPT_RT kernel, if 'migration_disabled' goes upper overflow, it may
make the migrate_disable() ineffective within local_lock_irqsave(). This
is because, during the scheduling procedure, the value of
'migration_disabled' will be checked, which can trigger CPU migration.
Consequently, the count of 'rcu_read_lock_nesting' may leak due to
local_lock_irqsave() and local_unlock_irqrestore() occurring on different
CPUs.

Usecase
========
For example, When I developed a driver, I encountered a warning like
"WARNING: CPU: 4 PID: 260 at kernel/rcu/tree_plugin.h:315
rcu_note_context_switch+0xa8/0x4e8" warning. It took me half a month
to locate this issue. Ultimately, I discovered that the lack of upper
overflow detection mechanism in migrate_disable() was the root cause,
leading to a significant amount of time spent on problem localization.

If the upper overflow detection mechanism was added to migrate_disable(),
the root cause could be very quickly and easily identified.

Effect
======
Using WARN_ON_ONCE() to check if 'migration_disabled' is upper overflow
can help developers identify the issue quickly.

Signed-off-by: Peilin He<he.peilin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
Reviewed-by: Kun Jiang <jiang.kun2@zte.com.cn>
Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
v2->v3:
Some fixes according to:
https://lore.kernel.org/all/20240704134716.GU11386@noisy.programming.kicks-ass.net/
1.Convert p->migration_disabled to a signed type and check earlier.
2.Add overflow check for p->migration_disabled in migrate.enable().
3.Check for overflow on debug builds.

v1->v2:
Some fixes according to:
https://lore.kernel.org/all/20240702124334.762dbd5a@rorschach.local.home/
1.Merge if conditions into WARN().
2.Remove the newline character '\n'. Right, we don't need the redundant \n.

 kernel/sched/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cc4975d6b2b..1992f2848732 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2259,6 +2259,12 @@ void migrate_disable(void)
 	struct task_struct *p = current;

 	if (p->migration_disabled) {
+#ifdef CONFIG_DEBUG_PREEMPT
+		/*
+		 *Warn about overflow half-way through the range.
+		 */
+		WARN_ON_ONCE((s16)p->migration_disabled < 0);
+#endif
 		p->migration_disabled++;
 		return;
 	}
@@ -2277,14 +2283,20 @@ void migrate_enable(void)
 		.flags     = SCA_MIGRATE_ENABLE,
 	};

+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Check both overflow from migrate_disable() and superfluous
+	 * migrate_enable().
+	 */
+	if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
+		return;
+#endif
+
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
 		return;
 	}

-	if (WARN_ON_ONCE(!p->migration_disabled))
-		return;
-
 	/*
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
-- 
2.17.1

