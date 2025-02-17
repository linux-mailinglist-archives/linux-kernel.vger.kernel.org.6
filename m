Return-Path: <linux-kernel+bounces-517476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8EEA38164
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD911887974
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775CD215F5F;
	Mon, 17 Feb 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrFy+5bp"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D9217F36
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790500; cv=none; b=El5Xvd9G3wj7T6G5X2kSeIBckTGUX7s4JfWRPXcl+mnRW8gzc1HsJHbFciBRGHwELBOozwQMVAc8r1VtlBDpWO4MOi56Z17raNDASArIUTUN2OL82GeB4bSjy8+3l/FufGjK0NH5fnSJj+moN+f5u6mxO9qHBsYXfe4Xs+BTsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790500; c=relaxed/simple;
	bh=AVOb+2c2LscErEo6bEGInPvTSGXSqHinXhCYdY2r7XQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZyA7Wfh/+ggHPlrkL2QpeMRjglabgOjH96t0q+mcH7M96fFbJt/a/ahH9MrT7TluLNq9rzF/TgBd29SPgs6Nt5qpGW9/wSUXFKZTg5DfkJ/3SWSQSrIEKZwrEREK9gBDgXWXgW9tYIBMvJz0OlAkBiPPGlfGwDya/TvUF2m8Rtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrFy+5bp; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-abbaa560224so43279366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739790497; x=1740395297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRwWmsv22nmRUUizlEH9+1SsyFJS3m6TMbnIpQiWyho=;
        b=XrFy+5bpzucSIY+wIUOBlCE+9bnQlpe3uIkfZarzwU8aiQcGK7tpXKoO3nX82IIng3
         joAyNijMRgWJuYJwjH4x9RopPkTZbTYxx/2hf25AKF7c4p+ab64OEbNDT3jocSazpY1D
         z2mO7vBx9BZqEClMbHe+Ouo5dojPevIjnFJQc2NJtMR7fSO70G7HFPOIhBl7v/WpfvvD
         RhV+9QbqXS0moBw2d/YNLZMwD5Kyh5dZgWHJlzIn9NltvPkB3GSTd+VEsEXaTrVKAokr
         0mPlTOZJKSnTy7TDxHwrzxP0wc/cbpHcFdA+n99yW1ufkxPU/eGaRr6FlXYtrW8rWj09
         SrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790497; x=1740395297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRwWmsv22nmRUUizlEH9+1SsyFJS3m6TMbnIpQiWyho=;
        b=hiB9/1Kp+cJdlfEjwA2fXcSeVveE4OHrlFgDuAiyX4nSf0ObNwI0jBU4YvZQ/PhsIw
         rq1gKQ+sNcDTggCAjCk3wyAFoWMdboiETpWIO5O7EqR5e8FTkVTZ1OcJ6BuVxJja8O/C
         rHMghdMQba5ag5CpEpj8uKUhH2fFfcHFguFp879aNA7eORsbQCBJvm7vp/qCBBKmzmqe
         65MTrvnxY1rWUpjMib5AlJ/cnEeIcskEvLFdmvo8B41CP9XR1dzJKYXNOYyMdmEtEq/N
         HKJicL8+DcNev0Pgy3ydWhrdYkOQt1jWR9fxjjx/+Kvco1SmoGWi6nPQoOqYBPNN+hhC
         3Ylg==
X-Forwarded-Encrypted: i=1; AJvYcCXQX4feGY3ka/zohsufWUyhCdJyn7P4jxyPL+qztmE1BXCd2wpxnq4y4RjMymKKAHXwK7TjbFVn/c2umUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNNTBH9ruVPX9BwkHg8u7oXDAfH0DQcQJD2QqzdDj9AVKf9Cq
	LDZVc+GSdYdDZtl0lKZrJ6tPR3NPO7SRJ4T6RNqc93nasWGbYB0sjB2hxjoTfSKvSGvWzE2GLpJ
	D5gyB+A==
X-Google-Smtp-Source: AGHT+IFx6Gx0Ot0IIGJvBhi1ET6MC7db4xfqL+5sQ3VeS8oMEVTRYGAd8v2+6CpmbjzdrlCRkNWEChPIdvO3
X-Received: from ejcvi10.prod.google.com ([2002:a17:907:d40a:b0:abb:9461:5184])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1c21:b0:ab7:faca:a323
 with SMTP id a640c23a62f3a-abb70d677c5mr944634866b.39.1739790497259; Mon, 17
 Feb 2025 03:08:17 -0800 (PST)
Date: Mon, 17 Feb 2025 12:07:32 +0100
In-Reply-To: <cover.1739790300.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
Subject: [PATCH 3/4] rseq: Make rseq work with protection keys
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
premissive pkey register to read/write rseq/rseq_cs, similarly
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
 kernel/rseq.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 442aba29bc4cf..31cd94b370ef3 100644
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
@@ -419,9 +423,41 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
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
+	 * (not part of the restricted code scope), we temporarily switch
+	 * to premissive pkey register to read/write rseq/rseq_cs,
+	 * similarly to signal delivery accesses to altstack.
+	 *
+	 * We don't bother to check if the failure really happened due to
+	 * pkeys or not, since it does not matter (performance-wise and
+	 * otherwise).
+	 *
+	 * If the restricted code installs rseq_cs in inaccessible to it
+	 * due to pkeys memory, we still let this function read the rseq_cs.
+	 * It's unclear what benefits the resticted code gets by doing this
+	 * (it probably already hijacked control flow at this point), and
+	 * presumably any sane sandbox should prohibit restricted code
+	 * from accessing struct rseq, and this is still better than
+	 * terminating the app unconditionally (it always has a choice
+	 * of not using rseq and pkeys together).
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


