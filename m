Return-Path: <linux-kernel+bounces-447165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F49F2E42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E4C18826D4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83D203D47;
	Mon, 16 Dec 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvcVYqDd"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3B202F95
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345496; cv=none; b=WaNpOf1M5C/ZuprAxu45eYzZ+Bqabu3jCLFekCsg4uTPPpscxy1uZbvdfOHdbpnRQ+DbsrtZvysbQoCfesYaRmeNzlMjdNMlvBFQjVPJjYx+7nZKHQtW327viN74g0zCxme9aUia0+NeRshp2X2GKr1n0oyWxl5hnez9ztO7pHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345496; c=relaxed/simple;
	bh=J/1eW73uHfhvljqiVFr+yoIAwaw+wlsdLCNC6qTi6Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njpEISufdy7TeZHENxuckM1s+kHrn3vKgoGtkkcIVndQdorwORsoqQUJMDkTUZvi71E9WIazvObaY1EPTf3xgnf9iBpYCT6zaAZY3lDK588T0h3r4Euln6g9pgFF57WJAxWuBpwZ6+S9B1aPrHG3o5uJhjLqitul4WRXFMZCP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvcVYqDd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so3500101a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734345495; x=1734950295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qRzqExWa68iwo9L78QJVYslDT5BJvdJCsI2gAFL2kEc=;
        b=DvcVYqDdITLERGoTO8EevyTnd+oMxxEv7LtkWeiC60AYB5ZyMGplIL4rtSJPIKfKlZ
         fb9oEtoilO7pl8l9//+gT5BQkTJo33/Id2TLDRj4i1eYwxT1iUOaRTTFsaYoP9+qhmYp
         PXKSE+pPrYiWRyaCp0I/zgJsnBIt7D2lSQRmxJi0CMfe9Ba0iy6smGLD/zAD47g1FuW/
         IowE1+qUPPEf20xo2YmTohwpSsNkvX25UOnm2i/V6MjOuspS5vhqe/E7oIKfJf2ISyLL
         YX29U4JD5zvnBcplLFhrE0qbmT70/VIdlodH6wfjsDgM8vPb1Y9Esdo9x2s5M8FcPKMA
         8egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734345495; x=1734950295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRzqExWa68iwo9L78QJVYslDT5BJvdJCsI2gAFL2kEc=;
        b=aN76Q21sEq4lTtrGSfbQvlmEGIbXoumtmoyE4P1zhVcK4ATH7juw4Ntx2f0BilEDfE
         U+aPQ/lgeikimpXeQU9xfceU4oAAeIa6tnfwCjT/YYD6gizuXE13kpgMobTsqGHBFkpD
         JBgS9Q4mxfAw0hTdu2+b3VS4z1scT+MQc7YwBM4z+6uOQi58MHUMM1BsnRq0I+TVlDrd
         0HiWsjYuxPajCKo77CtpptgxdAGuzEm24/rrnJo9rV/UT5x1BSz2RZJNGQh2Va6NRNit
         HJm7+4aLr4DkYtlqbTsFnaIzqBKKFjfmp4fU3R57L6Dld0t5uMAka6TH+1J02lIyvHb8
         wocA==
X-Forwarded-Encrypted: i=1; AJvYcCXpTdX8NHnml5WUZMKmxAd1md8zeK8n7q+CtQTYxRa1q6/lfrmF4xEf54KHRA+0Hy3VHvTR2bXP/X5czuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlaT4P4WBnjq1SVooh3gaxMppyHDMa62UmIdpKkmKH/MaumlAt
	QJYrgl5KzkULbkCfMVHRirgiobYcT8z2KwOvLHuWWPD4zJeGC+TU
X-Gm-Gg: ASbGncuOYgJugCAd6Ko0fzwHM/d32Tu0eIxRa65zk2BpwXSvr5u9aUkIzEeOGk3G04V
	SIu2WgtPBotR4QFaMuFzYvdCCCwHfHzpeLVYup46w/8KbfG87mgQPr7HrhXJIms6QbYCFSom+NR
	hSCeqEl9QrJgpq/4U1l/4KJDY8EmySKHIOc1Lk3F9s6qrmkLtQ1QBaitHD3z2gLB7NDX5OoEw64
	bgcvucMkixVMpb+sp5T7Lx6XFe9Uz9qJLKoH3kw/zyu3i5brzVrQoKiRM95mqa0N872iYtw
X-Google-Smtp-Source: AGHT+IFkqWGAorfnZyfemgvn+hpAksoZGvjlXA93ysWJUPD/Q51IlfTKN/FPipoZKBx2etyV/l0mSw==
X-Received: by 2002:a17:90b:2e48:b0:2ee:6736:8512 with SMTP id 98e67ed59e1d1-2f28fb6f983mr23047243a91.12.1734345494608;
        Mon, 16 Dec 2024 02:38:14 -0800 (PST)
Received: from kernel-VirtualBox.. ([2401:4900:8898:4d2b:e6be:8d6:fd31:1ed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1e80a35sm4355047a91.4.2024.12.16.02.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 02:38:14 -0800 (PST)
From: Atharva Tiwari <evepolonium@gmail.com>
To: 
Cc: evepolonium@gmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Marco Elver <elver@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tsc: avoid system instability in hibernation System
Date: Mon, 16 Dec 2024 16:06:49 +0530
Message-ID: <20241216103735.2097-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


instability are seen during resume from hibernation when system is under heavy CPU load. this is caused by the lack of update of sched clock data

Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
---
 arch/x86/kernel/tsc.c       | 27 +++++++++++++++++++++++++++
 include/linux/sched/clock.h |  5 +++++
 kernel/sched/clock.c        |  4 ++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 67aeaba4ba9c..1879ae5b49c8 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -15,6 +15,7 @@
 #include <linux/timex.h>
 #include <linux/static_key.h>
 #include <linux/static_call.h>
+#include <linux/suspend.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -1599,3 +1600,29 @@ unsigned long calibrate_delay_is_known(void)
 	return 0;
 }
 #endif
+static int tsc_pm_notifier(struct notifier_block *notifier,
+                          unsigned long pm_event, void *unused)
+{
+	switch (pm_event) {
+	case PM_HIBERNATION_PREPARE:
+		clear_sched_clock_stable();
+		break;
+	case PM_POST_HIBERNATION:
+		/* Set back to the default */
+		if (!check_tsc_unstable())
+			set_sched_clock_stable();
+		break;
+	}
+	return 0;
+};
+
+static struct notifier_block tsc_pm_notifier_block = {
+       .notifier_call = tsc_pm_notifier,
+};
+
+static int tsc_setup_pm_notifier(void)
+{
+       return register_pm_notifier(&tsc_pm_notifier_block);
+}
+
+subsys_initcall(tsc_setup_pm_notifier);
diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 196f0ca351a2..811b8ebb57a5 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -41,6 +41,10 @@ static inline void clear_sched_clock_stable(void)
 {
 }
 
+static inline void set_sched_clock_stable(void)
+{
+}
+
 static inline void sched_clock_idle_sleep_event(void)
 {
 }
@@ -65,6 +69,7 @@ static __always_inline u64 local_clock(void)
 }
 #else
 extern int sched_clock_stable(void);
+extern void set_sched_clock_stable(void);
 extern void clear_sched_clock_stable(void);
 
 /*
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index a09655b48140..efe8f2b69657 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -114,7 +114,7 @@ notrace static void __scd_stamp(struct sched_clock_data *scd)
 	scd->tick_raw = sched_clock();
 }
 
-notrace static void __set_sched_clock_stable(void)
+notrace void set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd;
 
@@ -234,7 +234,7 @@ static int __init sched_clock_init_late(void)
 	smp_mb(); /* matches {set,clear}_sched_clock_stable() */
 
 	if (__sched_clock_stable_early)
-		__set_sched_clock_stable();
+		set_sched_clock_stable();
 
 	return 0;
 }
-- 
2.43.0


