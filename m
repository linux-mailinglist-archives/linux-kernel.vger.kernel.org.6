Return-Path: <linux-kernel+bounces-259806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280A9939D77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32092832D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E971614E2C5;
	Tue, 23 Jul 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="G6tkJz1a"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928914D6F5;
	Tue, 23 Jul 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726615; cv=fail; b=rLtkNOPO1ocUb46Q15MiK3c9Cz940aKl+lBJdVNhK7YaubggF5/aCbcRQgV42TLfpPPfcUs1NEQZWwLvdSHTjSKeo5EdQewA7/YpC6kwogzbhbQ3RUlN7ElxbBNDZFzhCGwNU/ICeuFRS0hQM8hJn4822CYp3JH+g/F43tkVMVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726615; c=relaxed/simple;
	bh=73ACY2H/XC8HiFGPQdCgZZUhtUWvlcJspY0j/8nbnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owrP7xmr9ADQL7fDaCvrisZRmqaSWMzB+2z1/8Bh1/zQqg0j25U4Vz8Lcc5YktisXNA7Cwrx9zwkcjprhgOwlt7iV5GX1EqxuAN2Y9rhd9mLcO3/Qa4Z4vtDVhuEEqnBz3qveJONisBq+5lBSjJWZnF5BsM2bbXFvGgJm3493Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=G6tkJz1a; arc=fail smtp.client-ip=40.107.215.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBPIOPH/HvuEDZhUsqfMKHYl99rzYUa5/rFGG1a46ZiqycK/TI3dMzxqe2cdpQ0qNxBgkh9G6yZJD9jK1HTwlV9tQzavQbTk0saTGKkm9dyrb6C2Cro47CzJkXc1+O8WTJfx/X/aeyq927RqMH0//NWUAx4pbJv2b2cbGHND2IPcSwpbGlbEyniWGwRHNItplN7N5s1MGfR7hS3OplJGrBHwfSWkPH1Gx1JI8SyCUYhbEIsqkMfd9ALyeignJ1WTLozgKDva6yTgjzCbuPbssx/LNuRneN3sFfnOZruQ7t6FBrNiNRoi7Pvv8Z7MyjZVV0HzpCFrljytpTGYNgOvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=Kpxa5h4Hf0guliq/39/NrbszO+K6s+g/ospvXQaGLp5r2rO+yqOboTCU3bi2bNrg6jYgziGLYbvHCVnHEGB83dBJdNDjB8P/oZFaPHdXdQho/atgFYKNwOHVYEknoBI19Upmdbpz1mydTKbkFV6hpzCyv513zrLzG7c9Lrdqm8stWjNAmaQNgaUoyukP5/9q7nI3LUfu1MM3tU1me5yQm7KB47ty9xp5jidPtw0+mRfpcZzygNxwiVGGD5EfstK0fu65BmCkZg5TRJQglHBFaZ3NKjsiIFdkmge61TZZfvKGCgVCNSARv/+L7kqCZdgkKVBRWPF4HSRnnstgPXX2rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=G6tkJz1atu8Q957qIjfjInwQSIlKiwzjbADZWEmeHZSPghyqYn9KBmjoXTSl18InsNo45RZwVN/zgQcUsQh4WzqNUYZfVCMrbFkwtENxQhqCPy12S38mt/7fNIYy2+Igc3yMyJ4vIZXx0xfu542dBbZvT8hfFZwPFfaquX//SisKM6uX8Vijvs48PhYHtUGjoARGy/Lh8zqVAY6mLs4oTCc4bpGjSAXrtG/HggXKBmGB2OgbHoUVSWDRBT/YJ1kSdHz/8Yi0GvJOswgUQN108Sp9FGpoDFpY0UxNiGOoIvuhSqmMniTu1FCelk7gg9pN+nS7CvEOUuWzqH4F/YBFvA==
Received: from PS1PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::27) by SEYPR04MB7496.apcprd04.prod.outlook.com
 (2603:1096:101:1db::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.9; Tue, 23 Jul
 2024 09:23:27 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:75:cafe::59) by PS1PR01CA0015.outlook.office365.com
 (2603:1096:300:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Tue, 23 Jul 2024 09:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.7784.11 via Frontend Transport; Tue, 23 Jul 2024 09:23:26
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
Subject: [PATCH v11 02/27] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Tue, 23 Jul 2024 17:22:43 +0800
Message-Id: <20240723092310.3565410-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240723092310.3565410-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR04MB7496:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6af80a4-91ba-42f5-93eb-08dcaaf91ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UuvFZwS7HqZTFW2EW9R4ujBUmDvxMmo1AOuRtg2yYr9s7EomrDH3VMeVV54s?=
 =?us-ascii?Q?AZyC8DUyzRmUHVM1K1Uye7810RZrnTQCZM0lHFzd/94pNFjvJsVw3XaqI2K3?=
 =?us-ascii?Q?0X06x5WpeptKbZDsQ2fzQtNOvslCiC+ZOsnM/fIG/8etLeITscyiOXWaA2nd?=
 =?us-ascii?Q?EEmS0yos+CeowetF2X/3I0mJ2RWawdfHupNhxDL8/yVesBvr5qx/R+BOE4+1?=
 =?us-ascii?Q?oTbV9OlUfEV4qNbZHXDvoIAVC+1Ka3Xg86un3YhzC1cz+2vTbTq+QpkB55qM?=
 =?us-ascii?Q?sRK7yQDrc1lMPuYZLcMom0fMP+lxhK1/jb6TGnqgmeGreW8CIH6vEAQ6HSJX?=
 =?us-ascii?Q?WmRxY5MOGZpyI7NtCYoengo8tU3JoONJAXVl3YnvjD+JrujK0nq8DNvGcY5s?=
 =?us-ascii?Q?B6J0dfnLZqO+s69Nljl95OCSyxyn5zpECa2m59AdJrPBjyGEtZ/I6LIk2lHE?=
 =?us-ascii?Q?w/9IaBpzGrNKKIKMyl8y6Z+AXt4k+1ngz5mLu0rbuaP6dBnamqjsXbKXfqOB?=
 =?us-ascii?Q?6NsFDCZy1U4NlY9/r/v0DigqxCZxiPbJCmH46pPF6gdUDMkNawKiUE1s549a?=
 =?us-ascii?Q?UXEeSeJ8r12CnqoBy6uTNobV5S8ElDVpmo3D1c/exCbfaWBJiBBJjI2RM/8J?=
 =?us-ascii?Q?Dsb0+xtCMBd2ruUgJuCc3BGVZOcF7M70vptiu/f6llnJrPRECfWyk5nz2dUL?=
 =?us-ascii?Q?/cCtxvYe9K3Bc/MDQKNP3cenAi82bYY7pfLwWBzaqItcLEhrqhKJNwaLg5aR?=
 =?us-ascii?Q?0ICpZiBrnwhJr1aXl07DWERv4xk/hAhtKZGKp6M0BbUG0Q6CC5/FgSr4+N2/?=
 =?us-ascii?Q?rczbSdx8Tr33uQjnBqGgKiTyipLnZLCcrA8LU6gMUTPJKDdk0FxwKCmG3aGI?=
 =?us-ascii?Q?nt4cLsYfI3kC/fl4aRgpNrzee5Qmu93pXUJfbCvyoAR7ocMlY9kSAwN6PADK?=
 =?us-ascii?Q?M/LZj9UIC4Yr0kwB084SIsBtTF1B+IgXkDlK9TCrvUS1Zv3kIMeGUymrFIp5?=
 =?us-ascii?Q?GsbwcnWxF8vbB3fyisjXGzxQ625b4UyVDwnoo4cnFhh+tlEBt3eViK+xUwSc?=
 =?us-ascii?Q?SvIE8enbUg217vTeyyp+zbnj51UEnvEmafwA+aLNbiWBg/bvpYKJlxk71AS0?=
 =?us-ascii?Q?v4bV1U/Ai4nn90hWoNZ+vm7r5qvJnY62UhSeJVwF1EpWeVP4OEI1DKmErolA?=
 =?us-ascii?Q?cgm/u1tnEtPKul+KlYUZqMRIWGz1HbO8lpQTNuHPFr8IweBYYKAcpNy/M9az?=
 =?us-ascii?Q?nLYxSdAVTVlPOgpFQh5mOlGvZX0VR76X+x6bPlfLVqjqxnm/NPFKPiCwZsDS?=
 =?us-ascii?Q?l8Y4jytoS1zWaXh/m3Yqb0XvoR10gQVxfnJ+3YYsr34fn5rHHjCTKtcm1BYE?=
 =?us-ascii?Q?uZbRIcQuO4ZCkQLO4up3oUMmRDHLnPHahib/8T3RMy0xxh9hW9i6f4G7RYcy?=
 =?us-ascii?Q?DJ3nnl3eNbI=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:23:26.5191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6af80a4-91ba-42f5-93eb-08dcaaf91ba8
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7496

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ce206e2c461b..0d659ee2bc19 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -925,10 +925,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 
 &adc1 {
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>
+			&pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1


