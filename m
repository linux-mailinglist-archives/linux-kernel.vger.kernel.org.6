Return-Path: <linux-kernel+bounces-446059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F499F1F5A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83F96165B29
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13251991C1;
	Sat, 14 Dec 2024 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUB6iXb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20656946C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186672; cv=none; b=jectX1yz5uss8Mh9EzhoXQXdsX41XeQSzcdTwtk21WB2o/0jkCooLmOt7k04NXOBSZm3CXcL4ilz6r/Ijp3VD2FaiIpTMPv7gZlmwSgAB2X8fnEaRXJqgNj6dpw5iOZn2VcPvKZxaYj+WVJvs+xP20atA2YCIBLHpj25WfDNy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186672; c=relaxed/simple;
	bh=XWUteO3SqMG/DN0BQHorRffvVPXz/LZp5O3E/i63ktg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rN44q6oTx9taGmF9N/NZ4XwqeIaJZ1eTelLUQ8HxLAXi64AX0tN4tMIZNC/MkdMbmHwWcF2mI6i3BrPa+BIlWrufCd/yNWra4tTeH89RnKMyNzZPR8ukE12x/lFCgjN9LX0aHtpjSq5ii4uod3BVEb3bugdMfLeZBa9kDx35zuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUB6iXb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2003C4CEDD;
	Sat, 14 Dec 2024 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734186671;
	bh=XWUteO3SqMG/DN0BQHorRffvVPXz/LZp5O3E/i63ktg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUB6iXb6cbmAWcen6sVFe3VD2gazkdFV/uki2HBxmK3ZHR2T9oyz3agBpuoA2ToMC
	 /6rsDJCMKS1cFGAsMcl8A7zeCowp3Bk4OqJ05BqgXz5R2cvZ4wAhLerRcbbhQ9MW0h
	 wSzoJyeAt3AwqFPB011i2iujgh4xuYAaPaXA5RMSev/AgJcVUlpOPq6fml0YILXyBC
	 w7di9suHC8rrKUigPKPnJ0JfIcT5tyTCbNKoDL70bv5jkrm5CI48XDC+ubstOmZ/qE
	 0F/IhtJgc1s6YKwLxugv3q+v7hWole8k9PGnwkGg06iGuUAfa7TTAkZM3O5D3zgMwQ
	 e/Lym/7x67HrA==
From: guoren@kernel.org
To: guoren@kernel.org,
	conor@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	bjorn@rivosinc.com,
	leobras@redhat.com,
	corbet@lwn.net,
	peterlin@andestech.com,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 2/2] riscv: qspinlock: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Date: Sat, 14 Dec 2024 09:30:39 -0500
Message-Id: <20241214143039.4139398-3-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241214143039.4139398-1-guoren@kernel.org>
References: <20241214143039.4139398-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

The early version of T-Head C9xx cores has a store merge buffer
delay problem. The store merge buffer could improve the store queue
performance by merging multi-store requests, but when there are not
continued store requests, the prior single store request would be
waiting in the store queue for a long time. That would cause
significant problems for communication between multi-cores. This
problem was found on sg2042 & th1520 platforms with the qspinlock
lock torture test.

So appending a fence w.o could immediately flush the store merge
buffer and let other cores see the write result.

This will apply the WRITE_ONCE errata to handle the non-standard
behavior via appending a fence w.o instruction for WRITE_ONCE().

This problem is only observed on the sg2042 hardware platform by
running the lock_torture test program for half an hour. The problem
was not found in the user space application, because interrupt can
break the livelock.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig.errata              | 19 +++++++++++++++
 arch/riscv/errata/thead/errata.c       | 20 ++++++++++++++++
 arch/riscv/include/asm/rwonce.h        | 33 ++++++++++++++++++++++++++
 arch/riscv/include/asm/vendorid_list.h |  3 ++-
 include/asm-generic/rwonce.h           |  2 ++
 5 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/rwonce.h

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 2acc7d876e1f..fd6ba85b7a72 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -119,4 +119,23 @@ config ERRATA_THEAD_PMU
 
 	  If you don't know what to do here, say "Y".
 
+config ERRATA_THEAD_WRITE_ONCE
+	bool "Apply T-Head WRITE_ONCE errata"
+	depends on ERRATA_THEAD
+	default y
+	help
+	  The early version of T-Head C9xx cores of sg2042 & th1520 have a store
+	  merge buffer delay problem. The store merge buffer could improve the
+	  store queue performance by merging multi-store requests, but when there
+	  are no continued store requests, the prior single store request would be
+	  waiting in the store queue for a long time. That would cause signifi-
+	  cant problems for communication between multi-cores. Appending a
+	  fence w.o could immediately flush the store merge buffer and let other
+	  cores see the write result.
+
+	  This will apply the WRITE_ONCE errata to handle the non-standard beh-
+	  avior via appending a fence w.o instruction for WRITE_ONCE().
+
+	  If you don't know what to do here, say "Y".
+
 endmenu # "CPU errata selection"
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index e24770a77932..dd41f0221fe9 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -142,6 +142,23 @@ static bool errata_probe_pmu(unsigned int stage,
 	return true;
 }
 
+static bool errata_probe_write_once(unsigned int stage,
+				    unsigned long arch_id, unsigned long impid)
+{
+	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
+		return false;
+
+	/* target-c9xx cores report arch_id and impid as 0 */
+	if (arch_id != 0 || impid != 0)
+		return false;
+
+	if (stage == RISCV_ALTERNATIVES_BOOT ||
+	    stage == RISCV_ALTERNATIVES_MODULE)
+		return true;
+
+	return false;
+}
+
 static u32 thead_errata_probe(unsigned int stage,
 			      unsigned long archid, unsigned long impid)
 {
@@ -155,6 +172,9 @@ static u32 thead_errata_probe(unsigned int stage,
 	if (errata_probe_pmu(stage, archid, impid))
 		cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
 
+	if (errata_probe_write_once(stage, archid, impid))
+		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
+
 	return cpu_req_errata;
 }
 
diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/rwonce.h
new file mode 100644
index 000000000000..756586746a4f
--- /dev/null
+++ b/arch/riscv/include/asm/rwonce.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_RWONCE_H
+#define __ASM_RWONCE_H
+
+#include <linux/compiler_types.h>
+#include <asm/alternative-macros.h>
+#include <asm/vendorid_list.h>
+
+#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE)
+
+#define write_once_fence()				\
+do {							\
+	asm volatile(ALTERNATIVE(			\
+		"nop",					\
+		"fence w, o",				\
+		THEAD_VENDOR_ID,			\
+		ERRATA_THEAD_WRITE_ONCE,		\
+		CONFIG_ERRATA_THEAD_WRITE_ONCE)		\
+		: : : "memory");			\
+} while (0)
+
+#define __WRITE_ONCE(x, val)				\
+do {							\
+	*(volatile typeof(x) *)&(x) = (val);		\
+	write_once_fence();				\
+} while (0)
+
+#endif /* defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE) */
+
+#include <asm-generic/rwonce.h>
+
+#endif	/* __ASM_RWONCE_H */
diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 7a387368633a..d5a6e3963feb 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -23,7 +23,8 @@
 #ifdef CONFIG_ERRATA_THEAD
 #define	ERRATA_THEAD_MAE 0
 #define	ERRATA_THEAD_PMU 1
-#define	ERRATA_THEAD_NUMBER 2
+#define	ERRATA_THEAD_WRITE_ONCE 2
+#define	ERRATA_THEAD_NUMBER 3
 #endif
 
 #endif
diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e982..fb07fe8c6e45 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -50,10 +50,12 @@
 	__READ_ONCE(x);							\
 })
 
+#ifndef __WRITE_ONCE
 #define __WRITE_ONCE(x, val)						\
 do {									\
 	*(volatile typeof(x) *)&(x) = (val);				\
 } while (0)
+#endif
 
 #define WRITE_ONCE(x, val)						\
 do {									\
-- 
2.40.1


