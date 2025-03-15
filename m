Return-Path: <linux-kernel+bounces-562357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B109A6248E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E419C1B07
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF41193402;
	Sat, 15 Mar 2025 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sMBx1uTt"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02361917C2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742005354; cv=fail; b=sEWySwrlWeSKt2oKhbQMHGIj5lXIXOikkE+ozqqH/30/FFRhWa3P23vp1ZfKtfdxllrdNFbOIa0ij6lfiCVKpdOew1+o6o7h2f5jqCotjTEq6cvB22zjU8lGs4HaEEgDXT+Wa3/6QDDu5rOWJ/qnZG/W0Hmtn/4yZA3f5hblRoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742005354; c=relaxed/simple;
	bh=UnwprWv3hnS/bEKmhMxI3ahnfwE7O3nWBzvwTqhdq28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Npb4tEYx8C7468s6E90WrLOASYWqHLQ5IyqmEpVfJ3hhgID5uWtKbdLBPq34VUNDTaKrfy4Sd7Ylt+k71M6mSLj5sBrJHjyqkqoBQv8kB80w9q5qQN2058jUraxVjHLIeDvCH+1+zD7Wxl+0rW6cs0Nj9E+MPIPe7S0z0z1AP9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sMBx1uTt; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srBCoqIgfxZmiN97l7kI2WJYlTpTwL5erNBCYzib90KSKlQYsGuwi3cnlAs/sRAOfE3x6Z6dRaPghhaeWoQT45qVv34IFAQez3oArhol2G1cLGt/5qbw+fvg0Tfl+VNZRLuOpH2TtNVWzWg0JDJFzXkO6BL3Yi1ihSraEU5TUfrACh23IhTTI8vDqEPixDyENdyaDROkjwM9lq9CwamcSnN/MLQYdMEEv7oqaT1J7wW3k2DhNLDUcoFIdjZutxQJilj6GkHGtmFWsdROk3zi5XdCWNJBlw/4iBjROx+G+aEQk76LFvaSde/nZIjVbzsdqVvBLiR3HVzVW4Z+aqga/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97rnMfP3wrdbk3l7LDSIEd4lQxRMMfWjhpGvU6SZhZY=;
 b=hCHrS2krcits2OR7vubnStSz6+VVvYJWDBzO/MZ5m10foEua6oim4VdSko1mYbCWHSVPrskXsACrbaypp2EQs9UvWg2LSBS8BmEi6Qc+6py7hX+CgKF9T5wmUSMotkwKnpYUonoF39ElyY88xVaefg8Y6K/4bn4b4iYBN5u0lGaaKSGQ5DAf/W+hcZUl+gYdQHvYWR7d2L5+Mxs36Xfxul0kuHLFuS5YpOBJOT2FdjEXy2eM0hGGLJNye5ETZl0F9hCHHTeep07kObdE4S02xUlFbGn49FuR5hJVzqPjxQg8SR1v3vAwB+kG/YEtkgyUKNsuUo1+Nsrfqd25Ft9DFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97rnMfP3wrdbk3l7LDSIEd4lQxRMMfWjhpGvU6SZhZY=;
 b=sMBx1uTtRWQhXmn3KQvV4blLRsKTu/jrZ2JMivCme5RaXLVR1Kor47OrflWG5cD9DfvSShDFeW4fyHY1elr7ERVhFdoqyuRERncrRx7iwiARzpoF6amfLW4XH3mj2rUqL2f3lA7Z8bO1xK9R/Yp1fUuAi2ukN6MoV/Oev1VDsiMATu0ZflQVCVczWtFkbd67S2XzJpHPhnDG8qUd5AVpTHJb1h+DCegADgZM2b5z4ssZVmCfZpgHhBYGQa8odbl/Umrp36aXdAjnbQ547r9bt79wfOOubePWRjzPpVfxnBlnvwzXTtwmidOG+O+jeVWhG6vrJ0YIwTTVsYw0Ii0myA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 02:22:25 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Sat, 15 Mar 2025
 02:22:25 +0000
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
	Valentin Schneider <vschneid@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Luigi De Matteis <ldematteis123@gmail.com>,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	David Vernet <void@manifault.com>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH RFC 7/8] sched/deadline: Clear defer params
Date: Fri, 14 Mar 2025 22:21:54 -0400
Message-ID: <20250315022158.2354454-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315022158.2354454-1-joelagnelf@nvidia.com>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB5997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad33650-28e4-4ed7-db61-08dd6368399b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s4UdBy3+WY1SOx1o0jhz6dP5LibjfefO3rAfo6UYm3ONU82v72adu7U8nXVP?=
 =?us-ascii?Q?LSnlzKTZT82/3b7S3nEPniV3wreu2mJfHIwHSSNzJXNQH5PS6vf5WfGX/Wb8?=
 =?us-ascii?Q?V07dnMRadLvWgUpuX7baaYebE7Fg3kKOf1dPE9I7Ys6R2e9Iq/kS9WygDJaQ?=
 =?us-ascii?Q?ZPsbDtPa42u3SRYgz/+0Uoemnjd7PJTOS1f60P7XLU6zdRRSvBFyOoKneu+9?=
 =?us-ascii?Q?5kqgl709pTGWZGuHQQGA24sEZ6JPR2+75y6o9ueKSjdvjoPfIT2T0O0Zludb?=
 =?us-ascii?Q?WWDvQJLVHeKo9kSFsTQs3BKxrP5TN/XQxnaKXu/242EIRqjRUyQT0CPfciJE?=
 =?us-ascii?Q?jhDmLY2W5i7W+IvV/ttnFDbGtOjK0JGRMzg29/NnQnHCqEcsXKRT48d+Fpdz?=
 =?us-ascii?Q?RKpfJ2BJ5jRiUNrNMhhBmcmv4LMKCzpDmtgDqls7b/+dWEQBrXlqRV2mqaba?=
 =?us-ascii?Q?Ehl87SwF9YuQJMf8ViBhyCijsfIIIpsUP99WawyKsOY9/5JDWawOvkwAeQ9V?=
 =?us-ascii?Q?LbgeYxRfYAvdSgGakKnTI9elmgvdxgx+ph6gEkXLkCrfhJUzw0/hrC0ZmeS5?=
 =?us-ascii?Q?xRhBuJ4jyScsm7tnNsguGp9NuqsAnCLlLe1776j4d/5oVqDPRfv8vJ6w3kTO?=
 =?us-ascii?Q?4GbynJMWzyAC2eXr0xfLDTJubqWKwVd3sVSEaqnIXi88wLWt8xn+9dDpLYI6?=
 =?us-ascii?Q?ge6MIh/IBmYC4O7wnYeNU1vGxLrsMmxgeD16hWxCw4HMN7dKFPbqJQsZJ18q?=
 =?us-ascii?Q?fmvULGXy7yY7ee1Sfrhh3ohJlfbs38myDVZRMoiQ1wnhIHNeDpiIEUdJDeja?=
 =?us-ascii?Q?PN0Pi772iUTw0l8YbMthd5tMr+xUz78skz6asUuCujtpSTJneAfiffgwBZTT?=
 =?us-ascii?Q?1gF41tunuXRfzbf67voxc/bnugPGoptCNBiuMX009bHmnrvV/Lt6HGjxrayS?=
 =?us-ascii?Q?VdVQ48UPrLB/3k3K5YhfVh6Qz+vcHAk56sUs7G2PdegsKGNYMIAodQ7jbY5U?=
 =?us-ascii?Q?gXyY2VpkuGKHPG6VMJ6qMoPEUTaB17zjpygWotQVbc2azJaXyOFvXNrWAyw9?=
 =?us-ascii?Q?4OAf8fjrr6uhXjVSOOosKgKZhp+Nwbk1UocnDxzRp5+WBPXj9BfT4IAm5XIR?=
 =?us-ascii?Q?QeCtN08i7TQ7bSR1kQa/ozxJkpGD87TeO+CM91RDy0Pkb4xJfqw7IijoUvG+?=
 =?us-ascii?Q?bWL2ZasbtG2FbzjANItVfXACz0l1MkhG9cdIPiI18ktmvXKkrNvu64efms/u?=
 =?us-ascii?Q?hmTLVoAVZ42dhdncLDElCIwtVERdYX0dMiQzzv00aZXuXuXNUTP9SP/VN+YO?=
 =?us-ascii?Q?HjYma3jipG5uFSLvEcDXBgR58qwkcJaKaczMbEOPOU4Qc++xF3RVkIuYUVS1?=
 =?us-ascii?Q?1nI5T+O149s/ERTOA3bfYBY2B6GWh6B/B7TrufeHSdNDWzMxS9OGygzN0+T1?=
 =?us-ascii?Q?Sp9AuQtPQKA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zprDn2bU2/23ulAPJ1C4S8GbR0+yDSHFmFCr+5otNFLQnmOO+BLhY1WazvO9?=
 =?us-ascii?Q?ivsFjtFetJRJ2S2OiZG9yFikH212VxCXV6mE6WabyB+JFIWLpoDI8ydOMHJ3?=
 =?us-ascii?Q?/ob+rC63AkZx2dO0kS4m6YbYXrOQ/Qan5qBsDO79sXv/0rS+aHL3yd4sT6Ig?=
 =?us-ascii?Q?gJSltnN8CMI4/9AK7V/reQDiyoFier007DekPlxIaNb8pAFj54Q+MtR2Fixd?=
 =?us-ascii?Q?tulww5WiRBZ8mmm/Xir78hwjtjfnEl07Ee8Y/26wK5AwpiBnhJtLmuBeC6Qk?=
 =?us-ascii?Q?9FuIX94e2XfB/jDp2RscHeVO384FX/KdcqQqfnFYfxr5hxrwA4NpqiUTj7+N?=
 =?us-ascii?Q?ktYZO5V+fvSvx6oVHebY+ctD3DKAvvAvnZH5bZn+wH9SdG4YvLFCBcShNR5F?=
 =?us-ascii?Q?UeqvXCVENnVNcrhv7oRAb8b5yIOSyk+DxPFec5M4ZG/VKB8Zi0yCVNt9X1VT?=
 =?us-ascii?Q?6pwOWXKsvE+GOJHoUM9i4/1oQNhdSzOZb6zj94hv0KxpgDDWyzKHXOXX/JVt?=
 =?us-ascii?Q?YyROHg4Wlow9aDvDQOagXbKybUbchuIIHdEksIQVelj9otsuIpg+g8Oj/4ir?=
 =?us-ascii?Q?82B86VoAO/MKh/eKMn5oQADli2zMbnsPCQhgNdPgHa4gsotFrlD3UVDJZhip?=
 =?us-ascii?Q?2wb/CVmsrAwgN2wckpNIxPStKwTuqV/HV2lCikF1d/gNILPNm+3OdVN4ZfCo?=
 =?us-ascii?Q?r4RGz2ORFZGEM6FdUoHSdO+4JZ0CdgZhsgIpnqgNjtguhC1+FnreAHY5zISX?=
 =?us-ascii?Q?E5dBj5FY302Sb9DD7M0VcVcR3WJU5hkKQ3STWfhy1hwRdZaElhvfLVWg5fe9?=
 =?us-ascii?Q?JApmsQfLg36mXx1mzIeqxlyKxRTpP/HaE64tm505AHneMGQMEVNWU5cyBaKT?=
 =?us-ascii?Q?OoSyKdsROVmVSThYsX8jXUkRbIZyKphUt2mtFmGBVTFH0LZSOscbVTtjddZU?=
 =?us-ascii?Q?LGGd1hPbwnQFPX4A/7pa5qIZcHld0EaXLWaLd2sWtLDtSLAjNxig5eKjlqHr?=
 =?us-ascii?Q?4LDf4hsZKe4URSMsnDWzz9Sh2RZBMBmZu6yqJhxjMdIxpqNv9E4VtT/peToB?=
 =?us-ascii?Q?xfi7twM6g1AfmBKnUIkny7Xr2Ba45zOaKL4hAFXsS+FcnGYYM5//FatYELbL?=
 =?us-ascii?Q?L99I/9hV+OBRPbdyqx1MQdNIyNlQQtVNSkoXr4JoOZ8AWZcftQQZWN7XCRKC?=
 =?us-ascii?Q?DOCeMEl0dZtOZY5IFHztdyn57g0/Q2+k8f6vzabgjGcmeFGjJM+Wlz/lFYRO?=
 =?us-ascii?Q?4Mgman24lJevKLmNHWfw83PhiZpUtxQasK2L+yxd6E7b7uBOn4CgYRCeS3er?=
 =?us-ascii?Q?o/MmhhQGzQjoiXk9DaVu22/gecws+aKzTDyudQP4G6Y/j/YF21uLTTuetNzO?=
 =?us-ascii?Q?BogqkolZA5egHI+OWNcm6oXZV6G2qQwy+KcpRfmcQkCP4PrUL6iyUb+nsF6T?=
 =?us-ascii?Q?yPVig5Zsshjv9X5pL5ar3XJtjDIpHz20H+jU4mVX0H9IGXXN+BbJV6TVhp2q?=
 =?us-ascii?Q?adcDPG6BED0dxbPi5OScWdEjEcMzpoo3jqjz1nJ7QNk1WQCfs+p8/KCQYfSd?=
 =?us-ascii?Q?7CsbeNoIbz4f7f7oQKatEzg5FCFwfcfyf8QW1bbk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad33650-28e4-4ed7-db61-08dd6368399b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 02:22:25.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh2H2OQ6wt7eDJUg4A9pUSah6khQd/QbXEMH8Z0LQus76h+H3NmUdLkF5fLZY7gyN7YSoleMDichhvaxtARVig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index bcb66d9692ae..1a9c697a795c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3427,6 +3427,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running	= 0;
+	dl_se->dl_defer_armed	= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.43.0


