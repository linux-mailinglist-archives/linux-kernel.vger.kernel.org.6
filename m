Return-Path: <linux-kernel+bounces-218500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE490C0BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C80281B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C7EEBA;
	Tue, 18 Jun 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tfEUgCQw"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2130.outbound.protection.outlook.com [40.107.236.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332786FC2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671899; cv=fail; b=Q3QUrTxuCxhMg7N3TYFsUKGX12nNT1ln8TReElzFZg8Gl26SJYaOPdxKxB5aootajjx4IbafupjckSV0kEv6pTZf7AHHkVO/18TjebE6gbvbwKrhUS2WOm2K9rgVM2OJL2QWU8Mi0kTcTBlcPWBLaMN9dZMqZY5upPKB1kmtrzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671899; c=relaxed/simple;
	bh=7rhocSxskJFgXRXT2giniBQ6H2TEPA1voi+F2lPbZBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sgpxldiAgAVJa5THIMsrDcFy8guU8wfGqhrSWpTUN9FVeMlrHi2ZW6+ZM8YRBDbn9Ifw93qag0CrzGXygbo8Ye30tOzanUzrV/aHTbOKvP5JUsuVA/ijlApiu/waQ31ayGaUhPaaytJhTyeYdVSdlJio8oenWCfmQkCkZTb5aHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tfEUgCQw; arc=fail smtp.client-ip=40.107.236.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4yK1LD5WTpVSLmMXjC2r8s9ro2izlWVl4Yf1sFGq/XTek9smB3FLc7cDArkzTa4w6pz5mtHvvdcW0xhd4GkNZC+Ykg/B6lDzVtDGJ9Cq+ZwG76ON576KHJCGx3Mwm34Sx967AxIr6LB1O9pzBceuqSrHWnBOt/uDGpe+y1nzoWJ25nOg9+6cUeCAKQNJC93f0rFBxWjSq+qTuTNpY4ARRWjYbqRpzRuqwA+5YsJcFDJFGFBOnZ+fG2kUoHVSv19aRSQd1qQrvvVvXq/N9rkpyrGWrVVvWXZ924437Ry1CrAQTNaDCgz12UCZUXPfZo+BVzUwplMPQ2QXGdgTSF4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgCVxU8gDmcDqevGGX50xb2hvEd7LRwWj8UR2cpUb68=;
 b=AlALk9QLaVq8OKu8CeZWl8ZdReBxyv6yAcSW4iqYNsgCPu673DDJGQ/CmPCwZxF/mOZZOYgKSaMiPR/V8k5qzWdXtGW8vptfmdWB2J5e5vLOSISnTcYwBdIDTZ/7CXbAdGoALX3y83OBX80K+AXew1O8PIwQpwXSwLA9Th6QWXBlCyxCWgwljEYQChbYHwJI9HzhDaYmT5fFfE7r96eu4CDpG6hcYDVTw923GY4i7Z0PER4K6HeMNn65Rho367fN1Hri3Fxkl7NEMl7LUzPHesg3MAqmW+HjlPSRNqM/t2aDXAhBaZdcVhZUyc9A6retywIigvFyg9F+gwwQ2+cqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgCVxU8gDmcDqevGGX50xb2hvEd7LRwWj8UR2cpUb68=;
 b=tfEUgCQweCtXlCxenwjvOrpYXA6Mgp8QE2jeSSmC2z1i33DZVZSg9aiDBl65fVgO8fux1WxCPvRxliOtHqhzgV/kK7AevLixl8L4qBJ89UD5DUN25t07K/zwWnDNT3RuNHQklZlxNAAvEMYPejmDeo/z85zLz0zR+nvE5kRAsy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 CYYPR01MB8410.prod.exchangelabs.com (2603:10b6:930:c9::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 00:51:35 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:51:35 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v4 2/2] perf/arm-cmn: Enable support for tertiary match group
Date: Mon, 17 Jun 2024 17:50:56 -0700
Message-Id: <20240618005056.3092866-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240618005056.3092866-1-ilkka@os.amperecomputing.com>
References: <20240618005056.3092866-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:610:4e::35) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|CYYPR01MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 205fce94-c872-443d-886b-08dc8f30ce0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jyt/lJwsGOoI6bjr0zFG40ERIAFpsdurldYbvPcFugrsIqC5fE8tjjmp6Xin?=
 =?us-ascii?Q?SO29rNKqAGIfj8Okwz5htxXmDpBpN+B0o4HnIka9wuY/BqQCFS+Byu5ZTHeU?=
 =?us-ascii?Q?w03eXmzk41gLrHvcr/pvHYjOcPIoChetTtcvb6TiQbSZP1mKv0fQqdj0FGND?=
 =?us-ascii?Q?JNA/+cLnEcD9opamzeTzhIw8z02Duw1sqN4b/t+2ONWquvhoM2unaf1iTXvs?=
 =?us-ascii?Q?3B2ZsriQ8VLjollPSmYv96n1lCM0NUIQMtl/YaePAhvXrrxSewyTDcf3wdaU?=
 =?us-ascii?Q?eah+50FAXwVMtmsyWohKmdzSd67PwXgnhVxELD9AeGiSscR02KyrL87aKxZw?=
 =?us-ascii?Q?BmyCaHb902nZ9FDol0zS91XMGnePrISUUv3BiExZwvh5qNhW83ldHnq92Y0a?=
 =?us-ascii?Q?UYRmMiKNT/syFICecUfOYEQ4XWMVw5nXh85zv0ZhY1DxtVEPcBok1rrnJedw?=
 =?us-ascii?Q?X0Qigbzx/6tWmpoXKpzBKtiGmheq1OQuCYiuoCLLUrorx8hIYNIkccxRpT0M?=
 =?us-ascii?Q?E1/ZUuam29+FKdLlZRTxfvPdv9hbHMHj4KrQqVDl0+IgvEW+3jX2SQRU6uoP?=
 =?us-ascii?Q?66lPXhHQpiQe+QVhwUDkwNH6yAP05q2SQYawSjk+nOVXQwLcEjF2I/uMEoGy?=
 =?us-ascii?Q?PmybFcPx+t2VVRvGBMEN4oyMxbjuVvLALvzpH94+SRU56a75b0EYPbrljS/d?=
 =?us-ascii?Q?IQRL9yw09d5kR1tewvfKHGs0JqpAg2oIBb7gs+vOqSsrKs66ibkL7MtxgAOM?=
 =?us-ascii?Q?FIgZbSG4AkxqOF3Ayg+TbhIA3ByQ8nHFlWW/Bm2+KfD7JDwsJG7wk1la/su5?=
 =?us-ascii?Q?w0QhCytnViSzxiWM/Wcolg+Tpol8+DmxKOz1cUUXek4/+U8+5i6K2dLdBa6L?=
 =?us-ascii?Q?vOUCLeMNxC3aNbsG9YT/s8kzgtXAutjDbjOHdzD+7tcoiMAOj9OwgFXPJWb8?=
 =?us-ascii?Q?kRRscrkfoweCxftRDYhq94mle2OvqVVHpsMjCYA2IUyRxv4Nsh5x3E8MwuhN?=
 =?us-ascii?Q?QqCZl5rEsDEgT5+porddumYvvsoBxzt+gDun9WkkHww3oqC3y1wSw4Xfb8Yy?=
 =?us-ascii?Q?ZHnavIsXU2EDXLMefzNVu6v2d5QfuxRTJfSQYZS+/mZT/WyDVb2kit8OxlQg?=
 =?us-ascii?Q?oTla6VyhcHwVOS7cOx3IQmM4px1aaEDm/f1iBKXxiZFloAcxtVkp+1w/i/2Y?=
 =?us-ascii?Q?njPuQM7ZmjeH9CDzhbgMnXlf5Tt44NxqToXKZJ4iwoehPc8K4a0/4sgVZcIm?=
 =?us-ascii?Q?vLaU7dJxKY5w7k1hFgUAB/JlUfYoGubevH3HCPHi6sUrFfNpDPKwoT8/MW6y?=
 =?us-ascii?Q?/BZZmMjyUp2785iOFInkp+chPoVZfF2+OaOuNLv4OJGkNPJVSLqBE9MpMa0I?=
 =?us-ascii?Q?yu/emOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(52116011)(366013)(38350700011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AfuWgEyGd/FVYzG98QU0UO8HWCz7uaLDG5953Rbsb701yxqbijdzKGIjVM30?=
 =?us-ascii?Q?yDigfZCADJIX31Pg+YZQ64tjZSp7TU11wnohjZA6unNpZn/qJbGpwIArmiXF?=
 =?us-ascii?Q?7P5VN3IiymwtFDx8sMhoPp80t2hzvJrKnGj3in/Ij8mvtNvzIcPXo6vlIV6Z?=
 =?us-ascii?Q?dHmxUfux9vvpjNrT8ikpIIEHnihRny9lWxzQ5EPKbamnMJBi5UMz1gBalxzy?=
 =?us-ascii?Q?+V18jLdT3p+5BNmkcAnA1i5hxR3m9P4THIZ0VqsZ3TGts9AE21WmiKZKJZnF?=
 =?us-ascii?Q?tAiXXRxEMAJmUqC/otL79rFpDj27Sr1nW062H8vpwnJmm+1p0VfeXcSCp1jV?=
 =?us-ascii?Q?IkcW3dTvWyzAntyaxk6nP0ZDl3HymdoJ4L8BNhGhtJc0b84xokSNAY1H0qmF?=
 =?us-ascii?Q?GjoLMHjkRqP5SdLB+fyym8o8nkBLKZfCnm20Gu0u/WwHCUWT6odDrG7QXTAo?=
 =?us-ascii?Q?e0bPjlzc4feX+taFYSCoNWR/N7OUr4Sxd+i5mkz83kj1MWa/uEXbriGP3GsV?=
 =?us-ascii?Q?iHGjti2rlR5tiPV4eM7gtlzwnehdHZzRHsAKNDzu57hBKXrZqy1XHp26164s?=
 =?us-ascii?Q?0CGybN6egYfTT1NjQma3Nyqn01fz2ZygrYudYKPgmMYduihpdo7KNFwZp6o+?=
 =?us-ascii?Q?lrbtXDcLXKAbWq/N36TkeRj2P75Lfm+s1ZmRXC7vk+vO8zJoT9Iy/ewM5nvF?=
 =?us-ascii?Q?Y5XzPhxpCZmUSmIWjd7HUQNsAGQ+zaYE/LA5ZTpyRMYDd/WGZleqYwWSOrnW?=
 =?us-ascii?Q?LrLeDXh9e3MU8mav3xOIXv3QOx/sSPNpahaTc6QfPTfnBQCQ6nT2eKGMlSG0?=
 =?us-ascii?Q?efAxBS5f0Ht7l4VqNJmgFpsWPipbQQRJJlmtFxg2c43svg1lhagUkLqOfXSL?=
 =?us-ascii?Q?aLFjq2sSVw3OHhvIBDssYj/5ib7u0HqKIN4jvtfsyjHjBmwPdmTTezHjmtzT?=
 =?us-ascii?Q?3cSM5IaJBLepYwbm0vkY0pmCQ52BEX1LYrKPfX1dKm0BIFiw8QtW3IRY12b6?=
 =?us-ascii?Q?TZfBXtTjSjbYtdqogIzVgJfvOdvNNUq+WCfVqSvSvRtJWO+UKudmerdMeaJ0?=
 =?us-ascii?Q?RnGvRUpUUPQYvZlt5w9BA6WlZjZkIthRqWbGmS2RXaqnN+pdA/Gjc40ahkLE?=
 =?us-ascii?Q?3vWS9gV1OQ+SEBrGHQK76Hk2A4xrmB9caG3xYhJ9sVVc1RD4NJ0AdjQ6rURN?=
 =?us-ascii?Q?aQIVHVEa1QHsrwgCa92+9GkGdY8L1y3kBdiUVFqPeAr4TJxZIQR7KKwVcM6c?=
 =?us-ascii?Q?OpN4hV3r/VSnY7F5exQZAXOnhExC5eZEYdypRZjKsQQspmBnXzCfJMdoJe6j?=
 =?us-ascii?Q?yFJQLr4BLplCNxSOktShS1pz3XfbHBLAIBF3t07gG1V7KljAijpgLH0vVj9/?=
 =?us-ascii?Q?ZfBRdIPiUj1bzUq/2xLIcCiX/vdHgQDx4myuBbWFoEfIriM05rSkao4ZZekL?=
 =?us-ascii?Q?W0M646mfeLjI3cblP3l/9WDLONBhbFjQHgz+GuCijItRr4espM4aK2E97z1v?=
 =?us-ascii?Q?s0Yh6AoqkdzlIMUAfj2DBPR8Xvmo3j9SrhbjVcqQzR2xaQ42kU3MY4WCVskf?=
 =?us-ascii?Q?xTiJRQw0U7EkLy2ehwmILFitYC8lMzoeNOKUmcnfA0O3iGCVQyTIK6rfMIoJ?=
 =?us-ascii?Q?5JpxKFHr1l/XtLr2Bw0+y4Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205fce94-c872-443d-886b-08dc8f30ce0d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:51:35.9020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw35DyKlFrc0H/XY4p+5cAbXzS6yY5Kn/1v4Oe1Pkt4OBKmRBKTrrg9PNVPjDc9A66MjNBc8M1/5ZQrAp9MtcdSA+8rIgjvOuMnbHYHvRDRMuIRATgqtQCyJ3/N+yXIV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8410

Add support for tertiary match group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index f2349d23df57..c932d9d355cf 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -174,9 +174,8 @@
 #define CMN_CONFIG_WP_COMBINE		GENMASK_ULL(30, 27)
 #define CMN_CONFIG_WP_DEV_SEL		GENMASK_ULL(50, 48)
 #define CMN_CONFIG_WP_CHN_SEL		GENMASK_ULL(55, 51)
-/* Note that we don't yet support the tertiary match group on newer IPs */
-#define CMN_CONFIG_WP_GRP		BIT_ULL(56)
-#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(57)
+#define CMN_CONFIG_WP_GRP		GENMASK_ULL(57, 56)
+#define CMN_CONFIG_WP_EXCLUSIVE		BIT_ULL(58)
 #define CMN_CONFIG1_WP_VAL		GENMASK_ULL(63, 0)
 #define CMN_CONFIG2_WP_MASK		GENMASK_ULL(63, 0)
 
@@ -1384,7 +1383,7 @@ static void arm_cmn_claim_wp_idx(struct arm_cmn_dtm *dtm,
 	arm_cmn_set_wp_idx(hw->wp_idx, pos, wp_idx - CMN_EVENT_EVENTID(event));
 }
 
-static u32 arm_cmn_wp_config(struct perf_event *event)
+static u32 arm_cmn_wp_config(struct perf_event *event, int wp_idx)
 {
 	u32 config;
 	u32 dev = CMN_EVENT_WP_DEV_SEL(event);
@@ -1394,6 +1393,10 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
 	u32 combine = CMN_EVENT_WP_COMBINE(event);
 	bool is_cmn600 = to_cmn(event->pmu)->part == PART_CMN600;
 
+	/* CMN-600 supports only primary and secondary matching groups */
+	if (is_cmn600)
+		grp &= 1;
+
 	config = FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_DEV_SEL, dev) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_CHN_SEL, chn) |
 		 FIELD_PREP(CMN_DTM_WPn_CONFIG_WP_GRP, grp) |
@@ -1401,7 +1404,9 @@ static u32 arm_cmn_wp_config(struct perf_event *event)
 	if (exc)
 		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_EXCLUSIVE :
 				      CMN_DTM_WPn_CONFIG_WP_EXCLUSIVE;
-	if (combine && !grp)
+
+	/*  wp_combine is available only on WP0 and WP2 */
+	if (combine && !(wp_idx & 0x1))
 		config |= is_cmn600 ? CMN600_WPn_CONFIG_WP_COMBINE :
 				      CMN_DTM_WPn_CONFIG_WP_COMBINE;
 	return config;
@@ -1898,12 +1903,14 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 			input_sel = CMN__PMEVCNT0_INPUT_SEL_XP + dtm_idx;
 		} else if (type == CMN_TYPE_WP) {
 			int tmp, wp_idx;
-			u32 cfg = arm_cmn_wp_config(event);
+			u32 cfg;
 
 			wp_idx = arm_cmn_find_free_wp_idx(dtm, event);
 			if (wp_idx < 0)
 				goto free_dtms;
 
+			cfg = arm_cmn_wp_config(event, wp_idx);
+
 			tmp = dtm->wp_event[wp_idx ^ 1];
 			if (tmp >= 0 && CMN_EVENT_WP_COMBINE(event) !=
 					CMN_EVENT_WP_COMBINE(cmn->dtc[d].counters[tmp]))
-- 
2.40.1


