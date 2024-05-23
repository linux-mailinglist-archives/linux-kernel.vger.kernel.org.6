Return-Path: <linux-kernel+bounces-187149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927AC8CCDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B52B22D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFC13CABF;
	Thu, 23 May 2024 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="jMGKsx6o"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBF13D296;
	Thu, 23 May 2024 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451453; cv=fail; b=HPvyP6NejnhE4c/lqRurcB1lAgUNadunkwKWsDITv2KpPmLCMf/xfcpcEGBf0sQkVPc3cRrSx2J7yQTl7nkhCBwmKCUHd4CKLJq4oIaSu3VsXLvd9jaCFfruqoPYKS8zovV/WTwvpWIPHgcT4sLDgsZBneF2OY1x14/NfcTUV34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451453; c=relaxed/simple;
	bh=v8A+lpCk2uYYWBD3hEpdnkWDTM2NUZHCqXbrsIQNIGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6kDuuOejnY2MuD0qy+a4bs/BNEr4IUthZ/Gt1KNOQbnWZp8bZKLJzlFe35SG8qZcix61GR4rxQPnnHHpSiF5GP8ZSN9utuctANBT94ho1suonc9/j3GQ8OxjzLKJ58GOpsa6rFVZGTXbwzUtlEHJwedbPYDeVtxK9L6Dgs0eGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=jMGKsx6o; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSG4YOM2fJFzO++2XKIaBssFRnd1XRepcob564nXhryA0ofYLhZFX/Y0+yAR63zlRQa85SJfPxKhh1B926UNNHiBPUV/nStGXti5CxBFW+Fqi336mORWcY97O5KE4vcLmPZzow+EgdtZ/Wh8aEZe3//AwpUfWXKIS5vtMyuAOTEbGGE8OgDHzqRu53Nx/UE+dBV5QnoDiUgvF8eEQbs8wu6/AjHPtOmoTk5ky7yGbgXlsiceWFzvJ2PiVKYr7eolKGAHvBlagBSkJJHk+eSadBmzruqUpcMJ0gNRYSi0lstnv/bPNAVvLiBD/7wElfghOlZ9MIFyQRm/z4BBkO8Aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+DlfI1otun1CAydzoG/8ZXnTLi77JYQ8A3Djz4rKnY=;
 b=DuHrnP6NLm3a8RsiEya+hJYMUZmppyubNejUiQCqJDir7c3oxN9/YhJIFrHqHo/Vx4wcP3ZD7NYy4yoQ2dli7a/yJZdqHiAj1oTichkSCpBqcTZhond05mQJgvpy2tPS8xtA9dv4wKA+Aet/Az/hCyv1vXyY5B/jV088IWIG4ze+j0exqIo1qvXvl4TvkGT0uJLypYkLvePwVCbsa5B9RrI2l3hZa1yyoMBP5WISHpiHzN/+qBFWtuCLos7bE97Y5AyIxmRptOhgUBwezDG53RmByZU6U6AmdVi073BQg/S0WJnqkqqNmW4fmZmHgAYm2eV9v74VP8nQ+Hn47z1IVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+DlfI1otun1CAydzoG/8ZXnTLi77JYQ8A3Djz4rKnY=;
 b=jMGKsx6oQ0NurBOFKsSisV0pzeyGwh+iACvNOc6QczjlF/+qta6KI51rYRSfpDrrooHj8pN7G8tazl73BZc0BSCUN+H+yzu27zM/dIdnlRxLxdfHC7pYNQewSbdLEorbjz4Cwbmnd6PH2JMjVVcvyJXP04yQtUGLsv+aUnujOhcrJ5ml4LR/zwERFjtseNfHaPgQ5YkG6JTKwSdqQe4vkFc+yftPWAyTQx0sAwm9mdRp3UsAcQk1japmkMqbCFkmE9t+t/iAcKf+mrxGw0WCuQne/wRaSot7vfe2UQC7+xaBMNiIiUKoG4n43lkUuo1QO6w8DHTUwWzscLofvLtB9A==
Received: from SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20) by
 KL1PR0401MB6225.apcprd04.prod.outlook.com (2603:1096:820:c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.39; Thu, 23 May
 2024 08:04:06 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::1b) by SG2PR04CA0158.outlook.office365.com
 (2603:1096:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:04:05 +0000
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
Subject: [PATCH v8 04/23] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date: Thu, 23 May 2024 16:03:09 +0800
Message-Id: <20240523080330.1860074-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523080330.1860074-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|KL1PR0401MB6225:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f69affd-1b43-4753-70aa-08dc7afeeaf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|7416005|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WlFRcyeezYuUZeRExFEYBxkc6dizW3Dr0HJtat9qp1hfwKuCfnnPHLXKJFxo?=
 =?us-ascii?Q?lPQoPV7xcwMVfnEsylSOMUTlbVEHqm1WQoztE2L/R8anE0g2Jdn946/KL3zr?=
 =?us-ascii?Q?e0Gaf6ODX+n9Ofjq0fUaeipZPS8d/MUy3YUZXbOasyKHv842teR785WuQkxi?=
 =?us-ascii?Q?zuQvChsbms5Z20TQc5Ln6pwfdaJHjfkzxEdBudteqQW1FkzZ0uuR21RycgTV?=
 =?us-ascii?Q?d99agyf16zoFRsTQBGQellFi9mNWFQRFr5abNbbaSG1Dk09NyGSmpfq6sIYG?=
 =?us-ascii?Q?MS+tQZSvfyjHmVznYrDYOgVJ7eBGCjFa0YmM2d2EG6MuajgIHvo3gY8rCFf8?=
 =?us-ascii?Q?X83sckC3qTrr6Pc9vQYfWYMTYkbz0oCkoikPBVmEo5dV6QelkdOVPh/CGTQt?=
 =?us-ascii?Q?NJ5H60S85LrvHUyFqDiDqo48nc/uuSn8UFVmgrIQWHR/bUp85wQ+iSmzHiFu?=
 =?us-ascii?Q?3cKQp93Q7N3jvnFcM/iEkYBiHhH1KeeeYlBxB80u8dSiNHAG914MoALgGF9P?=
 =?us-ascii?Q?nsxHbRaqORhlczZTXC9i3JWLJnKcYUN8iSuo3Fb0H9TmMZf5MlP8UV6Nmk1E?=
 =?us-ascii?Q?fShBWKh2a3RVMILUE5bT2c+bvW/9Q5Hr/NHNYtUqjU9s4BPU878AV9ouKyzS?=
 =?us-ascii?Q?Sh10uh2eDwVAkg2YjezsK+ymsUU7pLFsb9GzCd06AQnH6mLvw9RoZkLrO5gn?=
 =?us-ascii?Q?tTiuOIY9oXnv1I1VV2LJaaAkLTTRp2f70DvHc5hLcf2vpWYucC0+4/ELds5E?=
 =?us-ascii?Q?xf6T1JQNZhu1hp7uIA+2OtdS+t6Q5aZsloLlElgKQiEtcOY3aZpASHWDh7w6?=
 =?us-ascii?Q?EYGOGvWMMWjAqUwQHP5BCLlPtyXci14vZE16549e0aB+xL4lOukb71g9PEtB?=
 =?us-ascii?Q?QGJlWfKyF5KY2eyK/NdTSLBpKNNxv9R8n4CNcPDDl4Y3WuFokom9af9H5C7w?=
 =?us-ascii?Q?l0nXaAJmgjZOMURl2gEEZ1E6V3+ehpxcqMFSTB9m5HOogzF1Srxag4aTXTQv?=
 =?us-ascii?Q?NOMumm7HVZIQVr+lD+I599vqxeeJqewh5A7q+SQxkuiSoBf797U0BpTvHOa5?=
 =?us-ascii?Q?omoH4uzdTTHqXdAYRkPUHw0E1vDY4JtUCGBjZ6I/MusDMGJP/Ne+UdXavd5+?=
 =?us-ascii?Q?nvvCWWezxpCx5+neaSoRrATD5sp3Rpi1sUv/M+IE9wm1H2fPJdLlv7MwQh5j?=
 =?us-ascii?Q?MS7P9UfP79yVtYPWW2L1gLh5imHegDxAzxLfylnFArNt3aWaYL2EYrx1EAnp?=
 =?us-ascii?Q?OCqP8Q7ZzsbXIfazszqeTiUii9q3EI8+d3w17yGnnL/4Xl9qkh6oBQ2sFs/r?=
 =?us-ascii?Q?TJHm3M5qsTxp9axkCewhxiOFhQZxQoEjXjaE7+m1fm73qTsbE7vfDlOLY9Dj?=
 =?us-ascii?Q?imyLkfw=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:04:05.5309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69affd-1b43-4753-70aa-08dc7afeeaf3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6225

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index effc2af636a4..b0643e8aefee 100644
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


