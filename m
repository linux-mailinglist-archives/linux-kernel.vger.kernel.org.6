Return-Path: <linux-kernel+bounces-187167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0238CCDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5487C1F23507
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDFC14D2AC;
	Thu, 23 May 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="fMNMyMEK"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2049.outbound.protection.outlook.com [40.107.117.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CD14B946;
	Thu, 23 May 2024 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451517; cv=fail; b=Uadw4r5Ru+lYo4Ywp0/IbLzSXVplmTBA2gG0Wm+fAvN/AcdBKI8zPRsNE3N9oqoOQK2/4y/qff95JHpUk1oTPOoqs/BHAXtqm9RUo3Frj1H58x2eIAT1US6BHC2hbXJXQBAYnVicp+oueN3pwrv5OA19+7lHn56ZI/mF85hub2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451517; c=relaxed/simple;
	bh=hlO3lXCni/1q/kb7fxUehMkLx79dHWk0XBPB/to4DPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hi9dJHBT1Rdb1PuWPpZIoO5eA4sS3KOwmq4hkzkMu9Qhazz8Os5+LfP6kYxZucGoDCrCv4/UKcWSOf3lig4vfHQjCyWnaL9odTAnpt8XD2QgA9rJfrfD2/83H9iJuHdCjTy/khcLs1sljhHAZfdzd+tt/FJcoOFRM85m7oeup/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=fMNMyMEK; arc=fail smtp.client-ip=40.107.117.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPMYRB+jy1Hw+Prt+iIAmpNUWHBNZF5wxG0wSpKZSXFZS2qWH6vBiZJJNWdr20bMG2uybomh3ioIDzZ5fa6XYEA/BUlxoNYjCJjjAXg2DRIh0CZlGP7upuKNZqvzXdKFxNwwLimUrBk7SdhPYR7LcNuuxDSFqSzROdt/osplcHFfLsDzUyoUmYj0mmxaL59uLcOtIMXPm7N+V5hJQNLNt/Ez+ptsCG9+BTLhqLHObYIOIDi8YeOpmce0I2YktcGSTKbgvLolPY2zEedLeoooXYoEYm1xCkVC9X0u+8VkP2xAtjnCgq9GwAp/0+Me5ijh8TykgYYOUW68CRN3sTkVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=mmA8GgvWecwZpKeU0o2U38U/QXTiRJK6WJMDMCifaVS/6lUPrXRxu4qM9SD1cQxWZvW1kT+5uYlbV5GfG6x20xX3mzIuQCViiTEt/oC+9RRQAx66uosSpz2FRcqHmEh2xQWgFPHhT5G86rBQySIgXQpOmTdtEDcm/BjU7DLCXreJ7Y9DzmVg/B0xDsXwAAckUzjvGXV9hdHMpOEdT2o46PRQ+/XorUmQISHWHt8KdqyUo90GA38LuiZGch9I1ZbPWgGs/ZOxldJ1N84MDzJeEZlhausg9dTpg2WcjMNNwafvrvh7vnM9I53ifVYkStbTRuor4JHNpBk7QWtzSxffhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPuO9qcjCRKT1hG8tAOI8QlF9L4C9eaYFzPaHsZZ6p4=;
 b=fMNMyMEK1Ajg5h9sxy9ProK6VyeDSRRSrT8m3ArjEUoJelLYswwzmE+LsgQf/eu36xJcnx+JSZCp7HujnQoogRtOvCmExeN9vfs8yQGKDt48zk8xZCSSxDjYswCnyw1G2Eu9cqc8v5DYEYk/hL1IjHRL4YOmUXHfWGDDajn0GdelnBDHpwK2Q2MvCq9OS8PA1CmLormsBeNdu5gEk6hw1lLTLy1VDVySuC9LxvzkPFZqm8KKv/LDVQVRawHC7JbjctLHIwYQNSygILp9vUr+Y/RBg+WFAWiW01ouST5Xc2JQJq8SKljMZRbmUoyOvnir8IlIMC8TTiVh6x6zzJKIOA==
Received: from SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34) by
 SI2PR04MB5703.apcprd04.prod.outlook.com (2603:1096:4:1be::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Thu, 23 May 2024 08:05:12 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::1b) by SG2PR04CA0172.outlook.office365.com
 (2603:1096:4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 08:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024
 08:05:11 +0000
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
Subject: [PATCH v8 22/23] ARM: dts: aspeed: yosemite4: Revise i2c duty-cycle
Date: Thu, 23 May 2024 16:03:27 +0800
Message-Id: <20240523080330.1860074-23-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SI2PR04MB5703:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 900d1956-f601-4f31-90df-08dc7aff1264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|36860700004|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?30R9VUnM2uqni7wScHQO6I0qlj583GKi8uQTRLaBHntrCOR+bO8/dH8OMQ3m?=
 =?us-ascii?Q?eLgD/nIBwFGTRgNJ7e8wHPLynRpBnIroWbHG4HuUKeUMX6rQiSX0OWE1q+PH?=
 =?us-ascii?Q?aKxgGUglgjEmBhu4ChUWBV9VBoHpP7qBGLDoRivnGhSVp2ElGpFMU5FdLaaK?=
 =?us-ascii?Q?kWac8Yx1VBlSMidPESKYtVD1Q7KnqMB8M+3dX7ah4X0pK8RvbMtG6VrQ++Oi?=
 =?us-ascii?Q?POaYQ1G6rghZHD4zldjeTcmZf3sIOU8+yorfUE7DujyCFlS+H75r3dfymPdR?=
 =?us-ascii?Q?1P+ZFQNodv7C1Yw90makkZFBQBnDdmhFBS4q4EreCxaP859RyPk4eAJn5HGd?=
 =?us-ascii?Q?uytKV8sjif5lwVdv13eFpG2Q0uI8XHbR1OWJ2EHRvUbKEluLslnOqKhTPBDb?=
 =?us-ascii?Q?lg9hvXVZ2S5Ff5RioOme0QhoQvatGxf1tq0AQnMESp/slPdU8UYZzW/tcTmG?=
 =?us-ascii?Q?lgHOhbXdWA43sY/z2Y6LxB3hsEfueGAO3u/1EscixOgm3fjJRFNC7AyoBpFU?=
 =?us-ascii?Q?BihfAFURE5r9OJJ4reYT7KZgEMq2VkojGuvlSWgNsIUdFgKy4/47TktwpmiO?=
 =?us-ascii?Q?fn4yfyS+ygFaRCBlf1mqk5N0DBwMXANK2X0vwebu+YQKoj9K2MZbfa6OjS9l?=
 =?us-ascii?Q?1d3YQe8U9ARUPKbQli2Y+vE6jndaCCz5Gso4YmuZwQB7SlTvJxiUfkHKHewg?=
 =?us-ascii?Q?ShpTv286S19KUSLczpzLboO2SVLSKtfkl2gTkxYubrFwvkfXb7SP/EEpADK1?=
 =?us-ascii?Q?9FhDi3aVRbSvYT8enyKFPcGjKCywQcDa6bo03x4BLe+x6Bc92S9AV7FF5+H1?=
 =?us-ascii?Q?KZKhhw28UN73AGQCoIc49QItc2ISevIAxDI3e227jh8oTuLUB5qwGphmohBQ?=
 =?us-ascii?Q?+zmwVp3lsSFw+cKA9yLTAwcwfo2ofSd2nrlstD21cw/1fs739si74FSVuFUp?=
 =?us-ascii?Q?QPhje7fk+lEe1fo+y90MKDJL3EvPiUWA2IZD0PbEfDLbOK88rfsg2yGNdO8H?=
 =?us-ascii?Q?vWcRoT6uIxP2GjNV/Jepjo/IafCOyTvHFegE8wHf6XMVkAFEVWGsWTC6Sk+W?=
 =?us-ascii?Q?XXHsgZ6zXffJJXPROcuEnKJ6LWXUplHALebpve+qPbWhSBfAH/NVl7n7Koun?=
 =?us-ascii?Q?pwn2k2MQ77yg2xo3Dbff3L10uV9856S2YVW/77CBqA6rB/5dGot0qL7bbDrD?=
 =?us-ascii?Q?Li5HMxbeC1h4BkFVu66Oj7/x6vV5zfOv/qo4ukzNw7ohR9+tuHPvbCVfhC0x?=
 =?us-ascii?Q?omOTc3kUjz+d8AuWZTnWNWUPq+7QKh0y7tLEBwg9AuiUEmaW4YgZsJvWFYd1?=
 =?us-ascii?Q?h6bDWCSqGVfez7O29mtSkZoIFHK6Gt5YbhPAr6r5QV9EcF1q7vkP5hDA2Gnp?=
 =?us-ascii?Q?FgTIiVOT/IwrD0zrCRaulWUqDW/B?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(376005)(82310400017)(36860700004)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:05:11.7034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900d1956-f601-4f31-90df-08dc7aff1264
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB5703

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


