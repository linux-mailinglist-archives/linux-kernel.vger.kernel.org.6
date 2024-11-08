Return-Path: <linux-kernel+bounces-402147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD71A9C246B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E8E285EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3402259E0;
	Fri,  8 Nov 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z6IydHdt"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38292245F5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088134; cv=none; b=BKMjbzXSoPYjCQQ80g1281xq8eL9sJD7DHiSAQXjeaNwk8+Boyxbjyaihj2vY2GAjmV5OoXxmKM+xhFILQintKruqU61zr9M/0w5Vwl4vsPYjaYLmVGaoNLeGlZCdgHuxrVXlR0rZH7FeWTu6oeQXfI2DoQpL44jGDsxfulj4C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088134; c=relaxed/simple;
	bh=nKHMcWayOScOxZEyAqzNq46KOGIDWVjkP+eAfDEo2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chGnjVX5n0K+MUXPvFAiyA8jAiZeYaypBaTzSjOF+iOIhHtDcvd7zfn5mozOk6JTGfF53E50VX9+3iTvnHQTSHbpABNqAfoxVXJRzdemBAGXhlGQoaZV9wZIulwKLz1VUFPU1ooSGsNW7VUB8C+K1pmLE88uNQAFrGbbkdA+FtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Z6IydHdt; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83aad4a05eeso91433139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731088132; x=1731692932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zogpuYrLrV6p+Ie1T3jZzQiuF3EC5ETYsImm5LZPhdg=;
        b=Z6IydHdt82ocqpwpO0GiATMhnyaV0878s0xam7C62DGkau1pOMF4/AjBe0VAc2QtPm
         Wb5x5+L0GyFSzLAtlyhzg1bfglMn/ZbVLZd4vv3ivuhF0pw8nBOYXg3mUQ0axTWE4akd
         8KDm2W6SMihxuTfzRUZ2OXjVrIxxq9EeNShYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088132; x=1731692932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zogpuYrLrV6p+Ie1T3jZzQiuF3EC5ETYsImm5LZPhdg=;
        b=Wd2s6WE3PD81Ob4fudOUST85ge72FYgLfHgmdPekeeBLxm8Jh7dM3Jg7AYyz7xjKSZ
         mXYs03kIfID5JA7n3IeGjqzqBl+7XNs1w2EsKuoqM+o6x+utPRQ/HVVv2kSaxBCApxfS
         GMNtmr69hf0SoQBxtWl1GBux4hY6Tsg6hQaTAWNiL/YAzTlApTwrC4CKEmqqEMwsW2UR
         euMfZRVdA5a5M6GzhwOPce4j4GCpA6QmgKDz1VYCto88ObaQMsIbDOPgQ+XdwVkhWJcX
         PdicJqamutjdXMy+7rL+l6TWEhnedr4LvrM3qwRR1s6AI7cRJjMN0kO08enjHqWMraCN
         S7mg==
X-Gm-Message-State: AOJu0YyDDvGBo+oc/XcNOeEFsHr7RhjDmTtOAsn9jz+NuUTuBaPWchFd
	1Ifd5xwFAVRCLkvsNkwzc7NsRjvaIfqKi32CzvV3YVOne6XKdjzbt8MirGPAsdWGsIkq30NAqH4
	l
X-Google-Smtp-Source: AGHT+IEEkwswzUiadUN1E1foVhKVlckkwZrKWDJEpyl0L9fL9YRNg7SHx4yXMCTUbC0/MZzaITx3Pw==
X-Received: by 2002:a05:6602:3cb:b0:83a:b2c1:8b40 with SMTP id ca18e2360f4ac-83e033b15ddmr434444139f.13.1731088131772;
        Fri, 08 Nov 2024 09:48:51 -0800 (PST)
Received: from joelboxx5.c.googlers.com.com (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f8e41easm918119173.136.2024.11.08.09.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:48:51 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC 3/3] tick-sched: Replace jiffie readout with idle_entrytime
Date: Fri,  8 Nov 2024 17:48:36 +0000
Message-ID: <20241108174839.1016424-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241108174839.1016424-1-joel@joelfernandes.org>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This solves the issue where jiffies can be stale and inaccurate.

Putting some prints, I see that basemono can be quite stale:
tick_nohz_next_event: basemono=18692000000 basemono_from_idle_entrytime=18695000000

Since we have 'now' in ts->idle_entrytime, we can just use that. It is
more accurate, cleaner, reduces lines of code and reduces any lock
contention with the seq locks.

I was also concerned about issue where jiffies is not updated for a long
time, and then we receive a non-tick interrupt in the future. Relying on
stale jiffies value and using that as base can be inaccurate to determine
whether next event occurs within next tick. Fix that.

XXX: Need to fix issue in idle accounting which does 'jiffies -
idle_entrytime'. If idle_entrytime is more current than jiffies, it
could cause negative values. I could replace jiffies with idle_exittime
in this computation potentially to fix that.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/time/tick-sched.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4aa64266f2b0..22a4f96d9585 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -860,24 +860,6 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
-/*
- * Read jiffies and the time when jiffies were updated last
- */
-u64 get_jiffies_update(unsigned long *basej)
-{
-	unsigned long basejiff;
-	unsigned int seq;
-	u64 basemono;
-
-	do {
-		seq = read_seqcount_begin(&jiffies_seq);
-		basemono = last_jiffies_update;
-		basejiff = jiffies;
-	} while (read_seqcount_retry(&jiffies_seq, seq));
-	*basej = basejiff;
-	return basemono;
-}
-
 /**
  * tick_nohz_next_event() - return the clock monotonic based next event
  * @ts:		pointer to tick_sched struct
@@ -887,14 +869,19 @@ u64 get_jiffies_update(unsigned long *basej)
  * *%0		- When the next event is a maximum of TICK_NSEC in the future
  *		  and the tick is not stopped yet
  * *%next_event	- Next event based on clock monotonic
+ *
+ * Note: ts->idle_entrytime is updated with 'now' via tick_nohz_idle_enter().
  */
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo;
+	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo, boot_ticks;
 	unsigned long basejiff;
 	int tick_cpu;
 
-	basemono = get_jiffies_update(&basejiff);
+	boot_ticks = DIV_ROUND_DOWN_ULL(ts->idle_entrytime, TICK_NSEC);
+	basejiff = boot_ticks + INITIAL_JIFFIES;
+	basemono = boot_ticks * TICK_NSEC;
+
 	ts->last_jiffies = basejiff;
 	ts->timer_expires_base = basemono;
 
-- 
2.47.0.277.g8800431eea-goog


