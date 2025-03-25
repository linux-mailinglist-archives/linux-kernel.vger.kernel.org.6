Return-Path: <linux-kernel+bounces-575847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C49A707F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A8C7A2B88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF1264A6B;
	Tue, 25 Mar 2025 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ax3En+ji"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295113633F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923199; cv=fail; b=JDg7QaYQCXRPMu3D8JWOo0aCuUV65jmeCHjfkmP7E27d9ydA7hb6Ga8cHnveyV11i9jVS3KuMgCi2fZN0kSewyEUxGOGSOsPPmR0lEF1vQgi3i9o6AXBdafB0Re1r7GfRqxkE5u8kaCcWuBbn2EwSgEfbwDNLWqQ5BTEAtH3QZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923199; c=relaxed/simple;
	bh=y1q4u70KLntw3wNu2Di28xNL58AuNu9qjaZ1eH1r6Pc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtcK+3pYYP/ggtcOE1+Aa/7TXc+ERgi0mub5D9/VLH5O6EC/bXtzhQmB9l8uOWI4L0buwWeyys4pvKZ2qW9l935QlJ4xo521Y/fdNYqXW1ptqyLZOERIMCUd8bbWJ/qKrNdpEj9yi340OQaFRwdSSKdETIapUduoJNDW1NtUWQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ax3En+ji; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGLlvq2nHgg6qJufIOnLlL0MHL0FNWDXvPVvNN7OrTZnVLibV7Bb6CPVybGsZa76HDGp01Gpxsp9MWmhzkA///GPBb7+r+Jzk+9sjq5h5rM+NrWq9KDo0f3+7CUTDN0zJbXtWcqSptWYKVZ5D40+mli9UtYEsc5seOCyDeHQ2qfXLr4m2e5wk/c08mRJ+edW1aMlQO+rRD/OiSH/t0CaRHFQlFn6Z5Kb0qiTTxTY4ik/EYG6WjdHK+xXF/TK/XB9BUiQJPU+0TUQ7J++0IRdbjEZ2SEpGJ75qxitru3OxGrrbRCpPN6YIbIWVKrzlyChASFR+7pOVlvL2eryr33ZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waJ/61+UogqXE+ow9jtD+wXAY4KjJphAcR3bp2zZsEA=;
 b=YbHlBtkOtnhd6a7Ly+KzZLGDYU/drlwi7pCU0RAI4LaK6M3T+uI2HZ6+Ir1q5snNlnLKtI+rQLFZw2vVEaWeFTpwf9tK53Jl+PITiVNxlWmgII9VgjJ7AiY7T3vf5z3Ppzat3hRxKft69PV8bHN0hD59YcdmTAQcMocJH6oxTPLP+cm9+LKvgThzf3cdNJyJspZD5GAe2OqIgK/3ovyORF+Eze9A7mT6pgv4E4mhJD0dT9fIubSuchHzlZh6hkaSJ9KC+7Y8Zy0QMpYbZicwmLndlt246CTZzA6C/DFmfx3UEYcP3l5u2TLrl+v6JSz7s17XAdlPK1Qs+VMmoLhnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waJ/61+UogqXE+ow9jtD+wXAY4KjJphAcR3bp2zZsEA=;
 b=Ax3En+jiBQzWUVE2RL3vdjxoB4p6p3wf4S7MyliShe9k3+NQJVAvnGHCIuxc3SEWdc6UHqtLKFcAHTrxqNHfrA/6Py6ZQRSszfyyGbP7a/3nsr1/eRmP29ISe56sRd8iGCUHeDitGIovlRzfskIgcT0sBVcHS50oYy2uyFOqgWk=
Received: from BN9PR03CA0260.namprd03.prod.outlook.com (2603:10b6:408:ff::25)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:19:52 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::48) by BN9PR03CA0260.outlook.office365.com
 (2603:10b6:408:ff::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 17:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 17:19:51 +0000
Received: from spgblr-titan-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 12:19:49 -0500
From: Nikhil Dhama <nikhil.dhama@amd.com>
To: <akpm@linux-foundation.org>, <ying.huang@linux.alibaba.com>
CC: Nikhil Dhama <nikhil.dhama@amd.com>, Ying Huang
	<huang.ying.caritas@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Bharata B Rao <bharata@amd.com>, Raghavendra
	<raghavendra.kodsarathimmappa@amd.com>
Subject: [PATCH] mm: pcp: scale batch to reduce number of high order pcp flushes on deallocation
Date: Tue, 25 Mar 2025 22:49:15 +0530
Message-ID: <20250325171915.14384-1-nikhil.dhama@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbbe1be-9fb4-4440-5794-08dd6bc140e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qpHdIgZb7pnc3cq/U/GscsT0xY+TV6EreGyLHBv2y8XGeE9OXVpk+5sp68YT?=
 =?us-ascii?Q?NL8zNhG3GabklPewUtlcrCmII6MXzeUtOP2/QBbtlzNUVPnI8naQa1Js44+a?=
 =?us-ascii?Q?/NAgxT8pt7GQbuHx2uDhnNesjyuCIpyRkgkcILVlK1F+jgD73iYbYUj3fp05?=
 =?us-ascii?Q?suvP5aBJGaMsC65XkfDmvv2SzMlR8YUUnXN+kbg0PC1Wuyk9kNuImbl3GgkZ?=
 =?us-ascii?Q?MOF0FTXn1oKmuhO1iULcNlGZSfwKbStCvTQ98SWqfNtLu5rhDSxQnYAMIQXE?=
 =?us-ascii?Q?zSSkg77BluqtMkZ1gPjROLBCzzljwA+/XwOsKA5pqWkZjzv3HlfTQz1XsvC3?=
 =?us-ascii?Q?dyNGVKOTQ8xO2LDwQsM58Tz8JDfl6sFdyvqB2zLHQIIFWhJRR/dR2t0nXoOz?=
 =?us-ascii?Q?kqk0BjGJqRiOHRmemJ2eWWom8BM+oJdxdVS/56yespCf91iHGk7DAoUuKdsl?=
 =?us-ascii?Q?QBkR+2L9RLfkBxDwkLMrZe7wUXqs0Ru3U3TylMt57xVtVANrMd8qCjw/w6IB?=
 =?us-ascii?Q?oawB/Wvi3ES2w+XVPWQBo2WmnBK7M/5zs4ErO6CbrX8WxRwzT91VgxtMfxvc?=
 =?us-ascii?Q?zMARVSplP7GOa64X11diyQBdhFpvOSNw/nxQw+W7cWijQjMnBwW/H55tOZ3O?=
 =?us-ascii?Q?w+kkZQHQNqmQ4/AGp6EBRn34uaIPLqtIcLQoiwNxWoKpk8v0VVeCZ52RH8c0?=
 =?us-ascii?Q?fgWanUAgovG8hUeO4xjjCYLVpIiCTGyCLVhEgU82VKxe+lZ/XfsTww/QE/D4?=
 =?us-ascii?Q?rPlLOimp2nd5oNz26DXpru5Mze+pTbX0f7vzaSD2m6ci2AHQirXuk3x67gG2?=
 =?us-ascii?Q?Of804+nJ9E63jLTnc2SLB4rloHFy6XBruGgC/8FK7hqIvnqQOGR6gh4yQ5vh?=
 =?us-ascii?Q?B6mLnhb5irMYhAFpdHFCAvs2eduA9DAhnan0X6I7he/twSY0tJ1WaFKRmoHu?=
 =?us-ascii?Q?fRocamFNncJhSWmMUFZZfcrtZPtoH/5NHQUs3T7HqU/fFBkmSsJL9xXSI8Q6?=
 =?us-ascii?Q?qMAHOXFq1W0A5PkHLd/JanQjcz+sONH7WMrEXD9AknIJ8erlEYkFDuGB2vs9?=
 =?us-ascii?Q?rIuhyQtPM0j2fhTP1N9kjrzp+I+2BqF1F86ah8RH5tTLHfz0XMMJ43Qqj4f6?=
 =?us-ascii?Q?htJLsUyH1R1nr6RR9CMorosAtHHXpRTO8PbUa1C45ZrL67vaWIXJkFev6MFn?=
 =?us-ascii?Q?htvg48c1UB07hKubtu+X65fkBlmMCuyId+jiZZlEyKBZKuYTzf08qQhSaRUI?=
 =?us-ascii?Q?QPkzSlaSzRCgtKCKqjHEwdJOQBQseV9Ad49oZ7Tuax89xZE8JdMql0MNF4p7?=
 =?us-ascii?Q?j5XYyEWjUEUDI3ZjqfSixFlKtY0B97KlYTPJIMM2Okz8gVa15eORIaUMRd6q?=
 =?us-ascii?Q?BZw0AlXOv586wZdDbCJXbIZxepnUyk0uYQRaOPu8rsADE4704AAJnypfHipO?=
 =?us-ascii?Q?rB6/KXt29tJWoNBgWDqLHhJ7MrW1LwyqxmuYZMdBa+i+mUnhEdWA3R4mK/5z?=
 =?us-ascii?Q?QmdGmOHvnX6F1PY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 17:19:51.7707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbbe1be-9fb4-4440-5794-08dd6bc140e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419

In old pcp design, pcp->free_factor gets incremented in nr_pcp_free()
which is invoked by free_pcppages_bulk(). So, it used to increase 
free_factor by 1 only when we try to reduce the size of pcp list or
flush for high order.
and free_high used to trigger only for order > 0 and order <
costly_order and free_factor > 0.
  
and free_factor used to scale down by a factor of 2 on every successful
allocation. 

for iperf3 I noticed that with older design in kernel v6.6, pcp list was
drained mostly when pcp->count > high (more often when count goes above
530). and most of the time free_factor was 0, triggering very few 
high order flushes.

Whereas in the current design, free_factor is changed to free_count to keep
track of the number of pages freed contiguously, 
and with this design for iperf3, pcp list is getting flushed more 
frequently because free_high heuristics is triggered more often now.

In current design, free_count is incremented on every deallocation,
irrespective of whether pcp list was reduced or not. And logic to
trigger free_high is if free_count goes above batch (which is 63) and
there are two contiguous page free without any allocation. 
(and with cache slice optimisation).

With this design, I observed that high order pcp list is drained as soon 
as both count and free_count goes about 63.
 
and due to this more aggressive high order flushing, applications 
doing contiguous high order allocation will require to go to global list
more frequently.

On a 2-node AMD machine with 384 vCPUs on each node, 
connected via Mellonox connectX-7, I am seeing a ~30% performance 
reduction if we scale number of iperf3 client/server pairs from 32 to 64. 

So, though this new design reduced the time to detect high order flushes, 
but for application which are allocating high order pages more
frequently it may be flushing the high order list pre-maturely.
This motivates towards tuning on how late or early we should flush
high order lists.

for free_high heuristics. I tried to scale batch and tune it, 
which will delay the free_high flushes.


			score	# free_high
-----------		-----	-----------
v6.6 (base)		100	 	4
v6.12 (batch*1)		 69	      170
batch*2			 69	      150
batch*4			 74	      101
batch*5			100	       53
batch*6			100	       36
batch*8			100		3
  
scaling batch for free_high heuristics with a factor of 5 or above restores
the performance, as it is reducing the number of high order flushes.

On 2-node AMD server with 384 vCPUs each,score for other benchmarks with 
patch v2 along with iperf3 are as follows:

                     iperf3    lmbench3            netperf         kbuild
                              (AF_UNIX)      (SCTP_STREAM_MANY)
                    -------   ---------      -----------------     ------
v6.6 (base)            100          100                  100          100
v6.12                   69          113                 98.5         98.8
v6.12 with patch       100        112.5                100.1         99.6 

for network workloads, clients and server are running on different
machines conneted via Mellanox Connect-7 NIC. 

number of free_high:
		     iperf3    lmbench3            netperf         kbuild
                              (AF_UNIX)      (SCTP_STREAM_MANY)
                    -------   ---------      -----------------     ------
v6.6 (base)              5          12                   6           2
v6.12                  170          11                  92           2
v6.12 with patch    	58          11                	34           2


Signed-off-by: Nikhil Dhama <nikhil.dhama@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ying Huang <huang.ying.caritas@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Bharata B Rao <bharata@amd.com>
Cc: Raghavendra <raghavendra.kodsarathimmappa@amd.com>

---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b6958333054d..326d5fbae353 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2617,7 +2617,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	 * stops will be drained from vmstat refresh context.
 	 */
 	if (order && order <= PAGE_ALLOC_COSTLY_ORDER) {
-		free_high = (pcp->free_count >= batch &&
+		free_high = (pcp->free_count >= (batch*5) &&
 			     (pcp->flags & PCPF_PREV_FREE_HIGH_ORDER) &&
 			     (!(pcp->flags & PCPF_FREE_HIGH_BATCH) ||
 			      pcp->count >= READ_ONCE(batch)));
-- 
2.25.1


