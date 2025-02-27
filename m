Return-Path: <linux-kernel+bounces-536507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75DBA480BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1261E17EC43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327423ED5B;
	Thu, 27 Feb 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCxIQVf2"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85123BF9E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665011; cv=none; b=C9TDdSs4PpzYot1bAuNQHN/wYzH2U8qC6x4NRhcEy1i51KUGz+IVMNqALdXQHM6ye3VAKS/Lz1I5PdktYcjuht8D5zM9dRv1n8+kPxn7Agj92fWMmMNec3Z/L7HtNpvMkEqkZ73X6Y2jWd/xnyb5qpT/CM3GukG3FCGwjDsgtj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665011; c=relaxed/simple;
	bh=tEYzJCTiKzF2LYVQgmRQQO5J+znKSKUm4lTw0Foc0rI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SUEhb4QJdAWdN+tLdHsvalH8stSLSUnvHyauLOO2nw5VrZxjhJk4Bzcff78FhJ18PuZm1yockoZWSHSLRZTkTiWG5Q3W87YnHlDe+5wdjoP0zj1bSwO+1vjA9Asgd8r+0j6bKmxuZhhyV+ahswgOouCLssTgg0l/18Bh7APvojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCxIQVf2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so8917085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740665008; x=1741269808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UERrY3gBSSj6jqgnpUhhnhNURH28RQ/gzb1aJd+BElY=;
        b=RCxIQVf2TR8+mwFImbw6l59LvRKXpw5erPd9Cv9YWlqKocgh80eu5+gjVqORvfR8HG
         iDJ9lYTvhq2X4YKPwGH3mk/JdcYsXKg+TnwO7b5fvM7C9Usezhk0oh362XHJYieIqqtc
         lhW936th2L1Q+Ki/DK7DEhOPqWRvEz+X1Y3IrQLRX8sgc2z8Kfy6kNgFBR1sI1GQpbx3
         BI9De0HgsUlZxdjdzqb6+pNisMEnV8Nv2c+WWFehq/BwgYY1qJroeiezypYR3wUQl9yz
         jlD7u5aMPrkUCNPLLAqzMqo901l7RWNBvxJzqQD7LPZetej7gCdr+u3vo6gKQwb3fU+5
         W88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665008; x=1741269808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UERrY3gBSSj6jqgnpUhhnhNURH28RQ/gzb1aJd+BElY=;
        b=jKiXv2uDhRNqC3y+r7WqmhSX+t5GOha0LVc6WcEEJc0j3jkpqYSp1Lq0RW7CxDNyrB
         KEdJOO2531XoRxRiCgKeNpVtx/tjHMc+8rJcPUG7KEheXG9OQ041HJVUpOfF0+5o2uka
         32gLCFhaFAhqxa/p6yjJzPJZHKkKs/CId76cRTqDLFU6nSh+VrYIDzqN4m2to2X+FNlA
         ZQunK7lRJVUEu6brzA8LVZmgb1NQ/zJQTHtTUm1WN48pucga3A+yITnwz74F0ikwdque
         qG37/7Osf+D+RF77y45iGsPuu67oBcOOLKP2J5BX5/Toe5SGnV19zpd88SUctXc/oNdx
         ZRSw==
X-Forwarded-Encrypted: i=1; AJvYcCUsShb/zjyu6FHCHO9BLel35ESMlBtZIGfuLzIzQLI+OBWH42r97TyYdKgqdwPKGgtRtYUbIiXi3XNKtG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCmT+G3kAE/xL4c9ZxZfs1ZuSOwMAHXwbLmiPw1eKu2wekGZAy
	wdMESFZRpAwBKFiQmYzcXUG01qy+BjJePp5Jv5f1fPXfg+JJ9g+JRe4Sib3YSAGZz0Xwwu22XY2
	PF+mK8Q==
X-Google-Smtp-Source: AGHT+IGELPmTJWOnBa0OmWHIZY2PvlDBv7UKitIGSs6BatAfX6oWrFx6LdmrVg2XeAUP6GEID5iXeu8ZKecv
X-Received: from wmbg8.prod.google.com ([2002:a05:600c:a408:b0:439:88bc:d27d])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5117:b0:439:86fb:7325
 with SMTP id 5b1f17b1804b1-43ab0f8dd49mr129858495e9.31.1740665008218; Thu, 27
 Feb 2025 06:03:28 -0800 (PST)
Date: Thu, 27 Feb 2025 15:03:14 +0100
In-Reply-To: <cover.1740664852.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <e534910c51271eebf4055a92f3b1c5ac998988bc.1740664852.git.dvyukov@google.com>
Subject: [PATCH v6 3/4] rseq: Make rseq work with protection keys
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If an application registers rseq, and ever switches to another pkey
protection (such that the rseq becomes inaccessible), then any
context switch will cause failure in __rseq_handle_notify_resume()
attempting to read/write struct rseq and/or rseq_cs. Since context
switches are asynchronous and are outside of the application control
(not part of the restricted code scope), temporarily switch to
pkey value that allows access to the 0 (default) PKEY.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")

---
Changes in v6:
 - Added a comment to struct rseq with MPK rules

Changes in v4:
 - Added Fixes tag

Changes in v3:
 - simplify control flow to always enable access to 0 pkey

Changes in v2:
 - fixed typos and reworded the comment
---
 include/uapi/linux/rseq.h |  4 ++++
 kernel/rseq.c             | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac90..019fd248cf749 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -58,6 +58,10 @@ struct rseq_cs {
  * contained within a single cache-line.
  *
  * A single struct rseq per thread is allowed.
+ *
+ * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
+ * then the assigned pkey should either be accessible whenever these structs
+ * are registered/installed, or they should be protected with pkey 0.
  */
 struct rseq {
 	/*
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 2cb16091ec0ae..9d9c976d3b78c 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -10,6 +10,7 @@
 
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 #include <linux/types.h>
@@ -402,11 +403,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t = current;
+	pkey_reg_t saved_pkey;
 	int ret, sig;
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
+	/*
+	 * Enable access to the default (0) pkey in case the thread has
+	 * currently disabled access to it and struct rseq/rseq_cs has
+	 * 0 pkey assigned (the only supported value for now).
+	 */
+	saved_pkey = enable_zero_pkey_val();
+
 	/*
 	 * regs is NULL if and only if the caller is in a syscall path.  Skip
 	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
@@ -419,9 +428,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
+	write_pkey_val(saved_pkey);
 	return;
 
 error:
+	write_pkey_val(saved_pkey);
 	sig = ksig ? ksig->sig : 0;
 	force_sigsegv(sig);
 }
-- 
2.48.1.658.g4767266eb4-goog


