Return-Path: <linux-kernel+bounces-274651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F6E947B1F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 933C6B218D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CE115ADA7;
	Mon,  5 Aug 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="SvVeTsqg"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2451598F4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861722; cv=none; b=Iyb914g2p5Tuq9oIMDRaUvW4BOlGJ1kO6bLRxWHEaYcQKD7X4ozB7gmzY2v6Lg8aEOKXir4K4gmSZAfQLZMvP4m2Gq6brevzm8rUHNrsinbHgsnmldbY72SwTvBD1aGNc4NOqLeWP9TtkDykTxHj33x8klAp0D/nNVdScMRf9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861722; c=relaxed/simple;
	bh=2oeDCd43gj3tEVG9acz79y7We8C38uo5aN+ARIR8P5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l9860e5mfrpKwq1HdPtX5sanOc6M0mHo3ENec1ppAfBZWcU0yDBFPqbZnG8ABekhzgXZe9b8K4H+Yq9xKRGRJlvDrToR/8iE1D7YAJSvDW4EL+529gEsrcgL/aM3BBPO010EMYv3v8irjfBseCIUSk9TtroNCDp+95tAenDfWSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=SvVeTsqg; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202408051241522dfffbfceef6f47042
        for <linux-kernel@vger.kernel.org>;
        Mon, 05 Aug 2024 14:41:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sS9nfVqlSth+qJIirvho6CZ3s4rCPhOH4Nl/w1oH1ms=;
 b=SvVeTsqgVS6d8YDOBWAVZD2yAZdKEZeXb78g4MnbhGBBl2pDGFbGZlt0iZ1TFQsczUxLQN
 qe1R4T9Q3ax6gJ0U2O3JyRjeudPavxH7B84CnQtWEtbFbJbRtly5yZoDrcVU4bQ5S1xcA8VU
 Rd0bybvZhs5KpyLL03CR11Jp+/vFk0Yz1aa0UFdfDWmNHKjdt6V0mfcnRL2veQZ+9+dJkNMA
 lCYYX2m4e95OScjG21PflqgrhJl6u25AdmNddoSrlBsbHEhBDdUMSEda8Q0JTIeDTz5lPPiv
 y42VhNgkbwPT4HsLV6kvjlyMOqjA3a8h4ftl2TXC86bg5ZViQ4ga0qow==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] hrtimer: Ignore slack time for RT tasks in hrtimer_start_range_ns()
Date: Mon,  5 Aug 2024 14:41:16 +0200
Message-Id: <20240805124116.21394-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240805124116.21394-1-felix.moessbauer@siemens.com>
References: <20240805124116.21394-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

RT tasks do not have any timerslack, as this induces jitter. By
that, the timer slack is already ignored in the nanosleep family and
schedule_hrtimeout_range() (fixed in 0c52310f2600).

The hrtimer_start_range_ns function is indirectly used by glibc-2.33+
for timed waits on condition variables. These are sometimes used in
RT applications for realtime queue processing. At least on the
combination of kernel 5.10 and glibc-2.31, the timed wait on condition
variables in rt tasks was precise (no slack), however glibc-2.33
changed the internal wait implementation, exposing the kernel bug.

This patch makes the timer slack consistent across all hrtimer
programming code, by ignoring the timerslack for rt tasks also in the
last remaining location in hrtimer_start_range_ns().

Similar to 0c52310f2600, this fix should be backported as well.

Cc: stable@vger.kernel.org
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kernel/time/hrtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2b1469f61d9c..1b26e095114d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1274,7 +1274,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
  * hrtimer_start_range_ns - (re)start an hrtimer
  * @timer:	the timer to be added
  * @tim:	expiry time
- * @delta_ns:	"slack" range for the timer
+ * @delta_ns:	"slack" range for the timer for SCHED_OTHER tasks
  * @mode:	timer mode: absolute (HRTIMER_MODE_ABS) or
  *		relative (HRTIMER_MODE_REL), and pinned (HRTIMER_MODE_PINNED);
  *		softirq based mode is considered for debug purpose only!
@@ -1299,6 +1299,10 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 
 	base = lock_hrtimer_base(timer, &flags);
 
+	/* rt-tasks do not have a timer slack for obvious reasons */
+	if (rt_task(current))
+		delta_ns = 0;
+
 	if (__hrtimer_start_range_ns(timer, tim, delta_ns, mode, base))
 		hrtimer_reprogram(timer, true);
 
-- 
2.39.2


