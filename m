Return-Path: <linux-kernel+bounces-569968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71140A6AA43
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A717A3160
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC921E9B0F;
	Thu, 20 Mar 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1FI+6cT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3831D5AA0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485730; cv=none; b=FUPqKbDe7kIuc8gdKo23yFWyTGdXCjp5nNjDM4n1XLZg4pJUKklyYnjOPKNy9Gt2ioRaBvMLnrHY80eGbzDJFiRVYjECKntUu5E5c+je+YNl0e//SZkFRzIQLCQeboi7MdfuAze8lPyv8sc1cAjJRGsKmw56vNIeaPrMEC1fD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485730; c=relaxed/simple;
	bh=WRJMRQMQc04VjZudPO5X9MB6nQQyA4mWKa+oAYkKpo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlID2I8fig/sWgSReRrLtw6WcKalNJxxVLCQc/yd5FNH5Vs3GmU7R3xiV7eYYc/Z+W+WNaflYjfTbLOJOnKRhvBEHya4SHfCfQrqzlTrNCQ5Pzb7rZ4R00A1JWmp6SCnhwfZVkUJmkWL/tJSw1OnPvF2ZlubM/xrhZ+0Nww/s7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1FI+6cT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so9556295e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742485727; x=1743090527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G4cGZmx/d0blV8DBSa1RJlaC798fm7ehsAeZ99f4+p0=;
        b=V1FI+6cTXSsxkKtVN/twRwu9Wtux1sS+Wn0Q2Z1mvICDDsdbEsG4khvTTkwOQ2XVvI
         zgnTzWsL5II7DGl7pItwxoGiJlNeoHWVj8EZR8xyAWsd0/OajpWycmZVzSl7LAprJ13i
         Xx9RXA00yv2zroOuikWDwWwcWqG/wR2e48GL5ZhxSiDQuRx7O4mta7CarqIqF4yPOVM7
         MK/q2cbHT/ASBmMbx2q3FDVziLDq0pXJleJeIXWuayQfmKxQNRQUCv/bQP9DpfTCPzik
         CRBMUqc2a1WxrHagctJyAV5Heyh19yNZBI5XGpTIqe8Q+n+DTZssd3XM2HLSOMxNPVuv
         O0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742485727; x=1743090527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4cGZmx/d0blV8DBSa1RJlaC798fm7ehsAeZ99f4+p0=;
        b=ImcWGcHBSt9R3Ztm75tn2Qrl/QSZk+pHL4b58ZCBo4uEtiLTc7TN0Mn1KW6oSVpGIn
         TWL5URDQsRE5pLmB5NEekH7EwI0mSgVbPkHsnWdIG9roeZ9O60fthO7/7HBX+n8vxq0z
         FIfWyKT4RXvq9VQJTklG/buov4s0yw/L2J4MZe0LNviE2Dw43A4u6BzMi3sj57iguqB9
         0js5NuRsvdqZJs4umpklMap6hQGv4FtIcqacjFo3vLciwMJA3xNN3MlFtcprWd3C0kUf
         1tm2/PNHfbSvUutqjs1c/25HrBbqMpyo74495ALcuA592TgiRB+uWKIZ3qEc6BFzsN5C
         gv7A==
X-Gm-Message-State: AOJu0Yx74gyjGOrJJR8A0LWzGuWllDhp0evIKB+MK1LqHFM0KqAvZ5+1
	VjQF0ziCcu5AFREcumYafoSm2m2ZpxxiU/5akq8uL79fkTcpGTaX
X-Gm-Gg: ASbGnctcsSIxRuklJT6PupwnX6oaHnBLcCJbyGBKpd2Z1LF3ksz+BCccnpCzRNgB+v3
	dfGqagwvDhb3wfwwGpQdWkQMj6LKOEsbc8SSmmqnQDLwkViPRzdwd+bhOPnvozy2w1pkoHY9yAv
	GuUxB6IvSeVwBqeQE5SYa0fRXnLK+CseAMik6GuobC8Zk7sk1394ZwJjOSB6DeiyUqo8H0S375O
	jgabwgBwfUkq+fzrxcfdlFOT9lCl9ZS/4/hqOUQ2SEly6KZlNrcCN8GMxyTXklcssuYYnCQmzoz
	OUK9f4BEsQk8OR6377uUPcx8Ck6csEF7C59Qy6v9cQxCaA==
X-Google-Smtp-Source: AGHT+IG4QhevPl8bcZzGcWOpVzywqw4vy6wZonhtLrkAQTdoAtyntfQedk7HtCKjcXxul9OTsQRJnw==
X-Received: by 2002:a05:600c:6b05:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-43d43beef9fmr56311885e9.6.1742485726205;
        Thu, 20 Mar 2025 08:48:46 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d440eda26sm52384675e9.36.2025.03.20.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:48:45 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][next] sched: add some likely/unlikey branch hints in scheduler core
Date: Thu, 20 Mar 2025 15:48:07 +0000
Message-ID: <20250320154807.982435-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are several places in the scheduler core where branch hinting
can improve performance. The added hints in this commit are based
on a 1.5 day run of all the 360+ stress-ng test cases and various
kernel builds on a gcov coverage instrumented kernel. The most
heavily exercised if statements were examined for very likely or
unlikely paths and branch hints added.

Benchmarked on a 24 thread Intel(R) Core(TM) Ultra 9 285K, running
Debian Sid. Built with default Debian kernel build flags with
gcc 14.2.0 (Debian 14.2.0-19)

Testing: Turbo was disabled to reduce clock frequency jitter for stable
results. Several stress-ng scheduler stressing stress-ng tests were
used to benchmark the system. Each test was run for 20 seconds with a
20 second cool-down wait between each test. Tests were run 10 times
and performance metrics based on the geometic mean of the bogo-op
throughput rates from stress-ng. Tested with 24 stressor instances
and also 1 stressor instance.

24 stressor instance results:

                 bogo-ops/sec metrics
              original       optimized
cpu-sched    1,405,594       1,476,842
fifo        10,867,835	     7,220,092
flipflop       370,684         388,464
futex          886,307       1,038,800
mq           9,874,889      10,286,373
msg         14,988,007      15,251,091
mtx      1,183,226,726   1,116,962,074
mutex        7,636,566       7,624,284
poll         1,875,193       1,849,430
prio-inv    43,605,926      48,446,085
pthread        153,030         193,861
race-sched       7,509           8,029
schedmix        18,858          18,617
schedpolicy  5,273,112       5,395,978
switch      10,078,698      10,077,338
tee            219,771         224,791
yield       38,654,965      38,441,461
Goemean:     2,488,153       2,527,566

Improvement: ~1.5%

1 stressor instance results:

                 bogo-ops/sec metrics
              original       optimized
cpu-sched      146,092         146,357
fifo           609,243         595,224
flipflop        27,288          32,939
futex          259,095         273,300
mq             971,830         988,218
msg          3,630,096       3,646,838
mtx         10,829,939      11,285,273
mutex        1,179,245       1,168,837
poll            70,430          70,369
prio-inv       450,512         457,393
pthread         39,407          39,642
race-sched       1,453           1,470
schedmix         4,373           4,376
schedpolicy    522,030         523,113
switch         247,287         241,640
tee             16,685          16,771
yield       37,409,707      37,064,076
               233,441         237,328

Improvement: ~1.6%

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/sched/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 87540217fc09..90a08eb571ca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5929,10 +5929,10 @@ static noinline void __schedule_bug(struct task_struct *prev)
 static inline void schedule_debug(struct task_struct *prev, bool preempt)
 {
 #ifdef CONFIG_SCHED_STACK_END_CHECK
-	if (task_stack_end_corrupted(prev))
+	if (unlikely(task_stack_end_corrupted(prev)))
 		panic("corrupted stack end detected inside scheduler\n");
 
-	if (task_scs_end_corrupted(prev))
+	if (unlikely(task_scs_end_corrupted(prev)))
 		panic("corrupted shadow stack detected inside scheduler\n");
 #endif
 
@@ -10402,7 +10402,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 	if (!mm)
 		return;
 	src_cpu = t->migrate_from_cpu;
-	if (src_cpu == -1) {
+	if (unlikely(src_cpu == -1)) {
 		t->last_mm_cid = -1;
 		return;
 	}
@@ -10432,7 +10432,7 @@ void sched_mm_cid_migrate_to(struct rq *dst_rq, struct task_struct *t)
 		return;
 	src_cid = __sched_mm_cid_migrate_from_try_steal_cid(src_rq, t, src_pcpu_cid,
 							    src_cid);
-	if (src_cid == -1)
+	if (unlikely(src_cid == -1))
 		return;
 	if (dst_cid_is_set) {
 		__mm_cid_put(mm, src_cid);
@@ -10559,7 +10559,7 @@ static void task_mm_cid_work(struct callback_head *work)
 	if (t->flags & PF_EXITING)
 		return;
 	mm = t->mm;
-	if (!mm)
+	if (unlikely(!mm))
 		return;
 	old_scan = READ_ONCE(mm->mm_cid_next_scan);
 	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
@@ -10594,7 +10594,7 @@ void init_sched_mm_cid(struct task_struct *t)
 	struct mm_struct *mm = t->mm;
 	int mm_users = 0;
 
-	if (mm) {
+	if (likely(mm)) {
 		mm_users = atomic_read(&mm->mm_users);
 		if (mm_users == 1)
 			mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
@@ -10623,7 +10623,7 @@ void sched_mm_cid_exit_signals(struct task_struct *t)
 	struct mm_struct *mm = t->mm;
 	struct rq *rq;
 
-	if (!mm)
+	if (unlikely(!mm))
 		return;
 
 	preempt_disable();
@@ -10645,7 +10645,7 @@ void sched_mm_cid_before_execve(struct task_struct *t)
 	struct mm_struct *mm = t->mm;
 	struct rq *rq;
 
-	if (!mm)
+	if (unlikely(!mm))
 		return;
 
 	preempt_disable();
-- 
2.49.0


