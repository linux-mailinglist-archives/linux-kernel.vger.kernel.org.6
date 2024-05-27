Return-Path: <linux-kernel+bounces-190544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727818CFFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E181F21CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099415EFAC;
	Mon, 27 May 2024 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="hJPjxmUc"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CF15DBCC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811994; cv=none; b=KqmF49aLE/rc8wdy2Ms0LI9hOA1IFV2NJ5uxGxH2BMZhaUzleN6SC81DQpXD345NhNWabOpPVHAI1Gxz5KS+Np/ibQ7URGDX6YtiZ1S4oOuwmytdNSa2IuNf3fhWbGd29jYjNLpVyiN4jRjxc+/c+n2E7wHjMXd22JUMakaPbYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811994; c=relaxed/simple;
	bh=HA3Ew5tpL7ApKKFbeZ+k1CKifd7ompu4unxRVvUSSkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhgzYqbGulhnn11Ol4vPfnyasdRGLfzmTM2q/jNxZ+KM5oFAg9J9Hb2DPjoL6trvGXFi+AZ2D+KAR2YVyrFYRPDB5hjeUcS4BSU2b8aVOvfJcqg2OH6slqZK/nVqOWaOVZ5VqQfYwYLbgrVyO8VHjJn3HpOKCDg0IVExBwc1i2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=hJPjxmUc; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716811993; bh=HA3Ew5tpL7ApKKFbeZ+k1CKifd7ompu4unxRVvUSSkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJPjxmUciGCeDmYTn82I0pH8ClJhQRo8Ku/9DqJTCAyoxQzt/DBzC3TAzhh+aq1Ou
	 I4eV1MaPXENiqYOJWp7wJpkbtalz5Sy02v0dXXOnvePNY7Sfp4jMVtwMHYT7dWxAOf
	 1t/Z/tINg6YYTXNeZMIOX4dx87+VOnlCQl89Z1eusBxC7Qvn0jhivLGtzFPQo5uh0X
	 b4uhNP9O2OSZadK8AVqoQs5Pm6cWRcMICojKTKM/ZE81NrO6DDMl+cA9m6X149aIxA
	 Kc+L+uWd2rwrfwAL+BE7MqkB8p3Zz9EYF5BrT8XiTq2iPNhHGrupEvQuK0EcYKcKPB
	 TINOv+umpz6nw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RCCub01921351;
	Mon, 27 May 2024 15:12:57 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 8/8] accel/habanalabs: move hl_eq_heartbeat_event_handle() to common code
Date: Mon, 27 May 2024 15:12:54 +0300
Message-Id: <20240527121254.1921306-8-obitton@habana.ai>
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

hl_eq_heartbeat_event_handle() doesn't have ASIC specific code, and
therefore can be moved from Gaudi2-only code to common code, and
possibly used for other ASICs.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c     | 6 ++++++
 drivers/accel/habanalabs/common/habanalabs.h | 1 +
 drivers/accel/habanalabs/gaudi2/gaudi2.c     | 6 ------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 35502e938b5d..f9b8601c4396 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2850,3 +2850,9 @@ void hl_set_irq_affinity(struct hl_device *hdev, int irq)
 	if (irq_set_affinity_and_hint(irq, &hdev->irq_affinity_mask))
 		dev_err(hdev->dev, "Failed setting irq %d affinity\n", irq);
 }
+
+void hl_eq_heartbeat_event_handle(struct hl_device *hdev)
+{
+	hdev->heartbeat_debug_info.heartbeat_event_counter++;
+	hdev->eq_heartbeat_received = true;
+}
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 8d0df685e627..057087dc8592 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -4059,6 +4059,7 @@ void hl_capture_engine_err(struct hl_device *hdev, u16 engine_id, u16 error_coun
 void hl_enable_err_info_capture(struct hl_error_info *captured_err_info);
 void hl_init_cpu_for_irq(struct hl_device *hdev);
 void hl_set_irq_affinity(struct hl_device *hdev, int irq);
+void hl_eq_heartbeat_event_handle(struct hl_device *hdev);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 4791582d157c..a38b88baadf2 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -9777,12 +9777,6 @@ static u16 event_id_to_engine_id(struct hl_device *hdev, u16 event_type)
 	return U16_MAX;
 }
 
-static void hl_eq_heartbeat_event_handle(struct hl_device *hdev)
-{
-	hdev->heartbeat_debug_info.heartbeat_event_counter++;
-	hdev->eq_heartbeat_received = true;
-}
-
 static void gaudi2_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
-- 
2.34.1


