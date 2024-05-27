Return-Path: <linux-kernel+bounces-191033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5368B8D05C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9297F1F2036E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8716C861;
	Mon, 27 May 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="JwYIrAxl"
Received: from mail02.habana.ai (habanamailrelay.habana.ai [213.57.90.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8016C6B7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.57.90.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822161; cv=none; b=KcElWDzAkISSVbTMXcKQAoxN7iyGDp4/Ihm2VmJh1ChJg35AdITRGoxoZHYCEJko3FVscKAZSA16aAH8z0X5FJ4XI1UMVOH15SpHU3572FWb/9qkfuCLgw9ySGLQdR9Y2VXgv5NLlFRhsYTA9HW0r3b5yYuy9tg99MQ/yCW0KAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822161; c=relaxed/simple;
	bh=A7hb/8XwlGIYcRbyAd3Z+DLTG2+4TxEgmPGbtk3dXII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUKtIL20jzg3a7fItuWAxVxyuCiFspml/Vg0WCpHTCVUWNk9EVJtsDzr54aXTGtuiLP4TuzVtRfuwsFI37Nj5jKCTRqoJ7bUseV1qShmZSB8gNbZ0POxOHJRyywAlkTlEahaFFDPahU5cjHf5EK5Eme7pi9nM+o+PnIGtIluHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=JwYIrAxl; arc=none smtp.client-ip=213.57.90.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822162; bh=A7hb/8XwlGIYcRbyAd3Z+DLTG2+4TxEgmPGbtk3dXII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwYIrAxlp9i/xR2v+Ewocpm/r7XEA0pGJiklc7Agj0sIRbV5H4WC8pqlIFJqwufF3
	 HlzTMa/1sKwROHZh5A9iUTFOHwkiESRtPDKVSoeSFjZK7x/uLdVvPI7bMyO5xL9gl6
	 N8W5CF8S7aVpY3cwEYhnWOFBasdadKFtFaIGTyg7OJjliL+wowjrZCNKHpzXdY83Fd
	 /APllACUdSvQqLfeTtfo2+bK2w7U+7q9sc1DsfQRR7jB4ij+tKq6/IOJXSGXrF4npb
	 iu198Fxv93ODFf+gAlwF7I6c7jrag9RjSmD6j3xd027b7CjBgjrtn53YQ8UGXVJzur
	 q2PgHLRhLFQZg==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiU1954007;
	Mon, 27 May 2024 18:02:26 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 3/8] accel/habanalabs: add a common handler for clock change events
Date: Mon, 27 May 2024 18:02:19 +0300
Message-Id: <20240527150224.1953969-3-obitton@habana.ai>
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

From: Tomer Tayar <ttayar@habana.ai>

As the new dynamic EQ includes clock change events which are common and
not ASIC-specific, add a common handler for these events.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c     | 46 ++++++++++++++++++++
 drivers/accel/habanalabs/common/habanalabs.h |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index fd117489a05a..31daa9184537 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2860,3 +2860,49 @@ void hl_eq_heartbeat_event_handle(struct hl_device *hdev)
 	hdev->heartbeat_debug_info.heartbeat_event_counter++;
 	hdev->eq_heartbeat_received = true;
 }
+
+void hl_handle_clk_change_event(struct hl_device *hdev, u16 event_type, u64 *event_mask)
+{
+	struct hl_clk_throttle *clk_throttle = &hdev->clk_throttling;
+	ktime_t zero_time = ktime_set(0, 0);
+
+	mutex_lock(&clk_throttle->lock);
+
+	switch (event_type) {
+	case EQ_EVENT_POWER_EVT_START:
+		clk_throttle->current_reason |= HL_CLK_THROTTLE_POWER;
+		clk_throttle->aggregated_reason |= HL_CLK_THROTTLE_POWER;
+		clk_throttle->timestamp[HL_CLK_THROTTLE_TYPE_POWER].start = ktime_get();
+		clk_throttle->timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = zero_time;
+		dev_dbg_ratelimited(hdev->dev, "Clock throttling due to power consumption\n");
+		break;
+
+	case EQ_EVENT_POWER_EVT_END:
+		clk_throttle->current_reason &= ~HL_CLK_THROTTLE_POWER;
+		clk_throttle->timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = ktime_get();
+		dev_dbg_ratelimited(hdev->dev, "Power envelop is safe, back to optimal clock\n");
+		break;
+
+	case EQ_EVENT_THERMAL_EVT_START:
+		clk_throttle->current_reason |= HL_CLK_THROTTLE_THERMAL;
+		clk_throttle->aggregated_reason |= HL_CLK_THROTTLE_THERMAL;
+		clk_throttle->timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].start = ktime_get();
+		clk_throttle->timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = zero_time;
+		*event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
+		dev_info_ratelimited(hdev->dev, "Clock throttling due to overheating\n");
+		break;
+
+	case EQ_EVENT_THERMAL_EVT_END:
+		clk_throttle->current_reason &= ~HL_CLK_THROTTLE_THERMAL;
+		clk_throttle->timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = ktime_get();
+		*event_mask |= HL_NOTIFIER_EVENT_USER_ENGINE_ERR;
+		dev_info_ratelimited(hdev->dev, "Thermal envelop is safe, back to optimal clock\n");
+		break;
+
+	default:
+		dev_err(hdev->dev, "Received invalid clock change event %d\n", event_type);
+		break;
+	}
+
+	mutex_unlock(&clk_throttle->lock);
+}
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 0d16b5310add..3ea1b131cd42 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -4063,6 +4063,7 @@ void hl_enable_err_info_capture(struct hl_error_info *captured_err_info);
 void hl_init_cpu_for_irq(struct hl_device *hdev);
 void hl_set_irq_affinity(struct hl_device *hdev, int irq);
 void hl_eq_heartbeat_event_handle(struct hl_device *hdev);
+void hl_handle_clk_change_event(struct hl_device *hdev, u16 event_type, u64 *event_mask);
 
 #ifdef CONFIG_DEBUG_FS
 
-- 
2.34.1


