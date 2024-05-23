Return-Path: <linux-kernel+bounces-187251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA348CCF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D7E286F80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66114F10B;
	Thu, 23 May 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="sFllFId8"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526913DBA0;
	Thu, 23 May 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455960; cv=fail; b=H6XG+/gA+fFgZ0lRsQ7wyKYDNhoPyN5WqeOry7lJrxETnTq2exF1BPfVv1tFHUxLDgr40YSywmwKnbMzCl5YbZvJfat58fKUA3TbAjXcOSBlKLOvoGwMuZZv4GWFCdHrCh8TWkzOGK0jy7VVYosoxtt48rhbLvgzKd0GIWEeseQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455960; c=relaxed/simple;
	bh=0/RZfxELZSv5ixlsRWXl29JeFAUJDoCFh+RoEwRg0LE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INrABbqpHmnPP/g4f5cHAUxPnlA5MC0Z0JRE3rCwJrnruu3Oc+F5DrMNKmCizEttIzzp8yEYbk3f2XwtumoQlKMB7CZ0pMrXRJIw0Sb+iwyXq/f9lASfz1NChJkHeSdwU+qeDyQgSP5mOtmgo1mxZNk43q0G1cKtg9MrxONMrwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=sFllFId8; arc=fail smtp.client-ip=40.107.117.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuNbT3LJLPfSAjQ2buRl4k6hkFNa5BbHQY0QNkG3XP5paUHyb/f1GJs5ix9XAfoJxhwQZbn+wCSilOzL9QgM3vVxNW/8zZOTVWPKz6dFBRvxKKkUO9IrG1K1FyATpD3Tpjp/Fo0JUlG5AVgLtErNi+8tVHdiYNr9aZPhsUlUFeLgX89lIXDOh95iy8KNTIFnVwiWcw4hAu60d3u709ABuNBMpV0J7U12a8y59KD1PhTWASC3hFZM934bTonorbOPFjRfE2bnuhbelL6CVvAhPpNlztuAWwQ9h99HLX/iP00aw5FExmbU3g3aFjPzsZHvO8Gfl+4mBKDiCtyAdMAauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=aQk8mj0mV/UvSi3C3cQwqfBeuz849UsdtuTqtNz2Jbm1p7SxidW+6rxu3XeEpL8L0ha9ttydQf7c/LM5pT+07z5H27PjVolm5hOiOP+sghm1py9Zmt4MKsj44EYT8gb14pVi7dmw+unZ7W1No9PTJGVhTdkwrm9zHOk8LLa0humN+TqnNZOyfqr642mb2iwPMcby3iC2uZxvhNCjY2Prdt4pCBUNV1mUirDjhT68mRFEbr+HYWstC10fu2+qMRQavMqQ4sTLIrHT0cVWp+AIRj7vHEgLvmrEiQM1YSO4UXNw+tplfSIhMvHtiyRn6sy7MMwoKL8cVdpY3LW1v/OQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O16c89fsxykpLXkgqq5cnVpUTCPvI9O9YW+Dewzjs4c=;
 b=sFllFId8WeMJM264RHedmqMoSklrCbAxylgpvahK7G48jeMBBmSPONlM4rjCvQ8OL2xmjHkJYw0hsxUqPZui+9JaSruG/j2pEA4HztnvCbHdgrLwtDa5gWqr6ammxOyzyqb/fJAHXlNpK/hgxHhea473JHEa99VCkxj7kR1WmjYZU48ToCaGoWJlfGS+xvpXi9qSuH365ysuZEJpuWLlgbLD8mbekx+8U0UxnXHX8WU4MxX5vpLYlX/6LFZx774iu8gOPFwcEnHiE69+KFAVuybeJKhXrfON3svwhSnbOc5pqDGHF3s68oatkDiYTDjd+hevlprekVdVtbq3kbuWTA==
Received: from PS2PR03CA0020.apcprd03.prod.outlook.com (2603:1096:300:5b::32)
 by TYSPR04MB7867.apcprd04.prod.outlook.com (2603:1096:405:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:19:14 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::66) by PS2PR03CA0020.outlook.office365.com
 (2603:1096:300:5b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9 via Frontend
 Transport; Thu, 23 May 2024 09:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:19:13
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
Subject: [PATCH v8 18/23] ARM: dts: aspeed: yosemite4: add mctp config for NIC
Date: Thu, 23 May 2024 17:18:05 +0800
Message-Id: <20240523091812.2032933-19-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TYSPR04MB7867:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 71e48c5e-a1c9-423e-369b-08dc7b0969dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?viCSacw8vKQT879Npxo1XYBojxErnzPEjA0SNSKOgRWaECyT/Ao3CkLoFOWO?=
 =?us-ascii?Q?Jlu+KjjkNoohrMnrLkaPZpHwnIrCuqFbm+Vppco2Jn8tWj+CUlJgCCwK9QDz?=
 =?us-ascii?Q?nI9ADNpO7q5F+cV64z2JzLum4a77BcMgz5cILqZN/uNiiaQmPRvoHwN3h8qU?=
 =?us-ascii?Q?0/lk9dxoNd/pcH+xUZiTOo4Jb93hSrvTQLLzywzXaXrFg5QZ3xoYj6lVw7oj?=
 =?us-ascii?Q?lcNMZOz3X3ZYBFE8Y4bSeVWDPy+YpQfY4NEcUm1/thw6p8Va1xz+rf5doPMf?=
 =?us-ascii?Q?xj3+3UHA4zDB6eQeeEEHXdq0U0kQDze8C/VxRkSQ/VFaofz52Ok4nOS+s9Ii?=
 =?us-ascii?Q?eaKMu5++J4OTgJ9C07Ek/WTvFKaTPTxhtP83BkJBdmsehZXMfH/P3AEUKPD0?=
 =?us-ascii?Q?cA5kixDMOeoQjR8UiElk3EsFYJLTtXIhMwQ2gUK6JhnaeIhHQldO+ipwrzN+?=
 =?us-ascii?Q?Owp+aHltSRac5a07j+qSMGlPtcwJtTbpzSZQ5xsBNG9Rn/n7nO/gszCbdBa9?=
 =?us-ascii?Q?A3DH3dCiTseN6KIpXlQMoHhZ5Z/2fBgVgP5J4Mex5v6UNT49+LUceCsgEjWw?=
 =?us-ascii?Q?MTeMmAa7kqPWueBG0cE3MPGLfBXI4gEM+fELDMQhAQFMAUipGf4ftaLVbPRj?=
 =?us-ascii?Q?Vp2fnlb+/7/swgwRW9/n/OgbgLiEHrx/Wv63JJaQqxf22V/op/MfVSl9Hnpu?=
 =?us-ascii?Q?sII3sauCVvW0WTI9uTuPo2l3McuTOTxBCW4AGBFGn5pnE6m+jnjTBOqhbDNp?=
 =?us-ascii?Q?T1zQTX+zyqFoUPIoDuCsHe1wcMM9vUTEfjFGBqzkNiA39J5IbslD4qMOaC6v?=
 =?us-ascii?Q?AGairOVKVwJ1ur0YCIhF1L2qP0kEfxCNteWnr+Gs1GJe6ePQ5qmdUGWtiXt7?=
 =?us-ascii?Q?7rOQ6+Iy/bXD5vceiGr1qWJm+K6l5BkS71Xk2ZpmcJUB4qtx6WqvlWhM5JaY?=
 =?us-ascii?Q?bRT4qBR/I5nrboibL+0Hxz2wqOIFrXwfIWZ1ujdfPKX+VbwbZy6b31k1caiA?=
 =?us-ascii?Q?OVM3eyXx0npO25RF4E193ryA+FxvuII12zNuqFIYpRQ4wrahfUU3FBNHadHN?=
 =?us-ascii?Q?/7Po59QN3lOMwRWojhbQlHc6YvVpp8q68lvvNE7fdF6SnPOeXhAhMAhXPRCw?=
 =?us-ascii?Q?ffm5BK2ABlzmoQ7kpO7RxsCxjABmURy1nUI4XBXsndL+iIPSmDm3wuZSUlKB?=
 =?us-ascii?Q?sYC1jKEbSm07AJKqghx2gt6VcNlJETyKrvsMF1acQZUAhb/8MOgpubq9JciQ?=
 =?us-ascii?Q?id3NyAZqoqqbqw7subyaFp9dbPtuEqE8/T9FRUKhWdmD6Vkqevrk8nnPchh2?=
 =?us-ascii?Q?nyilIXB4OfNC92ZJqOERhaTRMxFWEkEVHLY3xvUMf3dMSD9DfGIxFbPeO604?=
 =?us-ascii?Q?/RhU9q7Dlh7+5AxI5J2bDEbd2egM?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:19:13.8607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e48c5e-a1c9-423e-369b-08dc7b0969dd
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7867

add mctp config for NIC

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 59615a6958ec..83c9d76f5a11 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1281,40 +1281,64 @@ imux24: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux25: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux26: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 
 		imux27: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
+			mctp-controller;
 			temperature-sensor@1f {
 				compatible = "ti,tmp421";
 				reg = <0x1f>;
 			};
+
+			temperature-sensor@3c {
+				compatible = "smsc,emc1403";
+				reg = <0x3c>;
+			};
 		};
 	};
 };
-- 
2.25.1


