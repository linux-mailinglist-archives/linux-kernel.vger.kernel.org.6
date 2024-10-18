Return-Path: <linux-kernel+bounces-371366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4719A3A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A043BB26E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55F1F472C;
	Fri, 18 Oct 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="JNVGR+5B"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC8192B86
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244119; cv=none; b=e4fVtdMpRVlvGQomdc8Ge4YVpYzlrD49Hk2GWFT1DqVrrtiQYlQoi9gw/5DFneEl1c1qgXFF0+7uJ7Wbut2jjABovobBN3KR2UJzQI2LEIm6RQXHmDXTWtjIg3o/bb1Fp+Wsf4sds0JpnPFZLYLrUjgonf4CiMRenE5a9W0x69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244119; c=relaxed/simple;
	bh=dM7gZIp0Jt4C7WbO+DSuv6HKhD6xrvWkUpSiJpd/52I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ojHFcLDh3nq0qOiJIb+QaVmFKpdeAlGJgXUNng0621ESZAiRXU9MdS9b/0/YpKCEl9h46D9PUypoAvhMcIJ4D/VC8PPlWcuv9L+wMN2M+Rcb9Mhcg62F+JAcdK9ZsgcyT0m+fEQLPdXxozyFePWUvIJrchK/zYaDfm/QAGvagyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=JNVGR+5B; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f69e:0:640:3ef4:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BB3C060D6C;
	Fri, 18 Oct 2024 12:33:55 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown [2a02:6bf:8011:701:66e1:20a5:ba04:640b])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gXKVci3IYiE0-LhaHrjrg;
	Fri, 18 Oct 2024 12:33:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1729244034;
	bh=fViT825u906z3GmUzn3FWp/g1F9pjRQ7m1gbc1ELkSU=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=JNVGR+5BT9eSFcK/HBJyxatWXlIWcFGsHMp2DvIjBZJ+n8JvSOgnfFlL2ohU7ginw
	 lvao7KgOmqd2z4LME+zk9dowAX6+BN78ZItmdmxmvz6EvhU7RSCHNuk0fBETipwDrn
	 9usZF9Jz44hOIgiWHwVFNJdqjBxnQm2d2Qyv4yNM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Maksim Davydov <davydov-max@yandex-team.ru>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: den-plotnikov@yandex-team.ru,
	gpiccoli@igalia.com,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	Maksim Davydov <davydov-max@yandex-team.ru>
Subject: [PATCH v3] x86/split_lock: fix delayed detection enabling
Date: Fri, 18 Oct 2024 12:33:13 +0300
Message-Id: <20241018093313.532447-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

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

v3 -> v2:
* place and time of the per-CPU structure initialization were changed.
  initcall doesn't seem to be a good place for it, so deferred
  initialization is used.

Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 arch/x86/kernel/cpu/intel.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e7656cbef68d..b288ef4f1ad0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1071,7 +1071,13 @@ static void __split_lock_reenable(struct work_struct *work)
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
 
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
@@ -1092,7 +1098,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work;
+	struct delayed_work *work = NULL;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -1114,11 +1120,17 @@ static void split_lock_warn(unsigned long ip)
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
 		work = &sl_reenable_unlock;
-	} else {
-		work = &sl_reenable;
 	}
 
 	cpu = get_cpu();
+
+	if (!work) {
+		work = this_cpu_ptr(&sl_reenable);
+		/* Deferred initialization of per-CPU struct */
+		if (!work->work.func)
+			INIT_DELAYED_WORK(work, __split_lock_reenable);
+	}
+
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
-- 
2.34.1


