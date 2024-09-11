Return-Path: <linux-kernel+bounces-324172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257459748E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460461C2519B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FE136341;
	Wed, 11 Sep 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KJjp5Mg5"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E37E583
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026235; cv=fail; b=aeYU+Wu3MFPcHIqWgb4fcP7526PgBuxQHw7C6pwemB50hWzOO/7yF8Ws5ADu6lx9FZ/NWJd5nGfn9S/UNRL5Ox0cXU+4KHtjdfIln+o8U8fa/j6Wv7i4Oeel773UDY/xL1bJ0sgZHSXmrQIBDdEN4XJXTpeYM8NqDC+EVYktXt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026235; c=relaxed/simple;
	bh=lt1kuXig5/OcyT2+aCV/ZX0lUx+a7Paws8zyj6CObsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bLF9zTa04WOr0CcCEgSeVZNJz6jj8lVDYtzffoDtAgtxvz3JAZE2NbQXsYRksQ8oUQdTtjAuFRRnjGthL57iv+ky48jONJELV5G46NiZ0R/NUktjY9PVBnMoJPtyWjTzZDgpbRcXOgFbLtP6a4p1NF81WK7cqGmS8h1hatyaLjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KJjp5Mg5; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWObXJQh7DMaDk4Q1uSM0sKMjEj8TsITyDOu/ERZCv8d/hgVzUw/FcWvRsHYBMBmjz/cwPmcmh39G9VGbp/94TXglhFdf9m/54CF0Y4XfRQKwmgVKIPY9gVugDQ7j9uBFZSJmMXdZEpS3utxFJR1u5qnQmg2Q5sG24RxACG4Q0J6FnewkfXc3RW629GaZ1X69g/ozRskkXZEDNutuGvWw4TAKX+yZcGKvsFLy1EqbixZ2TjCBaX5BY8Usn0kIljCOWuTs58VEO+UKIhOISurq3MTLmwCIaJkQWqPBCRPMBNvXMOYMCxUuLNsIuwYs5vRkYk4t3Vv/oybGrVYlS/KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fI4xqj9AK+cyUPbm9hBvT+ojMH7CRydVKcnjsmQTb8=;
 b=UqYoj3K/EHaO+ueq0QPA79DF+9YiBVyo+BbTGl+bUTUAqa3XEazV4ACCmv0dd+kuCIybVktvC0gweblzfrkXQYG6QtpxaktCmJI9WDsYLcttdhK+J6Lw4VME0HxgKI3TipqAfrDLqieENu/UfTxjrAR739uSJX44taDMd8avzv/T8AY8+VLTKlSFSYE0IhKBT4X/KcEr2yXtWFfhYuY5oMSznIIPj1bwBf/UQQq4pzX4bgcBu8K7AKjwkOjI/9htMC63hvPjD8Ab0MFo+xiSZcuYip+/bjjpI1xO28xzMGrPlaZuVLtCw678zMyXmGKtBezxY7I1D0HgsEsYLrrhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fI4xqj9AK+cyUPbm9hBvT+ojMH7CRydVKcnjsmQTb8=;
 b=KJjp5Mg5U1XkXIirzpfvsPmBDwTTab4NUC8Mioj5U5jU1gHFm4d0eRn3i+ep7HNMl5Rm8O6HrGSe7f+CImh/AeHwlbdBGxzsREYQXcjqTjpUjTzQWU6iJMwEH7rTzyJ2cxEOqQwaDX3sKvejXZAgCHyayxnDLM2OW7nm5x3e5+/o5qn4Us4Gqc5I6NuZxIMqTJ2k9OFPEAEicDJEalNKpsQNzqlDc5CObcW5WUYYA6WDHeNmr4aeTfIQfB6rlVdKqFcDAQdRzSNNJP4m6faJdxZAFpMbVAeTbFExfpE3d3uEU9ey++o/vI6COA8tffe3UKqGNTByPNpJZjarVDrjCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 03:43:44 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 03:43:44 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 10/13] f2fs: avoid inlining quota files
Date: Tue, 10 Sep 2024 21:57:23 -0600
Message-Id: <cd12b5914d848976e40c920f8fc47a74c2f80fcb.1726024117.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1726024116.git.bo.wu@vivo.com>
References: <cover.1726024116.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: dde63625-a6b2-4e99-8bff-08dcd213ef63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dpEtUG2gSEgF9mgIT5sZAb8hO8SQhd9+Gki4YspSxVFRs5ahrd5O30ub7lXp?=
 =?us-ascii?Q?fILavCHMpAoQdiz6qSb605J87diMbUWcJqt9ULI/sTjA8QgzAFpgB8vWWoqw?=
 =?us-ascii?Q?+1cKsrDL6Zc6Uy3LS4LLHHGUKH7oOFc2LkKoaOZT8reAYTHGA5U5GA49IJch?=
 =?us-ascii?Q?FaviqEsEP+GUjHqZakD3hiBelD3+EMrcRNupqe9/ZRUXQGgTzPEZgJqNuTle?=
 =?us-ascii?Q?YOISrq5/hjpjQWg6fAgseh1LktYEQyl6THP49wySfsY0ajwVljQvogwtnVVD?=
 =?us-ascii?Q?my1NLiImPUqKMPRZnmRXWU7uEp+EwaX8IBB1zjA3ElPbQaHPdW4/rLWgFvmS?=
 =?us-ascii?Q?25XBt7aKU4ci1YzvdcNGnB/Y3PKenFT/Etedu45xr7LKsNwlQ9Tk7uAtRf1k?=
 =?us-ascii?Q?V0/iaXe8z4B32TBeSQM13oMWY3mzwHu79OFDZNQz3O75QUJ7bjO9EdQ2myeE?=
 =?us-ascii?Q?HNzd/712swHA4SFy+y5p6gJPxURxKaaYOjQS26z2ZVikq/33MeoRLlVlZrrJ?=
 =?us-ascii?Q?WWt75P1nJ2dvdBtGHJou4spBy90Htf7vgHdmpgxD+uuLQXOPnRgLqwgHzFJp?=
 =?us-ascii?Q?UgGSzrNXTJoLLjfz2QcNxXvOqOcetrdMrm9iPJizY78gEQo2OembJvJSR2Te?=
 =?us-ascii?Q?Ic4nXJf+4jzWWbarolbFdeCnHYFLfIqv07L2yy7nFvYFjpuouGP7UezLi9C9?=
 =?us-ascii?Q?UwagT1JNtfc2nhV9yBteM55j2UTudZH3KMP0e3BJU2g79RPRo8YSLl18xhqh?=
 =?us-ascii?Q?qhe5OBs8x01COnzPaBVUU8xqVf7ZWk44CDlwwhkadAqaeitcTIKY+8VveEmw?=
 =?us-ascii?Q?s0+DCon/iMhAWeUhQwTOghutO9rS8CX0SJkBq/EB/IXHBCMg80kJm6fLty9f?=
 =?us-ascii?Q?0jNDetAcZYWfdr0XlQYWY39n1ShBye7oIYpKKsA086Dzps+120t8WdVVdHVE?=
 =?us-ascii?Q?kLRShIfE+IIHzA7nzIj4Z7Pq05g6qjGrgU3ouH20xlS6CAedyx+Q6ouiQcYG?=
 =?us-ascii?Q?J191+zhLfDbgoClqB9xdfb/Zr1UglU/xuLf0r3m2opFl0zioPeL+OpdGdX8z?=
 =?us-ascii?Q?Y4WnR5e8Dxb7pOhI5s/KH0cQse/K/PEtzMmeYK3hlFoIvIuMuuKUxv58dzdO?=
 =?us-ascii?Q?Bqesec01ml9D+BR6cHxfqQBOM2E30qKDB86lMvnLeS5aWyc7+LeZ8/aIbqRb?=
 =?us-ascii?Q?t+hNwG0QX2FeuMbGrybY4MSi8U0mtiw1OMxA4bWgC69loEUJLu508N4bzWVv?=
 =?us-ascii?Q?35yoCYkeBP9d24PcHwQcAgj3HWrXpPsDSzpVpZskYmgiqgwr2RU3BvLl5ssz?=
 =?us-ascii?Q?jlFeLracFSL6y+rtkiBJyNkXwDpfM+w+HqIpsVWgGe0ghWwv5MhhBzAYjB/Y?=
 =?us-ascii?Q?8m8XoWZkagpk3XJoqgHXrnCST8nD4izsUToSwAUyFea7249UkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XnMnAtq4NitKc4UckgMVoWHV4Qfd6oI1N/5YMYRqmU2NwxSRTGfQQA5iBiPE?=
 =?us-ascii?Q?igkWuaDrwmeCXKHD5H/QEro2wp0hn/C9iBE9fC0KxOIaWD7AvG8r3WrqmYf0?=
 =?us-ascii?Q?0WeNsLY8Qj8FiNs+2cwsHZluDJODK9Zs8OtAGKYYsBNPxb+M+kTGka7p7nFT?=
 =?us-ascii?Q?dv9l1QunhpzfN1URqZtGV5kaFQQ0W7xi4lcmv4SUeYuwAcmhK+ue99IHnbwi?=
 =?us-ascii?Q?5wdrmKQLlemfQdpY6GMaMyS6sfiSQEmBgcgDhN0J/Q+ZVEr6b2EIyDjkaEvd?=
 =?us-ascii?Q?sPQvQ8AtZdUd4bFK1ndIvSbvLpZPq4nXjHrBCfQn8/F67ahoC7oiNaELk/Hw?=
 =?us-ascii?Q?BWU6sTOB8ZtxbMBUYnb8E7B0ZZ3zEuJGjkUOgqmyldCjSPXQuu+SZa0Xnw9f?=
 =?us-ascii?Q?Dul5iSKnIMfkPEmqhCJNs4OaoqWc9QEh/vKAo6zbUzTm75WJsjpt5mRnrk43?=
 =?us-ascii?Q?Ja+ELVoUitSrseBFnk66B0QaKjsAKx700sHrkOU/zJMsnAqt3XtjfLjLK89k?=
 =?us-ascii?Q?Y3JAYOa2tPrt8yAfzaa0xKAD045UDMa4szo0e4R6AKjNCBFeI7v14wriNeIF?=
 =?us-ascii?Q?qL17oAO9iYR4i2PgkwPLoZG/2TTVQFZLV07HAtXNvWbtS+QMf0CcLrLrMUgU?=
 =?us-ascii?Q?zUJL4uwc2PZb5Dkfc2CgZT0PyEwORWHUrtC3+fouHgRuyt7lyTrtXUVnJ0xj?=
 =?us-ascii?Q?GFw1S2RE7i+qMbK3hvJckYYjohJMbd1+GN02iwLfxKuvypSJW0mMuyJaYHa7?=
 =?us-ascii?Q?QzD+htOXlxBNEc3dSkAvdjPYeyXVnr522EDQ+IB29RwFTzi5MWe6xG8znaUv?=
 =?us-ascii?Q?WvpSa51Z+s7CxS56/JEHNB8qJIJIqDXkDl3AI8Tg5IlSjv174J0Ac13BX+JT?=
 =?us-ascii?Q?g9uQc5tHx5YyctXAsQpbmBe+FhZAmNCbRFymNT1yobdwV5xi/45C00jdpEP1?=
 =?us-ascii?Q?cYCSfujKLRcZKv1Bgrj7wmGcKzrzqREoo/+EtQya8H9nN65eSZ3Szd1GIk38?=
 =?us-ascii?Q?s2N8FqTs1nRlCtl/C/MF/OrBZGZZ8aSSDGf9Om9EWGrnpx8Y2X58LPhayiX+?=
 =?us-ascii?Q?aBpJuxJUwpBBL6mDdHDi91+tmCj6FKr5KSxqiYL+Dtqc+E+Ib/+l2tdLFf8U?=
 =?us-ascii?Q?HMUK7o9kf3vg2MA7zSqIbnCtwhUuvYPxmEKDOd4Uilv8KHh5J62hxjucSolz?=
 =?us-ascii?Q?t1DEUnuE9XLj9Y38i9D6xC0isKc41OQuxFAx1f3HrFovYsn6cGUNpZjMYg7t?=
 =?us-ascii?Q?goNlhH2kiF+MujihWdvYdoYOWnne05+ady+GOvV3jeZJpnGHvgES4GmBDC+w?=
 =?us-ascii?Q?FfMAKs7O5+awn4j0cxdKjaA7V9DDDV5VrJT59G0Ellt160NGucO7YlKuVN6m?=
 =?us-ascii?Q?j+RPDEcylyQQF7ywPVB883Ts2fsaYChE8yvlGs+j8FqS42EVyPxgezLTO8vZ?=
 =?us-ascii?Q?ZyBwjY5HjHAyfr5oGuZk8lsaebbUClgc/pTKvFhApecIQrA9B3CDf3p9Vzhp?=
 =?us-ascii?Q?uRDuIAAdQ2/SLpMUxKJ+OXuuXLC2lDXY2/4F3nNtyBYzOZd4h2yriaAbo+JA?=
 =?us-ascii?Q?M8usGLFWAUjnZupLRbypLQM0aBDwFVeNXwi4NTXN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde63625-a6b2-4e99-8bff-08dcd213ef63
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 03:43:44.3860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thwrUHUsL02nqMLg1+FEhBj69/KxpefBiietE5u9S28yGjgRSmxga8rY0ARBF4lhjI7bEJ8aptDY5uBaoLvTmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

Quota files have a different write path and are incompatible with
inlined inodes (whether data or tail inlined). To simplify the process,
inlining is disabled for quota files here.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/data.c  |  9 +++++++++
 fs/f2fs/super.c | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 275c5739993e..6d7b6074763f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3641,6 +3641,15 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			goto fail;
 	}
 
+	if (IS_NOQUOTA(inode)) {
+		err = f2fs_convert_inline_inode(inode);
+		if (err)
+			goto fail;
+		err = f2fs_convert_inline_tail(inode);
+		if (err)
+			goto fail;
+	}
+
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
 		int ret;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d4ec32ba6cad..0f54c055f053 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2807,6 +2807,14 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 		return PTR_ERR(qf_inode);
 	}
 
+	err = f2fs_convert_inline_inode(qf_inode);
+	if (err)
+		goto out;
+
+	err = f2fs_convert_inline_tail(qf_inode);
+	if (err)
+		goto out;
+
 	/* Don't account quota for quota files to avoid recursion */
 	inode_lock(qf_inode);
 	qf_inode->i_flags |= S_NOQUOTA;
@@ -2818,6 +2826,8 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
 	inode_unlock(qf_inode);
 
 	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
+
+out:
 	iput(qf_inode);
 	return err;
 }
-- 
2.35.3


