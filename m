Return-Path: <linux-kernel+bounces-383788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327149B2037
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5831F210BB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A816CD35;
	Sun, 27 Oct 2024 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="uJBRm17l"
Received: from 6.mo565.mail-out.ovh.net (6.mo565.mail-out.ovh.net [46.105.42.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F31741CB
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.42.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059822; cv=none; b=CNCnSW+YW/QKIklAzNMRZbOLb5Yy758z3luiVkPekG7ILnwivwf2i5Ilp/PIoACY7ir2ZcDbPPr+dmBsEDRnjI6eVDaArPNne+n0f75V3Z76VN1uDlJe3WGkp8XV5N9tsB+Wq6pk4pxV0JpO/4MGxz91V/ZkWGpH2StPbWjVj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059822; c=relaxed/simple;
	bh=bNRDXIV+41eqVfAPvbrIhRHeVVJjpRiCDhf2tqgGHUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uo8z7Q3qdTwhtTPrZgqsw/pphKfX+8ogkOZaUBU+4dbRq2K89xtb2fSuVZCu78ugP4LX5RW4yy3DKhzwwkYQ9lCh4Fcba6b87mQcaU2n2xe9VfETTc1/kvuYAAYHsQV+oSEzZttZtd5jLLMB+XzhnQCo5IeGJUb+WhdgJWPJaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr; spf=pass smtp.mailfrom=benjarobin.fr; dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b=uJBRm17l; arc=none smtp.client-ip=46.105.42.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjarobin.fr
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo565.mail-out.ovh.net (Postfix) with ESMTPS id 4Xc3m7061rz17ft;
	Sun, 27 Oct 2024 17:43:51 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <dev@benjarobin.fr>; Sun, 27 Oct 2024 17:43:50 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.108.25.204])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4Xc3m666W1z86Jg;
	Sun, 27 Oct 2024 17:43:50 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.7])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 2AFC83A2FB8;
	Sun, 27 Oct 2024 17:43:50 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-102R004b548d6e0-a6d5-431e-a3a2-269e5c452146,
                    DC00860D008CF58309D7786EEAF0FFC46D55EBDA) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp:92.161.126.4
From: Benjamin ROBIN <dev@benjarobin.fr>
To: jstultz@google.com,
	tglx@linutronix.de
Cc: sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH v2] ntp: Make sure RTC is synchronized for any time jump
Date: Sun, 27 Oct 2024 18:43:35 +0100
Message-ID: <20241027174335.60261-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8923319712839056347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejiedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegvnhhjrghmihhnucftqfeukffpuceouggvvhessggvnhhjrghrohgsihhnrdhfrheqnecuggftrfgrthhtvghrnhephefhgfejkefhleejteeukedtteduhfehfeeuhfekjefgiefhjeefueevieegtedunecukfhppeduvdejrddtrddtrddupdelvddrudeiuddruddviedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohephedprhgtphhtthhopeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehieehpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=mwaq4KOhuwBhIooj5c+K8AbP1aH1KGU1mC+50S0ruR4=;
 c=relaxed/relaxed; d=benjarobin.fr; h=From; s=ovhmo1728415-selector1;
 t=1730051031; v=1;
 b=uJBRm17lTi788EQo/uyCfaDHn3ksfaWlmq3XJRwu7yQPepRh6JC8viJ0hTiFiEv9oTjZnnWo
 PZjrh4aTrw4MPtGydV+UQjLKHmjQ1Xhcek0drOoK07ybbiICuqS7V+fg45cQ5XNn5zwCVhJqXI5
 7rKEjqyAOiJT1vzsyoynkjtgfEXIfE3nTpf+PWPHk5BQ6j3X0rjlKFc8SShKNNEll/vvR6ufzfl
 Mph8oGpKBtukAnrPeNQHOcDwpJdHvSKKz456BJCQlzTwxFvQCKKhUyAUEB/af93dvQZWKSG0ZZ4
 qjxSVVArrhIRjqDxWsrHkgW1k4duzWZKWGV33T5wFOnvw==

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
 kernel/time/timekeeping.c  | 11 ++++++++---
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index b550ebe0f03b..d91074633c83 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -657,14 +657,14 @@ static void sync_hw_clock(struct work_struct *work)
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
index 17cae886ca82..e44e500b694c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1536,6 +1536,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
+	ntp_notify_cmos_timer(true);
 
 	audit_tk_injoffset(ts_delta);
 	add_device_randomness(ts, sizeof(*ts));
@@ -1575,6 +1576,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
+	ntp_notify_cmos_timer(true);
 	return 0;
 }
 
@@ -1936,6 +1938,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
+	ntp_notify_cmos_timer(true);
 }
 #endif
 
@@ -2658,7 +2661,6 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct audit_ntp_data ad;
-	bool offset_set = false;
 	bool clock_set = false;
 	struct timespec64 ts;
 	int ret;
@@ -2680,7 +2682,6 @@ int do_adjtimex(struct __kernel_timex *txc)
 		if (ret)
 			return ret;
 
-		offset_set = delta.tv_sec != 0;
 		audit_tk_injoffset(delta);
 	}
 
@@ -2714,7 +2715,11 @@ int do_adjtimex(struct __kernel_timex *txc)
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 
-	ntp_notify_cmos_timer(offset_set);
+	/* Time jump (ADJ_SETOFFSET) is handled by timekeeping_inject_offset(),
+	 * which calls ntp_notify_cmos_timer() to cancel NTP sync hrtimer.
+	 * For the rest of do_adjtimex(), NTP sync flag is not cleared, so no
+	 * need to cancel NTP sync hrtimer here. */
+	ntp_notify_cmos_timer(false);
 
 	return ret;
 }
-- 
2.47.0


