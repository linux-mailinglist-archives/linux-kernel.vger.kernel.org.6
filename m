Return-Path: <linux-kernel+bounces-322180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F2397255C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75B4285944
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA59A18CC10;
	Mon,  9 Sep 2024 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NY3+yq3p"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2047.outbound.protection.outlook.com [40.92.45.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDDB189B82;
	Mon,  9 Sep 2024 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921393; cv=fail; b=TzEgz7YBCb6tJJb4fhpcTgrHpjUlBEpYcCDhWSNvePpJf6wrhYRjljB20WiAIjjcdSqr7J3Fu3FuAYGbxaaP9RMnwmjNcwhmwIKdmNhR5oEx3bHvUTKoualxpOSC0kqwaYjNXUlPyXXq/wF67sK1FUOGMNF6LPNw1LzHByE6URY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921393; c=relaxed/simple;
	bh=1EaDvX0gaQDnqaRyL1+DDN736M+VRNlIcC3so1TyP4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njlLVObUG+PqFKLxxn054hTFdXXQCSD5EfEeQn6s0E3yu9+ETU8adCFlapXLEDfDQ5J791wqOcqOOakVNpCvKAVx4eF/JkoMn5BwantKL8DmJnWa40htC6xGyf/igPOBggH5sGXrnentlFeEdgDwPUTjUg48LzENW4Ba/KmWi1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NY3+yq3p; arc=fail smtp.client-ip=40.92.45.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyentPL6NMs9Naoci1RWZU3MlWzkrEm0A1O+0gBX42dga1zWWxAAXngeKpAWgpw7JwgP4HT8pH6ytbui0USMfn+beiwFrii6DxqC7Vf2ewhrwWOKQx+p+b1lGAMQGPzOBZfmI/rjOPOcz2fr5TefKGJb9U4UWG3AV8adjUz0eEzGTuHQIUmYB8oF6Td1ObvSLNdPRJPFMceRq+qJMmHSCAdsjAwM1mvFi0D2iE7SUCQ8zMMaZGBnrEbj2qNbu+Q6GJTv3eQWY8HjqHnNUsxDhnopS2Kf8sFQ7bUZCVVHNNF9k6V9a0f51cA5OGn/H9+ODP6r4KDUa2drlhzI19y9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFX+B6+2JV/lJFkNZJ22XDLTbFXl6jO6eHRtuqk44og=;
 b=Wc1BuQ+kLE6PaPxJ30+SDDYUP4KKdmRcDh53ipeDmM6l6DHyk1MMF6BSCBT/qrO3NYzNZ9azYRIG0g2CtIS3TyEg+8gagS7RkSkQnJhQ8miVBPo5Pe+E60OXHFsdmi3u0cZ1+0F3q6wjLqswsbn95LbfY4iqE0t8vs1GxQKg4KTdQt1NWoZB1vDfsx3Vny4UR0FETMtmwWnFLQwO8pKMe5LW3pEAc+COYpW6Epb1daeSqIvboUDDpyNX4lqc55unuMRh3b5FpLjvhr1u2+bs2qHMkY5Y8O7oH0AYBTVasFwmMM1Ibk6oARHjYd8W/pYGTDpyFCawoEhrvyA0qubM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFX+B6+2JV/lJFkNZJ22XDLTbFXl6jO6eHRtuqk44og=;
 b=NY3+yq3pglNdAo2vv7Wn9YRf56JWCfTCM8Ai6GZAjuOwICWsG6HrZEiDOZmqw6L3C3xqibNIzibsKFuFS6q8/x6UpDOgRqpukZ7KvS3bJbBfa2Vxp6yzfQYDuikk0JL74+c/mI1v9VZudM3OI9wRaGPQG3umBGVv9l/iTjT0CVNsh1Bu3jUkLFCPrzdU3wN82u3Lja4+a2zRWa0Tw0mG/x+enLoUT3oxMcaa1VB/fBMMM728q0fmQrPfh+gzwc8vpbeEGroYkeeDKpXk1AWNXUYrbhEI3HWOUpiz2KiF+zdHQc7tOcjsMJ7EfNVmssgfYsW5TXSXMiRDMaRbL0nYaQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5195.namprd20.prod.outlook.com (2603:10b6:510:1c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 22:36:28 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 22:36:28 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] riscv: dts: sophgo: cv1800b: add pinctrl support
Date: Tue, 10 Sep 2024 06:35:10 +0800
Message-ID:
 <IA1PR20MB49535E7F28242174CA318317BB992@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB49538E389C866882FAF35B8CBB992@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538E389C866882FAF35B8CBB992@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [J/2BGSXaf/nDXG1h5VFEoxcCSR0UqpJJlWRiDqcxz9g=]
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240909223511.33713-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5195:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9b5649-5445-475c-b15b-08dcd11fd870
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|461199028|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	rB7PHSeGDiQ2LCIyJ/4Q1ud79Ac4Qv+aKs1UysU+g9BK/RtIbHQVo0Rf3sqVB6CggwMrnS5X5BTtnj0mWpk9Wsw8gCF9CdwYdAV1OH5jwtIzJej+1a7dve/okuC1tZQ+H9daOG5tAIDo4NuH2808JjeOtt7yEZcKvwm+Vz9KY5HTpjNwEGVrCFhj4H0g1CDJKoosKP1P+xWnLqaABRr2Zpc2TSRouQBmPlhKbSy/EPJTu0NCG8s4u8OBu54irbND5Hie6vm/fGLoY5mtTGgeMg8mxsO90uxJCbeUFsFQvI/A3hHQ15xEfCAQstExzZx4bKyindKADA0famnM/w3UXGMaBhu0XUfRfXs3LFXL4WBdQRzY0Q9hFCGKTmYsBQlu7JDHA63EhslbqxRslSBs92oo3xO1WaeZTzew+p/OiRO63MYd8HVixAEVM/FknFroOO8Owp2DyCXrpE4EYEHvyv1/xaNOUNE1SwqJkpAsImjf3op1akKQKMmocbS2KFKqJ/HISIuPa5hGP1m/IpmZumgKSZoHuiBWiQ+yh/5SAuku4nrZC8zWtLBoERN/IrXy50R3RE8cjlg0jnRe4XywBPA2uLDxL3pTpukxt3iqFuDktoKceG4/DRSYFOzfi+DU0iDBYR+A0avlkf5Kh3Orr8GiKJZT3c5sTvYmwWrZdwJYUuD+/NZHvmq8sgUNO58pXtrgrtypYFjKa9XRB4uZ36DDE3tzVKvLwn6rJY3WPNM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oAZgw2oVlNShIynL6rjnbrLBjU1KfbcJhqBQ6RIUsRZyj6KyEiqEFUZ2/+PH?=
 =?us-ascii?Q?GDEhJ0r9OBeOaCf0VlAeSE/B5c+IjYFwTC0FtaLyZejxJ3RjdgkqAvS1IHXB?=
 =?us-ascii?Q?XSD9E+hDg16TT/HQG5SI2LEocwzPg+hCx6onNsw9JKrovRc8lxL7Pxz9y//9?=
 =?us-ascii?Q?QciwpCCS9F6a7KiuR4FREoa5n7Zrg7PXidHzfjv8GEQTiGlCCVcwGypW5gX8?=
 =?us-ascii?Q?1osjjIb67STlKwjUlGismiYg0C5zlxT3aTUVx7hfQ1tuIFBOGmoCZMPMkUKZ?=
 =?us-ascii?Q?b6GIQuoTimHAKI0dclbSjCx3efCsFMu2UYoXgCIv8nO1bScjT/7Zq2CdIQAK?=
 =?us-ascii?Q?EChLcs7ObBBo/QfyfP6Bfl7VitLnSWQc7THtkn04I7pXiqWP8zk0PujsBYx5?=
 =?us-ascii?Q?/qG0GNJJ7D07crAYsrd6QhuYUKqaBVUT/I2/Lk6JIDt5UuQ5a9J8lRzUWpV+?=
 =?us-ascii?Q?H3C5Myw3C4FxvgJP88lRHs6zCfMBkv/QRkhIgZH7vXiKmutGVz1uL/FH1olA?=
 =?us-ascii?Q?lxg2o1L1q4/qDXHCDHXSHpiqOYkPPwPLsSAcm+2N7penoG0BkAN4TzLLm5I9?=
 =?us-ascii?Q?4qbCt3mTHOHg8gCNBM3tE2JFGDLrNCRI2Vclf/WszEr5IWK8BOc+eB1D5I0h?=
 =?us-ascii?Q?kTM/ERJNKeTXabY3NFpxYeQ6iy/bd8snBo4G5lj17WYElACCZdrWU16E6821?=
 =?us-ascii?Q?QhLHpFLaxh9TmjC6TVHfFX1NH1H5aUur7unV8NLCLyipUpMdIKtRKykplEVw?=
 =?us-ascii?Q?p9CU9UQfsqnub4+x6tIlvv1UNfb39Y/0hGs+h9Us9K5DlgV5j6wpNA+Q6O5D?=
 =?us-ascii?Q?Lnawd0g8JzEgQgMA61YiC1OMpGOTEKDDXgX6ueV7RFCtLLH46pq0kevw7DeU?=
 =?us-ascii?Q?q+gUTLE3+YPTQpwbI3tXmfVgTn2O2T8TXOlTgUZFztXb7GqWVdCuBSpzmd77?=
 =?us-ascii?Q?d0gVU27/mkywmTmgtVwHQ3Y5MaPUuIE1cTUNtSC6IJI/BY0dqMJ2P1GJNdDP?=
 =?us-ascii?Q?ScKiY8+zSMkXmmvAZe2CdsPRPlZ1xJ6EdUYHaPcQPIUFcjAT6g0OAoI4TX/a?=
 =?us-ascii?Q?+W8LJP4PZO80V0u3vrU80eRPTa27LT8/dmYFiG+GsZhxMA/zE33+OJl6QDzX?=
 =?us-ascii?Q?TkoKUXwLXD4YFASU/lLeB843949Dt3q+oKYGTOMTJsVJZsmoqTyOH+n6buiL?=
 =?us-ascii?Q?tmaz9Ep/J4C/skT+jIjBDNOGm2m0CDrtAMAEF6WiKD9qOELpxDAo/boSa1Qw?=
 =?us-ascii?Q?GYvhzC1qaopQr0ISHpK/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9b5649-5445-475c-b15b-08dcd11fd870
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:36:28.6902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5195

Add pinctrl node and related pin configuration for CV1800B SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../boot/dts/sophgo/cv1800b-milkv-duo.dts     | 49 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi       | 10 ++++
 2 files changed, 59 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
index 375ff2661b6e..9feb520eaec4 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
@@ -39,7 +39,54 @@ &osc {
 	clock-frequency = <25000000>;
 };
 
+&pinctrl {
+	uart0_cfg: uart0-cfg {
+		uart0-pins {
+			pinmux = <PINMUX(PIN_UART0_TX, 0)>,
+				 <PINMUX(PIN_UART0_RX, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+
+	sdhci0_cfg: sdhci0-cfg {
+		sdhci0-clk-pins {
+			pinmux = <PINMUX(PIN_SD0_CLK, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <16100>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cmd-pins {
+			pinmux = <PINMUX(PIN_SD0_CMD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-data-pins {
+			pinmux = <PINMUX(PIN_SD0_D0, 0)>,
+				 <PINMUX(PIN_SD0_D1, 0)>,
+				 <PINMUX(PIN_SD0_D2, 0)>,
+				 <PINMUX(PIN_SD0_D3, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+
+		sdhci0-cd-pins {
+			pinmux = <PINMUX(PIN_SD0_CD, 0)>;
+			bias-pull-up;
+			drive-strength-microamp = <10800>;
+			power-source = <3300>;
+		};
+	};
+};
+
 &sdhci0 {
+	pinctrl-0 = <&sdhci0_cfg>;
+	pinctrl-names = "default";
 	status = "okay";
 	bus-width = <4>;
 	no-1-8-v;
@@ -49,5 +96,7 @@ &sdhci0 {
 };
 
 &uart0 {
+	pinctrl-0 = <&uart0_cfg>;
+	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index ec9530972ae2..aa1f5df100f0 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
  */
 
+#include <dt-bindings/pinctrl/pinctrl-cv1800b.h>
 #include "cv18xx.dtsi"
 
 / {
@@ -12,6 +13,15 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x4000000>;
 	};
+
+	soc {
+		pinctrl: pinctrl@3001000 {
+			compatible = "sophgo,cv1800b-pinctrl";
+			reg = <0x03001000 0x1000>,
+			      <0x05027000 0x1000>;
+			reg-names = "sys", "rtc";
+		};
+	};
 };
 
 &plic {
-- 
2.46.0


