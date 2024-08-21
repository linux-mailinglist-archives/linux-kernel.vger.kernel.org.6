Return-Path: <linux-kernel+bounces-295273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4A959938
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE49FB23450
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B511FB2D6;
	Wed, 21 Aug 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="Wev5hCuU"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010020.outbound.protection.outlook.com [52.101.128.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA12024F8;
	Wed, 21 Aug 2024 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233442; cv=fail; b=nps1H2VjvzRTZq0nIunQm+1jClUCHXHQKFUNWOIhj5/kDq/k11q/Bl17zWqF0RAhsxR26EgSZKJhhgyNka33nB/IaD85G48euPA5M/O0aZ22narhKmE1ksLdBu21ioqWsUFW/JkH85MdQ4YY6gWs4cwwcKlH+at88pvAQyQtRrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233442; c=relaxed/simple;
	bh=jW0gVemZ4cl5PWpH2fNOD4IT7gRDiRPR9A8KhbqEULc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4wU4VYrj4p/Yxn4sRQHZ/Kr4vGW1IBW4f8lmLG9TNpx4aslnYA+anBpoK5oVYkDuONc4O4wv3SmEsOMkWE8rt6Y4ZY3Xp5sV2FxYOkuVrFrpeLqz9Pdglh4ctRuDdxqgm9Uh9smIge6eW5FwdyJr/9xe5WScz8U5DInw1grwDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=Wev5hCuU; arc=fail smtp.client-ip=52.101.128.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFJKbeKCIP7HXZD/zjkQ6AaJ4mismdmrjvxJQA4C2/2DRvUy07vbucyRExvaq6OZjkw5nsp3n1wbC3IZ6/KVbzKJlMT2XuUkKCKJGum+EYFI/DCmeR3zADKwQa8zYLphRs6Jn5/jhkNhOiCQe0gS9aiNc3eOg9rbSI0UsGSGEE1wlZhRr4g7ThhKcjjxL6BmrLnwQwXG708AVnmt+hCAFvX/fhKO14Yw0tl4lGTCezUSvaZPWE/kMRU5TW48UZ/hhG058S/u+pLD2Li2tv8yb6DxrnRD0CB9bFGmyI2t21fJWevs2DaFYLmIyKCY4oa2nQZTMrxEKYmobzBZHOgFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=X64tpwHDGmO7szOQQ+ii9BMAOP3x7dQd1iFUA5iGxNslGu8/8VraPKFoKCW5Ki+yfrGLDq+GL918tadM0Z08Xij9LNcpUgN/1zw0jUCiGaNGofmhdyWdt3nigAIIQW9S/8jfJeHImC6f1AlNF5IDeMaG+l2ysdWmu22DI9FBfYw4wC3+rE+mMf20PkoyfbyNMWd7uz++s7X1z4ZuMSCzklJMExgfesAqogMpRpMl6hFXnQk/E+JC8JdEC3TW49k5EqbaRRHti86h6yy9Og+l8ZzZN1hv7CB7ksMxMDvc2FErOfYA166ar9CC2bZYX7gYLo3a3vNS/PH/ZsyvcXN87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=Wev5hCuUwQmndxT2JKZrgKh6mzNtRUyD2/S1eX4ezoEymrLj759f3ikgvFceTiRoHgY1Ss1ITmvi3o9i8pt7VjBB4codTplKPsj9rTMGZhXycVOrmeAyPuegPkFEm+fWet3k3XU6oIrs63PvZ24psKjaYffD+X0R3q25dCTMCO82Yqb3FV8cKkf3DNCJnqwoZgXMsob7TMie7icNeKTyWGY2pUi9FEDYE5yewGajHCa7G+jLUQmQ8SM5FTbd7KA61UTtjhsKebobu2u3m8o+qI/2urLUhBPsGs1qtsCD9u4Kd+bLhwrR+O/TQXI+ElYGvH/npxyiHMzzcgWgIxzNaw==
Received: from SI2PR02CA0025.apcprd02.prod.outlook.com (2603:1096:4:195::21)
 by SEYPR04MB7062.apcprd04.prod.outlook.com (2603:1096:101:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Wed, 21 Aug
 2024 09:42:29 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::4) by SI2PR02CA0025.outlook.office365.com
 (2603:1096:4:195::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:28 +0000
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
Subject: [PATCH v13 15/29] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Wed, 21 Aug 2024 17:40:26 +0800
Message-Id: <20240821094043.4126132-16-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240821094043.4126132-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEYPR04MB7062:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 05c83bef-5704-456f-87e1-08dcc1c592a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ejyTV3s3jeqlxRJYcen/PKNl7FJ6H8FRLC9QC5A4gz/xkZO37iBhDoL1nKuP?=
 =?us-ascii?Q?2yTOJL4KoR4Z9OKWigCoFK2DqpHZx1gs7qZfgo+mRxxJ81FRbG7PEK2hdCCC?=
 =?us-ascii?Q?mlNDNm7gn+IR0ezMCVNSARE153JKfofzR05dCP5A/sCveMw+WpYpCg8hIZXw?=
 =?us-ascii?Q?5V3VKrO/IRKNGbfLiB+N7sy++b3rYln4mm9kgH4JKvSnDCqP9GDDFKsTlbwd?=
 =?us-ascii?Q?dTipM0WFey6BVCCt2D+W7Q4XyLtFozF21jBgI6YOAiQtT2a7At3DA+9vOAxt?=
 =?us-ascii?Q?ZeZmx0IqqQxYs/3b3Qp5HbxMTJUZ/14eTSiat5CWLukWCR6YxLoI64MFfm2G?=
 =?us-ascii?Q?WKqT292b/FEUy2YoqttkkbzLxdBXpeE8M+Y6SJScdgxdgelSRoTiMEIz1LwH?=
 =?us-ascii?Q?lqJOjy+NpfPlxd22nHH57vn/MQZhfnRTuH9i+pMWtzGvWPrmuRZAgy44upnP?=
 =?us-ascii?Q?7xkx+YvFiEMuf8lOqwk+URa0FwP6Q/1GWPgUTroO9tmjnzWSHtRce5pUQhUB?=
 =?us-ascii?Q?XuVF44SEnXPI8I+1V1bk6JP/v8zlBXOPrPuYtPzsFlq0XlmUq7JxI61xmKSb?=
 =?us-ascii?Q?J6J6z6/zxdkUTyB1AiJJdcoJk9FGJl1y+SwX7h14KCEdehySdmZjp04qkRKF?=
 =?us-ascii?Q?ter+iY42yByjhpwy5XfTsNilEXsQFQrn1WB1KNPACtDdzPiojcyX4xYIv42C?=
 =?us-ascii?Q?78qdTV/TxtlXUbLAM0j1Oc08NrMTIKml/43P1JppO6T2mWvrZK7xl7c/XEYL?=
 =?us-ascii?Q?CW6+Quv+ML7Lvl9pQ00bvu1xWCg8F+gI2xKtEbeXKub4aCg6v0X51Zha8BQm?=
 =?us-ascii?Q?VzvXgfXiTIIKlfoBa0gNX7jqBXdutwAMfnZYNt8H49xWugUGt8CAZRXU7+QK?=
 =?us-ascii?Q?j1LTRrV+2Ykh+Wc50tgHCXp1sTWpe6wJYiHm7756xMdC2gcErMsxXm7lg3K3?=
 =?us-ascii?Q?sYnhVf0ukWUU/G09iOmAbYGsI+JrXJBys7bztcqaxPyxfgpkYyqLjZ1dz6T3?=
 =?us-ascii?Q?SxXs2sg7yXqBOSXvCQbU0fwcOHniCRYt/gtAx24TQyhbyozr8l4FREDjNh2b?=
 =?us-ascii?Q?qls1IJ9aZWEFTP6WNwsIC/4S/9cF3f/SjFpzSb8dVN3mbISoJwbLofr2Icfk?=
 =?us-ascii?Q?u2DfNi7uSwk3fVOIJ2M43BRijG9Ze+Kxf7rSwMbptvZCy5y12RUPEk2M15Fz?=
 =?us-ascii?Q?rK186a/C2G6jWkUWKXvyjbWSpu6bASqorr0TJik2RGiMbtJ0OYCFx8JkfK8O?=
 =?us-ascii?Q?dGBNPaxSEGkzWMcbN+WUH02IKWtzSdvVLVBu8IeZJWysPLXKuzvh2umS5deV?=
 =?us-ascii?Q?kMZIF+uhIFuI9Juhi7fYKGIt+mYSRbe/y8cvZRoc52fNvhqMTYpSA0KtZJ72?=
 =?us-ascii?Q?v3qHbOLvdrdXElup15r/HzKIFCcIeaLhVNquJMEqvvjxIycayykt0f3niwY4?=
 =?us-ascii?Q?Fj2CbdOxGus5ggS/WCvcs4EXrcOY1oso?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:28.6063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c83bef-5704-456f-87e1-08dcc1c592a7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7062

Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index df389b506b4b..c0497a1aa93e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1235,7 +1235,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1


