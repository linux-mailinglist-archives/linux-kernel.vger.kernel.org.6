Return-Path: <linux-kernel+bounces-287462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDD0952809
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA621F21F72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C022208B0;
	Thu, 15 Aug 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uPxCf3H6"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2104.outbound.protection.outlook.com [40.92.63.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2261CA9C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690710; cv=fail; b=W7BR3WSIZS/8zRKyv2jTmSp7VXm3jjFa+Rr66yXOesD7f9uhLiAS+iWV3UgO3elniR0m1HepCvgBqCu5YqYbMaiYZgkXbX3j/n0UlyJkJwd3U3shsFLITkIyI2n8YwjpNj1oUbs9QNlYbUW6ZstPuvnh+i4oAvzKTFNUtWDCeU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690710; c=relaxed/simple;
	bh=N0FjUtSYsqMYnXnNsmZcWSM0H2CKVCCLtvCAUxIln4M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VBRHNgtlrzcMLwSLGqRLc4w5hQVrHQFQknsH6wsZ7XdDRWPTnuF7LmsTVLEvydlWToPHMtT4GGW8EuCnwvRXicjPZr9YejK8BnZU2hQPi8rs+uWAmfzCuRnApjyFJaOSkRkkR63VDmXtxSKOUvZh3nV18J6poSKLTqFqrI2wOCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uPxCf3H6; arc=fail smtp.client-ip=40.92.63.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KApIGQ3s/+zdzU1o10XZHkHrV99Gcen74IAx4jmYlokth0F4XDyIxEBJnkK6A+CCH7rHdkgn4gUoj+YCJy1/TSsLrglHfbhWXNK5MXlOd8K0lpguxQlakKeeRoeQT6ifgbczj4IH74R6gz49pBwbE2f0zBPDZYvsMpw4ebFiEoiCZWIhtxXnQtFbvfe2f9Vcv27xdTumEWrmQrz3dL9avl8XfGl5R8p15KPBmtECbwprI3/92PCcfHWzNXF2z/Ehe0rnci5RpbkrkxhFD8eCdScg3RVt6H04qhC3QH9SZQqZiJNhQc81v0q5Sy29CazHmR7tNPdpE/neGw5SXAxz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eubp37KkZ/RAdu+V0tZbFGPTFeI5eY8DvCCo8q93/vo=;
 b=hrIxjoJHQdGLAHs26fnYq9xofMk7z9/nGt6X7G4fMwGkICGI8PV1qAOUWrktpwN5UuBTxr8LDVgrMwxdJC6oAMTdtQYauUNAU+v1CLqgb0Y9wsptpLYImtD4gfOw4pBuABTBlEf2YNEgS0ETLFueeGnlqEVujlqQiwvrqMgq9BPKonIis4tI1wtxV3/9V5uWu61jwxuvNqU8jGPtD+sSITi5BLmZdAMG/iE+HBGCvMZNVu7jNOOBc81Y2vkjYaXi0DfTcgBy9FjDKF/4FCetCwyMHzIqlDR9G1Pc+3ezjUaMKcDWCSGeJuBD5chHoYZr4czcUsvQvNTkyZ4zHU83CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eubp37KkZ/RAdu+V0tZbFGPTFeI5eY8DvCCo8q93/vo=;
 b=uPxCf3H6UgRL56XQG9TEr94q49L2YfAxlZvE92RcxD9o3lgev3oICvKciXhSZIKJCCYYGLAdea8LYbRR1c9M/nJLTA4Zn3sUuSUzn9vLrxFvgLNZrV+2NTZCpmDmA3dj3uwyExtrANzoGtDtA4LzkFOxnXmKyxrUHEbYWAQwwn/M0n6cjhkZCSJy2usdOwvMSelUPIGYbl28HYTXq1ODil6KGnGS+wMmrgzo5a//QErXkQaVtH1Hhtn9tdmZDWnjIAz1oj7eXVV8g3lCLss9frojaqLzvRFVpcw8usYUY4TOew+UNYje4aJfkGSdYQ3ldLfN6pyMZkhKC+Fj4n1sgw==
Received: from ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22d::7)
 by SY8P300MB0550.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 02:58:24 +0000
Received: from ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:dcbd:f696:7ea1]) by ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f32e:dcbd:f696:7ea1%4]) with mapi id 15.20.7849.023; Thu, 15 Aug 2024
 02:58:24 +0000
From: Roland Xu <mu001999@outlook.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Roland Xu <mu001999@outlook.com>
Subject: [PATCH RESEND] Avoid schedule while atomic if meeting the early deadlock.
Date: Thu, 15 Aug 2024 10:58:13 +0800
Message-ID:
 <ME0P300MB063599BEF0743B8FA339C2CECC802@ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [01opBXNGGkcxDf6AnjxEd64DBX+9Z1QXWPpVfv5l8mI=]
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22d::7)
X-Microsoft-Original-Message-ID:
 <20240815025813.2224708-1-mu001999@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0635:EE_|SY8P300MB0550:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1fc358-c982-4c79-b47f-08dcbcd6210e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799003|5072599009|19110799003|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	ilLaYY9P3PL+cb2MSoHPMApvoJ8yv3PRe1SjCGXI+2nRsdSz0k8xVbk+e7O9BX7kahuSQ6tDbZQSPkM14fvUrMWN9WNNmZCH2H90ZkenCily9r8ZxfDXDipe9Vp2qiYQYs2x3H4tiM7qKjsUzv4LtWH2aEs5RIKDWcHogak0EnoNMyslrI6me2lEiRpA3EKmP9wxNiM7Zq/N6TGAX0vF0sh+kaO6aA9qtVXIi9hzp6jfc57OnG++pGTovabNUTd3Ix6HHieSH1ltjU5P/ayW+39JSYs9dNXhFljL+IK1TsAYWFOjXOOiT723Edl6kje7mHBEmPOo2yFOtoiorK/+NQ1eJ3Wm0uKDjFs/SlejPmNWW0nSuk/EpkZjsTzyFicQacQ08rbJ2VkQbnOsufRhXnfq8jGfTlEXcJsfTFvg7gT7GNnZCcm9w1WQsnE1D01FJSxZk6bkIU6XrevyHKtbP0juedz16t7g+YSSuFgoStYuap/oQNR7km90FBWXyzRBsF/Uuf/yh6o5uf998INPXMj9SuQt3QF2f1fjH60q7N+JeQYAaLWq+Kvdm7qveLm9S7/wGbRYbV0OrNVos5Jz4elk7rwb0g5juc7pOZvaqJdNK40/4TndpwVpJ4WW8AoJ5pkiXsXishYVqW0JPpoykEtt/pfKCeT/1qnNeEGvrhA2x6connmGSJGXT24R9F0PMOgqOJ+xRlA0oRNNRZINJdDT4JGSddH6TV238wCBlfk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GmZpLg3Buo5F0vyUO03dir9X7nSLStOe9/MB54VVaQDnThFSWa5YdhnyKY6L?=
 =?us-ascii?Q?G8w1Odgp8DXERxZbImLror2h5x9oTBVQhUfFMLchZhk6BZUEDmP/T1J7QVWf?=
 =?us-ascii?Q?SUJMMBuDZoomTNl8Chw2twsBhblQ3V8UeF4I43O9ZUKpziV+y83fyXqOCEXO?=
 =?us-ascii?Q?sfXmQaFpEvZ2HGKxjLTJ5rpuW7rfZyNBpni1jOblg+2pN9JV3KuyPzmmqmwh?=
 =?us-ascii?Q?dbs8en+UNKMheL1aHBi6YAPsHoDI9I2LOKRqqccwN3x/v0er4w7z3SqlPbRl?=
 =?us-ascii?Q?RMljFXYrqJA0ljM49IPjMWbXOavodwoeMe+KyF5H4cjp37Mng8RhZcm3NXUY?=
 =?us-ascii?Q?hnxiz/eHROSlXh3wXmXOmwai0NqqMbFxqns2h9baQKQDSwYjPanhsnbVeulH?=
 =?us-ascii?Q?H2VajlqGpHnhNdSRgOCbFOlJ+9nWoDsJhRHRWSJi+72ojkTH50Tvt7V9fdr2?=
 =?us-ascii?Q?9KYz5Sx3cliJbiONLv6myjm20t/pIcTrUc3xJoMqfrFWvkUxmLTIIzGJ/8Co?=
 =?us-ascii?Q?KvND4W9BQDP8mPukX602HbxnFRAmyaFCt2HquP24KVn3FDXPn0YALn/EY91q?=
 =?us-ascii?Q?6MVFuaWXGfOWvbm53DipiG6aGoxPMDqPBcOCNnGO1f4QE7rCJ/LE+PA40Ywm?=
 =?us-ascii?Q?YdEtGcdNd59HcLUZ4IN+F48Ch/rXULCQQN0LYtAK3h0QR7z6838vXNqXQmmw?=
 =?us-ascii?Q?YgiqkOcE1fLI5+Jv3uLQBGO9vs/WVN05E3mmFxfeV5b5DUTKeQTVJ73qdd++?=
 =?us-ascii?Q?sJv8ufa4/bp7I2vfr45RXpkggjH7jpg8hyrRy9MwvkbDnZ2anyBJR/ZrSYUs?=
 =?us-ascii?Q?ctJKs2LAMldlWeX9+vnQdybZqxjJU8Gu9kLvRqeQOa+A3Miyi586YRFbo5/n?=
 =?us-ascii?Q?6WwzbSg0XAIh2fg8Q0MZ6ddmKlt/j/+GIJeJuWOXYAAl843q+GopAZUSZR/H?=
 =?us-ascii?Q?xgxWy45l/MlWsUCa2GwTLhzlF7sI/iAcDzbWkH+jegshNyOKrqahW/yRw+by?=
 =?us-ascii?Q?2KlmBTE3KNuarJbqOWuwrhr4KDsrdk7otWIdibcKetRw/WYCdJxVpgDNIjCM?=
 =?us-ascii?Q?lasac0B0FjvXs60GL8IOdVqlZ474ux10JmX0LOGCmk2/LCe/8Kpbl9YmW/JJ?=
 =?us-ascii?Q?UEdiHNaa+XCbcn/Uxnr6QMsbwJKlPzqWEJtLYyAICsuBv9LJUaZ4LABD8PUo?=
 =?us-ascii?Q?IZ5by35p787j1CXbt8YL0/4jeqs75FKZG4cJjBS0t7fi3B4DL7BBQEU5cxw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1fc358-c982-4c79-b47f-08dcbcd6210e
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0635.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 02:58:24.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0550

The wait_lock is held in rt_mutex_handle_deadlock,
so unlock_irq it if rtmutex deadlock is detected.
Otherwise, this would trigger scheduling while atomic.

Signed-off-by: Roland Xu <mu001999@outlook.com>
---
 kernel/locking/rtmutex.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc0..9188bfb63cb6 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1644,6 +1644,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 }
 
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1660,6 +1661,7 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	 * Yell loudly and stop the task right here.
 	 */
 	WARN(1, "rtmutex deadlock detected\n");
+	raw_spin_unlock_irq(&lock->wait_lock);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		rt_mutex_schedule();
@@ -1713,7 +1715,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 	}
 
 	/*
-- 
2.34.1


