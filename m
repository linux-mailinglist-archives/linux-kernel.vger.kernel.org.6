Return-Path: <linux-kernel+bounces-404021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEF79C3E06
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B351F21C99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065F19C542;
	Mon, 11 Nov 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kt5B2CzG"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DF19AD93
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327061; cv=fail; b=DYnM5ijTIvQIlvfoD2HjBehnbnXmaVAsW287lASTA7h95d/7dz4reETw12rddm+lbslp/8jwDbBqDfYsE37ZpYZ+Pg7f48ZNi5u5ay6d4YrqtCzxrW3pZBt6cT9Ci9OMiK47zi8uqIia3ONuDokVYoALqf9hOu5KK05Fp3wSqpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327061; c=relaxed/simple;
	bh=RUB4zyGxfIayHq3XuknMTd7GF//9SnsSrvMTUKZzAl8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R1ex52aeTswe8to4Yg/HN/KNlirmo0p5qMgVsP5yLVzIeb1lEOjZ5vFj3/m+ma4ZPSsc3gletcXbWk8H0r4D5/ijSD4U9ZGI8imFYrK6DF2cFzEPbocBTfh++sueZbIHHsXr1M0APg7axVEiZI8sYPIS9yBmF9XxbMMambH8FRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kt5B2CzG; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyitdykz1K1SZYlnO9HS5eRUO71Jlb4NN4E4wldr3u/SaeYX6l5TX/H4S6CFadvpHMurWbvHqFMKW33fGekIibejS4jjJhL1pxZZT6BsFybfm5fyaTmajlYGtYH5D+pKaAAVkR3iulU8RUJVyZkLP774QHxyWSTMIq3RtV3GTFvwpTy+EAysKsGaDdtTsZz0D9nPdZ4ZktBu+Bm67KTkyxCZVeolm8yore95WV3Dy+Kkf6A9Ng+joxGyFp6MFwSre5N4RlbGU3RjCKqUnj20sIuMCRpH3cj1j9bZ/4T1uD39/Hiiknx1NUarEwdP69Iq6bI2EemTrXaWSoUcxvzBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieqSFTh4KeBwa53tpwp0iUAhMivK7HpaO5ro7AW5n08=;
 b=l0xZOfkG8B1Toczb0IXZZjyYgshL/KmbzxiyfuWwrrlMU17nYUZ6m9Fx/UYSzUYKJt5Kx52IfCEkkugmGYOheZ9mkhnwzQMrJv4Gim5NACkR2RDBkFZhj6KQcg+ecoXORRtTURZJC9F9WirfV60xPRoSxu8nSnEC7dRC+0b/l0h1zews1aBGfTtjZ/IYDRcqFg7QZhvOhIUpIjvf6mqhbN38Rjz3nHbVDoKFii3FEA40ETP6foOW8QtySb/cr1wCRqW1Cm5ormhSJhuw1TvvjMHb7pFMmbv9v4X9Io5f0IGorZrlDcVnmJKDHZRKfpFnI4UrcCI7kofzpSqAAQDaLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieqSFTh4KeBwa53tpwp0iUAhMivK7HpaO5ro7AW5n08=;
 b=kt5B2CzGNMM1JX0ahl2qeMtft50xC8LhqLwC4Ly5z5QOgBR093HqfZn1wOd2L4wTFOfORPKKDUedM50mz2YmnbTqkexMdQE3lNm2iAcUypxwHGt2PIi/AeOIankqAI34UsDIAW7Eixzi9DX+DLqKDYZkwcyXNg4wDy67qRHpzD+qReVtYhGkbE4HFZhCoKXHyj0vVXjXbzFggirqWTzRYB1zWGHcyMfa5veFXD1EDnKBdNmryvfNpweEHU2JPAkGIXWt9tmwA84w6EAHYTgfOTqFW4BluT6fGnLQfYpbNCuc9aO4rINrWRLdAmnGsyF0H1j/TV9aAwVTuYJADUlC6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 12:10:56 +0000
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637]) by DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 12:10:56 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Silvano Di Ninno <silvano.dininno@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Nikolaus Voss <nikolaus.voss@haag-streit.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: =linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gaurav Jain <gaurav.jain@nxp.com>
Subject: [PATCH] crypto: caam - use JobR's space to access page 0 regs
Date: Mon, 11 Nov 2024 17:40:20 +0530
Message-Id: <20241111121020.4013077-1-gaurav.jain@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To DB9PR04MB8409.eurprd04.prod.outlook.com
 (2603:10a6:10:244::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8409:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: db1d0de1-0024-4e85-5a03-08dd0249e53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h96KtEWr5oSox34uxeMUuPCkdFJHaJ3d3xHRXH1cQHHKzt299cu2GvUz0xVw?=
 =?us-ascii?Q?tr0pA+uZliQhcIvv7X+VSs7T2rigMk0y7sMJfh4Atntrk4TGxN1JxZBQPvDb?=
 =?us-ascii?Q?fEfxRUusfRgJd2HIhY9eTqp6bBL0F57vVLNLd2p+xji1S+TJL1STcLHLgE6I?=
 =?us-ascii?Q?SOkFH9iW+Mnz1VhlzCe1YVO6/wJh1/1l1Dtup+GOXpQOzQPwJRVq5T232ZQZ?=
 =?us-ascii?Q?LNhC/3zW7qlvUmxwljaFJkTOMOBJAYYjc/a2pVfFA1HvmjOY/56UejuhlsNN?=
 =?us-ascii?Q?ZbpxKhS1R7NWdkFNh5KEySpXKhrnHZxcUNnpGOglnZEr8Hu3jLDtUJ7cLiwA?=
 =?us-ascii?Q?eDBZCTZRsjv7BDeyYoKoiuUIIjti+6TAtn8bZJ32+qpB9Sz2ipmaZ3ZU0VnS?=
 =?us-ascii?Q?Ndi0ebdGUunXKO0pAJUXbTtNS7EHBif5voXVe2c8G86ZWoN8TFWNGOD0uaS7?=
 =?us-ascii?Q?dXfSvZeqenAu6EBcj0sqdIuZipkiEaG2G96cleDjy8NI7gfsngDlgRUsf+w8?=
 =?us-ascii?Q?JZ/PN9S8Ykr3JcfQHqy1msQ/nDzh1cuhFuE5h8K8WAv8iihqc2R7JHmdTlsS?=
 =?us-ascii?Q?6ohVPqK+Lzod9rYr1otZn1cvgCrvZiid5iJlazt3SrRi6bWSRbhxG0FMa/Cf?=
 =?us-ascii?Q?B0K6QjHGmtKn2cfx0nUzWX5xjmGpfUxN/STHc/WoysjaXcu7M1RLVrGGNimJ?=
 =?us-ascii?Q?HtCgFOc7p/YMhmTdWb4NalQBUCYgiSDi5lwOLaVF5WyC5p2xYXU5CQl5wlbA?=
 =?us-ascii?Q?kxlSpYMbGtO77GBUvFt80rM0+ewgZiyRvwLmzAkVrZiU5BO/R7v2hWCpC4cH?=
 =?us-ascii?Q?Ql36f4kHzpl6nEAaFtu9gnhSqlonixsf4biMBOozeujQ9N7N+a4BZaC1PaHl?=
 =?us-ascii?Q?ioW7/9V6bdy7KVseT7DKk2IGhIrJfY5hlPihmZwGmoz+x9oOCdOAtdws1/xT?=
 =?us-ascii?Q?fBfpDjQgNAxOvHFrr1Y3qXmFKYDY//xX1lCB1bwAN6YGbmREo6qfVDb4I8nH?=
 =?us-ascii?Q?AngMNjwWb0WUgamXx+tnIupJY4BrdhL8KRpf1xCIZteQ+xzGG3KJwT8A8yUd?=
 =?us-ascii?Q?CONVQLK04zDm6lsabKLqyLWEu6+57aYdCc0oMPj+lD+c1M77C39xlYTLryPL?=
 =?us-ascii?Q?xmA6PhgD1LEtBJmLjbR83xuBLkgsdAngbebZ2Wvl4SuGub0EgCSOZ6JtD9xK?=
 =?us-ascii?Q?Idu7BmB+9oI9FEqtwwpS4no/UsKUyPR+fn8rSlu+Utc8aAIMsP3YMMwR1E2T?=
 =?us-ascii?Q?k7FFHAlDvFd4NiztJhXRxcw5+8Sg96HrsocGhomKA6/7BvKNX+AdmhSFYuBz?=
 =?us-ascii?Q?mnYlTyRnSofAE+MhBpdcnF5G+CL5OYGZPTmcB9s62RXZjRikgwp+tPfL3MB/?=
 =?us-ascii?Q?xg/Lbh0CRAvnKwVCj2iZUn4m0M5z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8409.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qs+6uFA7gXgcVQwPCwQIS7dWYeKOQN9n0Tjy82cLXN4vExJRaiq4ATAh1ynf?=
 =?us-ascii?Q?IKdHgDDaUwkzlKFzZ1B6Iik4owFvyfq0PF2Kd4bKjKmRjoMgmjSt5Li+YeEz?=
 =?us-ascii?Q?pxXXVHXoK0AtEjnhES3ndC1E3IpCUWeGSKxzi2DN28SvlTbe9RaMQU8qKDNs?=
 =?us-ascii?Q?p8mCXtH62njRldBdtLmqesKy0wNo9+Lzz4wUNw+vCHYVrkZt0Lm6so7O1vh4?=
 =?us-ascii?Q?RPB24bMEwEwSb75tSkYpZzpyunUn1uBKyispy4gNMid/NJUiO/683EYaKrkW?=
 =?us-ascii?Q?PE+AZfJTBxnMF9iVGflDiwo2rhKCjsHR8nLBrCm1cnqUDwc3aM8tybStEC3k?=
 =?us-ascii?Q?e4nBWC1gN4XX9rrR92tRLIZS9hQ3IIpLlTPjdTzI1NePeJMUu7sgoi3aAXDu?=
 =?us-ascii?Q?HyqCE372lVks9xNVSdEweH3FIK++keYCG9tvBG/R/f0En8oP1bZFg7we9uYS?=
 =?us-ascii?Q?Rw3Tu46WtjfQahOur1FNGt8j6dvHhQipBSpOqwhO/hZ/X5yz3OvSkSRNW5FV?=
 =?us-ascii?Q?gC5Kg9oDr/AdP/5FHFyQEqlmpYSfyjVc2NpfuXdn5xjQaNRIV88r5Sb4cLQp?=
 =?us-ascii?Q?QuRr+qp1q5RKrle7HHPH4lZ+EfN8IJtC4qfRhdpPucn0N/w8SbmIgx5dSsIK?=
 =?us-ascii?Q?938SoXFIfgmVI/n1ZNDzuCzxHxxFM1ITEQWYyYsrWz2V1Y5in4GDAZiQI7WS?=
 =?us-ascii?Q?6oAm82mqAi8+Abfhogf+3JgTADApR8PL2Wah0sddXo71AjyuRyjvJrw5ZqzQ?=
 =?us-ascii?Q?PFuwcPENZCDRp0zSvx0CSf0dCvUyvOvuULyMMoF+WvZ7EEYoAsS7WaVEJ3zt?=
 =?us-ascii?Q?cXHhCxvQQ3EqHt80+RHDtV4MC/okc68G8vdsfny4VvVhiW/zyzYj6/N71J5L?=
 =?us-ascii?Q?KkyeuBCGU7vzzSCWP4U6zTMiopJro906t4jYZjjz/LmEBmGRlrei0p4qxcUT?=
 =?us-ascii?Q?S0JY+6qsBuPPPS6gwdEtpAbkUzYq0IebPH1JQ+UU+a5kgJeMugzZkcHrHTto?=
 =?us-ascii?Q?8F2AGzzeOFCPurnJnpDWlSBIrDRCoA3q61hZCte7U9bIQVbmrqBAw6li6VhS?=
 =?us-ascii?Q?QeuQJ4LfqnUzIvwbh+g/ILcP+Y6rby7TQh8vbZyscvpymAPszTa8AMHyjW60?=
 =?us-ascii?Q?NJ1nwiGqS+rHFDOK8voPan5WknqX8imZ1P9EFhgcqU1O5lT0WlMTkau8dGYs?=
 =?us-ascii?Q?/B49imxmU6KkdtXR8I9s6MUXNHXtI59dqsKxypdITuvxZRcMN3kyD3aXXpJG?=
 =?us-ascii?Q?dXx82swSEClhpsjXpaX5HkVOYj6r8SVJHKTN0Fe6++E2LrKJa1Um3aHsbviI?=
 =?us-ascii?Q?BR9g8E9o6jAcgtr8ELb68h8uo5UGoyg+pma/4Go59QIQFnEaNYRtzOp2A/FM?=
 =?us-ascii?Q?dyG4gOaQ+E/0L4Up1dftq5iyiFajHP7/Bz7BtxLCEApuBLEFsHD8+Omaymg3?=
 =?us-ascii?Q?ZEKPiKUt079xcf2Z8VKWJAjx4g7hV8pY/akPkgWXjn0btHQr8qtKAa1JhYnM?=
 =?us-ascii?Q?cA7aJSVyKqLMd+RRjiHoZ+k6qXFkH4qhTNqiqCjsSwev/gCEYI7TTplgmp+7?=
 =?us-ascii?Q?NRIuiX4/X+s5JqRvlmeoDqTDO0vfeyFFEr2vhfQd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1d0de1-0024-4e85-5a03-08dd0249e53e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:10:56.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2wH8UCv1NkNDdCsRyGd2km077pKDQvCIgcto+hEuAsDbnYUjNn3ROQMJhTcDdpNBcl2rZpN5vf9CmHyHCORFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

Access to controller region is not permitted.
use JobR's register space to access page 0 registers.

Fixes: 6a83830f649a ("crypto: caam - warn if blob_gen key is insecure")
Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
---
 drivers/crypto/caam/blob_gen.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/blob_gen.c b/drivers/crypto/caam/blob_gen.c
index 87781c1534ee..079a22cc9f02 100644
--- a/drivers/crypto/caam/blob_gen.c
+++ b/drivers/crypto/caam/blob_gen.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2015 Pengutronix, Steffen Trumtrar <kernel@pengutronix.de>
  * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <kernel@pengutronix.de>
+ * Copyright 2024 NXP
  */
 
 #define pr_fmt(fmt) "caam blob_gen: " fmt
@@ -104,7 +105,7 @@ int caam_process_blob(struct caam_blob_priv *priv,
 	}
 
 	ctrlpriv = dev_get_drvdata(jrdev->parent);
-	moo = FIELD_GET(CSTA_MOO, rd_reg32(&ctrlpriv->ctrl->perfmon.status));
+	moo = FIELD_GET(CSTA_MOO, rd_reg32(&ctrlpriv->jr[0]->perfmon.status));
 	if (moo != CSTA_MOO_SECURE && moo != CSTA_MOO_TRUSTED)
 		dev_warn(jrdev,
 			 "using insecure test key, enable HAB to use unique device key!\n");
-- 
2.25.1


