Return-Path: <linux-kernel+bounces-178308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D818C4BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D62282EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A411725;
	Tue, 14 May 2024 04:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GZRmtDAo"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F400ED8
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661910; cv=fail; b=rlUESjhA/ntgQUCFF8ebyjiuNqm4VW16l5MKuGesMi6CuRo0lhX5zTN1zoLXrOu/MFb0jh3+BedaUdKD9yyXoPkhPb7r+YVKDW4O7Gqa7kLpE3QTiyvDo1ta7OmPPQC390Z5of+zyxRmKBYiHgNslz60+VaOj2tBi3gJPsyihuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661910; c=relaxed/simple;
	bh=odH5jlLSQhcMoZmuCZu616Md1FybhIbB9/qTYfyDVjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j9Lpq8NL+iN/dJmR/TT7JnrN9mCEx4nTrKIruX+5D5uFlXOP1gbCizPJTIVhoUO87T2XiXr9GL5awkpVniGIYlIJmfWx1NjCPH+bj6nMun4AsrwbS6/FsPkr6dkjP5AbEd5DNmKZieSDY3oE9mGLo7hd9Y2yLzyy+O+MQg3nigE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GZRmtDAo; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6smylXICkWnJiYmrqso06gSgS/TsokPdxDb/RwiXqFsCulrl2zZD9/qguXC8DZq1NOfQLYHnd5ULYUw9oHZR60dO2jq7gC/ocPxlXto+++tkKue8MgS+91N2aGknQiT6t1qVPESDjV0Fx9npl40DteYQSUhbaN7zuYA7ZHo3iO/V2ZLnTBk2Ovivuxi3NhTVDrYdzKrrEYgnFCWf75R6jZ9OkQmeviFhM29+y7kQXUzvyKHUXFZq5Gd2fpG4IpyEmoKt0rQ19N1BmEy/AahTVq/77iz24KPjwQIlBKI1WNLMevBwZexRaex/dMrWfNABM1WNoj5e5tfBwdlx7v6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc6ndLlZxpmTfL/YevkG4pAQPjAWt9RKn0NQwdav4S0=;
 b=jLjKk2SjW6e2nfdEvesE1cp9XOKjFWSVKMSFmUJfH50qbsHtS0md0uqo/bo3BuHF9ZGxZE6cN8ENI7aUxXGLIDwPR0UV4TCNGjjRFs2Vwk8R/d7l6Mpb+0oKyCHT8FczdPmpyGuIH5H0DnEIVfZKM5QX7USNBSYGsXCD1/vOSEpugS6OM8hbqs8YarejfF6lnVrdEqAcu4o/ead1Oa0rZx9zfnPmtjFMb3poOm5w/9y2biKY6Alv1hMwTVVHrKZRhhGq3BpfHzHLnFepcC3YkYAIHH9dvsKE9PD2KKCBcYPSo5b8vgve9f/edQW3ky6yAmlXDvvCHboCTu9vZfKbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc6ndLlZxpmTfL/YevkG4pAQPjAWt9RKn0NQwdav4S0=;
 b=GZRmtDAoREm3AP5snGSHE0s6Pz4DuPqs/xoUJNtaNWkyI0taIyPzs7KukSNW3dcWcaqan3utD/Us2PZjtCAicDVHmIMw93DDopcZo5x17SktjRy5kT7JbJQ3Z441wpEKXOVRxNQ0fP4PzKurGiH9qwvpgF2Xk0oisGjcY3p0Eeg=
Received: from CH0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:33::35)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 04:45:05 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::90) by CH0PR08CA0030.outlook.office365.com
 (2603:10b6:610:33::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 04:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 04:45:05 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 23:45:04 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <peterz@infradead.org>
CC: <torvalds@linux-foundation.org>, <juri.lelli@redhat.com>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <vincent.guittot@linaro.org>,
	<gautham.shenoy@amd.com>, <sshegde@linux.ibm.com>, <kprateek.nayak@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [RESEND][PATCH v3 0/1] Fix lb_imbalance reporting in /proc/schedstat
Date: Tue, 14 May 2024 04:44:44 +0000
Message-ID: <20240514044445.1409976-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae278f7-c1fd-4f96-cff2-08dc73d0a026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|7416005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rOQmIEXwCGahSFk/SvAMIWasV7Sgrtvp31AENMG8bKTKHT2UQX+YSsboZGJS?=
 =?us-ascii?Q?CKdFaxXxMmH7gcIA12uzMRhhWCki0LSjpyn9PWSFQIFl+wgi6rwugwP44caJ?=
 =?us-ascii?Q?X+h09pQLTtBC6UTTHgRXwJJKwG29gxPo/rsdpwX6+FhJ1WtpyPtu+28/FAhS?=
 =?us-ascii?Q?b/2yEnBw3kiprDKWjHMjtHRCqTXsXU29WNKqL6b3D8kYOqaAw5FTvRvyJsKC?=
 =?us-ascii?Q?M4lKDIiCuVqCh9GPE2dzW40Fy5jnSlMAyROwV7PGJr93ElfFPW+mk9ZDpNqI?=
 =?us-ascii?Q?Jum8j3ywX4+DJpN6Z826ZkbWaCuBwfqOZYu/qa7YYevsf0PnqR0N9JJFK5Vm?=
 =?us-ascii?Q?pkMBplRNZGkQCxtykh7CZEZPvrznPuzplRpVzP1n9y6G6AEYAfIhKrdjI2rA?=
 =?us-ascii?Q?UaKLrmd5gUUb1szou2M1H/aeIFq60WpalsbHI4HdGDqCPUzCPFRb8iG8Fhry?=
 =?us-ascii?Q?NsJBQJLdtVwRBwojg/LS5tisMJ/JGd+5p5OauQlrLosJg+4ph5FEeWvse70T?=
 =?us-ascii?Q?F9FPXA58os4IPKhz9g07QsauqVrZGCwbijfZhi5Ll/Lve6hRQu17jvxj3+Gk?=
 =?us-ascii?Q?WmRdrY7yptC/NODUHWCdGb2XnMtcpJQpEz1Gl+WkGJCPb5LLIE0epppRMHmA?=
 =?us-ascii?Q?WwfyL8L8B6hOut63N0QGgn6tnb9BzNvBrDG6jrbVzSPoCnv1rSmcmU9JKP+3?=
 =?us-ascii?Q?s4zSeW1okAwTnuL0S1HPokKsYsP5iXnEXYVDTEdJ0al7gyxOh4M23qQcj//W?=
 =?us-ascii?Q?PzHLMG/FV2nOHeu55VuDIaNZj+abCjMPpO6vYW7DOidIZQmGJ2muuLfT77Ky?=
 =?us-ascii?Q?NF4CR+doSlPufgZi5fz0y7p94XDPzU37AghBLeWdmsgPH8sPmeJBPZ0RkFfq?=
 =?us-ascii?Q?UzcnZ4WfDP5AmRGL/BUlWnDyb2meeg0ksHZnkCXS26q4J+36LxkGNggd6BHH?=
 =?us-ascii?Q?LAxPJL41RQ2GIUsKFwZRQhL/Rq8ceGWKc8O5+2VkfFXdGY0v6j3Fl7xAF5S4?=
 =?us-ascii?Q?l50JJQZ6xdZEvq5B1BMBVKm0Ilstm5+yEwOcNNPz4GUAQ0Pvz4g3npIqQRRe?=
 =?us-ascii?Q?NoKrwrnoAxMt32LVU5JpopROfHm19UQNo71OJuDdfOGPpirjvnmBF8Xola8w?=
 =?us-ascii?Q?cqZluW2nEMB5kXblmyWhhwS5vX39a6flGy5KHYzkG5sPbclsLzbWClhI5tQK?=
 =?us-ascii?Q?+7pf1PKKX5KgoIIqHdo4OaRWPLCyNO8f8VFgsEmlYiyookYzjjPlYfmCXYTI?=
 =?us-ascii?Q?9sKxeVlnu8+P/VifOuJ4xY8iZctqEYFTE9Te2JoRfwUuDUyJXmgtUEy9R/8Z?=
 =?us-ascii?Q?L8dpwviGxrYq+YTfAD2l/H27?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 04:45:05.6432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae278f7-c1fd-4f96-cff2-08dc73d0a026
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

This patch adds new fields to /proc/schdstat. First version of
the patch is sent here [1]. This patch goes on top of the
commit d72cf62438d6 ("sched/balancing: Fix a couple of outdated function names in comments")
from tip/sched/core. This change is intended to be a part of v16 of
/proc/schedstat.

v2 --> v3 change:
  - Incorporated review comment by Shrikanth Hegde
  - Added reviewed by.

v1 --> v2 change:
  - Added links to previous schedstat documentation
  - Incorporated review comments by Shrikanth Hegde

Motivation:

In /proc/schedstat, lb_imbalance reports the sum of imbalances
discovered in sched domains with each call to sched_balance_rq(), which is
not very useful because lb_imbalance does not mention whether the imbalance
is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
from /proc/schedstat.

Currently there is no field in /proc/schedstat to report different types
of imbalances. Introduce new fields in /proc/schedstat to report the
total imbalances in load, utilization, nr_tasks or misfit_tasks.

[1] https://lore.kernel.org/lkml/66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com/

Swapnil Sapkal (1):
  sched: Report the different kinds of imbalances in /proc/schedstat

 Documentation/scheduler/sched-stats.rst | 121 ++++++++++++++----------
 include/linux/sched/topology.h          |   5 +-
 kernel/sched/fair.c                     |  21 +++-
 kernel/sched/stats.c                    |   7 +-
 4 files changed, 99 insertions(+), 55 deletions(-)

-- 
2.34.1


