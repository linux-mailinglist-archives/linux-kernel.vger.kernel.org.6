Return-Path: <linux-kernel+bounces-571981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89CA6C4FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8363BAC25
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F4231CA5;
	Fri, 21 Mar 2025 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQcp3/jJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2722652E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591954; cv=none; b=jqq4MctMlp8yBINwtdVN40Auiu2Daox9g3vifC9E5GNOkGXWBhgC4PBAG3OLp7MrfohSJiyEP2yVmoPDIcknEp7HLqlJPsGUAqqqRlsOp4NxYwnGQnSnV60vWMvy61GUOxfkH3DGt8XzrU/ZnM7auIuBYmcqOFdoe+ej7fz1z0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591954; c=relaxed/simple;
	bh=16lo43WCQfU44b5Ay5yDBNRXZcA+X9cCSut2Zt/sS6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJexIsZtEcXYdXkLcPaAc2DthrFbzuO2X1mrOeN/NTfFTrc9KWm9m2m+/OU8yXecrGgsvLQ8gcJfPHbsxTF9gl1IDQPlFByq48OZC41Nfl+Uts68yOXBh+jWPHv2WgBvdWqygy5/ZM7IIFTHQ4TTXZY327+w/qOoFrChk8eN1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQcp3/jJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742591953; x=1774127953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=16lo43WCQfU44b5Ay5yDBNRXZcA+X9cCSut2Zt/sS6o=;
  b=MQcp3/jJ1Lk7Y3Xog4YfyuiNe+TcxpzLlqUHYMyk85zZ2qiUyFbhq2MP
   J8RAolnOBXaWJXWO9Uns0zz32TyGZO4sDlb9MGpBI+RjpmApHN2AFDE2q
   cy9hkKdsv51X/TwqSZ2iYQxiKy6im7Yhm5fPn/dK6cr4lp0N9B1d37cis
   R7hXti3cvKjMWUpiH4znsgBFs7p7HnCxk33bi3mgKZeN3D+eoZUbduk4o
   GKcgKE3hRPHMtekJZrA+tla3MPqVkC40H9gLubqIwplTBM+yNhVLJxU+l
   2q9V0hCECjNq4gP0JSZHYmKWTzFsZGLe5xVmgHIRYPncYNiDrLlykIffZ
   A==;
X-CSE-ConnectionGUID: VvVcD/VCT7SOk/c+ETCniw==
X-CSE-MsgGUID: YtxuS6a8T2Cu3yXTwN6vaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54086275"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="54086275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:19:13 -0700
X-CSE-ConnectionGUID: 1fN17sKyQF6YyLzpZ7Ym0A==
X-CSE-MsgGUID: rDzy6drlQKy2S6UErLnnkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="124284608"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.168.117])
  by fmviesa009.fm.intel.com with ESMTP; 21 Mar 2025 14:19:12 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2a 4/6] x86/microcode/intel: Implement staging handler
Date: Fri, 21 Mar 2025 14:19:09 -0700
Message-ID: <20250321211909.13927-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <b01224ee-c935-4b08-a76f-5dc49341182d@intel.com>
References: <b01224ee-c935-4b08-a76f-5dc49341182d@intel.com>
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
V2 -> V2a:
* Adjust the code with the global variable removal (Dave [1]).

Note: this quick revision is just intended to ensure that the feedback
has been properly addressed.

[1]: https://lore.kernel.org/lkml/b01224ee-c935-4b08-a76f-5dc49341182d@intel.com/
---
 arch/x86/kernel/cpu/microcode/intel.c | 122 +++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 5d0216e9aee5..44b94d4d05f7 100644
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
@@ -321,13 +346,102 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 }
 
 /*
- * Handle the staging process using the mailbox MMIO interface.
- * Return the result state.
+ * Prepare for a new microcode transfer by resetting hardware and
+ * initializing software states.
+ */
+static void init_stage(struct staging_state *ss)
+{
+	ss->ucode_ptr = ucode_patch_late;
+	ss->ucode_len = get_totalsize(&ucode_patch_late->hdr);
+
+	/* Reset tracking variables */
+	ss->offset = 0;
+	ss->bytes_sent = 0;
+
+	/*
+	 * Abort any ongoing process, effectively resetting the device.
+	 * Unlike regular mailbox data processing requests, this
+	 * operation does not require a status check.
+	 */
+	writel(MASK_MBOX_CTRL_ABORT, ss->mmio_base + MBOX_CONTROL_OFFSET);
+}
+
+/*
+ * Check if the staging process has completed. The hardware signals
+ * completion by setting a unique end offset.
+ */
+static inline bool is_stage_complete(unsigned int offset)
+{
+	return offset == UINT_MAX;
+}
+
+/*
+ * Determine if the next data chunk can be sent. Each chunk is typically
+ * one page unless the remaining data is smaller. If the total
+ * transmitted data exceeds the defined limit, a timeout occurs.
+ */
+static bool can_send_next_chunk(struct staging_state *ss)
+{
+	WARN_ON_ONCE(ss->ucode_len < ss->offset);
+	ss->chunk_size = min(MBOX_XACTION_SIZE, ss->ucode_len - ss->offset);
+
+	if (ss->bytes_sent + ss->chunk_size > MBOX_XACTION_MAX(ss->ucode_len)) {
+		ss->state = UCODE_TIMEOUT;
+		return false;
+	}
+	return true;
+}
+
+/*
+ * Transmit a chunk of the microcode image to the hardware.
+ * Return true if the chunk is processed successfully.
+ */
+static bool send_data_chunk(struct staging_state *unused)
+{
+	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
+	return false;
+}
+
+/*
+ * Retrieve the next offset from the hardware response.
+ * Return true if the response is valid, false otherwise.
+ */
+static bool fetch_next_offset(struct staging_state *unused)
+{
+	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
+	return false;
+}
+
+/*
+ * Handle the staging process using the mailbox MMIO interface. The
+ * microcode image is transferred in chunks until completion. Return the
+ * result state.
  */
 static enum ucode_state do_stage(u64 mmio_pa)
 {
-	pr_debug_once("Staging implementation is pending.\n");
-	return UCODE_ERROR;
+	struct staging_state ss = {};
+
+	ss.mmio_base = ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!ss.mmio_base))
+		return UCODE_ERROR;
+
+	init_stage(&ss);
+
+	/* Perform the staging process while within the retry limit */
+	while (!is_stage_complete(ss.offset) && can_send_next_chunk(&ss)) {
+		/* Send a chunk of microcode each time: */
+		if (!send_data_chunk(&ss))
+			break;
+		/*
+		 * Then, ask the hardware which piece of the image it
+		 * needs next. The same piece may be sent more than once.
+		 */
+		if (!fetch_next_offset(&ss))
+			break;
+	}
+
+	iounmap(ss.mmio_base);
+	return ss.state;
 }
 
 static void stage_microcode(void)
-- 
2.45.2


