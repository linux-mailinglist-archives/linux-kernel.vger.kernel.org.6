Return-Path: <linux-kernel+bounces-186891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A98CCA6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F17DEB21595
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776ECA34;
	Thu, 23 May 2024 01:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCuFWUaz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320604690
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716428757; cv=none; b=Mb2UbSlHRAMOHvLp0XTCeh98hrmbNi7gawqk2B1/Nh5RwidA8GDIYGLe6OSIUXyb5Gl5ja9gzHBua8Seso1sPtja91R+MvIv1ue3lqCBQKq4SeRBb22H4+E63zSKPqToYKIoYnni6i/8l3CQzPaQ/j3M6RZ0ZgqLvO8ijdB7hA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716428757; c=relaxed/simple;
	bh=WSYL46L/nY3J3dr73k57B+B68lsssSYG6HVzprwEcOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oIQg8+7MM9Ls52oVtAJnK5C3Mf7yn3xw+e11hpSljO/8wa0gLlAQYCyhOKqwBUK98BxX1e/RF3cNrdZdwzskwvHn9j6YxpveuH5veSHHL8GCcUHpXw3ynjABh7O02Vd20Ltj8dtoQWSl7qu/p9U+Z+Aex2GR8UXYKvaV7u49sro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCuFWUaz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627f644882eso7929847b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716428755; x=1717033555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sI+JSuHl+a4DbD/5uHc0jD/fV7+8U56yFV1emFa1PRU=;
        b=WCuFWUazR2CLAPJ7xIrXD6C37yObRgSkb+kmm6cPttW7cKxaxI31CeGfbPECmXWc5d
         gi0KuWJRby+lVV/g1Zxa9SskNF0zot+PLs63Ty8Pr/YQFYd776tD6G7BWTR7lbVLSYbI
         ECAXeMbPblQu0XJ6WFQqJUzLKir50sX5JamGPDbDCqc01jBojjXaf7xrTV1X6s6ISvQt
         tpoTzmm1xv5tCArTFrWeeLHFGmHROQDACHdTtAUg333RhGt8KvW5uSxb7akIUlvX4yob
         ijJYMFmYaNrgqPwNeJTfvCZFMccI0STXhVE8m89/zNdTi2NLREKXxRBCPLX9o0CWYYOI
         /+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716428755; x=1717033555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sI+JSuHl+a4DbD/5uHc0jD/fV7+8U56yFV1emFa1PRU=;
        b=CV9zDVt2BWWs+TgqpEnqaNcB5R57rZhUcVhTVzxYRESmagHLA6pBu2LHWsf1rlrzgj
         xePT7CTWYMBjfGOERKW//HAtF/cmTEQhnEhuoyLxWFT3hghWiWXh3zADkALcIkpUvQev
         mRdl2DtC8tr8lS28BGy5/FgT80ciyYpoSsL4Bt94WgxfJ1VSmv0avbQb6BLabmVWyoEu
         GvuKf+tf7g5w1uCmINhqHYW07hW2GzP/v/AU6CCa38fulKJSfNd/T/M++Wzgfs2LK9BY
         khnwhTELh1QnBAIoglckAO+nOpsKe291ctv08uNF0VYYEKVOE2Se0T5S+Czu3XUmJ8ph
         /tBQ==
X-Gm-Message-State: AOJu0YzQfxECHly4VSnSGHV0IXSBpwuWxsUP97nU4G+0QxKGnGMIVmqQ
	qM+zD/Mx/DQL79HuYvl7DpGwhhBjcTuM5eGTmqBX7xA69ho6D/dIXRBR26irAWr48X9h+iSdcT/
	32A==
X-Google-Smtp-Source: AGHT+IGzggF9SRJa2KGxbzPde9yDh3H2RVncowhv5qumXpCIUtEWlrOKKj4O8Q2p3Qh4iGD516BE6DZWLg8=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a05:6902:1894:b0:dee:6a2b:5fdb with SMTP id
 3f1490d57ef6-df4e0aceda8mr347665276.3.1716428755262; Wed, 22 May 2024
 18:45:55 -0700 (PDT)
Date: Thu, 23 May 2024 01:45:39 +0000
In-Reply-To: <20240523014540.372255-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240523014540.372255-1-avagin@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523014540.372255-3-avagin@google.com>
Subject: [PATCH 2/3] seccomp: release task filters when the task exits
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>, 
	Andrei Vagin <avagin@google.com>, Jens Axboe <axboe@kernel.dk>
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

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 kernel/exit.c    |  3 ++-
 kernel/seccomp.c | 22 ++++++++++++++++------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 41a12630cbbc..23439c021d8d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -278,7 +278,6 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
-	seccomp_filter_release(p);
 	proc_flush_pid(thread_pid);
 	put_pid(thread_pid);
 	release_thread(p);
@@ -836,6 +835,8 @@ void __noreturn do_exit(long code)
 	io_uring_files_cancel();
 	exit_signals(tsk);  /* sets PF_EXITING */
 
+	seccomp_filter_release(tsk);
+
 	acct_update_integrals(tsk);
 	group_dead = atomic_dec_and_test(&tsk->signal->live);
 	if (group_dead) {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 35435e8f1035..67305e776dd3 100644
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
@@ -563,18 +566,18 @@ static void __seccomp_filter_release(struct seccomp_filter *orig)
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
-
-	/* We are effectively holding the siglock by not having any sighand. */
-	WARN_ON(tsk->sighand != NULL);
+	struct seccomp_filter *orig;
 
+	spin_lock_irq(&current->sighand->siglock);
+	orig = tsk->seccomp.filter;
 	/* Detach task from its filter tree. */
 	tsk->seccomp.filter = NULL;
+	spin_unlock_irq(&current->sighand->siglock);
 	__seccomp_filter_release(orig);
 }
 
@@ -602,6 +605,13 @@ static inline void seccomp_sync_threads(unsigned long flags)
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
2.45.1.288.g0e0cd299f1-goog


