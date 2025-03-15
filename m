Return-Path: <linux-kernel+bounces-562356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A451A6248D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6447D3BF4AF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA85B18B47D;
	Sat, 15 Mar 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZLA8QIRs"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66018E351
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005352; cv=fail; b=crjK8fbqLhUa4ROjQmNKkXT1epQlwWXefYF0X49uCWC84njUZR1ljhwYNCFBLE19lzcT5y2CYDjNISaVFrc3snf62H3HwpVfIE78YiOTvOqDMHEFB99NmI+lBXXipSNMukv0wcxoT7GrzBndBz13vGBDUuxTbWquUVSmPXhXAZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005352; c=relaxed/simple;
	bh=QSdnHJwENMZQW7QJ/5oyyWJZDhpNUD1y1Xyt2z/MKb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hoh0O15B9n/W9pJYYmkvVU8OxtF86vnfCdq1dNJXIJ1J97tLvK5yUTFb7DSnWxQDTJpSZXvj0eXoOhc7a3U+XFIfIXFEIFt/kBW+GFbe4kNw+2m6neWsjWKEJcQrqbWtRUC/vzhHMnj2SqJ9ktmoFMwL7h+2y6pA+oWENo9K4nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZLA8QIRs; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDJkG4R5UnJGdfUVYsI6UrvUya246gHny3l+hnqNNLEVRAbugMt2CbHeDwEUIyX0HELV1hcYy/S6tZNGZehoxvb3UYrB+lX+AL7I3hIP2nTzgQipWLw3UrnI58D91JJ8Neka6GwOiOofW3tqqYtJktY52oT+u8Yxz6+rn685/psao7r/gndymdX0mqOF+48xgTD74FRBmmONa04fysKF+CfHyT+yLIe/fHhc17GwdUL8rjZsVfpnrguEy4FqbNOT0Y9d1gxFYR7Kfy9PaneHWndsUSXzOFpf7HoTt9tF3AgMwJ/I39g/PDvuYsrWuF3sRYjmRyvme5QDy0sZzX1Sfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9g//EEbvmDbGlccouXKvKN4d5iga2LG9QQDJBTEj7I=;
 b=IfQaxYNoi6FYl7XDNrcTEejO8Kt6VHnMf3/pV3exLQDLhpaUTPm1e4Ax67yHaMnRpV9x6KhcOnmbZTbkU7tUHq7l1KUwUote3tApCp14IPvkZnrYMWipAYpBKYPksOlVrqmLJROlw8oo0uyXmlvPvwKQ3Q9vkgZNBkNPR0apYyOTyB13MFaYbLx2TP6xc3xo36yoIFd5m64mrzgfeujzCjXBtzZtMqw2I4Y+aR/uW5lIcNeGxWzCKxwuymp16JhRM6viG3ahHmuVL4CjmPK0JGJdLW9sTF/iAaIqKhXhxriIEuVj+8sf/T+NeguZNuQ9DIJgsWuzm4DyZrVVx3AHfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9g//EEbvmDbGlccouXKvKN4d5iga2LG9QQDJBTEj7I=;
 b=ZLA8QIRsQhkmCrAM5X9TMcloixEtiFjdZiL98HuoxuAXc4usMIKMgIEH1UMf7TEXKIYFoSCVgPJ/qQsaYTxDPOOpbU8gj0oN3XsbQEFuu0dhAOXNGdoX2hXYR6Lr0w6H9a3VL9hWUSdsdCZfJfkJAXYp9mgYUHPi3u1wJuDEMCYdtg4S6JNrqC2TTckbqex+BrrLHkbA+McTXzYYRthDgiWmIWUPxSZXkQernbxhwWaJAGLWnIEiUGQVDEG/W5bnQl2HC+u3vocOhHxYAjhD0M12CWExUQBK1XxGUyY5b/t2QTFYo4tQ0TsFrLJELaI93g5q/oBu1++k9r5t8b2zxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:22 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:22 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Luigi De Matteis <ldematteis123@gmail.com>,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	David Vernet <void@manifault.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC 6/8] sched/debug: Add support to change sched_ext server params
Date: Fri, 14 Mar 2025 22:21:53 -0400
Message-ID: <20250315022158.2354454-7-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:52c::12) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 02694c90-a066-4609-d228-08dd63683817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r++sUtcZSdkp6kgmYE9tgZRx7VT8LZZlSuvaN+j+X3V/X7Jq0JbOAWINEPl5?=
 =?us-ascii?Q?pV/79qJrT+3s+gd4bfRysWv8+tbdp2fpHbFkKRXMe7foCD0WNkYUwnjoZLGQ?=
 =?us-ascii?Q?ERn8rmk58Thpk7jYN5bN5iaUEHkmaIZilCR106hCATF7I3oYWy6Et7uuhpG2?=
 =?us-ascii?Q?dyXtS56UhNiNMkJWpXCboKwwqq41IBeTXpR9ME9Ku2n+FzupI4zSnuKzEIHR?=
 =?us-ascii?Q?3crgit0ZZvNpLBGKSq6rx41ICVOofIIiUD/lh50hd9wpnnM5oowIMRA1sGlh?=
 =?us-ascii?Q?UD1rqKaSNTudhj4Yj0WjHooaWeQePsZ04ORO9dRIunhSKtrM0yXBkiJZmgOH?=
 =?us-ascii?Q?BnVSOzvk7GmkS3DAbb+T94LMduGefX+e/8ucB8PZEYeGTj7hsswfGsncZNeJ?=
 =?us-ascii?Q?OEVJxMeXjzW2BhaHn+dW0Os9yXxnHgQhouGBW50USo5zf4XFlYNj/CKJ/fsr?=
 =?us-ascii?Q?LXngrbmtyklchpR1p2+jdcFwil2TqRAdvgZwercXtoVMs322GBYBfmJUaCQG?=
 =?us-ascii?Q?fFEIm9G5K+VDao/Dbugprtd4Sh14x/D6b2Da4lISkT3ymUZFBsSCH6Wu0iS6?=
 =?us-ascii?Q?StVEWT+smD1YYy4jz2X2AdsQ3SFqkRQaQAe6Tj+Ias1GbBst6Jf91bj/bFtA?=
 =?us-ascii?Q?P9Y133B91MX4P4zuWaHo7VlWsyLF/xBoSNuOK19/NIdxsUnRbXjFHcc0CoPs?=
 =?us-ascii?Q?vcPbr/+RC6npE3zWgh5W3xTBjNdSQBo+hajBEdgFiW0gcmZER0rnae5AVr2k?=
 =?us-ascii?Q?Q6vZEVEhYfTyt0fuEemG8kdcj5hGqJNoHkKvX53K2hLqa2ffvHFuqz/Xw5Pm?=
 =?us-ascii?Q?LFU0ew3/FWlD4ktnfUD8mR+YNMvM45Ifeqhu+GX5amYAGO99jDHAWJad9TV+?=
 =?us-ascii?Q?Db9Rlw8ckySB9z+jcwCB1pwpg04J7gs8xNRiLTB8mu+/8wrm8+mzFuvEhq9M?=
 =?us-ascii?Q?9NyQIl06ZyTJI7B6+RukV83CcX+LXRFzz2bSPlLrfKoxgLWe88YHlvYm+dSZ?=
 =?us-ascii?Q?8H04ZdboEXhpBoRNvSGhoX7hHZe/1bV0f3866+WlcT9MspLOVtDxWb3C1TGA?=
 =?us-ascii?Q?kFnJ6XAE/SK8kGe13Hm1eFkRw1iiOsCbtzYpsvRMR70InjZzfSUvYeF6Gf1p?=
 =?us-ascii?Q?cQdqHTz2R40NRansGLrZTuTisT2H+bkJUB3+49JaHYGBAwIFOOsYFKTz1IGb?=
 =?us-ascii?Q?QZuIKGcNdLXnNvy3r0c6a/YKwyw+/xm8aLA4U9Ekt2vBW7YUPWQFTPrm8yHa?=
 =?us-ascii?Q?DlYznIFlCHLte3wC88t0m+FXdL7aRgyfhE95D49u51PLxbhtuNQu6CKDsaVL?=
 =?us-ascii?Q?dP3dT0TSUXdse1ZNOa+JBWeP6tOlMzvPFO6wt3A3KGHhoyZMOfYiorgMrf1A?=
 =?us-ascii?Q?zobdXo2AgoWjpfYgziZZCAOGs+qblrr0h7YYIhzBYf+9rSG5cavVFrZp011h?=
 =?us-ascii?Q?BlabCODhnCU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ldmZPfmSaX7dl+6I5jK+I1a84kz9P7VGDSakmbx7O58NLRTfDft/gvStPDmy?=
 =?us-ascii?Q?clMi04RqeQ2M2cxOTvC03TI8Ff6wdFZJXmUi3KI7qbFfXcyqBSDjHHEbSFps?=
 =?us-ascii?Q?Z0BL57dkTaHARCKW9uXOdOi+XoVIaPy7coGKa1TEK/EtNXJ4Qv3kdwOMxi1b?=
 =?us-ascii?Q?NdenYE7hbzVCeY3MuReOShQSMOI4W18oxlX7M0ZGchVyfDIWdCCRPn3KOL7n?=
 =?us-ascii?Q?DPkBRfyL9O3PosR6G+4KG+kG15l2fATvl20M2BX9cBvMMYGI/z5kXUfLi7fR?=
 =?us-ascii?Q?UoLrPFqgMEFZnOxfhUPjeQXoeWvNKIVCeUa6VkoYfGtDP9isliWLM050GXIG?=
 =?us-ascii?Q?tFSupaFPK0EzSRCdEbSAjZcOwSRXMplINlrsOqHUgFw+3RqTqfToLISCqMQa?=
 =?us-ascii?Q?IDpkWxfYbecs1o19bSEWJdhxsEiAKemoD9HKvMpeB8iC5AoQyBxHuc1ilxWa?=
 =?us-ascii?Q?Znprxso4RWKT9chNasU/qiOcB86awTA/eFd/br+5k98fL5qN3qUJ/7ODdcLp?=
 =?us-ascii?Q?npxsYeqZrVVFYDKtjHrJHLpjLIYovLzd69EOjcZQAUYkFNyc08SqmGV5n0cE?=
 =?us-ascii?Q?NHeNcK7rDqT2aBis3W/1+66wvodPHfI6bAV/U2DchWXdSXl2H332e/mx530c?=
 =?us-ascii?Q?1qXZGVYF4/+Pis7BBhUZFZjKvGiCG4J9k+gW8EPgp1MQ8Xw7BC/im7Sqp13Z?=
 =?us-ascii?Q?SbjmgjXbJgJNG33eUd/lXZvOz7Hv48KSGEX0AOxecC3wh5pebrxS3j/rLQ02?=
 =?us-ascii?Q?1amqWlDM55ZgDnvvrtLXRZrtXRCfgmd+4wSTpW60pX50xQnOcLxuBL+AnA5W?=
 =?us-ascii?Q?+j56SA/dJ+g3z87VCJiY/i61DvRjVQ3DiK8MWx4qhr9AnILwk6bNQmDp8N1Z?=
 =?us-ascii?Q?0UMw7m70YauBdu0UZGpmw6yx68aJJx+wS5eZdYhzhxVE+JYRd4BndwMN91Yx?=
 =?us-ascii?Q?NV9TPqK/v93kCDcvNeBXHtoI7TgGPp/KaB6NIiklAEsCXbBBUQnCbRaqOyUm?=
 =?us-ascii?Q?EN1NihEEmQhasWyxsM0jzY2i7PP9QeGlIpec1tZqKw74sfO/8DaeoLH+GjOM?=
 =?us-ascii?Q?m0nSwa6EojjxmM9YoCpuLmMfriHdD+u/7B6hISAN3uOWWpcPONeCJfQFJh2A?=
 =?us-ascii?Q?k1/t86JaNtMhMtpwGjRBqvdi7HQFjLwFWG6UMKKwgxaWfIMLEVX0SaZlMNc1?=
 =?us-ascii?Q?Gj5dYCbBbtQSToAoOABFc/Dph/H4k/ikaSEvTP9bIDOyYmiRS07Sft/SqmLg?=
 =?us-ascii?Q?OZj1EaBbYZL5ckgIfCX/bDGH8J6KJFEGDwNlXYCKJIgusN7NnNtG23hUv0xL?=
 =?us-ascii?Q?avf9EKibqMP2lZmF8eFeHK+JcvmZzw/lAnBJzo2SY0EIm14/4yZg/+yJMMR+?=
 =?us-ascii?Q?23xbn64RhiH0fnK6wMTkgtMXWvJQ6Ayl7oiyNv87eEfPG3uIb+SoRvfhirf4?=
 =?us-ascii?Q?RDHBHqRpVCnckcifQB75DoZcArSOZTAhCSwV3aWYTNt/T7kE7tKsfzjMJK15?=
 =?us-ascii?Q?/nUOKraA1ELQJfFmeqi1cuF5Hjh15JPHJIn59x1gqmUwQdbjJm2LqFvrTiYr?=
 =?us-ascii?Q?239yx917ftQ/mdvjYoG5HmuojIcCb0+2AkEx/dIH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02694c90-a066-4609-d228-08dd63683817
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:22.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rYjK70CWjuiU682tIJRGlxtRIFIkOryVRsF+P2Oele1x74KNysAXfXUaROILlLYz27QsKd8xGtfX/hEkyXzjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

When a sched_ext server is loaded, tasks in CFS are converted to run in
sched_ext class. Modify the ext server parameters as well along with the
fair ones.

Re-use the existing interface to modify both ext and fair servers to
keep number of interfaces less (as it is, we have a per-cpu interface).

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 91 ++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 83cb695d6d46..218b3e239128 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -339,17 +339,18 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
+static ssize_t sched_dl_server_write(struct file *filp, const char __user *ubuf,
 				       size_t cnt, loff_t *ppos, enum dl_param param)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
-	bool was_active = false;
+	bool was_active_fair = false;
+	bool was_active_ext = false;
+	int retval = 0, retval2 = 0;
 	u64 runtime, period;
-	int retval = 0;
 	size_t err;
 	u64 value;
 
@@ -375,41 +376,57 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
 		if (dl_server_active(&rq->fair_server)) {
-			was_active = true;
+			was_active_fair = true;
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
 
+		if (dl_server_active(&rq->ext_server)) {
+			was_active_ext = true;
+			update_rq_clock(rq);
+			dl_server_stop(&rq->ext_server);
+		}
+
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval2 = dl_server_apply_params(&rq->ext_server, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
+			printk_deferred("Deadline servers are disabled on CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (was_active)
+		if (was_active_fair)
 			dl_server_start(&rq->fair_server);
 
+		if (was_active_ext)
+			dl_server_start(&rq->ext_server);
+
 		if (retval < 0)
 			return retval;
+		if (retval2 < 0)
+			return retval2;
 	}
 
 	*ppos += cnt;
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_dl_server_show(struct seq_file *m, void *v, enum dl_param param)
 {
 	unsigned long cpu = (unsigned long) m->private;
 	struct rq *rq = cpu_rq(cpu);
 	u64 value;
 
 	switch (param) {
+	/*
+	 * The params for fair server and ext server as set via debugfs
+	 * are the same, so we can just use one of them
+	 */
 	case DL_RUNTIME:
 		value = rq->fair_server.dl_runtime;
 		break;
@@ -424,50 +441,50 @@ static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param
 }
 
 static ssize_t
-sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
+sched_dl_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	return sched_dl_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
 }
 
-static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
+static int sched_dl_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	return sched_dl_server_show(m, v, DL_RUNTIME);
 }
 
-static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
+static int sched_dl_server_runtime_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, sched_fair_server_runtime_show, inode->i_private);
+	return single_open(filp, sched_dl_server_runtime_show, inode->i_private);
 }
 
-static const struct file_operations fair_server_runtime_fops = {
-	.open		= sched_fair_server_runtime_open,
-	.write		= sched_fair_server_runtime_write,
+static const struct file_operations dl_server_runtime_fops = {
+	.open		= sched_dl_server_runtime_open,
+	.write		= sched_dl_server_runtime_write,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
 
 static ssize_t
-sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
+sched_dl_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	return sched_dl_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
 }
 
-static int sched_fair_server_period_show(struct seq_file *m, void *v)
+static int sched_dl_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	return sched_dl_server_show(m, v, DL_PERIOD);
 }
 
-static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
+static int sched_dl_server_period_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, sched_fair_server_period_show, inode->i_private);
+	return single_open(filp, sched_dl_server_period_show, inode->i_private);
 }
 
-static const struct file_operations fair_server_period_fops = {
-	.open		= sched_fair_server_period_open,
-	.write		= sched_fair_server_period_write,
+static const struct file_operations dl_server_period_fops = {
+	.open		= sched_dl_server_period_open,
+	.write		= sched_dl_server_period_write,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -475,13 +492,13 @@ static const struct file_operations fair_server_period_fops = {
 
 static struct dentry *debugfs_sched;
 
-static void debugfs_fair_server_init(void)
+static void debugfs_dl_server_init(void)
 {
-	struct dentry *d_fair;
+	struct dentry *d_server;
 	unsigned long cpu;
 
-	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
-	if (!d_fair)
+	d_server = debugfs_create_dir("dl_server", debugfs_sched);
+	if (!d_server)
 		return;
 
 	for_each_possible_cpu(cpu) {
@@ -489,10 +506,10 @@ static void debugfs_fair_server_init(void)
 		char buf[32];
 
 		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
-		d_cpu = debugfs_create_dir(buf, d_fair);
+		d_cpu = debugfs_create_dir(buf, d_server);
 
-		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
-		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &dl_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &dl_server_period_fops);
 	}
 }
 
@@ -535,7 +552,7 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
-	debugfs_fair_server_init();
+	debugfs_dl_server_init();
 
 	return 0;
 }
-- 
2.43.0


