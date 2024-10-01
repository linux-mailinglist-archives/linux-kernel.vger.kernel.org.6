Return-Path: <linux-kernel+bounces-345328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964798B4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7BB6B2416B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9AD1BD50B;
	Tue,  1 Oct 2024 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="KSbM+m86"
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A81BD000
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.251.196.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765037; cv=none; b=oFmLCQI+aVOigvA12+WxpuGiM0iW4Lh/Zkta2oVAFItuGj3c3Gguq3B/nvLqFhl4HXmErSQBu8mTkmGoovwz/UbstuoBRlN8v9K0pF6sACXMz1fXTYEjvKlAQ6tv4Rb3DJUMvidfwQpPMpFDWYY/4x5OaC8S6sDnelvE8JcU/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765037; c=relaxed/simple;
	bh=lMt89tGOkvlLMAljKS0YGSulqFlslgukLbqfilHmuqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exQr4HeIInoq+UeU9VnpNwiVJsmAwkxQaHZlCGhS2gG34WqHIbSNnC+tWh0PPFAXpHxU7VbbvrTnlrR/9Jrb1dI/oLy9DXf1JV/adz27TNmEYF74LKXUqd9hUgfwBr9wLr1KZSTAKx24UzNWV1XINfeIUkbJkJv/fvE5MaMLGXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=KSbM+m86 reason="key not found in DNS"; arc=none smtp.client-ip=60.251.196.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4GaxJkwGXmvDnQAw3XxW8Th1ipHzWdX1WJyveeRbO4=;
  b=KSbM+m86MSEhzovDJBVR0XgRa9t71jiRx2YKTGRJLsJ/TXaJy+BkGXyd
   hy8iMoEUdpuWRKbzFmhygsYmrekTzZSON++YlwOrBkqyIbtDPRYxORYwC
   faA0LDaMJziqX1wgx+5dSle3neYF8D3y+hBji+sWutpGyohRc3aMNObbj
   I1KV5Oatk5JuA0SrZFqo9oPym9XdpXZO9naaI2topEaoyuWUA27AAIAc8
   bcaoorwhYynZUGriIEP8lLQ5XBAASBnQX1d9pRGNXIPN/ap2CaMU+mNtU
   gwOC2oZvznNFgyzac/7DNzAOOD9/l6RCREOBHoCOUMWe3+uX3giI+UdjS
   w==;
X-CSE-ConnectionGUID: aht/0++cSzi5xisY2jlWlQ==
X-CSE-MsgGUID: zZKhHuDoRASG/e7XnFRePQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 01 Oct 2024 14:43:44 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 4916hdSL044739;
	Tue, 1 Oct 2024 14:43:39 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 14:43:38 +0800
From: Hermes Wu <Hermes.Wu@ite.com.tw>
To: Pin-yen Lin <treapking@chromium.org>
CC: Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>,
        Hermes Wu <Hermes.wu@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Hermes Wu
	<hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Allen Chen
	<allen.chen@ite.com.tw>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 01/10] drm/bridge: it6505: Change definition of AUX_FIFO_MAX_SIZE
Date: Tue, 1 Oct 2024 14:43:00 +0800
Message-ID: <20241001064305.32180-2-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
References: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
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
	BAB9C0F91AF68659C02FC92D04E49AF60055E75FE2A9C17FDA28D8A4B90B33202002:8
X-MAIL:mse.ite.com.tw 4916hdSL044739

From: Hermes Wu <Hermes.wu@ite.com.tw>

The hardware AUX FIFO is 16 bytes
Change definition of AUX_FIFO_MAX_SIZE to 16

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index f372c05360f2..28a8043229d3 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -300,7 +300,7 @@
 #define MAX_CR_LEVEL 0x03
 #define MAX_EQ_LEVEL 0x03
 #define AUX_WAIT_TIMEOUT_MS 15
-#define AUX_FIFO_MAX_SIZE 32
+#define AUX_FIFO_MAX_SIZE 16
 #define PIXEL_CLK_DELAY 1
 #define PIXEL_CLK_INVERSE 0
 #define ADJUST_PHASE_THRESHOLD 80000
-- 
2.34.1


