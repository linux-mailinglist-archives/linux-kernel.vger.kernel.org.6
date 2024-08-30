Return-Path: <linux-kernel+bounces-307908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE579654E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AECB2195C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0054278;
	Fri, 30 Aug 2024 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="FlNRl3DI"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2077.outbound.protection.outlook.com [40.107.255.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F82C18C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982975; cv=fail; b=op2KJ4/DQBkxSaNPyzd2sxTuqIWabLvnaHlMivolXe6F2nCDS/yW41EJ96DkQTO+Iu/nJ+gGFyUQ1fmWThUzKJiBAMaEfWXMuZtu8h99rbL75Xfo1XGwwFwTVQLSmh6UH08KyGKu3/HxDo0H5Uqs/PwOxWO3nO3eJivvg7n6Rjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982975; c=relaxed/simple;
	bh=kaoqFroT7/7RbMQHczKHSBGoiRgd633hKJYrFE1oD1c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=R+z9ZRzTv+i796vVOo3O58KqkmD0CIPOQCBM7x/DtMItYIMcXz4Shhn4dg+FzShIePCdA57KEFjZRHtUS1a3Z3TwadhJ394VZX9Qm2oJIKeIDfc/rjAABor0QeLvvRXR5hvubfpCCRBdTSW/JnZwGk7J5Clr3BV/mJ2STw/jnHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=FlNRl3DI; arc=fail smtp.client-ip=40.107.255.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDBI6pWZ8JyB1tORxpauL/hBoAWVKwQL8zxqtaSmX+NYpD6bYLDElr1CWcYHSSy8n7h8wkOI+jVcwiw/yLloUms5LzHNRh9N7WMDfXJz8zvIT5pzufZws4MTFIZhsLv1aHvfDGqCu4GrJCyL4mCiX92GzgcNsXvp023yhyXE00CiHNeMAkrCdU0tr/l6t7dlFRlEbIIGnjF24d+GwPyilluV4Ru+yqhdGvYc4Bnv9s2Cficu+P/T+8xqWr5kyABbMfyX8PRwd0wB0EKqcVoQZjistm8nSNpd9Srf/CYTZUhjK9wC0G93aVhYKn7uLL/QSiZbjwmh16B+wKpQymIQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A938eLbs2JAvF8oBcT/e6QveOcR6JYxggodUcdLOpeA=;
 b=v+5qDRsIJdXD+3C8mdZZMC0iAL0iqeQgcvUHNjmB79VMBgWTtfAe0PX/2Nz0ijXaXi4pAjTaCMhbcz5DisdqLW0wjJRrLrEdH4tvglqgFROvuePAzwzav1vpdLkqiffRMH8VGJ+LSsii6o7Ylr9uh4NoL81T541zu1iauzWEG2w8yxH5xEI3duSrVf90j+AFfyREQzUr1MTCL4nIxJSvgRiK1a6fvVWUWIS778gNXodJIoCBhFLv4QR71IaG8KRKy8KWSUJW5cnD/6aQ1rrJHv70phIsM6R/PhyghTTCPkUMamIC6mhj2U2dviu1aqFSRIfxaQSAqkdRqLlH1WOfFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A938eLbs2JAvF8oBcT/e6QveOcR6JYxggodUcdLOpeA=;
 b=FlNRl3DIA/PJpCBQE0724lAb9z0QOxLNRiCqlS2HBIQ/tmtZhIVaGJNlrLwXLAzy7qzvmOmu1AL9dxULC1/JLq/6psAwwsInstK7L6Y20yQzeX2PvBSbMZqzsxQU818udXlvaw/WmKvE0fWnhRGDqsoJ7kaozXHLzMN/3o1HRb53ybfTEFe8VSdFE/RdErOmWwmiLClG/nh874AYMa1hc6cplxt3jsZdX/Nwj85QOSxiNFRYUbhbOSLRqAdlmuNoicalY5FOuDpDdMvPARYAnl581IuQBwXfaEi2mh8NZF+f84WBos3Bg39iqMbMGcfScOX4XgahFmshkgTkG5keCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14) by SEZPR06MB5716.apcprd06.prod.outlook.com
 (2603:1096:101:ae::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 01:56:09 +0000
Received: from KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f]) by KL1PR0601MB5487.apcprd06.prod.outlook.com
 ([fe80::2129:59e5:6c67:311f%7]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 01:56:09 +0000
From: Chen Yufan <chenyufan@vivo.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Chen Yufan <chenyufan@vivo.com>
Subject: [PATCH v3] timekeeping: Use time_after() in timekeeping_check_update()
Date: Fri, 30 Aug 2024 09:54:59 +0800
Message-Id: <20240830015459.2937-1-chenyufan@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0211.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::14) To KL1PR0601MB5487.apcprd06.prod.outlook.com
 (2603:1096:820:bf::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5487:EE_|SEZPR06MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: 9563bdd6-cfa9-41f5-3645-08dcc896eb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tbjplPkUNYNfKYKRSvvb4SYqHz1UbaPyLN3vcAlTyEMS3NbqN6KzH1jPF/oS?=
 =?us-ascii?Q?hAjPJWaSPt69TTC10Xp5a1u/3tmT0+19ahqRnMsgcDu/V5b/3Y9YSismybGT?=
 =?us-ascii?Q?VbEAqOmC2hmffAQ90hJrImSIjoA5C0j3QcSxdimw00T5YFM3XMfo+3w/Z2GY?=
 =?us-ascii?Q?cvgasP3a+UEj6HhxolVlww/rjB1bzu07zAnjrRp8oJ7quicXb/jn7OhnQIoo?=
 =?us-ascii?Q?DGafO+CcMZ9dPcF1hCQ2l1DLkxWCW5bEhbaRDtBSecOW5PVDzTvRvvX3CuLw?=
 =?us-ascii?Q?/R/W9wfMRehO4melmjhtHfoCYcalrSs2FbsjyaUigGZCANEdr/ZEEt5WqciM?=
 =?us-ascii?Q?klHzvxOlJpXCwDQUjePRL78vfD3BbFOLGR13TO4FVTxanFk0YtdotwVThI0z?=
 =?us-ascii?Q?PSTEDGHWBudAcOjDe1DfY2yqcRI5wooN5lX5I0dITOn5ZyAlCS0v1bax7Pgd?=
 =?us-ascii?Q?/J9hYMNCkuxwmGH2e8c9NsY2C2qZ8hi+758taT3jlweQapoLM7hyBb6y+hq0?=
 =?us-ascii?Q?+Q3HfU38Fz71KB2Z/WTqB9ky84r3hLGaoYMb+Sfx7durU9BAz+GJeuP8hXJY?=
 =?us-ascii?Q?MXXwMQ7GauQAUfR16ORV0MT7NBym/TeqSUj3srEK/YFTFNYTjsDJM29JgUa0?=
 =?us-ascii?Q?Wbd1HKVXmnJaX/rg7gNG3Xk+MQ9O+Qcq5m8JbvBf/YIXy+tMa+0wsXMjo6nw?=
 =?us-ascii?Q?Hstli4bxKuV/IQuvp1nHad5IfvJdfddhy5yCDFzUujayZeT1qulbqtYTzaKy?=
 =?us-ascii?Q?pngfYUJZooXvxDmJCQLNlaA2DJ9NDb3LkBGuFXzgVpMD2IdinFtlJgs8Ccd4?=
 =?us-ascii?Q?j5hqs4uD86WwTWQxPSVEze7+llqAcv+5fSVcMYYjn2oLS7ZziO/XHsIPRrLx?=
 =?us-ascii?Q?s5tHFklDoeoWiEjEqHZOOi4Ioxg8+njuk1kDgh9wkp7VuoaACh6InPy1bNMi?=
 =?us-ascii?Q?MLSEenvZGY1aSJxv0Ghk+H/NAkV+VsBvrLuAe19RJvLq0zOWCqWoay7nRnDu?=
 =?us-ascii?Q?OmY2+FGo+4BxlYZJ8yQBLPye4ab849MA5h1dRdAvwyIXX9L0eIjelQjwwlHm?=
 =?us-ascii?Q?IVwoPhLoprei2o1GUFOGfWgynMisTznDaTxltsp7Doh6cJhkyrbqpcH+pbZZ?=
 =?us-ascii?Q?QA92K9PEcAUYGhqk+KCWxx0zJPRclh+MT8vsYv41Pbr6dG8mYZtSBVi9Fb1L?=
 =?us-ascii?Q?vtyHIUTTNeavsHXQukpoGZK1bK6NpIYYimiNF8PLSxU1yZiKNv6atHLBjU4u?=
 =?us-ascii?Q?hglNuUOB/p7qE5Wt75/6Kwxj2PFwfxgLsnocW51LPCYNNaX28/1FygCl4KYP?=
 =?us-ascii?Q?KwtNLWq6TXoGHuR36MRNbVlNgMO85lfCezglcDuq5HYoK2a/b3NF63xgxjjL?=
 =?us-ascii?Q?wEnIWzxcChIR+/WE5LeEwUnNb6vRLJ5694cZEPy13abpLT5NGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5487.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xf/QZ9Cmr9KGhoyQ/3bEWmOtYzlgApiZwl5uqpZOzfDzSWYzmIGsnD1j/kYC?=
 =?us-ascii?Q?Vy+nMPLv5TibzGfzGr8WL4I6EsFbGQf3dygRYUEp/q3vyMBwLAZ87SBd2iYU?=
 =?us-ascii?Q?5viOvW9bnDS6YgLvvEMFEeTO8VSJI8dxjE6YNEbcexeNYfvMyQBajJ2Eceek?=
 =?us-ascii?Q?ZBnxqnpmnSiTJDFwGz2ee/3l90MdeKI9kLBVOUJhKRrIJL+OUVT5Gvd+jGPc?=
 =?us-ascii?Q?uSCDD/37OUgHzevO3kThqOfTvNKfpaVpHZSi6+CLAtGjWWpi6BS2MnewqUGc?=
 =?us-ascii?Q?LI8qPLpzPrse+0ct3ogSMKlOSCFpEFy+kBjKl/EAXSRvtfBlcU1k6UiHSKkI?=
 =?us-ascii?Q?74k88qkQDbc9/NFluQfMy3UpTNrWOEdfymDgCiZ1SIofpvYOGvWEDJSe0vk2?=
 =?us-ascii?Q?AnQyWQwHg/64jVn0D1OGbBDKUXBHATtfiFbL0A8QLMTSJ0aK+yd4f3isObf2?=
 =?us-ascii?Q?t8akWyjyNy+dVuFB9oHnEtiEzLF4yzPbBKW477cBX6owMl46xgtgQToJt7sY?=
 =?us-ascii?Q?9/nA4BXJfX+qvLoqLs8sM40+lxwu6hLZ3rCXf1BirVsXGSDIq83CMrFxSzfu?=
 =?us-ascii?Q?Tey/ZUtRB3V5pYXwecy5Bh3/Stn+bEsI1CSjkAtpK5ikX19O04Lk3eihMCVt?=
 =?us-ascii?Q?fFJTlYRL03xNAbAj1i6XzpAuTRBttYf4JZRrBuVN0ZlxWoh/+V5uCdNyGo2Q?=
 =?us-ascii?Q?Ja1M+ZmCcitfXild8FBX7BvKBENPD+nrWDDyL46rraFVwcIuiw3To39t3E8M?=
 =?us-ascii?Q?YD697tSBOqtTdtSrEDETGPgj6S2vJKcNFxm7EKRLaPR2TyzE0SHPG3S/7tBs?=
 =?us-ascii?Q?WZHGHl+UPnePBvpLYvurYqPUFWhoM6fkUwPcCAV8uzYFzpmTMIshfjMxBUfo?=
 =?us-ascii?Q?yyLGGpS0s2MzWf23ytDaznup7qAK31TXaGNftRQh8DX9IzFEMwTvVHOsBTDV?=
 =?us-ascii?Q?uIV5geMNCpzlZFF9aADF1ZRdW1VcRAXrHL9n6P/dTT5EwP+RFI9dehyvkvMG?=
 =?us-ascii?Q?vsIjH5p4SXm13xdrpDAKha5mZlDfLajkkOBSfsZinwF+ZXayIlO35khDULbx?=
 =?us-ascii?Q?uKnCJPBSRUW3cWs8o4Z0hbv6dOT0nvxilhQobX4wYCebRVd/pj7jxesW7bth?=
 =?us-ascii?Q?CdKAgVNHF2CrcTGo6shJfD+7JBxYfDOP7R0BlN/efgIHi7APuN2t+iUD1zq1?=
 =?us-ascii?Q?qvBvTEVF5pSgQydLHd7WQPUUibUGvXJyvBnHTRhH2Cj8UKkfYT6ZzvIqiMH5?=
 =?us-ascii?Q?nWy878eHRWZ2V5O0QsK4zCgGq+Ik2cV3hiTy3K03FMkcGkH2ICRkue8jFrTt?=
 =?us-ascii?Q?zQvTHaU6YX3/K24MDF0vEi9Quyk3j98/LAaxNClEwndNNFGB1rmsPH+AY4QF?=
 =?us-ascii?Q?I30KQkBsnhfbjq4n30QFOMaA9oH4T1yrCZfDFM6gyqLkmszU71ZmnsqONHp7?=
 =?us-ascii?Q?VUdGo0kYi+Rjh0dUa5cAvEZuf/56caaZNYje5PZPD3l81wcwy/gtzShxmn3l?=
 =?us-ascii?Q?pZErHbYelM7CLdvfspAs+iV1rG9MnPej4xTz2QqOK6Sm/XSc/S/bWvChQkTD?=
 =?us-ascii?Q?YPeYKG3GV6WP9Tsrg7X9E01vrp4yRj8YsosWZ9+y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9563bdd6-cfa9-41f5-3645-08dcc896eb26
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5487.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:56:09.7077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXvzb+EX0/dSaqL64pDyc0ks+9GoeKGQZHrxEdfMTHSqNtfaQz43UBfOVjCBEIbwYmPrJwa5bIjkaZMATiEltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5716

Use time_after because the open coded comparison 
does not handle wrap arounds correctly.

Signed-off-by: Chen Yufan <chenyufan@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. change the type of timekeeper::last_warning to
unsigned long because time_after() requires its
parameters to be unsigned long.
---
 include/linux/timekeeper_internal.h | 2 +-
 kernel/time/timekeeping.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 84ff2844df2a..928a9258b7dd 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -125,7 +125,7 @@ struct timekeeper {
 	/* Flag used to avoid updating NTP twice with same second */
 	u32			skip_second_overflow;
 #ifdef CONFIG_DEBUG_TIMEKEEPING
-	long			last_warning;
+	unsigned long			last_warning;
 	/*
 	 * These simple flag variables are managed
 	 * without locks, which is racy, but they are
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..6cda65dbe18f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -217,7 +217,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
@@ -227,7 +227,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 
 	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
+		if (time_after(jiffies, tk->last_warning + WARNING_FREQ)) {
 			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
 			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
 			printk_deferred("         Your kernel is probably still fine.\n");
-- 
2.39.0


