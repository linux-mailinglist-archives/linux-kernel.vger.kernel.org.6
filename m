Return-Path: <linux-kernel+bounces-391736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 641999B8B10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ADE2825FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C7F14B086;
	Fri,  1 Nov 2024 06:12:18 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940B14B07E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 06:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441538; cv=none; b=nokTbL+r6h9u3vN/jdJDFFIXJtfjZkgplDu0bBmYe7MbflPBK9KrUPVvWeTnmfzBDgrjnNe5HDFIU/iHRdfNUPne6FYG5kDmYyVkzBVBV/r764MDKy6HAbDVVMoK/hQLMaUArhfMTUu7n9DB98kele4BPV1bDWT7mf8awBSXCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441538; c=relaxed/simple;
	bh=9lQ773xlj4cTeGAmq5eDkMtPgj6vJ2Yh6Vu+xQr63mo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sewYRPJ7pw8n4m3lz6ExNeBYNR7/+3VRWU6PrUFEU6jPiomR2wPlGkuO2J23my2ihqzSr3nMmUvQsc9o9BDJqtvUTT7IUl00+qillh5FpWoBjSPCJ0U63Rfpn0X1K03MCdk8mnrTw12Dt5rvUKqD8f4o63pDBMlgMhhH7pn9i0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xfr7C57hNz1T9XN;
	Fri,  1 Nov 2024 14:09:59 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id E1E241800F2;
	Fri,  1 Nov 2024 14:12:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 14:12:12 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <krzysztof.kozlowski@linaro.org>,
	<florian.fainelli@broadcom.com>, <ruanjinjie@huawei.com>,
	<colin.foster@in-advantage.com>, <davem@davemloft.net>,
	<linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] phy: ocelot-serdes: Fix IS_ERR() vs NULL bug in serdes_probe()
Date: Fri, 1 Nov 2024 14:11:45 +0800
Message-ID: <20241101061145.2282501-1-ruanjinjie@huawei.com>
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

dev_get_regmap() call can return a null pointer. It will not return
error pointers. Thus apply a null pointer check instead.

Cc: stable@vger.kernel.org
Fixes: 672faa7bbf60 ("phy: phy-ocelot-serdes: add ability to be used in a non-syscon configuration")
Acked-by: Colin Foster <colin.foster@in-advantage.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add Acked-by.
- Update the commit message as Markus suggested.
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


