Return-Path: <linux-kernel+bounces-200739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967068FB437
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A53A2824F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256C8F68;
	Tue,  4 Jun 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KbZIfDOM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860063E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508720; cv=none; b=UJ3FMcit1MXmEzNPD9kLtNFdCMCMnpiQHPXhhr5Yddz33vQbw3rWl3x6x2NmhZRpwaf2h3cmhzqQAM1FdNY/GSNKhdl+QupE8KzF9BDuy2WMRGCQEGmrov0N2bSkvnJvV/LAbLsBwTuuTt0DllIWH804vyKRnoSbeYp+2XoAXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508720; c=relaxed/simple;
	bh=frboxRgAfUv+GKJapbgwQIbwJyHgxcCvYSSnLVeO6+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DgAcuj2eByIjMIXBsDUe4hU9lfjLfUYkpkhZHbjm9l4BLrrGEoBuC8xizwLo+twxEdD6BMwBqYyrE1Os7Aijm5acrzmA90MCuXkh6OrH4LQYrYEYnEe1YOddjE105wNJfHvj80d/pOS5Q5AUlWJqw7HLHmTO5XGYL+6ZYYkAj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KbZIfDOM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62c7a4f8cd6so79853017b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717508718; x=1718113518; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ3cUtQegabfCatPhpVz93lfzqoV7rdzjimbbupxJg8=;
        b=KbZIfDOMV4Xs/nxNp/xJnVtB/EJ8ERPuCeu/HcrbLpoIc29kQYO8egrId5AhZ7gSpj
         P2164+DvvR+F83RxJ5D5bLY53tXbT2Ol18oaDR1cD8CmtyZ51Bgz9T3NXzvrESpKqCcq
         ACH0e1EM2nvfre8QKM4IFrR/ywH8YHWmEAbC9acqrcmDjGW5OYTzhdeaAKKbwb9fgaHG
         kZeQVBSrVOEQjDgRa+g+bhrCTKcw2uRhvqM8Tc5Akx+CpEg9gZQjYaWdOUjLvpmsKAYI
         e5MEQl/dBlx9gbXf5eOoENoLlq7H901Uwh23QHufL9RbzB8lXCDh3keDYGz14qCbk6QK
         dxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508718; x=1718113518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ3cUtQegabfCatPhpVz93lfzqoV7rdzjimbbupxJg8=;
        b=Q26KougC9aYTbBg6qxRVqpDFiwqe1UjscM51rF/D7/ja1RDbwxbj47uewMS8o3U0rx
         6D4zH+XFqN6A87DkUQ39ZVF53/BJEFRdWL2s+/cxj7YSCCdnHE9QG2OeivDr9iJFyqBP
         0WQpI9x2xz/2oSf0aqcx0izFch5ccjcDgA+dqkFNj1lCNz1ybl3RcbEmKc4vj/TqMDHe
         gpY6Eokin+TQNzk62cYNGSFQ/rTAj7mOJitDktrtVXWMrp1g7ZWUMrr1/2PIOAjShznj
         NRJo3C5yJliFNuCMGxZm5gU01d6Mk/whLvNBBPAJIA4W+GDWTbm3VeYrGALxFgZji0qS
         2Q/w==
X-Gm-Message-State: AOJu0Yz7ui0pQe744b1Hu2m6avG60OJ4y3Knv12SX4gLHxw/1eSBppfP
	0RIDJiX4szIRVqggj8IhY53TA8F/UoFT0fJs3KB6nPoVazH/tBqXV5v6lCcuMkNAGBrnHhDhxZr
	7WR8XnQ==
X-Google-Smtp-Source: AGHT+IEkbNeSKC24YXNp8hEAS/4YltjsT2mzNRgclESiFRqUSFfQm058/Kdmud9BhwszYySoplorz7Dc+9sJ
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:789f:7f5b:3f40:46c8])
 (user=dvyukov job=sendgmr) by 2002:a05:690c:3506:b0:61b:e6d8:1c01 with SMTP
 id 00721157ae682-62c79896e11mr27605477b3.10.1717508717741; Tue, 04 Jun 2024
 06:45:17 -0700 (PDT)
Date: Tue,  4 Jun 2024 15:45:02 +0200
In-Reply-To: <cover.1717507310.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <1ada3be307bbd076c4ea63530cf445e7fbd0e4e7.1717507310.git.dvyukov@google.com>
Subject: [PATCH 1/4] x86/entry: Remove unwanted instrumentation in common_interrupt()
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
2.45.1.467.gbab1589fc0-goog


