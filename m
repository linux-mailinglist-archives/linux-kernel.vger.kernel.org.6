Return-Path: <linux-kernel+bounces-442890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2BF9EE385
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E422856A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B05210185;
	Thu, 12 Dec 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="sSOjReEO"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148120E308
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997443; cv=fail; b=HLbNAlZ2Vv5UAa400dVxi3fuhR+AVYaO6PpaDG38+OYiK7pG5J4MTbrDbaAwf4aUkqNndwo1YHLEt/3HmH2J7a5ssIAHgozJTL7T4NK3JdXwyHo6o9K09RQGcf0EYPPpxwZ04LBzTI8R+xV+6wW6lh5UMjkZoOE8LbZanaMaoTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997443; c=relaxed/simple;
	bh=2E0vdRlYWcvZ4UpObQ7ZbZCIebi9n7rRbYFeHdXt8eI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GHEC7V38TSSIr57vQUJi0Fv8gcOxh9GYFzoulndUfUvIYBUcuYgSGMT4BvMoBiDKDD9axUmHgiB9XOz3TQyEOKjebxxFesgT+fUDghhLYLIN8bvEamScJYnF4KlcWiSubKfQoYA+3QMfMvCJ3rri3zhwJ8HqQT06W+VeDQ7Z3hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=sSOjReEO; arc=fail smtp.client-ip=40.107.117.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KArLxVd1drQeb6yQrYaHbpoFjQVa6jJfLCh4loZfipCYpZydlC3vZj58VfQvVVBYEYrvZqkaDmObc1cq71FEdnCJR5wEpo/nnJkP0LRsJ7LWjEQ3WFrHDdYoIVpE4ScJo8QzNibXoXLMn/JAZmvMqCFOfOeGKlVx4arnFL40vmVvRYsGQ56DxMcFY/y4iluHqphhHSNG+YJgASWJl063Y1PHUI2lBFFJnkMuTf8YifkNqyWnEyHOfnwnYrQLiTQahVEX9TXenO5zubduO7KgmpBHzfbkBtpz4LtQ7eskSlsSOyDbdZ3FmykRiKnlrMeRJG0Nxh2BFdIEGzde9/MJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y19EQsVygP9K9V9bYVBEpblh0sNEKwAAVCYLQO7LLKg=;
 b=czJJRtX5c8ykSmMyLnqF8k4rww3uQSYAYbcYqx+pwc8TF9m4wxpKO+F3oUFQeNp7A9y5ptVbCjMyDRE26pSdiWfpB75fjf5an2Fu/KgnCQZ2HfXYcjl3+aIqgQkY/7FW+1vZNZSdYphIqtqJoFv+Gn25KYm7wGUEw9LiSkCZAwG/oFTT0JncCJ1nTnWgh44cU6wjc7mSRPebo53zoT3kilnImttQw7SY/2cVNoriF4Z1gGSUNBJJPkqQzUV2kgH81bsqhlDzMc+M83w/a1EdJBT5xLv/U/b2ojXRudQwE6dLQV4z0SFrzRFiUD90YOlr1spgmo3yLssXbx608nBN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y19EQsVygP9K9V9bYVBEpblh0sNEKwAAVCYLQO7LLKg=;
 b=sSOjReEOuZSIU/1Z8CBC602kFNgBAAI1vfI5jvE3rjgqwuTAn0UOH5LCi4f2hYzq/4Oio32/3s7VYUx1rzPzwXHFE0Rrput0i9+1zAFRILLTVA9FVk8FZU9YdH2V46jksYhXeIhorNxYDunFGcVVdo9gTDzooRYmA9+VysOPdDc=
Received: from SI1PR02CA0033.apcprd02.prod.outlook.com (2603:1096:4:1f6::14)
 by OSQPR02MB7767.apcprd02.prod.outlook.com (2603:1096:604:277::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 09:57:14 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:1f6:cafe::3b) by SI1PR02CA0033.outlook.office365.com
 (2603:1096:4:1f6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Thu,
 12 Dec 2024 09:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 09:57:14 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 17:57:13 +0800
From: hailong <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <yuzhao@google.com>,
	<21cnbao@gmail.com>, Hailong Liu <hailong.liu@oppo.com>
Subject: [RFC PATCH] mm/mglru: keep the root_memcg reclaim behavior the same as memcg reclaim
Date: Thu, 12 Dec 2024 17:56:46 +0800
Message-ID: <20241212095646.16164-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|OSQPR02MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1139d1-7385-4c21-052c-08dd1a935af4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ZxG8oofBQjUTY0xRJEHsd/kSGj4JQXrRAjvscbIiRRWIZENjoZXDMrEuV1y?=
 =?us-ascii?Q?FhG+E/oBhQcbnR/zP2IUhPyNj43QEeg7NJJeybNwRRImksAZ4/s1aVOPseRh?=
 =?us-ascii?Q?USSmd4U9ZEQXtpV2hujk0uu1qivSiLmhOQbQlHXpAUWnmXQQHY03mHIgwWhX?=
 =?us-ascii?Q?KiP1ScYjf6aPx9q2w2JAYpwcZVmNXdbAGdLQTe1urRhOZdRQAC80EAiiclZ7?=
 =?us-ascii?Q?LSyi9VooKeEhtKaQA0cdhB8Kg7JrvAf6D/kHXKMAjIry66zqy93UdAmMEoWn?=
 =?us-ascii?Q?RIXs0zyXAjbLR+09FOJVmHGuCZ6+RTg+7ll8SRtB6Ma4Jq2/4oD8qQkNxKBr?=
 =?us-ascii?Q?uZNQiuynqNLut31piVt+SHPo2ugQtYBt9XLS2VqVrL4BQKnYGuBhISb7KuJL?=
 =?us-ascii?Q?kJ8EmP/N1iV4mdhffYM6hfeMa9QzGXOJTdDqh+vcxS/kAv/8ifKx2Q8Cqkih?=
 =?us-ascii?Q?jjiv+Khc7v8EuoqL/MW0Wdpw48KBxftci6L5hEJlSJ8648pcAwfo7VEdSf7j?=
 =?us-ascii?Q?ZzbpCOYwpmj96QrrliydeAFO6ZgOjycT8gPPfy+rBRRGJEJNiSohKWLYAPwf?=
 =?us-ascii?Q?sBwb198pAX9toPVqpxPc2GizL84LDGndxbIZuUBuwi2VLODCm0wD4HQK1q50?=
 =?us-ascii?Q?gDYtEyQ81BKMpgBHOH6LaAaTTEMcTLSyPXB7nfVSmLFRp5vRVwlU5m37dsTc?=
 =?us-ascii?Q?KP1Y4VW2lc4bguXhinyYTmkuu2ano+b0OfB/aQM9fU78iPJDOTcG+nfXtkLf?=
 =?us-ascii?Q?7y6Fz2IO/cxnDxcFJYUGyU/w5+qZaU7oj1iySaFyIDsJLxl+FJqKNStl6jtl?=
 =?us-ascii?Q?F4qw7C4MLb5Fzz/mZ9AT5Eaa1rlQ3u1MkMNn8eW66fI6PlE5d0kWQD6NjYlN?=
 =?us-ascii?Q?T4S9RyW7WlYQfn0q8mK0dQXaclxYs/yNK5CPTA46a3ugjKj4junZVEijvF0Z?=
 =?us-ascii?Q?ANynv9Qf9qimWjpUR5ARJfOCWrCLj7/ADNalM3bL/6wsL4aZJjhzjD1r9Lnm?=
 =?us-ascii?Q?Pga13ho2avV7UK261D+YJjRGM84pw36KPwywOR0wBB4l/uqk0yzayGqDr/Wq?=
 =?us-ascii?Q?OMG1CdLGOufsZkQrRujgtVesbDgfdmiiJ38Il7t62bJ029rilNwqba25IP46?=
 =?us-ascii?Q?EilkMOtX2oL6R99QIFRmp3XZElQTwFg+63b5hDBs2Y8zzsbDkkg8C4MvLy+i?=
 =?us-ascii?Q?JjFFtBquKp9o4IkyIrhi5GlSQ7rXtOmnBFIfq1P2xLpvsv/TKKfpi1qSobCA?=
 =?us-ascii?Q?j4018mEZ7uHQ1+MVKSGq76aE9c8w0+B+IuLhtPodZEnGBnzo8yeCJbqqxhEp?=
 =?us-ascii?Q?m6H8hTMtRbWl9Xy447YkZT7JqyJN2C37u/JtxH0j4MMNBQR/G3inrmREgwST?=
 =?us-ascii?Q?L7gQlKf+TyB03TU2vpQ9U6/DKWfLhdIHkBBw4VD0UDwc8w5BzuSA7qhiXa3o?=
 =?us-ascii?Q?Oq1hrJx2L3yJEQTlMUz+HZps3o2/acrc?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:57:14.3997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1139d1-7385-4c21-052c-08dd1a935af4
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7767

From: Hailong Liu <hailong.liu@oppo.com>

commit a579086c99ed ("mm: multi-gen LRU: remove eviction fairness safeguard") said
Note that memcg LRU only applies to global reclaim. For memcg reclaim,
the eviction will continue, even if it is overshooting. This becomes
unconditional due to code simplification.

Howeven, if we reclaim a root memcg by sysfs (memory.reclaim), the behavior acts
as a kswapd or direct reclaim.

Fix this by remove the condition of mem_cgroup_is_root in
root_reclaim().
Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76378bc257e3..1f74f3ba0999 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -216,7 +216,7 @@ static bool cgroup_reclaim(struct scan_control *sc)
  */
 static bool root_reclaim(struct scan_control *sc)
 {
-	return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
+	return !sc->target_mem_cgroup;
 }

 /**
--
Actually we switch to mglru on kernel-6.1 and see different behavior on
root_mem_cgroup reclaim. so is there any background fot this?

Brs,
Hailong.

