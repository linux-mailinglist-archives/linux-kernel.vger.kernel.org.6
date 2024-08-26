Return-Path: <linux-kernel+bounces-300814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A595E8C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1875BB217E7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B488E14533F;
	Mon, 26 Aug 2024 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="dXTqFEDr"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3112E1CA;
	Mon, 26 Aug 2024 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653583; cv=fail; b=DA/mDEm0HC/Jb6zWPrnlA866E2ldfcNy6s81eSofrpQ/6TDF/1huF/3ImGKI0tcu9z2E4weFe7AEn+LI8lSIpdq9eN0zSy2BPqpRzpgCTD+4wt2ihIQh93IZW7wtFpFld7sbLBLF09XlPwK+GESRZ6Sz8x1Z6HUDKfSqVO33C6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653583; c=relaxed/simple;
	bh=bJyTPwQ6HLIm9WpJFkRqKJv3EdjekWxcOSacyOXtKik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U24lm7kLYjejyX5uImMCuRNen3KMV9jxyP/7CLnbYMqNc4PSbP/rgOa7F0tLl2WfQfyX18P1ebP+AitKGiCKfock2gYs9tsGEvl476y2ri4sA2mRdt9x2cLl5+xreLyeOS+N0SRvc7b9Ww17sjyBcZ3kQIrk+KhdMXVOtO8F3uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=dXTqFEDr; arc=fail smtp.client-ip=40.107.215.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yY+S2FK/HVf/VHkxSf3I+IYI/5FGnOFahCMewNok8bVNbkbTfnT0H34jt8XLip9MKKLDgKPa3wxi3x1QculAG+FANxalJyPaAFeDYoP+PF7rAluitm5KJ8ce2Zgu2Fs8Zgh5QhNG39ReiB0CJ97Yo4DJtNkhS00Fg8IeNKvwxBu/O6hQIc6XkQrw2JgB82YE4X74+iwxMKw2terK4ZcWdagwEhTTjrDPseTxfXPvyNxLgPb0W8rBtYc402b3vTkUgXsVlnlqk15jLI5Futz5TvsQJdkM7nyf0M7I8e0NpF3lMWx/oeIl7a0ZfPkhUpXLcQ9YaHnDVoA8glmfOowMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQFQ2bKjxnUV6R0l0iLzwvLwa8mKW3x6TIVY3QTprt8=;
 b=NEjsYpSaAJ5erDRtoND8trxwvijUxyRMBF6bpOCtnNzgCHfkVeT6A/oLLRBoEYO3K/fp0mIiHz3vjqQy25EnX5hdOarc4NJMumXue/bi1oN4p66wn0ltx9XV9szVxADUhs/7FnWUhymkEo/UudDx6lG4+7aj3NgrbGmVskaKBb9A5S5KlhbYVqc6WlCLWfQAu7+V9K6DGtc/hw6t9B+3P3MX3Zs9Orw/i5SzqbmX/ZVgaSIaITHY2H9jbTjgp/zu1DhdpCzy3RbR/7wj/5PWkXRr0QjH+Umf6xoEFmq2reqJzXMq2F+yNDBmYDvkwveOIxKpyctwxfGuib1oEq3TkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQFQ2bKjxnUV6R0l0iLzwvLwa8mKW3x6TIVY3QTprt8=;
 b=dXTqFEDrzNqxRm1YKAyLurRIcQKKTVx1sZDP1Zj5Dh+agdLYwENbf0xo5Dr8sbeIQ5dRui5vJWxsjoMMY3Kzryq8cjHS5ehYfXYwJBTxaLNVYam3wyAL/Y9oXte9yeI6wNNi4i7KglJAmmZROlmzdQ6bqzDf/ElUwqpzfPj2cM7DA/3zgp9TVPBhgukh2ziHjrwk+t1aKR8BnnwhMUdtA+UYFNDHex18jwhc4Q6+7tCALyloaisqNptq0iUgNlxvW9SdifLV4EkOmUovr1RxCoERiJUtYwhnN/tLgu6YxmM5wZw6s4n+9286778SaswpRoAQcx+Uncq3pgmwSSSW+A==
Received: from PS1PR03CA0014.apcprd03.prod.outlook.com (2603:1096:803:3d::26)
 by TYSPR04MB8220.apcprd04.prod.outlook.com (2603:1096:405:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 06:26:16 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:3d:cafe::44) by PS1PR03CA0014.outlook.office365.com
 (2603:1096:803:3d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14 via Frontend
 Transport; Mon, 26 Aug 2024 06:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 06:26:15
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
Subject: [PATCH v14 22/31] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Mon, 26 Aug 2024 14:23:56 +0800
Message-Id: <20240826062408.2885174-23-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYSPR04MB8220:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3459dbc9-b5af-45b2-0550-08dcc597fd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sUZ0CXmhpRWaCSgr63lzfQOdg0O1THj+4x5S3zR+5v5CYy9T8rrZKRdzEcu?=
 =?us-ascii?Q?zF6EGy1XitkWT5khnDxu3YT2XsJwiOAvxJHma4/Gpq6cboi3HCLJ5dYpOW5z?=
 =?us-ascii?Q?qnD/mm5YsgxrYzhXR67ivGV/b6U2xyd0xd5w1/mc1zJuChaVR4ZnqhBFAJFK?=
 =?us-ascii?Q?niOWRN/ivoektqYR5hBAte93S1FucthXO4a1so+4W90aPujmtrfAvATZPlB2?=
 =?us-ascii?Q?S03H6xdN+KerulFO62uVKQz3K3h2KE2RSWKbAmVUmNNbSR5WnM3rSMoCMg31?=
 =?us-ascii?Q?lLYbcglFwCbdj3Hg7om/VOK6WtMuiOxnIiZt5kF3sACujQ6gxvktFChOu6kN?=
 =?us-ascii?Q?PxYYsfPa4aHEP9XyfyAkrnFKYjsZRdX9X7Ed9ikUmo0a1VJ8Ja2SyzZfGdPM?=
 =?us-ascii?Q?CEMLdEzinBHEIv4mB9T8g3RqcF8PF7mEy4aRIxWcEgcvTBQbT5Zvzzn5a46H?=
 =?us-ascii?Q?VFByKwELcRXaTqDzOpdIo0YeLCvFCKbVaQyBBibFSIA0Q7JGtjAl6Je+ZlEK?=
 =?us-ascii?Q?vLfmFnGkLmhO4p3ZU3b5TqX5aNPT+/4M2RaQ4nxwoBRjOCtvbJo8HK/bQ3qy?=
 =?us-ascii?Q?r8OzP73vsMC+GwN5m3JHH/W7/9sEKchm3uUSpdlObxWbppXHQhfM/t3wry51?=
 =?us-ascii?Q?22hk17RPmZR5IgtJN3/QD9DNuaEkClLVBYnBgyQ8WAVxqCnPda07NAYajJWy?=
 =?us-ascii?Q?Dbs84dmssRM8UGQV02/bki7MFwNyEUOwyLk70SJLWcq+s1CvfoX94iBRw0zQ?=
 =?us-ascii?Q?DjOgzDUEIaLEdQEKBlPDV6ffwVUkDpe6GDjbHTsUd8pOfF7WREA+g57peKzC?=
 =?us-ascii?Q?zBW7Syx3Wj4qzkSfYV9Xcc7m3xFGAKsUUQ/4qMwSAOVHgeqigsmJK+BCq3xp?=
 =?us-ascii?Q?ZaG9IGJ/fTd+Ka2bbHaynCH+F4zY7pnPT7Ss1jfcDXPwh1ujIsjGKpa8Eu2T?=
 =?us-ascii?Q?lNR91EHWjvqFMV9VPUCTdCaxeWuc6hMpuJzBWCsgVtwd83S5h1ua0KcVt3lW?=
 =?us-ascii?Q?4xplhJk2l4SU0jusIpKq5H1nD2MWJzMnzzp1w4jJpAQTgwAINj0yZ2PFs/hh?=
 =?us-ascii?Q?FbeVesnBOalZ5AMIrm4AWpKClBcEvb8Xtrw0kp5xAbwuvRvoeD3ehmhn+ePD?=
 =?us-ascii?Q?WhxKUZFqIWqg3b6i50363lSao1IhRSu+qluprWd/phYqfpM18b+910H+GIJC?=
 =?us-ascii?Q?XASEZXQ4WoXU435OXET/PZDRrBfP8uHN0TQQnRVYMwT3l/vngM/4oZlhyc+e?=
 =?us-ascii?Q?XiEzHbD7XVCELrup8uibZtyCYzZ7u4Msz0w31MR13O4JhdXIBfvUbKRU/AFi?=
 =?us-ascii?Q?ps3WOwu0/bnktaZNNXKJ1M6t5MGOQmR94frC9Dq12C5nXGBAAnbDktHxStd5?=
 =?us-ascii?Q?Xdv0X7cwXFly8UDEo9SOsw+Vb0OiXul24x1PdgeeBI52qZIV+enA8KCvCIrh?=
 =?us-ascii?Q?qMoZaj5vTWcZVPawLckRhGvCN6/7ouBc?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 06:26:15.5179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3459dbc9-b5af-45b2-0550-08dcc597fd22
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB8220

Revise duty cycle SMB11 and SMB16 to high: 40%, low: 60%,
to meet 400kHz-i2c clock low time spec (> 1.3 us) from EE request

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c2994651e747..c940d23c8a4b 100644
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


