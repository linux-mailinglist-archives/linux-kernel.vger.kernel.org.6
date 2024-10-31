Return-Path: <linux-kernel+bounces-390525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675719B7AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E786281316
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D91BBBF1;
	Thu, 31 Oct 2024 12:39:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18931B5325
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378364; cv=none; b=FCHOw3O8FobXJJM5DXWfGU48k6dB69jiPM7T97tIJNzT9YbklTqUpjK6uFbe6EyECMWOB8/oTZgw+QJGnRQ6F1wox5QxtBNaGfb2UX/3q+ozJtDcjPfOOJmxNh1HpET+GwL/DGt6JGd+V9e3+LYOk27LSVtVqC3qldPqpzr+4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378364; c=relaxed/simple;
	bh=x+4k3ScXmc6pGd49ulluPwEZUnA9RxZJMnNu26rSZ3g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEiy2q0uEDlqu69vzKkJLh8gzIZC7/3wp31gRZL7Vz81W9poViGHkc6ULDt6GwD1UQby4nJcwM7iPdWOqBF9MCGIx1jCm8Om8ATS10xh4ihzr5wEwijATn2Cc/UO5CfkAfJbETkZTv7VRQyy8zdvKYJzEXarMsgQtLYTNWHTqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfNn20clWz2Fbsd;
	Thu, 31 Oct 2024 20:37:42 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 90A66140156;
	Thu, 31 Oct 2024 20:39:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 20:39:14 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <linus.walleij@linaro.org>,
	<treding@nvidia.com>, <florian.fainelli@broadcom.com>,
	<krzysztof.kozlowski@linaro.org>, <colin.foster@in-advantage.com>,
	<davem@davemloft.net>, <linux-phy@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] phy: ocelot-serdes: Fix IS_ERR vs NULL bug in serdes_probe()
Date: Thu, 31 Oct 2024 20:38:47 +0800
Message-ID: <20241031123847.1356808-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

dev_get_regmap() return NULL and never return ERR_PTR().
check NULL to fix it.

Cc: stable@vger.kernel.org
Fixes: 672faa7bbf60 ("phy: phy-ocelot-serdes: add ability to be used in a non-syscon configuration")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/phy/mscc/phy-ocelot-serdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
index 1cd1b5db2ad7..77ca67ce6e91 100644
--- a/drivers/phy/mscc/phy-ocelot-serdes.c
+++ b/drivers/phy/mscc/phy-ocelot-serdes.c
@@ -512,8 +512,8 @@ static int serdes_probe(struct platform_device *pdev)
 						    res->name);
 	}
 
-	if (IS_ERR(ctrl->regs))
-		return PTR_ERR(ctrl->regs);
+	if (!ctrl->regs)
+		return -EINVAL;
 
 	for (i = 0; i < SERDES_MAX; i++) {
 		ret = serdes_phy_create(ctrl, i, &ctrl->phys[i]);
-- 
2.34.1


