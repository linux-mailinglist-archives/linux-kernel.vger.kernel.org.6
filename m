Return-Path: <linux-kernel+bounces-340050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36189986E16
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5ED01F22DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B814F10E;
	Thu, 26 Sep 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="gAqoFEgH"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C318CC04
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336910; cv=none; b=JtTlfaSLJFv1pnDRPyvyeq3ys7wcLyhV+BkUaHpc/J4MBtiiBybJDMfxgIcTv4IrZEdhlq2XhRvVJSTmua8ut6abkO9Z6dCq8dYtN+Zkbn6pnU50yaeHGvSnMsztbRp0irDi7CYEYJUWJ52LEJtIka8FPGu0fZ8O4HG0JZSM6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336910; c=relaxed/simple;
	bh=wJF+s+2EGBD9x8hl2AW47QLrQfcV/6ht0oiT8TajY5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXVRajgAQcVuqAie6rxAoDi5i9pBlV6EXLj7fRLdgHZonD0T6y3tvNG5h1286ASLENBdRJbKQfPbZrxy797Zk0ZFvAYDB/IbI+bADrPd3piI1Wz+mHhgdpDHVlH8pLaYYx029wLRVZDmS1BdCUqU4NdDNJjZFxlPOJryGIgcURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=gAqoFEgH reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9wy6oeXKQX7StHiLFpt66e52YBrrEYLDdgs16DgEek=;
  b=gAqoFEgHvWlm66CBffdCHMCUgi9Igx/SoeG434Jbw+1IVD6c+CL7y27A
   tfcI/LIkqIpNo236/h3GzTJNy7jAyupqmBVxO9+c8S1xXesa2u9SZZx7m
   4yzCYNO3GgacPnHelqRITwJy39CPGC65I1hLvqj190cdWrbWeWwOW1gP0
   8hl6XzNpKlNNsfkUBVSN/+yigMlidrZiyu65195cKQxsHI5Ds/mbsO4GB
   TcVibFJ1V1St5dAqvfPFNBvWyIAxTYgkhTcP1hXIkhVfyOrcGYWZex45H
   RXq9NRK17+kuRIGiv27TJ/CAd31dTfuDz2adBljkyzTdTeXvV3TOm75t7
   g==;
X-CSE-ConnectionGUID: bzEVeNe1RcKaV4q3FI3k6w==
X-CSE-MsgGUID: 9KuovFHUTI6z46MVkanT4w==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:48:17 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7mDw1042910;
	Thu, 26 Sep 2024 15:48:13 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:48:12 +0800
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
        Allen Chen
	<allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>,
        "open list:DRM
 DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 01/11] drm/bridge: it6505: change aux max fifo size
Date: Thu, 26 Sep 2024 15:47:51 +0800
Message-ID: <20240926074755.22176-2-Hermes.Wu@ite.com.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
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
	5B6422415040F29640A03F5009CC7BCAA4786C444D41136DE96B06F9D2D240A12002:8
X-MAIL:mse.ite.com.tw 48Q7mDw1042910

From: Hermes Wu <Hermes.wu@ite.com.tw>

The hardware aux fifo is 16 byte

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


