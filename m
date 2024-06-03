Return-Path: <linux-kernel+bounces-199834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F918FA67B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD67A28AE5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90551411DA;
	Mon,  3 Jun 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ky2BsJyO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAsX5JrJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7A83CD6;
	Mon,  3 Jun 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457104; cv=none; b=duDPlXUZ06oOKIQsCKTvh2rKzH06JkIZfPq0eJW1apnSvfgceb9iRm2g7Oc1/GagUTcz2k/wEZDwTISIqTvUuk3/HGuP1OdcXvHOJ0IfbjTTUbwBtB66uK/sgcET0g2DfEU9WM6Ul/T53IcWbe1Hor3VMC93a8aDi2LdVChCXkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457104; c=relaxed/simple;
	bh=bcxSj8Z9J7RmjktPYNIzMOPv60DtDpqqHz/KdcZ02yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rx55/JZzPvg1zk/jKsnMaNhOI84ULGZyv0oRFRu3PiSnHD+V1pcq5aF/yTOZdwdr1I2jqhQ5wAIrshrDfYScXJM/7nWVQxMdQOxJggoIssXgtTqg6ZBxCehamIHVvdi6DMA2WXiE05rtn5zTcPLAI8LBTHKnPvdLOcB4YDFrhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ky2BsJyO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAsX5JrJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wwQIXYMP7sQGXrKm7reS+lNLiSQvf56nu+6ghCbaPM=;
	b=ky2BsJyOWTW4ECgcrsvSmWLnUuYxVlhQ+1oRAjl+tjYaSaOh8ukRpiHlAuM0/D4B6Vb5St
	JKxQj/MejhjrKoH5qAzGJBsPBl9DcLWniFPJgxVvPcQ82OL/RbI7lA6p64K50B8r1pBlKe
	9cvZSaJP2uHGNiPfq/iWt9Av9Hlp53uwgh243lhEvZ7WoC3GbUoG4AgMigvIB81nEovH2o
	8SPDIazcfijqohs7ZpRkdayi2UPMwpOQnu+FRaralEEUNUbtY0fwM186GKDG6tClv6kkcD
	J5M23o1Iur+hFgT47yba+Etdouf6y5yzeoEue40mAR4+sI9JQGdEQ83axpHhLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wwQIXYMP7sQGXrKm7reS+lNLiSQvf56nu+6ghCbaPM=;
	b=zAsX5JrJWtbhPiqDA7nRFKV+o2E3nQHOqXddS44mXB16BTP0VwYTpdHV/x1c10ZiKyJVe2
	lMDKAajg8wmpMiCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH printk v2 16/18] printk: Provide threadprintk boot argument
Date: Tue,  4 Jun 2024 01:30:51 +0206
Message-Id: <20240603232453.33992-17-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For PREEMPT_RT, legacy console printing is performed in a dedicated
kthread. However, this behavior can also be interesting for other
preemption models as it minimizes the duration of printk() calls by
deferring all printing.

Provide a new boot argument "threadprintk" that will create the
dedicated kthread for legacy console printing for !PREEMPT_RT
systems.

The implementation is the same as the "threadirqs" boot argument.

Users should be aware that if this option is enabled, the shutdown,
reboot, and panic messages probably will not be visible on the
legacy consoles.

Non-legacy consoles (NBCON) already have their own dedicated kernel
threads for printing and reliable shutdown, reboot, and panic
printing. This option really only applies to legacy consoles.

Users can view /proc/consoles to see if their console driver is
legacy or not. NBCON console drivers are shown with 'N'.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 kernel/printk/internal.h                        |  4 +++-
 kernel/printk/printk.c                          | 11 +++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 45d95614ec44..17977dd4fafa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6572,6 +6572,18 @@
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
+	threadprintk	[KNL]
+			Force threaded printing of all legacy consoles. Be
+			aware that with this option, the shutdown, reboot, and
+			panic messages may not be printed on the legacy
+			consoles. Also, earlycon/earlyprintk printing will be
+			delayed until a regular console or the kthread is
+			available.
+
+			Users can view /proc/consoles to see if their console
+			driver is legacy or not. Non-legacy (NBCON) console
+			drivers are already threaded and are shown with 'N'.
+
 	topology=	[S390,EARLY]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index b66dfa865591..48c3564f95eb 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -3,6 +3,7 @@
  * internal.h - printk internal definitions
  */
 #include <linux/console.h>
+#include <linux/jump_label.h>
 #include <linux/percpu.h>
 #include <linux/types.h>
 
@@ -24,7 +25,8 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 #ifdef CONFIG_PREEMPT_RT
 # define force_printkthreads()		(true)
 #else
-# define force_printkthreads()		(false)
+DECLARE_STATIC_KEY_FALSE(force_printkthreads_key);
+# define force_printkthreads()		(static_branch_unlikely(&force_printkthreads_key))
 #endif
 
 #ifdef CONFIG_PRINTK
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1c63fd0c1166..ea2d66152256 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -195,6 +195,17 @@ static int __init control_devkmsg(char *str)
 }
 __setup("printk.devkmsg=", control_devkmsg);
 
+#if !defined(CONFIG_PREEMPT_RT)
+DEFINE_STATIC_KEY_FALSE(force_printkthreads_key);
+
+static int __init setup_forced_printkthreads(char *arg)
+{
+	static_branch_enable(&force_printkthreads_key);
+	return 0;
+}
+early_param("threadprintk", setup_forced_printkthreads);
+#endif
+
 char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
-- 
2.39.2


