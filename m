Return-Path: <linux-kernel+bounces-394268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249639BACBA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C935282156
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C61418E372;
	Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq6V8Ihm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12218D62D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702646; cv=none; b=AmRbOUg+0dblhoo3HHgiB52jFPDBK5Bcv803ZeSBb25LPHBEnewmxhRUfok+JyXDcqiov6+hZmYqqcInH7BDgjgH4FhX8s9Fom9l8JJ+IiUEStWbZB2r1hxpCg750LL/8wTaVPMSk+BPQRUfPf9uvhqXuZW8UelO69fyeZMpqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702646; c=relaxed/simple;
	bh=jebMeVHnxHKhzdHUo8lgZOGGKX3f7GBIrJuL6SI9xIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cn0Ex39SaiWAtofQE4SsqjN0GSS766kUXwN9ETlQm8GzeeW4vsZpZpxCiIO9KkI5R88oLqGbkbzLnFR/ushTvYTU5avt6EJ9iuhpyewHJTjTlENyfx+h8ejsouzaZy03+0AWxZjXjf1dVXihMXypHHDltHrfwJ6Ry+B5cAEDYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq6V8Ihm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72464C4CED2;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730702646;
	bh=jebMeVHnxHKhzdHUo8lgZOGGKX3f7GBIrJuL6SI9xIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uq6V8IhmI/nfhDHJTGxnBU8TijQikYASs8X2pAL7ih2k6Q7hIbLxzdQsL0dyIgTDS
	 9UeJeEmRBESJC4/cdH7IIImeTCqaTDAFJlvsuQfTxyiog1GAmDURhWlNxceU1p/9T7
	 PYWBQiAJfOE9tfQiiDhnmmvjxIGI5tFlC7LALJ8aj2VZOII9Ve5N3eV9+MXeEYrbPW
	 X/L3yOzMyZ7I4UsT3cHmUpEMvmte2qmikhCb0ypYCaUxwLOoZOwrv6rUuAQWTbfZqA
	 eMnP101kB3adkoB0KuGTjUtOgx1V5/qnunfSiJeRgwD7jR+2B1RrQX1yF4eMM+8uZE
	 LqrmSIV000NUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD2D111B3;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Mon, 04 Nov 2024 14:43:33 +0800
Subject: [PATCH v7 03/10] drm/bridge: it6505: add AUX operation for HDCP
 KSV list read
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-v7-upstream-v7-3-8b71fd0f1d2d@ite.com.tw>
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
 Hermes Wu <Hermes.wu@ite.com.tw>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730702658; l=3615;
 i=Hermes.wu@ite.com.tw; s=20241101; h=from:subject:message-id;
 bh=Qm0Yg8xBTZewdPuvHcs5ADcGIPqmFgB/FG4kqG8Nqvw=;
 b=Vdbj/KgQsW9ht3RTek7Bd8aNOnnJVm2T9jt3MjZM46NOGiIyDqpfLlK8EFuVsq4rA9bmeyoGU
 jxJ8gg1DjsCDfP3qVKUAzyV9LOPZvUuOTLg3OaJ9MxUXvfwfeUPvyHu
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=FOYYbsP2Nlw6mjB3rLFYSLmAiENzj4AWQly5XTcDuMM=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241101 with
 auth_id=268
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <hermes.wu@ite.com.tw>

HDCP KSV list readback can choose to use AUX FIFO or
general data register.
For some DisplayPort devices, the KSV list must be read
in 5 byte boundaries.
The original AUX read command does not support these devices.

The AUX command operation control register "REG_AUX_CMD_REQ" uses b[3:0]
as AUX operacion control, and b[7:4] are status bits and read only.
To change KSV read operation uses "CMD_AUX_NATIVE_READ" from using
the data registers to using AUX FIFO.
The extended command "CMD_AUX_GET_KSV_LIST" is added as
"CMD_AUX_NATIVE_READ" with the 0x10 flag which selects AUX FIFO mode.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 9747d7ccf435d536da55c6a3ff79e504b7c724f0..ba37974967767a17b7025595f6864f057174efb9 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/bitfield.h>
 
 #include <crypto/hash.h>
 
@@ -126,6 +127,7 @@
 #define REG_AUX_OUT_DATA0 0x27
 
 #define REG_AUX_CMD_REQ 0x2B
+#define M_AUX_REQ_CMD 0x0F
 #define AUX_BUSY BIT(5)
 
 #define REG_AUX_DATA_0_7 0x2C
@@ -324,6 +326,9 @@ enum aux_cmd_type {
 	CMD_AUX_NATIVE_READ = 0x0,
 	CMD_AUX_NATIVE_WRITE = 0x5,
 	CMD_AUX_I2C_EDID_READ = 0xB,
+
+	/* KSV read with AUX FIFO extend from CMD_AUX_NATIVE_READ*/
+	CMD_AUX_GET_KSV_LIST = 0x10,
 };
 
 enum aux_cmd_reply {
@@ -965,7 +970,8 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
 
 aux_op_start:
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	/* HW AUX FIFO supports only EDID and DCPD KSV FIFO area */
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		/* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
 		size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
 		/* Enable AUX FIFO read back and clear FIFO */
@@ -996,7 +1002,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 				  size);
 
 	/* Aux Fire */
-	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
+	it6505_write(it6505, REG_AUX_CMD_REQ, FIELD_GET(M_AUX_REQ_CMD, cmd));
 
 	ret = it6505_aux_wait(it6505);
 	if (ret < 0)
@@ -1030,7 +1036,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 		goto aux_op_start;
 	}
 
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		for (i = 0; i < size; i++) {
 			ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
 			if (ret < 0)
@@ -1055,7 +1061,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
 	ret = i;
 
 aux_op_err:
-	if (cmd == CMD_AUX_I2C_EDID_READ) {
+	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
 		/* clear AUX FIFO */
 		it6505_set_bits(it6505, REG_AUX_CTRL,
 				AUX_EN_FIFO_READ | CLR_EDID_FIFO,
@@ -1076,7 +1082,8 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 				      size_t size, enum aux_cmd_reply *reply)
 {
 	int i, ret_size, ret = 0, request_size;
-	int fifo_max_size = (cmd == CMD_AUX_I2C_EDID_READ) ? AUX_FIFO_MAX_SIZE : 4;
+	int fifo_max_size = (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) ?
+						 AUX_FIFO_MAX_SIZE : 4;
 
 	mutex_lock(&it6505->aux_lock);
 	i = 0;

-- 
2.34.1



