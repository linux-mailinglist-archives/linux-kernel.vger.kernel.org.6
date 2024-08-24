Return-Path: <linux-kernel+bounces-300006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F090B95DD76
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711EF1F21F74
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B01684A5;
	Sat, 24 Aug 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4bq6LWp"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB38156242
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724498107; cv=none; b=aDKOg0G0xnS77XWruJ67lYX5jKkuV3rH2uyl+8JK6dHkUL2ReRkctgYVelvhYghgkX/fv+eQidfEww+CyG/xIlqBBx01/8TexnPSTSxAFgdiBxgRmB+10tiPz70SgKJfAsDyEtajODhkba08CnwgCW5Y4A7iJAAe6qMW3gcqPME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724498107; c=relaxed/simple;
	bh=O7YC1+vk3fbc13gzzalwrKhUK1pHLayxfwa57rIKDPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bMqj/H/jlOGIMIoVEqEhL92fba4vm+cYv8rDi+m7236qFTUqbeoUghw3x0Magbv/CU8nhTCg86XcPqcMNYhfJCOoNQh+pJ10MYaTALUXzWvD//A3uektQWNd1Hc2tIYwgJjniOv5HyHuKYnEc5cx/y3urkc/NFVSnm5xKyHlG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4bq6LWp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-202146e9538so24858245ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724498105; x=1725102905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtgbP1Eu0xbx3WuHiPWCXRNvM9xiFDKBn97sk+bYRDE=;
        b=c4bq6LWpG3oFa9VtUPY2zhakMAg40Xo4bj2lYjXwLWBIfB0aXpaL7b5t5xQLDsyu+U
         rE3F4oWb+IDzfWh+/sbfsmJ+L2s308gBus7oXXr1LbRfdc0dESSPYokjCuesjNNqK9K2
         4kpev0J7W7NI6mtqH9iqTH551r/+VT9/339Mc9K7APBOTXypv85mGV7z0UNlCWxtR6zf
         F7ABJdsgYXmGJiv04dCeERJ89Q0/So7dhfAZcY+dGUe36itS1PJi7MODTMDFHCX3fajf
         KFSpiMV2GjFknSwCINoaF9esf2/vEcHr6K4kgNo8oZmCSoqrv5G1wcKm3vCWEPo37isq
         gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724498105; x=1725102905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtgbP1Eu0xbx3WuHiPWCXRNvM9xiFDKBn97sk+bYRDE=;
        b=UzIwXgeIhsulHvmDVtY4RpTyIG6/aLSXG6ppPAx/ovAtXe+ngml83xQrxe5n99F2th
         ukEPw5wzKp2gmRVCZzq5tew+qAmuEnG6/ElvojDnjx8YmC+1uFePqvsRPvaghRQcA3od
         XI/GuPjr6qqyeHX7tlkgkiu7ScN9Y1XfJWaps8yczR50+uF0L/1vZtU7g+aT5GPYYsKw
         9Rsw8e23HdeTzxAZT/LHt/CPiFgA5gN0EDapV3xL8tFu3I79ljbD0eBJ/VesXVEmvYPb
         qeEMxQykmuUG8iCyQ8oepg6UzCgSYU9M/D1k4/6EzHChB9FVmRjQ7mn7JNOhkimHUnop
         p9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwwbbgcOAqzohK+NiTZxtzoVVjwmLJt9cOzhUVzQ8o8p25p+eI4uxbO5caiOkrJwn4rK2FK9cu+I9H2QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJcI2IASIe++Ro6+XbFqi90rpheJKgLz2jjjXG2DznATDWLGP
	NfgmfKc0Hndu17TvCQ4edOLDEv5F1Zaqr5mFLJ8v2pExR6q7OZrH
X-Google-Smtp-Source: AGHT+IHThhIjh7iP7Nff7xqy1wHlA8i7h4Sk41vDwZjjd4OoLQ5/BoylpoE4cDLARhVadl2f125EXw==
X-Received: by 2002:a17:903:22c5:b0:203:a11a:30c8 with SMTP id d9443c01a7336-203a11a30e9mr50657965ad.43.1724498105106;
        Sat, 24 Aug 2024 04:15:05 -0700 (PDT)
Received: from ubuntu.localdomain ([106.39.150.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385bdc663sm40786255ad.273.2024.08.24.04.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:15:04 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: catalin.marinas@arm.com
Cc: mark.rutland@arm.com,
	will@kernel.org,
	wangkefeng.wang@huawei.com,
	ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] arm64: Trace the memory abort exception
Date: Sat, 24 Aug 2024 04:14:56 -0700
Message-Id: <20240824111456.289367-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an event to trace the occurrence of memory abort exceptions.
The event can be useful if you only want to trace the page fault
exception when accessing a specific virtual address range, and it can
also help in locating the userspace code that triggers the fault.

I have referred to the trace_page_fault_user/trace_page_fault_kernel
on the x86 platform.

For example:

$ sudo perf record -e exceptions:mem_abort_user \
	--filter 'address >= 0xffff8fe00010 && address <= 0xffff90e00010' \
	-g -p 596  -- sleep 10

$ sudo perf script
fault     596 [000]  1218.765001: exceptions:mem_abort_user: address=0xffff9010e010 ip=0xaaaad8c90a6c error_code=0x9200000b
        ffff800080028e78 do_mem_abort+0xd0 ([kernel.kallsyms])
        ffff800080028e78 do_mem_abort+0xd0 ([kernel.kallsyms])
        ffff800080c89a38 el0_da+0x38 ([kernel.kallsyms])
        ffff800080c8ac54 el0t_64_sync_handler+0x8c ([kernel.kallsyms])
        ffff80008001148c el0t_64_sync+0x14c ([kernel.kallsyms])
            aaaad8c90a6c func_three+0xf0 (/home/pengdl/demo/pagefault/fault)
            aaaad8c90ae4 func_two+0x20 (/home/pengdl/demo/pagefault/fault)
            aaaad8c90b0c func_one+0x20 (/home/pengdl/demo/pagefault/fault)
            aaaad8c90c54 main+0x140 (/home/pengdl/demo/pagefault/fault)
            ffff90fece10 __libc_start_main+0xe8 (/usr/lib/aarch64-linux-gnu/libc-2.31.so)
            aaaad8c908a4 _start+0x34 (/home/pengdl/demo/pagefault/fault)

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 arch/arm64/include/asm/trace/common.h     | 18 +++++++
 arch/arm64/include/asm/trace/exceptions.h | 59 +++++++++++++++++++++++
 arch/arm64/kernel/Makefile                |  1 +
 arch/arm64/kernel/tracepoint.c            | 23 +++++++++
 arch/arm64/mm/fault.c                     | 18 +++++++
 5 files changed, 119 insertions(+)
 create mode 100644 arch/arm64/include/asm/trace/common.h
 create mode 100644 arch/arm64/include/asm/trace/exceptions.h
 create mode 100644 arch/arm64/kernel/tracepoint.c

diff --git a/arch/arm64/include/asm/trace/common.h b/arch/arm64/include/asm/trace/common.h
new file mode 100644
index 000000000000..a3efa45e2f20
--- /dev/null
+++ b/arch/arm64/include/asm/trace/common.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Based on arch/x86/include/asm/trace/common.h
+ *
+ */
+
+#ifndef _ASM_TRACE_COMMON_H
+#define _ASM_TRACE_COMMON_H
+
+#ifdef CONFIG_TRACING
+DECLARE_STATIC_KEY_FALSE(trace_memabort_key);
+#define trace_memabort_enabled()			\
+	static_branch_unlikely(&trace_memabort_key)
+#else
+static inline bool trace_memabort_enabled(void) { return false; }
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/trace/exceptions.h b/arch/arm64/include/asm/trace/exceptions.h
new file mode 100644
index 000000000000..919400c7682d
--- /dev/null
+++ b/arch/arm64/include/asm/trace/exceptions.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Based on arch/x86/include/asm/trace/exceptions.h
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM exceptions
+
+#if !defined(_TRACE_MEM_ABORT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MEM_ABORT_H
+
+#include <linux/tracepoint.h>
+#include <asm/trace/common.h>
+
+extern int trace_memabort_reg(void);
+extern void trace_memabort_unreg(void);
+
+DECLARE_EVENT_CLASS(arm64_exceptions,
+
+	TP_PROTO(unsigned long address, struct pt_regs *regs,
+		 unsigned long error_code),
+
+	TP_ARGS(address, regs, error_code),
+
+	TP_STRUCT__entry(
+		__field(		unsigned long, address	)
+		__field(		unsigned long, ip	)
+		__field(		unsigned long, error_code )
+	),
+
+	TP_fast_assign(
+		__entry->address = address;
+		__entry->ip = regs->pc;
+		__entry->error_code = error_code;
+	),
+
+	TP_printk("address=%ps ip=%ps error_code=0x%lx",
+		  (void *)__entry->address, (void *)__entry->ip,
+		  __entry->error_code) );
+
+#define DEFINE_MEM_ABORT_EVENT(name)				\
+DEFINE_EVENT_FN(arm64_exceptions, name,				\
+	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
+		 unsigned long error_code),			\
+	TP_ARGS(address, regs, error_code),			\
+	trace_memabort_reg, trace_memabort_unreg);
+
+DEFINE_MEM_ABORT_EVENT(mem_abort_user);
+DEFINE_MEM_ABORT_EVENT(mem_abort_kernel);
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH asm/trace
+#define TRACE_INCLUDE_FILE exceptions
+#endif /*  _TRACE_MEM_ABORT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2b112f3b7510..f78aa49b8587 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
+obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
diff --git a/arch/arm64/kernel/tracepoint.c b/arch/arm64/kernel/tracepoint.c
new file mode 100644
index 000000000000..c322e3644f75
--- /dev/null
+++ b/arch/arm64/kernel/tracepoint.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Based on arch/x86/kernel/tracepoint.c
+ *
+ */
+
+#include <linux/jump_label.h>
+#include <linux/atomic.h>
+
+#include <asm/trace/exceptions.h>
+
+DEFINE_STATIC_KEY_FALSE(trace_memabort_key);
+
+int trace_memabort_reg(void)
+{
+	static_branch_inc(&trace_memabort_key);
+	return 0;
+}
+
+void trace_memabort_unreg(void)
+{
+	static_branch_dec(&trace_memabort_key);
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 451ba7cbd5ad..aaccccb831a6 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -43,6 +43,9 @@
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
 
+#define CREATE_TRACE_POINTS
+#include <asm/trace/exceptions.h>
+
 struct fault_info {
 	int	(*fn)(unsigned long far, unsigned long esr,
 		      struct pt_regs *regs);
@@ -818,11 +821,26 @@ static const struct fault_info fault_info[] = {
 	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 63"			},
 };
 
+static __always_inline void
+trace_mem_abort_entries(struct pt_regs *regs, unsigned long error_code,
+			 unsigned long address)
+{
+	if (!trace_memabort_enabled())
+		return;
+
+	if (user_mode(regs))
+		trace_mem_abort_user(address, regs, error_code);
+	else
+		trace_mem_abort_kernel(address, regs, error_code);
+}
+
 void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf = esr_to_fault_info(esr);
 	unsigned long addr = untagged_addr(far);
 
+	trace_mem_abort_entries(regs, esr, addr);
+
 	if (!inf->fn(far, esr, regs))
 		return;
 
-- 
2.25.1


