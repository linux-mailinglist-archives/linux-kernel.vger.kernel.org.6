Return-Path: <linux-kernel+bounces-222417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2391012C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C01C22FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481C1AB36C;
	Thu, 20 Jun 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C2HMPMDY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE61AAE24;
	Thu, 20 Jun 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878091; cv=none; b=PRR7r1rbhU2T9yCpFLReDSne9CmJ8VyJg2TVMki/ujzdPC62Z3dOzPEjMfQZFQFRV/kCLKKUd93aNA4KqbEfjPjyuNLWV/VwFZHfudzKf5k2f8gNuqzav7LlwVZly6wVrkEcG5x3DTZDLRlpLz4wOd5VjTbwIWQV/WopaacXhHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878091; c=relaxed/simple;
	bh=ShQWh8bzftJTk5vQIrat2XfQUBjG3sEAiV/WjU/elxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5zrMKjy8iat2Ym9lC3aoIoBBpCJR+JrdS0A5RkMFtbaLHJLyffomt2pNnVk54Ng0rzYBIfgkenSUdyMYNYiZ7tq+s+Yj5v+QiD9efFZ9HHrUJSJ7gWcN4K7Nrt9JDPgPbyG0tSYkKiYP0jwPbn3a0KwNOkGL6f1HH2sXwOOVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C2HMPMDY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718878087;
	bh=ShQWh8bzftJTk5vQIrat2XfQUBjG3sEAiV/WjU/elxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2HMPMDYVWcGq4PnV37zbmAF+xEMSeM1JJDsyy6MTm13uJQdDX6DxIhm5NRTlYTmP
	 /FukztWTTEajkuZYRD5GY8JiziXDIhKTLQlNy+PwIvnJH61PZUZR4n/g3ZJGF7D+Zf
	 WQQ7imfkObBRppAQYAsGwGPbHPmUz3Ma45O9nguyEdJXEl7hbKCibpTfieluNt67Dc
	 4Iv1hK0xUFvUGyZpfg6tz37WdVyTY6nCRzhrOXkf7IhZc2gKAPbrKvAmp7VVKiZx1V
	 kchRBPJvFtHZCY6RK11qtgAXxuP05p0olNt984jskAzWjihBkZAGbnMHkxwgMfQKRJ
	 3dM6Ef0eERang==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1AAE837821B5;
	Thu, 20 Jun 2024 10:08:07 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jassisinghbrar@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	houlong.wei@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 3/4] mailbox: mtk-cmdq: Dynamically allocate clk_bulk_data structure
Date: Thu, 20 Jun 2024 12:07:49 +0200
Message-ID: <20240620100750.1075790-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
References: <20240620100750.1075790-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the clock probing code uses devm_kasprintf(), there is
no more restriction on the number of GCEs: dynamically allocate
the clk_bulk_data clocks array to improve flexibility and also
to get a slight memory saving on platforms featuring only one
CMDQ mailbox (and consequently only one Global Command Engine).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index a3f57151a221..2a71a5400088 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -22,7 +22,6 @@
 
 #define CMDQ_OP_CODE_MASK		(0xff << CMDQ_OP_CODE_SHIFT)
 #define CMDQ_NUM_CMD(t)			(t->cmd_buf_size / CMDQ_INST_SIZE)
-#define CMDQ_GCE_NUM_MAX		(2)
 
 #define CMDQ_CURR_IRQ_STATUS		0x10
 #define CMDQ_SYNC_TOKEN_UPDATE		0x68
@@ -81,7 +80,7 @@ struct cmdq {
 	u32			irq_mask;
 	const struct gce_plat	*pdata;
 	struct cmdq_thread	*thread;
-	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
+	struct clk_bulk_data	*clocks;
 	bool			suspended;
 };
 
@@ -584,6 +583,11 @@ static int cmdq_get_clocks(struct device *dev, struct cmdq *cmdq)
 	struct device_node *node, *parent = dev->of_node->parent;
 	struct clk_bulk_data *clks;
 
+	cmdq->clocks = devm_kcalloc(dev, cmdq->pdata->gce_num,
+				    sizeof(cmdq->clocks), GFP_KERNEL);
+	if (!cmdq->clocks)
+		return -ENOMEM;
+
 	if (cmdq->pdata->gce_num == 1) {
 		clks = &cmdq->clocks[0];
 
-- 
2.45.2


