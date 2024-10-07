Return-Path: <linux-kernel+bounces-352953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC08992670
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7261F22F01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4218C037;
	Mon,  7 Oct 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X6jzqMxQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E396184522
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287519; cv=none; b=nbQmzNCXGjfxdt9EeVRowfij1zk1NlcRRRn+MfkSs36id8hX2iml+NmKG0myT+40hPt8IywCywm7LGaUWlfaCwS5LFv4XSXzWOq+xKLuhOJqveW3kbrruio5tlpU/sdmtDYjrqha0aRnwO0OsrcdLRdwVhnr5pwA+jG3enz7go0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287519; c=relaxed/simple;
	bh=yXvhGBWJj3vTIaZTJSTgiTmquqXpLO3clf7EJDHrNMU=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mj0aJzoRfkyknu0SgRhpKvILejACSMTbkXIcBqV7GsnAKqUlRnnFpQQUz4aXBruYYxkaIoTN2dxmNtrK4SEzLvEaAQji9NXFFlvUuncSRHEqsEAe2rWA12dj3y8i7nsw06X6YpZI3nt/3w9nojIkbPQxAzZKhXHkkSR2vo0huMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X6jzqMxQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=5lWqTRF2EJbYpKSaa6UVs0aHY6F90ciF42uvCB5HDnM=; b=X6jzqMxQpbTDUoMSbgB50nSt1E
	VT4b8uKfFGvCo6MhQ+5TBFsCqH6ak7lz1KlzdZKR366vKqiTVHSzkXJY9CwIUVFsH+OkCQs0a7tp+
	Apa9PWA6XMRsKnN2xX5WecULEwJt0WFyOos9WgsGF+I/bhvZ1K/ltj1ZsODJQVGw9OnUToyv33oLv
	MnKFJGMzpgWAYYllWysTfhu23Dk9q4mz4nq2Q4q0Ok8l/T0cp8r/n84I5ColJT/jHOVzBNhlPQ0DS
	4a4Waj3CwcQ7u1/XMlx7Pqkk6UQquIbvBnih6x2eLithW8WYoQqDQlXKy91dIAoggqgBTyLBIck/1
	KVhDb6kQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxiWu-0000000Gvkx-2H3b;
	Mon, 07 Oct 2024 07:51:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3B765302DAF; Mon,  7 Oct 2024 09:51:44 +0200 (CEST)
Message-Id: <20241007075055.441622332@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 09:46:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: bigeasy@linutronix.de,
 tglx@linutronix.de,
 mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 ankur.a.arora@oracle.com,
 efault@gmx.de
Subject: [PATCH 3/5] sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
References: <20241007074609.447006177@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to enable PREEMPT_DYNAMIC for PREEMPT_RT, remove PREEMPT_RT
from the 'Preemption Model' choice. Strictly speaking PREEMPT_RT is
not a change in how preemption works, but rather it makes a ton more
code preemptible.

Notably, take away NONE and VOLATILE options for PREEMPT_RT, they make
no sense (but are techincally possible).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/Kconfig.preempt |   12 +++++++-----
 kernel/sched/core.c    |    2 ++
 kernel/sched/debug.c   |    4 ++--
 3 files changed, 11 insertions(+), 7 deletions(-)

--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -20,6 +20,7 @@ choice
 
 config PREEMPT_NONE
 	bool "No Forced Preemption (Server)"
+	depends on !PREEMPT_RT
 	select PREEMPT_NONE_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This is the traditional Linux preemption model, geared towards
@@ -35,6 +36,7 @@ config PREEMPT_NONE
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"
 	depends on !ARCH_NO_PREEMPT
+	depends on !PREEMPT_RT
 	select PREEMPT_VOLUNTARY_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by adding more
@@ -54,7 +56,7 @@ config PREEMPT_VOLUNTARY
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
 	depends on !ARCH_NO_PREEMPT
-	select PREEMPT_BUILD
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -74,7 +76,7 @@ config PREEMPT_LAZY
 	bool "Scheduler controlled preemption model"
 	depends on !ARCH_NO_PREEMPT
 	depends on ARCH_HAS_PREEMPT_LAZY
-	select PREEMPT_BUILD
+	select PREEMPT_BUILD if !PREEMPT_DYNAMIC
 	help
 	  This option provides a scheduler driven preemption model that
 	  is fundamentally similar to full preemption, but is less
@@ -82,6 +84,8 @@ config PREEMPT_LAZY
 	  reduce lock holder preemption and recover some of the performance
 	  gains seen from using Voluntary preemption.
 
+endchoice
+
 config PREEMPT_RT
 	bool "Fully Preemptible Kernel (Real-Time)"
 	depends on EXPERT && ARCH_SUPPORTS_RT
@@ -99,8 +103,6 @@ config PREEMPT_RT
 	  Select this if you are building a kernel for systems which
 	  require real-time guarantees.
 
-endchoice
-
 config PREEMPT_COUNT
        bool
 
@@ -110,7 +112,7 @@ config PREEMPTION
 
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
-	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	depends on HAVE_PREEMPT_DYNAMIC
 	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
 	default y if HAVE_PREEMPT_DYNAMIC_CALL
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7406,11 +7406,13 @@ int preempt_dynamic_mode = preempt_dynam
 
 int sched_dynamic_mode(const char *str)
 {
+#ifndef CONFIG_PREEMPT_RT
 	if (!strcmp(str, "none"))
 		return preempt_dynamic_none;
 
 	if (!strcmp(str, "voluntary"))
 		return preempt_dynamic_voluntary;
+#endif
 
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -248,9 +248,9 @@ static int sched_dynamic_show(struct seq
 		"none", "voluntary", "full", "lazy",
 	};
 	int j = ARRAY_SIZE(preempt_modes) - !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
-	int i;
+	int i = IS_ENABLED(CONFIG_PREEMPT_RT) * 2;
 
-	for (i = 0; i < j; i++) {
+	for (; i < j; i++) {
 		if (preempt_dynamic_mode == i)
 			seq_puts(m, "(");
 		seq_puts(m, preempt_modes[i]);



