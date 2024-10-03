Return-Path: <linux-kernel+bounces-349428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5AE98F5E4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF7B2828B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237CC1AAE11;
	Thu,  3 Oct 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZUlorhN"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E0224EA;
	Thu,  3 Oct 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979366; cv=fail; b=KH/9WFqE0zfJtlh8DwUMheex0mC3SZOAwUjHFLTWEXGk1Q1ND4mXq+9cC4OX/gTjhOv1NyEDXQFPGY9EnebJrASzRWUtA7gOLmwaoGzKmICqxwVw/eVOpH6RCPhbYm3UPmuVzniQCU0kwdLkAruS8ijkZa4UJTvZzKfssMu/Kj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979366; c=relaxed/simple;
	bh=rGY+3z6jFloVHCk5fNYs6SCw1cRu1gBiAsZI8v/0EI4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FPiLF+MlBZ+B8QHK8ox32FDIlgRPBDQaxBF9gl28SKCmcTGO6mK/sgSo1+5OCR/j74+331hZ9HlaAD4ibhifmn8g5rJxYml7jkA2keRW6FxN0pQIAyukFve9VN5M9FJKzwWOCqdkFpS3Rqp+UTsQNuIIDK3dm/cB4qnjrk2EK1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZUlorhN; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/fjF700fQcRLG7A6L340CTLujZjHcxHIxiyRpnznEBl/DAJznGsbxAW9kJUuITFGz/bH5PbadtZ6VHH5dUHm3vLFthUS7Cpz55eox8c3RRmfj8+LMl+v5ea7wvQJ1fkfnEGhRY0DFy5TAZkR910QuK4qnZ9NKBMpnhhuaCwaHAFsehwnydURBLKT8YiDwAfyRPFnRokkBtJIgS/wFH2jn0Sk8wAUUzv1xjwJOag+vmJNcx14glM6O5kFJxUt6lCUJplqWfRSSm3BVfsct6fWDffXWAF05FRWK6d4OTxD9/0IDeE1buerTu+P5YQc3fAwpT1Ukxjq9Y5WIBzZM5TGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otJX/mdx8jk1/7TFcF6TX17yGDYgpbkQQWGRIi9ynqw=;
 b=XCU4G2+g6UvzzWitnCbm8P0nL/ZwPj+xP8HTGY/0QWScq6sKrU8N2f+sajrQ+Mm4XoF58qW2FOVL4WFuDuatDNn+UQAOBhNRORmbStqBBozAMGDl3W1HTkRlLUXLsr7ywqhudwLx16d1VRSt8g5jJGNFw+eSR2vdWFgP7cJEPe2HPfHpSp1Kjavw5MGIfxCdaRhD7rwLndCw+GJW8dK+Y8H/aWtXNs2Ft6Mi7E8PaLF1stWhAQZ9A++MaVtSJE4lVQUjz02evNyjSm16fENn1C8gdIwLnO2pwRvFOEK6P/RMOCSaprshrPgu4DTup5/cnSeJGqTkpVw3waYqmEQ4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otJX/mdx8jk1/7TFcF6TX17yGDYgpbkQQWGRIi9ynqw=;
 b=AZUlorhNm/u+dE7AvFrR0nS3P0fJ65s04KDCC0xWfGbgYvhBUc5QTWw4Ys4XphP/efvaRRteyTsSD23LuZcriZNv4ZEkRnmZ32LjE+owOVBnc/Erv5GkuTjA5GVj10f11flT2RyBGW+xKbxv0EIG239z7epFUCcCACqgX2J4qzgPTDcR4lqZJJ/WgzknZ7dVPtU6w35G/i1Bub4+/vUDGrenwnZAzUK9B8P7wPxPjqX05aCBjTE41lrDrpb92IPHjmnforIvJ6XCIVqsa2D6KeEZ8aF0qT6IeAYDMO/f/PL2a9r+igqHNsPcy4UXNTJ3c4pL/GYx06Sfhu2fOnt0Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 3 Oct
 2024 18:16:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 18:16:00 +0000
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
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/4] arm64: dts: imx8-ss-hsio: Add PCIe support
Date: Thu,  3 Oct 2024 14:15:37 -0400
Message-Id: <20241003181542.620461-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f4a227-7629-4020-b6d9-08dce3d76ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E/HXdS9y1VYoWh1yAOv3q90MuX/sgGGNdS6+K0E5IwTIn9Y2nhfarIt+M2eU?=
 =?us-ascii?Q?E7xs7+NVYb4HFVyI6Ai8o3qxd072GKK73xOXzoNo/pTRg6Chtkgx5sEvy2ys?=
 =?us-ascii?Q?21wJjjrPva6/ZfvADjhdCDFiu9+dNsocy8bxSpCPhCI4VRgXWOtsIB1V9GeA?=
 =?us-ascii?Q?QJ1ju/TampwiFnFLLzfCKcvLld9OtQZ3kYE6ShYRZ1d0d+0opoVozyq9PSsj?=
 =?us-ascii?Q?XEuge78Ezb/c0Nlcqb8tuxEmTEPEtYVxBebm6GzX/ihxB4oHBJUxuRYqyJg1?=
 =?us-ascii?Q?3MJ6EQrziwHmLRDvekVt52ry82xUHb5vf0s0rUmtjwEXVBrBbTh+U+XuRtrc?=
 =?us-ascii?Q?VeqdyAgW1Sldlbgxu29uXL6hWfgeVqiSuyKrFlq/u29KoUpYO5Pg0hYIte+I?=
 =?us-ascii?Q?0wBLXj884bhDSir8yjfW3juPWr3cmQmp1O2PgM3OkBTpNbyyxV5GXpA2/ZWO?=
 =?us-ascii?Q?C5yosWJEBxXA+KturodO2aapgom5oWa5+ptUG1S7iB3DMhOg5D85RIkj/h/R?=
 =?us-ascii?Q?bfmdGf3pLuqHrt/Dt6KrFE6X5rmKbESNL4ul+XuLgWYK2HF7bdf4Fj77oqfN?=
 =?us-ascii?Q?ZdJbfvNez0ukhHfKPosgEnYGkEpfZ94e1dqZkHt159pkXelSXMSQhN8eITL3?=
 =?us-ascii?Q?2z4BwUHdVtG2VA0H2Zu8QKy3IALZagEvTbwePpuseaVGECAvrBwR4aQRpEp3?=
 =?us-ascii?Q?AJPw1RvPQyuP1oFbksmirvxzym2nLyr/Z9aDgqbEk+0VILDIu0Xqdn68oVIq?=
 =?us-ascii?Q?PL/YRNAjEXzfQSYToDxhMgqKGQy5MRrYriXu6QptaxYqAPyJAmisjsvj+Gaz?=
 =?us-ascii?Q?sexqlPjHIRKeXQGZ/sH/KOkgtPdzxVYb+DclJGwOgCRBiiRcrK+YacCUPtWe?=
 =?us-ascii?Q?ZT1/f5u4I8Wg6EaC1fTyyqUiY5nWiSGtXx7uy9UwcUkDdM4OevtCPPG1peWW?=
 =?us-ascii?Q?njcHbWOrzCz7V773aGEze8AorZqqrSEKjig2pZdTKyMVUdBOu3OO2uku3SV2?=
 =?us-ascii?Q?frPMVmZxq/0ELFwznkIos8Zil3faMLuZA4i+UZAiRAZkwpOllGrKig7tyX3a?=
 =?us-ascii?Q?QL2lgoEVEo9lp8vqoT2Vmxo2atGO+FA7n7zBOCO1m7i5a+j8P9BfECu291jr?=
 =?us-ascii?Q?7xngcpdysnuG2kx/mdt4e2AFF8F1jQZxqDwNVM4BU9IaudPoNykP9lI4qpQX?=
 =?us-ascii?Q?/bfabb0PezvhlWkXjmFoe6EUXt+moyvTgKnqjunsf5qhcID4Pqw4XSSKia4Y?=
 =?us-ascii?Q?FJA3H2RkKQxDYpF2UpTCsLqxAW6lFhlKMhL1d2XMFx/62wfBr2ZMMgG7oriK?=
 =?us-ascii?Q?kzbSSkdscYPue49uGHRU8OQT99e9LgpGK7ifXDhWP7zMyIu1IHaXlXHF5rql?=
 =?us-ascii?Q?GHKl4oo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p/oFYbFYCb3Gi2gRlhPLiIEPZL9N+hQex48ypDe+8VnWubpfNNPaKFzqPyDX?=
 =?us-ascii?Q?RKpmxVh2MyRDAKyGNDNzCWRY9Cm8e6crenMt0ompK3z7hUV0jy++f8ZwOXC0?=
 =?us-ascii?Q?MkMFLnk3013z9LYQzlnIolzGoly6Fj7vYW0iPaRNecw3Hd/4d4/sSgBrMnE4?=
 =?us-ascii?Q?KvDbuzQ6Y4cRPOFT7AwEU6L/hEJjt5difkO1bAxLMMcPi1TyutWuYLL1Lulv?=
 =?us-ascii?Q?jrfn4BcSpBpHAOFL/mzeQGAJ/V0FR0ybgLhNOI8AvlcPJHnnvhzYPEDWfitO?=
 =?us-ascii?Q?Pw5csH29CV3gX4NfXF/1kOIEk3eyerAWR7tptPE2hbO1lJFwahCh/xSCK8VF?=
 =?us-ascii?Q?ZFth1RePIDGGu/tus5rkYcvqqQkIYHwEB3xwGw104y2e9e3TZWrg0aec0/xy?=
 =?us-ascii?Q?5YpBCJ8170VWa0tTjNCWZaEjVsHzSOvX4HnNUnZ5+gCvVZqV6l+uArKC2XoT?=
 =?us-ascii?Q?KH6lkIv7U1uiMz9e0o2HMaeOFZX1+/tgO7ixi0GEIMgME0WeydAYDyFzkBMj?=
 =?us-ascii?Q?Tj5kBkbUS76yYhiM5BVe3ScTbhvhTfWiPU31P526JCOQZE9Dcgf/FcockiF4?=
 =?us-ascii?Q?vGxdH6BIUGNfVF9i78co2/t6MyxKImSbJFyqRcKIcfe6KsPhKQa/f7gmWDb4?=
 =?us-ascii?Q?TM4IOmcW9Bgm2v+qYhlUU4F6mj+aiFyaBOUNEuFnad0B1bpJjGKuIp2Q8CJL?=
 =?us-ascii?Q?yKQFLt0OWatPM9xrWGkfQfypuY4f5iiehRxC6b1mdSOwaxNDX5Gdv6SX7ims?=
 =?us-ascii?Q?txp02EYGPhpPjyHg2w79tpAkGIz1u4Ldhi4xqTYXpy2WlsUn2H6M7Gb9eugf?=
 =?us-ascii?Q?rk+vtcMJyLR+3+SN7czZ3Dfti06/9j0i7UsrJvqSMS9TqEb12wDtfx8zpHQB?=
 =?us-ascii?Q?NGEba3MGFwaye8CD+UDqgiSlsAJQ5n+0YLYIuGebUO3weOZ4JEpsUfqlS3XD?=
 =?us-ascii?Q?pRKy9GbiVZJdr+LjHQ7E4wcm85gU0dFIcJjlAcJ4qvA7MIqJwaZi0XaEQ93b?=
 =?us-ascii?Q?iAqjRQrqI3PdENRRHAKq3Ftq3MOEQc+zpLFkeUosi/u/GHXT9lCYaWdICQIT?=
 =?us-ascii?Q?72+M6ZhFL/bo3V1KXOACkIJVI1oySGrPibyLbaEaqauslubJ2jY9RqiN5NJn?=
 =?us-ascii?Q?fc+TNfKSATFHOQ+Fizcqd42jLXd3xH8rUmReZa+DgIFmF7BJ8T6hXhL/dADt?=
 =?us-ascii?Q?BIRJxnJdiht8YixdEs0BhKXRlaH0sq2CZAJ+to1K98ZrlYtQAUMpDwHKKBzZ?=
 =?us-ascii?Q?zIfFxbOgXUq9kU4IZwgJ0m6GqaeCnTSlFUOvpxflWN2Xi7cRy1IeUiIhFyJm?=
 =?us-ascii?Q?PQehtF0oGQMUQI60hD9kJxDI6QvBQxo6vazon8VAPOcEdFUlFvjqq0oo9rrT?=
 =?us-ascii?Q?CsHz9mJerlEDMWU/fucsYP242jeR+1P5JOYEzQ9iiBbOIdl4RECVNEh1pcv5?=
 =?us-ascii?Q?8gtlk8I7wpyRwY0IWlrrr/kwukf+b3j7FP/d8+C9VGbDh5DU5dd+dIjIKD9o?=
 =?us-ascii?Q?zq16Mu3A31Qw4CGVXTnmvepm4QqqQdFgYaR9w2bp8EHgBSOs/0Gz0+eu9LDF?=
 =?us-ascii?Q?nXuwJBu/lXxr+LcJBGKXjhKnbCaYJrko7xPk9vSb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f4a227-7629-4020-b6d9-08dce3d76ee4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 18:16:00.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUQzmkuvoHHHlovr5fNwFKl75J4C1ltQin5wJ4GNDRF8v6jL2I4qZrVUzw3duy1fo06yozvyxBe/FeCHW+Myxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

From: Richard Zhu <hongxing.zhu@nxp.com>

Add PCIe support for i.MX8QXP, i.MX8QM and i.MX8DXL.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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


