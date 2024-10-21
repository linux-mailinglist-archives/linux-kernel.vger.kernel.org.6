Return-Path: <linux-kernel+bounces-374992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E79A72E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB728B219DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCDC1FB3F6;
	Mon, 21 Oct 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gbrhf5pG"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEE1F9408;
	Mon, 21 Oct 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537584; cv=fail; b=By78d8XAsudGyFHQQAvmFymmVx0fQNbYLE9SH5egJ+yzZxh8rBW1v5Sv9KGU+0ABFqauQxmwAl0NeT1HQQAnPhKQTM4SYLaWUQ/CQ+mgvpu+b4kEsrzWxG6URiBuEEvP98v2cGPV+VVa1YFYwZg107YfxjKZC18KEUwAYKqAtcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537584; c=relaxed/simple;
	bh=nk697icWayCBWBjLUKZkx4ZyaXRa+5oQp0EltXkfzLc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D5ZsMlEivBj6PPR+/Sidg5Aegfele1XrwZZjuTEmb9A582+IMDdiFG5S5VTqtlUyFgWaVBdQjCrXsD0qn6wPcLLLCZUCVQdwZBcNAvxxK5mqDTmZfJqAk9An9o0pBeQ48TBmNFc851RihsVRo877ljOIUioLoMb3P8OaEiqeq1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gbrhf5pG; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc05DIl35zst0lauZB1Lqfe0PHxlanwtfsO/yBWNxD/JdzBlYD0TFIJWabrFMG9KuZzot7WMuOMk00csRK2JUBc2fqjm6zMA+XTKGHdH398bvyGbhiBrzA+jW+Awjn6U6f7h7Q8QlcwgtPmyH/+7kRyRvwCRpwkc+7sFpVaYYlqTDeUlIRiZhh49/0j+o+QgHF+TS0Oef6jvSAAjHSk4VvqacUVItmbgemkoC/B0h1nXn12jJiz3X0wgVSBNUXFmcL24CJOOCboLKEi450fbwg9YpDwdpBcqLrF6kVswv2rdrmFhZE+z6kv3w1P6C3m0lzWArehFAsuP+PsxPcHKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0lj7L1UzOex7lQ7QcUlPDAVRH+R8shCI1xB2WyENmI=;
 b=I70FR28C7hYdA9CuBCA6gL0aEpszN9+GjyDcNR1RB1Ur8qtZLExxd6KJFg3m+FpN/VvxyIFVxKMW1vIr7CV4r1QGoZJP8HGHXgf3+Ott8snjIHbBAJSHEMZVXABpuLT9ZdKtg98FVDqU6kepsR42TLNJNN73nc639tindRpiOc4Zg2MkCUBcHrc2bFz1EE/k+Mov6/OZnVPoOkT3NaB/PgWKYcvD/XXWf3iwV1blKFEFMmFrvOhP8Gs97vjW+JQYfEUrpftc2Zpn2qOsXXtzC6GDO/FbFJrFcbAzNvivjR1ezxDfBelPVNtVj9oI+R4zrLpQAsEb666cnz2RKbx+oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0lj7L1UzOex7lQ7QcUlPDAVRH+R8shCI1xB2WyENmI=;
 b=gbrhf5pGTL8Hy8oycb+6LRuesOZ595RXVYpPnch86NuZohMYfj5PG1T+FbR6bnad1u3rKJ1oDnEjc4H1HWAHEYqWnU6yDotxNljaWAFBjNMjMVyyWFcAuZo7micDQt0MeXtHqRtTFm8+TLaxTb2y9R8K3VtOufeSApGYOEv2hVPPiqGMvYGuRKx9CDDQmYgqMf1kvk4Ge3BFZA8MLrliF3mlQpf96u/5d6+d/PacrJcOnnBP+lEF93+KCO/c14QId5UPi3/h9zBoubrtXrVBJO7qTJpuXgnfWBOwbGlVnV6oLtgG+P3Icxpuu4paHjZ8j8+k00ueef2MX3zKrcH3HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:06:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:06:18 +0000
From: Frank Li <Frank.Li@nxp.com>
To: shawnguo2@yeah.net
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v3 1/4] arm64: dts: imx8-ss-hsio: Add PCIe and SATA support
Date: Mon, 21 Oct 2024 15:05:59 -0400
Message-Id: <20241021190602.1056492-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aaddb39-e2ec-4c90-b2d8-08dcf203717d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2p/Wqybx0Av9myHkLn+YYHsjm0YBR0EB0j4hJAucRjDmb3eFoawQsSfxVkBh?=
 =?us-ascii?Q?w90+GvWfVcBmAjQHGTLColgfYtN/MMecIMSbe3YUxpRgmMZwenR/Kt/eInuL?=
 =?us-ascii?Q?pvM0pH53K/KfUmOzcbMdUwfH2jSLvzXoQKS1VNJAt9BxYG8bpjg+OV3uUVVH?=
 =?us-ascii?Q?srcdxf+Jc8vw0iDOB4FtvHaIJ9VbBSUNqVLBvarXGH/E9SeZ+W0kW0rQT6Rj?=
 =?us-ascii?Q?w1H+RSJD2HOqAIX/UsVdCnNWuxMvIpROhv3NZ9gs/Aj/w8k9pOGbRBSh7HqK?=
 =?us-ascii?Q?QRB4InbRoP8Ha/cl/Ucl1oYC/UQ4Sexh77OaH1nrzLpkEYmk9jx4490IyZyZ?=
 =?us-ascii?Q?No/PMI2F6yIMHvIZfAjsTIbHRQMx884q3lXS5F27WbGXBC38mqVI79MAwkKq?=
 =?us-ascii?Q?2IyTfS4MZUL9SKiOgBr1865iA8APmvk4hqzrEQcSKfxdAeePNLbO8xDNUM4N?=
 =?us-ascii?Q?5tYLRszjkB90L9A9BT7PgPHyYnvHDOY5n1UfLj+0DwDHIoDJEgX9nt44xEWy?=
 =?us-ascii?Q?PPF4qN8RZtroZxtK9QQjjTd65yjARpY0kTUJFuQvCGlsuicG5mUzXzZHtwjM?=
 =?us-ascii?Q?Rj4f1FsizpRx0bFySwPyv0dmk7x+j5jhKbSPZOK9WnuJn4GC27OF9iktowje?=
 =?us-ascii?Q?GTr+Y+93Crz29QGKHdW/est2ntBVJWDSX/EpDqmlXyKk527QgiGx0g6gxiOC?=
 =?us-ascii?Q?IsSNYCWyyRNiS4YSrJeXfmGOuvUrrE52GuPD4HB/djFEcjdnNrloiMMbz+Q/?=
 =?us-ascii?Q?Ee/n5+GVlgw9Y0XkDPewD0m3Gb9iHOMCCw9mOU2e3pBzBgK4Opti67HV5X8a?=
 =?us-ascii?Q?A6nFl+kA49T66kC2ZxK0f+Fle45qYUB9+/6TRKT4AyBG6BhbuL/J20Pfplq1?=
 =?us-ascii?Q?Yh4aHJE706KnKG9sGWmAol+fx2r/+LsFWf8E92/1bv8wiIoE/n2fg6LGsjWv?=
 =?us-ascii?Q?8glgxT/FMSeY5xzROqJLLeNz4ZVoNaXMFwrNkwvpAW6teRhtN57i714HPF+a?=
 =?us-ascii?Q?U0pCcTl8Hl4OncWHQbd/wK/3k9RX9LTDJUNtI8dy0pOy7jg38IGWFWCatUjP?=
 =?us-ascii?Q?bcqgICn7WFx2idXVvR0XgAC8CnN6xn2sC1zTHEmhovkiKkApkGa4cPcBPT+r?=
 =?us-ascii?Q?TDwVTi8OfSdPx8ciswTGDsQFMvDlLZxGmcj7w1LuTwAufpGjvKKex92BM5yl?=
 =?us-ascii?Q?ymKvv5mV1IxcE6gjn3rsg/5fS130fPIhC1wvL+FBMg0r7v6Sb8qu/1gpqVIo?=
 =?us-ascii?Q?tV+VUAl/XSHfkoySzJ49Hv2ilHa6ari6MuFxmwjmRZmLu4whGxCA7QR3Ma5P?=
 =?us-ascii?Q?xoYRnWVJ3CSsH8mrfI8RqiMLR10A63pyhNoPgOoDKYo/4eViXT74UlNB+ZXz?=
 =?us-ascii?Q?wh1kc1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ArInr6+mjhdskUe6nRm1fzBN+TU875RU0KWwf2buG9Xmmx0aiU/1G+2L/Uki?=
 =?us-ascii?Q?z3l4vjLInt06r5yUdj8OlYYfnpgHrIpFIjIc/DajOGHT/e4Arep2lIaNs8DG?=
 =?us-ascii?Q?Nu0U53RPpGvL6K8hExQk3P9wf68xaCfXDlriwmYoQmD72z5iYZ9xTBSO8zm7?=
 =?us-ascii?Q?Rdt2c4JhLlNsNaeinPu4NNnTe1AMMtS7HYn+kfWmcfB35XENZz4FrJVBss/d?=
 =?us-ascii?Q?yd9tfBig1dmM1T0+CZY5MIXtTRrpe3tnZfN9k3sPrmYkZjWqMBuR+cQfk7Ju?=
 =?us-ascii?Q?Y+nM4N9ssozNkbqH1R1qZzZ8fTM5psLzkNb0d3FQE68mXGLsatY+tx6TCFzf?=
 =?us-ascii?Q?UseJxpdCNLO3vGZ7YbIwKW5JOGrBG4EeRgxBBQ/FgvLqAXbM2HOms617hSA9?=
 =?us-ascii?Q?ZO49oBLqR5xBl/TWSR1mpY8zStoz6m/MjQlXWfueqt8gEQY4TJ3+vMhAC3ia?=
 =?us-ascii?Q?gFVuWWSnSjYU3gLvgu97UiUdy0Z4cM+Xne2GsSx3cXXOFDFm0Hb9lcqZu1BU?=
 =?us-ascii?Q?GGIoGwmVue7w7XFa/rUFC3MJCue4lhTKQ29LqIul4ToLPKcJ0+gP7CrTyktt?=
 =?us-ascii?Q?+slSt7jliPMrV9fucMjV2rwhH5fpIhZmf0E3xBqRP6BWjmZntX+N9wzWV0TF?=
 =?us-ascii?Q?9ieGifDFF6MMGPD94EVqGuLe4bkNREEx5YiHtxqQD9wkp8WrYY4wjntsNLB5?=
 =?us-ascii?Q?yDNfbeF9wcyN9e0o5e3ugXZIeh95oCCv4pYvDdVwrsTabMGsHQpQbdnZdqqV?=
 =?us-ascii?Q?L0VfRbM1LD+fcZg0fi+lhVOdLHcHVe9PG3+N6KpgM0+h2gPRT3fdRq74N2C6?=
 =?us-ascii?Q?P9dQ1GVhqcfi10dypYBkI+ZS61qCdfQm0xWW2r6wrM8OKdZHA1lXlEiApKQ/?=
 =?us-ascii?Q?ZWqOK1Ln63sZWldyPjq8lWecYR3ZZynvehU7NxgAL/AylIiFUZifb5xRV4jd?=
 =?us-ascii?Q?387dKvZqwZyjFeDcJ6HEr1iCavWvrjm6vCisAyYZyQJDBtTcDeIkIBIJVw30?=
 =?us-ascii?Q?v06IMmFwpISfuroqr1bY1RrrP4gWiW7cOZZ/x2bafDObredLJYZnowbdRwYN?=
 =?us-ascii?Q?zvohR0VF3B+ZdXyFn63WZxcWG5CCRfmXfX0t20daTgrclWIp+/BnjL1nYcUC?=
 =?us-ascii?Q?Cg0Hlf63hASLO6sus1wCGI7NDvUjyySGWeqcCvfvgstteKAcFOueKyDlTncS?=
 =?us-ascii?Q?9TrPn5N9EGTb0hkFSlOOvkMcKBgBg4O5TLul1QZyswYCxR+9Lbdfe+grYKzi?=
 =?us-ascii?Q?LEZSzGJWY1XnzJkwkRyBsoIpPLg55scCgpGjfDeYNgaeuZsGEgZWQP3dT2t6?=
 =?us-ascii?Q?fYhCWqEZ9KqKQeqEhLOR0tZlDGzhUKlZLsJHepRL3zIdHnmNJbybmJKaw8hl?=
 =?us-ascii?Q?eR7YnUQF2ti91YV6ttHg2TQ+HxFp8M9qK8UFqIuLhlOFC8b/HsxfkI80JESZ?=
 =?us-ascii?Q?6Hp7hg3pdxp19UlbWR+HPauoXZhH+Ft01l4WQgnQUjEwNbZHQw2ySD+RFJiM?=
 =?us-ascii?Q?zd/+P+yP1Us62RMzhpkjmwmKp/yNBYt6mjowcpuaJL6HMFpZxtv2bIizy2Dh?=
 =?us-ascii?Q?WSRZtAjO34xmrpYYLeazMGuHmK1GAGCLqQJxIOu0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aaddb39-e2ec-4c90-b2d8-08dcf203717d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:06:18.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLQHt3y3mSpnhOc4Esfjn1QAyV6a46AUIchPkWY/g9RnUAIDzn97XSNUmVVT41fSfgVjHoQmBmWlzXpy/OPv/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

From: Richard Zhu <hongxing.zhu@nxp.com>

Add PCIe support for i.MX8QXP, i.MX8QM and i.MX8DXL.
Add SATA support for i.MX8QM, which is in hsio subsystem and is shared with
PCIe PHY.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- move fsl,max-link-speed after common property
- Add sata description at commit message.
- Fix hsio bus's range overlaps

Change from v1 to v2
- none

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
index 0000000000000..70a8aa1a67911
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
+	ranges = <0x5f000000 0x0 0x5f000000 0x01000000>,
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
+		interrupt-map = <0 0 0 1 &gic 0 105 4>,
+				 <0 0 0 2 &gic 0 106 4>,
+				 <0 0 0 3 &gic 0 107 4>,
+				 <0 0 0 4 &gic 0 108 4>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		num-lanes = <1>;
+		num-viewport = <4>;
+		power-domains = <&pd IMX_SC_R_PCIE_B>;
+		fsl,max-link-speed = <3>;
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
index 0000000000000..d24d90955c35a
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
+	ranges = <0x5f000000 0x0 0x5f000000 0x01000000>,
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
+		interrupt-map = <0 0 0 1 &gic 0 73 4>,
+				 <0 0 0 2 &gic 0 74 4>,
+				 <0 0 0 3 &gic 0 75 4>,
+				 <0 0 0 4 &gic 0 76 4>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		num-lanes = <1>;
+		num-viewport = <4>;
+		power-domains = <&pd IMX_SC_R_PCIE_A>;
+		fsl,max-link-speed = <3>;
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
+		interrupt-map = <0 0 0 1 &gic 0 105 4>,
+				 <0 0 0 2 &gic 0 106 4>,
+				 <0 0 0 3 &gic 0 107 4>,
+				 <0 0 0 4 &gic 0 108 4>;
+		interrupt-map-mask = <0 0 0 0x7>;
+		num-lanes = <1>;
+		num-viewport = <4>;
+		power-domains = <&pd IMX_SC_R_PCIE_B>;
+		fsl,max-link-speed = <3>;
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
+		phy-names = "sata-phy", "cali-phy0", "cali-phy1";
+		power-domains = <&pd IMX_SC_R_SATA_0>;
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


