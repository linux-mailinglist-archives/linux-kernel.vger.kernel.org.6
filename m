Return-Path: <linux-kernel+bounces-382855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A69A9B140A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 03:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C753F2837FB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 01:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833728E0F;
	Sat, 26 Oct 2024 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCsPUJO+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA645217F39
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729906539; cv=none; b=HsHBLgZ2Mq/hLTN8Z4CRjZcs5O21taZ1+EWr5ea+fCIp17rAbySeSbwEqXO2R8nt+TevuDRc1CX6BIx90RdaQN5O87tOp23BLK+z7q7+F/IPgnHIqkzC9stIRFMgEsHgvROWi5nJ3laMX/fe1Gk8+YYJ545ZSdGOZ/rkMXBeu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729906539; c=relaxed/simple;
	bh=xocFEQBxBOy9K2gs85UTaSYi9kuba4ROcwcIloxLqu0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jndFOSIxgqLtadSK6PuMtlQY8DZBp5kM52MbBRiO3vX/82gaMFP087LX54iB0FVvy+LH66wENYW57n22hXB7mMCCPEGOa/rOIW8RQMdIHOP6Zt/fAFVF8ZE7Fmxh932sBFV0cQ+/OAUOeBbm1eVQ9Ao9h8ydft6Q2tgzK0KzAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCsPUJO+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca1b6a80aso25695605ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729906537; x=1730511337; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph0Qp4+hJJI5w+kl9XPpLPZDbDTlG33ihuKYvhG6JM0=;
        b=jCsPUJO+DZ0pybCmLByERiOd5Nc6jJbb9fT9FjmQvgBT6zpPc6H9r3Y7HbKxrJQEce
         UeRn32mffw4cN6xviXVIRbnRKr3q5NZ9xEUblKPvu8Pk9DKfHJAmCYgMRsm6oRP5CsUI
         Z5N3oF4A6aLXxRKK2OWE/p4xgLdxQ5XWWpfLMmuO+p/pHwAZTEDJyRgjlZ8yvvnNDJ/N
         RAJELAMs08R+BFtOdBBD48q0IBxR+Stvvbodejd0FoOneSIU8zJtH4tJ4S3dVafbVFGK
         CqWKgsZifXkr9gzQd5IQHQM6mb8sN7rG8zpjpkoG6FAVTjVLJP501SN1gxSzjF6V1CIk
         v14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729906537; x=1730511337;
        h=mime-version:user-agent:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ph0Qp4+hJJI5w+kl9XPpLPZDbDTlG33ihuKYvhG6JM0=;
        b=kKp+oFmkBBzYxfWrYuYpBXpGCzw6LWErcHt0fEILZJgBWSLU4gwZATVzZco33AIDjV
         JwGc7x4FmMIW00Bj0guc15kk1xB9cD7CkaOl3o/uXeNFBR1adHJ4F3Tepurm1BkcpsDY
         XQEv0B/tCqM0ap3LMKdXNrz4lEVc2zk9O+uKan+YosqI8/fQrBh4rTWkVGCzWNUau3Ia
         dgbT2LEmgzGjDhwP1O/8e1dISgnRzJWgDJUIu5bMar3E01cvbMDj0xS6BBIpBuUde9s1
         T1HRQ7bAqnU8UqoS7RV6vp9W7fsM6yHSM2V4m8ubyoRHW7Jd3yq2IGgW3ueNrEekZ5sE
         odBg==
X-Gm-Message-State: AOJu0YzLQSJl9JZjoTsB+ZxBvhNtnwFrONksmHg4GCGBH0QBE4h696L7
	Sz4QoeTDGKzo5P20n+kzUVte5Z+E7V8PbbKjsigXswpWP0nrcHr7x24DJ5ys/182q30Nyg7QcY5
	quA==
X-Google-Smtp-Source: AGHT+IEBdPA7jcGvDdsvn0Xw6K9P4Ot+cl3XKLiDsOcLlPuR922EQNI8kvwextj/+KoWl71ZTfvkJQ==
X-Received: by 2002:a17:90a:e94e:b0:2e2:d1a3:faf9 with SMTP id 98e67ed59e1d1-2e8f11bbc20mr1259347a91.40.1729906536726;
        Fri, 25 Oct 2024 18:35:36 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3749149sm2220664a91.35.2024.10.25.18.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 18:35:36 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: [PATCH v3] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on clone
Date: Fri, 25 Oct 2024 18:35:35 -0700
Message-ID: <xm26o737bq8o.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When cloning a new thread, its posix_cputimers are not inherited, and
are cleared by posix_cputimers_init(). However, this does not clear the
tick dependency it creates in tsk->tick_dep_mask, and the handler does
not reach the code to clear the dependency if there were no timers to
begin with.

Thus if a thread has a cputimer running before clone/fork, all
descendants will prevent nohz_full unless they create a cputimer of
their own.

Fix this by entirely clearing the tick_dep_mask in copy_process().
(There is currently no inherited state that needs a tick dependency)

Process-wide timers do not have this problem because fork does not copy
signal_struct as a baseline, it creates one from scratch.

Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
Signed-off-by: Ben Segall <bsegall@google.com>
Cc: stable@vger.kernel.org
---
 include/linux/tick.h | 8 ++++++++
 kernel/fork.c        | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 72744638c5b0..99c9c5a7252a 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -249,16 +249,23 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_set_task(tsk, bit);
 }
+
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
+
+static inline void tick_dep_init_task(struct task_struct *tsk)
+{
+	atomic_set(&tsk->tick_dep_mask, 0);
+}
+
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_set_signal(tsk, bit);
@@ -288,10 +295,11 @@ static inline void tick_dep_set_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_cpu(int cpu, enum tick_dep_bits bit) { }
 static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit) { }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index df8e4575ff01..9adad1ad202e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -103,10 +103,11 @@
 #include <linux/user_events.h>
 #include <linux/iommu.h>
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
@@ -2290,10 +2291,11 @@ __latent_entropy struct task_struct *copy_process(
 
 	task_io_accounting_init(&p->ioac);
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
 	cgroup_fork(p);
 	if (args->kthread) {
-- 
2.47.0.163.g1226f6d8fa-goog


