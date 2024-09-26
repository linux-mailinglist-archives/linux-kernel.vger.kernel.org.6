Return-Path: <linux-kernel+bounces-340066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FA0986E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80DE1C2481B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155A1A3BC0;
	Thu, 26 Sep 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="asfD+vFa"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BCE1422D4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337116; cv=none; b=gC58Hlyv9QzMp3fqWMUivjj/UWEEzFybHBVgMec+hkXvGOwN5EYSAf+wEcibDxRq1c7riWBnXlgmGx51ZcFk2LxILtc+sg1R+u/5QsrBZNCOZEmgCdj5eq+I+3FVI4FfuqA/Zce8LirtIbQiU6OBA91/DLmVW/O4GkLy1JusqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337116; c=relaxed/simple;
	bh=3BQHpJou4Y9veuk4r7ceqOcoXwJUD+5cm2YWPl/prkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tItrDwZOGpnYkBF/ZFR3FmcSFcPkaOljj8cB3oQz/EVtItYxk6Aleq01JcnpqoZsFapxbloIAXyp9RTLtuv2kfGZUHVJZydtdM1naLNIPBYOVRq11fuqNxxDQdx9KICTyb86q/EpHQIAO3gpavHbhasrKNupPdO1D2QvClWi4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=asfD+vFa reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zrwVDjPIwKWx8PST3o8tOiny0kwm1JgvIxdDZmxFFbU=;
  b=asfD+vFaMJisSEf8FYPuLc14WC1njwDz1FHA3Xw4Fq6Tg+MpwnFVCQzz
   iirPkrrqRU0fX1ZuVly35oGfz6ff/onrau+v1LYoo2/OmzNrElgNS2oSY
   sy46WcvWhNmiIxAlWU8Zg90heRtzX0Kebx6AWwjSjuLk+RQoZLkHan/B2
   WqtzD+cmpCPLig7QGDNtoU34WAiAa06/9qfstGkuXR7XA+0Zx60K5HpfG
   /XotfC8AwtJ7CIheEczLrgUg4r1W2SKpEqM+/eQM1smmRoEJeZa5YHS1E
   rAaTCLDWodO9NQCeeV+Na2siWwPqVzI44I59Teh6l/w+iSzoQykTflh5n
   Q==;
X-CSE-ConnectionGUID: EALjjDOoTxC+7L80wk1IbQ==
X-CSE-MsgGUID: n2NBaRynTN61+suJEW9SEA==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:51:52 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7pnLM046831;
	Thu, 26 Sep 2024 15:51:49 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:51:49 +0800
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
Subject: [PATCH v4 10/11] drm/bridge: it6505: fix HDCP CTS ksv wait timer
Date: Thu, 26 Sep 2024 15:51:33 +0800
Message-ID: <20240926075134.22394-1-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
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
	BCAD1B799F795BD18B91676EA5CCCD6438D6A0284857668DAB9A24287FB284C92002:8
X-MAIL:mse.ite.com.tw 48Q7pnLM046831

From: Hermes Wu <Hermes.wu@ite.com.tw>

When running the HDCP CTS test on UNIGRAF DPR-100.
HDCP must disabled after waiting KSV for 5s.
Consider system ksv work schedules. The original timer has a chance to expire.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index e75bc1575aa8..22d9bec3faea 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2093,7 +2093,8 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     hdcp_wait_ksv_list);
 	struct device *dev = it6505->dev;
-	unsigned int timeout = 5000;
+	/* 1B-04 fail, wait to long to Stop encription(5s->3s). */
+	unsigned int timeout = 3000;
 	u8 bstatus = 0;
 	bool ksv_list_check;
 
-- 
2.34.1


