Return-Path: <linux-kernel+bounces-323062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D48973722
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53E0288007
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6518F2D6;
	Tue, 10 Sep 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgNb1kGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A01E493
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970986; cv=none; b=J4XT+N7tcZCclcMfo7EbNmTbSMS0PIrJ/fRoemfKELiQsIT4jZLAikc+KTZ+d4Mt3IBFuoGp9v9qQQHCodlUKXN31e3yo8wP+GYbCvz5UnkNdJb/mgYSYfnShh4+Lqcq3So7cWOsGxcYyefjPiut25bxszRtBWxIdc9NzY2KfHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970986; c=relaxed/simple;
	bh=pBHA4ep9yuT3OwfweqSXg7EcX3pYq2G1MrnYO+yVlak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAPGwb9MNh2gxURBapB6kuIEQT9eJhzIS8P0XxyLja1GxDgvODYojpGCt9YbnSNTb4dnbTwfMe5RJA0RpYAsWpkpI9EP60k7yD23fnAtqFRrFnzvI3qBefb2FF7EkfPfEAaR2n/eOzZtIjuR7vGy8sPIwodY/sV9tMcRBv+6n60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgNb1kGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA2CC4CEC6;
	Tue, 10 Sep 2024 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725970985;
	bh=pBHA4ep9yuT3OwfweqSXg7EcX3pYq2G1MrnYO+yVlak=;
	h=From:To:Cc:Subject:Date:From;
	b=PgNb1kGNj1gxKkFLSHZO9r+fa86r5vyDTblip+QjxmNtQTGDhZsswCVOve5zlh3bZ
	 G2ZXrm7usVqk/lvc66zFmyXumNIUo9ERH5oQrQ9FtEagYAPoYsSnLEWKEUTdTPhEJh
	 ea0FUDQLIye0sRYV0gt26XjEUFISLJqi3NvQm5RyiS9/PXP/0iDk2sN1C+fcYT5NE9
	 uvBLNGasVAepRkL/EaFTtop9NJ8qGb4rCcOoDp1hKomWxG3bIUJQ6Kl8CEr/rPlpaH
	 DEaaZmNw7TB0o9jC4p2R58A5vhHlskf0wCuU1NW06PwxgFLXJqbM/u7ZUUbdeR94gV
	 j/+lymBdRDBmA==
From: Mario Limonciello <superm1@kernel.org>
To: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] alarmtimer: Use aie_timer from RTC device instead of own timer
Date: Tue, 10 Sep 2024 07:22:58 -0500
Message-ID: <20240910122258.129540-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

It was reported that suspend-then-hibernate stopped working with modern
systemd versions on an AMD Cezanne system. The reason for this breakage
was because systemd switched to using alarmtimer instead of the wakealarm
sysfs file.

The wakealarm sysfs file programs the time to the `rtc->aie_timer` member
of the RTC, whereas the alarmtimer suspend routine programs it to it's
own device.

On AMD Cezanne systems rtc_read_alarm() is used to program a secondary
timer with the value of the timer. This behavior was introduced by
commit 59348401ebed9 ("platform/x86: amd-pmc: Add special handling
for timer based S0i3 wakeup").

As rtc_read_alarm() uses the `rtc->aie_timer` to report the cached
timer no alarm is provided as enabled.

To fix this issue, drop the use of a dedicated timer for the alarmtimer
and instead use `rtc->aie_timer` in the alarmtimer suspend/resume routines.

Link: https://github.com/systemd/systemd/commit/1bbbefe7a68059eb55d864c3e0e670d00269683a
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3591
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 kernel/time/alarmtimer.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 5abfa4390673..26f291a14cdf 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -59,7 +59,6 @@ static DEFINE_SPINLOCK(freezer_delta_lock);
 
 #ifdef CONFIG_RTC_CLASS
 /* rtc timer and device for setting alarm wakeups at suspend */
-static struct rtc_timer		rtctimer;
 static struct rtc_device	*rtcdev;
 static DEFINE_SPINLOCK(rtcdev_lock);
 
@@ -123,11 +122,6 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	return ret;
 }
 
-static inline void alarmtimer_rtc_timer_init(void)
-{
-	rtc_timer_init(&rtctimer, NULL, NULL);
-}
-
 static struct class_interface alarmtimer_rtc_interface = {
 	.add_dev = &alarmtimer_rtc_add_device,
 };
@@ -144,7 +138,6 @@ static void alarmtimer_rtc_interface_remove(void)
 #else
 static inline int alarmtimer_rtc_interface_setup(void) { return 0; }
 static inline void alarmtimer_rtc_interface_remove(void) { }
-static inline void alarmtimer_rtc_timer_init(void) { }
 #endif
 
 /**
@@ -287,7 +280,7 @@ static int alarmtimer_suspend(struct device *dev)
 	trace_alarmtimer_suspend(expires, type);
 
 	/* Setup an rtc timer to fire that far in the future */
-	rtc_timer_cancel(rtc, &rtctimer);
+	rtc_timer_cancel(rtc, &rtc->aie_timer);
 	rtc_read_time(rtc, &tm);
 	now = rtc_tm_to_ktime(tm);
 
@@ -304,7 +297,7 @@ static int alarmtimer_suspend(struct device *dev)
 	now = ktime_add(now, min);
 
 	/* Set alarm, if in the past reject suspend briefly to handle */
-	ret = rtc_timer_start(rtc, &rtctimer, now, 0);
+	ret = rtc_timer_start(rtc, &rtc->aie_timer, now, 0);
 	if (ret < 0)
 		pm_wakeup_event(dev, MSEC_PER_SEC);
 	return ret;
@@ -316,7 +309,7 @@ static int alarmtimer_resume(struct device *dev)
 
 	rtc = alarmtimer_get_rtcdev();
 	if (rtc)
-		rtc_timer_cancel(rtc, &rtctimer);
+		rtc_timer_cancel(rtc, &rtc->aie_timer);
 	return 0;
 }
 
@@ -944,8 +937,6 @@ static int __init alarmtimer_init(void)
 	int error;
 	int i;
 
-	alarmtimer_rtc_timer_init();
-
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
 	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
-- 
2.43.0


