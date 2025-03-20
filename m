Return-Path: <linux-kernel+bounces-570521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B4A6B1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39274881B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B8C21D3DD;
	Thu, 20 Mar 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YX8slLnz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E222ACF3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514086; cv=none; b=oI7LjP7tKEEnzo5IZuC2dX6I7UFkYPpkcKIXOSJgLxuezh6ZZXsllRMmkXtG7VELM6qd6/FlteRq7Au6VkjF0P1FP/bnVTBjnXeqJqPkGo73NYRedNV0XOrmIAjXvetr8tYd1iXDFx2QNSV70T1F9iYqGI1RgfTxLd0aQOKPJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514086; c=relaxed/simple;
	bh=JKFenFhNTRKKRxHJ8UZ9oXVmTS+oUwePqrJCVgBFpJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te1aQqu09mUPlC5WsC4h0lIgak1k5Ol/Sow1jRgH15Vj8U0u/7K9YTqvN08169S9361nUEoCBiaLx0xGbxlIGmOn5wANU4tjmpYQZI5WXQFfIyDsS7e854wCSLscvKwe6CUlh6JRbljw7qseazJC6CY3dGIJ/M1cOZltvHlvzvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YX8slLnz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514083; x=1774050083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKFenFhNTRKKRxHJ8UZ9oXVmTS+oUwePqrJCVgBFpJ0=;
  b=YX8slLnzF6CqbE3zGjA/bXlaLqOADkSPi12vV9lL/ST1ZFpLVgZgKycK
   fZZFXAX4lsXjmkcJbKydCmJlbIjMvOCM9VRX2Sir5OLoqBH3VCJZhdQjt
   KlLADVja5M/R8rTKZd05TpKtbye/613N3FCHkkgwIGYLOlGbQ9NK+IQlc
   pZt8Stsb08k73pqJeRyTvMYIyC0LwsX8aTsVga+7ohCo91EivRoR3DCHO
   +c+OTNnoqA3MLkZQGTgI6YaS2ORrI3gtqc2J+UZIUFcxeKXymqPma9etf
   iaDe1yrhpEG3fgjw5nVwwLdBzaNE2/N4U5MjQsYByriIg51UQwVbeoENf
   A==;
X-CSE-ConnectionGUID: iQXqJ4boRqesAQYMMaovNA==
X-CSE-MsgGUID: qZTulPNUQd+q2dyTR3B/0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439152"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439152"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:41:22 -0700
X-CSE-ConnectionGUID: cPbO6SLoQTq9J+taoJ4XVA==
X-CSE-MsgGUID: QQ9MwDLTTl++gkfO2xM8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123418063"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 16:41:22 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 4/6] x86/microcode/intel: Implement staging handler
Date: Thu, 20 Mar 2025 16:40:56 -0700
Message-ID: <20250320234104.8288-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234104.8288-1-chang.seok.bae@intel.com>
References: <20250320234104.8288-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, per-package staging invocations were established for each
MMIO space. The next step is to implement the staging handler according
to the specified protocol. Below are key aspects to note:

  (a)  Each staging process must begin by resetting the staging hardware.

  (b)  The staging hardware processes up to a page-sized chunk of the
       microcode image per iteration, requiring software to submit data
       incrementally.

  (c)  Once a data chunk is processed, the hardware responds with an
       offset in the image for the next chunk.

  (d)  The offset may indicate completion or request retransmission of an
       already transferred chunk. As long as the total transferred data
       remains within the predefined limit (twice the image size),
       retransmissions should be acceptable.

With that, incorporate these code sequences to the staging handler:

  1.  Initialization: Map the MMIO space via ioremap(). Reset the staging
      hardware and initialize software state, ensuring a fresh staging
      process aligned with (a).

  2.  Processing Loop: Introduce a loop iterating over data chunk,
      following (b), with proper termination conditions established from
      (d) -- stop staging when the hardware signals completion, or if the
      total transmitted data exceeds the predefined limit.

  3.  Loop Body: Finally, compose the loop body with two steps --
      transmitting a data chunk and retrieving the next offset from the
      hardware response, aligning with (b) and (c).

Since data transmission and mailbox format handling require additional
details, they are implemented separately in next changes.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V1 -> V2:
* Re-write the changelog for clarity (Dave).
* Move staging handling code into intel.c (Boris).
* Add extensive comments to clarify staging logic and hardware
  interactions, along with function renaming renaming (Dave).

 A key change to highlight is the updated main loop in do_stage(). With
 the introduction of global staging data, sub-functions now focus on
 being more self-explanatory through meaningful naming.

RFC-V1 -> V1:
* Rename the function name and change the return type.
---
 arch/x86/kernel/cpu/microcode/intel.c | 116 +++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 14c20b53f14d..05b5b73e525a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -20,6 +20,8 @@
 #include <linux/cpu.h>
 #include <linux/uio.h>
 #include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
@@ -33,6 +35,29 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 #define UCODE_BSP_LOADED	((struct microcode_intel *)0x1UL)
 
+/* Defines for the microcode staging mailbox interface */
+
+#define MBOX_REG_NUM		4
+#define MBOX_REG_SIZE		sizeof(u32)
+
+#define MBOX_CONTROL_OFFSET	0x0
+#define MBOX_STATUS_OFFSET	0x4
+
+#define MASK_MBOX_CTRL_ABORT	BIT(0)
+
+/*
+ * Each microcode image is divided into chunks, each at most
+ * MBOX_XACTION_SIZE in size. A 10-chunk image would typically require
+ * 10 transactions. However, the hardware managing the mailbox has
+ * limited resources and may not cache the entire image, potentially
+ * requesting the same chunk multiple times.
+ *
+ * To accommodate this behavior, allow up to twice the expected number of
+ * transactions (i.e., a 10-chunk image can take up to 20 attempts).
+ */
+#define MBOX_XACTION_SIZE	PAGE_SIZE
+#define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
+
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
 static struct microcode_intel *ucode_patch_late __read_mostly;
@@ -323,14 +348,99 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+/*
+ * Prepare for a new microcode transfer by resetting both hardware and
+ * software states.
+ */
+static inline void reset_stage(void)
+{
+	/* Reset tracking variables */
+	staging.offset = 0;
+	staging.bytes_sent = 0;
+
+	/*
+	 * Abort any ongoing process, effectively resetting the device.
+	 * Unlike regular mailbox data processing requests, this
+	 * operation does not require a status check.
+	 */
+	writel(MASK_MBOX_CTRL_ABORT, staging.mmio_base + MBOX_CONTROL_OFFSET);
+}
+
+/*
+ * Check if the staging process has completed. The hardware signals
+ * completion by setting a unique end offset.
+ */
+static inline bool is_stage_complete(void)
+{
+	return staging.offset == UINT_MAX;
+}
+
+/*
+ * Determine if the next data chunk can be sent. Each chunk is typically
+ * one page unless the remaining data is smaller. If the total
+ * transmitted data exceeds the defined limit, a timeout occurs.
+ */
+static bool can_send_next_chunk(void)
+{
+	WARN_ON_ONCE(staging.ucode_len < staging.offset);
+	staging.chunk_size = min(MBOX_XACTION_SIZE, staging.ucode_len - staging.offset);
+
+	if (staging.bytes_sent + staging.chunk_size > MBOX_XACTION_MAX(staging.ucode_len)) {
+		staging.state = UCODE_TIMEOUT;
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Transmit a chunk of the microcode image to the hardware.
+ * Return true if the chunk is processed successfully.
+ */
+static bool send_data_chunk(void)
+{
+	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
+	return false;
+}
+
+/*
+ * Retrieve the next offset from the hardware response.
+ * Return true if the response is valid, false otherwise.
+ */
+static bool fetch_next_offset(void)
+{
+	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
+	return false;
+}
+
 /*
  * Handle the staging process using the mailbox MMIO interface. The
- * caller is expected to check the result in staging.state.
+ * microcode image is transferred in chunks until completion. The caller
+ * is expected to check the result in staging.state.
  */
 static void do_stage(u64 mmio_pa)
 {
-	pr_debug_once("Staging implementation is pending.\n");
-	staging.state = UCODE_ERROR;
+	staging.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!staging.mmio_base)) {
+		staging.state = UCODE_ERROR;
+		return;
+	}
+
+	reset_stage();
+
+	/* Perform the staging process while within the retry limit */
+	while (!is_stage_complete() && can_send_next_chunk()) {
+		/* Send a chunk of microcode each time: */
+		if (!send_data_chunk())
+			break;
+		/*
+		 * Then, ask the hardware which piece of the image it
+		 * needs next. The same piece may be sent more than once.
+		 */
+		if (!fetch_next_offset())
+			break;
+	}
+
+	iounmap(staging.mmio_base);
 }
 
 static void stage_microcode(void)
-- 
2.45.2


