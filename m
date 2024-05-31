Return-Path: <linux-kernel+bounces-196212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 262DF8D58E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90A0AB24B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8DC1946F;
	Fri, 31 May 2024 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="XgbxUpsL"
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11011004.outbound.protection.outlook.com [52.101.133.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134922595
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717124931; cv=fail; b=ZmydlaclxOK0O/bm8B7VYCPtqHkvcIBO4pwmAe9m+7KrcvLFUbxm9WTDBZIXijDBegneZ3SKLVEuaaMCt3c27VZqIuKGmOM25KV8TBJ6Su1cRQ8oO9d44s05qNAUeXFZyKnYf8Nq5McvDo7TkqQalKTYlFs/RWqiOrrMWtPn9dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717124931; c=relaxed/simple;
	bh=ie15qnxaS91j8K47rn1yBrEzdQyrKpQXI1x8niwGsJY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Bsm8Wjg0qd6ASFgneLQAT3LzfKlqpyKfG//17sLfJ/HaVnuNgsGijAfKLj8ZglyYnGqsuFBSO2FIc7QdgnbGw3E49l7HieTTb5+h08hGLhwy4X1EBqtabfFeAmm6IAj+KL6dhKcTaR6q2cADlcJ3qMsfEL3/nhYviS6UNrxYuj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=XgbxUpsL; arc=fail smtp.client-ip=52.101.133.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkFq4Ab0LjfdLunq69NTDZzKEsTvu4Pne0DyJbb9DIXwIMyWyc8g3CnVp4MmQLw3Q1RNq1c3/ojqb5AzzPGHzNxHYVx1A3arElijfXd+UHSzxiSfZvXlelcQlolymPoTx7jyM79gUzHJnqRP0fARidIYrKVtSYdYHbsdiZ1Wisj0VfaL41VietitxXEOk5khqUKMcVoYWXMbgh/qdDxNZ9TxqojwADCG8eadFD8G/47C/qu0IPJ8vDsj5jU3C+IIoMj2uLD5o6/u2iRE6AMll7Er2wcDbj6H/RiE7fT6PthAF6uTn+L9QKUrUOcDx62FisOYXVHWMGvsdmdTjcPM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZhMltMTHaGMm3EdVE1ll/uTu3DSvVh/3OBDnT8q6YA=;
 b=S6ThLr5VKOAs8Rs6clA/cDwet0Ueqr+i7SwYxQn1EZWM4Imic1tYQKoJeikjnEMpuJeugJLbbrmLkUU9iB943R86/8yxXyQDYfDT94ZgQ3ffGAt9by8ztdXGyezT3zYkUxJOXjUjGW28DV8ZPw7hP29sIEmEXRS4Bq/q7Ogx9syybyzdSFONcTmi3Okk/CBrZNqSluc9LlXTCoJtCWk/RVlVeR8dycwIKgkL2hAKgn5ldlsNuv+6EVOFuEFnf48gA7Bu+VKk+v5/OO765lsuc3oyi1Y0ZmulYtSJvge3hWh2E163dcKgGT1hdMALN3WG+MYrAV5QbX/98O35br5Hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZhMltMTHaGMm3EdVE1ll/uTu3DSvVh/3OBDnT8q6YA=;
 b=XgbxUpsLUci2WOc2oEMHU0baM2P3sq5C5lGULA+2IOwPoYl0naxrb+DXBimRo4G6VCs+z5Tgn/0u2R3oI5VLdQ8CBOKjKcnyRaQ8yik6fg45gpByM+aLAmay9hv3k8k+RA971kJyQ+iA+R53QDZF6Lv8AnQ2VFvDaUqEEfoa0IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by TYSPR02MB7555.apcprd02.prod.outlook.com (2603:1096:405:33::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.27; Fri, 31 May
 2024 03:08:45 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 03:08:45 +0000
From: pugaowei <pugaowei@oppo.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	pugaowei <pugaowei@oppo.com>
Subject: [PATCH] sched/fair: updates weight of cfs_rq before update_cfs_group() in enqueue_entity()
Date: Fri, 31 May 2024 11:08:33 +0800
Message-Id: <20240531030833.3375-1-pugaowei@oppo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0047.apcprd06.prod.outlook.com
 (2603:1096:404:2e::35) To SEYPR02MB8152.apcprd02.prod.outlook.com
 (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|TYSPR02MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: ca57c3b6-3e18-4c0d-b02a-08dc811efbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|7416005|921011|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V+wQbDRzi7S4C0croY3o5qY+Shi4ZU5On0w8BTnGxXo0i3OYoQDsRvAnynvw?=
 =?us-ascii?Q?rtZL7FsfEnl6Em9Yc6oK9v5IWd0OKN/SmH8WOdGCty2/aqS993ufcLUFY1Xk?=
 =?us-ascii?Q?hlx+HbHvKdo1/fzqEsUaAlwlvg5AO+Eq3AlGUUGC9owLYYKqdoT0ytWCbf7s?=
 =?us-ascii?Q?YvKSc4Lv9dNvsltSoDPgCT6XdQSF81LgyLQjeQirwI9AJjYZNqRqH+glp57u?=
 =?us-ascii?Q?Jgxrb2gi29E3TnD9fLtL6eOMRqcMjv91hNxacB9qxhOSWXYzVFOrWKnE1HD0?=
 =?us-ascii?Q?Vh7adRasjA+4GDuO++hCb8IrMNRip3Z1a49m2OLsbrd03mkbvVz9mmQgW7FA?=
 =?us-ascii?Q?H5Dd2ujOeWpgnYwYl0bA0Z2SbTOgGKY+wIasu5JJ2ZnqVLr0b5QPsuI1z15t?=
 =?us-ascii?Q?chYs2tlJ2OL5G1XuHWAWMli/YDpLg3Juol/O9xEHIqXVu6wdbbVxdhPp4P/I?=
 =?us-ascii?Q?1eL5KLMFGJdPdzHka1VQBkhSad9nkxAntjG1xwT1EJQBS50/sRztTCVzwvWW?=
 =?us-ascii?Q?zaEHrLcq6yg7zXJbwM3DyvjJOMlkAgMgXQqMJyvY0uT/huxjC1/mfQ7yJ5ZK?=
 =?us-ascii?Q?ap6SAsLescaPkaOF8cYWTfNk6zsJUdl6jTtOEDPQhNPcaGVQxzUnirIA1kVn?=
 =?us-ascii?Q?F7VZqzVEYVaLOTMokb6GtTM3AGo7qqbVZtwkiiV1XAvvuuxGtd/0lYQ6pkuq?=
 =?us-ascii?Q?6NgBEJv6UMlDOR6+WYhSqAfpDdZryiR+TPPBrN+vFo7E+nN10hyt8r534ns0?=
 =?us-ascii?Q?fFng09z2zUl4KIIk+gTcHdPHnAqtrxxlUln4kvaXg4n/3iHkzuXKnWzcDXUa?=
 =?us-ascii?Q?H2HvtRu6fwxBLpTLpXE3YCLiX/KVRL6wqhkJxE/5j6D93Gva9IiCTXYLB3Bb?=
 =?us-ascii?Q?9VzBX4ZAnJj7eFLsGOGJYoCQJUIyJ44C/jscOHA806McykEQWamnXHyrbr32?=
 =?us-ascii?Q?VqhPY6KZNrrsYYJJYMEYEDEoXHOf4vjf2qJ72/whAbjCjwc9cu8Zg8lwFJ/4?=
 =?us-ascii?Q?B6czZRgrnshvNLzcmGOc5z9Q/kvI5e0u6+UGTREoNrfl55jZY6/fUDV62Rel?=
 =?us-ascii?Q?ENfnNnbcDWg9nRjwvLuCHFQbHkUBwpZ+x3Bgme3QqTrKaQDrGGfmudqRck2T?=
 =?us-ascii?Q?f9TvRJ43wJndFpdxowkspDVYcXbOkptW51wdr+Azx2pnZUjCuM4C+cuC1aia?=
 =?us-ascii?Q?qvOW0k4aTtIdw9t5NxpotSV8iveXy99rbFAZcB5zAiIFYk6Y0fNn6ELkbs7n?=
 =?us-ascii?Q?DhNndBoTLjjPzZDW8AFeqOjq5ia9V5J7RHd/F6KGlW377bOZNr7PK4NiT7OD?=
 =?us-ascii?Q?3iYVMi1rt4dQ4vhJXPNMDeKNx4bzNmGG1cvY1zTL6DFJH9PedxQW59y2aRrH?=
 =?us-ascii?Q?+0c0SJU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yFAfc70fF2VnWnipSWmp9jP6BIF3lXUSIGym6JgnT7H7KVGDljBnpyywFhiQ?=
 =?us-ascii?Q?3JCkaCIVxVzD86g3qDCQnBXDP8r2rhfUmuc3vsxDV8XFwviJynviNf6xe+NX?=
 =?us-ascii?Q?0kB5Yyhz8iWE6M80gDV7/Uxg1N1F5vc2lKzh4N6YuBMwctBGZ3xyGi0f0wHs?=
 =?us-ascii?Q?P0zi+uVHg4q2UUlFKc4Fmf3y5pc6HFo7w9kvfsO5xpDNDQHY3RE+sfGNVSjs?=
 =?us-ascii?Q?Qcd0ZxNgkANGpoQWbmPDjEdedojOWxoLcheUx7dancbXVk89K1+Z5nFkxeY2?=
 =?us-ascii?Q?wsXtr4ijo3ZkuVEX4queNqVaZXxMCYLxVF6LgdmzOSmwfRRETzn0NhduEdGq?=
 =?us-ascii?Q?MYT8rXZlMrs19DpMUnRYyTEPW4CswXx4hLWJJPiGhXM7QVVzfW7tq/TqTK+k?=
 =?us-ascii?Q?i2UQJDYIgLfmebjCZEuzw3F/nJ10Qp9JQ5q794fiCKQjX9t1nPH6V62dvrfF?=
 =?us-ascii?Q?oOzVA3PKUuo2gqr9mvvDPDNLLzUDyDJj4YuM2lIJBCVPDA1BydCA2DGYAtfq?=
 =?us-ascii?Q?ubCPTFCx3zx61BHvUkmnRyaHC465NXXOe5B4wBNi1scJ72Gkl25qssr9kJRa?=
 =?us-ascii?Q?18cm04dH+Ya/Cmu8jAh8GXLBUPP7uvrFFwRUQboZo6sVMxcRCNR9C/Wtv7vP?=
 =?us-ascii?Q?11vb9q6bgJT9t/9ckVLZzQF7WD05Pf+Tt4Ks6Fa4v9GS5oq8bW46wnufdzRQ?=
 =?us-ascii?Q?otmt9TullrYObGWsMqie5X6xKJhF9o3uRhQYHp8RrYoXqLU1n6vDNLgiYIu0?=
 =?us-ascii?Q?LzudpIJV5WpaP/z6G4NUZoaXtyyL0AfrO5FR/v0Ts0CWyNzHHGrIn7TjHfwP?=
 =?us-ascii?Q?roxmEJjdCVimGu1V7H7Sk1JTRl/157whtRxdEGsYY25DDLNEaVfQoFbu6b9+?=
 =?us-ascii?Q?dyFPtMV5uOjdRH3fOkv3ArqtgULAlT2TJ1ebwHeNucInYTfnEr+H3vlSlRGu?=
 =?us-ascii?Q?nr0mh1vBU0q7a7eOQ6FROqEi+qF3Lc/ZdtK/k3tTle02R0BXpVAARv/0Z1k/?=
 =?us-ascii?Q?3SMwunpaTwfZO1GjNlfJQQ7hFSHd0zmnMSmO6dGQjo2g6LxAMAYYsHkFqw1N?=
 =?us-ascii?Q?azc6+PeF8b0Lm+oexRV6hU2mgno451ytH5HifW1DXmV1MtxF+RDVZjl+aRKZ?=
 =?us-ascii?Q?OKgBWRouMxOXHIeejFqgH8bjRN51RPWtkcnyjvL2YNNGVjlOt9wbySTlr0qw?=
 =?us-ascii?Q?Xs1+3z4P/d8PME4uUmSZoJUiB0fqNQ6Jsw/y7zxUmVY2POpaj0HGvAxfCZt0?=
 =?us-ascii?Q?ykHvfV7pBmHTxDqfvI7HP46Uv2KZf0NhH0JL/h5bUJBAMJ7/dU86eWIMpZag?=
 =?us-ascii?Q?DPiQX4Kfnstr062nDBONVfoBufMbLCghps7UYqzBL98Pyy9sTsNdC3pI7jvQ?=
 =?us-ascii?Q?vf8APm7vimlvwcOSHe8vmZWefWc+6fZe2zm7P2HQhMbEvKmrj9G1njg4x2YX?=
 =?us-ascii?Q?q2c/EkemhAmh9A+BvZLHUILumDo/rhK9W0Bo35eoKH6+hVelDCKX03ZaNZwt?=
 =?us-ascii?Q?R23CrlOfPtkZLlSZzNmCuZauDDIMQ51hjjRqhYsTdnqcuaJ/+G48BZHtxmIu?=
 =?us-ascii?Q?CMMTh+7l5tv1T8hgz5Qw7VIYGh46tG3wOZsmHOIB?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca57c3b6-3e18-4c0d-b02a-08dc811efbbe
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 03:08:45.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3XSbZ42lN/ixni3L8wJUu0yslmQkJi5xPuWRwD+T5eOKvdcWjCvEHqbLp7fIPjdCUQ0VOJVb0Qo8J3iyaJfvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR02MB7555

we should update the weight of cfs_rq before update_cfs_group().
Ensure that we can get accurate shares of the cfs_rq when its
weights changes. we can find this work was done correctly in
dequeue_entity(). so fix it.

Signed-off-by: pugaowei <pugaowei@oppo.com>
---
 kernel/sched/fair.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..395840f3fa1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5304,6 +5304,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
+
+	/*
+	 * we should update the weight of cfs_rq before update_cfs_group.
+	 * Ensure we can get accurate shares of the cfs_rq when its weights changes.
+	 */
+	account_entity_enqueue(cfs_rq, se);
 	/*
 	 * XXX update_load_avg() above will have attached us to the pelt sum;
 	 * but update_cfs_group() here will re-adjust the weight and have to
@@ -5318,8 +5324,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if (!curr)
 		place_entity(cfs_rq, se, flags);
 
-	account_entity_enqueue(cfs_rq, se);
-
 	/* Entity has migrated, no longer consider this task hot */
 	if (flags & ENQUEUE_MIGRATED)
 		se->exec_start = 0;
-- 
2.17.1


