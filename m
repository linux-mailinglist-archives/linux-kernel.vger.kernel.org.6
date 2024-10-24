Return-Path: <linux-kernel+bounces-379493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2338D9ADF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CC61C203B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B66F1AF0AD;
	Thu, 24 Oct 2024 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mq4MHddh"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF851AB522
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758985; cv=fail; b=FwMTyaeIuivFIFrO9otfhafCWb7m276Y/habA7DtPQL4rKwMgHq/JXg2B+D9JkuLVy4KidElWJtq5+iroetcNXNvrtQGFoDR+U1UEN2WfdKmv86P06PODhcq9HQbU0IA6EBZMPA3st+PZp6HPP+GEuAHygAWiROYAQ2RG7NV/rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758985; c=relaxed/simple;
	bh=J3lKrDr7VisPa7I9jy8+PtA4uTqdBdUuhHa2h00iR14=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cMdHfp5Y7UdOyiYkKLwvgm6YHuMuYKM28VxBDZP8qwCaRR08wVseCBHxH3vTp2lR0qtgYMCMwHsfVbFgQEhkngqmrcxzqZgiaoJWDfUR79QsxMGNYu/vghX/PrUmsugu0GVb44m65hqe2/QFX6WUqGZMxWc4Durjp5b32ZKHb9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mq4MHddh; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJTQK1SrfzWWnvOgaCbrP+ULmzi9fo7jAlXPLEnhYCvGiykDhBjPE/1lIjmlrkyjrJkABzBcxcI2G+d0dlCiCdKBP9Hln0sEI7ira5RZ+g/JCldVFP3bsn1jU9R0zxGnSZoio+AsqA4duNKKhGKtYP+R3jnNzsQlaYVEFzBLHmTlToa025S82u0/sMthg0bGaxBarwqvRg9KCJv5pa7DJhg7DPvgocfS3wgBvPh7DxxJZvsUQAq3+uv8ysdAwXmiKymH2iQb5o1WtO2W9phApZy1AMfosIN+KV5T3LyNnKLCTLjTFgw1wSWynxG1XZz95OlooiZLKEKp4V6hrSKB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOm/7/+1RFpET/U/93yAsTnOrt91B4+0DDrorUwq60c=;
 b=AiUC/KPGu9V4Ye7wmczphSYwrqFgHSXd6EBBFJTeIS6GuUCld2rgjvxq3VYOa+zHcVKINKdb/VLn8vAdBqHK8uxHJZJOO0LSvaz/AD7a71psTYGSSZjrZJ1y9N/rOkqK4B5qey//ajtIv1KbHhxVRsZ60lQ86Uq+llSedENmN6w2sdt9SRNjRzuDdi5n5fLG4pYGFVkhXandikU8vV5gnZTzkrnjShPczpyOtD9O+kYCcs241sQZvJacfdCa72JmnAQC3uI3kUTnuIinDgDlbd/7t7cAlQqyWw/eCPgj9RPXMdTz9ZT2HU3TC6h6pmOVBbMOGu+Ek4G8CS9eor5JFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOm/7/+1RFpET/U/93yAsTnOrt91B4+0DDrorUwq60c=;
 b=mq4MHddhTouw6o2eWnbBcCmu/hI3I9IxsKSua6SRdBnJmRWYAfBNnFjE2t1+HyHXDNWs5/VlJIw1X1xvjBIlxGIOKZ9D/jA96np0t7/Vr8qh6c+2Bg6JjMpN6IcaNm2TT/8k5x54VNnDY/Wd0lmsar8+76NuXhcZ2G+xGKJB8hjOdob8fE8/SZJ8bbR0QdMdoTnzdKVTxh9pYkdaJWVBEDu9TRXyFzFyCBKVC4lhdV8Um9f+SO6AfFE1S4V4VbqaojfVB0NYwXlELG9pN1Y+Khi+gTIPhLiyoHyz9f/Gt+Q0B8+a3zoHTzVJ/wY80JmYzaDJWZXdCPFO3t+/PZK9rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 08:36:20 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 08:36:19 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Introduce NUMA awareness to the default idle selection policy
Date: Thu, 24 Oct 2024 10:36:15 +0200
Message-ID: <20241024083615.64948-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::10) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c24399-4955-441c-4442-08dcf406eedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wELYnc4ncecye5zS9aY/ZJNv3UzFyOFCuG0fJ2EAnmaaT0JFKGUU3fK/2i5+?=
 =?us-ascii?Q?iQdYPgMFJnVcGz9V7DVEhaEMwaezPe+1LvjjeYAd+JMXDWuyUmYxohHTsYdR?=
 =?us-ascii?Q?HOpGbzJvfjtPwl61zmslOOxqbKGsTcZR5SoGSeczpVFwcMNSuNarCU0WZ5ON?=
 =?us-ascii?Q?HEUQccLiucruig/kR9ntwuQTz9xNzw5w8KtrCoyKSKy2B3xmHf91I119qU9v?=
 =?us-ascii?Q?iVSkzT09lH3wRJ761a2Nt4LxfzcIcEWjXUzjVs4fH93ITS8Q1KTRc6J/z2af?=
 =?us-ascii?Q?GmGLkkFcVqGwfzp7jE6fHZFW+RYa9WqdUtc9rEuM/ekFCXLWM/12AeuCUBLk?=
 =?us-ascii?Q?g0/+6eWXJv0RrKiFQY58aNonlGzkxTDmZmtJKSHrPo493mCDkL/cdXXiFTQ1?=
 =?us-ascii?Q?j25oR3INcXx5O3YQiUYC1udqECFop2xDxh26DfI6Y3bdm8DTP76mCxX2/EmV?=
 =?us-ascii?Q?92uCRFB9CcoVOVSUkHbN9ZtamaxG7rqp01cMdRN1xq+3VIAtF44LFLIa97xl?=
 =?us-ascii?Q?sttWAlQCVysjO/tGOUcj4NGAr4Ik1+eGNXbaLsTYNrlF3e1MUuauKd5xGH/i?=
 =?us-ascii?Q?G2oCnBg2hIT7CZyzows8aqPzRj+QO95Awa6Cq82olSakCvY8OLPnnQTMFtzM?=
 =?us-ascii?Q?wOPcPnODyJLXPEc7eRGLgQdv4C4Q4l1mYwW2S3kzZW8dD9EaTmXvHox5DdKv?=
 =?us-ascii?Q?8dVTPtF5iJfdB8bfd/XLIVJbOUaSOLlvJjI8vZzvFbxQa6kyMvlSgxNCKks9?=
 =?us-ascii?Q?/9BWFHdhfPwstVuX4ogEb3O723YJIrfBaMhEf48+VodP5FnAld8FTd8/ltq4?=
 =?us-ascii?Q?A3kQAe7s4wDXLxlABEQsFZbF2yzqGUZeHNKHR6vPNnt2mATLm+ENnCVa5wo/?=
 =?us-ascii?Q?LcecoYRvD98QdczfhGO6YLgGxhf9ymyAcNjRog6QhH460HtzZYOS8WSPT/7x?=
 =?us-ascii?Q?QIgP21cfXhkTa4+hcQ1QNTRoN6XnVF3Zgv/f3T52UgLSCGTi3AUKoN0d19nB?=
 =?us-ascii?Q?Bd9QrXKBKEXZkgdufkdLsync4oCjMPK0LDKF+QWxXNhtO79EDpNEPoLhPRnq?=
 =?us-ascii?Q?8pEzQ/2o+F9L7I5GtMIrAbFCwse0iT/yhoaLahvv6B1HxLYWmMmtwMJTQ+yz?=
 =?us-ascii?Q?Tk2ou+QuqqSFHfa3Usacwb2JEQvb5nX8r9TipTIV6yPIc28SFpn53Cfcn0qs?=
 =?us-ascii?Q?60BrSGL4BivUZNOar5lC5UE5oIJu2RuZI/p4d809RmxGaCSdiDVISy/OI2Lk?=
 =?us-ascii?Q?ioQWWdAAbsuHq8cBQiMk6cexyeZEiR35pGbRmcOafShxsYJYJEv6jeD18MwS?=
 =?us-ascii?Q?P2TwgVDmhuygxmF7xR5B6obE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qlqV/plLRfLBR2xVKQBlVEqo4ly3uHE+iN8vbOw83WDepUd+qSTnSaO6jFi9?=
 =?us-ascii?Q?WpK2bvp32Eb/PZBd127IYTtuMEDRDgdQd7JfWUE9b+bXlY6DeECrSJM0LrMY?=
 =?us-ascii?Q?Rl8icm+fGjR/fOPqlN+GLrt7l7cEdaOLTd5ElPVGNvcXUTfD/Dp2h8zby5G6?=
 =?us-ascii?Q?CflamxwvHO4Xnkb5/V2vT4+JqCOqW0iRkJDKLrBV8fEVyFuNihy7RxJgLQ1I?=
 =?us-ascii?Q?RbC4gJoN46lsyureMHbw2pdkikYQMvBnyyFN0aZZsrG4YzqflVSklku/kG5U?=
 =?us-ascii?Q?JcY5hW7os/bI2Y1T3AbEZZKaiMXzTTC5H+eL890O0Dh9LPlHFFuqXSRo69jL?=
 =?us-ascii?Q?lN7t0Pg/l+DwY1fJWVKMqULiXBf2pz23zIivhjVHidJKMcNmzxEfpYaKJLRo?=
 =?us-ascii?Q?7I0b+QqnUM7m89xfkSSozoSvljHSvrTmmSvYm6f89JGD8w//SJsSLO6ooumP?=
 =?us-ascii?Q?e3sEvjIjfSj9oFko8PaQUFOOEIJVD4x7+emuAP4pkCbQKOUlcZ6W+Ihb+JxZ?=
 =?us-ascii?Q?UEuRVAw+L+9NDCYCT09g5y8RO2UFNTnyRNf0+pgoREPfNbs5qpL3goOypmWg?=
 =?us-ascii?Q?V+97d6DQxMSDpKk++O5R74RCGVtuNAFAlFVbiFtBQZ0oULfLSlQy14TpzUD/?=
 =?us-ascii?Q?NF03T/uZr8+Xxmx7hCRPSaxCxEOlODxQMdLu079iyZtfqJiFlT/pGGZiOlHX?=
 =?us-ascii?Q?uQWjOLBhNho/v1khOQFaTYQ5iX82eJYtuEDSqmvTLaE9jIlTvpW5jUB4H2mp?=
 =?us-ascii?Q?MimprQpFnKevvF0zneWbQMs9AyCNxuJGEBLDPj4upZFdAZTQXpWxL7t6lGiv?=
 =?us-ascii?Q?57nzbZ2FL3EiObjfx6WfkVMYyQlWNr6EZkKO6eYOTkeUiB7bk8sqk/pJlJ9c?=
 =?us-ascii?Q?9fQ3YiK+rvu55i6tzpqH7upv2/jtpblWAtJCEbpIj6JuDBNmxzErrRL59u65?=
 =?us-ascii?Q?XoN3ucAeF0PiikOXvE518f5jmWMoyqdGLTjIPMBWgjAQuaS0XTJYiaLyf033?=
 =?us-ascii?Q?c6B9wJdH9Gyz2P8784s6eAeVkYZNHoUY62U0xiz4mL1yxkBV2kKAJtDlT0lG?=
 =?us-ascii?Q?rW1twjXJVR2JbL/X7cBjumiuVjcp3q8ECGhMVscUPsoad8UQXLdrUM4E4LtA?=
 =?us-ascii?Q?T0xr0sgqGZZ8JRHUp5Zd/7EJhwpc+lJ4Wvo9ZVNxKu01QBWxFpEttKxBZS2C?=
 =?us-ascii?Q?09Dw7bMvINsT+wJPbZOP8lYtq8VOaql8oe9LHR7YYDvXisF8dm8k6RY429yv?=
 =?us-ascii?Q?53lsEu0XVVEhcfp1jRDeYqJBVDFTxy8GJM6zHUs1zDTwk5TZ9aeN55wLMkzX?=
 =?us-ascii?Q?w1/jGz+e3px2nmJ5Q8Cr2FFNBEuhsRfhncHyDo9Aev6zdXq+8Peaqt1juNN9?=
 =?us-ascii?Q?SqCUBO0J+CUdlO/8F/YMq/Bip25Ke2CBLs+HRFE4w0LdjJGeGl3+jyQ1Crv8?=
 =?us-ascii?Q?Qpyu/rvCv494FwjpNIu5j6boGcW5AMgiL4pe7E/BEyWgdNAjpLUm1NNJ1N71?=
 =?us-ascii?Q?x8wTUl5jR6zdcn/5yscelUyhN8zGyx0+dcxSUOHOYELwfSn3TI/I6hTXj2lV?=
 =?us-ascii?Q?3NmUQjWL+ZiAOp1dMcsuz53hhcgFnqwOhRFgVBki?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c24399-4955-441c-4442-08dcf406eedb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 08:36:19.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbCi5Q8umVBmtQ+MRHt6QIJW/iAQhuRc0Kl1+7XRQqRYzS7BsdsZVcbbJoANRTsxpHFxAJXuCUHDrBaEHIRxrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466

Similarly to commit dfa4ed29b18c ("sched_ext: Introduce LLC awareness to
the default idle selection policy"), extend the built-in idle CPU
selection policy to also prioritize CPUs within the same NUMA node.

With this change applied, the built-in CPU idle selection policy follows
this logic:
 - always prioritize CPUs from fully idle SMT cores,
 - select the same CPU if possible,
 - select a CPU within the same LLC domain,
 - select a CPU within the same NUMA node.

Note that LLC and NUMA awareness optimizations are only applied when
CONFIG_SCHED_MC is enabled.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 97 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d7ae816db6f2..cdc6094893db 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3124,31 +3124,85 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, u64 flags)
 		goto retry;
 }
 
+/*
+ * Scheduling domain types used for idle CPU selection.
+ */
+enum scx_domain_type {
+	SCX_DOM_LLC,		/* Use the same last-level cache (LLC) */
+	SCX_DOM_NUMA,		/* Use the same NUMA node */
+};
+
 #ifdef CONFIG_SCHED_MC
 /*
- * Return the cpumask of CPUs usable by task @p in the same LLC domain of @cpu,
- * or NULL if the LLC domain cannot be determined.
+ * Return the cpumask of CPUs usable by task @p in the same domain of @cpu, or
+ * NULL if the domain cannot be determined.
  */
-static const struct cpumask *llc_domain(const struct task_struct *p, s32 cpu)
+static const struct cpumask *
+scx_domain(const struct task_struct *p, s32 cpu, enum scx_domain_type type)
 {
-	struct sched_domain *sd = rcu_dereference(per_cpu(sd_llc, cpu));
-	const struct cpumask *llc_cpus = sd ? sched_domain_span(sd) : NULL;
+	struct sched_domain *sd;
 
 	/*
-	 * Return the LLC domain only if the task is allowed to run on all
-	 * CPUs.
-	 */
-	return p->nr_cpus_allowed == nr_cpu_ids ? llc_cpus : NULL;
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
+	if (p->nr_cpus_allowed < nr_cpu_ids)
+		return NULL;
+
+	switch (type) {
+	case SCX_DOM_LLC:
+		sd = rcu_dereference(per_cpu(sd_llc, cpu));
+		break;
+	case SCX_DOM_NUMA:
+		sd = rcu_dereference(per_cpu(sd_numa, cpu));
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		sd = NULL;
+	}
+	if (!sd)
+		return NULL;
+
+	return sched_domain_span(sd);
 }
 #else /* CONFIG_SCHED_MC */
-static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
+static const struct cpumask *
+scx_domain(const struct task_struct *p, s32 cpu, enum scx_domain_type type)
 {
 	return NULL;
 }
 #endif /* CONFIG_SCHED_MC */
 
 /*
- * Built-in cpu idle selection policy.
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
+ * 4. Pick a CPU within the same NUMA Node:
+ *   - choose a CPU from the same NUMA node to reduce memory access latency.
+ *
+ * In most architectures the NUMA domain and LLC domain overlap. In this case,
+ * making an additional attempt to find an idle CPU within the same domain
+ * might seem redundant, but the overhead is minimal and it can be beneficial,
+ * as it increases the chance of selecting a close CPU that may have just
+ * become idle.
  *
  * NOTE: tasks that can only run on 1 CPU are excluded by this logic, because
  * we never call ops.select_cpu() for them, see select_task_rq().
@@ -3156,7 +3210,8 @@ static inline const struct cpumask *llc_domain(struct task_struct *p, s32 cpu)
 static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			      u64 wake_flags, bool *found)
 {
-	const struct cpumask *llc_cpus = llc_domain(p, prev_cpu);
+	const struct cpumask *llc_cpus = scx_domain(p, prev_cpu, SCX_DOM_LLC);
+	const struct cpumask *numa_cpus = scx_domain(p, prev_cpu, SCX_DOM_NUMA);
 	s32 cpu;
 
 	*found = false;
@@ -3226,6 +3281,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				goto cpu_found;
 		}
 
+		/*
+		 * Search for any fully idle core in the same NUMA node.
+		 */
+		if (numa_cpus) {
+			cpu = scx_pick_idle_cpu(numa_cpus, SCX_PICK_IDLE_CORE);
+			if (cpu >= 0)
+				goto cpu_found;
+		}
+
 		/*
 		 * Search for any full idle core usable by the task.
 		 */
@@ -3251,6 +3315,15 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 			goto cpu_found;
 	}
 
+	/*
+	 * Search for any idle CPU in the same NUMA node.
+	 */
+	if (numa_cpus) {
+		cpu = scx_pick_idle_cpu(numa_cpus, 0);
+		if (cpu >= 0)
+			goto cpu_found;
+	}
+
 	/*
 	 * Search for any idle CPU usable by the task.
 	 */
-- 
2.47.0


