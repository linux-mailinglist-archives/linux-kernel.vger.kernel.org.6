Return-Path: <linux-kernel+bounces-542374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9203A4C901
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98281189127A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9FF25E815;
	Mon,  3 Mar 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YX5e86AF"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FF25E446
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020799; cv=none; b=Gd8fFJix/hbfAgFITIqtThj/s58q+o/kaKzB/UQSOAkzLdLdqkNJ3saBFOgG+JKTiSW8ABPJvIfkqDE06QjYDTuI7yKajo6Z+kX+cfkjg8vk6t8pesO1tlAFnuJBTnNbpslzBnOJNnQjvxjio2mBWpjXSmhxan/F4jjJYqQ3lmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020799; c=relaxed/simple;
	bh=rSUNvriQSjVIpywPkCIL0ssJzw1abFGSQqq9fcCN0Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3W+CFYQ7j+mMH8EnRL3IPwjb5X99E8rsoEKIytwASat7ZoPqeY3aOT9lxOM3jppMXWP66Yk4IfXCVGxS63E1FnbIGj66ZBhh3F/xtzFfIk73puFq9J4LgCtN7lhxAcXrNjSX0YgvvNpdqn/i8IstskhS06Q8wSGrCyEARtBKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YX5e86AF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd420f82e2so66099446d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020795; x=1741625595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iNgkHr5bj85f6gaDanw+SgUtlzoAy3q+atablztih4=;
        b=YX5e86AFC6bgQYgKTZN7twHw1VRn0993YF8fLkWbzYWwjb+Wgk6KQBK8XVjT5+jw8T
         j4bmkp18XoUPs4slOPyQcKL4ZX2Eg3TrgUzr0Rw83lW4Ki4/qg1XQ1Icsx8pksnPaHEI
         WoPxD0M0259MGKo3xGA4cZ1hbNMnmLVYhPwz79cENzkFHmGp2/fkOoshYJ+Ol3pWGNEv
         dSuEpZ1qXj+V8Ur6sY8m+TYE/8q8Fpg5S6SahsRJbuE41Jx9Y3VEtI6i9YCz533cXAxT
         OoQt7tXSsJsZCj2A/ue7/k1DN1Ne5b5Jj0ociMnALsisjgVtf55DVEPAMIPmya3IJAmU
         Tq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020795; x=1741625595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iNgkHr5bj85f6gaDanw+SgUtlzoAy3q+atablztih4=;
        b=nIgGnZ5bttl2gQ5cU63jSrnJm3BmR9ViC/3gOr5qf5Q19AERBgRtKCtTeEV1+IXmwn
         /EZV9PAMIM2Env9fsEvCCI18W9Dbz9sDx4dEgTa/QEPBBAVRPOQEI0VcbnOtEJ+REBQO
         8hoKHzq1f0f4EUrSDQYmivZgHwHOOoodzwj6mTE8rJEfMuPa4hMiGK/33rrxOnTMYu7F
         0RbGEgw3/5b1KHB8UZbqFltyF2moSvxVD2f3r518gxoyWTHqPh0qkW0/gB+Xhhn5v9bO
         I6X2uyu0XSQ5hmUYrx5tCHcs93v7XbVxl/NZ5U7Yl+sR+SovUfYCiibZtU29uvLWJaju
         8sTg==
X-Gm-Message-State: AOJu0YxHvRY58NMiKxEWRNCFlgR1xaYRqW0B8EHX8PUfI9zlbjcDD3uz
	Vigp7dFEPITbaNkpRPD0RsW+Yw6c8WmO0lAHKsIiXBo5lD3iKZEf5Fc1
X-Gm-Gg: ASbGnctuf8L4HPLiuP1LhtbSOatoPcW2wl3dTygfV5Z4bNTdKhnbzKdbIKqNdfnihru
	b09k4upAJyIWMFSYrSeEAIi+YUb8+ZGfgwJcMfbl+vCYp0RDTvp/hDP86tZSeXZPvMe5Ys7Z7aG
	Q1Hhec7pcUsi8if8ToEcA1ozZhy/mancUQQlsw2sYxYCy6QJ4QraDXGKfjFKu5BpTB+RatS4XN+
	QAu7DM6uVN29M7NpT77OdyVjb8IcmAk7uuB3Vfr6lAMkxAcHl2Rpt84wxxU5tse/iCHwlLnZTUH
	iZH+xVg4QazvwoqZT+wXTPa0Eg==
X-Google-Smtp-Source: AGHT+IHy8HDzYv7FlGVafnjXASHLEtkIcUC087TOMcpwjRQRGkBS+ZNPs3S26DW1plbiHblSx/3Y3w==
X-Received: by 2002:a05:6214:19ef:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6e8a0c80a4cmr233960906d6.7.1741020795433;
        Mon, 03 Mar 2025 08:53:15 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:14 -0800 (PST)
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
Subject: [PATCH v3 03/11] x86/preempt: Move preempt count to percpu hot section
Date: Mon,  3 Mar 2025 11:52:38 -0500
Message-ID: <20250303165246.2175811-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303165246.2175811-1-brgerst@gmail.com>
References: <20250303165246.2175811-1-brgerst@gmail.com>
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
index 7e834820e030..a1748b4e5598 100644
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
index c33eaca1e9f9..8db36699dc78 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2051,12 +2051,14 @@ __setup("setcpuid=", setup_setcpuid);
 
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


