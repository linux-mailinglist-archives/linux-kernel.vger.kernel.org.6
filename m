Return-Path: <linux-kernel+bounces-340053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28621986E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86571F22DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC141A42DA;
	Thu, 26 Sep 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="BMkQSlN2"
Received: from ironport.ite.com.tw (HC210-202-87-179.vdslpro.static.apol.com.tw [210.202.87.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32991A3AA3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.202.87.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336915; cv=none; b=Q9gyY/7uxSAeMDBw5QmNOLSjDiB8FV77Ag4aYWBX2ZASlaKT6f4jFZcioS430BRdfqcSs33iIGOAf4D7u9tYhY2eIbeVILHx+OOOwZsNm4O+OlklUsWbCQa/wFRN2MY1SdrkHHWk3NCI3Gz+ZrB/dktO0bv7Kdc1HjeNiqQ+j1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336915; c=relaxed/simple;
	bh=RnLhCgUJLc54wRnyts7yx48QQwfvHB056DH61qTYrzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIJdfGpsFHcXy+oI3SmbqXERpdliFK+gKwv4moS8U5RZ7J4O+D7clsW6Ne3IKUC150DGip/JbzMpoEhHcFX2N8f8KAWylLJajpffHm8Rd3osBih4wsnuBzmjZEtF4BmYlsDgUcXeDxeZ4v9QCQpz6vsb4na8sGh12x2zwJJzPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=fail (0-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=BMkQSlN2 reason="key not found in DNS"; arc=none smtp.client-ip=210.202.87.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ijDiBw7pXE/kYeGlF5Zmeunc5r3macGsFd6fqhWC56Q=;
  b=BMkQSlN26YwhkthgXEqqIBa9Y6GRPB737NHQ0919IdcFB6hudmjNja3u
   FpXAFSxZh20XgDr+4domwGYkJrzgbINDxU3rafiMXxjceDnRtlbFdGp//
   DLBnFfXeec+ZzMFDD9f9+wg4IfLoqIfMuC763aUtiT8CzqMpHAK5X9DkW
   LicJvP95od3xHvAmbOFV8ZphA5Xb3Sua8E0t0H+JyYx76xwTk7JfcIpjT
   BdjLrEjv36aVzmauLbquEdfaaUmCU2JbcECSGxsirW0057T4irV2+ocfl
   XItlZLLXyKptuWyznG8NGheSSLa5U7Vdw34Cr/yI5mC8xachVQH39++LZ
   Q==;
X-CSE-ConnectionGUID: dmXKpNvIQF6+pbVwgppX0g==
X-CSE-MsgGUID: lMeR4MaZRK6/wufTFTGGNQ==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 26 Sep 2024 15:48:21 +0800
Received: from tpemail1.internal.ite.com.tw (TPEMAIL1.internal.ite.com.tw [192.168.15.58])
	by mse.ite.com.tw with ESMTP id 48Q7mG0I042933;
	Thu, 26 Sep 2024 15:48:16 +0800 (GMT-8)
	(envelope-from Hermes.Wu@ite.com.tw)
Received: from LAPTOP-C4GM1L3U.localdomain (192.168.82.6) by
 TPEMAIL1.internal.ite.com.tw (192.168.15.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 15:48:15 +0800
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
Subject: [PATCH v4 04/11] drm/bridge: it6505: fix aux command write to aux operaction register
Date: Thu, 26 Sep 2024 15:47:54 +0800
Message-ID: <20240926074755.22176-5-Hermes.Wu@ite.com.tw>
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
	1BF483AF16F2451C787FAEA0B2DF3355A1826589CCA7A56C5E09E5698954C10E2002:8
X-MAIL:mse.ite.com.tw 48Q7mG0I042933

From: Hermes Wu <Hermes.wu@ite.com.tw>

The aux control register command is 4 bits LSB only, adding a MACRO to get
correct operaction command.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 0583abdca75f..d1f5220e04a6 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -329,6 +329,8 @@ enum aux_cmd_type {
 	CMD_AUX_GET_KSV_LIST = 0x10,
 };
 
+#define GET_AUX_CONTROL_CODE(cmd) ((cmd) & 0x0F)
+
 enum aux_cmd_reply {
 	REPLY_ACK,
 	REPLY_NACK,
@@ -1000,7 +1002,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 				  size);
 
 	/* Aux Fire */
-	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
+	it6505_write(it6505, REG_AUX_CMD_REQ, GET_AUX_CONTROL_CODE(cmd));
 
 	ret = it6505_aux_wait(it6505);
 	if (ret < 0)
-- 
2.34.1


