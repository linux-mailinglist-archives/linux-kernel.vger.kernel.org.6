Return-Path: <linux-kernel+bounces-377234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F779ABBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D11F22090
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715034DA04;
	Wed, 23 Oct 2024 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H84T0iZX"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011033.outbound.protection.outlook.com [52.101.129.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5C847B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651415; cv=fail; b=NxA5VnN5sICA8TokA6EpLr2+9dnOmhI5gmzRyLIkXulJ74hnS2HtBNW7o1kWMyyegIJFV8pHk1V4J3BSrQz0PId5HcP91/cEzulCeZwhAvxMBEdSdJI8VRFaNs7RNRRinkEw1FTHpQ8Cd+oIP2zfKXgBQrRVjj/r9RQbbPvvft8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651415; c=relaxed/simple;
	bh=Dz4bytw7VYOrxOM1m/NTeFOyOuNi00x+0Tlz42vl/8U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GwjkPKrano7ecJep2NPc93AI6ZeY8bNJnr6ko3LOFW0NcsoxWzCs2Igs8f5+yrp5O35on8hvQWkqVBeWBfvhPcmeD2vYHMW+RZSoKuAJdERRH/veYvpCY7JCVyEwOxr/xRxzA2uo+40cFogoyxUO6cx/Wd4oZMPIoDTEOOPkW34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H84T0iZX; arc=fail smtp.client-ip=52.101.129.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQU+q72v4Fc9v+Zf+7L1xxxhgjcdbdkwJSCf9TOfDTh2YWtHmC1Hb1jFAmhNY9CMhOJor1j2QEeWrRWiaK0XG1b8wWNdL7PvXeS7ay6jqzH8EDDXNGvN8fg5tLrOhVAxCGZZk1KoyS5eFarYiRf/d2mVpFgfDZQIX1P4CnAgjvjZlLdrjSx68YvXlGuJn6ODpSpPvIqR0Xa6lBV5ps2WfEoscGz75YtJdr1sxoQ0k2Nd63JGqviTBZQqjHmhjUPZSaLY4J5jf6XRMrMg+SLpRKJNcrN+qDxZJoMnqqMohfAvNxPN/qKTdEB8orfDdOomzopccbE44FiKLI63/tjFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31/B/P5KVS387l91kICJzz0kfOPBEZisMqBbfEFlnIo=;
 b=ia9YLS6qHj6Ww7drSgv7wJVV2ZDJxyX2jqo1YXgXE5lxZl6fWidArHzJ7pCnsk3pq812tBrbHVE+OhY/u291Z3Cx5QHUazVGE9PiOJPQNVHxxenKIh3zlMoH4s+m4NouKQAvJhlKis6fEpcSMoBGc0yFXkgO5ShHcz9zi1QHIbhu6Zi/KKZkhzEyxGGsdQKJbyXSEx7143GOZTfwrMdQbenCh2HceMBSfsaw+YuTlfnLkWIkAIXQOLE82UjwGa9bL88aSQTGGCci5wtCgFPqOuwKP6GXYFZxdoHsxaLKn+XUVXomXZgvG8Oo219Tx1SjPh+d6aBvUFmGTmkY3omipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31/B/P5KVS387l91kICJzz0kfOPBEZisMqBbfEFlnIo=;
 b=H84T0iZXymNx6e3ouKe/g5CFItK7czcf9TOIl4rvjY2hZ2Hpgya3hJ25r6qbZpW0s43NkO9RywWGR274/HH1H41ohCBI5C6hSFlsV4Np6PJvJT9qP6ENPTjyyRZQIFit+rOA65/RpJ/gU2u6Z29MTo2AtgHc8HyJVLawVyKpJGJ6WeTmQcbzKRn/ay5b4OGnm8VfExdC2whyYEl2lHBrrV9EqtA/C8fSyvYrnehjAlNj2cMf2b/fEHFp09ltDCahurGTUOvVxZLa0MEqFLwP9j9QFIWBzOUp7ex47CeeqSwNC4Tgq6sbwty2EKZaK+9NQpj2lYv1YejU8aQoqLrj5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by TY0PR06MB5233.apcprd06.prod.outlook.com (2603:1096:400:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.11; Wed, 23 Oct
 2024 02:43:30 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%6]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 02:43:30 +0000
From: Qi Han <hanqi@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v3] f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable
Date: Tue, 22 Oct 2024 20:59:45 -0600
Message-Id: <20241023025945.1817457-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|TY0PR06MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d7c2a6-aaa1-4078-667a-08dcf30c7a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4aXFt9dX37j/f7h5zdmgXrbmbB7o7sXfIeheZVHbqPctmFBfTqI5ccsRbrTB?=
 =?us-ascii?Q?XqauOedthMd5RY0/z0BfF0xo1SklcBLPHWBkBINfAw15rcm/bzkdMrh+KOKo?=
 =?us-ascii?Q?KbferCRSr9Qw9lObBwkcCgBZKI0hDmNy8Hh+ZwIJf4jz2lEXc8SSMt1HbXZh?=
 =?us-ascii?Q?VZ9+DxqGOXmOBvs5Id+jIpogmuoqHwBATioWZGbG4LB2EEghrXC91Q8ex//3?=
 =?us-ascii?Q?Pdp3DhOgERi+VHa9tqMrAKGczP2GTCWusohM+W0sHzLqQJpZQzjBdYGAmUKr?=
 =?us-ascii?Q?HbjZvCSGHcHLnNavJtzdWEeWIrlhh2+szEfG7tsY48c8+m+lRnl+G8wHPms+?=
 =?us-ascii?Q?rW++w82+rnSXNxMZLjTNLyXrDBkNUzy2TSNCXrK+3TZAsM6z7NumQfoVYd8Y?=
 =?us-ascii?Q?40bEYrE7AFehxiV/o/7NvoiRcVNMzg3w8wp+C2R+oo0W3J4U6UCD3FyvkJ1e?=
 =?us-ascii?Q?Fg6oOMCWCiA5pcSXJIE1OU57EIxSgT/625nh9EdzXhtXucB91ed/DNZ5VeQJ?=
 =?us-ascii?Q?qgS+sj0Yj9aqzSUvfrl4dlewgUK/BIt8piU6VbnKCz8tW1NG7yVpktStveRj?=
 =?us-ascii?Q?0rfN9iOL2jtv64fRz6CzKHb7u3U2F3RPmr6Opg6rupTyL4haVZmiDz48RJNr?=
 =?us-ascii?Q?6HnAaCu1sgVzHgOqVFz79V4jC7uYBc/HEhUX/mWV8idBEhRZ5cpAg6+Bbc0r?=
 =?us-ascii?Q?X0eE6h5mT+UexJNrV552H4l/V1qnx0vrTN6qsjQSjyspsmu3Ob5P3RZM5tps?=
 =?us-ascii?Q?z22oxoX7i2ZkCTJRPjq/EGCy7idqI0n//kGn2HtWoPVviDzVwdh+FoUeNwTw?=
 =?us-ascii?Q?ef+hrrXCzKgmP+Td5UfL92kviMpe/9SUeUaCbm85U2kCIOHqhLBCpLFARtrb?=
 =?us-ascii?Q?DdyluCSPE6lG9/cDV/xDITnt+DMxv3DNClDRZZUFV8HyKnUSkcUaLgFAlP+U?=
 =?us-ascii?Q?ARcu5CNJs1AI4m238p89SC+B2nbt7VBhZq4pX1855/0T1wBH1H7t99kQf2Ur?=
 =?us-ascii?Q?NHEnCoS60fryPLE77gTVcVBVnMCxgvg3GniyZWnbpekzM3O+CKQAbP5Nh3eA?=
 =?us-ascii?Q?9uHc0G12PXnWAjMdFoug+bRWJKB7ma6SgxXWyutw51t3eYp9KHYZIh3EJSKJ?=
 =?us-ascii?Q?9xfaPHa910nkHcUCiNmoYXz5SU1d4mn4Lcr/MRCPvbTaG87ZEF5W3TvIxTUi?=
 =?us-ascii?Q?u3/I2BkIJYA24nr3/QQPPIcFlXgWRN837xEsesa4DENm5Jv8HNoHPaFWu7lR?=
 =?us-ascii?Q?gZ3SGvPfkjpbGBhGDh7q7LWtCYdrGBtNAUrn/Ey8vYUmCGky2VR9URiZBwZv?=
 =?us-ascii?Q?Zy1QGPOzmPO1+RkexZBNmr+4OZe2tHy3fs/U2vr5nzQmBuj3ttL+Xq3WOMx/?=
 =?us-ascii?Q?px7KYRE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qp8VoN73tdYCfmxZAbNRenj2I3wcWSWrWQ3xd4hVES/0TH0QA3Cj74ApBSq1?=
 =?us-ascii?Q?YHQG1js0Bh6SnwrY/yHvKbqMMhSBJUM+Usrim9qx1gkm9sZl3jNWY0Euh2Iz?=
 =?us-ascii?Q?1Aoh7glzh1M9dYF7N44oFyeQsulWYZsgBoQAoZ5EQdt/U0FuT4Cex085ImW9?=
 =?us-ascii?Q?y7uHyvkElB3uAsYb/fQB58/FCszyUkhLj/Tt1zXpm5W2UF/za6gJrzS8EUzj?=
 =?us-ascii?Q?0D+AC7P+KiZKRZZY1ee6hINbsUb6rbn6EQ+YzIuFOQCXrfLn/Jf6VMhTBr8k?=
 =?us-ascii?Q?pfel/ECZLXKI+KWzEy3oqQMKCRYaBEkCEVWe00aS1lHX0ra+PKdEQPs+20RG?=
 =?us-ascii?Q?SXqGicWiWDlldbr1QOWDwPfDkDVfit92GYhBLhJzg0GiBQywtL1jps11YEzH?=
 =?us-ascii?Q?3a8g6obDYFRvw2z4y7BblEpCNv7hTpOv6NZu7UFTxkUvNz3SgZBwyy6N0SYs?=
 =?us-ascii?Q?Sb9LDYttfD/PL0rb/GyaTseCUXgBdaqPBA5xyxuBZC60rHmFOuimGZhzQ160?=
 =?us-ascii?Q?/JNVNgA3FN3dUDnQIVE6JwtzLFjDxyfdBpmck967e6PYUidsMDkWZvMhgY/u?=
 =?us-ascii?Q?L+KNAQcth0HpVjIwKg9xe5m6SiRMCT2XABY2A/Bp+xq9oZkTDmsxT/3t/O7x?=
 =?us-ascii?Q?t7Xr9N1Pq965qDkRxbT3gTE+yeTa6djDT9uqXd2mvReJ6MgF/9p7f84W2qN4?=
 =?us-ascii?Q?t5MwSnfHUU5BZmL8R13jmOJw6hS5pKMPSkKf5bnMKALkRpTWzYZiuWEEmNko?=
 =?us-ascii?Q?0g5JIYjv3NzOH3da60PxN5s8IDznq83/tKZvdSsVCzi+zvd2FHv34zk+Zx2v?=
 =?us-ascii?Q?ZWsga9MMeP/QslR7qIvgPW6GMkqfsrbDEcxUG5X5uyTjRmIXdDxDDL2FTAlm?=
 =?us-ascii?Q?nSI8ux6aXxbJkj5i0UfmazhexsUwOLJ2gv/ZGwaGwWWI6++y5cclyHB4vemv?=
 =?us-ascii?Q?u2nva8bm8xmPFKeKcg6dxGMQKNg4aZDepxf0OoE0trA+o/l1l5UK9ZzOBeNF?=
 =?us-ascii?Q?92mx2TNjZwlvLrATYvgD/XNRu8g2T87LD3AStUZUEg6u6pK6NovztiH8yoXe?=
 =?us-ascii?Q?N0LfqG7vln+Ol8/EFPkPc/54Z2tvmOCWrXaiSLx20pOOQeQdoRQAgUUM/PjU?=
 =?us-ascii?Q?MWGyk/uZJijloypDxPImqXcMtBUBDVSPRzyQUzNHmPjVc9OoWn1rAkYPY8MT?=
 =?us-ascii?Q?rb7OtKoDjdSQwjrbAo56S9cSe9WoeEAlOyr0CImad0SxpL3cK9hjkZ3d4Sri?=
 =?us-ascii?Q?7/gFk+M7kvwKC3tuO8pSdE7apZ+Be+wBhEpe3aKZfY9B4gsqOuSsh55Y1mFk?=
 =?us-ascii?Q?cN9gAXnDKHNkwxvWDJd7Gwdf4vkWAtHhbNWf/P5REiWG3RmJ1lK0sylrv+LS?=
 =?us-ascii?Q?4Taajyz2Jtn8nKpHCg+J7SOCtIoHm7khtjfPCm9zLh9/8LlmJx2i62MeUDkS?=
 =?us-ascii?Q?7nzw/CfPS7JbtoDEyJkRLG0M2xis1AnAWBScIjAqfr7/p/YTroUNvVnd2Nfm?=
 =?us-ascii?Q?BVDVQKN6pSHkSYqgxwrJn6xm3U4efSqx37lTu5SqRTm540xbPBuzRxXR+ZYI?=
 =?us-ascii?Q?zbe6mUqY5cIIh7LZbdRXnD0ZH8uUeuQhvkzn4qf+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d7c2a6-aaa1-4078-667a-08dcf30c7a7a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:43:30.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrL+I6WkeKWk8wq04XQ7wskv7JIu4BK3QZ5Z5Y9YwMHbebH4zy+q1S2OcOJkaTTH50ExKTGz0fE2sGUnh7pqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5233

When the free segment is used up during CP disable, many write or
ioctl operations will get ENOSPC error codes, even if there are
still many blocks available. We can reproduce it in the following
steps:

dd if=/dev/zero of=f2fs.img bs=1M count=65
mkfs.f2fs -f f2fs.img
mount f2fs.img f2fs_dir -o checkpoint=disable:10%
cd f2fs_dir
i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
sync
i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
-s 1K $file_name); i=$((i+1)); done
sync
dd if=/dev/zero of=./file bs=1M count=20

In f2fs_need_SSR() function, it is allowed to use SSR to allocate
blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
can we judge the number of invalid blocks when free segment is not
enough, and return ENOSPC only if the number of invalid blocks is
also not enough?

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/segment.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 71adb4a43bec..20b568eaa95e 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -637,12 +637,29 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
 	return !has_not_enough_free_secs(sbi, freed, needed);
 }
 
+static inline bool has_enough_free_blks(struct f2fs_sb_info *sbi)
+{
+	unsigned int total_free_blocks = 0;
+	unsigned int avail_user_block_count;
+
+	spin_lock(&sbi->stat_lock);
+
+	avail_user_block_count = get_available_block_count(sbi, NULL, true);
+	total_free_blocks = avail_user_block_count - (unsigned int)valid_user_blocks(sbi);
+
+	spin_unlock(&sbi->stat_lock);
+
+	return total_free_blocks > 0;
+}
+
 static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
 {
 	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return true;
 	if (likely(has_enough_free_secs(sbi, 0, 0)))
 		return true;
+	if (likely(has_enough_free_blks(sbi)))
+		return true;
 	return false;
 }
 
-- 
2.39.0


