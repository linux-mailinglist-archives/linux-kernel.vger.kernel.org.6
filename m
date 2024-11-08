Return-Path: <linux-kernel+bounces-399648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A54E9C0253
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF4A1F22987
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0051EBA1B;
	Thu,  7 Nov 2024 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T+3YnnSo"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D161EBA12;
	Thu,  7 Nov 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975256; cv=fail; b=IvQ1Vq5imLNJB8jZc6lB5sqpBFR7pXK+W8K0GVVQyB2z56v6cGDhpmxhxtBiXtvUpDLgN5IlRtvOAyAFK8VYkVmBm+wr2PaJ3dIOMOoiHHrOjywXTcyQPYgfkYvNqxuKsERgiwZ50ppqOPqYg1QLCVXTfnEHG014CFrBWYauMZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975256; c=relaxed/simple;
	bh=ktU68AscG4sV9dcsnDXzuUj7sUVXw5AMNiRjNe3sC1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kPb1l4A9g8FTt+3Vy0gbEegsgPRN6CglEQ/a3hSdHNkznafzRKv0yO2vaIXgqxFhJSbgR72ldmbSGU4JHl3w9UZHuJss+6uPBiDrm5LL0x/amo5yH5zV9v1RdIZzyH4LlrvDnEuTHEOiagdKlXRPtf4qaXCCp0j7D9SzUbz2bl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T+3YnnSo; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xls/Y6uSwkqGUm7RPZkgCATTtST7KS3XG+40ze+TsPlL5IxcMt0NgJgSiGgi6pnrgWFILs+G1Eo0Aer+IUXzAsjDNY4hHWN1EieeMSbGv7laEnXhAn4DN93kLJehg65MuiAeEDkg9ajPJZ8TMqWIVnmyRURE55nKEwMJuKOH+DlAP1MLMa9G6OloW4sPKgF7kwSogUC+qjawdHXV+l5LPaD7St8B4FK7Wd8Lj6BKGZDSkOjJ0J9wOo28mF7CykXV3kAFYcF2r4w8fLoG4fBNdNxjAywSLKj02xjYsHdLo1NNgnGURo08qn0gvpHOSydmUNJ3N9ede5CqfDXGIPweVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yux8Ojly9AL4uLA/CDKx2j/tPk0gBNsCS29BhcoSbss=;
 b=mQZfU6Sj1xhlX8JJHWiLnMi6R86dnvPCbHxD763TE36KW/NQgNyYG+92PfWQ/XJ/mNOse0PVTRlkmZcXHGs+nl8DCpYXiiOh1S7Ald771o5tmiPgCLQBGBIU6L3HBI+XEGKXLE7pGxQk9mghdHK4AQ28tzQQ+iMX2HShxT/+bK5qIFuCW2n4F9EJbh6qrBSaWCn35kS4MyjJ3aYeEePjVO6PEW/3jR0h3fIBUKnFFvCnnwFazmOGsOUw8NHdql7dljF2quOqOj3jNEjL/FqDjLv9/W7dwj/DFTlRFsdhPNisNekcoHo9sewZTtqFVJ4xkmOUErh6V2pvbXE5vQZkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yux8Ojly9AL4uLA/CDKx2j/tPk0gBNsCS29BhcoSbss=;
 b=T+3YnnSogl4OMv/YyhYcTIcm4Yam9r3yLn/TefHcRmcmHw817AlLMslkB/qcgc3OlzwbD6uO+w/5rzRoeq4SPc6fQ0eUp0nHEfowj7skQBLvvFY0JrKoz65PYq2MlK93EqIPdwW9cfLOS8IICfV6syfWXqqaIM1MkY7A2ikHG5qe+SnoRaAn5ia9VX0Y2dwAy3uiRAMmhuUCQnyDPuaT1pm7hkpytp6cAD8BQxcj5jvuyJngBfUlzGcM80/RixVWnQvELd3+83+YBjGUSjCWtouz36uLgpTqtbeZmqyfodXusOth9ZQPqiaODUzzD/A9zK76IvUpL5f/dgbsoWiq/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by AM9PR04MB8290.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 10:27:29 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%3]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:27:29 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de,
	marex@denx.de,
	hvilleneuve@dimonoff.com,
	peng.fan@nxp.com,
	alexander.stein@ew.tq-group.com,
	m.othacehe@gmail.com,
	mwalle@kernel.org,
	Max.Merchel@ew.tq-group.com,
	hiago.franco@toradex.com,
	tharvey@gateworks.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Subject: [PATCH 0/3] Add i.MX91 platform support
Date: Thu,  7 Nov 2024 18:27:00 -0800
Message-Id: <20241108022703.1877171-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|AM9PR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1748b183-0583-482e-c731-08dcff16c81e
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?lH4JBeCYQ6wrEYqm+rU23ylq5D0c0fuH2ok1stO0jaH4F+RuwE6arMjT0ghf?=
 =?us-ascii?Q?T/lFHSRr0VpcSKrau8+TFArIJ95b/+lV73oXCDYjf++Dl5K2E89S9zIY59YA?=
 =?us-ascii?Q?I5/PBhdNGH/SZjuIH4/b/kpupl2R1MZYJRMMDVjFW65inU3C1qtBm/26nfl2?=
 =?us-ascii?Q?Uw6VS83fSGXdKOOiD46YX+vvrdNPbNRftUsAGx9TALPZNMg6/pM+uBjW0m6r?=
 =?us-ascii?Q?gUApYnb7PpLgWMgasiIKE7UMG67PkRA+n0CXcYc0uyFiIKuerI/VirgFds84?=
 =?us-ascii?Q?fZTEVi8vJD/zLNLAaaA/Um1RBYQMhe5riU0k3WH/r4q6jzbnVtZkqE5c9D7v?=
 =?us-ascii?Q?V5q2QEQKsiybSHyX8uoDpBhbDJNpbYWWz7zc4mO4ZUolICGWsPy8H6W9icDY?=
 =?us-ascii?Q?JMI2fyjwXelUckd8aEQpxBqHL1XA2qnCgKr03FF+SGLeqM7lvboytPlX4cdG?=
 =?us-ascii?Q?dygSlwfhsEqZ5I4j53l1pj4ph+rDChLFN/TtDKvGvT+YuXQ7LGMHho+coakH?=
 =?us-ascii?Q?fo0RVAEVdE2XcJ/h8k9g701CVe+3RHAvggj96dn+tGhIYo9VpKUoA0hd2Tec?=
 =?us-ascii?Q?8PcpFkRG8vNpfBjxkjLNMLy0pHpSOmKaV3pHPXGk3jtKS9tNBFSoj8tlzcEP?=
 =?us-ascii?Q?DLmL6DN3Mpx1/A48T8qCuSH4ud/tg4CFHUnG0xexVH0v9W5tjq7/entMb/ZQ?=
 =?us-ascii?Q?kT0YqrTYpv2DEZtWto3ngbth2Exjd1gnkoRbz+eRbk/LBFxnkrxjwscZULnk?=
 =?us-ascii?Q?7C4GjWgXsXH52ZAZCIQsoysfy/Y7qBGXbjeMj80Rt3Qm4xEfkqzCm0YM6DCh?=
 =?us-ascii?Q?N6QZx0iFT9kzHd0Y6AYIqk5UjWbnr7wg7kdGJRX7HZ1w+PlXcZTdhbRoYb6m?=
 =?us-ascii?Q?T5c3JPc5YD7hnnTOy0kYCmitKcduGK28iUokan8hdbKDIvAzZygQencVXL22?=
 =?us-ascii?Q?/IrWbgBtdsDbPxU3LXeWHtSWtM9fSqUizJyO47Mo5s2+zSxfOVQtMAjdrBZ3?=
 =?us-ascii?Q?PQM7uHsGxdvSqUwzCXh0OiRqJUXd2aQl+VxrevpkBHNfqe4GKXnLp5iOpgC1?=
 =?us-ascii?Q?VUhr/PE7/peVKCYKLDNgGs9hYhBRQVKFrczGrbdlSUbNvnTMuCGdUUoFQTkh?=
 =?us-ascii?Q?9MXUlZ+F56JHY/Q9hSQCBWXd6VZBXvg/jafEPkY7eqaqPxf9JBt9kzwKAl/i?=
 =?us-ascii?Q?NgMnxgMUUazSurapsqjecorI2kRs5bb0pnZyEKchO9ynqIE6uPYvWSAVqIwp?=
 =?us-ascii?Q?7eIOa2hzy6+o28hRRXrCgCdIypB1yWIsnA9T7Dh5cpCzgMWadS32mtfcnMTQ?=
 =?us-ascii?Q?ZKLA13IEYRFixRy7H1jUr+mbYo9TfVwqdoKGb7d08ssng3nDpV4I6pIYFS1P?=
 =?us-ascii?Q?ybriAko=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Y045J9dYz/o1j6Bn4fjctcn2WGmiOkrE/Nks+lrDMR/WtetSriHc9hhXbeQE?=
 =?us-ascii?Q?lUPSdV3vcbD5Dl0UzQggmD8g7zzLkx+hEgyPk6tNhCnORcRKjfK+NyUzxmOu?=
 =?us-ascii?Q?0s0brrCe2wooeN357WWa2piilVvvHDg21DN0YTp+WJFC4gHV2/p0p5bB8cFa?=
 =?us-ascii?Q?zykd+tX+p/+QUH5UZ9RDkhWjKT5ywWPYikExnP6aVXLXNzF4m+Vr4daxe3lh?=
 =?us-ascii?Q?8UpD5foWmdQdjMftYERhuoJffbkLKyhFyQbm2GKdqQdrYY2uZmikneWaqvVm?=
 =?us-ascii?Q?gz77CDT24WjiGZBbMPaVWNbll9JYnol5KWCZt3vv1zA/OfqgJrWrz1vgAdT9?=
 =?us-ascii?Q?Xt0JjmbPARqvvM8nAvSBVcMZmpQiWESzCqQQH45C1hskgqCsbrT8VJdMq/a+?=
 =?us-ascii?Q?9m31mrDqun8bSfgGZdHRiLI3+Hp3d/Vfa0H/XVqgnC/Hhz/W9IZSKrbDduRA?=
 =?us-ascii?Q?Ll3zI/Ke4hepGwGPdZMXnJBGDaIVkI1EMwWV9r1F2l3fAULSWQ+awJDm4WJL?=
 =?us-ascii?Q?VLNRi8G/BwdewU7B/5Um4TuqDyYf63Hn5LbmjbDkzAHVYnciPTIBZ+2/pP0C?=
 =?us-ascii?Q?tT0x2IrGSdEOlibdCn8rgRmQAw9aIFbe7Z8pMp8M+kgHnz7hNVlU3ulEMF3f?=
 =?us-ascii?Q?88LH2RDfnii0WyWpNB40KwhjQPEdK8uZPXQKUnFkEPQr1hZo/lLqz+OdEXaj?=
 =?us-ascii?Q?5sYFwjBuVqpI6De3gES4VO8hB2e1cnCuqJ+RYpP4jkpQonrBtBCKT+AdDtpb?=
 =?us-ascii?Q?72bv168tSPD7v9xOVxnfot0JC/P4ngqJn2vNAg2wqHZHxU/z8hK1a/2lNxZu?=
 =?us-ascii?Q?fkRKW4xff8qP4+uFVZiqemXlpugrRu9zcblm9bjBE9MZkuw09ABkXM4kVog6?=
 =?us-ascii?Q?B7ZQk5v7x0d75E9JOpnBtXZDx6foa5y2T2gVKfcdajY465c7ELyJ7TEhUoXW?=
 =?us-ascii?Q?GHBELdTRYLldpb3gqtHf5haNkXddVZaojpqd0p0wC6NIAmErom40Eu0703C/?=
 =?us-ascii?Q?zzgaXvZoCHSNvkCChSvvnmgto8fquRXK3tc36bBx87cWrPYQnOqH3U8VKcxx?=
 =?us-ascii?Q?MtrK11eEWsjJGPUKRoE/YDTZqFsp8bQjZj8mgXR/xJgDfZOmzyCmzi2OgDGe?=
 =?us-ascii?Q?N7ONHREvehgTnNm0PYZ5MFJ24P/bpRX1BOM3uB5aSLl3Wbh4kjMq4BU8bZ9V?=
 =?us-ascii?Q?1iyrM4q4ALQYhcbZlTg+LZ+v0+Lgg+h6C9umbMDQq87rLMvN/6rnJ1gBNjVL?=
 =?us-ascii?Q?Bo9xYJw3fRoNC1BhovIfuk9J9In+sSCTCMAYH90/XD8pH4hu+UEQFmpAa7VO?=
 =?us-ascii?Q?LEUchYcPbWzQtgchLxf5svTTlkgJQuAll1W/yx1n7y+BF/Xx57kh3+IOKkZY?=
 =?us-ascii?Q?aY4AnHUNTkQYM2zLMp7QLJJAlnjusxokSJqWFZBzUWWUzAaf/4dLTUsFuZ33?=
 =?us-ascii?Q?67i+0T7ocFxyUpwKsUUEaQsPbwc6B2KUG5uXDTaZE0Ms2pOEtix9hoOv6Bfv?=
 =?us-ascii?Q?GYlkTSID9oOrqcYPQnm63MpEj8zTzWMmditYV1cT34ebYdR37wiLGPpW8nyf?=
 =?us-ascii?Q?2WfcQAnv2q+MEIbMBzK4HMiU7U3WWe5REGVfLGvV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748b183-0583-482e-c731-08dcff16c81e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 10:27:29.5166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1L70/wmzXj2Uq7jndhY0qr+7MtMezmMREYPzqjMeHKUssle3EkiPQQhj+rMl5VgxvngnepxMOjSOqzPuTDpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8290

The design of the i.MX91 platform is very similar to i.MX93.
The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core

Therefore, i.MX91 can reuse i.MX93 dtsi.

Pengfei Li (3):
  dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
  arm64: dts: freescale: Add i.MX91 dtsi support
  arm64: dts: freescale: Add i.MX91 11x11 EVK basic support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 820 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
 5 files changed, 1663 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi

-- 
2.34.1


