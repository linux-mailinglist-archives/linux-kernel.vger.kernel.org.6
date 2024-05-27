Return-Path: <linux-kernel+bounces-190505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E308CFF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50FE4283964
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127A15EFC4;
	Mon, 27 May 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="gU3sezJV"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E715E5C6
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810527; cv=none; b=K3X0BmesUWmsdOEMFPEdYxMKVbu1Us65qm3jf78BHGkk87nECoFZXePUz1j80dUrI0UAsE2QumPk5FG2qCujKH2JTCMnFaY0u4E7m3fLvmgX1/5b3yFHGMi9AMZnJJ+q1E5fHwUcbA01gOLY1cuvItPwtrR6R54osD/aWZ5xB74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810527; c=relaxed/simple;
	bh=mp5DAl21UuJcDlAVTYNSw0SqQLrU/a4V6eKgkuG5J8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9AnokWO0v05yB58qCPE27a9rotEnR9kcmVFWESPFurodlXG6hrGyeNJIdMMlKQ/2zeu6/085oY8jqbnBglHJbmFPhhxiT0yrAkG/Mkbx+CCUd0ViixRiCpUxAJcqpPWbSloq6eCaGiXqW8U85bKfweUoixIQE3BPaB0d780hnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=gU3sezJV; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716810492; bh=mp5DAl21UuJcDlAVTYNSw0SqQLrU/a4V6eKgkuG5J8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gU3sezJVjMC+rZyyE2IDiEiPjdsfNX87Jxr+wY/gezbcd9j9FFyUzPrRVrXTAR1n4
	 DcF9m4YsVwW8UCj8vOVqdm0EsACpMYTDGWXxsSts63egR42iidyWg3V9LPdoBwSsrI
	 JsI/NwlMRR0kXhh4vN8fjowwUWW7nrnTgcPZ1f+qo9q94cMGaDYjcnuzhQrdob1ERz
	 NkaDjKcfW3+6Kpt0ZBVN8I0CGM9RY/mT62SeCD3SIac6I+90w6MVS0t7fWt+cdXOqA
	 lO2n+0jcA7O6YKkPG4r6B4/hQ+7J7iJt5OqCGpuBtqRdt7kNvu900hP4VjMZ9nWlVC
	 1FYta+dXIvrow==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RBltNn1919357;
	Mon, 27 May 2024 14:47:56 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 9/9] accel/habanalabs: add heartbeat debug info
Date: Mon, 27 May 2024 14:47:46 +0300
Message-Id: <20240527114746.1919292-9-obitton@habana.ai>
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

From: Farah Kassabri <fkassabri@habana.ai>

It is hard to debug the reason for heartbeat check failures.
As an attempt to ease this task, this patch will provide more
information when this failure happens.
Heartbeat checks the communication with FW, so printing
the CPU queue pi/ci and the counter of how many times that event
was received would help in debugging the issue.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c     | 12 ++++++++++++
 drivers/accel/habanalabs/common/habanalabs.h | 15 ++++++++++++++-
 drivers/accel/habanalabs/gaudi2/gaudi2.c     |  3 +++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index bb3f44392908..35502e938b5d 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1052,12 +1052,22 @@ static bool is_pci_link_healthy(struct hl_device *hdev)
 static bool hl_device_eq_heartbeat_received(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 cpu_q_id;
 
 	if (!prop->cpucp_info.eq_health_check_supported)
 		return true;
 
 	if (!hdev->eq_heartbeat_received) {
+		cpu_q_id = hdev->heartbeat_debug_info.cpu_queue_id;
+
 		dev_err(hdev->dev, "EQ heartbeat event was not received!\n");
+
+		dev_err(hdev->dev, "Heartbeat events counter: %u, Q_PI: %u, Q_CI: %u, EQ CI: %u, EQ prev: %u\n",
+				hdev->heartbeat_debug_info.heartbeat_event_counter,
+				hdev->kernel_queues[cpu_q_id].pi,
+				atomic_read(&hdev->kernel_queues[cpu_q_id].ci),
+				hdev->event_queue.ci,
+				hdev->event_queue.prev_eqe_index);
 		return false;
 	}
 
@@ -1138,6 +1148,8 @@ static int device_late_init(struct hl_device *hdev)
 	hdev->high_pll = hdev->asic_prop.high_pll;
 
 	if (hdev->heartbeat) {
+		hdev->heartbeat_debug_info.heartbeat_event_counter = 0;
+
 		/*
 		 * Before scheduling the heartbeat driver will check if eq event has received.
 		 * for the first schedule we need to set the indication as true then for the next
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 55495861f432..5e9f54ca336a 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -71,7 +71,7 @@ struct hl_fpriv;
 
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
-#define HL_HEARTBEAT_PER_USEC		5000000 /* 5 s */
+#define HL_HEARTBEAT_PER_USEC		10000000 /* 10 s */
 
 #define HL_PLL_LOW_JOB_FREQ_USEC	5000000 /* 5 s */
 
@@ -3174,6 +3174,16 @@ struct hl_reset_info {
 	u8		watchdog_active;
 };
 
+/**
+ * struct eq_heartbeat_debug_info - stores debug info to be used upon heartbeat failure.
+ * @heartbeat_event_counter: number of heartbeat events received.
+ * @cpu_queue_id: used to read the queue pi/ci
+ */
+struct eq_heartbeat_debug_info {
+	u32 heartbeat_event_counter;
+	u32 cpu_queue_id;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -3262,6 +3272,7 @@ struct hl_reset_info {
  * @clk_throttling: holds information about current/previous clock throttling events
  * @captured_err_info: holds information about errors.
  * @reset_info: holds current device reset information.
+ * @heartbeat_debug_info: counters used to debug heartbeat failures.
  * @irq_affinity_mask: mask of available CPU cores for user and decoder interrupt handling.
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
  * @fw_inner_major_ver: the major of current loaded preboot inner version.
@@ -3452,6 +3463,8 @@ struct hl_device {
 
 	struct hl_reset_info		reset_info;
 
+	struct eq_heartbeat_debug_info	heartbeat_debug_info;
+
 	cpumask_t			irq_affinity_mask;
 
 	u32				*stream_master_qid_arr;
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 962b7fcd4318..08276f03c80f 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -3796,6 +3796,8 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 	if (rc)
 		goto special_blocks_free;
 
+	hdev->heartbeat_debug_info.cpu_queue_id = GAUDI2_QUEUE_ID_CPU_PQ;
+
 	return 0;
 
 special_blocks_free:
@@ -9777,6 +9779,7 @@ static u16 event_id_to_engine_id(struct hl_device *hdev, u16 event_type)
 
 static void hl_eq_heartbeat_event_handle(struct hl_device *hdev)
 {
+	hdev->heartbeat_debug_info.heartbeat_event_counter++;
 	hdev->eq_heartbeat_received = true;
 }
 
-- 
2.34.1


