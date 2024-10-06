Return-Path: <linux-kernel+bounces-352593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8A992132
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F357F1F210B6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D285D18BB95;
	Sun,  6 Oct 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="JUCT/g7q"
Received: from 8.mo574.mail-out.ovh.net (8.mo574.mail-out.ovh.net [46.105.72.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70417EAD8
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.72.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246902; cv=none; b=CbUZTJbkpaNHL4BxXvXGixRdjYV1njcb59QhlTdKUBAa85QYHUXuN7DMY0K8dFFoqoqyJZ/B9XnvskMP8+YBTZeaCs8d19IKN18UyCvtgqfqiYjgiXcXRWOaS6o7sAK8aPdudA5ikV5CtHy8wP6YcPhPUKN7fbHXqvSZmTNUy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246902; c=relaxed/simple;
	bh=TBKBxrgD5lGDxv+NJgXEB2b86P2iPNP408fWBGwlRDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCksEFaoD/cEGWjP9gXKhbFJUn0d1jr6b1ns9MJ1OJWXpmHNtBtZGmuKdZGlE2YTKgBOMxMjR/DJcW7dF5yLnyf/aVJbiVpXZfb5oCkhsiiDoUZD+PMqazPfHXZrYbZEo53hAURE9xBqMCrOkuBuj3PxqFLVwZMm9iMdBhnQ3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr; spf=pass smtp.mailfrom=benjarobin.fr; dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b=JUCT/g7q; arc=none smtp.client-ip=46.105.72.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjarobin.fr
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo574.mail-out.ovh.net (Postfix) with ESMTPS id 4XM7m22n8kz158m;
	Sun,  6 Oct 2024 16:58:58 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <dev@benjarobin.fr>; Sun,  6 Oct 2024 16:58:58 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.108.2.127])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4XM7m20brszHq2H;
	Sun,  6 Oct 2024 16:58:58 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.2])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 5E3A13A2EC2;
	Sun,  6 Oct 2024 16:58:57 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-106R0068c83a0ac-9c49-403b-8fa1-bc00b4c5bf9e,
                    562C85B86D3D78A264AE363F9EED7FE1148DE02A) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp:92.161.126.4
From: Benjamin ROBIN <dev@benjarobin.fr>
To: jstultz@google.com,
	tglx@linutronix.de
Cc: sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH] ntp: Make sure RTC is synchronized for any time jump
Date: Sun,  6 Oct 2024 18:58:05 +0200
Message-ID: <20241006165805.47330-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13966225395420838875
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvjedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegvnhhjrghmihhnucftqfeukffpuceouggvvhessggvnhhjrghrohgsihhnrdhfrheqnecuggftrfgrthhtvghrnhephefhgfejkefhleejteeukedtteduhfehfeeuhfekjefgiefhjeefueevieegtedunecukfhppeduvdejrddtrddtrddupdelvddrudeiuddruddviedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohephedprhgtphhtthhopeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeegpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=1zgBYfyiHe5o6Vy8vwBY0BNmexFQjCrl+f6tUeYY04w=;
 c=relaxed/relaxed; d=benjarobin.fr; h=From; s=ovhmo1728415-selector1;
 t=1728233938; v=1;
 b=JUCT/g7qwMkXNgEIxgUyyXFFKtcJJIIhD+aOErNApY8ffHZSfvqGI7bMbgzNQ9ZtK2IdJ40n
 sV9HsbGRZxPQyiwE1+3K5zvnhM3bIapNH4Sni4pU/JXklDOtcZC9/4WK0X/Mm6C7eSZ048E6Rjl
 LaV738MEifY7cYYD3OOnfDTanFcTAdx7a12RV2+CNi/erm3KPYHxwiq7T0ZqH3smszV9p0LuyNu
 /sI6lNtQNQ2bbU4QOZyyy/88UJg8L/Jfd+87KF52YHaLyFSR7cRrV2ydYpD2lE/JFD6nNjCmtY0
 B4Z709N6353NauzgHXqh3nDX/GahaTaXaw1pmDL3IDIQg==

Follow-up of commit 35b603f8a78b ("ntp: Make sure RTC is synchronized
when time goes backwards").

sync_hw_clock() is normally called every 11 minutes when time is
synchronized. This issue is that this periodic timer uses the REALTIME
clock, so when time moves backwards, the timer expires late.

If the timer expires late, which can be days later, the RTC will no longer
be updated, which is an issue if the device is abruptly powered OFF during
this period. When the device will restart (when powered ON), it will have
the date prior to the time jump.

This follow-up handles all kernel API (syscall) that can trigger a time
jump. Cancel periodic timer on any time jump, if and only if STA_UNSYNC
flag was previously set (net_clear() was called).

The timer will be relaunched at the end of ntp_notify_cmos_timer() if
NTP is synced again somehow: This is possible since stopping the timer is
done outside of a locked section. Otherwise the timer will be relaunched
later when NTP is synced. This way, when the time is synchronized again,
the RTC is updated after less than 2 seconds.

Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
---
 kernel/time/ntp.c          | 10 +++++-----
 kernel/time/ntp_internal.h |  4 ++--
 kernel/time/timekeeping.c  |  7 ++++---
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 802b336f4b8c..b296c71af09b 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -660,14 +660,14 @@ static void sync_hw_clock(struct work_struct *work)
 	sched_sync_hw_clock(offset_nsec, res != 0);
 }
 
-void ntp_notify_cmos_timer(bool offset_set)
+void ntp_notify_cmos_timer(bool ntp_was_cleared)
 {
 	/*
-	 * If the time jumped (using ADJ_SETOFFSET) cancels sync timer,
-	 * which may have been running if the time was synchronized
-	 * prior to the ADJ_SETOFFSET call.
+	 * If time jumped (clock set), and if ntp_clear() was called,
+	 * cancels sync timer, which may have been running if time was
+	 * previously synchronized.
 	 */
-	if (offset_set)
+	if (ntp_was_cleared)
 		hrtimer_cancel(&sync_hrtimer);
 
 	/*
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 5a633dce9057..0615ed904119 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -14,9 +14,9 @@ extern int __do_adjtimex(struct __kernel_timex *txc,
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
-extern void ntp_notify_cmos_timer(bool offset_set);
+extern void ntp_notify_cmos_timer(bool ntp_was_cleared);
 #else
-static inline void ntp_notify_cmos_timer(bool offset_set) { }
+static inline void ntp_notify_cmos_timer(bool ntp_was_cleared) { }
 #endif
 
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e6f409bf311..602775aa24c7 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1472,6 +1472,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
+	ntp_notify_cmos_timer(true);
 
 	if (!ret) {
 		audit_tk_injoffset(ts_delta);
@@ -1522,6 +1523,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
+	ntp_notify_cmos_timer(true);
 
 	return ret;
 }
@@ -1897,6 +1899,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
+	ntp_notify_cmos_timer(true);
 }
 #endif
 
@@ -2553,7 +2556,6 @@ int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
-	bool offset_set = false;
 	bool clock_set = false;
 	struct timespec64 ts;
 	unsigned long flags;
@@ -2576,7 +2578,6 @@ int do_adjtimex(struct __kernel_timex *txc)
 		if (ret)
 			return ret;
 
-		offset_set = delta.tv_sec != 0;
 		audit_tk_injoffset(delta);
 	}
 
@@ -2610,7 +2611,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 
-	ntp_notify_cmos_timer(offset_set);
+	ntp_notify_cmos_timer(false);
 
 	return ret;
 }
-- 
2.46.1


