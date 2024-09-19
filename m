Return-Path: <linux-kernel+bounces-333453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1597C8D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D311F23C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189218893D;
	Thu, 19 Sep 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TNgS/I5M"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7138DD6
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747334; cv=none; b=hpkLNPLWPRXHRhvl3drWwjODFCTZsLU2ddXNMwC5YdivtVogGqq0TDyqvZECiifwVZZoDJaxgV4oGXQJta7WKghg/nOw8MC1ZvW/SdxVAzgytCTGiYrheUWT31mtZJ46pZ7JIGKozzXv6bs5X5VvETZAYbwipKN2iQU1cIMxx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747334; c=relaxed/simple;
	bh=r531HWlJ6rYxVUwGU7B5dyRowoYmcdAstECRw39fhQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EaIXMBDkC9kF0FSrlhis/Hgc0LHw5yrXsIVbq4R9O80GLA1vCuUIr08i7+VmOp7o59NS4GoZA8xYxgmc0/eh2n+VdtfJMky/Xepyw/jRJgU2WuKkmmtQiZxjhXSWaSQh/yHC2QImt1mkB7wcbvkVVegtkoFmf8V2VU1+ARJ1XXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TNgS/I5M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726747330;
	bh=r531HWlJ6rYxVUwGU7B5dyRowoYmcdAstECRw39fhQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=TNgS/I5MfsMkxjmqkDIb+LkWwGmu7LVrjplsagA1+NXFPBr3gaT163B1p5VlI+emZ
	 1gZWHY7JqlNJlAwvKVzRpeSCbOfkymKdlfcx/8BqTlQJFkEEhJXgnxRnJo8yGpZOkW
	 dk3kyPLAuC7R1uZT4K2l3cjPcyvlyVo385d+UMejyZQ5/hOrN1tUvAWAp19LMRW7h6
	 eGdN0GntBilV7CB+IRklQJg3P8J60KHtO6FBkjmrOdeIxM3jbPlLebdC53BxcNUnE1
	 1KOlv6OJ+EKX6xR6zWOBYrY4WvE+2T8HUFL6PU/aum1YuTOyA3wMMSkRphSzBwEor8
	 Na2gdaYvn69Dw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 61C4E17E12D3;
	Thu, 19 Sep 2024 14:02:10 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	gregkh@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] firmware: mtk-adsp-ipc: Switch to using dev_err_probe()
Date: Thu, 19 Sep 2024 14:02:08 +0200
Message-ID: <20240919120208.152987-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an error path that checks whether the return value is
-EPROBE_DEFER to decide whether to print the error message: that
is exactly open-coding dev_err_probe(), so, switch to that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/firmware/mtk-adsp-ipc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
index a762302978de..fdb083f42ebf 100644
--- a/drivers/firmware/mtk-adsp-ipc.c
+++ b/drivers/firmware/mtk-adsp-ipc.c
@@ -95,10 +95,9 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
 		adsp_chan->idx = i;
 		adsp_chan->ch = mbox_request_channel_byname(cl, adsp_mbox_ch_names[i]);
 		if (IS_ERR(adsp_chan->ch)) {
-			ret = PTR_ERR(adsp_chan->ch);
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
-					adsp_mbox_ch_names[i], ret);
+			ret = dev_err_probe(dev, PTR_ERR(adsp_chan->ch),
+					    "Failed to request mbox channel %s\n",
+					    adsp_mbox_ch_names[i]);
 
 			for (j = 0; j < i; j++) {
 				adsp_chan = &adsp_ipc->chans[j];
-- 
2.46.0


