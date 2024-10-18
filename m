Return-Path: <linux-kernel+bounces-370900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9D9A336E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9921C237D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465916DEA9;
	Fri, 18 Oct 2024 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W/GkRvIB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD6E16B3B7;
	Fri, 18 Oct 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222630; cv=fail; b=l0ECg0n248WNYlHFnFNIBGGKNiVXzTFqJUu2VnXjoyeHvQAbKaeJUtmLfw6ztDS7cMqiYEzKpo3QI7V1XMBiSAOSACoEqCW3LTsjj3/5IbS54eiuB3GPSi8Ajob5a3yGGSKiOh3wHv9HxIFQkJD76QuVNltaKt2jBtPlOs0Vpw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222630; c=relaxed/simple;
	bh=UNuUqEJd3+0h7YOdJnGO5bQb2YMNqgFOgNHF34fdmLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L2i/9GXw/oIwRkIZyld5h65oNyQrS+4544yF8DfaLZVCE2A2EMFLx6GcTt5eT5WBYvCnMExP/EURWZvo8Yf6GroyyfwAnQSeAPP5BweX6T1CZMDZ4kouuvPYee45Xwwa+0TRtybtsVd2JCoL3WPbtytxVFXIvLTVaTt6illPZlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W/GkRvIB; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDwTF8p6ObDHfReJfQTQBu9OTRMVOQ5dWTqeAY/L0zmYjB0liKyj0diqBrMmCYQQhAPGseK8ELRKt/c0XlQI978MQ0kX5XImofkPKsnO74jFTlBKp1BMYuWJZ6/VT70Blh7EO1ahdFUbidBD8xTAf/B+iN0jbwhdyTd3bDVmiazQHH14C3x9L+e7rrCYLXBQ4OcpQ6zG4hymGF8QNMBvQf6VORWZswm1zeBDca4syjahVUeW30v6gKGCsJCLIS18IhYVqlpf11TsorPtBskEHCxdm25MOPfxDLRs0hhp03vOL0ywtrhEFhRWN7TB8uVB60OM8EO+Oao1A8XNuoI1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdzrrF3oQfQfLIaX880KECXWGIHzeF4siwn3PikOpQM=;
 b=aGrPyaMBIb8FDZ8ZVHTsxJpXSAod9yN82PjT20n9t8IIu3M75aq9Z+9Mk32qBuHSuk4Q5fJl2EtfjE/J/B2g3Iftf1qb5YridWrJ9Kp0KCJE3MHRbgZSkDzv8Z8HHrUptUgIkuujzhxdeFnyYr12b8QT7S0FqHZExH6Py0MMzWn78rhbiiCB+jGEegn5hhA8Fr9A1wO3xx1WFOFuTBZIQ8u9k9gG/pexDjSAcqugIO8nYdTazs6jTnYs1ejIjYAmHyQbrqqre6tNJh7hFSa4tn1T+Z2wFjw491v8MHXl3r6hMSg/dq4cGlOyrg4nz05t27m6dJplMjidmNUo783pOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdzrrF3oQfQfLIaX880KECXWGIHzeF4siwn3PikOpQM=;
 b=W/GkRvIBhZ/pmRgnwmFffC4DSe9CW/FpLkr93hP/nl+EKhwNOoETvQdm0o7j91tJfoUYiPHnCoy5S6bwkuStKB4mXVMaIVWkoYsT+DI4M3EOSYMxeq9wmbQ3S+arQTVymnKzeq7o2LKoMHANbMbTVVxmW/bhrb2il7/T31U01SaF4k23eCTAI2icJe1HTLny9pHcohacIOmBixgiQ30KdvEzQlIF3pYUDo5ZhpPWQsR6VVJRT3NcTE+JfK0AzKrIy45clkxeTCFCLAU4G/Z+FBhuxyLv3l2VFnz1ZzAmp9oPPgxs7w2fZYJ5A4ervE319lfQIvgCNt6ftmmE8/jv0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 03:37:02 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 03:37:02 +0000
From: carlos.song@nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	frank.li@nxp.com
Subject: [PATCH 3/5] arm64: dts: imx8dxl: Add LPSPI alias
Date: Fri, 18 Oct 2024 11:45:30 +0800
Message-Id: <20241018034532.2552325-4-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018034532.2552325-1-carlos.song@nxp.com>
References: <20241018034532.2552325-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3937:EE_|PAXPR04MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: f22c37f7-25be-49cd-f049-08dcef261c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RbjvSjz6aCBWy1RvOfWTv1UjYVrqQgDtzdqoLn574e7tAnOczpdALI6GZEKO?=
 =?us-ascii?Q?UO2o0GUoMitEypQRzSIy9HKiz3gbU9umEXJ54gPCb3B/c+ePHlfHpzIwUGHF?=
 =?us-ascii?Q?LGOZdxx+OA+UDR2Rfx8Zv/3oecKkkPCrpmHgSp8NKbU2YWfYD9wNgnZyjTqn?=
 =?us-ascii?Q?oddUt7keR718Ix4KujcC81cBti40yt20EFKTLR/nAVc/5jWwpmG6VR0Lhw4n?=
 =?us-ascii?Q?f2mTXXlCTXOvct/l7xd2vG4GfpDe0ZY/vpzI55Xsx5J8nHu5k1Spy1TCKBJX?=
 =?us-ascii?Q?SeUeZNp7koAlQz4v1Q/2V1NAfhDkDae9ZQei8/iSsYJ9A8RPpZIgUUkKt8VT?=
 =?us-ascii?Q?FxDQdKVO00gHvXbVpQvCT7+ISjDJAQEpn8EqE3ho8gJQPtmIoq26RLzLe83D?=
 =?us-ascii?Q?9QRhAsh6AoURLEtQUNA4iddZSdrAgnQyvLFfoUtWfJQ2EoJhN4IZln4QhJjT?=
 =?us-ascii?Q?UqRr9+uym/FcgBD4PzV1uQ6SKpWugkhI2UK7y85qi94GyL2rWa54KtDzpmuO?=
 =?us-ascii?Q?UBBibkWwDjeHqkNlieqZBiOl045zAfNhs5GO4yFAEnKVDcU41VxZ0o/j6UxJ?=
 =?us-ascii?Q?pdP5jbbaefYJL/n40KkFl+l6Cod/5O7GOn8qhPPt9FR0JfFHaTIZUTVNce2Q?=
 =?us-ascii?Q?oUF7xx08QTrPS/8eKhxjlNiMzOx8hkgx46/DIzoWNre7HeD/6BJd4c8JcVn4?=
 =?us-ascii?Q?czCfBSc0lFXlgeFaIc8wcpYEyKYsxWif25Tcc255Svf6NR5CKUrte8ePlomz?=
 =?us-ascii?Q?hWBv2Iuc6be809Y9Jz/CGtZXHQIoUWBc/vdo8rtBxskpoK8Yx0bDK8Ubq+fu?=
 =?us-ascii?Q?O4RD21XIHJnfnO2CCURMckLupMVnkNuFoSrKckEtFfulaCpW9hkUr8jmtVxq?=
 =?us-ascii?Q?6om5r7am8cgY3/x+LXH6/L7LuEpecUv5GlJ47oMmMe94vdlBQvnTJCGn0JeM?=
 =?us-ascii?Q?eeNxv4g1uxjSZVaXIQ+PBy8XlaRwjG+4hS6B2rX39DDdIXkpiBXpfgD5KRwX?=
 =?us-ascii?Q?57j4cAeZCyGGepr6QcUVnYB3rpHvMzVXqXXz2DKqtOvz8dismlv+JFZc6y5H?=
 =?us-ascii?Q?YZUblWPo1uXlH1wDhgtjuXgokutwNeaWeBVvdEhuOdMQAydZ6ULgaIDE1Vpb?=
 =?us-ascii?Q?w2f+3cqm4S4sW4rqK72mTpcPtVNxul/UHwS9sZSooXQJ5IvDY+QyGyOTZgw5?=
 =?us-ascii?Q?d2XIHgwiWLPX+fYTx9p4h65vet+kjT0NYQX+Mraem2DovbTgRZNRBQ4t982W?=
 =?us-ascii?Q?8JwXgLLeNXYw5B+rE0ft7772676b4TNIExTrRkI3f/Bg4rr3rDj2zi1dGh1W?=
 =?us-ascii?Q?p607DUdZM0PnkXi7PbsSqswTsSe4jR+n6Lye6axVHk+CO2CsUZixnylCe/7e?=
 =?us-ascii?Q?QgPzGdw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gHEv8rfvcOhg2r9saroNqIqLDbLNYkAP2DJZjpQPyE/ZR9i+HfRqF1N+aL4T?=
 =?us-ascii?Q?33H9ErPEeIjZSgM+KpLpccyZ4beK1gRgOwUYWXqlFrUr7r2VYJ4vFsl+mX85?=
 =?us-ascii?Q?8taXDGt2+38msIZS7HFmGg8pNYEBsuqRI+7YqLLKSrslDxrVaDYLlrgKePqD?=
 =?us-ascii?Q?xugc52TTZU570d6+vfOVATvoD7F7mO73TqzxnbfG2cocoflWBqHVK+cZYNmW?=
 =?us-ascii?Q?8pZoVL2xhl9fwSdbZjB+RJowWYVD9Uzrcc9p93N/yQ9L43q6c/vvKooBOOsR?=
 =?us-ascii?Q?yI8aGSAcl0sLGVRJAcPP6uf0X3EIS/Nzrk7leORJKLbcW9pzwQNWjpTpSmh3?=
 =?us-ascii?Q?LStXEPGAeLII6SZrOLOgU9LnVMnIVJcIx0m/aiowd+XsnogqWtmDAgQRKWMW?=
 =?us-ascii?Q?FD5FLB/zwcAtHietQ4mN+KAV558K/NlzY9+Cjgn/LMNrfiKqorzFdoHt7RHW?=
 =?us-ascii?Q?hbFNeBHcC4z49cUtrvgypkLPZdU1yXCDzH6UHwN5cvjrw719+Q5O2yO5eRqS?=
 =?us-ascii?Q?ZouCVwdY89pg9eZM1KngX3kPEf6ElzeiGUuIisxNLw6I52enmngasMySKe69?=
 =?us-ascii?Q?XzDEOt7D9r5O3iVZkQwqsQkgfL26tyL2pTYom9JkNq44bFvi5T5ciP7IFAOn?=
 =?us-ascii?Q?npJ+/dhz2yjSuFRg5USH/QkfIHMOh/mYCNPZx7LjFA10a28EUKYYJc/3yCj+?=
 =?us-ascii?Q?cT7GZ+5eB00HgqJai6llHDpYItBviJ6W1Xqa4ER78bfDqBw5L3mJd2wUpYXo?=
 =?us-ascii?Q?eu6i5/UeBqZ5cZVDKsuUn0DAdHOEzMOHGarj7sIYtG+gr7G34gOHOIjGNbfc?=
 =?us-ascii?Q?MBe1y4bX4xNicFXq4WZSeZbPtHDqt1Kw2vfcVl6gJ6ncnj7FLYYp4TaD/q9F?=
 =?us-ascii?Q?qH1O6yxvnw1lJnQlzmqsrJbMTJiG+Mhg7ayFZxsRDCg04BSM2ihbUSw+C+Ao?=
 =?us-ascii?Q?KFCASjPyLtmKrGxjtv3fpc6yQu+eNCnz/BsHnOzdlQXQlo9/N2VkOxFfz9Au?=
 =?us-ascii?Q?vGHoMk+RDQgKoRQFwab8B5NsvPvbOP3fgBPUESDrPiOmAdKwJJdc87RAjg1U?=
 =?us-ascii?Q?f4SfOukRj0jaUEItarJndQKi1CtSz9jq8bs4u5+AODpOua4/nH6IgXKGuO/o?=
 =?us-ascii?Q?2PFkRBttsNLglNX21GtEn6l2ea5nvLvx+YHQKSIQgu6aLPREu8wLe/Gh99b6?=
 =?us-ascii?Q?d1Bp0XoxST2yazyCUofhMGlJR+bHorJtBn4H3uMBXZKXR7akGL02T1HgBrH7?=
 =?us-ascii?Q?EUNrL35w+DChr7+EjqAWSI5pDLd0iDipUr0sjMJrh1cLAGs5Lvk6mOnjs08f?=
 =?us-ascii?Q?gdtfRdbRowcubfAgBWuK53mD26Ynimpuk/YQ61sqdN3DnHSdQyomB5XoZWBd?=
 =?us-ascii?Q?Jay+A7PFTq5UgjSRSsyPJUq119gkP/dfafYFuAhopvwvSVcLZL39OFh9FoTF?=
 =?us-ascii?Q?ZtNxe3BdHYFkxZa3155xEIjDFcsc71bKz9uXqCy/YFpJfv1Jc7u1P0Zc+6OM?=
 =?us-ascii?Q?fS7x6x59XqJ/QV9+SW9f7CdvCy7D7Z5U0tVTopbfiguIhck5FO9HAszUXHly?=
 =?us-ascii?Q?hWlutSKDDuAuSkosjKkXCstEx4S+6mYChI3aEP8u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f22c37f7-25be-49cd-f049-08dcef261c1f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:36:54.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4uZlgzdeMUOsomCXCwhGRsz/FNnWkmAVb69guIAAehbaS8Ks5VSofW/cZoP/XXFts/jWa6t/xAa3A0d+MDVJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

From: Carlos Song <carlos.song@nxp.com>

Add i.MX8DXL LPSPI alias for kernel LPSPI driver usage.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
index 7e54cf202858..78dcdc132c58 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
@@ -30,6 +30,10 @@ aliases {
 		gpio6 = &lsio_gpio6;
 		gpio7 = &lsio_gpio7;
 		mu1 = &lsio_mu1;
+		spi0 = &lpspi0;
+		spi1 = &lpspi1;
+		spi2 = &lpspi2;
+		spi3 = &lpspi3;
 	};
 
 	cpus: cpus {
-- 
2.34.1


