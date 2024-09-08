Return-Path: <linux-kernel+bounces-320290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23773970867
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C061F2164D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDADB17279C;
	Sun,  8 Sep 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="OpRHxkIw"
Received: from 2.mo565.mail-out.ovh.net (2.mo565.mail-out.ovh.net [178.33.107.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823D29CF7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.107.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725809103; cv=none; b=eIustliCKCyIqpJxcQO2QpLmVbSKFd65LmugjUEP5CaxPhWA20aoKZ7sQqvIOaDSSRwZSSDdALmwmCAmOLsH5KzoF2dowK9T1kcjvvzNNbEIwY37fkcMg1trLjWYXjE3Bwb5CG2FB5iuhyQZS95wLHwYj245S77Z+QJNm/lQHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725809103; c=relaxed/simple;
	bh=Eqc3xphOq/5faKqXuyhXAGPpMiG+adjaUfB80wH7mk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmM5H3c2WEWDodFfWA+8qHuEintUWYEw1vYXCnLj9Ld9CF+uPjqvg8dArcXLdarrx8sSvTyDv0uo8kPxZ5D4RI9Qh5y1ogjrfunxdMdUzO+KEI3Wo/gKg04LzYXXlCosJocZMwHtgZuIK7szM7pALm74eMGMGCN+GMz0FXN6b5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr; spf=pass smtp.mailfrom=benjarobin.fr; dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b=OpRHxkIw; arc=none smtp.client-ip=178.33.107.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjarobin.fr
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo565.mail-out.ovh.net (Postfix) with ESMTPS id 4X1sJl4t3Mz16tk;
	Sun,  8 Sep 2024 14:08:55 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <dev@benjarobin.fr>; Sun,  8 Sep 2024 14:08:55 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.139.179])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4X1sJl2p5yzHcF2;
	Sun,  8 Sep 2024 14:08:55 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.2])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 8FD913A34A8;
	Sun,  8 Sep 2024 14:08:54 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-96R0014a1d59f3-9f63-47ad-9aec-1f4c5e291b1b,
                    2138D52549B61E75FE7EBB3F53CE47A04563795D) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp:92.161.126.4
From: Benjamin ROBIN <dev@benjarobin.fr>
To: jstultz@google.com,
	tglx@linutronix.de
Cc: sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH v3] ntp: Make sure RTC is synchronized when time goes backwards
Date: Sun,  8 Sep 2024 16:08:36 +0200
Message-ID: <20240908140836.203911-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240907190900.55421-1-dev@benjarobin.fr>
References: <20240907190900.55421-1-dev@benjarobin.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12679603278014528475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnjhgrmhhinhcutffquefkpfcuoeguvghvsegsvghnjhgrrhhosghinhdrfhhrqeenucggtffrrghtthgvrhhnpefhueffgedvfedvheekheelueelhfehfeeukeffgeefiefhgfeiheevteegudehveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdelvddrudeiuddruddviedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohephedprhgtphhtthhopeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehieehpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=OK6NsLTNptsJgQxz3KSWrANZKPRULmWIwqPZOntpde0=;
 c=relaxed/relaxed; d=benjarobin.fr; h=From; s=ovhmo1728415-selector1;
 t=1725804536; v=1;
 b=OpRHxkIwSWLvPGARds0V9uAxlnYYk9G7ipvAgA/Ng1wJeQnVxwmv98kRdxW1iQHnzdBrHl0f
 MJ8Jn0QLeBw4hwsBpJfHgbxxG7/AlgycxzQIzm0ZItVko0mHiXWhrCjj8AX0EentVPQJDGys/6B
 +z6DCNMwVfwQBne5NvCzVV9y1c+6vU7GyA27uzVUwh7v4oXG+m98jE+xVoNwABkfYBMStyxaGO4
 kKykKkAEBwxOYbq1BsAOYIFwqGUkN5mTTkQnXAE2GvaO0yhztyx7sw3zwkur51YRsmAZV3ffRWG
 nBkCbanAuKvlKVTrGzn+jw6FpPgI/rC/xJhJwqRStmr3Q==

sync_hw_clock() is normally called every 11 minutes when time is
synchronized. This issue is that this periodic timer uses the REALTIME
clock, so when time moves backwards (the NTP server jumps into the past),
the timer expires late.

If the timer expires late, which can be days later, the RTC will no longer
be updated, which is an issue if the device is abruptly powered OFF during
this period. When the device will restart (when powered ON), it will have
the date prior to the ADJ_SETOFFSET call.

A normal NTP server should not jump in the past like that, but it is
possible... Another way of reproducing this issue is to use phc2sys to
synchronize the REALTIME clock with, for example, an IRIG timecode with
the source always starting at the same date (not synchronized).

Also, if the time jump in the future by less than 11 minutes, the RTC may
not be updated immediately (minor issue). Consider the following scenario:
 - Time is synchronized, and sync_hw_clock() was just called (the timer
   expires in 11 minutes).
 - A time jump is realized in the future by a couple of minutes.
 - The time is synchronized again.
 - Users may expect that RTC to be updated as soon as possible, and not
   after 11 minutes (for the same reason, if a power loss occurs in this
   period).

Cancel periodic timer on any time jump (ADJ_SETOFFSET) greater than or
equal to 1s. The timer will be relaunched at the end of do_adjtimex() if
NTP is still considered synced. Otherwise the timer will be relaunched
later when NTP is synced. This way, when the time is synchronized again,
the RTC is updated after less than 2 seconds.

Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
---
v2: Improve commit message (takes into account tglx remarks).
    Cancel timer outside timekeeper_lock, from ntp_notify_cmos_timer()
    as recommended. Cancel timer on negative or positive jump.
v3: No changes. Resent since lore.kernel.org did not pick it up.
    Also, to indicates that it should also fix the build issue discovered
    by kernel test robot. v1 was really broken, sorry about that.

 kernel/time/ntp.c          | 10 +++++++++-
 kernel/time/ntp_internal.h |  4 ++--
 kernel/time/timekeeping.c  |  4 +++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8d2dd214ec68..802b336f4b8c 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -660,8 +660,16 @@ static void sync_hw_clock(struct work_struct *work)
 	sched_sync_hw_clock(offset_nsec, res != 0);
 }
 
-void ntp_notify_cmos_timer(void)
+void ntp_notify_cmos_timer(bool offset_set)
 {
+	/*
+	 * If the time jumped (using ADJ_SETOFFSET) cancels sync timer,
+	 * which may have been running if the time was synchronized
+	 * prior to the ADJ_SETOFFSET call.
+	 */
+	if (offset_set)
+		hrtimer_cancel(&sync_hrtimer);
+
 	/*
 	 * When the work is currently executed but has not yet the timer
 	 * rearmed this queues the work immediately again. No big issue,
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 23d1b74c3065..5a633dce9057 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -14,9 +14,9 @@ extern int __do_adjtimex(struct __kernel_timex *txc,
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
-extern void ntp_notify_cmos_timer(void);
+extern void ntp_notify_cmos_timer(bool offset_set);
 #else
-static inline void ntp_notify_cmos_timer(void) { }
+static inline void ntp_notify_cmos_timer(bool offset_set) { }
 #endif
 
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..7e6f409bf311 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2553,6 +2553,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
+	bool offset_set = false;
 	bool clock_set = false;
 	struct timespec64 ts;
 	unsigned long flags;
@@ -2575,6 +2576,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		if (ret)
 			return ret;
 
+		offset_set = delta.tv_sec != 0;
 		audit_tk_injoffset(delta);
 	}
 
@@ -2608,7 +2610,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 
-	ntp_notify_cmos_timer();
+	ntp_notify_cmos_timer(offset_set);
 
 	return ret;
 }
-- 
2.45.2


