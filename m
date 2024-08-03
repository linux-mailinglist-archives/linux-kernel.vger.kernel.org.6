Return-Path: <linux-kernel+bounces-273390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B4E9468AE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2E81C20CB7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 08:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4114D435;
	Sat,  3 Aug 2024 08:17:23 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D093398A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 08:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722673042; cv=none; b=rBOr9F81HcjBgqRHgUqrvXf5FHVJXcc20GzLZxncnaxz06TNoDPz/fggZvcsXAymaNu6D+qJq+kIvHg8mKmWUDTqnT8P76L5zfhe170KdI4IQ8bFUZ/5T8Acn1mCkpC5WQSlTH1y0Xblq+4I0cJfdEXk6F3/kIBDqkZH1fb2z1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722673042; c=relaxed/simple;
	bh=Okt4th+dunwgJoAjm5jlmafvU1m2Lva9o6MtCMyGnGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwLzy1NTEMazXMc+u8O2vFZAgt9xyca1onYWtOomrE5Owr73O3KBMMMKg3AecSPVTVXQstAmmXPwhssCkYI/v8AqN+06DPRrpPFWc0prCbSdBDeN6V1+EGhgb5pPzUgWs7iRf2w0DwgbWtNOedO4vg7CmDXGfQJwkElFXasJ/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 58228A9D82;
	Sat,  3 Aug 2024 17:17:18 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEIIqc0BZppC; Sat,  3 Aug 2024 17:17:18 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id 1174DA9D63;
	Sat,  3 Aug 2024 17:17:18 +0900 (JST)
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
Subject: [PATCH v2 2/2] Allow cpu backtraces to be written into ringbuffer during panic
Date: Sat,  3 Aug 2024 17:16:49 +0900
Message-Id: <20240803081649.224627-1-takakura@valinux.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240803080444.221427-1-takakura@valinux.co.jp>
References: <20240803080444.221427-1-takakura@valinux.co.jp>
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
---
 include/linux/panic.h  | 1 +
 kernel/panic.c         | 5 +++++
 kernel/printk/printk.c | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6717b15e7..556b4e2ad 100644
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
index f94923a63..d7ed93567 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -63,6 +63,8 @@ unsigned long panic_on_taint;
 bool panic_on_taint_nousertaint = false;
 static unsigned int warn_limit __read_mostly;
 
+bool panic_triggering_all_cpu_backtrace;
+
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
 
@@ -253,7 +255,10 @@ void check_panic_on_warn(const char *origin)
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
 	if (panic_print & PANIC_PRINT_ALL_CPU_BT) {
+		/* Temporary allow non-panic CPUs to write their backtraces. */
+		panic_triggering_all_cpu_backtrace = true;
 		trigger_all_cpu_backtrace();
+		panic_triggering_all_cpu_backtrace = false;
 		console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 	}
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d0bff0b0a..fa2580dd3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2354,7 +2354,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	 * non-panic CPUs are generating any messages, they will be
 	 * silently dropped.
 	 */
-	if (other_cpu_in_panic())
+	if (other_cpu_in_panic() && !panic_triggering_all_cpu_backtrace)
 		return 0;
 
 	if (level == LOGLEVEL_SCHED) {
-- 
2.34.1


