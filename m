Return-Path: <linux-kernel+bounces-566369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008CBA676ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C646A16F2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF320F092;
	Tue, 18 Mar 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YuF7dT2E"
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A4820E6FC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309511; cv=none; b=Nu9kujOon+HgEx8cuJc81Ce/FoybYbxIWuKeuo2ddA332yt/tD/30uREsiYi+/8QN5e7LCaKqIZjKJwhsnjenn3Ec0ZMTwTBbOoiGylvdc/B2nHThgAGAI+uEc+0PLBQxrV072+ZqAkqNwS8kySp2MXmdpnZwQvlK8OmkvmcF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309511; c=relaxed/simple;
	bh=PTwboqiO2Ryf/kIoVPpizaXYYtdcV4ShPS7w7yx8kbU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Of9wKBrUApFQS+tNYdOkRKBcTv9vLIXahmwUnBKcCQbg9h9bZqCCTpjTgrT/fK7eoDnX/5fsKyr1SeYuRFb/l6pyCSZDCcO7HWqgE6huPf+ihwCaKPtYqwDiflN4+RbJvTvbTeAz0OANfXZNHb8M2qwpr5qbfYFfRQtPSuBUGzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=YuF7dT2E; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a19b:0:640:7c13:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id ABFD4610F4;
	Tue, 18 Mar 2025 17:49:28 +0300 (MSK)
Received: from davydov-max-lin.yandex-team.ru (unknown [2a02:6b8:b081:b407::1:6])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id DnJ6t73FTOs0-DwITw8pz;
	Tue, 18 Mar 2025 17:49:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1742309368;
	bh=1st08C0MmAzmZ5dxXArk0+G2EPIbpRvV5Pu4I7LVrg0=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=YuF7dT2EUUIxMGm670ao59TEoqxc2g++Nxf1ai9R72KK2ZnAFhs2G8nxJKY9/1kXx
	 +FeN/t78zwQR5FmMkJn4mwppvX0Cg59l+572kAJ3L4TcmzKaZDkbrm0W8lS7NlvyNR
	 G0lpnFlJbx7eqZ3Tdgwe14TQaNaLBhNZH1PZeRwk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: davydov-max@yandex-team.ru,
	den-plotnikov@yandex-team.ru,
	gpiccoli@igalia.com,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	hpa@zytor.com
Subject: [PATCH v5] x86/split_lock: fix delayed detection enabling
Date: Tue, 18 Mar 2025 17:49:11 +0300
Message-Id: <20250318144911.10455-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the warn mode with disabled mitigation mode is used, then on each
CPU where the split lock occurred detection will be disabled in order to
make progress and delayed work will be scheduled, which then will enable
detection back. Now it turns out that all CPUs use one global delayed
work structure. This leads to the fact that if a split lock occurs on
several CPUs at the same time (within 2 jiffies), only one CPU will
schedule delayed work, but the rest will not. The return value of
schedule_delayed_work_on() would have shown this, but it is not checked
in the code.

A diagram that can help to understand the bug reproduction:
https://lore.kernel.org/all/2cd54041-253b-4e78-b8ea-dbe9b884ff9b@yandex-team.ru/

In order to fix the warn mode with disabled mitigation mode, delayed work
has to be a per-CPU.

v5 -> v4:
* using pure_initcall for per-CPU structure initialization instead of
  deferred initialization

v4 -> v3:
* rebased the patch onto the latest master

v3 -> v2:
* place and time of the per-CPU structure initialization were changed.
  initcall doesn't seem to be a good place for it, so deferred
  initialization is used.

Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 arch/x86/kernel/cpu/bus_lock.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 6cba85c79d42..1a8112dba37a 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -192,7 +192,32 @@ static void __split_lock_reenable(struct work_struct *work)
 {
 	sld_update_msr(true);
 }
-static DECLARE_DELAYED_WORK(sl_reenable, __split_lock_reenable);
+/*
+ * In order for each CPU to schedule itself delayed work independently of the
+ * others, delayed work struct should be per-CPU. This is not required when
+ * sysctl_sld_mitigate is enabled because of the semaphore, that limits
+ * the number of simultaneously scheduled delayed works to 1.
+ */
+static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
+
+/*
+ * Per-CPU delayed_work can't be statically initialized properly because
+ * the struct address is unknown. Thus per-CPU delayed_work structures
+ * have to be initialized during kernel initialization.
+ */
+static int __init setup_split_lock_delayed_work(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct delayed_work *work = per_cpu_ptr(&sl_reenable, cpu);
+
+		INIT_DELAYED_WORK(work, __split_lock_reenable);
+	}
+
+	return 0;
+}
+pure_initcall(setup_split_lock_delayed_work);
 
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
@@ -215,13 +240,14 @@ static void split_lock_warn(unsigned long ip)
 {
 	struct delayed_work *work;
 	int cpu;
+	unsigned int saved_sld_mitigate = READ_ONCE(sysctl_sld_mitigate);
 
 	if (!current->reported_split_lock)
 		pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
 				    current->comm, current->pid, ip);
 	current->reported_split_lock = 1;
 
-	if (sysctl_sld_mitigate) {
+	if (saved_sld_mitigate) {
 		/*
 		 * misery factor #1:
 		 * sleep 10ms before trying to execute split lock.
@@ -234,12 +260,11 @@ static void split_lock_warn(unsigned long ip)
 		 */
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
-		work = &sl_reenable_unlock;
-	} else {
-		work = &sl_reenable;
 	}
 
 	cpu = get_cpu();
+	work = (saved_sld_mitigate ?
+		&sl_reenable_unlock : per_cpu_ptr(&sl_reenable, cpu));
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
-- 
2.34.1


