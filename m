Return-Path: <linux-kernel+bounces-359183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E795F99886F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892261F22287
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011B21C9EB5;
	Thu, 10 Oct 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rtZmJ+Qy"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF0A1C8FD7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568496; cv=none; b=PTaXDHmg0PTqZnC98cKs0I2lGEiw85TIJaa6HCVYphSRSY6OVT27Xvh0+NYkeHii1BC3VD6nferPkHGbnfZLq1McmeYcSi2M7UytkquK5s9XG6QB76qVt22r022KZWsV+AIt19huJyqcpExFlVxm97fujr4ndzv5M+4quKofy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568496; c=relaxed/simple;
	bh=qSUxFxZspgMcfQY5+jl1jPXfgQQnoNowZXPOJtAoLYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SA9zz6Rvr1XDrAtc2hBnCYmCbRfoqe8Fs5eyrvhMYUPoLIgRJGMF6xUuXH6nawR7mkVaFn8U+ENbaefhRRCip7yC8O3f3F1KYm5uA6k0WUhnu+hOKiH06nqPaZm4CjqAb3TA8ETBBCruXFNdWioU4vVncAFFmpqQ2psk43EQwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rtZmJ+Qy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=v8tFS6BLOJ3erqK+DhD25hVS1almgqLVcNOb3Z708U8=; b=rtZmJ+QyqXimeHs1
	8+6c32YRdgu/5BHZEoxIHEUqNs0AZoro7A8Mp0XHLsvL/WcXeTLMgEZdKNV6quzl1WQ2R9K+Xuh62
	OYzCx8d3WJpo0VPp7Vp4Y4oAMkBEJjf0BhR9RZiTNsur3bT59nkhrPI9GAiswn5P4+8W89zDrAldu
	pEqZlFlFvfMvBPaHlg5hB1sjbjgVd/n0/dISWcvmemBO9RyyIO0R/QjykUWEyVZhGcQqZEajUssUq
	/c6JdxbE1nBTWsAL7WG1JTZ3wM01/tTIziT4vEk7UGbkCL3Q++PFmvy6OJ8I0eYF6vt3RdTYaninF
	kIpkeirmZ5IghxUczA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sytct-00AFZ7-1C;
	Thu, 10 Oct 2024 13:54:47 +0000
From: linux@treblig.org
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] clocksource: Remove unused clocksource_change_rating
Date: Thu, 10 Oct 2024 14:54:46 +0100
Message-ID: <20241010135446.213098-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

clocksource_change_rating() has been unused since 2017's commit
63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clocksource code")

Remove it.

__clocksource_change_rating now only has one use which is ifdef'd.
Move it into the ifdef'd section.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/clocksource.h |  1 -
 kernel/time/clocksource.c   | 38 +++++++++----------------------------
 2 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d35b677b08fe..ef1b16da6ad5 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -215,7 +215,6 @@ static inline s64 clocksource_cyc2ns(u64 cycles, u32 mult, u32 shift)
 
 extern int clocksource_unregister(struct clocksource*);
 extern void clocksource_touch_watchdog(void);
-extern void clocksource_change_rating(struct clocksource *cs, int rating);
 extern void clocksource_suspend(void);
 extern void clocksource_resume(void);
 extern struct clocksource * __init clocksource_default_clock(void);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 23336eecb4f4..63564339b7a9 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -20,6 +20,8 @@
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
 
+static void clocksource_enqueue(struct clocksource *cs);
+
 static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
 {
 	u64 delta = clocksource_delta(end, start, cs->mask);
@@ -171,7 +173,6 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags)
 }
 
 static int clocksource_watchdog_kthread(void *data);
-static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -191,6 +192,13 @@ static void clocksource_watchdog_work(struct work_struct *work)
 	kthread_run(clocksource_watchdog_kthread, NULL, "kwatchdog");
 }
 
+static void __clocksource_change_rating(struct clocksource *cs, int rating)
+{
+	list_del(&cs->list);
+	cs->rating = rating;
+	clocksource_enqueue(cs);
+}
+
 static void __clocksource_unstable(struct clocksource *cs)
 {
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
@@ -1255,34 +1263,6 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 }
 EXPORT_SYMBOL_GPL(__clocksource_register_scale);
 
-static void __clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	list_del(&cs->list);
-	cs->rating = rating;
-	clocksource_enqueue(cs);
-}
-
-/**
- * clocksource_change_rating - Change the rating of a registered clocksource
- * @cs:		clocksource to be changed
- * @rating:	new rating
- */
-void clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	unsigned long flags;
-
-	mutex_lock(&clocksource_mutex);
-	clocksource_watchdog_lock(&flags);
-	__clocksource_change_rating(cs, rating);
-	clocksource_watchdog_unlock(&flags);
-
-	clocksource_select();
-	clocksource_select_watchdog(false);
-	clocksource_suspend_select(false);
-	mutex_unlock(&clocksource_mutex);
-}
-EXPORT_SYMBOL(clocksource_change_rating);
-
 /*
  * Unbind clocksource @cs. Called with clocksource_mutex held
  */
-- 
2.47.0


