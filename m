Return-Path: <linux-kernel+bounces-256980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FC937383
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAFC281737
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A03BBD8;
	Fri, 19 Jul 2024 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="HIwZmbyv"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2074.outbound.protection.outlook.com [40.107.117.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9769959;
	Fri, 19 Jul 2024 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721368782; cv=fail; b=hjV767N5r4dwapCIk0Vc7IdoLEBrJpPlSJzMGf1/PemwzQ81CcCWtcqRL71atgPjvZs7cvwYMExzCpWBi3omk3KLxjJqM655uy+50Pfp8Btgb48iZ/faYoQwkRI22+vU1H3eu6TM/j64GdLEUfV3xJQbjGalr+WSYQbxoQAp7w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721368782; c=relaxed/simple;
	bh=mDZZJlkVcsKOGKmKvCEVvBfa6/zQ+Wv7iupq0qbeGNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsSAcbahlHN4ITebP8mvotSqZpzcwCE3V7zooWoBr5QkSNRHKUUsA/IQOjeKu6OugwDpdr2fasHHGiVvv4G4AhgE8qxfC1bT/5CO9i6D+55wd1yqqUq9RXyjO8ViEHTk3HhbzbptkAVboCmIKWinUNlliPEHXIlpaNh5RTAPqWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=HIwZmbyv; arc=fail smtp.client-ip=40.107.117.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W14RQQiOBOvE9khQxqIjF2rmU97TFHGPKxG05My9XzzcepwXnH2hDJvtpSdj8DpefjXtU0LYiL3qqMcjDmKaskTxVmyKb0XYSjWIYGGy0Zas7tLA19bZrx4veJrdTkghlTzK39jYp10vIHAQ5fKEg67JCOY0ziS6uwOCYc0aJKNJICZkkBLBjx5k5nVl8ygt+ezxTSck6BNx8qCVELPuNTnGW2at8y0pu5zlwBRqB9Fb0pDqUzb7yblQLRRLUMt5JBi5rlOfYwbv7EFoJs2Ng36y+w9rxBWt10fzpNYK9jgCooR5AmvRgmXdXc0f/psAJ8v3DGZDuo3wHfRsdEonug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=bJWToOJE1B/kNFqpd++ZfprfUFQEbxTZvuy5jIYBCqED0YkOSx2hv+GJS/6B8r5SFVKsWmjAzHlnrUhSimIQ0R1b49MxnjaQzsbNe6Ry1/aNYoTK1dvXwq1+DNAzLnuBY6dN5rHxo6oz9G2FmjyeTxchMsKPzlcQP6CZi20lTdkWXfXlfsNtDhXUaopxlUMVEeESDbIUL53PoPrk3awfs+x5b5tIuR+0ADKCW0lUj+x672pu2YysWnG44w8skPmcNm9Fw8BC6xULrBEWHoZTzZYrXKUeZxtqzdHbOuKtaXKLODqV3XKK4Q5sfXKdoZ0WM6Oru1Iq50esecOAoKiykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/dqJuii+ID5NkttuzvqI67JF2qX2ZPzbFRrGdWVquY=;
 b=HIwZmbyvkl5pmTZBz3SMw19bi68K+xWhItHiwGAWMp1Rfd+NKsUm/MRFHZHcqqev/X9kFsz5xHP5Mb1uMT2WelnHbLi0jOBuS0Iv/7/SqEdHHyWhmFiCKaNoV6TykGkrEVHR1+P2bugsAc9Cbs0VDiIm4mgqeJFy41M3NOhQfQN7bTVRuZ/HPzYb+UMHcFkGaieHageraGrvcekLfy+QblQUUeW2ZIUMJmeq2FcQ+1zRhY92flw2kGwHdVd0/5NCwF4PQxG/HbpmKjUHfM8F2vgYQLdYlbbrywKJ8+0TpUZrlSJ9MB+Zi2cc0Wfnbl8dzuc0wDap0d2CsOdKkbS5vQ==
Received: from KL1PR0401CA0031.apcprd04.prod.outlook.com (2603:1096:820:e::18)
 by OS8PR04MB8122.apcprd04.prod.outlook.com (2603:1096:604:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13; Fri, 19 Jul
 2024 05:59:36 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:820:e:cafe::1) by KL1PR0401CA0031.outlook.office365.com
 (2603:1096:820:e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Fri, 19 Jul 2024 05:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Fri, 19 Jul 2024 05:59:35
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
Subject: [PATCH v10 05/27] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date: Fri, 19 Jul 2024 13:58:34 +0800
Message-Id: <20240719055859.4166887-6-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|OS8PR04MB8122:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf81f268-140c-4ea6-2b2a-08dca7b7f7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|34020700016|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1pyw3XixiylsNny+GBM1bY2e49PqSQGj/bKEOz31hBmUm46E/YFalBn/o0+Y?=
 =?us-ascii?Q?BJubWNL+PDBY3tY8iGDkCjN2Ob8H0+l04/15KH4liQW9ZPkk+7KGK6LdUz9P?=
 =?us-ascii?Q?WpjeRU63PlIAoDyE0fl4EiPSJhpoEi2o0soJskOzntLQMTojlZW2NGfUy7XC?=
 =?us-ascii?Q?Sj9BIc9YnYCM5lDduPUPTbPY4RuUSGRxKYIwnW4C37iiSD3rSbyILKqPRuuF?=
 =?us-ascii?Q?snOh34goeAZky4TvhDw1SdHQH8SCkipIdrP93po83X5xYcJT9SzUDZXZeGRd?=
 =?us-ascii?Q?lwKK17A4SxitqWYsxshL3MKI/Kx9GTtgN3HYDC8csBFInWV39PvXc1cbZSFQ?=
 =?us-ascii?Q?xW5B8Uzl8sEeWNoZREoE5aBj/ib4zfzzD2aPTq+k//WkaAPLtjF4O/eARVD3?=
 =?us-ascii?Q?5izLkArByByFEy3YKBi30vpsaZi7O9uz3WP78ZL+h0Fo7aDPcZM9ZzXR7FLb?=
 =?us-ascii?Q?MayZY5epDDP8qNWRCaqdaJbUblV8o6/56ceebcne0/ungI06NTu7vsjym/pq?=
 =?us-ascii?Q?gJFp9QLZQOqeLUR2vrU3UKtotXMp6UY8Obyl1qtNP/dPriZ42jYDZsPwrSQo?=
 =?us-ascii?Q?8W+hYtaa/tp974xcwnTkFaHVzK00Cf5oGPK15m8g7nY4ZvqIVOw2H7RaoaAY?=
 =?us-ascii?Q?P+kUNcmRrVODn4kwGmAIXxQl0hGj6vDJnUPkQuZvddOwYyXxR7jvv8GUq7wY?=
 =?us-ascii?Q?kk9SK237JZde5s8lXrapVud8/q6FA/nPvJYSJF0W21o6errnnvjg4tNVQY+w?=
 =?us-ascii?Q?9RMOjr1rjNf4fTop6U9FiT+tQQwHPB15qwH4RGSD1dasMTwQeQv2T6c9FtMl?=
 =?us-ascii?Q?tiu0v2MCDGdXzfAyEI4IitAEWD3cKxa/M7WE+XsVy1eILAvPfqsGiJ58lv18?=
 =?us-ascii?Q?36Jc8jdA5anr6LH7DFjoHO/l8TpdeCQ/BDAhVgQ5jP47YoSo4raPok4tvtOF?=
 =?us-ascii?Q?mDVkMyy6SA655HiEwfYJJbLhwRnWMVjsz3j5LkxVY1T0VR7eJx7LqgTc0ngE?=
 =?us-ascii?Q?CvZyd9MJEpCF0FkcdRkeA04MCnRNq6JTzTRoBquRlnI3jbPMZ3m3NkHRSUNJ?=
 =?us-ascii?Q?sNP8E6bFbbwFTHS814Ra9m9IRF0/PmoWgeQoJW3BHP+XMy8h4Y50E1X8aXDb?=
 =?us-ascii?Q?HuQzc7VVPQC066Ymq6VHES8BBgQYmOLucPGlqU4KWPjDlPUof5e+okf5ImTg?=
 =?us-ascii?Q?usi1M7jYuBOvtq/PTTbzS2yKIiHeMEgWoKI4KPPh1BLN7NPMD9EmHXN4Fgg0?=
 =?us-ascii?Q?GfScMJqRgqWyvpCqxnJa0Q9yJyY6c9ivryeTqgroFirulOazfdX3k/hIp2dz?=
 =?us-ascii?Q?ao/l8Z2E5O+G55f/THKE2DPyTZXRy5TFExylEbFJvoPpbOG0o7rnZThuOdtc?=
 =?us-ascii?Q?BnInYASM4oXY3Xydl0HMVLgrhizOsM5CPXT4oFK2Qf5JTvAdftNd0cSfcsBH?=
 =?us-ascii?Q?XHeuu9M/7Qkb3FPufbGKAaDcF8VNRK4m?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(34020700016)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 05:59:35.4385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf81f268-140c-4ea6-2b2a-08dca7b7f7b9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8122

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index b0643e8aefee..a708e56b7ec3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1


