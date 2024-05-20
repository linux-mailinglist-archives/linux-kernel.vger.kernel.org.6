Return-Path: <linux-kernel+bounces-183436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB08C990B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0A11F214AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 06:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581D41B7E9;
	Mon, 20 May 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="oXKhlD2T"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094D018EA8
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716188027; cv=none; b=ZlWbLLzJCSOCYpp+POTOUH9qPtg2kzhrR1G4VRMzD4kcZWD6p0XjQsZkVU6RhBWun4wr2BkYJ1a7bCRWw9o86GfaHVFTfTxmkMxQpYXDeu7y5XoMX6dLOHd9LwCfqIJSVSmTADiSbdVjyKQlK0u3x5CUxqTfDrJo+pjqqwtY0Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716188027; c=relaxed/simple;
	bh=Kj158VoswzrvZErVDui75uuH4g1aYRxPZqPeo97q+X8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K2hsCV3h2pHkp/irLFznTE1B1SpAGFD/c58zi4Xuxq3egLx9aU7vcvc732gZeydVfixkMn58z1OkmaFr7sP5dO7S/oWNkhSryfqrOoIynWr7c7E76y0c8weDGd1nWy6HgR7nUe5T5JzUTbmh98Qihk1th8ExOa+nKOGri1kfAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=oXKhlD2T reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eUy2/8y84vz5smLa+9O8KjGZa8QisMDqGetd1j7XITc=;
  b=oXKhlD2TRaFUGIincIX0pXmYkpIAySNunRVC4+x1tDLebCs3Tg+1UrJ6
   6T3Fh3lWHpEJUEKi4tvyaARfZYgBBMvrwshXTCQ6X/uBgp2mHfPKZ3A1J
   Sqg12jEvI0C/g+eHja1cFN90eV5JC7fk98jVeZ+geTrpm2KjvD7a57cB4
   6wJ34z/djF6xKzPjRINe3Gea7kF6jeGSgvo6sEqlT/W03Hlk0/J1OQ8tm
   0s1ansuXcic5LuQxBjtZGutJINjV18a9cyLLa3+Xt+V1xPpokcti8a0Dy
   kFgn36MYpqPKyLrgfBdnDTziFH0LWp6fZOjhJy1eR+Tq3buCbvuhA8gOY
   g==;
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 20 May 2024 14:53:36 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 44K6rU4n010202;
	Mon, 20 May 2024 14:53:30 +0800 (GMT-8)
	(envelope-from kuro.chung@ite.com.tw)
Received: from ite-XPS-13-9360.internal.ite.com.tw (192.168.72.42) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 May 2024 14:53:30 +0800
From: kuro <kuro.chung@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>,
        Kenneth Haung
	<kenneth.hung@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>,
        Allen Chen
	<allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
        "open list:DRM
 DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list
	<linux-kernel@vger.kernel.org>
CC: Kuro Chung <kuro.chung@ite.com.tw>
Subject: [PATCH v11] drm/bridge: it6505: fix hibernate to resume no display issue
Date: Mon, 20 May 2024 15:04:09 +0800
Message-ID: <20240520070409.1044236-1-kuro.chung@ite.com.tw>
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
	32CE3029E6253C26B22258C158503B563CB29E6C12715E4EF3F8DD316004466A2002:8
X-MAIL:mse.ite.com.tw 44K6rU4n010202

From: Kuro Chung <kuro.chung@ite.com.tw>

When the system power resumes, the TTL input of IT6505 may experience
some noise before the video signal stabilizes, necessitating a video 
reset. This patch has been implemented to prevent a loop of video error
interrupts, which can occur when a video reset in the video FIFO error
interrupt triggers another such interrupt. The patch processes the SCDT
and FIFO error interrupts simultaneously and ignores any video FIFO 
error interrupts caused by a video reset.

Signed-off-by: Kuro Chung <kuro.chung@ite.com.tw>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
---
V1->V3: update MAINTAINERS mail list
V3->V4: remove function it6505_irq_video_fifo_error/it6505_irq_io_latch_fifo_overflow
V4->V5: customer feedback again, update again, kernel build pass
V5->V6: remove unrelated patch change, split into another patch
V6->V7: modify code 0x02 to TX_FIFO_RESET by macro define
V7->V8: fix merge conflict, change mail from 'cc' to 'to'
V8->V9: modify patch description, patch summary
V9->V10: modify patch summary, add Fixes
V10->V11: modify patch description, add Signed-off-by

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


