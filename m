Return-Path: <linux-kernel+bounces-348694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A934598EAAB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360F01F23331
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D10143C5D;
	Thu,  3 Oct 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="rPiJscTn"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010031.outbound.protection.outlook.com [52.101.128.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07E13CA95;
	Thu,  3 Oct 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941394; cv=fail; b=myUtxOiEx8zHiX5X0GF3T7dnxopCHK9fnijHQE/yn2GswaWDjk2/LNfKzaZYKo3liPH27isi02SZz83Ho6kkrB0FTDMyAxC46x+QliWpfQHEeSdQTKLNp5gRKds8VBpp/MWCiiTXRIC6nN2c/9KG/GmzBlXHBkqACz2VyqxM1jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941394; c=relaxed/simple;
	bh=AaLqHlzanEnJl9WXpqFz4c51z/LuUo2Tp0ctQyMxESQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi/3/UF8D9NsZG15MbM7knz33QUbhyD/qisddfcpmf+SFzFJmQkUrHF3U2GjClNIaOi/9JiS5xuebl+C305aQuyGEeHR2FKWHji7xvhZOVQEBu32cQUfDLSGmX0zGxXg966Mvdi/0TTSIW4Nqgu6vr38cg/Ou2AmpVrxytjSKoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=rPiJscTn; arc=fail smtp.client-ip=52.101.128.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CU6hFIA/OclnNpG9aeiICxyBq5m+WktO4ZYzYQTlLRPwbgwenHmoyt41UdXjRBK5zVk416YRdJjmi/GzuvdUQ/mkK3pNE0OMqcw3A6+nr3Rb0WCsKu4haA7SnCzzIgjZR+v0jSka4ffU3fZVqZeYnZvLrHuFixwU0nubQYjlY5eNfHRaleUv8VLzPiiujK5ZpFSk/6rdhXq+ZsbgXZQuSxpDpW//BxfV3AdiMjpyJ2OUj4Y1yCFQroEJyc5yBjq2L3eneG/TGj3K7Wt8pIGmdxVdkpg4buFFmQOVYv7GC8rQi2VLWh12TgXEQ00tOvuYzl7GeB2mC/2vUUXa4aIMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiBJ5q+bi/IjTKgy5bY8+hHYQMTUMoy9jFuZwzN6mzw=;
 b=LEBO7LBqy4bmwv4Kn4GICMv6uYKz1D1BPp0r2oI8owkqMGWTzF3ExYVDQyi9Buq8z4wviXfbfI+dejvYirpwFQWgjduY8ddx31NcRov2jvIro0DSH4s6R8d+SjVVY9eL3pkhq8M9z9+8jK73H7WlLl3BsQIK5t7GRCMPJzcKfqG5epgEBi88ARyqyz9vj03PBSfjWJpVi5UCUgKKJ/0F+o5KndhAVhcN1VNP7Vgq/UEuYpMAYGgkvgBoNgXVU+ScjS/wn/w2iq40SAIjoKRvNeR7oTJ0DDSXeyllIAWxPc1bPO09Etcl2nI1VP+ZALPgr/bZDWT6jaEgBC9tWdAv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiBJ5q+bi/IjTKgy5bY8+hHYQMTUMoy9jFuZwzN6mzw=;
 b=rPiJscTnGpm2e1h9ctUHln6X0zDmQhehz9/aT5s36nExx826EK0lD3pX1p3mqwZ4au9W7OHvSOpI84uqMK/32D5YX8pSbC0j4lFwXZIFRjqFWhYZkMEq+goxrDWNCd5kBu4P4og6clwqoKofYxwZza33RnCDyxCFgM6b5N4COyg5ialCCRvGoro6XhxFO83udXJVWx03QFLh9ifUo97ivSw3jcoWIVF+P5kZ7GOxLT0ap2WiM+skSRMHDFTi/dySBAPt3mgI/okMqKauhdF9pqudb2Rp4fa9vysgHb6L2PXBt+vK5/+rylTGBzoGKh9TFPhtDxxNrwfatjG/CUlngw==
Received: from SI2PR02CA0002.apcprd02.prod.outlook.com (2603:1096:4:194::22)
 by SEZPR04MB8336.apcprd04.prod.outlook.com (2603:1096:101:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 07:43:04 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:194:cafe::1e) by SI2PR02CA0002.outlook.office365.com
 (2603:1096:4:194::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Thu, 3 Oct 2024 07:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7918.13 via Frontend Transport; Thu, 3 Oct 2024 07:43:03
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] ARM: dts: aspeed: yosemite4: Add required properties for IOE on fan boards
Date: Thu,  3 Oct 2024 15:42:45 +0800
Message-Id: <20241003074251.3818101-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|SEZPR04MB8336:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 246a350a-8958-4e68-45bd-08dce37f038e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WesgE4TxySCx5UVvX22sSJneu/SDT8+lXD/8BU10uBFc5kE4CNgs7MB4tFt9?=
 =?us-ascii?Q?TAiKu15eStAvz+DZ4R1dTX6YxpXLPecUIzyNx4XUdub4v74DZMCTE/Xuawwt?=
 =?us-ascii?Q?My9G12iQg1sIurt1BfPmfEGmQe0d6QgfBmjpMlStWJ57NH0wUqBUZn69Iisq?=
 =?us-ascii?Q?d22gmuSmeCycAnGBwir7LyJ6lL/UNOIw8BMO751gwk/PdTPu4fMB/H4/JgsI?=
 =?us-ascii?Q?hZT9yMTZwgYYgZammm7WdVBpMQ4vmdFuo6Ok/lJNDqnUztylFqS0CyyCrTcL?=
 =?us-ascii?Q?8Sbjemx8xIivZ1F4P4+T2SkeHoyB5E4NBVGphNTBNYTf2kntjZMnb++sap3O?=
 =?us-ascii?Q?x4fgfxQWWnGJoYq3S2jGlSV9lcTNn6BL6GnwZ4/ASepS1R/BO1YqZVlxDRJe?=
 =?us-ascii?Q?gHKOVh++I+uBn/DIF775ARXrVCA7CnlBLfk6xCZAFdC9fh28vWE8BAX/xsN6?=
 =?us-ascii?Q?y3i92gPJtHYeNKG9MuZliiHjUiWRSufNtIjciDPu1bj54+/B+ZUzgP426IiO?=
 =?us-ascii?Q?wt3yfZ4CpSyd2mwGJyj9bgcXZQh4uosaoAsRsMbjUROqD1dE7lAOLppl7thE?=
 =?us-ascii?Q?JJJGzdsQBV5RJI7n7qI/ienVCGrzXnReWuCh3Z3MJKh5t2SySQ5Spu1qcP86?=
 =?us-ascii?Q?WSKae1g44ToQZl1/PCwQPs46Rc7ZeFU5hOwNvlBTj8zymF1f9l/nSrpT2Inc?=
 =?us-ascii?Q?xscefnnqT3pYL6oav4mYJoCW8IGm2iIk0m5bfy4bLl6fHYbgb48aLu227HSQ?=
 =?us-ascii?Q?f6f7BgKwvfP2XxQ7UaV3Dm24Iv589GnKvaX9j1KWLiYnsAois4Lr1JFFwdc1?=
 =?us-ascii?Q?rkBAxwBp1f9TfwZxiR4rm9EWoZtwXnv1QF+WhiIHqTcFnH4igWqpTEN4k5gi?=
 =?us-ascii?Q?zXlUYsd9Z/rwKK0yrBu0vG1UDrbbRh34F5W1KRrGo92ZC7KwhFlecz1LxA3m?=
 =?us-ascii?Q?6u+Oy8Zg6bQv0U0xLo8UuUS78mutcK0Zcby9vjsF1Ca3S6OdkpNZ5URjt9W4?=
 =?us-ascii?Q?Pz5kpAFLZEvjyoZ2lat5eh6O2gYHBvLjhV8fFiuVBXByiwvMBYC9MRva/dqE?=
 =?us-ascii?Q?rqW7+YO+HTPPKIWbEzAskTx5mvwpCSOkrBTkowuyBwifoUumyoTMuQo6TOd6?=
 =?us-ascii?Q?8NO0iBSIlXIQUoAqTTugvQK1Val8CZNaM2xsgl+JGb3wO4iZURBkb1UNhMx1?=
 =?us-ascii?Q?RP2uHn3UiYhQ3ieAQG1JDPXf1El4kip3OvdCx6impokBvB8f1UyhvlExevxG?=
 =?us-ascii?Q?sf3S3/I+LhBSxpaxL/x+plDDjAYHr64VT6FTnsRalzYMqJYn4WYCeGczvr83?=
 =?us-ascii?Q?091Wk+BAUCu8qC80yVqpM6pJB/SrwE8rh0UDxfpuKRxLSeZt8WbXFBZ7JbPz?=
 =?us-ascii?Q?CRHvVjFLCNpUEefuCdB3QfoHPiCI?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 07:43:03.2275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246a350a-8958-4e68-45bd-08dce37f038e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB8336

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Add the required properties for IO expander on fan boards.

Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC")
Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 62fe4d513852..5a995d8c326a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1124,6 +1124,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
@@ -1174,6 +1176,8 @@ pwm@20{
 			gpio@22{
 				compatible = "ti,tca6424";
 				reg = <0x22>;
+				gpio-controller;
+				#gpio-cells = <2>;
 			};
 
 			pwm@23{
-- 
2.25.1


