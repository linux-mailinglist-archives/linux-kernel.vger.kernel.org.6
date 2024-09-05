Return-Path: <linux-kernel+bounces-317840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476F96E45E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 22:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD5F1F26BE7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 20:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5D1953A9;
	Thu,  5 Sep 2024 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="g0sOiDsh"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020082.outbound.protection.outlook.com [52.101.193.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDA3D6D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569290; cv=fail; b=nSb3nHSdzTJDf/Dru8cDzmC+MykgbiRlF3NfAofdPS9Ms3zyXMFg7UbpthWC/r8IVbbBo9iIErqh8vmoLWTF+cVUrYrKDIBsZmU9YX9O/fDnGWFT0mUrSZUEJri4hbrEbrSsZWpGaQLQcdel+3ucfZs2XKfgzEe+gDdo30n/jj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569290; c=relaxed/simple;
	bh=EnriQt5VAqJWXM06KSNMKI4DCXmu9/lFYo8z1tdneyo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L+UpYuJjl93tAgKr2c2tALxM0JM7o5S12DJnkuH6jbxfwfcvHShnzLjzyxmDpWMISa8BPcC99r7QgZjG/nJ5QQLtOae4q4d+hFQeWNTtdH10Gnblcd0OMPhP21GF/CTwDkI7b1dqLGUxwb4kRruLxOF1eBQdgluQeHhxFKrAXWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=g0sOiDsh; arc=fail smtp.client-ip=52.101.193.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9637AZKn7CBkKg+ixaI4vaNpwgzszPaURJ8Giyszs7s/A4nXA/cQThw2ccRpeR2cJX/ltmTSzs2BnwJWbQlqVp6Um77nTTJ3DHjWENnLO5yThU0IkOeFbnJCFcbgmibFPdlrwHgLlsM4vNAGAuk70XQD6aUjcUqacpz7+FkKQELdFn8qd72YdqAtOee4EK1Edk8Sb2rGGolxXXNfij+4DvzH7le8HX4bUm144eO9tFCPKHMonDeouSbad9XMqPeh1qmhfVN9SAogM0c5ekkJCckNYx1UZKxH5vxa/N1yRVjvlIf/LPY+v1OJw7L6SyE9VBPvJGZB7GJFZhAK2vqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bEZfU9CPXhWTeY88jGqHAT+Y7Cl3c7XFLardbZihFc=;
 b=aic/Wco2UgtxyYSDvi4i6k02g8MJH70guD2X6yjVSY+kR5jcBaTQXiVYX5ksgTnVRAVo4IP3BQnXUTXovcHe2A39TpkTGh5NysEPqxZYOCi+MaMcvwLnW0ZN7F/c02Q7qq81xzV/BQ9Npql1jLsUtvdr0G1bPRp7rrM7xVOhIHMcc4PmALcV8tcV+WW+/pRIuKZ2o1OUbQqTX6lw4tr6YU3DqkAA+hicgwYN6akn2wZlalSeQRS59tXveAQt6jV6fNEHTotCgmm/bwfboN86vypDgeM3EKC28aKvLJMsxvnblchO48RKLHhAUdV5JfqpxpUpVXU770QdkIwc26GAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bEZfU9CPXhWTeY88jGqHAT+Y7Cl3c7XFLardbZihFc=;
 b=g0sOiDshDlk6jveDSoS9LGnwu0L+qnj+kyvri533GyqWNdjfceY6A45cvi2/9IqKJxC9LhDjHoJLPgqYzkzuQZ8qjQXBGPTOmkaHs5FG1lvcRcneFI8ic1E3fJpMTnuPIBa8TCJD99r2JcFuChSW+TUSJYLG6D+hRpG1DzBKEoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6237.prod.exchangelabs.com (2603:10b6:a03:2a2::23) by
 PH0PR01MB7236.prod.exchangelabs.com (2603:10b6:510:10c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Thu, 5 Sep 2024 20:48:04 +0000
Received: from SJ0PR01MB6237.prod.exchangelabs.com
 ([fe80::ba9b:75fd:46b8:c984]) by SJ0PR01MB6237.prod.exchangelabs.com
 ([fe80::ba9b:75fd:46b8:c984%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 20:48:04 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ilkka@os.amperecomputing.com
Subject: [PATCH] perf: arm_pmuv3: Use BR_RETIRED for HW branch event if enabled
Date: Thu,  5 Sep 2024 13:47:32 -0700
Message-ID: <20240905204732.20546-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:610:52::38) To SJ0PR01MB6237.prod.exchangelabs.com
 (2603:10b6:a03:2a2::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6237:EE_|PH0PR01MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: f76db03f-4d5e-4597-d9ec-08dccdec0a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G0lvclgfD/o/Q9AoEx5PaVi9yiCP5tkwMNHoMsTkNMntStHmS74qpcBLjok2?=
 =?us-ascii?Q?DFvf2nEEjGjdtbErFOos0kqz7T5gNJDgoKNMdHfbtdyLe0JC11dccrEEoR5b?=
 =?us-ascii?Q?UFhS0OAVvPrnsc39c2SFL5R+kKJlJL7Q3V3UK5NjG2cH3JV0blhTjBnJ/0TB?=
 =?us-ascii?Q?Esj7CA/uEx3qbNoaOaZ7JYnr6UKCKo4eNu5a8yiQekrkbBVoK//vdYyK+8dX?=
 =?us-ascii?Q?Vc+U2z1KHFzJJ2lAzkBN05OMHCkWOPv0t9Fsw/TdvRjUNjnRdLiYY0F+7EhK?=
 =?us-ascii?Q?xFf1uHyWzXpsXUWLblKUKcujXtgdP6Vic7Cm85kG4heg7dqup1csxicc/D+g?=
 =?us-ascii?Q?mb5Gpq23O/GnLTqSB4YXNWrb5Y6nsa+XLSPK2aWCchnCzs0rechLVhME4w56?=
 =?us-ascii?Q?jXT/8t3XikmaaavSD1dyy0J+nsPC0aCh2CpcNhgq2kAOoFZrGhQsh0w8ee1r?=
 =?us-ascii?Q?pOZ0tZOoae637CtiHU7sw82FgITLSAegFnhR5LmlivC0JJQZkitXetE2FAge?=
 =?us-ascii?Q?zti30POxW+WIO4qSzKcfQcOQ5MA3SeBsGV2m2DtiM9egbcEmQg70T+isJR+x?=
 =?us-ascii?Q?Qc8V2cN/cqU5k6T8idbGMTPoiWF7+kP3r6s9+gkJLNVICbekeaKn1/xWgA4I?=
 =?us-ascii?Q?lMTqjY9jw5VEFNdY3SaQentgK7g28euXBNwWpP5sV/00qURFApIH86gZDOi2?=
 =?us-ascii?Q?T18tSJtjCVQfbVlaV1XTYSiZXn7lp2yiZDiSbDN4AaMenK6lto9K0ipBqN1R?=
 =?us-ascii?Q?qa+4JIi8NS85MkEAYcGLcGcqSz8fcU37oAlY3bWmaI/MUIuBTs+DAH9nRtsy?=
 =?us-ascii?Q?ygx6aaeaSpcB4N/d9BRAABqOEciZ1vY7nEgxxfOctoB5ibaYDp29Gvwn9WGH?=
 =?us-ascii?Q?El+MHBW/LtT7Upvcb8Ofll+yOJ8rXisCq02sD7KL3KgOfjVuHHxYVnrBn2dw?=
 =?us-ascii?Q?rCLDx+ULDMLe2HNjuiLWNeiIB5tP34s7OFLjcajrLQTz/Ygpih9hxWhHGth2?=
 =?us-ascii?Q?po2yMM3AnQZHE/OJ0aV7rRs+vmZIRUhe27IbP/urlY8dvDh2AOAb//lZGc8B?=
 =?us-ascii?Q?U32klHycADdH67npIXTvBTYhaUWDewdhW+QtclUCRhxxY8blwJkzNCBvdKfg?=
 =?us-ascii?Q?ph5jk+3pYq3PiFRF/3loI+8f0tqB8c+VEmpGnEVHilF2ibiz5nevwoXw83/s?=
 =?us-ascii?Q?MOGyzzOqp01YJMgUfYlu0P/TlsFdLHvC5WN2oYDB5IOo6240EjvXAetlDQCa?=
 =?us-ascii?Q?rMAWUCmsRMCEg3Pdzi/chPMcGC9JhgGbJLcXHkaKITr3B08Uagbx7OOKDFsG?=
 =?us-ascii?Q?e4u0lyXxsOkbgMExyyKGCTd7MHEOrHxXhBHehVNwDPVrtIiXm67nIQ8h5Gy9?=
 =?us-ascii?Q?KJSVi+ZTVzZW+GuN+H3j/b+LNYh4zFybsGdCsvh6Q5cQP/f5cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6237.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JRV2Xo6yrtJmbiM6VMuCjuHEkDM0F0n4IJG2Q4RXc5F2RN7IDfyF4jevUR+1?=
 =?us-ascii?Q?djHxQzwAQWAY/OjSwtYJ0m9YcrNt3jPUB/zxClV8TnV7yP03iA/RJ/hjN2rl?=
 =?us-ascii?Q?igs/BCjwScpCAOk3/SaVaruzcb23XSEDjt3J8awC7wsJRB48IjQmE0CcIbt1?=
 =?us-ascii?Q?ZZBQgq6dhFznfV2Ogx7hKcIZMnav6hYp50REjaDVIIrEBRdW/NRSiqnujrpT?=
 =?us-ascii?Q?kSycfAH7PuGzWlkgrROZ8wxCnSmoRuJvcCCam7+vR9DYDJsIXzUwJjqbgX1/?=
 =?us-ascii?Q?G08luVEtxu5oFFzvPMWKouTF+zoVdZkD64Br/p2Su6DbZFn5lD+25iFTBBSV?=
 =?us-ascii?Q?3cTBuVMJz8iJRXYmUyV18KJJGyNKar9g0yAw9M0jQ+LbKtAYUNhYOl6n2Iy0?=
 =?us-ascii?Q?RSC6K/6dm6dxG8VAgKw/4r2zTgDVjKUWYmSBxbq0BgA5Jz0edlDXiHMzi8iO?=
 =?us-ascii?Q?Y0H1MCwBDo3z+xflhlxQ10IXeigECG+t0vlc0IL+rpaBpW7XKXvbNIpNpgKh?=
 =?us-ascii?Q?eZ5Avdy5fqdCUHwVre3h6zPNKLJvAC80SGbWOj1n5tLHynVbLWuQGCZqj7e1?=
 =?us-ascii?Q?EbiXTqU5DkGy2rO2U+WnZcFYGRIPbLBxO/aXOGTgMMj2VdggCV1xHNyQWM8Z?=
 =?us-ascii?Q?8QxXCFBa4SiO7riuwCJ0F7i0t43GkbL3hJV80JmGoheFeeArm/hnfHX2NIKM?=
 =?us-ascii?Q?JR6neDuNu5ktuNJZkIodjz81c5wAQxrUlMHiKoiQrtuzr4flV8HBkQyqHH4k?=
 =?us-ascii?Q?Kwip83zonP9lGak3/TpYIGOCDWRR0L5ZFpZosKDc8ZnLf+I1zBbJto/lA71v?=
 =?us-ascii?Q?zH8YZjUJhGHx+TfaWVq4pYSSx4v9nTR23d5evb+IB8sSXG9LmpEz0Zg2I2vW?=
 =?us-ascii?Q?f1oG3W/tzVKXU/Szs6t6oXV1zrZMMV6tc1SIflpUTfJjlpkiG/N/MlCCEtBE?=
 =?us-ascii?Q?BIVN1IbhM+cyGw3QdQnP/SBBiUPlexdMBzarWgW5ScGHAi7qtCo3k2l3QJxy?=
 =?us-ascii?Q?aFGlbzB02rhwnRQAbyyM2SvRxrjjMsLek+p2MUGMFEKmDY6RLaNFMz8k66sU?=
 =?us-ascii?Q?TswkxIV8mw7QTwS0PNvoQggEyspdQt5RdjfYwED4yKPO9YSGd45jhmFlK75t?=
 =?us-ascii?Q?nK46IEmiWdqEEqfI6jVSx2pm07eQCUooTTULAeZf2ARqo8aAuklGoegdI0o5?=
 =?us-ascii?Q?Bqm7j+ydTVVZ1/p+ukzl3fKGlWy8ug40yBIHQCVlT+INKsc0QGdGpggs/7m9?=
 =?us-ascii?Q?IqneteijKaPUIAeQDcdhWTTdUY3UL36oIgqMy66c/qWJyML1+DH/ggvCzYIX?=
 =?us-ascii?Q?acyMGReZL3zALvVdTS+RAman0+Vuhe7HPCcbz+3QdGvh4ZdtrKxhl6abl42G?=
 =?us-ascii?Q?A0OCfIW5YTCObE0L1rIhDu10KOVV9ti/c/IXEAIk8xMc3yXQ3yvPeysnSaPc?=
 =?us-ascii?Q?qrWr+OX8Fma8t3gCUOfIHH70nPWczT1PTylg4mvPUk5JNTEHPyAmwyv5CMfe?=
 =?us-ascii?Q?/eB4N8W460Um8RX1YLPUSUADCQuwwwtpJ1QqNnV0BtlAkfjvsgDt7FBfrDQ4?=
 =?us-ascii?Q?cjr9nYyBJq48ire8AS5L5maeLdXjjHoS63LXKNs8LmFw/66jU3YRJWB7vSRk?=
 =?us-ascii?Q?d9K3AogqKGu69WJRb8x+Xsg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76db03f-4d5e-4597-d9ec-08dccdec0a1f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6237.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:48:04.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViB1tTLghP2vLdzeYsZCV2ljNyGHHgyRb8MNsUcLZveZ3JfturUVd9LlAO98ZdGerdNcNXfngrPJL4Iy9SV+yqALrP8w9fMWrUgmENHTT1CIYzojy82icy1FNuBPP2Ir
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7236

The PMU driver attempts to use PC_WRITE_RETIRED for the HW branch event,
if enabled. However, PC_WRITE_RETIRED counts only taken branches,
whereas BR_RETIRED counts also non-taken ones.

Furthermore, perf uses HW branch event to calculate branch misses ratio,
implying BR_RETIRED is the correct event to count.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_pmuv3.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index d246840797b6..a8ed08df1411 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -46,6 +46,7 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
 	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
 	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_BR_RETIRED,
 	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
 	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
@@ -1083,28 +1084,6 @@ static void armv8pmu_reset(void *info)
 	armv8pmu_pmcr_write(pmcr);
 }
 
-static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
-				      struct perf_event *event)
-{
-	if (event->attr.type == PERF_TYPE_HARDWARE &&
-	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
-
-		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
-			     armpmu->pmceid_bitmap))
-			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
-
-		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
-			     armpmu->pmceid_bitmap))
-			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;
-
-		return HW_OP_UNSUPPORTED;
-	}
-
-	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
-				&armv8_pmuv3_perf_cache_map,
-				ARMV8_PMU_EVTYPE_EVENT);
-}
-
 static int __armv8_pmuv3_map_event(struct perf_event *event,
 				   const unsigned (*extra_event_map)
 						  [PERF_COUNT_HW_MAX],
@@ -1116,7 +1095,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
 	int hw_event_id;
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
 
-	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
+	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				       &armv8_pmuv3_perf_cache_map,
+				       ARMV8_PMU_EVTYPE_EVENT);
 
 	/*
 	 * CHAIN events only work when paired with an adjacent counter, and it
-- 
2.42.0


