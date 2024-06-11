Return-Path: <linux-kernel+bounces-209419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C001903455
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B67528B337
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A9173357;
	Tue, 11 Jun 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uooPEM6J"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07417333C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092251; cv=none; b=Ddc8rfo4GOfcIVLDS5ohRfB/E/YeYWwszW/qw8BKBRJJtkggInMivkceGj1+GJOKRr2A/60iZ3c0av1ePnHqNhywUnF/DEpMzB9qk3c73o6WpXmo3SdDh8KbLKNavc6NwS6xKmXGNJxqQfCL3w6QuBz0Ka0GuWhcsZ+yCAV6xsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092251; c=relaxed/simple;
	bh=obXNaQKtwmfKs/HeVx3sFOvUFRiQ9zUGMKMIURRICfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y2XuexzOZPMHTHhcaJXJvbyEs8FdFOQWNe/NgSmwqDmuXfv5a0/r/OA4/LVjfZSQS+6jWwbHZG2drUnsT1ESE4RkpKa9dDOuznS488fWqHn3Qzg4xlRUmzY1g9RglpBrYPzwgIjqYBnAR3Fi80+OowiPGJsay0BkEKIsTlb61m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uooPEM6J; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfb17fb0fb6so4905652276.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718092248; x=1718697048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAtcOHuRzSGyLislV7ie7CX+oVaiZiFwLMGIqPD6yUY=;
        b=uooPEM6JEKV0TGjRgjiC/worVz9Od5Nu9q+Wy1YKEV3rtjiUpKhneMZNYTsADg0e3B
         jIXQIUoLnPm1nHjTfNH24VSy5qwNh5cMMUSELoFId7w3e79rvoj73lomVZs1AE0nHlX+
         Echx6Z8f1wSqjEIWlekGyeSPvZ4Cvlrl6z6yJ3gDDw6M0RhB1TM/4lywcD3i3UYN037P
         S7ZsIcokyDmwvWxGLIdmDHc5JnsYaHy7+1f6ugP69vpXcnahXw/Ascq8ggOPH+WthTY5
         YVJ4jWStpf/0sU2rcgwDCfkRy79bxWmEmE51YssInZk/sKtBy0zyFAexFBLerU2QEyjj
         M9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092248; x=1718697048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAtcOHuRzSGyLislV7ie7CX+oVaiZiFwLMGIqPD6yUY=;
        b=vb+zoL181XwVDK93DoSLhxzsV8g22O1D/xNhZtTEzABY+bTmGbxS+Q0NqnGi+Jtic7
         3z0Tv212hsfELP1Fhm9UvxC8TDRYMCgl2+r7nyOfPVBxd6yrqUh4ZaOdA9ESgUbOXpiU
         ElwWWKSF8ufDu9Y9QyUcz0JiUL4z0vmSuBi1MAFXFfvgntDIWlacO+QPoK8jQAZE08ce
         ifNTVPEBmkZMFfYgIIrFuiRdEbnnp8L38YW4SElF0UtdIabzypOXaDg964N7fY3BDMRD
         gBcyVidbM4C5A82rzA+Vm5grwaHnx85fxotVgW1b2A5PV5g8ePLVAPc2T8xUS3fRpOpd
         GbRw==
X-Gm-Message-State: AOJu0YxF+m/B3e8DsycBA3VlLP0MuMR+xTNjCwJYzM3BBF6gJ0FU54nQ
	Y7Q2je+pq24T86DZUkoBWYRnvU0d6WQ+CYuvXzCFQFF/krLCKsS1kGP9uDexfktHRnjDplwlLg4
	16FgGIg==
X-Google-Smtp-Source: AGHT+IHNlBTt7mAmtq78eZgDXdcijLRtCEKJFBoTv8PY0G/YjnZSBVYglfX4ej9nDG1bI4uRUSG7J1jdy5f1
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:ecf:76a8:5d44:6e8b])
 (user=dvyukov job=sendgmr) by 2002:a25:ad91:0:b0:df7:d31b:7a29 with SMTP id
 3f1490d57ef6-dfaf665abb0mr2530071276.12.1718092248447; Tue, 11 Jun 2024
 00:50:48 -0700 (PDT)
Date: Tue, 11 Jun 2024 09:50:31 +0200
In-Reply-To: <cover.1718092070.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <7662127c97e29da1a748ad1c1539dd7b65b737b2.1718092070.git.dvyukov@google.com>
Subject: [PATCH v2 2/4] kcov: add interrupt handling self test
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
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com

---

Changed since v1:
 - renamed KCOV_TEST to KCOV_SELFTEST
 - improved the config description
 - loop for exactly 300ms in the test

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
 kernel/kcov.c     | 31 +++++++++++++++++++++++++++++++
 lib/Kconfig.debug |  8 ++++++++
 2 files changed, 39 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index c3124f6d5536..72a5bf55107f 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/hashtable.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/kmsan-checks.h>
 #include <linux/mm.h>
 #include <linux/preempt.h>
@@ -1057,6 +1058,32 @@ u64 kcov_common_handle(void)
 }
 EXPORT_SYMBOL(kcov_common_handle);
 
+#ifdef CONFIG_KCOV_SELFTEST
+static void __init selftest(void)
+{
+	unsigned long start;
+
+	pr_err("running self test\n");
+	/*
+	 * Test that interrupts don't produce spurious coverage.
+	 * The coverage callback filters out interrupt code, but only
+	 * after the handler updates preempt count. Some code periodically
+	 * leaks out of that section and leads to spurious coverage.
+	 * It's hard to call the actual interrupt handler directly,
+	 * so we just loop here for a bit waiting for a timer interrupt.
+	 * We set kcov_mode to enable tracing, but don't setup the area,
+	 * so any attempt to trace will crash. Note: we must not call any
+	 * potentially traced functions in this region.
+	 */
+	start = jiffies;
+	current->kcov_mode = KCOV_MODE_TRACE_PC;
+	while ((jiffies - start) * MSEC_PER_SEC / HZ < 300)
+		;
+	current->kcov_mode = 0;
+	pr_err("done running self test\n");
+}
+#endif
+
 static int __init kcov_init(void)
 {
 	int cpu;
@@ -1076,6 +1103,10 @@ static int __init kcov_init(void)
 	 */
 	debugfs_create_file_unsafe("kcov", 0600, NULL, NULL, &kcov_fops);
 
+#ifdef CONFIG_KCOV_SELFTEST
+	selftest();
+#endif
+
 	return 0;
 }
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..695a437a52d9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2171,6 +2171,14 @@ config KCOV_IRQ_AREA_SIZE
 	  soft interrupts. This specifies the size of those areas in the
 	  number of unsigned long words.
 
+config KCOV_SELFTEST
+	bool "Perform short selftests on boot"
+	depends on KCOV
+	help
+	  Run short KCOV coverage collection selftests on boot.
+	  On test failure, causes the kernel to panic. Recommended to be
+	  enabled, ensuring critical functionality works as intended.
+
 menuconfig RUNTIME_TESTING_MENU
 	bool "Runtime Testing"
 	default y
-- 
2.45.2.505.gda0bf45e8d-goog


