Return-Path: <linux-kernel+bounces-290512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963529554DF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE4B283871
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 02:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087050271;
	Sat, 17 Aug 2024 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EY0W3MHw"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2095.outbound.protection.outlook.com [40.92.22.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8443152;
	Sat, 17 Aug 2024 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861438; cv=fail; b=Fav2HfXBUc66MBlhz0pprqVDkNCZCckGfgdURuJ+C/JW27Ye2ReEZ5ihHB/aumf5Q5yz5suT0RTyBUbVH45K3DnHFgXHWaafIDuvsXuH7fgqTxGiL4dlX7YT0o+5fKAbWMGTV8fOp1eruJ/m1rd+Fuv5mZkl45ANgNvxOtxgdes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861438; c=relaxed/simple;
	bh=geJq3s5fiHbTiRFcKHoVOXp0idsDu6lWvk8T6ej/v5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meTu9MeoVRVFM+9FNs2CeM5SddwNbYLIo7pKgSd5w/jT2oPEv6kqEwi248sxFPfF0XMDlrTLVMQg7ewpfbyHkU1Hrmts2Zs/9k9vHF2+GeS8QpR5hDr6aEDqMTlsHSwRm/gU6dN3p7vylWtGLSk9MFVECzlL0HhjvJPzBOVdtzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EY0W3MHw; arc=fail smtp.client-ip=40.92.22.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx0iJVZISCdh8R2jO9rOTzk/JANNZeZe52u+srKIPL7Nop3IGvh5fuMDFKDEnYpeEqF2xT386emv+/qoHROnB+8alf4mqhk7LT3WJJRfVujMkwM49hmi5VhfxzYYXc4cObUeebFQ8j/hJsTqy+vugFZUdDqC3eLIqJW8kti6Nvs4hhsHw0pTAkvSa8Z6W/yC4H7+meW8lz+YHw5ZbONtN/H7lUnDj0kx2OmgAVfaz2e8hVAKpSX7dxr1iMeU3TLzgPN2IQmIwL3G286zk1S0SkKCaogYFYoA93akFGGJP5P8BJj009sgIsdnpoCKXtyULemyQ6W2l0XTKcG1Xfl55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHEUQngGJDx0vOokAPvghmYJe9j03nCnYapbJwhGE3s=;
 b=gg76BOOYeSTttXSWWvKRdmeMKPpvdsRAY/tjid18ranXoC4WCXWUJR2fA4pNjGU4yfK1hBcJAnW731VCXqlcTm5aJ/mlSoyukskOBe/prk9hotDTHBVQvYMfaI/a3UMv1cnO2oxVXDMDRRBTUm5FiAt0oqrMAc0uwuPhsdu2kmIf6Sa3A6eKgxXV4GR58j9vlfwpmqL3Oa4D1y/qCGk2rGIzzZ/w7+D2w/h0ZMouGoHUrR8UeNYSBlRX9KHX+g6RLnJA6Qth0KDJ78OoQ+wqNFxgvPyEW1qHiykK7uwGLhzdhg/+VRiwaYM3dWlkbLG7DM/4oIQ2DpTZvD2w2as2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHEUQngGJDx0vOokAPvghmYJe9j03nCnYapbJwhGE3s=;
 b=EY0W3MHwI5fsWnYHKNJ9NzTyeSZzmZPK1G1kvCizdb1oUl0ZQ/DSlTGCr2kxcgNCCa6j1D11xgMysdAMeVjvUmeJ7pyP6nypl4xxCSxnJyiHj9wk5BYef/92ax7A4NREoKVOzmdixF6SXZGjOi8/FaR3B2lFwk4krmvM2cRXkOGGr2lr4GbYsKBWUhCyQztFX3223ElxlWBMo9uJo9o9KGvSKOcZcPU9MNygc0IxpN9ImPboDH9yT96gDqYivNkDaawlW5dryTn5+XJnFA5p2jSgpu3NWnOVafTzmKZY/I9U02LRVleCZOZWKBux5iefnALc1GkdSSX+0GKeX3v4og==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5337.namprd20.prod.outlook.com (2603:10b6:510:1bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Sat, 17 Aug
 2024 02:23:53 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7875.019; Sat, 17 Aug 2024
 02:23:53 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Hal Feng <hal.feng@starfivetech.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 3/4] riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
Date: Sat, 17 Aug 2024 10:22:58 +0800
Message-ID:
 <IA1PR20MB4953C675C28B35723E87A36BBB822@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953DF0AE7210A6D74162952BB822@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7UTbJOnCX9xbqYuGyIDWpnboqLlFs9AIh6hoXEFos2k=]
X-ClientProxiedBy: TYAPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240817022300.360949-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e7041f-3041-4004-5cd2-08dcbe63a377
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|15080799003|8060799006|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	ft0hdUAXVmOqK6TW/ewNuthT8Srr6+YBe043s6zWwFiCT/J5vUW8ED1iI9CNtT5NotstU1UHN+pBbzuyIdH70/mvyV1DFoQFNAdAfxuVvdNGSACZRU54dXMqr8wYxRU50ZrDys5yjxjDriJDQz/izgHVoatNgUkza1oqwIs0KC5oiGdxEY+AwKnJJf5dg7zuvD3NSPq2HIds+k7qDAHjPI1PKAN8NsLZWS3igOuodXltJqBXlR3qHiSZrDbww4hripPN8AxPZ/A0ah7TOLaQZ6dTf7yS7aNgNK1Os7rJf/pecn3Byp0rka1Uz64RVYo9DI/7qBIYdwtLoP5/UXi7U1pQjQNh8x4zBIA6it892/u6kCyQKoVLHo8j60Nzhj2V9WuDPHoZNgkalt2AwLo02Y9BMHneO+4Vq0fvlooTMvAMYREbmABV9EPsbY6cz1uApRYRKYbRIz6K16psGtrAbh9Dc/gjD8AsY2lmw7RrdsZE21W2ELcY8Pl7QmYZz2MT3D8lI+4+5utZ3qvJgm4czbFxdNAVcQxaOkin4MM0joHyltUv09d4+3I1OYE8f4gP4AseBTktV4hPYMn1100gcomgtrIYSFzp2m1KdY+cixhNcNclTGXxevhcPErOmJqDOxNHXqyp70qkg4OyppwAZY6Zsvv5MXMjR/ZEhCtZBk4Ee5r6y80pe6s/HqbGvGl9DxxNVaDURJpk9/wagC8jHfmSMkiw7MzgelSnPZwMojM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oMMwvkGy6IJoK9isW85rQbywTxvIHqgsqWXgC0jOvjN1mX3Tm1O2BlkPPBH3?=
 =?us-ascii?Q?JhWIqV74J6MnbKECASe4qaegNXEhlAuziTzeMHFU0pWe3yJqgHtIGzjdtZz/?=
 =?us-ascii?Q?7HdsjWvOLZfDu1VNmJog/2cgAzwrFsKU1ALBFBsPRxg3Ai1JiE1ZESyWyRF4?=
 =?us-ascii?Q?x4mJ06x6OLMNwH/Ua0RTrtlDTn5btuc00UAVes5PgvdknLf5PCUGhkQZSZCu?=
 =?us-ascii?Q?8jW2e7btirhhiE6Rs2s9te9JNesvRmVXeR1hztBAqlwYQajw62SxHQYfC6rA?=
 =?us-ascii?Q?Utbin66qgm/EiSVDM2W7wAIkBmkBk08e6wmvrn4I9I7oUcdgHWdVPg3mEiNh?=
 =?us-ascii?Q?sfv1fkxRdRLNFw+rF6h6x1JMVW5jPzsNy7JA41Ea6byb89EbCLz7S1rpyACZ?=
 =?us-ascii?Q?/iTiJiOHcNPcMGWcQycylXXi8uvoaVGVYngnYdIdF/VqHiSF/lZ/g6MmSmPj?=
 =?us-ascii?Q?tFZWBVzp2LNU5hqOtUZzFFFTA6Bdz0Rji2EdfpJoC9+QpGRiP+kvlWMyUKyV?=
 =?us-ascii?Q?5TPiEHXsTXHy/Z0CN8b4vWQc8QWUMJQI1TtaQZq35p4Vf65sPNLPkG+TMwj2?=
 =?us-ascii?Q?htVkiYogvKeb1hIuCnckRX83A0XxI4M0fXvoQf8S3Ela35DtdP/JPkoIzij7?=
 =?us-ascii?Q?EQMjNX4hudDuSGgHmy7QJUXUEt1S9kqDJ99wmtVTkzLEtHKen2j93tLiP96B?=
 =?us-ascii?Q?RblQx4w32yEJ1+VJlepAibWDts6Mf3xI4waNtrDi2UJbTcAIYs2zMr61YLbj?=
 =?us-ascii?Q?gD/BBQ3nqE523h2Usd+7fGqIDQDXw2IRlDMK2UTNpoaaSufNH/xtNJjtq1/e?=
 =?us-ascii?Q?cQvPStT+YtOBvewiddDz/0twUEm9lvAMvAuiPHUbSiJv7yRuO6d+iggBfaa8?=
 =?us-ascii?Q?D61VtmLpoNRCI/LOTcHzl0Xgp/IORcJWur4JR4edP5hL9RWgqlOc2modYOLI?=
 =?us-ascii?Q?PVceX+rxJ5O3go1FU1aicEyLhggrYFDWOdWB0KKGukdSCAwtwgpskBAwWvOO?=
 =?us-ascii?Q?fZiYhO1ThbVEZtlJ7yLRQr5p4uCCpS2BJPmgi/iciLBGiYGUkIoUNIVAvM5Y?=
 =?us-ascii?Q?QvJ/fLhiyWEEukT5HqJUzdR2s21LC0Ef2Q94IJndTqv+30bmhAw8etWRV1fV?=
 =?us-ascii?Q?lnf0ZHuPaiSDTyKY+y5W5C3/zlnHwK7ecrgyZ066h3WFEB1rYuOxgNZ8RLIP?=
 =?us-ascii?Q?yZrE6RQXDMwB1JEot0THbEMltG1LV3rp5LdlrVaurGfXpvlUvzajfvewYxr+?=
 =?us-ascii?Q?hzy8Tjg4+KCp0Igj1bHc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e7041f-3041-4004-5cd2-08dcbe63a377
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 02:23:53.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5337

Add mcu device and thermal zones node for Milk-V Pioneer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 80cb017974d8..76375e25a495 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -26,6 +26,66 @@ &cgi_dpll1 {
 	clock-frequency = <25000000>;
 };
 
+&i2c1 {
+	status = "okay";
+
+	mcu: syscon@17 {
+		compatible = "sophgo,sg2042-hwmon-mcu";
+		reg = <0x17>;
+		#thermal-sensor-cells = <1>;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
+
+/ {
+	thermal-zones {
+		soc-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&mcu 0>;
+
+			trips {
+				soc_active1: soc-active1 {
+					temperature = <30000>;
+					hysteresis = <8000>;
+					type = "active";
+				};
+
+				soc_active2: soc-active2 {
+					temperature = <58000>;
+					hysteresis = <12000>;
+					type = "active";
+				};
+
+				soc_active3: soc-active3 {
+					temperature = <70000>;
+					hysteresis = <10000>;
+					type = "active";
+				};
+
+				soc_hot: soc-hot {
+					temperature = <80000>;
+					hysteresis = <5000>;
+					type = "hot";
+				};
+			};
+		};
+
+		board-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&mcu 1>;
+
+			trips {
+				board_active: board-active {
+					temperature = <75000>;
+					hysteresis = <8000>;
+					type = "active";
+				};
+			};
+		};
+	};
+};
-- 
2.46.0


