Return-Path: <linux-kernel+bounces-256159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE9934A04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D6B1C22B9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FDA7D075;
	Thu, 18 Jul 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP6yYGun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC613B784
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291970; cv=none; b=nHqS2p+HIVPrNHRdpBkWeq4u2HnY5l4PWm9XvLsz+uDMgVSQ8SpImOIKDfwpNA/kAf5IVFot2ualdUQE2/Vv3xzhR7JTUFpQm/IQHRbuOHzeqMaGl0mfoWrhmKVyJWuiSz0AQDaFdApy7K2BsoWk45FMfHhz3gIuLv6MRnpsWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291970; c=relaxed/simple;
	bh=IkCKpGRcoNsDv8m1+yrQr3FUpbncEbNr7F7+noxanhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q26p5acQJuqwUxtj2Q7sqUIkRymnqMomMmcKuBKHco7/icMEYeFDkGWbc80TMA0QkSH/wIsw+VRti3z25PHNpGwSkADJ4Ib9VNFyeXIcaEC10m7MhYxJoGzkV62WQP4ACdQZCsY19zIu/RS8zBMKG78FlCoNt79NEsaqcyBaHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kP6yYGun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98BDBC116B1;
	Thu, 18 Jul 2024 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721291969;
	bh=IkCKpGRcoNsDv8m1+yrQr3FUpbncEbNr7F7+noxanhk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kP6yYGunJWNWH3w9gV1dkszZSP5nSjqGWJrcaSonP659/O3Ug/5fB2Dzy4M43fXU1
	 zXehiZz21aFHiRkwuLad54L9UQTCiLpUl+Lg5t276qrvrMfLtnujEFFix4HqryuZ0c
	 dN9sMFCLY5ZC2jkAebUQuzw1ezEZHig4TwxAUGQfD7iGerw20cybgkVfeFT+KszP4a
	 hr0XEaAh+xn5eZLECCoWMfjC4TPl93V3s15sK3zFuZaJicnsuUM0/CdPYRJl7wWux0
	 Lc2WaoUvrma5HUbqaWvg3yV3M8WuRbypIeDY+FwDqifvMuQT6rQJmuf7lUxXAaTZZY
	 1OClciHr9UyQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A218C3DA49;
	Thu, 18 Jul 2024 08:39:29 +0000 (UTC)
From: "Jason-JH.Lin via B4 Relay" <devnull+jason-jh.lin.mediatek.com@kernel.org>
Date: Thu, 18 Jul 2024 16:38:58 +0800
Subject: [PATCH v2] mailbox: mtk-cmdq: Move devm_mbox_controller_register()
 after devm_pm_runtime_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-mtk-cmdq-fixup-v2-1-f6bb3c052a60@mediatek.com>
X-B4-Tracking: v=1; b=H4sIAKHUmGYC/yWMQQ6CMBBFr2Jm7ZC2QAFX3sOwQBhlwLbYItEQ7
 m7F5fs/760QyDMFOB1W8LRwYGcjqOMB2r6xd0LuIoMSKhOFLNHMI7ame+KN368JM5EWlc4FVfo
 KUZo8xWMPXurIPYfZ+c/eX+Rv/ae0TGUutNKJylUpUOLQBGdx6JMH27OhjpuZxqR1Bupt274Qh
 S42qQAAAA==
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>, 
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721291968; l=4363;
 i=jason-jh.lin@mediatek.com; s=20240718; h=from:subject:message-id;
 bh=ygtphOut6HLHA8ydhy2hDmOMgR0COlbPJWasC/1Cw8I=;
 b=Ze2pqM8+jGwXQ+JzInd9tLbwpk0U8NnJOUu2mhDLnYXcTK9Iat2UjLUrVE3ZhkMSLzur2jUch
 fb7GXOkS/XeB8Kw3+dkHHWdN4XIn13qN8+l4YK18rZJKoXXYkRvhMVN
X-Developer-Key: i=jason-jh.lin@mediatek.com; a=ed25519;
 pk=7Hn+BnFBlPrluT5ks5tKVWb3f7O/bMBs6qEemVJwqOo=
X-Endpoint-Received: by B4 Relay for jason-jh.lin@mediatek.com/20240718
 with auth_id=187
X-Original-From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Reply-To: jason-jh.lin@mediatek.com

From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

When mtk-cmdq unbinds, a WARN_ON message with condition
pm_runtime_get_sync() < 0 occurs.

According to the call tracei below:
  cmdq_mbox_shutdown
  mbox_free_channel
  mbox_controller_unregister
  __devm_mbox_controller_unregister
  ...

The root cause can be deduced to be calling pm_runtime_get_sync() after
calling pm_runtime_disable() as observed below:
1. CMDQ driver uses devm_mbox_controller_register() in cmdq_probe()
   to bind the cmdq device to the mbox_controller, so
   devm_mbox_controller_unregister() will automatically unregister
   the device bound to the mailbox controller when the device-managed
   resource is removed. That means devm_mbox_controller_unregister()
   and cmdq_mbox_shoutdown() will be called after cmdq_remove().
2. CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
   devm_mbox_controller_register(), so that devm_pm_runtime_disable()
   will be called after cmdq_remove(), but before
   devm_mbox_controller_unregister().

To fix this problem, cmdq_probe() needs to move
devm_mbox_controller_register() after devm_pm_runtime_enable() to make
devm_pm_runtime_disable() be called after
devm_mbox_controller_unregister().

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
When mtk-cmdq unbinds, a WARN_ON message with condition
pm_runtime_get_sync() < 0 occurs.

According to the call tracei below:
  cmdq_mbox_shutdown
  mbox_free_channel
  mbox_controller_unregister
  __devm_mbox_controller_unregister
  ...

The root cause can be deduced to be calling pm_runtime_get_sync() after
calling pm_runtime_disable() as observed below:
1. CMDQ driver uses devm_mbox_controller_register() in cmdq_probe()
   to bind the cmdq device to the mbox_controller, so
   devm_mbox_controller_unregister() will automatically unregister
   the device bound to the mailbox controller when the device-managed
   resource is removed. That means devm_mbox_controller_unregister()
   and cmdq_mbox_shoutdown() will be called after cmdq_remove().
2. CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
   devm_mbox_controller_register(), so that devm_pm_runtime_disable()
   will be called after cmdq_remove(), but before
   devm_mbox_controller_unregister().

To fix this problem, cmdq_probe() needs to move
devm_mbox_controller_register() after devm_pm_runtime_enable() to make
devm_pm_runtime_disable() be called after
devm_mbox_controller_unregister().

Change-Id: I4f0e68eac5186fe8041ea2f16c8e852d52d71cb0
---
Changes in v2:
- Change to move the calling sequence of devm_mbox_controller_register()
  and devm_pm_runtime_enable().
- Link to v1: https://lore.kernel.org/r/20240613150626.25280-1-jason-jh.lin@mediatek.com
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index f1dfce9e27f5..002003c3970a 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -370,6 +370,8 @@ static void cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
+	devm_mbox_controller_unregister(&pdev->dev, &cmdq->mbox);
+
 	if (cmdq->pdata->sw_ddr_en)
 		cmdq_sw_ddr_enable(cmdq, false);
 
@@ -689,12 +691,6 @@ static int cmdq_probe(struct platform_device *pdev)
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
 	}
 
-	err = devm_mbox_controller_register(dev, &cmdq->mbox);
-	if (err < 0) {
-		dev_err(dev, "failed to register mailbox: %d\n", err);
-		return err;
-	}
-
 	platform_set_drvdata(pdev, cmdq);
 
 	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
@@ -722,6 +718,12 @@ static int cmdq_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(dev, CMDQ_MBOX_AUTOSUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
+	err = devm_mbox_controller_register(dev, &cmdq->mbox);
+	if (err < 0) {
+		dev_err(dev, "failed to register mailbox: %d\n", err);
+		return err;
+	}
+
 	return 0;
 }
 

---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240718-mtk-cmdq-fixup-40379650e96b

Best regards,
-- 
Jason-JH.Lin <jason-jh.lin@mediatek.com>



