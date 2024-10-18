Return-Path: <linux-kernel+bounces-372482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4189A4911
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72693B25B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD6190067;
	Fri, 18 Oct 2024 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb8EYlh0"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151C18FDD0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287667; cv=none; b=q+YrTM+esK63yDjVGXtqZ87hLoG2aQff+K3purbKauhLwa0MYpXfdKJ0Lh7CFbF8X3HnsvwRxcQDcFeymFTX/NIh0f0r8pDqlTioYPzUaLuxxrFOeUTVYA3rZizCwhFw4DKxLWNPbFO0xI9hQRMqT4NQeA94u/PUjBe6X2Qrz/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287667; c=relaxed/simple;
	bh=Iq9ZUTfiDCowSbndQgUeX26pEsHlvOjp84G1E+xxJxA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NyIVpC68pK8AT2ECiJUmopIl7y4vAWkLqIBJzYghwTsk9NSANBb07fgkC3YESfJxMvhI91VeK51FtzvoJnDk+QicBVUuEfDQr4nG5DwR5iP1ql3qypWr/rPW71vGwbB6313baQIrCJm+UocEDdhnfn7yLNsfVyQSLg5LiuJNg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb8EYlh0; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so2176360a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729287665; x=1729892465; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIdSLC2e2A01nqWfaLJkAsLAiPp7KyzjBuBhWn5f/uw=;
        b=Cb8EYlh0uaN2xx5t2gs0SMMCRf1lWy9er9ePOzNfLqUAtZgZbGtK1yU+/6KSIgF+cL
         7WpJ11SccB1W7W80nTDKfq9YW3ao66Fn9A0A9c79h8Dss27sUn8MtxxEh1ImdIo3Kcv0
         o2w+JJveyCtJZblikXxYohLeuAHxTuYNMFAMgw4u8LCKPYgBzENqkEdj99p8RRBhk7/e
         gl378xtoA8HQP/1ryZ7m2MH8dC65+VXQwLVEewAvtAotNIUcRut9YKxsiasbAEdPkfRG
         p9fdfB3+tVJ6UiE7Px+xKvhol1oq9ZPZ+TeqY5evu2m8lhmRZdrvsyUBkKEa+kZbKMzv
         Ng3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287665; x=1729892465;
        h=mime-version:user-agent:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIdSLC2e2A01nqWfaLJkAsLAiPp7KyzjBuBhWn5f/uw=;
        b=Kcg6MwX0SVnpsELlhWc2v+QPhtGc9yruUuxT+q3FmnvGOzewK9CgDbrb+iy+/rBVeK
         oSE+OVwKFm4lqTBOESXiii/pFeCY5gMy1A/p+75FfeWwRavuZI8I5hgtS78qSn8rCGNI
         KcAHfSaNsrtHM8YkbtyKHLC9I8IRv0pOYc58JxPvAZFCnxcj2A9IQmhUZxvJ+Ec2Y0Ag
         +QHFw9jA446D37JE+FZ3LkLoCHCMm8jLrdxhmZyvAEtqXNwvuJGFMFpVX7FgVFo7JaBx
         Z3nDJXLbbE4BmaDriS5h/WRSCkdAw7pEo0UvDip4W00goMJvZCWh28aj3b4bWsEmh0Qo
         FqVw==
X-Gm-Message-State: AOJu0YyZKkbylKpRMK4b2IcQxLjOSl45klEdIF9+s5jScbRhV30VaFeJ
	tNQF3jbP8oCzMmDUzg+c6Ngp1ofnhikLvLSaUHqJrOL978yZSm7UtIH8VGnBty8VcMzATZATOU+
	bpw==
X-Google-Smtp-Source: AGHT+IFdiJ75WEx17rYYQLgH4+V0QxTLFmguvx0augBCVA4zVYekzG0kTt1RMFs4e9FdvSpjdIYsrA==
X-Received: by 2002:a17:90b:814:b0:2e2:a96c:f00d with SMTP id 98e67ed59e1d1-2e56185d15bmr4242949a91.21.1729287664935;
        Fri, 18 Oct 2024 14:41:04 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d79208dsm2675968a91.12.2024.10.18.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:41:04 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: linux-kernel@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: [PATCH v2] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on clone
Date: Fri, 18 Oct 2024 14:41:03 -0700
Message-ID: <xm26ttd9ay34.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When we clone a new thread, we do not inherit its posix_cputimers, and
clear them with posix_cputimers_init. However, this does not clear the
tick dependency it creates in tsk->tick_dep_mask, and the handler does
not reach the code to clear the dependency if there were no timers to
begin with.

Thus if a thread has a cputimer running before cloneing/forking, that
hierarchy will prevent nohz_full unless they create a cputimer of their
own.

Process-wide timers do not have this problem because fork does not copy
signal_struct as a baseline, it creates one from scratch.

Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
Signed-off-by: Ben Segall <bsegall@google.com>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
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
2.47.0.rc1.288.g06298d1525-goog


