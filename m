Return-Path: <linux-kernel+bounces-200740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201068FB489
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C921B27A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F77D182D2;
	Tue,  4 Jun 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="baj0BDsg"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEE1755B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508724; cv=none; b=so71U+WRO5bEb1prFdZ2QYnlwzfT8i8OEJh+B69908Ej30QDLZ6N4Nfw/nDcfc/v7JenBHxm2QKLYFyHkI6sctM+EWxrEx6O+SIuUwLMl6TyZDLIjmO8Bzk0bXskWGHKVU5QLEqjILoeciz133ME0pnzS7INtyYZnhLR4yQ7MNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508724; c=relaxed/simple;
	bh=hKlh8wSLpHYjQZ00z5cSoH3V/VHXsRFhCXxLunpXjZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mc6Q1reXZQaXx7cfbLVjCxpG0hyRknURoUL2u3Mr1MOHekoHsZhHtbtf7L4TgX1Efg+ebzEe1mevKjEVXlQoyPQscXPpAfIhX2jPZJHBeqjTgME/bYUho+Grsbc6X5EWGJaIrOa4383JdsR77LUw66dugERyUQZfI5VmVOo2QyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=baj0BDsg; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-57a32f2f782so602760a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717508721; x=1718113521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6EPyYWpPcV+5NfvSnZb4FIJDEsQgnCMX3rGaAHKq7k=;
        b=baj0BDsgksOwfM0b7rZDPQYaTnCBjRdyzl7C1HTLnGkNXgL35hAicPup7b6wpvAo65
         assCzdDwhlUIgavFxGWm7uZFxAuxCcLuwc+/P/JrW34wLlsx9uTRjDkiGDtq60OTKjXA
         jC2bCeap80uPKvPwNpFnRV4TJkqt2+H/NSEWc/Do0/M7qB5VTxejnDitQunC8GL9tAG4
         tFt8tQB4BlZVVseIAsEzJu+meWWjAfyACr1D4bNCVU8CyGCZwzEvP2OdmmpkUy8/9XtP
         w+RBc1ouyrMlzooVUr0VnqM1Fd7IZiYYFDyHOogDvdDdl6vLiPmMr4DpaaqzTWVlav4D
         EubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508721; x=1718113521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6EPyYWpPcV+5NfvSnZb4FIJDEsQgnCMX3rGaAHKq7k=;
        b=UJ2lutcJnOmQ4xpSMAUz7mv70OP38Olw8Fz+hqZyiltN25lEA0Qvw+G41FAUfK1EBF
         Oem43EtG+rl5KoF2FKg4TqTis8sFKPmFx5CFoksy943ica+TDe5CbPOE8fiRzj+oCW6p
         tQibhffVc+UFKYlT4mnhEm7TXbbOyQFr1Ti6HvdozrUmE7kFUkrhuFG9Uaor6cIP5vBD
         /PTSUVExK2BX8bGG/P5pB5fJUzFpXZ+bFvWn2sAwUJ3UP2HRHJGtewaL7sBi7s4wFWWN
         Z/jP9s2CHA0FVVXUObMFL9mdU+hdn237zHffXVgZ8M91PAV8N4dKhEaUpU73t3lDQTnS
         d5Hw==
X-Gm-Message-State: AOJu0YxOVjUIHZsOd2RdkmCN1m7zlS7fkLAn5RnRVR9m/P3XsHjFldS8
	t6BVqFGaRBc5p9w9Xa60EMWHEWcvC3y+6Gu4x0ors8hWOgp8RMsrbfw7vEddq8/rxgccQqN+Fsq
	+BH2A9A==
X-Google-Smtp-Source: AGHT+IE77ud1956R29vGZAYu63z48AEP617RiQyEfP6nSn1grWpFCRZzwp0bmaj7cTS2Uw50c0BJt91Ko4lo
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:789f:7f5b:3f40:46c8])
 (user=dvyukov job=sendgmr) by 2002:a05:6402:5309:b0:57a:5e7c:d9ef with SMTP
 id 4fb4d7f45d1cf-57a5e7cdac6mr7044a12.6.1717508720597; Tue, 04 Jun 2024
 06:45:20 -0700 (PDT)
Date: Tue,  4 Jun 2024 15:45:03 +0200
In-Reply-To: <cover.1717507310.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <80972769ad2ebebc7ab0c39bd48f31ce080f0394.1717507310.git.dvyukov@google.com>
Subject: [PATCH 2/4] kcov: add interrupt handling self test
From: Dmitry Vyukov <dvyukov@google.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, elver@google.com, 
	glider@google.com, nogikh@google.com, tarasmadan@google.com, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a boot self test that can catch sprious coverage from interrupts.
The coverage callback filters out interrupt code, but only after the
handler updates preempt count. Some code periodically leaks out
of that section and leads to spurious coverage.
Add a best-effort (but simple) test that is likely to catch such bugs.
If the test is enabled on CI systems that use KCOV, they should catch
any issues fast.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com

---

In my local testing w/o the previous fix,
it immidiatly produced the following splat:

kcov: running selftest
BUG: TASK stack guard page was hit at ffffc90000147ff8
Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN PTI
...
 kvm_set_cpu_l1tf_flush_l1d+0x5/0x20
 sysvec_call_function+0x15/0xb0
 asm_sysvec_call_function+0x1a/0x20
 kcov_init+0xe4/0x130
 do_one_initcall+0xbc/0x470
 kernel_init_freeable+0x4fc/0x930
 kernel_init+0x1c/0x2b0
---
 kernel/kcov.c     | 28 ++++++++++++++++++++++++++++
 lib/Kconfig.debug |  9 +++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index c3124f6d5536..04136f80042f 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -1057,6 +1057,30 @@ u64 kcov_common_handle(void)
 }
 EXPORT_SYMBOL(kcov_common_handle);
 
+#ifdef CONFIG_KCOV_TEST
+static void __init selftest(void)
+{
+	volatile int i;
+
+	pr_err("running self test\n");
+	/*
+	 * Test that interrupts don't produce spurious coverage.
+	 * The coverage callback filters out interrupt code, but only
+	 * after the handler updates preempt count. Some code periodically
+	 * leaks out of that section and leads to spurious coverage.
+	 * It's hard to call the actual interrupt handler directly,
+	 * so we just loop here for ~400 ms waiting for a timer interrupt.
+	 * We set kcov_mode to enable tracing, but don't setup the area,
+	 * so any attempt to trace will crash.
+	 */
+	current->kcov_mode = KCOV_MODE_TRACE_PC;
+	for (i = 0; i < (1 << 28); i++)
+		;
+	current->kcov_mode = 0;
+	pr_err("done running self test\n");
+}
+#endif
+
 static int __init kcov_init(void)
 {
 	int cpu;
@@ -1076,6 +1100,10 @@ static int __init kcov_init(void)
 	 */
 	debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
 
+#ifdef CONFIG_KCOV_TEST
+	selftest();
+#endif
+
 	return 0;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..79836a15b6cb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2171,6 +2171,15 @@ config KCOV_IRQ_AREA_SIZE
 	  soft interrupts. This specifies the size of those areas in the
 	  number of unsigned long words.
 
+config KCOV_TEST
+	bool "Test CONFIG_KCOV feature"
+	depends on KCOV
+	help
+	  Sanity check for KCOV coverage collection.
+	  Runs built-in self test on boot to detect some common issues.
+
+	  If unsure, say N.
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	default y
-- 
2.45.1.467.gbab1589fc0-goog


