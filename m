Return-Path: <linux-kernel+bounces-565732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF2FA66E47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C372189800D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403231F873E;
	Tue, 18 Mar 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0aaKevn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A81624DC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286695; cv=none; b=FdJ/uEIyOzt0MORn+QDPXljciVDGlDnAP6efN978bGxCNi0QRpaQaXW4ZqMW+8PX3jFfzJdEzjLkLj1U6dmBiHTHctuFwNmk3egNxIad5yQ6lWcpNJac6+qpWjRljT5gLlddR1MvlS4yQ8+8uWLdhlgH8fy/E5tlOjsEFFuaJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286695; c=relaxed/simple;
	bh=4mDtKJNOvXzo04STzoLEDzk08HuB8UCxRKC60TOOa6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQuIkyJNJRaouWhI8bG9XeDJEswQ13gWcRlm5Jz8HzH4NNQ/bN1bJisSgJ+YPZqfSYwH5biHnjuI3ztKPrwlS+AXWbAvD0P4TTmrLLYJi8x81TS15tlBd4SSYUWe9AoDO7xhrPTnqnNaEZuX/n6C+qVrJZrlnRiKAFRy+vZlbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0aaKevn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D82BC4CEF1;
	Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286695;
	bh=4mDtKJNOvXzo04STzoLEDzk08HuB8UCxRKC60TOOa6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g0aaKevndOGgmTPrOCkH6A525jePLzpUn9JUu/XrlcW6XDxWnp1uI4GYaqmJ0djh4
	 D+Ct5rg1OvVNkWZ+CY9YTRJrIkd2nbhXdH/0jlnfepLyxQpPve++reY25EKcpzOb/3
	 /7cTh81j0rozyFpblAjDPKW2yH9AhWopF/V14nS9CbaZOwI1ibXseewfgExyGnSTui
	 7gGDIfqYfwS9VY0mAzoVPECL5Fr2j3ruRANe5IDi22Q1Pum67IrZDqRuciBzzEwXur
	 H0ITFyzIZjo0EmM8NVKjLBbp/d/FyXqP4bFXz2W30ib1KsKoDG2g2+a1915HEbC5Rq
	 /7nSTT+LK7Y3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363A0C282EC;
	Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 18 Mar 2025 16:32:11 +0800
Subject: [PATCH RESEND 3/3] drm/bridge: it6505: skip auto training when
 previous try fail
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-link-training-v1-3-19266711142c@ite.com.tw>
References: <20250318-fix-link-training-v1-0-19266711142c@ite.com.tw>
In-Reply-To: <20250318-fix-link-training-v1-0-19266711142c@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742286741; l=2801;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=JH5TB+6KMos7mGcxiEmqDSjWU1p596CHLwJaILJm+RQ=;
 b=S+EhrMyfHzLB4Mdct6UqU7bM+Y2qISVqUnQwr80nBAMU4i/KCs+97Mi6zRZOUYC2PykGospSR
 d5a4ditZcaCCeIxWaHLnKpvwn7E4Vl3741Wcbed/9EEBtb/QeWh2ph9
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
 drivers/gpu/drm/bridge/ite-it6505.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 11231a642bbe185c4f36bf5f2a0b115fa056213b..730481a9446ff00a54ef70e86b4c28ff0a3f417e 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -468,6 +468,7 @@ struct it6505 {
 	struct work_struct hdcp_wait_ksv_list;
 	struct completion extcon_completion;
 	u8 auto_train_retry;
+	u8 step_train_only;
 	bool hdcp_desired;
 	bool is_repeater;
 	u8 hdcp_down_stream_count;
@@ -2459,11 +2460,13 @@ static void it6505_link_step_train_process(struct it6505 *it6505)
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
@@ -2479,21 +2482,23 @@ static void it6505_link_training_work(struct work_struct *work)
 
 	if (!it6505_get_sink_hpd_status(it6505))
 		return;
-
-	retry = it6505->auto_train_retry;
-	do {
-		it6505_link_training_setup(it6505);
-		it6505_reset_hdcp(it6505);
-		it6505_aux_reset(it6505);
-
-		ret = it6505_link_start_auto_train(it6505);
-		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
-			     ret ? "pass" : "failed", it6505->auto_train_retry);
-		if (ret) {
-			it6505_link_train_ok(it6505);
-			return;
-		}
-	} while (retry--);
+	/* skip auto training if previous auto train is fail*/
+	if (!it6505->step_train_only) {
+		retry = it6505->auto_train_retry;
+		do {
+			it6505_link_training_setup(it6505);
+			it6505_reset_hdcp(it6505);
+			it6505_aux_reset(it6505);
+
+			ret = it6505_link_start_auto_train(it6505);
+			DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
+				ret ? "pass" : "failed", it6505->auto_train_retry);
+			if (ret) {
+				it6505_link_train_ok(it6505);
+				return;
+			}
+		} while (retry--);
+	}
 
 	/*After HW auto training fail, try link training step by step*/
 	it6505_link_step_train_process(it6505);
@@ -2605,6 +2610,7 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 			it6505_parse_link_capabilities(it6505);
 		}
 		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
+		it6505->step_train_only = false;
 
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D0);

-- 
2.34.1



