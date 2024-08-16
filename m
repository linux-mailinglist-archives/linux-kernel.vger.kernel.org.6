Return-Path: <linux-kernel+bounces-289367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B6954582
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648621F2495D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554812D744;
	Fri, 16 Aug 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="R+mJAkTu"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF427140E37;
	Fri, 16 Aug 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800284; cv=fail; b=D/WZ32XAvfiJ16jU6O53pa4pqrVBC6rfepDFgyX75pZVWaU7RBIloZcq4Da8k/jnIKAPl5Vwm7MTbnAsqeQYgs184ktGg2e4K+IgeK21MPh102Vqy37AE2eAp2X8j8EF3jm3kjf1lgBaSF799pkgyk3IFnowBXVa/TGmnYMYJpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800284; c=relaxed/simple;
	bh=73ACY2H/XC8HiFGPQdCgZZUhtUWvlcJspY0j/8nbnW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XihFcvQsHRdNBYNDhKIB3jCTJ9rZPbsaM/6zUcy1IpdkmjExc/eaDVIs6sY0kMWBMBBmScfB7Lh7ta4iTM5NUl0yIfrOgQzAFGDY+e/V5aic8jZ6hBLviLZR+VQzjhRnC1UKDUsxkXigcNGlwjzZWaC3yTc1V/dQhng01IQO6sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=R+mJAkTu; arc=fail smtp.client-ip=40.107.215.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njfzqSxboUS4gug8RAT1jk3fWRD38km5VBs4dEmYGI1CvonoCt8NyeeKVGVI2xrJKxCEdQ3g8QopXt7Cq1ik+7VMulGEGGIjIg/qdC52qqmDspoR7Zx+a4oPtnXLOvRffkbcDmk1QLllCdMQYzEyc2rrCUQlA/HXoP+cvd/Y8waeCtOkfIgt1gssEFSGE00kOZw2UCJxs95hM6JmEvU3pwaOk7Q8JQHfhA7FXBXMD2+6flAJlGhu4MHepi7pVOcT9RSCwYP2sPNyrPOL6RFA+FX6WZNlxE6CHejSH3c4rYh9PUn4jXNH8+xRknVT7eCCcM9neWFdNUuo9nX7GymcQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=nRoY51ifdXg1lSUzwsEDcwNK4hNYg9uvECr7PeimiU2jJ/kWlHH0EmAvIJ4ZZG4YLQZyFp/bTTEeJUArOaqDMx6N5hUUG+258OB7THaDxCkxdZlKAX7Dsyf5E8NQQ8wQA4uzWYXIKQrCYSo4q7k3mlZ5I/VreMBjDaAgMvhsbFtwlcLT93Q39T953lt7Yq+vNzMuTJKrd+mYp19gThhsksxs+DVIHtFI7zwmUyVz1ddKikc3Gvo95/I2gBOlwmb+GpWIRkK/qNcHDW/+htbnfBGIqBPybwDbnUg6x9P9O3CH3b28JjX11hgifeXQ3O58RUDFc+uDb0JGGQqRrmTS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmNKl6yn93kcqul1yKpNviuiMr4uSmPfzjmHAX59pcs=;
 b=R+mJAkTuwlSCq8F+RgXsEe/Ulb5ObxbUJJ0F1o8w67BD4EiS8O3vAbolAnJkiG7q0f6nZfYnQbD4phBa1bfKmB2Ex7gXbvX8PCzEByDvJRHMwcP2MEkynjLkCHwhcjsJz/5zME2oLjfd9PVh2V3isfDv7Qg5hYl+rJwfpkEIqBdbm7EpHf8uaNWi47Cl3ZlL6iFH2g4pKC7PTpY9MeNAv9J8ZT2PhBtT/c4nvPSs3HdGtStRuE07fVAjgxUcNCwvGJMmNv4SKEe2dkq8jhECaoxNlvpq/NTNvUUQbJIOQ5ChZTxFA7SqiIbJ3RS5OPKmtOvBi8p19xa/uXYOHKU9Rg==
Received: from SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) by KL1PR04MB7078.apcprd04.prod.outlook.com
 (2603:1096:820:fa::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 09:24:37 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::a3) by SI2PR01CA0047.outlook.office365.com
 (2603:1096:4:193::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 09:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server id 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 09:24:37
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
Subject: [PATCH v12 02/28] ARM: dts: aspeed: yosemite4: Enable adc15
Date: Fri, 16 Aug 2024 17:23:49 +0800
Message-Id: <20240816092417.3651434-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021D:EE_|KL1PR04MB7078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b703381d-fac2-47ed-6f46-08dcbdd53fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qmHpKBGcRPpYhaHX+k6OgKBfn92d+/rmXpbFJ8bN3ENri1+pn+cF12LuPV7y?=
 =?us-ascii?Q?nziL04qsKiL8VojGfBj9L/DyBNqsragvKUNgFJrAUITs13K4pvnlyfA3lpDy?=
 =?us-ascii?Q?DwDKwvlCYT5mcLxfEntXpLdEYf4+KUPhI8wdVek0R7UYwhdbeChTzkvfrL8D?=
 =?us-ascii?Q?nxR3Az9t9ajkrcETcFQHhmkH7oq3+U8083XchU6rK3Q84OkMfxyy4zYBvW/E?=
 =?us-ascii?Q?cMF5tEr2L0AFv7B08QsuL5oLQH3cchA992wvxFUmiOKZZCE511DjWOgVENmE?=
 =?us-ascii?Q?eyCCS5rgrGeN/DLfMQ5ypVRNVwnz6f5PcghxYwRyS9em7/Bj6Dn/vWvtDHmn?=
 =?us-ascii?Q?IhbcRB8joDhhIj6Xq6CTAMsc804m4Gcr+8sL89be3RQQgF4wLC+X+wwThgMz?=
 =?us-ascii?Q?oOr94q6WgqiOETqhOisAy/uBFplXE0IDb0N1la+ZHYN75RMDOW397d/NdA5w?=
 =?us-ascii?Q?6MhPiJHcUsZj3d0SCnfPuPEHwsVGmE4eu+1IL0qjhYyJ+q5THv3b29/6gVok?=
 =?us-ascii?Q?i1YQGPtFkP400axKa7bAmdH9UkmoCrpY9PxKJ1mENc5pnscPeere3norIR1e?=
 =?us-ascii?Q?+7szkS/pydlTn2K6W21PBc7MgqLVstJ8mLUtvOWyLM0jlLIu7gNemlrq+V1C?=
 =?us-ascii?Q?kUs+fDhZzB0g0K2H50WhP+sGdW3LhW9uWuUaZ6F7vqbpwFtgTuqH6pYtTq5o?=
 =?us-ascii?Q?lJYd4Mo6d8uzwAwWZk+HBGnGqWwGfhdGbpJZIKYzILqL4NU6lnjmr6SzXgDX?=
 =?us-ascii?Q?Vsod/GS2ZmvhHOomRs5AP3d7nROvTOIjkA+k2L0gw1TNRmuJmuQFR2wla+tm?=
 =?us-ascii?Q?mzjeDUAt8c+cB2SL3uZiWPbFiLdrwmi6z4pVTU9BB4sTANMxIomTOdI9XtgV?=
 =?us-ascii?Q?KQkPHwbIH1JPK9QNwttbsG7XIWUgfx3oV4b0Mllx6TZ3CcbbwJxihzbbiL1n?=
 =?us-ascii?Q?uPIcKgZ47mzWqGVgcXWdtEAeZITQ2qe2yWeL8etfuSo9g4bF2SCSk59HHX4o?=
 =?us-ascii?Q?Qk7W2wbF5WReWM1ELggpc88vksMrgNTHK7d7E1Aur1U51zvFrIbIYpDCPwJe?=
 =?us-ascii?Q?8uANzDnlnw9J/5HKdbVhEB8xPitTucXasVvptGYYE/8c3SYHWN4Q9/SwYGhf?=
 =?us-ascii?Q?S2p+ai3RYIrK+a4PtfRyn+2m/bQ7Q/681Rapu/W3USUDTD7YBukS16AE1/BF?=
 =?us-ascii?Q?pwBPEyRUWLjXXTVS/rOyTSly5UoaMDlYbmAjETgt54Br5uRurYECggQxgiKi?=
 =?us-ascii?Q?GbGkjlt4aV0tBmO753TnoWtGSfv73AO16pY99nB89cZv6DwDNc9iFY2jioLX?=
 =?us-ascii?Q?ZodUsblI5+Y63srvJ28X4Yfw0Bw1GrQ57RqPo7eqi0A/jZNXbWKVykEG+eVL?=
 =?us-ascii?Q?6xlG/cQAzqn142YmFetAd52jGk6aNV5hwxYKx7oaKOgMj6x4L/5mMAJ15omI?=
 =?us-ascii?Q?Ea/+cu6S07s=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 09:24:37.3566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b703381d-fac2-47ed-6f46-08dcbdd53fd7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021D.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB7078

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


