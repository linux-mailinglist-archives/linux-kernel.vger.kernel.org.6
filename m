Return-Path: <linux-kernel+bounces-440609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554189EC1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492A71888DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DC21946C8;
	Wed, 11 Dec 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TellIruS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696D1494CC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881341; cv=none; b=q3/C+xhU9+/R8nmOcoYG496c2M8/8DZBUNcREGO4G7YADqjpchjko4YUfdZ5wwwRgj63BsD5jv01nURQ9yHTmXoSR8tJR5H7znWi1zomM8PVBJy4eRx1ySrOjepndzX3btkj6gqS9gob2i+QVS/IF8w1lI+cDom3qfkLBXzKCyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881341; c=relaxed/simple;
	bh=DUIH1w/BOjTwUrlULnXMLR6HxahjuQBSWikikRSPEzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnLIwDZY0X2c1sL2db/d13vaNpyFYyzPuAF5iwRcv//Dup7JWysD8BzFN/X633OGrTPQ+s76hx63Aqs7DSddgm1+MBLa0PFXGh6UaAVZaNnnMUm6ljdiKDS3uoKwuJfC9sJ0blsIxKCJeXikRZjRQoH2LOE9H7c6kx2ueC4QEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TellIruS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881339; x=1765417339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUIH1w/BOjTwUrlULnXMLR6HxahjuQBSWikikRSPEzY=;
  b=TellIruSOqeTzufVdQTYj28MUDzbar0oy1W/u5QucBhxbHUGE1LbThOq
   xuSdW4JbLyGCrvr+PDzknudf/Z/d5dGOUlRdWy9Hc7f9TqcmSoWkKCdAh
   Tov9ZY7gJbnGyBGS/OITHpED5grhrI+pslGptM0dnt6t+9yb/8tSMw3gZ
   UrS0HKXG4YH62Y7T8nZAotabr6y7ngbSqQoSexMmNsP75pIscIoNNddpN
   oiuczzXnzIBwEPNkSq92Fsxm5JEO6P1pgsmG/1CYoTV/dLwFwuJLHpGPu
   JF7V/Tgr31wJ/JzUvoYrD4VFGs09JF87mQ9BgxB5K/MvcX8TiCg/ixpEh
   Q==;
X-CSE-ConnectionGUID: Fy1v8BtOTs2zFIWYur9cMg==
X-CSE-MsgGUID: +PzDHKPYQG62p37QK8fvZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33570553"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33570553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:42:19 -0800
X-CSE-ConnectionGUID: Ydo5LzeaQYm1CD9knU2ykg==
X-CSE-MsgGUID: Ocgj/pnLTYC4wgdxaFrWeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96051765"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 17:42:19 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 4/6] x86/microcode/intel_staging: Implement staging logic
Date: Tue, 10 Dec 2024 17:42:10 -0800
Message-ID: <20241211014213.3671-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211014213.3671-1-chang.seok.bae@intel.com>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
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
RFC-V1 -> V1: Rename the function name and change the return type.
---
 arch/x86/kernel/cpu/microcode/Makefile        |   2 +-
 arch/x86/kernel/cpu/microcode/intel_staging.c | 100 ++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h      |   6 +-
 3 files changed, 102 insertions(+), 6 deletions(-)
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
index 000000000000..2fc8667cab45
--- /dev/null
+++ b/arch/x86/kernel/cpu/microcode/intel_staging.c
@@ -0,0 +1,100 @@
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
+enum ucode_state do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize)
+{
+	unsigned int xaction_bytes = 0, offset = 0, chunksize;
+	void __iomem *mmio_base;
+	enum ucode_state state;
+
+	mmio_base = ioremap(pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!mmio_base))
+		return UCODE_ERROR;
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
+	return state;
+}
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 158429d80f93..787524e4ef1e 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -120,11 +120,7 @@ void load_ucode_intel_bsp(struct early_load_data *ed);
 void load_ucode_intel_ap(void);
 void reload_ucode_intel(void);
 struct microcode_ops *init_intel_microcode(void);
-static inline enum ucode_state do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize)
-{
-	pr_debug_once("Need to implement the staging code.\n");
-	return UCODE_ERROR;
-}
+enum ucode_state do_stage(u64 pa, void *ucode_ptr, unsigned int totalsize);
 #else /* CONFIG_CPU_SUP_INTEL */
 static inline void load_ucode_intel_bsp(struct early_load_data *ed) { }
 static inline void load_ucode_intel_ap(void) { }
-- 
2.45.2


