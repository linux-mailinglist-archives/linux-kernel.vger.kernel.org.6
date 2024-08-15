Return-Path: <linux-kernel+bounces-288524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A01953B42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7667C1C22837
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2C14386C;
	Thu, 15 Aug 2024 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXuC+ee8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E76A10FF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752213; cv=none; b=gadNpJRhCIbp+EqkEnoTkZpZ0RRjM0Nyrd44mIrs2SPcA2lMJBrvsV5QzYoO0MsXwB1xu35M0yKuNktd/grIkcP5QikZp/LYDenZH0QlO0x8SsNfDqT3K5lK4EWa0xBc3q9WsBcaQphuWi3bI3NtS031gaC9jb8acnGlA4AWj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752213; c=relaxed/simple;
	bh=6efwW+TiMeyn7babczOAcu+G06aaRQ14SQYo24lfVyE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UpIBj4I078uX7QYNS4YVf6q+GqLkTZWCC/L5oK1qCo5YVJDIGKF3paokHocGR4XAy4wyBSRsI49dHiHcg+FrYTEt5AhnnVlM9FhtiyF2GRTBb2NvtGaD352tVeDbfJO98zB2hcpZ8XZ0cqHRWD3bZ/GDlKSHB/lMAfbzne/IBBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IXuC+ee8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-665a6dd38c8so22493707b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723752210; x=1724357010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LejLHnu5f/FXOnf8ScDyru0HSogJNHqdvYaawTLeU0o=;
        b=IXuC+ee8RhM5nMieWG6JCt1nu1Un4RJqNG1R5eMKx4Dg5dKWYEBvnSZp7iw5Zziitl
         trDnseTGUYRPnwaU7lnBto/TcfmuWw2zFfVM8SB9qT63sju0d8sNkJO/T007noQIVqVp
         RKvzT5D22lv3N/+Oy3bARvQ18sDEGRKYoUP60oSyIANgks2hFrd5qwZkDmlmQoKspTt/
         ZXHkwlpFV1yYeNGsrnJnXXCioYdA7U+TrIAU3VedmYHiq3OHQHHyVq5lNN7aTaJ3Kwbd
         yvZeM07n+Q4jpgwmrRqDhQzk7lm4dRlkNKaOlS5SzCW2nLBuAOwA7REnvwLA9zg59JF1
         8tTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723752210; x=1724357010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LejLHnu5f/FXOnf8ScDyru0HSogJNHqdvYaawTLeU0o=;
        b=feXtz+WIgQB5fSUDMGOS0j/4wi06cRosP4ZIHGx96Pmh+JYyWNVuUZa7HaXXrrDGAq
         5wlPz5bL+OVRpUcOldyOyP9n8cqG0l7OjBsy3YoslICvVMuimvcTfR3Lk0iDHdIMwiri
         BjePd6PVVZuDshshJ2B+9QAVEAhJFmSMhrlIOiPxmiNrUmYy97vbrhhSFDcudt/BFxnz
         n69m1aAXbhR4fulNistlYrf7PX9FQG1coFJKijT6amnJCz4OAtyuWIbfRxwJ1wIEV5bP
         AOWs+ZZdSGb8Qxnhqwo60Oz+BWYq63WJKu150+P5aBJkcCYNoV4YVUEt8/2ZODYIuAr4
         zHhw==
X-Gm-Message-State: AOJu0YxRl5nsxqDOZDEO/s8axfgH6qOtCULJDBRCR0zhM/XZbOfCMv3F
	Gk3jQwuLMfqZProKnI9EA86RxlhYQLSQZEzhbeDj/s1Ta1CdPikyUoIZQ3cpNPTJZuYvJBn1j0w
	Nrwkfosvu4o3SEhdCz+AZFGUx9jJrxNEGtHtcsYNTAV5yFfqvUFimdEANYMEzByd7eOFbXEjFd4
	VcJ687HVZqQqCy0c5dm+UJ49ai2JVM8bIrJ/MKigQST5Pq
X-Google-Smtp-Source: AGHT+IFzFRIU3SNfYIV/5IOtCTN8mbricfo8Uo5jYYHy8pkSBs198jTgo9tHaGQ8rKQk7POIwmEbZU5amz4Y
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:3009:b0:69a:536:afde with SMTP id
 00721157ae682-6b1baeb1478mr13207b3.5.1723752209970; Thu, 15 Aug 2024 13:03:29
 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:03:09 -0700
In-Reply-To: <874j7y6cwh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <874j7y6cwh.ffs@tglx>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240815200325.2474604-1-jstultz@google.com>
Subject: [PATCH] time: Rename CLOCK_SET_* as BASEMASK_*_CLOCK_SET
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"

In commit 5916be8a53de ("timekeeping: Fix bogus clock_was_set()
invocation in do_adjtimex()"), Thomas fixed a bug where instead
of passing one of the CLOCK_SET_* values to clock_was_set(),a
conceptually related clockid (CLOCK_REALTIME) was incorrectly
passed.

Just to make this type of accident less likely, lets rename the
base masks used by clock_was_set() to something that doesn't
resemble a clockid.

Thus:
CLOCK_SET_WALL -> BASEMASK_WALL_CLOCK_SET
CLOCK_SET_BOOT -> BASEMASK_BOOT_CLOCK_SET

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/time/hrtimer.c       | 2 +-
 kernel/time/tick-internal.h | 4 ++--
 kernel/time/timekeeping.c   | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d41..ca18a2a344294 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -980,7 +980,7 @@ void clock_was_set(unsigned int bases)
 
 static void clock_was_set_work(struct work_struct *work)
 {
-	clock_was_set(CLOCK_SET_WALL);
+	clock_was_set(BASEMASK_WALL_CLOCK_SET);
 }
 
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5f2105e637bdf..59a6e50734f40 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -181,11 +181,11 @@ extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle);
 void timer_clear_idle(void);
 
-#define CLOCK_SET_WALL							\
+#define BASEMASK_WALL_CLOCK_SET						\
 	(BIT(HRTIMER_BASE_REALTIME) | BIT(HRTIMER_BASE_REALTIME_SOFT) |	\
 	 BIT(HRTIMER_BASE_TAI) | BIT(HRTIMER_BASE_TAI_SOFT))
 
-#define CLOCK_SET_BOOT							\
+#define BASEMASK_BOOT_CLOCK_SET						\
 	(BIT(HRTIMER_BASE_BOOTTIME) | BIT(HRTIMER_BASE_BOOTTIME_SOFT))
 
 void clock_was_set(unsigned int bases);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d602..c8108345438aa 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1471,7 +1471,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	/* Signal hrtimers about time change */
-	clock_was_set(CLOCK_SET_WALL);
+	clock_was_set(BASEMASK_WALL_CLOCK_SET);
 
 	if (!ret) {
 		audit_tk_injoffset(ts_delta);
@@ -1521,7 +1521,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	/* Signal hrtimers about time change */
-	clock_was_set(CLOCK_SET_WALL);
+	clock_was_set(BASEMASK_WALL_CLOCK_SET);
 
 	return ret;
 }
@@ -1896,7 +1896,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	/* Signal hrtimers about time change */
-	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
+	clock_was_set(BASEMASK_WALL_CLOCK_SET | BASEMASK_BOOT_CLOCK_SET);
 }
 #endif
 
@@ -2606,7 +2606,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set(CLOCK_SET_WALL);
+		clock_was_set(BASEMASK_WALL_CLOCK_SET);
 
 	ntp_notify_cmos_timer();
 
-- 
2.46.0.184.g6999bdac58-goog


