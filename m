Return-Path: <linux-kernel+bounces-302802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB54960388
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D275282838
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A7198E77;
	Tue, 27 Aug 2024 07:44:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9317BEC1;
	Tue, 27 Aug 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744678; cv=none; b=bTuZySPJNzPa5eTpTAUXGstWQ/oJ++j6oSG13SwAZTEEO8BAYjrTHfYxv1nUahSGPlE7ujDHmuck0ke0IUIjV0xL2vi1/2feVKc56C3Gi/nPGmA5io1VknpSX84DA9UXnWC4nkZ28X+3ngHvuji1Hp3IHGy8g0a7auRj4nHOz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744678; c=relaxed/simple;
	bh=jv4XI5yACXeh2L/Tsbj6z0l+qxWAU6Sc3h6P+yEirmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZATw3Qt6Q4vQ9Qk0pj+of2aqBW5ganq38td1E/HVAOBe3w2qrfmfS7xAAhttJoD/LBpGic6kYXwu+osvE2AuaQ5iDA3VVoVyTgGoRHZgAKmbmuNq5C/o0k8hG7clRdKzRBxEqMlVvV/JjoKacXQVLbsarRpBLeLyDNZGb1usUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtKLF1fMlzyRDk;
	Tue, 27 Aug 2024 15:44:05 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C38B140202;
	Tue, 27 Aug 2024 15:44:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:44:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 5/7] net: mv643xx_eth: Simplify with scoped for each OF child loop
Date: Tue, 27 Aug 2024 15:52:17 +0800
Message-ID: <20240827075219.3793198-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827075219.3793198-1-ruanjinjie@huawei.com>
References: <20240827075219.3793198-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use scoped for_each_available_child_of_node_scoped() when iterating
over device nodes to make code a bit simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index f35ae2c88091..9e80899546d9 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2802,7 +2802,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 static int mv643xx_eth_shared_of_probe(struct platform_device *pdev)
 {
 	struct mv643xx_eth_shared_platform_data *pd;
-	struct device_node *pnp, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
 	/* bail out if not registered from DT */
@@ -2816,10 +2816,9 @@ static int mv643xx_eth_shared_of_probe(struct platform_device *pdev)
 
 	mv643xx_eth_property(np, "tx-checksum-limit", pd->tx_csum_limit);
 
-	for_each_available_child_of_node(np, pnp) {
+	for_each_available_child_of_node_scoped(np, pnp) {
 		ret = mv643xx_eth_shared_of_add_port(pdev, pnp);
 		if (ret) {
-			of_node_put(pnp);
 			mv643xx_eth_shared_of_remove();
 			return ret;
 		}
-- 
2.34.1


