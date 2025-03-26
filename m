Return-Path: <linux-kernel+bounces-576511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31ABA7102E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3551716F8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41718A95A;
	Wed, 26 Mar 2025 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxMwDDaB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F12E3361
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742967221; cv=none; b=Fc3Yedma8+iP5QUTyzU8dOvnPskn+r98oy/sttplSrnI3sizcVt/FewsnTzopt0fAxJQn0cIaypzzT6SJ5pfcwNhbUhg2Xvc1HiW7hSA+FN2uZ1H1ig0wJFVGJLA/IKsBeAhNxyrO/FNaQQrLhJuG7oUqg7x6GfrOnOs2WxIy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742967221; c=relaxed/simple;
	bh=kHtdah/7J9+lICAdEY2QWLUviTDD9x2Pk07Ly2lVO0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fPjK1BuWRU3TAxenqjbl3gCYl1IwG7aeBiTcL2cY4Jm2P43xsql1H79MAtdEKVn/DWbSOBBYBTO/WfAeE6t5tFr6vDCOmDmW1i7I0cFKf59sxVmjxz8/aIZWnQ1rVbyKZJl46QMPZXryQBIaPw4PML/fKbCn1PpfFue2pWAlM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxMwDDaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68743C4CEF4;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742967220;
	bh=kHtdah/7J9+lICAdEY2QWLUviTDD9x2Pk07Ly2lVO0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YxMwDDaBa2uTUf0RGPlnM5r7kaIhnRLdN0qAtbTs8F/7J5IG89oZJEUAv7mLucsF3
	 83vCzmM7nD7C7xWN85jZ8e7ZQZkxBhSLRZd/4lw9eEDc4BK6yMkcSa+SSyySsFhlYq
	 8h6yQeyBzpNL/UKiILebz8Mdj9VYrI5LZHtPQOYp62xFdE1A0DApeWNzB6PC0X5Bgl
	 SF8wrDOVGZTxIL2+6+lIgJGf43krypfkL3Q5n0/dI3uYp45hCpSAbdyrAfxHGOIiL9
	 /79iTYYJ+mRkl3vlGiAYRh3RTZoDsNL1a9KHDzR6UMrCe6NnujwLBLkD6ylHxgOUAv
	 SL7h/Fd7N9ToQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB1C36011;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Wed, 26 Mar 2025 13:34:16 +0800
Subject: [PATCH v2 4/5] drm/bridge: it6505: modify DP link training work
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-fix-link-training-v2-4-756c8306f500@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742967277; l=4425;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=hBOJBY2XTkl+EvP8IZiH3XQVQvr/2YIKA/X+KvsSbUs=;
 b=NEFSW1BW80J6hUzk8TcL4jl7RHa78HiGxL9aafQiv5H6/4IqePGWxWSd+6Snj1mnjqFhGoAgT
 cSiuTvwgHUUASFGKotq47YHf6z/WzQCp9x6EQ9pwDlb4Op0w+sZvajX
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

The DP link training work include auto training and after
auto training failed "AUTO_TRAIN_RETRY" times, it switch to
step training mode.

It will more efficiency that finish link auto training,
include retry, and step training in a work, rather than
re-schedule train work when each training fail.

Drop auto_train_retry from it6505 structure,
and it6505_dump() is remove from link trainig work,
it takes too much time to read all register area,
and is not necessary.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 40 ++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index e0e13e737763fb801fd1cd803734a0d6ae1dd812..2bbe787ccb1b57906f2a31a011dd92f327019b08 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -467,7 +467,6 @@ struct it6505 {
 	struct delayed_work hdcp_work;
 	struct work_struct hdcp_wait_ksv_list;
 	struct completion extcon_completion;
-	u8 auto_train_retry;
 	bool hdcp_desired;
 	bool is_repeater;
 	u8 hdcp_down_stream_count;
@@ -666,7 +665,7 @@ static int it6505_get_dpcd(struct it6505 *it6505, int offset, u8 *dpcd, int num)
 	return 0;
 }
 
-static void it6505_dump(struct it6505 *it6505)
+static void __maybe_unused it6505_dump(struct it6505 *it6505)
 {
 	unsigned int i, j;
 	u8 regs[16];
@@ -1399,7 +1398,6 @@ static void it6505_variable_config(struct it6505 *it6505)
 	it6505->lane_count = MAX_LANE_COUNT;
 	it6505->link_state = LINK_IDLE;
 	it6505->hdcp_desired = HDCP_DESIRED;
-	it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 	it6505->audio.select = AUDIO_SELECT;
 	it6505->audio.sample_rate = AUDIO_SAMPLE_RATE;
 	it6505->audio.channel_count = AUDIO_CHANNEL_COUNT;
@@ -2472,7 +2470,7 @@ static void it6505_link_training_work(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505, link_works);
 	struct device *dev = it6505->dev;
-	int ret;
+	int ret, retry;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
 			     it6505->sink_count);
@@ -2480,27 +2478,22 @@ static void it6505_link_training_work(struct work_struct *work)
 	if (!it6505_get_sink_hpd_status(it6505))
 		return;
 
-	it6505_link_training_setup(it6505);
-	it6505_reset_hdcp(it6505);
-	it6505_aux_reset(it6505);
-
-	if (it6505->auto_train_retry < 1) {
-		it6505_link_step_train_process(it6505);
-		return;
-	}
-
-	ret = it6505_link_start_auto_train(it6505);
-	DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
-			     ret ? "pass" : "failed", it6505->auto_train_retry);
+	for (retry = AUTO_TRAIN_RETRY; retry > 0; retry--) {
+		it6505_link_training_setup(it6505);
+		it6505_reset_hdcp(it6505);
+		it6505_aux_reset(it6505);
 
-	if (ret) {
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-		it6505_link_train_ok(it6505);
-	} else {
-		it6505->auto_train_retry--;
-		it6505_dump(it6505);
+		ret = it6505_link_start_auto_train(it6505);
+		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s,",
+				     ret ? "pass" : "failed");
+		if (ret) {
+			it6505_link_train_ok(it6505);
+			return;
+		}
 	}
 
+	/*After HW auto training fail, try link training step by step*/
+	it6505_link_step_train_process(it6505);
 }
 
 static void it6505_plugged_status_to_codec(struct it6505 *it6505)
@@ -2581,7 +2574,6 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
 			     (int)ARRAY_SIZE(link_status), link_status);
 
 	if (!drm_dp_channel_eq_ok(link_status, it6505->lane_count)) {
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 		it6505_video_reset(it6505);
 	}
 
@@ -2607,7 +2599,6 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 			it6505_variable_config(it6505);
 			it6505_parse_link_capabilities(it6505);
 		}
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 
 		it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
 					     DP_SET_POWER_D0);
@@ -2744,7 +2735,6 @@ static void it6505_irq_video_handler(struct it6505 *it6505, const int *int_statu
 			     (unsigned int *)int_status)) ||
 	    (it6505_test_bit(BIT_INT_VID_FIFO_ERROR,
 			     (unsigned int *)int_status))) {
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
 		flush_work(&it6505->link_works);
 		it6505_stop_hdcp(it6505);
 		it6505_video_reset(it6505);

-- 
2.34.1



