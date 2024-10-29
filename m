Return-Path: <linux-kernel+bounces-387793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3429B560D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259131C2278F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671F20A5EB;
	Tue, 29 Oct 2024 22:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="JEF0UwZ/"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD9818FDC5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242287; cv=none; b=ZvCTexkW3I+FUu04LYfObMoOBox2ni57hGw/v3h23mIW0ARz4fY+fkrJnVVVsQpkSSty9n/2wJSri+1YfONUhrw8xzrqXzDveKOFP4OkNgyGrmxYwVQn3oDxkznJAgDkZCAaqCAyQE9fuVGdmm0EOIAqooTQsFHrb+YcxXz4wQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242287; c=relaxed/simple;
	bh=mlKWtRpu7yrd4sXhq2NPVYsHThPHZWdtHpa2fbttkFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXDcaYpbct1mOb3v3Mh0FfTqwzwkCi9r3w3CfKJQYzGbAz8pY9gNL4qIB8F0cFe7L1ymek5XtMnMgdd+bnRO87jrI5eLBkwvze8KbEgjG0TpmbscRrP7CiX43h1iILumcUI2ykZvYJU6lP51usAlrXCoc0eRwXeY5iIXuvWWUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=JEF0UwZ/; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83abe4524ccso223668139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1730242283; x=1730847083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqf0bUbikeWvDlOlsdQyuQbSUCKyD7hXDY/0YfSasy0=;
        b=JEF0UwZ/GlGJuekpXKbj+m/uG46kuZLSK/N6ULnYjb1QNK2gboKYaoNgyx18KIsFCm
         nLlS5n1TT/VhKVXjMBeIW32FqB4SAQpl0bv3V6UNNn6acfHqgReu/z34Uy0FM65hRv4k
         jC7xfyzzJcmo9Yq6DSo4c73Cdb+9XicVI7RCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730242283; x=1730847083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aqf0bUbikeWvDlOlsdQyuQbSUCKyD7hXDY/0YfSasy0=;
        b=uH/zXLgCps5xvP9NEBf1pIWgdxPTyA1UHQqJaiyXRUBmRdWNp3Dk52nE8z3Pb1En8r
         xGTEFEF8H2FB0ZOsPm7nVp0DfL/c6FHxEa99PyLOW0Z1GuBO2q2hiXHuEIyKEsdWyuQ0
         /khyDdDXo35afF67PvvDzkqtYu4ysoG8iEMqdBifXZgfRteJF8IQ5JkaZHIcBHVqXIUB
         JuRaf+kkCe2kFL8rzDbGgP6MvCzBM2r+bnxe9u7NOo/u81FjAHS+eGMd7g7pihDMsdZd
         c837rofY9TkUgnHqccxYazsJe9UYDZyUPn8uyg84YeHYDyVvG1gTVal7eSSqfHu9Ukxf
         0A5Q==
X-Gm-Message-State: AOJu0YwuJwxX4/j5iPTpWkmR9XQ5lTEpplajKylmXSuv+DNdOALU8Gj4
	1fChQrxxRYH6qBXdGBUrUUSstNfSclOc++1WKTU7P41QoLR5kA13Uofq1RbquXeGRqaLHlplCeI
	m
X-Google-Smtp-Source: AGHT+IHFxK87znbZYIk6VMxNzlyQBvbf98xDKEdwn9+Z3mI7EInQUBoAhOBn9vGz9ShUCPmTWHoAOw==
X-Received: by 2002:a05:6e02:1c0d:b0:3a2:4cc4:cfd with SMTP id e9e14a558f8ab-3a4ed2ad0f7mr130885205ab.14.1730242283607;
        Tue, 29 Oct 2024 15:51:23 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (68.192.68.34.bc.googleusercontent.com. [34.68.192.68])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc727809afsm2553275173.134.2024.10.29.15.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:51:22 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Subject: [PATCH] dl_server: Reset DL server params when rd changes
Date: Tue, 29 Oct 2024 22:51:14 +0000
Message-ID: <20241029225116.3998487-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During boot initialization, DL server parameters are initialized using the
default root domain before the proper scheduler domains and root domains
are built. This results in DL server parameters being tied to the default
root domain's bandwidth accounting instead of the actual root domain
assigned to the CPU after scheduler topology initialization.

When secondary CPUs are brought up, the dl_bw_cpus() accounting doesn't
properly track CPUs being added since the DL server was started too early
with the default root domain. Specifically, dl_bw_cpus() is called before
set_cpu_active() during secondary CPU bringup, causing it to not account
for the CPU being brought up in its capacity calculations. This causes
subsequent sysfs parameter updates to fail with -EBUSY due to bandwidth
accounting using the wrong root domain with zeroed total_bw.

This issue also causes under-utilization of system capacity. With the fix,
we see proper capacity initialization and scaling as CPUs come online - the
total system capacity increases from CPU 0 to CPU 1 and continues scaling
up as more CPUs are added (from cap=1024 initially to cap=8192 with 8
CPUs). Without the fix, the capacity initialization was incomplete since
dl_bw_cpus() runs before the CPU is marked active in set_cpu_active(),
leading to CPUs not being properly accounted for in the capacity
calculations.

Fix this by tracking the last root domain used for the DL server and
resetting the server parameters when the root domain changes. This ensures
bandwidth accounting uses the correct, fully initialized root domain after
the scheduler topology is built.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Aashish Sharma <shraash@google.com>
Cc: Shin Kawamura <kawasin@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h   |  1 +
 kernel/sched/deadline.c | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1d5cc3e50884..427d1da79d05 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -695,6 +695,7 @@ struct sched_dl_entity {
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
 	dl_server_pick_f		server_pick_task;
+	struct root_domain		*last_rd;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a6..076b372f28b5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1627,21 +1627,26 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
+	int cpu = cpu_of(rq);
+	struct root_domain *rd = cpu_rq(cpu)->rd;
 
 	/*
 	 * XXX: the apply do not work fine at the init phase for the
 	 * fair server because things are not yet set. We need to improve
 	 * this before getting generic.
 	 */
-	if (!dl_server(dl_se)) {
+	if (!dl_server(dl_se) || dl_se->last_rd != rd) {
 		u64 runtime =  50 * NSEC_PER_MSEC;
 		u64 period = 1000 * NSEC_PER_MSEC;
 
+		dl_se->last_rd = rd;
 		dl_server_apply_params(dl_se, runtime, period, 1);
 
-		dl_se->dl_server = 1;
-		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
+		if (!dl_server(dl_se)) {
+			dl_se->dl_server = 1;
+			dl_se->dl_defer = 1;
+			setup_new_dl_entity(dl_se);
+		}
 	}
 
 	if (!dl_se->dl_runtime)
-- 
2.47.0.163.g1226f6d8fa-goog


