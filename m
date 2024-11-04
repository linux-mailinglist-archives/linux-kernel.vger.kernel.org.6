Return-Path: <linux-kernel+bounces-394272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E99BACCA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C36C280EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5F71AB507;
	Mon,  4 Nov 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9zvM+o3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895E18DF91
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702647; cv=none; b=hK+2wRMHqqTFrXB7543VT9h2kGYFU0PXHkKLK0ulv5Fg2Iv6o/Ns6815Ru5JSyr3CHR427ZXzbIwVSsZZnzYMgoTzILDJccZWGrHYwgPIQ2r3KL7P4fWZnQRWRLtqy/GonpmTdENVWuodlhqqYbug/SEciERg4AsfK5dFaHesQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702647; c=relaxed/simple;
	bh=v3lSQyy9gXzgX8M13zqUf14k/OSbA7fxqxLe1EaQEtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5tTWRCR6aCU3+F+ZzzSFJ8uOk0emwiFok/SqzemFNSmfanwOQuhnDuKkMSEEdj2TNO/+Ntq/LL4+HBwWJzlQzd2F0fYBJVRTAElNCJ6iHzg0pb/OHTR/XKezmmwWiYAGpH4Hi3vpOXxVhH0VhuYe3LHK297Vnwsh/lXIPyosck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9zvM+o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F1F6C4CED8;
	Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730702647;
	bh=v3lSQyy9gXzgX8M13zqUf14k/OSbA7fxqxLe1EaQEtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o9zvM+o3MizmY2tWs7o0RsHT2TrfH2wa9T6r4/7KiUZ62uZw/eW7Kt/6s71JhNBwg
	 3Go6Cc7J/DZ1WkY2+/RNetyLgwhHQD/FMbEtaXyP9y7xYXmVFlxLYoPG3oneSyzvnA
	 cGt2/HgYQlgegqoJjnw+14HIOEYxK5PDl+1xxU+4JeRqvdLJL2zSgv6f2aUEGESCPE
	 Wa/XpyM0pspFaB/neXe9OSPvRmJN9xvt9ARuueqoiOTxRGTUL6vkjAyGt6MkezoPXT
	 /z6bQqqq+qIZaXrdI8iQ4j5aim6c4AyukPKWUicNF7FRmN5G7g6TTjWCP7zDVHmABR
	 D85koxr9lgd+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06290D111B6;
	Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Mon, 04 Nov 2024 14:43:39 +0800
Subject: [PATCH v7 09/10] drm/bridge: it6505: fix HDCP CTS KSV list wait
 timer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-v7-upstream-v7-9-8b71fd0f1d2d@ite.com.tw>
References: <20241104-v7-upstream-v7-0-8b71fd0f1d2d@ite.com.tw>
In-Reply-To: <20241104-v7-upstream-v7-0-8b71fd0f1d2d@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hermes Wu <hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Pin-yen Lin <treapking@chromium.org>, 
 Kenneth Hung <Kenneth.Hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730702658; l=1723;
 i=Hermes.wu@ite.com.tw; s=20241101; h=from:subject:message-id;
 bh=QISr17OTE/349oMqfbcRg7gIss3cy8H02akOrW/SuWA=;
 b=5wclQJlV2oEcIDMwHjjZwt9btEgTeYh3Wif+2xLf+6CvQ7lDDmauVYlsnjLgZZYm0BKKS2TCE
 Ihk/KJGMEB3DSfV5wXpAHcvnaPrhxIUgyONBl/+GJs0b07iKDglElcm
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=FOYYbsP2Nlw6mjB3rLFYSLmAiENzj4AWQly5XTcDuMM=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241101 with
 auth_id=268
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

HDCP must disabled encryption and restart authentication after
waiting KSV for 5s.
The original method uses a counter in a waitting loop that may
wait much longer than it is supposed to.
Use time_after() for KSV wait timeout.

Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 2b8f208d1e17eebe3287ab0aa71180176dd0574e..83e2df618c97f8fe3e59789ffb810ce8639f96bb 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2096,12 +2096,13 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 	struct it6505 *it6505 = container_of(work, struct it6505,
 					     hdcp_wait_ksv_list);
 	struct device *dev = it6505->dev;
-	unsigned int timeout = 5000;
-	u8 bstatus = 0;
+	u8 bstatus;
 	bool ksv_list_check;
+	/* 1B-04 wait ksv list for 5s */
+	unsigned long timeout = jiffies +
+				msecs_to_jiffies(5000) + 1;
 
-	timeout /= 20;
-	while (timeout > 0) {
+	for (;;) {
 		if (!it6505_get_sink_hpd_status(it6505))
 			return;
 
@@ -2110,13 +2111,12 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
 		if (bstatus & DP_BSTATUS_READY)
 			break;
 
-		msleep(20);
-		timeout--;
-	}
+		if (time_after(jiffies, timeout)) {
+			DRM_DEV_DEBUG_DRIVER(dev, "KSV list wait timeout");
+			goto timeout;
+		}
 
-	if (timeout == 0) {
-		DRM_DEV_DEBUG_DRIVER(dev, "timeout and ksv list wait failed");
-		goto timeout;
+		msleep(20);
 	}
 
 	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);

-- 
2.34.1



