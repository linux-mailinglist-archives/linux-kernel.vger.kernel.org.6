Return-Path: <linux-kernel+bounces-527425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADC3A40B19
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B44700559
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA86212FAA;
	Sat, 22 Feb 2025 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/inXcaL"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45BF212D84
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251203; cv=none; b=A92RHGjv1ReTB4J7VAWcS9c+44eFU2iH7FPVNJSW+5Pkx+ZsuqtFEE9eLHDFvQfH1pe2uT4DmXsz14h/C3PEOZDskCDFyyZY9My5YB7iIEewk/YA9Sf1UUpxCwTER9Jpv/gpNSydSexpf2UkDNIFUoGmxkAUIL3Toh0WGUN34Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251203; c=relaxed/simple;
	bh=GCDATYO1AJw/DO6eXDNV5UGJUlAocFyLKrDA5Y9egrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nred4citTGew+aa7mYTEStIknQCt7ByGWU4BZuMVCf5kUUIKm10JA82uJDiIAU0TZ7P7h2neHrl0jU+cbwJJldPvxU2WpmhOMLGNMB2Jfi+mL1WgkjoE1h65qQJUpKmNQhkXBKqnlcPBMk0BdfkanKlHlBwORnlg9KuZssypyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/inXcaL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e67fad4671so28010196d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251199; x=1740855999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjXYEbe3KPR6UiCU0EfQ6entX/O21jgJvDj0fnAodH4=;
        b=l/inXcaLl9noTTRka8T2pYh5oKsf2zD+tMl9x8kBHjjj4x6IVty7WldFeroAnaO72L
         PFi1q7DoFEOrtw+N7WqYbf/leB0Pu1WX/ZKIgtqWDk3A1xZQYb0hNYnW+G0NSiCVzFzK
         v+3Jw+YmU9LJN9jOMNcJ2Sj8SMb4JvLHe4uDuABpESA9BP5seOuVpfFPvjq2zcR8NsEX
         RZt6y8C0nHyPVF0P0Q+J+Lxhm6d3N69oyR3UENtmL5gts1rtGZ15j38WLRXC+V6EV5Bh
         Q/9vnpFrd/ncbcfis6Vh9LK0gq/ybF6dGyv0TWJ6S2o30B7/XXtnr4v9aiiK6VIKXH7e
         jPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251199; x=1740855999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjXYEbe3KPR6UiCU0EfQ6entX/O21jgJvDj0fnAodH4=;
        b=LTSnyO8UE9a221ruPgU/2Tnid7AepGRJ3hN0s9EgBFDPNgFPmW09dgtCwo4tTJmrjG
         4+euCE/+jEi9FUiM/y1r1TT5TvfxwF1zqgFlme6nF4Dzv0wTaLFl/bBrEEv5b67hCslG
         qy7MAcXQdfQpVmmlwIoaDVLD5UxXYheWRzhV2OCcT0vK6yMTfWFX+YfocHGFbPWg6mNI
         3qrj3RI3D4FDDa3Lr+NvpV1s1wqkYWrNpmWUJnXPrR69Lj1KQdK+80URmdqCSQxjeEnV
         AS+uglYHxDHqdJauG7Xc8nC9s/3cyfzqJlqhAk6vLOlCj61eRAZsu4GSAnHLZukJ8frr
         6dBw==
X-Gm-Message-State: AOJu0YwcH/r510fL6nJnXSsL+jwJuepKikqpxNwFA0bUKPMujHRDBR84
	0a7sOmkIQSOCOM9/qmzgZwjsJ0w2xrk2psv8JAHGI/jqsBJuO3IPaAK6
X-Gm-Gg: ASbGncuIs2KU9i5+vhztvqEOclSY8xBeceaG/BHfi9HEKFzKLtZ4trY+omYkRBO5P2X
	ybPLIzLQM5s+l9n0wIvG2QHlVJjL8L+eXHZ8N/FHjqVsCqmPM3+rgi82sg/ZpZ/s2L1p5jZkEId
	jnnUyYpXxfH/OnQKgaY0XThyMMZvWR3iBSTndmseqT/d10KsUTwTea942oTzrSOm5X0oRR+OS2T
	qzkvQ6ClHXeBIiCy63OMERAlEBxVNN0/T0STCYdH2ozXtLpSYp9QL0zdcch6YKBGpbfyyp+a52c
	EKTbEuA=
X-Google-Smtp-Source: AGHT+IGTkdzWrpW7dzRyjdyZtx+YvQudfz8Sv8S4UaagzhZB79LJ0eOt3gP+2pjjOQiJt6D0gdKw4Q==
X-Received: by 2002:a05:6214:daf:b0:6e4:4331:aad9 with SMTP id 6a1803df08f44-6e6ae7c96e2mr95206856d6.2.1740251199251;
        Sat, 22 Feb 2025 11:06:39 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:38 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 02/11] x86/preempt: Move preempt count to percpu hot section
Date: Sat, 22 Feb 2025 14:06:14 -0500
Message-ID: <20250222190623.262689-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222190623.262689-1-brgerst@gmail.com>
References: <20250222190623.262689-1-brgerst@gmail.com>
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
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index bf5953883ec3..9a2fe2fd7d74 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -16,7 +16,6 @@ struct pcpu_hot {
 	union {
 		struct {
 			struct task_struct	*current_task;
-			int			preempt_count;
 			int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 			u64			call_depth;
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 919909d8cb77..2f3a40cbdd76 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -4,10 +4,11 @@
 
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
-#include <asm/current.h>
 
 #include <linux/static_call_types.h>
 
+DECLARE_PER_CPU_HOT(int, __preempt_count);
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
index 8b49b1338f76..519e2ec2027d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2016,12 +2016,14 @@ __setup("clearcpuid=", setup_clearcpuid);
 
 DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.current_task	= &init_task,
-	.preempt_count	= INIT_PREEMPT_COUNT,
 	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
+DEFINE_PER_CPU_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
+EXPORT_PER_CPU_SYMBOL(__preempt_count);
+
 #ifdef CONFIG_X86_64
 static void wrmsrl_cstar(unsigned long val)
 {
-- 
2.48.1


