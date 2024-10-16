Return-Path: <linux-kernel+bounces-367509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E02D39A0341
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6062AB26931
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2511D359F;
	Wed, 16 Oct 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWge3eLO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000601D1724
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065253; cv=none; b=dKA1Gqjo0GfQxGO+cIi0GKdFpqi0YWIOn+Hzm7tKpRrMiE5lO+c4/lCdqe93QMianFposK1z2v+24/Pn8Gcir/2ja/Kk6ecrAe0FzMqIEBwzK7F8kXEniJqAFjiPre375eyXXn33cdbdMplDmsrNtucyHRjWRZSUPdBqSPHkDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065253; c=relaxed/simple;
	bh=Vb+2n+MAUfgAIp8TePUzygedx1r8RBKo1kmKaDIUJB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3rv155Ultf+9BDthN7sZpSFQsSbh70JLf/DX0vBMppmBQz94azrdSk6L+0G+JG7vmkQPOWgEwOaNG2F1e1FBhKNLpsrpgEyGxGs5FAl4UtMtZTbo+PbvfLvaYtteLw4UVQ38uAbTtMVmW0mIFruliZF7WCtOcP75RxlkZLNG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWge3eLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6DCEC4CED9;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065252;
	bh=Vb+2n+MAUfgAIp8TePUzygedx1r8RBKo1kmKaDIUJB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SWge3eLOBKqWEdzGtCGv23f56qRiQYCyMicx53kG1ueWm8hD2b1KZmEX64i5+r3MS
	 DkFIT7hgI5S34e1wym/NJ+40kuXJnFpzjg5hwQn8E4xaD89/zmB/HZ1Ul1t1sVdcWu
	 AH8mrYDLRk8+VE7LxjW+UN/MF9lID7LLx0m5EqogRZHo9Z/s25WVScXxqYeJQjg3FA
	 UjE95QYEqdmE5ODSLqU72QIonFRGCjZzxDaxKhd4JAO3jVqZXsBXvtCptElvgjcPnb
	 21UaFpHpa7pYT6rIkYXyrnFTibSnomzh6Ns4iWqp4hIp1lnoE8ecL/nzEstO8iYbak
	 vTCYbjnch2zkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9D7D20684;
	Wed, 16 Oct 2024 07:54:12 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Wed, 16 Oct 2024 15:54:18 +0800
Subject: [PATCH v6 06/10] drm/bridge: it6505: fix HDCP encryption when R0
 ready
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-upstream-v6-v6-6-4d93a0c46de1@ite.com.tw>
References: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
In-Reply-To: <20241016-upstream-v6-v6-0-4d93a0c46de1@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729065263; l=1834;
 i=Hermes.wu@ite.com.tw; s=20241016; h=from:subject:message-id;
 bh=qR/Gpw52l5zLkqw/wfFTDrG6OM+qapW0KVFY2MBecyA=;
 b=Hu13NgyYtDaKX6ChWU8xiKMrGhUKfKUtC61YZjDWNkCcgZEZQv1ifNETnsEi2C98ig6wUv0P6
 rCO2Xb7PtuSBqqA+fypGrs4anb/we3lrHybjNgXndbB6OQw0Jsjpysp
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=kV18uQEXox+1WccdQceCbMlJKN+BBNUk3N8VsoULcQ0=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241016 with
 auth_id=250
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When starting HDCP authentication, HDCP encryption should be enabled
when R0'is checked.

Change encryption enables time at R0' ready.
The hardware HDCP engine trigger is changed and the repeater KSV fails
will restart HDCP.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 65c17e53e05f3bc2a647474cba7d9d7e737f11b8..85626b49a048a1178676ed616130a522ca314152 100644
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



