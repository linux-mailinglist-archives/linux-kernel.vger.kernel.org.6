Return-Path: <linux-kernel+bounces-185469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BE18CB545
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BCA1C21795
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9114A4D7;
	Tue, 21 May 2024 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="O3fC9bgB"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63150276
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325902; cv=none; b=l91veUKg7X7n8hhido5LwdehxO/8mwzCUkqRhJdz59Z5i/hBLQMPKUAVjUO31NI+pOIpLWJSmYXVCLIpGkwbER/eJYZ9BZd7YLRxMVKmb6RunOT6w97pv9NBvQVpznd4FDvv1dPhlMciQrFQNymgbLo3H/ViWZLgbu+qZp8ByJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325902; c=relaxed/simple;
	bh=N1WkvKCkGv066UHsJWDgyr4P1jYIFEIRBxrzgLOo5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaRImpTqGIB35SbLfArsHLedtGWNPPGWvxFIuLC1Vyo0566X6IGq+yRZg01ncQo+Ek0Mcs0t6lIkBT2oV3S30jHxgXPLMSZEIr96r7VIuNtgxh3f9vcmfQIjtQwhpCKICbzWHHvne5Wf/l9rirHaQZuJCuahunKk7533Wjhb+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=O3fC9bgB; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1716325881; bh=eyj04u+/DPesCV1unk9Wb1gsmDXj34axtvqf+FzsKkQ=;
 b=O3fC9bgB1MOP98dBjT871oX151vBHRil4IpGhTa48l/Kott/lcBq4QssoodNrnlAMCQBuBrf1
 WdDAIwvj4Q9XDmEuvoFH1AiAPhKh+SeNZkuRCDMgOJwkrq7h7jTeyZEMgQ1H8buqePODiuASHFD
 iCk9w9+cy7Q8bNZ+IBCHkzayTQNRDmBkwg6JA75yd/brOhMeRcCJkXHiKYLSh2ufUnBkwUOCfQV
 VBdLwRUYEI/xEJDDYR5nNzfOPeEGPmiCvUP0BubO6gs7ni7TilWfVb3BsKJ5nESwvdvP4wEfqE9
 zorz3ef+l9SBmw0LqL8IGBqzCVtaPOnPq5NEljHKes/g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>, Jianqun Xu
 <jay.xu@rock-chips.com>
Subject: [PATCH 10/13] soc: rockchip: io-domain: Add RK3308 IO voltage domains
Date: Tue, 21 May 2024 21:10:13 +0000
Message-ID: <20240521211029.1236094-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240521211029.1236094-1-jonas@kwiboo.se>
References: <20240521211029.1236094-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 664d0df48b6b0c828344af54

From: David Wu <david.wu@rock-chips.com>

Add IO voltage domains support for the RK3308 SoC.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/soc/rockchip/io-domain.c | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
index 18f809c160a7..fd9fd31f71c2 100644
--- a/drivers/soc/rockchip/io-domain.c
+++ b/drivers/soc/rockchip/io-domain.c
@@ -39,6 +39,10 @@
 #define RK3288_SOC_CON2_FLASH0		BIT(7)
 #define RK3288_SOC_FLASH_SUPPLY_NUM	2
 
+#define RK3308_SOC_CON0			0x300
+#define RK3308_SOC_CON0_VCCIO3		BIT(8)
+#define RK3308_SOC_VCCIO3_SUPPLY_NUM	3
+
 #define RK3328_SOC_CON4			0x410
 #define RK3328_SOC_CON4_VCCIO2		BIT(7)
 #define RK3328_SOC_VCCIO2_SUPPLY_NUM	1
@@ -229,6 +233,25 @@ static void rk3288_iodomain_init(struct rockchip_iodomain *iod)
 		dev_warn(iod->dev, "couldn't update flash0 ctrl\n");
 }
 
+static void rk3308_iodomain_init(struct rockchip_iodomain *iod)
+{
+	int ret;
+	u32 val;
+
+	/* if no vccio3 supply we should leave things alone */
+	if (!iod->supplies[RK3308_SOC_VCCIO3_SUPPLY_NUM].reg)
+		return;
+
+	/*
+	 * set vccio3 iodomain to also use this framework
+	 * instead of a special gpio.
+	 */
+	val = RK3308_SOC_CON0_VCCIO3 | (RK3308_SOC_CON0_VCCIO3 << 16);
+	ret = regmap_write(iod->grf, RK3308_SOC_CON0, val);
+	if (ret < 0)
+		dev_warn(iod->dev, "couldn't update vccio3 vsel ctrl\n");
+}
+
 static void rk3328_iodomain_init(struct rockchip_iodomain *iod)
 {
 	int ret;
@@ -376,6 +399,19 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3288 = {
 	.init = rk3288_iodomain_init,
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3308 = {
+	.grf_offset = 0x300,
+	.supply_names = {
+		"vccio0",
+		"vccio1",
+		"vccio2",
+		"vccio3",
+		"vccio4",
+		"vccio5",
+	},
+	.init = rk3308_iodomain_init,
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rk3328 = {
 	.grf_offset = 0x410,
 	.supply_names = {
@@ -528,6 +564,10 @@ static const struct of_device_id rockchip_iodomain_match[] = {
 		.compatible = "rockchip,rk3288-io-voltage-domain",
 		.data = &soc_data_rk3288
 	},
+	{
+		.compatible = "rockchip,rk3308-io-voltage-domain",
+		.data = &soc_data_rk3308
+	},
 	{
 		.compatible = "rockchip,rk3328-io-voltage-domain",
 		.data = &soc_data_rk3328
-- 
2.43.2


