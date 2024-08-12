Return-Path: <linux-kernel+bounces-283691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0A94F7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0371C210AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E43192B69;
	Mon, 12 Aug 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGd2LK5x"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45F2F2C;
	Mon, 12 Aug 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492938; cv=fail; b=sKZzcuY60cw6Y4Uor21bATl7Oppm/5MQPyFiTaiComw4B8AuTvrOGxnj5MFdRgLrlqwjtKFWqQyLfbM+bz3VpVNTdvGVh9w5iVPRaPq4ABs2HyTh5vajWBMZY+1Vpemv+6OjewwlHCKno3Jo+4Ij1UdAClIfNlCmUkuVJ2iJfbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492938; c=relaxed/simple;
	bh=5xfxtyegvkkMxl9PZIM2QFNOVCYueK1GeA/dNqCdZlY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u5ArZaQ8HZx/C4NECAjfvmMh1x5wSPqqFaBh4JRuIRvQocSEogbUS++FcjFwSJffWabIdXIjqGWG4TzKK9wa/fRflfJvOnzsd6RiYE9Vj+QJw+1tlqeQgtcAedeqBja+nT50bTxXkqCTLQErQPoxNgTVBq0DmIaMFB2kba3z1Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZGd2LK5x; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+4gsV4JPR3fyoA3ShvdwbNaXaSfD+Xo2HyJbnMB9Xhnfsy/Q50yIUk8d3/g3TcHe4hHwa8Dsi3+Nu9eYCRGHmLR8XVKfYJSAg/oePJ3TKnP7syiIhnHBux3VXCmskJt6pWN7FtuYlS4P1yHJ7jigvEtmnbNNl5DYvH95pb3Ba9QzxRx9fQigJU+gOW40LxyRhA6Rwm0ZJlcKQBTIbWgFjzvo/J0jFRQokWc8j4dBWxqYdtPlZGK0KJKmwxelF3cuObufnr2FKK8yWV1bvfdCAlqN+euABkM6GHZwsT0+bXjRpudiOOMEuCkIuWQoCQlP2+WsNr8rAz8z3JY3hcbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4p4mwqaL5PEz1gp8vpEsyAYo63FOtsLMOixT5IiUWU=;
 b=jbX6pqaVi1s6AkKK4BHYWGGME2xudeXhuMcNoenB4K/qVsfIxc2GNxSBiZVKcPenT4/kG8uMDr+LMKPNPMHI46xI758BSGDBgYnnTVdhqGvEJqEi7DXI5qX3ojfyfenwQX0MnfmC19Sh8lmP1Gg5ShiQpgVJpYtCH+in/4RjWjJ3Ecrup4lENu+UqetrJ8Us4zw1AaXhdwT0nZZH3bII8rmjnuV/8HlSuaP1zAV1GXa9moGpR9w2ED5NFzFck0y3Ue40gjBjIrxSQKD8ThyA1vNUAx4YnyiEYPIQr5YE8U/fOZL+mrdzO4FjEAu27Syr/T/VjaIyQk47Odld7K0Yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4p4mwqaL5PEz1gp8vpEsyAYo63FOtsLMOixT5IiUWU=;
 b=ZGd2LK5xl9Mx0IIxFSC2DtC4GdkaWaAs0Xo/FneOaSzlPbomobIE0NTO5XIVdEgw3S/1o99GxZzkVpiC0f/yIrUo+ku5+Kcgy/vstZUUFjy3IzA58kstLpvkMWzA3y0NH5iGWWcKl+X0jNu9N87qovGNfUMAWL4GCq3xOjaVCCszIN1w5ZTwlKVLISFmN+leFMIdD2FjSiw6OF1wqcjsNFS2saPWlb0z0lF4cPhDgPmsye9ZasmAGfaFTk1AW8xhx6BtM1IMKkOx6U+uU78QIS6Xr8+0EsEN3p1pjrmddcRVwd4T32Ci58W5wUS1cmFOVGqukf0rz4c4XZEPAxp1yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7927.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 20:02:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 20:02:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-binding: board: convert fsl-board.txt to yaml
Date: Mon, 12 Aug 2024 16:01:52 -0400
Message-Id: <20240812200200.3828047-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1979b1-b185-492a-2441-08dcbb09a757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MYdb81Mv+cF/e9QSk9mSdeg7Ii7MLUlCq3JheqAxu4bM1R6fq2x7Yfn0um+R?=
 =?us-ascii?Q?MyYduCdVrmoDlI7MtiIibFPJ1KC/TtYdW5ShgOUHOXe/AfT6N+ZBekwZljuP?=
 =?us-ascii?Q?Zm3VO5tUUjTO/QVvn0wktqwrID8NOOdwCoBWYOJvlcaFkYXtdkhXYjW5cWeL?=
 =?us-ascii?Q?+3IqxwH5/prEJauLYAkBZr/9d0DeLV6KeUEejzS9R2myQDjWA6kTDJyuurGM?=
 =?us-ascii?Q?souRrwyLqxlSQNDQ321KVodTNfwNNTDvZqiDo70a8qcruVo+U19Xh+sQLzvj?=
 =?us-ascii?Q?40PW2XVZJrqyU8DVEQ7bBnD33NWAGUkvHuqQvBO7m7hW45IA7qlDxAs5oHlp?=
 =?us-ascii?Q?coteiUNsuBd3PxIxqWug0Qv+diZGpER2NUgeJ4O+9j0hBp+hX8GDGr3nLdNN?=
 =?us-ascii?Q?QDjqDvyD07icUFPL++fKI5Tpi76erZPw6lUJS44OJZpxEqvZI/ko8iYMDApp?=
 =?us-ascii?Q?EN7T0ccNJf7SwUEJ46MWTDnoLO9ujNUKA4XQefJy1x5f633mR6UFDZiVNmRB?=
 =?us-ascii?Q?yAgo7gye4lLgXJ4Q72/nRnlMjHYx88Ls+Bj22QpFANHJcLs8Xi4YCTU7Arq6?=
 =?us-ascii?Q?R2ZZAesvw+Cf4sDm6ekVPCUa/kZI1Fq927z9LGB38GNJvFNrWVcSAU78nT0a?=
 =?us-ascii?Q?qFtqcxLAtH5PJKZZtORPmK07A+sbfkyjfoitmh+7I3FUpOEJb4WWX/7hzNLD?=
 =?us-ascii?Q?KgAXNJfJeRnac9Vkdyudq2DrXzUrtI6fHA5AaiYu8Z8b/H4PktEb3+7NbU0Q?=
 =?us-ascii?Q?fOmrxcprc9sISLpyRivtNFAqxfadoMrRF2nUXw4zmJX1rrjU/pOBAqeGaRAh?=
 =?us-ascii?Q?v9gbOls4xYU+Lu2+lz626/8PV0UTYhtrtLTNkQ4+LcF4iXnDgy/UGA/a23IB?=
 =?us-ascii?Q?lGYu9jMksRaVO057YWTGGUFsCo3NALKRXTn7MqfY4Kgk7oal7cySsE3Qr1PH?=
 =?us-ascii?Q?ke7nrbT0GFCmUAcO7D55VXlDK1t1WNfnMzdMN73u7q+NlH+o8IYuy/Cyw4GL?=
 =?us-ascii?Q?s6BK7scib0+idQZsHTtOOjGXM25DiQrn6V3TSqvEwRYqezdnBAX0wBT8CuLp?=
 =?us-ascii?Q?OpLRcaOkYD9aruQ/yfMKj3jsDHpU75lNuaX+pgn2u/bNgmAqbxIWmUwiEvwz?=
 =?us-ascii?Q?UbU57rtCpQMgs5oWu6m2Wr9pZRG7WSZxun3fpVy5i6A0qj4FHJ/Y994GK/Oj?=
 =?us-ascii?Q?vvPqnj+91rQaNkt4P6hWBgnHVEYS831R4sd5xTxJxNjWh8XCovEiOBq/hsv9?=
 =?us-ascii?Q?6e2uU57BxiCf3zEQHiXNk+tX9wiD156B/E4gk84xXpSZcV76ygk7qdmIFP+5?=
 =?us-ascii?Q?MRLinTHwN9exiOLL8Z+ouz7P9VxnbTtSCRf0/NAaq0foG1Tpym8EWEmgQQRs?=
 =?us-ascii?Q?zuPu6RA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8osxCHzWkIFYpvLwIH0T6wDumvAqreb1iIpU6lT3c04JXt7opCk8DBDpihUA?=
 =?us-ascii?Q?2v/Ny683Z82uAy1AJhw/6OJwm2Cu0Kmzip5/2mHwL6UvZ1dQb2i8f2MrwSk2?=
 =?us-ascii?Q?UYcA9Ls4rD9EGz9dfCagtxZMYSiXnbjuFGWqVmUWmncYpfE043uECgoZKlEv?=
 =?us-ascii?Q?A8wEpWqcU4/OF+VUfdRAZ/3r9U3eBz/15USv5++AtVpkax3GtMMze3eJFTuX?=
 =?us-ascii?Q?t17G+RExaf6zFQpd5GiieWmhCxc0cVZlffi0+bvsHajq3sJTzyN4bQBx7FXj?=
 =?us-ascii?Q?Vqk09L/WOhB7zLIHamIidwDXqXiXr57Mr1wygenD++56OsZSqf09vqkMDllL?=
 =?us-ascii?Q?gShd9KbUk+uGmHoxwyZjIhIyJs66m73GCslgiA1OWazpNbaEdRpSDrOx3JZQ?=
 =?us-ascii?Q?/01r2gqgIK1PKWuJ3PQx7o/Uy/jPBobCIWlfRdXzH/aolNR2blMvpOTtSbl4?=
 =?us-ascii?Q?vKJha9SpsPDLvUQYxcIxVBKppx1PvuGESuaGshSxxPDnCp47EjY2d8l9R7ut?=
 =?us-ascii?Q?pd4jH1AAGOgtIzp5WFFf1IMabM+SLxWYft1Kb7UmSiaSEmmR3Ugyhx4dOA9m?=
 =?us-ascii?Q?IpW8yBq5jIFCWMjJBkpt9sRhHdTEjnosN3KhpTAJLahgSPzAaVLxBAaqouiX?=
 =?us-ascii?Q?Fk2giPz0C9zlbxFSwGd4/vsFU+joNiJCdlEOgeaXna4LcaBwcLmZRFWZWSCi?=
 =?us-ascii?Q?mm+5ZkriybWB0cqdJD3VBAxhccp1pFjX5fEDnvBQPkpaXIgv9HcWyPWpqegD?=
 =?us-ascii?Q?Sf7yObzvSKtA/S7I5BKLu0C9WmQghH9TH0K3hGT28IPhAT2tvl4GtbzNrfrN?=
 =?us-ascii?Q?WCZ+Szdxg40Yl9WiaRV1kFdS/ycaAZqGV+6raXcsJG0fm2Z466JglX5dDAgl?=
 =?us-ascii?Q?+sJ4wJy7KoY/vG6Tyyu4bmb4E3ZbtSamrtPYtaNo6HNlhyRlu34l9Fj/NP9E?=
 =?us-ascii?Q?MplBR0xkcGdXLx4KysYQDxd31I4xTO7g0dNVQcq/PC/8Lw+PHkoN4dsCcL8r?=
 =?us-ascii?Q?RS58nM5IGEB3gHupfusE9ZCeSZw3JNHPMTEDvhqo4qfLyx2hiY9R2lAs+5ru?=
 =?us-ascii?Q?bRQH6xYSwozxfIy6E/NV2NnGhtCkKcuDTblsaQYtmOADMeoBe8kBAzi/JqeX?=
 =?us-ascii?Q?ntVGBk4yrlfEfGq/+Fb8ryNVeXjQSB3k506HJKhib56jLHjJ8fW9UfSZP5YZ?=
 =?us-ascii?Q?EiEN97RP80HUYV8ODFFH9ZTtaMkDmeyM3Y147iPdV5NwCSED7vNJl/u1vsCV?=
 =?us-ascii?Q?2kQe6Bv67yS0VFLR0o0LiabbPIagSSoxfg4l4FG+048U5BxWqzOYEMyjLC2z?=
 =?us-ascii?Q?VOo2RUR6GWpsyM8it/bz+cmMhAQREcY7QsB2UuUNgH7DPncvsuZ90VS7csUR?=
 =?us-ascii?Q?b2sIe2TxbSWd0vFMvv4JExsy6Z04cSdB35prRDv2ohC89RRlLNwEPOU1Mx5D?=
 =?us-ascii?Q?QL7Hui3Uvzs+3AzcIABd6SO0ngcrFYPUbOGoVvI3c1J1blC5t+wR9Ppcq5BF?=
 =?us-ascii?Q?XEKuVQFsN9q1WLrRW3Ht9nvWo1MuaKJN8qnGQ6xqkZxHFlon0g8p+hHKbYdV?=
 =?us-ascii?Q?nHrd342kdKYHbH8Jxe0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1979b1-b185-492a-2441-08dcbb09a757
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 20:02:11.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIjqB8XfP4GrrbS/5MQLWuvtQjmr7A7Fb0LvDWUe5RdoWANKJ/nfeObEIdjGQ8AQMmcpfbkXzD5uzIRUnQJDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7927

Convert binding doc fsl-board.txt to yaml format. split to 3 part
fsl,bcsr.yaml, fsl,fpga-qixis.yaml, fsl,fpga-qixis-i2c.yaml

Additional change for fsl,fpga-qixis.yaml
- Add childnode mdio-mux-emi*
- Add compatible string fsl,ls1043aqds-fpga, fsl,ls1043ardb-fpga,
fsl,ls1046aqds-fpga, fsl,ls1046ardb-fpga, fsl,ls208xaqds-fpga,
fsl,ls1043ardb-cpld, fsl,ls1046ardb-cpld, fsl,ls1088aqds-fpga,
fsl,ls1088ardb-fpga, fsl,ls2080aqds-fpga, fsl,ls2080ardb-fpga.
- Change address to 32bit in example.

Additional change for fsl,fpga-qixis-i2c.yaml
- Add mux-controller
- Add compatible string fsl,ls1028aqds-fpga, fsl,lx2160aqds-fpga

Fix below warning:

arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/fpga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga', 'fsl,fpga-qixis-i2c', 'simple-mfd']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/board/fsl,bcsr.yaml   | 38 +++++++++
 .../bindings/board/fsl,fpga-qixis-i2c.yaml    | 50 ++++++++++++
 .../bindings/board/fsl,fpga-qixis.yaml        | 81 +++++++++++++++++++
 .../devicetree/bindings/board/fsl-board.txt   | 81 -------------------
 4 files changed, 169 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/board/fsl,bcsr.yaml
 create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
 delete mode 100644 Documentation/devicetree/bindings/board/fsl-board.txt

diff --git a/Documentation/devicetree/bindings/board/fsl,bcsr.yaml b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
new file mode 100644
index 0000000000000..73e33483d20c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/board/fsl,bcsr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Board Control and Status
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  Freescale Reference Board Bindings.
+
+  This document describes device tree bindings for various devices that
+  exist on some Freescale reference boards.
+
+properties:
+  compatible:
+    enum:
+      - fsl,mpc8360mds-bcsr
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    board@f8000000 {
+        compatible = "fsl,mpc8360mds-bcsr";
+        reg = <0xf8000000 0x8000>;
+    };
+
diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
new file mode 100644
index 0000000000000..cab221a1fd466
--- /dev/null
+++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/board/fsl,fpga-qixis-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale on-board FPGA connected on I2C bus
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,bsc9132qds-fpga
+              - fsl,ls1028aqds-fpga
+              - fsl,lx2160aqds-fpga
+          - const: fsl,fpga-qixis-i2c
+          - const: simple-mfd
+        minItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  mux-controller:
+    $ref: /schemas/mux/reg-mux.yaml
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        board-control@66 {
+            compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
+            reg = <0x66>;
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
new file mode 100644
index 0000000000000..455620daa1fee
--- /dev/null
+++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/board/fsl,fpga-qixis.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale on-board FPGA/CPLD
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,p1022ds-fpga
+          - const: fsl,fpga-ngpixis
+      - items:
+          - enum:
+              - fsl,ls1088aqds-fpga
+              - fsl,ls1088ardb-fpga
+              - fsl,ls2080aqds-fpga
+              - fsl,ls2080ardb-fpga
+          - const: fsl,fpga-qixis
+      - items:
+          - enum:
+              - fsl,ls1043aqds-fpga
+              - fsl,ls1043ardb-fpga
+              - fsl,ls1046aqds-fpga
+              - fsl,ls1046ardb-fpga
+              - fsl,ls208xaqds-fpga
+          - const: fsl,fpga-qixis
+          - const: simple-mfd
+      - enum:
+          - fsl,ls1043ardb-cpld
+          - fsl,ls1046ardb-cpld
+          - fsl,t1040rdb-cpld
+          - fsl,t1042rdb-cpld
+          - fsl,t1042rdb_pi-cpld
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges:
+    maxItems: 1
+
+patternProperties:
+  '^mdio-mux-emi[0-9]@[a-f0-9]+$':
+    $ref: /schemas/net/mdio-mux-mmioreg.yaml
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    board-control@3 {
+        compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
+        reg = <3 0x30>;
+        interrupt-parent = <&mpic>;
+        interrupts = <8 IRQ_TYPE_LEVEL_LOW 0 0>;
+    };
+
+  - |
+    board-control@3 {
+        compatible = "fsl,ls2080ardb-fpga", "fsl,fpga-qixis";
+        reg = <0x3 0x10000>;
+    };
+
diff --git a/Documentation/devicetree/bindings/board/fsl-board.txt b/Documentation/devicetree/bindings/board/fsl-board.txt
deleted file mode 100644
index 9cde570159219..0000000000000
--- a/Documentation/devicetree/bindings/board/fsl-board.txt
+++ /dev/null
@@ -1,81 +0,0 @@
-Freescale Reference Board Bindings
-
-This document describes device tree bindings for various devices that
-exist on some Freescale reference boards.
-
-* Board Control and Status (BCSR)
-
-Required properties:
-
- - compatible : Should be "fsl,<board>-bcsr"
- - reg : Offset and length of the register set for the device
-
-Example:
-
-	bcsr@f8000000 {
-		compatible = "fsl,mpc8360mds-bcsr";
-		reg = <f8000000 8000>;
-	};
-
-* Freescale on-board FPGA
-
-This is the memory-mapped registers for on board FPGA.
-
-Required properties:
-- compatible: should be a board-specific string followed by a string
-  indicating the type of FPGA.  Example:
-	"fsl,<board>-fpga", "fsl,fpga-pixis", or
-	"fsl,<board>-fpga", "fsl,fpga-qixis"
-- reg: should contain the address and the length of the FPGA register set.
-
-Optional properties:
-- interrupts: should specify event (wakeup) IRQ.
-
-Example (P1022DS):
-
-	 board-control@3,0 {
-		 compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
-		 reg = <3 0 0x30>;
-		 interrupt-parent = <&mpic>;
-		 interrupts = <8 8 0 0>;
-	 };
-
-Example (LS2080A-RDB):
-
-        cpld@3,0 {
-                compatible = "fsl,ls2080ardb-fpga", "fsl,fpga-qixis";
-                reg = <0x3 0 0x10000>;
-        };
-
-* Freescale on-board FPGA connected on I2C bus
-
-Some Freescale boards like BSC9132QDS have on board FPGA connected on
-the i2c bus.
-
-Required properties:
-- compatible: Should be a board-specific string followed by a string
-  indicating the type of FPGA.  Example:
-	"fsl,<board>-fpga", "fsl,fpga-qixis-i2c"
-- reg: Should contain the address of the FPGA
-
-Example:
-	fpga: fpga@66 {
-		compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
-		reg = <0x66>;
-	};
-
-* Freescale on-board CPLD
-
-Some Freescale boards like T1040RDB have an on board CPLD connected.
-
-Required properties:
-- compatible: Should be a board-specific string like "fsl,<board>-cpld"
-  Example:
-	"fsl,t1040rdb-cpld", "fsl,t1042rdb-cpld", "fsl,t1042rdb_pi-cpld"
-- reg: should describe CPLD registers
-
-Example:
-	cpld@3,0 {
-		compatible = "fsl,t1040rdb-cpld";
-		reg = <3 0 0x300>;
-	};
-- 
2.34.1


