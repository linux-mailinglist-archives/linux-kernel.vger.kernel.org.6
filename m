Return-Path: <linux-kernel+bounces-348231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4298E464
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F041F23B6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21CD21731A;
	Wed,  2 Oct 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QU498d2c"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79A8F5B;
	Wed,  2 Oct 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902097; cv=fail; b=JsMWqWpGHxiePeZzmEPjYoQezD2TV/cs0XLoV8uBCqjAnv8et81DZb2PK5Lhj7E4zFBoMqClWfJJOXi6ZnyLFczNXXtvdrGj0lcVJVcvpoEpZasMPydewSU5w2BS7RvZVX8TUqq4etIOBNSHApKIvHMPW724gBCnq8KcWxfgFBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902097; c=relaxed/simple;
	bh=Ka245HKXqUpNg757p+4ZS4ZC/Xsj0RdbEOMez1Lso/s=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ImPUdJ6ilLYLrNk31lFuyHUU1mn9h8kkR3Secgc0Se8yqBSRPv/IZFT9814LOJ/bwIPUItapB+ONSYoCJvo+5jXGrs15CB3wO3itTi3CxfvfjLBHUPFL6qxDOVcFHNIaNwQvWtyYEaTxTilSpGYWLHe3Dn4Ujb4Ik4fq86ZagrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QU498d2c; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS7v8HqdY3ue5WPiD562Wcxx0kjICiityY+UZTxw7KR8qGDoEt9zooDbMmsTiBxOKbgzCu9sjGmqkjYWBUeZXCJ+H62Mk1LbXDpJgj9ur1ykDJroKY2BOwZtvDbRU2pYXO9P1oH0rCkhWf2/VR05GSowvhupB/3ogdu3/bnAtDnvU+ZxoddauH+jIV2LuNxa3wn/lSZTUsl/BvaQoW01lHGIPxHdT8qtSKEAbJiCeI+zTO6HNDDKvb800SzlDrnt3TR6PXbJ4mQAZvSdCpvWo5NM5Tzpeg59duHzetW3FQ23P/m1G0LMtBnh09x/RjgE1Ad5rNSGrUnYFnskfYr1UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXi+j0EV0CJc/u/p3PXyNKxvwE4Wq3Yfw/N/ihHs1ms=;
 b=EvByI9W1lX706n50xqzL7wqBT6SzdCRxuzXm4/lYx0S9mc1ON0LU2gO+o2QJ7U2PzSk6wIMlQquwS9HPFdZo+2NXVSbhJ4535bsMsUayVz0W0aDgruE5ldij3u2/jGAei3tWvoK43Z7Oikag9AgRkKjKR7Q95PSOVbf5d/RYhfvPar4+L4bhhbDj7SJbUKCofsl59Kv/BXF6QkHa1bsqBsAl2jEM0j25f55CH8RY5sXVGr0ascuVIxA+/dNXhSlJFmqivNxHoRKnNj53VxTXofgjH4+TeYXr8JZgJx1j5Xp4BEVMiCbIwqXyYRLlMl+ZfI0ctA7A+eIspQPlFL2nZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXi+j0EV0CJc/u/p3PXyNKxvwE4Wq3Yfw/N/ihHs1ms=;
 b=QU498d2cWvgbXRHth2o7upM6t7y3Bf1AzL+dLEh7u4RkK0ryu/jKZITjN1HbKFYfJi+MxN8wGXOV8QTNe8a4KUYV3FwxxFqxM/tm75X5I0Kn57XCRRBJv0otM/i2tcT8FoOHtLAD7i4AwzsZtB0XklA471UznCwLrtyb0rEnIGV+lV+Y3j7/9NJvEkfCfc3B7YWpAS1pCBghUrx40UHdIvdrZZNmjU3Ad//4wRmw3r9xQ/uNb0ClxauQ8OR+5cD7/eA7fx6w7VqlK5fCnNBYu6rUk1MCJ79iKb9OaiFCIUfVg6ki3OGUJGnQoNCjeY8+bZsa28vo6t/0JDfwAc9Akw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:48:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:48:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] arm64: dts: imx8-ss-hsio: Add PCIe support
Date: Wed,  2 Oct 2024 16:47:45 -0400
Message-Id: <20241002204750.597337-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0af5a0-d64e-4316-7445-08dce3238661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jEqwuRbGNInLaVhy0nTGlxsW0Kg1ls6q1BGnSMMHiOd4/1lusfqH5HM2pZG3?=
 =?us-ascii?Q?SygXWCxhWhzv4jq3Oc8rSkS4EXS9qxx2fKKCGHuLHdBA4HBz3GflAVH0Tbi/?=
 =?us-ascii?Q?xsA4gbcsdWK8ywpaFe3yXsbLLx/ULHrpZSrXhVW0fXwh6uJYEgbS13aDPWGP?=
 =?us-ascii?Q?ynEhcOTbV6t2x0H7ShawMfugi8JyqGCvZCc5VIhwxnU28htaAtqSQ9slzbQn?=
 =?us-ascii?Q?p5RKioCNjV2/NQdFFw8wxWHYoM/zJ0p8KeDrE3vECca/5gidywbU7lvjeOqU?=
 =?us-ascii?Q?++ktLxNP1LnyS6xYHCB3R29afEJiEGS0l26S9QaBX3x6923C6GtZ8o+2vRYt?=
 =?us-ascii?Q?K8fu12FxiA6tto2x7J+X6+n1JkAPQC4C6L69iTgeLvrUdhwB+6hR4Jm58p/4?=
 =?us-ascii?Q?1iX0kU6zzLxEXlvckLKxoVLF3pf1cdujuzkypjTnuaRxskk5DvMwFKDON1iT?=
 =?us-ascii?Q?P64IoMzC0N7KFzGYyaiS0xSuHwspKLHIWPnqYAz8TWjXsgCpOPSZDmvYbAIi?=
 =?us-ascii?Q?tj2x3nxc18+4Z5y9ZAZmqMH8T3He4fYQFNY2SrFXkhWR7xUrY+OCnP0MM+Df?=
 =?us-ascii?Q?qIWelJxCEgjBdX9F2dYobIsiP4X0RdoQVshX/NvdJlXMugs/kJ6WNrspnb4L?=
 =?us-ascii?Q?aLz6c1Gt+bB4ntCnvMJRr8dcP3867t3AV8DUcpFlammFEJ9VsubZYWEttjAv?=
 =?us-ascii?Q?buoWwLSN4I1/7KWCagR7VYpGNlI9wS1XO6vCg4Y5zVL+9ETLOBUmzo/IMqZj?=
 =?us-ascii?Q?slXOg/zqmv8OaKszH056bl/n9zUUNbYVrVZYamrzDkehHvQTKIvE3+dwv4NZ?=
 =?us-ascii?Q?vAqH8+3qvJHEV1vq6SS4VtNscZJXZNP39/9cpCbYeTyelA/ol+kYzpRBz4GR?=
 =?us-ascii?Q?CvcjLLkkpVAqThqjJM685TdMcqLZ5OmNHDlEtzw53i42PTGjxbxpQ7h9Qb0R?=
 =?us-ascii?Q?ssda+JQv3P5re6beeaaD4c94V3xhzN5T48lEs2T51vcMrLK3tj+RBT53fmn4?=
 =?us-ascii?Q?ot/uaASxsqNlD1V4d0rx4dcBMh5CzJs7Nl5qoQ2aHjKJ1Tg3Sr+v35v8QXTZ?=
 =?us-ascii?Q?aJsWN4Qb9IwOhQsjGh5P7Nn4VwTYxtp6VfUR2lNVEXAJiQEavmxqwppv0lWe?=
 =?us-ascii?Q?jn6yEIoO+ig627QTrf7G1VB3H55ie+XgtrsaKRex0/EZvw7JIb1w3j2KaZDY?=
 =?us-ascii?Q?Pl7PV5UOHolpoa65BvQeLurJgyY51beYpgplV9++QSZGSWLdD89WPGz/O0fv?=
 =?us-ascii?Q?WAJWmXEOaKZWL/FZezsTfpwg4AbPtVVZm2nd/bA4BWsnvGCWJzb7gTXuZJPi?=
 =?us-ascii?Q?TC8E7FonmGdr0FutlMaC4Goi+SZ9Q+gSUfIIeL3O/QE9eRIODT/wggStLnIn?=
 =?us-ascii?Q?e/I7pbs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?732722lDY1HGdCrvnfvYVUnMkSw/K3QVoQXfiLJ7sIXpHDcEnIK4YQ1wa6VU?=
 =?us-ascii?Q?bDnZYyPpvDjE5fkTOLuP2ioBXI06rCYRi8Po/CezGArDHXhZg+03K+EDOt3k?=
 =?us-ascii?Q?f0nt7NN5JecWLhsNiX/KrKr186g38JgW1c3omhIdbpGt87LWBhFDA2Ypdgjc?=
 =?us-ascii?Q?+VjqcbIehvMs1TVlubIklPbQva9bocEt2oyijYQ/1uMpmOhshnSXXwW+vOhH?=
 =?us-ascii?Q?mvzSfwLRb8vv6btE/RybfnkOSU+M3zPWocpGvv2GcjH39sOIB6vBlBxF3rNc?=
 =?us-ascii?Q?fETg7nvdxDOsQ7C0etSUiEMXdl6LsM9/ZO6fl/xzkFbnPJiGj8473ErWNBY3?=
 =?us-ascii?Q?EhXyiuB7FlCkXk9vdykjPh5AiuP5p98aW/uLvEn5KfCu4qWkM8pRqD/IoaB5?=
 =?us-ascii?Q?KBwkuLU49PnRMm/QLjfcBQtieOq2p2sC9D6/dJn15+XAuY7uIqf3r9Z4PXWK?=
 =?us-ascii?Q?O+eaFXO51I4XuTSYTDv3ctRoEYdsaacQxU+2Ow4jjVJK5zSd48G0tzzEwiG1?=
 =?us-ascii?Q?OHrDx6K7rTQJnPmD9u+MKAgSqllOpTLm2Ewh3ZsJHl2/WcpamiAVwxkq7kwo?=
 =?us-ascii?Q?ejRzdR14Alc6jP9GZ2sbe6Toem53Kr6mKLGNmk85z7WkpW4UAVTrOJPAAtNG?=
 =?us-ascii?Q?/G6Y4+KpCpDAI+1JOuWre0j1gSDc7Gq9n9S84tsdMIjBKVeoOtvHhTnlW+tJ?=
 =?us-ascii?Q?c2YDgFWj2Y3eaC8eBoKbRWC8zwUHBxv3q8QpCBtE18VBIFdsUcwLFqyBbF44?=
 =?us-ascii?Q?ZJuMB+adYO6wFXBftlHSjFX3L2HXeYK6IElM1Nlw9qTfx31wKITdPJI5Ggk9?=
 =?us-ascii?Q?7Qp9tmuKCfWxhVBN1iFqIFFtKBNLzBOCyZNwSWdhO5aTyIyPHkentZm1F6Vd?=
 =?us-ascii?Q?tB+5RjdQbOlyByzkmCMRLfEIu3vNkhF9lZy77I1W5IROw58ONnFqE6f4uDBX?=
 =?us-ascii?Q?KWPMOp9bRH+S7HQgxT/UrWfl16csv1x4beKSMn1KiaHMyD1IIM0w+gvKljHW?=
 =?us-ascii?Q?2Dw+ITO2uuBMoi16orCm20PwlC444xzj5k3lvJlWdqcvs5wKn1qRb5vuuZmI?=
 =?us-ascii?Q?sCg/4C9U0rtaJxHA1nZIO1F68Vl4AzbU/EHVxrw1634Q3DbgkGGlLG69V+vs?=
 =?us-ascii?Q?u1Wk05FQ3LjjkbPa3G/KOerxDjoEhjq05bfnWEj0lytsQaCQ7avmwp5nh45c?=
 =?us-ascii?Q?VtVSIPlr8VL4f9STLFZrE2WwlUPJo/YXImdgXkYWNh13aHmfKAXlBcH2pt1+?=
 =?us-ascii?Q?x3ftYO8RtTwKZv5eGeXGS0PxSQwJus7ncg6RYL+pve46PdwblxEEi5CN7po3?=
 =?us-ascii?Q?x4Gh6dpDqeLwWus2KCS94Ow0vCjB1OZFkgU8kN+lDp+WuUpcDPuxdc7CbZrc?=
 =?us-ascii?Q?MotfUpdd0iv1WihEzdZe8iYB9QtrrEjaLHoqHZTfF8imoIHnz+e+3NQ4ITJi?=
 =?us-ascii?Q?vjArp+7aF15vwcEm8uzEhYAKWYP81X4EelZSEB0H0bURonbe+clF3EQiXPBK?=
 =?us-ascii?Q?4Ra9JIEhXtMf6AuF9U3JFF9zVNv4mYJwTnm4/Gp5cir+dVG6lMAL9t9/RfBu?=
 =?us-ascii?Q?d0Da7e9MuFBiULRD10WngEy+W6iq/rMCxwQkqWVf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0af5a0-d64e-4316-7445-08dce3238661
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:48:10.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlZgRoBalz9UJycmZb3GtgMM9+ZdjjXK2BDJyMQ2kCD9pmJWKocfB1JMaqw8HQ/Bsi9eLqGw04APc8wvE7rhWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454

From: Richard Zhu <hongxing.zhu@nxp.com>

Add PCIe support for i.MX8QXP, i.MX8QM and i.MX8DXL.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
On going discussion:
https://lore.kernel.org/imx/20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com/
don't affect this dts.
This work for with/without above patches.
---
 .../boot/dts/freescale/imx8-ss-hsio.dtsi      | 123 +++++++++++
 .../boot/dts/freescale/imx8dxl-ss-hsio.dtsi   |  52 +++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi    |   2 +
 .../boot/dts/freescale/imx8qm-ss-hsio.dtsi    | 209 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |   2 +
 .../boot/dts/freescale/imx8qxp-ss-hsio.dtsi   |  41 ++++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |   2 +
 7 files changed, 431 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
new file mode 100644
index 0000000000000..bf05cae05d27a
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *
+ * Richard Zhu <hongxing.zhu@nxp.com>
+ */
+#include <dt-bindings/phy/phy.h>
+
+hsio_axi_clk: clock-hsio-axi {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <400000000>;
+	clock-output-names = "hsio_axi_clk";
+};
+
+hsio_per_clk: clock-hsio-per {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <133333333>;
+	clock-output-names = "hsio_per_clk";
+};
+
+hsio_refa_clk: clock-hsio-refa {
+	compatible = "gpio-gate-clock";
+	clocks = <&xtal100m>;
+	#clock-cells = <0>;
+	enable-gpios = <&lsio_gpio4 27 GPIO_ACTIVE_LOW>;
+};
+
+hsio_refb_clk: clock-hsio-refb {
+	compatible = "gpio-gate-clock";
+	clocks = <&xtal100m>;
+	#clock-cells = <0>;
+	enable-gpios = <&lsio_gpio4 1 GPIO_ACTIVE_LOW>;
+};
+
+xtal100m: clock-xtal100m {
+	compatible = "fixed-clock";
+	#clock-cells = <0>;
+	clock-frequency = <100000000>;
+	clock-output-names = "xtal_100MHz";
+};
+
+hsio_subsys: bus@5f000000 {
+	compatible = "simple-bus";
+	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
+		 <0x80000000 0x0 0x70000000 0x10000000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
+
+	pcieb: pcie@5f010000 {
+		compatible = "fsl,imx8q-pcie";
+		reg = <0x5f010000 0x10000>,
+		      <0x8ff00000 0x80000>;
+		reg-names = "dbi", "config";
+		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
+			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
+		#interrupt-cells = <1>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
+			 <&pcieb_lpcg IMX_LPCG_CLK_4>,
+			 <&pcieb_lpcg IMX_LPCG_CLK_5>;
+		clock-names = "dbi", "mstr", "slv";
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		fsl,max-link-speed = <3>;
+		interrupt-map = <0 0 0 1 &gic 0 105 4>,
+				 <0 0 0 2 &gic 0 106 4>,
+				 <0 0 0 3 &gic 0 107 4>,
+				 <0 0 0 4 &gic 0 108 4>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		num-lanes = <1>;
+		num-viewport = <4>;
+		power-domains = <&pd IMX_SC_R_PCIE_B>;
+		status = "disabled";
+	};
+
+	pcieb_lpcg: clock-controller@5f060000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f060000 0x10000>;
+		clocks = <&hsio_axi_clk>, <&hsio_axi_clk>, <&hsio_axi_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>, <IMX_LPCG_CLK_6>;
+		clock-output-names = "hsio_pcieb_mstr_axi_clk",
+				     "hsio_pcieb_slv_axi_clk",
+				     "hsio_pcieb_dbi_axi_clk";
+		power-domains = <&pd IMX_SC_R_PCIE_B>;
+	};
+
+	phyx1_crr1_lpcg: clock-controller@5f0b0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f0b0000 0x10000>;
+		clocks = <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_phyx1_per_clk";
+		power-domains = <&pd IMX_SC_R_SERDES_1>;
+	};
+
+	pcieb_crr3_lpcg: clock-controller@5f0d0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f0d0000 0x10000>;
+		clocks = <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_pcieb_per_clk";
+		power-domains = <&pd IMX_SC_R_PCIE_B>;
+	};
+
+	misc_crr5_lpcg: clock-controller@5f0f0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f0f0000 0x10000>;
+		clocks = <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_misc_per_clk";
+		power-domains = <&pd IMX_SC_R_HSIO_GPIO>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
new file mode 100644
index 0000000000000..f3104e205ae89
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-hsio.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+&hsio_subsys {
+	phyx1_lpcg: clock-controller@5f090000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f090000 0x10000>;
+		clocks = <&hsio_refb_clk>, <&hsio_per_clk>,
+			 <&hsio_per_clk>, <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_phyx1_pclk",
+				     "hsio_phyx1_epcs_tx_clk",
+				     "hsio_phyx1_epcs_rx_clk",
+				     "hsio_phyx1_apb_clk";
+		power-domains = <&pd IMX_SC_R_SERDES_1>;
+	};
+
+	hsio_phy: phy@5f1a0000 {
+		compatible = "fsl,imx8qxp-hsio";
+		reg = <0x5f1a0000 0x10000>,
+		      <0x5f120000 0x10000>,
+		      <0x5f140000 0x10000>,
+		      <0x5f160000 0x10000>;
+		reg-names = "reg", "phy", "ctrl", "misc";
+		clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
+			 <&phyx1_lpcg IMX_LPCG_CLK_4>,
+			 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
+			 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
+			 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr",
+			      "misc_crr";
+		#phy-cells = <3>;
+		power-domains = <&pd IMX_SC_R_SERDES_1>;
+		status = "disabled";
+	};
+};
+
+&pcieb {
+	#interrupt-cells = <1>;
+	interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-names = "msi";
+	interrupt-map = <0 0 0 1 &gic 0 47 4>,
+			 <0 0 0 2 &gic 0 48 4>,
+			 <0 0 0 3 &gic 0 49 4>,
+			 <0 0 0 4 &gic 0 50 4>;
+	interrupt-map-mask = <0 0 0 0x7>;
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 7e54cf2028580..76de3db8b9423 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -237,12 +237,14 @@ xtal24m: clock-xtal24m {
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-ddr.dtsi"
 	#include "imx8-ss-lsio.dtsi"
+	#include "imx8-ss-hsio.dtsi"
 };
 
 #include "imx8dxl-ss-adma.dtsi"
 #include "imx8dxl-ss-conn.dtsi"
 #include "imx8dxl-ss-lsio.dtsi"
 #include "imx8dxl-ss-ddr.dtsi"
+#include "imx8dxl-ss-hsio.dtsi"
 
 &cm40_intmux {
 	interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
new file mode 100644
index 0000000000000..6494f55d33f85
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Richard Zhu <hongxing.zhu@nxp.com>
+ */
+
+&hsio_subsys {
+	compatible = "simple-bus";
+	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
+		 <0x40000000 0x0 0x60000000 0x10000000>,
+		 <0x80000000 0x0 0x70000000 0x10000000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	pciea: pcie@5f000000 {
+		compatible = "fsl,imx8q-pcie";
+		reg = <0x5f000000 0x10000>,
+		      <0x4ff00000 0x80000>;
+		reg-names = "dbi", "config";
+		ranges = <0x81000000 0 0x00000000 0x4ff80000 0 0x00010000>,
+			 <0x82000000 0 0x40000000 0x40000000 0 0x0ff00000>;
+		#interrupt-cells = <1>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		clocks = <&pciea_lpcg 2>,
+			 <&pciea_lpcg 0>,
+			 <&pciea_lpcg 1>;
+		clock-names = "dbi", "mstr", "slv";
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		fsl,max-link-speed = <3>;
+		interrupt-map = <0 0 0 1 &gic 0 73 4>,
+				 <0 0 0 2 &gic 0 74 4>,
+				 <0 0 0 3 &gic 0 75 4>,
+				 <0 0 0 4 &gic 0 76 4>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		num-lanes = <1>;
+		num-viewport = <4>;
+		power-domains = <&pd IMX_SC_R_PCIE_A>;
+		status = "disabled";
+	};
+
+	pcieb: pcie@5f010000 {
+		compatible = "fsl,imx8q-pcie";
+		reg = <0x5f010000 0x10000>,
+		      <0x8ff00000 0x80000>;
+		reg-names = "dbi", "config";
+		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
+			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
+		#interrupt-cells = <1>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		clocks = <&pcieb_lpcg 2>,
+			 <&pcieb_lpcg 0>,
+			 <&pcieb_lpcg 1>;
+		clock-names = "dbi", "mstr", "slv";
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		fsl,max-link-speed = <3>;
+		interrupt-map = <0 0 0 1 &gic 0 105 4>,
+				 <0 0 0 2 &gic 0 106 4>,
+				 <0 0 0 3 &gic 0 107 4>,
+				 <0 0 0 4 &gic 0 108 4>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		num-lanes = <1>;
+		num-viewport = <4>;
+		power-domains = <&pd IMX_SC_R_PCIE_B>;
+		status = "disabled";
+	};
+
+	sata: sata@5f020000 {
+		compatible = "fsl,imx8qm-ahci";
+		reg = <0x5f020000 0x10000>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sata_lpcg 0>,
+			 <&sata_crr4_lpcg 0>;
+		clock-names = "sata", "sata_ref";
+		/*
+		 * Since "REXT" pin is only present for first lane PHY
+		 * and its calibration result will be stored, and shared
+		 * by the PHY used by SATA.
+		 *
+		 * Add the calibration PHYs for SATA here, although only
+		 * the third lane PHY is used by SATA.
+		 */
+		phys = <&hsio_phy 2 PHY_TYPE_SATA 0>,
+		       <&hsio_phy 0 PHY_TYPE_PCIE 0>,
+		       <&hsio_phy 1 PHY_TYPE_PCIE 1>;
+		phy-names = "sata-phy", "cali-phy0", "cali-phy1";
+		power-domains = <&pd IMX_SC_R_SATA_0>;
+		status = "disabled";
+	};
+
+	pciea_lpcg: clock-controller@5f050000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f050000 0x10000>;
+		clocks = <&hsio_axi_clk>, <&hsio_axi_clk>, <&hsio_axi_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>, <IMX_LPCG_CLK_6>;
+		clock-output-names = "hsio_pciea_mstr_axi_clk",
+				     "hsio_pciea_slv_axi_clk",
+				     "hsio_pciea_dbi_axi_clk";
+		power-domains = <&pd IMX_SC_R_PCIE_A>;
+	};
+
+	sata_lpcg: clock-controller@5f070000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f070000 0x10000>;
+		clocks = <&hsio_axi_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_sata_clk";
+		power-domains = <&pd IMX_SC_R_SATA_0>;
+	};
+
+	phyx2_lpcg: clock-controller@5f080000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f080000 0x10000>;
+		clocks = <&hsio_refa_clk>, <&hsio_per_clk>,
+			 <&hsio_refa_clk>, <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>;
+		clock-output-names = "hsio_phyx2_pclk_0",
+				     "hsio_phyx2_pclk_1",
+				     "hsio_phyx2_apbclk_0",
+				     "hsio_phyx2_apbclk_1";
+		power-domains = <&pd IMX_SC_R_SERDES_0>;
+	};
+
+	phyx1_lpcg: clock-controller@5f090000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f090000 0x10000>;
+		clocks = <&hsio_refa_clk>, <&hsio_per_clk>,
+			 <&hsio_per_clk>, <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_phyx1_pclk",
+				     "hsio_phyx1_epcs_tx_clk",
+				     "hsio_phyx1_epcs_rx_clk",
+				     "hsio_phyx1_apb_clk";
+		power-domains = <&pd IMX_SC_R_SERDES_1>;
+	};
+
+	phyx2_crr0_lpcg: clock-controller@5f0a0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f0a0000 0x10000>;
+		clocks = <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_phyx2_per_clk";
+		power-domains = <&pd IMX_SC_R_SERDES_0>;
+	};
+
+	pciea_crr2_lpcg: clock-controller@5f0c0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f0c0000 0x10000>;
+		clocks = <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_pciea_per_clk";
+		power-domains = <&pd IMX_SC_R_PCIE_A>;
+	};
+
+	sata_crr4_lpcg: clock-controller@5f0e0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f0e0000 0x10000>;
+		clocks = <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_sata_per_clk";
+		power-domains = <&pd IMX_SC_R_SATA_0>;
+	};
+
+	hsio_phy: phy@5f180000 {
+		compatible = "fsl,imx8qm-hsio";
+		reg = <0x5f180000 0x30000>,
+		      <0x5f110000 0x20000>,
+		      <0x5f130000 0x30000>,
+		      <0x5f160000 0x10000>;
+		reg-names = "reg", "phy", "ctrl", "misc";
+		clocks = <&phyx2_lpcg IMX_LPCG_CLK_0>,
+			 <&phyx2_lpcg IMX_LPCG_CLK_1>,
+			 <&phyx2_lpcg IMX_LPCG_CLK_4>,
+			 <&phyx2_lpcg IMX_LPCG_CLK_5>,
+			 <&phyx1_lpcg IMX_LPCG_CLK_0>,
+			 <&phyx1_lpcg IMX_LPCG_CLK_1>,
+			 <&phyx1_lpcg IMX_LPCG_CLK_2>,
+			 <&phyx1_lpcg IMX_LPCG_CLK_4>,
+			 <&phyx2_crr0_lpcg IMX_LPCG_CLK_4>,
+			 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
+			 <&pciea_crr2_lpcg IMX_LPCG_CLK_4>,
+			 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
+			 <&sata_crr4_lpcg IMX_LPCG_CLK_4>,
+			 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "pclk0", "pclk1", "apb_pclk0", "apb_pclk1",
+			      "pclk2", "epcs_tx", "epcs_rx", "apb_pclk2",
+			      "phy0_crr", "phy1_crr", "ctl0_crr",
+			      "ctl1_crr", "ctl2_crr", "misc_crr";
+		#phy-cells = <3>;
+		power-domains = <&pd IMX_SC_R_SERDES_0>, <&pd IMX_SC_R_SERDES_1>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 3ee6e2869e3cf..ac9064a949d82 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -594,6 +594,7 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-lsio.dtsi"
+	#include "imx8-ss-hsio.dtsi"
 };
 
 #include "imx8qm-ss-img.dtsi"
@@ -603,3 +604,4 @@ mipi_pll_div2_clk: clock-controller-mipi-div2-pll {
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
 #include "imx8qm-ss-mipi.dtsi"
+#include "imx8qm-ss-hsio.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi
new file mode 100644
index 0000000000000..47fc6e0cff4a1
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-ss-hsio.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ *	Richard Zhu <hongxing.zhu@nxp.com>
+ */
+
+&hsio_subsys {
+	phyx1_lpcg: clock-controller@5f090000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5f090000 0x10000>;
+		clocks = <&hsio_refb_clk>, <&hsio_per_clk>,
+			 <&hsio_per_clk>, <&hsio_per_clk>;
+		#clock-cells = <1>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>,
+				<IMX_LPCG_CLK_2>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "hsio_phyx1_pclk",
+				     "hsio_phyx1_epcs_tx_clk",
+				     "hsio_phyx1_epcs_rx_clk",
+				     "hsio_phyx1_apb_clk";
+		power-domains = <&pd IMX_SC_R_SERDES_1>;
+	};
+
+	hsio_phy: phy@5f1a0000 {
+		compatible = "fsl,imx8qxp-hsio";
+		reg = <0x5f1a0000 0x10000>,
+		      <0x5f120000 0x10000>,
+		      <0x5f140000 0x10000>,
+		      <0x5f160000 0x10000>;
+		reg-names = "reg", "phy", "ctrl", "misc";
+		clocks = <&phyx1_lpcg IMX_LPCG_CLK_0>,
+			 <&phyx1_lpcg IMX_LPCG_CLK_1>,
+			 <&phyx1_crr1_lpcg IMX_LPCG_CLK_4>,
+			 <&pcieb_crr3_lpcg IMX_LPCG_CLK_4>,
+			 <&misc_crr5_lpcg IMX_LPCG_CLK_4>;
+		clock-names = "pclk0", "apb_pclk0", "phy0_crr", "ctl0_crr",
+			      "misc_crr";
+		#phy-cells = <3>;
+		power-domains = <&pd IMX_SC_R_SERDES_1>;
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 0313f295de2e9..db21c6d64f24d 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -323,6 +323,7 @@ map0 {
 	#include "imx8-ss-conn.dtsi"
 	#include "imx8-ss-ddr.dtsi"
 	#include "imx8-ss-lsio.dtsi"
+	#include "imx8-ss-hsio.dtsi"
 };
 
 #include "imx8qxp-ss-img.dtsi"
@@ -330,3 +331,4 @@ map0 {
 #include "imx8qxp-ss-adma.dtsi"
 #include "imx8qxp-ss-conn.dtsi"
 #include "imx8qxp-ss-lsio.dtsi"
+#include "imx8qxp-ss-hsio.dtsi"
-- 
2.34.1


