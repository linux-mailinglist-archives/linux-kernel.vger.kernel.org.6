Return-Path: <linux-kernel+bounces-576509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A9AA71028
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E623B2185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DAC18A6BA;
	Wed, 26 Mar 2025 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXTLWbQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778CCA6F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742967221; cv=none; b=n7mgKtOy2jin3lfmHZp5FbrOggA+6y23gVomRndz+wKxiUErMZUSQcmVKmllBZa94mDOEuo5JpvbaAPMpNZ/oBh7KRl20xqcm6SwfJhvzZwTrilcfyOf2o3kciP+2ogVm4PCKX335nrhVNhox0i1/FphIbm4bofDtecS+qomERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742967221; c=relaxed/simple;
	bh=lyxU3J3tgj+XOoWNtnnGcdmy7uN8MZQxyZoClXZLkIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBaxwFWBHEUtnCn+Hxn/71ADPsUWPIydpiVn42cQZ7Z+apU/faIsjbmexkFB0oGP1immKekkjXcyyA7hnMwCRPCFYzOU6JzTBJPa8l01ISZjHloL4qEIk04RRGXN0BcND4E+suPJjQTnZaV2VLbRxDQfRrK2P99ylA/StqgbkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXTLWbQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51A25C4CEE8;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742967220;
	bh=lyxU3J3tgj+XOoWNtnnGcdmy7uN8MZQxyZoClXZLkIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XXTLWbQBdOmD7Gil9jwx9qPNXzk1V7yQU2r9CMzTtyFyg1eX7npfZtscwUalXplp9
	 iQ3eMxqTtfdcEDqSoS/1IOgRy9szyhEG35JmArzw9uQkySZKmjbxBXhB3NH1g+7HsE
	 P0qJ+zNEz8vS4Pbeq0TluHs+pzv/mLVmkAvTcncSykMm5RPlKdIKuqH/BrYa4qcgen
	 r+fsJvSoWTIuE9CquiHMIQMhDuD/u6HS4hSbAI3vf5O8ueZVubGnAyniNC52NfrGoJ
	 BRO1fvHPU2OGZUqBqDYdFE6B4Nh4u71Eb++4fsZ3bCE6XNMHePE/nb/3O9/sQsn4JN
	 ZXuK371TGRhGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB9C36008;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Wed, 26 Mar 2025 13:34:15 +0800
Subject: [PATCH v2 3/5] drm/bridge: it6505: modify DP link auto training
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-fix-link-training-v2-3-756c8306f500@ite.com.tw>
References: <20250326-fix-link-training-v2-0-756c8306f500@ite.com.tw>
In-Reply-To: <20250326-fix-link-training-v2-0-756c8306f500@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Hermes Wu <Hermes.wu@ite.com.tw>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742967277; l=3243;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=7J6H/GfrtlSBRUa1Zq4Q3BBQ6RF81ypZS5T9zoXdwKE=;
 b=UfbQwxcyZy4hSilSen89RuLoTEI0B1PbBkTVqkpw4L5U70/C+uiM8M8DVI+r7KAjrs9IY1oKo
 1lJ1gYcfrl9AWt+ukZN1cY0D8AiDDl7M97AWC67tt5AYteI2BGBhBIT
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

IT6505 supports HW link training which will write DPCD and check
training status automatically.

In the case that driver set link rate at 2.7G and HW fail to training,
it will change link configuration and try 1.65G. And this will cause
INT_VID_FIFO_ERROR triggered when link clock is changed.

When video error occurs, video logic is reset and link training restart,
this will cause endless auto link training.

Modify link auto training with disable INT_VID_FIFO_ERROR to avoid loop
and check INT_LINK_TRAIN_FAIL event to abort wait training done.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 38 +++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 0607f99446b37c82b41a376c2f4e10c7565d1b61..e0e13e737763fb801fd1cd803734a0d6ae1dd812 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1800,11 +1800,20 @@ static void it6505_link_training_setup(struct it6505 *it6505)
 
 static bool it6505_link_start_auto_train(struct it6505 *it6505)
 {
-	int timeout = 500, link_training_state;
+	int link_training_state;
 	bool state = false;
 	int int03;
+	struct device *dev = it6505->dev;
+	unsigned long timeout;
+
+	guard(mutex)(&it6505->aux_lock);
+	/* Disable FIFO error interrupt trigger  */
+	/* to prevent training fail loop issue   */
+	it6505_set_bits(it6505, INT_MASK_03, BIT(INT_VID_FIFO_ERROR), 0);
+
+	it6505_write(it6505, INT_STATUS_03,
+		     BIT(INT_LINK_TRAIN_FAIL) | BIT(INT_VID_FIFO_ERROR));
 
-	mutex_lock(&it6505->aux_lock);
 	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
 			FORCE_CR_DONE | FORCE_EQ_DONE, 0x00);
 	/* reset link state machine and re start training*/
@@ -1812,32 +1821,41 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 		     FORCE_RETRAIN | MANUAL_TRAIN);
 	it6505_write(it6505, REG_TRAIN_CTRL1, AUTO_TRAIN);
 
-	while (timeout > 0) {
+	timeout = jiffies + msecs_to_jiffies(100) + 1;
+	for (;;) {
 		usleep_range(1000, 2000);
 		link_training_state = it6505_read(it6505, REG_LINK_TRAIN_STS);
 		int03 = it6505_read(it6505, INT_STATUS_03);
 		if (int03 & BIT(INT_LINK_TRAIN_FAIL)) {
-			it6505_write(it6505, INT_STATUS_03,
-				     BIT(INT_LINK_TRAIN_FAIL));
-
 			DRM_DEV_DEBUG_DRIVER(dev,
 					     "INT_LINK_TRAIN_FAIL(%x)!",
 					      int03);
 
+			/* Ignore INT_VID_FIFO_ERROR when auto training fail*/
+			it6505_write(it6505, INT_STATUS_03,
+				     BIT(INT_LINK_TRAIN_FAIL) |
+				     BIT(INT_VID_FIFO_ERROR));
+
+			if (int03 & BIT(INT_VID_FIFO_ERROR))
+				DRM_DEV_DEBUG_DRIVER(dev,
+						     "video fifo error when training fail");
+
 			break;
 		}
 
 		if (link_training_state > 0 &&
 		    (link_training_state & LINK_STATE_NORP)) {
 			state = true;
-			goto unlock;
+			break;
 		}
 
-		timeout--;
+		if (time_after(jiffies, timeout))
+			break;
 	}
-unlock:
-	mutex_unlock(&it6505->aux_lock);
 
+	/* recover interrupt trigger*/
+	it6505_set_bits(it6505, INT_MASK_03,
+			BIT(INT_VID_FIFO_ERROR), BIT(INT_VID_FIFO_ERROR));
 	return state;
 }
 

-- 
2.34.1



