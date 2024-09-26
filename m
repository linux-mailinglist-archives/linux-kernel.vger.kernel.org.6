Return-Path: <linux-kernel+bounces-340061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78F986E37
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA8B1F25B91
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC18C1A4B73;
	Thu, 26 Sep 2024 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="hyRhOUne"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A87192B91
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337053; cv=none; b=sVxBFX5AdziKsBoryB4VTzisZkbB/gz8/VVqTgGKmMLsSDaazeZIf6hv3AlFc1zAUptIDj+pUGva4H1OMWxJ9WhHv3NMyOwktLdAg8b7GelIe4GMXM/rep0I6RxtvbXRC1mgJ3F5Rl8X4ngrJjHVMazZJoIDkssh3VGfzY2vuQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337053; c=relaxed/simple;
	bh=rCEkrXcygtOiMg0wEqwWeSBJqip2eQhqWHPvkKTIKHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzrhZlFV3j5vq8eAm2BX++6a9DSoQD1smjq9BS7Q+/nN5qTxaZQhwWJJHbhoeKJJNKWqZTh2igpsFZHgI4b3CnMoi2cRTp8eFpIEaAKZtuxnJyRnVpAXs3T/My5XoPmhTVOb3axG7Bzkd+063hkBRnthrNtarjyoze1O0aew0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=hyRhOUne reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TL0RVCovDNNgxWowpAkzwVX4O27zCkE2i956LEsHuhA=;
  b=hyRhOUnetIMHOvyh4i6jBMNeKwk5ojr7YL3vGrp1bb1X2tKyjjO6EdiT
   hhNup0WIyp2Ir7tqTeWITtvASzJ+e1KDI+2dkBYoJWmq0z8SCnjkFB8Wz
   +D5KW7mAES8hsZ64yLap/4mYS+Qk911TwhyMvh3b1ZQrz34u2HZhAwe/g
   7vw/ePzpFDSbgYfLHFqU3qZZ5qN6+uEevhqqpYWYnOYSazHYfV+U5eHxJ
   n0n7BBXyaIouY5+LDOd1axlz9OANEerW1OtZrgPqpyo6aZ8gy48qr0QiZ
   ReYUE8a7KM4ZVNxpG8hjS8vWYSa2bw7aH6rXFVENah0cXl+w5jbOgUXMY
   w==;
X-CSE-ConnectionGUID: kWp+db1uQ1qBHpH0z7guFA==
X-CSE-MsgGUID: 3slr1Z9NTY+4Jt19DJ4+Ng==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:50:43 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7ocVs044817;
	Thu, 26 Sep 2024 15:50:38 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:50:38 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: hermes wu <Hermes.wu@ite.com.tw>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>,
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
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 07/11] drm/bridge: it6505: fix HDCP encription not enable when R0 ready
Date: Thu, 26 Sep 2024 15:50:16 +0800
Message-ID: <20240926075018.22328-3-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
References: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPEMAIL1.internal.ite.com.tw (192.168.15.58) To
 TPEMAIL1.internal.ite.com.tw (192.168.15.58)
X-TM-SNTS-SMTP:
	0EBEA4471AE5B0C61383775D94A830EAC1652369C823F42BDA0FD3BDEE6158032002:8
X-MAIL:mse.ite.com.tw 48Q7ocVs044817

From: Hermes Wu <Hermes.wu@ite.com.tw>

When starting HDCP authentication, HDCP encryption should be enabled on
the link when R0' is checked.

Change encryption enables time at R0' ready.
Hardware HDCP engine trigger changes repeater fail to restart flow.


Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index d2ec3dfc57d6..82986f28f653 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2091,15 +2091,12 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);
 	DRM_DEV_DEBUG_DRIVER(dev, "ksv list ready, ksv list check %s",
 			     ksv_list_check ? "pass" : "fail");
-	if (ksv_list_check) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-				HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
+	if (ksv_list_check)
 		return;
-	}
+
 timeout:
-	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL,
-			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL);
+	it6505_start_hdcp(it6505);
 }
 
 static void it6505_hdcp_work(struct work_struct *work)
@@ -2472,7 +2469,11 @@ static void it6505_irq_hdcp_ksv_check(struct it6505 *it6505)
 {
 	struct device *dev = it6505->dev;
 
-	DRM_DEV_DEBUG_DRIVER(dev, "HDCP event Interrupt");
+	DRM_DEV_DEBUG_DRIVER(dev, "HDCP repeater R0 event Interrupt");
+	/* 1B01 HDCP encription should start when R0 is ready*/
+	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
+			HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
+
 	schedule_work(&it6505->hdcp_wait_ksv_list);
 }
 
-- 
2.34.1


