Return-Path: <linux-kernel+bounces-439635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0883E9EB20E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB07C16B633
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3D1A9B5B;
	Tue, 10 Dec 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWeRf9r2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CA1A0BD7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837983; cv=none; b=j4QAcxK2xdawPNim0P80YHM6aTuB7gd0WdR7y79062thjmbu5/+qrOXxsGkTadrWPyJHSsTri2wF27Znr8V8LHkyl2REwFxhV0/nKsaZLKwgl5dOFAQ82VMGKLdU6gtqUDc9RfDAbRjgctx5FkCkUtWSgx6xw0VA9NC9IlXErO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837983; c=relaxed/simple;
	bh=0ugzxxvwzE9ljXmGx2ouO88PkoIF1MInTZ2nTU0wGtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4DkZGh5otRsjh8RTo79K5V4y6NCpzKVOf4m/HIUboXgJcsNXWLU5Y2PTKKqQlpDQtIurlPwjXxy1sA0MbZFuRheNJSrx/neXgVqA3+1e1M91ejbms4gYA4j/l6Iwp2vMPPP3mNRY2wYyr4p1K38akx7QFcnMFanU7A18tkU+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWeRf9r2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21649a7bcdcso22406125ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733837981; x=1734442781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2i5krlZFaILuRhhCaT/OOirp5qYUinnHgLUVyefzFi8=;
        b=CWeRf9r2NCFvPKa/HNOe6AFjSpWFsbPM70sIsOsV7qT0EPIwcxByrdA+eg9pJ5DBkD
         PvUDM68J1zbBOHkKdlFostW2/jiS3Zp8higicF2FmrRhWTA0LF/e93TX81QQfO+VKq/s
         kpBCPKn9C55WB31rsHUWHaRpgbTnerXbP2VVdf4WzJbyE3f43oNRMFeT7llmYY73MRZf
         jOhDjvaHRhzJ4js2FIDVTvgYPjUT0m0NeuiAN5GRHxwvvOzjU2xjNOBRcZtFARdr4nqB
         A80gO9pclhEOPeuPDUJe7JXboh/2xny+up2jwIa0WQZzwgH3s2RWXp/MkFrEn/a49L4/
         PrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733837981; x=1734442781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i5krlZFaILuRhhCaT/OOirp5qYUinnHgLUVyefzFi8=;
        b=eH55ZBZ5cTtqyjHbQ9LqOg3jcqBhZr8nY1M8ROgeVFn5ZY8vslmBlaHWz1CoaqSrvq
         9cJykSrGLvOH7iB7Wj1UvqeN18VET5fZSZH81CH0VuQI8JRp2TBFp8LGELuKMBaUmlKZ
         c173jWX6zX2BMz8+Tvxg0Jn7tngzO5Nncd5rE5HV3ew2ZDUqWxyJKZm5cB9qzZ1b7sr5
         GzT2t/3NFgkbg+0qB+mWN7tCgDyAugq+QxGno7XQIdIdN2BuxRZgMmULttf64YpHDYX7
         g4Qf6KPkqaxuUrzVKGRRVEyywGKwuyiIzgB0UXnfX1C/2DLAgFfX6AW8zOghu4B8g9g1
         fxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR/0zhx8x/ecbyyzX7sqE+0QSp9iMg1Cg0/qKUx5KXflZPAOxodMK4I2XV2fXKJrDhsxc3WWog5mtGu1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhprdJ02Ky2AkByuEr0u7mOCVeoCc7TWaHJIFAy9bW7b9Iclrr
	vpcAPhHLIY/Q3qCXhteVxUBbrmKWyj1h+9v+eWAKjtvOpXdZ0mlK
X-Gm-Gg: ASbGncv2c9g8Zj+eoAbJ3rLFhrBVpJTQIjoaz37yUCEHmL5vD3OKPTx27DCsz960DR2
	GZFu4YL0yHCRAXQ4qomt9/5R5pOni1K2mg5L8xFxqF39VNJonsTWtwD8eJgCOgHKR1Ws9NWSB1x
	lQUNnP1sIOXi3UTrRkqpSqN9f5ji83bkX0UZaBfxXUekJ6X+sTcFfIm8jnY/0b56gAiEvQmReQ7
	sPGAFnFEqv3Gj5mrVr7qmF8a08CCzHGA7MXRC6Z49KiGjA5/LwwlneWPKHywpEtcSept8M=
X-Google-Smtp-Source: AGHT+IFflGu2vSqkHEeZvRAMvR39jNi4QOF/rPl4xw5Bfd+34TeTpzjhW7qrFHTybtyllCsbPits4w==
X-Received: by 2002:a17:902:ec92:b0:215:a172:5fb9 with SMTP id d9443c01a7336-2166a05562cmr67967965ad.48.1733837981231;
        Tue, 10 Dec 2024 05:39:41 -0800 (PST)
Received: from kernel-VirtualBox.. ([2401:4900:8899:46e4:3dbe:314f:9385:c642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21637c96975sm47510795ad.25.2024.12.10.05.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 05:39:40 -0800 (PST)
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86 tsc: avoid system instability in hibernation
Date: Tue, 10 Dec 2024 19:09:18 +0530
Message-ID: <20241210133930.1195-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System instability are seen during resume from hibernation when system is under heavy CPU load. this is caused by the lack of update of sched clock data

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


