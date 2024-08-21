Return-Path: <linux-kernel+bounces-294864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E5B959385
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C8F1F22C84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EF15855F;
	Wed, 21 Aug 2024 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Yqf68O3L"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010030.outbound.protection.outlook.com [52.101.128.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6C15B134
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724213090; cv=fail; b=WBNYD9EtXnyEEbjeaxLVPSAwmIFgDU7tRr48HfV/ikImTpneRQPTR6ZNkTlu6zc8aIXHL59DY1UN142/yQK8JxCi+/Hw+hr0wdF/vlnBT07aHVHO9i2g4cKL9UZweJVxm4aX51mZr9oA6DUHIOdXwGs/2PyFMgLqhAhJZt8POgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724213090; c=relaxed/simple;
	bh=iEVZArQHNDPJv3BkCZfzbqN1Y1hHeVcnwTD8cbzKHnE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C0obo7QUS8NZ+FFkoFgfEcLq87i1Q5D6kOunnfVmvzhEZLrvSPSByUxGuJdfFgpb57XnuKbTxXKv5CzppFYBqtf5CwLMFPkf86phKnjOLszV3Bwks8+/Mi84VFwbbqowkkCujaOYL43yJ4b86o5ivGZH38u9oUSd3YSRx/msIlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Yqf68O3L; arc=fail smtp.client-ip=52.101.128.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chNvShEzYANkA9PO8JFkCalwBhaNzqJuidDf77o0DEfcnrk0DWgWjsmwhEWYQvKg+jzpVQ3NszlPGYoRZn0wRtWGsXRJESPiHz9hrckQI9sFm2q/Lw/pLe3w6Inf5wKK+ez5lfuT95DUC/+m1uKb1T287hLYni//hYiZQmuSf8czGNeNfal3PA3KeaQlJt4mUH9tAi0QEytGXIzP2SK9orqWMCACl+23vKA1SSbVC94bMOScNDaJL1vslo4L4AGDd02UHGsJBHMBhOA7kSwvdoM7V1DLMwyXoRuqYrAsD781xI/5SGi2ragCE4qFsZcabQaK8/AggI1TEjXdHrtP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPy3Bu26lfYbVlY1h27ewj2dY5JOBp/bv8RZqXCwmAk=;
 b=UnPBuiEwOxgTI4IiYvpmfm6QHQsb7HM3z1omZ/4Qmh30WiiflVjGUnh2DKVfJGRzZk5Ual91gYweqlSHWZIL8sZ5EJk13VMOfMbdLFmtEM/T3lOkfR5SuUCBekBvMGAWe7d8mS0LP/ezN+fhVB9EmUkkSMO1QgC6kHm71hj4PkpYWUlijBgiFAIjPgretVjJNHayVpXGExlx2vHlU+DLXdRaHASNtpLkMWWH9nJKbS02dUWkBu52JjPXQiTNZEcTS11aGEz+JOIv8f4F1vKJhtAK90Q+zZcsKaIXqES22VH8u17j6wfXSm9Mnc2zz6/RT6htfJwk1p9tGgDK6rKRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPy3Bu26lfYbVlY1h27ewj2dY5JOBp/bv8RZqXCwmAk=;
 b=Yqf68O3L0q9vFLuYkOFcgEFP/t/iGuAt4O4ZM3thAH3Um03RYiqByQH9Zec26mb4zCYC/KHeCUbi/HE9Z4Sv11dxhGGAvIxs7Nux6tAjAeLZQgt479MqdCs3/yxOEw4TMJOiCiqQRnE/Sy9mgIAxau+HFgyrwaT3X/nwzkfiK9fIxS0MxyExxZdS/Bnkti9wiN1oTkr7LLlNoOr7Ryg+PAYPRhOjTal9A+WveJaSZCjsE0d3R2xaiMjfP5hNjFL1uOHTen9MQ+JsNeS84ZztcHQbEj3hem2yliAo62ONjDubrwI5xmraVZoc/q3byUKjtA8YF2Zh0AMtvhnOO5JAZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by TYZPR06MB5148.apcprd06.prod.outlook.com (2603:1096:400:1c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 04:04:44 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%7]) with mapi id 15.20.7849.021; Wed, 21 Aug 2024
 04:04:44 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: gregkh@linuxfoundation.org
Cc: rafael@kernel.org,
	linux-kernel@vger.kernel.org,
	sboyd@kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] driver:base:core: Adding a "Return:" line in comment for device_link_add()
Date: Wed, 21 Aug 2024 12:04:32 +0800
Message-Id: <20240821040432.4049183-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|TYZPR06MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b6e7f7-6e65-4521-be8c-08dcc19663b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IxCs4Yh1yTgg+CpNIu1NlIlLUKRBVN5xQvoBOBxRqDqFVsuRPVLdxrAs56Iz?=
 =?us-ascii?Q?L9ceO5KWvUNl26uUScHLpRk705WxqVF1pxmqUiuw+uTA5o07rSiKA4zA5PN1?=
 =?us-ascii?Q?nHtWFcHT1sFgj8rVCs5KKG0bYMwnizNm9o8sVeRLF73ApnSpTV3497ZSpRbc?=
 =?us-ascii?Q?c1Jf/It4p/YH54tMYbCj60FO0l0GSZhkKx8D5SVhDkShcZ3pmjVlXOcu5KeV?=
 =?us-ascii?Q?EI4DY5qPdhWz/veP1zepsWzJRkmi3Q+azWGM2xZLryNoQdx0uk6VQ+/Sh+CG?=
 =?us-ascii?Q?JESAQU81rNNa2tXDrGNMZ/A0Yfyzmx3Q9fK1PGW+xhzCZ+qXdPF4MHuh+BfN?=
 =?us-ascii?Q?Zo8V+PRaqLKsOLWsEAOzFEfxdewNw5sVwoJEl+IjEAHYbt2eFNcDB7fpyrGq?=
 =?us-ascii?Q?paYjjZvc2JhuGeY+nfbvN6pVgAQ38S/cr0ZURJ9rOJXgu0P1ImbiVmtL88ux?=
 =?us-ascii?Q?ehC1FTAVji6qLX8+TPJur0Jl1xHj6r+D7X96F9+WR119b8G6BCUTOYWG9/Be?=
 =?us-ascii?Q?fWcccw90Wvg0vPlqvRoDfOeYq9vou0ND2mJQfDgxeGv8h4Dof5mcD87gnVCv?=
 =?us-ascii?Q?fufES3ngPd7ITfS9O0OsqO/ZNGBU+lPb0ww2zVATi1xr9KIDwg3QgYC5v/JF?=
 =?us-ascii?Q?9WM2xeppM/cdl0H3urag++/3rodFKgopjriffY+/5gTLOgUbDbhXbGWaffYi?=
 =?us-ascii?Q?CFrhgLD37exRtSOTi+OJJhSlGO5Dv57nkbqVlpC0EMsR/agbAi7W4FTBvhMc?=
 =?us-ascii?Q?QnGAN9v9//p1mdZp3pEAAWmNadCsqRKVRBhzlw+oPWom8D1l+FpLAt15EALC?=
 =?us-ascii?Q?6HPGNEgS7eaNGhjUOxDNwbvbx4/LsyLRh1FqNHcPxWekqGKyQVhdFrSAimZv?=
 =?us-ascii?Q?x4q5Qvf53zawb0xnpRUWOQ71dylu89nr/pZiy9g7k1XWyhzPi9i0klHsMNYK?=
 =?us-ascii?Q?tme7dsngp8sfgvW1TRwPSkxoj28r7MkM9gwmJsDqiuGKWXZy7v2wmUzoL2Oq?=
 =?us-ascii?Q?B4XAvHa9tEqcKLhx/Ze/IZxZ2HA3pnaqO5WwzfHzK5SqKHQSdXem/FtEdFuC?=
 =?us-ascii?Q?iEXQP3x1pdTxgb8674l7Hr+CVT9gjHXVJEsdixs+TPXdmbvEiW5emzbbjgYU?=
 =?us-ascii?Q?u32GWh9YEMl9AKeDhaJKzOmiHgxog6vdwPd7o7CNO0D9o2fJNVFv5jn954yT?=
 =?us-ascii?Q?csSGOdeDzOFHo1wKkAqhD8jASVWdL5kN/bA7hCg4z0QGQMztPWYlcpY0hF6c?=
 =?us-ascii?Q?9GWjcAicr7XVrbZgEO3tRIQ9iez/ca7oHZXo0kD57dYTEDSiWhHvkhzgoJIX?=
 =?us-ascii?Q?DzyEHqHH5gh+hfvXz/XsjCRgEL6Tkd2GvoTgAZL0A3Y4HoJ+PQZ5HPm7S2yG?=
 =?us-ascii?Q?Tf1Zs4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xQHSOdbz9QTq76gAiIe5p+6a0tnW9KMptEj0sodcErfNO9MTYfS4BVIKoluT?=
 =?us-ascii?Q?tvCsjYzHroClkcF9GQSkJXpcTXnGXdUJS2L6eVB54IYQ97rwOL677HHint0/?=
 =?us-ascii?Q?GECWluMTYoFUbExCz2mMl8N/8OWibod0GhCMagX/dq22rQmyLBzDO6NZrqsU?=
 =?us-ascii?Q?VbKN6wsgoQksIsxJtT3dZ8IyFfrqem/ybBfunwaB9bygAZwE5TAjPCoEHdwF?=
 =?us-ascii?Q?MM2K654KXYOHYwvTXKTI9FmQkdriWwfEGDY8G7C/zahNgronbbuiy/5rjsaV?=
 =?us-ascii?Q?2QXTIK11qaMYBFuLN7I+mxsdtaT9p89nnDzkhaHcxUlfy3mylN0D2Zj0ir8p?=
 =?us-ascii?Q?YxmW4/No5IXiCIXhCfCO64/IRNPFytYrJXWJ2vwhifpnb5C5LrU6jGhXAzuW?=
 =?us-ascii?Q?g0q1VNrb+VSZnbYR/xSQ4puQ4i0a+KXKeGt7DVnS852CHnQUFHYvL0PN3UDw?=
 =?us-ascii?Q?AZb+8efEI9rzjvFYHKCTsZKw9RS+kgH0fn4n4hPbodoWLIL1EcaLt+Tzn8ey?=
 =?us-ascii?Q?1RheBQKmYxrJRx0HeZ8lvx+0FpG5gp64lQPaBzV25FDdJWGv96LyNqa4frPJ?=
 =?us-ascii?Q?PitMBy/djd1pJzmOOyF8sldn8SowHRi30rEnKKL1k/ldtC0HdFiyU406/dZm?=
 =?us-ascii?Q?derhldj2l6Hd3tBAIiE2JmamqxzIRDNdjADgUl2E/qUt88gqbtNHj/JHJhnc?=
 =?us-ascii?Q?XYbjnA+aJAq+uAe0YRviiSmAAcVwMcoCzS0glKkcbuLHhpkawBsVjuQvGXNX?=
 =?us-ascii?Q?AFWCSdQ2XaAopmjOHY80izxsbK8P96BmoPQ5zKD64LPVgd1T3Du2rQrchKeQ?=
 =?us-ascii?Q?fYxHUBiB47kh6CCBQ2U2GfMdPPqbszxFOpCOFcHryNOZE15GWQGJ7JqwlJQi?=
 =?us-ascii?Q?0dD0+k4crTp056MoRd2lq7DwDwMBCigUhrmeKHFGKrwGKIrUT4UICu0vw3dv?=
 =?us-ascii?Q?sJ1xa5r3dCJhU1sutQ+/N/DKRGlxuXqifc80ruDDljrN2fU01ZQSUEtzk6Z4?=
 =?us-ascii?Q?OFFUXQKUo1oxrmI03yC1XN/RRS3IljT7H3dg8K08sXq/nW0dT9f1ws4jz06k?=
 =?us-ascii?Q?PNYh8wjAWUdxPbwPxd0KKYHVK0U2pvN2QZr/upsijEHUisVs5JOPFOc1DNf6?=
 =?us-ascii?Q?EKln+StlgrES0rdxR75Hd/UJBRUPN3+vzYSDBLbNY9FX9mNH6XS5KZC2975l?=
 =?us-ascii?Q?BxQgAYBrTjirnyyu9IkO5rG+zbKKz2S9xkiccoiPy42AfhbFa+SU3kgscscd?=
 =?us-ascii?Q?Vblnl8QdF2F/4m9Ir1xjZUxrtbRKv0isxDgATQ8b/72b1wlTKt9kDEl+rwBD?=
 =?us-ascii?Q?AB0NJZ4g746X8AraIAvVYK9vZ77+bHiNiAf3VfQ8gJjhC2zBhlhCAxSwDStm?=
 =?us-ascii?Q?HqdrbygPv1RzhEHTgB5QU6nfJ4MZCcFYwzyh6kufumdIWFlsFiRRfR39pYSZ?=
 =?us-ascii?Q?7xeJhtTL7/7Mf7ZfriavAWPoVELi9wNaHLzAyQyA8j4O3OiuRm1KITPtC2Na?=
 =?us-ascii?Q?uCD220xLho7QsaRawfk+GgpDBwL8sNA0ZN72V5rqo6u3KNw3pDhl0hFp/KST?=
 =?us-ascii?Q?XVRGAtLCOyQEAIJ76GDJxiT0FgiWI9Loi2wLWhKu?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b6e7f7-6e65-4521-be8c-08dcc19663b5
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 04:04:44.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIye4cvo2w+PIZqxOo0ulZtms9W2rSf+svkd2mTplQDx5iPdaPsVs2o3bQhchruSf1pvafUJ6Vb9SvEc/hOPsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5148

The original document doesn't explain the return value directly which
leads to confusing in error checking.

You can find the reason here:
Link: https://lore.kernel.org/all/1d4c39e109bcf288d5900670e024a315.sboyd@kernel.org/

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 6d3897492285..97d5005b2210 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -682,6 +682,9 @@ postcore_initcall(devlink_class_init);
  * @supplier: Supplier end of the link.
  * @flags: Link flags.
  *
+ * Return: On success, a device_link struct will be returned.
+ *         On error or invalid flag settings, NULL will be returned.
+ *
  * The caller is responsible for the proper synchronization of the link creation
  * with runtime PM.  First, setting the DL_FLAG_PM_RUNTIME flag will cause the
  * runtime PM framework to take the link into account.  Second, if the
-- 
2.34.1


