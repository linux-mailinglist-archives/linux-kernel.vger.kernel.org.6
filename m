Return-Path: <linux-kernel+bounces-340059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE9D986E35
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2442528637B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23F1A3BC1;
	Thu, 26 Sep 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="Q69UuyHn"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446B1A3BB9
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337051; cv=none; b=HElNu2r3euqOA5tOdcHnkmV7Nfa0xUekXr+fS8lxsBGYIdohjW1sq89xTdWd3aYCcHISEKfpBhnP3g8vTPrGZsd44U+PeJzSZm8HAtxXbHpKrlA3APGetwi0JgMZm3eTqjh108oCzHPux48ei1SRj0GoM289d6wcYvMQ8MjN1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337051; c=relaxed/simple;
	bh=sW1CnOFJ2b26JnyH/6mh3GR16HS3q9peW75ZgnJJWs8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eUc3ERG32gC3wkE2b/STREgb18Dmxjq7vpUx1raUxinuZBEibrRH9OqK6Ef4e6f1kcRZ86/L3TNzqHoRfvodxoZM6XQqm+daydu4fJt5hB25azm4c9mQGwogwoDc5EQa0OcjAxnmtaV2T5lkcLF0WYSXvNmfwi6650o7qArIKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=Q69UuyHn reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/MhsEBOD2/Qogtg45F1mT6RHWB7u2J8P93IBSo1/Tok=;
  b=Q69UuyHnD2IDo8vtQ/OD2Cyq3UJlik3jMuedhrw0MBj1nMpsKL6Ep4ow
   /Lod+W1hT+gpGy329bJcvxfJb8K/xvnNGiSuYhDyHUaogcZfIjLxZgSYY
   gANPfv2Htbho82JzIM7zJxx9L0PycP+/Km1MomQbfJ0iMKq/5qNNcmLWO
   meAfbjd7HluVsxquKCYolXStFSnUvZYWqFSnM+AFHbFWTdAlKRpzSYoQQ
   xULZ3JwMA12FC1QpvMMh7l3ZOyAcIeubUL0xN8TU9nR6PzIMTmYhMGnxs
   DcRAVQC5YW8x9T4SLh9JmWgQvEnrbq+rKwJEzEPoHMeIAGFCo86dFch6c
   w==;
X-CSE-ConnectionGUID: Nll7VDqNQ7eWttAhJ8buvQ==
X-CSE-MsgGUID: 060e/ZYdRpSraTD221/REw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:50:42 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7obPR044815;
	Thu, 26 Sep 2024 15:50:37 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:50:37 +0800
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
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Hermes
 Wu <hermes.wu@ite.com.tw>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 05/11] drm/bridge: it6505: increase supports of HDCP repeater ksv devices
Date: Thu, 26 Sep 2024 15:50:14 +0800
Message-ID: <20240926075018.22328-1-Hermes.Wu@ite.com.tw>
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
	EF65523E155F9F62D73D22204B3A2FFE016E29029054F7626C7FB58BD1C9ECA82002:8
X-MAIL:mse.ite.com.tw 48Q7obPR044815

From: Hermes Wu <Hermes.wu@ite.com.tw>

A HDCP source shall support max downstream device to 127.

Change definition of MAX_HDCP_DOWN_STREAM_COUNT to 127

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index d1f5220e04a6..5d5ce12cd054 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -296,7 +296,7 @@
 #define MAX_LANE_COUNT 4
 #define MAX_LINK_RATE HBR
 #define AUTO_TRAIN_RETRY 3
-#define MAX_HDCP_DOWN_STREAM_COUNT 10
+#define MAX_HDCP_DOWN_STREAM_COUNT 127
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-- 
2.34.1


