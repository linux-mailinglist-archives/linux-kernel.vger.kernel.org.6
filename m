Return-Path: <linux-kernel+bounces-300806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6859D95E8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E96A281832
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D60839E4;
	Mon, 26 Aug 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="jq5b+okS"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061.outbound.protection.outlook.com [40.107.255.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679DA85947;
	Mon, 26 Aug 2024 06:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653528; cv=fail; b=X9jS+AU1lo0aDs4e6CaTlSzFWgYsh1rIkhlZi4FNzXTB9GHHge52RI9ESJXVMHtD4kUefqU4Azoz5GBlKK5VVlcLGG77nri/sohdh+eeI1YDQi0ARKJX6EuEk0VNZjdHwmPIU9DvM4eCIYMCTXRW/qaNa+JCxU5WN5qB/wDg3i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653528; c=relaxed/simple;
	bh=jW0gVemZ4cl5PWpH2fNOD4IT7gRDiRPR9A8KhbqEULc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFLXk7PlqXExTTVlsFsTuKU+rhIoy3ATdbAOPGTxu1Nr55B1oewz+afYhJdik8Mr7zw9ijJv9Q6ey93XBWgjA5VLTEvo9LhRq9Alvee3ma3I/DqqxU2l5zImTtrFqXo5NwjFpJkHkHXtNrertCzZTfmGAm5LEkh1uMEMbP49hfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=jq5b+okS; arc=fail smtp.client-ip=40.107.255.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5YwDAtxyhzZlbMnxr37M5cyOohTCfIPCe+wmWb85MZIWoQsvqe4GI7ZqQ/amBvx2c8rN7hboLmdCAMk0twODx6jTDf8slMj3hEyYHaDWKKcAlXT6+ULZwg5Ng1pfasvNhw/ZxC49EJzj3kX16bzHT29lYMvwhp0V2EPkjyXiU4AH9PfqFZYlB5C7OGunFzAugI644H97+o7tZA7dwCLX8O4vFTMrSGKtitI286xS1fueroPiKbadazJLAXNkkKRkb2h1RA/wQsFrJHyadHcCg9V+1+3+CsCUyChczqrL4Ik2e5G7PFc+2bvJBu5mvJLDv+VR87/YXsFA5bIdjZPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=qWulU5YtZ4gCTSSrhc1O9W5xhheRQy+iYMPN0fe2X4mqpLedXBSg1G0eiYinUWNfPxEFJonn4S5IuiY4Qw3g3PHtAP+AEPkFcyDGkEWtKtJliZeDhwoCbirlMBiH7fxmfyFxlltVbCAXQDTTxdt+9VePL/DAL8fNIgtCooXCKp3QQNA99+yHrQX3NLO3dEh+ay6z6XYLobEunL1C0M2aUPqAucp4yfq9DpJKq92jx8oE6s26Z9lGwdz76DyQjDwKHkvSCtcC9CQxcxR50QZIqnrUkrtGXL4j1iYb39MAk23oNA8m7bQweLAkdgzDOhs/G4yRdgT9bRrutul+L8XMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP7PVLwcCxjPpagISxynxIAExRDCx7daqT/H5FzbdV8=;
 b=jq5b+okSDrdmOfA5CTBJZUIZ3xbfL2RITJPU0PhJQzs1r7uG2Jwz3VUAQZPLc8lH5FsxhZqZhwkDIOTwGBZJdkomtrxTQf5ul0302EU6VzUzjU8tbsee0PFHmdtSvBIEDBv76wbm1ypgKC6/VlTiwaFXerK+PAV50hWDdAtT9c0zIMEwhG2zUrHfL/TFdclT0jWwKOFukcX5TBgGx6cZvp6PBDZSBwuxusnhCpXQLCoC4pdlMiDSXFQw1KCOd8yu/axbURaOc697v0IgSzo2SG9lz+KLIKKgJo3tkeIkpoZasIURB8OYzyQLdQdcTle01DnX0GzifaKAdogyjW+IGQ==
Received: from PS1PR03CA0020.apcprd03.prod.outlook.com (2603:1096:803:3d::32)
 by TYZPR04MB6810.apcprd04.prod.outlook.com (2603:1096:400:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:25:22 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com (2603:1096:803:3d::4)
 by PS1PR03CA0020.outlook.office365.com (2603:1096:803:3d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.14 via Frontend Transport; Mon, 26 Aug 2024 06:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:25:21
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
Subject: [PATCH v14 15/31] ARM: dts: aspeed: yosemite4: Remove idle state setting for yosemite4 NIC connection
Date: Mon, 26 Aug 2024 14:23:49 +0800
Message-Id: <20240826062408.2885174-16-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR04MB6810:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8c9324f5-ca2d-49f6-42f7-08dcc597dcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f4yBSLW44TyrdxjEtBN9d7ZZKDKsA4xQNFPgKdCKdJ9SHe164BJivfq3tqsq?=
 =?us-ascii?Q?eRy2n6/ojRpOsK9gY2WxOLtVv7uOHglSU9tt6iwtq9c8POuElCD0A0JMx5oy?=
 =?us-ascii?Q?wbd/SFrvraMqGEIvOtN1KxwDQcSuf/vOda0bG8TBUnp9IYwJuKCfqj11gvcJ?=
 =?us-ascii?Q?SjxHamYp8tFN8EY2roLi0LiaEk/01c9ln3dG9QZy+ReG5gcYPh9ccv7biK9n?=
 =?us-ascii?Q?tWNuKWU3dWTMWSCLvvuQX8GvQHT/+FjEK3vBdDj33WBSqOskEB8ya6BoBgrf?=
 =?us-ascii?Q?vsZtt2+imjt29lEQXO4QvdfRzpvjDxMI+hvwRCmD0wTlACroPNrtc9Kq6Dxe?=
 =?us-ascii?Q?X2FhNXoqfVqHg8hcPVrgbdkYMMA2AO0GDfnhazx1/tEazHpC5LkqHW7GNf5D?=
 =?us-ascii?Q?0QtM7LKrZY3vzjvN0ANQwFp5P9grCKbnqncu3AaS7OH+iTudxNA8MS2SPFua?=
 =?us-ascii?Q?OkWTm7wgieSTttKDvgKCOgbggdcjyS6ohpWWgTVmhYzaHOq53tDvi3amFP2p?=
 =?us-ascii?Q?I0c10PyOWaBwy7ZtzTDd2YhUoxfELqp4zPp6OYArx8m542eO1NlrSEhH6wu6?=
 =?us-ascii?Q?IWyt0GY8ubrtd9QX2H4hNQfLrS5AYdlW8Tp9f5KKy48UGA0/Vc06FxXvblpL?=
 =?us-ascii?Q?doHOCUWRfEAvm11TtEru5Ke3882LV6yU/7ABxsUPuX0nhpaBLaKDL1LTdShs?=
 =?us-ascii?Q?FW7PjEJ2Aq4FzzoVbchwaGn4fSGLVjwMmuIhXgHTUVmTnmszsNzsFh048+k0?=
 =?us-ascii?Q?dfRDtHWeM/gP9MPINv+yEFJipHm5sQqOGWDc6v8ONuwL74ZAwolzL1ENYq3g?=
 =?us-ascii?Q?d+VLc+O27G9XARx9UrQR5hFxO2iXTwMaJXd6EGoAqphJ5Q1ylJw/9/rGdqED?=
 =?us-ascii?Q?BXGHIcFijA+vaRzuFTYmGSyvO/exxgeR381jkLLdA7HoMn3sasxvAIJS6jHZ?=
 =?us-ascii?Q?XwsSr6/2mgtbTxw+/B8TwnZ9o6/m4mTPO9sCpS3uxLFy6q65CM+B7Vc5ZR0p?=
 =?us-ascii?Q?nxgwZoCPQA7Y/MjJ1M1Xg7p3s38EmlDoVu8koSm/UkaOQnrmGdMWc4NZDqIo?=
 =?us-ascii?Q?dhGGpElQQCunrXHN87B1zZuUU+GNm3lfeL97q3XlRS7GpcVEjFgRqDkCFpKy?=
 =?us-ascii?Q?fn+j9/jH3xKocGVobGSdMJwY0t2cctSsG6pZzCYJ7AfivT4gF6iMj0ZVHPRa?=
 =?us-ascii?Q?KG9upBJnRPHLVp4767bTcwcjHCHLmtd4MQ2Zr7aQq8EbIbQcgoCpPmJhpOEd?=
 =?us-ascii?Q?hKqHgWX4hy45s3M35G0TDWAIf0WWSiQ1CuqdptImkRdjomwzSbOiKui4bd3A?=
 =?us-ascii?Q?R4AOfDJ6Jxx9QlwHmd7DfoI6Z6pTmpdQ5Z0Mo9dvBN6tnYGkuRovlNe59Idk?=
 =?us-ascii?Q?MMGtFmlxYr4MpycfMZe5bpJuRwrfEw5ie7sjv5MqYNcDP4Frl2MamAyUYRZS?=
 =?us-ascii?Q?m75pjkQ8lKIJF7Dj92dGYHUjTjtQvM9L?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:25:21.5339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9324f5-ca2d-49f6-42f7-08dcc597dcfe
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6810

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


