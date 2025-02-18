Return-Path: <linux-kernel+bounces-518756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00DCA3940C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD72C18967FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47691D89F1;
	Tue, 18 Feb 2025 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOUauUU7"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297971D63C8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864694; cv=none; b=WFwD1RKdXU4Lo1n+XPVpjwKLlWeOXABxF8azGstpUA+sH+npIm2HHnBzVqwDLVACinCT39k3nqrjajYsSpnR6oSfr5nypZ6HQCSgRmXFPoMS34KXcTrpPdYZDmxRaPWgFVkhrfO0+l4vCNQv5YDegJzt4+SI2dSREWqpsh1AUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864694; c=relaxed/simple;
	bh=PXebd+2RcnzFz+kFW9cPkWKRFrPOPVUVFufyVNlUgoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OLzfaIYFxr06WHm10ok8a6o0B3NVnR5sX2aIUKFokyJWcDQZ3FLItTwdFhfdx/ngMs5+06KX+O+eDTke42yPscCLwTgWdKLpRj6JpabH35jAwPFWWjW79Ion45OQCzhQMReK3bjiWyLZL4RWkQ+jMdaC5S2Z1b0IxcSQfVY6Fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOUauUU7; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-38f36f03312so1218719f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739864690; x=1740469490; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=srQYdJbi1jjIOOLhg9CNze3jDrWH0CuD3JBCypprX1U=;
        b=pOUauUU7qUWDaWpiF2yyPbHZiGhcgAl5Xu/gyNAu3frzGuOtm5amafDH2Y9SKd/w4/
         aBDyYzTqkNGT+Kx+yoiIapS0kdX/sJmA0+iauyuulSycoH9WkwgTv/43F3cwNwDUyc/3
         JmZhFqSp56UhRIwpnrduNQdzwTJkpXOJnPgx6teaVBqL2Qwq5BR0uzz6CXTVm3/bkRkm
         FvdGEMMn8VgWqRvuHIvBRlymQsHJIx+kubf3eIbozHgCYiFZ4NUwA0iNGStxbWb1W4xk
         luYM/nx1KBQCnEZVPnik8NdZkVdbMChgMaLm3Hbt4x7LtUQAGllTBmAxDlcdL6ghmaDx
         Gncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739864690; x=1740469490;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srQYdJbi1jjIOOLhg9CNze3jDrWH0CuD3JBCypprX1U=;
        b=oLwrtPS7PZKEiM3MsyjRXOAc32v/J5tCJrT8jP0Qp1pdfrGCB/EnyDpqEFT97jk/fb
         dYvQqdXJweDy4T0eX0Zx5LEl0geEZZxiYO7oTyu9Qgte3kQ3zYCUb3+sIJdoxDejN9iI
         V3ROP/QLz+my0ZHxiCcYQ7OzSeqRbGNC/atC/DOHJJlSR3BhEeeJpesz6SOQ1AW6hWZf
         pD2oSaqoGXVQVxYtGXb9bmMi5I0vhjUal93QPlPWBvtR4kOJl/RHLBwxTr4XdMRymlwZ
         /Wg+cG9ksQeFIaHBu/zp1FneWvU+KZi3CjOF+Bx9Bu3ydLbis7QMmtLi9JqUlbpZlfEK
         IFGg==
X-Forwarded-Encrypted: i=1; AJvYcCWVOyBjKZNd2RhXsKfsx4zlDF77YzdndEuv6dzDgZ5oNjbq7p3E1ficw0EtW2AsZf23xsjkALV8shUYdPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hvMtgLT1v7rdBRFjn8Lp+VUbLTiHujHNkJHKX91BooPeKN3Q
	oLIhuXzyPHANkCMC/GpPUHfahvO6yzBSPtH2Wl3b2cDyJ9VGHE5fVC7igyQ/vduMLInWPgYbTGk
	CEJe30g==
X-Google-Smtp-Source: AGHT+IEeTAyxXWlywB/4ofXQhxtsj1lJcV2fDOtW63ONNjXhRi7PmcEOfgzWH5+cmU+xYG2YIaR9GksmWZJq
X-Received: from wrbay28.prod.google.com ([2002:a5d:6f1c:0:b0:38f:37d4:8212])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:638a:0:b0:38d:dfdc:52a2
 with SMTP id ffacd0b85a97d-38f33f531e1mr10281271f8f.40.1739864690530; Mon, 17
 Feb 2025 23:44:50 -0800 (PST)
Date: Tue, 18 Feb 2025 08:43:47 +0100
In-Reply-To: <cover.1739864467.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739864467.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <b9c17ad6f9372d3c92b9812b5ea3dbaf44e82b01.1739864467.git.dvyukov@google.com>
Subject: [PATCH v2 3/4] rseq: Make rseq work with protection keys
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
permissive pkey register to read/write rseq/rseq_cs, similarly
to signal delivery accesses to altstack.

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

---
Changes in v2:
 - fixed typos and reworded the comment
---
 kernel/rseq.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 442aba29bc4cf..6fc9f799720cd 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -10,6 +10,7 @@
 
 #include <linux/sched.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 #include <linux/types.h>
@@ -403,10 +404,13 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct task_struct *t = current;
 	int ret, sig;
+	pkey_reg_t saved;
+	bool switched_pkey_reg = false;
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
+retry:
 	/*
 	 * regs is NULL if and only if the caller is in a syscall path.  Skip
 	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
@@ -419,9 +423,43 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	}
 	if (unlikely(rseq_update_cpu_node_id(t)))
 		goto error;
+	if (switched_pkey_reg)
+		write_pkey_reg(saved);
 	return;
 
 error:
+	/*
+	 * If the application registers rseq, and ever switches to another
+	 * pkey protection (such that the rseq becomes inaccessible), then
+	 * any context switch will cause failure here attempting to read/write
+	 * struct rseq and/or rseq_cs. Since context switches are
+	 * asynchronous and are outside of the application control
+	 * (not part of the restricted code scope), temporarily switch
+	 * to permissive pkey register to read/write rseq/rseq_cs,
+	 * similarly to signal delivery accesses to altstack.
+	 *
+	 * Don't bother to check if the failure really happened due to
+	 * pkeys or not, since it does not matter (performance-wise and
+	 * otherwise).
+	 *
+	 * Note that if code has write access to struct rseq, it may install
+	 * rseq_cs that is not accessible to it due to pkeys. Still let this
+	 * function read such rseq_cs on behalf of the code circumventing
+	 * pkeys protection. It's unclear what benefits the restricted code
+	 * gets by doing this (it presumably has already hijacked control
+	 * flow at this point, or has arbitrary write primitive to write
+	 * arbitrary values to struct rseq). A sane sandbox should prohibit
+	 * restricted code from accessing struct rseq. Disabling pkeys
+	 * protection is still better than terminating the app
+	 * unconditionally.
+	 */
+	if (!switched_pkey_reg) {
+		switched_pkey_reg = true;
+		saved = switch_to_permissive_pkey_reg();
+		goto retry;
+	} else {
+		write_pkey_reg(saved);
+	}
 	sig = ksig ? ksig->sig : 0;
 	force_sigsegv(sig);
 }
-- 
2.48.1.601.g30ceb7b040-goog


