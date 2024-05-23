Return-Path: <linux-kernel+bounces-187147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0D8CCDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA81F21DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48F13D260;
	Thu, 23 May 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="BMXoBpfo"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011005.outbound.protection.outlook.com [52.101.133.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3913CFB2;
	Thu, 23 May 2024 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451446; cv=fail; b=R90VZ/qq7zNWl7k1m3vshNhPZ+joVFfzgIhSDlg61ReTPYNmgJ8xYLrUrwcsuSa+VcwXqj+7yr3xNHwmJl9qX+Ww20ICygtqBcJ24c4rfuhRslOrFcEO7oUhc6z8+rkBtCAbmcsUtqHmQ9BniQTxAXv0JkMNHnqTnkMlPgBIg34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451446; c=relaxed/simple;
	bh=btgdBgFxtTzunG2/lrrBUYJ1QxP+cTltq/6I9W7+wPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oG3AWvNboibFP+Z6ttz1k1OV1lExShRF5grF9pSOx36r5ZkWlHcxTiXQUq2n+n1k0cO6pbT6DTIf+mA+tzMR97LZEkwsm6ti7Pdk6kBCqkIZmf6nnHKZFfh54dk/Kd9Gu70MOMhXeVsPAm71rfLHnWRNqo71hv0pcz2jX9zjotY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=BMXoBpfo; arc=fail smtp.client-ip=52.101.133.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZg0Un3dLiTguHut3vKE19ZD/RBCzwNoqyDAFVPSxthR9M56l5PEG5LlJUCMffLGIQj0NSC28EXm8nZsh3ta+uKwlHTvW5DY8wszqmDj17l6lwYlmoVcvlaNI2Thn/4l7Ap3zo8UfaIW6DrRwCCtXOP0j2r6UmSj7jQ1oRpMxTpEYvMW3fUzgOaEBle3NyjuNnvzgeEZS8SqPIlD82v1nUl571YFqovcdQ8iWMQz4TaPzLzUr7M43/vy6Cw2Nf5XI1AbYZ+31szDwlUpW2xWukFmqG+U9yQB9XilsmKSMqxh8ok9F3Ax6i0hZZBWmTrX67mk3Slq7N3oKTxLAu264g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsZr14PNPmBXIPZ1202IghyP5Yyu1YMx3BAbXzof8TE=;
 b=R8tz7vKMwsBGgPnkJLsL8NbvwY/zfurYTAuMC00NJME+CpxghsHslvlP9jICx8LqaaoguNg+s+QLDwzIEHjyU6g3qu5mk7cnOlBTXhaLhQuPHOXeDY0T+qSnXPR0qaOeJ46sKds2sp1k8mL0P068kMue3d9vy/Kr3Yu1QvfEk8y3UnFYNpbk40S/FnBs37+quCDSqR3O2FObk4ieiZEz4MahdwkycqT8zuD2R5JHHaREj1oW1JVoHDZRmKuJ1TIgjCTGrlDXHJ/8loNWOTYg2fKnv8bhhNOe5sRWJAshpMuJmOPSNcaOGWlcV8WFuvpT9maeIN8kKyPjGJp79alcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsZr14PNPmBXIPZ1202IghyP5Yyu1YMx3BAbXzof8TE=;
 b=BMXoBpfoXM7y6oe2EvSY7ynGT+Y76Hgw86cTaScLSozPx9zMYsKCs6aO8VLOjGYpfPWuRY+KDlAlMVcxv5ZW+Fb25N30sOru++pqUN9H2N7wuOwobHlykrRnEgsfXRuGgk63/F5077LhDf8nwKKXmjblSydtwTSOaxG4LVEMFVR08Zx/V8T92vKv43lHi5Y3aL+QmZEsA8l779nHEpfjvST9WedLChEvgmZH2Y+pBsvl9f5jbq0e9PA7ZISMY2qKcJgpq/tZZTeTNbvWvJm69DHRzH5vWpDH4nbPNAa49jmgaim/G+yj/O0GqZExv1BawuLf5BDHKU33xUnCBs0OTw==
Received: from SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27) by
 OS8PR04MB8162.apcprd04.prod.outlook.com (2603:1096:604:289::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Thu, 23 May 2024 08:03:59 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::8a) by SG2PR04CA0165.outlook.office365.com
 (2603:1096:4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 08:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:03:58 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 02/23] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Thu, 23 May 2024 16:03:07 +0800
Message-Id: <20240523080330.1860074-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|OS8PR04MB8162:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a550532b-892f-4b87-0395-08dc7afee69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yBg5lFGQ5t1Nnagy7DNlS6K/1o97lDgT9syF7VKGT8GOajcprqcgtitGtQed?=
 =?us-ascii?Q?gf0FuUQOFHmPTuLf6EvNJ5dYDNAVrO55B3a3BVRYKeIOs8Gqs4RGU3gxwWmZ?=
 =?us-ascii?Q?ZlFMR0SIABBJv10eG/ZdNjXHpTLoSS5/sZZHjgaDIICWJTZGvfRAj+ZJPSyy?=
 =?us-ascii?Q?6ue0AK3hJv2ZAJAJKpy0EbgM1cUzatlqIkAoHY8Dn8AvkuqqrSCEssdfSmGa?=
 =?us-ascii?Q?4QZXI3L9kjHi6v+jUBnS9r6gbeTeVDYOKrsNDex+qKcv+5+eOjklUsJ8Z4uv?=
 =?us-ascii?Q?ofRJpim6ZstGh1e1+7njdv5jc+38q3Wm0FXYzU9h/pGSSnfVVzvLMzxQhhXj?=
 =?us-ascii?Q?MOoj+dBOV/muYqYQ4qawfpVG9a8EWBz4XCOR7lX6jqd7y5tNil02XBn8Ass2?=
 =?us-ascii?Q?vjCdQU6hHrx4bvy1PzMOlINbYFLguAJK9Rcw7Ww3av3lwSlOF6VzFJmFBM17?=
 =?us-ascii?Q?CXodzemCQVcJ+pT54UmuIPESTsYYmYCTg0GRVodRQUWeQClXRhC7rM+GoTgM?=
 =?us-ascii?Q?ntyQb5JiMu9ziAnoCMCs298aIdIsH/3v77FCcgJePgXAD03cIJzhQiEBuO4J?=
 =?us-ascii?Q?JDkTfoniNwG10bRV+u2mc/DQHSL77ZUNvIKnf7IPU3qAHUamnknHOQGvFs3j?=
 =?us-ascii?Q?soppdF9v3G7a6vSIIw2ep2STHErYhFi8vCP2DTGOQMKr+yEppZytblDlBYx0?=
 =?us-ascii?Q?2q3jmIrVMB0/MFppv6vnqacswCtWgd04Z0KPhBIBLH0Iw/b867s1UkmXZkC4?=
 =?us-ascii?Q?3gNsgU9jNna+2Vv0DA8frV6sQpagX6/wn/mWdTfiq9Snlo8ymISluefHyW2L?=
 =?us-ascii?Q?vVxKQf6lacHVTXg7FU17hYMuUapDK0Uo/dmW9XXqGO6WZJqDhlEGCKDaFru4?=
 =?us-ascii?Q?uaBhadlc5DDwwvRm7ZysOwGDpqmFV6c0NBaWnOmsWM8aa63J5xktCN7ZC7bC?=
 =?us-ascii?Q?9uV72cHntRNByeLD55MB6C71bD9YY37mf+38WHXGUb2RTtEdDKYHgWiEpPU/?=
 =?us-ascii?Q?YhFNScyDq9PuDP/UVhKiR3xSPffVfzbcN8nZ5UDEBVIYx/qFzRCsk20EcDYZ?=
 =?us-ascii?Q?B+8EKUUsnKjwHh/3x8MmJvgOl2Lrj6umM5edsQsXUlkG7HJz9aUNkURiTzKU?=
 =?us-ascii?Q?6GtJesa8BzooXWzzf+kIExXWlNqYvCBiG0Kh0sp2tkPs/7c8xaEoCTizosX7?=
 =?us-ascii?Q?7OcHn+MM6nI7sJLYYdFoteeGu5y+Sos4PB4mApcL9M6/UOis5knLiYr8qejL?=
 =?us-ascii?Q?Y8eNonrVFXAGn0cLTjwBftzyIMq5Jy6J8SbyZjvELmpzvjVpkZTLdWTizv63?=
 =?us-ascii?Q?SrlYVV/74OwJLQGpOcvo0Eo9WY4cTsHbZPsVgrdhgTc/9zqOczn9pOfHv6Rj?=
 =?us-ascii?Q?43VPq2k=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:03:58.1558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a550532b-892f-4b87-0395-08dc7afee69a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8162

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 66855efa0b4b..dd88be47d1c8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -925,10 +925,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
+			&pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


