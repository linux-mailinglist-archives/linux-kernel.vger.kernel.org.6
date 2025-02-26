Return-Path: <linux-kernel+bounces-534590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272CAA468E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311033AF568
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9386B2356B8;
	Wed, 26 Feb 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHE8TKrs"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEA23535E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593152; cv=none; b=B4lE42Jqo7c3e5ALxOltayjAruGiAx5QWg78QPPkB5lGlAAzWKrKTZ8MgX7Tuc/SykX+nOmvGLnjOS7uQzYzd0BqCDC7uZ+olEUav16DoScmyJNBbcEpub/OOmW+p3uSFPtWA4bVa7LWOix7/wgv1ZbOj7pl+1UFMHe3J92dh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593152; c=relaxed/simple;
	bh=EqJavPMpXmCpA8qSqAJ44MdPREeuZfT+T6RTPcdaOXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8QTOiwU5907U5kKqEXFazLvXx2uFwJVkZHwu1w4dg5v1eu9VSn0sY0eD9Cbwr/xIFDBrg96axYQQdNPGioNzHW5Ha8VpQGMaRR+OFvwdcleBaMJMKWTZwo2GJcW34OgfHkqn7o8z3UEFA8+Muqxmm0jdmj7cI17dp+uLF+A5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHE8TKrs; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f40ad1574fso109091b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593150; x=1741197950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=436B8vpLTNU8Oi703zHdG5tjEBpnGGK8nyxnE2IzJMU=;
        b=nHE8TKrs32KXhOo6wz1dGqH1APvdWg16k1JO/PIDpcNR4hCBszxXLx/WV2SUkE0VW+
         2qql2DMhof5CHkV5Ruw4/VDhCkHzgFSKlL8BLJT4vmPYiMtpsrKZadPgLC3LoOeAkShx
         ZrWgOLhAJwYzSPsESsz8NsP1T3Du8dkIXK70EtrnGkIWzUGTilxUU8PGqnD3r0eEmtEt
         /CqXGQ8q4dgGYeeDUm8i7j1wJuqevgw/v1O2iah4DibIiAE/p9wgxnWsMy+/Uoplu2WV
         EO/cO++NuQzgFvKl1uIFYsUN5bqo1u7UsuzLAjikhUer68UaFIXoGy83GuIn8XMSyzc3
         bBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593150; x=1741197950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=436B8vpLTNU8Oi703zHdG5tjEBpnGGK8nyxnE2IzJMU=;
        b=WAu1+iOR9UPH/od2IxV+yvpe2NoTtQX9Ly+kSlDworUT0mrVjAEFypqbXx/BhyR4tY
         TbxN/GTc2zqfp00CxUxqU9mZgzxKPgyovk2mg/bNECrMvXLC9pXkrF1Ft851DyONV2Nr
         VZs8Hv7c0BqqpExfBeiLKUx8ojQPU3AoFnEwrY42VIbiejMtUv3ckhpBiIrsB54D8jqb
         nA62EMZorQERv4j1o7zybkvPFIdNtezwqtVbJwhpr0vTSWQ0gcapTC/PcTstE6fvtPro
         sBXrZF4qsP4j39LvWJZxgxJFHYg7dVeynvrLZPjjzS3mc7boxYDFu3KWB9FBofGzEUDZ
         hxMA==
X-Gm-Message-State: AOJu0YwrUbpap1yRwTZ2j36Ibqd92ZNwLZhHNb+DIjrvUS5dqauqd+q7
	K0DeLN/4jhOEsP6yO6IDBgiwx7pPyiTGm888JJGnX15ZEgiMkUMQkblB
X-Gm-Gg: ASbGnctxpp/9KXx2jwKgCElQ0DoB826f25reZudNkkp67pzm2RqrJHflNt+nBqbU8jJ
	/d5VQMJFw2gs1sRpGLBlYXlWmmlDJXEl0bAwN8Na12CjHwMWIpfndn0Z6mAuFchBvUWJKvivUdA
	vEboJ7TyrIqTs4GAuheSaa9FuiDt2G8bJvxzcha3mSHcgG4jacj/Ah5Wj7vjyD9hqjZJC+Joa0b
	Ct7fq94W2wJhdecZwHygVlEZY5C6rFayNXT7c04c4yGTc37uBjCSMqn87tnSdXCt54Sq28YBkiZ
	sL0GGdk=
X-Google-Smtp-Source: AGHT+IHBoZzpk5ImyC5zzaHAekmEnhUZpbt3EjDP8LKX859d6FgFlKgg2K8qSx307vOhxAe3FHhv7A==
X-Received: by 2002:a05:6808:3209:b0:3f4:400:e5f3 with SMTP id 5614622812f47-3f547e3981fmr2319169b6e.24.1740593149857;
        Wed, 26 Feb 2025 10:05:49 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:05:48 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 03/11] x86/preempt: Move preempt count to percpu hot section
Date: Wed, 26 Feb 2025 13:05:22 -0500
Message-ID: <20250226180531.1242429-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>
References: <20250226180531.1242429-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/current.h |  1 -
 arch/x86/include/asm/preempt.h | 25 +++++++++++++------------
 arch/x86/kernel/cpu/common.c   |  4 +++-
 include/linux/preempt.h        |  1 +
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 60bc66edca83..46a736d6f2ec 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,7 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-	int			preempt_count;
 	int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 	u64			call_depth;
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 919909d8cb77..578441db09f0 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -4,10 +4,11 @@
 
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
-#include <asm/current.h>
 
 #include <linux/static_call_types.h>
 
+DECLARE_PER_CPU_CACHE_HOT(int, __preempt_count);
+
 /* We use the MSB mostly because its available */
 #define PREEMPT_NEED_RESCHED	0x80000000
 
@@ -23,18 +24,18 @@
  */
 static __always_inline int preempt_count(void)
 {
-	return raw_cpu_read_4(pcpu_hot.preempt_count) & ~PREEMPT_NEED_RESCHED;
+	return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
 }
 
 static __always_inline void preempt_count_set(int pc)
 {
 	int old, new;
 
-	old = raw_cpu_read_4(pcpu_hot.preempt_count);
+	old = raw_cpu_read_4(__preempt_count);
 	do {
 		new = (old & PREEMPT_NEED_RESCHED) |
 			(pc & ~PREEMPT_NEED_RESCHED);
-	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new));
+	} while (!raw_cpu_try_cmpxchg_4(__preempt_count, &old, new));
 }
 
 /*
@@ -43,7 +44,7 @@ static __always_inline void preempt_count_set(int pc)
 #define init_task_preempt_count(p) do { } while (0)
 
 #define init_idle_preempt_count(p, cpu) do { \
-	per_cpu(pcpu_hot.preempt_count, (cpu)) = PREEMPT_DISABLED; \
+	per_cpu(__preempt_count, (cpu)) = PREEMPT_DISABLED; \
 } while (0)
 
 /*
@@ -57,17 +58,17 @@ static __always_inline void preempt_count_set(int pc)
 
 static __always_inline void set_preempt_need_resched(void)
 {
-	raw_cpu_and_4(pcpu_hot.preempt_count, ~PREEMPT_NEED_RESCHED);
+	raw_cpu_and_4(__preempt_count, ~PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline void clear_preempt_need_resched(void)
 {
-	raw_cpu_or_4(pcpu_hot.preempt_count, PREEMPT_NEED_RESCHED);
+	raw_cpu_or_4(__preempt_count, PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline bool test_preempt_need_resched(void)
 {
-	return !(raw_cpu_read_4(pcpu_hot.preempt_count) & PREEMPT_NEED_RESCHED);
+	return !(raw_cpu_read_4(__preempt_count) & PREEMPT_NEED_RESCHED);
 }
 
 /*
@@ -76,12 +77,12 @@ static __always_inline bool test_preempt_need_resched(void)
 
 static __always_inline void __preempt_count_add(int val)
 {
-	raw_cpu_add_4(pcpu_hot.preempt_count, val);
+	raw_cpu_add_4(__preempt_count, val);
 }
 
 static __always_inline void __preempt_count_sub(int val)
 {
-	raw_cpu_add_4(pcpu_hot.preempt_count, -val);
+	raw_cpu_add_4(__preempt_count, -val);
 }
 
 /*
@@ -91,7 +92,7 @@ static __always_inline void __preempt_count_sub(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.preempt_count), e,
+	return GEN_UNARY_RMWcc("decl", __my_cpu_var(__preempt_count), e,
 			       __percpu_arg([var]));
 }
 
@@ -100,7 +101,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
  */
 static __always_inline bool should_resched(int preempt_offset)
 {
-	return unlikely(raw_cpu_read_4(pcpu_hot.preempt_count) == preempt_offset);
+	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
 }
 
 #ifdef CONFIG_PREEMPTION
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9b8bf43019e8..1470f687f8d6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2016,12 +2016,14 @@ __setup("clearcpuid=", setup_clearcpuid);
 
 DEFINE_PER_CPU_CACHE_HOT(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
-	.preempt_count	= INIT_PREEMPT_COUNT,
 	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
+DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
+EXPORT_PER_CPU_SYMBOL(__preempt_count);
+
 #ifdef CONFIG_X86_64
 static void wrmsrl_cstar(unsigned long val)
 {
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ca86235ac15c..4c1af9b7e28b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -319,6 +319,7 @@ do { \
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 struct preempt_notifier;
+struct task_struct;
 
 /**
  * preempt_ops - notifiers called when a task is preempted and rescheduled
-- 
2.48.1


