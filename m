Return-Path: <linux-kernel+bounces-571983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA01A6C4FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13B63BC2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973B23237A;
	Fri, 21 Mar 2025 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxYZVzce"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF401E9B34
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591964; cv=none; b=lrPvvfirAuJ+UmbDNVjhVbZsob9yhdZISbpwlNrIHl3bKpPU8m3ORcb5SLJsMiB41EyMPo9wG03HQwma5L5V+LqZFUxGymWGOLI+WmSQTOw8iJQZ/7ptaeIv4Ji6RSMU3ZcYljKBRyGtgj21Uy1JKWC2R4XWPkXcgZq3M+/3iQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591964; c=relaxed/simple;
	bh=JXIAAuoVrvy5Ob63FrknpztYTblf94+zyGMhc43zRhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYDFSl7CWi/FKrWePgahWoDgeoDc9ERpQyVY5NgDsq3g/+J+TFx25f0eW/EclLGSj4VdEbTk8JgteokzY6+TFFHlIJMA+ZngSI8ja5PCE5CTx0ZkkmWbirUzmsywsklaWY4/polc9pNWGMYpMihQw+2ISvTDUpzKstmVX3oFpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxYZVzce; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742591963; x=1774127963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JXIAAuoVrvy5Ob63FrknpztYTblf94+zyGMhc43zRhw=;
  b=TxYZVzceI7hv6rgmvUzPKe2eT/9PGa9RQ9fgC6QaJ0DCqhIi4TeMIBvi
   ArH010PrB21ITXBjvvnY3La/Kk1GpWBVJaOFaxueQcRXVMLF0flI70yOV
   wy4dHA5OzDAA76Se/B/TwJEEkX7o1Tnpg/2h/ceu7dZwI8rtx5fLtetL4
   34SUPZJcdWp9ZR+LLjiFTtW9havjyevhH0ISb19i88KfLHb+/s5MmaiAf
   pEFqsdohU/3Xl31Ss8xsQgSJqBu+kyBefVQ4GYIoUGpX7TY/djMLtIvGI
   21jUJd1Jkx8cneIlsoQgvs6DSoWmuBSWZgFbqVUTicfRbjgPrEoF1wx45
   w==;
X-CSE-ConnectionGUID: sjeWu/7NT5qrqTYWEJ0h8Q==
X-CSE-MsgGUID: Fxd8KMrATZaprteYEoZHwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="54086294"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="54086294"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 14:19:22 -0700
X-CSE-ConnectionGUID: /A5h12UYRViiN1r5g2tFRQ==
X-CSE-MsgGUID: kTIgXRfTSUeH5qv8OMNPbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="124284614"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.246.168.117])
  by fmviesa009.fm.intel.com with ESMTP; 21 Mar 2025 14:19:21 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2a 5/6] x86/microcode/intel: Support mailbox transfer
Date: Fri, 21 Mar 2025 14:19:19 -0700
Message-ID: <20250321211919.13944-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234104.8288-6-chang.seok.bae@intel.com>
References: <20250320234104.8288-6-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the functions for sending microcode data and retrieving the
next offset were placeholders, as they required handling the specific
mailbox format. Implement them as following:

== Mailbox Format ==

The staging mailbox consists of two primary sections: 'header' and
'data'. While the microcode must be transferred following this format,
the actual data transfer mechanism involves reading and writing to
specific MMIO registers.

== Mailbox Data Registers ==

Unlike conventional interfaces that allocate MMIO space for each data
chunk, the staging interface features a "narrow" interface, using only
two dword-sized registers for read and write operations.

For example, if writing 2 dwords of data to a device. Typically, the
device would expose 2 dwords of "wide" MMIO space. To send the data to
the device:

	writel(buf[0], io_addr + 0);
	writel(buf[1], io_addr + 1);

But, this interface is a bit different. Instead of having a "wide"
interface where there is separate MMIO space for each word in a
transaction, it has a "narrow" interface where several words are written
to the same spot in MMIO space:

	writel(buf[0], io_addr);
	writel(buf[1], io_addr);

The same goes for the read side.

== Implementation Summary ==

Given that, introduce two layers of helper functions at first:

  * Low-level helpers for reading and writing to data registers directly.
  * Wrapper functions for handling mailbox header and data sections.

Using them, implement send_data_chunk() and fetch_next_offset()
functions. Add explicit error and timeout handling routine in
wait_for_transaction(), finishing up the transfer.

Note: The kernel has support for similar mailboxes. But none of them are
compatible with this one. Trying to share code resulted in a bloated
mess, so this code is standalone.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V2a:
* Adjust the code to align with the global variable removal (Dave [1]).

Note: this quick revision is just intended to ensure that the feedback
has been properly addressed.

[1]: https://lore.kernel.org/lkml/b01224ee-c935-4b08-a76f-5dc49341182d@intel.com/
---
 arch/x86/kernel/cpu/microcode/intel.c | 152 +++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 44b94d4d05f7..ca1847ce1059 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -22,6 +22,7 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/pci_ids.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
@@ -42,8 +43,30 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
 
 #define MBOX_CONTROL_OFFSET	0x0
 #define MBOX_STATUS_OFFSET	0x4
+#define MBOX_WRDATA_OFFSET	0x8
+#define MBOX_RDDATA_OFFSET	0xc
 
 #define MASK_MBOX_CTRL_ABORT	BIT(0)
+#define MASK_MBOX_CTRL_GO	BIT(31)
+
+#define MASK_MBOX_STATUS_ERROR	BIT(2)
+#define MASK_MBOX_STATUS_READY	BIT(31)
+
+#define MASK_MBOX_RESP_SUCCESS	BIT(0)
+#define MASK_MBOX_RESP_PROGRESS	BIT(1)
+#define MASK_MBOX_RESP_ERROR	BIT(2)
+
+#define MBOX_CMD_LOAD		0x3
+#define MBOX_OBJ_STAGING	0xb
+#define DWORD_ALIGN(size)	((size) / sizeof(u32))
+#define MBOX_HEADER(mbox_size)	(PCI_VENDOR_ID_INTEL | \
+				 (MBOX_OBJ_STAGING << 16) | \
+				 ((u64)DWORD_ALIGN(mbox_size) << 32))
+
+/* The size of each mailbox header */
+#define MBOX_HEADER_SIZE	sizeof(u64)
+/* The size of staging hardware response */
+#define MBOX_RESPONSE_SIZE	sizeof(u64)
 
 /*
  * Each microcode image is divided into chunks, each at most
@@ -57,6 +80,7 @@ static const char ucode_path[] = "kernel/x86/microcode/GenuineIntel.bin";
  */
 #define MBOX_XACTION_SIZE	PAGE_SIZE
 #define MBOX_XACTION_MAX(imgsz)	((imgsz) * 2)
+#define MBOX_XACTION_TIMEOUT_MS	(10 * MSEC_PER_SEC)
 
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
@@ -345,6 +369,49 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+static inline u32 read_mbox_dword(void __iomem *mmio_base)
+{
+	u32 dword = readl(mmio_base + MBOX_RDDATA_OFFSET);
+
+	/* Acknowledge read completion to the staging firmware */
+	writel(0, mmio_base + MBOX_RDDATA_OFFSET);
+	return dword;
+}
+
+static inline void write_mbox_dword(void __iomem *mmio_base, u32 dword)
+{
+	writel(dword, mmio_base + MBOX_WRDATA_OFFSET);
+}
+
+static inline u64 read_mbox_header(void __iomem *mmio_base)
+{
+	u32 high, low;
+
+	low  = read_mbox_dword(mmio_base);
+	high = read_mbox_dword(mmio_base);
+
+	return ((u64)high << 32) | low;
+}
+
+static inline void write_mbox_header(void __iomem *mmio_base, u64 value)
+{
+	write_mbox_dword(mmio_base, value);
+	write_mbox_dword(mmio_base, value >> 32);
+}
+
+static void write_mbox_data(void __iomem *mmio_base, u32 *chunk, unsigned int chunk_size)
+{
+	int i;
+
+	/*
+	 * The MMIO space is mapped as Uncached (UC). Each write arrives
+	 * at the device as an individual transaction in program order.
+	 * The device can then resemble the sequence accordingly.
+	 */
+	for (i = 0; i < DWORD_ALIGN(chunk_size); i++)
+		write_mbox_dword(mmio_base, chunk[i]);
+}
+
 /*
  * Prepare for a new microcode transfer by resetting hardware and
  * initializing software states.
@@ -392,24 +459,97 @@ static bool can_send_next_chunk(struct staging_state *ss)
 	return true;
 }
 
+/*
+ * Wait for the hardware to complete a transaction.
+ * Return true on success, false on failure.
+ */
+static bool wait_for_transaction(struct staging_state *ss)
+{
+	u32 timeout, status;
+
+	/* Allow time for hardware to complete the operation: */
+	for (timeout = 0; timeout < MBOX_XACTION_TIMEOUT_MS; timeout++) {
+		msleep(1);
+
+		status = readl(ss->mmio_base + MBOX_STATUS_OFFSET);
+		/* Break out early if the hardware is ready: */
+		if (status & MASK_MBOX_STATUS_READY)
+			break;
+	}
+
+	status = readl(ss->mmio_base + MBOX_STATUS_OFFSET);
+
+	/* Check for explicit error response */
+	if (status & MASK_MBOX_STATUS_ERROR) {
+		ss->state = UCODE_ERROR;
+		return false;
+	}
+
+	/*
+	 * Hardware is neither responded to the action nor
+	 * signaled any error. Treat the case as timeout.
+	 */
+	if (!(status & MASK_MBOX_STATUS_READY)) {
+		ss->state = UCODE_TIMEOUT;
+		return false;
+	}
+
+	ss->state = UCODE_OK;
+	return true;
+}
+
 /*
  * Transmit a chunk of the microcode image to the hardware.
  * Return true if the chunk is processed successfully.
  */
-static bool send_data_chunk(struct staging_state *unused)
+static bool send_data_chunk(struct staging_state *ss)
 {
-	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
-	return false;
+	u16 mbox_size = MBOX_HEADER_SIZE * 2 + ss->chunk_size;
+	u32 *chunk = ss->ucode_ptr + ss->offset;
+
+	/*
+	 * Write 'request' mailbox object in the following order:
+	 * - Mailbox header includes total size
+	 * - Command header specifies the load operation
+	 * - Data section contains a microcode chunk
+	 */
+	write_mbox_header(ss->mmio_base, MBOX_HEADER(mbox_size));
+	write_mbox_header(ss->mmio_base, MBOX_CMD_LOAD);
+	write_mbox_data(ss->mmio_base, chunk, ss->chunk_size);
+	ss->bytes_sent += ss->chunk_size;
+
+	/*
+	 * Notify the hardware that the mailbox is ready for processing.
+	 * The staging firmware will process the request asynchronously.
+	 */
+	writel(MASK_MBOX_CTRL_GO, ss->mmio_base + MBOX_CONTROL_OFFSET);
+	return wait_for_transaction(ss);
 }
 
 /*
  * Retrieve the next offset from the hardware response.
  * Return true if the response is valid, false otherwise.
  */
-static bool fetch_next_offset(struct staging_state *unused)
+static bool fetch_next_offset(struct staging_state *ss)
 {
-	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
-	return false;
+	const u16 mbox_size = MBOX_HEADER_SIZE + MBOX_RESPONSE_SIZE;
+
+	/* All responses begin with the same header value: */
+	WARN_ON_ONCE(read_mbox_header(ss->mmio_base) != MBOX_HEADER(mbox_size));
+
+	/*
+	 * The 'response' mailbox contains two dword data:
+	 * - First has next offset in microcode image
+	 * - Second delivers status flag
+	 */
+	ss->offset = read_mbox_dword(ss->mmio_base);
+	if (read_mbox_dword(ss->mmio_base) & MASK_MBOX_RESP_ERROR) {
+		ss->state = UCODE_ERROR;
+		return false;
+	}
+
+	ss->state = UCODE_OK;
+	return true;
 }
 
 /*
-- 
2.45.2


