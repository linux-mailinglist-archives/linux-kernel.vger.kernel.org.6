Return-Path: <linux-kernel+bounces-382118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259E9B09AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AEA1C247BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E64187874;
	Fri, 25 Oct 2024 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="blFkic2y"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1D170854;
	Fri, 25 Oct 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873207; cv=none; b=ppQtLaQ9I9FthEJ7hpqfDrsBpgA6LvgzvrSlTxa8StgZX8ROYQcnzr9CUTxvGhWFC1c1x/XOxp9Ho+pgZ7/8WOYxuZrp5+/tX29ka4wBJpbxQ9Yo8S4IFIE/rAqP6AtQMXZKy8kodo3p4j2C86P8U6mCODPrr/8gdGO6LpYJOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873207; c=relaxed/simple;
	bh=TFd9jpYi7KDBUb4nJuv0TiRqmi2upfwJigTQQiB6ZoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjIPdHkxSrEU63tQiIE6NXNiAPKYciXs1axWzShNgNV4Xf5q2FNRRrmOGmzNEQnCkXwqaOKqOlTesLJktURiEpXEAfFvqS/ALfCtf0+/P4ZOzwEFNjYWGPxKBcGJO5zBtS4DE0DbDUf6s3+8NmpB2WrEnatJ8I2BryC86zv25NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=blFkic2y; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4MW1tag1Z3B144MW2tnfRZ; Fri, 25 Oct 2024 17:46:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729871179;
	bh=goXfP12NdyXqfEtjdmE+Sw+InXCrHTgSpMmeNxMM+70=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=blFkic2ynkTyXgIOuzF1e+2DLRxnlptZjw3hfUUlMsZDjYbwtNaUUBvLY8aXClf3w
	 dvOGERrp/7JvSSHsY7+oWbpY9ruJsc/+cJqM7JN/pN5G7TrkHM8YkRNW+KFPwq2om1
	 Nn9t8U8IsFIiQiIst/Y84jZbDKzoFQgA1ta+tilwnJPxgzIVNKlT712WTFBJSEfYTN
	 vATTdgSkMqyCfnHcB1vRJpI8ifHJHbyaR0S3NTU84T4O2poBrhRSl5uiRt/tCVqcIz
	 tXKeNEyqgCrm+iAx3JUIxI7Sgk8alMAso59xN6Oug3y7BB1VEo2XvH2QfBcE1NP8fK
	 UdA6NF5MjprZQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Oct 2024 17:46:19 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Yassine Oudjana <y.oudjana@protonmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: mediatek: mt6735-apmixedsys: Fix an error handling path in clk_mt6735_apmixed_probe()
Date: Fri, 25 Oct 2024 17:46:08 +0200
Message-ID: <89ad840e7a484eaf4727470824acfe0fdc60fcef.1729871146.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful mtk_alloc_clk_data(),
mtk_free_clk_data() should be called, as already done in the .remove()
function.

Switch to mtk_devm_alloc_clk_data() in order to fix the memory leak in the
probe function, and simplify the remove function.

Fixes: 43c04ed79189 ("clk: mediatek: Add drivers for MediaTek MT6735 main clock and reset drivers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
index 104722a61dfd..e0949911e8f7 100644
--- a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
@@ -88,7 +88,7 @@ static int clk_mt6735_apmixed_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixedsys_plls));
+	clk_data = mtk_devm_alloc_clk_data(&pdev->dev, ARRAY_SIZE(apmixedsys_plls));
 	if (!clk_data)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, clk_data);
@@ -114,7 +114,6 @@ static void clk_mt6735_apmixed_remove(struct platform_device *pdev)
 	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	mtk_clk_unregister_plls(apmixedsys_plls, ARRAY_SIZE(apmixedsys_plls), clk_data);
-	mtk_free_clk_data(clk_data);
 }
 
 static const struct of_device_id of_match_mt6735_apmixedsys[] = {
-- 
2.47.0


