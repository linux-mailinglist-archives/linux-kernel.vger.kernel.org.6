Return-Path: <linux-kernel+bounces-421676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 036BB9D8E63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F7CB24443
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A871CBE8B;
	Mon, 25 Nov 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="RB+oMa5S"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23125190059
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572768; cv=none; b=B7+h4QxFb0QkYPfkuRZIvz1NtSbGwa5P/OAeK/L2Lw/NetkLfeQylkb1Fyq7Rt9h10IkWpCuo7N6any3usoqcXBabE2/R8kzyQOLkD/HSKu7TX1A05CPrZAnKazqXFp0YLpqbHIWzRKdkLWYcTImMNmH60+C5hYRL/LLN2PZM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572768; c=relaxed/simple;
	bh=d1EzrEkUUc0mYs24aI7ALW1mWLJdV/eipHeDnMmkVy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=faMCy0Ld/dVMBv9cbGyJlhxZ1z66Dyr3IZMTLiJdH+41SRyQDPALtUPNNBl6JabsCY5K56F4c0MEo9hf1dmYq9gxtljf0aw6e1SFGG00XLWKmkLUqUOeh34R359HO5yX8WmUFxAXg8fuzwNTJwosv6j080/eW2AwDZlxbe9ltGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=RB+oMa5S; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f69e:0:640:3ef4:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2ADE160B2F;
	Tue, 26 Nov 2024 01:12:32 +0300 (MSK)
Received: from davydov-max-lin.yandex-team.ru (unknown [2a02:6b8:b081:b6b2::1:1d])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ECgKtw2Gca60-dw7FuPQq;
	Tue, 26 Nov 2024 01:12:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1732572751;
	bh=qdhLndVUgTJR6LDAq5tAYJT2KGUbCHEgtBVmGgL4Bz0=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=RB+oMa5SpXK8mcWCDnROSNKS5EOu0/Rnk+8VCzES7hcSgA1X/UUbMxucr/nK1zmt1
	 W+d26EIea7Ed4JUAZDrjnum8+KknudNdb3KKkkHeYiSY+eGpTa+FndGyniJEpZntQR
	 7rmS8BQF3Ze9tCCQC2ZqteJIBLnNVX7DO6v+0Wy0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
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
Subject: [PATCH v4] x86/split_lock: fix delayed detection enabling
Date: Tue, 26 Nov 2024 01:11:47 +0300
Message-Id: <20241125221147.932377-1-davydov-max@yandex-team.ru>
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

v4 -> v3:
* rebased the patch onto the latest master

v3 -> v2:
* place and time of the per-CPU structure initialization were changed.
  initcall doesn't seem to be a good place for it, so deferred
  initialization is used.

Fixes: 727209376f49 ("x86/split_lock: Add sysctl to control the misery mode")
Signed-off-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 arch/x86/kernel/cpu/bus_lock.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index 704e9241b964..b72235c8db3e 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -192,7 +192,13 @@ static void __split_lock_reenable(struct work_struct *work)
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
@@ -213,7 +219,7 @@ static int splitlock_cpu_offline(unsigned int cpu)
 
 static void split_lock_warn(unsigned long ip)
 {
-	struct delayed_work *work;
+	struct delayed_work *work = NULL;
 	int cpu;
 
 	if (!current->reported_split_lock)
@@ -235,11 +241,17 @@ static void split_lock_warn(unsigned long ip)
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


