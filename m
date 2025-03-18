Return-Path: <linux-kernel+bounces-565731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDCA66E44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B816C1897EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3511F585C;
	Tue, 18 Mar 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkboDAqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633842C0B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286695; cv=none; b=dI0zrIwRm6A6zaqpBG95zzYT1t1FCQ3fPFS4H8kanfRgXZzXTaqd8sYQdxqQ/29LGpZKFGYEOXG1Ini4scKuTd8ILypmwJwxFjaUhkGN/YTA3ZeUJecrstyVzkssuo2J46oTIqt7vz60nqZ5QzlJQTGu1wsOwMAGTzVFYFebLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286695; c=relaxed/simple;
	bh=XjpJATAQwVIRHRXGlMiNdqzLMiErwOFwlEhNbhbQjwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUdzCMnhLNIQ8XY15bjp9yaEsne8B3BHbskzJJksbrYuoyX19FZs7AmfxVsBT/a2evOlvJ1GvQ87i7f1D8Z1gaQ6o6zV2UvectuQZrp6CVn5Q7MCIsnBR0gwTJkSd3z6ldq9xJ9wXaTuHYbyzCXQ/86qHm11A5+DtF1528Ds6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkboDAqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2ECBDC4AF09;
	Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286695;
	bh=XjpJATAQwVIRHRXGlMiNdqzLMiErwOFwlEhNbhbQjwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qkboDAqKo4Yk5uH59l137jcKic9omJKMnWcHmXY4eiQyQTvI6/xtDITqpWeEjlCHr
	 c3AwW8xP/oWMGbLMAdJd0s5kDAaQ9zY68qNjXle8p8itatpbKL0WXUIMAlWY/IORmS
	 s8t0IJ5dVw25q1qdJG7fpGp79W6HwV0Hg60UVLoGuPVcYzvALCU10TuOcZMqqTyFwM
	 sezReDDglriBOwjMtk7c1aZ24gI2KtIb1DhPb83Q9/7ZuRPbNBBL/p4HgnEFphd07Z
	 qYhvDI2qh8FfseDWAprLnqU3t8TXaew8peeRbF/rUeJDHIT0arVXalxb/ZiYL2QlBZ
	 A1eIN2a5qcz3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EEC35FF9;
	Tue, 18 Mar 2025 08:31:35 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Tue, 18 Mar 2025 16:32:10 +0800
Subject: [PATCH RESEND 2/3] drm/bridge: it6505: modify DP link training
 work
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-fix-link-training-v1-2-19266711142c@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742286741; l=2681;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=llpaVHPsyMc2Qs3dtoETLe0MUHFLEKcOWtYQxLf0olo=;
 b=Nq9Cu/zN2QqLOmjzI7sVdCwUS49UGwJKAWpdxDlY+uVif3xPoNkBVNChSIDqb2xD/kYJQDNDu
 FP35pkdzHNfBEfx0TjlOAcbe7f5vyKx8dUi9/11VMsCuWWBMEcCt3Az
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

The DP link training work include auto training and after
auto training failed "auto_train_retry" times, it switch to
step training mode.

It will more efficiency that finish link auto training,
include retry, and step training in a work, rather than
re-schedule train work when each training fail.

it6505_dump() is remove from link trainig work, it takes too much
time to read all register area, and is not necessary.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index dc1179c8338e27866f6adda4ef8fb2950336221b..11231a642bbe185c4f36bf5f2a0b115fa056213b 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -666,7 +666,7 @@ static int it6505_get_dpcd(struct it6505 *it6505, int offset, u8 *dpcd, int num)
 	return 0;
 }
 
-static void it6505_dump(struct it6505 *it6505)
+static void __maybe_unused it6505_dump(struct it6505 *it6505)
 {
 	unsigned int i, j;
 	u8 regs[16];
@@ -2472,7 +2472,7 @@ static void it6505_link_training_work(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505, link_works);
 	struct device *dev = it6505->dev;
-	int ret;
+	int ret, retry;
 
 	DRM_DEV_DEBUG_DRIVER(dev, "it6505->sink_count: %d",
 			     it6505->sink_count);
@@ -2480,26 +2480,23 @@ static void it6505_link_training_work(struct work_struct *work)
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
+	retry = it6505->auto_train_retry;
+	do {
+		it6505_link_training_setup(it6505);
+		it6505_reset_hdcp(it6505);
+		it6505_aux_reset(it6505);
 
-	ret = it6505_link_start_auto_train(it6505);
-	DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
+		ret = it6505_link_start_auto_train(it6505);
+		DRM_DEV_DEBUG_DRIVER(dev, "auto train %s, auto_train_retry: %d",
 			     ret ? "pass" : "failed", it6505->auto_train_retry);
+		if (ret) {
+			it6505_link_train_ok(it6505);
+			return;
+		}
+	} while (retry--);
 
-	if (ret) {
-		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
-		it6505_link_train_ok(it6505);
-	} else {
-		it6505->auto_train_retry--;
-		it6505_dump(it6505);
-	}
+	/*After HW auto training fail, try link training step by step*/
+	it6505_link_step_train_process(it6505);
 
 }
 

-- 
2.34.1



