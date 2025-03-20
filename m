Return-Path: <linux-kernel+bounces-569454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ECDA6A338
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F47466546
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74282248AC;
	Thu, 20 Mar 2025 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YOse/jQU"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284022541C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464824; cv=fail; b=AczKJQEsiPPKK11Q+MsW5luK+TZIisiV5Yu+M6LCCepguBHZ/iStALTt1azUN+DBPWdvfF94c0g/7dbBCiQsFrHzDJK5lY9sFeVhSNOYGItyKyiDAddxBobFYelSRwYo7p54lVAHAnkUWL53IvbsVCFh8dwwFvM9AGZ9Mh/tp50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464824; c=relaxed/simple;
	bh=30LqFDdnEF552DnA5RFOCs35GYNHcF8g89Yy1ovV2gs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2dw2fyHEaAKbmF31CDSKZtuKK8AzXzqhYk1S7gepR0VXyhsZqIpqiw7KjtQ+0GHDCDiU8U/NPybvUPhYtb4JRQbX7ppaBmbGhiJnD+9vEKpbbdAZx1hjdcD6af6mwtPPaiRcP/8qZF5dngTm/Gwx/zENZgAoWcEndSiMO4QvV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YOse/jQU; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XazZfT9mO38s8KLtecsx7I37D9lLEiHSx+reQ7DNPs3Bdr1OX4i6SZxP8zlhvHC5NjUMN40oY5iHruLhyEvK5v+N0mxzynDS56mLEXyi9HD8YGT1PpJYkOn5ur01F6vYnvSbAvKM/Gm0hkTenuJtxXou20AhcModBSaZ343/lQSM9kWnM22kJHpADaiQbyhhHYtMw9Js9thHxa7rgSCbmIKC2wWIsyzXXGBWAfVAzI6pVRQZ9bnmZ3bzwCwVyI38v7s7+Q2u5wfeRBhj0iGQ4HE9I0zmWdG+2P3BzAZOOeSnbius2KX9GHBCq/qqI+DrLcRRUtUOntHpOVEhUuJ6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmRgVIm/Ck5cswQUi6abXdFXnHGofjpBeRclT9WlT1o=;
 b=smvX+twH9X5lNGy06D1+CZZJczYo01sygw9PqLapbG7OXxg2Z+1y3cDiMmXXVwYh+Ott12A9wgxxqvHjYNsxviI5utP1dMdfMJ2STMeVKNmAX0XzSfrL0g/z6GY4E+Fpq0MZSSdbaoScOGD8gc9LZSt4tN89xspJRFPAP0CU4iM0MnR6dhCbKbALXBB4cXvOee4dgcPxsKWbL8O7HbClDSJZgho54pXzke5yPUb3wdqmXDv88s4bFcA+/ulF53XFXil+4I2oIEXrV52auprCtBeBIbxavoE28NUFJNfoyhpKsnR+f4i7IeVAu95dBUu8Nk9aa196dmZ3letlFmzLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmRgVIm/Ck5cswQUi6abXdFXnHGofjpBeRclT9WlT1o=;
 b=YOse/jQUkfNy/VP6h1FEZKM6bTlyfl17xMcj4HtoSxGGBAWatsQLWNy1wFYx1ox4zdPIHdte+q4LFJfsx9bI1vSWjosRTsam7UXXY3bh+/CB4ZDDKz76Zdc3qBjHaKIfSOEYKw5a8kYFCBuTUk4p0G/ZahvRaqByNQeDsbYpxaI=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by PH7PR12MB8013.namprd12.prod.outlook.com (2603:10b6:510:27c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 10:00:17 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::3d) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 10:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 10:00:17 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 05:00:13 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich
	<dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 07/10] drm/sched: cleanup event names
Date: Thu, 20 Mar 2025 10:58:03 +0100
Message-ID: <20250320095818.40622-8-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320095818.40622-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250320095818.40622-1-pierre-eric.pelloux-prayer@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH7PR12MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b94254e-cfc1-4589-73a3-08dd6796046d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xBygZ0/4xMSkSPRxWbWNyQ7NKS4SbOozmyxWXmXddEGIG/XXJeTfek7Px7kd?=
 =?us-ascii?Q?wmUuVTMKqd8ltL8d9UNR6ZIOmYJ2vk8Ba7UbWje8g0bxPiX/w9zKm4NfeaIW?=
 =?us-ascii?Q?ywqrajAFHqghusQhABJUbwutQkwceqWRlvDH+GYQszlivaRIAfI/NHiiseKk?=
 =?us-ascii?Q?+9lhIlS3wJAc1y5MNdsV387CYxJpz2he1Enh9KpictZV6Rf6n9exWDIXRbxG?=
 =?us-ascii?Q?dg94hvCyPiHj2UeBMF/uOxrOY3KQ2xnMtUdTTsmddWyKCuHIfA+SQ37cJXas?=
 =?us-ascii?Q?etZITfSUKc1BT/FiYmkGBfjcUSJL+Gd9bFq1HCWksKAma2FoY5KeRyFlnm5j?=
 =?us-ascii?Q?ue7LtEmivmWe2KJ0a4b83RoUps2jy7A4NBtdhGq1RmvvY4qozajnE6HoLpkk?=
 =?us-ascii?Q?q09z/lKJHhqWlNvGcopbbJlaJURhnJMfSVB0GF0iMmvCB1kzOGVWDrnilTzk?=
 =?us-ascii?Q?V4Fg74ja8erMNkkUbgtyZs5/09tvbCyiejacQYXk0PFBn6rp+wPNs/BgTz11?=
 =?us-ascii?Q?Vbms2hJxTYpgqG/hSRuVv6T0cuiYQZ/d7tydcMJedb2q+SrMWoY5j9qhl6eB?=
 =?us-ascii?Q?9437KNhLRI+tK8H8ETBIF5KY2GU2VWWyizIFDMhe4MVM7DSXZpb+KIIwkDFH?=
 =?us-ascii?Q?/p1ZetCtRQfSbFj7OfoVtpiMwjti6YNjxp2nX9JIevHToDyhmIptsEr90l4B?=
 =?us-ascii?Q?rwdaYzjw9P57F/VagnQI2xzhAvdpXNQ/tniw3BhVd++ePopXrpUZfih8s14S?=
 =?us-ascii?Q?QkZcsKgmERtltML8K14HRlXCeMEZENTDgEmYGPdEjpiymMMOiv8NnpkhJO2U?=
 =?us-ascii?Q?j9G1zO3TXUd5aQARS8h35NQ2eypoiC7ETq1uPBW5Xyx9SXMQtDIosmyvq3Wk?=
 =?us-ascii?Q?gWlX08blT2T6SjdbQc7kmS9ud1W1qXXaIM3hwrdnItJcLAIsvOxfZw6o0InA?=
 =?us-ascii?Q?bW9rMewIskDeBBPsxezEk1aZj0cSkWy+nDEDksxbpvOxM/+aRqDRpdwHD3U/?=
 =?us-ascii?Q?g+B1ZoQO0g4p3S7E81wNzOEdqR5qZZzv2NpdHHDwdQn6k0/faIehczKEifQB?=
 =?us-ascii?Q?3qzxxztamKPhmXnvOeAx8YM13eEmNgqt0V0SV2oRfpVBBr54IsEDf+klSf3c?=
 =?us-ascii?Q?TD2Otdm0jH16duWr8o/7E3g/WYVkjw3hvqQCO2kfZP2uRCK21JuL+2JjeE3z?=
 =?us-ascii?Q?pisa1jFnB9YFZvXWfod1L0ohvaTKtxN8ypvDBkPoFRmUJfYpp2gct6OutIxi?=
 =?us-ascii?Q?VBCfQqeREtrQP2EtQMyo2QEWOZW+541pHrhPqK1uEQSgnnR2xQ2x8xtukYsU?=
 =?us-ascii?Q?GiIq/WFvAzMpgm3PMUJ1D2k91dEHWT7h9DE6G1eaX5F2RDUftZplj4T7qs+e?=
 =?us-ascii?Q?Ske5LfUUg0nnyGKP8QSW7s6Kzh+ygmI0/pZgWvOaRbnr3iNezt539+HIOBlo?=
 =?us-ascii?Q?d++MRCJ7RKuoSm6HPtHsNomYyiH+Hicv/GSeCrC/5fkpM/rOZTrAwmBGlp2w?=
 =?us-ascii?Q?S90EedYGjFX/7ds=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 10:00:17.3046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b94254e-cfc1-4589-73a3-08dd6796046d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8013

All events now start with the same prefix (drm_sched_job_).

drm_sched_job_wait_dep was misleading because it wasn't waiting
at all. It's now replaced by trace_drm_sched_job_unschedulable,
which is only traced if the job cannot be scheduled.
For moot dependencies, nothing is traced.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/scheduler/gpu_scheduler_trace.h | 8 ++++----
 drivers/gpu/drm/scheduler/sched_entity.c        | 8 ++++----
 drivers/gpu/drm/scheduler/sched_main.c          | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index 38cdd659a286..4ce53e493fef 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -63,17 +63,17 @@ DECLARE_EVENT_CLASS(drm_sched_job,
 		      __entry->job_count, __entry->hw_job_count, __entry->client_id)
 );
 
-DEFINE_EVENT(drm_sched_job, drm_sched_job,
+DEFINE_EVENT(drm_sched_job, drm_sched_job_queue,
 	    TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
 	    TP_ARGS(sched_job, entity)
 );
 
-DEFINE_EVENT(drm_sched_job, drm_run_job,
+DEFINE_EVENT(drm_sched_job, drm_sched_job_run,
 	    TP_PROTO(struct drm_sched_job *sched_job, struct drm_sched_entity *entity),
 	    TP_ARGS(sched_job, entity)
 );
 
-TRACE_EVENT(drm_sched_process_job,
+TRACE_EVENT(drm_sched_job_done,
 	    TP_PROTO(struct drm_sched_fence *fence),
 	    TP_ARGS(fence),
 	    TP_STRUCT__entry(
@@ -112,7 +112,7 @@ TRACE_EVENT(drm_sched_job_add_dep,
 		  __entry->ctx, __entry->seqno)
 );
 
-TRACE_EVENT(drm_sched_job_wait_dep,
+TRACE_EVENT(drm_sched_job_unschedulable,
 	    TP_PROTO(struct drm_sched_job *sched_job, struct dma_fence *fence),
 	    TP_ARGS(sched_job, fence),
 	    TP_STRUCT__entry(
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 047e42cfb129..0bad247f783e 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -470,10 +470,10 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 	while ((entity->dependency =
 			drm_sched_job_dependency(sched_job, entity))) {
-		trace_drm_sched_job_wait_dep(sched_job, entity->dependency);
-
-		if (drm_sched_entity_add_dependency_cb(entity))
+		if (drm_sched_entity_add_dependency_cb(entity)) {
+			trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
 			return NULL;
+		}
 	}
 
 	/* skip jobs from entity that marked guilty */
@@ -579,7 +579,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	bool first;
 	ktime_t submit_ts;
 
-	trace_drm_sched_job(sched_job, entity);
+	trace_drm_sched_job_queue(sched_job, entity);
 
 	if (trace_drm_sched_job_add_dep_enabled()) {
 		struct dma_fence *entry;
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 501eae13acb3..85c2111e5500 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -401,7 +401,7 @@ static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
 	atomic_sub(s_job->credits, &sched->credit_count);
 	atomic_dec(sched->score);
 
-	trace_drm_sched_process_job(s_fence);
+	trace_drm_sched_job_done(s_fence);
 
 	dma_fence_get(&s_fence->finished);
 	drm_sched_fence_finished(s_fence, result);
@@ -1221,7 +1221,7 @@ static void drm_sched_run_job_work(struct work_struct *w)
 	atomic_add(sched_job->credits, &sched->credit_count);
 	drm_sched_job_begin(sched_job);
 
-	trace_drm_run_job(sched_job, entity);
+	trace_drm_sched_job_run(sched_job, entity);
 	fence = sched->ops->run_job(sched_job);
 	complete_all(&entity->entity_idle);
 	drm_sched_fence_scheduled(s_fence, fence);
-- 
2.43.0


