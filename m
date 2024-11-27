Return-Path: <linux-kernel+bounces-423047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF99DA1DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEDA1665B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B88146D78;
	Wed, 27 Nov 2024 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TS/fL71F"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021119.outbound.protection.outlook.com [52.101.62.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85978146017
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687013; cv=fail; b=tP4gpps8B/qWWEkT7TvIJbCEsM7Zg8zlHDDNXSCe08XLmnh9tXtbUjqVJ/VGpb2gYjTXBOncgLYasRtBv+A7Ns54jZAKVrS+ES55p1rWb2aDQNXploipTNCioLunZL6t7fhrqfK21KEmY7qQ9twIkZne6UqGYZfScw9qxkGLcC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687013; c=relaxed/simple;
	bh=AQh7ayRd+rLd+o6xkAvvOgUfSbvAYQvgehURYLwyk38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NGJfAWoTsWux97HoaYGmbPS71nQ0B8HLUBi/xGmFFd6YJ4K9cViJhTHHfnlgg/77nsK2angNSXDbAEYqLVTCWDjskqSmF/bjgTQZN5gEXuEXnyLLe9sGrQQAXvbn5Ke5Qa2uNwFLK2DG+CfksIVx692u6MtHDba8IM9bmTUsNAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TS/fL71F; arc=fail smtp.client-ip=52.101.62.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krlzeI8UalL4zdRwxlc/zU1bNk01UyLYo2zaSQoBsub515xuesw4vmSCT3wOCYcah0d/3wyLs7eSahzca+3BNqxibWv24Y/H7EkgHmNu0GOE1fQe03IE/Sdfg/54qd/b7OWiZ6lA0S0cN5DYP8RHM5De8OZ3TEXy7PSQ4eZfE/43rLQUGd6NO1Wvmq72meN9iqzu5hY/wKuXuv9qXu7kETwyNavLUQriZLc/PO7E28qjdzliHdtJd/mQT/2E2JNgeJ7YmVs24XuqlRb2IUAYZYmlxJBww9b82tZJXSdbAA95kZK4INJ4xnknSqxwoVGJL/ECXIyGhpOfi1NjBiKe3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3csQBHyGj9gzV6BdnUErEM3KCIwKP7CDH+oJvZhlbg=;
 b=E90MUXrZ9DjOcwEGFf3Eb1hohw2/Xc0YbmX1NiEL4ldX4FjXAsVUttbmUter9IVGQO4z+/kUl5p678kCplOPmlhhUh9F0qzA2Kd3mEmiuTGY06qzkTiXwkrW+v0maEDXbkElIOU9KgLhZCTvxBTt4+uiNf+mdSuEPagR04lYLqFRvgpOYny30p9lpdlS1tM4Dzwd1NyNpa7+gAwKUI41yhB7I+Vyo+9B7QfqxvSraJ8qdfsyL5e6qwB2rHZKbgZ0AmL9Nb9wR5I03aIwy6yKn8Cexh9Q4a7QQtIwBm18pezcWNbHekxsHRgmgbaFhHBRQwaJF/pomJsZuzH2VS6H0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3csQBHyGj9gzV6BdnUErEM3KCIwKP7CDH+oJvZhlbg=;
 b=TS/fL71FnKEu1OgpsvQLFrf+kvIOdrbgWahAkcgaLcEzGeZhyjacPCongA+wUbn8gGGYjJG4MV3sjDJsIGtOXc6GL5609p5+ZVd4WPd4DcTnIXnnQKeR2CwaWvG+XLezR0iiV1Dbuy6pLGXTDq7/KxnZZEdX1Yldf/O3bVDtTMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6436.prod.exchangelabs.com (2603:10b6:303:64::21) by
 DS1PR01MB9086.prod.exchangelabs.com (2603:10b6:8:221::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Wed, 27 Nov 2024 05:56:49 +0000
Received: from MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970]) by MW4PR01MB6436.prod.exchangelabs.com
 ([fe80::77c9:9e36:e28e:7970%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 05:56:49 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	cl@linux.com,
	christian.loehle@arm.com,
	vineethr@linux.ibm.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH v2 1/3] sched/fair: Fix warning if NEXT_BUDDY enabled
Date: Wed, 27 Nov 2024 05:56:08 +0000
Message-Id: <20241127055610.7076-2-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127055610.7076-1-adamli@os.amperecomputing.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To MW4PR01MB6436.prod.exchangelabs.com
 (2603:10b6:303:64::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6436:EE_|DS1PR01MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 2092b1f6-9dcb-4a21-4ec8-08dd0ea84847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NvUQ8Qe1sOcZnBCW1V8zLNuETk/n9iIfJQn/T/nlX4HQQsNrZm311wy7Jm/A?=
 =?us-ascii?Q?8MgpZSyTdgo5jfRbcJy/6V+ZPM4W6hM9RylP0cGCzsye0zKPekQca33Fz3ox?=
 =?us-ascii?Q?a5dPlusjNsWXNCctisxrhhdgL/v40DkTt+SaF3Rxu+8p+7KAMC0AYR0eM4BQ?=
 =?us-ascii?Q?iKkwY4PxGwsMBGZ3aucKBRcOKN7V79sKX+SPolvXGmCfW7T43Exb1cqRBwsn?=
 =?us-ascii?Q?vg8O9sujUIOi8qJNNLqkmDoEQL1DWqYw0ONqZouvxC8JQjYi9oLM583ouRSg?=
 =?us-ascii?Q?DphMTaIxCr7F5NYvfz1Op7fA9IOcf/+BUbL+/9T5dQC3/Nr9Rk4puqABXDt6?=
 =?us-ascii?Q?4IoBqRZJqR8hCOZxNad5tV97SXp/h+kaca/3C3/WeaKMhErtUMOVLCCVS099?=
 =?us-ascii?Q?NwlTT/YrUfNQqm9fI0BrFrWpLX5llEbu0Hi6YqgI8/nyPjbVxqmLBomOSeqk?=
 =?us-ascii?Q?e/96+fyIDZ73a2skh3L25/r3qSUWQpwe+oN6nTpcR4tE05GP2ldQbX72Kvy/?=
 =?us-ascii?Q?MSNkE7/XxqEGmJeoFtG7NwY4ePWGnyNE04jaoiem3JK6++I2282APWXJsYfI?=
 =?us-ascii?Q?stZQ8U1+u/hRSqKit+4dYapwv+SJyv1SKKL6Z35aI9P0zrzd1pUnWb7Bk89H?=
 =?us-ascii?Q?8mu829h2KbbThJ1ramuyXXvanw99fc7pxogcB7bJhhVCJ+tDRExN739+Xoxp?=
 =?us-ascii?Q?jhee/cIGtSfdSXCYHqKtuKT9FuUoXPnUPtr3xymmA86npJp2MAVw3b4HpkUS?=
 =?us-ascii?Q?oZlbnMkljoul6X1b1t4MNVzCdkCcj5IKwOFr8iY08IFaq2NfjAaAov6Iqdr5?=
 =?us-ascii?Q?OotLeuYIdSNP5qI1/R/4682wVeZwNbNDbjld3J6G6J9psqOU8jDTzqEC9JwB?=
 =?us-ascii?Q?mnFmCROIDy13cwotjm4qIF/DFruBsQJuWiDvpNQ8vheojcEJzsHxEFa3o49q?=
 =?us-ascii?Q?hw0RbscEIDCO30y8wcDNzLPNvpLXqAVq531taF8/WWYOBF1toUGTxm3OFZr+?=
 =?us-ascii?Q?R1OhHmhqGrvPCPSwQAQCcvhL6TzKmnRHuLq11EOj6jbVdIqh+qFbVcG40GUI?=
 =?us-ascii?Q?EEdme99ZvVseDnWY4aEcZqhqOeITg/ZBrnOp4dHae20TpsrFcpF85qSDbyxH?=
 =?us-ascii?Q?3bfEURh8Sob87/NhYUtGuDCwu60Tb4+5+5Ewio0fyTwt5HPJGqgWZqoxWxjh?=
 =?us-ascii?Q?kyAtcgtcEOmcqRiYCu6bMROPduSsRaQfnV1aKVkKMSfwscV6mLac5iuC8OfE?=
 =?us-ascii?Q?arek4x+Ut3gKb0FqLNMPE2X9ZLDDKiZcjD840wHyqXIYBsSeXCX3ASWuPZLq?=
 =?us-ascii?Q?T3kDc50yja5gIpnFVkvZM3v/E+1c+5/5uYJCVbcBaco6rjM2js84Yecp7G+R?=
 =?us-ascii?Q?sT34jDFMzRyTzQsKZbE8Oy+4DcZSve4/YUggsH0VfYANB9htRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6436.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPL4oAkEwyRJeVtlLJrf9oZaJW5GGdoqweMZan3VLNHqUV5UmLOgL4nlQhSL?=
 =?us-ascii?Q?jAJ1Ae48xdN2jdk30z6g/icsJlba7wQpfJRh7LIzJlYUkxSPORtTWR3LgpXA?=
 =?us-ascii?Q?oV6jVEkgt6Wh/aHT4OOiLO4fGBKKaGkXpVx1IXd/9On+NCakG4GjD0Axa9Bh?=
 =?us-ascii?Q?O7lUT37iXRGu39+nALENLeVRSJo2aBqpucC3C3D5O1NuS2XAXn1GsJrxmLaa?=
 =?us-ascii?Q?2lER3hjLXMxHZLojYZ9n3/qozCwh0FBtJbtQ4e9Iz+UxSIhadR2lKXgGI2Gg?=
 =?us-ascii?Q?tpUQ5YSqsCO9hzPRxaIwnGf4xaccLPuNjko/1XyUXVlwUcXBDA9GWgNf8QcD?=
 =?us-ascii?Q?NHgvTYMYFK6kNk6fjsVtk8JOplme/bBAyJubuCXknxDE5DfHZg3FzWVavrmp?=
 =?us-ascii?Q?TLdum7mAu1RH2p/Ep83KlCOQravEpM+JTQtyNuC/MKJjEMTX+4/6Uf/7gyug?=
 =?us-ascii?Q?c+UoJAjaYMLNAHdiVu+XySpGyz+3tm3yStCfpjWwmOoQJEIB+8D3Qmikk3Nr?=
 =?us-ascii?Q?o6cxA27jxwDFALzhxksIZxwC1HZt3iR8PVQuC12sMVz/VlvspAjZnadEd6Mf?=
 =?us-ascii?Q?d29K6En/tww4+Pyi1sdg7KQ/aPfVpP3MTrgIPtcWz2sWLQCFrBCUvFXeEAWb?=
 =?us-ascii?Q?I9Yl/4jcOwDa9HpcrddSqM8G9SwPWcaKqgMBsJQ+13dX7eRrUr8uLlEp2v8T?=
 =?us-ascii?Q?0rGMbr+V9BVSH7xjH0nILx/27Qq64U2u+f7n1ZzPCXPq9W8NZX6AKmWnIrPx?=
 =?us-ascii?Q?2+MZBhwYoujD48O4kZWKxx0uJ5h43iOEfm1+/gLfvlD6FniGwsvxFsItsIeB?=
 =?us-ascii?Q?nrdVLo4glF0lO8pCLoMwFqDg6ZjXCmmPCjrX5Rkxd7IGBOkj2+qtC6t3Mrfo?=
 =?us-ascii?Q?AuWFM2O9Ip1G+QV5GEoJO2MFwUUCKVB/AmYs4QXygIUtq3BjQSzD3JVAjWQY?=
 =?us-ascii?Q?tt+rvcNavFs0KXwcYXkt+yRV8zEAlDDsmDdx3XYAzPvEFaloHcQYaVO1jCmF?=
 =?us-ascii?Q?6fCA8gvkZ6gOT8jfIFYUNEvddh6UcV1ALR1olJv3cB2Nm/9fUfo+7LW4rLP1?=
 =?us-ascii?Q?wyUX70sbc8Kbfl72VzMPumhbDDkt7oyd0V2ultLPheTZA2ePVCqEuhSd/ra/?=
 =?us-ascii?Q?Lkw+tzEFodtNuKMK/9vGEX7MeTQXz89LogugROCmLfSmyxi05lrkrXpcy7nQ?=
 =?us-ascii?Q?qGrqWHMTe8bNq5y7SGXeFNf0vKIr7BV5JSOcS7wBpKjLOTPvamrjGQrJqSvP?=
 =?us-ascii?Q?lR1wZEpH/h07ZR0+Z31PNXF0FmbWOdTb2vrFG5IJui/HliPwEkiPRGXOCnSJ?=
 =?us-ascii?Q?8g03SX7bIw1CJ1VRH9Zrymb8ikL5gkI3mnvxAnqUPexdtJU04hZMUMNNjuz+?=
 =?us-ascii?Q?iP0UsvS9y/SINR8SWERJwMBKkfMzwNtYnntWEAPxjXZGZSWw0IAAgckHS0mV?=
 =?us-ascii?Q?mFPluq519EbK+qwp0BDfuhJdSmcpvx4WFvrJvh6bUQKucHTwrx0UE1dl9DPT?=
 =?us-ascii?Q?/qbMHwFaGUnJFrHZ099b/l5C4XO3yb6mMH+LFVo9+41q9PwRS7W1SaOSnXf9?=
 =?us-ascii?Q?3pY7kwnNscFTzkgXB5OuF0adg2k77kHsO334PafVezrTgRIB9WD8ZpeR6E5i?=
 =?us-ascii?Q?teOEnIPK0Veb/pqX6LYz/N0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2092b1f6-9dcb-4a21-4ec8-08dd0ea84847
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6436.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 05:56:49.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2O0SBZvSXvA9zOtdtPSYxFX6aUb4R2TwpHYCvCs/pmMC9nEav5HScEkQcyTVnms4Q9xUDTzX/XJ1JvORmGf0FIzIiyBSXqkA6XorhCAX809siAcxYj3Y017waKiSOFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB9086

Enabling NEXT_BUDDY triggers warning, and rcu stall:

[  124.977300] cfs_rq->next->sched_delayed
[  124.977310] WARNING: CPU: 51 PID: 2150 at kernel/sched/fair.c:5621 pick_task_fair+0x130/0x150
[  125.049547] CPU: 51 UID: 0 PID: 2150 Comm: kworker/51:1 Tainted: G            E      6.12.0.adam+ #1
<snip>
[  125.163561] Call trace:
[  125.165996]  pick_task_fair+0x130/0x150 (P)
[  125.170167]  pick_task_fair+0x130/0x150 (L)
[  125.174338]  pick_next_task_fair+0x48/0x3c0
[  125.178512]  __pick_next_task+0x4c/0x220
[  125.182426]  pick_next_task+0x44/0x980
[  125.186163]  __schedule+0x3d0/0x628
[  125.189645]  schedule+0x3c/0xe0
[  125.192776]  worker_thread+0x1a4/0x368
[  125.196516]  kthread+0xfc/0x110
[  125.199647]  ret_from_fork+0x10/0x20
[  125.203213] ---[ end trace 0000000000000000 ]---
<snip>
[  211.151849] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  211.159759] rcu:     (detected by 141, t=15003 jiffies, g=5629, q=26516 ncpus=384)
<snip>

Do not set next buddy if sched_delayed is set.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbdca89c677f..cd1188b7f3df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8748,6 +8748,8 @@ static void set_next_buddy(struct sched_entity *se)
 			return;
 		if (se_is_idle(se))
 			return;
+		if (se->sched_delayed)
+			return;
 		cfs_rq_of(se)->next = se;
 	}
 }
-- 
2.25.1


