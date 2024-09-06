Return-Path: <linux-kernel+bounces-319436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAD96FC93
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900B42825B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9331B59A;
	Fri,  6 Sep 2024 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oH8mo1/a"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A091B85D7;
	Fri,  6 Sep 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653724; cv=fail; b=lO12OryxWg2x4hXPScPC1b13umI+G5dvVhqozvMldZViRl31aPOJEaGzaWE+orDuBRvem7xdS6uUYjvgAssqC92s2S0NYEJEm8Y/CefZ9bmZNUxP8KG+cxBtQspA0qa0a2Zyj5uit4FtWc8GMsyBeQigkoH4RZUAV8wkU+d8338=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653724; c=relaxed/simple;
	bh=9ZWnSqe0hXVV0YFcHZg5PpauJMGytfXCMp3eImzbEuw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GTCS6fBIC02PdzDN+D/fSYBtFN/wztjGSchXjgwFZGJHm4YhjPjzzkYIgkYx5Nh3VA0K1ymHm57X5rMXXscsaT81C/1As+Vj0TNqbT61e3Y0Oo9NRLLstqysbxXMP/8Fy0qhueda3SLSI1BN81qtokwnrOL5PfZ0mjZk9erQQJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oH8mo1/a; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTJhJfyTUsYglwUZTrz3/Nkurc8cWCJQ6lHufBvxd2h9hIh7P282YmuT9oSdVrqWgoiGTmvaTu1WYzYLof3A7TvTZEB5fIbzsGylfQFImXFaK4WNIk4Y0ZvVN4kaREobLxGLxd+lfSV6tc0yZJe3FzHSvvb7IZ/a8dJrHVi9afAHvG1mJPvW+53/NV+aggQ9+CuSatO0xQptS0GQafVvVQP1etvJ+o/bcUCaECwXPu4NFpDKmEACe+R78AQO5aTb37OQbOjuhLairgRnUIMwPkeKTmMw3bPFoFEeq/6zKQS9ajpK9qFJ/dUrKlAhYuwms6F8vLDizMHsOrToykO1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/GLq3G814IcNmhcubK1noDla7nbOXJDkywDxBXFHiQE=;
 b=WwvQw2spcSiRCocz/YqtFYyCGp9XblcbH1qvQgDqf9OSmXIcfGrvNSZSVrR3A9B3w95j3Q8FweiyHfBGBLDBSjPbaTp/yGfItTU3C1JqNBg0+AnsDqwBf39wIvyCSMzRoPvweQC8ACMGyEN3t/9hNx+P4EOCOaG6EwbcoPSIQBHdWf9kwkMdbjjowshhYPv06SH4GNWeC24zKM494tEN0tuNEzc881oxhCr53iPzw/CDy88Sdf4ZfUOdBCKIGRCy7fInhinKwZpi9c4IRkQlX1uCRPF9P/96KlKR37YYd+U4twLoHv3geZeX933J9axb58sUCGHmrgdqvRhDMxxqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GLq3G814IcNmhcubK1noDla7nbOXJDkywDxBXFHiQE=;
 b=oH8mo1/akGtP2/2RSDSEQ1iKHlGqTC3qYzzm/PrdLTcVZ3TaBatsxKqDeqklznyK5mDHcLiKnlXDNvkXttyfyJofJr8qvc6RxeBP09RpYD641srVrwjZLq6M9ovjrtJNMKF9v8asAOhsj4KZXyb9Mb3Jv27us4L8MZT8vXv5E64gip95gc4wnPTSHvqXLPA0opnAoeyUvLEREnNNuZkDUlTRVJftfqibIK9kPiwj917RFLBMnH9eNmtS7/5HIQFUL5zCzjb7Pt3BmBNE8WLunKeCF6uL8pKjDWfJCLhG0d7k0Fr7Wnd0NadIbBckl2QM8oHxCLOCIFe/B0hBtSKZ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Fri, 6 Sep
 2024 20:15:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 20:15:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: peng.fan@nxp.com,
	shawnguo@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	frank.li@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH v2 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
Date: Fri,  6 Sep 2024 16:15:01 -0400
Message-Id: <20240906201501.2249242-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0216.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc13430-1c8a-456d-2e28-08dcceb0a099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m09lmNO2d6IYvDBRL3LFVoDTR08nP1niw5l2iayCogU3RArrdoKnRWk8Hv6I?=
 =?us-ascii?Q?TR6484NJkHtjh0HcJfKqRb8YQppjbFktoLwwMEeFoNwezGchRBMuZR6OO/II?=
 =?us-ascii?Q?1FpqD0r1Z98ZZZLHGihPtBcFv0SXzuX0p+KpYm3QyROK7fu9/Vy3T6qFGQ8r?=
 =?us-ascii?Q?tdPi0/hfYNiyIe+m4Ue11Xj4EmjfpD/hFIpUcO5S+C6+nwT8NfGINtdBAmV4?=
 =?us-ascii?Q?ZtSmUY8ZnU5Y/s5HsW7YNww8xJyy9UojS4wFEH4EardTyPH0f9kGQCMVXWxe?=
 =?us-ascii?Q?r5EeU7pcc+y8C4kViWEF9LMtSKAzJQhseMJOLLphbP+YLrrXJwnVb/4ZJ1Mp?=
 =?us-ascii?Q?m8BNMq/zdW/fbU7+WP2/L9DsMbhGIbQKGLbGxKA0f8J+nsvy9490qRenkTam?=
 =?us-ascii?Q?iipyDrZQZ+gyuY/ad3OQgMwKcefd5c1Uq4ieMlpLmX+nRCpSgfIjvFvKktVj?=
 =?us-ascii?Q?8U2mPceMQ40cyeaz7ZASxI/juMv4Jxy75oJ95KSTkZJZuaGrBcO8Ds2lzGr3?=
 =?us-ascii?Q?ecYAhLCEANmekvs0Q0Kdi/XHGdpIkR+rqsorSVn04d8LQof+dyL7PrqLGi1L?=
 =?us-ascii?Q?ZL4pqI/yWIZSTP5c8nufDgaVjM6+JBDf4urn/NfRsQWfvj+EvDq/PJaNlDvN?=
 =?us-ascii?Q?vnT81Od8dIkXGdhv50Ef/usxaEYlSbN4NaND3W9GAy7hz6U/StfcJB3/kWu1?=
 =?us-ascii?Q?jFPOgw3BpfpjQdgwTzv1SDfF4qhTsYmcaigY3jPwAtahFu4vghpxNJxJpcGy?=
 =?us-ascii?Q?hCvDlGxNv7MHdCVaIlQhd8AbXAXGXip+KP85uM3OacCO3W4tp/eLcgBEw0Bx?=
 =?us-ascii?Q?LYy6ODczckgP6qBbuby9pXvb/L1tzfLSlwy+JHF7FgKnVCXD81ZM3IzNU5gl?=
 =?us-ascii?Q?oFxo2m17kjGY1Ed3JFde20KOYYN4Eld6QyJRfyqU+NGNOMSZvVGSjrwvp4fE?=
 =?us-ascii?Q?ghxrqFRcKKBqcQdYdFVv+3Z2vbNT+IaWazYUp6DJIwqmYx4ndiVvO9pN9Tvv?=
 =?us-ascii?Q?stscqsw28kLGc+rSqsBaKyRNrPLxS/DA25bE1hbhSUO/FjZTzMtxMlXyP4t4?=
 =?us-ascii?Q?d++HH5ckfubk60CeqdbHkov96tMTOnWZzDHpcUYeS6mDdI5Eg1yN4pezrANW?=
 =?us-ascii?Q?sC2DVVzldHwvDDe0skAHGKg34j/FeWWeH440FgrnA7xDowlcTxX20zMG9Q1m?=
 =?us-ascii?Q?O/+hoNSfNg2GQAc93nHCe+wVrBOStJ+h9jxrvMeb1sy7avwKw/ym2V1FxYCi?=
 =?us-ascii?Q?Zz54diJAek9mqqB0wRK585C0y5OuBlGz1rriB5jHH4fdHo1ED31e8BNjWxDD?=
 =?us-ascii?Q?MxbrpbMk5E14Vkf8APP/fwZCZ8MBhPxQBr58/P3Ban88OKzWB5typuBZyMjb?=
 =?us-ascii?Q?l9PRcuTezqDgaljeU5HCshTz0Z0w0h+NvB74rXYq8Oz6xCMNpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3fgjxJ0JsLbimrCr/WVAT6omUF5d/N6ALZYTPJD3yfa3zWOhF7zjTx3v3XyK?=
 =?us-ascii?Q?e7GtV+LXRRxSk6a4g0E2rAZycVbBwbmm1SH5M6BFqJX7E2LudL3CoUzCtD2N?=
 =?us-ascii?Q?w7/5yCoQ3W9asv34Rb3zSbXeYkXncuit45cTylcyjDdEAMFAbbCazV2h5fAc?=
 =?us-ascii?Q?y6YLBs26XrzkeQ7UizmCyg5/8FVYV1DYCiUuxbdCfzWpHORtWaoGNBc+7dnw?=
 =?us-ascii?Q?1wAeU71Anb9INgYjX6XAJ0NjogXzf81GePyxP1Jtdg1o2ZfQCrXbxVcnPaE/?=
 =?us-ascii?Q?EbOpYKPbyH2RsRhu4L6TzAoiwj5/V3JVsLezlSp0DTJszG002rqfOvkgKPPB?=
 =?us-ascii?Q?FRbcprm9CBS/m7kWaO0kUGO7+gCPtGPv3FkEEL/xNbCPssNUEwejJriptZ4X?=
 =?us-ascii?Q?DB3uy4VXYiikZNXIg/MJQ3klie12x4/dxF847B5nyPwD2TYq+KgN01IWWJSG?=
 =?us-ascii?Q?2w8vgXco9o1202mEznGvDx8tXsdozlY1TfM0vbDoOQD5HcrN+0ARjulantB0?=
 =?us-ascii?Q?o7jX7UPK9JaxZ7oSbIdfkRtquJ2IEPtkH8XcEqKBp7VaX0JC14FMnqimmBBo?=
 =?us-ascii?Q?SnCzSAKKfr4lyzPemtu6MjoOpTllmTYn8z7vlZqqfRlmPdD1yFs0Y/wrssFj?=
 =?us-ascii?Q?xEgGY0Ev1wNZYZmTYochtH6fcYcWUPns25+Q+ix4z1fi2BS3HLOUVfzfxls7?=
 =?us-ascii?Q?/keTO73ljCTCV4MxDskgyZvt3O3wxp1A9ckagWMpJ0iGjSWuJjuhA4w2Y3Dd?=
 =?us-ascii?Q?cKekzJZoMnGqe1m7JfRy1oY3CdEpWnTFml8HFJk+B/v60ju5V838qnKcAlA2?=
 =?us-ascii?Q?lcV11umStzgZ97R8N/LRTecc1pQ0gZ/35Uo4/RYcN3Zyub2qMupi/bNq25fM?=
 =?us-ascii?Q?/huc5MGNtsY03xk2on7Ww8o4U2pCucJXlB3+2eXXrSPR18O9ER6G2gTK8gLf?=
 =?us-ascii?Q?Hnq4ikT8/XZTgHbzUVrwQ04Sz0QTGnuHy3+4mUXT6zf3LckFnGrL2UOY98wo?=
 =?us-ascii?Q?yGMd0UuGNp5MLO3CiYvFEsQZQ3dqq6dF6jaSmDeFz79yoFfv8s3G6n0blYmK?=
 =?us-ascii?Q?Gcwxlb2yQAFmLWiZNeddZzrgUE8E0t3A/WPlxzCYS4gVQUXKo1Cm2vA+uk1p?=
 =?us-ascii?Q?fMZXWUynoEhbAa49UklLeDED4fcpMNiYEwFj9K8pfA32L9DbfhV8xfQfbLks?=
 =?us-ascii?Q?bKAUlhiUbLT8uVi79pagiD8EANBXGxnil/xrVhDm0Xck/eJns0J+RX8hs3Gj?=
 =?us-ascii?Q?FSV+1nQX4eXB67hPk6yca/RrtUJxU2+y7V1b1X3jOZ8T67+JPsYjYQiL1TO/?=
 =?us-ascii?Q?Toz6UZ0VE+eMyDg7Er5FnZJjEF3aEhNnaIW0mBvn1jC2GMYvWMTJ9lV2TLXZ?=
 =?us-ascii?Q?5dDbhOotivTlXVpLICAaHVCixUx83BEaMiDeIiytbECLK6JrIUbf8fnRd5qo?=
 =?us-ascii?Q?9LfTf8bdyem3tcH1QFUrsKwMWN5NQKnEnkG5UKYCs5mZLM6x9KoQDNVaC4VF?=
 =?us-ascii?Q?OC5+oVqp/ho3YoOudnYZNGpP5jQIx5B6nbsaVVg0OPgg/65JmgtFuk6t8tpu?=
 =?us-ascii?Q?/E46d3EqzPBKtz8ZPwU0RjhbgdEXWytEor18BIlD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc13430-1c8a-456d-2e28-08dcceb0a099
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 20:15:18.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dXU7BWd4CjIOd2SC+9Kv+qMrSXKlhhcxnNDbA1OneXjEo2bbgXlHoeX0tDy3+KoSslf/tEb/rky81uUtEP1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

Add an overlay file to enable I3C support on the i.MX93, replacing I2C1
with I3C. I3C is compatible with I2C, but it has not yet been enabled in
arm64's defconfig. This overlay allows users to conveniently utilize I3C
on the imx93-9x9-qsb platform until I3C and its driver become more mature
and ready for full switch to I3C.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v1 to v2
- update to 2024
- drop imx93-clock.h
- use irq.h
---
 arch/arm64/boot/dts/freescale/Makefile        |  4 ++
 .../boot/dts/freescale/imx93-9x9-qsb-i3c.dtso | 72 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 9d3df8b218a2e..032f07adc0c53 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -240,6 +240,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
+
+imx93-9x9-qsb-i3c-dtbs += imx93-9x9-qsb.dtb imx93-9x9-qsb-i3c.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb-i3c.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
new file mode 100644
index 0000000000000..3fe6209a34236
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-9x9-qsb-i3c.dtso
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/i3c/i3c.h>
+#include <dt-bindings/usb/pd.h>
+
+#include "imx93-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&lpi2c1 {
+	status = "disabled";
+};
+
+&i3c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c1>;
+	#address-cells = <3>;
+	#size-cells = <0>;
+	i2c-scl-hz = <400000>;
+	status = "okay";
+
+	tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50 0x00 (I2C_FM | I2C_NO_FILTER_LOW_FREQUENCY)>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&usb1_drd_sw {
+	remote-endpoint = <&typec1_dr_sw>;
+};
+
+&iomuxc {
+	pinctrl_i3c1: i3c1grp {
+		fsl,pins = <
+			MX93_PAD_I2C1_SCL__I3C1_SCL	0x40000186
+			MX93_PAD_I2C1_SDA__I3C1_SDA	0x40000186
+		>;
+	};
+};
-- 
2.34.1


