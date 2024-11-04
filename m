Return-Path: <linux-kernel+bounces-394269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091FE9BACB8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB791F22230
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCED18E364;
	Mon,  4 Nov 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK9ZT56h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6D18D633
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702646; cv=none; b=FZozFxsnsv6lfttZraHZ4J++HXFmmeBxnq+nYPSftfhqfVabod5qta2tWPg2xQOeCjwgjreWs97eTBdFbdxo4iU5ALQrRVWGSPl/QXD8KEIN0kcJOJKHnPbkTpb1ajmWWGWLyzlAAU+xE1XW8SobAzDP7FJvj9wFVqFt94UTOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702646; c=relaxed/simple;
	bh=SuDEzxxGQ/ta1asAIHNz3x/IkkoMDrKwg/H261/ZP48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7/KCW4MI2xVJoBlQ2T0l9zgyJ+ErG77KnmG2SEtPoX3/W/3s3ylml3ujUW3atu+DKr4QKCnY9/ZRtOaxSrEJTdG0hxnvXKAFOx7rOxVzWcfodrbn5xvH7hl45r1PHxMMVVlNC5urp60CQ+LDHYprgg6SctLgBSsMo7jrauB9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK9ZT56h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6016DC4AF09;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730702646;
	bh=SuDEzxxGQ/ta1asAIHNz3x/IkkoMDrKwg/H261/ZP48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LK9ZT56hg8TncXc1GQZ/Ks5gEIfvy+KOH47qs1ktMVjcySWgr+dqkIHe7hg1MUhj2
	 uU55cFE18m5Q4tttbyZszu04b4+wheFJ8CH/5T+oenk7Te2jDvugAtnLhHJj2p0Bof
	 L+0NkIw9lp59wZmOgIgg26BJ486FFaDCY1Aekc3JEkub7EMEhWr8qnqSuM6Yg+VxRL
	 lFtPdrO9ZROz0jXxQEp5OT5TzItugFU9Wi0pswlmew0CwNBINq5YDS5hy/WN627DIa
	 8CJT1O6Ijsl2x7gtagZo3JZiMjEkQJWxTPBoCyeMykCOMaf/Yv5QZyfCN//EY0FGFs
	 fOh+6cuYUIysw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8E7D11185;
	Mon,  4 Nov 2024 06:44:06 +0000 (UTC)
From: Hermes Wu via B4 Relay <devnull+Hermes.wu.ite.com.tw@kernel.org>
Date: Mon, 04 Nov 2024 14:43:32 +0800
Subject: [PATCH v7 02/10] drm/bridge: it6505: improve AUX operation for
 edid read
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-v7-upstream-v7-2-8b71fd0f1d2d@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730702658; l=1532;
 i=Hermes.wu@ite.com.tw; s=20241101; h=from:subject:message-id;
 bh=32P1BrTFeT18E3yzyJHILz0Ri1zpfzlb6udBE3GEmSs=;
 b=jAs4ALalPFcT/no3nP40m25b5d4wCMZzy9ChzrGptppyfoD/zleahHwKaciyvSguICLiNee66
 CacZdXxGEfmA1sLto+u5wJqWVQ1m7IwfxlxbzcRJXLAO7j8jXEfUYg2
X-Developer-Key: i=Hermes.wu@ite.com.tw; a=ed25519;
 pk=FOYYbsP2Nlw6mjB3rLFYSLmAiENzj4AWQly5XTcDuMM=
X-Endpoint-Received: by B4 Relay for Hermes.wu@ite.com.tw/20241101 with
 auth_id=268
X-Original-From: Hermes Wu <Hermes.wu@ite.com.tw>
Reply-To: Hermes.wu@ite.com.tw

From: Hermes Wu <Hermes.wu@ite.com.tw>

The original AUX operation using data registers is limited to 4 bytes.
The AUX operation command CMD_AUX_I2C_EDID_READ uses AUX FIFO and
is capable of reading 16 bytes.
This improves the speed of EDID read.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 3272ca6951f2585f9592834869de23ac50ce41a4..9747d7ccf435d536da55c6a3ff79e504b7c724f0 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -1076,10 +1076,13 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 				      size_t size, enum aux_cmd_reply *reply)
 {
 	int i, ret_size, ret = 0, request_size;
+	int fifo_max_size = (cmd == CMD_AUX_I2C_EDID_READ) ? AUX_FIFO_MAX_SIZE : 4;
 
 	mutex_lock(&it6505->aux_lock);
-	for (i = 0; i < size; i += 4) {
-		request_size = min((int)size - i, 4);
+	i = 0;
+	do {
+		request_size = min_t(int, (int)size - i, fifo_max_size);
+
 		ret_size = it6505_aux_operation(it6505, cmd, address + i,
 						buffer + i, request_size,
 						reply);
@@ -1088,8 +1091,9 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
 			goto aux_op_err;
 		}
 
+		i += request_size;
 		ret += ret_size;
-	}
+	} while (i < size);
 
 aux_op_err:
 	mutex_unlock(&it6505->aux_lock);

-- 
2.34.1



