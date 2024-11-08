Return-Path: <linux-kernel+bounces-402144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C96E9C2467
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF5F1C2130C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CB721C168;
	Fri,  8 Nov 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="j6f6gzk0"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5591A9B37
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088132; cv=none; b=XAfn+w5nofT2pTa6MVt6tWtjhnzC24XdEmueKNY8SBiDyotIFBzWcno9wP76eCAg3ivOrz7X587lJ91zw+6qnpSZ/5kBPg1BsnMhV6tQmh2O9XqhU4npvo+eDODUH4mGtV0W/yBSssQMRXQTALdah1MyE81MxYggbOQ9wnnezqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088132; c=relaxed/simple;
	bh=tmFq8a+ZAxdOgfeOQxZHaNcqzEsFbHUZQrCFrrD8SYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QscXSFVDN2iadKkSDKHrcXcA01jYwQqeRIbz1CYPxKPlMZgxaK4LJVdyn6pKa3zy/2JFfKQj9X44DTJo0PMmKqAMIhYhbarpJT/zpJlY1Nvsep7fun1gvodg9kr5HwXdkhrbtiVzBLIevSVLKynDIL48tTLGjBk0HiTVpnfqj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=j6f6gzk0; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83aad4a05eeso91431639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731088129; x=1731692929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51zFNAixGSsd9ALX5NS0WV/Z/XAO7RyEwGQJD2JSoVM=;
        b=j6f6gzk0VrAxWFGLJ3bz9Vxcsgo/6jOTG0laY4WprNXOBkmbtOEZ7NGJP1z1vT3MRf
         66Mhw2zaHsnjRtygtvyEZ4nAdf86nYBxlOj1euWhSaTORwMXcg6a9oGvSFKBbevTSuMg
         6qsSeIa73OAB3wwO3qqjq9PBACJSC8U8suA/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088129; x=1731692929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51zFNAixGSsd9ALX5NS0WV/Z/XAO7RyEwGQJD2JSoVM=;
        b=KHjVKAXgD7F5sXJ35WQnqKrhAZ+elxcpQNQ2W26SA8c1zCL1WFsXQurpgOospy+YHc
         4Y6THK2p33TkxzFUY2dssq2QjvzdBVEMuDzz951yzLuH0glwyQC5J/NlqdU6EcpVEs7m
         XIubIXZiSfIxg5ajbUua9nvpnh5QgwZSzdilZgFWnJ/3rvo7LXNHpo32aLejBt4wCtqc
         z2aXhr1vplSn0NO46OKvkWqm4N/k1C94Symi27yvLUfmpwgbEyEpzDseelZ8oXehdDtH
         PRUxbRqxVvQQyKMBVS9dhb79eQtp+Nf0qrfjbUzmGB5Rp/g/zfQRUdChgaoOxQRk2F82
         WR/g==
X-Gm-Message-State: AOJu0Yz+kizYt0qLJZLUsNfCy600JcyDDIjlbdsmtLZ9xqtJ2n0Okw+G
	9rnRJmvMMfwsqhWahtZpBlzHEAt15no23byKsy4BoVmuZU+H9qBdJdud3r/iXo8zO0c5T5Bo0ou
	h
X-Google-Smtp-Source: AGHT+IH4kmeAX/ogEJUE0aSZ5tgef2/OtRkzMBTW1yI8mtzM0hYiXrymeKzfi/TGoKvFM+2wiYuTKQ==
X-Received: by 2002:a05:6e02:1a65:b0:3a6:c1ad:3a02 with SMTP id e9e14a558f8ab-3a6f1a556ddmr42001355ab.24.1731088129371;
        Fri, 08 Nov 2024 09:48:49 -0800 (PST)
Received: from joelboxx5.c.googlers.com.com (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f8e41easm918119173.136.2024.11.08.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:48:48 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick from now
Date: Fri,  8 Nov 2024 17:48:34 +0000
Message-ID: <20241108174839.1016424-2-joel@joelfernandes.org>
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

During tick restart, we use last_tick and forward it past now.

Since we are forwarding past now, we can simply use now as a reference
instead of last_tick. This patch removes last_tick and does so.

This patch potentially does more mul/imul than the existing code,
as sometimes forwarding past now need not be done if last_tick > now.
However, the patch is a cleanup which reduces LOC and reduces the size
of struct tick_sched.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/time/tick-sched.c | 7 ++-----
 kernel/time/tick-sched.h | 1 -
 kernel/time/timer_list.c | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..52a4eda664cf 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -837,11 +837,9 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
 static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 {
+	/* Set the time to expire on the next tick and not some far away future. */
 	hrtimer_cancel(&ts->sched_timer);
-	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
-
-	/* Forward the time to expire in the future */
-	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC) * TICK_NSEC);
 
 	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES)) {
 		hrtimer_start_expires(&ts->sched_timer,
@@ -1043,7 +1041,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		calc_load_nohz_start();
 		quiet_vmstat();
 
-		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
 		tick_sched_flag_set(ts, TS_FLAG_STOPPED);
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index b4a7822f495d..7210cc473855 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -71,7 +71,6 @@ struct tick_sched {
 
 	/* Tick handling */
 	struct hrtimer			sched_timer;
-	ktime_t				last_tick;
 	ktime_t				next_tick;
 	unsigned long			idle_jiffies;
 	ktime_t				idle_waketime;
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 1c311c46da50..26688a3b8ea8 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -154,7 +154,6 @@ static void print_cpu(struct seq_file *m, int cpu, u64 now)
 		struct tick_sched *ts = tick_get_tick_sched(cpu);
 		P_flag(nohz, TS_FLAG_NOHZ);
 		P_flag(highres, TS_FLAG_HIGHRES);
-		P_ns(last_tick);
 		P_flag(tick_stopped, TS_FLAG_STOPPED);
 		P(idle_jiffies);
 		P(idle_calls);
-- 
2.47.0.277.g8800431eea-goog


