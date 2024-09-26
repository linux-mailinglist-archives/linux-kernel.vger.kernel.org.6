Return-Path: <linux-kernel+bounces-339850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A762986B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72211F21C48
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DAD18A6CF;
	Thu, 26 Sep 2024 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="FznEw2F5"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2087.outbound.protection.outlook.com [40.107.117.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AA188CC6;
	Thu, 26 Sep 2024 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727321324; cv=fail; b=lAqYAQcAQD+9KxK3X4KUoR28htmPsL1IZS8ipwKYFfP/6Atybn2p85DJylcKs816PZMyfjxa2DxYNCEp/o+OEZcrXCjrj0cb3DoX6QxPYzxO8YyU+S80rnUxvc/4TjTzRyEqbvc9/5BL629Is7t7P8IWtEnZTL2ZcZopx7d1PTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727321324; c=relaxed/simple;
	bh=/tQp2wOcNtG6FRnPg+f3EdBNXMlEAh0hdKuw/v9K3a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLMk7W0kE/5kx7F3qkpZGid2OFUEk1kt2Byr/QtrRQPrjgycHQBXf9qp+WwrOSegGNwv3rle9G47A5SfFzeY2qn60APmb5hP+vTFO7IuYAsjJc8kVJJUkMqiRXnSStg+C9Cgz6fP/BWT/KpH2NWZVCuGbxSUHa3oCl5PALwVCq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=FznEw2F5; arc=fail smtp.client-ip=40.107.117.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L69uvT+f9XlTVSaS+eDicaG8ZQC87wQbK4qLhr1vFBjC6tET/DqpvlIrwJmYLMA6HSL8xkpi6lJTPN13q2K8b5/CBWltEv25B9Jwpe7X4I81Dyp50KEpsoBzX5G5Nt1gMjAa7op8HEn0eP7c7iOjpZXgD6WPPbxApuM6iFKa6SQ7Kvt5bXFmvBafZJ80CSpvCIVe9185MpB4RwIwwEXzD1Y9JOLlZlUySOSi5hn0dh5zcTvV0cd251b+SS2rhSiGa3JU9nip2NjY7EfY9Rlarv5al6Sm5NtJgJisZEawp38TKhtxu/I2qELtPVelD1lNXKAeLLgwkwBZco57G4p+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VthJ90Bk5Al7wYIhOnvOz+lNd5ewuwm5wVjUsl1KImc=;
 b=YlWJg6UezVTnKYdHuzVB9y1Xmxz9ug+TVF4iOmV6bzFr9yprHFDipByqqnn6zxaIKtBu7QWuv6PKBigJBxlMxcgIK9S3jGS2GIiMxmY3WzJ/ggINPKPbckVFhABjA56xivj3LfWkaa/yB7sUC+B5nAp6MPhtHxkjiRzid8dXsoA48m6Pl/5Hu/+tNqVYZHwA3BFOmhMTocVF+VRzroFlfQp/5xm/8f/H2yE2OigmHZ5r/i9pCcvCuQnfFZqwEUeMjkxP6Xo6230R7RSo3Ll9zdQ8zo+adWeZuOyKHjt55E1pRwdgj62oYN59xUJjCGKPdNhezu4R/9yYkwzj6p64XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VthJ90Bk5Al7wYIhOnvOz+lNd5ewuwm5wVjUsl1KImc=;
 b=FznEw2F5eB4q7A+k+C9LaQllYJCSISTj4gpFYgNHmwZPmdRNI6SS8P/ZOgHLHEcfFMNuuXzETrQN9XHmJtGFxwpWIeMu2jUwarEi1afR/3N0eXziVLpMTUdCU5WtPGWsjlA7tZOE0Ou7t/S8KBZx4RkC9LQOMkqKRtpBpLDlUXOHwe5s2MQjAhLsnAkT/WF5dtGZ2BGvzgmi4EZSnmlOmj90+nhLwNTx+wb3ulyulFZsumXJIfw3MScM8Ybhl17XVfCgNMyt1bQD2fgV8uwoDp24LXvaOaXo10zK4Hr/uCz4UR1zUseN/6pgaQRfo1R0n4rGnm2sk/+exmmiQ9bUIw==
Received: from SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) by
 SEYPR04MB6481.apcprd04.prod.outlook.com (2603:1096:101:bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Thu, 26 Sep 2024 03:28:33 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096::cafe:0:0:17) by SG2P153CA0016.outlook.office365.com
 (2603:1096::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.5 via Frontend
 Transport; Thu, 26 Sep 2024 03:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server id 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024
 03:28:32 +0000
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
Subject: [PATCH v1 4/5] ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
Date: Thu, 26 Sep 2024 11:28:20 +0800
Message-Id: <20240926032821.4171466-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|SEYPR04MB6481:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d32a5c35-a26a-429e-f125-08dcdddb4cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvUJwWYvu3YzmXSLnQU5By/5S+3YvOI4vzPD/uoomyalMS6i2eEqbDdTLbI/?=
 =?us-ascii?Q?iVJLRnp1bKENkbHxGzf1NzFbjDZMjlC/nNwKISUL661oaN5tyLrPm0MTEvBg?=
 =?us-ascii?Q?4iunySy8TkwaXRmjbStf33B2G+GTfGI4BKYKHi/CuI8IacBN4L8Z1udzRx+p?=
 =?us-ascii?Q?mMOqiudFvb6t73ZcIRCO1S8mlaMfCHprTC+oGC0GNRLvx4L1OvVpS7mgNlkk?=
 =?us-ascii?Q?DToZIwxhR1spKL1WVQaoLBiJ4+HUcxlGjkGNw80uM/4bU5ANiBvaYGpk1jHl?=
 =?us-ascii?Q?KKBk3KSngv4EVbQifyc8utEQOerPF5oUiFNgRhYLt5pCk+8aOWc0EHJOV/bO?=
 =?us-ascii?Q?9/72STre60LFaPX1yiN5TN9Nhpu0vizaneS3STFK5bc5EV1b8LBmGxdB0hDd?=
 =?us-ascii?Q?8nXFtthYBNclJ+QyS+Fygm9bT8FQXyZnX/zJGiQixKx163Iiurq3msO7zwcJ?=
 =?us-ascii?Q?PwP7kjqXgFsi6hd6XcPWPMEVUUnvQLnyIz18rc5GYPuU6f5OC4cPjGfoBcFt?=
 =?us-ascii?Q?U9MhtwiPqT9qbzTy5uwdxZU6Ah46ZkwNtKINjd6zYZLFO/cU5lEngW7K053d?=
 =?us-ascii?Q?EcgvTOBuizwqsdgRdz8CnKIL4G8kPGRejQZx14+Sactgv1nAUEDBkHWMt/E2?=
 =?us-ascii?Q?YhVSK1OKVBbswJIZJ0jkk49/3/zgXUWoPQ3Vv2xXFtmYuks/Z5KkbV3ZO4EI?=
 =?us-ascii?Q?yZmPrw27I9f4JaYtrTeYBg/lBPD4zmQzdJp5Iq/vQMpnUf/d4PCAXeRUDuPF?=
 =?us-ascii?Q?V8uMEVBYdFtPurOH0HXJ1QmA7RNdw/PwXV0DCZwIAy/bw/bseb/7v21svu5f?=
 =?us-ascii?Q?uQWiEGa8VCHxFQYQGyZFF6xFbnC38X9e5J9qbjwq6rQu7Onp5oEFHvv4Ev/H?=
 =?us-ascii?Q?vR/97dK+8hj3BtMjvbDZr+TFg9hqIzMDUwTNrZjsR9mgU+sDcEx0tPyeQG+j?=
 =?us-ascii?Q?fGa+Yv0MGi7EpvoXIjWMIv2D9ly8dYQKJ+WEJrG7coL0YJYmUzgPAX+k9zE9?=
 =?us-ascii?Q?9hJSnEgNKtB/tL+4F6qkQ+gRaxpGZeZDLGOrZJMpFIgng1EuXMkLnIKormvf?=
 =?us-ascii?Q?RXTIyjeSp9kWzwNUt36wil+HLTvsTbe+ylNvKdEGAdzi/A6eRm5Q4ohOwx0V?=
 =?us-ascii?Q?XJEBTCQ4ycyUEDFxqayTvXbS1qSUi43McKDO7DgKuMFPZCCcz5tQQqimN0zn?=
 =?us-ascii?Q?Bk1WQVjzWZxuw5dSpmnKn0/UM+Csnm9sZbpKQ0zO/iubY0IvDa3l7dptCsmE?=
 =?us-ascii?Q?679vfz+JztBo+9E8C+XRxzxuPhGZF7oKWy9GLNDHfXokWZn5cvt553zvla4r?=
 =?us-ascii?Q?54W7lY2LHjQD0WBIO9oN4vL1nJixc1f2irbPq/1dJmlpibcgSwVT63cyQ4pS?=
 =?us-ascii?Q?z8dF9yqXiNZ5iWgsnDpVefpoZA8B?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 03:28:32.6861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32a5c35-a26a-429e-f125-08dcdddb4cb3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6481

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

Revise adc128d818 adc mode on Fan Boards according to schematic.

Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index a7e51725c595..29dd109ebd08 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -492,7 +492,7 @@ imux30: i2c@0 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
@@ -531,7 +531,7 @@ imux31: i2c@1 {
 			adc@1f {
 				compatible = "ti,adc128d818";
 				reg = <0x1f>;
-				ti,mode = /bits/ 8 <2>;
+				ti,mode = /bits/ 8 <1>;
 			};
 
 			pwm@20{
-- 
2.25.1


