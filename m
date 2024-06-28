Return-Path: <linux-kernel+bounces-233849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA9C91BE29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60841F245DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA0158219;
	Fri, 28 Jun 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CMiSEvrP"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2087.outbound.protection.outlook.com [40.107.247.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F3481A4;
	Fri, 28 Jun 2024 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719576417; cv=fail; b=qVX2BC30kJBsD9RI87h/r3smW1NwfGDAYSpOy9KCJXlUsMLjSzKA5OXZsPlJQH65KxEk0O8PfrC69M9P17LARPl8/uOK5TtAQEzP5pbXpP2EqZCUwwrwoJn345vLYenEOqk4GHwJL8Fc9KVLKJnwINCQyPvPmc9pp69CLBo3JVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719576417; c=relaxed/simple;
	bh=wB3vAkX3SdSBXX725bsCBgsvo5Rj8Ym1JJBAIqKwGK8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pyeAqb707iygG5HlzSylZ9EvJY/3NbeE2AfxxmKq6vz9T8A7bbNU1sv4AfCL/yi1JCdxKFUlqODD0Kj6qhrBAaI83/5v+f9AF4D76KKjnrvJnT6IFl6FvuV3MGylzCx6COuRDVpnWJFHnlXGrYzYgAd+dEAfMD6EUKE2vNowtCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=CMiSEvrP; arc=fail smtp.client-ip=40.107.247.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJiqjGpN/2INHgMyqSiW0dDlRTrVPsGhk8lCGI0Qt5xBlzmwfMM6Gt56DHEtCCOh+vTlbivzUYLdy74XGgOW0caviXvfmKaT+N99U/T3C93aaU/2dEegtEWwNvgkMXGvKE5qpnIXWCG946JnYl9EOczfz7D1ZR3XgTTVl2bDtj2O1b1nQ47VYcAoxcJ6n17qTVDnsj1Iuo7ijq0YP6cLm2l7aUmzgcywF8SGrD9RUpNyvAowTDGMZKNb791BSS0/MINOmNtU3axPVGmNLYW/frVdpEuRuNwGFWCNvMN5jGwYjBhPWEdwrOHDV3HJOBCsmvdRFyTkjNQooCnhZFKBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53LRiyNPFHpoF/pfXsog0gbQxi85bVpalQVFsJWI5Vs=;
 b=l8wHWMrvAQcfKkEi8N7DmMOdGbJlz2fK8htZutMZfLFnguvMPIfq7JlPh4oYtToKKASjgWI69ycotHrVbJTWGW8lUvirqLjQlZaNgI5eKvLHloDtUaJBoqTusWE4L85mH1NL65v6+Ftt/WdZqPM8Spl6JuguXGiBYNIW/66Msz9Zx1sbqqBd51AnVMQanJBjLXqVq+xkWZdu1uB/PW5l+yDaml1CcmHG7iTj4Il6eOOwZwiHd8Bc83tJ3Hz47/nuYNLt2peiQKdx/yllrW8672yYYH26TBwAiNwLnJmJfMuRx7r5vYzZyEhkdw6iJnXZWe6gmrZCW/G/MDKcXQeQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53LRiyNPFHpoF/pfXsog0gbQxi85bVpalQVFsJWI5Vs=;
 b=CMiSEvrPCT8PDu/g/EEGnXIS95Q3jWKmf/inlGc/ed08O/vo646FMiyLzIM2gNxNYqSWg9hmCtcR9kfgnFxmKMAnDRZV0bg5ppFe/tm6soE0NXeGpuK5yt68vJidLJUlcQUE01cE0ExIU+oBbYVRuj614NYpQYBS41nCI4lzZic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB9279.eurprd04.prod.outlook.com (2603:10a6:102:2b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 12:06:51 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 12:06:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add i.MX93 14x14 EVK board
Date: Fri, 28 Jun 2024 20:15:41 +0800
Message-Id: <20240628121542.2000184-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|PAXPR04MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cd091f-9e1b-446a-9488-08dc976acb41
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avGArcsVfWtg74jxpWDCNI1CtQ1uX2uJzOssxup3jF5KkfnRyo6OivXBHa1x?=
 =?us-ascii?Q?iaX+N5oVaW2/VFdTQTVgfkie6msbVUwvjMyW4wbUj4clb+1jIMifRE/UgiiC?=
 =?us-ascii?Q?fUPuJXZmIt1NCdLb638FUzRpZRkz7Rut6b1DIPhLyU733qwp5BFcuUebCc3F?=
 =?us-ascii?Q?7Bc0XCVhPm3r78NfxDlYxcwgrCeQmDGQ1Zul3kxXYPjb/1bKiN6IzgDiEI7B?=
 =?us-ascii?Q?zbcaZMn67lag45Whd20J5mfwytf6QGJydmUErXmTBq2i9z1WZNepMIF3R+0G?=
 =?us-ascii?Q?jAAEQAwlmafDHrJ28CZO0Xn/tNSTIv5ogcT1Xks6/Z8HUuAIZByFv4FLXHYQ?=
 =?us-ascii?Q?Bzz6oz1Jqm9+7ky2LUZVIEnZq7lBx+QMw1ey0n6D/PKGSesSqWtpPGAgs9fH?=
 =?us-ascii?Q?ggDzp9mzG1PBbJNj+QcqwAr4ZHdy9e3nZkS0RoH/V0VSQ3GC4yEDy8Du22AB?=
 =?us-ascii?Q?4K3+NfOBqIF45sAog9AF1oNeuIzJ+zBawz/w72ZqFDytgwDRU1/C8ZjFYiAj?=
 =?us-ascii?Q?DDP1f+YvfnsUnk2ErYh9NFZUo+gRvieZAT8ypwOifHgoUGRGMJWLR1voJurO?=
 =?us-ascii?Q?4nXz3pkSNjLjiqOQkWMoOUDhxGv1ZZ3iUWJ9B4jnfndeLNNEMDnQTfIP0XYB?=
 =?us-ascii?Q?PRz1uyB8HFiBXlkyTrnbgM91WV85ZwLCShy5Inujmm5ny7CmERMPC6Vfm0X6?=
 =?us-ascii?Q?lohJHf9sqf7KDvlqBv3QxhyFbPkzoCMC5oHM5Ohr04sVLYPjH0EAPseNAWMt?=
 =?us-ascii?Q?SEW7esUJfqwKtrkmNxMDKqaMfZhPHiM/kmzLg4/bEOWZ6hY1Gdil8oZRK0Ak?=
 =?us-ascii?Q?LF9gBT5rE3Bcv43EP452jMapukA2Yx6WS5cE3lk3Hc3CqMlEol0jN23CI4xY?=
 =?us-ascii?Q?t/a2OGFxcyWqUx7LiqhmIYMg9YmR7FeJUB4myrRWxlLr+qx/cWQBdVqldQG6?=
 =?us-ascii?Q?Gvc+w+Gbo1IQaNhIzhnd3egPUns4oNEAs9MpBYTni6tfVw/zycdD7YgmTw6M?=
 =?us-ascii?Q?h+/22Aaa9O7xOTCnUfsuG+i6v74D0HhVOx7ZcGbNfr7JtDC0b/A5YU3KmYBX?=
 =?us-ascii?Q?9iyf9Gas4/ihW6lyAN6FW7HiyCwYPyWxJwEzYRWZWg9dKAxI+at7+CNdIQiO?=
 =?us-ascii?Q?leZCZ9ean6lqfGxJ/DStsFU2dKLVM/P/aFuXbb5+nHpL5eQDbtaH8vKHOs9Q?=
 =?us-ascii?Q?jTj0JgJn4l9IIsum/Z/PB7GjUzbm+Z1LnwTFsAELr/Erbvg7V1wDsQx5g25d?=
 =?us-ascii?Q?/w2cas8N4TKpUy8k4gqguC5mGCHXWE0yyAZnwSnRBQDDDvy7RN9BFI2qEu8C?=
 =?us-ascii?Q?beE072vbuHNYzQ+41kMnIThBhfnFfcEOFJnIeYl0E6QAdGH4t0cqcCezrRGD?=
 =?us-ascii?Q?4GYIB2i0wbp0yoAiKrMz+IV9YM62/pkKc+02CWelrO9EZs18Ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqr5aO43tQLGaxCG4PXi3eTd/AYjsgGf85Ga5tD52J4BemOC1pX0/mZEQnso?=
 =?us-ascii?Q?Mo4wvUCMamm/Jy8/1sDnWWOwGA2hkKWQX7rRonKXw9I85u28R2tJ+6tb3xZr?=
 =?us-ascii?Q?gsGzjJlx4lndr+Uj8AufbTdCXjD/K0u+5JLNRoASBmLjd3iX0jYYqBpCTr6p?=
 =?us-ascii?Q?bYoy0MSFD8TKzqG/vaqQ5mXRr0WmvfZVH9+GFBSec3PiIR+pqpCXHMXv6z33?=
 =?us-ascii?Q?zWo8whWPtRJFlWx5xOfBBW3Hz16gJdUm4GsxOdbtSkFBsDUxXeMF8rXYdb6N?=
 =?us-ascii?Q?Ry+8u3uiNqPc56r0Ovjx77WT8bmh8EIX+3+TrXyfO6NgYdu8pXtX4YEz8oJ6?=
 =?us-ascii?Q?b2BpV7FJixbjtTSCrkEZSmfbXvaYOlWHR06V1pyEQoGhgyZJf8j27yU8RbhD?=
 =?us-ascii?Q?kJXAPOYUhfY0baWwqLC3XdlaAEOk83wHjkF9YTXfjD6475nUUphMqUPaBjIg?=
 =?us-ascii?Q?mzOAm88pXIaWzm7Po/biDT/fVx7mmk6yytTUdc7lpJRuLJtLLvd4vye5OOSO?=
 =?us-ascii?Q?eZ9t6/LJEOvsDYvQq/cCtYo/52Yac5jF2vBgtqu0DFb5o9ZjacG3j/t3ywLS?=
 =?us-ascii?Q?D+eXXTFR0WclIjV4+zf3O9Cs5bIhL8e8KqEr+qxDyQdZBUM8rN4MS0CDKSLB?=
 =?us-ascii?Q?4lIORvdp1MHn8LPhTX49O4oEypMopZ5BmTpv4Sgs5D3mhLIV3pgo2/TL9M64?=
 =?us-ascii?Q?6PxeDq8OqE/91G+VNa2tCXDDXOfYGKYYuyt7jr+ee91IbEp2xfqh1ilIzsZT?=
 =?us-ascii?Q?GL+/3gtNHvD2dt9YXi/KCqOtYKismYF05OHVr6Aov1DJJP0vNLsY37FHgQPL?=
 =?us-ascii?Q?wejYHcPxYeT7sPzRLBm4RaTUruYFr8Ne/oPV931WcKeEbRrS0bccaLn2HBbh?=
 =?us-ascii?Q?pzeKAt5QLkhgnvOmiTL9CDPuslPvz7j6f8V7cZaBlBsixcxkfAi3olnRguhe?=
 =?us-ascii?Q?e5X+siM8JAFoApO2EUdlSDW2gB/jP6YP7OlnfTrsVrd879JWC7eea/GTo0Br?=
 =?us-ascii?Q?EOsmYOIIMHMYLaCFZKJZ8ngHfgyJXKCirCS/0dV4F8UbstiSfo2dRJYv3h3O?=
 =?us-ascii?Q?LkhmrvIEq2T8fIMmcWH0u2sVUza0y/q+n1n0tfV+V00yIroGbEcjZefjsH1o?=
 =?us-ascii?Q?oiDriy/sZtO4FKrj2cwbNaf0il92nErk03xm5zqMSSam25bjIPTPD69bL94r?=
 =?us-ascii?Q?gRktYB3IUHxYv7b2wuWxGgyGTn/RDDPZjSiB6Det29PkDMkK0pTwq9oAXdOE?=
 =?us-ascii?Q?Rmrr3YINmnALV4iIJqq1Tun8/8mN+E5AcGnf8Giq9pBtYB9aLCmtpA5POvRs?=
 =?us-ascii?Q?3pvNkf0p0KvFeKzTpE/UbOskXB0uH95PPoR9mALslAnBb3CR26fLLxNXYBgp?=
 =?us-ascii?Q?fzL7vAde2c9FZT0sNG4SvWamhVsmYH6bbJg93s116VgcC3gaKK16k43J0p81?=
 =?us-ascii?Q?aeThfSX3mj1PGAbT8qHKD2MQILWI88dOjQFck3EWKpeMNE5R5opxJIpwSThv?=
 =?us-ascii?Q?H/zmmaNu+kgRPZ0EthtnHZ881+yx1j4DkpI6dhabIlLL6ieRAU84m6pZeOxW?=
 =?us-ascii?Q?pnKgFXAykD7v2zT35+ADLfR8155xCtFxeaEXlyOy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cd091f-9e1b-446a-9488-08dc976acb41
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:06:51.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBffPnZKfHJPl7aVnjAn5qXcJ+QzJS9wzGex6/b3XUskhmOpk+5nMeIRl3d9SIfHJZHb6Vtwd902t5ihQ7CAAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9279

From: Peng Fan <peng.fan@nxp.com>

Add compatible string for i.MX93 14x14 EVK Board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 80747d79418a..1abdeb804468 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1293,6 +1293,7 @@ properties:
           - enum:
               - fsl,imx93-9x9-qsb         # i.MX93 9x9 QSB Board
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
+              - fsl,imx93-14x14-evk       # i.MX93 14x14 EVK Board
           - const: fsl,imx93
 
       - description: i.MX95 based Boards
-- 
2.37.1


