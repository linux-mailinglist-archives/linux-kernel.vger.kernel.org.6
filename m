Return-Path: <linux-kernel+bounces-283035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE1894EC36
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3375328248D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E177B16BE24;
	Mon, 12 Aug 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmUl+6oA"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1491779A4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464002; cv=none; b=m5uonxafi6oIAN7e9brGodY/aznuO+dB/W0j698fW0mIcgXNqB8MVHqFYQu9pIEuFPLIRIgcSICLKqe0MqbGDoeXUpHVfx1Wsz7vVFI7VjK0MgymsQi6fZV/a/1whC5dpW4Huo4Jd+CtAogKNkX257F2A4bVLPtc17TlXTlTwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464002; c=relaxed/simple;
	bh=vmXxu2Bpkktda/zGB5IUkhfiITUIErTtQ92h56iIjHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtME0UEpGeTSes5cKjUNeVO/PK+p+0OZJFYhgQdedR+7SYBfqmzfawlHUIHlFuFuG1Xz42qGoMN3w32ZO/PVWWNfZLpxZd154MOSmT2kJ7ntuAT1zyOk9ss9Nec19JJ1LGSDBFocyX8N5aSZBCsw7y0o3rvlST7k7OQpj48U35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmUl+6oA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso5736229a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723463999; x=1724068799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fruDKXqvLpvOHXHlfsYMBztoBLfQBCYZJcuGnYhVG7c=;
        b=ZmUl+6oAMaGLE2SYliqbyz1VAh22PH7JbiS5UbmS9obXt2/cCLAdVCeQB2lxSTdFCr
         hjoIENIObrPl4bvretAa6pFjY89WH7qIIOR6aIEMkdQtj6WMAvaQVG6MWg+SLRj7ZnQE
         i9rrvugObayrVAd0E3q8idxUX/v4ZQ9OQuWSUqFTeS9iA/9qxTM/bx7D1WEKutOxDjhz
         HDkx6wKSAvrqAnz8od5GYQtm7n9gPKJb4rQ0edseCdqaySRNMWLmsylOJJ1EqNbHjRU8
         9vnNDYanc8oIRWzsY7ZrDl74oE0XIoAztw6iFqJcIE0eFeKqdYliIUSkj8L6tVstq+En
         nQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723463999; x=1724068799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fruDKXqvLpvOHXHlfsYMBztoBLfQBCYZJcuGnYhVG7c=;
        b=k3d8x5Vy8vYnac0UtBLv2fBR3tzCOK9ddZs51qr1RC6GWd2vZYD6l1m05g+f+yHNhJ
         FRp6n0G3vt1fX4gEe1T8A9ZZxUkzq6++6BlsCAPmJykfr/wOv1BMza5kd6fOQhXC/R5x
         VR2SXY8DaXDxG6cT8T3OUwBei/4IEYqAp3liINDlBEbsDKtar87Id2SL+DQ93zdxxs//
         IHv4uZtsr2b31IOj2tmpBozMi1SyUvScQeUTiVybajymSNuYW4Y0dH873sS7AxF4UNKG
         u7oipFcmX2wuQqFWD11igo3iGb/z9v9lxQtBzdjvop5SBoahqn8wHpgKkyoow9t2Sxrf
         c6rg==
X-Forwarded-Encrypted: i=1; AJvYcCWW6EfOaVgnD4ZA8ddSZ4gPxU13MMp+bWtPpqzePjQWhSRuYKC76TYkblfgh71n5bnuYFCeH/VTJQ6HkKofAFMfDQqiaekrAhwqsqQ5
X-Gm-Message-State: AOJu0YwGI2ZrhpRYI8jgqVquGn11yA6ICUqhhMgo9G1HFiBoSJPDXf3o
	ENHaAgsMfngIHksRqA3lbZoHT0W25y37D+h36YxVMAueztOjPDutoVYX4v63EKY=
X-Google-Smtp-Source: AGHT+IHuOkc+I/HRzwKiheSTIvJj3Z6nmuPXhvaWwBFb6EcIiM2K0UMjtS7f0OP9qPL7ja6c4c3zXg==
X-Received: by 2002:a05:6402:27d0:b0:57c:7471:a0dd with SMTP id 4fb4d7f45d1cf-5bd44c2fb29mr21508a12.12.1723463998274;
        Mon, 12 Aug 2024 04:59:58 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e04aesm2055970a12.76.2024.08.12.04.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:59:57 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH v2 1/4] percpu: Define pcpu_typeof()
Date: Mon, 12 Aug 2024 13:57:35 +0200
Message-ID: <20240812115945.484051-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812115945.484051-1-ubizjak@gmail.com>
References: <20240812115945.484051-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define pcpu_typeof() to use __typeof_unqual__() as typeof operator
when available, to return unqualified type of the expression.

If an arch defines __percpu variables in their own named address
space, then pcpu_typeof() returns unqualified type of the
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
 include/asm-generic/percpu.h  | 26 +++++++++++------------
 include/linux/part_stat.h     |  2 +-
 include/linux/percpu-defs.h   | 39 ++++++++++++++++++++++++++++-------
 init/Kconfig                  |  3 +++
 kernel/locking/percpu-rwsem.c |  2 +-
 6 files changed, 75 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..4ab4ad60d767 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -73,10 +73,14 @@
 	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off);	\
 									\
 	tcp_ptr__ += (__force unsigned long)(_ptr);			\
-	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;			\
+	(pcpu_typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #else
-#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	BUILD_BUG();							\
+	(pcpu_typeof(*(_ptr)) __kernel __force *)0;			\
+})
 #endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
@@ -172,7 +176,7 @@ do {									\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
 									\
-	(typeof(_var))(unsigned long) pfo_val__;			\
+	(pcpu_typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define __raw_cpu_write(size, qual, _var, _val)				\
@@ -180,7 +184,7 @@ do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 									\
 	if (0) {		                                        \
-		typeof(_var) pto_tmp__;					\
+		pcpu_typeof(_var) pto_tmp__;				\
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
+	(pcpu_typeof(pcp))0;						\
+})
 
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
@@ -205,7 +213,7 @@ do {									\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
 									\
-	(typeof(_var))(unsigned long) pfo_val__;			\
+	(pcpu_typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define percpu_unary_op(size, qual, op, _var)				\
@@ -219,7 +227,7 @@ do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
 									\
 	if (0) {		                                        \
-		typeof(_var) pto_tmp__;					\
+		pcpu_typeof(_var) pto_tmp__;				\
 		pto_tmp__ = (_val);					\
 		(void)pto_tmp__;					\
 	}								\
@@ -239,7 +247,7 @@ do {									\
 				(int)(val) : 0;				\
 									\
 	if (0) {							\
-		typeof(var) pao_tmp__;					\
+		pcpu_typeof(var) pao_tmp__;				\
 		pao_tmp__ = (val);					\
 		(void)pao_tmp__;					\
 	}								\
@@ -263,7 +271,7 @@ do {									\
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : : "memory");					\
-	(typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
+	(pcpu_typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
 })
 
 /*
@@ -272,7 +280,7 @@ do {									\
  */
 #define raw_percpu_xchg_op(_var, _nval)					\
 ({									\
-	typeof(_var) pxo_old__ = raw_cpu_read(_var);			\
+	pcpu_typeof(_var) pxo_old__ = raw_cpu_read(_var);		\
 									\
 	raw_cpu_write(_var, _nval);					\
 									\
@@ -286,7 +294,7 @@ do {									\
  */
 #define this_percpu_xchg_op(_var, _nval)				\
 ({									\
-	typeof(_var) pxo_old__ = this_cpu_read(_var);			\
+	pcpu_typeof(_var) pxo_old__ = this_cpu_read(_var);		\
 									\
 	do { } while (!this_cpu_try_cmpxchg(_var, &pxo_old__, _nval));	\
 									\
@@ -309,7 +317,7 @@ do {									\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
 		  : "memory");						\
 									\
-	(typeof(_var))(unsigned long) pco_old__;			\
+	(pcpu_typeof(_var))(unsigned long) pco_old__;			\
 })
 
 #define percpu_try_cmpxchg_op(size, qual, _var, _ovalp, _nval)		\
@@ -568,7 +576,11 @@ do {									\
 #else /* !CONFIG_X86_64: */
 
 /* There is no generic 64-bit read stable operation for 32-bit targets. */
-#define this_cpu_read_stable_8(pcp)			({ BUILD_BUG(); (typeof(pcp))0; })
+#define this_cpu_read_stable_8(pcp)					\
+({									\
+	BUILD_BUG();							\
+	(pcpu_typeof(pcp))0;						\
+})
 
 #define raw_cpu_read_long(pcp)				raw_cpu_read_4(pcp)
 
diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 94cbd50cc870..c091e09046c5 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -74,7 +74,7 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
+	pcpu_typeof(pcp) *__p = raw_cpu_ptr(&(pcp));			\
 									\
 	*__p += val;							\
 	*__p;								\
@@ -82,8 +82,8 @@ do {									\
 
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
-	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
-	typeof(pcp) __ret;						\
+	pcpu_typeof(pcp) *__p = raw_cpu_ptr(&(pcp));			\
+	pcpu_typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	*__p = nval;							\
 	__ret;								\
@@ -91,7 +91,7 @@ do {									\
 
 #define __cpu_fallback_try_cmpxchg(pcp, ovalp, nval, _cmpxchg)		\
 ({									\
-	typeof(pcp) __val, __old = *(ovalp);				\
+	pcpu_typeof(pcp) __val, __old = *(ovalp);			\
 	__val = _cmpxchg(pcp, __old, nval);				\
 	if (__val != __old)						\
 		*(ovalp) = __val;					\
@@ -100,8 +100,8 @@ do {									\
 
 #define raw_cpu_generic_try_cmpxchg(pcp, ovalp, nval)			\
 ({									\
-	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
-	typeof(pcp) __val = *__p, ___old = *(ovalp);			\
+	pcpu_typeof(pcp) *__p = raw_cpu_ptr(&(pcp));			\
+	pcpu_typeof(pcp) __val = *__p, ___old = *(ovalp);		\
 	bool __ret;							\
 	if (__val == ___old) {						\
 		*__p = nval;						\
@@ -115,14 +115,14 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(pcp) __old = (oval);					\
+	pcpu_typeof(pcp) __old = (oval);				\
 	raw_cpu_generic_try_cmpxchg(pcp, &__old, nval);			\
 	__old;								\
 })
 
 #define __this_cpu_generic_read_nopreempt(pcp)				\
 ({									\
-	typeof(pcp) ___ret;						\
+	pcpu_typeof(pcp) ___ret;					\
 	preempt_disable_notrace();					\
 	___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));			\
 	preempt_enable_notrace();					\
@@ -131,7 +131,7 @@ do {									\
 
 #define __this_cpu_generic_read_noirq(pcp)				\
 ({									\
-	typeof(pcp) ___ret;						\
+	pcpu_typeof(pcp) ___ret;					\
 	unsigned long ___flags;						\
 	raw_local_irq_save(___flags);					\
 	___ret = raw_cpu_generic_read(pcp);				\
@@ -141,7 +141,7 @@ do {									\
 
 #define this_cpu_generic_read(pcp)					\
 ({									\
-	typeof(pcp) __ret;						\
+	pcpu_typeof(pcp) __ret;						\
 	if (__native_word(pcp))						\
 		__ret = __this_cpu_generic_read_nopreempt(pcp);		\
 	else								\
@@ -160,7 +160,7 @@ do {									\
 
 #define this_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(pcp) __ret;						\
+	pcpu_typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_add_return(pcp, val);			\
@@ -170,7 +170,7 @@ do {									\
 
 #define this_cpu_generic_xchg(pcp, nval)				\
 ({									\
-	typeof(pcp) __ret;						\
+	pcpu_typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_xchg(pcp, nval);			\
@@ -190,7 +190,7 @@ do {									\
 
 #define this_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(pcp) __ret;						\
+	pcpu_typeof(pcp) __ret;						\
 	unsigned long __flags;						\
 	raw_local_irq_save(__flags);					\
 	__ret = raw_cpu_generic_cmpxchg(pcp, oval, nval);		\
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index ac8c44dd8237..e228e1087f0c 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -33,7 +33,7 @@ struct disk_stats {
 
 #define part_stat_read(part, field)					\
 ({									\
-	typeof((part)->bd_stats->field) res = 0;			\
+	pcpu_typeof((part)->bd_stats->field) res = 0;			\
 	unsigned int _cpu;						\
 	for_each_possible_cpu(_cpu)					\
 		res += per_cpu_ptr((part)->bd_stats, _cpu)->field; \
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8efce7414fad..aa824c6edb82 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -220,6 +220,21 @@ do {									\
 	(void)__vpp_verify;						\
 } while (0)
 
+/*
+ * Define percpu_typeof() to use __typeof_unqual__() as typeof
+ * operator when available, to return unqualified type of the exp.
+ *
+ * If an arch defines __percpu variables in their own named address
+ * space, then pcpu_typeof() returns unqualified type of the
+ * expression without named address space qualifier when
+ * CONFIG_CC_HAS_TYPEOF_UNQUAL is defined.
+ */
+#ifdef CONFIG_CC_HAS_TYPEOF_UNQUAL
+#define pcpu_typeof(exp) __typeof_unqual__(exp)
+#else
+#define pcpu_typeof(exp) __typeof__(exp)
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
+	RELOC_HIDE((pcpu_typeof(*(__p)) __kernel __force *)(ptr__),	\
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
+	(pcpu_typeof(*(__p)) __kernel __force *)(ptr__);		\
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
+	pcpu_typeof(variable) pscr_ret__;				\
 	__verify_pcpu_ptr(&(variable));					\
 	switch(sizeof(variable)) {					\
 	case 1: pscr_ret__ = stem##1(variable); break;			\
@@ -330,7 +355,7 @@ static __always_inline void __this_cpu_preempt_check(const char *op) { }
 
 #define __pcpu_size_call_return2(stem, variable, ...)			\
 ({									\
-	typeof(variable) pscr2_ret__;					\
+	pcpu_typeof(variable) pscr2_ret__;				\
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
index 6083883c4fe0..8345238ba428 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -184,7 +184,7 @@ EXPORT_SYMBOL_GPL(__percpu_down_read);
 
 #define per_cpu_sum(var)						\
 ({									\
-	typeof(var) __sum = 0;						\
+	pcpu_typeof(var) __sum = 0;					\
 	int cpu;							\
 	compiletime_assert_atomic_type(__sum);				\
 	for_each_possible_cpu(cpu)					\
-- 
2.46.0


