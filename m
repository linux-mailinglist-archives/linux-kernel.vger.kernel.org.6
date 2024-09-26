Return-Path: <linux-kernel+bounces-340060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710AC986E36
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1FB61C23ABF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2EB1A42D8;
	Thu, 26 Sep 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="TNGNeQQf"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4411A3BD1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337052; cv=none; b=JjzFaM6BsPH44pJfUNJm3Ar7cs322elNCReuIsnC/rrfLwiZEjHNARLq8bRQtNXTICzLvwpVK3NjjSVVGtPCarDFM5pt1pSb7x9uSDZ00hjrmiFFR1rU8RLLxRKt50t6uSKaN1u/tWVGK5ddGEIF1SjkhHQ5V/PHRTz5/0mSB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337052; c=relaxed/simple;
	bh=2E4YYhP95nxsUSCjxBm3gpcLSzEKy4vZL3Y5o1FLPJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB6cmSM5lORTiH76K/06dp6pUMz3opIe6CI7R3Ort1lDUkqX467FtG3/T6D86II/oH07rfYhbNUL63w+12c3nwabnjA311jK/Nfw0WVNSOtFo1SVaGZAytomvSTsm6EKiuSXDWSqx44cYIO2bYDTdUQ1cgjPld4fcMsN4M86XCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=TNGNeQQf reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pi+QFeWgKpk+/I68ogVRXcsOGmQVhBx1Tx/8xnU0Dqk=;
  b=TNGNeQQf/PP4bn1p6KTPEFs8B2JMXtPNw+qK1yNaVng3LEojF/uhJzo7
   bNw8pTt7PM6lFDZGHu9MbaKY7iTzN8ddadNtxhPRBzfmsEAWgWjio2rIq
   TdKHa9BImIvxCJu5AxpJvFWp1+v5KiXL0VpkQ4lBQqx5syd1phdyGN4w7
   HNSTFCQvxeU4k5y3Jz1Ve/vxtPIQsNsE8rddEw5FWLTI11PiAqdRM6mi8
   HSHSZk44kTo27qKKF/HqWtNzWvke6EB3tA9MtJpOkNY6Ruqn3DFdZX2xU
   nZ7Gef74wJB94OIgL2vb7Nvol3XEjfG6Z9UCN3LmJdvYGeV02R+vcY2xO
   Q==;
X-CSE-ConnectionGUID: qvw8ssHbTxOTe8c7N5IFpg==
X-CSE-MsgGUID: mHTnMsGdS/6YJDX4IjdxpQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:50:42 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7ocuP044816;
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
        Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen
	<allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 06/11] drm/bridge: it6505: fix HDCP Bstatus check.
Date: Thu, 26 Sep 2024 15:50:15 +0800
Message-ID: <20240926075018.22328-2-Hermes.Wu@ite.com.tw>
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
	1E2CC0F2EB62D09B0282AE46C73472B56B4DF3E7C203867C6794392B923BEB652002:8
X-MAIL:mse.ite.com.tw 48Q7ocuP044816

From: Hermes Wu <Hermes.wu@ite.com.tw>

When HDCP is activated, A DisplayPort source receives CP_IRQ from the
sink shall check Bstatus from DPCD and process the corresponding value.


Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 5d5ce12cd054..d2ec3dfc57d6 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2322,14 +2322,20 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 	DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector = 0x%02x", dp_irq_vector);
 
 	if (dp_irq_vector & DP_CP_IRQ) {
-		it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
-				HDCP_TRIGGER_CPIRQ);
-
 		bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
 		if (bstatus < 0)
 			return bstatus;
 
 		DRM_DEV_DEBUG_DRIVER(dev, "Bstatus = 0x%02x", bstatus);
+
+		/*check BSTATUS when recive CP_IRQ */
+		if (bstatus & DP_BSTATUS_R0_PRIME_READY &&
+		    it6505->hdcp_status == HDCP_AUTH_GOING)
+			it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
+					HDCP_TRIGGER_CPIRQ);
+		else if (bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_LINK_FAILURE) &&
+			 it6505->hdcp_status == HDCP_AUTH_DONE)
+			it6505_start_hdcp(it6505);
 	}
 
 	ret = drm_dp_dpcd_read_link_status(&it6505->aux, link_status);
-- 
2.34.1


