Return-Path: <linux-kernel+bounces-231109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384B6918649
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D261C219F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C318F2C0;
	Wed, 26 Jun 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="CYtoWvE0"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2095.outbound.protection.outlook.com [40.107.244.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57118E77C;
	Wed, 26 Jun 2024 15:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417206; cv=fail; b=OyFHUAZYhdmVErGiIgdKB461M/4WA/5pxo1I7I88J96zYB07+SHJ8OhiTsoX/BwWgFn8fRzTC7pQeOVtJXEnMGSVw/WyYotaAb0349xSzhrguxNN1AlSRMRG2w93uMRl3gsyG0bDKBR0DBh/O4UG5xDsqQcF0GLgfhLWpdAxr+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417206; c=relaxed/simple;
	bh=OImTvQatsPLMjRdtjaq6JPE5UTYtXsiDzq/lLJdtgwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jGF0PEFtMv/qImvNznk7y70HfytMMJ9+MyycbdFpwZdxkSYbITdPigplfT4uA1VgxijsEZTEZAU6MlcGQ04dVERtbuIY8wk9Plj/hHKCU8zLbIZOKO02kLZFetwvtFIKvtAIxyrUmbbXBISfE/MEiZyZJEyskQws8LaBITyBphE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=CYtoWvE0; arc=fail smtp.client-ip=40.107.244.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHiem8WZ1odq62Cex13+870QucR32VuX5ZKoPLYT84dAXrG/jMy8+vneuVpaivVDUK/PbpHNtWNafOr+IIDK8FDj4J4eywRNgICf4tkrgWne7qMMNwai18vaLws2QcO9CMjyGNIXGKhAvlbguYpGyASA33Tjf3MkAv5Tksgd/5Xv4F9D8sblaxRY9OJlq9kmofI84LtIDG+cMO2G2pfnkddjkHy0k1SFpOXic/PPlN5IlW5hLwY7nWicoInZpEYCxQ4Chq02zhwttTmqwRhbaerpPzMokr9UjxYtuGubGUPH0Gkvswvrx1go6nyS+Cr4pBpxNp23ZwAkw69RfukEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeRMweAwVv68NYPh01dopHsPbUzhEI3qliwxY73QuHE=;
 b=oS+yP70q9IyU/Nv7KqtLUBO99MiPe60k/Ou/vcgDkJSVjdXx8G2QHAQ/Wntgz7TrQGNoeRjp5uEE0a7yX1B3a9WRF7T8XMBbbFP1qBvCfzB38pDmZ4k7HiCsNmHPxPwt5Xr5UaFtwqv0hDNAOZmGClZ+LP7c3a6gZwhAMZ7MQPYmAWc2R3/mC89VpNGeleX9l/HnnfTtPXd5kLazQIj+hBOeInpEfxlwDg/XFKrR9CxOHerRylrde6DPsGD9DVP08W4N0mdVwdxLN5rh837Wpi9zW3u/osRj7BJGwmRdrHmfNkf5aAhuM9GnhQWSk45GbgVRmvsL5qLTwlr2QRrGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeRMweAwVv68NYPh01dopHsPbUzhEI3qliwxY73QuHE=;
 b=CYtoWvE0FfC4NUBWerrswirMvpCz8KNgkwpq+JM9vvbFDOtVL0ETRRcPl4CaRoxulP9w5rQS4tAOjPMJXqDwlEp3qzMLGbRi0TeIonwvm5f4zRLZIKGl51lMWQblsZmzHbciDE1yKtDxz4g8ejteYt5DIp73BOGHtbnoyKwgJaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by MN0PR22MB5515.namprd22.prod.outlook.com (2603:10b6:208:4c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 15:53:19 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:53:18 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 4/4] arm64: dts: ti: Add basic support for phyBOARD-Lyra-AM62Ax
Date: Wed, 26 Jun 2024 08:52:44 -0700
Message-Id: <20240626155244.3311436-4-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240626155244.3311436-1-ggiordano@phytec.com>
References: <20240626155244.3311436-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:33::35) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|MN0PR22MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: ece4a28d-b918-41a4-76c3-08dc95f8190c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|1800799022|376012|7416012|52116012|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PTtV+a/nQ13mk2eAeddYP7qYyH5tfp+9xTk8rVyXbl2NjuJ8BpMoRyJDvpBw?=
 =?us-ascii?Q?gnEJ8R25Y0oylJMCk4aEf0Xz40+kK05ocS8OK2FWAvgUDk9/4VeFYoFK/m0R?=
 =?us-ascii?Q?fFhZc6swG9RzpYFY9LGaFvk4Vb+krYzjkizIc1jSUFheOVkXX4sjdaRW+FNj?=
 =?us-ascii?Q?7p3lYIf7AN/PQAI4l/F/WKfOJ2AVg/qCUA/+YUIh+MG5BpNZVcDaBJtG6ebT?=
 =?us-ascii?Q?WSCDqOZfA4pNfhPfPCKsfi9f90sBAXg3rH14PH3+HSAZ/+BL0Hy0htFc/d07?=
 =?us-ascii?Q?BnJDF8dBXUevnlP2DajriKWfGyd55oMNKbMxaYarjxdzaDOGz8MaWJ118sjX?=
 =?us-ascii?Q?3SXWuhnidV7DqzM3fDmo4ApazSYDORAF6wF+8XWN6XfPFnrob+gcSO82tnrf?=
 =?us-ascii?Q?sdw33tlL1r8O+fBZfbiUGY7ImaXSM4VDzjYtmYBuhwI80kxydM5NNgMEo7Da?=
 =?us-ascii?Q?+dJ3q75KLRz1Etikql0TSaFBhrsrLm429228OSG/ws18KXdQgrjHbKtYZZPn?=
 =?us-ascii?Q?WjZdZHSpn39L01HfKDW3XL7pENEOz2MjptmOlxdcNM5PEm8F95jtkcFZ4mSm?=
 =?us-ascii?Q?LYwKi6ME+Pw6/irVTc7ds5ayI7tFUa71EL9LYjWzUfVN7ROSoXn2jYr7AQQ+?=
 =?us-ascii?Q?y0uoxC2euzlilS5NO0TtEkUQOfl1MD8RI2XXTiHSbiNDrBR2s5M7q6/8h824?=
 =?us-ascii?Q?SzY57wo779BkPjK1ZQUbdTUrP4KFogz/enbXVvsfQAWnu0OJ6pd2eGunW6Ow?=
 =?us-ascii?Q?A5IScZCBiKsjxDd9VCYw1Xx+ny6M5hFpuD+QaVdysv5XqKYxFleX10ZsLrIt?=
 =?us-ascii?Q?K3G9JasZau3yeZX6u7TAaZfWsd8ftfX2+i/bSZpzvlvYQNV7HWNiFETs7zHC?=
 =?us-ascii?Q?5H6ylqiFw4R8lZtO+F0elaIlVJP+iL5MRFDlKYEWq7USqphRu9fnK9bJwQl2?=
 =?us-ascii?Q?dkI1ngXLf6vJZTXBYM8qeGXC8lSV4FdCPPy+UhLRjCBaNqf7IVsMdQDeqq9S?=
 =?us-ascii?Q?7CEfj+MDq5/3BNBpkMOEPyUmUehLmiTegxewcHaHUYmbMgYz/N5G+FGwEAND?=
 =?us-ascii?Q?WDh2JX4szqB/pzrS0Lba18qV72V8eh3+BEfsMjA67j6QlQkc8DF8qBgeNXX0?=
 =?us-ascii?Q?q7FCcNb0TmNVuPejjC0GeGx0xPMnHd2wE7gmh1kBFE7QTv1+uPZG8khyqGzB?=
 =?us-ascii?Q?Ifw+BH8vEIColBs90+nW3rdADIIqEBkR9m59UaJJ/VOKPpQfJhzE82BZImWn?=
 =?us-ascii?Q?jgcBGGsIkjYVwAWEk+sTPtZL5TfpMisZ7KTKO6/2P6G63zqKKbDVg6XPwrUJ?=
 =?us-ascii?Q?KKO6JmqxD95Fer5OTBCU4SCpzzmaviHhktqr19K9usw6RgwNs1Tu67xas865?=
 =?us-ascii?Q?zcfH+Ik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(376012)(7416012)(52116012)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NTXnGqxlE29McQgKNClxS74fwdQwNnA2AkinTCkdudnD7u/GLrC85wWwGVNv?=
 =?us-ascii?Q?i58ksSODxwXUd9eki5oL1RR8VPUcRLbyN+Ct5cQIV+uDbBSVYfT/fEW3Uexf?=
 =?us-ascii?Q?pgJvMnimnAnLwG47lHrRpDWCVcXBLsN0ci9eGrsZ9lcFVLf3Pxk1z9BLsJVq?=
 =?us-ascii?Q?afCCZnilEz1Qa0Y1NOIaiLv+V0WC4jHNZg2vpQGTihXERKpcQbCBXOxWP2il?=
 =?us-ascii?Q?L2ljyttufr/Lj5n0owHGVdRdwD8RZ/bsWX/b1McDe3M5O++ZTO8oDkatEdWW?=
 =?us-ascii?Q?p4hrVkORszu/QPjznceMzRd8U3SOfm5khP0HFLHaGS1eRLaAKa3QrTZcZOaf?=
 =?us-ascii?Q?Q+AIBaQJvGdEStrnfZlIXB40S3n+jaFc7YOx+OjvTWahO8o+L7hzZVW/dS5F?=
 =?us-ascii?Q?rSMVNA3QZoNorEOc/L54D0PnWB4gUGv6amjHzTv6L7PogNl1Fv9bQ2HAmC3n?=
 =?us-ascii?Q?GgglzvpKzQJXpOyRAc5I53sCFHp1IUeF5eu44K8cIfloUo7/51ZbYQIx1q/i?=
 =?us-ascii?Q?TGxPd0dlom4sRZw/24usRymCRhWqEH7xbw92ri5KhsiKXcJ0Kehs7Knu0MpA?=
 =?us-ascii?Q?xnCoDoMB8gyu9ORocj9Hp3BQ2Ujjp8tFXXMzj3NAnD4IcUDlODRDN6F7AGtc?=
 =?us-ascii?Q?xzVi+BuJV8HIE+VCUM45ola/RBfdEU/Uwmjjbnw4E8yaJCY6q9fNomK53acA?=
 =?us-ascii?Q?u4Usg3l5L6JTVSxef6ltMKb3Yejqm/NHjDO49UpHC/5uyipzlae68nygZy7S?=
 =?us-ascii?Q?nMIL0F4s6JjrFgp9dMj6+tH2i9o+7rvAQUqYbSDmyxcC47Cm4hV8BacSBf9g?=
 =?us-ascii?Q?HRlMnWhJ1YEKwrkNDEqWoMubRxoU/aUVi6UoNuzkAOhE9aOpgFfzgeiLkfsB?=
 =?us-ascii?Q?hD9lZyaJEeok4gm+9gOTxIfiumIMmabdu4Ttc+6Dw1Rlqb2iis6FcD0F7aci?=
 =?us-ascii?Q?Zx9xmhdZXZo+eBnbzsBfruJIUr95uS3eQb2Ve2nzkho0p6yKR6ReQap80YJD?=
 =?us-ascii?Q?Icpe1VKYK+Ty1B+5O1yCl5/H0/WWpNTf6bSRaLqzA/BX0aGhR31hFYTfUZtS?=
 =?us-ascii?Q?eXTsRjhmshWa2EojzhFgR7XHNsrctHlpXSeGSgGXFDX8VmF1vKtWOCShLwNM?=
 =?us-ascii?Q?Ekw1UhKy5zJ0WOgXOHAxzQaeroQng671/mK05OAr+SDgS7iQ8hW2VjjnP2GD?=
 =?us-ascii?Q?wzi/zbKfd3W45EkvweltdttPze1duE4sQ890imkbYV5gl5lCT3P9g4J+OtBV?=
 =?us-ascii?Q?6fBZnxzriEN7CQ8bwRTn2ZpH8FIK64yB/NlwKtqINCa4I17Jxw1+oYi1cSGL?=
 =?us-ascii?Q?Pl6Lfsjus1oT54uaNAsJFNzPfihxzfdvj2un8G4L6vG9Yu7xmVvmJf4lZcNj?=
 =?us-ascii?Q?NUVpNUt7p4ALPKe6L4vuE0F86SMKy/dcCkDwEJr3cn0ogdk1KvUZZlY78JJI?=
 =?us-ascii?Q?6QnRSe7S2CXYbRPyG71tAiDPr60HRpJbvTJX+on0wjcP2a4BS5dgs1A3rwtA?=
 =?us-ascii?Q?Gqo72y892d4JS9njiA6cpjcXXSevTC6YQnJ9L5Zv27o+tFfnuQhji+cQtFTw?=
 =?us-ascii?Q?mT7R99MLPewPTD47NdA8FAyFeQE/3I3DT1jp6WeS?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece4a28d-b918-41a4-76c3-08dc95f8190c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:53:18.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blGLZMmatpbLcZr9KUSn6Xs0XivIuoOgmp6+u5B3hx6tX/SYhf9RoXHYbAcDJgEiHCxgPqMv1Hyu7dKwbiO/Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB5515

The phyCORE-AM62Ax [1] is a SoM (System on Module) featuring TI's AM62Ax SoC.
It can be used in combination with different carrier boards.
This module can come with different sizes and models for
DDR, eMMC, SPI NOR Flash and various SoCs from the AM62Ax family.

A development Kit, called phyBOARD-Lyra [2] is used as a carrier board
reference design with a mapper board being used to allow the phyCORE-AM62Ax
to fit the phyBOARD-Lyra.

Supported features:
  * Debug UART
  * SPI NOR Flash
  * eMMC
  * 2x Ethernet
  * Micro SD card
  * I2C EEPROM
  * I2C RTC
  * GPIO Expander
  * LEDs
  * USB
  * HDMI
  * USB-C
  * Audio

For more details, see:

[1] Product page SoM: https://www.phytec.com/product/phycore-am62a
[2] Product page CB: https://www.phytec.com/product/phyboard-am62a

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../boot/dts/ti/k3-am62a-phycore-som.dtsi     | 330 ++++++++++++++++++
 .../dts/ti/k3-am62a7-phyboard-lyra-rdk.dts    |  18 +
 3 files changed, 350 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 2c327cc320cf..cd6e14edbbea 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am62-lp-sk.dtb
 
 # Boards with AM62Ax SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am62a7-phyboard-lyra-rdk.dtb
 
 # Boards with AM62Px SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am62p5-sk.dtb
@@ -173,6 +174,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 # Enable support for device-tree overlays
 DTC_FLAGS_k3-am625-beagleplay += -@
 DTC_FLAGS_k3-am625-phyboard-lyra-rdk += -@
+DTC_FLAGS_k3-am62a7-phyboard-lyra-rdk += -@
 DTC_FLAGS_k3-am625-sk += -@
 DTC_FLAGS_k3-am62-lp-sk += -@
 DTC_FLAGS_k3-am62a7-sk += -@
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
new file mode 100644
index 000000000000..a5aceaa39670
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 - 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Product homepage:
+ * https://www.phytec.com/product/phycore-am62a
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	model = "PHYTEC phyCORE-AM62Ax";
+	compatible = "phytec,am62a-phycore-som", "ti,am62a7";
+
+	aliases {
+		ethernet0 = &cpsw_port1;
+		gpio0 = &main_gpio0;
+		gpio1 = &main_gpio1;
+		i2c0 = &main_i2c0;
+		mmc0 = &sdhci0;
+		rtc0 = &i2c_som_rtc;
+		spi0 = &ospi0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&leds_pins_default>;
+
+		led-0 {
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&main_gpio0 13 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* global cma region */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x00 0x24000000>;
+			alloc-ranges = <0x00 0xc0000000 0x00 0x24000000>;
+			linux,cma-default;
+		};
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			alignment = <0x1000>;
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0x01e00000>;
+			no-map;
+		};
+	};
+
+	vcc_5v0_som: regulator-vcc-5v0-som {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_5V0_SOM";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&main_pmx0 {
+	leds_pins_default: leds-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x034, PIN_OUTPUT, 7) /* (K20) OSPI0_CSN2.GPIO0_13 */
+		>;
+	};
+
+	main_i2c0_pins_default: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1e0, PIN_INPUT_PULLUP, 0) /* (D17) I2C0_SCL */
+			AM62AX_IOPAD(0x1e4, PIN_INPUT_PULLUP, 0) /* (E16) I2C0_SDA */
+		>;
+	};
+
+	main_mdio1_pins_default: main-mdio1-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x160, PIN_OUTPUT, 0) /* (V12) MDIO0_MDC */
+			AM62AX_IOPAD(0x15c, PIN_INPUT, 0) /* (V13) MDIO0_MDIO */
+		>;
+	};
+
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x220, PIN_INPUT_PULLUP, 0) /* (Y6) MMC0_CMD */
+			AM62AX_IOPAD(0x218, PIN_INPUT_PULLDOWN, 0) /* (AB7) MMC0_CLK */
+			AM62AX_IOPAD(0x214, PIN_INPUT_PULLUP, 0) /* (AA6) MMC0_DAT0 */
+			AM62AX_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AB6) MMC0_DAT1 */
+			AM62AX_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (Y7) MMC0_DAT2 */
+			AM62AX_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (AA7) MMC0_DAT3 */
+			AM62AX_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (Y8) MMC0_DAT4 */
+			AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (W7) MMC0_DAT5 */
+			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (W9) MMC0_DAT6 */
+			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AB8) MMC0_DAT7 */
+		>;
+	};
+
+	main_rgmii1_pins_default: main-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x14c, PIN_INPUT, 0) /* (AB16) RGMII1_RD0 */
+			AM62AX_IOPAD(0x150, PIN_INPUT, 0) /* (V15) RGMII1_RD1 */
+			AM62AX_IOPAD(0x154, PIN_INPUT, 0) /* (W15) RGMII1_RD2 */
+			AM62AX_IOPAD(0x158, PIN_INPUT, 0) /* (V14) RGMII1_RD3 */
+			AM62AX_IOPAD(0x148, PIN_INPUT, 0) /* (AA16) RGMII1_RXC */
+			AM62AX_IOPAD(0x144, PIN_INPUT, 0) /* (AA15) RGMII1_RX_CTL */
+			AM62AX_IOPAD(0x134, PIN_OUTPUT, 0) /* (Y17) RGMII1_TD0 */
+			AM62AX_IOPAD(0x138, PIN_OUTPUT, 0) /* (V16) RGMII1_TD1 */
+			AM62AX_IOPAD(0x13c, PIN_OUTPUT, 0) /* (Y16) RGMII1_TD2 */
+			AM62AX_IOPAD(0x140, PIN_OUTPUT, 0) /* (AA17) RGMII1_TD3 */
+			AM62AX_IOPAD(0x130, PIN_OUTPUT, 0) /* (AB17) RGMII1_TXC */
+			AM62AX_IOPAD(0x12c, PIN_OUTPUT, 0) /* (W16) RGMII1_TX_CTL */
+		>;
+	};
+
+	ospi0_pins_default: ospi0-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x000, PIN_OUTPUT, 0) /* (L22) OSPI0_CLK */
+			AM62AX_IOPAD(0x02c, PIN_OUTPUT, 0) /* (H21) OSPI0_CSn0 */
+			AM62AX_IOPAD(0x038, PIN_OUTPUT, 0) /* (G20) OSPI0_CSn3 */
+			AM62AX_IOPAD(0x00c, PIN_INPUT, 0) /* (J21) OSPI0_D0 */
+			AM62AX_IOPAD(0x010, PIN_INPUT, 0) /* (J18) OSPI0_D1 */
+			AM62AX_IOPAD(0x014, PIN_INPUT, 0) /* (J19) OSPI0_D2 */
+			AM62AX_IOPAD(0x018, PIN_INPUT, 0) /* (H18) OSPI0_D3 */
+			AM62AX_IOPAD(0x01c, PIN_INPUT, 0) /* (K21) OSPI0_D4 */
+			AM62AX_IOPAD(0x020, PIN_INPUT, 0) /* (H19) OSPI0_D5 */
+			AM62AX_IOPAD(0x024, PIN_INPUT, 0) /* (J20) OSPI0_D6 */
+			AM62AX_IOPAD(0x028, PIN_INPUT, 0) /* (J22) OSPI0_D7 */
+			AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (L21) OSPI0_DQS */
+		>;
+	};
+
+	pmic_irq_pins_default: pmic-irq-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_IOPAD(0x1f4, PIN_INPUT, 0) /* (D16) EXTINTn */
+		>;
+	};
+};
+
+&cpsw3g {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_rgmii1_pins_default>;
+};
+
+&cpsw_port1 {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&cpsw3g_phy1>;
+};
+
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+
+	cpsw3g_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+&fss {
+	status = "okay";
+};
+
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c0_pins_default>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		buck1-supply = <&vcc_5v0_som>;
+		buck2-supply = <&vcc_5v0_som>;
+		buck3-supply = <&vcc_5v0_som>;
+		ldo1-supply = <&vdd_3v3>;
+		ldo2-supply = <&vdd_1v8>;
+		ldo3-supply = <&vcc_5v0_som>;
+		ldo4-supply = <&vcc_5v0_som>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_irq_pins_default>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		ti,power-button;
+		system-power-controller;
+
+		regulators {
+			vdd_3v3: buck1 {
+				regulator-name = "VDD_3V3";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_1v8: buck2 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_lpddr4: buck3 {
+				regulator-name = "VDD_LPDDR4";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vddshv5_sdio: ldo1 {
+				regulator-name = "VDDSHV5_SDIO";
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-allow-bypass;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vddr_core: ldo2 {
+				regulator-name = "VDDR_CORE";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdda_1v8: ldo3 {
+				regulator-name = "VDDA_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vdd_2v5: ldo4 {
+				regulator-name = "VDD_2V5";
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		pagesize = <32>;
+		reg = <0x50>;
+	};
+
+	i2c_som_rtc: rtc@52 {
+		compatible = "microcrystal,rv3028";
+		reg = <0x52>;
+	};
+};
+
+&main_gpio0 {
+	status = "okay";
+};
+
+&main_gpio1 {
+	status = "okay";
+};
+
+&main_gpio_intr {
+	status = "okay";
+};
+
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ospi0_pins_default>;
+	status = "okay";
+
+	serial_flash: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0x0>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+		spi-max-frequency = <25000000>;
+		cdns,tshsl-ns = <60>;
+		cdns,tsd2d-ns = <60>;
+		cdns,tchsh-ns = <60>;
+		cdns,tslch-ns = <60>;
+		cdns,read-delay = <0>;
+	};
+};
+
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	disable-wp;
+	non-removable;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
new file mode 100644
index 000000000000..3b93409b23e7
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 - 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Product homepage:
+ * https://www.phytec.com/product/phyboard-am62a
+ */
+
+#include "k3-am62a7.dtsi"
+#include "k3-am62a-phycore-som.dtsi"
+#include "k3-am62x-phyboard-lyra.dtsi"
+
+/ {
+	compatible = "phytec,am62a7-phyboard-lyra-rdk",
+		     "phytec,am62a-phycore-som", "ti,am62a7";
+	model = "PHYTEC phyBOARD-Lyra AM62A7";
+};
-- 
2.25.1


