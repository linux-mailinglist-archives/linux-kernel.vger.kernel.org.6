Return-Path: <linux-kernel+bounces-440610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC59EC1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C161631A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54BC19DF9A;
	Wed, 11 Dec 2024 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5EeM8aa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676217C9E8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881343; cv=none; b=BBM3xzFcRUdgDmLQMYJy8RqiIdZJmiFz+1XmUvA/XpiGDr6w9OeRA+iLRRlUxzWZPb8Xb63mUIXPQUFNHX0CzrfS3Kmh+Zr+PiA1CYmO10Cqg4cpma5Af/2AO7bVUkkKCBzS30BxoJUjK5HKYHBzl3yjn0vmQLNASBWubevZklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881343; c=relaxed/simple;
	bh=8Uw3yWy/mUWZGgTBnwiaM8RATRkH4ZM/yU3+UpseVeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJu2FbgPsVkWwiEfkd6UQNPxDldXnRukDIT2f+4dPT0TmYEemV7BAOy+aX2OrPE7ENIEOyl3Yc6XTJjglbelJ8AYZ6OGHEU/hjleJzPpvJQo+mpvUcyysYgcIJ4+EwqiCVgB+LhX5yfeR/yKlTWTUiyjS/J2NtHGNs0FqSiiuJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5EeM8aa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733881341; x=1765417341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Uw3yWy/mUWZGgTBnwiaM8RATRkH4ZM/yU3+UpseVeg=;
  b=T5EeM8aaBjrXuYxqPJRrwLnpi91lymGbjkgniGBh90lnCGDLBqVdNmR3
   yPJg04uMPhvyWm9NOurkty0u66x6B7rJ3+cn/APezHAO0zB5/tSgkM+cp
   ZzaSrfvxbUAEjksjUBBf9+runMH6P+TXQAeBbRfsbTNHFppYwa8WwEEow
   QPVCQwvT2IJaZyYJBNLq7/mEBHvP85wjMyTlZjJ7HtyhwIEmKL3rXuDyl
   TPwsUr/YpGvnyY1XiHuz1FMfBtinLrZzsr1MY7eGIEPAznt6H/gY4+QnD
   dCaarWKxivlwsKiKrmZB0fuL4YCZl3LBKgH2iPiumxJXaiSbqpQAg4QKH
   A==;
X-CSE-ConnectionGUID: t/YSrL7UQE2h0lS+ZkQXmw==
X-CSE-MsgGUID: 5DCyF/+yR4+kxLZGo5z2zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="33570559"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="33570559"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 17:42:20 -0800
X-CSE-ConnectionGUID: mP4DrLrrT/WgJSGdouCOXA==
X-CSE-MsgGUID: fhiTND9sSM+xWs8o4Fli2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96051770"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.134.127])
  by orviesa007.jf.intel.com with ESMTP; 10 Dec 2024 17:42:20 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH 5/6] x86/microcode/intel_staging: Support mailbox data transfer
Date: Tue, 10 Dec 2024 17:42:11 -0800
Message-ID: <20241211014213.3671-6-chang.seok.bae@intel.com>
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

The staging architecture features a narrowed interface for data transfer.
Instead of allocating MMIO space based on data chunk size, it utilizes
two data registers: one for reading and one for writing, enforcing the
serialization of read and write operations. Additionally, it defines a
mailbox data format.

To facilitate data transfer, implement helper functions in line with this
specified format for reading and writing staging data. This mailbox
format is a customized version and is not compatible with the existing
mailbox code, so reuse is not feasible.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel_staging.c | 55 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel_staging.c b/arch/x86/kernel/cpu/microcode/intel_staging.c
index 2fc8667cab45..eab6e891db9c 100644
--- a/arch/x86/kernel/cpu/microcode/intel_staging.c
+++ b/arch/x86/kernel/cpu/microcode/intel_staging.c
@@ -3,6 +3,7 @@
 #define pr_fmt(fmt) "microcode: " fmt
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pci_ids.h>
 
 #include "internal.h"
 
@@ -11,17 +12,44 @@
 
 #define MBOX_CONTROL_OFFSET	0x0
 #define MBOX_STATUS_OFFSET	0x4
+#define MBOX_WRDATA_OFFSET	0x8
+#define MBOX_RDDATA_OFFSET	0xc
 
 #define MASK_MBOX_CTRL_ABORT	BIT(0)
+#define MASK_MBOX_CTRL_GO	BIT(31)
 
 #define MASK_MBOX_STATUS_ERROR	BIT(2)
 #define MASK_MBOX_STATUS_READY	BIT(31)
 
+#define MASK_MBOX_RESP_SUCCESS	BIT(0)
+#define MASK_MBOX_RESP_PROGRESS	BIT(1)
+#define MASK_MBOX_RESP_ERROR	BIT(2)
+
+#define MBOX_CMD_LOAD		0x3
+#define MBOX_OBJ_STAGING	0xb
+#define MBOX_HDR		(PCI_VENDOR_ID_INTEL | (MBOX_OBJ_STAGING << 16))
+#define MBOX_HDR_SIZE		16
+
 #define MBOX_XACTION_LEN	PAGE_SIZE
 #define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
 #define MBOX_XACTION_TIMEOUT	(10 * MSEC_PER_SEC)
 
 #define STAGING_OFFSET_END	0xffffffff
+#define DWORD_SIZE(s)		((s) / sizeof(u32))
+
+static inline u32 read_mbox_dword(void __iomem *base)
+{
+	u32 dword = readl(base + MBOX_RDDATA_OFFSET);
+
+	/* Inform the read completion to the staging firmware */
+	writel(0, base + MBOX_RDDATA_OFFSET);
+	return dword;
+}
+
+static inline void write_mbox_dword(void __iomem *base, u32 dword)
+{
+	writel(dword, base + MBOX_WRDATA_OFFSET);
+}
 
 static inline void abort_xaction(void __iomem *base)
 {
@@ -30,7 +58,18 @@ static inline void abort_xaction(void __iomem *base)
 
 static void request_xaction(void __iomem *base, u32 *chunk, unsigned int chunksize)
 {
-	pr_debug_once("Need to implement staging mailbox loading code.\n");
+	unsigned int i, dwsize = DWORD_SIZE(chunksize);
+
+	write_mbox_dword(base, MBOX_HDR);
+	write_mbox_dword(base, dwsize + DWORD_SIZE(MBOX_HDR_SIZE));
+
+	write_mbox_dword(base, MBOX_CMD_LOAD);
+	write_mbox_dword(base, 0);
+
+	for (i = 0; i < dwsize; i++)
+		write_mbox_dword(base, chunk[i]);
+
+	writel(MASK_MBOX_CTRL_GO, base + MBOX_CONTROL_OFFSET);
 }
 
 static enum ucode_state wait_for_xaction(void __iomem *base)
@@ -55,8 +94,18 @@ static enum ucode_state wait_for_xaction(void __iomem *base)
 
 static enum ucode_state read_xaction_response(void __iomem *base, unsigned int *offset)
 {
-	pr_debug_once("Need to implement staging response handler.\n");
-	return UCODE_ERROR;
+	u32 flag;
+
+	WARN_ON_ONCE(read_mbox_dword(base) != MBOX_HDR);
+	WARN_ON_ONCE(read_mbox_dword(base) != DWORD_SIZE(MBOX_HDR_SIZE));
+
+	*offset = read_mbox_dword(base);
+
+	flag = read_mbox_dword(base);
+	if (flag & MASK_MBOX_RESP_ERROR)
+		return UCODE_ERROR;
+
+	return UCODE_OK;
 }
 
 static inline unsigned int get_chunksize(unsigned int totalsize, unsigned int offset)
-- 
2.45.2


