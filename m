Return-Path: <linux-kernel+bounces-440010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDEE9EB77B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFF31886A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAD234990;
	Tue, 10 Dec 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKsL2b5A"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E32343D8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850564; cv=none; b=eXcyEofRprdbjJC1ncavjCJCQ40v9v3Nv1NrtzDcoaf4szNeQ/zeholHFthzcngT9jFyPOm9mwZcqJJbR8mH2vSFYs1CjDh5Qm79rys1VS3t52r2NT1+Q4puSEHf3L79KUQYjKpNrzE8H85riTGQje915vfLAcaRuhztZasqeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850564; c=relaxed/simple;
	bh=2Vij5PTCO0kafN6R6GRZ1yy5eAw37bHJzx4g/J6CGXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHid0eCB9zIAlm+64YtszljOKz3ytw6NwhD9I7lAsaK2XFe4JxlVr24FMUdeOgScSGtT0yuGzrgUBAQt/lzYhvs+MA3vAjJKWiZSC1xchVkAK32BT8uv00SmV5jMDq8WFL6prJNDGGVK5JVVpjSbz5+sIIXAAIwgMrSRlLeK+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKsL2b5A; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2156e078563so43951615ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733850562; x=1734455362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=idCVEtzcq9gJcyfgY5CFOJogj9NHMiebhAUM0HlATss=;
        b=nKsL2b5A4FwZk/FP8BHsijq5sjMJrkkjw+bs0rJJvl8SWkw/MrC88tZrlcQVW/zNMv
         sOTgqJk87S0DKit42/c3oKJ/UY8dFowPEh+a/JJfPaiLoNm7qoU+dk7kxm5/iCVx6qkA
         DrZc3gBnnMOj2a0/qYe8v4zp8qymfUBZPX8OUlWDlCXyRt4g+1Q5E+N35ieFa+K6PmV8
         N5NTYbUiLQEAb6KkodHm1kTQmffPtxxbKsMbvOa/c05QQjoKEb4dwjifspP4vDCDZ2my
         VmO5ergfcMv2NOyPPCYCSyzPkflzjXOX+aeUlrqFVBv3taX8iAIdEWAMmYP07KkkT9XK
         7+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850562; x=1734455362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idCVEtzcq9gJcyfgY5CFOJogj9NHMiebhAUM0HlATss=;
        b=Lc4VJLsyrvZShSBY6rF0sI/H9OJayQTkxBFYioyn74ZJSLzG64j/GevEetr8lZM/8q
         n68ZERNaHOQN6WuM0oGguQq2ZrteOH79ElaBLNRoSML42C7kIEkXfAR4vlC3gI3nlrL8
         AnoXH9C2zm4jRV1ouQS0BDcAkpfjM9xMxFbRKzR1G+d1WTpvr6SkK+iihBGD6i+hQKjL
         f66pD3pAYeDK+rCn8tqxqdye43AXR+BR0vcTp10Vd1um869zhhtM66BxWuK6eVqotzIJ
         fkty0m0DIFIS6dOReEOUuf0ruFMejAxMW3nC6s9xzde69px2dSDsKHVJWzoDruW0sPfF
         a3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWySh/uLLqh5EKtH4iygM7HL4ECjKGpweZH2C6XDm1vCQc4AGay6a5I+fC94kCBgQkXFwCumPfs2d6moYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOT41hySJj/ItLJfEiJeR4+RSXYxF2GI5qu3xWNh3uPmfR1iIr
	vU64vuqsb+j/HxgK1XE/GNOP6fxGs0GVI6GoNfL1izlBnvg7NPhd
X-Gm-Gg: ASbGnctL41BC66MSwsILcVZKVflyff2xKaFRpOM/yc60qHA1Sbroct/rKYCcOCVwO1p
	75D+PYWXGnLWCthZYHdspgLrEWp7YtnTsWL6v66N/fOKUD8d6/6g9SujTrFczIDCWcNG4dePYfe
	bcZCFVMlj7Eo+SdYevFJLlSFjJSD1BgCc6ddDngVueHH6qZxcjAH33Fr4NvcC/9L9c6XQlZ8KI4
	BRXECeA7b3zFDqvRDMK8VepQBKLu3DBOhxTLreKLj7hL4MqSbqsHzErf3XOcGDQ/7MFhfE=
X-Google-Smtp-Source: AGHT+IFLfDvEeQ8noMrFz4ASuaeBBllh0R3nhL4lsvZCI7UZjxxtHLoStTALiSPhtyQ/pvpcw3/gyg==
X-Received: by 2002:a17:903:184:b0:216:410d:4c67 with SMTP id d9443c01a7336-216410d4e91mr152563315ad.41.1733850562127;
        Tue, 10 Dec 2024 09:09:22 -0800 (PST)
Received: from kernel-VirtualBox.. ([2401:4900:8899:46e4:3dbe:314f:9385:c642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21634f24f78sm52987985ad.32.2024.12.10.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:09:21 -0800 (PST)
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
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Feng Tang <feng.tang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tsc: avoid system instability in hibernation System instability are seen during resume from hibernation when system is under heavy CPU load. this is caused by the lack of update of sched clock data
Date: Tue, 10 Dec 2024 22:38:42 +0530
Message-ID: <20241210170906.70898-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


