Return-Path: <linux-kernel+bounces-187240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327958CCEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C5B22413
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A913D2A6;
	Thu, 23 May 2024 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="iVOiFqQr"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2058.outbound.protection.outlook.com [40.107.215.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266D14601A;
	Thu, 23 May 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455928; cv=fail; b=FVHkxZEz19WeYlDbmWBPWPY0XgFjTtN+cCfHdxGzysGdqasF5JgC3lXwngypYpk06wILBTVRhE3WuoDu3MfbCbPZU0yJIACQS5v89hVZA2ZRB0QcZi1VuSR5llOB3hH8y0I2eQJNLp4w0B0M7FGl5OKKK9rtqjuOtCbGlc0p7xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455928; c=relaxed/simple;
	bh=AzUdi0zJNRywe/hzeEuDOFHkQ4MQRZ8PHccKu/FaOKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBL5LY6YFVqvikXzO4hh1S0F6Scm9BQSR5mPBAoJtTcvu+exIkQM11mI8B/e9Hl+RaIN+m96xVzB4yGLrkZggep69oxXW3VbxcvmxOc17WUouQ4CiCWmrdo7eEGkbtBPy8guOp5T/kWGu3TJNVB4zR2e8XGYH4wbSG4NardR0jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=iVOiFqQr; arc=fail smtp.client-ip=40.107.215.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blEuI6ob85YlBA70cdPiAFLTbUwGaDHCtD2By5WdWyPREDkVXxfAPjO8212Pdyh08QsC7p7xTTssSIhW0x+p/eYW7RsbyP/n1y2Lr3FkF37YlN2GbA/L06ZWL8Qo7/dd2bk3uIwLe3oVy1K4JGqtk5CGFzbNZua2Zbn01FddbIzYRMCa2s7iud+pZSU+ZUyrwy105opoXA7q9j3TcXhj8mTcPonhKFa4Cwug8sxWOEnb7gPPKxKIBOcbu5x/tjj46AGXe232dMs/JIkmcSN7O2YkaBQ7RunJYxBfCV2FNpEFj4INP2gsAClPnOryEI2uL7gbRFpJgehnqptSiKn/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HypuHXBWroWYlUbZ7+/af+Usbe6kheKPtiyQQytzoQE=;
 b=YqfmHQCwlKjgU/9433+dtiP0cgeblDlsqWK9PNn27BVJijuVgEshw8Bq3GTxzpHyGdBY1MQRwO/nWdWgkIaiX5Me80msI2e+nI8edptoNX0chUA8ZIj5jIDCzNJk0TbFrlBZDokleTC+N4jqlV/us4m3DcLPjpYUe4h5V/BueXdDfTQpJ4DbIi01ixBdHZ5h9VjEbOyH+Xw6FKY2Bdt4K5Ro92xt7mkVI/kIOl01/2ShFgUXlNm/pDUHA5J4w+CiyMg67DS1yH4z3denUFs3Cd6TsyWyRzA11goDDolv5m38sedXI+tAsw0YkERMRaRR82jArdd3wNaJgXp6TwQmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HypuHXBWroWYlUbZ7+/af+Usbe6kheKPtiyQQytzoQE=;
 b=iVOiFqQrsCyMxq5kIWhAqw9OnlI+tskSgzgQ55HN528QRypsMnKqgDeame/vn0wrOX/ggSfOLzL3lPZ3rVvTTUE0ergjuikUJJHcWQg7Bxkq1a5U01bCcZlbsCErlA7WgQp7Y6/PVrUcc78jsOZPlwGgsj9LbFb0aZYeWg65jeOaL9EFcXEvt1I8Dl9XuiJ/lJCIsrAp+pkjtfCGQIBMeVL2PKuYhZjeD1G9dNza6zlJfrNyTN2UdJOv/YjSq9n7IcXvouJuq5fRpIZXW7Tp4dnlQyMZxzhUge2ZJq9e3nXZAlYLfzATwtptLvmhbFprr7DCWb21OXXkWlFFToTS3A==
Received: from PS2PR03CA0019.apcprd03.prod.outlook.com (2603:1096:300:5b::31)
 by KL1PR04MB7210.apcprd04.prod.outlook.com (2603:1096:820:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 09:18:41 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::90) by PS2PR03CA0019.outlook.office365.com
 (2603:1096:300:5b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:40
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
Subject: [PATCH v8 08/23] ARM: dts: aspeed: yosemite4: Remove space for adm1272 compatible
Date: Thu, 23 May 2024 17:17:55 +0800
Message-Id: <20240523091812.2032933-9-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|KL1PR04MB7210:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 694be20c-e437-43a6-46d3-08dc7b095628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400017|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?++Lt7sOOK6yJtms1pR0AcNzCrk/PKz5X+6qz6Oq/Z3/tnJp6uiU3hKp/3ZXD?=
 =?us-ascii?Q?J6jHR7cxOnRHb/S7IIR//oGw1aXH1hEirle0bb6SdQ1aHs+LRUOAgdIB0SbG?=
 =?us-ascii?Q?cze8ZP1GdBsPWXbSPgGBjlroqWcUOSJdwnhQTTqQaj6sRMBVk6L3K6ZT6NNa?=
 =?us-ascii?Q?7egXdQcLujdXe/1zU9LAbXWF/yNtR/2x7McpXra35JcM9C9Zprev+p5fIz1g?=
 =?us-ascii?Q?k8vBev5jPjIl+1j9Kle7D0jknia2/0Vr02oEa7SzUNAviYMoOpObi/kl9Uau?=
 =?us-ascii?Q?ySqZNy+0eztEvj47vTYWktJpUF2Murl1d/+nRxvdv3DQ+pnXx8sqGDDy2yc3?=
 =?us-ascii?Q?o+sp4l4MczttlnHtyephyLqoIfkCUXddE0tL107nREuqujO7t8BDy0BcOdfI?=
 =?us-ascii?Q?GTUXmZQBcuuWCXCjlRcC8Cc0AteXSfNZDD0rg1Pqg2yC+0/alF9GI6gCL8Md?=
 =?us-ascii?Q?XGfhoJ6eocCkeXZF2H6BhGvavRXTfaR75kIv3X0BnWsQqmSuKOnlfcddbhh3?=
 =?us-ascii?Q?EVOBYPqTTVh9GSx2FkLnw2bknA82jZVaQzx001ETa8m5au+Pm+RypJgp3LpK?=
 =?us-ascii?Q?vu4K130VTs6qs4yDCbHWUCQ3EWZq5zDaFRU6+972DmDtQDrPs9LehTZF5HK6?=
 =?us-ascii?Q?soqWqxHn/txl9tJqOKLu67Ejq8omcDeqykQJsQZTQw+GSIsm+fUiOVIZ1kU/?=
 =?us-ascii?Q?dO21XQZuqKe5etyuTXtcvr4CiXpA2S46I//tYHfcKulskwQvZvlHHHk3lF31?=
 =?us-ascii?Q?2BJbFTEzyKdfSME2vYwYo1mz7OejbG79BEnUGyhdguWPYWYK0Dwv9SGB1Zl+?=
 =?us-ascii?Q?tj4s2GQjmXmwTc7uIvdvvTII8AK/Ujp0RFlQ79a6TPbagC7KMNv5H2r+2V4e?=
 =?us-ascii?Q?qfyedEDbvjv631fxOXLP07lmu8T5Mp/27thghuQS+P5+H+lCD5157I/M85aw?=
 =?us-ascii?Q?wGHBzA42Mt/+eO96n0gUOJ6iUYULXjh522X9JF+5ywh7KSvaTJxTqOyzxJ5d?=
 =?us-ascii?Q?s9J+7LBB7BaaSN/9AXnJakeJvlmK0wPVIsviLOnG/5WBGWgw6RuvIGMtUiHh?=
 =?us-ascii?Q?kbvOW6KY6BhwtzxiokHXq0sjvmalAHeQJVUmh2msz7rimb7YYD8hU7uMLaVt?=
 =?us-ascii?Q?KuCwig4S5BhMmsqPgdtZHm1otCa4oPYbuMeyU2O0c/TePCzhFXU91IJE6CiD?=
 =?us-ascii?Q?cc+3V/9oG4BQVE+jRorDmTPoGW2sSS9c5teMk2LZ+VbVbJiOTVBxv4XTS1Y8?=
 =?us-ascii?Q?pllRHhBSHYWAhE7q1hDaLW1ztlpl5QN2h6ti1iz+ukR9c16Ke1burfBXFcP7?=
 =?us-ascii?Q?SjQ6Oby6Kh+Ehac3SJP35VZStU5JcTz+RDi53fpCzcO3VUcN8FyuQzsr0WVo?=
 =?us-ascii?Q?EnnwDf/90p88P4K3PJybXtmgFAWt?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400017)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:40.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694be20c-e437-43a6-46d3-08dc7b095628
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7210

Remove space for adm1272 compatible

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 33dcb2451ae3..ee11b3b8e81f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -821,12 +821,12 @@ imux29: i2c@1 {
 &i2c11 {
 	status = "okay";
 	power-sensor@10 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x10>;
 	};
 
 	power-sensor@12 {
-		compatible = "adi, adm1272";
+		compatible = "adi,adm1272";
 		reg = <0x12>;
 	};
 
-- 
2.25.1


