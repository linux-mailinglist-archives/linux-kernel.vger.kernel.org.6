Return-Path: <linux-kernel+bounces-574962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6127DA6EC05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3112E3B23DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34621A5B8B;
	Tue, 25 Mar 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="B017g4Fs"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D281B4234
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893127; cv=none; b=MWoU+2tIcb7lSZAsfAVN4lVsI1f4eYF672H1xh0ekRtQMS7/8Vb/QnvQ5Y9S8geQbkP7VPwU/+IUgI8QcJLPdsIJadcyzzTkJoT8v1LGei1FHGShfO+UIH9fQ5WfBt+P338j5qLxJ8Kiyf7rTvC6RgwPCekEjfI/eX6qlTz9mXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893127; c=relaxed/simple;
	bh=XLZsWhb3EDYAD6Y0tQ+TuJiSLRze9fS4VXBSVbXqQ7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YA1qYjvT7TJSn4rHs9B3VYn22o1jt9eiIvrwm/8E+zLu9aUmFcMKN21HnBwJkNLQvuJA3GRhTDDMgDR2UfxFzGjeQAmVftNcbj/FZpvJqkYauFqBmji3PF2zj0f0I6dLdlJ4KdVBjobuJAv6/PqBpZ3hbYKm1sdIXlQzSfS7/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=B017g4Fs; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id AAA2660E1F;
	Tue, 25 Mar 2025 11:58:33 +0300 (MSK)
Received: from davydov-max-lin.yandex.net (unknown [2a02:6bf:8011:f00:9e4b:6d51:21c:fd30])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id FwKqQi2FfiE0-vtYjJ33n;
	Tue, 25 Mar 2025 11:58:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1742893113;
	bh=0a/27Xi2n7arAJi4CM7IVxVuTgO4OA180Lb08vAUT94=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=B017g4Fs/iLltKXkpq0REoP/FalP2QqURt1w3g2X5pSO5McJxt8OQDsGVVg5j0eys
	 aM1Gg2xUYIwx70IpW+J7sD373RmW/x/DYpx/XdF9Qk8tOu4TX5oMKgFJv7PjNRgsK4
	 DcLU2hYIkRMoExbh6k3iA0U0EQF7Mb1ChdmBiPP8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
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
Subject: [PATCH] x86/split_lock: simplify reenabling
Date: Tue, 25 Mar 2025 11:58:07 +0300
Message-Id: <20250325085807.171885-1-davydov-max@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When split_lock_mitigate is disabled each CPU needs its own delayed_work
structure. They are used to reenable split lock detection after its
disabling. But delayed_work structure must be correctly initialized after
its allocation. Current implementation uses deferred initialization that
makes the split lock handler code unclear. So the code can be simplified
if the initialization is moved to the appropriate initcall. sld_setup()
is called before setup_per_cpu_areas(), thus it can't be used for this
purpose. Another way is to implement independent initcall for the
initialization, that's what has been done.

Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 arch/x86/kernel/cpu/bus_lock.c | 36 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 97222efb4d2a..5149e3874c92 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -200,6 +200,26 @@ static void __split_lock_reenable(struct work_struct *work)
  */
 static DEFINE_PER_CPU(struct delayed_work, sl_reenable);
 
+/*
+ * Per-CPU delayed_work can't be statically initialized properly because
+ * the struct address is unknown. Thus per-CPU delayed_work structures
+ * have to be initialized during kernel initialization and after calling
+ * setup_per_cpu_areas().
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
+
 /*
  * If a CPU goes offline with pending delayed work to re-enable split lock
  * detection then the delayed work will be executed on some other CPU. That
@@ -219,15 +239,16 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work = NULL;
+	struct delayed_work *work;
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
@@ -240,18 +261,11 @@ static void split_lock_warn(unsigned long ip)
 		 */
 		if (down_interruptible(&buslock_sem) == -EINTR)
 			return;
-		work = &sl_reenable_unlock;
 	}
 
 	cpu = get_cpu();
-
-	if (!work) {
-		work = this_cpu_ptr(&sl_reenable);
-		/* Deferred initialization of per-CPU struct */
-		if (!work->work.func)
-			INIT_DELAYED_WORK(work, __split_lock_reenable);
-	}
-
+	work = (saved_sld_mitigate ?
+		&sl_reenable_unlock : per_cpu_ptr(&sl_reenable, cpu));
 	schedule_delayed_work_on(cpu, work, 2);
 
 	/* Disable split lock detection on this CPU to make progress */
-- 
2.34.1


