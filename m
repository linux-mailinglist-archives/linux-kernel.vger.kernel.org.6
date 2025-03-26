Return-Path: <linux-kernel+bounces-576513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDCA71030
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDC718929AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE519ABD8;
	Wed, 26 Mar 2025 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/AFtXU/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B38161321
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742967221; cv=none; b=ds85cdXcZzDRutMOEYD6TafTpUZozi4pN3cZ/T6iut29EVN1jO1ln2CqTAcxK8J4QAq2RGQuoX9kpsCUWDciYc5yBUjDjTS4ljDBmx7BUL56eVqUDvNSS8UWu9SOVkLs0MaqjLmFv1XE2Oanj/eRE9PSyoeycUv54xplUDyaC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742967221; c=relaxed/simple;
	bh=Wy7WE6LuZZ6xBpl3FIbcxjqEGw2E3rBrzulxGhYwh9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+DzryS7jOGNlq8vLAMxvMKrdEzhl6+nlBf7/FLWAaSve6Tbk90vdUSwMnAH5M65L0fxKtVr2DPlOs+z/5G58VtuBR4miC/G25rv+/JNUjtoMsHk902reeQYQCR//PuOnz3gLhIATSD1Bpj7D7SBsEr9kRzuvWp3O6/ITrMvQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/AFtXU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78D91C4CEF6;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742967220;
	bh=Wy7WE6LuZZ6xBpl3FIbcxjqEGw2E3rBrzulxGhYwh9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X/AFtXU/fEdwZ3SAz85QW5q5KbM4UKU13WwZJgjr2WcCzAtCBXB6eIBLoQwFjDPkb
	 pF/jV/K5Phx++Rwmy+q5IrumHFP3UybFVO3OOgX6ropkKHppx16okhzm+4XnRu00Wh
	 Vnyl3HG4QM+1KW+Q/yU6H/0z6wy/Rm+2gCs6B6LERqdCOipyEc2OQbooteQMBXty8Q
	 ERFko5SdwX/XM6Rjj1AHv8rb/YIN6UqxbkgPhPCQ8hOMhmafZ9xBeWzC7enLbUKsU4
	 sWhrKQpaCNKV4vIs6hhda222V03B3bfnNkxBQvulwFoZ/6h0QfNt3UVODmK1RIAh83
	 OoQAKyRbRlxYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D812C3600D;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Wed, 26 Mar 2025 13:34:17 +0800
Subject: [PATCH v2 5/5] drm/bridge: it6505: skip auto training when
 previous try fail
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-fix-link-training-v2-5-756c8306f500@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742967277; l=2513;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=tiJ4RlbfopmJYWvIu2IM5fgKRrXTP6oin1aKAqqcppQ=;
 b=lCmQZ7iuZxv2BHsc/G9uHxkeG4Ex0zbCFP4cowt8AFQz9da00JgtJQPZbg6UilJ4erYIjhDtM
 jw25gSKiTxGBWX+I+9Cx0pHXc/+7y2VimoE+KSEaZMjbE9K2oeZbwxj
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

When connect to device which can only training done by
step training, skip auto training when link training restart,
usually happen when display resolution is changed.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 2bbe787ccb1b57906f2a31a011dd92f327019b08..47f8134df8b6f5c2172c6cfdbc91da8063993a05 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -467,6 +467,7 @@ struct it6505 {
 	struct delayed_work hdcp_work;
 	struct work_struct hdcp_wait_ksv_list;
 	struct completion extcon_completion;
+	u8 step_train_only;
 	bool hdcp_desired;
 	bool is_repeater;
 	u8 hdcp_down_stream_count;
@@ -2457,11 +2458,13 @@ static void it6505_link_step_train_process(struct it6505 *it6505)
 				     ret ? "pass" : "failed", i + 1);
 		if (ret) {
 			it6505_link_train_ok(it6505);
+			it6505->step_train_only = true;
 			return;
 		}
 	}
 
 	DRM_DEV_DEBUG_DRIVER(dev, "training fail");
+	it6505->step_train_only = false;
 	it6505->link_state = LINK_IDLE;
 	it6505_video_reset(it6505);
 }
@@ -2477,18 +2480,19 @@ static void it6505_link_training_work(struct work_struct *work)
 
 	if (!it6505_get_sink_hpd_status(it6505))
 		return;
-
-	for (retry = AUTO_TRAIN_RETRY; retry > 0; retry--) {
-		it6505_link_training_setup(it6505);
-		it6505_reset_hdcp(it6505);
-		it6505_aux_reset(it6505);
-
-		ret = it6505_link_start_auto_train(it6505);
-		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s,",
-				     ret ? "pass" : "failed");
-		if (ret) {
-			it6505_link_train_ok(it6505);
-			return;
+	if (!it6505->step_train_only) {
+		for (retry = AUTO_TRAIN_RETRY; retry > 0; retry--) {
+			it6505_link_training_setup(it6505);
+			it6505_reset_hdcp(it6505);
+			it6505_aux_reset(it6505);
+
+			ret = it6505_link_start_auto_train(it6505);
+			DRM_DEV_DEBUG_DRIVER(dev, "auto train %s,",
+					     ret ? "pass" : "failed");
+			if (ret) {
+				it6505_link_train_ok(it6505);
+				return;
+			}
 		}
 	}
 
@@ -2599,6 +2603,7 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 			it6505_variable_config(it6505);
 			it6505_parse_link_capabilities(it6505);
 		}
+		it6505->step_train_only = false;
 
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D0);

-- 
2.34.1



