Return-Path: <linux-kernel+bounces-448972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE79F47D3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B781162A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDD1DFD8B;
	Tue, 17 Dec 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ay1Ep2O7"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F71E1A25
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428569; cv=fail; b=Gz0iEWuZ14ejl0GiGuiuGqlW3rkBwghdbM1+lD78yhm5cj7W2I5YcuWRaXYr/zPQ1LC0NkIu5UKeTAQRlF/ZszA3MCiYEDejhTc9/oMn2Tk0NvvYDpIIwBPVfdTIMzoFkYFTptK/eeVNh9CvdIu0zCVm2Wg1tMxM81G25yMPIww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428569; c=relaxed/simple;
	bh=GHNGDSQe2U4FYP6U6qnQRgPy3+6kFgzHmz1bXUXvplM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8luIOn/aA0W00grPrr4WBD8JbQlPjQfDML33t6dT01ijYnR6qJtRKOJZos/+hpH3ocpUCWyqf3iS7cWrNaybwje41+xvhBKBTWse9IvKc0e/MyxF2L4s0XLSLq45hdUg0skSDScam6DS0tQ3dCcU+ihXjcH+BOcWiEdXFWVTn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ay1Ep2O7; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waAvuQagQ9WXQ8KeeDFQn6BSQnxSqNY66J2+bqRL/3o5j9lEmIooTnn/QewO6WJBTKUcaF9G7eWVKEtcwW/1XZVfbwkH2qeLyYK0C/U4oW5dXubN4PieygpCYuI99Il0d4mkuMDdrVWJUlg+7kGd5g01Xgi4eF/6KNbRMngYtZP+yjUWeDNE2p9TjLyFLpPCwI9sEBcITKyikJUyISDmH2TokIpTcSC4hdL/SW3YEfhXSf45RaV68FM3I0CFaTRHUBF2EigIyO4Zg70Osf/MHoZU1MpynsHm9rRLOpNhdq8SPSRjVQH99ns16aVuu2MeEA0JnywYtA0BxTkG/Pl76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed6e3mG1aHC3xGM37w+CGh6s3kI6/NaQj8C/i1AyzqU=;
 b=RJV8KXe3heAdBEUlqNGvjG5vyf6xXf1IPONHOFEwdX2lTm5nOVZPtu3EfT/X/Q4fcmQ9IQyLbpQLEaup2bAAAhH+M8Bzzk8Q6KkmvG1fQhQPA6TqFpq9VGuJR5Km73wMEXaBMKL3L5xAYUWhSoDvb7bvPmp1jcLFh5EZhxYWBs2b0TyR7MVQi8xgfKzfU02cpIxO8DEc3KV/oF3DzoGkjfd4CQb6LVu4LqvHTkia6Bv0R55D6WHwhDVHqLeFYMucdWh2asjMskipsJDl50zvybo1EfDrSTIs4GNDr461WSFt+lP76R/RTi++9unEPE0Fmr/eD8JAEF0ohrGeTJmeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed6e3mG1aHC3xGM37w+CGh6s3kI6/NaQj8C/i1AyzqU=;
 b=ay1Ep2O7SxV3v7ELxca45k8hSA0VbOQ/1GphPzUD+/EMthTCMGlZtceIYnIi0Gf7UJc43k7w4qMqOKYZ4rI0tbsngvD/ZYOeCmgj2PbPo0Qo0pAdPikVPRENShT6uAshRsttSFqoW3nM/ff5GwNGfduyIzvtImstG5HyOlURDIxIuvctiAiSIpWfs7k0tlLkO1xiD5ze3pL2EAQ63AdaS00cCrg0To8GJrMZh59hlfFEg+pIcmPbBEd6TjHzFEUupGiZHrqHy9lqsFlJEsxo4VcNA99xqgJIpFuAc+3Ke3xg5ciI0THuP+GRwsQcQOlbStjzrpzYjg9CkWBbZ2/7qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 09:42:43 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:42:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] sched_ext: Move built-in idle CPU selection policy to a separate file
Date: Tue, 17 Dec 2024 10:32:31 +0100
Message-ID: <20241217094156.577262-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217094156.577262-1-arighi@nvidia.com>
References: <20241217094156.577262-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2ebeb2-d774-41e0-2174-08dd1e7f27cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JZqJorX3YE+snyP8BTFCpgonA9p8F3DMMAOHW7xgGFV4qpj7fEBMjtwU8DLx?=
 =?us-ascii?Q?nVl26X5PTgxnCb++NbPc13sHtB5jFgrizSaJIpPM/6QzB3d8QAC61vcLCUsn?=
 =?us-ascii?Q?EnLNaVUgBhA/G38pHUg3/udsDEBvl+NHoG6IqEVFYbWDeNnFoJgCjLXZ2IYy?=
 =?us-ascii?Q?cK6btNBydrY5Wm/RYZ1/0l8qltLDsd94KxAabZ+4XrpaOcYveEt+NfzEpUxn?=
 =?us-ascii?Q?3b2N4yQiqld0GNNmt/RY3jTfJR1xJK88f3zQPKu0JD9m4SZp2AUWggXl0pkG?=
 =?us-ascii?Q?8zg1lFCcAMLphYlOqHKCEvlFLhKf4H3woesgkrG3NW3xq4tGbOpnhWjAFerE?=
 =?us-ascii?Q?7cJ65c53KbzUUsKrp3lbVUKiYowMiQ7Fhnog0cZAHp4pWpkE5P7b1qnK/u63?=
 =?us-ascii?Q?t/xwSj8TU0EU1Ex+rT3L2rvRXH8havJt5gzyDX3DX3ASpTLC8BkVbOGqYJCU?=
 =?us-ascii?Q?EhAD5zqDtT1P00ANOuvmhUwgxVpZReSqQTQtnw1SYY9GB1vSoE0IzN7jdtKN?=
 =?us-ascii?Q?jlpmv5NN9EOElGqv77yLUy+B9XUqhG+bztvIJunSgkbnPlGxppgvZl2CI3k2?=
 =?us-ascii?Q?o/fLimUK/nEClHkXE+pu0sWc4M8qPgYEpEdePhdwW7JH0PXV5buVAPUuNn9h?=
 =?us-ascii?Q?KkVRgQ2MdyCGyv7TgkJVtZEaCgonRYoVYh8KKK6Hv8Zj2rIog9XE3PP9mA8s?=
 =?us-ascii?Q?6H7ncuwJBHwcoMlx03C9B5CIqzQAJnosQlsa6Z8hqVPadQRED61LP/geNXlo?=
 =?us-ascii?Q?NnvUUX3Ra7ZuObIxKYU4PZxiAUy8McFRfYcoO/93Z8a3Tfh6t3vDqbZGXxVj?=
 =?us-ascii?Q?IGHe/6rdckGZd+nZnh9Lb0jIeTnOe4b3LBdJI+d9hytalBG7r8xEKCWVGpQ3?=
 =?us-ascii?Q?JOyAAzGKgPwlGkG5UaQbSkwWwgb5TRXYwxXeBOdiH+Tro9y/l/MdtYfhKert?=
 =?us-ascii?Q?Cb59kF7h1kDrJjq/u1PwRQPPQS6VKewBsL8LavlojOL7MBQ7C58K2CmkPqHM?=
 =?us-ascii?Q?A9eOuwf7Yob9nBNaQxp+ELCu2zWrgVbvvQ07ozE0WF0WVFuGBMuthGMwnOr+?=
 =?us-ascii?Q?uXuM/LoETXCIms17Spcf4GyUMjMjFGDEoRYjnYuZXZoT6FXsFNUbP3L/FQPk?=
 =?us-ascii?Q?VmWdy4vX12UEndFremLaE/QkRD/VdREKqkden8guWMVdz6OXrJveGj/vZFVV?=
 =?us-ascii?Q?PNwA4AwB2Wm7WrfM6fbgAQ4XBf4IdODMnLp5ljgeMRZ1ry8Zyelk6NBdCpSP?=
 =?us-ascii?Q?BwRwH8NJLkMJtWYH8WMlOKVOSFgBYfzMYvL2u9GvziDj7i4GCBm9SQwE2NUn?=
 =?us-ascii?Q?me4aPk/ZXmaZf5Hf0AaPRQiRmB86eGgw9Cm9WKtqgu/2OUUkiZ///Ru/iYG+?=
 =?us-ascii?Q?XKgix212j5l1tHWgNcvqUIWwCAY2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ln4qKS31k1kFpHZfq4/oyj+TFNQ3IemngP9nuaSdFejUxgn6UmLdHyrYirc8?=
 =?us-ascii?Q?ZvanJjwf0OluY0PVcpuB8Pp6EqZHTTTel9BUxOWXFCTDNvESW4JSp3g5jaAF?=
 =?us-ascii?Q?BLB00izpOViRe28HyDFRs8Zn35IRvOm20TkiZD3QV9mpA4ImdhX+p3XpUi92?=
 =?us-ascii?Q?v4kwpl9bgA3gKytPGf6+HkJPa8oflCIiDovwywl8lkkCPWU/vPks2Bw4zM/Z?=
 =?us-ascii?Q?jlPAbQpLevPWd4rHT2YPgRSo+V0CLnFYudvlo7PBlx9lstl+NAL6ya8Rmdt8?=
 =?us-ascii?Q?pXPXWWhmGKbhLlOTzTfw7hCHhSbbr+F5ZB4aXG3xiKahK+g75rxjv3DCQLxL?=
 =?us-ascii?Q?RHNtaNP009jaifakvgGbXtE2iZl+cZZ89kNaXW9IYgTQeWOO0tB+l0je2ogD?=
 =?us-ascii?Q?K3k1Pd6muZgv/ySq9SWrP2v1hCxPT+s7X6vPNINmLM+U5XcDZ8akqbFVvFQV?=
 =?us-ascii?Q?RXbvkT0aT2AsW2uQpUwJjC6JbW/OGkuCbr3xPs96fUwyfzJrQszDl9itYIt0?=
 =?us-ascii?Q?/uouIiFAFWz5oOzckhnjahU/zbgNqH1z/e6xWPiqz4oERdb4iL4z58NRkJxH?=
 =?us-ascii?Q?XUp/diCeYoZJT72bBsVcgGlzIPYLbcQ/ah3YLem9Cj1j49CxEI6RB1qonBvz?=
 =?us-ascii?Q?NiT8GMlb5HHHve4cZVFWbNBrqxrivultfOYfKRVkEjZzSMvRnRwc++PIp+RX?=
 =?us-ascii?Q?KmZGfNsxF1ECj0+lW7ISuIeB8htmgsJp2nbZ6ux9C9pAxtG1qgVeYZCXfhca?=
 =?us-ascii?Q?RJzCFC/CR2kFSPb0uVCuJc6MwW/fw//svB0yyHDA5SaojIvPvo2J4I9Cu1xt?=
 =?us-ascii?Q?6b3R7z/3SFXaA8Y4Mnk1VG7DefvDWj0yTsPrQw8h+PgblQiHRMsU69VhtXN8?=
 =?us-ascii?Q?tGViEY+qcX0iVvNRqTig0Kj75Wf/x1KRuP0SOUDPnmsW1R1S3vW8PtOFx6KU?=
 =?us-ascii?Q?XDZRI3s2T4L8VizRsCvLde4CMf2zeJzPMp/mwC1A0m8uxrmghdQRR8LaOjjk?=
 =?us-ascii?Q?uCIQ5Fmx2h8Thik8akuexAnLzdrTwtZ9hGtBZUfYFT0UHTj1tZb3SEAjRY+a?=
 =?us-ascii?Q?V3nQmeyJIS7a5p8q09BpBJ7Phhb5wmcbhctHanbNTnMR4MEJwjSRCA8uutBy?=
 =?us-ascii?Q?CZi6fMGwm+uIaEOfHyLH6CzMvQTpiXqhC+lodo43EmRgWabw5WahPBcowrFs?=
 =?us-ascii?Q?Yevh9MxFp6Xd+2E5dyTYbRPtG0FZ17QR629chWu9OZ5oeYzrm7AJNyQbFTJh?=
 =?us-ascii?Q?vjQi11zMlbRVkAdm8YrJTI4KisJCUAOhBA0Rpq7P3s4dFsZ7Oa6KUNI5J5EP?=
 =?us-ascii?Q?OGrgLE8YOaqh8XYCW1vLgY+wvTvow3whxKRRfR/feuKmkuQ0HEpotftxRnlJ?=
 =?us-ascii?Q?RrDeo9lC1ALpXG93wp3aeuIFgEmYM2jEUsJkQ/N+DAWds0IgVCP4vvjgBVke?=
 =?us-ascii?Q?oZfpIW7s2EqdZRuRdBymWJAnv4xsUCr5frQIhaoToJjVxSy6fLJzpbKQ+TPw?=
 =?us-ascii?Q?akM2CRci3b8vkN8i9LYVcmFY2qJsf9gY1QKEg8jIXaDC0zXqYKOZ1VHdfiU9?=
 =?us-ascii?Q?Rp56SdtKJBM3C8tOb7RBoYDcdcBsZJ2dBmupcCkv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2ebeb2-d774-41e0-2174-08dd1e7f27cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:42:43.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD9Z/kwzcafnQgO1pwfSWrW8NYLu0C5h30IoZNu6/qYz0dyb1Sl++bcf8BTuG5p36rwjWLpN/6NnlWZZP1ocHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

As ext.c is becoming quite large, move the idle CPU selection policy
to a separate file (ext_idle.c) for better code readability.

No functional change, this is purely code reorganization.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 MAINTAINERS             |   1 +
 kernel/sched/ext.c      | 857 +---------------------------------------
 kernel/sched/ext_idle.c | 835 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 853 insertions(+), 840 deletions(-)
 create mode 100644 kernel/sched/ext_idle.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..02960d1b9ee9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20909,6 +20909,7 @@ T:	git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git
 F:	include/linux/sched/ext.h
 F:	kernel/sched/ext.h
 F:	kernel/sched/ext.c
+F:	kernel/sched/ext_idle.c
 F:	tools/sched_ext/
 F:	tools/testing/selftests/sched_ext
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1edf4206aab5..40d13594c1d1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
  */
+#include <linux/btf_ids.h>
+
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
 
 enum scx_consts {
@@ -890,12 +892,6 @@ static bool scx_warned_zero_slice;
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
-static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
-static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
-
-#ifdef CONFIG_SMP
-static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
-#endif
 
 static struct static_key_false scx_has_op[SCX_OPI_END] =
 	{ [0 ... SCX_OPI_END-1] = STATIC_KEY_FALSE_INIT };
@@ -903,6 +899,17 @@ static struct static_key_false scx_has_op[SCX_OPI_END] =
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info *scx_exit_info;
 
+#define scx_ops_error_kind(err, fmt, args...)					\
+	scx_ops_exit_kind((err), 0, fmt, ##args)
+
+#define scx_ops_exit(code, fmt, args...)					\
+	scx_ops_exit_kind(SCX_EXIT_UNREG_KERN, (code), fmt, ##args)
+
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
+
+#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
+
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
@@ -930,97 +937,6 @@ static unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
 
 static struct delayed_work scx_watchdog_work;
 
-/* idle tracking */
-#ifdef CONFIG_SMP
-#ifdef CONFIG_CPUMASK_OFFSTACK
-#define CL_ALIGNED_IF_ONSTACK
-#else
-#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
-#endif
-
-struct idle_cpumask {
-	cpumask_var_t cpu;
-	cpumask_var_t smt;
-};
-
-/*
- * Make sure a NUMA node is in a valid range.
- */
-static int validate_node(int node)
-{
-	/* If no node is specified, return the current one */
-	if (node == NUMA_NO_NODE)
-		return numa_node_id();
-
-	/* Make sure node is in the range of possible nodes */
-	if (node < 0 || node >= num_possible_nodes())
-		return -EINVAL;
-
-	return node;
-}
-
-/*
- * cpumasks to track idle CPUs within each NUMA node.
- *
- * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
- * from node 0 is used to track all idle CPUs system-wide.
- */
-static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
-
-static struct cpumask *get_idle_mask_node(int node, bool smt)
-{
-	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
-		return smt ? idle_masks[0]->smt : idle_masks[0]->cpu;
-
-	node = validate_node(node);
-	if (node < 0)
-		return cpu_none_mask;
-
-	return smt ? idle_masks[node]->smt : idle_masks[node]->cpu;
-}
-
-static struct cpumask *get_idle_cpumask_node(int node)
-{
-	return get_idle_mask_node(node, false);
-}
-
-static struct cpumask *get_idle_smtmask_node(int node)
-{
-	return get_idle_mask_node(node, true);
-}
-
-static void idle_masks_init(void)
-{
-	int node;
-
-	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
-	BUG_ON(!idle_masks);
-
-	for_each_node_state(node, N_POSSIBLE) {
-		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
-		BUG_ON(!idle_masks[node]);
-
-		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
-		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
-	}
-}
-#else	/* !CONFIG_SMP */
-static int validate_node(int node)
-{
-	return numa_node_id();
-}
-
-static struct cpumask *get_idle_cpumask_node(int node)
-{
-	return cpu_none_mask;
-}
-
-static struct cpumask *get_idle_smtmask_node(int node)
-{
-	return cpu_none_mask;
-}
-#endif	/* CONFIG_SMP */
-
 /* for %SCX_KICK_WAIT */
 static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
 
@@ -1107,17 +1023,6 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     s64 exit_code,
 					     const char *fmt, ...);
 
-#define scx_ops_error_kind(err, fmt, args...)					\
-	scx_ops_exit_kind((err), 0, fmt, ##args)
-
-#define scx_ops_exit(code, fmt, args...)					\
-	scx_ops_exit_kind(SCX_EXIT_UNREG_KERN, (code), fmt, ##args)
-
-#define scx_ops_error(fmt, args...)						\
-	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
-
-#define SCX_HAS_OP(op)	static_branch_likely(&scx_has_op[SCX_OP_IDX(op)])
-
 static long jiffies_delta_msecs(unsigned long at, unsigned long now)
 {
 	if (time_after(at, now))
@@ -1624,6 +1529,9 @@ static int ops_sanitize_err(const char *ops_name, s32 err)
 	return -EPROTO;
 }
 
+/* Built-in idle CPU selection policy */
+#include "ext_idle.c"
+
 static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
@@ -3247,406 +3155,6 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 #endif	/* CONFIG_SCHED_CORE */
 
 #ifdef CONFIG_SMP
-
-static bool test_and_clear_cpu_idle(int cpu)
-{
-	int node = cpu_to_node(cpu);
-	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
-
-#ifdef CONFIG_SCHED_SMT
-	/*
-	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
-	 * cluster is not wholly idle either way. This also prevents
-	 * scx_pick_idle_cpu() from getting caught in an infinite loop.
-	 */
-	if (sched_smt_active()) {
-		const struct cpumask *smt = cpu_smt_mask(cpu);
-		struct cpumask *idle_smt = get_idle_smtmask_node(node);
-
-		/*
-		 * If offline, @cpu is not its own sibling and
-		 * scx_pick_idle_cpu() can get caught in an infinite loop as
-		 * @cpu is never cleared from the idle SMT mask. Ensure that
-		 * @cpu is eventually cleared.
-		 *
-		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
-		 * reduce memory writes, which may help alleviate cache
-		 * coherence pressure.
-		 */
-		if (cpumask_intersects(smt, idle_smt))
-			cpumask_andnot(idle_smt, idle_smt, smt);
-		else if (cpumask_test_cpu(cpu, idle_smt))
-			__cpumask_clear_cpu(cpu, idle_smt);
-	}
-#endif
-	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
-}
-
-static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
-{
-	int cpu;
-
-retry:
-	if (sched_smt_active()) {
-		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
-		if (cpu < nr_cpu_ids)
-			goto found;
-
-		if (flags & SCX_PICK_IDLE_CORE)
-			return -EBUSY;
-	}
-
-	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
-	if (cpu >= nr_cpu_ids)
-		return -EBUSY;
-
-found:
-	if (test_and_clear_cpu_idle(cpu))
-		return cpu;
-	else
-		goto retry;
-
-}
-
-static s32
-scx_pick_idle_cpu_numa(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
-{
-	nodemask_t hop_nodes = NODE_MASK_NONE;
-	int start_node = cpu_to_node(prev_cpu);
-	s32 cpu = -EBUSY;
-
-	/*
-	 * Traverse all online nodes in order of increasing distance,
-	 * starting from prev_cpu's node.
-	 */
-	rcu_read_lock();
-	for_each_numa_hop_node(node, start_node, hop_nodes, N_ONLINE) {
-		cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
-		if (cpu >= 0)
-			break;
-	}
-	rcu_read_unlock();
-
-	return cpu;
-}
-
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
-{
-	/*
-	 * Only node 0 is used if per-node idle cpumasks are disabled.
-	 */
-	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
-		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
-
-	return scx_pick_idle_cpu_numa(cpus_allowed, prev_cpu, flags);
-}
-
-/*
- * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
- * domain is not defined).
- */
-static unsigned int llc_weight(s32 cpu)
-{
-	struct sched_domain *sd;
-
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	if (!sd)
-		return 0;
-
-	return sd->span_weight;
-}
-
-/*
- * Return the cpumask representing the LLC domain of @cpu (or NULL if the LLC
- * domain is not defined).
- */
-static struct cpumask *llc_span(s32 cpu)
-{
-	struct sched_domain *sd;
-
-	sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	if (!sd)
-		return 0;
-
-	return sched_domain_span(sd);
-}
-
-/*
- * Return the amount of CPUs in the same NUMA domain of @cpu (or zero if the
- * NUMA domain is not defined).
- */
-static unsigned int numa_weight(s32 cpu)
-{
-	struct sched_domain *sd;
-	struct sched_group *sg;
-
-	sd = rcu_dereference(per_cpu(sd_numa, cpu));
-	if (!sd)
-		return 0;
-	sg = sd->groups;
-	if (!sg)
-		return 0;
-
-	return sg->group_weight;
-}
-
-/*
- * Return true if the LLC domains do not perfectly overlap with the NUMA
- * domains, false otherwise.
- */
-static bool llc_numa_mismatch(void)
-{
-	int cpu;
-
-	/*
-	 * We need to scan all online CPUs to verify whether their scheduling
-	 * domains overlap.
-	 *
-	 * While it is rare to encounter architectures with asymmetric NUMA
-	 * topologies, CPU hotplugging or virtualized environments can result
-	 * in asymmetric configurations.
-	 *
-	 * For example:
-	 *
-	 *  NUMA 0:
-	 *    - LLC 0: cpu0..cpu7
-	 *    - LLC 1: cpu8..cpu15 [offline]
-	 *
-	 *  NUMA 1:
-	 *    - LLC 0: cpu16..cpu23
-	 *    - LLC 1: cpu24..cpu31
-	 *
-	 * In this case, if we only check the first online CPU (cpu0), we might
-	 * incorrectly assume that the LLC and NUMA domains are fully
-	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
-	 * domains).
-	 */
-	for_each_online_cpu(cpu)
-		if (llc_weight(cpu) != numa_weight(cpu))
-			return true;
-
-	return false;
-}
-
-/*
- * Initialize topology-aware scheduling.
- *
- * Detect if the system has multiple LLC or multiple NUMA domains and enable
- * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
- * selection policy.
- *
- * Assumption: the kernel's internal topology representation assumes that each
- * CPU belongs to a single LLC domain, and that each LLC domain is entirely
- * contained within a single NUMA node.
- */
-static void update_selcpu_topology(struct sched_ext_ops *ops)
-{
-	bool enable_llc = false;
-	unsigned int nr_cpus;
-	s32 cpu = cpumask_first(cpu_online_mask);
-
-	/*
-	 * Enable LLC domain optimization only when there are multiple LLC
-	 * domains among the online CPUs. If all online CPUs are part of a
-	 * single LLC domain, the idle CPU selection logic can choose any
-	 * online CPU without bias.
-	 *
-	 * Note that it is sufficient to check the LLC domain of the first
-	 * online CPU to determine whether a single LLC domain includes all
-	 * CPUs.
-	 */
-	rcu_read_lock();
-	nr_cpus = llc_weight(cpu);
-	if (nr_cpus > 0) {
-		if (nr_cpus < num_online_cpus())
-			enable_llc = true;
-		/*
-		 * No need to enable LLC optimization if the LLC domains are
-		 * perfectly overlapping with the NUMA domains when per-node
-		 * cpumasks are enabled.
-		 */
-		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
-		    !llc_numa_mismatch())
-			enable_llc = false;
-		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
-			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
-	}
-	rcu_read_unlock();
-
-	pr_debug("sched_ext: LLC idle selection %s\n",
-		 enable_llc ? "enabled" : "disabled");
-
-	if (enable_llc)
-		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
-	else
-		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
-
-	/*
-	 * Check if we need to enable per-node cpumasks.
-	 */
-	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
-		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
-	else
-		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
-}
-
-/*
- * Built-in CPU idle selection policy:
- *
- * 1. Prioritize full-idle cores:
- *   - always prioritize CPUs from fully idle cores (both logical CPUs are
- *     idle) to avoid interference caused by SMT.
- *
- * 2. Reuse the same CPU:
- *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
- *     branch prediction optimizations.
- *
- * 3. Pick a CPU within the same LLC (Last-Level Cache):
- *   - if the above conditions aren't met, pick a CPU that shares the same LLC
- *     to maintain cache locality.
- *
- * 4. Pick a CPU within the same NUMA node, if enabled:
- *   - choose a CPU from the same NUMA node to reduce memory access latency.
- *
- * 5. Pick any idle CPU usable by the task.
- *
- * Step 3 is performed only if the system has multiple LLC domains that are not
- * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
- *
- * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
- * we never call ops.select_cpu() for them, see select_task_rq().
- */
-static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
-			      u64 wake_flags, bool *found)
-{
-	const struct cpumask *llc_cpus = NULL;
-	int node = cpu_to_node(prev_cpu);
-	s32 cpu;
-
-	*found = false;
-
-	/*
-	 * This is necessary to protect llc_cpus.
-	 */
-	rcu_read_lock();
-
-	/*
-	 * Determine the scheduling domain only if the task is allowed to run
-	 * on all CPUs.
-	 *
-	 * This is done primarily for efficiency, as it avoids the overhead of
-	 * updating a cpumask every time we need to select an idle CPU (which
-	 * can be costly in large SMP systems), but it also aligns logically:
-	 * if a task's scheduling domain is restricted by user-space (through
-	 * CPU affinity), the task will simply use the flat scheduling domain
-	 * defined by user-space.
-	 */
-	if (p->nr_cpus_allowed >= num_possible_cpus())
-		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
-			llc_cpus = llc_span(prev_cpu);
-
-	/*
-	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
-	 */
-	if (wake_flags & SCX_WAKE_SYNC) {
-		cpu = smp_processor_id();
-
-		/*
-		 * If the waker's CPU is cache affine and prev_cpu is idle,
-		 * then avoid a migration.
-		 */
-		if (cpus_share_cache(cpu, prev_cpu) &&
-		    test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		}
-
-		/*
-		 * If the waker's local DSQ is empty, and the system is under
-		 * utilized, try to wake up @p to the local DSQ of the waker.
-		 *
-		 * Checking only for an empty local DSQ is insufficient as it
-		 * could give the wakee an unfair advantage when the system is
-		 * oversaturated.
-		 *
-		 * Checking only for the presence of idle CPUs is also
-		 * insufficient as the local DSQ of the waker could have tasks
-		 * piled up on it even if there is an idle core elsewhere on
-		 * the system.
-		 */
-		if (!(current->flags & PF_EXITING) &&
-		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
-		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr))
-				goto cpu_found;
-		}
-	}
-
-	/*
-	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
-	 * partially idle @prev_cpu.
-	 */
-	if (sched_smt_active()) {
-		/*
-		 * Keep using @prev_cpu if it's part of a fully idle core.
-		 */
-		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
-		    test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		}
-
-		/*
-		 * Search for any fully idle core in the same LLC domain.
-		 */
-		if (llc_cpus) {
-			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
-			if (cpu >= 0)
-				goto cpu_found;
-		}
-
-		/*
-		 * Search for any full idle core usable by the task.
-		 */
-		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
-	/*
-	 * Use @prev_cpu if it's idle.
-	 */
-	if (test_and_clear_cpu_idle(prev_cpu)) {
-		cpu = prev_cpu;
-		goto cpu_found;
-	}
-
-	/*
-	 * Search for any idle CPU in the same LLC domain.
-	 */
-	if (llc_cpus) {
-		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
-		if (cpu >= 0)
-			goto cpu_found;
-	}
-
-	/*
-	 * Search for any idle CPU usable by the task.
-	 */
-	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
-	if (cpu >= 0)
-		goto cpu_found;
-
-	rcu_read_unlock();
-	return prev_cpu;
-
-cpu_found:
-	rcu_read_unlock();
-
-	*found = true;
-	return cpu;
-}
-
 static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
 {
 	/*
@@ -3713,66 +3221,6 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 				 (struct cpumask *)p->cpus_ptr);
 }
 
-static void reset_idle_masks(void)
-{
-	int node;
-
-	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
-		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
-		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
-		return;
-	}
-
-	/*
-	 * Consider all online cpus idle. Should converge to the actual state
-	 * quickly.
-	 */
-	for_each_node_state(node, N_POSSIBLE) {
-		const struct cpumask *node_mask = cpumask_of_node(node);
-		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
-		struct cpumask *idle_smt = get_idle_smtmask_node(node);
-
-		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
-		cpumask_copy(idle_smt, idle_cpu);
-	}
-}
-
-void __scx_update_idle(struct rq *rq, bool idle)
-{
-	int cpu = cpu_of(rq);
-	int node = cpu_to_node(cpu);
-	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
-
-	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
-		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
-		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
-			return;
-	}
-
-	assign_cpu(cpu, idle_cpu, idle);
-
-#ifdef CONFIG_SCHED_SMT
-	if (sched_smt_active()) {
-		const struct cpumask *smt = cpu_smt_mask(cpu);
-		struct cpumask *idle_smt = get_idle_smtmask_node(node);
-
-		if (idle) {
-			/*
-			 * idle_smt handling is racy but that's fine as it's
-			 * only for optimization and self-correcting.
-			 */
-			for_each_cpu(cpu, smt) {
-				if (!cpumask_test_cpu(cpu, idle_cpu))
-					return;
-			}
-			cpumask_or(idle_smt, idle_smt, smt);
-		} else {
-			cpumask_andnot(idle_smt, idle_smt, smt);
-		}
-	}
-#endif
-}
-
 static void handle_hotplug(struct rq *rq, bool online)
 {
 	int cpu = cpu_of(rq);
@@ -3811,21 +3259,7 @@ static void rq_offline_scx(struct rq *rq)
 {
 	rq->scx.flags &= ~SCX_RQ_ONLINE;
 }
-
-#else	/* CONFIG_SMP */
-
-static bool test_and_clear_cpu_idle(int cpu) { return false; }
-static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
-{
-	return -EBUSY;
-}
-static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
-{
-	return -EBUSY;
-}
-static void reset_idle_masks(void) {}
-
-#endif	/* CONFIG_SMP */
+#endif /* CONFIG_SMP */
 
 static bool check_rq_for_timeouts(struct rq *rq)
 {
@@ -6399,71 +5833,6 @@ void __init init_sched_ext_class(void)
 /********************************************************************************
  * Helpers that can be called from the BPF scheduler.
  */
-#include <linux/btf_ids.h>
-
-static bool check_builtin_idle_enabled(void)
-{
-	if (static_branch_likely(&scx_builtin_idle_enabled))
-		return true;
-
-	scx_ops_error("built-in idle tracking is disabled");
-	return false;
-}
-
-static bool check_builtin_idle_per_node_enabled(void)
-{
-	if (static_branch_likely(&scx_builtin_idle_per_node))
-		return true;
-
-	scx_ops_error("per-node idle tracking is disabled");
-	return false;
-}
-
-__bpf_kfunc_start_defs();
-
-/**
- * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
- * @p: task_struct to select a CPU for
- * @prev_cpu: CPU @p was on previously
- * @wake_flags: %SCX_WAKE_* flags
- * @is_idle: out parameter indicating whether the returned CPU is idle
- *
- * Can only be called from ops.select_cpu() if the built-in CPU selection is
- * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
- * @p, @prev_cpu and @wake_flags match ops.select_cpu().
- *
- * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
- * currently idle and thus a good candidate for direct dispatching.
- */
-__bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
-				       u64 wake_flags, bool *is_idle)
-{
-	if (!check_builtin_idle_enabled())
-		goto prev_cpu;
-
-	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
-		goto prev_cpu;
-
-#ifdef CONFIG_SMP
-	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
-#endif
-
-prev_cpu:
-	*is_idle = false;
-	return prev_cpu;
-}
-
-__bpf_kfunc_end_defs();
-
-BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
-BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
-BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
-
-static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
-	.owner			= THIS_MODULE,
-	.set			= &scx_kfunc_ids_select_cpu,
-};
-
 static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
 {
 	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
@@ -7535,189 +6904,6 @@ __bpf_kfunc void scx_bpf_put_cpumask(const struct cpumask *cpumask)
 	 */
 }
 
-/**
- * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask of a target NUMA node.
- *
- * Returns an empty cpumask if idle tracking is not enabled, if @node is not
- * valid, or running on a UP kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
-{
-	if (!check_builtin_idle_per_node_enabled())
-		return cpu_none_mask;
-
-	return get_idle_cpumask_node(node);
-}
-/**
- * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
- * per-CPU cpumask of the current NUMA node.
- *
- * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
- * kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
-{
-	if (!check_builtin_idle_enabled())
-		return cpu_none_mask;
-
-	return get_idle_cpumask_node(NUMA_NO_NODE);
-}
-
-/**
- * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask of a target NUMA node. Can be used to determine
- * if an entire physical core is free.
- *
- * Returns an empty cpumask if idle tracking is not enabled, if @node is not
- * valid, or running on a UP kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
-{
-	if (!check_builtin_idle_per_node_enabled())
-		return cpu_none_mask;
-
-	return get_idle_smtmask_node(node);
-}
-
-/**
- * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
- * per-physical-core cpumask of the current NUMA node. Can be used to determine
- * if an entire physical core is free.
- *
- * Returns an empty cumask if idle tracking is not enabled, or running on a UP
- * kernel.
- */
-__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
-{
-	if (!check_builtin_idle_enabled())
-		return cpu_none_mask;
-
-	return get_idle_smtmask_node(NUMA_NO_NODE);
-}
-
-/**
- * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
- * either the percpu, or SMT idle-tracking cpumask.
- */
-__bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
-{
-	/*
-	 * Empty function body because we aren't actually acquiring or releasing
-	 * a reference to a global idle cpumask, which is read-only in the
-	 * caller and is never released. The acquire / release semantics here
-	 * are just used to make the cpumask a trusted pointer in the caller.
-	 */
-}
-
-/**
- * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
- * @cpu: cpu to test and clear idle for
- *
- * Returns %true if @cpu was idle and its idle state was successfully cleared.
- * %false otherwise.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
- */
-__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
-{
-	if (!check_builtin_idle_enabled())
-		return false;
-
-	if (ops_cpu_valid(cpu, NULL))
-		return test_and_clear_cpu_idle(cpu);
-	else
-		return false;
-}
-
-/**
- * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
- * @node: target NUMA node
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
- * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
- * was found.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
- * not set.
- */
-__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
-				      u64 flags)
-{
-	node = validate_node(node);
-	if (node < 0)
-		return node;
-
-	if (!check_builtin_idle_per_node_enabled())
-		return -EBUSY;
-
-	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
-}
-
-/**
- * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
- * number on success. -%EBUSY if no matching cpu was found.
- *
- * Idle CPU tracking may race against CPU scheduling state transitions. For
- * example, this function may return -%EBUSY as CPUs are transitioning into the
- * idle state. If the caller then assumes that there will be dispatch events on
- * the CPUs as they were all busy, the scheduler may end up stalling with CPUs
- * idling while there are pending tasks. Use scx_bpf_pick_any_cpu() and
- * scx_bpf_kick_cpu() to guarantee that there will be at least one dispatch
- * event in the near future.
- *
- * Unavailable if ops.update_idle() is implemented and
- * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
- */
-__bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
-				      u64 flags)
-{
-	if (!check_builtin_idle_enabled())
-		return -EBUSY;
-
-	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
-}
-
-/**
- * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
- * @cpus_allowed: Allowed cpumask
- * @flags: %SCX_PICK_IDLE_CPU_* flags
- *
- * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
- * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
- * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
- * empty.
- *
- * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
- * set, this function can't tell which CPUs are idle and will always pick any
- * CPU.
- */
-__bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
-				     u64 flags)
-{
-	s32 cpu;
-
-	if (static_branch_likely(&scx_builtin_idle_enabled)) {
-		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
-		if (cpu >= 0)
-			return cpu;
-	}
-
-	cpu = cpumask_any_distribute(cpus_allowed);
-	if (cpu < nr_cpu_ids)
-		return cpu;
-	else
-		return -EBUSY;
-}
-
 /**
  * scx_bpf_task_running - Is task currently running?
  * @p: task of interest
@@ -7796,15 +6982,6 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_to_node)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_put_cpumask, KF_RELEASE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
-BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
-BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
-BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
-BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
new file mode 100644
index 000000000000..ec36848c1a10
--- /dev/null
+++ b/kernel/sched/ext_idle.c
@@ -0,0 +1,835 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
+ *
+ * Built-in idle CPU tracking policy.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ * Copyright (c) 2024 Andrea Righi <arighi@nvidia.com>
+ */
+
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
+static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_per_node);
+
+static bool check_builtin_idle_enabled(void)
+{
+	if (static_branch_likely(&scx_builtin_idle_enabled))
+		return true;
+
+	scx_ops_error("built-in idle tracking is disabled");
+	return false;
+}
+
+static bool check_builtin_idle_per_node_enabled(void)
+{
+	if (static_branch_likely(&scx_builtin_idle_per_node))
+		return true;
+
+	scx_ops_error("per-node idle tracking is disabled");
+	return false;
+}
+
+#ifdef CONFIG_SMP
+static DEFINE_STATIC_KEY_FALSE(scx_selcpu_topo_llc);
+
+#ifdef CONFIG_CPUMASK_OFFSTACK
+#define CL_ALIGNED_IF_ONSTACK
+#else
+#define CL_ALIGNED_IF_ONSTACK __cacheline_aligned_in_smp
+#endif
+
+struct idle_cpumask {
+	cpumask_var_t cpu;
+	cpumask_var_t smt;
+};
+
+/*
+ * cpumasks to track idle CPUs within each NUMA node.
+ *
+ * If SCX_OPS_BUILTIN_IDLE_PER_NODE is not specified, a single flat cpumask
+ * from node 0 is used to track all idle CPUs system-wide.
+ */
+static struct idle_cpumask **idle_masks CL_ALIGNED_IF_ONSTACK;
+
+/*
+ * Make sure a NUMA node is in a valid range.
+ */
+static int validate_node(int node)
+{
+	/* If no node is specified, return the current one */
+	if (node == NUMA_NO_NODE)
+		return numa_node_id();
+
+	/* Make sure node is in the range of possible nodes */
+	if (node < 0 || node >= num_possible_nodes())
+		return -EINVAL;
+
+	return node;
+}
+
+static struct cpumask *get_idle_mask_node(int node, bool smt)
+{
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return smt ? idle_masks[0]->smt : idle_masks[0]->cpu;
+
+	node = validate_node(node);
+	if (node < 0)
+		return cpu_none_mask;
+
+	return smt ? idle_masks[node]->smt : idle_masks[node]->cpu;
+}
+
+static struct cpumask *get_idle_cpumask_node(int node)
+{
+	return get_idle_mask_node(node, false);
+}
+
+static struct cpumask *get_idle_smtmask_node(int node)
+{
+	return get_idle_mask_node(node, true);
+}
+
+static void idle_masks_init(void)
+{
+	int node;
+
+	idle_masks = kcalloc(num_possible_nodes(), sizeof(*idle_masks), GFP_KERNEL);
+	BUG_ON(!idle_masks);
+
+	for_each_node_state(node, N_POSSIBLE) {
+		idle_masks[node] = kzalloc_node(sizeof(**idle_masks), GFP_KERNEL, node);
+		BUG_ON(!idle_masks[node]);
+
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->cpu, GFP_KERNEL, node));
+		BUG_ON(!alloc_cpumask_var_node(&idle_masks[node]->smt, GFP_KERNEL, node));
+	}
+}
+
+static bool test_and_clear_cpu_idle(int cpu)
+{
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * SMT mask should be cleared whether we can claim @cpu or not. The SMT
+	 * cluster is not wholly idle either way. This also prevents
+	 * scx_pick_idle_cpu() from getting caught in an infinite loop.
+	 */
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		/*
+		 * If offline, @cpu is not its own sibling and
+		 * scx_pick_idle_cpu() can get caught in an infinite loop as
+		 * @cpu is never cleared from the idle SMT mask. Ensure that
+		 * @cpu is eventually cleared.
+		 *
+		 * NOTE: Use cpumask_intersects() and cpumask_test_cpu() to
+		 * reduce memory writes, which may help alleviate cache
+		 * coherence pressure.
+		 */
+		if (cpumask_intersects(smt, idle_smt))
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		else if (cpumask_test_cpu(cpu, idle_smt))
+			__cpumask_clear_cpu(cpu, idle_smt);
+	}
+#endif
+	return cpumask_test_and_clear_cpu(cpu, idle_cpu);
+}
+
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
+{
+	int cpu;
+
+retry:
+	if (sched_smt_active()) {
+		cpu = cpumask_any_and_distribute(get_idle_smtmask_node(node), cpus_allowed);
+		if (cpu < nr_cpu_ids)
+			goto found;
+
+		if (flags & SCX_PICK_IDLE_CORE)
+			return -EBUSY;
+	}
+
+	cpu = cpumask_any_and_distribute(get_idle_cpumask_node(node), cpus_allowed);
+	if (cpu >= nr_cpu_ids)
+		return -EBUSY;
+
+found:
+	if (test_and_clear_cpu_idle(cpu))
+		return cpu;
+	goto retry;
+
+}
+
+static s32
+scx_pick_idle_cpu_numa(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	nodemask_t hop_nodes = NODE_MASK_NONE;
+	int start_node = cpu_to_node(prev_cpu);
+	s32 cpu = -EBUSY;
+
+	/*
+	 * Traverse all online nodes in order of increasing distance,
+	 * starting from prev_cpu's node.
+	 */
+	rcu_read_lock();
+	for_each_numa_hop_node(node, start_node, hop_nodes, N_ONLINE) {
+		cpu = scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+		if (cpu >= 0)
+			break;
+	}
+	rcu_read_unlock();
+
+	return cpu;
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	/*
+	 * Only node 0 is used if per-node idle cpumasks are disabled.
+	 */
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
+		return scx_pick_idle_cpu_from_node(0, cpus_allowed, flags);
+
+	return scx_pick_idle_cpu_numa(cpus_allowed, prev_cpu, flags);
+}
+
+/*
+ * Return the amount of CPUs in the same LLC domain of @cpu (or zero if the LLC
+ * domain is not defined).
+ */
+static unsigned int llc_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sd->span_weight;
+}
+
+/*
+ * Return the cpumask representing the LLC domain of @cpu (or NULL if the LLC
+ * domain is not defined).
+ */
+static struct cpumask *llc_span(s32 cpu)
+{
+	struct sched_domain *sd;
+
+	sd = rcu_dereference(per_cpu(sd_llc, cpu));
+	if (!sd)
+		return 0;
+
+	return sched_domain_span(sd);
+}
+
+/*
+ * Return the amount of CPUs in the same NUMA domain of @cpu (or zero if the
+ * NUMA domain is not defined).
+ */
+static unsigned int numa_weight(s32 cpu)
+{
+	struct sched_domain *sd;
+	struct sched_group *sg;
+
+	sd = rcu_dereference(per_cpu(sd_numa, cpu));
+	if (!sd)
+		return 0;
+	sg = sd->groups;
+	if (!sg)
+		return 0;
+
+	return sg->group_weight;
+}
+
+/*
+ * Return true if the LLC domains do not perfectly overlap with the NUMA
+ * domains, false otherwise.
+ */
+static bool llc_numa_mismatch(void)
+{
+	int cpu;
+
+	/*
+	 * We need to scan all online CPUs to verify whether their scheduling
+	 * domains overlap.
+	 *
+	 * While it is rare to encounter architectures with asymmetric NUMA
+	 * topologies, CPU hotplugging or virtualized environments can result
+	 * in asymmetric configurations.
+	 *
+	 * For example:
+	 *
+	 *  NUMA 0:
+	 *    - LLC 0: cpu0..cpu7
+	 *    - LLC 1: cpu8..cpu15 [offline]
+	 *
+	 *  NUMA 1:
+	 *    - LLC 0: cpu16..cpu23
+	 *    - LLC 1: cpu24..cpu31
+	 *
+	 * In this case, if we only check the first online CPU (cpu0), we might
+	 * incorrectly assume that the LLC and NUMA domains are fully
+	 * overlapping, which is incorrect (as NUMA 1 has two distinct LLC
+	 * domains).
+	 */
+	for_each_online_cpu(cpu)
+		if (llc_weight(cpu) != numa_weight(cpu))
+			return true;
+
+	return false;
+}
+
+/*
+ * Initialize topology-aware scheduling.
+ *
+ * Detect if the system has multiple LLC or multiple NUMA domains and enable
+ * cache-aware / NUMA-aware scheduling optimizations in the default CPU idle
+ * selection policy.
+ *
+ * Assumption: the kernel's internal topology representation assumes that each
+ * CPU belongs to a single LLC domain, and that each LLC domain is entirely
+ * contained within a single NUMA node.
+ */
+static void update_selcpu_topology(struct sched_ext_ops *ops)
+{
+	bool enable_llc = false;
+	unsigned int nr_cpus;
+	s32 cpu = cpumask_first(cpu_online_mask);
+
+	/*
+	 * Enable LLC domain optimization only when there are multiple LLC
+	 * domains among the online CPUs. If all online CPUs are part of a
+	 * single LLC domain, the idle CPU selection logic can choose any
+	 * online CPU without bias.
+	 *
+	 * Note that it is sufficient to check the LLC domain of the first
+	 * online CPU to determine whether a single LLC domain includes all
+	 * CPUs.
+	 */
+	rcu_read_lock();
+	nr_cpus = llc_weight(cpu);
+	if (nr_cpus > 0) {
+		if (nr_cpus < num_online_cpus())
+			enable_llc = true;
+		/*
+		 * No need to enable LLC optimization if the LLC domains are
+		 * perfectly overlapping with the NUMA domains when per-node
+		 * cpumasks are enabled.
+		 */
+		if ((ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE) &&
+		    !llc_numa_mismatch())
+			enable_llc = false;
+		pr_debug("sched_ext: LLC=%*pb weight=%u\n",
+			 cpumask_pr_args(llc_span(cpu)), llc_weight(cpu));
+	}
+	rcu_read_unlock();
+
+	pr_debug("sched_ext: LLC idle selection %s\n",
+		 enable_llc ? "enabled" : "disabled");
+
+	if (enable_llc)
+		static_branch_enable_cpuslocked(&scx_selcpu_topo_llc);
+	else
+		static_branch_disable_cpuslocked(&scx_selcpu_topo_llc);
+
+	/*
+	 * Check if we need to enable per-node cpumasks.
+	 */
+	if (ops->flags & SCX_OPS_BUILTIN_IDLE_PER_NODE)
+		static_branch_enable_cpuslocked(&scx_builtin_idle_per_node);
+	else
+		static_branch_disable_cpuslocked(&scx_builtin_idle_per_node);
+}
+
+/*
+ * Built-in CPU idle selection policy:
+ *
+ * 1. Prioritize full-idle cores:
+ *   - always prioritize CPUs from fully idle cores (both logical CPUs are
+ *     idle) to avoid interference caused by SMT.
+ *
+ * 2. Reuse the same CPU:
+ *   - prefer the last used CPU to take advantage of cached data (L1, L2) and
+ *     branch prediction optimizations.
+ *
+ * 3. Pick a CPU within the same LLC (Last-Level Cache):
+ *   - if the above conditions aren't met, pick a CPU that shares the same LLC
+ *     to maintain cache locality.
+ *
+ * 4. Pick a CPU within the same NUMA node, if enabled:
+ *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *
+ * 5. Pick any idle CPU usable by the task.
+ *
+ * Step 3 is performed only if the system has multiple LLC domains that are not
+ * perfectly overlapping with the NUMA domains (see scx_selcpu_topo_llc).
+ *
+ * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
+ * we never call ops.select_cpu() for them, see select_task_rq().
+ */
+static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+			      u64 wake_flags, bool *found)
+{
+	const struct cpumask *llc_cpus = NULL;
+	int node = cpu_to_node(prev_cpu);
+	s32 cpu;
+
+	*found = false;
+
+	/*
+	 * This is necessary to protect llc_cpus.
+	 */
+	rcu_read_lock();
+
+	/*
+	 * Determine the scheduling domain only if the task is allowed to run
+	 * on all CPUs.
+	 *
+	 * This is done primarily for efficiency, as it avoids the overhead of
+	 * updating a cpumask every time we need to select an idle CPU (which
+	 * can be costly in large SMP systems), but it also aligns logically:
+	 * if a task's scheduling domain is restricted by user-space (through
+	 * CPU affinity), the task will simply use the flat scheduling domain
+	 * defined by user-space.
+	 */
+	if (p->nr_cpus_allowed >= num_possible_cpus())
+		if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
+			llc_cpus = llc_span(prev_cpu);
+
+	/*
+	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
+	 */
+	if (wake_flags & SCX_WAKE_SYNC) {
+		cpu = smp_processor_id();
+
+		/*
+		 * If the waker's CPU is cache affine and prev_cpu is idle,
+		 * then avoid a migration.
+		 */
+		if (cpus_share_cache(cpu, prev_cpu) &&
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		}
+
+		/*
+		 * If the waker's local DSQ is empty, and the system is under
+		 * utilized, try to wake up @p to the local DSQ of the waker.
+		 *
+		 * Checking only for an empty local DSQ is insufficient as it
+		 * could give the wakee an unfair advantage when the system is
+		 * oversaturated.
+		 *
+		 * Checking only for the presence of idle CPUs is also
+		 * insufficient as the local DSQ of the waker could have tasks
+		 * piled up on it even if there is an idle core elsewhere on
+		 * the system.
+		 */
+		if (!(current->flags & PF_EXITING) &&
+		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
+		    !cpumask_empty(get_idle_cpumask_node(cpu_to_node(cpu)))) {
+			if (cpumask_test_cpu(cpu, p->cpus_ptr))
+				goto cpu_found;
+		}
+	}
+
+	/*
+	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
+	 * partially idle @prev_cpu.
+	 */
+	if (sched_smt_active()) {
+		/*
+		 * Keep using @prev_cpu if it's part of a fully idle core.
+		 */
+		if (cpumask_test_cpu(prev_cpu, get_idle_smtmask_node(node)) &&
+		    test_and_clear_cpu_idle(prev_cpu)) {
+			cpu = prev_cpu;
+			goto cpu_found;
+		}
+
+		/*
+		 * Search for any fully idle core in the same LLC domain.
+		 */
+		if (llc_cpus) {
+			cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
+		/*
+		 * Search for any full idle core usable by the task.
+		 */
+		cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, SCX_PICK_IDLE_CORE);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Use @prev_cpu if it's idle.
+	 */
+	if (test_and_clear_cpu_idle(prev_cpu)) {
+		cpu = prev_cpu;
+		goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU in the same LLC domain.
+	 */
+	if (llc_cpus) {
+		cpu = scx_pick_idle_cpu_from_node(node, llc_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
+	/*
+	 * Search for any idle CPU usable by the task.
+	 */
+	cpu = scx_pick_idle_cpu(p->cpus_ptr, prev_cpu, 0);
+	if (cpu >= 0)
+		goto cpu_found;
+
+	rcu_read_unlock();
+	return prev_cpu;
+
+cpu_found:
+	rcu_read_unlock();
+
+	*found = true;
+	return cpu;
+}
+
+static void reset_idle_masks(void)
+{
+	int node;
+
+	if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
+		cpumask_copy(get_idle_cpumask_node(0), cpu_online_mask);
+		cpumask_copy(get_idle_smtmask_node(0), cpu_online_mask);
+		return;
+	}
+
+	/*
+	 * Consider all online cpus idle. Should converge to the actual state
+	 * quickly.
+	 */
+	for_each_node_state(node, N_POSSIBLE) {
+		const struct cpumask *node_mask = cpumask_of_node(node);
+		struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		cpumask_and(idle_cpu, cpu_online_mask, node_mask);
+		cpumask_copy(idle_smt, idle_cpu);
+	}
+}
+
+void __scx_update_idle(struct rq *rq, bool idle)
+{
+	int cpu = cpu_of(rq);
+	int node = cpu_to_node(cpu);
+	struct cpumask *idle_cpu = get_idle_cpumask_node(node);
+
+	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
+		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
+		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
+			return;
+	}
+
+	assign_cpu(cpu, idle_cpu, idle);
+
+#ifdef CONFIG_SCHED_SMT
+	if (sched_smt_active()) {
+		const struct cpumask *smt = cpu_smt_mask(cpu);
+		struct cpumask *idle_smt = get_idle_smtmask_node(node);
+
+		if (idle) {
+			/*
+			 * idle_smt handling is racy but that's fine as it's
+			 * only for optimization and self-correcting.
+			 */
+			for_each_cpu(cpu, smt) {
+				if (!cpumask_test_cpu(cpu, idle_cpu))
+					return;
+			}
+			cpumask_or(idle_smt, idle_smt, smt);
+		} else {
+			cpumask_andnot(idle_smt, idle_smt, smt);
+		}
+	}
+#endif
+}
+#else	/* !CONFIG_SMP */
+static inline int validate_node(int node)
+{
+	return numa_node_id();
+}
+
+static struct cpumask *get_idle_cpumask_node(int node)
+{
+	return cpu_none_mask;
+}
+
+static struct cpumask *get_idle_smtmask_node(int node)
+{
+	return cpu_none_mask;
+}
+
+static bool test_and_clear_cpu_idle(int cpu) { return false; }
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, s32 prev_cpu, u64 flags)
+{
+	return -EBUSY;
+}
+
+static s32 scx_pick_idle_cpu_from_node(int node, const struct cpumask *cpus_allowed, u64 flags)
+{
+	return -EBUSY;
+}
+static void reset_idle_masks(void) {}
+#endif	/* CONFIG_SMP */
+
+
+/********************************************************************************
+ * Helpers that can be called from the BPF scheduler.
+ */
+__bpf_kfunc_start_defs();
+
+/**
+ * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @is_idle: out parameter indicating whether the returned CPU is idle
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
+ * currently idle and thus a good candidate for direct dispatching.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
+				       u64 wake_flags, bool *is_idle)
+{
+	if (!check_builtin_idle_enabled())
+		goto prev_cpu;
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU))
+		goto prev_cpu;
+
+#ifdef CONFIG_SMP
+	return scx_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle);
+#endif
+
+prev_cpu:
+	*is_idle = false;
+	return prev_cpu;
+}
+
+/**
+ * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of a target NUMA node.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
+{
+	if (!check_builtin_idle_per_node_enabled())
+		return cpu_none_mask;
+
+	return get_idle_cpumask_node(node);
+}
+/**
+ * scx_bpf_get_idle_cpumask - Get a referenced kptr to the idle-tracking
+ * per-CPU cpumask of the current NUMA node.
+ *
+ * Returns an emtpy cpumask if idle tracking is not enabled, or running on a UP
+ * kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
+{
+	if (!check_builtin_idle_enabled())
+		return cpu_none_mask;
+
+	return get_idle_cpumask_node(NUMA_NO_NODE);
+}
+
+/**
+ * scx_bpf_get_idle_smtmask_node - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of a target NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * Returns an empty cpumask if idle tracking is not enabled, if @node is not
+ * valid, or running on a UP kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask_node(int node)
+{
+	if (!check_builtin_idle_per_node_enabled())
+		return cpu_none_mask;
+
+	return get_idle_smtmask_node(node);
+}
+
+/**
+ * scx_bpf_get_idle_smtmask - Get a referenced kptr to the idle-tracking,
+ * per-physical-core cpumask of the current NUMA node. Can be used to determine
+ * if an entire physical core is free.
+ *
+ * Returns an empty cumask if idle tracking is not enabled, or running on a UP
+ * kernel.
+ */
+__bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
+{
+	if (!check_builtin_idle_enabled())
+		return cpu_none_mask;
+
+	return get_idle_smtmask_node(NUMA_NO_NODE);
+}
+
+/**
+ * scx_bpf_put_idle_cpumask - Release a previously acquired referenced kptr to
+ * either the percpu, or SMT idle-tracking cpumask.
+ */
+__bpf_kfunc void scx_bpf_put_idle_cpumask(const struct cpumask *idle_mask)
+{
+	/*
+	 * Empty function body because we aren't actually acquiring or releasing
+	 * a reference to a global idle cpumask, which is read-only in the
+	 * caller and is never released. The acquire / release semantics here
+	 * are just used to make the cpumask a trusted pointer in the caller.
+	 */
+}
+
+/**
+ * scx_bpf_test_and_clear_cpu_idle - Test and clear @cpu's idle state
+ * @cpu: cpu to test and clear idle for
+ *
+ * Returns %true if @cpu was idle and its idle state was successfully cleared.
+ * %false otherwise.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
+{
+	if (!check_builtin_idle_enabled())
+		return false;
+
+	if (ops_cpu_valid(cpu, NULL))
+		return test_and_clear_cpu_idle(cpu);
+	else
+		return false;
+}
+
+/**
+ * scx_bpf_pick_idle_cpu_node - Pick and claim an idle cpu from a NUMA node
+ * @node: target NUMA node
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed from the NUMA node @node.
+ * Returns the picked idle cpu number on success. -%EBUSY if no matching cpu
+ * was found.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set or if %SCX_OPS_KEEP_BUILTIN_IDLE is
+ * not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu_node(int node, const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	node = validate_node(node);
+	if (node < 0)
+		return node;
+
+	if (!check_builtin_idle_per_node_enabled())
+		return -EBUSY;
+
+	return scx_pick_idle_cpu_from_node(node, cpus_allowed, flags);
+}
+
+/**
+ * scx_bpf_pick_idle_cpu - Pick and claim an idle cpu
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. Returns the picked idle cpu
+ * number on success. -%EBUSY if no matching cpu was found.
+ *
+ * Idle CPU tracking may race against CPU scheduling state transitions. For
+ * example, this function may return -%EBUSY as CPUs are transitioning into the
+ * idle state. If the caller then assumes that there will be dispatch events on
+ * the CPUs as they were all busy, the scheduler may end up stalling with CPUs
+ * idling while there are pending tasks. Use scx_bpf_pick_any_cpu() and
+ * scx_bpf_kick_cpu() to guarantee that there will be at least one dispatch
+ * event in the near future.
+ *
+ * Unavailable if ops.update_idle() is implemented and
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is not set.
+ */
+__bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
+				      u64 flags)
+{
+	if (!check_builtin_idle_enabled())
+		return -EBUSY;
+
+	return scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
+}
+
+/**
+ * scx_bpf_pick_any_cpu - Pick and claim an idle cpu if available or pick any CPU
+ * @cpus_allowed: Allowed cpumask
+ * @flags: %SCX_PICK_IDLE_CPU_* flags
+ *
+ * Pick and claim an idle cpu in @cpus_allowed. If none is available, pick any
+ * CPU in @cpus_allowed. Guaranteed to succeed and returns the picked idle cpu
+ * number if @cpus_allowed is not empty. -%EBUSY is returned if @cpus_allowed is
+ * empty.
+ *
+ * If ops.update_idle() is implemented and %SCX_OPS_KEEP_BUILTIN_IDLE is not
+ * set, this function can't tell which CPUs are idle and will always pick any
+ * CPU.
+ */
+__bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
+				     u64 flags)
+{
+	s32 cpu;
+
+	if (static_branch_likely(&scx_builtin_idle_enabled)) {
+		cpu = scx_pick_idle_cpu(cpus_allowed, smp_processor_id(), flags);
+		if (cpu >= 0)
+			return cpu;
+	}
+
+	cpu = cpumask_any_distribute(cpus_allowed);
+	if (cpu < nr_cpu_ids)
+		return cpu;
+	else
+		return -EBUSY;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_cpumask_node, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_get_idle_smtmask_node, KF_ACQUIRE)
+BTF_ID_FLAGS(func, scx_bpf_put_idle_cpumask, KF_RELEASE)
+BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu_node, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
+BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_select_cpu,
+};
-- 
2.47.1


