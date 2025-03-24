Return-Path: <linux-kernel+bounces-573405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF2A6D6CF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB95B7A6F56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C725D8EC;
	Mon, 24 Mar 2025 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cA4LwZ4b"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779791EB5D7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806686; cv=fail; b=j8l8JpGTOgcokpDYDus1ggM39hyltpYxp5FTx0DVTsL6Vsy/VEaL4OdcPJPo3GehvqkUToQPAI2Bi/7RZVMV9cGOgrh8qrH+PgwYNh6HnkUyvy8KwFKe/1ssH7Ki7LcumWaURfLd5L8hrO7HroqJU9fI6KVySXlVVz7otWPLCcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806686; c=relaxed/simple;
	bh=iwKijLjp/yT5h+Kd2eOQy3sshDkYiA+ZsqM3rOS9DRI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SOF1s87oiMvWbdj4nqsdflMeC4t50oL/U8+GwszGjjEiOHEWlQuvVMYswdGstq1veYAH0O/KxgtnRgupupYfzWM5xhJDkRCvNSjM4e7aQg0nM7Vh9TfAW7S1gutZVZz1/Z+sdooVbe2LrkGrPEsxXF7mzxXew5A9bD4mv49mtHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cA4LwZ4b; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THm3iP7YUuZ0Cgr4jxWAOEZGv6BLgWpxAJz/QDjnVT/6nrCWmXTsRioHU/f97inQlikCL7n7KvlDbLQYNTJ/snnPgjJgzE6bWxBhJjM/4K2b/Y1F0nsG23k3tUBoXD5mpOwLNaPNxIqaH2lZjsdcacKTUR2mboIluwjLtld4UDWtCIz6O9LFLC2/Nfs3TZsYbCtjiIaRGGP2NdQ14Y47MilA/0l211OIz8DU1WBw4jb5UKxFK1Y4lTcKuyUImH+2TlupJfqwqts03At2X/Xle2Om3MNvBmCkf6Y1Xsd6sZR6NRywyAVDl/Hr5AdYrsfi9HyiHQMjDCAxMYqC/VW1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4jXNKrbtW1ANiXrxyy16cQFPC35IQc1jMG6n89c6a8=;
 b=Zj7M0elNq0ZQmMoMD7uSbhUuFvXyn+B7D9voJ07yfv2jlzdZqm6WP0jgwFbx+WqX86NrnJYwWU+1oosRbWvBjPca5+/Ezy8FU3cjvraSRWIX42zalzAUIQtbG2xdJDuBfJik2ayhLg5U3GF1PKOVBy5u7Q7HxoOkRGmrYU9mIEffx7anyDwDVslrMnyA6iwnxwTlVKvvQZ9+2Dzw7pSdgwVBEh/f2NTMpYFSpl22pi/RhyHtSEEhxkttSmq7+hzeg+aVFng0iI87G2aO0twUlJbjlOrRpgJ26X5xSeeY4jQnQKhBpZaFEZET6Z5zPPze+BBsNhI9yBFoe8b5a5NEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4jXNKrbtW1ANiXrxyy16cQFPC35IQc1jMG6n89c6a8=;
 b=cA4LwZ4bFd1WawjLJWnoE4gU4a9YrgrxiH0x6VPZv5l9rS2NN9rlfe3/BX6DEcKBG5BIM50T/RppRWBbX1Nw2yjXq2fQL0Qo2XhWajo87kdg/Ux9d5g9bI7+vNKpM1oYnrKktWpmHPlQ6mDmNhRn1oxC7Vid1nZyv+89OWfVmuZnRlqpnT0jQvWSb87Ep98Z2mMtTqxPvOxO/qZkEyB/ccyckMoWVrNxzOhDZYUKRK1D+qbnk2nCpYWx1FoRyjeIBOaSRVqstQzDxQuYMs2SEQTmHUM3boOSh6o08kY4TPiuDJDTidFcKY7yT+6hfQYq1IS6b/3tUzVnUXoh8d4avQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:58:01 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:58:01 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15] sched_ext: initialize built-in idle state before ops.init()
Date: Mon, 24 Mar 2025 09:57:53 +0100
Message-ID: <20250324085753.27112-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL3PR12MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3110c0a3-d36a-491e-3512-08dd6ab1fb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ShBmrCh5ixCfkbNlW8HMkFgalW7LDvlDIisUi4vbx4Bfbn1zw9xW9z8UPdIw?=
 =?us-ascii?Q?sXacWaH2/rEeyr5Y1THPhdMa5GnXtlQEYfc2PwG8luKhFCuNqweS7x2JCnu5?=
 =?us-ascii?Q?4lyvj9f8BuMS3xFXDFtRtN1oJoWj+AtYfmx5/2zCQHlj5UiTbL+x8r2AO+NZ?=
 =?us-ascii?Q?SPi7+T84eJMdGcBEpDTgJrbsNUMtLhWkzozg6ncWcOFGzgpxbA4LM/vo/pZN?=
 =?us-ascii?Q?Kn4tOMv+GLAWMSBzFfzbkF3PV+qmGHoAdjAf1PJ5cmtA/2e4QwJ1mU3HkXgK?=
 =?us-ascii?Q?tDY5w4bdOzpkbFMupKx8DSW05ARL+s7S34AI3pTB1T3WVis8sDQYQaiBswmO?=
 =?us-ascii?Q?5bb89+Q1K1ayhoUvxWD4j5Y2UYhq73aUxWp2EAW9qb6Kc14nq3SWB0/RlEuC?=
 =?us-ascii?Q?fAv4MviT11E5hUMcHFElTfX4XeFmY1Kcf7OTXwQlMglPRgp9hg0U9uUu4YNK?=
 =?us-ascii?Q?clJTVQ2CZEvO69IxD/OWgIDD8jXoOFU/ZTfCbPIvy8rj2rp2gB/h/OkG59TH?=
 =?us-ascii?Q?qSJeB7jqTdHsnpqfu4Pq/g7I40StpIdfRfIwxiCirvK7U+Vk5o81Llsh61Tn?=
 =?us-ascii?Q?X6/70GuS4QgdVAj+OAlWSjWYELteqB+ySLV0g0lQHXjBQ6zWCjUIi2FZORdk?=
 =?us-ascii?Q?fucY/QPyutLGxzV1JpjZ5BrMtqOdwFhOX5vV0YcyxYac4rh1zn/bDDcl6Fz2?=
 =?us-ascii?Q?RAMbM7vxIasLynsH1asW1URb/q6F/wpbqU1UNN3B+NTNKD0rsvDrNVeAVdiE?=
 =?us-ascii?Q?hDPRDUbsriMdKKiT1Gq6FAhkd1dSrpDmL3uf9APFiaMDljOupTQWKFy5A+s6?=
 =?us-ascii?Q?9Z7nngrvYpevg4zl+XhfDQLETsIDe/sSDbpCA3jMSDa/GbD4RgXSZV6MfZ22?=
 =?us-ascii?Q?l8gKsG0sgW8okXuFXVP5xlIn6/JR/dzdNFuf2CK2V+6yGK4xwzarqs9ZpSES?=
 =?us-ascii?Q?/KhUzexKm5Ki4m0DQP+4NFTRmsxSWrxYUQIGK6uZioHvd4x0Ar68l6ORVbi/?=
 =?us-ascii?Q?Dj1tiNGqb6axSmDErCZd4xuJhIMvRFRt8yVym2awu3xLtH9PHI4Dll/JqASK?=
 =?us-ascii?Q?TTiWUMbEdUgGQ8A3dzu+BaSD200v7iybyPWfEeDw692DtI7gf2mNMUZwOpv5?=
 =?us-ascii?Q?HaTrnmGNAE7e/BkUVLvGzuhfY0R5UVGUbrrJ70zj2TXbbFKcHhjtss4NXMc9?=
 =?us-ascii?Q?zm5v83hYrtGPg7S63kW4iEWhw4bEjbMER6LZ03kNJbxQzN7cUv90kjs5wsyc?=
 =?us-ascii?Q?lDn0Qn0yN0m6tXHTtb3JzDLoLxKhcb+w7OPWPQHt5moktatMEL6cqwPaO3YN?=
 =?us-ascii?Q?nGGYg86huUJzkvrhEqbQ+8MzTJvqLX3htSv49YOOKo97V4Uiv3eDeQp3LPBl?=
 =?us-ascii?Q?2GjhoWJshbqcaI8Tb/I5G32lMdwe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wHNHpxqPcErgKonpy6zvwADyW2mIqPY8JJbIXjT3T+437ULB6Nf8XdfnYRk1?=
 =?us-ascii?Q?B6ppooWR+jT999UofmzQ4BHrToC3XrP+UjSqjfQs4AvCS0tQXm39vptChTZx?=
 =?us-ascii?Q?5nohDytJ4aclhtzugQV6u3aH+jyzRe9LHE/exXImYnbuDkiUi8G2t9iXbwHc?=
 =?us-ascii?Q?sapPB5VmvgQgn5S1UtpYZOHksJOP92JrrSY0G0sNNBvLhS+URnJeIxSghc5T?=
 =?us-ascii?Q?EDK0+lGsJkFrgPX5MtXjqtGQReaw0gSQU3iUogPKcNJdDKY/XRVW2cRmM/OD?=
 =?us-ascii?Q?FC7soSd63olURvzpEoLfKTAilC2gZg9b2VYg8UsNnGgMKb/frvwTviHVGsJ0?=
 =?us-ascii?Q?kj6AGmR8YrQ2O+JSAGRiKBz3NL2RGGLwAY1iqzfJHodQiFLk1cNl3OjtNxRM?=
 =?us-ascii?Q?WSalSMqC6X74GH69hX5NY7oGK5cbmoN9622EJa0NT6QEo3x8HWlTa3OMmpng?=
 =?us-ascii?Q?Iac0Q3q6PIfYdUPtFgUDm1QA1BmjdXmcF7dZ+Woan/qJL+Qpk4WQAJL91D23?=
 =?us-ascii?Q?v/QcvWHz3MxwF5hmNTDLOEuQztKHr5Y/op2jyI7ngiKjSs+Ia6Zpz8I5HgzU?=
 =?us-ascii?Q?Tpzj4HqjtYxisNxOpHH1csC5ns05A7PDWI57chtzk+PFpXpWE2v8ZKeEeTPm?=
 =?us-ascii?Q?vPqbcv86Va6R7ccHRQng2jFaszIOzvdY8slDTf9/UklaptN76SH3xPtI7bp6?=
 =?us-ascii?Q?Jo1Xiko8PwWWBGfYwTDWCvroaQyRz0UVPYMNIKgDUGYzkdn1yRoKNFPG4Ywm?=
 =?us-ascii?Q?SA9bux0N/Q7KY0EPaAGIyftZ32V6rYy7Z4I0x+0Sal+uWtAaA0UMDXZp4KgI?=
 =?us-ascii?Q?MpvVnS4WRofABJGf+nBtnHkWgistHcyY30bhiX9LUYHh54mihbAVbevrDHtF?=
 =?us-ascii?Q?eyScKuYmyZ4uUYWtY0OJ+NrmVzaMwXUJj8e/7pD5Co4R7bZ8WW7cwGMG8fyw?=
 =?us-ascii?Q?pJJ4PkQPkzIar4QFZnkQtwK7w8Eu+krRQ1jMuIFx6FQN2cBmFUKLJelyEl5d?=
 =?us-ascii?Q?1qJ4C1Z8MGNiJfbNzMPmhg3fPiCaZKZDtuVMBE+E2botvmntu9YyctWkfDNY?=
 =?us-ascii?Q?w46j8qUG1Ea3mdyJz5cKVSs0NkenrGVw6A1kuJa9mJLx2/xzHe6ioAAksTp+?=
 =?us-ascii?Q?FxsmIe0NpAy39qqbCW4IGTFaZ3gvibIuyCZvL8x3A4mlaLedgdZaTFwqufWj?=
 =?us-ascii?Q?Lb7+TlihEDNVej6bIVixNbSOvoZw76yZDkHj7Ems6qjjwId+b+BraS89suJn?=
 =?us-ascii?Q?zY+l8HNeEQvMUhDCwF9Masad/K39Eh/vZ4ioDUtWF42HH7R72Te5NidWcfMv?=
 =?us-ascii?Q?gDr/72oV7shlsSe2tB3/2Shs9F3+38HrUiZj9MTkKtw/zMNlG2z8ve0ojgEt?=
 =?us-ascii?Q?FIY9FhIQ1GqlIX7w6tD6S1DnePxYTCA62VvpX/NIdmqJeuM6WIO+nA9HHcAY?=
 =?us-ascii?Q?DuyWuw8vYs4x0ZFBtfVGHwwC23EqHOLECguMVCOQJfwnW7lukna7hriCEOpX?=
 =?us-ascii?Q?Rlz/aMYPRzwqIOPQiayLAJJpT/muvXrVRdznJ8VUy9JrAqvum3nQfS6HInmd?=
 =?us-ascii?Q?daf8vQQKAjK/CX89rykIz1kjIqdSbONB2ZRjQBjg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3110c0a3-d36a-491e-3512-08dd6ab1fb75
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:58:01.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEMrRdjNfONSgxOcMJhd6ITsCbCWIr0Z8BneC/qFcc2iZ5Fr4/dpRbDouRNSVWR+lXOK0aqFyEUsLKSGVNPoXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

A BPF scheduler may want to use the built-in idle cpumasks in ops.init()
before the scheduler is fully initialized, either directly or through a
BPF timer for example.

However, this would result in an error, since the idle state has not
been properly initialized yet.

This can be easily verified by modifying scx_simple to call
scx_bpf_get_idle_cpumask() in ops.init():

$ sudo scx_simple

DEBUG DUMP
===========================================================================

scx_simple[121] triggered exit kind 1024:
  runtime error (built-in idle tracking is disabled)
...

Fix this by properly initializing the idle state before ops.init() is
called. With this change applied:

$ sudo scx_simple
local=2 global=0
local=19 global=11
local=23 global=11
...

Fixes: d73249f88743d ("sched_ext: idle: Make idle static keys private")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06561d6717c9a..1ba02755ae8ad 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5361,6 +5361,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	cpus_read_lock();
 
+	scx_idle_enable(ops);
+
 	if (scx_ops.init) {
 		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
 		if (ret) {
@@ -5427,8 +5429,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
 		static_branch_enable(&scx_ops_cpu_preempt);
 
-	scx_idle_enable(ops);
-
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
-- 
2.49.0


