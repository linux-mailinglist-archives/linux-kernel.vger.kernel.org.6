Return-Path: <linux-kernel+bounces-312498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F8C969777
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D57F1F24CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866D1AD245;
	Tue,  3 Sep 2024 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SD2tgbvB"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2086.outbound.protection.outlook.com [40.107.215.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3319F433
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352866; cv=fail; b=gmUzGp4aUl8Ny9fE0LI00XQmXdPs2ymo0CEz9n4elyKPHoZjs/kfU3ehx6lFDzKKg/14cc+mZ5JkyscT0cWrZrQyGWL5WWvr8hLdku1Nb/nEiS3IvoJWQJfBgytbuL8D78tP+sZxSi23A9ib/29/4RxvNeAv31R4fUW43XHCPEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352866; c=relaxed/simple;
	bh=lt1kuXig5/OcyT2+aCV/ZX0lUx+a7Paws8zyj6CObsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPzfWfLJxv0QurqeICfp6PADpBKSMwAU9gtSpwaGEZLc65X+ywJRU9kbfzregRnf/p5hvzLl/dhDRl5ofaPvkvaqu4rrsQwde8uETYK4nuRg5oGPg0Ha84rOHBgquJDkANx3wp43vCttqwGHHw9UZ+bYebSLMIuKYGSCjh2Ja/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SD2tgbvB; arc=fail smtp.client-ip=40.107.215.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvRzFdBvcthkvjg/Hqhq4q9mjuCjZTD6pNUF+orxPGhTX1buweJZReBAJsF5zpMAzOY7WXancBmfIXrk0kwadZyxHIkjYa+Lo925sOMrWe90+KtPLfEgdwgmJfIdgwKzhnjk6ujt0+PDGwNpi7XnrGmeAvDkOLNiT5eSzDjERp0j19Uf7Wh/39kxwk/rkg/pNndQbf90pkpLgeHTOxc3bGiEy4QYNB7v+yWZJiaCRtP0RuhBcMYK3UntljJ+MilNgNHc2q/6kPFadfIKWekrMu7nToSO7IjhSCMD/FZtVJtyVDwJHtJYLjBvA1pGFdVSs464MB+WPEnI0Zw4UOgwQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fI4xqj9AK+cyUPbm9hBvT+ojMH7CRydVKcnjsmQTb8=;
 b=pDEM08qsEcjtmLyMIh+MOlj8XIGuXBgXiKTRarJUg5fsbeEoph5+MZXh/lm8KuW/OxKAWKbQrz25XeggVVcLFWjU4WD/S5wkrVJCNb2HN3hLdEo19A0AEt7wjSu8tgUYTWI8ECcxojRVoaJsFVNcEi/VTeUCQ9h7NZaXOQ3jdMC2wXIsFCo+FHMlUf/3zD5QDEVSv+1eOG3J9578JILnp2sIM6XPxex/sroHxlr4XWmTagweQdscIRdGntvIhwDv4kY2He2NSJ8/DGFJiwdBSV7c3dRMnAEkG0dnuTzykQx09zXd73tgLyIseeSmksiPZm7dlLQPEfVJ0xTwAg5pWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fI4xqj9AK+cyUPbm9hBvT+ojMH7CRydVKcnjsmQTb8=;
 b=SD2tgbvBKOcZo4RPbFuvCwXBF0DKcr9Sh5QjPjXzmA/yvTPzMui2HkLRsA/6rnAt7oP7NqdhHclt43gysHz3kQy1fCjbKkklkTmCUX7kT0cExaTbGyvqb5r5XzVOdqsK+kptz1q+0wOo9huimR9X1lg8IBKCkmZj9ZV+ZCvCPIaW95hJIoI+syUTOXufnjYsct/VuYtOYlqtKxxHBHrknK9FvECIQLstF8pvcnVQO59OBzsi0cQlDqln8xhq40JDT4pJCVgfbwwi/mm2erJ4sXu9IMF6VfnujwT/ksLAPkHyWXBAN8zHLlDqw3oIGC/c3Yff38hN69RIVETkVTQ53g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEZPR06MB6253.apcprd06.prod.outlook.com (2603:1096:101:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 08:41:00 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:41:00 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 10/13] f2fs: avoid inlining quota files
Date: Tue,  3 Sep 2024 02:54:54 -0600
Message-Id: <cd12b5914d848976e40c920f8fc47a74c2f80fcb.1725334811.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725334811.git.bo.wu@vivo.com>
References: <cover.1725334811.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEZPR06MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: e72af517-adfc-47a5-54ce-08dccbf42326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKDhJe7wlVra0y0x8MpSwEJ7jhUgJM+af0soqdHpformwCj//xwJiCs1aJO9?=
 =?us-ascii?Q?nIAxMRO3wv9LRNsZeTlT1aowU0w6OuwWdW7okqUoUlNk60KclAqQhPvCNFws?=
 =?us-ascii?Q?kfchNT88DHFGdaYJHwj7FjccuFkn0xagNnI5fDqzu/kXN937NdtRClzOf+9H?=
 =?us-ascii?Q?Mi6UScR3qYSXmv+S58FKNdssfmf1myELdcP3zveV7jtLfK97QeUJPEAz/XzS?=
 =?us-ascii?Q?0xp21YcC9n4zV7uwQr7MKYSjHapdM0c8KHQksemvDikQEenr+ieyBJs5pFvI?=
 =?us-ascii?Q?bYIgP1OaCJpbAHLkXMlYyzyypQJKXRy0yHvnjdidEchF3/qfocdq+R4nd7U+?=
 =?us-ascii?Q?MhtNWiozLReMrGKaod1MITros9aqFQ6dhWCbPMLHi8uV+5NypJuPADeDNwiC?=
 =?us-ascii?Q?ijwB0GMtxvemAjqpx+PqQw954fJQyBMRveVQw5TKgAtSn5R6Lc85FzaNdf53?=
 =?us-ascii?Q?OyXYBzUYVG/yDVTT+Zn9tAc/ZAodnYAZRtesW79Nn18hrI8mcx1+Xet62j0Y?=
 =?us-ascii?Q?I/4jlm7zY02ZTLt3/wOUfhWh1XLBdoAsA6HgHvMjugG/+jeSDx0wlq+e7UlV?=
 =?us-ascii?Q?KnM5K7Zyrue+/qvWRdyOV+hB72xbetKkk3CmSywHqC+Iv7Ob4GYaZ5VMqHhm?=
 =?us-ascii?Q?ieoyspguepSiLH9LJ4pJXHinLTcghO8KW3/eUjKbJj982g9sjvnWzgPjaV4C?=
 =?us-ascii?Q?BAunJzHhU77jXcf1/3Wc4eIEH4xPrF4yaoeRgbvvTPof0e8iYHMftTg5Z/Dd?=
 =?us-ascii?Q?OWmbQg3hzHhvog5tLecebvhUTiwjGYqAkL6aEe7JaY1BoaTaDVcT0Oh3k28m?=
 =?us-ascii?Q?oRX7PvxzoOHAe563HtsohWdBHyNLXIwG7uyUxb6ljkkKZ6KeIVYs+c/WM2ec?=
 =?us-ascii?Q?Qm4ru/29pXYMZ1GX4dUGYcGUSsM+R1WOO9J9wkKshjGiKa5CawbT359K6tlN?=
 =?us-ascii?Q?O+sb6fq5hVFk/5SGlQgZ4wIUmb3OXdCRXsjgwrXPoVCVlRUwz5nx5skIQtzi?=
 =?us-ascii?Q?4spbM/knS5Ieu6RbnWYRBgv+HhL2z6mH/4nUbpXDzWou+rC2msa/yRLVDYRd?=
 =?us-ascii?Q?sw8rhorBaQrx5WS2B4x61G8Wt117r1Xc4i/XmXJhwm93HVeX3eYP6H0QtPe/?=
 =?us-ascii?Q?gA7PlIjT8z/dfsCG5qdcqATm0+xPOEvKdNhzrU5kosdoO5SyHNMMcTk7i0vp?=
 =?us-ascii?Q?4Jgh+g57buuYcgoucmIBFBuYnz5c8MNO6nkg9oOC4wWUivner+e4UfoiYfet?=
 =?us-ascii?Q?SWPt9KEcRWG1wp12PAb8t6UGGgMSSx/TfwjSOkCWp3ChDBO+DRBcnA/diEN+?=
 =?us-ascii?Q?5PNMU45oU65olTM97W8CUVZnmQBvzAgU13ZovGEliRBN468EBIf5fXu2qW7K?=
 =?us-ascii?Q?/IjPtpql4OvuZL7RE0fpDTkOTshMN30vUI8fKwkzccDK0yQDXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvTUa/Ry+Ya4i97Sufo6OcTgN9cGnMEY3ivH1d41CAU7V0kGWSNfTWu1wcgo?=
 =?us-ascii?Q?yPdrOYF8NI0YifmQX2/sJ/N2PLzK3eiHqo2khDfrlw14aMGxwsgLCpV4cZVq?=
 =?us-ascii?Q?QnUTxzO52/zb9xmXHicHW3wrqkRnbWQJ+OXfagMOXg9Vo9PJ2JbZckl4h7R4?=
 =?us-ascii?Q?XlQMdgUEmrO4cUA7lQI8vx4B67SkYODTJZlOvSLRYhEKe3b2jlv32AsgMY91?=
 =?us-ascii?Q?kD9rrLgAiSskzG1OEOwPcr5dED5mQRDG0+7+ylQE1Wo1AsX1IEOOlbnlnYC1?=
 =?us-ascii?Q?kHbqgBGGl2HDbm5GoKyBrgLdy907bAw3xwKtPaDNzwepxTrxCKL1rPDta3OJ?=
 =?us-ascii?Q?f21wSjWc96DJnqUmUwEsgzGMPqD3wKyMnysi27eGlk+iChkx1fXCdqdzquXA?=
 =?us-ascii?Q?JjpQD1S8tUXK3bbw5CGfroJkb9xc8fncsu0H6MX9W3Rf40KD8Z5YlXFCdKHC?=
 =?us-ascii?Q?5RgY4sILv3OOM1iKbDBRkmL4VjNaqfDDTlG1K6dpNk73TSiOo3frddgrypAL?=
 =?us-ascii?Q?AcbGfBSWCoaHO8JyMjxYg0iLw9PATpdcibQrN+Z8mJfuHG0ZRBNiQe+he4ls?=
 =?us-ascii?Q?QJt/dQOeOd37eSBTF3Tk5Jg2FkIy/jyju8TUtHNed/op6CaGwqKjSwFS+dGL?=
 =?us-ascii?Q?m5zzt9eHEmUVm1/CmDRXRRfHCdmYoy3Hdex/0BJvnDEZkna/MZz5wA9bAtMG?=
 =?us-ascii?Q?XWo1WHLYiz5CL0Hk88nF91bf9qv7YoDKDLizVm0cSAqyYd3NRf1shWgKfIXw?=
 =?us-ascii?Q?79ZYXFMxvlHAG0WqRZ5YKLI8lALdsns3CcBAdVpRT967/PximSl60teAO1Jf?=
 =?us-ascii?Q?YZzq2l1ZtjqMwRWbsYzXnJoY/hYh9K1/J3TNEfW0YDgkvWf0vxS91GCy4Wio?=
 =?us-ascii?Q?fZIS9cWhgczu6e3/HL8Y8zehKnwdnQQ8peb0THexFKrLbXV5KW/lIl6HFMAT?=
 =?us-ascii?Q?czbeYXLQG055lbR0qJNT9QS0/V5Np6QyTJxuQqr3IzLDQgYRdCIJQLZCZB63?=
 =?us-ascii?Q?amd0FZK6RUidigHtM6+oJaDPzcUZjvd22uMqYYGwdpifzeWW5FwWVFbLokiQ?=
 =?us-ascii?Q?/pZTj+Ft34NoIOYjDmGs3JQbZnmUSUOGcN099SuVtDcLqInOfHfRgOaOKTgw?=
 =?us-ascii?Q?/8mM2CwSzpWQMmZXoIRdbPM65U6lBM6zUYW0AmcTIrnojJ/xol28mCFADyoG?=
 =?us-ascii?Q?mWvfiQ74dD0Q1nxwuFWZP+L/xHpDmLPNSd0w3NxdiiAYA0aDilkaqq29msW9?=
 =?us-ascii?Q?w7Li+17D4exL7qp66lcl1xt8KLseRsI0jm1IB0vgKankSNgcJajfIlU4i1dj?=
 =?us-ascii?Q?aYQu0n1Nhf/2rF4CIKSDvmfXqYfPo2LeII7pj+D0Bml6RZPNKvq4MSmBTrDl?=
 =?us-ascii?Q?ds2hAhBy1oqIQjDJBSdM1tcVa+ZhkVGPP0Ua4j5T8Rf54B1hAUnsTQh4NKnm?=
 =?us-ascii?Q?nPTCfbckbbbbZ14wRxxbCpZvzLHfhPOe4ClMlR5ILZ2pc0e2uRyol+zviE5E?=
 =?us-ascii?Q?gPlXtHS4aA9OpSiM0byh0xqEAdNYgkB6yhEt7HsXrSGd3amJsTXe1Z7ksTKM?=
 =?us-ascii?Q?D94OXHPrVfjS5TVP6TZ7IYdijjCcsumlR2RsNvoK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72af517-adfc-47a5-54ce-08dccbf42326
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:41:00.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3NnmjS+7yHCfCdIdtBt2RIyazDKeHEsTU6weDPgvBbd8qeoYF79R7kO25Nb2NKQ5QEi9vx5R8BcG2nDY6UMzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6253

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


