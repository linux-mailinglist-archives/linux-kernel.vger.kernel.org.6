Return-Path: <linux-kernel+bounces-300795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8195E886
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4451F21345
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38D8563E;
	Mon, 26 Aug 2024 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="mMP+irt2"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CCA84DE0;
	Mon, 26 Aug 2024 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653480; cv=fail; b=ZsIIvqzzP2zOlgs/NeEwUkuJdN9+BIwRTllRu8Zj9EXE5zrgq0CFxBDgt9gqkLb1u9iTYEXd1TsNISGzn68w9oWGGR4MjTFnuJhNZiHsUyl9leQecWGYOdtPGJJ/sHV9gQNY4rnPi7bsylGb8FtfX9fWPRHPw6vI76GhGxvIogU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653480; c=relaxed/simple;
	bh=FOb8jOZM6I/Yf4bmbBSziNy2HqRVQUfHDF/sd4v9AWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3e8CGTcNUFe4N3cIBCr1ZODn4xo6j5b3Ik4gtzPikEI4XZkSzkD/Xb/e19gMFBYIRt6sdYA+B5KuGRM+Mh1iQLF8qSy48peLIjCT69S6lagurkq8RA59yqTYLwOZiACFK3hY+jldObRPAMnbTIJ9VDCgLlpeUwXrbKp+Z+khRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=mMP+irt2; arc=fail smtp.client-ip=40.107.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nma5moVNVdqBSSsH7RjF/OFVIvViQoyDHs9QE0sUn82xjjjOJAnT/x5rQ1l6NSdeJ0oH/NaSr1owhGYa7VSfigjiyTRR1lHlqPOmr82RJ0rC33aH8qVCPSnzzG85zHl2XAkJnDP03BKXN2Lrmakfw6ahq3BbRZFAUuJSyGQ9JT4UfjGflz6sDmfLpgBN1JU4LVnOP3el5nMezSHoqQyq1z9ZyrqExz9bKSJ7bZdAju8UpdiyS3Da5FCP83vbg+XYIoiSpD24xvCYN2TuuhjZB07ySgjGbLITz9ewS1X2BGKnbnNq9KuLNA1hAOwCvKwJXaKamx62rtxIWOJQjmE7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2AzjfJFXFA/0WPUqtPxoFn2BZSzzb91uVzc8URhJAk=;
 b=atVS58JKxMXhLUgCChB8eIGpxhp0NpmupC6A+H1U1a/D3TMwarVTWDvwZTS5JVwtu4DFL11cgPM2nO2aEVAtltwsGqRJKBM9j44Sa51rqwCJ6tnO3ZbxkJJnlx/F1l5zyugIp9Pe6SN1cRPFZ+m+PdJq5/aQnepRxOdAEI9Ck90U1njxHulkxAYPWVS4gUhkGzb/SuhNebuantBRayd6n8iPrph0JmGz01vHcvchPi3HZbt20glE2w5nIUSYyNigOhNd9tzwgo5O2gkpqJkaggFVJ7TNZcASg0UqOz3VfZo606mgws4Vp4y2/b+PRTfwPx7fmkr2wZ59mt7z2L5Ixw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2AzjfJFXFA/0WPUqtPxoFn2BZSzzb91uVzc8URhJAk=;
 b=mMP+irt2PZ+7Bk0WkFGJQzD4TiY68vAsGuYYW/X4YZwlfaQWyTG4gWM6UI66XH4+zxgHMCNKxUAhNWPmBIPjB/8t8JytiDEiGHfTHnld0P0PaoPHUXoesltX3Bkqs8mFlUxbbrtPUsZTcpyiRUGIU4KceEtE+XJrVjIPs5ivTfiGPeNdmuEj2yOambTXE5p1wkeWid2lYFrh3H2S+/EDIET/LSjpbjQdenf6Sg6VD0NRHxF59zBYrk2cEezBmo7ZISia2La3vAFeBQGmp/ZB+sqaYFQCIlPdwT7y8yeHLaLi8CIRI3zSiPG70rBmdKDEwxTvx6zgePfE2ulYxE+BDQ==
Received: from PUZP153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::7) by
 SEZPR04MB7459.apcprd04.prod.outlook.com (2603:1096:101:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:24:34 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::51) by PUZP153CA0011.outlook.office365.com
 (2603:1096:301:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:24:34
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
Subject: [PATCH v14 04/31] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Mon, 26 Aug 2024 14:23:38 +0800
Message-Id: <20240826062408.2885174-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240826062408.2885174-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|SEZPR04MB7459:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 41b1692c-9031-438b-4f62-08dcc597c0d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQPAuhwXTvw4/lYaiqUlEVRFl3rE6xPl8rzJcQdPGGqj+Kws4ksQ6vEvHtpc?=
 =?us-ascii?Q?IhtM4V/Fbwl4XzTsIdmwbCM+xN9Lr5MiGKOxEX7YcnOFYH9X6SobOLJ1Qn0G?=
 =?us-ascii?Q?WzIMDxDvfSKWQOQ3n3B32J/aGFlp6lF+tzW+VT12F5mfxLjsZrT0/OJYM/be?=
 =?us-ascii?Q?98H/Sh39gsILltbxo2f30Vnx5bV2/YZ6Xkq1obF+MvIYpmh+hbphP+Gfcsdd?=
 =?us-ascii?Q?inoR3Ju9/WeybXlKChIuz40Wi/k+oyYwuTBNJEr/3QHn94DLcbIePCVwyRWT?=
 =?us-ascii?Q?EhwO3DtwPojcVMksiwwjb++ZRNGAqSZXwgNkJt97UQEUas1uYmC0JkD/3Sic?=
 =?us-ascii?Q?MGe4/YUJBERFX8kX1sV+6x00AzzEew6dE5jyok8/fGgV4etv86ds/g0Qx3ML?=
 =?us-ascii?Q?2D9TFuZP6EUR3nskmxRkHVtC7hGSGQX5AIrtEF4Al4HmH4bl1dXm9S47286f?=
 =?us-ascii?Q?uySNN4SUEHfMluWNR4hRcCzVfYTwn0EfGEvCHsjASFYLffu/dqEyj+tPbSvb?=
 =?us-ascii?Q?453dl0Yaw1pmaAean4IQekRRsMwgvny6SqwCcUdd9nHISbBozQLXcVL7SCiI?=
 =?us-ascii?Q?EPclnEDost1qDVWkJ3p+DD4+kH33tMiPyMBY5CkDHRk+eJzA5H42zO5Dd7mA?=
 =?us-ascii?Q?by+iffsptfGGGcLJ1/Xdr81aK/PWUqYeC5G+BkuPzObIgzxP/pQwz4spzxnq?=
 =?us-ascii?Q?S7xvwIWpmg+Dj38ro4LfgKX1wIlFdEIJB9tBCiem0whJ+WmpK4nUc/UvuyHn?=
 =?us-ascii?Q?CTRxOVb0VeY2LcW76agJCtJSlGAt2h/+gWg6NGbX/E+n7x2bNSTfl4gSfUvq?=
 =?us-ascii?Q?riS7q3wNuQBsRpjMkvX3ojNtupzEc30Yw+1rFUvoVLEKC4q9bLoKc54YRj8Y?=
 =?us-ascii?Q?odlNOZYaEpK4GO36cN7BHIk0QTwEGHwU7HLj5vFhiX+G5UVvIbKhxLPPrKkj?=
 =?us-ascii?Q?i1Dxt6GqUlRNkkZdxxiR6+N1/I2+ZKRzQ4WiV7Z/8Yj+AiIe8HrEmK8JOr/B?=
 =?us-ascii?Q?B7oXkptjYkD57gTzSEWiYRdiJiV7ZQp7E/by0NnZbGsaeYPMnsRWOajhtbVi?=
 =?us-ascii?Q?1Ua0XkQjy5HYWygy2y2k+j4YJcIEamkmmiyf0bpN2VAwAmKDccloSdQuHQK5?=
 =?us-ascii?Q?yTa63Qhg8N6kllJlxWAH8LYLHfzKHvq97uWJpRyOkPs7LcFU1hTCCg45U7aW?=
 =?us-ascii?Q?TNzKtnUoVmHFWpd5I8arMwJrOLOfdvn2++Ue7bn/ObxmHzVKvElARnZJbSOa?=
 =?us-ascii?Q?14BMHkhVWu8gBb4g6Jp1EGrIyBuJdD9NfwPiYMENkAqnAhF7xVHr1L2Yey9x?=
 =?us-ascii?Q?ZTCSPoWbRl6A+bxzZhikWQjkCw8AzGYaZmOqHcFNwySX3v0Iwb/dAdxVfjJT?=
 =?us-ascii?Q?IEm2XaDzCPbq9LVezx/JhO828PadCkljgDvwXJ+VUv0EzSNBhEnkh79KxyfX?=
 =?us-ascii?Q?Vn2niUXhQkmHhyFyX1JKFTyU7bNVbumV?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:24:34.3780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b1692c-9031-438b-4f62-08dcc597c0d9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7459

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 575abdd530df..51b4e9ae13cc 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


