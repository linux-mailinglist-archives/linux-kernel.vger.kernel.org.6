Return-Path: <linux-kernel+bounces-233261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3060691B4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4802D1C216FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C921CF8D;
	Fri, 28 Jun 2024 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="boZGEkrl"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF417999
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719540621; cv=none; b=kFT4uaKvJ1Zrhx0iNh8j0/B4t2WDgNOgnnZEriAKe09KY+Ce4YV9slnDm31bvcGwvJXF/8WFnPsOxUUF2OgJnI3Mabp48QyCD8nwjfQ2ukGKsCGGc848+SMpRXw50Uckoous8N3AVBwNIWsMPg3nCPOunKg2hs5oxb0xw8jqdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719540621; c=relaxed/simple;
	bh=QkaSF5A9KMosmZloQcUgW8Q/hsAxDn1li1t/sAbp0FQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q2XUYsNVz7+0l91AoHnfAU4ZEsFevHpqDIrw/t2fPvy+g6ClW3tBpUcPI/bKa7aEcOx9bkLHy4QzOrBXBICBa1RMRyknMMo6m3+WDlFDNIDYUf+0pvAgD95yrO00r1UWKqFqi0/txgf8vE8TfxfzTgnhVgOzL1UOtYgQGdfkt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=boZGEkrl; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-37642e69d7eso1514165ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719540619; x=1720145419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=huWPnK1uLkj4Szurv4ShoZ3wTZ6ipU4nAKcPAprc9hg=;
        b=boZGEkrljNNp571l3OXNRVG7cvVGC+5CrlY3Zjw2KHkHo9cvyHyWGRI/i40X28lwym
         9hn3pb7PPIICStEzrsO7hE5j96f7YQnStmj530TJneb30DyhPfOYsneKNVuhv3ecLRxX
         AVW+t0XE3o49LXv3rN9ByxYCv2Xec5XgSlLPRHOs00L8nkKTfRmX1i/9VpdP4gIZs8fY
         GDI55EzSRqLgnn6aimdbpianH61Jww1nDzIrdrVaas748Hti0yem8QwW066VGdqjLgjm
         dda5yCLEUdh77J5PMRGYYXP6HHQ7Cu7M8FG/rRuwWNyew9DZzYxnyqJR2ThdUvCLGaeG
         8j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719540619; x=1720145419;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huWPnK1uLkj4Szurv4ShoZ3wTZ6ipU4nAKcPAprc9hg=;
        b=MlNZKUTwIYZlgnoD8FmUotRoVJB8YyC1SsvqQLqRR9Jzwwe33YXF2f98LvyUwm8/9p
         2r9X0oDIJZf7pA1lbLUFLhrovJxk1nAyvier6hJyP0r68gaFCExMVpQ1xcvy7nqKMdTh
         A3vO1S+P18XT4I8CyNM66knkykFQrAPR3stSt4o4GYq8hMDEteDZ3q/Hmdxl0Cem5leb
         sd+kf3GefIR8hvKjY7Xh7TY0AOVJV++uOBJxYacdBQ3Y3zN7DLrR7+jcsLhmfFHpmI78
         EVmpuCmu2wqG4pujIH8e/93IzkNYehc7fifSoRVjRxsD8H0EaQPQYDhWxlcAHD54Ktw8
         zccQ==
X-Gm-Message-State: AOJu0YxOQVr91xIc3C8r982pfSoqBvIRF5JWqpsbp/S2GiPW7iO4e+FF
	D8IObewyBJQYohcxRbyeG00UvBH9lyk2f8CSaaM/hxudV5NqEUgjdq96QFV/UNWBd29hff8vzSy
	tJA==
X-Google-Smtp-Source: AGHT+IEUDFyLCtWGzIFRBZlQ9Sdlt047pCjBFbfCUtAJWHlBva8lU0tMhsDkYHUs6C0VM8X4qLnIeCnl3xY=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6e02:152c:b0:375:a202:254d with SMTP id
 e9e14a558f8ab-3763df1be5amr16494845ab.1.1719540619142; Thu, 27 Jun 2024
 19:10:19 -0700 (PDT)
Date: Fri, 28 Jun 2024 02:10:12 +0000
In-Reply-To: <20240628021014.231976-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628021014.231976-1-avagin@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628021014.231976-3-avagin@google.com>
Subject: [PATCH 2/4] seccomp: release task filters when the task exits
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Previously, seccomp filters were released in release_task(), which
required the process to exit and its zombie to be collected. However,
exited threads/processes can't trigger any seccomp events, making it
more logical to release filters upon task exits.

This adjustment simplifies scenarios where a parent is tracing its child
process. The parent process can now handle all events from a seccomp
listening descriptor and then call wait to collect a child zombie.

seccomp_filter_release takes the siglock to avoid races with
seccomp_sync_threads. There was an idea to bypass taking the lock by
checking PF_EXITING, but it can be set without holding siglock if
threads have SIGNAL_GROUP_EXIT. This means it can happen concurently
with seccomp_filter_release.

This change also fixes another minor problem. Suppose that a group
leader installs the new filter without SECCOMP_FILTER_FLAG_TSYNC, exits,
and becomes a zombie. Without this change, SECCOMP_FILTER_FLAG_TSYNC
from any other thread can never succeed, seccomp_can_sync_threads() will
check a zombie leader and is_ancestor() will fail.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 kernel/exit.c    |  3 ++-
 kernel/seccomp.c | 23 ++++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..b945ab81eb92 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -277,7 +277,6 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	seccomp_filter_release(p);
 	proc_flush_pid(thread_pid);
 	put_pid(thread_pid);
 	release_thread(p);
@@ -832,6 +831,8 @@ void __noreturn do_exit(long code)
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
 
+	seccomp_filter_release(tsk);
+
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 60990264fef0..dc51e521bc1d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -502,6 +502,9 @@ static inline pid_t seccomp_can_sync_threads(void)
 		/* Skip current, since it is initiating the sync. */
 		if (thread == caller)
 			continue;
+		/* Skip exited threads. */
+		if (thread->flags & PF_EXITING)
+			continue;
 
 		if (thread->seccomp.mode == SECCOMP_MODE_DISABLED ||
 		    (thread->seccomp.mode == SECCOMP_MODE_FILTER &&
@@ -563,18 +566,21 @@ static void __seccomp_filter_release(struct seccomp_filter *orig)
  * @tsk: task the filter should be released from.
  *
  * This function should only be called when the task is exiting as
- * it detaches it from its filter tree. As such, READ_ONCE() and
- * barriers are not needed here, as would normally be needed.
+ * it detaches it from its filter tree. PF_EXITING has to be set
+ * for the task.
  */
 void seccomp_filter_release(struct task_struct *tsk)
 {
-	struct seccomp_filter *orig = tsk->seccomp.filter;
+	struct seccomp_filter *orig;
 
-	/* We are effectively holding the siglock by not having any sighand. */
-	WARN_ON(tsk->sighand != NULL);
+	if (WARN_ON((tsk->flags & PF_EXITING) == 0))
+		return;
 
+	spin_lock_irq(&tsk->sighand->siglock);
+	orig = tsk->seccomp.filter;
 	/* Detach task from its filter tree. */
 	tsk->seccomp.filter = NULL;
+	spin_unlock_irq(&tsk->sighand->siglock);
 	__seccomp_filter_release(orig);
 }
 
@@ -602,6 +608,13 @@ static inline void seccomp_sync_threads(unsigned long flags)
 		if (thread == caller)
 			continue;
 
+		/*
+		 * Skip exited threads. seccomp_filter_release could have
+		 * been already called for this task.
+		 */
+		if (thread->flags & PF_EXITING)
+			continue;
+
 		/* Get a task reference for the new leaf node. */
 		get_seccomp_filter(caller);
 
-- 
2.45.2.803.g4e1b14247a-goog


