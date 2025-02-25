Return-Path: <linux-kernel+bounces-530892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38DA439DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E13F3BB168
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB52263C85;
	Tue, 25 Feb 2025 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bvXGLVmZ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747488F5E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476269; cv=fail; b=VBxPTkgbXZ80qdPcK5yJkJyNaxWChF4EhWGR+Zd0qk3WvDw4FrZXOZbblaSrhX3vJS5G5jWIU4WJNtSGNN/EkNJg6mXqqqaTkDfgZrvD8lIQ/NLTwyUC5pB02tU/kvn1CnOAvTvy6KQqo1tnCrJ4pr26lF/DkI48I9cV0mSe10s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476269; c=relaxed/simple;
	bh=lV3sMLCtvbE1ZfFSJHnTqGLK4mkcmXN41E600RHK7MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DQIAtW21KRUYbdF6LwSgMauuqoZ8EVPStEErBnIM3KsY+qcPtpswH87JUithzk7al1/FgVk+E0iSJdxeqt7R+ewaKU47wKlAV0g6a9vkJh9P62bOE0PUmFi5gZzLns2/h4zSFkGgPWpLlws2+KDW5ppvzkOtvjfHIrHr3DBaRQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bvXGLVmZ; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTu7+lXBnCZHLstY3DX0/5gCXkMnsL+uN8AgCUOinhjiHIN2CpxP4asEnIfYaEIAn7ctVrhjZXKxB9DFeT5QMd45BfUtrOumbB/vklUBz4/VaDJKmTGRp9mj+6zlZHwccg46hS5QEZGEfAiTfRh5Z8SFlLL4HVgT5ow/DYtOGXBhapweDQUhv6/Evd7LHTrkgBGXzAWvy7D13dBnzJfqrTYa73h33ZLQeWyB1j6o0PoNrz8Q9kpzLve3QduUt5um3Ui5UwTALzA1UGeiNc1OQwTwqRQZijEG1hpo200Syna63QZzzP3ZYQQqGzyW92cJsjjlHOIL+L04m15GBGIFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLP8autDq7oktiukDOt0qdO1+CTOAfirjlxVEbQw2ME=;
 b=Pohya6n9qBDAkwJZGx9tMj2N2WeTdFw/SgU9kokLz25J+QYVDMIlR3TiK92aC9JFzaiZDsg246l1/U2EshwqHvxy+mMK2ePzxqkfaSxsa+GU70lkKMT78UnAvZfXJzKNZHuPribO2Moe4IdJk21EzQk+x59XqMBiWonEiU6n/dLgGqMOIzqWskEdnn5xdafVI/OCIVj/HiITfby5WmEvLBcjemH/ju9A7QoG28tmib8ofrYK5g1/DJO3JjJyCSvAj5ktsE0y5Smx0cbMbTk7CFY5LEPlGDEYx9w7s2j1KEen2yapIGpMJmne7mVbcSIcpFx480HJB4egqcJ+0MlA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLP8autDq7oktiukDOt0qdO1+CTOAfirjlxVEbQw2ME=;
 b=bvXGLVmZF1xFNEL4/+Q0avW0PdB/Hn29zlhS29QIB3MdtXKSF6CEF9M1EBaaZWkZ7xoKrKrAQzTpBL5H4HPTqJAprGhT86Vm+1lOopXknxmkpBqih6jnkKam36eHXELp81sHUY566TcWgETsxCAfULd8xkPw3Vu2JFHRhV2ptqok7iN1SImFtXbqlb0I/gMVBDdBiaT0p9W0XUM76AvBErE8cm/AJ8I+DA6IPGhJ/aGftu4hDx9T2NzeQQ/8BJTk8zlfn5nA1lsRWgetMTQxLNl+VTlXbsE0pAi9+M1sJgHBf+74djlLMPryTNfynKweyXgJmRcYitcvpgmOC62N+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 09:37:46 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:37:46 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15] sched_ext: idle: Fix scx_bpf_pick_any_cpu_node() behavior
Date: Tue, 25 Feb 2025 10:37:42 +0100
Message-ID: <20250225093742.51597-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::21) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: a12adee2-de4a-4d0f-0851-08dd55800f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uPPi+dpROo71TjAe1+B1flNy685aJrZNPG++eZo2aDLTz1mV6HZHCOUGRhiv?=
 =?us-ascii?Q?AVRcOy4fyw8EocjvNnOSRcuqrCvjczx80Pdhm0jKmEshahcA7RlRR5gI3Kdd?=
 =?us-ascii?Q?IWlFCNy+MtBvUEwXsMUl9QZIUdneilxhcTXRuB8SpdjZVnjazNi/8KSsVguY?=
 =?us-ascii?Q?21XAkra/8y+0dEt9tr702vLYcGfK3w4wFwHweX7b6Z0u5QLbJC504T56vcVg?=
 =?us-ascii?Q?uf7ElkhyClH9ai+3IlX0S/i64ktdcdGpHUXMxwvcP6qV8jPwvPhqknyAMwDA?=
 =?us-ascii?Q?1yCWnGEti1qovNG+HCmQ/6T87ZZtwrkZTFQCoNf0PDL5kvuKsPQSXnKih2pp?=
 =?us-ascii?Q?GxEt6MgIbIb59JYsI0l3cAfGJK4zFgj6QW/QcDEPdYuAeZ4geDUSRsD04jAk?=
 =?us-ascii?Q?5Q4srowXQG1haWz3Thp6nqP8CB32S+XbDAbZ7ik+ETX58cLrjP0heXXirU+I?=
 =?us-ascii?Q?iwAuZ19X3JUkPIQGmMp3XwM8z6tbfZNrfGLx5xZYKs2rbDFyTLz3WFTsKsWk?=
 =?us-ascii?Q?LBF51qa+qdAvabzoHfftiTwjYof73bDeR1kBz6cvFix+ehAW+ImNIJAzf9Jx?=
 =?us-ascii?Q?ApHuqDTsr5pku+f0rR2reE6o/rxCuyh2hyTZvbPdFH2bHgIIpTyAM6mQkacB?=
 =?us-ascii?Q?F9bcwnvSGq4qQFZ4x3yxY4BPIdwkdn4iFD6JZCxryaIkxW9q7Ne8g13F74NX?=
 =?us-ascii?Q?IFRfjQoGRd2akW3Q7I+KS3fuOjTXHHPaklNQousGMo+U7hIe2idpDp4ED99K?=
 =?us-ascii?Q?PmpdlM6DFA7BKdgVJGR2wrAfJLRij99yHAgimgR/HLa9gYO2hZWkwJYKKIXo?=
 =?us-ascii?Q?dNUJFlZ94adO9l6isMXbfvUjax2q+1Z4DAjguL0WsInewnlq3gwnzuNWcKkS?=
 =?us-ascii?Q?deLUziHErnMUz9xIid+MwwVmnjbYufGWEexgLWIHJInMclDkdnQufaG5vvd5?=
 =?us-ascii?Q?EEyIJViNVTJBRiNe/D/emOiBJtjU/QGx9MXKguavI0HYhfpjxMjxBuZtM6sT?=
 =?us-ascii?Q?k97GuYTMyrkLu8Vm9Yef9NIQNRg9EB3h1qUVC4QqjhJ1nwERMzZXJYqQkCpc?=
 =?us-ascii?Q?zB+8rfmgpQ6Omwa9Fim00qfT7bDnAJOCbsRWmJR99YqBui4yvkanRSlp7tcx?=
 =?us-ascii?Q?PG2k5qPYU9XyKDLqP+hGm2LfvfQSbc1uaMbK33kfDolKZlTF62mRJX/yOtL8?=
 =?us-ascii?Q?J4faWA5wmDfcVnG4LG+j+Qyv7u43rbrWhWjjqEbSOjGAgZOzaYFWfqtw1Ift?=
 =?us-ascii?Q?Ty51ATkhVlzvxijPAC2MgcllHz1tGmEiFILz3R80oShZm+LWhQHH5vMyZcB3?=
 =?us-ascii?Q?KQKXe99q/RodTOephSxrsbz2+snehHUXTTJxJ/09FoI63tyM2GEY+fods1m7?=
 =?us-ascii?Q?2rcB08mRPE+wU7rGutdqg3crbnSS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIQFbHV9ES8rohneYdEdnp0Xqu6psBZzs+JJdLZgW+Id70G/3E2LJrYpNFl3?=
 =?us-ascii?Q?hn4rLVGou5fWpcjKqnAPJfHZ3H6xAPkwVja6Vhe9dPDtAHLBI02AHNp6pUCW?=
 =?us-ascii?Q?VbMZn3aBCYs/t9Tzi3v94bFUStv3R5nAAX4uDbeb3Lf+eih82/IOfEWTiUlW?=
 =?us-ascii?Q?L00J3LXZRNghUCBklda/TOi7O8gQKqPV1nQtAfo79Fb6mcfTVJH5b58o5HbX?=
 =?us-ascii?Q?YnDoYVrKabgfk1QzTyNq8Vz5qJyjGHTqFPfp9WTGB+1nY5JO+wKjVDc8XYoG?=
 =?us-ascii?Q?c5tQr4QbfN4Tpa2+AzUZlB94ne+lTjLza1uJshBUhVkplcQrbWm43A81X+kS?=
 =?us-ascii?Q?qffDsMcLx9RwDkVnkYGB5jULQCQtHj0/RU8skhEOjpU/xFBmBhaoJlNyKfgV?=
 =?us-ascii?Q?Jwk1N+XBJtmgFanmP6iWPG+aQ0osAagaDvSAG+mz+mq1APfCsLY73d0lb0KN?=
 =?us-ascii?Q?uJzgmMGXdEWwjtpGZ4bVsnLhp3BcUvCecgnpYYhsnNW9M6ZLMk/cFtA9+65Z?=
 =?us-ascii?Q?/mxGWTtWkyNqfmk6NTFa34JcQKp3Ii+6M2wYfBPDQ5cth5CLP6LwGqAqvQ/s?=
 =?us-ascii?Q?d2AGlMOv+tyuLwbSRxgsQcqYpDN1zzBl4C94q2QgWzBocRsnJC6uWQVVkV+d?=
 =?us-ascii?Q?Wl5zi7VnDDPjcYIJdfK3PYv0yVt1A5jHywRbmv9H0HKJwrlS4ENsNGTjJnWz?=
 =?us-ascii?Q?NWd3AdS34B7sgaLF9RUrh2jR/y2rfwGdOqSyviuU5ZK/2lDVbAHogeWwOCiR?=
 =?us-ascii?Q?+qZR+wH2L9tJWKA5euTskjCtnn0lQZbV6SoV7mutr+aK9XpDt998Flva2kP4?=
 =?us-ascii?Q?Wg5x8gZ8Yf+aKoDF+lc889EvWYaM5Ij1229PpJfaBjN9JSgqQa9ya3ZgSBIy?=
 =?us-ascii?Q?cff4RfnCUWid4deiEZQNMPC6B+xy7Mj54fQ/t/b4gYpFuiCn+0L0hptZvxnE?=
 =?us-ascii?Q?0JIgBvq/peLIIDqcbviqhGS9k+HM0jVD06MadCOfJAi3gEaynl+TyWnXNo4x?=
 =?us-ascii?Q?OmQ9sJ7C2uklhcS+SelWVpcj3RZuak0lxpwRUWPY7FljKr5jBl5K6ZJWCeVg?=
 =?us-ascii?Q?0q7JqwLy6gNuob2sXYUI3MkUQsSYyE/Wg8eQS4tdjTyL6dKsSaBMij5pb+Bh?=
 =?us-ascii?Q?+/dc2oGoQTOrg7fJWrXmqn/l4HvGmuIAXZEaLkE70Lwm2CtmlsLrfD83u0Kf?=
 =?us-ascii?Q?BHTZfIhvxa3Rw25xL9aGC/EH7yyHMAcT4Sz2z98o30Iqv75x3xEpBnDRKzJd?=
 =?us-ascii?Q?Po+zxtQ+a4paaFH8oRUnMlkEBIb9UvZ15HT23yE1OuK017Kxpuvp+W3NywqN?=
 =?us-ascii?Q?CtF2w62ScIh3u2a+w79W5lcU7YyE7hyVSnLzKnVV5UU4Uegg4scMx2vxoG+O?=
 =?us-ascii?Q?DktbZSptpPKhANgymdQU9zt0nT4Jhf0OU8H+miSwahUXsi/tVn6bIboSyG9u?=
 =?us-ascii?Q?bPXN9kLincSQx9HQlYZZdeg5ECy6Hvm2BM2fzYJsHngJ7pomG6PG/Du1jepD?=
 =?us-ascii?Q?MHCXJEcowZm/d7V+YCO02WvPh68WVi7BcTnNaBCcddE8mbNrotnOOVJj9vdp?=
 =?us-ascii?Q?xSS6zKGjFHTxxotiU6NDFSeMExR0wjuLLRR09aLj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12adee2-de4a-4d0f-0851-08dd55800f6f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:37:46.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +I5TcTXUSXQcLZaO8LsQwkMBY1NhcdG5bPnbxqyNH2TdrptcIrNWZb2xBY+l5zMa5B10sHWZNplriMstvenTOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781

When %SCX_PICK_IDLE_IN_NODE is specified, scx_bpf_pick_any_cpu_node()
should always return a CPU from the specified node, regardless of its
idle state.

Also clarify this logic in the function documentation.

Fixes: 01059219b0cfd ("sched_ext: idle: Introduce node-aware idle cpu kfunc helpers")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext_idle.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 759a06774b5b3..dc40e0baf77c5 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -1029,8 +1029,9 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
  * empty.
  *
  * The search starts from @node and proceeds to other online NUMA nodes in
- * order of increasing distance (unless SCX_PICK_IDLE_IN_NODE is specified,
- * in which case the search is limited to the target @node).
+ * order of increasing distance (unless %SCX_PICK_IDLE_IN_NODE is specified,
+ * in which case the search is limited to the target @node, regardless of
+ * the CPU idle state).
  *
  * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
  * set, this function can't tell which CPUs are idle and will always pick any
@@ -1049,7 +1050,10 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
 	if (cpu >= 0)
 		return cpu;
 
-	cpu = cpumask_any_distribute(cpus_allowed);
+	if (flags & SCX_PICK_IDLE_IN_NODE)
+		cpu = cpumask_any_and_distribute(cpumask_of_node(node), cpus_allowed);
+	else
+		cpu = cpumask_any_distribute(cpus_allowed);
 	if (cpu < nr_cpu_ids)
 		return cpu;
 	else
-- 
2.48.1


