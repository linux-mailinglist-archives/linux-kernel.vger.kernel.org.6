Return-Path: <linux-kernel+bounces-252357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC293120F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B02843F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50818734C;
	Mon, 15 Jul 2024 10:14:32 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2A18755E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038472; cv=none; b=oibLTWZFbFcexjBB74E44rzKnF4Fn2SOC4ygbGJUs46+hOr+fZXplIRj0/x9nLiqzllGDAOzqjsqb46zqeUHAyEPlfwpk+W81ecn33PvibsUhTqze/XTQgBpbZ8Ju8A8Ngp/m7GrkS+RBlZEq2z7DZP3bc6ApVioT1TiLD2IKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038472; c=relaxed/simple;
	bh=2FrgoAReGtAU9NNfzP2Swd2Ae/oac1vx9uDc8XDbZ4I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XTwzuw3CscOEPjH077TsGICLm9WS2im8+GfKpQMnEhzotDhM1Li8zTF2vCFcP8Vn0QsjAKxTUUQQCqTdIFrpzLxH2h1sDaW6YFQ4AcEuoO7x56f4nLUhooZSAXy1JxVrYPywssfFMkvgsj0EyponWtiYkT2fkJfMiwywgfzvW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubuntu-2204-dev.. (unknown [180.110.112.93])
	by APP-05 (Coremail) with SMTP id zQCowACHjeVp9pRmxFxsAw--.40406S2;
	Mon, 15 Jul 2024 18:14:02 +0800 (CST)
From: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Zhu Hengbo <zhuhengbo@iscas.ac.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: add tracepoints for page fault
Date: Mon, 15 Jul 2024 10:13:55 +0000
Message-Id: <20240715101400.39103-1-zhuhengbo@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHjeVp9pRmxFxsAw--.40406S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF45Gr18ZrWrKw1rtw17trb_yoWrZr4rpF
	nFkF95Gr47Xwsa93yxuw1qyF15AanYyayjgry7Gw4Yvw4IqryUAws2vrWDtryxGr1kGFyI
	9F4Yyrya9w15u3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUwr
	WFUUUUU
X-CM-SenderInfo: x2kxxvpqje0q5lvft2wodfhubq/

Introduce page_fault_user and page_fault_kernel for riscv page fault.
Help to get more detail information when page fault happen.

---
Simple test go below:

root@riscv-ubuntu2204 ~ # bin/perf list | grep exceptions
  exceptions:page_fault_kernel                       [Tracepoint event]
  exceptions:page_fault_user                         [Tracepoint event]

root@riscv-ubuntu2204 ~ # bin/perf record -e exceptions:page_fault_kernel -e exceptions:page_fault_user
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.091 MB perf.data (19 samples) ]

perf report tracepoint:

perf     826 [007]   894.795520:   exceptions:page_fault_user: user page fault, address=0x7fff95af4400 cause=0xd
perf     826 [007]   894.795970:   exceptions:page_fault_user: user page fault, address=0x7fff95a73400 cause=0xd
perf     826 [007]   894.796738:   exceptions:page_fault_user: user page fault, address=0x7fff959f2400 cause=0xd
perf     826 [007]   894.797088:   exceptions:page_fault_user: user page fault, address=0x7fff95971400 cause=0xd
perf     826 [007]   894.797273:   exceptions:page_fault_user: user page fault, address=0x7fff958f0400 cause=0xd
perf     826 [007]   894.797445:   exceptions:page_fault_user: user page fault, address=0x7fff9586f400 cause=0xd
perf     826 [007]   894.797998: exceptions:page_fault_kernel: kernel page fault, address=0x7fff95870000 cause=0xd

Signed-off-by: Zhu Hengbo <zhuhengbo@iscas.ac.cn>
---
 arch/riscv/include/asm/trace/exceptions.h | 60 +++++++++++++++++++++++
 arch/riscv/mm/fault.c                     | 15 ++++++
 2 files changed, 75 insertions(+)
 create mode 100644 arch/riscv/include/asm/trace/exceptions.h

diff --git a/arch/riscv/include/asm/trace/exceptions.h b/arch/riscv/include/asm/trace/exceptions.h
new file mode 100644
index 000000000000..a9a68d471703
--- /dev/null
+++ b/arch/riscv/include/asm/trace/exceptions.h
@@ -0,0 +1,60 @@
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
+		__field(unsigned long, cause)
+	),
+
+	TP_fast_assign(
+		__entry->address	= regs->badaddr;
+		__entry->cause		= regs->cause;
+	),
+
+	TP_printk("user page fault, address=%ps cause=0x%lx",
+		  (void *)__entry->address, __entry->cause)
+);
+
+TRACE_EVENT(page_fault_kernel,
+	TP_PROTO(struct pt_regs *regs),
+	TP_ARGS(regs),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, address)
+		__field(unsigned long, cause)
+	),
+
+	TP_fast_assign(
+		__entry->address	= regs->badaddr;
+		__entry->cause		= regs->cause;
+	),
+
+	TP_printk("kernel page fault, address=%ps cause=0x%lx",
+		  (void *)__entry->address, __entry->cause)
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


