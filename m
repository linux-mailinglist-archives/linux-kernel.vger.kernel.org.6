Return-Path: <linux-kernel+bounces-220543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E990E381
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915821C21411
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0A46F2F3;
	Wed, 19 Jun 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="MnY6i1PS"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A514C98
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718778888; cv=none; b=S3LARE1RY6TrFdo7hKRUtFKk/UGa6zbKUqCDYkUEtnogxP0ZZO2dPNJaL6DsHnXzNuTn3n/tshb5d4dSl7NZRAD8n32+avHamvIRTRKN67vxSDu8NZgJgQfTQ+UAl8RxO3RLNsIqNjOvkttVm9omzRe8jL6vLwfP2e3l+jCE6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718778888; c=relaxed/simple;
	bh=5ump6eTLOwqBw/KiRuccbtl0IWfZ6Ud4eHUp0djojrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doqP8u3TEY616EdL0UK92Ah8gpC/gJ6Dg3nTkitPQ/Y/EwjcFUEgpUaauZFBEVLlgZseB0xMMJQF0HvB8cm+6DCQi8dAyygwvK6RSXjxk4fFEwttZZuzb9VlYaQ3azU1Zia5e8cFK1tYHGCqHfxUNRjxPkcHmXKuEzZx9ERb+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=MnY6i1PS; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718778884; bh=5ump6eTLOwqBw/KiRuccbtl0IWfZ6Ud4eHUp0djojrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MnY6i1PSqvaA9TQQuARbAu1bYcyotWLFA2uZ3I9aZP3TrCP1jPAJxdkA+9PNjAOsR
	 a8s7Ap7CNLGGtLCAHfF4x2xYBA+2/vqgNg+/tqKKgt5W0FbJrBKDuGiUmnUuA6H60S
	 ywqNoCELtYlEQc3TgY9HJORW568ZjE/06PcLRKMFMWrumDgt6L9tP+hEuXAguIUGgG
	 768m2EKncDYnwCIbLCXACgZVC+ubkUODpQDYga4m5AlPTN1vrUy0Q0T7p3mzmN/Yc0
	 rQhMs9kJ3xkn+xRtaXxr8eI5u/M2aRqPRDRBdlOLQAD7T1iyykv0G7uxcEb0FmVRfg
	 7NMUWLU8+Xzqw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45J6YQB41377354;
	Wed, 19 Jun 2024 09:34:33 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 4/9] accel/habanalabs: add more info upon cpu pkt timeout
Date: Wed, 19 Jun 2024 09:34:20 +0300
Message-Id: <20240619063425.1377327-4-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619063425.1377327-1-obitton@habana.ai>
References: <20240619063425.1377327-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farah Kassabri <fkassabri@habana.ai>

In order to have better debuggability upon encountering FW issues,
We are adding additional info once CPU packet timeout expires.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/firmware_if.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index 6f0c40b12072..3cd8a1f69980 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -460,11 +460,19 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		/* If FW performed reset just before sending it a packet, we will get a timeout.
 		 * This is expected behavior, hence no need for error message.
 		 */
-		if (!hl_device_operational(hdev, NULL) && !hdev->reset_info.in_compute_reset)
+		if (!hl_device_operational(hdev, NULL) && !hdev->reset_info.in_compute_reset) {
 			dev_dbg(hdev->dev, "Device CPU packet timeout (0x%x) due to FW reset\n",
 					tmp);
-		else
-			dev_err(hdev->dev, "Device CPU packet timeout (status = 0x%x)\n", tmp);
+		} else {
+			struct hl_bd *bd = queue->kernel_address;
+
+			bd += hl_pi_2_offset(queue->pi);
+
+			dev_err(hdev->dev, "Device CPU packet timeout (status = 0x%x)\n"
+					"Pkt info: dma_addr: 0x%llx, kernel_addr: %p, len:0x%x, ctl: 0x%x, ptr:0x%llx, dram_bd:%u\n",
+					tmp, pkt_dma_addr, (void *)pkt, bd->len, bd->ctl, bd->ptr,
+					queue->dram_bd);
+		}
 		hdev->device_cpu_disabled = true;
 		goto out;
 	}
-- 
2.34.1


