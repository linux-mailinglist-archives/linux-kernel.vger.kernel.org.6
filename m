Return-Path: <linux-kernel+bounces-397188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CACE9BD7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFA6284015
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A3C215F4C;
	Tue,  5 Nov 2024 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4qwKwd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F11802AB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843346; cv=none; b=kfdYeCd9HlHLc+CqlW+MDjJjd5/8rF0JlSI695GuZd9jYRoX2HSmtDde7L/buYRXJxcZUCMMDNQbqvVT9X2cfGYFl5Cthe7Rfv3X4LcquAe3fED7zePaASpwNqzsssVL0H3AW2wMwdhs9vM2lofFON7xcnUK5wNIRFFRksP0Q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843346; c=relaxed/simple;
	bh=gqleNOsl+VNeYX3SpJsFnUI/2zaqR394U+8Yf7uik6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j71jrXnC6oNXWN+qWGtf2BKi1zcc+eGv40d10tpKTJcxgHePvbSu+rzDKgNc46CBq3DSvuFuccC3a5yDVHIrFkGsxq0HBEUzehCYQn6Is9X+mgpWOuy4XCsWgp6+x8svYktB/NHYdjjFPft3W0eYEdNRS8Zv97uxSl6U0vPQSzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4qwKwd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16BCC4CED3;
	Tue,  5 Nov 2024 21:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730843345;
	bh=gqleNOsl+VNeYX3SpJsFnUI/2zaqR394U+8Yf7uik6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4qwKwd2Xqna7JiI7Ni+aVsT89CTis1YuthIXZd1SW30b8xIA/3GINNdIjekZTvev
	 dPjAGBhgJ0zzNsLOm54i8odQmcsGowi9AhNMWPLn7A3jdWIyr90LGJLVJ320Uxzaow
	 9zCDFzIvjEYuGTa2GVCIhCfSNGdW4xBu2X6oqDBG82mxHckyKIM2VmwePdcDfQKycw
	 feoALJMYuLJw4rXcPZWi/vnBnd8WOQIUBZ8126O9bvzeqE9ehXFkPtWvIstn/4UVxT
	 B3iC2WhqENDVXAsGslJ7oqnoHYS0+tf2OsWz9ePX8MvcQqzygCD89Ae6sOcpjRou/x
	 pIyp7O04beY4A==
Date: Tue, 5 Nov 2024 11:49:04 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH sched_ext/for-6.13 2/2] sched_ext: Enable the ops breather
 and eject BPF scheduler on softlockup
Message-ID: <ZyqS0GP9h2hG2lvC@slm.duckdns.org>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>

On 2 x Intel Sapphire Rapids machines with 224 logical CPUs, a poorly
behaving BPF scheduler can live-lock the system by making multiple CPUs bang
on the same DSQ to the point where soft-lockup detection triggers before
SCX's own watchdog can take action. It also seems possible that the machine
can be live-locked enough to prevent scx_ops_helper, which is an RT task,
from running in a timely manner.

Implement scx_softlockup() which is called when three quarters of
soft-lockup threshold has passed. The function immediately enables the ops
breather and triggers an ops error to initiate ejection of the BPF
scheduler.

The previous and this patch combined enable the kernel to reliably recover
the system from live-lock conditions that can be triggered by a poorly
behaving BPF scheduler on Intel dual socket systems.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/sched/ext.h         |    2 +
 kernel/sched/ext.c                |   45 ++++++++++++++++++++++++++++++++++++++
 kernel/watchdog.c                 |    8 ++++++
 tools/sched_ext/scx_show_state.py |    2 +
 4 files changed, 57 insertions(+)

--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -205,11 +205,13 @@ struct sched_ext_entity {
 
 void sched_ext_free(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
+void scx_softlockup(u32 dur_s);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
 static inline void sched_ext_free(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
+static inline void scx_softlockup(u32 dur_s) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 #endif	/* _LINUX_SCHED_EXT_H */
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -867,6 +867,7 @@ static DEFINE_MUTEX(scx_ops_enable_mutex
 DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
+static unsigned long scx_in_softlockup;
 static atomic_t scx_ops_breather_depth = ATOMIC_INIT(0);
 static int scx_ops_bypass_depth;
 static bool scx_ops_init_task_enabled;
@@ -4556,6 +4557,49 @@ bool task_should_scx(struct task_struct
 }
 
 /**
+ * scx_softlockup - sched_ext softlockup handler
+ *
+ * On some multi-socket setups (e.g. 2x Intel 8480c), the BPF scheduler can
+ * live-lock the system by making many CPUs target the same DSQ to the point
+ * where soft-lockup detection triggers. This function is called from
+ * soft-lockup watchdog when the triggering point is close and tries to unjam
+ * the system by enabling the breather and aborting the BPF scheduler.
+ */
+void scx_softlockup(u32 dur_s)
+{
+	switch (scx_ops_enable_state()) {
+	case SCX_OPS_ENABLING:
+	case SCX_OPS_ENABLED:
+		break;
+	default:
+		return;
+	}
+
+	/* allow only one instance, cleared at the end of scx_ops_bypass() */
+	if (test_and_set_bit(0, &scx_in_softlockup))
+		return;
+
+	printk_deferred(KERN_ERR "sched_ext: Soft lockup - CPU%d stuck for %us, disabling \"%s\"\n",
+			smp_processor_id(), dur_s, scx_ops.name);
+
+	/*
+	 * Some CPUs may be trapped in the dispatch paths. Enable breather
+	 * immediately; otherwise, we might even be able to get to
+	 * scx_ops_bypass().
+	 */
+	atomic_inc(&scx_ops_breather_depth);
+
+	scx_ops_error("soft lockup - CPU#%d stuck for %us",
+		      smp_processor_id(), dur_s);
+}
+
+static void scx_clear_softlockup(void)
+{
+	if (test_and_clear_bit(0, &scx_in_softlockup))
+		atomic_dec(&scx_ops_breather_depth);
+}
+
+/**
  * scx_ops_bypass - [Un]bypass scx_ops and guarantee forward progress
  *
  * Bypassing guarantees that all runnable tasks make forward progress without
@@ -4665,6 +4709,7 @@ static void scx_ops_bypass(bool bypass)
 	atomic_dec(&scx_ops_breather_depth);
 unlock:
 	raw_spin_unlock_irqrestore(&bypass_lock, flags);
+	scx_clear_softlockup();
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -644,6 +644,14 @@ static int is_softlockup(unsigned long t
 		    need_counting_irqs())
 			start_counting_irqs();
 
+		/*
+		 * A poorly behaving BPF scheduler can live-lock the system into
+		 * soft lockups. Tell sched_ext to try ejecting the BPF
+		 * scheduler when close to a soft lockup.
+		 */
+		if (time_after_eq(now, period_ts + get_softlockup_thresh() * 3 / 4))
+			scx_softlockup(now - touch_ts);
+
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
--- a/tools/sched_ext/scx_show_state.py
+++ b/tools/sched_ext/scx_show_state.py
@@ -35,6 +35,8 @@ print(f'enabled       : {read_static_key
 print(f'switching_all : {read_int("scx_switching_all")}')
 print(f'switched_all  : {read_static_key("__scx_switched_all")}')
 print(f'enable_state  : {ops_state_str(enable_state)} ({enable_state})')
+print(f'in_softlockup : {prog["scx_in_softlockup"].value_()}')
+print(f'breather_depth: {read_atomic("scx_ops_breather_depth")}')
 print(f'bypass_depth  : {prog["scx_ops_bypass_depth"].value_()}')
 print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
 print(f'enable_seq    : {read_atomic("scx_enable_seq")}')

