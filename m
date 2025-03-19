Return-Path: <linux-kernel+bounces-568017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB55A68CEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950387AD077
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9FB257AF8;
	Wed, 19 Mar 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="fb3RRawQ"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D842571CB;
	Wed, 19 Mar 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387487; cv=fail; b=q8SS2pVUFtc3flju1WerhkBCyhxcgzjbhEcK+su+K6hNOSc75tIFhIUJqpHfq6KVS5MiRKiZZfUbykNDsK52z4HLYEqUPNN4rQ961gnlUG02mrIM+ZaEa8kxQJyJr0jMLqFUYgL12LnMn5/fc3qhbUru8NlFFa+qDASlB1KdSdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387487; c=relaxed/simple;
	bh=YYgorFPl1B3+kKFplaJR7buaAuCnVY1I/oPe48Gz/Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7SqscFJHwBQnmOJv3aKsBtpTI+Owhd/Eu2JHal1JL4y7oKrcuI1q1/yDXJGfoW30u0BJEmQP1E4JqWpWfEUvDngmmIORjKVRRkps/++a9b5uZdBStampu/Y1Db0MO2ub/mEgaiebYElus2NBgbjCZt/SLt0N9hAJr+QCF6ptNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=fb3RRawQ; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xe85psz4Plvd+Uqj2jMouQR7PR/UxdiNaYKgHVms2mtt2x8dYcqCU8T0x8WU5Vana1BFgUxdJJnK/H3UvRUCYN7iLv8k2ppyHkiBCuTaG7vrARV3SRH6T56jZ3RsSjQmLnLVLmbuEo+akVrg7Qp/nnYzD3Snxd+vU1ewHOFKwBU8HSdF2qzT/AnLQQgG6PrL3ch6oHA3/fiPhn9w4F65dGDAZPBSoFnGJG9VpX/hQTuVJrFSkDluH4/Iu6JvGBeEm0Wj/sX8BTGfL8gwZyOhrDo03PvMOCFlhMgJnC8JuAA209odA1IoN+V/5inthQ1rT1Y751zvuU4AucJhgw7nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhY25m2nlIOGMtUFgphbVF0Axx9gObv/Nzra+axx6dc=;
 b=UeiatxDxeC1lt7/fvVo303SAGOhz6lhzhAIWQ2DThpon3ECsgVFDrlbxeGMyouOSVRmiSjnQMghPnJPwcKEVgtK9jUvMxm47MzkuLDtXdevPgSgMIO607uEi+qZt/54rLF+pD2S+pvu+qCXpsg3BMGzKM/J8lCEApDmLaMupMKpmiTpPoYXvaCfgrcpTbgfyo5EZrhXo6ewPmg6Qj79weKJR4cwkU5PCl3IrSmmqcA6M0WdPVrEAc8C4CT5QlCpBxmMdN24fQCHDKdYhMiJ4S+Eh4PSupy+WibQuaYWBCHs7Qw+Elj9BJLelGJ7YcfSZAAptUF+W+fQ/eP6m1G76Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhY25m2nlIOGMtUFgphbVF0Axx9gObv/Nzra+axx6dc=;
 b=fb3RRawQwQYs5haYBMtS9hAP6tCZ9mLJPfWzy9XtRA+4WmBCn8/bMHiHI/wgujkUAl137eVwWmUuu5wzuBwsxUV3cbXrjZNzd1PeV6lEGFK9n+hIyvpKI1P09sUTZqx8PxfBCE5Z7XZPAXJMxVT5CeyAnYsrZSTC/a+DZ8o/Ip0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:08 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:08 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 2/8] mfd: ocelot: move SPI specific macros to ocelot-spi.c
Date: Wed, 19 Mar 2025 13:30:52 +0100
Message-ID: <20250319123058.452202-3-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::8)
 To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 60062349-66a6-43b6-3e6c-08dd66e1ecd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfVvCpGtURMwco/4Iq7qs9X7Xh9O55h5D1+BpisI5l0BcOHPJ+xWlj9c2qUm?=
 =?us-ascii?Q?2fv9oQYw3b0sH3Vcw9yYTDeOYZ5yIzrk8sWuVeMePJz/qghlol6g446OeQzH?=
 =?us-ascii?Q?ZMJpzQvNnDOgpZdTLaJF/jtLO8u1uDHab/MQZvvNBkFnMYjo8LkBWGuuqXjE?=
 =?us-ascii?Q?KQDHSzTALJNjphDoZT0UM7ldEkiUNkdtqmsn/U/zbDq6ZK23LlaN2osFkyxu?=
 =?us-ascii?Q?xtVDJsMD34YInK0OCDWIZT3+16j75ZZYZkrkudUCwlj9OQdvo/L4+1D7tCHA?=
 =?us-ascii?Q?vulPOouITKKk7byXibQfhBNmMa1bSDomcxqfrD5hJCZ3RsiSkqQvupnyv9Hk?=
 =?us-ascii?Q?tNTjMG2RbSPFLOG6ovKC6CW5xPv2uKcTJjrJfwXZsfp9XcaTxsmeDvGVR2xk?=
 =?us-ascii?Q?KFon+vmPN47NbycecQtGoxlfYTLzkQsh6/COLxDk4BVW6c2yKbC12tQByvOO?=
 =?us-ascii?Q?DfRiHA1rbeGxnud6OTxUlWieqt7Uh9ss8Y4jUCw5uOnIwafdvhFEp5vJGhVk?=
 =?us-ascii?Q?SMhlYMT27f+zQWuzgCP09wXaaezpTbQCGEVyj/j7VeS0uXzlhsr4JR2oktRx?=
 =?us-ascii?Q?D+kuxkZoOjtQvaB+3VyfBXJMNzuYeQur5W73aF+XxfcNR4L6B8br2XeY2SLC?=
 =?us-ascii?Q?YDyr765HM3ttAUIrzSC6IASu1XMLyYu1yQS8JkVjudzwI0T2kPyIjgxJpiBj?=
 =?us-ascii?Q?xA50QR380md70j4av/FjDoSjhr6HREWK6eBpjBkBtn4cJYtSaFK4jL9cXOjh?=
 =?us-ascii?Q?2cqn0+KHJ05ENnZC9yaY2v2UJAiQQIRLtJNFLmsL9gkUNfK/BjWx5VFynyL1?=
 =?us-ascii?Q?BVHVslhIcvCQ1GOCh0aMAPKtNkcAPnpLXxr8yz3LT659nonlxpELIZ4oGLI4?=
 =?us-ascii?Q?JJyoEKllln1KzhRT05IN1QjyjbQXasvixUbyuumE211nYsMJl+ath4f8NuVK?=
 =?us-ascii?Q?AXxKOnjZ99uAnPwmit21tGI5kirZa3E2JwjcEVYBITEYNOPl7GThRErdj9Oo?=
 =?us-ascii?Q?pq6w/r5VkVypkUN49B5olVtKX+I+8S8RZgpgA4leNzd4fnwUnWw6JwG9+csg?=
 =?us-ascii?Q?VqvHHP+1oys/qeZEnnKHhkru5+wG+MMSlMWvaZolgG7F5HKZC7hlvTdyPG7g?=
 =?us-ascii?Q?hU3WqHQQZqTSCAvIRz1ZyPuds9k79vUERNvWzfBTlbYAkTwVvaefkP/FPIXs?=
 =?us-ascii?Q?0ElH5imUB+Vmxs+pFOY82Ui7Yn8vKRocCl0XyREzgIJaeCwc7ZH5mKShCbTH?=
 =?us-ascii?Q?MPRwka9casLZITDPIAwxPvX+IRi1oJnyddtlt2v+85KnvvjKnJo+w6xiRyHQ?=
 =?us-ascii?Q?CPS6GaGz1FlkY+JH+gVN127hCflvLQssC8P5nsJahdm0YKmebIPk3h7VbPu5?=
 =?us-ascii?Q?zd345fgoFvG/LWeNvgH0YeI+5/N6kPdUvAWsb5EO0N7SdK2Wac3/DVYEr4+L?=
 =?us-ascii?Q?wNDRJKtBCtSr64u4H+5e4O5yKvFrImtY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e9t8ttjdOlF2O3EFGsvJu/3JxTp0T0ALlBF6mm6qnp7pg4iJETPmapULHbb1?=
 =?us-ascii?Q?FTPfF32oL7GoHapSE37yeZq2aS6BuhvOcSnpQDSjNt/4hmaw8NnQD/DzD6Lg?=
 =?us-ascii?Q?imMuy3lsYx8Pl4aImLaSPV7y/MPNpUWhZjipQqBK7fflYITp12h+5ksxpcdQ?=
 =?us-ascii?Q?Xqludc4dDyU8+qE+LWYY3fBqKCp/7ki2hOAWE2R1eC/S1IAhAmSz4OjP8CwV?=
 =?us-ascii?Q?2pSvu/b6NJgjFZPsJ1ybgsPNJ4GBQY3Onv2PtCrxivhK7lUUifGhlbUzSthK?=
 =?us-ascii?Q?W8W7GqSYc5I9DXit0n7oiME9qZErkxN2EaOaqxhieet3NC4uOp1ePZ4S5erw?=
 =?us-ascii?Q?Vhvd65dfzJL4+xTsujACjTQAmqrthNxzjIj+J/3VcWQpmKCzKCimIJp0RRPu?=
 =?us-ascii?Q?NWvxsI/LdFZmeqB49nAl334cIydftgL5lrmpNK7B6j0jl0cX18rbhgBj5Iht?=
 =?us-ascii?Q?DZIAMQO1Pf6cJEj5XJVTDOb6A2jwyBvIgu1lJuAzyXBCS3oP63qvUsErc62P?=
 =?us-ascii?Q?EVEVvQBfDjtm7Wr5JELjSlyb30xAGdvs8suV/ayXN3nU5xb2c8iOpf9G02iL?=
 =?us-ascii?Q?BHf7AqDfSAAa3DjNc/zH444EINndbBY/MxdJ0du2dWgTL5t6aD4sQM3HKHUM?=
 =?us-ascii?Q?n4RmR/3hp+urxRIXQerYagnla+D96tR9nnKqBpVQlKoItJ8akcN7MpTo7Vyv?=
 =?us-ascii?Q?+5OVuoZ3szVxKk6eb4vj7SJ/qSlT2uxQtTb4isPQWRam7Q73YKApWs8XV7TG?=
 =?us-ascii?Q?SHXx8NF+Lj69/kHJ16BBjYfE1Ho8/VUX0rv2iuV+93sGzffPz9nyGqCw0ylL?=
 =?us-ascii?Q?mAKwuCjnVqKgsi7OF4pyNleHDLvrosf37itAQ5PfDMh5FKstogAUULiIcyfb?=
 =?us-ascii?Q?jJgBOJvgdiSRPYJVtC3DZUHUxOVCo7f2329hO9LuHWx0YaQgoO64IVTiwk0/?=
 =?us-ascii?Q?25JwShZyBZTienFHIdmqZ2CC3NgmmySm+fmKRsRHBsjfZ6WufvgC6KegUyWs?=
 =?us-ascii?Q?FrxQxbSPfajzSXf/u9Ipg2mpkBy0wgf4zR0uYe1kZw5fC3ztXwYe2AZK80LP?=
 =?us-ascii?Q?6QCjIduNcPLp386+v+4jU3lJSsd/E4ng81VLuE2kY4fqWlGpX4rPyzNL0rv7?=
 =?us-ascii?Q?DUewv3JXTfRf0G85BFtLLSfgLfwn9C6sn6wINKVvDZb+QohbMSAyBekU8PiM?=
 =?us-ascii?Q?rd9xSFfKntPZXj5Or8PcK+GJV1/51KGlIbgDlpdXjhGsU1lkzfuCo034YLNy?=
 =?us-ascii?Q?s4LItQMZwTHswqu0+AgtfkvzNYG6kgefVLBQqsYen58akOmLoURL4HstHXys?=
 =?us-ascii?Q?d9H6Vys68NtzUfJaNcBM4KHpVGrv3Q2MWKJueSnf0VIxMqmqVNNhSDpyzlqb?=
 =?us-ascii?Q?Ktf4HuslVjyq9t81u9SAnU0sWLkZKYpkJRKinfe60ehGT49tvJnup3e3Zj3Z?=
 =?us-ascii?Q?cPFidTYhGFK8hlJkFKVO4y2Djdkw3MouHisKHpftGUnukTOWMODD16/OenPx?=
 =?us-ascii?Q?VpDrDOaows5YsZOvuP1PUAcDbqsXTOg91Opq9MdnUXpDHwCaBBxdXwO7vFQj?=
 =?us-ascii?Q?TBQ2kpluudaoSWLKXhA+G/qRgjN5V4lc890dIqKo0UVjknhWzCnLKtkx2adT?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 60062349-66a6-43b6-3e6c-08dd66e1ecd0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:08.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMPo9r9VZtxL3ZS2jXWRCufiWfgxi8+7Pyb0Dn9SnDPWxJtwkaYrzxgBwFl24+AtTp6Jq1I5JfaHBSKC2DLokj47IW/e4h0Fbo5uzRu4f9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

These are only used in and relevant to the SPI backend.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/mfd/ocelot-spi.c | 9 +++++++++
 drivers/mfd/ocelot.h     | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
index a320a613d00e1..97e4061e3dff7 100644
--- a/drivers/mfd/ocelot-spi.c
+++ b/drivers/mfd/ocelot-spi.c
@@ -41,6 +41,15 @@
 #define VSC7512_CHIP_REGS_RES_START	0x71070000
 #define VSC7512_CHIP_REGS_RES_SIZE	0x14
 
+#define OCELOT_SPI_BYTE_ORDER_LE 0x00000000
+#define OCELOT_SPI_BYTE_ORDER_BE 0x81818181
+
+#ifdef __LITTLE_ENDIAN
+#define OCELOT_SPI_BYTE_ORDER OCELOT_SPI_BYTE_ORDER_LE
+#else
+#define OCELOT_SPI_BYTE_ORDER OCELOT_SPI_BYTE_ORDER_BE
+#endif
+
 static const struct resource vsc7512_dev_cpuorg_resource =
 	DEFINE_RES_REG_NAMED(VSC7512_DEVCPU_ORG_RES_START,
 			     VSC7512_DEVCPU_ORG_RES_SIZE,
diff --git a/drivers/mfd/ocelot.h b/drivers/mfd/ocelot.h
index 4305e7a55cb1a..4f602611a5a86 100644
--- a/drivers/mfd/ocelot.h
+++ b/drivers/mfd/ocelot.h
@@ -35,13 +35,4 @@ struct ocelot_ddata {
 int ocelot_chip_reset(struct device *dev);
 int ocelot_core_init(struct device *dev);
 
-#define OCELOT_SPI_BYTE_ORDER_LE 0x00000000
-#define OCELOT_SPI_BYTE_ORDER_BE 0x81818181
-
-#ifdef __LITTLE_ENDIAN
-#define OCELOT_SPI_BYTE_ORDER OCELOT_SPI_BYTE_ORDER_LE
-#else
-#define OCELOT_SPI_BYTE_ORDER OCELOT_SPI_BYTE_ORDER_BE
-#endif
-
 #endif
-- 
2.49.0


