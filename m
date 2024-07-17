Return-Path: <linux-kernel+bounces-254897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DF89338F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62281284203
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47B2E3EE;
	Wed, 17 Jul 2024 08:28:43 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF897B662
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204922; cv=none; b=oJggmVn9IwmwXWnx2RfRNnIDSOjxtRWuARl6zEx+nm3x30dh4TVXfYQbEhJZ+4lNyl9nHweOJZTN7gw7s5nNzQdWax0tI41wxDerFWQtmH8Lk35wyPxoS4POuPUtZYOv6zL1D5bN+kNLNycc7Jk3TB+y+kSbBPaFzFVLV4da11A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204922; c=relaxed/simple;
	bh=S4CHwK2Ck2N521CQLrRjvWgDHbo/+ZJ6/X+J8Oj7ZNs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNFC68bjKy/d1p4+EgcgSpDCna29VAaBqykb7Kc2nJpjl2XV0hVUURNu0QTezxssz8IgjNoK41l4lQLy74AgAZKb2zBLyfzMr/S1OXu2ObZ0HV+PSUwUExio6OJmXVwreF59Z1VxPt/vTW6PtcqBMN1GB2q2f7+kgCaG7qYaje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu-2204-dev.. (unknown [180.110.112.93])
	by APP-01 (Coremail) with SMTP id qwCowABnbsp1gJdmjKDXAw--.5352S2;
	Wed, 17 Jul 2024 16:27:34 +0800 (CST)
From: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Zhu Hengbo <zhuhengbo@iscas.ac.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: add tracepoints for page fault
Date: Wed, 17 Jul 2024 08:27:19 +0000
Message-Id: <20240717082728.84401-1-zhuhengbo@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>
References: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnbsp1gJdmjKDXAw--.5352S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryrtw4xXr1DGry7Xw4DXFb_yoWrKrWkpF
	nFkr95Gr47Xwsa93yxZwn2vF15CanYkayjgry3C3yYvw4IqryUA392q3yqyr17Ar1kGFyI
	9F4Yyrya9w45uaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
	jUTmhUUUUU=
X-CM-SenderInfo: x2kxxvpqje0q5lvft2wodfhubq/1tbiBwkBDGaXTZmt1QABsf

Introduce page_fault_user and page_fault_kernel for riscv page fault.
Help to get more detail information when page fault happen.

Signed-off-by: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
---
Changes in v2:
- Add print instruction point info

Simple test go below:

root@riscv-ubuntu2204 ~ # bin/perf list | grep exceptions
  exceptions:page_fault_kernel                       [Tracepoint event]
  exceptions:page_fault_user                         [Tracepoint event]

root@riscv-ubuntu2204 ~ # bin/perf record -e exceptions:page_fault_kernel -e exceptions:page_fault_user
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.091 MB perf.data (19 samples) ]

perf report tracepoint:
perf     563 [007]   115.824363:   exceptions:page_fault_user: user page fault, address=0x7fff94cf6400 epc=0x55558632808e cause=0xd
perf     563 [007]   115.824441:   exceptions:page_fault_user: user page fault, address=0x7fff94c75400 epc=0x55558632808e cause=0xd
perf     563 [007]   115.824518:   exceptions:page_fault_user: user page fault, address=0x7fff94bf4400 epc=0x55558632808e cause=0xd
perf     563 [007]   115.824907: exceptions:page_fault_kernel: kernel page fault, address=0x7fff94bf5000 epc=fault_in_readable cause=0xd
perf     563 [007]   115.825238:   exceptions:page_fault_user: user page fault, address=0x7fff94bf4408 epc=0x5555863281bc cause=0xf
perf     564 [000]   116.247999:   exceptions:page_fault_user: user page fault, address=0x7fff94b73400 epc=0x55558632808e cause=0xd
perf     564 [000]   116.248558:   exceptions:page_fault_user: user page fault, address=0x7fff94af2400 epc=0x55558632808e cause=0xd
---
 arch/riscv/include/asm/trace/exceptions.h | 66 +++++++++++++++++++++++
 arch/riscv/mm/fault.c                     | 15 ++++++
 2 files changed, 81 insertions(+)
 create mode 100644 arch/riscv/include/asm/trace/exceptions.h

diff --git a/arch/riscv/include/asm/trace/exceptions.h b/arch/riscv/include/asm/trace/exceptions.h
new file mode 100644
index 000000000000..ff258da2f45f
--- /dev/null
+++ b/arch/riscv/include/asm/trace/exceptions.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Tracepoints for RISC-V exceptions
+ *
+ * Copyright (C) 2024 ISCAS. All rights reserved
+ *
+ */
+
+#if !defined(_TRACE_PAGE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PAGE_FAULT_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM exceptions
+
+TRACE_EVENT(page_fault_user,
+	TP_PROTO(struct pt_regs *regs),
+	TP_ARGS(regs),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, address)
+		__field(unsigned long, epc)
+		__field(unsigned long, cause)
+	),
+
+	TP_fast_assign(
+		__entry->address	= regs->badaddr;
+		__entry->epc		= regs->epc;
+		__entry->cause		= regs->cause;
+	),
+
+	TP_printk("user page fault, address=%ps epc=%ps cause=0x%lx",
+			(void *)__entry->address, (void *)__entry->epc,
+			__entry->cause)
+);
+
+TRACE_EVENT(page_fault_kernel,
+	TP_PROTO(struct pt_regs *regs),
+	TP_ARGS(regs),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, address)
+		__field(unsigned long, epc)
+		__field(unsigned long, cause)
+	),
+
+	TP_fast_assign(
+		__entry->address	= regs->badaddr;
+		__entry->epc		= regs->epc;
+		__entry->cause		= regs->cause;
+	),
+
+	TP_printk("kernel page fault, address=%ps epc=%ps cause=0x%lx",
+			(void *)__entry->address, (void *)__entry->epc,
+			__entry->cause)
+);
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH asm/trace/
+#define TRACE_INCLUDE_FILE exceptions
+#endif /*  _TRACE_PAGE_FAULT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 5224f3733802..22874074c5bc 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -22,6 +22,10 @@
 
 #include "../kernel/head.h"
 
+
+#define CREATE_TRACE_POINTS
+#include <asm/trace/exceptions.h>
+
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
@@ -215,6 +219,15 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 	return false;
 }
 
+
+static inline void trace_page_fault(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		trace_page_fault_user(regs);
+	else
+		trace_page_fault_kernel(regs);
+}
+
 /*
  * This routine handles page faults.  It determines the address and the
  * problem, and then passes it off to one of the appropriate routines.
@@ -235,6 +248,8 @@ void handle_page_fault(struct pt_regs *regs)
 	tsk = current;
 	mm = tsk->mm;
 
+	trace_page_fault(regs);
+
 	if (kprobe_page_fault(regs, cause))
 		return;
 
-- 
2.34.1


