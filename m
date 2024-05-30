Return-Path: <linux-kernel+bounces-193957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C918D348D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02351F254A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1717B42A;
	Wed, 29 May 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pbm5lJ3R"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF373475;
	Wed, 29 May 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978630; cv=fail; b=JIt/lg5hAvVoUBh33HIpNXMYzeHrxdakmOmEYgr/rWtDGSPnpwMuBMtb2UPlKM+i9XeuVdW/veecMHMEmoIm/SG8l/NYGb62hrpOZ6tV+TP9c6yPQNK979rhhvwZH49JaQvraTbiOKmcWyDzuPQlvaGQO/D4koV+axpSNRiYJpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978630; c=relaxed/simple;
	bh=sL52OjcMsJmrTZlFopYxDZ/44kSD0doQMZcKxwnyh1A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H0IqbNHGFu7bMFK6MckYAzrfoJbSU4Gx5vo726N02rj3cv2bC5xUYkiAcrz3IhCqj9zLvtVvoOu9jmYgNnptW69O1xIyZCausir6GQ3iMNGCftpA1QGlqfXcQ9BpRQ+LVDwDQDJbgMqVgzcWX0Ca83dzZ0IpW4FgYkZjPk5+tx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pbm5lJ3R; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGvulrbPa134a4rpwlO8nSnI/3He0+nOKLlOf/I5BBzpyqVenUCVXaAbhWAP1KLKnqvRO55wseR/sBLtqF0lXg0KYpSvRKAkn/rYSwldF+KLWpGDORI9a+Ce1M1kD0PcgpI04kb2iB4cnWj29+fFf5/qjmvygRbvTtjrjehyWmnrcind6BFGEDDBaZnB5VZg2KIOSqSTPP93x+MUWjmu1s7ozjXWjcWJKP488j+bjbjVeykDmvTju/oCgcpIb6ViXzIBQARqRjSf8L2huX6nUB8B/5krlr2+2BZd13JKG7oQsuAINiNCLdO3mMmM/1ATdw8D1PpOB/V83D7MLUQTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVhEFBdpzNyxQ3N/WZMtMRmKamoUNMfEnCFGlV6ZoB0=;
 b=FBSjsba+K/VwIC6YC3CgezkjocLriLv7gBDxCJvhCr5bCinLc7xLvtxnPztj0Y3e8p/dOlhMzxXkRz/DhmG8dgFYjcqirGzU4q17pPQfBBPjGZv/Vgzt346A89TuuQnthbkqk2p01tEorJxIl7ietx2hxmY5t8xtdUQdwl/sYeNYnDl41IQYgjOcWF4C08tqJJmGDWErFFQ/Wz7sZrrOrU37gZdhnkY3ZeCorn7Rfxr5UIzgk27ate2Q7h9oYOon4wxSk7z/IVgzqWAyzi6YhjfjTLWtJ/dbEgrsWpUBFT52zYJioEf8K1q+Zl9jMKS1UKooEtsNlNWTMdCeYnNeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVhEFBdpzNyxQ3N/WZMtMRmKamoUNMfEnCFGlV6ZoB0=;
 b=Pbm5lJ3ReF3N0cPiPg/2o8yP2vre51cd2Ezs0ujmpD2Yf0+3ZjZLYjDVb01Am0DBzzYLvWb0OS1EetKYT6WpkxVz8zKZw9XOxAGzBJE4+41MzjvPts57BZgiLiabvbc0S1f5QaepaelmemJTaI6pxRidkCS56hf7Ba5KtXtBiPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:30:25 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 10:30:24 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: tharvey@gateworks.com,
	alexander.stein@ew.tq-group.com,
	gregor.herburger@ew.tq-group.com,
	hiago.franco@toradex.com,
	joao.goncalves@toradex.com,
	hvilleneuve@dimonoff.com,
	Markus.Niebel@ew.tq-group.com,
	m.felsch@pengutronix.de,
	m.othacehe@gmail.com,
	bhelgaas@google.com,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	pengfei.li_1@nxp.com
Subject: [PATCH v2 0/5] arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
Date: Wed, 29 May 2024 19:26:29 -0700
Message-Id: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: c67e492b-1880-4617-b7a4-08dc7fca59b9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|52116005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?TIZtgKtL1pgKbCFkPGFt5Q1YzCGU9aRp7PxIb3Tioj05Ef7OJd483T4KerhN?=
 =?us-ascii?Q?aNlMy34RQTZUWNATq15UwXrzatlD/7IeZ/i6PYVDOIFSUulWuDNGX8i1tfFo?=
 =?us-ascii?Q?zjmH4ssxuPOY6ZlEP6KWI0PymUO3Gxmajk62SFWh+DivViQ28Cw6tDQX56b7?=
 =?us-ascii?Q?JW77CvtXdLkLV9zJDJf1OillRwUOmogTasAJ5MF3Trr6Q1NwkfvvRJxGoAZ1?=
 =?us-ascii?Q?qVcYMgwDQuBMyAyMqNxUdUBANSPIabetVV7JqhCybm10GzLRjq4oBC9o4me6?=
 =?us-ascii?Q?6sL2kG5mRBkW6V293jYsZx8m1OBOjqgicQIZ/SKJnmgUAQRfXCQj/dmdLT1o?=
 =?us-ascii?Q?ZAspavTprmcL3edNkI+pJREYlR9iNBu2rQg4751wTtA9CpST10r4HfRVf8d+?=
 =?us-ascii?Q?rjk5ppZOLT2KGt1oMjqv0HHyEUJYCBB9Lqjd9tVB3DOdbvsQ+p4UHsV82o9m?=
 =?us-ascii?Q?H/61SW3xfDZxk/jQN+wfsZDoGqxcttwIbQfxqiam07400JZP/o6N7wvUTr6+?=
 =?us-ascii?Q?2leArj70P2K4b+ow+mcEa8GkX4yQLttom5OgNBegLiAwBVx3GpSzrFaLRVwn?=
 =?us-ascii?Q?HKQdIcFI6CgSx8YvtMqGOcfMdcn3RwhZ3DtLhh5lByW6l1KieZiUr3GS4vBy?=
 =?us-ascii?Q?88WGPKHLRrFAQ8v2gWcqRO7a1OsvvMPcNviE5BgyK8/3olNCHSzwub9yYkgH?=
 =?us-ascii?Q?asMLGTndBpK3lfD+EgUIXrFO23+2VgK2rHw+w8QhnFvmgkBJ7amGAJwrsyUu?=
 =?us-ascii?Q?IiRSJO8Mt9qSncFtVee+CDNSxvTjLyqfuP819q/DHPE+kVvsmbNvXjeKWTkd?=
 =?us-ascii?Q?BQj0RGCf1XY1Nyu8W/bpM39/3U+WxLu5iOZlY6FgZeWEoeunFrylC6syWP6r?=
 =?us-ascii?Q?Kf8xOnhwjywpn/7L3h+34ZbVRK7Oze1xfEDQooZCz5WFfQBQ4j4WivPAu/Zg?=
 =?us-ascii?Q?XSx9DtV6hEhVhZ+bUjy4kiezbwvnJQiL9BPCq7VKUMDC13ndKjTLX43hfnd2?=
 =?us-ascii?Q?ZqnRtUFoy5XaFiHtvihtiOrPw87bYar43Xqb2v2YnNh//J36x2ASWskn9FRN?=
 =?us-ascii?Q?C86kc4RfjRlDWK4XaOyinleekDUrkjem9pmVpAaNkzarE8qC/g1QCWZlWnCh?=
 =?us-ascii?Q?bt8QOoH9ZAWQsnq3l9B57pOl3xsEGOHWTATSTL7VulcbSExL9HpN6oAIZ4e3?=
 =?us-ascii?Q?VbBpkpVV2MG4lwZfM2QgDqbZEYqBCi6OOrFT1aTTspSrXac43TK4lHe44V5v?=
 =?us-ascii?Q?SvsjkawjRbPErJv5GwDzpEiB94fi8oexvi/iS4Dq5+L2NV1XIok44xB5JC8L?=
 =?us-ascii?Q?cAw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?BwTFUpJojmqeQf50BCFUrzzibISkXcFroY6ZuGaTZduT1VGPMas0ws2qeVYK?=
 =?us-ascii?Q?z1Af4t4yx+sf0Z3Mh7HRQRc8kmQhTXzFUFF22UTih0w0PnzsPA5QyFiEaP8V?=
 =?us-ascii?Q?NmEOJeSQQ1NITu3cBE6TT5DP3tK/oICUfLTZXApsvVkru0uLFy3JH9tswCrn?=
 =?us-ascii?Q?2zoh6fypejbA9lESp5yj037dOfMUvz0FAvuFCNv+tI4FabySO/41ZzIN/9Vs?=
 =?us-ascii?Q?F/3QhPQizajG7Cjf6EcfOpRsVNzS+3EhGLLNruXitWG9sTpYwcpD9c1TXy/K?=
 =?us-ascii?Q?h9NyFrQEqDhfKFbYXrqN2TaHtTeNsz5YVgzoEJWoRuruiUhBCOy/48W5pYzW?=
 =?us-ascii?Q?INNaUwCpEMsYivEeskAx9vTiOe+k65GFzKtxA4ERXXlqeUbYa3cseWTV0AXm?=
 =?us-ascii?Q?X1sZuhVzzOuscS4ng5jNWIskxLEbwgSuDiKMBob6uEZeozqiquFvjvIBMrh4?=
 =?us-ascii?Q?pEh899cxedJ1jE7UAirSlB5petHOg5cPeUe51OL8rL8ZqkE08wbRjN9jcelQ?=
 =?us-ascii?Q?luUVn38+rdWWElGEhL+5e/dRK86xPaCcLwUhE7Ok58WQcyCYQZr7eFrKvIrO?=
 =?us-ascii?Q?9bhzIbBYxtQWY0gqdhJHLWJxhRDoFQgr7eBAKp5qgHz3ZCtk2VND4/gVlr7k?=
 =?us-ascii?Q?3pxlWjWX2IvCxpf1j/buZuMD+cHo0ZBJUPisw6iwEPbbJ5pR7bzB6hqDOGI+?=
 =?us-ascii?Q?aWPQRW2p/E5Ao7D2/tI+b/a+pkSWuJFwMOTTPst+Qja35a7k8WD4wlNhmma5?=
 =?us-ascii?Q?plcz3AjkcEMkukR5Qi/WxV8n3pMiGofySI9OX7WqmJxGueCfIAVjgRzg6pwD?=
 =?us-ascii?Q?iCsXyXLkyddZ2wlVD8C+Qj7ZK1GPpDOwNb3ywW8D1GBjZq1MfGmhHkVVjAn5?=
 =?us-ascii?Q?N5+eCLGvmok5SLo7cB0NcTkcYwjFKu2JCOI27ymqSSxgryqwok/c2dYqiS1i?=
 =?us-ascii?Q?PzDyi+enSvkhVI7kzPjzZrIf+7s9vgKOrgXT9itFuge2+K5LHuEB5OcngCnK?=
 =?us-ascii?Q?c7/QiGVz9tmtGOatJ3gz5M7rMk7ZwLHwCi619M/dMwU/TQxa6/dxdwd+pEnp?=
 =?us-ascii?Q?iHjPivs/mz/vcKKD+zn7wl3GZvJWPmUhjdHsdAGc4O/mLN2tQojK3rEjVGUu?=
 =?us-ascii?Q?fvmSc6JPcbKVyvhUV77cBMMvlAmeYbQlarnCA9pCNi5w7/EXglr2AcAux9gN?=
 =?us-ascii?Q?Q4gDUjk3UTmzoUQMOCm0MqISqD/g5GAfc3j7loxJNnOR5rTbh71v4Pu2DhC+?=
 =?us-ascii?Q?rU4RK0sAzRBsj6F8izD2fyBO9FtJCNVBWNQrXzgCwflYXMO1Ti5xiTY9kaq+?=
 =?us-ascii?Q?SuN6bSjpb45aiZ4vbQn9ZBy3XmCBToreBfD9TDWGBPJ0U4W+jYSvTGZkSbVj?=
 =?us-ascii?Q?D5vFN7MMUAZSTb3AMStk6dMksdi3JjfdxlHbyE2FSCLEbQFWlUaSEajj/VFc?=
 =?us-ascii?Q?tIjiQas3lp+OQ7vAbhiczuUP+WhC3BuSDtRVd02difoQ+jCam8VjW0yOiY4s?=
 =?us-ascii?Q?5n9cxX4ru4o0WjeDcG+GOexKQCPsISYwP7nkpK6NfZXWeRzlFUxDbNwVgNb0?=
 =?us-ascii?Q?SzNrlSZ4A/wDdqYUZqGSL7pUfnS1/INejG3wNZyS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c67e492b-1880-4617-b7a4-08dc7fca59b9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:30:24.9242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7NlmhsfP4yKqdNKFORW4b5wY9P986IjLkhvuX7eiRQbZ/vyYoYrn2U1nYdYjkBC7RRjm7j1nUxlJ6k6eX4EEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

The design of the i.MX91 platform is very similar to i.MX93.
The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core

Therefore, i.MX91 can reuse i.MX93 dtsi.

---
Change for v2:
- refine the commit msg to list all enabled modules and supplement the differences between i.MX91 and i.MX93.
- fix imx91-11x11-evk.dts dtbs_check warning
- link to v1: https://lore.kernel.org/all/20240527235158.1037971-1-pengfei.li_1@nxp.com/

Pengfei Li (5):
  dt-bindings: clock: Add i.MX91 clock support
  dt-bindings: clock: Add i.MX91 clock definition
  arm64: dts: freescale: Add i.MX91 dtsi support
  dt-bindings: arm: fsl: Add i.MX91 11x11 evk board
  arm64: dts: freescale: Add i.MX91 11x11 EVK basic support

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../bindings/clock/imx93-clock.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 820 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
 include/dt-bindings/clock/imx93-clock.h       |   7 +-
 7 files changed, 1670 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi

-- 
2.34.1


