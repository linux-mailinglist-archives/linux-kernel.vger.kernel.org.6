Return-Path: <linux-kernel+bounces-274775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB5947C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A70B2169D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167F7139CFF;
	Mon,  5 Aug 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="J4qaqR0D"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F780631
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866992; cv=none; b=QeAI02OBBFOf9tUAG1KZKU4M4Db/i+SufPA8SdEF5tlcWSEo2bxabyrGocRNkS/kQcmYOihmta7a8VefmaHrfkRHPXzWpfj1DDg935wLbKBAKSi3mHfQcp8eR3IOU6Xscb69sJrw/mnzzHwGi1InaGEPmw0fgkEeMVWvMBVq8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866992; c=relaxed/simple;
	bh=X2A35lPHw0nMF+vJCFZrhHC1hh8zXDG7UPxBKAS5+Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oVZ7IgUJg9ZpsfV8KaQru3GOLjGxa/R8WePxeo2DTtt3jIbC3yyujK393Ppm/HDNQ6/YWxkHaYvXZnKxJp/lOlYXmcZIMiuN+gTC9NZFTjjpikAXyngun6P5Y+q7pomZe8Zv29x54gUFmv7b87LiOdkosCxFT+qtkUffKDXmuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=J4qaqR0D; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240805140940ac95eb8b929fed6eae
        for <linux-kernel@vger.kernel.org>;
        Mon, 05 Aug 2024 16:09:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=efEiMeR14DlOUKlOcoXz29JjldjKUG7RWy7Rwu0IWnY=;
 b=J4qaqR0D2ZdTDBlRvNc+91DYOWwScI8riUXJdp5OdU4jXriTg7RMcRtO14X5dwJ3XleaP0
 75Y2vp2r/+CbFtQzZZfyNL4dJIkIxPgch3OT6WEBLw0Mab+iH5JVZIFz2Pn0lqt5kJzMjS0i
 hUGvl8s9ef4om54xXQRcHG1l/8C5YSD31cax/r1EJnSFKN/eSkQsrXPVYetTsMZ2iBnwi4Ur
 b2xieU/KcSfWj6prSvjLAg+CtAL95vaSFTdj0cFajZWYVVTM0rmnlm5S13v2DBUTqsxu0rPP
 v5F+V5zbNMe5l81bXczvQjVrnRXGqebgffNhOJGuXv5csi+9YgP5oGUw==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	jan.kiszka@siemens.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	qyousef@layalina.io,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] hrtimer: Ignore slack time for RT tasks in hrtimer_start_range_ns()
Date: Mon,  5 Aug 2024 16:09:30 +0200
Message-Id: <20240805140930.29462-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240805140930.29462-1-felix.moessbauer@siemens.com>
References: <20240805140930.29462-1-felix.moessbauer@siemens.com>
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
changed the internal wait implementation, exposing this oversight.

Make the timer slack consistent across all hrtimer programming code,
by ignoring the timerslack for tasks with rt policies also in the last
remaining location in hrtimer_start_range_ns().

Cc: stable@vger.kernel.org
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kernel/time/hrtimer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d4..e8b44e7c281f 100644
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
+	if (task_is_realtime(current))
+		delta_ns = 0;
+
 	if (__hrtimer_start_range_ns(timer, tim, delta_ns, mode, base))
 		hrtimer_reprogram(timer, true);
 
-- 
2.39.2


