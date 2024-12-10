Return-Path: <linux-kernel+bounces-438959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45B9EA8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD9A18888F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8064922CBD1;
	Tue, 10 Dec 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGa03Byu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B622616F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811903; cv=none; b=tm2fn4I0+3bFADi+YFuToiDuWtWklbBaHZQtAWbNIyKtvSK24A/JXlOVXnhNfZ7vC5UCWDcXAuHBRqYySIouXKeXhZfw1aEiuJI4PORXlblrkWQay5hvf5E0fKjhO78T/qZgzqGSIFCXzpFBpv23fN1If7Z3XlsN1LZX4ZQk7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811903; c=relaxed/simple;
	bh=hBH3FKhc5QIywZsPnjAO3bmp7nbe6fm6dxQE+5D8TQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ES1sK8HgbRJvwyb9wh9r0UAgYpBqGhczp8e0XqN4IdWiZiOpZLkKRN3B9xcaRW9uRMV+ZgCuYjUGZY0wwBPldQ249SqsQpQt4W8i33plqsRJNqOO7aAyqP9Gm6dTRtyfpw5T0pcwHnefXsLTdpnj7+jJVuu6NVCQiby1wmR5fqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGa03Byu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ef0397aeso1538242b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 22:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733811901; x=1734416701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WM2VRXCYbtVzaIpjbhn3W4iQfUn5QfssdbRllbFzNIs=;
        b=GGa03ByuaamCYCpyQDzQn8WKDNgxhTchLijdEvqJ2N1CW1124QqNioFlHd7oTVawI5
         klnmaTRp1v8+ecfBi4Y/KxKyH58kl9FbzsPhZrEIfGXB/A4/TQB/ERj5rlZqxD9sEeq7
         4ukR8SCPkRzhvO+BA/TjjB2b0camC0vO8HVqNwRrjUQf82b8WGVEQ/sO2C1rt6tzYNEl
         s3bGrnTcLGv7WocEoTgUDPVxN7DeEGYFu001r3lKzXpmGJy0zovQ6cYCw1Zc4dhICttJ
         x4KzaOqOvaiAM9aUD1mj6RMtWLTT09Y1t8DcYL0SgIkiPdHRm8/hoOyugqvDjDDLQiFd
         MDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733811901; x=1734416701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WM2VRXCYbtVzaIpjbhn3W4iQfUn5QfssdbRllbFzNIs=;
        b=ikReJGslsVKOwOvycNGdwjYB/1tqdjrf2lf3jF62lDTHwstIYE2cIEV4gwSK5fIsm2
         CytwWOrZRnxaASoa3EqcLRj2OZrUCyTwfMaRXaTHCosj9+nQkc935gWqAgv7S7Z8SKnA
         ECzQ4bxWyhOK1z55cb0c5OS3u5moWQS4r9vog79EIySBkKwfnPMsXArA4Ulq+KPhXaeG
         CVA32D17qYgTvBhg7SnKYw74yg0S4I6uICvs5JEiQVzb3ubJ6uysgIuvFos+N5qy0Ok/
         4/vpbkO02MGzp3FerxYSdNRTl97lH17atodijVom6wbL0nrsgKbBOhDg9GfFNeK+pgGA
         UTyA==
X-Forwarded-Encrypted: i=1; AJvYcCVK4/lpnlDL0doIFGfGRGs6U0ek34TloDJkEc8O073d39UieaU/HjrqfbzA6xG9JV+raJoG1iZOMkDGrvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAs3v9LIWVXF4aoxVRRGwf3GUKtptO3P1VpLn7ULP8FPY0CIw9
	LhAo5ip1295JKr+GPJIwRD6YNSTOX18F19BH0hrSPGaagHlo/YfB
X-Gm-Gg: ASbGnct7o5HiBiXxtJfBFpQYEFYa9XL++L+MmSSuU4CVgitUY7p/82/wGHq/ezdH65W
	Cf7dBVEgd/eCJ1PyeVGzJTSpOJtSQpgl1lqll/r2fOPKF5I2FKyvNNXLsPGxyYI3cxrsBHOrEvK
	OijRYT3AODP0CRPDzngasr6h9JxdVShTGlIXOetAJXVMRBtr/w29Qn4VUuC6Ladwcl5u1JQi2nL
	0juVPPOMO6CWuahtBmg8TxGBbsdc+Tf6behdNvUksl26ZgqwK4CyiTXYBxadCGxox4wmw==
X-Google-Smtp-Source: AGHT+IGYtCTbVptfPIURCVk7ZTyxE3Ks2q/b18yNUV/dEG6pYWZCRManIwU03iipTitUU2538V7RZw==
X-Received: by 2002:a05:6a00:14d6:b0:728:b601:86df with SMTP id d2e1a72fcca58-728b610cfaemr2729954b3a.10.1733811901443;
        Mon, 09 Dec 2024 22:25:01 -0800 (PST)
Received: from kernel-VirtualBox.. ([2401:4900:8899:46e4:646:c8ea:ef7d:d291])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4be412f1sm2616475a12.38.2024.12.09.22.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 22:25:01 -0800 (PST)
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
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
	Peter Hilber <peter.hilber@opensynergy.com>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Feng Tang <feng.tang@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86 tsc: avoid system instability in hibernation
Date: Tue, 10 Dec 2024 11:54:18 +0530
Message-ID: <20241210062446.2413-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System instability are seen during resume from hibernation when system
is under heavy CPU load. This is due to the lack of update of sched
clock data, and the scheduler would then think that heavy CPU hog
tasks need more time in CPU, causing the system to freeze
during the unfreezing of tasks.

Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
---
 arch/x86/kernel/tsc.c       | 27 +++++++++++++++++++++++++++
 include/linux/sched/clock.h |  5 ++++-
 kernel/sched/clock.c        |  4 ++--
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 67aeaba4ba9c..28a5c3ff2e90 100644
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
+			unsigned long pm_event, void *unused)
+{
+	switch (pm_event) {
+	case PM_HIBERNATION_PREPARE:
+		clear_sched_clock_stable();
+		break;
+	case PM_POST_HIBERNATION:
+		if (!check_tsc_unstable())
+			set_sched_clock_stable();
+		break;
+	}
+	
+	return 0;
+};
+
+static struct notifier_block tsc_pm_notifier_block = {
+	.notifier_call = tsc_pm_notifier,
+}
+
+static int tsc_setup_pm_notifier(void)
+{
+       return register_pm_notifier(&tsc_pm_notifier_block);
+}
+
+subsys_initcall(tsc_setup_pm_notifier);
diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 196f0ca351a2..69efc280f14c 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -40,7 +40,9 @@ static inline void sched_clock_tick(void)
 static inline void clear_sched_clock_stable(void)
 {
 }
-
+static inline void set_sched_clock_stable(void)
+{
+}
 static inline void sched_clock_idle_sleep_event(void)
 {
 }
@@ -65,6 +67,7 @@ static __always_inline u64 local_clock(void)
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


