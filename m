Return-Path: <linux-kernel+bounces-567653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D036A688B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C001B3AC73D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924B25179D;
	Wed, 19 Mar 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ExMhRaHt"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48122561CC
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377417; cv=fail; b=C9xcTgLQOfO7Iy3gF0nCctUJxVNchwPhIZwdLlLoDXW/2GJjQfeeI3zHO/UFVgO+yK2yvDmLvAF53DIHh+os6AgjJ5ARG8akZj2Ix/m/5piBaN0AWg05qCkoC8ZA5H61/BAAUGkxWv6juRISuYInNSbCA6JGD0WOtjTeUFL6ARE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377417; c=relaxed/simple;
	bh=u62WC6FGYATuVDguz51SVk/CI9ZQeiFV0eCAxxHixCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEJNTIH00YrniJVb84jVqcbvwRPuEbi8abBwnC2fkoBtXBiMsoR/Y+Ik7JHpoFH0YT/yzR/Eok2WA6BXZtnBlWDBEEnbxZJLIIr3Oq84jkQlzKkuCwOuz8pMMI0IzD+LfZSB8clFmtjXtXwKNgkoudVgIdf10LLshs4oZim3euI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ExMhRaHt; arc=fail smtp.client-ip=40.107.241.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fua2huKUdC6xw2EF8PGFl98qCj7/Hzo/NWjqbz3W3HMiPVJngB62nu22EEkomyN3XUO2QbMqyDrpSEtmcWS5rtygLFUZLT7vo3OySaOi+ev/w2wWh45cnYflrXgoOTbH2aIIXiYATSxbkzAZBvtL0Ev9Ap0C3w3epEs61dJxVRF4ScCSdZVQAROYW9H67z80YsqQuQDflHgf+nEIZRBGE9bJ3vBuNl/dYXi/Hz6ijU2o8nbanhaJPYJ+GQZS6HqFLmALv3RGPtrAXz+Ho/MmIcY2aVUZdKREHIv3SMLSMVf+ppEuCMOGdxHj1PIsLnf+SJlnupKupCY7sSipy04xtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3Pb65q2maNt9D17dexvMlkfRtAKCV/Nt2qVjYvwq74=;
 b=uIJSRRXAns0Y0+b74YgJkXN477Q/Jc3aHZK1e0iFruuxNzvjGt+S/dtTvU1iVpbP8EH1fMF92ObJ3XHOO4m0y+BnkNgl0HmZedW/DRrselaXin27FUq5wtuPGBAA86mlg64hYJYpf2j+dLkypBtL62b3aXJgE5eYMuMaAKonUrJTAib/8ufl+y5BAFNYwzkqxsRL7ZyqyzGlsJRDfVQY0x7ZReA+r3A9bvzcwUv+iUKI3qXjAHO25PorALJAN8eAhAivOhz51InIX7w0Qt/vJbu/YQm6J6LtyVPjzy6EgixmTD9pYzGDw6TIsYIMxXbD9twTHGaBiyojy6pPgwKXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3Pb65q2maNt9D17dexvMlkfRtAKCV/Nt2qVjYvwq74=;
 b=ExMhRaHtCup2J0or03AoP1FRhKNi1PGlWY/eUtz8TiP5VOeLvGAg50ZM3h04toyuE6UKyrYoU9YPyfTnd/zsb9Z5Yj/8N2u6g0q2LxoEFtyVX/rE5cMTXu4SblkcEgOTUgU4aSw1SObvUoLpywZvshUcNZetrar/YvTf7nwr3htFryKTjwrwA1axNkp+6xNNeTeTOzxud21u8VVx3IG5Kqv7Mg4p9fibgrb39Lmm2SvyJvqIE6ZlwbhXJrhm8Ho785RHNLDc5Ao/C6JdI91c3tFc4asyapw7zfq6LLMfjR+XAv5DpYJWTIMYUU8z9h/nmr3YhPar1JA78Dcq2TYg9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AS1PR04MB9261.eurprd04.prod.outlook.com (2603:10a6:20b:4c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:43:32 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:43:32 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Stuart Yoder <stuyoder@gmail.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] MAINTAINERS: add the linuppc-dev list to the fsl-mc bus entry
Date: Wed, 19 Mar 2025 11:43:11 +0200
Message-Id: <20250319094311.2966519-4-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319094311.2966519-1-ioana.ciornei@nxp.com>
References: <20250319094311.2966519-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::32)
 To AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AS1PR04MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: 25baaa10-b60a-4c3a-a79a-08dd66ca82e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiJgfZevJJt/8GDJrhOPbCpc20PbLQ67wti/2DeVZPO5HnccSQb6lb23L9qi?=
 =?us-ascii?Q?ERkGeTJ1thU0SzTPXrR607R3HP+MWKs09qyEjJxnu5R0sjGU7rmPCZUUie4y?=
 =?us-ascii?Q?bKJ5LcoPy46TxSMvsLAnrhBA68Mh2ARs7kiuB35Z0W9MGmOiR5gltYRegbob?=
 =?us-ascii?Q?h9QMNdNkBr3MdnW83uR314lm3yu19zdxLwV3s2Fy7aVfum0+WKiSwRv4O9VT?=
 =?us-ascii?Q?hN7IExsEsoPsPpTVNsNnT1UGw6V9ibbsiG8FDylrEkY9NNZfWhNUGtP/t9gs?=
 =?us-ascii?Q?IHv8nkoPWjIZaiBz/OwWIcXghd+CEpXuIKXd79r4/8Wdmydl/CrD/JDKUam1?=
 =?us-ascii?Q?OjoEPTDmW0f5TlQE3Yq1KSifvUH/QjZokiYVMRr4v6qRwiLkzta9r/4Xa+xb?=
 =?us-ascii?Q?KRsiS2VFPyings6RWi7GJRoIgOUgjNf0DR9SND24M4tHOotlJd4e0LQ1HnIF?=
 =?us-ascii?Q?ohcB1xgPukYf9pG6kQ5o8X98KqUVsjsioiC4dYDEYP1L5E6qdRGPat/6RUff?=
 =?us-ascii?Q?7WzckZ7wh6Oc2H4c+wi9TZdUlPFTkb0+OSuXWNq0nl6nL/3/y65LlsSFhy47?=
 =?us-ascii?Q?6CzW1FLDCB45XPRjDzbRnLvfoXZCjnP2edz0dkVhswbvWnItl37mRxrbygvH?=
 =?us-ascii?Q?BsFoYnSJC38s8sNa3SVDtImMQSJulkfzzSS7kmmV83fVZj6mz3+5kmEsgxel?=
 =?us-ascii?Q?lwNDOxk2gWVyeWu19Y1QQal8v7pxgnCXnCoJSiGPkOiHJB/j3OTdJ6DHkhsU?=
 =?us-ascii?Q?v0dDNxsPm3ICzsaJCsMoPfTzpZ/4YQ2CdWSNQ7PW8rqARiemsDr9PnQ/eDj9?=
 =?us-ascii?Q?up7yCNce+/WRYv9Fqf/qAf4TTytBC66Jzgzi/948tmua7KfqJOpThaYcryQ0?=
 =?us-ascii?Q?tBJjnlB8l7qguaDq9oWX+/Hmajahc1X9QtkW4qZPu3I/p32acyyLgeV44bX1?=
 =?us-ascii?Q?X+qBpXdhkBmMAWbf3/t8Qxi9ktMHbaLN5+29aHvhGFCRpzImhE9a5UlaKjGA?=
 =?us-ascii?Q?7Dl4YWOMmcpnd49KSLnzz0dW+VXXruUQDhygZx4D9SS7rZU21hcAtb/EawGs?=
 =?us-ascii?Q?DKufiA7fSfhuMAQxVRUfLR2fzx1V2DlfbJqL9tudyCOHMn8Inrz1FFln1Tsw?=
 =?us-ascii?Q?9qwGEoj0ODFnkRtE4QBw3MZhaLhzBrQnC9jSphXfRvl5PCJEwuai6IkZsOws?=
 =?us-ascii?Q?RbYVMr1DMwKKpg6dA14mrW+7fzHwXJE4h4rXCklrbzD0+mjHKw2MfIZmpw62?=
 =?us-ascii?Q?mowiWuRmnKy1nK3fvQFPCqTsBa20L6YideCXycT72Ced/klL72XQ2GdIof+5?=
 =?us-ascii?Q?im9PPXMSLjB0G0sO25ytHWa/q+O54wltGVvvUX/tu1R1qfQtUz8pKz9jH+8i?=
 =?us-ascii?Q?wDkI5atsx8Sv6qsm/4WosUKBCamO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Stoctr4o8dPDzBH1Odi0y7c3u/51Ki5kL3iLvhzUzGAh1kT4IqHwLeWEHVbN?=
 =?us-ascii?Q?oW/hW6Qnc1Qi3/1z4YVaJ4p5ORYekPVy9eax/rZU3i5b0tzSBH1Li4ObLpIJ?=
 =?us-ascii?Q?VOsc8iM7BTpYVA/ewpbtVqoQXSSyv8q2WEAAshqX85wN9ut/Mt5V/2z3LlKn?=
 =?us-ascii?Q?tZ3RDK2fq+ra17Px3onZgccdpiuBChonY6r95H9FGBSglx0LWTlN/WfuhezD?=
 =?us-ascii?Q?eKXAEFr/G3dMSENK//ROLixHd+v+S9grs4gbPQ3PiF9NNRrowj9p8ujS5B3Q?=
 =?us-ascii?Q?S5u8LJXMYDXOOgOOelLCVU5oWmv3ixXAjcsAY9LhrSTQSC5sHGyY5s6Y1tp8?=
 =?us-ascii?Q?FLCAHZZiDtmba2iUBaCvtll96LO7cOP5aQBVMNWewqotk3/V59FTumV8ocy/?=
 =?us-ascii?Q?okL1z8JM1BiLAEXnC8igAbcxH3kpSvhu8h48hD3ZfR+VaPyY0BN8orXL0FaU?=
 =?us-ascii?Q?ciFCmZcFG9nPBGqFBsVYukerp8QrlVdAEr5LcHv+8Vq4HlvdMb2imOcvBpEd?=
 =?us-ascii?Q?vs51vLAICU6VszyDyp5YEeboMuAZcfxm/7/+K9oB751mmObJSQim39uGSduH?=
 =?us-ascii?Q?S4dIvH1nzo66uljmbtc9m0hfRi7mgoHTeK7uD0tD232yblhdiqkFAtCzRXSF?=
 =?us-ascii?Q?+Top564L8lmFIpSrJEOOu1w7bijLQGdXsqkrYB6ZaZr2UiJQt06SRKVCK6I7?=
 =?us-ascii?Q?8FMF2k+9EFvu9a/MKGLZjmpQBkdKbiLRcuzZbWuChSVC6uteiM75bomLBq6T?=
 =?us-ascii?Q?O5Hn1QUhsAM/q8SiphU4Mys8rLU+z4YCHAuvMsXkkzVFfw+ct41xbGOdhdeb?=
 =?us-ascii?Q?1zy9Ijphue5kZGB+tjpQREnHRH/XAY9VwitzWwYGfr027veyM1svd0gGU0hA?=
 =?us-ascii?Q?EwIVrJNjOSZ/eGN74sN8390Ge5KRHaW/X+y+YNbiRzp8zyBuXLDyK+X5Nnt2?=
 =?us-ascii?Q?PRczhZCM78LTSycYTAGX4+79jKQFt0OmVklQSBtz6AcTr/nCkIRb8ODUtd7l?=
 =?us-ascii?Q?IdF0N/j3YKj4j44CtlDpXSbECfx8TG2W7RsFuBZ4CPZvmyufGRG8LGGMZEI5?=
 =?us-ascii?Q?AAaUdQKjkBBqZXX+00doXaOy1QYjb+AnxYp0XMC/7GenIQKSETBGMc4SbINd?=
 =?us-ascii?Q?NQJFpRxGODNipZMm8UOX2Dseseo4tyVuY2yANkjCz3w4tzgEJRGt4e47DkVy?=
 =?us-ascii?Q?xk8lCFWh4r+LUhqb+QyBqu0vQn+w+pnqzA4bd0KpQZVfWH82yy7dBSbZyxJi?=
 =?us-ascii?Q?h5WGC3zwErcuA0JP1LcEIhmsIrICGMXFcQQD6ZoqUOUu0kT7MITlezRB0Mjc?=
 =?us-ascii?Q?Y5yOPF3k3NSOp0tKPJxvUM0HRxn2LWXeEm/6og0tGoffOcvuF/0lyWoGFNOu?=
 =?us-ascii?Q?AsWSacPe7sHD0jryyyX6Nszwh3RKuyMaLB0n41yzdbkFxce1AqVmqsZcgClO?=
 =?us-ascii?Q?Br7o5H1GMG1zYPHgIAMNuKzWUZUQYN0Papq6pLbvX1+vWyiWmLx1PLwUmSSK?=
 =?us-ascii?Q?1fMQ42fC9aI+KkDs0JN2skHhcHkvJceLXAs8FSiYCSjfjCcmTi26nqyIQhoW?=
 =?us-ascii?Q?AwxXXb2/iNOwJOHVptHygEVtPKX6bruJc2oxpj57?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25baaa10-b60a-4c3a-a79a-08dd66ca82e1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:43:32.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNKT4jQwRjXEOtnECrdp7llILjpipObboRY0AQf8EE4p/P7abyExP2cPKYe6ZRZV+83ITNIU7g1ksFf3KP46zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9261

As discussed in the thread linked below, the fsl-mc bus lacked a clear
maintenance path. Since Christophe accepted to take the fsl-mc bus
patches through his soc fsl subtree, add the linuxppc-dev mailing list
in the MAINTAINERS entry.

Link: https://lore.kernel.org/r/1d822960-85a7-42b3-88cf-9d3dbc75a831@csgroup.eu
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e6aac2962dd..cfa6db4b6ce2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19634,6 +19634,7 @@ F:	include/linux/qnx6_fs.h
 QORIQ DPAA2 FSL-MC BUS DRIVER
 M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Ioana Ciornei <ioana.ciornei@nxp.com>
+L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
-- 
2.34.1


