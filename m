Return-Path: <linux-kernel+bounces-529129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50993A4200A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AFB1898284
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995C724888E;
	Mon, 24 Feb 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7OIIlMQ"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D823BD0D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402780; cv=none; b=mv0BqAI8v8UM6wx+I7jg44So634YxHjxTI2IsWLdweucaq0ItmLB4uVZ9jwE4LhgflY4z5qKVpwXlNNQ85HmVQtPEA64pd7QZHpKYTWuzEhxSIf5wLu98U0EdIwyfzEy25LprV8Dg+sgPJed2oD40yDl2d4gYEZbA8Xv9UgO+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402780; c=relaxed/simple;
	bh=L/0k1hSZ9gz743H51cji2Z5NFpOyX5yX7VSWovr7evk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sFNMcrYHfgTc6jpN+5ks6Lz9VczVdETbkMeudCUycEMFH4CMJZron7nBMPc+10isFTqEh7BesCS02npMhaP2r3wmXfB+6vXu75fLnZEMX0XujPZOMCDjopBH2lNCYyBZzl+dBEpDnOOQx2cNBXpcLcYUQMVXXHxZMF+4AWIlbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7OIIlMQ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5dec9d39295so7373442a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402776; x=1741007576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+N33++797Qql4ocC0bl2HCKwFCX4KLJsQfp8uRtafw4=;
        b=t7OIIlMQyzaD2XVfNv+HfT1oxpLMt401QTiasAOXSQakaExqecRK/OlonUVYZKSesN
         GLpwBlTdete1tKceZKQ5ugpntJL8ocezfFCLK57b5alNLwWA+hRydcPpsx1F69HUUZq3
         uSPoIK7T0i12tOwweRMfUZVaFn2K4cioQGsg7lWW2/oTkwhy/ECxLnse3rP2uu0IyOP3
         rTiz3Pn3gRWjPzX8mi5bbGac9dev8wL2eDIF5SzheZPfjb9EO4hgR5Vngj3d1ybNcM7b
         OnO4nrL6tLmwu2p8Zzm/0ncaVj/0DPB7Hrit+FypoijDE6kNKEd/0mOu9bf9wbmbI8OB
         kILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402776; x=1741007576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+N33++797Qql4ocC0bl2HCKwFCX4KLJsQfp8uRtafw4=;
        b=ka//cyWX27HVjwK5CgOCoohdF/zHHFdyDSrtorZzt9fA0BdJGa/OSTYGMqk1dhungs
         T44C4wUrpTYgjWo4aizSqN2txppWzId1nFjkvgy/FBeyka23wUyoGyT6uKSDXbGP70rK
         FEp5Z7ySHqNXa4OWUKMjpHs4DdfzAZGwgFvzIDEMrNrenzo/09X2sVmN3MztACcjAlxc
         okHzUhVvC0s2EHg96gR5UJBms80BzmtQUTwQLSwpBPm0zjTJT5s6ekWp1OZy6QQXB6DK
         kAlm18akC03pLSFKuoNsmttgc8/gF8QXKJ8Ez9eEu3wBHJT2LPcurOSx/j2WgKPZDTeO
         L7FA==
X-Forwarded-Encrypted: i=1; AJvYcCXxFQLuTV/UmK1/gTfq+VVTTj/0CSwaub+IDMwUFBNE0FcwReHiiWBiQJH2cs+rc9o0lbDHvAnaKSWlvYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWDh83RPN+n4mhC0+38WkXq6oAJX1RyhXJqdI4E8kNl4Pejhh
	xzeq43xFIzoDdE/pVgtCGDFXDi6zWbPfgKzyjDSmzLW5CnH8ZU/bVhE/QdjdqLqCBvbvDzmGFZj
	e56gYpg==
X-Google-Smtp-Source: AGHT+IFPP4+jzk2Z93tjp7XSQREesB7jyXDn0m9TXgHEqwGqN/FRLDcOgHYE5gKEwkuRly905rmkrYcyRUsO
X-Received: from edbds12.prod.google.com ([2002:a05:6402:1ccc:b0:5dc:578d:62e9])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:4617:b0:5dc:91c6:8096
 with SMTP id 4fb4d7f45d1cf-5e0b722d3ebmr13945528a12.30.1740402776594; Mon, 24
 Feb 2025 05:12:56 -0800 (PST)
Date: Mon, 24 Feb 2025 14:12:30 +0100
In-Reply-To: <cover.1740402517.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740402517.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <ac4d535eb0c14008d2e1287f4610a10a77d2dffc.1740402517.git.dvyukov@google.com>
Subject: [PATCH v3 3/4] rseq: Make rseq work with protection keys
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

---
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
2.48.1.601.g30ceb7b040-goog


