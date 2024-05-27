Return-Path: <linux-kernel+bounces-191036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED778D0700
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2FCB27338
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6D416F296;
	Mon, 27 May 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="TKWMqcx5"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9A616C6B9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822163; cv=none; b=lKqjxptl2pMcah4zVpmy848aVzlg5bXAFsu4Dfm4+5gePQPcBDI+qVxRho6nANQu+E+icbcn1vlWg4qLL4tFnd3ZUXs+9ov8fzTSpGjftvDlXsD/iV0Sonuf3DAwC3/hki2d4opLcHiAct+zdatLspnX+Fq9KQaniz3Qpd+EnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822163; c=relaxed/simple;
	bh=02pFJ4y+owr0x7FFw2etdAv6pcbCk5FXca4Qfvfnw+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uVgDkNFan/u/r4momRBBiYmaYPGXKKjJxemzJq5qOyQUsnFJ0xq2OuKYUSiolZj+W9D153RE6/yL9O1xu9vXmKG0dvIHdTFQGgaxvYVmPiyzyE8cwrhOhy9z7vo+7WICo4bRzBmZVBOxUp4yBL+qXZcB4zyltvcN6tPJKFrILjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=TKWMqcx5; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822162; bh=02pFJ4y+owr0x7FFw2etdAv6pcbCk5FXca4Qfvfnw+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKWMqcx5DTK7U7vLjrOjrJjsNrRegt9cGkaRBW7kWR57UXGu1LfUgeQqhqZKbdm5d
	 ERZbDKCjJhlNnvDHsW6keNX06sjUqufeJRPw91ZE2k8MfPKSoAN4hGen6dGe8SI4IY
	 T8fc1Ub7cDSlNBXLSdJYBE7a47OQarX7w7Bx7PH8az86YG2BY2ZYF2XPkzeQFMNfjn
	 PE3Gc8FoLNFwGNyKCIQZh5fZtoE6RDGt4r1kCDoU/dqTd+hDJOcqe4nyHX6B1UvBWz
	 caAv4+Dr9M2TCIA4178jBoorl5xabZd8q40U7elnDjVDIJLTF0rsvPX52dkdYy1E7T
	 HSftQMRlPiMCw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiY1954007;
	Mon, 27 May 2024 18:02:26 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Farah Kassabri <fkassabri@habana.ai>
Subject: [PATCH 7/8] accel/habanalabs: change the heartbeat scheduling point
Date: Mon, 27 May 2024 18:02:23 +0300
Message-Id: <20240527150224.1953969-7-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527150224.1953969-1-obitton@habana.ai>
References: <20240527150224.1953969-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Farah Kassabri <fkassabri@habana.ai>

Currently we schedule the heartbeat thread at late init, only then
we set the INTS_REGISTER packet which enables events to be received
from firmware.

Init may take some time and we want to give firmware 2 full cycles of
heartbeat thread after it received INTS_REGISTER.

The patch will move the heartbeat thread scheduling to be after driver
is done with all initializations.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c | 54 +++++++++++++++---------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 31daa9184537..5ca7014def00 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1150,23 +1150,6 @@ static int device_late_init(struct hl_device *hdev)
 	}
 
 	hdev->high_pll = hdev->asic_prop.high_pll;
-
-	if (hdev->heartbeat) {
-		hdev->heartbeat_debug_info.heartbeat_event_counter = 0;
-
-		/*
-		 * Before scheduling the heartbeat driver will check if eq event has received.
-		 * for the first schedule we need to set the indication as true then for the next
-		 * one this indication will be true only if eq event was sent by FW.
-		 */
-		hdev->eq_heartbeat_received = true;
-
-		INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
-
-		schedule_delayed_work(&hdev->work_heartbeat,
-				usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
-	}
-
 	hdev->late_init_done = true;
 
 	return 0;
@@ -1183,9 +1166,6 @@ static void device_late_fini(struct hl_device *hdev)
 	if (!hdev->late_init_done)
 		return;
 
-	if (hdev->heartbeat)
-		cancel_delayed_work_sync(&hdev->work_heartbeat);
-
 	if (hdev->asic_funcs->late_fini)
 		hdev->asic_funcs->late_fini(hdev);
 
@@ -1286,8 +1266,12 @@ static void hl_abort_waiting_for_completions(struct hl_device *hdev)
 static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_reset,
 				bool skip_wq_flush)
 {
-	if (hard_reset)
+	if (hard_reset) {
+		if (hdev->heartbeat)
+			cancel_delayed_work_sync(&hdev->work_heartbeat);
+
 		device_late_fini(hdev);
+	}
 
 	/*
 	 * Halt the engines and disable interrupts so we won't get any more
@@ -1565,6 +1549,26 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 	}
 }
 
+static inline void device_heartbeat_schedule(struct hl_device *hdev)
+{
+	if (!hdev->heartbeat)
+		return;
+
+	hdev->heartbeat_debug_info.heartbeat_event_counter = 0;
+
+	/*
+	 * Before scheduling the heartbeat driver will check if eq event has received.
+	 * for the first schedule we need to set the indication as true then for the next
+	 * one this indication will be true only if eq event was sent by FW.
+	 */
+	hdev->eq_heartbeat_received = true;
+
+	INIT_DELAYED_WORK(&hdev->work_heartbeat, hl_device_heartbeat);
+
+	schedule_delayed_work(&hdev->work_heartbeat,
+			usecs_to_jiffies(HL_HEARTBEAT_PER_USEC));
+}
+
 /*
  * hl_device_reset - reset the device
  *
@@ -1934,6 +1938,8 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	if (hard_reset) {
 		hdev->reset_info.hard_reset_cnt++;
 
+		device_heartbeat_schedule(hdev);
+
 		/* After reset is done, we are ready to receive events from
 		 * the F/W. We can't do it before because we will ignore events
 		 * and if those events are fatal, we won't know about it and
@@ -2368,6 +2374,12 @@ int hl_device_init(struct hl_device *hdev)
 		goto out_disabled;
 	}
 
+	/* Scheduling the EQ heartbeat thread must come after driver is done with all
+	 * initializations, as we want to make sure the FW gets enough time to be prepared
+	 * to respond to heartbeat packets.
+	 */
+	device_heartbeat_schedule(hdev);
+
 	dev_notice(hdev->dev,
 		"Successfully added device %s to habanalabs driver\n",
 		dev_name(&(hdev)->pdev->dev));
-- 
2.34.1


