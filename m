Return-Path: <linux-kernel+bounces-425865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B29DEBFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13E4163D58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49491A7271;
	Fri, 29 Nov 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/zb3gZj"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F21A0BFF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903976; cv=fail; b=uOcl6YZ0X/8iyIkK5A0zKGsPXo8XVWsnSGSKONDhO/4b7rj3MXidion86PXDiwNbUYJ4TsvpUEt/QWlJp4xKifnlZYx41lcYQUqSg3ZUkn6XvIy1mGFR63ponOmCulI8TRX6DEvW8W9luK6BHvkg+sastyE2NgUqPTrTj3by+ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903976; c=relaxed/simple;
	bh=5hcZCOdNIAsZ4tswUYWoefmWShSFxWevXY/7+NKovgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IfQAKd9rKO/coJb+PPwoJYJXNfHyLnw82iuLYA66SaN5saGygmUKqx7wNrguyZphLK0hX9urffj0MoPL1p7F4cVJxxkcoxJVpyor+UxRO4/YkNlmFcGZEOvCqftHQxiKMo0eU0ezsggXHxeCjjZ3izEDXgH88Zpj/ZzojetEGGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/zb3gZj; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNiZg0K0vozhyQEeR/VqF9VJb8lvYw6h5yFKMar/GOeR+c0HPz+q54s0MhZp/OjjXhe0OP7yYwvUAgV/jTmXR3Wqte0KHsCc4RnyoHQFNrTKIQ5TPKD8Srhz7KGPlPLx82wFzJXXgZYxFkTR+j0Hrw0DHZNLY/2uFQzTyRQv1dPihl6RM714Ww4DCDyIN9UzYmN/XGxL9q+Z3g2oJshf4dEFt28xcOaRvUEfthetsu/F5bSX9LLVA4zuSwgz/uKDRudrPl2m7kYK3Xw8W2993ygk5ab42dtGws1pgRWehjJko1yoJ3O26VkpfijXgA0cl0X6SHhcxFOEG6bmjOcbwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMpudSIO06WJlk4qApsPzMxwH27FT976EIbjiPIARq4=;
 b=uWEsSZVz+vd81rPZfDVTPe89C0h1HoV0URLLGgDmulizMSpz7+MnZFixxNn3E7F9ymBkXj6c5LbaXJVBM+pBhYPVBo8Pfr8t8qzlxfyvLxEsT13sU4tqXO70V6QkiN9Cxhw9S20YA+UsYIs6248CWpEQZWPl965lSop9azhVzRvBUraEluA+hrHfpVayeLQenFjJeItrGpSmI+xokz3lCsDBisYHMVyWvUHxOoSfvkA14QqNMF1DsW86WgXTi2Nvp9HX5ghVVDIOgsdXsIdXnhMDaUj+nhjRFx+7oEyuW3h7+yERDuq312Ez/PU24KTrDtZL4U58rtqa7PKOljfXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMpudSIO06WJlk4qApsPzMxwH27FT976EIbjiPIARq4=;
 b=H/zb3gZjN55Pg9FN8qiwlyxXlqLCjd2dcHXZMiKZb9Vv7Zl9c5f4y08p7lI9hLLcuzulIFetNymL9rH2pwyNanXIKsBJAHmW1HgCUgpOcsDCe4sew8eLnEDQankvUMOjsac7W3T2DM2OHjdmEZcWPqDxTGaMyFyeWJB/0tEEGTR0cZ2nL8Ts71r4+gki002OM+q8PMlIO2qYWItxQxEl1Q16kDo63mbwccaPgpCwMU5dI5qccnu4mB9MY93T8Quk338CZ6vkrpJ2vY2Ey37vu4+C2r2u3MUqYgsLgAWdN4MRxR2raZw0Vqea7GRrQj3sNOTbYSPyQw/UC4ZpTYDySg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 18:12:52 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 18:12:52 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nodemask: Introduce for_each_node_mask_wrap/for_each_node_state_wrap()
Date: Fri, 29 Nov 2024 18:54:31 +0100
Message-ID: <20241129181230.69213-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129181230.69213-1-arighi@nvidia.com>
References: <20241129181230.69213-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 904e9790-8725-4bb3-3db4-08dd10a1708d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQ6zygoYFHOJWkM276QIvUMAJYu6EqFzUISGt7lZkFrR/CRmIFZp/y530DGU?=
 =?us-ascii?Q?LquBH9A6lZr/SPnu5BUsBkAvExhY4GwhLybDtsjXT1G0aQz73Nf/n7Tiattm?=
 =?us-ascii?Q?qAYzMZIjcHI5XIYPtbIiGTGJwjBusDfMYyArNIR0KMLlnALAq3fvCYIu9LIr?=
 =?us-ascii?Q?VdfAa/KG1kCGrpvsDI27TnBoQt7dpg2NCX86pRyLlV8RaTwuX7dTJAaW2lva?=
 =?us-ascii?Q?S9MOmYUsp8AHCtbZ0epRB06lhTOSvM4u3K+fRw21bhz8K3AYv75jRaPYJKkd?=
 =?us-ascii?Q?U3zoU9sWaIIPXKrM0laHmIbuo1jEOUZY46hfvZom02ztEaU0ps0roYvZxTAS?=
 =?us-ascii?Q?TbmFSMHVNhu80p5dsKSrnA5tUo1bAHno+aFLh4HmSM9x80eKGoiendbGEzmE?=
 =?us-ascii?Q?Il9LxDkXZeNEnX+gXhJKPOu1ob3DhRI+EDK+xN0HObOupUrXqNIIh43nE+sE?=
 =?us-ascii?Q?0kL66wT9IQmxe/8BIVh1wHVEb4UFhWIdMCrKwIe9MVF7JnTdrggwOPp/IDgM?=
 =?us-ascii?Q?XHLQqb8FUlmzP9fdYMmYrWgFtBCZCMFlNj68S1gNLbpIX++FLrdUWJRqzziF?=
 =?us-ascii?Q?O8mCZcJfnWELdGMfMhfRFUQZHby2IERa9QVx34+XeTk43H3po4LMC5Hs0F6u?=
 =?us-ascii?Q?AdIr+Q3evlPBsh1vRj8iNNBtdXtvZFS+3j6qYhZQjeQS84RmgghBvN/U4npQ?=
 =?us-ascii?Q?v0cAKUiT7dsLRglQjhIx+vQjl+/56X7AQYN7dlVM0hhL7lEeR5iOR/YohvYU?=
 =?us-ascii?Q?cZ3SbFlbsjdRcZZc7x85UufU0oArPzAxHxrzteMi7JUxvh3mAzolwf63gQ25?=
 =?us-ascii?Q?0ejHxadOnQv1kebHzH4AwSdK9YhtMPEMkbTZT6EmrQFZr8Jj6k+Mv8LKMn3Z?=
 =?us-ascii?Q?PduVmZofTqyUGBcIYc3qwVbqPkF1PIEIozipbbCqKJHGlKBi9+Lyc3g8J5CN?=
 =?us-ascii?Q?AvalY6FJuN0oC6rrT5N+UGgYg0PBYzTZ1wPH0H+WE0V18j4ZMzoxDi9erwFZ?=
 =?us-ascii?Q?lTgJbtE8nuN47+6eWGv2kNeAwBz9ksJdm7Jzk9KRQgOjxu40180VA/i9ltQ1?=
 =?us-ascii?Q?iQUKt/Xs+0Q4EJ7XFyzgpPkOCJkSDJIM7hvDUi69A9oO3Y9Hn5JKo/ldTFBH?=
 =?us-ascii?Q?op+cKJZdy0n9hxnVJwYKbGdKXW/dXYIrD7wG9ZYFdVsX2x7WWS2ltWzZzwgh?=
 =?us-ascii?Q?b+vJ1agXylLpgY+0ZsxbIvsIoa56bZ6/j38wk1WcJmoDdwLQUIQZvODdSdWD?=
 =?us-ascii?Q?Ic68Z8ca0pf9CXOOSU/WDDf+Is4iIGeJE4sBqs2PMd4z528zpTB2kwwqGqBx?=
 =?us-ascii?Q?tQ8SiPczOmjXzl/7kgoqW09zwNjOGjO7YEm71Dweagvtag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rAcSJyIY3OginqD/6/JN0zYriHl6BGiWQuPYeSIVh9oQoipgrY+NH8FyID28?=
 =?us-ascii?Q?O6hMqK+vF/G2olUuXYPCHUOnOO0f4GBcE2/IXzuQo36jwGvx1itYYgdA6D/9?=
 =?us-ascii?Q?UDdWUnoEv4zQ9Aab29Spgz0P6AXs4Kt+CXiL8pkehMlWboMcq+xmisldsvKP?=
 =?us-ascii?Q?8apOW3M0jjhzXL9w3XJ1fzT7dNz/gSM5zwhgCoNx8HhLOFIMePlBjeuOEmPa?=
 =?us-ascii?Q?jY5KegvTmhBos5JkkJEYI9VdDs8ZXvipZCPG9OoKWOPxYxi0wBgU3egUrpDP?=
 =?us-ascii?Q?69qngJi8V3gJCJDnH5oqfJKjzbTBrjkfQzQUymocwpLYu8HfVWYMFtTndFL6?=
 =?us-ascii?Q?eAeZCmc7PnY1PqPTPzOx4QcPJPBE0vtJLFmu9MgTQsitiaFQE7IUPhbvc7RH?=
 =?us-ascii?Q?lD/WQj7CBGDdsR0U6QERkeP70MMS3aIpc8kBlNnfnu2amXGpSi9nRUOxhG5/?=
 =?us-ascii?Q?gIr67DX1xl8TZKnBHbOQnvRroOWs28wvhs/rhjQeaB+0l1K6zU+qeM8Kaxpu?=
 =?us-ascii?Q?HR7iAczO/7M3NeVHNzFCVAug4KX9vQWT7X3JAQM5or1jPOh+5N+8I2AtOrAJ?=
 =?us-ascii?Q?7rDT5rPj5THgjKnjjQpVjycchw5tdxTs7DiyZ/5FGmFBCo/7UecO9ELRnO7/?=
 =?us-ascii?Q?KyUP3mKyHYjKX3x+D5HaPViUp9XqH2t1uDM0H9P3lBGLl9SNU8faq8St2uXO?=
 =?us-ascii?Q?b3i1ZtO7uzKiV4ZuwBHdkIb2XAOlSaZPiLK/TzxgAEu4+o4Ch6M+R1eFMEfb?=
 =?us-ascii?Q?8Y0+bVSNMMTQmP3FGJ1D++2l1En3955BBo8lPsfGqmSJd+7Us5oVkd6bLpsP?=
 =?us-ascii?Q?R5X/pwLjz4bKp3sKgF+QSqVseCQeYdXL4iQ5y3LBhw9OBtx85BDAT8SwQ4BH?=
 =?us-ascii?Q?DDKB9Tdx3UohEMgcB8gUB4VxR9U2cKtLCmZ0OnNcBE+c2B7SCG7avol/4q0S?=
 =?us-ascii?Q?6A1yvbhWLNwthklQ1sOfAzdcRWlNDQ0sn2JGywDziSRWjj9F32tdbMuZ3cjh?=
 =?us-ascii?Q?4/i8goaxdR7f/j3si2FScrFkf4baBiCNPe5ckQclvSiqNiB3CV84Jjo8AWXa?=
 =?us-ascii?Q?HsFt8fgThfzh7NCI2NGbPqGlxhwv5pbx2ZpvuT4PNvKdKTrvM9U+Yvv+2qgs?=
 =?us-ascii?Q?tdrsDuauaVnuH0dGSZXL5xtES6vl7A5ShIB2NeUYiw820nFumc/r5i8JBcWB?=
 =?us-ascii?Q?fkNZYi3BDe/c5OLdVy1HkzUApPIZfGGLQqb/EWClAJQRdBtG1+Ds420NyW7F?=
 =?us-ascii?Q?rNOVMK6YPZAlbYELdHU8SzUsTFwN9GnAS+TpYNzF25FlWkqNoCyZlvP5nQ66?=
 =?us-ascii?Q?VGKCdnH2YWSrBs6FhSOCO4BoA3Qy5A9g9oe+FyktAr88Q2mA9gj0+sm1zUs3?=
 =?us-ascii?Q?9ClJJ+aXDEXYbHAX7kJfHDKRjNDCh5m3BqRUO0U6m1nLXAcptcQeaYzFMwhR?=
 =?us-ascii?Q?Z0k8xRKoMI18QwVi0uFhZhRqtKG+rnOgTAVh5AoB0dHsyAihp6He406/Xnc/?=
 =?us-ascii?Q?a/GzZu/Lr59AHOryfey5QLjabHdevWj2cXTtCenCBQXS3VW/sJByWvfZl/o1?=
 =?us-ascii?Q?AvYZJAKoQ6khro4uDzBZgfjodMsWQo0ScSNJDgaM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904e9790-8725-4bb3-3db4-08dd10a1708d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 18:12:52.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aCNeTPmJx9dQTwn4lp88G7FGYJ6r9r5rr8MW/qHkX0pj6yVjtrS5RSKxcBsoq0mXTFh9MZW1XeelQezabSsTLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

Introduce NUMA node iterators to support circular iteration, starting
from a specified node.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/nodemask.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index b61438313a73..c99cea40dfac 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -392,6 +392,16 @@ static inline void __nodes_fold(nodemask_t *dstp, const nodemask_t *origp,
 	for ((node) = 0; (node) < 1 && !nodes_empty(mask); (node)++)
 #endif /* MAX_NUMNODES */
 
+#if MAX_NUMNODES > 1
+#define for_each_node_mask_wrap(node, nodemask, start)			\
+	for_each_set_bit_wrap((node), (nodemask)->bits, MAX_NUMNODES, (start))
+#else /* MAX_NUMNODES == 1 */
+#define for_each_node_mask_wrap(node, mask, start)			\
+	for ((node) = 0;						\
+	     (node) < 1 && !nodes_empty(mask);				\
+	     (node)++, (void)(start), (void)(cnt))
+#endif /* MAX_NUMNODES */
+
 /*
  * Bitmasks that are kept for all the nodes.
  */
@@ -441,6 +451,9 @@ static inline int num_node_state(enum node_states state)
 #define for_each_node_state(__node, __state) \
 	for_each_node_mask((__node), node_states[__state])
 
+#define for_each_node_state_wrap(__node, __state, __start) \
+	for_each_node_mask_wrap((__node), &node_states[__state], __start)
+
 #define first_online_node	first_node(node_states[N_ONLINE])
 #define first_memory_node	first_node(node_states[N_MEMORY])
 static inline unsigned int next_online_node(int nid)
-- 
2.47.1


