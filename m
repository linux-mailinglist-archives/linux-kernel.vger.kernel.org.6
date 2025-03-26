Return-Path: <linux-kernel+bounces-576510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D0A71029
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5A67A4453
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D9189B91;
	Wed, 26 Mar 2025 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd7mJaRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BDEED6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742967221; cv=none; b=Cjj2AF9Hes3NE9G6oe7uhRVog9INTuRJkmwb2xAnesp55J8WTlgaA6SqMkuet55paBDGdLLUbNEQPr1TIyINhH9ON+8SF0/q0HhejxvDFR3AEVimJqexu3Vtbt3ai2ZVtWjjxTzrytOPole94FNUmkvAhFGcoYgZ/fUt1RC+JFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742967221; c=relaxed/simple;
	bh=ZtkHl+byYB3jXFUMZpEX6J8Zkg1NiuvJsQL2tkaY504=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXK+XuUTTz5PplUUNhZS0hy/B6kermox0J43xRWXcKFSefXi2JvAevapqZGKURFabLRdh/GLtNm8FiMGM3IFM8LhHEdzH33WPCVzRvTsZK32kA5GBMYCL3SOuaNroVa7WNdpMcMRDgWXQyBMJScr2UzDrgkNriqo53uoxvM2J0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd7mJaRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F5EAC4CEED;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742967220;
	bh=ZtkHl+byYB3jXFUMZpEX6J8Zkg1NiuvJsQL2tkaY504=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fd7mJaRkk+1OuJkqrXeCV8v8YC2vIleN2nHIAUodmuF3EPgDiYAVrjsavRPz7hVwx
	 roEpIc8ZKIO3d6SczFhMjQneab5s3zJJ1yq/TIB2EOlbJHPWQxLbMW3ue9k0QaN/iF
	 G2a4KY1h/UPsVf2pG+4sCW/g1zlsIcDxtFoJp/9OHYx5ozyK8j1RXh0+N3ZOV1yDe9
	 KImsVTClKDQIhA0uaBdUKpp8+Q1U7N7qpQhOiGNqFZ+Z81KOthkUJg3w0qvI5kPe/y
	 oTXyWpchBxEnuApHWrzWsdKYICqiwIRM8nRfgSlIZZZ9V44mg108Q2Lm0ZUCH1IdJc
	 mJ4ALY99MIutg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F4C3600D;
	Wed, 26 Mar 2025 05:33:40 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Wed, 26 Mar 2025 13:34:13 +0800
Subject: [PATCH v2 1/5] drm/bridge: it6505: fix link training state HW
 register reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-fix-link-training-v2-1-756c8306f500@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742967277; l=1417;
 i=Hermes.wu@ite.com.tw; s=20241230; h=from:subject:message-id;
 bh=OPKp1zu9zQb8F0T0g3XsULli11ufIoTr8/+5pxJA4Ms=;
 b=fVQ4Yl7k7aszXn5kMllRwvUFeiv9cHjn5Uzo5eB3T6/HhKUoNRAwLaVs//fgI4xMDMhaNBCfR
 RlM35DmSu5jCqZnXvFVhjZadhD9oHlKaFrv/FwMKzNm5OLQNjpgLZtM
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=qho5Dawp2WWj9CGyjtJ6/Y10xH8odjRdS6SXDaDAerU=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241230 with
 auth_id=310
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

In order to reset HW link auto training state,
bits FORCE_RETRAIN and MANUAL_TRAIN at REG_TRAIN_CTRL1 must be set
at the same time.

Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 88ef76a37fe6accacdd343839ff2569b31b18ceb..b47042dc06bb1e1dfd92bc0dc6d69dc918a140ba 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1806,7 +1806,9 @@ static bool it6505_link_start_auto_train(struct it6505 *it6505)
 	mutex_lock(&it6505->aux_lock);
 	it6505_set_bits(it6505, REG_TRAIN_CTRL0,
 			FORCE_CR_DONE | FORCE_EQ_DONE, 0x00);
-	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN);
+	/* reset link state machine and re start training*/
+	it6505_write(it6505, REG_TRAIN_CTRL1,
+		     FORCE_RETRAIN | MANUAL_TRAIN);
 	it6505_write(it6505, REG_TRAIN_CTRL1, AUTO_TRAIN);
 
 	while (timeout > 0) {
@@ -2377,7 +2379,7 @@ static void it6505_stop_link_train(struct it6505 *it6505)
 {
 	it6505->link_state = LINK_IDLE;
 	cancel_work_sync(&it6505->link_works);
-	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN);
+	it6505_write(it6505, REG_TRAIN_CTRL1, FORCE_RETRAIN | MANUAL_TRAIN);
 }
 
 static void it6505_link_train_ok(struct it6505 *it6505)

-- 
2.34.1



