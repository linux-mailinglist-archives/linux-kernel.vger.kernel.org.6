Return-Path: <linux-kernel+bounces-295262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9F959923
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AA92811C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D07F1FE1D4;
	Wed, 21 Aug 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="QnIQbz6P"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B101FE1C0;
	Wed, 21 Aug 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233380; cv=fail; b=OTzodvVNb9tA7OIu5cbGKuGrzn0F6JIal2pA4PWTN+WP2RQR9Y39MJfAUEkhF3spr9LoDV/tP9oqQTUWZymUzXWNWD1MQARd5fRmZWpOslTz3dcIu0pqt4+KQ6ZDrKqeA+ndHltoRIacCXN73OgeKOsqCZFO4rK9vIIivHJ/cJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233380; c=relaxed/simple;
	bh=Gb1cMubfab+esZE2lUZ8pmnTHC5wWT80/mJF+02OPjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plPeGhrMX6KXZxUhIGSeLJkc5PwwhqRiuBVb7S13fb5vK9Ph4QTC+2Te3G4CBM8fctkLIKXycbQ+wOWBlG/dvL9gTzDGNHGKOKzqYc1Cp2IxOSoOrkMok6Z5fr43/IJqx4OFkxx0R+aL17DcmYZaO3n8sbPT88I5Ci/dXlYGtJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=QnIQbz6P; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w49S6MyT6PsbO0d7yIjSPp+GiJETRBgbZrV9Ehz6eBDf1J+NdzI2t/LfIJeK8ZDSmG+Mwjiuy1nOjyb1WV+PF3UZ8nv2/NJRwhcojXCwFnwYYumdNaFolCoxHaQevtG/8SQjLOuApVMxbvALj4Y9xZBuXNw14MRLN0KPa0qhhXuPo1O2yoDPdPReWHkR62VJ3pUAqoTtvQfciseSFcBHyTMl6R31e9lRh0Js3TZ33YEYQWHXKg18pnsEqo8M+4vo0UzvwoWH4MTHun5tdfi3rzaH4c8WNMc8C1WN76e/Pv9+WQnKMk2mv3YabHTqaG15TDOqlHiUxwS0ag+ysYJzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=XsB3z/YoMXit90BjXYwDcDuxIuVeMyXklguYqUEIcNJNFAneBhwHELFIphbvS1SlQRhAeQmB2xPnagLTsVbDyukU+Cs7BVf6KZ+6rxd33GSUq0orXvmzW91tTvbem+VtJcW0XQGZTntnTvQGCLp2xI0waG4F+jl83fIXuI+SUA+HwG+L/u0AxNsR/P2otn9zvPyR8ZPXHWLp6ovAZ4/boD//6FLDFgJDSNgCJkGjx1A5zudGVLQw9YIieqkhFP3Oz4zc0TclDdEfL3weBFt1DISwkWWE6z8KSsqnF9zGUDHkmhTWDDbLyqfaPgF8cHjxVILL6YbxX25V4A9K7NsU2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKDiGhY0qi6Zhw5yz3X3KRvVupBpI62BiZwruuZTFwI=;
 b=QnIQbz6Pz+L2aq+NA3ccM1Ih17yytUmvciiYYsVHwYy0bZ3rnwsP7g7qWKduvfGwCjNlDjlk27eqXcpr0KOMQJvhlWEl1qZp3jD31eKUPoPzjVOjgBhjOYH5CnZ7ybgPnjzKZ6V73OBV98WHViG/8kOKdfa+Ji9Nf5BRtakcsWAoNPv0qzjgYDJTfxiAeUE0keDETaIeP5tSdfm+MfbKgkrVtoIifIEh7Qg3z2xFYgFZVqJlD63sL92TdQohOyu5/wgWLEXsJf5errzh13hLmH9wlgt8fz1BZ+uWLCPT31/U/wa2pX6U7wJWdmetJc7uc95KTIvE78nK7Go79/Ptzg==
Received: from SI2PR02CA0025.apcprd02.prod.outlook.com (2603:1096:4:195::21)
 by TYZPR04MB8298.apcprd04.prod.outlook.com (2603:1096:405:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 09:42:53 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::67) by SI2PR02CA0025.outlook.office365.com
 (2603:1096:4:195::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Wed, 21 Aug 2024 09:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server id 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024
 09:42:52 +0000
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
Subject: [PATCH v13 20/29] ARM: dts: aspeed: yosemite4: support medusa board adc sensors
Date: Wed, 21 Aug 2024 17:40:31 +0800
Message-Id: <20240821094043.4126132-21-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|TYZPR04MB8298:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cdd22b0d-932c-452d-d60e-08dcc1c5a0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f++Ji3FMJJbMaR9f50piTS6VR7tY4gO5VP8kcvHZMvbHvbRBBcMFe9pKwxul?=
 =?us-ascii?Q?w/dLNdJMu1C7JFt5jLrx8ZjeJyfw05kvJ74qy1YnF7SyLW4G5Vg+7765JgTh?=
 =?us-ascii?Q?dq3WBFMTADzOVDLDfkSpliRWp8XQF86ZpkxhRZyaz14mfxkxbOhVIhqDNeQD?=
 =?us-ascii?Q?fIrxAFRGALOK1PUZI8VE3G4MkUshUuvY9/FzSjnnYSArrk467Dxuiyko5KLp?=
 =?us-ascii?Q?gQWTPwvV+ss7UiWj/6yzsTkOyHxDbz8NjsAWoxuhJhxoi7Ija7VX47Muifk2?=
 =?us-ascii?Q?FbIdkSN3pfkq2uGEGhjEtC6A6Lp1MGLwwDGXn8uLb1jOpd4QHPKrxr2ZDidj?=
 =?us-ascii?Q?Q0aTzi0t9xxbQmxwsGOpyflN3ifxiz6oxhXKUYcepdtIp0/MwdrduY16nkd5?=
 =?us-ascii?Q?SpcMosNGGSKp/IHa3Y4l5nJVv6471KZ57ysAEMdjmMd0tBweYgchM16mm0FN?=
 =?us-ascii?Q?lzVh+Q2Z7nfIGb1kulez9xILG+F3rzFzuYnC+yF+XLcJFhekmUi27pHToi4s?=
 =?us-ascii?Q?zsDWOZv1AVRYprGSJmEU3SkiHKMJn3JXlw9trQ7eWaYitrulyFurczFX4SSn?=
 =?us-ascii?Q?vWiorObru+pmVe93hIi9WNLfjHo2I5vQ5+m4iMd1XZlZKAW+D/ob/5P3JwZl?=
 =?us-ascii?Q?JV0aop+yXGgVIyrVt4hM07cC6izMvdamtpCjsY5NMJkPsdnuFdTBOFz6AawC?=
 =?us-ascii?Q?Hj38ti5bq2l0ijODz3ldBRANmGStXS0Im2ZA9EnT+UbsN1FK/A/5d1FY7XtB?=
 =?us-ascii?Q?Nsk00NKkyGhKtXNrt4XCLnRDa5sFTBJe9dddCUiVAKMW3GyLJ9wgRzmfbVXB?=
 =?us-ascii?Q?VskTzBkA/6lz9mkGsETHFesl1fOYvY3hLTSe3JVNSpDgkuZ6+ijbB8F7lU++?=
 =?us-ascii?Q?zW2hj4mvs4GHHmycXoj1JUkoquWwZgFYZDD7bvTflPJ2v6wGqLdgpyWx/SFk?=
 =?us-ascii?Q?k77SpmnDOyYjvaCnx3xqfNJKWJYccOq9fhABd4JLICBgqkAME8npFMDz2zHu?=
 =?us-ascii?Q?GzEdut+7wGMQXOHLja8k4iDdwilVy575eSZW7AgFRGzq7MtENX4oCWnF3p00?=
 =?us-ascii?Q?s1UEcFnlfQmxzxb91LsTD0oTTqCY89JYuTDAUM/YPWhv3ULQDd0BK+qJoO59?=
 =?us-ascii?Q?SY6P4giRR5nUm6FcSjA4Yj7oPq8RgOjc7DuI0BWyFnuukqhhc8B6kLzKd7Oj?=
 =?us-ascii?Q?ZJfo72gwYvdJP0QCkM3+v3OxJormsFralSMG688XYPGsdZ+AL3Ms+XUva1uf?=
 =?us-ascii?Q?p6ZumIYF/Av8qUZviayFOKTEqZLiYrcSUk7hDr+pA0xzc2blDIrg7p29tfvq?=
 =?us-ascii?Q?zefKjyGUYyync2PH4cnQKGbi8gBIJ2NPhYa2VbyU7hmifCxtlDePysfAszBc?=
 =?us-ascii?Q?EVhhY/dkc4mTI8XlYG2QlOxTuXbgplKz7xmOEci5qe1py6pIRBCrxSvlk4/e?=
 =?us-ascii?Q?0vOKPvsZbxI+q8+HJwEt16dThkResymZ?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 09:42:52.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd22b0d-932c-452d-d60e-08dcc1c5a0dd
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8298

Add ina233/ina28 support for medusa board adc sensors

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 98eeee49b082..49500db53a13 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -915,6 +915,19 @@ power-sensor@40 {
 		reg = <0x40>;
 	};
 
+	power-sensor@41 {
+			compatible = "ti,ina233";
+			resistor-calibration = /bits/ 16 <0x0a00>;
+			current-lsb= /bits/ 16 <0x0001>;
+			reg = <0x41>;
+	};
+
+	power-sensor@44 {
+			compatible = "ti,ina238";
+			shunt-resistor = <1000>;
+			reg = <0x44>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
-- 
2.25.1


