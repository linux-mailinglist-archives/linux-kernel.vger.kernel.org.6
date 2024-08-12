Return-Path: <linux-kernel+bounces-282715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD694E7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6D1F23CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609E1586CD;
	Mon, 12 Aug 2024 07:30:04 +0000 (UTC)
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2115854C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.128.90.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447804; cv=none; b=JeK7s8tw9ykFHB8Y2pLkXO2zYF1/m5QIrgLXER9l0qQZtt5cFo97q4Z61a1Q0FKD0yYzRujK9hsms11ocPY6GpJDmHlNKNJDD1pctnTyTZ7YDmK5b80eLVfVBv5/R2q7vSfV3F3KeKoJM/9EjqvtY8ED872zcMyucsz3lcG5XUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447804; c=relaxed/simple;
	bh=E7S2VAvUA4wixOtL/CY8u6xDZ4zL9QmT30ykqGOY8MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kkw7xkbLdJRsVWjykIcnbUDaxGQjcUqaLMWR9vm6cIQWFhlQM+xTtK3MMQNyKfTZUC2vpb1AR/NKWTM/NH3lmJwRxrrxlL7Q6athMBV3J0xcTzllokotzof/5GK6Y+yWE4vYTj22ETuL4gED4Eq1fzMY2kzfMJNVaFFaj1LpOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; arc=none smtp.client-ip=210.128.90.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Received: from localhost (localhost [127.0.0.1])
	by mail.valinux.co.jp (Postfix) with ESMTP id 16337A9E3D;
	Mon, 12 Aug 2024 16:30:01 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
	by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vm01jyLsZTxJ; Mon, 12 Aug 2024 16:30:00 +0900 (JST)
Received: from localhost.localdomain (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp [153.220.101.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.valinux.co.jp (Postfix) with ESMTPSA id C1E95A9E38;
	Mon, 12 Aug 2024 16:30:00 +0900 (JST)
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
Subject: [PATCH v3 2/2] Handle flushing of CPU backtraces during panic
Date: Mon, 12 Aug 2024 16:29:31 +0900
Message-Id: <20240812072931.339735-1-takakura@valinux.co.jp>
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

After panic, non-panicked CPU's has been unable to flush ringbuffer
while they can still write into it. This can affect CPU backtrace
triggered in panic only able to write into ringbuffer incapable of
flushing them.

Fix the issue by letting the panicked CPU handle the flushing of
ringbuffer right after non-panicked CPUs finished writing their
backtraces.

Signed-off-by: Ryo Takakura <takakura@valinux.co.jp>
---
 include/linux/console.h |  1 +
 kernel/panic.c          |  1 +
 kernel/printk/printk.c  | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 31a8f5b85..c7eb6f785 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -504,6 +504,7 @@ extern void console_unlock(void);
 extern void console_conditional_schedule(void);
 extern void console_unblank(void);
 extern void console_flush_on_panic(enum con_flush_mode mode);
+extern void console_try_flush(void);
 extern struct tty_driver *console_device(int *);
 extern void console_stop(struct console *);
 extern void console_start(struct console *);
diff --git a/kernel/panic.c b/kernel/panic.c
index 2a0449144..6519cc6bd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -260,6 +260,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		panic_triggering_all_cpu_backtrace = true;
 		trigger_all_cpu_backtrace();
 		panic_triggering_all_cpu_backtrace = false;
+		console_try_flush();
 	}
 
 	/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c22b07049..517b8b02e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3284,6 +3284,20 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	console_flush_all(false, &next_seq, &handover);
 }
 
+/**
+ * console_try_flush - try to flush consoles when safe
+ *
+ * Context: Any, except for NMI.
+ */
+void console_try_flush(void)
+{
+	if (is_printk_legacy_deferred())
+		return;
+
+	if (console_trylock())
+		console_unlock();
+}
+
 /*
  * Return the console tty driver structure and its associated index
  */
-- 
2.34.1


