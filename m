Return-Path: <linux-kernel+bounces-230383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33279917C14
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E091C21E95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7231836C7;
	Wed, 26 Jun 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="YkVRbC0u"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2047.outbound.protection.outlook.com [40.107.215.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD1183073;
	Wed, 26 Jun 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392960; cv=fail; b=ZWuEU8sLVn6EXyTL5HWjabXdeQWi2CljKmyB+QxawxOjUKP5u9AIdBD7HMsUVXoT7lgl0K5nGp8Z9N3UvxP5s44S0sfWOESOoj7BNgjGbT/ARa/Q4HHUaKnaZ1xh1F50D/k6kMTZTKbqWKWXpaAduTC7SbG3j3eMy/QZ4yKrc2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392960; c=relaxed/simple;
	bh=hlO3lXCni/1q/kb7fxUehMkLx79dHWk0XBPB/to4DPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrDFvRKMristEBzksZzjPgmgZjNCu5p4gkUhFVxwdyH2fi45DR7VMFyYpgiM0tT0gWg2+KZGv8vwMyTeKl1v7IIvIw75o0zaOi46Zh9g9jiDErY2dHQQSs7/N/theVH0ryDJ6vjJQsysF2dH6POF4MGVc5SexX1Z7Odfd3iyMic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=YkVRbC0u; arc=fail smtp.client-ip=40.107.215.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifsjb0UdaypTnaht7YI0GogX4hAe1VDprPL6shY7VWD2vR6/F+yytahTPiwjbuJ+rUhtMtReZ1GnMuZE/eRqwEykEVItS6kUza3kHR6yTAKV8/YILGfddV4FVZHF60RusiB6wgfAnkF/QxvCUnfwksluqCo3RR2YWmfKpNSerXWM/7ubOpLg7TM7JA/Iio5KVJ6DjfBr/4Mfuqt6gyoXCWQDlxfLySr3XYxpWGjtBL0AbKEe83m3i2C+LThpGnavnuBgRlfNius5io91fvoxuISV5G5r8SBQDp1m/5kwLD215DkoF9lMPmRMU49K7jZW+zmerx0vFp6c5WmQ+nywQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=j9Px0ETdwVGbwTCQhwD7SAR0TpNqT+4vXxQmaHlSmxenb3AXeQHVyzBwK0NXPORU4ntkdnCioT0Ai1aISkMo0A492hKtc/C9w2HHk4OKjB/sqKHAc9SKxDWo835NN7vfl+dkFWsmZ7mP0f2aENsFxPbRZQhy4kFIfaOXS/NR+UYdpyb1jBLoKDu++y8jAZk2Uw61xYOULpnvfXQgDNsSXUf0O3Z7Yh9PA/9pSAWPydRIda9e383puVFQ9QBTcdoXFKsWrM5RhVQ02fDezvApbnjXoqo0MDletQhJNg28B4MkxVVrSxPQCo7NV6YlWUa4zPumNfe/YC5f3iSuiUSReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=YkVRbC0uE26smsAPR4xlxJsZYB6E7Ml8gb91Hhe6+1hXmKOAgYffxxCJgre2LcFyj3dHJLMQh9YEQiYJni9s3pctAzRMfPdg00kOe2qyS1j+DpIkBtO3xxVNpVTzMXY6YbqCYATUmMFlfbl6xj6+tNV8Ge33+RFKP4P2p5T72io66wfmZu8GYrDAT117Ik1ZuFw1dHFXhlXrp7tpM5xXSHsNJ87wVNI+mR87UreqTG3YrPXG0hVhblUIdNGpHkRZyrM1wCXXMovV4nde1Whr6LqGzjVOuj7K1l2sLC/L2hxeRdesdehMXa4N9uNUZjvk+xB9RAxfc9eP5lfkKkI8oA==
Received: from PS2PR04CA0012.apcprd04.prod.outlook.com (2603:1096:300:55::24)
 by TY0PR04MB6469.apcprd04.prod.outlook.com (2603:1096:400:275::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Wed, 26 Jun
 2024 09:09:14 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::a4) by PS2PR04CA0012.outlook.office365.com
 (2603:1096:300:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 09:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 09:09:13
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
Subject: [PATCH v9 22/26] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Wed, 26 Jun 2024 17:07:38 +0800
Message-Id: <20240626090744.174351-23-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240626090744.174351-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|TY0PR04MB6469:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ed527b74-a782-455f-0832-08dc95bfa601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|7416012|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dmALihi5UD2XtE4l8Jdkjs7ZmYGJmt3kZamJPoqLDlNCGICjvjAfNvZ6SxMz?=
 =?us-ascii?Q?yb4oIXKQuxONO7MqvMvnlYMtal6i8gb8jQF2P90C6h/x6uxmq7+hZcWS8XgU?=
 =?us-ascii?Q?aYlZnfDYKCJc0f8wYpMHK4Ub7mA7HqTxRnsvh00byygnW26JDRe0BlAEOqoy?=
 =?us-ascii?Q?ER6KXNP70ELycAw3sejUzvNQ18Oe2FyLvsNrFUaJSzFNnR6NKgMOHMtEEKN/?=
 =?us-ascii?Q?rDsyBlNJ98jGPkK75Z0Tjjudp5k2Q+0GHn7lKZ7B2QZUrgm3hH/fxtgmZ90V?=
 =?us-ascii?Q?geNF+VjrzSsThzGtPR1YWs/2JQm3oNY5R1MEP9YXAK4a9gQ/He/DZAfYq2xv?=
 =?us-ascii?Q?u6E93TI3NPbwmPAUMVXlj2apxySNafAGG/7rQPrWOgxFAgxq8lD+G/47Fixd?=
 =?us-ascii?Q?xwBC3Xam/Tzge+cDe4D9RDAk81645ph8A+9/KegFqO9M6/+nORtj45SjWHCl?=
 =?us-ascii?Q?JoTI3ySc1KPquh/7Pd2acXrYS+YtXPLTfFWbhyvZmUk88LWh8Dw5r/graUN5?=
 =?us-ascii?Q?1P9+R75PTqZyKdR5hGpgLC1hZsaZIDyc3wf8Gkj9yLpdr3SEes/6UKHjZCRM?=
 =?us-ascii?Q?FrtUzTbkdJd3pwiFAArhE+/t95EsZfIfR1Nr6b0RIGcbAqwtlVVe9lOvT8m0?=
 =?us-ascii?Q?hzOJvKxnW1BflysSbKomN1OOxx5FSerWBOYT+AfaCUlZKaBD4IA12NriIuD2?=
 =?us-ascii?Q?oWo+UOdNC3F6Am4CYRTQDMHdgWM/hJjD5EYOIuNfHxPSjQGiOT5q06vFzyRK?=
 =?us-ascii?Q?DxLsgBkAGW9tI5HzAmfVtZ3LZ+4jt+fRgOPvBd2MX1aVfZa10VjvPHbN6TC4?=
 =?us-ascii?Q?4BzHGTJq7riMDUGSiTzVlbz1JiNePSwy3EKfuNG71j13G71G/oK+blruoN6y?=
 =?us-ascii?Q?YdbAq4hKsQq8VBPKxxhmlQCGsUpnpP8C9GxTsOriwKwCEwV1xNQRYs1nuEUQ?=
 =?us-ascii?Q?TvAV9yGXAZ38DeB7u9wBdI5WOrjWax3mP/hBLly/wuJInFpAsQU2X+2EtQKg?=
 =?us-ascii?Q?ogkgH4INaAm16Psq8fnRI1lxJnjNJnkZumIDQOtPY6MaDHNAT/owhhkPbD9S?=
 =?us-ascii?Q?Nz0qxs7MFcstrCY7moJJAcUcVaprJ0rkEp18EKUeaC1qO4K/mmaEx+kClRc8?=
 =?us-ascii?Q?l6kMlGagESRXQe/4Jy+1cddzIBzwvspj0Eiu02AUgNUFIx+8zfzmy9FSuzwl?=
 =?us-ascii?Q?Bw0Ajjov4t7gtg/uek69lKW3bvmR/X6CLpFruntSY6FF4XDAWlAiT+AskjYK?=
 =?us-ascii?Q?o8POwJeh1y91dLbTOGKaLTE2J/PklgF96UXsfLry7IowDufd+4hvGRtee3xe?=
 =?us-ascii?Q?GHp4eX0M5b2p9FVcYdAExxWRGvPjmllxlgarJGbKRoKG+TTL4JKbSX8NOfrZ?=
 =?us-ascii?Q?jKAYPbnhK75q5OmYSSD8L0NZBKFMahSSwImMN/IylSMoqkek7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(7416012)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 09:09:13.3957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed527b74-a782-455f-0832-08dc95bfa601
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6469

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 62dfe935cbcd..21ca22281ef8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -761,6 +761,7 @@ eeprom@54 {
 &i2c10 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux@74 {
 		compatible = "nxp,pca9544";
 		i2c-mux-idle-disconnect;
@@ -1314,6 +1315,7 @@ &i2c15 {
 	mctp-controller;
 	multi-master;
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
-- 
2.25.1


