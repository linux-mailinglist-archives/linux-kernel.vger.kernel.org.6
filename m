Return-Path: <linux-kernel+bounces-266951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF223940A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06646B215D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B421922F2;
	Tue, 30 Jul 2024 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hy6emlfj"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2012.outbound.protection.outlook.com [40.92.21.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E31922C4;
	Tue, 30 Jul 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325888; cv=fail; b=sf1j/GbtuGez0sJ5DkfsZv34jiJFmE6kxmMOzfVIOvVRpQJ7wIEdAnyCIPUotlj2xVqi4F9jkwYdTgSjvxIayg+cHpTY5xQGalK17XeBjxezArwsRWtIirdMH4gs26CUI7isqeqvKLXUNGYJpNj4cyiKSe2rngjQ+7VSixG6L/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325888; c=relaxed/simple;
	bh=4N1iAkDpHCFbF8MvS36PvOlEaxLbh9TgSbtPmN9vAYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hA1Z9vXAoGOhf0Ns/5DvsdLrND73VBke3OnmpwSrOhKtbNO/lo2BZQb/cF7iRA9NaiIgLr+MkAJ0yYDYj4wHvX6qugneRsUTBW4k04jvzSPS04lcYnkXj7FRFGTP2UEiiPCJ4V5NdJm9b3w9CNC8+gW9u9zM8qZy5RktYYxFcK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hy6emlfj; arc=fail smtp.client-ip=40.92.21.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBnaYZLILghTFyTEhFl0d+0R+uxeaj/eUKn982QSd5rPB/8pc+ad+1BYocxrVVHdxwVpGxETSM9GBxI59DNdXo6K0eJhxovHwYYrsXZPQ4jsX/GZDy0199h6yGMXweLTfrUQ2ieT4TWcTrgRr8RX2lMwi4VqNERBodrzGWFWmK8vMLakgpvqs70dSVe2YCHF8b86thckhzImSblppDZ4ikMaxf+jDmfw5qTSYL1UlgfNKW8oizS3eal2Lhtqw2MEJCAtxboBw7qd5q3TW15cavM4ncr+1mUtykb0/DYHAVCxXYTEXp/AvBSrDdGd2bCJinb2p/LLmQlbbiOvtIdCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+Tfw1dxS0oeqMmzxgma1iDLTRKCmGYFX8bp+GsGX64=;
 b=Nv31Ac6jXm4RzK8Honef6jxbw4xZrGQOPHndLsE2Eosxrc0coI1XNK2cwJOQG3yhuein8UOcgEv9CA/D226cbtXTuLYoES0V5MDRrC2fNh3sHMr0m4UIlYbexHC8HI5/cm8/i55p1O2BYPSSUPM9xPCBa6dzGPMwtzYt6nvBQiKiqge3bDZ8x9iF/w6vppmgVazd9Y+Wu/rIrYqtnGA2R8ctpowKZLwpR82rLZ5dPOGyWtBSamf8eEJ48rE1L37FQQuRge1FatPmo97yR/eVQZTjAW93mal/XkpNOJRjaCrcXZ35OB3pjGPmr4vibgvl0kp5ObEdYeL6Yr/eT//q9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Tfw1dxS0oeqMmzxgma1iDLTRKCmGYFX8bp+GsGX64=;
 b=hy6emlfjERYHsIG9EpjsSqlBjfLhBArJfAbxpo9J212DJQlJCfqjq9cQ+Atn2Um27ygctkRoJTE3c6mPWeEXH/kGq0Bx04VKf5PpMZxqkou5mzsIKFESmXJX8WAx0YGJtZZtWRhhRUbbIg+3rVxNEr4LjljPdYRA2+Z1DrMrFLKz/32VysYXxJkbNheOD+0Bhn16i3CQapkrKzu7cKAl/PvSEwJK90bu5lBvDHwGMuwp+Yp+a8LFSendxoYlU6hyauGdnuU+mK9kXyesEsBGRVicLJdqt6gUV1nMr5SLsMrWe4imM07p+AF7t61qWvg0DrGv0Bb+5MlbHpdOZuge1w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7552.namprd20.prod.outlook.com (2603:10b6:208:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Tue, 30 Jul
 2024 07:51:23 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 07:51:23 +0000
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
	Hal Feng <hal.feng@starfivetech.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 3/4] riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
Date: Tue, 30 Jul 2024 15:50:39 +0800
Message-ID:
 <IA1PR20MB4953826DECDCC141A7CDE634BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [LKmAa7ANCEJWvC84jqUzMW371ZBNlHeE6MJdR4GF50s=]
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240730075041.489815-3-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb6e5fd-c61e-4d53-2832-08dcb06c6887
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	mt3kvQOennPGqdOQOEMGUP3UH61TuPcg+ka6I/fADcLYZ2LjELLCz+wngt3uRLCFBDOYt7zH5519ZsEDA/XXN09lcm/rw8L8PvTmnhHkQwxC6MNCQpenrWRWVp/c5iz27Saxig6OzMSSRnguh6JkK/xn7EReILi8SFsP1d0JwsrNPySPY6Fp5VxbACLRCkx5eGsHg3/IBRuK4K53bik2NB704Eq5Yw76e2T1HroBFwvi4e6+tPLDX00NXnMxa1C+a1+E3EtNQCqVO+6sqtFzlg0wsMqOydCALMArdQyh+aTApGFCwPfbG5gUxlmXMjRv86Wyt7/YrHyqRPn+5ZakbFt9BkA9CwBxOPBTexCdLhPZGgpHNyeJIzsJIcMPGEa9PYjcHApJwKnfQ0LqemAX6lpNYV0zB8jEPA6Ev+JiGir+QPWSaHBn3Pc4HcS4+uM9PFNbo0islO2e99ntpg/iaSWOI5bP5f67n28UYVTkEkNTsfqFue+CvBEhvFx94xaLVm8BYGxxvUEYgSiqgmhhHbrZBbga+PX3CffqIMmiD2+cOU3fjGcRLHl766vZtKtg/U1FrA6MJx5e8zird98aRm5nl4wtI6qnD+5lrqoBeCOt6NdQoI1k+8V9ZoVoxZxH0z6oeNJIpMGcfGw4Sm0MC5s69Dt9MPXQEVZp9AYqctGtRpaGfbqSPH51Yw+D3tPw/2LdaAr2iSJlzNiulh29sg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yPPegSqUdX9wFRH3x/Zu/oTc+fq5m4u0CtyE2aGL6GYwBZBNo0U0tMJsg2Br?=
 =?us-ascii?Q?wDT5ddyzVHcMf2JSwHZtiK0hw3NMVrZnCaXf0QGbL0AKKNz92XYWXzsJOa/I?=
 =?us-ascii?Q?T07FJ1ZHJsgI+eNfQvx7QEIHdSHFBJPIg8VE/WiWss+ogpG5z9LUvuekujVA?=
 =?us-ascii?Q?NuvVgen3bWSg+2JOrp/0nWVVlEDPP4vFuLYUnQSkCeGYXAhj/EjgLTMLFr7K?=
 =?us-ascii?Q?hPfzjV/aS7CY139yABGOVe4L7xOEzKvh2YMvIZIb8/NglJ9tEgjG2kHkL97y?=
 =?us-ascii?Q?x4lSB7L9tm9NxAnPTeVItOya9V1UwwIvUCP40Y1B3GCyUm/GR/22cN3rsqPz?=
 =?us-ascii?Q?SKR/3j4jCMqvz06wPLUACmPRZ1t+TTOuzki8R59gBFXEhaeVqc/MlWXO5p4g?=
 =?us-ascii?Q?sSdlt3jCjYLhcY6KLnRIFEyKQ9PhyBXYG1AOU5f/AbhajNfrguummtaWMP8a?=
 =?us-ascii?Q?nO6zUnF8Ubmpbocc1hjCx0me5SsVJNr9T6ydd1Wqya4Skkr9onOEHSKOGh/y?=
 =?us-ascii?Q?UfR0nZGUVSMzI9AWLsP9lrfhaEMcOKNQqShXHeNl9K8vg1lOkwT7TZmKWHzk?=
 =?us-ascii?Q?wdeXNk2XOudr6yhT5m8Ig1c8Sjo/OMfQxbHrgT8sVoEGwBmOKrjTkOl5XMYw?=
 =?us-ascii?Q?m4ytb/4RetsJXWeHLD/IDWePhnua5wO2DipYKAs4vL/QXuKc/T/kfX4A91e0?=
 =?us-ascii?Q?UHrtVTGl85z26j0SePsg8989Tw0MKWCQ679yiaF1BAoVtP4wntsg4NBsNnO+?=
 =?us-ascii?Q?RdfwAg+2OLBM1DoG2TLZlunUjmuN3lzxKUopGK8sKmUaJKUzPaFda3nB26ZX?=
 =?us-ascii?Q?yKWN5TimTh1JZf2mLLRLeSB9s036mCRKQFB55ikLZhEOf/cbyBUtaJLS9D2d?=
 =?us-ascii?Q?aZXwtkF/pPQ3HwbeAaJoKDgr/XVof/IBIYA/2YbC21zioKsPa6wOQd3GiS6t?=
 =?us-ascii?Q?YIN4SI80tjC939Ynd5SASSkj9lNRWQHXxkOoxCT9Xgeyav5Z1qyuRsG/HMAr?=
 =?us-ascii?Q?CQ99eLIvT6+Cw3XycRjXqBR0Itbgx9lwnwDE4LE+yLWdCPgM6jj0twYYPGVE?=
 =?us-ascii?Q?n1ELPATPCGoOKHMbWPnVcx1qHGjqrBoQxHX1P14jnXUkOIqeBR2vmUVce+jG?=
 =?us-ascii?Q?CzMXnfKVljgHHSQ/gmCIIZAUfngq/pjMX1A9aRLXt64ib9B2igXmFTl/zO99?=
 =?us-ascii?Q?SbapuLuwh+aI+P9FPbt8v/7E8lxRQTlO96XW+zM5mTjaEpe8rg+zXHMKI27t?=
 =?us-ascii?Q?xgrp2qVHLRTqWmizdi/v?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb6e5fd-c61e-4d53-2832-08dcb06c6887
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:51:23.7973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7552

Add mcu device and thermal zones node for Milk-V Pioneer.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index 80cb017974d8..8b8fdf6243d4 100644
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
+					temperature = <85000>;
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
2.45.2


