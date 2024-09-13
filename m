Return-Path: <linux-kernel+bounces-328683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1E5978752
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E11F21DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A4136330;
	Fri, 13 Sep 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Pqs7hYDT"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2129.outbound.protection.outlook.com [40.107.101.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B70126C13;
	Fri, 13 Sep 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250218; cv=fail; b=UXWMFEIkM9GefXRYOzc+GSvvYde96AJD5/a5YE5tpGItLg9EOZSWht0rSMFsQCsPd1fWzhIYHhKmMiHtdbsrf+4iDJp0pNXis654cYIggDM9FR8n7M6x11y424slzLP3f8NGdAkDwBqomMk8n8vDmYtRolfLVQK8osTZVsdVM34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250218; c=relaxed/simple;
	bh=5vNpXvKShIhaO9eK/gPpGgy9d3nnpLZTwldol40bAI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+qpT8hfMwmx5Wa2VK5gETu46rc5BFZJ776ooJAr26vbHdAJwVyHBo/kSZ10GT+O48uFZrSaX3nmVAi1OIlhcXzCHfd1UuTBTUKpWZpP0wntVkHuW68yh39C/24NbMTVf4ihfOdm0ggKLmUrtOAqG1AZuvLJ+Pgx9SKu2kbpaXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Pqs7hYDT; arc=fail smtp.client-ip=40.107.101.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ibV7xjbBHzJwsh7suh7XdR+mfwdZzazlgVbCd205iy8XiGm4XtSij2I1TFgkn9X8vweZAHJGpduAqz6vF0URfLZdmAkAhiuZ0gq9L4Jyi6yXHca2RaU/z0faEpXAVqyLIE2c0qnL7ZBBk9GRtHxL3B676kjLpvxNkvR6sRNQbp9Kq21QcEIf9YQpP2RHjwiFfveqAeUvHsWn5nMe6+JtsfOBQLaYwnMwqkHJb6acx9iEU2dPFeAd6RxyKHXpzu+C7y5UsAFJhtLAjJSJeUzz4CeQikLVt6/TiG9O8eSNwBaRYhyFIlI6+HJ1qHqR5QdtSD5JuNf+l3AKzSp1uKAJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZmCYQXL7QxXJWZlqJNUMObse+9EjHGPA8gvbfnCT2Y=;
 b=KU2uexrrhjoe1QllP2yf8hojMBCHYrqfjAj3sbyqQKdV/aJwGM2ZnpS4ZE84q2FZUP0S2l0SZl0h3uXDvQPoTUB57XbEzt6suJChhu+zjn/PCJ1PmmuTX4cStXYwJ6wJsAVx8q4fcLn15iyC81Btu5CCgh1Nuk8jiM6J4kwjGOq4mDr+XEbKPjDV0e/qm70hgawIsNoSQIZHiIzR0ttjHVlai7ZCMKVfCNJR7NmAUv2pfk2S8CYsFvRTnS+qqfRM4UejoQUIofdaER4FCVrMbXKH3VmWpZQWv0kJB0Kj/rv+KsofFgaxRSQGJWMpdTg3ueBaco92L301/nHZxAU+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZmCYQXL7QxXJWZlqJNUMObse+9EjHGPA8gvbfnCT2Y=;
 b=Pqs7hYDT5Aid4aN57Cl0gPIlO8FFxc7iuHmwufILhAN0WTrrUIc9ozSU81LDkCxfFH2bIo6P8M5WNi+3sKQ7Puf6W0HUCYNO0HtH+HsAcI916jgZ4fbt5iO9QnrYdDt3Nie7VvYrnXpzwaslF8hwiZtiWtifwXKyL1an2ZSBlCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by MW6PR22MB4151.namprd22.prod.outlook.com (2603:10b6:303:249::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 17:56:54 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 17:56:53 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	w.egorov@phytec.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] arm64: dts: ti: Remove k3-am625-phyboard-lyra-1-4-ghz-opp overlay
Date: Fri, 13 Sep 2024 10:56:25 -0700
Message-Id: <20240913175625.3190757-3-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913175625.3190757-1-ggiordano@phytec.com>
References: <20240913175625.3190757-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:610:5b::12) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|MW6PR22MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 869b92f3-efbc-4a80-e0db-08dcd41d735c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yln1+GPvaajooVx1OVym/xam95O7vLx41VQSHpKG8GXQfM/um2IylbmzHEdD?=
 =?us-ascii?Q?FYCbg1faSFsl1IxlJ8Ciop+fTnooIRail2dOh60dJmotavw2CwOd2ofzyL/J?=
 =?us-ascii?Q?Xr/myGXo0zlpP9WLnaF+LCHUpITeQv5vTnFilRS3dqdamfboFAihXiTXWP1D?=
 =?us-ascii?Q?zrPqSSggje4PH5XycvxT8Q6PjbONaTYZ0eeDj5JIy0sJL3y19pSQaciDkf7m?=
 =?us-ascii?Q?GVIXfUnXhexSOMcEnbVMxKa5LwOL0Lfh+2KZCuYk5f/s2gXyp36pu6heAMVF?=
 =?us-ascii?Q?tgD3UBQV7iDLuIcSY3wyy66jzMpzX1OIv1OmCeKvFpoy7EmklxY14knjR2i7?=
 =?us-ascii?Q?qew9BezEYgHphVbAM3+wevn5NbYEICnh+viuOwKkhjCPlo4nKK65mfQTOGgM?=
 =?us-ascii?Q?cf/2nEy86bhTnuCYp6Nk44q0htRDwuDRat/RkDLOS8QMgxdeF57KPOXiLoSQ?=
 =?us-ascii?Q?JQdz8xXRhxmAp12FAB+IJIkdJBwREtZbTx5s+d0Ks/o9r0Ou5r4j69awB+ga?=
 =?us-ascii?Q?3gKIG482wHdH6yRo49xCx2i/id1wxsTpwsKB2PW2op1pgI7dnt4qEexbNoET?=
 =?us-ascii?Q?2i85FnYfH4KLQC7zclCZI+T1SzO3FC+TWTaoGQepg6b3cvrj9ELnShgYYh5l?=
 =?us-ascii?Q?AqhWhDgmAxGrlQFJDexPQoSUNEVRnFsl3frbZXJoXTUpGGBYNhVqtI0uPJLn?=
 =?us-ascii?Q?qubb5hz4WK3u5eGB8Dnacs8S35cTajFLs7pT+s0Inpy7ni0jyLa3mhaPiaXc?=
 =?us-ascii?Q?FuXXkQQEWdJx7nn/7ssAT7Tw7bHAa9RwTjKKmv38J1IUJgS981JIZsiaP6m4?=
 =?us-ascii?Q?Ws1wUUFFubJlxGOcxY/FDqEz6KGP4HHbKdxq4d6mnh7dbeumXWFCouTFjOpN?=
 =?us-ascii?Q?GRvy6tYop6GPGl0pFdwUqXg5ITiSCkDdwdBw+K2YfRcicCsRDfnxfYUT48ki?=
 =?us-ascii?Q?p30JZvDqGPj0grgtpPNQS4b8z0t1ACkhn0tz0N9hg4w7FiA2EumlykAKkhQe?=
 =?us-ascii?Q?SKKlXbWn7hsqIcx+vd2zWpOylXwhwp8L5YOk/KxWvhwUucX++cnhVKcqWA/F?=
 =?us-ascii?Q?39CSJs6CaDeK5hrWfZb4+tnssSwldRCz97mbe394LeHJD+PPprmD4ARVY6s8?=
 =?us-ascii?Q?SI+mFOW4aQt/gouqnkhCAXQ6Rwyg9MB4uWKrv5qEtLwrqH+WjJZTNUsjllj5?=
 =?us-ascii?Q?guoL7vSdcAJ1FIqMN9CTi+5dpnKTOdA8FtXGmCJr0JkgjAuEEWt3t94pGlQG?=
 =?us-ascii?Q?sebBKcxdWi8Ie1YQUyZgjwtYoOgsM040tn5T7Oelxmq5xu+feIGlhrQ7MFod?=
 =?us-ascii?Q?CnG4yi3ERWSueI+31QK0zM1lIF5eeyPJsCx/2TjO3pGCK/8Y9Z6dfGWTGABZ?=
 =?us-ascii?Q?5XLgBXiVg4TGVrIqKhWDTMCC0Y3wB9UxH1qoFMkQhhQbqDgPXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQbKEI2P7BE4AQa9/x7Coev3YxMaCdRQq3hX8LH2mWcHQFZOgc4qzBEmiMmb?=
 =?us-ascii?Q?kda+mRS1hmJWq6ocAclFtRTQsUcth5FmhnFzxbt9k/DxRuVRwm09e7ofE6CG?=
 =?us-ascii?Q?/skZc+MsHk7IK3pMkv0gnaFl6c1Rt+p2UthZny8rlcdbHTXvrwbynDIVfUpK?=
 =?us-ascii?Q?8KWDXmLv9FtxbO+R4om+r1+uyhbYk/7Ypy3O8xpICJSh9UHBa8bhoaaEogsw?=
 =?us-ascii?Q?dW3R3SpQiJBIq9uvpVCLVD8sPFlE4IYMqLlD5xqODdflFWmzmIF38biX6ECh?=
 =?us-ascii?Q?gAhXSgtsfGON8L27XgoUf/AifBOizPDNvPtnF4DRwW1EolI8ZOnRvnBc6lm3?=
 =?us-ascii?Q?zpCwd8szeDmGVNL9YE5gklb5CTRnzHlx8ozOhtrIF9WdMrYtzbZUEnfWKsJc?=
 =?us-ascii?Q?VSrrFXy1/5oFiWcMrwWiJoJNt28XsrxdlXHK9PwyBNjgLAoyGdT0p6svqmiZ?=
 =?us-ascii?Q?6yD2ZGk0TR4SITIOBbJzz+AGBqQZ8MHNh3OTY6qtPd+AHu+FZwh6ZBR+LRu1?=
 =?us-ascii?Q?TGF8EV/cVi2JQGsViy+os8ogWEN75T4Qkkoj7i5eyLDdPLkjcBO0JnLTWvtd?=
 =?us-ascii?Q?DVrmhD7v39qOl0wMi/nHaHH+b2ElnsZey5N6Adu0dDqSJGVxg2UaowabmcIZ?=
 =?us-ascii?Q?fT+P7NWTOzFEEC0aY1IQkqQ5fCz0awY7d+8Tf42lU/aGt+iJxZVBfVwzFnz9?=
 =?us-ascii?Q?FDU59HmXaC17UTJeXyTf/naJuD4Rikq3zjouBQnjegF6+vWNYy/jiYIg1eoD?=
 =?us-ascii?Q?219aHh4/DoI1TgES/dy3VVayGj2q/rq7SbBSVHdrKMSUFau/xbQyQmd7nVkL?=
 =?us-ascii?Q?tWr16F5mTM6La6UrKo9X/UxW5HsnAVD4mf4+9dswDyO9xZHKG4JtLkcAh+EU?=
 =?us-ascii?Q?vwWTqsxGN6SVFmkOj8c3yLf0i6oLJymifDrSWg5LgmpOo6mqjtnrewuMS0UK?=
 =?us-ascii?Q?8u/xZkXGXoNWP3leeDtdwdtQ+XEKMQdVhQ9YLP4ruJFpWe1UuADkOIVa+Mqv?=
 =?us-ascii?Q?IIi1o+rObCIQ/efZxpxKE76RTPZD7hhNloPxuSzzlpgfjQlHIwafTEIC5nYN?=
 =?us-ascii?Q?cOmCIYrIF6/cJfHIiiRvunQn3FE3l3/zd5WbEaaHJRP0yPd/Zz1cOl1dyViT?=
 =?us-ascii?Q?tB8RJJCpyqRtwArEWH1qkEdPtIg7pBRShkQHrG6kJB06LpfFgviOWnj/0+Yw?=
 =?us-ascii?Q?emYvUmbEccFt8+FElknsUpBptC9PvgKeY/pNhC0U3aJ46caVfWokOrr9AGcn?=
 =?us-ascii?Q?t1Q0UYcNy5DaO/gvDWvju7ILGV/FCoM/VQa/7m8JyDJYgVh9z9KNBF87K0eJ?=
 =?us-ascii?Q?Qku/dYuFRZGArH8/vac7Faavv6/XQ1m5XQ651KI95fp5RC+CMRW0wiZ+KYxw?=
 =?us-ascii?Q?yGYM2bzXSOjCZl7Yvd/ZS7JEBDgpgLYjDLU44sNkuHC2BY+J1Ec33GpPObkG?=
 =?us-ascii?Q?PUi16u3ThZl9Ha1GR2b3odwiB2tgX+VUyDDMO905W6p74l5Q/+gfQSj6qH7/?=
 =?us-ascii?Q?5M5Q0TWYOo86TS79IilOXN0cn7ypCFTSHXPjWj0MZ2Bl7ztjMQrkN2KuIe4T?=
 =?us-ascii?Q?HiPpnnq5fc2IfoV5g3+DtGZ9TZbdvDRWd2cB2bck?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869b92f3-efbc-4a80-e0db-08dcd41d735c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 17:56:53.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/Xdm8KWXzCN+A05RS2x4aujiJdylJ+GVlo4mjl0e97mCcQS4z6k1FIm6wVVGlAv2c0exsmwZNo+zHPZaMC+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR22MB4151

Remove the k3-am625-phyboard-lyra-1-4-ghz-opp overlay. We now
configure the a53_opp_table to include a 1.4 GHz node and set our
VDD_CORE to 0.85v in the k3-am62-phycore-som.dtsi. This change is to
match our PMIC which is now set to output 0.85v by default.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 .../k3-am625-phyboard-lyra-1-4-ghz-opp.dtso   | 20 -------------------
 1 file changed, 20 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
deleted file mode 100644
index 6ec6d57ec49c..000000000000
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-1-4-ghz-opp.dtso
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only OR MIT
-/*
- * Copyright (C) 2024 PHYTEC America LLC
- * Author: Nathan Morrisson <nmorrisson@phytec.com>
- */
-
-/dts-v1/;
-/plugin/;
-
-&vdd_core {
-	regulator-min-microvolt = <850000>;
-	regulator-max-microvolt = <850000>;
-};
-
-&a53_opp_table {
-	opp-1400000000 {
-		opp-hz = /bits/ 64 <1400000000>;
-		opp-supported-hw = <0x01 0x0004>;
-	};
-};
-- 
2.25.1


