Return-Path: <linux-kernel+bounces-320289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE58970866
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41E6281065
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE96172BD8;
	Sun,  8 Sep 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="Q5mXnHSe"
Received: from 4.mo570.mail-out.ovh.net (4.mo570.mail-out.ovh.net [46.105.34.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075A29CF7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.34.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725808964; cv=none; b=jRHSJ0AgLbY1aTFN3nX+WqajlnY/vNFMPVKRXATGV0zrDjNY6p4HuNh97FVbcSPrZC4ov7jX8LTWNL6t4XXJUNI8P4yx783c3oTFU99ycM+kZ0q2KiGYlG3kFqnD4HRvTcV6+wuAklr0X67KimldFLFa5rHSa1mWGGkBFav2R0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725808964; c=relaxed/simple;
	bh=u4kBgFKSlXbCkUXGz42lbPGF6x7C0pMND/fPXCK1Zxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcvIABOWQOteScUdnjax6laTuWrackCIN/TEAoj1ySVVC9Y5/kj1BseqZbcR21ah78Q6ZpW7kJ1p1nTU/F4nA3RCShyWNgVEDK3oz65XWYz41iDDnH9a0yBs9Z41FWp6JtUOmotaZaNzF7qeT93FXG4lHP/EZ9SEByFqAab5hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr; spf=pass smtp.mailfrom=benjarobin.fr; dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b=Q5mXnHSe; arc=none smtp.client-ip=46.105.34.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjarobin.fr
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo570.mail-out.ovh.net (Postfix) with ESMTPS id 4X1p8w1Ttxz1984;
	Sun,  8 Sep 2024 11:46:56 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <dev@benjarobin.fr>; Sun,  8 Sep 2024 11:46:56 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.134])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4X1p8w0mPPzy9Z;
	Sun,  8 Sep 2024 11:46:56 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.0])
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 1E2D4D4344A;
	Sun,  8 Sep 2024 11:46:55 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-100R003afb73630-c69e-417c-a324-da5818aa7ab4,
                    2138D52549B61E75FE7EBB3F53CE47A04563795D) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp:92.161.126.4
From: Benjamin ROBIN <dev@benjarobin.fr>
To: tglx@linutronix.de,
	jstultz@google.com
Cc: sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	dev@benjarobin.fr
Subject: [PATCH v2] ntp: Make sure RTC is synchronized when time goes backwards
Date: Sun,  8 Sep 2024 13:45:58 +0200
Message-ID: <20240908114558.191176-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <87zfojcf8g.ffs@tglx>
References: <87zfojcf8g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10281717950186601435
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeihedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnjhgrmhhinhcutffquefkpfcuoeguvghvsegsvghnjhgrrhhosghinhdrfhhrqeenucggtffrrghtthgvrhhnpeehffekteejudduteejheelleekfefggeduveeiudejgfdufeetjeehleejuddvffenucfkphepuddvjedrtddrtddruddpledvrdduiedurdduvdeirdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepuggvvhessggvnhhjrghrohgsihhnrdhfrhdprhgtphhtthhopehjshhtuhhlthiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejtddpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=t7vhuYgFDQg6zcPD1XZL+YUt0A+ISaLMC5xsBSAZk1Y=;
 c=relaxed/relaxed; d=benjarobin.fr; h=From; s=ovhmo1728415-selector1;
 t=1725796016; v=1;
 b=Q5mXnHSeU4apsVwBruFiKYG3lVVnFFEePqOXtJrNCJ8Y5PBxVhayYgkKPTKKh5FHBMKvI9Av
 4RkpPnGaCUiughsE+Yq+udYAnYCEkDmbCU1rG/v1S6lKyP5U56btLuKalgZQ/gaUg4HKTMvWGzN
 LXCAJmWgKtsXitY+VBTHq2+70yMFWD7yQ0/XdUAnA+tWMg+J/K6fT6xOsPN2NJi5oiVk+63KpZM
 qiQa6dx16qFxy7vSYQ/kivoUmbeJVcwLIy6p+Pc/zic/X7tvIplO9f3oGzocvsU/vr+Qx8GEtT2
 uFbkPkC5jFoJCFhgTTRdoY/ZRzgawpu/fHrojZlzKhPVA==

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


