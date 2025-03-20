Return-Path: <linux-kernel+bounces-570522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7DA6B1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F09C188C00F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C802122CBD8;
	Thu, 20 Mar 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjTdSZ8Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E722B8D2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514088; cv=none; b=XyIENXujJ3tIqDfnZIxUHzSThQQqR/z55IuORtPaZ1hy6e+YYM83ShSnYRSFi+zLB716ASfJDKpQvUTbHiu6nXn2xEJJzP3/aEcgD5nMVnn0/O1Wv9DEIbleKKOdUHSQVazNAIM9H8t53JxSGnYPkZihLCUCTGl+XXSB0Gx7i8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514088; c=relaxed/simple;
	bh=4EnL6N2E+dvP8uq/sVmBwRV9HeGLEuCL2dVASUxIipQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWG/9GJsxRRQwsG8wVtWSGBiM86ZRTmv80ATT0+AtAu2GFNSPH7zzEiBZx/7yli0updfDY3HMxswj1A3eUwQGNXZKYvAePO5xTXZI4kHw5PgJ0VngiOOGKIr7RQeGvYG7nCyrcP7yFSQyrhEILadSNvYJuvW4Aui/LWgO6a9oyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjTdSZ8Z; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514086; x=1774050086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4EnL6N2E+dvP8uq/sVmBwRV9HeGLEuCL2dVASUxIipQ=;
  b=XjTdSZ8ZyrZs2ual5+jCjM5Je7esqZPIdBNBO9aK+qNSZQ2tsP8RUOk1
   QVmDoT3Nr3C2a28hbOzRC8034wPtJxAz14J0fwf+EEw/EeqfkfU4ZnmNH
   zHnt/4VcnwS+fQnOXaw4K0/sfxcnAOIDsDVI3Osmmfs0eWRJ4wTrK1HkP
   JOFlzIfRlAHNhRS9JCKqYPjkMq0vNRMhriufXZxrGCBKJ9P31YGK7QoRc
   4qBgSdE5OFD2Xl12itiO6d2bsqHTUL8ERQBAJQ+eFeZnHSk+PFwQEc8zJ
   P0NJR3jO0Fv16hRZDPehYQ2kVO0ZmiLbzByexpBbcqx4OM8gJgX/Kke01
   A==;
X-CSE-ConnectionGUID: WYILw433RI+I+O8UN7VMAA==
X-CSE-MsgGUID: GXj4M+FnSeOItTvG014ktg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54439163"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54439163"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:41:26 -0700
X-CSE-ConnectionGUID: fCsL6ljRS8ubdIWHhPlCwA==
X-CSE-MsgGUID: UFjsKWoySkGTGwjQdjKUNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123418088"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2025 16:41:25 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	colinmitchell@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH v2 5/6] x86/microcode/intel: Support mailbox transfer
Date: Thu, 20 Mar 2025 16:40:57 -0700
Message-ID: <20250320234104.8288-6-chang.seok.bae@intel.com>
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
V1 -> V2:
* Add lots of code comments and edit the changelog (Dave).
* Encapsulate register read/write operations for processing header and
  data sections.
---
 arch/x86/kernel/cpu/microcode/intel.c | 148 +++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 05b5b73e525a..b0d530db72dd 100644
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
@@ -348,6 +372,49 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
 	return size ? NULL : patch;
 }
 
+static inline u32 read_mbox_dword(void)
+{
+	u32 dword = readl(staging.mmio_base + MBOX_RDDATA_OFFSET);
+
+	/* Acknowledge read completion to the staging firmware */
+	writel(0, staging.mmio_base + MBOX_RDDATA_OFFSET);
+	return dword;
+}
+
+static inline void write_mbox_dword(u32 dword)
+{
+	writel(dword, staging.mmio_base + MBOX_WRDATA_OFFSET);
+}
+
+static inline u64 read_mbox_header(void)
+{
+	u32 high, low;
+
+	low  = read_mbox_dword();
+	high = read_mbox_dword();
+
+	return ((u64)high << 32) | low;
+}
+
+static inline void write_mbox_header(u64 value)
+{
+	write_mbox_dword(value);
+	write_mbox_dword(value >> 32);
+}
+
+static inline void write_mbox_data(u32 *chunk, unsigned int chunk_size)
+{
+	int i;
+
+	/*
+	 * The MMIO space is mapped as Uncached (UC). Each write arrives
+	 * at the device as an individual transaction in program order.
+	 * The device can then resemble the sequence accordingly.
+	 */
+	for (i = 0; i < DWORD_ALIGN(chunk_size); i++)
+		write_mbox_dword(chunk[i]);
+}
+
 /*
  * Prepare for a new microcode transfer by resetting both hardware and
  * software states.
@@ -392,14 +459,71 @@ static bool can_send_next_chunk(void)
 	return true;
 }
 
+/*
+ * Wait for the hardware to complete a transaction.
+ * Return true on success, false on failure.
+ */
+static bool wait_for_transaction(void)
+{
+	u32 timeout, status;
+
+	/* Allow time for hardware to complete the operation: */
+	for (timeout = 0; timeout < MBOX_XACTION_TIMEOUT_MS; timeout++) {
+		msleep(1);
+
+		status = readl(staging.mmio_base + MBOX_STATUS_OFFSET);
+		/* Break out early if the hardware is ready: */
+		if (status & MASK_MBOX_STATUS_READY)
+			break;
+	}
+
+	status = readl(staging.mmio_base + MBOX_STATUS_OFFSET);
+
+	/* Check for explicit error response */
+	if (status & MASK_MBOX_STATUS_ERROR) {
+		staging.state = UCODE_ERROR;
+		return false;
+	}
+
+	/*
+	 * Hardware is neither responded to the action nor
+	 * signaled any error. Treat the case as timeout.
+	 */
+	if (!(status & MASK_MBOX_STATUS_READY)) {
+		staging.state = UCODE_TIMEOUT;
+		return false;
+	}
+
+	staging.state = UCODE_OK;
+	return true;
+}
+
 /*
  * Transmit a chunk of the microcode image to the hardware.
  * Return true if the chunk is processed successfully.
  */
 static bool send_data_chunk(void)
 {
-	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
-	return false;
+	u16 mbox_size = MBOX_HEADER_SIZE * 2 + staging.chunk_size;
+	u32 *chunk = staging.ucode_ptr + staging.offset;
+
+	/*
+	 * Write 'request' mailbox object in the following order:
+	 * - Mailbox header includes total size
+	 * - Command header specifies the load operation
+	 * - Data section contains a microcode chunk
+	 */
+	write_mbox_header(MBOX_HEADER(mbox_size));
+	write_mbox_header(MBOX_CMD_LOAD);
+	write_mbox_data(chunk, staging.chunk_size);
+	staging.bytes_sent += staging.chunk_size;
+
+	/*
+	 * Notify the hardware that the mailbox is ready for processing.
+	 * The staging firmware will process the request asynchronously.
+	 */
+	writel(MASK_MBOX_CTRL_GO, staging.mmio_base + MBOX_CONTROL_OFFSET);
+	return wait_for_transaction();
 }
 
 /*
@@ -408,8 +532,24 @@ static bool send_data_chunk(void)
  */
 static bool fetch_next_offset(void)
 {
-	pr_debug_once("Staging mailbox response handling code needs to be implemented.\n\n");
-	return false;
+	const u16 mbox_size = MBOX_HEADER_SIZE + MBOX_RESPONSE_SIZE;
+
+	/* All responses begin with the same header value: */
+	WARN_ON_ONCE(read_mbox_header() != MBOX_HEADER(mbox_size));
+
+	/*
+	 * The 'response' mailbox contains two dword data:
+	 * - First has next offset in microcode image
+	 * - Second delivers status flag
+	 */
+	staging.offset = read_mbox_dword();
+	if (read_mbox_dword() & MASK_MBOX_RESP_ERROR) {
+		staging.state = UCODE_ERROR;
+		return false;
+	}
+
+	staging.state = UCODE_OK;
+	return true;
 }
 
 /*
-- 
2.45.2


