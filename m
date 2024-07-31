Return-Path: <linux-kernel+bounces-269967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4526943969
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135E61C21C42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D9716D9C4;
	Wed, 31 Jul 2024 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h88Wp3Jf"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834733A1A8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722468729; cv=fail; b=YP6fIpyzeIF2Oroe8w4ow1v0DGQmZiN3Rs2NdF0Be3wbl/jWxhMVmI0+q7Tu8QL9rAp46oAmB9Hy1BwpI41bHcdmypb51xrNuy5u4EQZbq2ZawY7pn/BqG/F8IzW/ktT3fnazGKfooEzbla/wgmCq0XmFWrHjoVEKmTPUlWzKkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722468729; c=relaxed/simple;
	bh=UFk+n68eg6OKseNW84t+4Btpc2eqSstFT6CR/iyammQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LyrQOP4LJ3WhqcwfL8r+nURN8LIeElMyBsh1Z/HEmE21lfqcAevvTuaw0EyKGLRm8u/Frd7VVDdDgkBZKCXJS4/AhilonI9cMRRbtRXyYjsXHAjUV4UBAVeeJL2iHMrhDCP5eIoGZZ9meLWT5ElckBy81P1AwZaZ+gj3AuYCafk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h88Wp3Jf; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEh9uuZDVVOH8GrHtLfU1eeoCN13lhzliHdZPep2Y5PVeIMeLSbrcmAcT/KfDkGl1L83hw/euxnzHdoWldefRNB+Yq/uaa1INdoW8ViJ/bvMQgjbaa3C5FIfSW+PSKDdspLH5t7dfWSRkP7+KNgmLwdrLCb4iugmUI6nFKdWfHtBlMtvBEtVxPvVJVMzzpwit/9LSZTnpYV9tl6XoshBguwupAOJLT4kl6txiRwqxYleidOtOscf932a7NZpGQQVLKd5iQFHGg2V+qL+06pOCU1MXspJiPvL+QuOMi2JtdliRLZVH/HLfLHCuVMBLrzU7LbwUImwRhpLDpgaEgTF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjY/IyLRX0OPpHv23KJ+cPTreh8+3AIUth6jgQTPGgQ=;
 b=GGevdAGtE3+qO+ixn9Oqt5qnzUbxPuCU/xEiGKS1oFp65wQqDqJcB9n02CH+6u0wBoqpA3+RUR7OyKFX05gBhBkgtzuNAotqhX5DUPkLP1Jlc7MaGUVngHlhnQGd88rLwg36R0sM0akEAMKyMacd6WxBQ8b9NYA+WxzMJCNfKr5pF8/lU+Hf9RzsRq+IhXU6M0byPj8DWlf+Bt1UJi15dpX/mqL/tMFSIci/0tg1xTIJhelfy2B/x4ga9DqnO++u/UhbALKyu1Jvtimck5ICmVTaR8exCBUt4Xrj2pGhVq5jlbAnpZ3ornJCsLDAf7LLYHrbqylm2jCiFhE/Mu/KTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjY/IyLRX0OPpHv23KJ+cPTreh8+3AIUth6jgQTPGgQ=;
 b=h88Wp3JfzHGxVBXqDY6teNEs1Q82ei06iBWOOSx3E9yn9PXQ5iHGWd6+3kzg2Wi3oXwUbZ+seIULmQVMQpKW8wY1zZyzisIYgiZ4K+AJq0rLnVOSKxKM1VwHRuGlqC7Ai94h3hLLu/R1es44bWtV7+O/dEmX24McLlNshk/Yp6mwAvRBVYXL6vCjQnzp/xt28vI1OxNA2w38JoIKFfHpO31YDHcFRMqYP8ncWymnoNIVB7fTcXxGLCH3sBTdRq2m4XM4kOY3RN9T1pgCTrDygk8RHumLvBvn36UTGFcsylcMBYVuEp+MzpVQtsqq2JDub+UQfObeAZR8A3/RDa56Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7796.eurprd04.prod.outlook.com (2603:10a6:20b:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 23:32:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 23:32:04 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] linux/io.h: Add cleanup defination for iounmap() and memunmap()
Date: Wed, 31 Jul 2024 19:31:44 -0400
Message-Id: <20240731233145.2485874-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3518f1d5-a841-4404-edbe-08dcb1b8fbf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yIdb+pZpXoKN7mNdztTfmX0B8O1luQZ3x3JmLHXu7wfciAM3oFWLmmr1GoXe?=
 =?us-ascii?Q?5NQtzHHV/sp7l1ZStfIso7bgAtj+BFucVjj4CSO3nc4v86RHuUOqGIEpr+Zd?=
 =?us-ascii?Q?YEwHUrfB1WRs0Ojf+Q+1ZjeQ5+tABsac+zbE3Ez+j+NC/QMOEwCPnxlkaQUx?=
 =?us-ascii?Q?YXZma3Zbqu3+jp7rUpf1eWtYcDsYEW9Y0pcKXh6aM1bCilhA+atrnm5sFjbG?=
 =?us-ascii?Q?laBWbhnLv69UR9BAuIIGLrPSvIkwOpIBiEXCQoA4E6sbezzf0ZMoRq7pGHmM?=
 =?us-ascii?Q?wc0642wdutrzLo3/4shO/szXh2MwLkaxluxx9Gbug/QQA/BkZL65iDIzI8yg?=
 =?us-ascii?Q?t9BZKPrVM+LWKpsI+XIulou8EIQ1nEk+1JtDYQ1TnTScysLyZdVhT/QiDmAJ?=
 =?us-ascii?Q?8FyYWXd7jmNmd9KipIHmqTOd+/MqRyN3Q0LKQ3OrOR300ajWqtbjjRoIj1Tr?=
 =?us-ascii?Q?4e+qE/PYZoFrZp+DqO79uQ7XGiLqF0E9ex6SlhprxshuzBS9VmY6ftA55XtJ?=
 =?us-ascii?Q?ddxweRxkTMqeLeN4uIHaYneImP2zTzY8Iqh+NIkAXwHeq7lRFimyZ03qUX2J?=
 =?us-ascii?Q?RqtWyXkpRLBTXiWTZRQLmMqZpcZGCmnaAm/y5pZyAMIJgosvn51/kTg/R7a/?=
 =?us-ascii?Q?U4wIfXqxxMoTHA0ACIBg8zXxCmejHBJLiV1S38DNJKf5/rsMmpaXZ4XBRrHR?=
 =?us-ascii?Q?xmqXqAzkRLUriXa420hgGb8SsbRncLcfvO1ZFIruVADNf97JT2j6kNVR8ieR?=
 =?us-ascii?Q?8q2NTf7XRmvAJ00zZepl4yQZXUw7s+iwCE4jCcgEVXEog3pv60xkmeMZJGBN?=
 =?us-ascii?Q?s2S3DhiYZIZxju65HhsA+Njvc/lrq9xW4I8h2VY4cF/EL3C5vz8wCZHIt4yk?=
 =?us-ascii?Q?zW2KMBWFQR0PFD2VwWGLOmj25doxQmph3VeeiS0O7gNnBPvOzRnqb2CbXlOv?=
 =?us-ascii?Q?Tt6v8uHFpZ1R/nqtAQOQKHwJx8xMnP1birP1CloZd9xUhF3kqcdMv9549qxT?=
 =?us-ascii?Q?+OTLcGG3WWUzcww6jl71VnnJHlcpUXni/q1jaJgaNv2wY6znsHdGh19TZQSa?=
 =?us-ascii?Q?ysjw5rooQ+c29w3hMW8tHy9h5jmxmib560WIoh6RRfwnvwVVs19zXRuhzX8Y?=
 =?us-ascii?Q?85+IH+3BBT7+cIwjQ9LLcq4ro0qFN1PDYawmMBHJbTib8t9bObZHbDr+MLbe?=
 =?us-ascii?Q?8uQcJFT1xizWlJTKxzcWEkQ8//Od2NERHeK3LFiacDLaMhsUfzaT4wpRy4ls?=
 =?us-ascii?Q?aFsfTmMYq6g5H2Yzw1mWXXusyoKX4xaxQQXjy8pvnRWgWxZNkMzYrV5Q/93D?=
 =?us-ascii?Q?pDr8oPInOO/+xRk5PczPIQOO9XVELs+KLXVPN5v79ZOUyNm7u5+4EEfPBSjz?=
 =?us-ascii?Q?XSIIs8ve6ibocmg4pevpvDYy0pm1CtwkgsclGV8UhXzXE1lzOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bYnURl1mol82GhYU6g5n/j5EtrX2SlAIPQdCAuDmvXwuWeS9Uj5DaGKpitDb?=
 =?us-ascii?Q?kBAByC7Yt1Jnw6zydk2+rrFVsoKLasU4Uw7O7h1Tt4bJGWAUfk6r08RJmqK6?=
 =?us-ascii?Q?PmccEk7b0NDW1iD68jmJdKBt7D8tGbl8L1Tqc4H+XnFEjMy7y2mA2Dcz+3iv?=
 =?us-ascii?Q?ozowW0Ypb7K3j7TmMpaglRWuqjzIDMkRBS6JUBxGSA8dJd/bqRDWM4iNTyHC?=
 =?us-ascii?Q?oXePwNjXdcGGCS1QXBPKrCboV5l/HFoG5rKC80WDnbVqLCi4tkWhwsbPgHzK?=
 =?us-ascii?Q?4aj7KJCjdoDEuvEHQTkYUIscJaER3z6IL/99SpQDM37iCUDsWjgorTnL1Kkl?=
 =?us-ascii?Q?roJXcbWvJJ4YBNA3VpH7a/afMJ84bNQj0SsIUUGTi6qgpnne7P7kwrT34zPM?=
 =?us-ascii?Q?+9EMaiSrUBijpa69flQk0ClyMj4t16JRSL4qMoehLcJTNaci1t3DljxW7eRM?=
 =?us-ascii?Q?h24y94UUmTisH6JR5nWz8mEzVrkvf78D9oE8VhQoGgWBpQclHuv3kKkddlPW?=
 =?us-ascii?Q?ka6WR14dgG2TUNy6in9RvDoDnN9WVwiJAzKLqoZLXY7tH00XbrwVKfwswOg+?=
 =?us-ascii?Q?dGTgYfcxiLZgAwvPWjp2+RJxCoRsw3k1Mr5QlLWBv6C3pUepMpreN0HIOoRw?=
 =?us-ascii?Q?AYhQOMN7ED+DRkxSimV+DxIP/zLtxvcIK60BLhesC7b6FwjVZ4foW2th3iZ6?=
 =?us-ascii?Q?XVis4qGavni25faODvETLqjmd2XpnK1ekiJRNeNsZq/aXo721z/a7eibW8Ak?=
 =?us-ascii?Q?VNPfUvrmuTU5zMUx2a1PhT2WNAMIIhCWCvVU7QYA+vj7bwu2AeCzcPUA/fAt?=
 =?us-ascii?Q?tV7IxWeay3/fIrRo0i5tk5XVj5pHJiCMpzcuMcGTFheE/BhSBTsmmmbe1J5/?=
 =?us-ascii?Q?sgPMoGKBTpjtSxGfskzTEk/J1oGiOumCUAJ2Jj35/Fu8QFSW4YfJ5BNlQYkK?=
 =?us-ascii?Q?NQD/WTmCIFy6Zx/OM1pD9gcINhIZl0z6J6Aw8zKoyfwMoAU+A0IXfMQvPfuF?=
 =?us-ascii?Q?nI1h4X1d4QtLUaipsn0pgxw6DYC5po4jh/wTHdQT9p6iDwESn5B7btLdcpdh?=
 =?us-ascii?Q?K7s4WZqRqGCm8hcafHyqUHxeQ0zOFPVi20m7PWSGRQ/CbmmOixfJPIzkzmHC?=
 =?us-ascii?Q?0pe6/EBIgRH8ecPeUMxqF9uqYtKZAE9qLKT3sKbHdiUE/wbsRLyYLwKy9aP2?=
 =?us-ascii?Q?7ypKykfl+MfsKAcKc9tiKs+VWgI4Cnu/MiPu4/f+7/nnn0NE7cTBhbgjwccJ?=
 =?us-ascii?Q?SoU7OUrMVci7s1uW27GOWzyziTd51SpKVAgO3UbhDeGcdS049pMzCjP+JFem?=
 =?us-ascii?Q?pLw+Pg5jA5koA7Eyq/5K35gtQ7c9vbR2pwBMLCzATL/vC1ijJJFBVQFCp8ta?=
 =?us-ascii?Q?BzMMuPncTFKvDnADG4byFL/oRvgwe7LmHIbnLQA0TNwzRYDLNh4QIBgTW+Xh?=
 =?us-ascii?Q?PZTXxuFKgSyl2b7an4hpYQ6czTrXrwKaidQ9uT9cGQy42EnauxOuFozjN7tl?=
 =?us-ascii?Q?/grL507i4cIyUjq0LQbdyVqhIf/oaqCFv27XA1kh2Y1bJ0p+BBoHdsWow0bQ?=
 =?us-ascii?Q?4tOXFmnxgT3c5qAgGxE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3518f1d5-a841-4404-edbe-08dcb1b8fbf7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 23:32:04.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcQ4JomradGn0VAgxpmKiDRX90sqXYL//WjW5N4X3RpwqX15Hv9iwITwOnc46DEEj6KkBk8Gh4mO46jHS/K0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7796

Add DEFINE_FREE for iounmap() and memunmap() to support scope based
cleanup.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 include/linux/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index 59ec5eea696c4..7695d7973c8ff 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -163,6 +163,9 @@ enum {
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
 void memunmap(void *addr);
 
+DEFINE_FREE(iounmap, void __iomem *, if (!IS_ERR_OR_NULL(_T)) iounmap(_T))
+DEFINE_FREE(memunmap, void *, if (!IS_ERR_OR_NULL(_T)) memunmap(_T))
+
 /*
  * On x86 PAT systems we have memory tracking that keeps track of
  * the allowed mappings on memory ranges. This tracking works for
-- 
2.34.1


