Return-Path: <linux-kernel+bounces-195179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370A8D4891
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA7F1F24826
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0974076;
	Thu, 30 May 2024 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="hQZsw/Rf"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2052.outbound.protection.outlook.com [40.107.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E013DDB4
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061478; cv=fail; b=YcCAX+rv6P2WRKx6YwWAK82eetbtPchKziLClVQXJCX76Wml7zL/op6HaH6pCzHISA6fH1BWWnMAY2stCJYxZfNftFwps0ugudsus4v/OJw9TgGZtd6HiPJrjttgZFaNI6xPh7qGkx/06AvMK1Oy2+q2GRy8SqP96uzoN9A47cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061478; c=relaxed/simple;
	bh=26dlg8DQDQulTazbysn0KMftmcQ95avZy3ofQtxpe6w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VKrvlkgGtYzbJCPXnSo5w0hf/oeIGArtP9m7LYeQCtvlYqREMzTa4j3Z+iUuqFGYS6CtR/hiHg15Gg2L9YqwQw9X20+XKTL2bwoac+fEW6JhsdIhSm3OabXGrXxdkDfEfr3lJ1jJ8LQ9/xipvrNCopeUMLaFnvwEuoD8meGDubo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=hQZsw/Rf; arc=fail smtp.client-ip=40.107.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I51ZoBM9+rEMjm37D3Gv9lAso1V7ON8WZUuZhu4k/OzVkhkXM3nvp3+5Y1Gwr6bJmsECSi2EL2DP4tIaLmBt5jeBpoiKGNazis2FTHh6mPb1c2pOPQcetQ9xuoZvY6Q6R0lZaTYNgw5EYiLW4KvJe29MUZaozq6I7N/oSdKBblnE28TxRk/Q1u4gUTi945vY/HstkFxT2QVzy0rzleL8vl3zbBN1AMwT1MOO9w7NFXSqIbybocuy+7mf5RaJmxjqIC7IRowng/mZs0rfEFwdPexVpwq5kj2cMEw7QjXw5MsvnBIxM9RQps5N2DCvpK+yXx/IeeoyIoevOKjOV2XJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J01VLTYJ7T3MjtXkj0Aav2CAvpBH8log1cEjdPHE2uI=;
 b=gDBuF1QoX/1wX/vYFMGZqk4iahDHDT/O9cbnfNCAviacG2XCqjvWH6Fk+CeJdXuZQ+H667WHZbQ2aq97OloPZTdRRrnrn55jboGZqWtpLKHhf5DiN5mr7CHM3kyKxekrME/GMUYYGcx7ofNlWnbxYGSGGUM2MqaDpi7t5u7IO4pgaJfzk4vzTcHGEfqD66Ec5a6RPUaA3CRKXnguPu+pnG9CTTilUq2vZTpGNL2/31HBpN2+LMcANMc/+W+EP794rN+jw+byjTiEgDGPSTx9vsxe2epF8TscpdUaGJnI00lyHKYl0Er7mjJYphxmu8RqtrO2evSxMQjUGtdDveNfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J01VLTYJ7T3MjtXkj0Aav2CAvpBH8log1cEjdPHE2uI=;
 b=hQZsw/RfEHrGufuhvs4V/zzfqghhdKcsfpg0aYPNPfPR8h6muxvcu5efK/MsQbyJvwDfiKYFZlaxdbgCZx14WcxJvkrSY5qTuP/xr8hVTvy1ZnNHKEn0NRxHViuV4Uiey/SYyTctjAXT1PtdyNcYfw08QbCqwTEMMupzZbMgOXo=
Received: from SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19) by
 SEYPR02MB6842.apcprd02.prod.outlook.com (2603:1096:101:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:31:13 +0000
Received: from SG1PEPF000082E4.apcprd02.prod.outlook.com
 (2603:1096:4:c7:cafe::a0) by SG2P153CA0032.outlook.office365.com
 (2603:1096:4:c7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.7 via Frontend
 Transport; Thu, 30 May 2024 09:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E4.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 09:31:13 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 May
 2024 17:31:12 +0800
From: <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<xiang@kernel.org>, <guangye.yang@mediatek.com>, <zhaoyang.huang@unisoc.com>,
	hailong.liu <hailong.liu@oppo.com>, "Hailong . Liu" <liuhailong@oppo.com>
Subject: [RFC PATCH] mm/vmalloc: fix vbq->free breakage
Date: Thu, 30 May 2024 17:31:08 +0800
Message-ID: <20240530093108.4512-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E4:EE_|SEYPR02MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaaec90-7d55-48ed-38d9-08dc808b3f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|7416005|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rwPOCWi//p8MTZGZaFPImBXKwVDrUhzJX9k6wSjU8aDw/x/SDSgI86w/WpaM?=
 =?us-ascii?Q?lF64tOcZXuSHcT4M8QYo2Qj0kRzjahQBKDOhFQJKaSfKx+lfGavOu/D372YX?=
 =?us-ascii?Q?3yl/Q32uNoSJ4iee23gm0RzNrAJ6wZdIOABS/briQrZvFhXzTO8o11XNuLQ8?=
 =?us-ascii?Q?qnGYSpRyG2L/wO2oJV5AE8ERFPaq7D/JV9KjTD+D3IxIbJkoyrXjzdftVEj2?=
 =?us-ascii?Q?qnfiGJMIg21Vy8gjbsxIHmgPGNLbbUCiY5zUK5tUTZkxNXfUH5e3m1IbpmFi?=
 =?us-ascii?Q?dEjyZhWQsCF99uSpk6GPOsp3yOjUah33qNvNOqg3K/gBfd3cbsKjyZ0MH2sq?=
 =?us-ascii?Q?tPTdJiCKaNkhC3/JecBIpvQmBb6p3teVFcAb2r4ZIVTf4cLX+kV/ouaeGmxM?=
 =?us-ascii?Q?il/nD249X9TzNTUK3TnM7NFPTrumU/xWkl3JqzNbG7Lsy3ZB+MaFsxTVQYUd?=
 =?us-ascii?Q?hApiVhJJUp5pLZ4m+MQ/CITilKvysFPUghzv4XzO+sg39gT62ypoL5Vp609r?=
 =?us-ascii?Q?Ur/qA+E7t50TTXP+iVhJswlkRlF8X/18u9kqlRgA+zOmgXM1hS33m2AaAMA+?=
 =?us-ascii?Q?F41+6PGshhyU/wRkZeGUXMboXTxoOBjCLdsgEsX/R/62M4Nug6UW9ySKraRE?=
 =?us-ascii?Q?39YFr6d8bFv+OVZaDpMMARXKton5+kmFT3Sn66y4xTYMAjrJ2g9KHUkdG8CM?=
 =?us-ascii?Q?igov9DBF5Q2w25qtH58ckdpDpP6YHjl181cg73R7paEPfNpqQjMTd3mWWzo/?=
 =?us-ascii?Q?CZdr/nAia/ZmvU0n6iM7AlLevxGf3BM1awLmdcwPyvE6dX8WfQHD3L/y5R4m?=
 =?us-ascii?Q?GVEfDHeV2LwoOMNBqUJoMMCaJ9z2SLgocslltnbTcqJ6kQxkehdA4ZYKHrwm?=
 =?us-ascii?Q?83LzBa+pheYp1M+tZ+j0YlEWSIlq5pKQxQH3M63gGyLZ6e5Hqyf2EoD6UfmI?=
 =?us-ascii?Q?DVhC6SXbSKCPB+qRDDH6ihTXqZF/TVquiGoh3Jkiqep1oBrwK250T/TVk4rR?=
 =?us-ascii?Q?66XVylaGl7191BKryWuWrmHgl79WYj8egbQpcVO/rHE9BlHS7INGhbsZkIc6?=
 =?us-ascii?Q?HY1V/+a6EarTsdQUu4c8WMl4MSas4D020QPxRq9SFyRZg+fNc/FihFlfcexx?=
 =?us-ascii?Q?KUFlUBSQMy2yDt6XbALbm0dAiY/MyztRumKgcAtcNqh7wTt/gZqloxMOwq3l?=
 =?us-ascii?Q?8xOCkeFO+cvnCycbPv8gqNLeJhh0X8vHAk88eSV0ynm3vKYff8k0eNHXdrLJ?=
 =?us-ascii?Q?2d21pdPvDb63eQ/JQr9nml50svH3bnw+lAdZyWBa4hHdfX/yUbAe5V8ouEsQ?=
 =?us-ascii?Q?IjSfsXWmpFahqQj3251KYxNQ?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:31:13.3637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaaec90-7d55-48ed-38d9-08dc808b3f8c
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6842

From: "hailong.liu" <hailong.liu@oppo.com>

The function xa_for_each() in _vm_unmap_aliases() loops through all
vbs. However, since commit 062eacf57ad9 ("mm: vmalloc: remove a global
vmap_blocks xarray") the vb from xarray may not be on the corresponding
CPU vmap_block_queue. Consequently, purge_fragmented_block() might
use the wrong vbq->lock to protect the free list, leading to vbq->free
breakage.

Signed-off-by: Hailong.Liu <liuhailong@oppo.com>
Reported-by: Guangye Yang <guangye.yang@mediatek.com>
---
 mm/vmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..869e7788a7d5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2269,10 +2269,9 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 	for_each_possible_cpu(cpu) {
 		struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, cpu);
 		struct vmap_block *vb;
-		unsigned long idx;

 		rcu_read_lock();
-		xa_for_each(&vbq->vmap_blocks, idx, vb) {
+		list_for_each_entry_rcu(vb, &vbq->free, free_list) {
 			spin_lock(&vb->lock);

 			/*
---
https://lore.kernel.org/all/20240530025144.1570865-1-zhaoyang.huang@unisoc.com/
BTW, zhangyang also encounter the same issue, maybe revert commit not a
better solution. we need a map to get vbq from vb.
--
2.30.0

