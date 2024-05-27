Return-Path: <linux-kernel+bounces-190540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3888CFFA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C6A2836C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1115E5B8;
	Mon, 27 May 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="vF1NwWg+"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A95C15DBB7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811993; cv=none; b=NK5i7uozrr6QRt21iE1VW4+TEl9CuBO3B4qq+Qex1dw3ZroN2v3LlmwlxePTTB3+a0cpluE4C5YbvmsXstiYktVFPsDtJB1WHDhlhnNdhsMzsw7ru2NCTsDBQCmKx+/JhdfONZWksCGkVpsIhogBLFCrv4Ww15o4W4tB+dp6Ahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811993; c=relaxed/simple;
	bh=U9MPkc2aHrKjb35j4wkT+YPsoCL4v2hDv0CLivsUJDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CppoTqAX+oTi/APBEDEjsczu0Bp5yrFKT8ZNJMek8RD4cBlvpO2Le8wqomKQMEXMrNaxZcxmBSEY7MTpLvzkeh8B1ExQXqtwGo8ZR0dyY6TaYbTR1qcz4njFAVkmFHOe9RD0pBvgyaHONKXAD1i4uTAOSKvT5Hz3dEWLhxDOLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=vF1NwWg+; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716811982; bh=U9MPkc2aHrKjb35j4wkT+YPsoCL4v2hDv0CLivsUJDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vF1NwWg+FaHiAOT9UF/be/Exbyf0JagRctd5W1240nR69rSZyVqMc+3sajkv0p144
	 9DI0qn8a7168/9Po2LX/b7xKvJKqc0xR4uZrUO1M+l19XiHyMk6vDNZAeVRxwekDe9
	 xWO8blujS6AVMwx8h1q328h3SW6nha1bx24PlN1i3tGFrX2FvVHPcE8/oSYwiiM6wb
	 y4knMVBLSJ5LyWOjDFBXUSTT00O/ycaFCUR+xv5/l84TGOdOM6mGTziv9ba6OoF1Gy
	 mrWKgY/6o6WdC4GTNh4DzfSaxc2HptEkiTQxOE89jwsGVgIA/hODjBf+dguAO3i9JQ
	 ghDkY2i84NZiw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RCCuax1921351;
	Mon, 27 May 2024 15:12:57 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 7/8] accel/habanalabs: add an EQ size ASIC property
Date: Mon, 27 May 2024 15:12:53 +0300
Message-Id: <20240527121254.1921306-7-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527121254.1921306-1-obitton@habana.ai>
References: <20240527121254.1921306-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomer Tayar <ttayar@habana.ai>

Future supported ASICs might use the dynamic EQ mechanism with the
firmware, and in that case the EQ size won't be equal to the default
HL_EQ_SIZE_IN_BYTES value.
Add an ASIC property to enable overriding this value.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/habanalabs.h | 5 +++++
 drivers/accel/habanalabs/common/irq.c        | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 5e9f54ca336a..8d0df685e627 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -651,6 +651,8 @@ struct hl_hints_range {
  * @hbw_flush_reg: register to read to generate HBW flush. value of 0 means HBW flush is
  *                 not supported.
  * @reserved_fw_mem_size: size of dram memory reserved for FW.
+ * @fw_event_queue_size: queue size for events from CPU-CP.
+ *                       A value of 0 means using the default HL_EQ_SIZE_IN_BYTES value.
  * @collective_first_sob: first sync object available for collective use
  * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
@@ -782,6 +784,7 @@ struct asic_fixed_properties {
 	u32				glbl_err_max_cause_num;
 	u32				hbw_flush_reg;
 	u32				reserved_fw_mem_size;
+	u32				fw_event_queue_size;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
 	u16				sync_stream_first_sob;
@@ -1229,6 +1232,7 @@ struct hl_user_pending_interrupt {
  * @hdev: pointer to the device structure
  * @kernel_address: holds the queue's kernel virtual address
  * @bus_address: holds the queue's DMA address
+ * @size: the event queue size
  * @ci: ci inside the queue
  * @prev_eqe_index: the index of the previous event queue entry. The index of
  *                  the current entry's index must be +1 of the previous one.
@@ -1240,6 +1244,7 @@ struct hl_eq {
 	struct hl_device	*hdev;
 	void			*kernel_address;
 	dma_addr_t		bus_address;
+	u32			size;
 	u32			ci;
 	u32			prev_eqe_index;
 	bool			check_eqe_index;
diff --git a/drivers/accel/habanalabs/common/irq.c b/drivers/accel/habanalabs/common/irq.c
index 978b7f4d5eeb..2caf2df4de08 100644
--- a/drivers/accel/habanalabs/common/irq.c
+++ b/drivers/accel/habanalabs/common/irq.c
@@ -652,14 +652,16 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
  */
 int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
 {
+	u32 size = hdev->asic_prop.fw_event_queue_size ? : HL_EQ_SIZE_IN_BYTES;
 	void *p;
 
-	p = hl_cpu_accessible_dma_pool_alloc(hdev, HL_EQ_SIZE_IN_BYTES, &q->bus_address);
+	p = hl_cpu_accessible_dma_pool_alloc(hdev, size, &q->bus_address);
 	if (!p)
 		return -ENOMEM;
 
 	q->hdev = hdev;
 	q->kernel_address = p;
+	q->size = size;
 	q->ci = 0;
 	q->prev_eqe_index = 0;
 
@@ -678,7 +680,7 @@ void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
 {
 	flush_workqueue(hdev->eq_wq);
 
-	hl_cpu_accessible_dma_pool_free(hdev, HL_EQ_SIZE_IN_BYTES, q->kernel_address);
+	hl_cpu_accessible_dma_pool_free(hdev, q->size, q->kernel_address);
 }
 
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
@@ -693,5 +695,5 @@ void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
 	 * when the device is operational again
 	 */
 
-	memset(q->kernel_address, 0, HL_EQ_SIZE_IN_BYTES);
+	memset(q->kernel_address, 0, q->size);
 }
-- 
2.34.1


