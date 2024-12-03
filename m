Return-Path: <linux-kernel+bounces-429790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C79E2502
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664581629CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D721F76D1;
	Tue,  3 Dec 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EgaKwqzn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E221DAC9F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240975; cv=fail; b=O0bKDTX4XQEtJoEJMJp+CkDHspbFa3v18SJjljH5B2DFySHVvAQ6loTs3ztUTfGUz2GFnAzDG4V8sZ2F66159gW3v9LNtErK4wO0N85z4WH7WNlTBpPDPomKLpibfgKuWK67Kk6WnxA/HjrIV51ORgBrXI5FYuKwp4DBL2ljZ1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240975; c=relaxed/simple;
	bh=J+N1jw363TPFwi2zDjNC2vKSKpzVsKn5IrZbVfZjRjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iNKvf7lgdSO9RnmFkimAMgJlf0LvsvMfpCc7lKNwdHMbiRFu8YE6mQ/mI9Fly1cwNhoXbzSPgCXYn7NzyipZIaiGCJ0jhMsCQXcRplNhQzEv7p4HKqghjdlf3Z2FxuUETQLLSHwiqbgAy9LhTyy9jWUGesxZjl+SVihrHFmw7Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EgaKwqzn; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkYpy/iYen5P7ImcN1aJExZuIepBwbTPj+N+mVKXrlyFeLuwKu7DpQgTitW7ezjNEFDn5Y73rF9uoNaqIelNnU/NmAhu0I5wEWEBheixiX+GjcTA/wklPX9l4s4JuLXlYUlVdOZU6kD3agtizR0F5ltO1lT0iYreK71EpxZysqxQ6amcmtiK6BA7YMSNDhd4mElMjULod/ld+zPYY7T5LbHw9tWBkRZMNy0Rd9EPOj/6HT6SND1XQ02/iIVRwO391w8BawzhVuPiMRm7dEgs00at3xXTeEvLCiFUJlw9akkn7IkKEUyL1syHkRa1dgC+v7MPtUxttZh3TyuEMbTTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/06Zhm0Kkxy6bFEKFAoxJx/O0SnYd/nkQ0peNqVzy4=;
 b=IX7XmnjgEcz8gq+sG6aZHIsYHfMZkKRnjYCDV585q1A0wpi9ZqFumEGlRHxy3KhN+FB6lTYzHr+EPteBXGKw3cqYTyrpoiz266WBuScEiOs5iKOUsiPiCNXBzMv71vZyr9zlvOiqgtuCi3IrpuPPjsmzIWZ4mAQWFw8DjD2OFSq0RlLnnwFDm/LYhF+TxV7Utcb96JDdK4cHnEWr4qp4ZAQ3lZZxem5lj8AHFtcaIBPK8ZoB/eTF86JtwSoF95Tetng67roS6AW6P0SFBOhWBJpL676bCs+TAhKD6nzGFDZAkzNxhqENHsU62pSpDjBPZVQfAjqjKhkcPl9erbVQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/06Zhm0Kkxy6bFEKFAoxJx/O0SnYd/nkQ0peNqVzy4=;
 b=EgaKwqznWtdTnaCGCMPRKKMzTu923BDYI1jYR7LyjblXfkiELUbuaX+eRqI7RzXgBe/vCPrcsdohUrmQy6DhgmgY971kvoNUcMV2fGf3pO0dDdf3wZBVFRBgy+aOH4Gt0jcbk7VZxYqt2dubl3A2Sg4H0XZt8lwOU64V93cqSYycdLHwEG9zeqQ41Qg+k47rkOfwkWs1jbDU6xFV3qWjtnAxdzVO/a2W34dIczsPO+Cts6bB2Y13T74udjEA/jgaSUjZSETxJ9zh4Imz7xlJtFZjUDnvUo4MtlGJdDcPQn3RkJHwaG3tJbkEXmZMNSjlAR4nSNOTjnGnpv5/K2Rphw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 15:49:29 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 15:49:29 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nodemask: Introduce for_each_node_mask_wrap/for_each_node_state_wrap()
Date: Tue,  3 Dec 2024 16:36:10 +0100
Message-ID: <20241203154917.123419-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203154917.123419-1-arighi@nvidia.com>
References: <20241203154917.123419-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 518cf498-05c5-4e03-219d-08dd13b212cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otrc0fko740iGl5yyPzXh6MAitcrxxPb3fSBwNzolRcDWC++AGYdcxTVIQ36?=
 =?us-ascii?Q?d1F4ULYOIn5Q19JoUWdlMMMz7g5ygXuPcDOkTjz12lHitWqLyAS6b7OFXcFh?=
 =?us-ascii?Q?6j7EvRTBAi8LTccxGuzlAp1nKBVvkJ9RGUhCzjYm+67WRiu29Q+45k2Agt8R?=
 =?us-ascii?Q?7rnI2POq2bl5z0GXeBG349yGb1E/mTtxEB6qiicUzW4knuz2wZNd4u26I8O+?=
 =?us-ascii?Q?R2TZwo7NisIcPNOmKW9yIc5WuoOoMee4OWqoaVXZC2k813m8umUuxWveXnnd?=
 =?us-ascii?Q?y8g1WxaSGNCXfyW8Po7qZzfswCyPDS76qZ2JMSeRUjHgrqukZmjK9F61WEIB?=
 =?us-ascii?Q?bYUPsuaZZF4UoxJ0vVdh7PGBos3htmwPQxsN+J4AzVZR+9ZumYVlyy3BUlST?=
 =?us-ascii?Q?dnVUxNzMIWan7gsr9xzDo+tkS9YDkDD8kHs7/9XdquJon1BfTBLEIa+crf8D?=
 =?us-ascii?Q?+mdJxoglmKF0PQi75xNDlQHBMOv2CWlKVln9i/Io7Lx2aLpEmk0DTROIoKYm?=
 =?us-ascii?Q?nRccHg7nnixwhEroMjceLfIkvx49F5Jcte+qXmidr9qOKh3Odj7QtgFmNE6l?=
 =?us-ascii?Q?gETiBrRBpkLoSchQ1q46VDvMGjifLUB/GIaFaA4st1NZXwgVF40IBKHwGM9O?=
 =?us-ascii?Q?ru0cx+XcyH+tf9VsajgcoK3CAXSLFpKoK9yb6fpJmNmTirrWLP37uBGA9LOz?=
 =?us-ascii?Q?uXzwokKanvRSsaf4NmyEdM/UsMlzbvdqGMvL0K2z0I74p2rdYcoo5ou0eNpT?=
 =?us-ascii?Q?lGLdbbGAhYMSdREc028X2i1LJumaTKPmGGxVtRrnIoq4FPHT9eWzIE/LBTDp?=
 =?us-ascii?Q?kjXG2GkLkrH0I+pVmFRiV0DoQsWJOKBRkeGjjrpwo3alKdBIKIwXWc6Pu0Xd?=
 =?us-ascii?Q?JwtuizSWMPAaG0HrSHjbw7mDdt+Q5471gJveh+xXLGpax3zs5WiAytoS8C/G?=
 =?us-ascii?Q?nGpFUBq7wtJYgdleH6UlqYKaUCOEjjZh+VHJecLaxCinl7i/fJo8ikqvgPbC?=
 =?us-ascii?Q?kZyPgSsrKb1flYGFSN+g1MAMLkIDONXQOdrXSFfli+qqi4+zXbu23fB3lQTb?=
 =?us-ascii?Q?krUmNY3XpjN/rwg8cGuFkTLNAofPS/wI5gZId++6cqqc4pbHMRv67XDQu4Gj?=
 =?us-ascii?Q?A7reWlvcj03mcCxncBHjE3u/qHLvaMsOYfj5L+Af90uYiZ9pUtSTJ3ziY1/i?=
 =?us-ascii?Q?BxIVZfKZBSNYvCVXuf8wDgyW4Bw3IelAFgABi+ZvkjQP3pSi9zTw9PAzutZH?=
 =?us-ascii?Q?HIFoutbg3Ytx6/Mgs01io5/tnyq3+Vv4o5YHaK0pVUn+WaS+iq5tyL7pEQRK?=
 =?us-ascii?Q?IHi2Rxgqshc2kfDQRg/m4hXYt3XyoTVbSg6JTuSzzKvrYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?roc1Tm9oI8fNBDMcze55ffHpf5ZdYuunNz6FgVXBrZyX6EEonGv6t3rqIjUk?=
 =?us-ascii?Q?GyIlYeoPFydrgzrFvuzCyN9tDooQ/8jQINDb5GYS15f0HS9Z25ymCBO2ZW/A?=
 =?us-ascii?Q?+RI8d3cKwfYVGJqbBbZ3ecAuNznKdP8By8N5q/0pbkmiPyQUxlgFOQ+BjM2A?=
 =?us-ascii?Q?wmYNXmOUTvvBIOw2kdz/yNHKdKtUL9YNJp8p6lW11LWx38XQ/0aUDYsMc8Wx?=
 =?us-ascii?Q?MF424ai/3M2+tMJ3W4op5tU3iT0F2UYKPfy94S9mhkByM4ivjEztzuAYYv3x?=
 =?us-ascii?Q?2V8x5wCdkl/bwZxblHwseqBn9IKunpS6RsSU2jLH5DMXJCedmgiTrqMzibBr?=
 =?us-ascii?Q?ERRmeV4+uUvD2V6Vpe1PDF4pWpg5ZDMexrRzMg+a4ifUjnXxqYr8H2boqdnB?=
 =?us-ascii?Q?3dFI7thdae3aISu7AG4bvFCc9P4YT8rM8xWDAgxGbQmvviU/vyvlPU5nqlGA?=
 =?us-ascii?Q?FF73CBUJh7O9zcdQpuvkkV+RAP56Us3h6ZCV2lL8M9Ji5/JtxZHoz2coVnLY?=
 =?us-ascii?Q?W8k3hKt9ZJFwDI3AD+MDhecHjtn2ogSZWKsKZ2dFTQCOvdWyQHJpbfWGSIcx?=
 =?us-ascii?Q?7+eg3B/KCDyvbPn1NdsDWhH9Pwedrsbca6Ql4Oa/fz2KCkE0JBzb9XhsVXSa?=
 =?us-ascii?Q?subV9CDe3W6FittnYpGx7N1hMW5bWDQtoSbwbc6Rcp419ukYxxtZIiu6sy8Z?=
 =?us-ascii?Q?qV3/Z5RNHU+XBrNiDLjSLwvknQQGGjixjyXNWQilq4Gf/Wci4tng7TzPXhwe?=
 =?us-ascii?Q?QH2HdQ95BhfoGkbjIJra4gVD7MMqr6b3wl1xp3cSU+ErOeap7gPk8yVZmO8v?=
 =?us-ascii?Q?j9Xo+7txF9OyCW8ATj64HoUEmCG8PJh9ZTjZbame+HJL0m+cucxwL5zYeym1?=
 =?us-ascii?Q?3e58I77QhlqYs1tARml+6OJEblLahCmTkb6mmKxlr47oHcPKSQxW3cq5tp/i?=
 =?us-ascii?Q?irFqMcCcW2f9g+bkvCO2YjyRDCdnyBCbvN47sHIxD1DLHBE5LqNR3EqqBe+M?=
 =?us-ascii?Q?9IFYEU2zJdnQT7I34MSTtAXkpHCsWpz1ArNRqA45lVdIbCUrXB9ux17DbAvg?=
 =?us-ascii?Q?Q+naHa5TgIYeM38vTCX6Gg04Y4ecEraC3ChNjiM+jipqbOajhAQvqXT6tspk?=
 =?us-ascii?Q?AaIkDbqAAXfKiEcQiIZC1C6JTO51cDPwHJvX3R70lak61kAOWaCj/IKBF9Q3?=
 =?us-ascii?Q?YO1A4ObqcF35FEBpaUuJ85cLAuutmO187RRRsfSKsKd3DDctS58peV6eev4a?=
 =?us-ascii?Q?3cSZ674qobijRO17D0WIW1jRZ5engECKMvn82teWghNJHlgVJTZSokXFNV68?=
 =?us-ascii?Q?VOeRu1XfMBkz5L5ua084DljR4DiIxqY94FdVs/2hSwoImKI2dFDik3hnud21?=
 =?us-ascii?Q?b5aHcmRUxZER6SD1uGGYaQ3z2HD1xr4U0HO1x3TVnr4j+uCC6rtExPb48vGh?=
 =?us-ascii?Q?1tZNPKIypN//bKkPOKJ4Sj0LZTRysDxO8QhiZbQT7pSRGqubBW/tFDke62gU?=
 =?us-ascii?Q?MZTsqqoddAjfCkZvGZHz2t3AxSPfWfr2InZ0ZHZ4EPPXInccIBShLPtHJYcJ?=
 =?us-ascii?Q?mKdC0jEBu/bW9u/4AunF3s/okW8znWBkpUiLvM3i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518cf498-05c5-4e03-219d-08dd13b212cb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:49:29.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g02oXwSB3UKGcD3Ca6IC/lnhzpwvpBQjJRLrJOshXw7KufQF/GQS5FdDx6BHLVSGRPyuh6ofC+Jac0ngOCzr9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466

Introduce NUMA node iterators to support circular iteration, starting
from a specified node.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/nodemask.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index b61438313a73..7ba35c65ab99 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -392,6 +392,16 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */
 
+#if MAX_NUMNODES > 1
+#define for_each_node_mask_wrap(node, mask, start)			\
+	for_each_set_bit_wrap((node), (mask).bits, MAX_NUMNODES, (start))
+#else /* MAX_NUMNODES == 1 */
+#define for_each_node_mask_wrap(node, mask, start)			\
+	for ((node) = 0;						\
+	     (node) < 1 && !nodes_empty(mask);				\
+	     (node)++, (void)(start))
+#endif /* MAX_NUMNODES */
+
 /*
  * Bitmasks that are kept for all the nodes.
  */
@@ -441,6 +451,9 @@ static inline int num_node_state(enum node_states state)
 #define for_each_node_state(__node, __state) \
 	for_each_node_mask((__node), node_states[__state])
 
+#define for_each_node_state_wrap(__node, __state, __start) \
+	for_each_node_mask_wrap((__node), node_states[__state], __start)
+
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
 static inline unsigned int next_online_node(int nid)
@@ -535,6 +548,7 @@ static inline int node_random(const nodemask_t *maskp)
 
 #define for_each_node(node)	   for_each_node_state(node, N_POSSIBLE)
 #define for_each_online_node(node) for_each_node_state(node, N_ONLINE)
+#define for_each_online_node_wrap(node, start) for_each_node_state(node, N_ONLINE, start)
 
 /*
  * For nodemask scratch area.
-- 
2.47.1


