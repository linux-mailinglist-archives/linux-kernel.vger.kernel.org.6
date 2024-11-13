Return-Path: <linux-kernel+bounces-407768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2F9C736F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BE41F24DC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6F1F9ABD;
	Wed, 13 Nov 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VCzomGeh"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA31F4707
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507814; cv=none; b=MHvrxntVUneZI9rWsKRKyfQL2eWz0dRNwkE9Hih5zNMH0Kv6GTedibw25cPNjR7lCGtFDlVcjA1uNpzuSPxcCCx0vwV6tXjDrmZiq5bzy8+NyEkE6dvwRJkmkebtwN3trhFGQmSSLxSRxIKf0ifNWjk3575VIy14ztEmHZ9OCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507814; c=relaxed/simple;
	bh=dM7gZIp0Jt4C7WbO+DSuv6HKhD6xrvWkUpSiJpd/52I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kw7sjbavbu8TwWDwRH/p9Fz6rNIF0M7/7Y7CdjA8nR+brm5gC5yG+7AiKuCW1TfaCrXgwFfA8dWtERmuJ7Ew5mbdR9mMyzQIw6imnUB+PGL/dp+CsKxiiU3a6M2OP733CRveT9/2i7USkbL/ZvsuN3TO9jpyDpKYIR4r0VuvJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=VCzomGeh; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1814:0:640:37e9:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E87E4611F2;
	Wed, 13 Nov 2024 17:23:20 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown [2a02:6bf:8011:701:66e1:20a5:ba04:640b])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 2NMoFA5MoKo0-55Ga1JFA;
	Wed, 13 Nov 2024 17:23:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1731507800;
	bh=fViT825u906z3GmUzn3FWp/g1F9pjRQ7m1gbc1ELkSU=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=VCzomGeh5EMxnQvb10isJFLDCq1DYcmzQrri+/HCAFOpgEuURebHULw5ppvG6pRhk
	 vuV2OkOBvm9jjCN4IqnKhEYW67PLHit9bFv84JYdxbPwy6FYBdqKNkq7TBuRYJ6lhl
	 Xqq/lJqqWTAkU/qaLdjKHdJ2VkE9B8aHu2+8ooY8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
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
Subject: [PATCH RESEND v3] x86/split_lock: fix delayed detection enabling
Date: Wed, 13 Nov 2024 17:23:01 +0300
Message-Id: <20241113142301.704057-1-davydov-max@yandex-team.ru>
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


