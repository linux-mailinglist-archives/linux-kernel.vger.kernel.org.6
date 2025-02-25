Return-Path: <linux-kernel+bounces-531526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB4FA44180
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E1617329A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B69271277;
	Tue, 25 Feb 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbqzLesD"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0D5270ED6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491653; cv=none; b=sB08PtMbJYLUC53tCpG3xLmq3OCtFNRTYpjLCu/dXImjFAX1QS8Xo5n1PaS+9LTKrnr7LDbbgfTWYD+5C0lCrkB4ut4NwOHspdAmmgRu41n+rJ4qRS/MAMiJS+VHnFNtNw0vg+cVKwo3IawTCDkfLFen69jASgHJzw+QvYCw4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491653; c=relaxed/simple;
	bh=mxDSTV22DiCZLVFJCl4A43B/Ycht0NkS/AjZis6gklI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TUjMVnIEgcTmyGNnL0p+98h4laReByRKwTHgNp99ia1dq6WRfWrsL4Ce5TY3MIaQ9nPCMddNRAVmZS5SM5wQfCiJqExkXWwW1Z358bWAQ9O/m3/NFJvthEKaEBO4zffrQqVmNXe8Hl9FnWtzmdv3q7wadPzT+loD2gJSLs01G5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbqzLesD; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dca72b752fso4749689a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491650; x=1741096450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ChERg0C5IMhC+KsYfx8s1jLwzf306OmVcGDjMs1a3W4=;
        b=LbqzLesDXYOnJEi9nH+QwW4yAp+e0Bv2SngsYrkEiZJChLSVh199iwAiOZWqA1ddY/
         SmQ1c3UaHNo1t7T+ld9+hBoSP1mzFfTSBUdfZ8dwdAZnBIhB+aT4qm5nqIwLFFVcZ43b
         zfih7ouoxml78BZRwSPK80LfyCZlGCt+uVBjcfyGwQtFvNzigMgRIuTuRVJ8is5Evuah
         eh06NbrfdO8RFZ5hSzQ3yrvGDt8i3GQViPkNeOvusXSAJx03aR+2tLKw/qdk5Z4gr6Id
         OXdWx4AdRJKcC8dpDZPTb44k5pdKLWXQQSiRvAAO6Ln9oEGgogZNy8jC4rzdXJQ8uY89
         MtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491650; x=1741096450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChERg0C5IMhC+KsYfx8s1jLwzf306OmVcGDjMs1a3W4=;
        b=cZcWL/wm0szBQou48rc/ev+LenzdyvwDAjc7pG7/j22f9f7rIY+5QzlLTCqx1WAFN4
         LWePyCDqmHNE82MkensRzZm3R25T682R6cBf4J4kZv9deCLSRULzozBxAq8CXhNvQzQS
         8xCbPcRdHyBSTZdis37qIo/HFahijO09U3x+q3gvx2cgp3biZV7kPKvlpTwo1UAirRRH
         e/R25diOe6HUBLjFWgDHAD6SozSmh+si0dz0eW2YdiYqNuiJUd0pxntZPlg8Fg94m8E8
         pPUc4bNKoFtSCNiRh+Lrvm9oxnwBGQGnQfPh49Y4cxPaJgg1AFTY9iqNSFMt3PxMUTzm
         hrPw==
X-Forwarded-Encrypted: i=1; AJvYcCVO8pXEKf2KAAwi0qKhTTf84mLuGv/krkFXP+u2FexxiFJMTo7jq4FJzzKUdvM/RA2AehsGV6ywVXkZrIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxESUr1dxSSOpRDNZLoePVvGkDOBRBah2zxUCnDL9t/TIpGBR2s
	tkNSjFB7J6TMXiHkpAHNDKFf/U8pW9fKR87waNQyndMl1TbCg1Q5JHsKAD0kLZqHvd+PYAvTSV6
	I5JOOqg==
X-Google-Smtp-Source: AGHT+IGR4ye76RG7GGhfnoDpouhotKvLlIH8/k3O7dfNt7egFDh7xZ6VjoDI16/iX0GRZKK4+UHXURQUOnI2
X-Received: from edat32.prod.google.com ([2002:a05:6402:2420:b0:5de:6258:5aae])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2790:b0:5dc:1173:bfa3
 with SMTP id 4fb4d7f45d1cf-5e0b7247814mr18073474a12.29.1740491650230; Tue, 25
 Feb 2025 05:54:10 -0800 (PST)
Date: Tue, 25 Feb 2025 14:53:45 +0100
In-Reply-To: <cover.1740491413.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740491413.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <659cbdf4c59910d3d3a7ce3f7ea6f6935c102fcf.1740491413.git.dvyukov@google.com>
Subject: [PATCH v5 3/4] rseq: Make rseq work with protection keys
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
Changes in v4:
 - Added Fixes tag

Changes in v3:
 - simplify control flow to always enable access to 0 pkey

Changes in v2:
 - fixed typos and reworded the comment
---
 kernel/rseq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

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


