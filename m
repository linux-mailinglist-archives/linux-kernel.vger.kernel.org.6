Return-Path: <linux-kernel+bounces-209418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC9903454
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D88A28AB74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C1017332E;
	Tue, 11 Jun 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CaZluKs4"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8610173324
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092248; cv=none; b=OKEdSrGWQZbJVkibwaSJxsomP8Wv/qmgZ5RanmcyP4oW6zUZBpWs7RNHkhUzvSwhSG8z3YCpiAs3g2UCrUD3285AntyyT/5ah7It+6eetEYcqMCWPTuN2phuPQzHWBiMD9JdVCBpunlaUbS/2imll3ynzcnbYYOsXUdAU9yxKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092248; c=relaxed/simple;
	bh=7WFTaoPd6g0ZpYQbP4UGUhGjBxvqWVx9Cf/jADBYR7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TMAkOiFProJyc5OBq4bONjVR7R6gqFXnzEySBMLh1rOsXDXLnIwqzVN+ecC5abi9H03xRGcPsVqx2cI04gXiDEpEDqYh2gaVRYaptn1yMwXoV5U/aZ8aeL2GJ8AoQpo9Z6Exf2cJIwKygTn0RIO9rCgi8EVlPBg5sZHRqFLiDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CaZluKs4; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-57a306c4b1eso3701163a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718092245; x=1718697045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwuQA0p0+HG46lx6pF3ZZS+XaAeBpStGoMIngkuSx9c=;
        b=CaZluKs4A8t9ntBtZoNUTT5QOLc2OU+a2OsairG4ExWKPi3jb3fouovASiIWy1j7HF
         fdn0GImRyVQ/bOgSv/WiMoC+WsIt8iON35tQJgtJtw/btgKzRcAYCTgvLs7MiyAQ3UQX
         Zt2RRl4/sS4gC1MqddLAuRhj5ZlPNe0TQhC1KHR5KOIMVgVmr5WUSB6nGvnH5T9f0ACk
         eRX11VrsOu9oMJ0Yi2x0LEUXtLdJQo5fpBx3umGfO8k7AZcoF3oGZ5YoG0z1xrGISVjP
         6j1Yq3204ifXENo1eEpl2Zav2UOgzoCu5UFJTLOKH3XfWJNpL9RZuyiF5bl+UFnblPpu
         P2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092245; x=1718697045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwuQA0p0+HG46lx6pF3ZZS+XaAeBpStGoMIngkuSx9c=;
        b=aQlPuzCtb3UBQ+pYzYwXoPnhXXNDgNhMmgjXHI1i+NbVcgp2cp0DmlMoBtCyMNaAwg
         W4Xw1GN09l0gR/YXWCXrQyQ5p2q083lmS+Fgqo/qtKPji29REdboyr+d6yTeWNyUFyo5
         VJh6D6UGrAGrraG/ULK6h/l43pfMe6U35BnLTKu09JJz7pKI947daUrmiVxhlraJv0td
         VnGvMx1Hsk+XR+RbleAIhP19GAm4Q+uX7laYpW4ykkikNDSGmi3zexm+zx4aFU7MtTOL
         xjrYCHSKl4sUicPYIuFYZIyaHQWS5QOOxcMPLbfh1fQQFGz4TiFcuLUngW53mT0XUk3u
         2fLw==
X-Gm-Message-State: AOJu0YyO2+V+RJ49GrjUP5xNn9y8lCkUEw4YReWLJuXXsTRsod0duYlk
	KA6mnXwxkoQnpaQ7sXcFyubFIt/BRiTL6lVDn3DGzvU4QI75UBmb8w+/MrrA6T/ZLS+uKUs0tNu
	3Qe4kVw==
X-Google-Smtp-Source: AGHT+IEfApTwOGG3l/6rsfCwCSPsaLFJ3yD1+iIRVS72JUcJsFxfC5+Ok6FlJY/rf3pz2IQmxfsVY25piVL1
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ecf:76a8:5d44:6e8b])
 (user=dvyukov job=sendgmr) by 2002:a05:6402:3809:b0:57c:82b2:8699 with SMTP
 id 4fb4d7f45d1cf-57c82b28836mr6596a12.6.1718092243480; Tue, 11 Jun 2024
 00:50:43 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:50:30 +0200
In-Reply-To: <cover.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <3f9a1de9e415fcb53d07dc9e19fa8481bb021b1b.1718092070.git.dvyukov@google.com>
Subject: [PATCH v2 1/4] x86/entry: Remove unwanted instrumentation in common_interrupt()
From: Dmitry Vyukov <dvyukov@google.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

common_interrupt() and friends call kvm_set_cpu_l1tf_flush_l1d(),
which is not marked as noinstr nor __always_inline.
So compiler outlines it and adds instrumentation to it.
Since the call is inside of instrumentation_begin/end(),
objtool does not warn about it.

The manifestation is that KCOV produces spurious coverage
in kvm_set_cpu_l1tf_flush_l1d() in random places because
the call happens when preempt count is not yet updated
to say that we are in an interrupt.

Mark kvm_set_cpu_l1tf_flush_l1d() as __always_inline and move
out of instrumentation_begin/end() section.
It only calls __this_cpu_write() which is already safe to call
in noinstr contexts.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Fixes: 6368558c3710 ("x86/entry: Provide IDTENTRY_SYSVEC")
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
---
 arch/x86/include/asm/hardirq.h  | 8 ++++++--
 arch/x86/include/asm/idtentry.h | 6 +++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index c67fa6ad098a..6ffa8b75f4cd 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -69,7 +69,11 @@ extern u64 arch_irq_stat(void);
 #define local_softirq_pending_ref       pcpu_hot.softirq_pending
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
-static inline void kvm_set_cpu_l1tf_flush_l1d(void)
+/*
+ * This function is called from noinstr interrupt contexts
+ * and must be inlined to not get instrumentation.
+ */
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void)
 {
 	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
 }
@@ -84,7 +88,7 @@ static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
 	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
 }
 #else /* !IS_ENABLED(CONFIG_KVM_INTEL) */
-static inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
+static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void) { }
 #endif /* IS_ENABLED(CONFIG_KVM_INTEL) */
 
 #endif /* _ASM_X86_HARDIRQ_H */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index d4f24499b256..ad5c68f0509d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -212,8 +212,8 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	irqentry_state_t state = irqentry_enter(regs);			\
 	u32 vector = (u32)(u8)error_code;				\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_irq_on_irqstack_cond(__##func, regs, vector);		\
 	instrumentation_end();						\
 	irqentry_exit(regs, state);					\
@@ -250,7 +250,6 @@ static void __##func(struct pt_regs *regs);				\
 									\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	run_sysvec_on_irqstack_cond(__##func, regs);			\
 }									\
 									\
@@ -258,6 +257,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
@@ -288,7 +288,6 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 static __always_inline void instr_##func(struct pt_regs *regs)		\
 {									\
 	__irq_enter_raw();						\
-	kvm_set_cpu_l1tf_flush_l1d();					\
 	__##func (regs);						\
 	__irq_exit_raw();						\
 }									\
@@ -297,6 +296,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
 {									\
 	irqentry_state_t state = irqentry_enter(regs);			\
 									\
+	kvm_set_cpu_l1tf_flush_l1d();                                   \
 	instrumentation_begin();					\
 	instr_##func (regs);						\
 	instrumentation_end();						\
-- 
2.45.2.505.gda0bf45e8d-goog


