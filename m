Return-Path: <linux-kernel+bounces-529147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2FA42065
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87B63A9069
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7D248862;
	Mon, 24 Feb 2025 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ksg0PwxE"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E36248893
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403274; cv=none; b=ruC5wRnCCingqFWHtO57RSkx6GyxKLRJobq6U2AtMUQ1fU8KYgkSbgTEAyFEt7inkuCH4fGHD2Ttu/YA0cJmu1SYAu2YWWghgcZabmro74AlacZtUPPXxbA7DKi2E5TB5Ec8BjNtddG5aQvgacMe4G2iVwxhFmkWx2vvujrKk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403274; c=relaxed/simple;
	bh=HytO26zLM8+O1BMCP7WnHH9d/GbvFekhicdIfAp2HB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oGI+fOGV13d+06Ro1GFgpjlfDGtLdXCYevvzv1Sl9psuOhpSkQFJs3HqfdxURXDgXG2jxHIFZXXgooA2QjMrCZZutqgoiUTF1XKXVum9koTA9bUiNYS+oEcxPCuTdP3Dr5ug7sd70FR4MThvDvCVBAvraXfMe/zF4LZwWephAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ksg0PwxE; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab76aa0e72bso362851766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403270; x=1741008070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoS1pMG7iajAiL9EPpdBXs5d6A5g2FVWe59r0YTEeMk=;
        b=Ksg0PwxE8VVFTYImyCseB7wkqQ+unBx8dPIPZh3TCJNvZGVZVDsLuHfKsOE91mY5lp
         8+SSb2jwFSUgu6G4a29aucecWjIBAtUeKj7DtTiYyN95MtwDzrNC7Jxh36+/OTnXP/eT
         zd7lMxj0NT1W4iYpskg3u60t2b2CrreOoi4mxXfEmVp30+kJVLe1CDKxK3bVdp6AMStV
         oyhmT+cMOoD6CZBSq47byYkP/b53ClsfYyeXLjnUyC6+nzKXq8q+FS1Jzpoket8US9wc
         /Lj19M4QdahBj/Zcr352CUiYn40tPdY7NhGh1r/LdjY3xKX/5M7TylaCkFs8Jcv3fV6P
         lurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403270; x=1741008070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoS1pMG7iajAiL9EPpdBXs5d6A5g2FVWe59r0YTEeMk=;
        b=BOn5p1Os6PnCOP+C2nbPjx71acHwpxXbFdX3ltZbvsWh9l6aamg+ELLR+qPWBULbjl
         KXNUJHrliwuRvd0G3ZKxX2ysyiucVPe1N10XYocGfeo9i/R4xR8Z0XcHYuj2tNAAyQ/E
         RpiMV3c2iMLUbLBjnRyso1DNqyKJp8xVQ/px5DykFZugsB8V8g8Mn9AylOvWxNUBZlJe
         +HFwq+4KhiFkTiPGoYfZnBDTmVhM8Fgodt4H0TL+677zKZF+GMykSbvBKyN1vLVt9wpf
         rjn/qxKVzbx3Rb4rUDi2gwb43yIONexz3ZJkU3e3LaH4noC8fL6TJYiCvqkaKunOR8aH
         iX4A==
X-Forwarded-Encrypted: i=1; AJvYcCVGjPkW19h9Nes0p6nKUJ9TZoiHGmx3Q9jikBXLdOCcpmdIPmPAIIIhTvYdP9pGm/ggqyx5w6/irSiDMs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2hy1HeWmP+VZpLsHJFIu2sUYB/YpAAvi+7S+7xLKBgeifYNO
	YnvdgGtXvX5k1hNuL7rA04wDRNg+8iYzSvhLKpQOIYO1AOMt5RkG4F3xoufCnvqA1A4EL96lGzN
	UHNYwrw==
X-Google-Smtp-Source: AGHT+IFo2rkkO/3ufbjDiQcEue1dIbtir35TxI2Z+mEC1dhWIpGwLnEHxgzviefjCL+xM/yyjcOx8StjSktg
X-Received: from edbev16.prod.google.com ([2002:a05:6402:5410:b0:5e0:7520:e3b9])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:268f:b0:5dc:6e27:e6e8
 with SMTP id 4fb4d7f45d1cf-5e0b7252c81mr30143762a12.24.1740403269315; Mon, 24
 Feb 2025 05:21:09 -0800 (PST)
Date: Mon, 24 Feb 2025 14:20:47 +0100
In-Reply-To: <cover.1740403209.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <4e93f7da6dfa450d488fafa3599306349e6e34e8.1740403209.git.dvyukov@google.com>
Subject: [PATCH v4 3/4] rseq: Make rseq work with protection keys
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
2.48.1.601.g30ceb7b040-goog


