Return-Path: <linux-kernel+bounces-309548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B72966CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBE61C21C55
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58AE1C1AD4;
	Fri, 30 Aug 2024 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KMlINEnZ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2046.outbound.protection.outlook.com [40.92.47.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DC14E2E1;
	Fri, 30 Aug 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057651; cv=fail; b=dJvQI8EKGfwwjC0wovTLvvAM1Bz+pfnn8vABFxX3FXfozk3Uu8e+UKetAq0zRXSyBIDlec8pKtoyYwF8gn+IDW41Dx83Lo/3vv3RKMG1oNJHIjKtaEqYppN5r4jCZEThPCnZs/tSt/qGBOUH3tIAQszq7YKBOLW+j5kfZ93DZCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057651; c=relaxed/simple;
	bh=im6eG00/8qRAISayC3vWmtd774nZeA0mhNX7rIANZvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ikd/OcIKrWKgTvFVHQyHVY17OsHZqIv3nPjPstpA91t8N7AHxS9Rr4yiheJu/sDxhcAJWBObdx7b5vGBkqIY+Ai5QxZ80xk4GfnZEVboNynlkgnXIHWDpICSK0foLJ4LInlhmNlWqxExcqur+ESVZPKazb5YoMLfH5zgz94jCB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KMlINEnZ; arc=fail smtp.client-ip=40.92.47.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxXCT7zuSpat3IDcx9k9xeYK4bohfr0uzX0vRjBMjov1iV4rqSguxyKJvF9zOGmA15BeVtRswY7/jBxAeooO0vjlypUkHejYm8yDX4XdmjoID/T3aupD3875nSXNW/vOthGVMFeE224/xrqsktPXaH2lelNTrATIfxEqM5mrcHIfsxrZp6rrCTC0pHfPM2YzPJ/N3Chd11z9BeNZ6A4lLbhHfYBRMS78R4KRhlWyRoWCUCkLY4Ce5o5ZlDKKaLec12CRU91g0gr7t3aVlrrHZ1nnzX0OHhNOp+fBQlao3SB6LlYtmNlv0sNjF8uQkxM6emzbxSadLISXTMBoEQj78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tMdoJKUcFhW9N16PjBtXK4Yy/yKi0NCQNR05/20ius=;
 b=IsEA7Ux6MbA+nwqIfpUyoRC/qzg21VEzSK24cQLbivEfWZrvIBEXCO7Sm0cp2FW6GShTxz5pO0F2eJfMgMlWWCJRTTiUYoHBK+52ALGfeME6+IYDjn59ubEbbW82MFx6v6BisUo/gQbV7G7Elt/Gx4rVqAJOe3A40bGi8Nds6lBtvsUSdwO6Ka5XQQ0YyniNU/i+6ui68hcGaclN4dU1nNsbdBxO5x8ApRy+KwRivl6akURv9g9NWQSecSOhX8xR5KeM7qZKGZsAeCM8+ID4yRw1wh3xMYALnKem7XJnb4aV11KloUsD2PPkWnRWd3cMQP5nJcF9nfHLtA1cph9zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tMdoJKUcFhW9N16PjBtXK4Yy/yKi0NCQNR05/20ius=;
 b=KMlINEnZNeLIdH3gYoC/mTwg+Va0doei7buRS7TzQAFZ9PetdOtIovPlk2YuKIjc/OiJSYwNVI0SCdbbiqIJ8dowZrIdWUyAbEdTwAYHyWTh4Ch5aBoL6ebWRF0DEpWHByJoTydfAvA3EoeVrfVy2TeaWWmlM+scfZrhkgic6ahK+4GpuLWzBcC74e9JYepf+Ufqc7Qf3I8MD9HoX/Sz2rWwmf66p/UsNTtRAQNhfDtUb614hZjH4JRgE9T2U9qprXrmdrx+CKX/t3kNO8WL2+22aPOEfBGZvXhS6g0pkROVYgXY3yN3zW1fa3Yqq2IhrKYzgS4HUkUaoEX9Z5QvmQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by LV8PR20MB7473.namprd20.prod.outlook.com (2603:10b6:408:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Fri, 30 Aug
 2024 22:40:46 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 22:40:46 +0000
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
Subject: [PATCH v5 1/2] riscv: dts: sophgo: cv1800b: add pinctrl support
Date: Sat, 31 Aug 2024 06:39:40 +0800
Message-ID:
 <IA1PR20MB4953F9D378DF2C3E739319BABB972@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495374DB8C4208575AAC9675BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [mFE10AW4YCpZq8EOi07DjUdtbmaHpuor3X15D6PtoRk=]
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240830223942.27776-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|LV8PR20MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2996c4-fcc1-4a43-4485-08dcc944ca17
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|461199028|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	/gn30HGspPujjtT4BTzWRVwBuHGzMzWES1trX1beEQR9MO1Xt5QVwy3wqKpv+ikWRs0yYy4vr/YQ97KEZM2thNKDbCsPXCHBeApPiqTSsU9YyrOvFlHmjHHgehAUXnxUlTOMyiysXzLdGZDOuyDX/juRPz4SSaK7GoEFLcO4cQcle8W6B3CBs31/9b2hsEECvLmOma3blGnHdGcfUraILAjlQRxF22HPQhnzBaBenEX+QwGgpX78EkOOtBqRNpezxJJZWbUglpb0WGxSmMpviCZfb/L8Ob8Ms5MtL3BplAmqWnKRVm42l50TvpAhQMSLxw3RHX2mjzKUYCjDCFsTgaiMqvGeIUR2yvw+PUvXwfQVjlo/9p96C6/uj5D9oam43SO4Z9mlKTvdjip37d98pKnP5S9j1glzMzIHqG4ofBxjepp9oRVvlOEX7KyWMqH5GtnQtrhnVz4hOwO8kws9Zy0Bpj+v6aDof90hTQKcp92aHMIOiq48S/Z496NqFLuVNHQAx8uGWL30bp3oOGPsQuVCHAsK6c13pPZP7NAU7snzG/vf+4NYsIkvW2rHu24r5uyBD0/QxR8c5FPkajaXoGMEqi07CYR6vrWDeJ6KD7Oa8PsGpufJW8V6yt3nixRaiiOoAR6B1tczBL2m7tZRSKDV31ca4dkHaK2exlhv2RAmKvYV1oVnfIwdr97gV4d+G3cTa7VGvglRNT5SXMV9YBWy4FDCnl3/52nv7w/SU/Q=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kb6+6rRvqiY3imlnTX3wkbFJdiIxxHXUfIWo7M05X00WpZk/l+kPGN/0uCuO?=
 =?us-ascii?Q?J2MnRJAVNePx6iWgqIFgC/WjyC51W99axbYrM9O80LZzIcZEU4V8LPq+/iKm?=
 =?us-ascii?Q?KqWqkjv4r1N41k4pLHJXysotKCo80IZYDKkHzeusdBZ7M8G08bpt6twfLtQK?=
 =?us-ascii?Q?cdJnVgAwvYdnJysbYQBAXnSqtI3w4dc0uLc9sTxG4ra7XQJuzbQ3eRCDvNWA?=
 =?us-ascii?Q?j97r857Rtl0OLdr2xT73sfMvsqCQkzOCFPF6sQXCtLols7TTfenJxyBVq44N?=
 =?us-ascii?Q?JiF3O9I4xa6KoBXUXVFdKhlYH2+fiihLPdRjDM+g35x0GsWexTgxXag65WLZ?=
 =?us-ascii?Q?ENpL6PksmpkSD9yR/KYDkeMXuB6kAaoGnSind5+p/9dIBJFdrMhITLLzVc7S?=
 =?us-ascii?Q?e+ebhvrNk/M5u/nwmqDDNkJKfNVFSmQD3yz7kvfwuWVXeedORTU1TWYjefiG?=
 =?us-ascii?Q?TFkXI29QedKIKOook1DxF7w4RpwnlzqqgY+ve4HzPcfxCz58NT9v6vaWB9D9?=
 =?us-ascii?Q?exkinhdS4IIlzsVWHUmkXKeqOK0u7rnT7F4OQMw+n92eVAB4fGqGwGqP2sEt?=
 =?us-ascii?Q?TN503g8F6ZHZsy3toP/fpQ3qcCH1sVEkPvj0M0jPFYFAwS3HZEtYU82lSzI7?=
 =?us-ascii?Q?/60dDRV1XqtQv8U6utCp67cpmguHXqlHzWggGdfvd2RXr8LsXvUlYv+hQKw5?=
 =?us-ascii?Q?alkNVipdMePbx34mXR79/83tLMrRCxfb54xhcN9d6hOf8NtWTGmXetvN85IR?=
 =?us-ascii?Q?RTg00jJFrGvj/I0NvsqKHCCoIkBq7LptqeRVkEhDlpC++qMGwr2a8kDXNgnJ?=
 =?us-ascii?Q?RLh5wl/4Gy87h+sHkyGngwE5lKUHjh8iECYW0mE7NKmrIYHOyQgYwNTD85RK?=
 =?us-ascii?Q?r8dFaudwcQzv5i0ja5zFog7W8cCB4qCza4uZncKbwG+mB54Xe1Xs5jR6lwG8?=
 =?us-ascii?Q?rSC/9kfp/NizD07gwPk8SVq5W1oG6IHDqfk9RsfDLRo9qOGMWvOloSvIK8mQ?=
 =?us-ascii?Q?TQGibTasCuMR7CWcmRYwY800ELvuPK1ukj0ne2AtU/yV8nxaoaG3h7dIN/5d?=
 =?us-ascii?Q?8VyphfBddZ2+L3oj09yyBZfHtSs6Lpmvu4B4gFJanJPCr4e0qwPIU+AMAhB6?=
 =?us-ascii?Q?TgtQ36i/ru3xB1wAz3CeXsQzQwRCiuL8p0XYGAf6aCxQs8GuuLkVLoUkanyu?=
 =?us-ascii?Q?hV9K4tqZt/NMDYnd1/0RZ2dz/zSqu9fKxtVBYus+fMQF7kb/i3kGNKB/5WH4?=
 =?us-ascii?Q?c6sCquEyxnw6JI9ExaeZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2996c4-fcc1-4a43-4485-08dcc944ca17
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 22:40:46.8035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR20MB7473

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
index ec9530972ae2..6a958b822097 100644
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
+		pinctrl: pinctrl@3008000 {
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


