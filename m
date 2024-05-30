Return-Path: <linux-kernel+bounces-193963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7EF8D34A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A841C242E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFD17B4F2;
	Wed, 29 May 2024 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHFJ/MYj"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8874F17B4FC;
	Wed, 29 May 2024 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978690; cv=fail; b=k2+ZrstpbRl/ZSlQnwa3aYlrwiS6y2ZIUSr1ND1EDNJAMbL5N/CPIodPMECh8oVWemr5zsPR4H367GZfXKR+ii0wNmAwHD3fy1szphbP97fGY5LTewpNLxMQfdluJl0p1NeRnSpWCkqNUYV05tlVST2shvUB1Lz0x9AHyo1n3wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978690; c=relaxed/simple;
	bh=eJnknsxielhxzfUN4ECAV61n7KteCQEAq4fj9SNJJ58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J276rmROSSVPh/8SA+ul1dHIqoJNX806g9arYCc3wPPJ0i971XBCYMApXIUm4xt9+r9dTrFuc1CsSVA9MCFOpdv2Y6/Cf2CP0x+Jg46OpuAh5sgaH9IyLT5/GsGhPaokD0BzGEmWYEkaRdzcBJrN2Yg0lGjk53miWf6g1Zb3w+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YHFJ/MYj; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuhjvmEqmJ+OkJGNGw/JU90D3iLW3Gw2Q9r6mGyFr7Zkq6o/AGuYtOLXhKhDj5PUraeM91sNi5vPos1GNrwDztvD/ovbGUZyrW/Oiv/TdM41qT+HQdA0gMsEVEsQ8ZoIvdi47oZXB1yrHC/fj0TqunIalZLmTmphAJ8osxzGtY7wB4h84kZeDfTGcKM4yJM+/Da26RVPTsoFfNjEDz1Gx1Afb1QXcIOPoa2c4wHdHwI4n4tK1SIOAehjVZXCG7zlgep5h4mgtcPvIX1eRviPI+auklKWA65EjZJqydHL1MjR+OQuPHkEjpX3ZCtTKJXx6RkXXowxzzNf2OlFpzwZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKxh5IsaPTo8hdA1+JCjulPNaRHnx9duHPhC4O4BGG8=;
 b=NTL/MX3ESFUL5cT2DRZE/x4nc8No2qZ45RJM7A6dUHS0GLQ02kPu/b6A/81ZeHk8FtZY0Bf5i/2ReBJWAUNRxINHvhH0gHp8kigDRrpdny4UcC7SGnizvjUYUImaHJzfvykQVpHU0ScItaW7vllc8LxVK0h4NTxVkotOLajybTSEx01CIGI+qWArc2Xq+wpOj3ZjhEP9OXiaAdMWBxw6KUKfYNdokrBab68BDw0RdoKyaYmBnC0YCZ78i/wdBSgnnwkhPXwutjijPwodzvYSm4kmJgyCAX9G1hL7lBhWZfcwnk79DK/vz4J8FlZzruscFMrdyKNlmjnW1s9jS+cLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKxh5IsaPTo8hdA1+JCjulPNaRHnx9duHPhC4O4BGG8=;
 b=YHFJ/MYjPe9+1yq6+J8eBevOMtQB2xC1rNHtRqHXKSwqiDRg1EdV4N6tn9PV07Ira/6CIg5SqiEBUsd045neLy6NxIfcgy0Xa5Q6dy0vAg4nQJHJHorjD736NfwEovVVWMWv1IxJrpP+zdT83+a9SqyCNDX0u2qS4qMvu5pQLHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB8393.eurprd04.prod.outlook.com (2603:10a6:10:25f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:31:24 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 10:31:24 +0000
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
Subject: [PATCH v2 5/5] arm64: dts: freescale: Add i.MX91 11x11 EVK basic support
Date: Wed, 29 May 2024 19:26:34 -0700
Message-Id: <20240530022634.2062084-6-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5e6a4836-ab39-4c28-1676-08dc7fca7d14
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230031|366007|376005|1800799015|52116005|7416005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?HHEa1y3r8S+POeX9SHO1eVE5y8W4L4J5vGaY+TRBQ3egiNyLI8KCcHvCBZ1+?=
 =?us-ascii?Q?Bt3kZluBlPl5GROWH5vYlRhD7Irf+Eq/XlxEotjMjEEeHjQqy/1WHQQ2XJn+?=
 =?us-ascii?Q?zySdJBsniwxClB+8fTiBWcWGg55okRx46M3AWJW9+mRkRZqZMCBFIZQuxHAW?=
 =?us-ascii?Q?PjDFmKb95I7BcNJN5DKQ2fZQzEaxMcwYozplrbqao9uqvLvzex9CSC5Gjbnp?=
 =?us-ascii?Q?qNClZDLrRQOjbwYUG0uhoTTR65SkMwDqKG0x9ZpgXnFCQWxS2oVwiIIbJ6WP?=
 =?us-ascii?Q?lv+xqqcfJFIp0O33oEPOkR911f7kajy7yLbKmxK38U14QgZ4EpuRxOIBFt9l?=
 =?us-ascii?Q?vLj5eB2+N1MNRNgXLwVFVIDg4Ua/rRah5gWg5WdmJ+k0LaAB/2oGK9WyXYCJ?=
 =?us-ascii?Q?Ov32ZXla9pSlMlbbzW14uwk/cZWQqDTifIE+yLKl3jfm15jcCT/2HmO3K/9t?=
 =?us-ascii?Q?bL3QtUsWWBV1h0kvsxcUffeER93imXMms+sCbE1j2FXC/qDW8Gkqy5OEtoyB?=
 =?us-ascii?Q?pLeceVmk2JioaVWDulAOQ9Q8FABxUqkrCTOqcYe4kdokb0LUaub7rBu5KaWK?=
 =?us-ascii?Q?ar+teF8wMboybAKSJT5oxpTlpGvQVzDuuDbBAD7fW88+jZSmhwqb/j1K3eDN?=
 =?us-ascii?Q?Kle6wak47IMZNaon/rycTEhMnC/zActJxeA322ukw1lCapqVusoDAF4HIkh0?=
 =?us-ascii?Q?A9Y+RUrfTMekD9JJsJJJQF/Aq1TMT9R2TyKD7HV6ASg+jpQZJ5pc7rIsX52o?=
 =?us-ascii?Q?Lw9o4GQDOCdUgMnlUp7yDOOQbIaGxMhcE3Shv7NpfkscJA1GdXWrfIQaJKbu?=
 =?us-ascii?Q?P/odHG6OyVtoPaNeyfTHEff/MW5O5Y8hJsLZPFl2RkWHTd4oh/yMF7VLyOhj?=
 =?us-ascii?Q?i2RlPTK2YyMuOFHq+D20TzdeOBBIcrfkqw8r8LZfB5f06SVkQiyUFt/X5obX?=
 =?us-ascii?Q?fbtOGE2/eHC+1NAfsZoVGlL0rN6ITH2vFB/X2MqKQA4Am290rO+jHyJb0C+f?=
 =?us-ascii?Q?F7CanjNKj4dEWyvwNy8dY4PgxBTTmKjGdGw0sOHZ4meb0MEWF3f6e6TsDW4T?=
 =?us-ascii?Q?yQdR9pqRDMXdfcz7VUdpg4Ep0oejp3o2zfHq1UouX1RMI4E9kMc0Nqp+nM2E?=
 =?us-ascii?Q?g+YuXfL6v1N9PwekHEGCXFkbD86AXsbm0lLdThBOt/VvRYitMwCEB8YXkrE5?=
 =?us-ascii?Q?nH3Co5eX9owzKencmT1+cT16zwMTeRNmTseY8Pr5x5Ko9nlXR2nO+yw9jdIB?=
 =?us-ascii?Q?ghnripCVVBGkNd5XvvjOssgzPTRp/yBlDg7FJbyofIaEq//VNHE+fFCVMgpi?=
 =?us-ascii?Q?ErFMEfLAwkTGt8Hx/WAL3lcyyDnvBQ2T0jUg8r0nusI+JTtnQlMjTevI51e/?=
 =?us-ascii?Q?DE+hgk0=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?cKH6FR+dZk38pp/Zly9aGq1fqlmYk1AYrovsB5y9QcbtksU/MhoXdOB9oToZ?=
 =?us-ascii?Q?Q4+m4coBhZGAtCn2jdqaoetoTFbUZzLymZBd/tg2AzR/aO437qxghXm2HeZV?=
 =?us-ascii?Q?S6HK+WvapRSG0lIfkxpxrDFevceWC8ChY0k6lD7TFyJVl+zFDgvDqEL4s2fk?=
 =?us-ascii?Q?8EtJ1PDfZLS3gJO84NqVmOWtykpazUNVwLN1/6ZqUEtj5MeINCTV6Ty+wRt1?=
 =?us-ascii?Q?ZNLTAdhCP2nDjeqgPUN6jFMJ/G2eHHrc2knTTWvF/DNULxxbLx4NXMUmqP3m?=
 =?us-ascii?Q?iKL5AWwmQ/J2mNfiGJVuKqguAh6T9TI9e5aM0UF4fkiGMF0CsY/cgONWzw5m?=
 =?us-ascii?Q?Q7sBqOPtd3fsg27nSfKtEggOBQ0rNBTiLFL6HUymZlem+OJuwMlz30ShigzA?=
 =?us-ascii?Q?/GbtR+qwZgNv8MF64Xd57e3lXguzRrt1SSVdePphyIWDMnvoiKpNpl8p4uiH?=
 =?us-ascii?Q?rZVDjBB9+fKrkJAKGzC3pbdCU0ByNSBSsV6j2tLM/kK+CALB1l3gtCoZwW6w?=
 =?us-ascii?Q?rAP4B4Zs2flAtWFpD54F5ECmzakphM0N6WSDMzJZwaNS6iQzFzBPJ3K4VglO?=
 =?us-ascii?Q?ooGa9JdPmekRRMLXtZMLD3VKxvY33T4SExnFSA97tTy6F6CCoN9cdiCRzbJf?=
 =?us-ascii?Q?JTbWxNhx60dDYF5j92S5YZ+dq/1/+lXAd1PGtbhMOAw5MggfOmVoAfCKi4rg?=
 =?us-ascii?Q?m3374ufvB4W95Ry/l9SF4+qjK9I/+Ya1NbRL+5Mn9TkGljS5eh8ti07M72v0?=
 =?us-ascii?Q?xOifT+l2nJJRu7ukoxKF88pGMOtYTMUu95l9oZUjC8YWeKqwFh6Stdq1vcGT?=
 =?us-ascii?Q?kGAyzcn1PJI2rLk8DdYvMjN0H6M4fQLOl3Z6ZzNy/M+8IhPYw0izNjltlLGb?=
 =?us-ascii?Q?94OzkACCbQyIneIf7DHezcb6H+GixBDzqs97ItUACFoSRk8MFcSbzsSX7TBs?=
 =?us-ascii?Q?AhlaRlwdxJor+2Eebc6BLqDWBJq3a1rPMQtzTdmxQhF1KyTrOMc32p/+QUsT?=
 =?us-ascii?Q?ijQaa19o5WJKWp+6VUXR1qoA5fHlqn8FdYtRUh37URpsCQQcqGEr0H0XCNKV?=
 =?us-ascii?Q?5QL0WI7plgAlJ3cNz4L6VrS0yP2abOOwfUHrNuzE0vznMJxxnEqKrQtPdSab?=
 =?us-ascii?Q?XzewIp8gH3N31WEQMkuaF7jYnTLr0FrPoJH9xxqhb34b+8YD61qLlZCxJG5k?=
 =?us-ascii?Q?oKjSu0dJryBeMUgLIEg7qgKMKvl3xkUVORYzs/gMEx9fSEsNE/3qy6y2cRhI?=
 =?us-ascii?Q?OCYQZ7y+FPMae2Ip30eu8QrsgFtQ/J5Naetq6YuiSU8WCYvLplzRG0gA5a4g?=
 =?us-ascii?Q?sUx+hV1cukQDyrL1vxy7yO3Qld1sY0jIlkrDnks1yukzrl1epDAqYpomibYB?=
 =?us-ascii?Q?RjZr9qRQB0rY378IokMcFATAHYE2/QW/9FBjcn3DqXtwarLTVEbHlFnQvy9l?=
 =?us-ascii?Q?Ad0VagJ3I4f0dMGy/QjTAICHY50fAENf4XmDveCtEa92mw5pKTIZiVEISJe/?=
 =?us-ascii?Q?Xy9f+/vURLcVnb3xA+2xiARxybXFRDzQn3bwfDC5xLrJqnwq4FREnGmB4s3f?=
 =?us-ascii?Q?eY0mqv+R8/CiY4NN9ThWw3znwJI7rIoa1YxCLC0f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6a4836-ab39-4c28-1676-08dc7fca7d14
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:31:24.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCowVQhKRqlNtZNfnzvlZU9UGSvFZTiPEFqIhu22QFw7l3qMl9DquBXQG8XGyYBgHn1/fsOPkLOzFqIukycf+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8393

Add i.MX91 11x11 EVK board support.
- Enable lpuart1 and lpuart5.
- Enable network eqos and fec.
- Enable I2C bus and children nodes under I2C bus.
- Enable USB and related nodes.
- Enable uSDHC1 and uSDHC2.
- Enable MU1 and MU2.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change for v2:
    - refine the commit msg to list all enabled modules.
    - fix dtbs_check warning

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    | 820 ++++++++++++++++++
 2 files changed, 821 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index bd443c2bc5a4..7083f6824e9f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -236,6 +236,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
 
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
new file mode 100644
index 000000000000..c58dd4f1e745
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
@@ -0,0 +1,820 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/usb/pd.h>
+#include "imx91.dtsi"
+
+/ {
+	model = "NXP i.MX91 11X11 EVK board";
+	compatible = "fsl,imx91-11x11-evk", "fsl,imx91";
+
+	aliases {
+		ethernet0 = &fec;
+		ethernet1 = &eqos;
+		rtc0 = &bbnsm_rtc;
+	};
+
+	chosen {
+		stdout-path = &lpuart1;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			alloc-ranges = <0 0x80000000 0 0x40000000>;
+			size = <0 0x10000000>;
+			linux,cma-default;
+		};
+	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <12000>;
+		enable-active-high;
+	};
+
+	reg_vdd_12v: regulator-vdd-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "reg_vdd_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&pcal6524 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_vrpi_3v3: regulator-vrpi-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VRPI_3V3";
+		gpio = <&pcal6524 2 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		vin-supply = <&buck4>;
+	};
+
+	reg_vrpi_5v: regulator-vrpi-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VRPI_5V";
+		gpio = <&pcal6524 8 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+	};
+
+	reg_usdhc3_vmmc: regulator-usdhc3 {
+		compatible = "regulator-fixed";
+		regulator-name = "WLAN_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pcal6524 20 GPIO_ACTIVE_HIGH>;
+		/*
+		 * IW612 wifi chip needs more delay than other wifi chips to complete
+		 * the host interface initialization after power up, otherwise the
+		 * internal state of IW612 may be unstable, resulting in the failure of
+		 * the SDIO3.0 switch voltage.
+		 */
+		startup-delay-us = <20000>;
+		enable-active-high;
+	};
+};
+
+&adc1 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
+&eqos {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			eee-broken-1000t;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy2>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			eee-broken-1000t;
+		};
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		typec1_con: connector {
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
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x51>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		typec2_con: connector {
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
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	pcf2131: rtc@53 {
+			compatible = "nxp,pcf2131";
+			reg = <0x53>;
+			interrupt-parent = <&pcal6524>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+			status = "okay";
+	};
+};
+
+&lpuart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	status = "okay";
+};
+
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	bus-width = <4>;
+	status = "okay";
+	no-sdio;
+	no-mmc;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__ENET1_MDC			0x57e
+			MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x57e
+			MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x57e
+			MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x57e
+			MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x57e
+			MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x57e
+			MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC	0x5fe
+			MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x57e
+			MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x57e
+			MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1			0x57e
+			MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x57e
+			MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x57e
+			MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x5fe
+			MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x57e
+		>;
+	};
+
+	pinctrl_eqos_sleep: eqossleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET1_MDC__GPIO4_IO0				0x31e
+			MX91_PAD_ENET1_MDIO__GPIO4_IO1				0x31e
+			MX91_PAD_ENET1_RD0__GPIO4_IO10                          0x31e
+			MX91_PAD_ENET1_RD1__GPIO4_IO11				0x31e
+			MX91_PAD_ENET1_RD2__GPIO4_IO12				0x31e
+			MX91_PAD_ENET1_RD3__GPIO4_IO13				0x31e
+			MX91_PAD_ENET1_RXC__GPIO4_IO9                          0x31e
+			MX91_PAD_ENET1_RX_CTL__GPIO4_IO8			0x31e
+			MX91_PAD_ENET1_TD0__GPIO4_IO5                          0x31e
+			MX91_PAD_ENET1_TD1__GPIO4_IO4                          0x31e
+			MX91_PAD_ENET1_TD2__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TD3__GPIO4_IO3				0x31e
+			MX91_PAD_ENET1_TXC__GPIO4_IO7                          0x31e
+			MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                       0x31e
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__ENET2_MDC			0x57e
+			MX91_PAD_ENET2_MDIO__ENET2_MDIO			0x57e
+			MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0		0x57e
+			MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1		0x57e
+			MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2		0x57e
+			MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3		0x57e
+			MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC		0x5fe
+			MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL	0x57e
+			MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0		0x57e
+			MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1		0x57e
+			MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2		0x57e
+			MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3		0x57e
+			MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC		0x5fe
+			MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL	0x57e
+		>;
+	};
+
+	pinctrl_fec_sleep: fecsleepgrp {
+		fsl,pins = <
+			MX91_PAD_ENET2_MDC__GPIO4_IO14			0x51e
+			MX91_PAD_ENET2_MDIO__GPIO4_IO15			0x51e
+			MX91_PAD_ENET2_RD0__GPIO4_IO24			0x51e
+			MX91_PAD_ENET2_RD1__GPIO4_IO25			0x51e
+			MX91_PAD_ENET2_RD2__GPIO4_IO26			0x51e
+			MX91_PAD_ENET2_RD3__GPIO4_IO27			0x51e
+			MX91_PAD_ENET2_RXC__GPIO4_IO23                  0x51e
+			MX91_PAD_ENET2_RX_CTL__GPIO4_IO22		0x51e
+			MX91_PAD_ENET2_TD0__GPIO4_IO19			0x51e
+			MX91_PAD_ENET2_TD1__GPIO4_IO18			0x51e
+			MX91_PAD_ENET2_TD2__GPIO4_IO17			0x51e
+			MX91_PAD_ENET2_TD3__GPIO4_IO16			0x51e
+			MX91_PAD_ENET2_TXC__GPIO4_IO21                  0x51e
+			MX91_PAD_ENET2_TX_CTL__GPIO4_IO20               0x51e
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO25__CAN2_TX	0x139e
+			MX91_PAD_GPIO_IO27__CAN2_RX	0x139e
+		>;
+	};
+	pinctrl_flexcan2_sleep: flexcan2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO25__GPIO2_IO25  0x31e
+			MX91_PAD_GPIO_IO27__GPIO2_IO27	0x31e
+		>;
+	};
+
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK		0x31e
+			MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE		0x31e
+			MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC		0x31e
+			MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC		0x31e
+			MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0		0x31e
+			MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1		0x31e
+			MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2		0x31e
+			MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3		0x31e
+			MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4		0x31e
+			MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5		0x31e
+			MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6		0x31e
+			MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7		0x31e
+			MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8		0x31e
+			MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9		0x31e
+			MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10	0x31e
+			MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11	0x31e
+			MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12	0x31e
+			MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13	0x31e
+			MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14	0x31e
+			MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15	0x31e
+			MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16	0x31e
+			MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17	0x31e
+			MX91_PAD_GPIO_IO27__GPIO2_IO27			0x31e
+		>;
+	};
+
+	pinctrl_lcdif_gpio: lcdifgpiogrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO00__GPIO2_IO0			0x51e
+			MX91_PAD_GPIO_IO01__GPIO2_IO1			0x51e
+			MX91_PAD_GPIO_IO02__GPIO2_IO2			0x51e
+			MX91_PAD_GPIO_IO03__GPIO2_IO3			0x51e
+		>;
+	};
+
+	pinctrl_lpi2c1: lpi2c1grp {
+		fsl,pins = <
+			MX91_PAD_I2C1_SCL__LPI2C1_SCL			0x40000b9e
+			MX91_PAD_I2C1_SDA__LPI2C1_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX91_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX91_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX91_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX91_PAD_UART1_RXD__LPUART1_RX			0x31e
+			MX91_PAD_UART1_TXD__LPUART1_TX			0x31e
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX	0x31e
+			MX91_PAD_DAP_TDI__LPUART5_RX		0x31e
+			MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B	0x31e
+			MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B	0x31e
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x1382
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x1382
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x1382
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x1382
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x1382
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x1382
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x1382
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x1382
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x1382
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x138e
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x138e
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x138e
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x138e
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x138e
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x138e
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x138e
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD1_CLK__USDHC1_CLK		0x15fe
+			MX91_PAD_SD1_CMD__USDHC1_CMD		0x13fe
+			MX91_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe
+			MX91_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe
+			MX91_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe
+			MX91_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe
+			MX91_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe
+			MX91_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe
+			MX91_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe
+			MX91_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe
+			MX91_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_RESET_B__GPIO3_IO7	0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x31e
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CD_B__GPIO3_IO0		0x51e
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x1382
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x1382
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x1382
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x1382
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x1382
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x138e
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__USDHC2_CLK		0x15fe
+			MX91_PAD_SD2_CMD__USDHC2_CMD		0x13fe
+			MX91_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe
+			MX91_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe
+			MX91_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe
+			MX91_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe
+			MX91_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD2_CLK__GPIO3_IO1            0x51e
+			MX91_PAD_SD2_CMD__GPIO3_IO2		0x51e
+			MX91_PAD_SD2_DATA0__GPIO3_IO3		0x51e
+			MX91_PAD_SD2_DATA1__GPIO3_IO4		0x51e
+			MX91_PAD_SD2_DATA2__GPIO3_IO5		0x51e
+			MX91_PAD_SD2_DATA3__GPIO3_IO6		0x51e
+			MX91_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x1582
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x1382
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x1382
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x1382
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x1382
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x1382
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x158e
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x138e
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x138e
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x138e
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x138e
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x138e
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__USDHC3_CLK		0x15fe
+			MX91_PAD_SD3_CMD__USDHC3_CMD		0x13fe
+			MX91_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe
+			MX91_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe
+			MX91_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe
+			MX91_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SD3_CLK__GPIO3_IO20		0x31e
+			MX91_PAD_SD3_CMD__GPIO3_IO21		0x31e
+			MX91_PAD_SD3_DATA0__GPIO3_IO22		0x31e
+			MX91_PAD_SD3_DATA1__GPIO3_IO23		0x31e
+			MX91_PAD_SD3_DATA2__GPIO3_IO24		0x31e
+			MX91_PAD_SD3_DATA3__GPIO3_IO25		0x31e
+		>;
+	};
+
+	pinctrl_usdhc3_wlan: usdhc3wlangrp {
+		fsl,pins = <
+			MX91_PAD_CCM_CLKO1__GPIO3_IO26		0x31e
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			MX91_PAD_SAI1_TXC__SAI1_TX_BCLK			0x31e
+			MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC		0x31e
+			MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0		0x31e
+			MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0		0x31e
+		>;
+	};
+
+	pinctrl_sai1_sleep: sai1sleepgrp {
+		fsl,pins = <
+			MX91_PAD_SAI1_TXC__GPIO1_IO12                   0x51e
+			MX91_PAD_SAI1_TXFS__GPIO1_IO11			0x51e
+			MX91_PAD_SAI1_TXD0__GPIO1_IO13			0x51e
+			MX91_PAD_SAI1_RXD0__GPIO1_IO14			0x51e
+		>;
+	};
+
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO26__SAI3_TX_SYNC		0x31e
+			MX91_PAD_GPIO_IO16__SAI3_TX_BCLK		0x31e
+			MX91_PAD_GPIO_IO17__SAI3_MCLK			0x31e
+			MX91_PAD_GPIO_IO19__SAI3_TX_DATA0		0x31e
+			MX91_PAD_GPIO_IO20__SAI3_RX_DATA0		0x31e
+		>;
+	};
+
+	pinctrl_sai3_sleep: sai3sleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO26__GPIO2_IO26			0x51e
+			MX91_PAD_GPIO_IO16__GPIO2_IO16			0x51e
+			MX91_PAD_GPIO_IO17__GPIO2_IO17			0x51e
+			MX91_PAD_GPIO_IO19__GPIO2_IO19			0x51e
+			MX91_PAD_GPIO_IO20__GPIO2_IO20			0x51e
+		>;
+	};
+
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX91_PAD_PDM_CLK__PDM_CLK			0x31e
+			MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0	0x31e
+			MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1	0x31e
+		>;
+	};
+
+	pinctrl_pdm_sleep: pdmsleepgrp {
+		fsl,pins = <
+			MX91_PAD_PDM_CLK__GPIO1_IO8			0x31e
+			MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9		0x31e
+			MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10		0x31e
+		>;
+	};
+
+	pinctrl_spdif: spdifgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO22__SPDIF_IN		0x31e
+			MX91_PAD_GPIO_IO23__SPDIF_OUT		0x31e
+		>;
+	};
+
+	pinctrl_spdif_sleep: spdifsleepgrp {
+		fsl,pins = <
+			MX91_PAD_GPIO_IO22__GPIO2_IO22		0x31e
+			MX91_PAD_GPIO_IO23__GPIO2_IO23		0x31e
+		>;
+	};
+};
-- 
2.34.1


