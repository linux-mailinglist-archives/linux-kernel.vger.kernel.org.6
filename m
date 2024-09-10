Return-Path: <linux-kernel+bounces-322436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D69728FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6B61F250ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD247170A2A;
	Tue, 10 Sep 2024 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="CN1I/H4W"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011009.outbound.protection.outlook.com [52.101.129.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D06B13A885;
	Tue, 10 Sep 2024 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947286; cv=fail; b=kvjB2w5jOouCpdgTBACPepEMKXHtZe0dnQQ3bkDjjgU2whxfNNkrlderI+tH/EIF3yUtp88/GLDUW76IECiWWIgx62hjFdQxkUp1ipvP9QSCPGkAi0HcM5SnVXPlxtYggKhC1JrrUiL7kLzTUUSntPsHLyBjUm1iTSZ+8F8s1fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947286; c=relaxed/simple;
	bh=6wEBaLX3yhEiMoZziGSfAUDSKQefMMJDFtm3vtHL0Fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYU/+id9a95diYMQ5HyhpV/EuQyarOfitI2uKNF417F0ySPCehCFWv5sr0anfye5NG/NDeZnXZJ+MvMSY6B6EHY2ID2SA8ZOAsbkzDJEpdlYQlhKgivVD7r9UBzv1xlDJTDK3gwDv1V+kRr1iaHcEs65J4xOykQbICskTL7xeNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=CN1I/H4W; arc=fail smtp.client-ip=52.101.129.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLZDecJU/8PFrTYV8I6rRaKS2MB06Z7u3yElNxK07As+Jp87vuCbA9kjqJCuolh/J24MMvWNkJGYdd5ZHwJbtyf1cdM1YNDdB6/GIHFD14u8kwBTDxBbqV+i0YAVruch/2YyoS8lUKua5Tn2CYlFgHh8llwa8wIsx1dSW75cS7vGelobIALsWEoO3zHnMPRyyY1AWF00QnNDzx8LSOoYBTEXPTbQFMBHa+knpNBCCn/gKWxYpqUXy//iRFOuuLTIPLD4YM6B4oYKlYY9KR7xzoNaGSDD1U98KhpV5yLy4hpO9WoDS/dTDmVBqz1VJ6ig8XCoq1mP0NU+58zQ5X/A8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/XIy7eVuZj3SBMDgfGePU0xugPwcgrgy3mDvSWNc+Y=;
 b=AgT54oemzdE/eGpUtH54NP7C0X2o12P3nkOs/Jbbyn0KtQuk6h3yOmVnAf1bBJOvJAkdn9kGw6V0kDXE9TzOAB99ft9EyvrIZ2ewb8l89mzFgvKldourVwTeyElBbr1pdERkcWKO1qgrh3wEOQwoT/5bwmq6ytA0NAOXSHvUJLXq+QU7TCN3BUGD9VJMiu6jjEUXmmGRUhMN2zvNPoKQmIcyMi2bo/0wGLaPK3j+butaiLpAEoYglgUnimGuwX+pusAB3j7EpWge3EXHsc6cUE81e5NSHztUfSY2MBFChIcqkjEYNahUx9rp0G0eae3DVzypfvRkg+QaqbDqzROjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/XIy7eVuZj3SBMDgfGePU0xugPwcgrgy3mDvSWNc+Y=;
 b=CN1I/H4Ws+ugbJj97VQSXKEUyNQUFkYH374wc1zdA/STLbrKQaKtgAfubPeMU/cNTYJkCGZKmCrwJtcoh/vlB6bKu1cNPUFZWj8bR+TpEjFjzO8U7bliYHa+VzS2fD8BxJyUaes7KkY0FinJLnJumP/swFZrWI4zoQQbpMlrspoh1wSG7CHCkFkBFLsZUx6mmQlIJnWWCJ5/aSN/TS8PZOhMDr1q9dKRORdWLXM22LeorDjMiDH+hzeOTvas4RjpTv3zVEPKYR+SCTu+3Xgb6IUscoRb3EKqY2bXPYanB5UXAjkourAblY7pLi4I/ROC+f0J7nfC2HGMOtcj4zl42A==
Received: from SG2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:4:188::8) by
 TYZPR04MB7179.apcprd04.prod.outlook.com (2603:1096:400:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 10 Sep
 2024 05:47:59 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:188:cafe::97) by SG2PR02CA0130.outlook.office365.com
 (2603:1096:4:188::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 05:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024
 05:47:58 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: aspeed: yosemite4: Revise to use adm1281 on Medusa board
Date: Tue, 10 Sep 2024 13:47:50 +0800
Message-Id: <20240910054751.2943217-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TYZPR04MB7179:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c6583dd-d057-49fc-a905-08dcd15c2050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hGU/yN3V28y83Mrn8EmvvrsCCMgod9GDE4M7PbK5q+j/RQbPbnwvJnjjbS1M?=
 =?us-ascii?Q?rVDoVMQMZHkbFCuY3U+4ZACc/HdOG9EUcD6MUHC0QyGD88P9kQYO7aeZ5gSp?=
 =?us-ascii?Q?V/MOIH0bPNimDXnRwREJF/RSOcUc4r0bCIxz7r2dNJ6WhWV9fmvHXWG+iKbq?=
 =?us-ascii?Q?rjwHE984kOt2gGFMnKS8qN1vqEee11CRRzmZb5fslXWZg3lHntJkWt139uom?=
 =?us-ascii?Q?BMDL/zKxm9cZjR3fu17URgwDdJpGaF33zIwX6YGuePvm+YUmOK9XKnHWQfmV?=
 =?us-ascii?Q?RoS7BRNDz8nMKLkboWCegH9B8nBd4FT8aDn3kvlPhO6jC33au57GQ53Y9vwe?=
 =?us-ascii?Q?PxnnJJE9nGFD1XigAJtL16aX+KD2Wsh7dGdicYCCJ3yfWwNa+FCFvXClPByd?=
 =?us-ascii?Q?mw/qgXGIq1GF3rt7Aoy9lYXaWC45BK9TzZvzv087ElfsbN/3/D7E+wPgAKk/?=
 =?us-ascii?Q?G+Btoi6eAgtaz9pR0fwSUoN6d4eHAx8ThZKvO+M3vorCMnWJQptOiQ+KUku0?=
 =?us-ascii?Q?+906pHbQA0BNvYrhk3h4zUf7SescjLQSXrGjyd7i6snstyS5686AslypduLB?=
 =?us-ascii?Q?VnbyoLzsWNYbvzVV1G4t9A7/l8kEjvohAGzM3xq2V1hXt/RlirxP8vmTArXL?=
 =?us-ascii?Q?MjTDNTZ4ZSJt/FswoonVmA7JC3mPLvRu0vO3RC9V3fbrBOzwtQjyGPhYlJI9?=
 =?us-ascii?Q?TQsQsjERDY0Nfl05avESNeHxvmpOYmnOY3VYGpL2PsuwKmJQN0UkNOFd10Hh?=
 =?us-ascii?Q?gVOgvhfszST5BaZzVwKnfkEsledbAtOoZfm7+nAkgV+zMGS1QxpbwmrcqJZh?=
 =?us-ascii?Q?3T5p1375/4aiNOth/omwUoapMw8jHM6Mt3GJOha997HeXR5cBqAy4rgI/7N7?=
 =?us-ascii?Q?ujYvseEdm86BHHda1Nxz7PyzoMPpGStxi8fUXqrAzTx99gPzEktJ8yok8brw?=
 =?us-ascii?Q?v/Qcn7zAXzajXQ2pxx653cu91hj7fKl7xxPtjJ/oaa9Y4ltRiskAp8bduTre?=
 =?us-ascii?Q?YhssBnADO2l991QtVBASAghp/sEpGzG5xhb41ssitImVS1emIqYB2LMHUMAV?=
 =?us-ascii?Q?Y4mAYc3pqHaaZYEmeABIbpyERUiYryVvqy+oAmrU82ocx0yjDK+NPMcMcarr?=
 =?us-ascii?Q?qXdlIgIn+e+ybEpzzqmp5n85+lxf5vLpyQTwPR+HtwQGV6KhdEoq68Vh29Qp?=
 =?us-ascii?Q?+8mcM+8+y3+OhSO0C/fIeyD27nJ4EAQGRRglHpFZ0nSrKyffHIKMvhNLJA8N?=
 =?us-ascii?Q?+B6wgU92Ci2K0iuY2wec5wqu1wKsz3XMVCcRZcWYL2S2QVEjKDNVci35d3+V?=
 =?us-ascii?Q?voappWNn/87eYO5KNa4/EkeQguyWUiYg6SUQ1SgwEAEX9OJhRkWaXY9ih30N?=
 =?us-ascii?Q?2URodwLnt/jhluV9kJyp1sOvfxFxkqcT++4gW4T85Cdnn2PAiaQFBM99SlvR?=
 =?us-ascii?Q?P5tdXUYb1sOLeYqt5l8NwJEnftCJX2iu?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 05:47:58.1933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6583dd-d057-49fc-a905-08dcd15c2050
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7179

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise to use adm1281 for HSC according to the hardware design change.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98477792aa00..08d32e42286e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -130,8 +130,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -147,8 +148,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -164,8 +166,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -181,8 +184,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -198,8 +202,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -215,8 +220,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -232,8 +238,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -249,8 +256,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
-- 
2.25.1


