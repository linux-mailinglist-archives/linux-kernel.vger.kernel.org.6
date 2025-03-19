Return-Path: <linux-kernel+bounces-568011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FD6A68CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7133A1891C08
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707772561B6;
	Wed, 19 Mar 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="dlnzmnvB"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AC2561CC;
	Wed, 19 Mar 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387475; cv=fail; b=W9Z8N0zhzu+RDzFGngJnDG8Q3OAzNrwBc79wTDDT+d3aC1opnEkUjoyR2Scmuzyhr8bc0ATru5Rnvh7JvSnJwlBw7niMQDxEBinEJfRHObcvh4b1lnHQ+cA4TZ/5DnRfg4nwoBP0l1hFsLVsHLbGTleq5/fJHQ4L8m9VKg3vLds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387475; c=relaxed/simple;
	bh=4zIyNIohc5o6wRPlISQ0QmpbdeMLi1IZ/Qyl7ZT428c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LV2a86N45kgOXL5f+KDs/UmY1YyO1UiRznxFGHTjGlZ50IiXnJmzWT6Jh0t4bketHt/BBmvyrtO8eqvZ8kqkXM0ll3MyZWSwxVpNE9iFaw4w0927bHgpZlp13sUgjvKCSelIpeXQ1rC4M7LVgzHr1YlBhE9xAP700E/rUJN1DSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=dlnzmnvB; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9pUi0GNHSVUhL3FvCfBJrjRee2i4IviQqc872PasrDJshNcWL8zLjp9xukx7TzJTMbmLFBIVkvSkWwRawwd/n81FihJyGa8peS4GIQK74CIexgcpR1ZTcmijsrFrYjbNw62C/HqA9tMgtEdRnw7ozy7VJ8h+kbkvVP8DFKiGZ1Kc04B13Pql0bXs7UUDqfBle9j/oDVNCCeJs8funZ50KnqBR4M2kD5QUDVyN3TJACenv1zy78fy7q9eUPfZ7eJBd9oWOQHbSOgs6KAVmkvk0vsAxFve81YOJTsOytc1cyAmBM46BOTZrfWwg/UqdNHJ4qf1xYJPiD+tUWfoy5FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Efse0SuVEQde+NghvVizF5pW2/EBTtZem4w0UIiLJ4M=;
 b=ObnCxiwEcCnXuNvn0rgYzjzgRUv886j126Bix2t2YZaKO7+U3avCOoekPOaEdMYzxU8heBhfin76X/mU/1PAA/3biJRuYIN6PIJQFG5jbONwFJ0C5BVx3uT6AxoUpRwgxDOHW7gNAKOZi9GA6MYM0nTVaiXIPDoEaiPk1eEKd4jaHrVf8uiuBkatV91oUDrSUoec89rs9yyJU/D9gtyN6EyrFqdFXydd0MtXSNKpKHCrQpQJcX65YFgn7UQGqgvC8tnsJy4/oXlkg0KRArsBYrNUvZc9xCoMdUAD7m+RRiKRnCLYrXis+RBZc3AQ1Sb/6uWP7eLBpqbhVHOx/yWgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efse0SuVEQde+NghvVizF5pW2/EBTtZem4w0UIiLJ4M=;
 b=dlnzmnvBVxpoPdnP6aNo2uk3tP9iQIWfDu5yeJHnycW1I6rlPOUJgjkbW/k81krBjUCLOQs9eZnIsuVX04zfqPPsvpnf/9Slr0jAw1Kz9vwQv41vR36/g66cxTOpBR33Tk4qFla4Z+JtMZPsXWIdbxI8oPbVis4+YFJqk3rS9XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:05 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:05 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/8] mfd: ocelot: add support for MDIO managed switch
Date: Wed, 19 Mar 2025 13:30:50 +0100
Message-ID: <20250319123058.452202-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0095.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::13) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b1be5c-ad11-4c34-a55f-08dd66e1eae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KJs4PmNl+8g/hCaY/LNeUBy8v+PEQMxEcD8RX6gHGsHqIII5WSXGnT1uV6os?=
 =?us-ascii?Q?X//Rf8A6jiJsj65tHh4kCywowvW5XkBLsE/GUaNfxcm8we0xpfs07EbhBP3j?=
 =?us-ascii?Q?osck0nctyUVy4rN4sq8x0ZyxlgVHPwg8fou30vtoiYAYb5CJkb4M+SRZdDus?=
 =?us-ascii?Q?ZYh5CBVWYl0I9jg+7UIWXHZwul4k7dkF0jy2/JWIGEvcoW/dV5CE2CO0HaBF?=
 =?us-ascii?Q?4bQtOtk0SKjtJcD7WygmBdT48h8dgPTKoWDpv59+MCBd/UMTQD/bs6tQQ9ds?=
 =?us-ascii?Q?0mChgPyMtVLdPomLRH7duxtRbEZ1aglNb4y5i3xhhrg5CWCFTP+BXmanYyfQ?=
 =?us-ascii?Q?XPnQk1fKSinJ2Qyc9Smb7LOpynUhlbYLICtvHLIORlUJtYxOlCx1hGW+vs6G?=
 =?us-ascii?Q?xdrXKwaxoGG9VMqrYpxqDgDXpsITDAsbotfAPAfa9GaCoRSgzhSwSp7D+CYs?=
 =?us-ascii?Q?CRbIid2u4pOXjGQ3N57I6eLz/Il/kwBwjBd0+EmIpw1lw6m0MWi7s8/fNPZM?=
 =?us-ascii?Q?TUGc03Wj5m5yr4TvhS2jjAPelzO+WYfgBuZcgd+YuftrKrgQYRSk5vgwZn23?=
 =?us-ascii?Q?0HVN8O+Uo3N5ArRhE2BeAxeRS4bxuXAL559HpBVfrKfL1KdRAOkdiBXmHntb?=
 =?us-ascii?Q?jZrKO0tUphU1ROnLVAWZyxbOA7Hmh6mBNZiELKgpYnO55ze3Bup75aCfLM/B?=
 =?us-ascii?Q?rCDcBWQDMixXca5nZuKlT93n6EnH6XATyCIJHgu9YwrbRp1JSNnh5J7Ymkd8?=
 =?us-ascii?Q?aqopFhrnZsbWel90fYrzrB2JCP1HC7e1icbNHFDYQeuHXxnSGNlBkcgBvHfp?=
 =?us-ascii?Q?S5Rcx5u7A7wyaHKwRztnmf61RcLS9TwDl1YOHvTRbbTJJngVGwL8ffYU3B8n?=
 =?us-ascii?Q?NLplRXlqZQ6oxy16ROeAY4zGQ5QyTNWSog5MxTROw1u0++dI3kCE8rBU5Cqf?=
 =?us-ascii?Q?Vv0nQbeYep2s7TcWxh9dHmiI6Vm+hbRZ1e0n0i0DPb+U5XaBl1jIZzuCv0w/?=
 =?us-ascii?Q?KHgnWNWJMxRlNUqwlnCkRu0BYZghVouosJkGz4BDpQ6CVaD0M0mnvT4ZkPCf?=
 =?us-ascii?Q?2CJmE+DBZQSP41dXdB5zDX9RiEGV5CovRDCabIcO5EUp3ArhtJzU0zZKlDkZ?=
 =?us-ascii?Q?sklZdT0/gkbO6uxuoNUAQdrW7AheHRfT8AgsZ/kVIZHaJdkamrVkRnr/TGpr?=
 =?us-ascii?Q?WZ/ajv7oHqz9XggMgn/h+GBtVoz3eIq1m0x7To4xT9oEaJKqEcEzphJXNjIR?=
 =?us-ascii?Q?qxmQ1/i/TMl06yQ21qW3fo8C8OS5IlFjEca920vYxyHb5xc4/QUHRB5R8D0P?=
 =?us-ascii?Q?EBHNxjDitBGxr59p6yFzPl+3VAQqMu+o1Nyd8Kr/SUTwRP5ccCkALNxmyxl1?=
 =?us-ascii?Q?bi99dUc6T7y9jG01WHrQYXpoJAIAkkvKQiN0H5Lmn9CWava0wRPCReLVKry2?=
 =?us-ascii?Q?P0Nw/uP/jwcyX/YgXu6jC49ELIRKjoJ1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCUe9aIYCX20wAK2PU3K2jipF3nbscVFuejkMJMNQIzJoZ2RH51l6ph3OwZX?=
 =?us-ascii?Q?2LWAKYvUA9w4CMn587GgE5KEmZY/P//3Cm+nsqBKS4Qk08t1rZEis1I4bO0O?=
 =?us-ascii?Q?n9FZkyZgHDDvsm+iRgC9AVl2ThaR6uspRO8EmK58jsMZ98AainIq1nKVHn0N?=
 =?us-ascii?Q?8zJ6pdiEG1cQN9Vuees35ZwRDnZXUEIG6pFLoe5kBKUGv1t5CroLsUcvM+SU?=
 =?us-ascii?Q?DETv7a4rtfms55uq/MEJkF9i3aJ9I4GolL+SZTtx5PPmxLPGccNe2JPVDQJu?=
 =?us-ascii?Q?qrsV0g8+szfCiuU3IvYGkTaPNkwwUfWFirbIYzoxq0Xip0c1+deOFevKK8ev?=
 =?us-ascii?Q?kwBFVdg3HG3OhPw/WYDcvJzo9Ao1mpp3vmHfTz4i8p8ua31iz4RbOyb/wpQU?=
 =?us-ascii?Q?Pyx4Uim/Rkscn8YDLoYqc3JcZOzk8xnwpMhAgwHhYEMk0gOVa3dvwjOBTg4H?=
 =?us-ascii?Q?uTK5TjxOgMgk5F35M8OZN63MH56PwD2QoetEnN4tol1jhtkGnbouRwPCsl2j?=
 =?us-ascii?Q?l8UCKNENCTU2cP9qMzu+mfSnbC2POvgSQZT87qmOxzugxsKAvh4KNiqMXDRP?=
 =?us-ascii?Q?4V7o17iEXpteDehoqx8uc4VFYWRUSNzqjQrUrp1xzGar6h2gVLOG3fqIDkC8?=
 =?us-ascii?Q?JZLTmzBoMff8NGCdJVd+A5NZE8/X5ZK9ozLBD3cs6/5nE5XatsTgWHBULWAI?=
 =?us-ascii?Q?R8knLLhiiUbUFG95XF6FiRfSwH4yijS89AqIwhNgtMm+DEy3pgdJoYAM03iQ?=
 =?us-ascii?Q?0sF5D7wwxgYnGpHT2OpFfKznmffs+Ky28AdCwQPlgYwdeg8+DVG2tp2pbQ50?=
 =?us-ascii?Q?ELdStFE7kTBi3SmsOUtpFnWG2YH9qjV4+SG1UTyHxZNDjEz/sOKy9uGQ1+mp?=
 =?us-ascii?Q?eFwb34zsEzPQOJ8Nm7tGAGV0EaL+BKiPo9PkXk5i66+Zkqg5odzaN9peI2fH?=
 =?us-ascii?Q?miZXuzd2kp7k6h1pjYQdYMP+puHJKMqzcd3Flk11VAPFx0KjPgFi1mW2r4hE?=
 =?us-ascii?Q?G1fXOqbrW3ULCAEfl5LbuQSbbLE6/89YuwchV6ghwGn/osXGPZxhRKyHfI/F?=
 =?us-ascii?Q?8ks/x/WMNaJXBxs7GnHzYjTwiM4qipinHjMtbF9aNP23Q/DiCTRds4ctDLxI?=
 =?us-ascii?Q?kvwecFQNePfheALvOYjGuiW7aTTFARB8LeWdF52DsubVhniy408ID2F4MBcd?=
 =?us-ascii?Q?sdR0kJMAVE4VqIpQRLNVp5dhgCvFVz5L/o2LutGkBpBMKdoJY692eWFbTBbG?=
 =?us-ascii?Q?Rw/qSezZccTvzWNK+v7RhPffQr3BAGCJVIsZqEpuv7o0B66wxx+LyPUaDhF3?=
 =?us-ascii?Q?JxtI0P6rLSYZ/UZ3OPGJJKjyCLpAlhEwAjgTPvcwIPzU/TClkzXdjJ6P5X/J?=
 =?us-ascii?Q?7TC4JxJ+2SQG4oxyt1maoCQbI3HMsgePnxrZR4Nf3nLT71u/+kCECt2ASsvK?=
 =?us-ascii?Q?HJOBO6pzdSrjjNaTMoUeJBo1H0OLlblcpg8n1yp8+U+irKqdFzgWS25gPyPT?=
 =?us-ascii?Q?Ple1pmMKXC0ILF01CzdYJcuOgyqADmTBUnd2JHKHsokmEIgFW1+7mq1IJKl+?=
 =?us-ascii?Q?EeyeAgHxqNkC4STShgPaDuj1b4L8hBhaMbe9zGJ6wTh1/2Kozu0aKPrKXWHW?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b1be5c-ad11-4c34-a55f-08dd66e1eae0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:05.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntgrmjrKBDjcuZoBcIX7+YeJlCFMPEYAEg1AULgS/UcSYMjurgFZFp4Qc0GHydvOoV4OT+iTKp8hW4xiGpwQlnvBDur/l9WM+0ml6uxFGQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

The primary purpose of this series is to add support for vsc751x
switches that are wired up to be managed via MDIO. The current MFD
driver only has support for management over SPI.

While reworking the spi and core files to allow hooking up another
underlying bus, I found what I think might be a bug in the SPI
implementation, for the case where the SPI bus is set higher than
500kHz. But as I don't have such hardware, I don't know if the bug is
real, nor am I able to test my changes.

If desired, I can drop those changes, at the expense of having to
duplicate some logic around setting up the gcb_regmap and calling
reset in the mdio backend, but since I spotted it anyway I thought I'd
include it for the first iteration.

Also, if desired, I can put the mdio and spi backends behind separate
config options, with the spi option defaulting to y to preserve
behaviour of existing .configs setting CONFIG_MFD_OCELOT.

Rasmus Villemoes (8):
  mfd: ocelot: refactor bus-specific regmap initialization
  mfd: ocelot: move SPI specific macros to ocelot-spi.c
  mfd: ocelot: rework SPI (re-)initialization after chip reset
  mfd: ocelot: lift chip reset logic to ocelot-core.c
  mfd: ocelot: make ocelot_chip_init() static
  mfd: ocelot: correct Kconfig dependency
  mfd: ocelot: enable support for mdio management
  dt-bindings: mfd: ocelot: mention MDIO management and add example

 .../devicetree/bindings/mfd/mscc,ocelot.yaml  | 121 ++++++++++++-
 drivers/mfd/Kconfig                           |   5 +-
 drivers/mfd/Makefile                          |   2 +-
 drivers/mfd/ocelot-core.c                     |  44 ++++-
 drivers/mfd/ocelot-mdio.c                     | 161 ++++++++++++++++++
 drivers/mfd/ocelot-spi.c                      |  53 ++----
 drivers/mfd/ocelot.h                          |  18 +-
 7 files changed, 339 insertions(+), 65 deletions(-)
 create mode 100644 drivers/mfd/ocelot-mdio.c

-- 
2.49.0


