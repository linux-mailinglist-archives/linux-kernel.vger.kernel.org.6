Return-Path: <linux-kernel+bounces-277796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64194A6A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7586428288F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA41E2122;
	Wed,  7 Aug 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HN1bq6Ip"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011050.outbound.protection.outlook.com [52.101.129.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AC1D174B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028857; cv=fail; b=je4kteFgbwyij8pnh/uM8TKN71XVvpMmZKuX0Cfddmnvaztv2kkgcwf+y/pUh6JKKcj1HN4CIdnXTDMynUe70L4lmjg0pJJTxlkwGvkj8Oz3GF/7t8eC9pS6lUVCzcJfkW+uxzTPxedugGfa+lfxAjh86X5ph0ZyowQ9jehP7cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028857; c=relaxed/simple;
	bh=ojOFPHfvDOdHclJWwpyOOQisSA2UQCIeDCeb3VXlotU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hF8W41BD+4rHWMGCyUlTbP79rrtNfmqW7vocD44fG08iAw0ujDEfugfHcQSL8/G0xFnN9TfIhXK0S1bDTInmCT1ScPOE6iYOb8f1hh45S9/SvsZrl1pyxwN+UvjeVLwuoL/yb7aqNZqvVs8hAa+DhqQ+EYih7QzwBvq0EZNG6Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HN1bq6Ip; arc=fail smtp.client-ip=52.101.129.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ/1oLYqnz50N8nH1GiLC/pY3ABBkp9o28sVi1KOHjQNbvG2vHpJ1uNx8Q1dsnF0FNuwZ2Yk0hjqY0s2t0TVNS2riyZ/QlJXy72VmERyQea8uXy0avKbDKO2f8gL7u3C6Vc4jP4hDWjnJecoymR910eeZNehAOE+CpZcLdfTVoMILq0DMPpmWtqG/lYmG8Kq2BIsPJyq1kz41R+CJzv6ptMI5Ss+oWRcPubygjl1Qz7MS1RKD4CPxkAS2OO3YuzLSDKwD0IJfgQTBKd9CCBz1AT4HF/j/Dr/MozHwB/Kvg7UUpkZVs7V/aG8w7gDNGjk9v50mx8G13yNcehr367ppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6S1VeZ1IA7yyuDlVJSC2QYXi9n0B8EHO4qzVyL2Yes=;
 b=vAT7N0wfpG4PpcmNYkJUz7g6bdpG98mHXn+vFq0CLQNVfUoHdujWUBYWYSYnp07QC9PzBCx572L+D6BkpHcIvb9Fbz+N2HQfzgppWBQsSY/yPd7yTO95KV8vHvpr2ebMnAKmMgUdD7rj83XMpLkIYt7/mMq7+Rt8zy2YKMy/j2E8HVfQlLMYqPzSnBQT/5MDhvZ6MOcfaW5n9XLqONsZ+ee/EODBh5HGz+fnC2Z3uLlxw00i9FUMv/EXsrNgg77HuV/cH9cKKoltll0z9KjfvHJiw3tIi9FGW4UW7ji7F/2q1OMVchvEWvNwbmbReevdrQGCJv8PgtPlfx7h8wFZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6S1VeZ1IA7yyuDlVJSC2QYXi9n0B8EHO4qzVyL2Yes=;
 b=HN1bq6IpuwYcBR4N21H0hvzk/B6QC4nGnW6YddLe5v4nCDR6ac3YiaBsz1m6Q946oo6By/xcTnsyTtBtydKzd4ljvZoiquVcaAHYFw1zejGwZgFQoH9D88CHJAepOX93+OOpDTT92Rp+rXSsQnIWUxz3ZKIg1gOgu+RZlEvx7ddonvwRwT1ahHyL9TA2X6kYXfe0mnl64qdNU+vPX1NJ/WuXky8e+vPmxzvFooOnPOQRpEEJ2jxjxLhxKhtktLRrX1127gfOFpCOotgm1GKnB/uUNhoL/5kHOrXwNCKgE6x5ndyVScib3DbbB02uBmTEvrGitPVLX6AD7q3XDdCw9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TYSPR06MB7341.apcprd06.prod.outlook.com (2603:1096:405:98::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 11:07:30 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%4]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 11:07:30 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: bo.wu@vivo.com,
	liaoyuanhong@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs:Add a threshold for the FG_GC of zone UFS
Date: Wed,  7 Aug 2024 19:07:15 +0800
Message-Id: <20240807110715.6541-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:404:f6::25) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TYSPR06MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 79342b04-2dac-4c50-3f1d-08dcb6d12128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BbPsRbdPlucCCR9PCzBN0brVC4aSUzFHn3hrnBFmKMcaBGSrVKZpCOjWhen8?=
 =?us-ascii?Q?t5uCY0Ldtke8Ej15ZBQZaPmwJ0u9ZlkbR7N4/zsiPfsXkos1omT1ABpRYcG2?=
 =?us-ascii?Q?JKJjE4imwiFtXs+QJGUBlihfSEywTRCnV0ETLhENUmypvYXazgXAi38WQVhE?=
 =?us-ascii?Q?xU0dySRWsWhqpB7WHdeIq5ANbSln5v4yQMw1nXIXzH7t8TcbSy3lMb8MKeXq?=
 =?us-ascii?Q?QSECw4O6oq75Oh1IqbX9EbglWRW2YTQ6hbdJNf1wMjtaHQfSsnmqDpZ0Ijnc?=
 =?us-ascii?Q?6t/g3MzzK2t3GRn/1ydQwtRZWdQzK02gwy6httTi41M4ADktYeYcZwPJ51RP?=
 =?us-ascii?Q?Lty9u7h6EHexY+Hq/pYEQZCT1HsxxN0/WpLUsd0NkBhCbUdiI/fsaWtoWfLr?=
 =?us-ascii?Q?O7y7UeKq4HjiVvIzY+IhlV9SX/pFdeGHccJYDvtUzbZ68V5gNVS2UUXJJmWz?=
 =?us-ascii?Q?IumQc8HpOizMqkLpSIFSWMq7Nc/TfgWa+aOhdQzIGmJFyqwVl4LKjgdJ44eM?=
 =?us-ascii?Q?hVayfGAyi2Oorj2Ajkz4BYJH5THmEm6koRuxNYGCO+OwH1fCkWsurOKEAg3j?=
 =?us-ascii?Q?LHMx/Xvu/HP9v06V0eH55Cuy8DcPTMM0SdABotMuzjqbjAwRJElzA86i//Kk?=
 =?us-ascii?Q?K9eGl0OOA9Lbi1gWkFB8t/BtLRNcLSdqYDkfX3EWB0Go6mvXmfLKV4hcWOH+?=
 =?us-ascii?Q?7Mrt+sXtFhG4NS89um6AqXrtUkSt+mP6xz/bpYdy5dJq+i8pa6uMikDj3nxJ?=
 =?us-ascii?Q?MNtcGjEJ+gPcr11u2GZBfSN+KZJT1/JPp/KZiNuXhmbz5+boZgjGyq0UPfY5?=
 =?us-ascii?Q?lYPwTL9BXZR299clNq79rmEQVh+RTj2xaIQYKdVE1+VoJeOMu88hiHex8KU0?=
 =?us-ascii?Q?VzCBkq4k1GiA8sFqulgggf5riM0DLMcYuAYUwsRZQO9Mi7Y93+H5ZiQy0Jvg?=
 =?us-ascii?Q?Q5EN4MhtyF95ypiC0dXf2Du6Ot44zpvO7CRW3XmEd3QkhEAk7ME5OQ+WOKN3?=
 =?us-ascii?Q?cXXwZlvtkiIy4wtnf2JL6L2vwuT8acdB+7QGr2mGGOMQcVQcCbrclfU58POR?=
 =?us-ascii?Q?o3SaoGstQnmDNAH647q72oZFU20osE94hUQQTxXp5UmlYSKg8rY3hqL89iji?=
 =?us-ascii?Q?/nXVF09VbM+/hp9RyevZI7UCgtPtdEw7iHj7agSO0DQDvqttQey1SL91ZAKX?=
 =?us-ascii?Q?CGnv9GSROScviEneAhJTVY0nKO0xBjBHSO95hhbuunpdjpZIM9+U7Y+YKOqj?=
 =?us-ascii?Q?RAUOK0rNqPyhQ3LSDfU9DqIJDdS5LVHCKR67WYahejsCxS2fZA/12aBjYK63?=
 =?us-ascii?Q?HHAZYO9H2Vdh8J4fxfwfsnjdM78UqSlP6nc8MXc8YGmWN8SwLtEpiKGCm/og?=
 =?us-ascii?Q?/LDODN7jFjYLuPg6sdQGgaoXTUe36TOjD2ZwXtAxFmHaPLMGwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y4n7/99mig7lBVQ0JQhVxvAaSvVxcqmjAy2yJh3v3DRAO9BwGKLeZNdxyQm5?=
 =?us-ascii?Q?EnaOry71zi0wFJGsbvgUO6UUhijhzenxjV79c8oQ6CBSymU1jrX41NSP7+NN?=
 =?us-ascii?Q?z6jgJz7nnQbrlDdqn38AGoHWzO0bifmCsqF9Ej9cLoVxwCvS5Y+1Vi/VMwMX?=
 =?us-ascii?Q?pn/octOkTggUIDs2nUTPujz7Zlk0jeN6Dazk6LSSDqnGVFMeM6unVwWuvTag?=
 =?us-ascii?Q?i4NSF0VYCl96eaexIQY5lq7vFtK6NaRZH7dw4ZYGqYr4jKP2pIhbrZxDJ5l0?=
 =?us-ascii?Q?ctk1fC2P+q9yg20TBuKh/mHk8+P5G1hqyNwlO/0xSTk5DcA7Nv/T5RKOdUYH?=
 =?us-ascii?Q?cq5fiqQJKgMIoXQ8C3Ul1jAyvwdAAYT6oi/vD+NlD6yit+XwjYd6pnnLezZ1?=
 =?us-ascii?Q?0hb8mheOmwYbSYWNkGNpFTN+LJYRgCqkZCzEp8osa0YLKNf43CdXlB343XJI?=
 =?us-ascii?Q?zKamAV/czFOX1hJ+YkZ2Lyeu8zArV9st+EC0OSAGBgBg61lNiycWTVrweBfL?=
 =?us-ascii?Q?FmpJaM/Txoovq9Az4O7VGjbBFOmoEIe+gMsJ4JFxEieHjzVC7AET4heVQzld?=
 =?us-ascii?Q?nu3Od4Xr+kar/plKB3OB/De2BmNkzlAbQLX6sNm8jqrZb0BpB+FRXlKqplcX?=
 =?us-ascii?Q?EieLOF1B262t+gfyiBiWuWnRaEIb+8eZezaShFSMCH7bDgBF1S4wXCDXzSb8?=
 =?us-ascii?Q?ujy4Ed4bax3M8UYSs3U+IXXjlCmsdWqjoePGPiYUooDDlNrZqhONpTr6rs8W?=
 =?us-ascii?Q?vEeT7I5h61S58KKq4jwmmoW/D7o3/quT2ZBccUhr/BPW4kJ9UtqHekDVeKGC?=
 =?us-ascii?Q?trme2VWbPKY8segfyu5UTvYUmHxf5sohErv/MQc+bQ/MmVmOZaU+ntU7G9JD?=
 =?us-ascii?Q?/plOlpy1bdURL7R0mfRQyzjBfcfrngbDPyVs+DFeaOYp+2fW4iu8uTL9Afjb?=
 =?us-ascii?Q?0GLV31rcj4GnceDQ0uKkl1pNTYjn/QMe61vlM02XCwA/VHXKeKGAqTdpXV6D?=
 =?us-ascii?Q?lvjANjqJ7ZEDMD1c3sCvtI6tyQiKWA0eNSiQ1P0Cd21n5NZ93FGbwmoO4eHQ?=
 =?us-ascii?Q?QLCqiA+xPRwcpFx+LVt4iAYEI4LkTOOcB9Ks30YZSUDO9AnhNxZv1OUGGPEI?=
 =?us-ascii?Q?ifyCK4BVyBq3buw6DP4KCWhBAdTAYL3HA0gT9GRhBaM6/knEqaOyFhaXAi0s?=
 =?us-ascii?Q?l7c28/tYL+WHQZE9h1JLZdb7mQAb3YGnDjPxZYwkNjNO5d8WSbw1HXY17MLN?=
 =?us-ascii?Q?ZAfgGnRjSYUmc9TinmeO1r1+YgU1ZH8i2HgyCj0GdYtQFumrcsgB3VqG18AD?=
 =?us-ascii?Q?RL5fjp9rxcnByyHyyAoviUBjwlI7aKnFDNAlfPx0AA/iDt9Qyzogn2nPyado?=
 =?us-ascii?Q?bN/sQX12is4wFrZdWLGcQk4EkLVDjqo4L6aRMnx6PNToy9amDwa+yAqBKMEF?=
 =?us-ascii?Q?oZWaFt72M9wzQoREb5JAPi0MMI+kaMApKIG0ln6t38dQRP7vP3MYh5uZCQsl?=
 =?us-ascii?Q?/ur9ea6cWJFH635tNrKT4XthEHtgCyaWT/2iSsyW4D+eo1c15+Kct7SaCQfH?=
 =?us-ascii?Q?wznYmJrMj4YsfDUJ4YbzF6hGTXznOM3j35C9qBRb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79342b04-2dac-4c50-3f1d-08dcb6d12128
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 11:07:30.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2BJauS5VnNNsjaW+sjfKdhiJEfGUvFd1hPPsRexMphamNReXpzvEVvpq/hbnXezz2Fc3wqYFwm2oADqW1BBFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7341

Right now, when a zone UFS device gets close to running out of space and
starts FG_GC, the system continues to execute FG_GC even if there is a few
dirty space available for reclamation. This can make everything else slow
down or just hang. 
Since the function for calculating remaining space operates in sections as
the smallest unit (has_enough_free_secs), it only makes sense to reclaim
space in multiples of sections. Additionally, the larger the zone size,
the slower the reclamation speed. If the total size of dirty blocks is less
than one section, not only is the reclamation efficiency very poor, but the
system will continue to be stuck in FG_GC.
So, we really need to set a limit. If the clutter is less than this limit,
we shouldn't waste our time with FG_GC. It's just too slow at that point
and doesn't clear up enough space to matter.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/f2fs.h    | 6 ++++++
 fs/f2fs/segment.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51fd5063a69c..aeff0d2a644f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -133,6 +133,12 @@ typedef u32 nid_t;
 
 #define COMPRESS_EXT_NUM		16
 
+/*
+ * Avoid entering the FG-GC when the total size
+ * of dirty blocks is below this value
+ */
+#define FOREGROUND_GC_THRESHOLD	2
+
 enum blkzone_allocation_policy {
 	BLKZONE_ALLOC_PRIOR_SEQ,	/* Prioritize writing to sequential zones */
 	BLKZONE_ALLOC_ONLY_SEQ,		/* Only allow writing to sequential zones */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 741e46f9d0fd..5ad7b5362079 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -418,6 +418,8 @@ int f2fs_commit_atomic_write(struct inode *inode)
  */
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
+	block_t invalid_user_blocks = sbi->user_block_count - written_block_count(sbi);
+
 	if (f2fs_cp_error(sbi))
 		return;
 
@@ -438,6 +440,12 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 	if (has_enough_free_secs(sbi, 0, 0))
 		return;
 
+	/*
+	 * If there aren't enough dirty segments, GC is not required.
+	 */
+	if (invalid_user_blocks < FOREGROUND_GC_THRESHOLD * BLKS_PER_SEC(sbi))
+		return;
+
 	if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
 				sbi->gc_thread->f2fs_gc_task) {
 		DEFINE_WAIT(wait);
-- 
2.25.1


