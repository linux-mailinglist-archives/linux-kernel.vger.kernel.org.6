Return-Path: <linux-kernel+bounces-259015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD3938FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E5AB211A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE616D9DA;
	Mon, 22 Jul 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4cqI4Xg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BFE14F90;
	Mon, 22 Jul 2024 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655475; cv=none; b=MjNvh3tS3MgBWDtz385HocOLLWb82owLmAz7FuXcJJHQl22lnerV8u+tGTwfBEGYXFQ2SZrrhjkttDc7QvHwpQz3AZ3NIigNYdl2D+TQD3rv3NdD1mKbSw5IePor/UOcG7o7NOuAjsXnoFRU0VPJuBX2cx5Wv9iyD84lHENOsWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655475; c=relaxed/simple;
	bh=qHJ5Vpfkh0DnkehcPl9mSnrv+0B4SLAaJxRPzc/l0Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4r36b4n02RC9eXthSbAmBksdoQhca6oZLIoS+1T7KQnHT77fsmYqljxErRZkst+q6WT4SVC1dauvZ173p6a/LMW1hQ2+qwoqWmzjfTuMDO15RanGbJNd011jPP25h/ynTwF9Q8R1mq777xAzkuTiM7gSYXtSqc3fLEU9+xQ1MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4cqI4Xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80620C116B1;
	Mon, 22 Jul 2024 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655475;
	bh=qHJ5Vpfkh0DnkehcPl9mSnrv+0B4SLAaJxRPzc/l0Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T4cqI4Xg9YGLTejR17bc+uvgH5KOah/fuJDZOnTGGSsqIO2c1PZDnfbGVoK5XXlin
	 mK6B03Xp37roiIRPtKbTgJGN0UbB0Bv/d5fqZjcAvfjhAIZwQoVwaAaZjtakZidUPQ
	 xSK/H7VH38kFXwyXbk/RNK1pfAjsTHeg/MScQneU0uk3F0KfoRUof1iHdqz7qYkpJp
	 +Euuz1eZfKej4nXUosQ1hh/Phkv0tmk5dgC8/ONjsADux10yTTKiIQJNRxyTes2xOu
	 suy58zm7eI3Hzz+2AUDauhS7ILYrmbTOnshsaxJx4W99UB7jfQjxfai07OCNcNKiUt
	 cqNyITVMozNgw==
From: neeraj.upadhyay@kernel.org
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	paulmck@kernel.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	neeraj.upadhyay@kernel.org,
	tglx@linutronix.de
Subject: [PATCH v2 2/3] locking/csd_lock: Provide an indication of ongoing CSD-lock stall
Date: Mon, 22 Jul 2024 19:07:34 +0530
Message-Id: <20240722133735.667161-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240722133559.GA667117@neeraj.linux>
References: <20240722133559.GA667117@neeraj.linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

If a CSD-lock stall goes on long enough, it will cause an RCU CPU
stall warning.  This additional warning provides much additional
console-log traffic and little additional information.  Therefore,
provide a new csd_lock_is_stuck() function that returns true if there
is an ongoing CSD-lock stall.  This function will be used by the RCU
CPU stall warnings to provide a one-line indication of the stall when
this function returns true.

[ neeraj.upadhyay: Apply Rik van Riel feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Imran Khan <imran.f.khan@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 include/linux/smp.h |  6 ++++++
 kernel/smp.c        | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index fcd61dfe2af3..3871bd32018f 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -294,4 +294,10 @@ int smpcfd_prepare_cpu(unsigned int cpu);
 int smpcfd_dead_cpu(unsigned int cpu);
 int smpcfd_dying_cpu(unsigned int cpu);
 
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+bool csd_lock_is_stuck(void);
+#else
+static inline bool csd_lock_is_stuck(void) { return false; }
+#endif
+
 #endif /* __LINUX_SMP_H */
diff --git a/kernel/smp.c b/kernel/smp.c
index 81f7083a53e2..9385cc05de53 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -207,6 +207,19 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
 	return -1;
 }
 
+static atomic_t n_csd_lock_stuck;
+
+/**
+ * csd_lock_is_stuck - Has a CSD-lock acquisition been stuck too long?
+ *
+ * Returns @true if a CSD-lock acquisition is stuck and has been stuck
+ * long enough for a "non-responsive CSD lock" message to be printed.
+ */
+bool csd_lock_is_stuck(void)
+{
+	return !!atomic_read(&n_csd_lock_stuck);
+}
+
 /*
  * Complain if too much time spent waiting.  Note that only
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
@@ -228,6 +241,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		cpu = csd_lock_wait_getcpu(csd);
 		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
 			 *bug_id, raw_smp_processor_id(), cpu);
+		atomic_dec(&n_csd_lock_stuck);
 		return true;
 	}
 
@@ -251,6 +265,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
 		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
 		 cpu, csd->func, csd->info);
+	if (firsttime)
+		atomic_inc(&n_csd_lock_stuck);
 	/*
 	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
 	 * to become unstuck. Use a signed comparison to avoid triggering
-- 
2.40.1


