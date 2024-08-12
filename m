Return-Path: <linux-kernel+bounces-282712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DA094E7C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7164282BDC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C991581FC;
	Mon, 12 Aug 2024 07:27:42 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DF15098A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447662; cv=none; b=hc7OQ3RqWGISuWUBbozSxcVFifwFB6W0Hv+xJ5XiB+NB0C+ioJO2KU+j/qxytFiqksWT9n3DHCFZhL7Pj8qZC1/hIiA5GivCQDd9osuhxvcPbGCFXMH4yLa7K66tJiaxPqBzLzpJm8p/TUEu70dlCzJmdCpTGeL9jwI7xI2X9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447662; c=relaxed/simple;
	bh=80BpKBUj/6IL2a36Mynw3AbqPtC9KyrQGFqkt56TbeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bL4IPJvLcIlvrdIxiA3HNWHZu9X2CjHBWewnknHAkv5c1nokbmSnKzpl+X9KgZe+MP26rlrAHQEh9DaYmrLrtv8X7EVLRFlK50XPoccSmunZhk35Mm46uQFHgCqLLhZ7A7KKsmiu6VfGJlIOKExgiEEHq0Vq86/3IowPftrTlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 2D489A9E3D;
	Mon, 12 Aug 2024 16:27:38 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id exf96Y1OiL57; Mon, 12 Aug 2024 16:27:38 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id DAE6FA9E38;
	Mon, 12 Aug 2024 16:27:37 +0900 (JST)
From: takakura@valinux.co.jp
To: pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	lukas@wunner.de,
	wangkefeng.wang@huawei.com,
	ubizjak@gmail.com,
	feng.tang@intel.com,
	j.granados@samsung.com,
	stephen.s.brennan@oracle.com
Cc: linux-kernel@vger.kernel.org,
	nishimura@valinux.co.jp,
	taka@valinux.co.jp,
	Ryo Takakura <takakura@valinux.co.jp>
Subject: [PATCH v3 1/2] Allow cpu backtraces to be written into ringbuffer during panic
Date: Mon, 12 Aug 2024 16:27:03 +0900
Message-Id: <20240812072703.339690-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812072137.339644-1-takakura@valinux.co.jp>
References: <20240812072137.339644-1-takakura@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <takakura@valinux.co.jp>

commit 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing
to ringbuffer") disabled non-panic CPUs to further write messages to
ringbuffer after panicked.

Since the commit, non-panicked CPU's are not allowed to write to
ring buffer after panicked and CPU backtrace which is triggered
after panicked to sample non-panicked CPUs' backtrace no longer
serves its function as it has nothing to print.

Fix the issue by allowing non-panicked CPUs to write into ringbuffer
while CPU backtrace is in flight.

Fixes: 779dbc2e78d7 ("printk: Avoid non-panic CPUs writing to ringbuffer")
Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/panic.h  | 1 +
 kernel/panic.c         | 8 +++++++-
 kernel/printk/printk.c | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 3130e0b51..54d90b6c5 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -16,6 +16,7 @@ extern void oops_enter(void);
 extern void oops_exit(void);
 extern bool oops_may_print(void);
 
+extern bool panic_triggering_all_cpu_backtrace;
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
diff --git a/kernel/panic.c b/kernel/panic.c
index f861bedc1..2a0449144 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -64,6 +64,8 @@ unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
 static unsigned int warn_limit __read_mostly;
 
+bool panic_triggering_all_cpu_backtrace;
+
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
@@ -253,8 +255,12 @@ void check_panic_on_warn(const char *origin)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
+	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
+		/* Temporary allow non-panic CPUs to write their backtraces. */
+		panic_triggering_all_cpu_backtrace = true;
 		trigger_all_cpu_backtrace();
+		panic_triggering_all_cpu_backtrace = false;
+	}
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 054c0e778..c22b07049 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2316,7 +2316,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic())
+	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.34.1


