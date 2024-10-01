Return-Path: <linux-kernel+bounces-346323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183E298C321
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ACC8B2289D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBED1CDA03;
	Tue,  1 Oct 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGsHsWij"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722331CCB5C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799065; cv=none; b=pub24L/RPs01VaSzkAp6ICeGtNT2vmRmBmnBZXqlhWWXkDhoN+WGmD+uTiGSJllPnUBe9lm/wU6nbHVhLbQrrqclNzX4APajESOGnUm+Ql0ZDUeDf5LyqZtq9IjS2bgjZNERHZqRrR86Smd9aFWLT986ri3wxRa556PhBpmyt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799065; c=relaxed/simple;
	bh=EwCbfEuiC9mYKhMwm1CkPj25gkwa9/Ea9FZGoCISMiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKcGXYV2VoaB2+jkArvARSJiCkE4J9Jaf/8MNPbxXIe4YNCgig/5fQXIZrrSJfLk6+b76HK1uufwzbFvBufaM38hFFU7p9WocFgoiaY8+KOEg9vcn9setm3Ep2AZGzUdPU46HXTwXxWLwl3/NJGuTvvWJzYvjdWZdCv2Y/O7o6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGsHsWij; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727799063; x=1759335063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EwCbfEuiC9mYKhMwm1CkPj25gkwa9/Ea9FZGoCISMiU=;
  b=DGsHsWijlNInvqi7b8Fsb0olflnSqfgtLRU8X1cZmKzRXibixIMf/G/d
   LqVVr8rhay2TjnEyvdnzTq5kPRPKm7tUB2RaTwINZQ9i21MVXEuXSp6BV
   NT/F1nzCczONODYJvvp5REWtf3ZJmAAjKp2ty2oDt0xCbgiQPTNlt7F+R
   N23bKPbD99PJ0F/CyZ/SuS9OA7yT6EoSg9ufLdqF0E+QEcnzR2Co7Keb1
   TmsEuUBCovlv0dM7hgVxSPPkhtkAeq+gzury3y0d29ktj7suT7kHgHPcv
   S4mEXzgKrWPy6yQH/xPyHAW6cB9Obunec6mJo3Rm+uVtCnTakwDU3Ayvf
   w==;
X-CSE-ConnectionGUID: OshFiH8oROChQP2eiXuXXg==
X-CSE-MsgGUID: O5P7/CnmTvieUatC/d+eJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37539394"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37539394"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:11:03 -0700
X-CSE-ConnectionGUID: vYPBXhLqQwOIe20TPOdLVQ==
X-CSE-MsgGUID: dv483kGfQRy7xeTKUK0RVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78585997"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.136.21])
  by orviesa003.jf.intel.com with ESMTP; 01 Oct 2024 09:11:03 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC 5/7] x86/microcode/intel_staging: Implement staging logic
Date: Tue,  1 Oct 2024 09:10:40 -0700
Message-Id: <20241001161042.465584-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001161042.465584-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The staging firmware operates through a protocol via the MMIO interface.
The protocol defines a serialized sequence that begins by clearing the
hardware with an abort request. It then proceeds through iterative
process of sending data, initiating transactions, waiting for processing,
and reading responses.

To facilitate this interaction, follow the outlined protocol. Refactor
the waiting code to manage loop breaks more effectively. Data transfer
involves a next level of detail to handle the mailbox format. While
defining helpers, leave them empty for now.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/cpu/microcode/Makefile        |   2 +-
 arch/x86/kernel/cpu/microcode/intel_staging.c | 105 ++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h      |   6 +-
 3 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/intel_staging.c

diff --git a/arch/x86/kernel/cpu/microcode/Makefile b/arch/x86/kernel/cpu/microcode/Makefile
index 193d98b33a0a..a9f79aaffcb0 100644
--- a/arch/x86/kernel/cpu/microcode/Makefile
+++ b/arch/x86/kernel/cpu/microcode/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 microcode-y				:= core.o
 obj-$(CONFIG_MICROCODE)			+= microcode.o
-microcode-$(CONFIG_CPU_SUP_INTEL)	+= intel.o
+microcode-$(CONFIG_CPU_SUP_INTEL)	+= intel.o intel_staging.o
 microcode-$(CONFIG_CPU_SUP_AMD)		+= amd.o
diff --git a/arch/x86/kernel/cpu/microcode/intel_staging.c b/arch/x86/kernel/cpu/microcode/intel_staging.c
new file mode 100644
index 000000000000..9989a78f9ef2
--- /dev/null
+++ b/arch/x86/kernel/cpu/microcode/intel_staging.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define pr_fmt(fmt) "microcode: " fmt
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include "internal.h"
+
+#define MBOX_REG_NUM		4
+#define MBOX_REG_SIZE		sizeof(u32)
+
+#define MBOX_CONTROL_OFFSET	0x0
+#define MBOX_STATUS_OFFSET	0x4
+
+#define MASK_MBOX_CTRL_ABORT	BIT(0)
+
+#define MASK_MBOX_STATUS_ERROR	BIT(2)
+#define MASK_MBOX_STATUS_READY	BIT(31)
+
+#define MBOX_XACTION_LEN	PAGE_SIZE
+#define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
+#define MBOX_XACTION_TIMEOUT	(10 * MSEC_PER_SEC)
+
+#define STAGING_OFFSET_END	0xffffffff
+
+static inline void abort_xaction(void __iomem *base)
+{
+	writel(MASK_MBOX_CTRL_ABORT, base + MBOX_CONTROL_OFFSET);
+}
+
+static void request_xaction(void __iomem *base, u32 *chunk, unsigned int chunksize)
+{
+	pr_debug_once("Need to implement staging mailbox loading code.\n");
+}
+
+static enum ucode_state wait_for_xaction(void __iomem *base)
+{
+	u32 timeout, status;
+
+	for (timeout = 0; timeout < MBOX_XACTION_TIMEOUT; timeout++) {
+		msleep(1);
+		status = readl(base + MBOX_STATUS_OFFSET);
+		if (status & MASK_MBOX_STATUS_READY)
+			break;
+	}
+
+	status = readl(base + MBOX_STATUS_OFFSET);
+	if (status & MASK_MBOX_STATUS_ERROR)
+		return UCODE_ERROR;
+	if (!(status & MASK_MBOX_STATUS_READY))
+		return UCODE_TIMEOUT;
+
+	return UCODE_OK;
+}
+
+static enum ucode_state read_xaction_response(void __iomem *base, unsigned int *offset)
+{
+	pr_debug_once("Need to implement staging response handler.\n");
+	return UCODE_ERROR;
+}
+
+static inline unsigned int get_chunksize(unsigned int totalsize, unsigned int offset)
+{
+	WARN_ON_ONCE(totalsize < offset);
+	return min(MBOX_XACTION_LEN, totalsize - offset);
+}
+
+bool staging_work(u64 mmio_pa, void *ucode_ptr, unsigned int totalsize)
+{
+	unsigned int xaction_bytes = 0, offset = 0, chunksize;
+	void __iomem *mmio_base;
+	enum ucode_state state;
+
+	mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!mmio_base))
+		return false;
+
+	abort_xaction(mmio_base);
+
+	while (offset != STAGING_OFFSET_END) {
+		chunksize = get_chunksize(totalsize, offset);
+		if (xaction_bytes + chunksize > MBOX_XACTION_MAX(totalsize)) {
+			state = UCODE_TIMEOUT;
+			break;
+		}
+
+		request_xaction(mmio_base, ucode_ptr + offset, chunksize);
+		state = wait_for_xaction(mmio_base);
+		if (state != UCODE_OK)
+			break;
+
+		xaction_bytes += chunksize;
+		state = read_xaction_response(mmio_base, &offset);
+		if (state != UCODE_OK)
+			break;
+	}
+
+	iounmap(mmio_base);
+
+	if (state == UCODE_OK)
+		return true;
+
+	pr_err("Staging failed with %s.\n", state == UCODE_TIMEOUT ? "timeout" : "error");
+	return false;
+}
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 06c3c8db4ceb..6b0d9a4374db 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -120,11 +120,7 @@ void load_ucode_intel_bsp(struct early_load_data *ed);
 void load_ucode_intel_ap(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
-static inline bool staging_work(u64 mmio_pa, void *ucode_ptr, unsigned int totalsize)
-{
-	pr_debug_once("Need to implement the Staging code.\n");
-	return false;
-}
+bool staging_work(u64 mmio_pa, void *ucode_ptr, unsigned int totalsize);
 #else /* CONFIG_CPU_SUP_INTEL */
 static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
 static inline void load_ucode_intel_ap(void) { }
-- 
2.43.0


