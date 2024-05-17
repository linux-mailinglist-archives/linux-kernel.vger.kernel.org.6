Return-Path: <linux-kernel+bounces-181691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68AD8C7FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 04:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180C71F22BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FF8F6A;
	Fri, 17 May 2024 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="pWAwxVF/"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6A18C09
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911596; cv=none; b=lYgGKhM5Ngs+5WbbGm9VAKCb9Z0ltT/r7X72w5pVFTxgNkbiwZxbGt2oqmMj7dzpPBgoDFXJEnkNteBIrh6HaoN5wZ7w61Sj/o6sA8GRn3v8dzawy9rH7mM6YzenZWhKakgtTVfjuRBbtZKdhPBOKNd6zHZMB/y9x3zi/JOTf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911596; c=relaxed/simple;
	bh=LDnLZItMwRImux4eAMbe3ANlwaZBle3xaItdfLbElWM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KRzGKR96cnrby+kwoCrk6DcharGmsyejLnDZEsgADPRElpjd5mY9XJ//cwNeiwZqo4nwYswvkTH9BWiVwF4/pETYLatZ8zYYbJZVxgUTFkzg3Bl4X/RUJyd6FXp+/uZhYS/PufKOf3WthUUB0fGkMokm/7X9WLxnFYkjrhPzkmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=pWAwxVF/ reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U26g6f73eFb1u+VeWeFRAy17R0r1C2uB3ZL+Z2+3L88=;
  b=pWAwxVF/2Nax62ngg+YpZEjeDXJLe7C9YtW16IY1CiN2S99F7JIXCEz/
   kfpuaWZ1A4sQWVFKzzF4z1ulSBT+TSWf0QyTb12U+5uUivG3bwSxscdPr
   bQtySEAhpnIF9EjsVf6YJdHy7ER6+MTYITjBOPCWyjOENEWPe03nRKAvF
   QndmD1fKg3hpcdNppLvSGEyGN7+jRcfrgBQ+y+aWgfPclo1no6nux7RSZ
   bDwBWoMCYINTrreqZYNnRCtRCojXFf8FhRLInlvgfQLr/OeAmFIlsvPkw
   JV9KSiSXJ4N4uU5fd1A1gQuCI5NfOp63Yz2Kjue6gngQnyvW48SOOU9zd
   w==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 17 May 2024 10:06:25 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 44H26M2r025561;
	Fri, 17 May 2024 10:06:22 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 17 May 2024 10:06:21 +0800
From: kuro <kuro.chung@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>, Kuro Chung <kuro.chung@ite.com.tw>,
        Kenneth Haung <kenneth.hung@ite.com.tw>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v9] drm/bridge: it6505: This patch fixes hibernate to resume no display issue
Date: Fri, 17 May 2024 10:16:53 +0800
Message-ID: <20240517021654.1034218-1-kuro.chung@ite.com.tw>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	3FD3A1F283697E9F2574A3F1F0E0086D56A360965AA35BF6DC7C50A993DD6C072002:8
X-MAIL:mse.ite.com.tw 44H26M2r025561

From: Kuro Chung <kuro.chung@ite.com.tw>

This patch added a FIFO reset bit for input video. When system power resume,
the TTL input of it6505 may get some noise before video signal stable
and the hardware function reset is required.
But the input FIFO reset will also trigger error interrupts of output 
module rising.Thus, it6505 have to wait a period can clear those 
expected error interrupts caused by manual hardware reset in one 
interrupt handler calling to avoid interrupt looping.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")

---
 drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 469157341f3ab..5703fcf4b7b00 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1307,9 +1307,15 @@ static void it6505_video_reset(struct it6505 *it6505)
 	it6505_link_reset_step_train(it6505);
 	it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, EN_VID_MUTE);
 	it6505_set_bits(it6505, REG_INFOFRAME_CTRL, EN_VID_CTRL_PKT, 0x00);
-	it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET);
+
+	it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, TX_FIFO_RESET);
+	it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x00);
+
 	it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, RST_501_FIFO);
 	it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, 0x00);
+
+	it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET);
+	usleep_range(1000, 2000);
 	it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, 0x00);
 }
 
@@ -2245,12 +2251,11 @@ static void it6505_link_training_work(struct work_struct *work)
 	if (ret) {
 		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 		it6505_link_train_ok(it6505);
-		return;
 	} else {
 		it6505->auto_train_retry--;
+		it6505_dump(it6505);
 	}
 
-	it6505_dump(it6505);
 }
 
 static void it6505_plugged_status_to_codec(struct it6505 *it6505)
@@ -2471,31 +2476,53 @@ static void it6505_irq_link_train_fail(struct it6505 *it6505)
 	schedule_work(&it6505->link_works);
 }
 
-static void it6505_irq_video_fifo_error(struct it6505 *it6505)
+static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
 {
-	struct device *dev = it6505->dev;
-
-	DRM_DEV_DEBUG_DRIVER(dev, "video fifo overflow interrupt");
-	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-	flush_work(&it6505->link_works);
-	it6505_stop_hdcp(it6505);
-	it6505_video_reset(it6505);
+	return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
 }
 
-static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
+static void it6505_irq_video_handler(struct it6505 *it6505, const int *int_status)
 {
 	struct device *dev = it6505->dev;
+	int reg_0d, reg_int03;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "IO latch fifo overflow interrupt");
-	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-	flush_work(&it6505->link_works);
-	it6505_stop_hdcp(it6505);
-	it6505_video_reset(it6505);
-}
+	/*
+	 * When video SCDT change with video not stable,
+	 * Or video FIFO error, need video reset
+	 */
 
-static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
-{
-	return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
+	if ((!it6505_get_video_status(it6505) &&
+		(it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_status))) ||
+		(it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned int *) int_status)) ||
+		(it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int *) int_status))) {
+
+		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
+		flush_work(&it6505->link_works);
+		it6505_stop_hdcp(it6505);
+		it6505_video_reset(it6505);
+
+		usleep_range(10000, 11000);
+
+		/*
+		 * Clear FIFO error IRQ to prevent fifo error -> reset loop
+		 * HW will trigger SCDT change IRQ again when video stable
+		 */
+
+		reg_int03 = it6505_read(it6505, INT_STATUS_03);
+		reg_0d = it6505_read(it6505, REG_SYSTEM_STS);
+
+		reg_int03 &= (BIT(INT_VID_FIFO_ERROR) | BIT(INT_IO_LATCH_FIFO_OVERFLOW));
+		it6505_write(it6505, INT_STATUS_03, reg_int03);
+
+		DRM_DEV_DEBUG_DRIVER(dev, "reg08 = 0x%02x", reg_int03);
+		DRM_DEV_DEBUG_DRIVER(dev, "reg0D = 0x%02x", reg_0d);
+
+		return;
+	}
+
+
+	if (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_status))
+		it6505_irq_scdt(it6505);
 }
 
 static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
@@ -2508,15 +2535,12 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 	} irq_vec[] = {
 		{ BIT_INT_HPD, it6505_irq_hpd },
 		{ BIT_INT_HPD_IRQ, it6505_irq_hpd_irq },
-		{ BIT_INT_SCDT, it6505_irq_scdt },
 		{ BIT_INT_HDCP_FAIL, it6505_irq_hdcp_fail },
 		{ BIT_INT_HDCP_DONE, it6505_irq_hdcp_done },
 		{ BIT_INT_AUX_CMD_FAIL, it6505_irq_aux_cmd_fail },
 		{ BIT_INT_HDCP_KSV_CHECK, it6505_irq_hdcp_ksv_check },
 		{ BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error },
 		{ BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail },
-		{ BIT_INT_VID_FIFO_ERROR, it6505_irq_video_fifo_error },
-		{ BIT_INT_IO_FIFO_OVERFLOW, it6505_irq_io_latch_fifo_overflow },
 	};
 	int int_status[3], i;
 
@@ -2546,6 +2570,7 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 			if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
 				irq_vec[i].handler(it6505);
 		}
+		it6505_irq_video_handler(it6505, (unsigned int *) int_status);
 	}
 
 	pm_runtime_put_sync(dev);
-- 
2.25.1


