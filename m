Return-Path: <linux-kernel+bounces-568618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB3A69876
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFE8171204
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE420C469;
	Wed, 19 Mar 2025 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlkkkgUh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6E20AF62
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410495; cv=none; b=hIgs72hPciWQd1SL8MWc1Fmmk3ikfNYkko7S3C8UN85p4qLrbO46iQeKxkxCe4hYh+xxKIrAoULwPjXtxh9a3K5mw3oK2uXVr/xnwC5rTY3QBsxa3yk571lhqHazSYpPS0KkxhmwV6nwlW64AlxQ3zI0E2cj073QhDzhl1cdUGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410495; c=relaxed/simple;
	bh=Pbf/VZjIfX+bfHHffNdf4WyrWfdv1PKUzGXbIQWfiBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r33kz8iES2rAhLxlz6VvM6guzwPLidW2luLplt9JqIBBMQ9o7zDJXsf/+F4SvK7OqHH2zSt11I1cycAXTlryJSRd333mM52lFWC4YqzbH0Ihh1iCCNEt6bfF61my1De8hLrVnT6Ev3IOKs9fazpa4Iwl+Z3tlTTV3yhikp9gS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlkkkgUh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso36446415e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742410492; x=1743015292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qeu7mi12nSRNz+lmS8wmHof0NIUveqgYhZ0cXhZyn1Y=;
        b=jlkkkgUhYmKguKUhVPQKcZY7U3x2ekNHKdk12yFYQY7ecSjYsj2kM1YLN1tzpUbrv8
         sCymkiZjskKh9fcYi1OpEpGTxbZ/CqrtWmzO7D+oQvXfw/ilJugV4gcHk6sz2OrDJdnA
         zaV5nbJLRVIx0o6nQDjBBGSDukz2WvS7iM5QiWFLaz4qIb8oYPJoWtrHoNPE97TQioPc
         bwoTFbb0KmmauSBx8e6ZU42ZZfVkeoNGBbQslsQMCFOZvcVV0ETxPD3YzMvWAR54Xzkd
         5FGigmX6Trg/RRLT8fz0fzatnaFKCbwG+184jfieveqEJZjz3a6hr1OM7MW5j7P8soYo
         gRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410492; x=1743015292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qeu7mi12nSRNz+lmS8wmHof0NIUveqgYhZ0cXhZyn1Y=;
        b=wLH2ONt687lWv22ZSF0iJAON9+1ii+Sp9D9yeRB7k6RZmicEsd2GuKLsUUI3LF+ID5
         KAPZWhPU3eRrZRGpDDShxebutlm8hCfLdd8CiOyJiqsEdvQtOT/ghBxJknjH22V5JcUU
         /wc2kBgHs0HsW2DYGh513ZTQDGZOJRhb+UFiZw7j75oGfNO59fkDpUriBNfCvjRkD6Gy
         kIoi01LyZEVHUX0ga+vcTshJc6TTAKZSJp2cWmQBG29zGLfOQa+F/NKdn/PFZtKKC93g
         9oD8xY8O8UrSHZsgWwEyJ1aAXNvssKDNF/ObqP9rthPa/tKP63yobL7ehcWRWQFaCc9O
         jVPA==
X-Forwarded-Encrypted: i=1; AJvYcCXw/5p/4tHemk+E8pTwbpTNJC8QMx2OGB+oJ/cz2UUnPPWSly+eLYHo5KxWNOrl31YUW3j7uBJXPpS/R34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7mUf2odoXiHSH0MIUIrrjEz3tu3jHYkadAIaFyJGbPkJ1o/C
	5xJEo9wm7JAyd/xMW8no/4WW8alO4d/XIy5FbFm9G/T75QS+AYpd
X-Gm-Gg: ASbGncttpCZ4+K06ylOHpbEvtrgC9+Q265XmvHGY0uDQvT6v/sEwPl0SuOuvQQXn0Xl
	UBbDqws65q5LmME6OPwgFNFvxKb5tFysqb1JI4CrsMQmLbp2eO/OzdGLh/iu0dkd6UnKvb3wv7Y
	nFsQ6x2W6cgaspURe8iDxVvftr1C4TIwjtUKNRImimcHhoIxrhtr9T/NKt/fhzSEEf243AYFU+5
	Sj5UbFWB2yY2x/0sgH7q5aoW2jl7nvFRlWxfIdIM5J46Ormtt79dsSPg3ERXEjOn3fmy2D0kY6x
	uL7ipta3+fyKHT1RghRn37yvWZJJrIj++ZbZaEtzUWDqaWNwxryOGMCjAYJnY4k=
X-Google-Smtp-Source: AGHT+IGR16/RwLEHMnVZoPiOvqhT0VgNC25Qw/sltnwMUD+lCx6cnC0gS2MeBgHX2g/BZTILLDWNaQ==
X-Received: by 2002:a05:600c:1c19:b0:43d:16a0:d82c with SMTP id 5b1f17b1804b1-43d437822b6mr32745955e9.2.1742410491630;
        Wed, 19 Mar 2025 11:54:51 -0700 (PDT)
Received: from f.. (cst-prg-67-174.cust.vodafone.cz. [46.135.67.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm26332305e9.33.2025.03.19.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:54:50 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: oleg@redhat.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] exit: combine work under lock in synchronize_group_exit() and coredump_task_exit()
Date: Wed, 19 Mar 2025 19:54:33 +0100
Message-ID: <20250319185433.1859030-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces single-threaded overhead as it avoids one lock+irq trip on
exit.

It also improves scalability of spawning and killing threads within one
process (just shy of 5% when doing it on 24 cores on my test jig).

Both routines are moved below kcov and kmsan exit, which should be
harmless.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- push the routines after kcov and kmsan

I kept them separate, imo that's cleaner and might help pull up more
work later.

If you are ok with the patch as a whole, but want cosmetic changes, I
think it will be the fastest if you just do them yourself and submit
your own version. I don't need credit, feel free to steal the bench
result.

Alternativele, should you want to bench yourself:
plop into will-it-scale/tests/threadspawn1.c:

#include <assert.h>
#include <pthread.h>

char *testcase_description = "Thread creation and teardown";

static void *worker(void *arg)
{
        return (NULL);
}

void testcase(unsigned long long *iterations, unsigned long nr)
{
        pthread_t thread;
        int error;

        while (1) {
                error = pthread_create(&thread, NULL, worker, NULL);
                assert(error == 0);
                error = pthread_join(thread, NULL);
                assert(error == 0);
                (*iterations)++;
        }
}

 kernel/exit.c | 72 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f97a2bbc9db9..055f645b3ab1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -412,9 +412,9 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 	}
 }
 
-static void coredump_task_exit(struct task_struct *tsk)
+static struct core_state *coredump_task_exit_prep(struct task_struct *tsk)
 {
-	struct core_state *core_state;
+	lockdep_assert_held(&tsk->sighand->siglock);
 
 	/*
 	 * Serialize with any possible pending coredump.
@@ -423,33 +423,37 @@ static void coredump_task_exit(struct task_struct *tsk)
 	 * will increment ->nr_threads for each thread in the
 	 * group without PF_POSTCOREDUMP set.
 	 */
-	spin_lock_irq(&tsk->sighand->siglock);
 	tsk->flags |= PF_POSTCOREDUMP;
-	core_state = tsk->signal->core_state;
-	spin_unlock_irq(&tsk->sighand->siglock);
-	if (core_state) {
-		struct core_thread self;
-
-		self.task = current;
-		if (self.task->flags & PF_SIGNALED)
-			self.next = xchg(&core_state->dumper.next, &self);
-		else
-			self.task = NULL;
-		/*
-		 * Implies mb(), the result of xchg() must be visible
-		 * to core_state->dumper.
-		 */
-		if (atomic_dec_and_test(&core_state->nr_threads))
-			complete(&core_state->startup);
+	return tsk->signal->core_state;
+}
 
-		for (;;) {
-			set_current_state(TASK_IDLE|TASK_FREEZABLE);
-			if (!self.task) /* see coredump_finish() */
-				break;
-			schedule();
-		}
-		__set_current_state(TASK_RUNNING);
+static void coredump_task_exit_finish(struct task_struct *tsk,
+				      struct core_state *core_state)
+{
+	struct core_thread self;
+
+	if (likely(!core_state))
+		return;
+
+	self.task = current;
+	if (self.task->flags & PF_SIGNALED)
+		self.next = xchg(&core_state->dumper.next, &self);
+	else
+		self.task = NULL;
+	/*
+	 * Implies mb(), the result of xchg() must be visible
+	 * to core_state->dumper.
+	 */
+	if (atomic_dec_and_test(&core_state->nr_threads))
+		complete(&core_state->startup);
+
+	for (;;) {
+		set_current_state(TASK_IDLE|TASK_FREEZABLE);
+		if (!self.task) /* see coredump_finish() */
+			break;
+		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
 }
 
 #ifdef CONFIG_MEMCG
@@ -878,7 +882,8 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	struct sighand_struct *sighand = tsk->sighand;
 	struct signal_struct *signal = tsk->signal;
 
-	spin_lock_irq(&sighand->siglock);
+	lockdep_assert_held(&sighand->siglock);
+
 	signal->quick_threads--;
 	if ((signal->quick_threads == 0) &&
 	    !(signal->flags & SIGNAL_GROUP_EXIT)) {
@@ -886,24 +891,27 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 		signal->group_exit_code = code;
 		signal->group_stop_count = 0;
 	}
-	spin_unlock_irq(&sighand->siglock);
 }
 
 void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
+	struct sighand_struct *sighand = tsk->sighand;
+	struct core_state *core_state;
 	int group_dead;
 
 	WARN_ON(irqs_disabled());
-
-	synchronize_group_exit(tsk, code);
-
 	WARN_ON(tsk->plug);
 
 	kcov_task_exit(tsk);
 	kmsan_task_exit(tsk);
 
-	coredump_task_exit(tsk);
+	spin_lock_irq(&sighand->siglock);
+	synchronize_group_exit(tsk, code);
+	core_state = coredump_task_exit_prep(tsk);
+	spin_unlock_irq(&sighand->siglock);
+
+	coredump_task_exit_finish(tsk, core_state);
 	ptrace_event(PTRACE_EVENT_EXIT, code);
 	user_events_exit(tsk);
 
-- 
2.43.0


