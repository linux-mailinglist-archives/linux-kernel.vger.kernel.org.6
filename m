Return-Path: <linux-kernel+bounces-289369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8795458B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B11C229E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E591448F1;
	Fri, 16 Aug 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iLB8rTl3"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010060.outbound.protection.outlook.com [52.101.128.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9587147C6E;
	Fri, 16 Aug 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800291; cv=fail; b=vFGtpWTW9XJ426BfrhaZpwEFGo2chbF35XEYOh/U8YXWlUbvg8tWi61LFslW/jnPlBIQz2VZn/XSHaQ+2JKdXn1SMOPhon+2r4deWbRavnUhP/reqjk8JnJjir3adn/X4YEDRS7VrwEVtytRVgV+eEyWzHbJLyhozuaR25wH4eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800291; c=relaxed/simple;
	bh=8kUwonoYyYB6FHmWPqpT9IgUk9yz6V38DdWLkRxT/ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKUr1KY9+EZ1fhC7FEazO8IgxOQffAvME9gmH+aQOaZS4uhCDpl77NG58h0oWl9QNjZQ4OYaKrvt4n+FPiYci/mWXt+CCqJHg49E1Vbv7aQ72nLEo+mEGX0C+YNx0/A2ubKCeVB9LtmhXFpN0Uq9OBMnPTXtGyYIjX1zFE32z20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=iLB8rTl3; arc=fail smtp.client-ip=52.101.128.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu1jfU76xLE0iEpV/S/cWBUPbBwKah/6aEDDi/+yh8vq1jMDWDXCHO6zC+i5uoIfuTirHg8DVfodZwT7YiCJ1UnLWR4yn/c5TbIAPYf1FGct2eLHglkK0qZF9jVs5FYzKse6cQNs0mCOxOWrECzdacV7R+6ds3FhbwYUIC8+thA3eqcpPzX9gvG+bCmTBU5vpqX/i6vvJ0+IOV1Xp762M+tc9V03zgMcV3xzBmp9qOSn9g6L45cWj8Bh7JJdUpLm+k8rYcm3ALnaKj94spWzYcvyO3v1n1vuUVN22ui+/8Rva5xJqa5nC+lGp0wlTsEN1MLhNHk+DPHEfQ0lQ3l4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmHAwAuLtww6S7Kx24cCQt5tMxYWDkSMHxAXTvM1SXo=;
 b=uyILZ6Go3h9LG+RrQALnHNHU5OEvSFzsCy7CbCL1WaEsG/dO3g4fBFalxf6cOdXbN24or0/RAyKY8mJjLulkW6sdZ7HKJ1Cxiu4ALdnviL5llnDBdmCJcbAV4oFo/XZLRW2LssKnoI190PwxeQwagXKP0coBQLBgJllXdE7PAsoSYh6m94l2xhKuJlhAa/P909c+LHfTs67OBSZ+K7Kmgq4H1j8EsCgLuIE26pUb2CZllrf76sNxcnWRa3TsTbcNF/fJtmmjjmSLyxuh1a8e4uQ8h8fZhEHDFqcecjOh/7P2URRTxuOiceca/4ecL0MzKVtVrvddf61jidsWALqiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmHAwAuLtww6S7Kx24cCQt5tMxYWDkSMHxAXTvM1SXo=;
 b=iLB8rTl3Y9sxbF7cRtpcuH4aZpoMvS1vvS2Ck5U/mb3Rg6y1IXXMMNHyl4BeVY1am0sDzU7kQpn9vvyxlx2VLovJAiqrTM/rwW+D4kCUAwIs8n3ZX/aMRa68gKt2WkZFXoTtSTmy3L5EB6LDfIvAL94AiYGCVcBt3U1rlxtL1TbgVxfBlqa5elZrLxvs9ySJsll5stQFqBORSUDErqHZb8xJguGFJmcV0JWRxCTFNu6JlGLbO/l7A1H1Vg/SHFb0Zn+ufz8yJzStix4NwotY6OHkZO3MMU2kE5C59QNnIttL3aO0MVqXAsMO6JfOgftzx520xJqOnEnNeP67wbHFBQ==
Received: from SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) by TYUPR04MB6724.apcprd04.prod.outlook.com
 (2603:1096:400:35c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:24:42 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::d2) by SI2PR01CA0054.outlook.office365.com
 (2603:1096:4:193::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:24:41
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
Subject: [PATCH v12 03/28] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date: Fri, 16 Aug 2024 17:23:50 +0800
Message-Id: <20240816092417.3651434-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|TYUPR04MB6724:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9fda0940-abd3-4ed4-a0d9-08dcbdd54251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a1m+8xE/Q/4gsdnD43ce+abeqhc00EwsB4TsFXgYnVjYKp1pfeQFzwrhQ1Bz?=
 =?us-ascii?Q?WHZju9/iMIkbrGBmkCJVGQCSNnF9wcsz68PLz4ImzWYii16nfVPY0Ir+UfAz?=
 =?us-ascii?Q?+TqQ3ZthmtOweiQaV4/1DBrSXsoUm705O3ilHAX6olxg4TQMtIpE/rd6Ymdo?=
 =?us-ascii?Q?VxoGAmpuRpl/U8+TEGqbYlrwMSpup5zOsiLGy76ZcTuYVkC29RlS3hrc7OW5?=
 =?us-ascii?Q?MaF9RyjPLJ0KdBrDQTpXkOLCMTB5ePSAb/qvz7pPboexAvbQqdb8vlaYP90z?=
 =?us-ascii?Q?ml9+NVO6IyQ87ogD8l/LiOkp9kTkK67kWWPyzh+IfSAJ0MS3wuZt04DmE91E?=
 =?us-ascii?Q?/LtCsyJLxAyPBkuSOoUZ42pmuVkSMxHIWllMDugI/gcMe7p+BuRdJE6Zm9j2?=
 =?us-ascii?Q?LAvo6ocGb3qtZpH2eAOOlclb4tIXvnYPD6jyNCHnEHE9gCd/Olf9qNeibW2x?=
 =?us-ascii?Q?MqKw9653uTHHJ2VHbNS5G723jYG/3caTr+yyzxYBJnkIXuXemLKBYxQs52jl?=
 =?us-ascii?Q?unBLbk8ZYS/q25qbpTfqkcN8Hhvp849AlUplxU/kVdMsffd1YHmZlm1AIJWX?=
 =?us-ascii?Q?oNXtt+iV3G+Csy+CAVXHJne44axYhVwFvLRUUuaMo+ZB1k3qZ3odYNYE5uEc?=
 =?us-ascii?Q?wWqDTa9VS1arlG0oJEeZb0OvdwO2eUeeBbm+Z8/dr7I7i+RR9atyE3CobPUn?=
 =?us-ascii?Q?ktlTpSdOexpFiDuFa+ihQNE4kbo8lmPlF8Jh3usL3VxkDERJG+7GCRHW6zwd?=
 =?us-ascii?Q?bneS18HVHgUkcEwB8yFPZvClGYhtLikA0BoknbiH5tBKKnU6HVydnAPQlDpB?=
 =?us-ascii?Q?75nIbxzQcYqvZtYlJ3r4dMrSDkXsl9CS9wfaKmdDP8eEtrelaLiNAQ3Rrpww?=
 =?us-ascii?Q?k4J2ED5tFtLfSJDT7+R+Pcb+ofbt0OONyGrak8zxv8ubnkO/MO1E3cgYZdSk?=
 =?us-ascii?Q?ieINv5+c40BAmwSp7ZHmJpxZ8H5ttOGZ1UvrflpQB+pzdamwzJ5Fk04QdAxA?=
 =?us-ascii?Q?ThUT50PSNUCI18RVHgfgl/Cgfk2ImmsgjcQKaV6hSMQX4vu36XW5wnu27wyb?=
 =?us-ascii?Q?8rhZIoIN+3l/kJB6kL0vZ9ZLIoCzIPXkpz/6yRCD0tuUnjlMZ+kl3x3fF5H4?=
 =?us-ascii?Q?DVaZmg4i53cxHpv7M0iPowBj/LpmB5pKxVKuz5tSZnChN8v6tntoVIdBrDqT?=
 =?us-ascii?Q?NYoptfzfIHfsnXvfAWEKAgmp7wf+Il77D6F897is7FdV5w7S4i+dq73m/qhQ?=
 =?us-ascii?Q?pB4Al/tEvvjI8Q96Dtcv6wQu8GJnp0cMnjxPy5L6s8N1lxDG0FK9LQmb0ktK?=
 =?us-ascii?Q?NmoHfCQhLVFgTiX8JFstTkQGIrPABwVH7zt06oeNCMpRavtmxq8Qm2ToDQox?=
 =?us-ascii?Q?8NrI938kE3sCqyuvhougAI8fgB+4Ao18tkX8T3N/Ek83ci45xIhSsIoOifgD?=
 =?us-ascii?Q?aLoohA/j6gWPFIpkQWwhr/83hw1JnnPJ?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:24:41.5909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fda0940-abd3-4ed4-a0d9-08dcbdd54251
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6724

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0d659ee2bc19..575abdd530df 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -53,6 +53,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1


