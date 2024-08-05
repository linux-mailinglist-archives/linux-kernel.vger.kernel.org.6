Return-Path: <linux-kernel+bounces-275207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AFE9481D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845421F218BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C715A874;
	Mon,  5 Aug 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ4nhW2m"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38981607AB
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883238; cv=none; b=EhZfAr7emErGUCXykUcjtDk1S3pa93w5ckbR/QqybLlZCDklgsrzLegxB1ynyOW9LNrxeNzH/blD7c28Ca8XKUL1szZ+U9+5gihk7V7Jy67Gn66HSxHszoGrQGybcLONVi/+03NKzjM8gKm1sVRtUMpnxZ61onkgFjuJau2Tw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883238; c=relaxed/simple;
	bh=6TKZTvnr4hDLb6Pz4mcTEssQCKkCHvMQO3oyqAbQsnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmkGKV7xT6Jq7OYsm2gxgzxUu0Tdqbw0K3HaibZlRUUkZsokW790Z87v4/eBmMEiTM/CcrGeyUY4kXr3jirv2kmVitCR/5UnVaGnHISMT1+kYilPbtnlvKmLLSrFCMo5DuCqh1JAALjNh/JBOIe5vU/2+vB3FNep0P/cUFsERus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ4nhW2m; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso1399411966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722883235; x=1723488035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE/o4qSaUHLv/y40/aLwm+zO5SXvHFNVlO+ercnrRJY=;
        b=JZ4nhW2mU1mfEU7FM9StvGkOSK1CObxWpJGYe2LO5wAeO/Fm4r17V89VY+cj5EvXLZ
         ONY4V+48PD/PQNx8qPjD+baX3eYlL+ezM7Tt8kaPVhkaitB7K5sLIqo3u9c9CPWg28Hc
         3JkjeHNdvciUigJIUTdi22KClyLxNf9AJBVyMbQ7obVRMhADuIVR6d11RE1y1UegNluP
         rzKfywb+hzwbdlBPSQjadiO+UEmdIFkYKnH3I8jC0/p5Bs0X8AyMYg3s9Lj2ZLz9yNpN
         djxwg7WrCu/pt9aa3+RuyjVNCfh+2xjyW2wOmxcvvKD3iCNnxPcnuBZzXQ80agMIs1ov
         Z6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883235; x=1723488035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE/o4qSaUHLv/y40/aLwm+zO5SXvHFNVlO+ercnrRJY=;
        b=NXIKyA3QeG1bh6le9i+aCSK/1cvV/eJN/I25h9garvbMALCm8lwEIBc7mEfrdgSGur
         erSNq8lUfjKXsV3g5gLFwDiErtTk4at5f8bGZkoEz3zHgFUDOblY88gOoiF9cke8w9Xy
         eULR5q8VA1Tw8C659VtmQhpv0AOwq/UfKj2qu7RTr2hHE0RwAPw8xogMSCG6LQRnkmIR
         d1POtNdFD+FobJCcksfOrjg/E3OqV9W28OhsFzyJFocvNrtlSHm9mOy0rvnlSO8GLJ0e
         HAHfcmBrNi2sR2YN1TVjVGkUAn5JLhWuuEQKl1ZdbLxTN9HwDNznXoSKTeCU8f+BSUfS
         mUVA==
X-Forwarded-Encrypted: i=1; AJvYcCVfzRr7Ga7CHf5202kJnQVWURVBEw/SN2+gvL9L4P+5H7eaX/BYAHbpG8tT0UmdAL31mEMBKA5gcZECuHYZChhJcwqk1yOhgcHi9cQc
X-Gm-Message-State: AOJu0YwfCgCoeSaM5LkkwlxSZ5D84AFfhDesfZee5LC+eKwQo5E1JxxN
	alFTm+3cO2ga9cQwOBrTmBLCIkkRG1LnQsay0HzPQ5gJzXixSeND
X-Google-Smtp-Source: AGHT+IFkVV7ouGVBTfQqeCTN4nxr/EWf3RpQbZFrLGcAjto3LgX3mNyQ3drkidVkE3T2KpUQpA4GsQ==
X-Received: by 2002:a17:907:7f90:b0:a7a:bece:6223 with SMTP id a640c23a62f3a-a7dc4db8bfcmr957386466b.6.1722883234971;
        Mon, 05 Aug 2024 11:40:34 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c12ad3sm478517266b.88.2024.08.05.11.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:40:33 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 1/3] percpu: Define __pcpu_typeof()
Date: Mon,  5 Aug 2024 20:38:59 +0200
Message-ID: <20240805184012.358023-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805184012.358023-1-ubizjak@gmail.com>
References: <20240805184012.358023-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define __pcpu_typeof() to use __typeof_unqual__() as typeof operator
when available, to return unqualified type of the expression.

If an arch defines __percpu variables in their own named address
space, then __pcpu_typeof() returns unqualified type of the
expression without named address space quialifier when
CONFIG_CC_HAS_TYPEOF_UNQUAL is defined.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/x86/include/asm/percpu.h | 38 ++++++++++++++++++++++------------
 include/linux/part_stat.h     |  2 +-
 include/linux/percpu-defs.h   | 39 ++++++++++++++++++++++++++++-------
 init/Kconfig                  |  3 +++
 kernel/locking/percpu-rwsem.c |  2 +-
 5 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..4d31203eb0d2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -73,10 +73,14 @@
 	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off);	\
 									\
 	tcp_ptr__ += (__force unsigned long)(_ptr);			\
-	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;			\
+	(__pcpu_typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #else
-#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	BUILD_BUG();							\
+	(__pcpu_typeof(*(_ptr)) __kernel __force *)0;			\
+})
 #endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
@@ -172,7 +176,7 @@ do {									\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
 									\
-	(typeof(_var))(unsigned long) pfo_val__;			\
+	(__pcpu_typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define __raw_cpu_write(size, qual, _var, _val)				\
@@ -180,7 +184,7 @@ do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 									\
 	if (0) {		                                        \
-		typeof(_var) pto_tmp__;					\
+		__pcpu_typeof(_var) pto_tmp__;				\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
@@ -193,7 +197,11 @@ do {									\
  * The generic per-CPU infrastrucutre is not suitable for
  * reading const-qualified variables.
  */
-#define __raw_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
+#define __raw_cpu_read_const(pcp)					\
+({									\
+	BUILD_BUG();							\
+	(__pcpu_typeof(pcp))0;						\
+})
 
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
@@ -205,7 +213,7 @@ do {									\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
 									\
-	(typeof(_var))(unsigned long) pfo_val__;			\
+	(__pcpu_typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define percpu_unary_op(size, qual, op, _var)				\
@@ -219,7 +227,7 @@ do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 									\
 	if (0) {		                                        \
-		typeof(_var) pto_tmp__;					\
+		__pcpu_typeof(_var) pto_tmp__;				\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
@@ -239,7 +247,7 @@ do {									\
 				(int)(val) : 0;				\
 									\
 	if (0) {							\
-		typeof(var) pao_tmp__;					\
+		__pcpu_typeof(var) pao_tmp__;				\
 		pao_tmp__ = (val);					\
 		(void)pao_tmp__;					\
 	}								\
@@ -263,7 +271,7 @@ do {									\
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : : "memory");					\
-	(typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
+	(__pcpu_typeof(_var))(unsigned long) (paro_tmp__ + _val);	\
 })
 
 /*
@@ -272,7 +280,7 @@ do {									\
  */
 #define raw_percpu_xchg_op(_var, _nval)					\
 ({									\
-	typeof(_var) pxo_old__ = raw_cpu_read(_var);			\
+	__pcpu_typeof(_var) pxo_old__ = raw_cpu_read(_var);		\
 									\
 	raw_cpu_write(_var, _nval);					\
 									\
@@ -286,7 +294,7 @@ do {									\
  */
 #define this_percpu_xchg_op(_var, _nval)				\
 ({									\
-	typeof(_var) pxo_old__ = this_cpu_read(_var);			\
+	__pcpu_typeof(_var) pxo_old__ = this_cpu_read(_var);		\
 									\
 	do { } while (!this_cpu_try_cmpxchg(_var, &pxo_old__, _nval));	\
 									\
@@ -309,7 +317,7 @@ do {									\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
 		  : "memory");						\
 									\
-	(typeof(_var))(unsigned long) pco_old__;			\
+	(__pcpu_typeof(_var))(unsigned long) pco_old__;			\
 })
 
 #define percpu_try_cmpxchg_op(size, qual, _var, _ovalp, _nval)		\
@@ -568,7 +576,11 @@ do {									\
 #else /* !CONFIG_X86_64: */
 
 /* There is no generic 64-bit read stable operation for 32-bit targets. */
-#define this_cpu_read_stable_8(pcp)			({ BUILD_BUG(); (typeof(pcp))0; })
+#define this_cpu_read_stable_8(pcp)					\
+({									\
+	BUILD_BUG();							\
+	(__pcpu_typeof(pcp))0;						\
+})
 
 #define raw_cpu_read_long(pcp)				raw_cpu_read_4(pcp)
 
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index ac8c44dd8237..3807bc29ba05 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -33,7 +33,7 @@ struct disk_stats {
 
 #define part_stat_read(part, field)					\
 ({									\
-	typeof((part)->bd_stats->field) res = 0;			\
+	__pcpu_typeof((part)->bd_stats->field) res = 0;			\
 	unsigned int _cpu;						\
 	for_each_possible_cpu(_cpu)					\
 		res += per_cpu_ptr((part)->bd_stats, _cpu)->field; \
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8efce7414fad..842d10912fdd 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -220,6 +220,21 @@ do {									\
 	(void)__vpp_verify;						\
 } while (0)
 
+/*
+ * Define __percpu_typeof() to use __typeof_unqual__() as typeof
+ * operator when available, to return unqualified type of the exp.
+ *
+ * If an arch defines __percpu variables in their own named address
+ * space, then __pcpu_typeof() returns unqualified type of the
+ * expression without named address space qualifier when
+ * CONFIG_CC_HAS_TYPEOF_UNQUAL is defined.
+ */
+#ifdef CONFIG_CC_HAS_TYPEOF_UNQUAL
+#define __pcpu_typeof(exp) __typeof_unqual__(exp)
+#else
+#define __pcpu_typeof(exp) __typeof__(exp)
+#endif
+
 #ifdef CONFIG_SMP
 
 /*
@@ -228,7 +243,10 @@ do {									\
  * pointer value.  The weird cast keeps both GCC and sparse happy.
  */
 #define SHIFT_PERCPU_PTR(__p, __offset)					\
-	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
+	uintptr_t ptr__ = (__force uintptr_t)(__p);			\
+									\
+	RELOC_HIDE((__pcpu_typeof(*(__p)) __kernel __force *)(ptr__),	\
+		   (__offset))
 
 #define per_cpu_ptr(ptr, cpu)						\
 ({									\
@@ -254,13 +272,20 @@ do {									\
 
 #else	/* CONFIG_SMP */
 
-#define VERIFY_PERCPU_PTR(__p)						\
+#define PERCPU_PTR(__p)							\
 ({									\
-	__verify_pcpu_ptr(__p);						\
-	(typeof(*(__p)) __kernel __force *)(__p);			\
+	uintptr_t ptr__ = (__force uintptr_t)(__p);			\
+									\
+	(__pcpu_typeof(*(__p)) __kernel __force *)(ptr__);		\
+})
+
+#define per_cpu_ptr(ptr, cpu)						\
+({									\
+	__verify_pcpu_ptr(ptr);						\
+	(void)(cpu);							\
+	PERCPU_PTR(ptr);						\
 })
 
-#define per_cpu_ptr(ptr, cpu)	({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
 #define raw_cpu_ptr(ptr)	per_cpu_ptr(ptr, 0)
 #define this_cpu_ptr(ptr)	raw_cpu_ptr(ptr)
 
@@ -315,7 +340,7 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 
 #define __pcpu_size_call_return(stem, variable)				\
 ({									\
-	typeof(variable) pscr_ret__;					\
+	__pcpu_typeof(variable) pscr_ret__;				\
 	__verify_pcpu_ptr(&(variable));					\
 	switch(sizeof(variable)) {					\
 	case 1: pscr_ret__ = stem##1(variable); break;			\
@@ -330,7 +355,7 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 
 #define __pcpu_size_call_return2(stem, variable, ...)			\
 ({									\
-	typeof(variable) pscr2_ret__;					\
+	__pcpu_typeof(variable) pscr2_ret__;				\
 	__verify_pcpu_ptr(&(variable));					\
 	switch(sizeof(variable)) {					\
 	case 1: pscr2_ret__ = stem##1(variable, __VA_ARGS__); break;	\
diff --git a/init/Kconfig b/init/Kconfig
index 37260d17267e..a9a04d0683b6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -873,6 +873,9 @@ config ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 config CC_HAS_INT128
 	def_bool !$(cc-option,$(m64-flag) -D__SIZEOF_INT128__=0) && 64BIT
 
+config CC_HAS_TYPEOF_UNQUAL
+	def_bool $(success,echo 'int foo (int a) { __typeof_unqual__(a) b = a; return b; }' | $(CC) -x c - -S -o /dev/null)
+
 config CC_IMPLICIT_FALLTHROUGH
 	string
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 6083883c4fe0..ac9b2f4bcd92 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -184,7 +184,7 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
 
 #define per_cpu_sum(var)						\
 ({									\
-	typeof(var) __sum = 0;						\
+	__pcpu_typeof(var) __sum = 0;					\
 	int cpu;							\
 	compiletime_assert_atomic_type(__sum);				\
 	for_each_possible_cpu(cpu)					\
-- 
2.45.2


