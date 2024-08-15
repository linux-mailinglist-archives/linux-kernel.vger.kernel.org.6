Return-Path: <linux-kernel+bounces-287763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81035952C51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B470D1C20BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBD318CBE1;
	Thu, 15 Aug 2024 09:46:29 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1F17BEC1;
	Thu, 15 Aug 2024 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715189; cv=none; b=Kv/mF5HHoMp5UWS1Fv8k4YfwKzyQW78BVTogV5r72RFLnf7TyZxx5GNtZvT6RvU1XcVOCYvfMNmjjyRjgCpqE/Ig0h/7HKCs3CGlPa2A52gUmy/KeCu8yWja6FH5EEJ/0vLV+LKwj6WhCXsPguWF5LU37t+/LMAYxpHrmhfLrhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715189; c=relaxed/simple;
	bh=TekCVkLFHhtXMRf4UsilP3Rc8B1Nvh9A1LfPnR5dLFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYvDOt9TfnyAC3kXfyeoEHuql1TWYPlRIugqhBcCcJfn6WiB1K/oxYKnty6+K5AS5spCwjmwu7r4Zc8+w9QpzZMZSegPOL1KXdC/Ee5pxa0tjkRFqkqjh9pS+8DiFo91sem/5KzYrykKq7r3YiWKrvZUzGe0mbjf0HKtWSzZR60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wl0WF31qZz1j6MV;
	Thu, 15 Aug 2024 17:41:29 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 74438140202;
	Thu, 15 Aug 2024 17:46:22 +0800 (CST)
Received: from huawei.com (10.67.174.76) by kwepemg500010.china.huawei.com
 (7.202.181.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 15 Aug
 2024 17:46:21 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel@esmil.dk>, <hal.feng@starfivetech.com>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <conor.dooley@microchip.com>, <palmer@rivosinc.com>,
	<xingyu.wu@starfivetech.com>, <liuyuntao12@huawei.com>
Subject: [PATCH] clk: starfive: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
Date: Thu, 15 Aug 2024 09:38:53 +0000
Message-ID: <20240815093853.757487-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500010.china.huawei.com (7.202.181.71)

We need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
fails, so use pm_runtime_resume_and_get() instead. this function
will handle this.

Fixes: dae5448a327ed ("clk: starfive: Add StarFive JH7110 Video-Output clock driver")
Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 drivers/clk/starfive/clk-starfive-jh7110-vout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index 53f7af234cc2..aabd0484ac23 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -145,7 +145,7 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 
 	/* enable power domain and clocks */
 	pm_runtime_enable(priv->dev);
-	ret = pm_runtime_get_sync(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0)
 		return dev_err_probe(priv->dev, ret, "failed to turn on power\n");
 
-- 
2.34.1


