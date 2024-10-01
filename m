Return-Path: <linux-kernel+bounces-345341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB298B4F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19DC1C235C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFE1BC062;
	Tue,  1 Oct 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="V5dF3Spw"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020129.outbound.protection.outlook.com [52.101.61.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42221BBBCA
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727765721; cv=fail; b=BMPLEbySDsquMVqa8+ycBRLzAvfgbL8D2BERkR4aZPDJeOJsRWiBbkJU78u01XvYvJh9FPLW6ovVBIHihZDaKi/gs7OXxZ0E4XAKugdPNCqdfYOz5R0szyCxLEQtqB1vOIbXjfEmHzlOe3giEghZdDAc3N+nJ6vDGEuZMoDRUis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727765721; c=relaxed/simple;
	bh=k21VFBf8pJlezWAfAZQntNiW88B1Xdynylugwztp84k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VZQdqF7ScGx7dk0ObGuTg5nOeilh/vjlrFbzIr055MhREkzpTRoyU4j+L3vrJ4vWnE6VB2qeYQJlTB5wl5KU0ZjQVYU5eTzGULXTKKgJ6FEhRjBaPNbHrYnAVU7jYYYFXNv25ODRh7/mtfxH3r59uiwPnYRo17sQB/Dmj4SVrXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=V5dF3Spw; arc=fail smtp.client-ip=52.101.61.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nq6FWur00OqU2yE0bZXW0AOKAC0jX9vJsJ8ysSjBeM7cal0T84xfBs8xjpFm1yl1KIwVha9QBvQg7IQgAdva/JBoYnoUpAA2goDvj/7hMLnuF+Ti2jb0fTfUtmjWZ/IEtBKjosOm5AF8YLsGKY7T+D5AM9py0F7+CWBSEmthMLWOA6e277NpUrziXnHxl8Qc48tcVwSVXqUfPyoA1evTvjKlV7jbncpd9sObRDYM7KTrt4sFcAL8sgXpEq78HcfFSwVy+QwtEHjZ2IbT72uyhRW/3sbyJyMgC4iQTz4xSCV7HmG5FkiB9O2yRm4HhExSmXt/kFs9lQ9/qvnhoL6aww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8tLrxfKz2Ov8JI2Sz2Pp3rhu3EJH7Gp0ya2q+kuj3w=;
 b=J6RGpK2oww6gjpvuf3rOW1v3x8XPQC7wOG7r1XwgR5N5SCcP8gUjLNYxxQpZdMiNsEkD06CF/7QzsyA2fUixkihDRyUWaHhk19UZFNkMT1/HM/hshfNZkjTmxUit3e/D0eMnGWc8A9WHHnSKmW8i2H8oFsBSAPeEMxWeFVYuVnjBFmtqd3AY5nME+e4XbQOwuYf9MDLKkPLxzVKCvjfb3rsnbF6CBaMRjNzWBa7L5qeX+ggIbhWYXwP9XeYDp2H06Cnbn/VZnlPA7xtbYO93rUYdk/deChjD0JgNux1JkhMws431WpYMLW14S5R/zgfv00y4Gb0r82m2+7v/p6bucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8tLrxfKz2Ov8JI2Sz2Pp3rhu3EJH7Gp0ya2q+kuj3w=;
 b=V5dF3SpwzvQeZ+GcOpzJ/+9CyzRQC8KMDNBcHfCtV37eAUvHjwzsnFU/tMQ4YrvTUz7wgIkMaMHgsm84Zf98Mjv14bE3AaRpzY3stqpaa1tj7mwPvihJMJStNPjuD201ODEtyGCcMIOdbsX20EcUAA0+L1Nn+6QluEKm4gECeLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BY1PR01MB8779.prod.exchangelabs.com (2603:10b6:a03:5b8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Tue, 1 Oct 2024 06:55:16 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%6]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 06:55:16 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com
Cc: patches@amperecomputing.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH] sched/fair: remove the DOUBLE_TICK feature
Date: Tue,  1 Oct 2024 14:54:51 +0800
Message-Id: <20241001065451.10356-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BY1PR01MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6adbcd14-3f34-45a4-fa28-08dce1e60130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PcmPho/K2XOhmeRC+syzBKzVrFq9a1D5p3y0u699hEmEG4nDNdPz9AfdnlbF?=
 =?us-ascii?Q?crKrw2vLmoHscpKYeUZbWCpdLhqzztDgVn6ST6YC9l25FrrH/pn5UQEYfC2L?=
 =?us-ascii?Q?vfsgbtUg0JEbT1qn4HREWX7Q/izeE5flIUc1+cSZfVMvWqU5PN5qa/FNlxFc?=
 =?us-ascii?Q?UUOCKgFSRlO6WGiaTrwjfnk64hlNqb8ZCp1msWz1hZKu8MF96b4BcSR3SNcf?=
 =?us-ascii?Q?uiXZHk7oi8r3jCGQRmggMPPd0wG6PVt1xHsIzUPxfg64vqdvCpkkdaAabKqd?=
 =?us-ascii?Q?4eTsgOENy+MQvqiobU5jnH13MVuECyQyQf5dLZ7bWt7PADGUgoph2aI8m0oU?=
 =?us-ascii?Q?DvEKcOMaGJ5eE9Soabs18geii0UrpMo0aAuJlOeBGV0a4DLdcnNLVl/i25Rd?=
 =?us-ascii?Q?kwMhMGkpne8nq2GvQXPh3FRuVOWlRbdNHuR5F6v/AdVs1NXIMFT8Fjrv1zw4?=
 =?us-ascii?Q?N93EBnYILSYay1VL/ueodYALjSzzE5DQOXghq8mGcUiy/h8+LcGWLHeTyMSB?=
 =?us-ascii?Q?Du5rTax0pboryCoIOMElaD4BB58Wv7yPo4gx4N4CV9fbgwkZDtIbrwTiwsGR?=
 =?us-ascii?Q?/rFbxZNNRVJ5mykV21srY51/LvftnlwzvXwbsm5IJIW7yQyRB+LP9wghJW9g?=
 =?us-ascii?Q?NogpcnyQV6O1su2AFOzw2FWdjKuAJ9vzKO7Ta5RZwT4PVgZEhhqYuMxfP9oK?=
 =?us-ascii?Q?HMxiXAaS+AFgdHAqFGPwwR78VgPLGwfp3bJ+b1348Iu6BGGx1XuvjU7fI51y?=
 =?us-ascii?Q?qy13p6nZe8dHJ12Lr4LgqfojqcLBLnjE5HoQ2b+QXWoDpFa2WrgF55QH4P+M?=
 =?us-ascii?Q?A0szOFyFrYsBkxjDkEEL+vWTl3DMHzTp1qTVreDzHyOYFwCJoo+BvDHmUAJH?=
 =?us-ascii?Q?7wnmnq5vaCA/olXhO4Xbz3YXZ3hEYx7eMBjbO8cuHtQCwXsZ3hzMv4zrb2yC?=
 =?us-ascii?Q?+d6S64x7MozyQWleIVJ8ns6D3Tg55XJwcEoxbI0RLD9C3sx4e8SHr8ZMEPKN?=
 =?us-ascii?Q?cDwafQmMplX+jWMy57tbqUuZQMmLLOA3BXb8XVgh0qtVGbB/6hxwR5vqrQKA?=
 =?us-ascii?Q?iT4ddGlbk4qavyfjTu1XKa/BcddxLqca3t1Kt4pP994tcGlnA8N1ig+tEzDv?=
 =?us-ascii?Q?y3b9lIsqRaatyVkrAJMF6Bf1qd/OxR45Z6GaEdOGV5WFN3leTMfPD4kl1ZtJ?=
 =?us-ascii?Q?hT6X9IcOmi+Yepr00okFqPVJ1Lasci4ezi4Bbv4A0LBszbl1/zxqCuFAlWiP?=
 =?us-ascii?Q?Z046tUKM7p2DEoobVlvSWaKbwcbEV+RYWX8ZemblCs3ID8AkoynHbmt1gRcR?=
 =?us-ascii?Q?fvasio7CSkU/O9z3eH9ebLqwB04BoNyuSgB8KmAyxggjBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Py8Xa1wYgLiTYUQLBfLNuI34Ro5M4U8XeF1OmnFlSO0m6veW1AvyytlRZaT?=
 =?us-ascii?Q?IKkExceNtG0mkZ7K/FlZ94Xrl9ty11zprUSME/Y3Us0xgt76Dt7GhubK+Lb4?=
 =?us-ascii?Q?70FoMtth8kYV+6xjiZ6Nim6KC50Fn64i6ZpWnkSzoqyaTgkseCPw8fiezwK5?=
 =?us-ascii?Q?7TNCRJIVYQY5h5gSvndd9AGBQffWisniLq+quI+3d9byITUIFWHO4OO8+eMi?=
 =?us-ascii?Q?FMvLFBD/NaHhv6K30DsVDjeAXhIqesS5wnl23Z/ng4pqyKxwncVGm3zuPzvH?=
 =?us-ascii?Q?cvtqJv6OP1r/r9b23O5mAoyD+igZWVoa7qE88W8VaR+a3Z3cbzpW2SdVuffN?=
 =?us-ascii?Q?66yLTepTROrw/epfwFGy2H/pmTvnuU8SDRzjg67x6i5AAEtKVp24bQ6U1V5b?=
 =?us-ascii?Q?dpiPMJEzcNhqsLiQ+FDyPZg9GhARUDFlx+tjbyb2blMz/smNbrTYfft/K3jQ?=
 =?us-ascii?Q?Xuf8y+W/cmaxBDh3EplUiJ2tOEgKda3kJgDvMIvQqkPUdVH0M+sTVWl0xUo1?=
 =?us-ascii?Q?iGZcFDkTJfZ3qEDUR1equ+1y6LIWjlPwa5YSkOZxvGkMnu2Xlz7U6DoQdsXH?=
 =?us-ascii?Q?jepvSCwzVuLD0PYA2Fnb0tVK0GgqkhB/hfBTR0DfexmAkL2r+8cnaclB2Nw4?=
 =?us-ascii?Q?OwVpJjlI+2e7kyZYtorUfaUVhWWbZBx+9Br+aAMD+tdOqhZA8MpGfZLpy8Lr?=
 =?us-ascii?Q?BhYLlg4ZF9i29aotJAF4lbpzJrArEr+L8KVI9m7nFwqNpSP7WoDLkxPEKc36?=
 =?us-ascii?Q?m1CP8wxcZ8QOZj2w9YRDcWZVSa3an1yGgZMMsFaYgiWkqg5cnfoRrWgrKoI+?=
 =?us-ascii?Q?YU2CTtnDDjqZ8pciJgwCOKfAzmSeiQRrI7ZLOow+O2I7FT+Vf/ew79mgP+Tl?=
 =?us-ascii?Q?zF6Q+JTs5+8L5QSef3YvCIJ0bGYpH5ljzUAhIJCb/XNqm/Xd3a2qI+GbWHAx?=
 =?us-ascii?Q?K8e74OkUV7VvqMaXAJg+byp07yEzhm3wPgDgU5J77DZ+4TZ7/rhyWfSrjNu3?=
 =?us-ascii?Q?fsSt9t88BvWxxjRFAmwpntJIlPdU4odSFbfB+Hamj6DL2cvVslsmph7liFVk?=
 =?us-ascii?Q?q8CjUL5YY4UCsq84MWqu9XOjN5OnoixQiLGoCpy6MBicm8VzpArMEfEKvggI?=
 =?us-ascii?Q?qA1RIuQClu+/0O/WYS6zAukjpd3BBroWPlX9+rAiutcitf/E4sZjubpmFQXE?=
 =?us-ascii?Q?kqfVvViiEcwEqAxqZmfuwjRo5CnFJk6iJQfRriYicZZ48UKPXawqOPwSU/o7?=
 =?us-ascii?Q?W8tTQo9gImIoT8L6jlr2jONnyNbTWvFK9eycplj3Q/osbDSFXHu78/u0V9sV?=
 =?us-ascii?Q?x0y+kBHmuvMQUNElsVFQQxnXN+BK/7CQDB5IL3z1PyYK6n5iNhydzLoFG7rF?=
 =?us-ascii?Q?93KNpwjqRIsVxuPTscNivbw9KJCs6yoINxvGBu20+OjFBwKbPfXnPfXg01+3?=
 =?us-ascii?Q?zPU9WXtewGYRGx+F+IqXk99wrh3FaUgU3szTZGGCD5XNYkhBtTuv8R1us5L6?=
 =?us-ascii?Q?UlHkEpTHRiCZhZ+Iy2sdDnuXBdKqUfhFHprquUiGnRMIKvt3caF7mXdoDAfQ?=
 =?us-ascii?Q?PM0PDguw39No1QVfdiZY9BYqQjYwu69s86B7ieaLtiAgfYbNOrx5tCTzc/gx?=
 =?us-ascii?Q?JrWvSWPsaXhe4jqtaCguRBQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adbcd14-3f34-45a4-fa28-08dce1e60130
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 06:55:16.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/+1CSZRo83KSR4bWLdrFAYnH11aQzvTmylLLI+2PkisWzT9xpeNmbHYgZpfZ5hcO6817E55/WWzqHrMY97IMXX6S+nd30swGYPABMVmBeoixHO2ZESdG6MWkIGN7a2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8779

The patch "5e963f2bd46 sched/fair: Commit to EEVDF"
removed the code following the DOUBLE_TICK:
	-
	-       if (!sched_feat(EEVDF) && cfs_rq->nr_running > 1)
	-               check_preempt_tick(cfs_rq, curr);

The DOUBLE_TICK feature becomes dead code now, so remove it.

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/sched/fair.c     | 6 ------
 kernel/sched/features.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19afc2253c4d..1812c9cc079d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5680,12 +5680,6 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 		resched_curr(rq_of(cfs_rq));
 		return;
 	}
-	/*
-	 * don't let the period tick interfere with the hrtick preemption
-	 */
-	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-		return;
 #endif
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 0ae351974e49..a3d331dd2d8f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -56,7 +56,6 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
 SCHED_FEAT(HRTICK_DL, false)
-SCHED_FEAT(DOUBLE_TICK, false)
 
 /*
  * Decrement CPU capacity based on time not spent running tasks
-- 
2.40.1


