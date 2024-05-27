Return-Path: <linux-kernel+bounces-190506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE78CFF4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA913283C18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69C615EFCD;
	Mon, 27 May 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="UkLH1els"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C415E5CA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810530; cv=none; b=a2Mr8ZtgnKwsl3hCkNKtpT+2Sfgoh78QGrgxAkQdvtwZPQ6/hLykBqRHf/5MepGXHMu+WomyfGhUnfqymDY+uJoYsrRbe1mtCWK4JjA3DVcm0Ig/7b9V8DFQ0mtj3kakkuesssvrJlgLlPdvne/cj8aqbQcQ5SSTkshWOd5kBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810530; c=relaxed/simple;
	bh=jxHY8fiURwbUDxH2EqODM/mfzNkmtKBp+RbUF5zNYpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rndo/f9HlZMt+yWGNFlkYI3LNrITwnkeLqP9D6JykkU+O8YhriDhDVQSQedig3ryDcctglH8GW5mUS6ASClTsqBOSRMhfZcL+TAAhi2W+L5bXFpXUf0yHMf+NOxOjHl3sg9hus1E3VHYINLt8SXsRg2uKbc3zWsqLF5X8sohM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=UkLH1els; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716810481; bh=jxHY8fiURwbUDxH2EqODM/mfzNkmtKBp+RbUF5zNYpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkLH1elshxJ5W4W6FS1O7IH1dmROmE8EDoeqzOuNqOvvPk68FF7jwbhKl/KjEp4Vz
	 tKZeyMoYxZT++RI++swWSvn0dhGQRK1XEvaNhEb5H1uB2GBzeHG/d9SAERrpECmHq+
	 J38xqAAahM+6agTZ+Wvx2lgMQh8FGndR1t9LRQXY887Ry4Bq/tOlS9607Ky00oKDvS
	 njLW4p8H6Wz0unRCWoYwpnwulUOMo6C1GWQJ4NzyGASUH1Hp6qAoERt74tBcyy3rld
	 8JNgitmr1UBIPOpmxZhPZDEYUucAxgF2Y/lQWgBG4wXvqPrvTHtwubu+WSrY5Nypnb
	 vIK0Nu/BLVDvQ==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RBltNk1919357;
	Mon, 27 May 2024 14:47:55 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 6/9] accel/habanalabs: use parent device for trace events
Date: Mon, 27 May 2024 14:47:43 +0300
Message-Id: <20240527114746.1919292-6-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527114746.1919292-1-obitton@habana.ai>
References: <20240527114746.1919292-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomer Tayar <ttayar@habana.ai>

Trace events might still be recorded after the accel device is released,
while the device name is no longer available.
Modify the trace functions to use the parent device instead, which is
available at that point and still informative as the device name.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c      | 25 ++++++++++---------
 drivers/accel/habanalabs/common/firmware_if.c | 10 +++++---
 drivers/accel/habanalabs/common/mmu/mmu.c     |  5 ++--
 drivers/accel/habanalabs/common/pci/pci.c     |  4 +--
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 087bbb1778e5..bb3f44392908 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -130,8 +130,8 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 	}
 
 	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))
-		trace_habanalabs_dma_alloc(hdev->dev, (u64) (uintptr_t) ptr, *dma_handle, size,
-						caller);
+		trace_habanalabs_dma_alloc(&(hdev)->pdev->dev, (u64) (uintptr_t) ptr, *dma_handle,
+						size, caller);
 
 	return ptr;
 }
@@ -152,7 +152,7 @@ static void hl_asic_dma_free_common(struct hl_device *hdev, size_t size, void *c
 		break;
 	}
 
-	trace_habanalabs_dma_free(hdev->dev, store_cpu_addr, dma_handle, size, caller);
+	trace_habanalabs_dma_free(&(hdev)->pdev->dev, store_cpu_addr, dma_handle, size, caller);
 }
 
 void *hl_asic_dma_alloc_coherent_caller(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
@@ -204,15 +204,15 @@ int hl_dma_map_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 		return 0;
 
 	for_each_sgtable_dma_sg(sgt, sg, i)
-		trace_habanalabs_dma_map_page(hdev->dev,
-				page_to_phys(sg_page(sg)),
-				sg->dma_address - prop->device_dma_offset_for_host_access,
+		trace_habanalabs_dma_map_page(&(hdev)->pdev->dev,
+					page_to_phys(sg_page(sg)),
+					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
-				sg->dma_length,
+					sg->dma_length,
 #else
-				sg->length,
+					sg->length,
 #endif
-				dir, caller);
+					dir, caller);
 
 	return 0;
 }
@@ -247,7 +247,8 @@ void hl_dma_unmap_sgtable_caller(struct hl_device *hdev, struct sg_table *sgt,
 
 	if (trace_habanalabs_dma_unmap_page_enabled()) {
 		for_each_sgtable_dma_sg(sgt, sg, i)
-			trace_habanalabs_dma_unmap_page(hdev->dev, page_to_phys(sg_page(sg)),
+			trace_habanalabs_dma_unmap_page(&(hdev)->pdev->dev,
+					page_to_phys(sg_page(sg)),
 					sg->dma_address - prop->device_dma_offset_for_host_access,
 #ifdef CONFIG_NEED_SG_DMA_LENGTH
 					sg->dma_length,
@@ -2593,7 +2594,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 	u32 val = readl(hdev->rmmio + reg);
 
 	if (unlikely(trace_habanalabs_rreg32_enabled()))
-		trace_habanalabs_rreg32(hdev->dev, reg, val);
+		trace_habanalabs_rreg32(&(hdev)->pdev->dev, reg, val);
 
 	return val;
 }
@@ -2611,7 +2612,7 @@ inline u32 hl_rreg(struct hl_device *hdev, u32 reg)
 inline void hl_wreg(struct hl_device *hdev, u32 reg, u32 val)
 {
 	if (unlikely(trace_habanalabs_wreg32_enabled()))
-		trace_habanalabs_wreg32(hdev->dev, reg, val);
+		trace_habanalabs_wreg32(&(hdev)->pdev->dev, reg, val);
 
 	writel(val, hdev->rmmio + reg);
 }
diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index b5b960ce4ebd..d1a1d601bde9 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -8,6 +8,7 @@
 #include "habanalabs.h"
 #include <linux/habanalabs/hl_boot_if.h>
 
+#include <linux/pci.h>
 #include <linux/firmware.h>
 #include <linux/crc32.h>
 #include <linux/slab.h>
@@ -1803,7 +1804,7 @@ static void hl_fw_dynamic_send_cmd(struct hl_device *hdev,
 	val = FIELD_PREP(COMMS_COMMAND_CMD_MASK, cmd);
 	val |= FIELD_PREP(COMMS_COMMAND_SIZE_MASK, size);
 
-	trace_habanalabs_comms_send_cmd(hdev->dev, comms_cmd_str_arr[cmd]);
+	trace_habanalabs_comms_send_cmd(&hdev->pdev->dev, comms_cmd_str_arr[cmd]);
 	WREG32(le32_to_cpu(dyn_regs->kmd_msg_to_cpu), val);
 }
 
@@ -1861,7 +1862,7 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 
 	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 
-	trace_habanalabs_comms_wait_status(hdev->dev, comms_sts_str_arr[expected_status]);
+	trace_habanalabs_comms_wait_status(&hdev->pdev->dev, comms_sts_str_arr[expected_status]);
 
 	/* Wait for expected status */
 	rc = hl_poll_timeout(
@@ -1878,7 +1879,8 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 		return -EIO;
 	}
 
-	trace_habanalabs_comms_wait_status_done(hdev->dev, comms_sts_str_arr[expected_status]);
+	trace_habanalabs_comms_wait_status_done(&hdev->pdev->dev,
+						comms_sts_str_arr[expected_status]);
 
 	/*
 	 * skip storing FW response for NOOP to preserve the actual desired
@@ -1952,7 +1954,7 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 {
 	int rc;
 
-	trace_habanalabs_comms_protocol_cmd(hdev->dev, comms_cmd_str_arr[cmd]);
+	trace_habanalabs_comms_protocol_cmd(&hdev->pdev->dev, comms_cmd_str_arr[cmd]);
 
 	/* first send clear command to clean former commands */
 	rc = hl_fw_dynamic_send_clear_cmd(hdev, fw_loader);
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index d3eaab908457..166c7da8b937 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/pci.h>
 
 #include "../habanalabs.h"
 
@@ -262,7 +263,7 @@ int hl_mmu_unmap_page(struct hl_ctx *ctx, u64 virt_addr, u32 page_size, bool flu
 		mmu_funcs->flush(ctx);
 
 	if (trace_habanalabs_mmu_unmap_enabled() && !rc)
-		trace_habanalabs_mmu_unmap(hdev->dev, virt_addr, 0, page_size, flush_pte);
+		trace_habanalabs_mmu_unmap(&hdev->pdev->dev, virt_addr, 0, page_size, flush_pte);
 
 	return rc;
 }
@@ -349,7 +350,7 @@ int hl_mmu_map_page(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_s
 	if (flush_pte)
 		mmu_funcs->flush(ctx);
 
-	trace_habanalabs_mmu_map(hdev->dev, virt_addr, phys_addr, page_size, flush_pte);
+	trace_habanalabs_mmu_map(&hdev->pdev->dev, virt_addr, phys_addr, page_size, flush_pte);
 
 	return 0;
 
diff --git a/drivers/accel/habanalabs/common/pci/pci.c b/drivers/accel/habanalabs/common/pci/pci.c
index 191e0e3cf3a5..81cbd8697d4c 100644
--- a/drivers/accel/habanalabs/common/pci/pci.c
+++ b/drivers/accel/habanalabs/common/pci/pci.c
@@ -123,7 +123,7 @@ int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data)
 		pci_read_config_dword(pdev, mmPCI_CONFIG_ELBI_DATA, data);
 
 		if (unlikely(trace_habanalabs_elbi_read_enabled()))
-			trace_habanalabs_elbi_read(hdev->dev, (u32) addr, val);
+			trace_habanalabs_elbi_read(&hdev->pdev->dev, (u32) addr, val);
 
 		return 0;
 	}
@@ -186,7 +186,7 @@ static int hl_pci_elbi_write(struct hl_device *hdev, u64 addr, u32 data)
 
 	if ((val & PCI_CONFIG_ELBI_STS_MASK) == PCI_CONFIG_ELBI_STS_DONE) {
 		if (unlikely(trace_habanalabs_elbi_write_enabled()))
-			trace_habanalabs_elbi_write(hdev->dev, (u32) addr, val);
+			trace_habanalabs_elbi_write(&hdev->pdev->dev, (u32) addr, val);
 		return 0;
 	}
 
-- 
2.34.1


