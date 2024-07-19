Return-Path: <linux-kernel+bounces-256995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DEF9373B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248361C22659
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205CA3C6AC;
	Fri, 19 Jul 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="qr1k4kzx"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A113AD04;
	Fri, 19 Jul 2024 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368846; cv=fail; b=h22lnJVML8OVfX7bB+CoZpIr2q563b/FuN7AtBSY1SYT1N+u3bY3Vlui2g9xrlbBw20YqWdrmlFCHadD4647BOr1sgUF5GWUg3ZBWyTO/E0Y+Rg6xZVc+5fZPkVyxc/o9XuaCVGob8ivGzvdf+1T1looExBLNysQOUMqr99886A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368846; c=relaxed/simple;
	bh=XIC3q3yzw9TGgmhnHE175vu7ugyAJzMsBFkmkSRby4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awof9Q5aSnR+D6p2cKBzUhO06ruNDN9s6qLWuGgMD/RVYMZJnPGKvDodIT+6mMOvqLgkLUkQMZgEIJ2y6iAm1GmUAKj5Ojmm+jZO4W0RcqlakDQHbik0QLO4NywsFzlgWNRDcwHNZH8fuBL59xWsnVbhnezNVyMRQQqLxEh1BBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=qr1k4kzx; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOs3C3lS2RlffomCgVHONga5rakigSauG3GzBY8P1Seaq4KDUMZiE/J0dl1zvBgy6Vj73yW0Bd7qweNQUzcBwTJVn/RhzxKrTeqzg4susmnFpCmSNaIvtQc9liRnWVCn7aSNu6ywTTeva6tjVnjqcp7IGfStY0dIiAsDl68h1HCn7iWi5SCA6yWSCXI4giHX/CSw3xX8do4OGw1OW4RInAWH9xxIlbp+Vhp7GQ4CnCp698Z8GM6nuHn2EV7ny+gA/LrNZ08nZko4MtDZuit/MRA8G79+p20Ch844fjrVcdc/JGrWNIUGzfUPFt/vaIN6CT4d416H+6NGprIAjsZ/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foNIYuXpkItBjY8qUhSUDvLy6XuG5cw+SWa9LoMYeno=;
 b=MqIQcaa+xadIumyKF3tmpYFJpoZdQyU2EYASq5ILdsEVQQxGGOhfAuFknaC1jZ0Qj+OLNNSVgJuP+k+YygohWd0aPHk7+gI7hSlZvDP0D025KgMVjJrAdsgV+NkGipxoj+BxVfD1LBRzQWHx9RSZVKVNbuimKAG1O73HVsVHkihTtIZFZCuZSCEjLamnIw948KJlhaCdTzuxbAPpwYHV0/8Ppvu2YFvSVmyqkXKLO1a6veh5fZjs7PerBss5n2cdjvwLTUZVSMjmR7PT23zcAMGA7n7gj9Hgs/VBLXtReNNyXzRC2Tk2Dupwnjexkz42z2jP35l2ezIn4Sk9ZhSKDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foNIYuXpkItBjY8qUhSUDvLy6XuG5cw+SWa9LoMYeno=;
 b=qr1k4kzx48/eNoO+PJXfxy1CAC+szTf/rvnU5LTj8zE2mLMdg7vFYfX5DDDPoTCuy+6rzIoLTzNbGDCZUt+2XO5u+WyNwiSEpuVk2AVm3MVU6RgcraWQV2oPF4wc3zo8xoEGDQyoMwVdj+ZuQqlBsozwSQcxHW3ddGvHNDliaSRCymW+dy2WkENx+QebpYWYLAix14haU7MQmxvOPc73FqcxZN1UKuci0TZW7EEXrPj+VP/8HDeD/pwfrf20tsM/Nat6iLe0/DuU4iSzKeMmIi8DPcaZZdZrTYfDN+gjCDW/a7OHUSg++E7s4thTmySdl5t7iLaLW9h5434lWAxMng==
Received: from KL1PR0401CA0026.apcprd04.prod.outlook.com (2603:1096:820:e::13)
 by PUZPR04MB6842.apcprd04.prod.outlook.com (2603:1096:301:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 06:00:36 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::c5) by KL1PR0401CA0026.outlook.office365.com
 (2603:1096:820:e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 06:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 06:00:36
 +0000
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
Subject: [PATCH v10 20/27] ARM: dts: aspeed: yosemite4: support medusa board adc sensors
Date: Fri, 19 Jul 2024 13:58:49 +0800
Message-Id: <20240719055859.4166887-21-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240719055859.4166887-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|PUZPR04MB6842:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 297a5c53-c2a9-443b-1f1c-08dca7b81bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iumhk7Sr/PoKd8x1BvyOklViSvzupCPTpilbJH7JGjKVis9rUfSy3vmm6K93?=
 =?us-ascii?Q?5Lg8Gd3os/dpm8XMaCY6wJuq53uhvaIrNEVHJUb2bdK0xfNVP4SMaGJCRdhX?=
 =?us-ascii?Q?H0/xXwGlLfh9A053IpUb0bH60rjSe/LXnuy7/is40tFeoEPyvyg+DSGzMwR3?=
 =?us-ascii?Q?q7d+V2mAzH6MhuC0EYaceCDu0HnPIImumXSPEQX6GCOZDLjh7FHt812dF+bj?=
 =?us-ascii?Q?nw48MEzAu1UAGRMifEsfJZ0Tp4kxNHj1XL9B4xfJk0tbN6D49bzzgjcrtRkp?=
 =?us-ascii?Q?xfjT1ovAciU2VvMrj6ckXcTPYR9BqxY6+MRq9tUXkqGibNRhhTCjtsOQHnHn?=
 =?us-ascii?Q?CkTxUQU+u3WZfqR9oe77mILBQiUQb3ZrOe9j1lAFGvcjtv6QuxwsLtXuzyt0?=
 =?us-ascii?Q?X/t0HpREYoDP388OQl1q0jpCleFdTC8pLPy691SDCJoAdWUV6kDkwoQpkJIR?=
 =?us-ascii?Q?JepC8dEjU4d8BtqaIipHqb6+gQw8g5czvil7BnH8+kZDk5k5sJ9D8s1vD6Q6?=
 =?us-ascii?Q?jCHnvNaz6eNOnrmlRj3gxW/diGWIhuHC41xHR9MIGdOw4+bxlsoYWy4+WDH8?=
 =?us-ascii?Q?5oBD8KzZZQ+XWEhd2tQrQwz10VbxAZH7L45/d91BuM/ft4KbBr0crBaMmxi6?=
 =?us-ascii?Q?6/ku7AG2gGT6Svnyb/dHfcMC0MtB30Q7l6ltPci1nAd0aSxv//A/wJhxNof/?=
 =?us-ascii?Q?IToSk9gQvym+k8UCLOxijh8FFq64lMVfOKujYTCZY40wEz0C+pjIDBoq5LLO?=
 =?us-ascii?Q?aJql6SpfIgKeagrINiZPHMdhvPkjjgHOY64FAZJmMW0Z6c5W+t7iVGoGi6U6?=
 =?us-ascii?Q?NAs/43JPi8BauPwsI6LFKRzFMekXUIIXr1Mhnqs5nfTPpirnhsA+X6LKgtNQ?=
 =?us-ascii?Q?POLw8/2QlwaNS567iFcz71a09h5LtPItcElFBTtRi4mC6ttQ6cZcf6/SrlTT?=
 =?us-ascii?Q?NZN+1erlBOkiRm/mz1lWhrjuQUolNVr4z7dTAuqpATEk9csJlnWkkJQDYAQJ?=
 =?us-ascii?Q?1/8If4y04hLns2o2epct9tAG54f+7DxAPMI3dfLKWjHZTXd3JyHkIr83d+Ay?=
 =?us-ascii?Q?8lJV0pUxaOhARydI7j+xAb2CFnuAkleDl6xBAU42Q7i/s5gTWxs+OA9a/7He?=
 =?us-ascii?Q?zdMgkT0GUMN8MAGD+fidjWVD2Kd7e7lgRMFdULdeisHztjtt5VzFvKmwYD5u?=
 =?us-ascii?Q?pstzABr2tXDVNV/gvWAWK8cm3UXEVCo/JP83A+j/jq2mQHvERFJIPsq2hw1i?=
 =?us-ascii?Q?Lg/SPwjz66uLVEuo5oSI/kV/9UrZqx5krxmqrkiC3uajX4dRPLgDqo8s8P//?=
 =?us-ascii?Q?EtFQKhU2pVHiK5yifsQJMJCkRr7hl5uAD5PzYfdz7DWqI2q64WV7ndZpUUx6?=
 =?us-ascii?Q?2FW3PY1qPPnOVAZkdbGYaNZz8mjJX2w6A1vucK6SnpILRKVkEyY3fJteL5ry?=
 =?us-ascii?Q?YvhGZHsLBJKaE+PWF84Whym5hRfrx5U8?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 06:00:36.2203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 297a5c53-c2a9-443b-1f1c-08dca7b81bf6
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6842

Add ina233/ina28 support for medusa board adc sensors

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index f4e37187bd5b..bacaa2208734 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -915,6 +915,19 @@ power-sensor@40 {
 		reg = <0x40>;
 	};
 
+	power-sensor@41 {
+			compatible = "ti,ina233";
+			resistor-calibration = /bits/ 16 <0x0a00>;
+			current-lsb= /bits/ 16 <0x0001>;
+			reg = <0x41>;
+	};
+
+	power-sensor@44 {
+			compatible = "ti,ina238";
+			shunt-resistor = <1000>;
+			reg = <0x44>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
-- 
2.25.1


