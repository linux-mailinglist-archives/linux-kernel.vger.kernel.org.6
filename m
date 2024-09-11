Return-Path: <linux-kernel+bounces-324131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FCE97483F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3E42885E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4762D7B8;
	Wed, 11 Sep 2024 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="lAkmnFyF"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA029CFB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726022502; cv=fail; b=O/QT1n9SU9Q+AP2Id9chXvJgGx9zIvtm91Sz/GK3L4UKGDaItdbOfa0kqt++8i3aIerzxirGc++1+aO/ZT7pSAsYgMA96ybvs6JTXzHgCpnroJS+fXrY2y24MzyNGQrN4R/La664PhGH3hK/8dVnIaZKXw6ZowLB2UOBkncka6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726022502; c=relaxed/simple;
	bh=982MIbF+pMVHCSMMq1eTqq1jWSKMfZek8pJsqns7mS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD5ULP3uObaPajWu0isEA4Sl5b7Xxk/hWgsuHYrh04Z70ewCFUfNKzCGXw8ppkNDl4dEkW5LBnFwov5RGOaL8yYoTt+8v7OSNdAuDIRX8iaXA/u0O1oqAkcsD9I1cq6bOjNBZVeM5CqwGcc3VmKfnOShBvnpynf8njOhWwtqnH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=lAkmnFyF; arc=fail smtp.client-ip=40.107.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgUII3xOxDwmYFBa8feTkvll0vul0ENwAGPseGWlp8gsrcC+MR1WX53W1jSVF4luwL7kzTYv9VA/jKYnwBaKfAkd/+jJNxfvQ3Q6Z0ABY7Nfz4QF90nlDtNdOgHzSdC8LI8TAB0YpRdopt4t7Q9UZk+oJFwBBrnLbBnXZxwLVU4Tgl8QMDEsE2DFGz+1r6jCGl5z/559ShI5K3pGk15vMwN6r7HU0K2fS/OlvC89uJxJ3VR6Pq/BOUotQm+4WZDlSKo+Vleytn/Q4kq0gE2llkk65tWtbIFjpZE0yJ/+aq6obMnu2/3YGThfE5cYt3MRtYZ8qJWHsWVXXVN2DHz6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oJi5Tsc5XQZVx6Qgy+PcZpLe/on1RX6iAt1S6MS0Co=;
 b=PNWc52zZse7MTLVXGr5rs532G55TCA+SKCfFAuVFZKzUwoTJaqSZ8ManRSiUQM1v15krWU/Um+fjZx670pg6vbTAXJOTdBChoCymKKKX+vGehU6AWoEstHDn0AT9Ec5MidaNparsR1dcmVAofwM0S8f12lVgUGBNF+DGenGPfDkEBfDYiXa36L/DvrtoG1oZ2DEEAboT+64gX5Nmg9M10QMs/u4cMWs5AqKtZ+apXVUZfek0zwRjKd6OKPaHsN8BtYmxUs3Sr/ynyRbrQ3rJeECfD39+dQF9o8UwunH0Ql7/keLPFwCvaGcSy251ZLUahCRDJYpAhIKYTvc915Ja/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=kernel.org smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oJi5Tsc5XQZVx6Qgy+PcZpLe/on1RX6iAt1S6MS0Co=;
 b=lAkmnFyFHN6qunTaO6LXl/nBVy5YS8jkN/TOCPGvnYcDmIyUDVqvjIlJ3dDhzESuQdcl6EnDoRo9+LzEOc/LdOd5mhKQGZwCcdbdZ7S8F5+/msx3AwSQwDhvW9YwZd3QWwa05V7hcAax7fdQsvxYQXLULmeLNNeApImEC7FE6Vk=
Received: from PUZP153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:301:c2::16)
 by SEZPR02MB5781.apcprd02.prod.outlook.com (2603:1096:101:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 02:41:34 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:301:c2:cafe::5c) by PUZP153CA0004.outlook.office365.com
 (2603:1096:301:c2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.6 via Frontend
 Transport; Wed, 11 Sep 2024 02:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 02:41:34 +0000
Received: from cndgdcavdu0c-218-29.172.16.40.114 (172.16.40.118) by
 mailappw30.adc.com (172.16.56.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Sep 2024 10:41:23 +0800
From: <liuderong@oppo.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	liuderong <liuderong@oppo.com>
Subject: [PATCH v1 1/2] f2fs: remove unused parameters
Date: Wed, 11 Sep 2024 10:40:20 +0800
Message-ID: <1726022421-58677-2-git-send-email-liuderong@oppo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1726022421-58677-1-git-send-email-liuderong@oppo.com>
References: <1726022421-58677-1-git-send-email-liuderong@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEZPR02MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 3204d60e-e623-4ad3-ebc0-08dcd20b4027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nAT8u8J/TbHzL5aZQdDe9nVEVsJElWLLw1to2yjgXeUelZ4sc87a3zzlmfDQ?=
 =?us-ascii?Q?Skai/K6WesaUD1aeHwIXDddYcmfGz2BjRm6LswCydhUkvFr1ynOb8woSdxGj?=
 =?us-ascii?Q?UlENCKHxYywMyNsPv/CuZjfmfGkNwONlJ2DDN6HRKKvu6BTfDJ98M8Nswv9E?=
 =?us-ascii?Q?SVGTOD/SGzcRtYNV/SVbOxlxspyLHqms7xNXso/fTH5vA/79dY/Q43ln4sjr?=
 =?us-ascii?Q?ywHwad1UcevLeQEThUMhmmzUNm4LlCUYZCjdb0Don4aw1sHVRTQaFEWGis4F?=
 =?us-ascii?Q?6j3xnfRCKqq7/m690O8/bnGNGxsEEQeFQxnTjXS6bZMiYu1Dwv70Y4W2DXY8?=
 =?us-ascii?Q?dvlNs5b+criNvxqsiozKLf9AgsUsDFrJ2BpG1c9zgNvzbpS+J2m1R4vQwbmi?=
 =?us-ascii?Q?RqHv9xPXFJl+koWWUMPmpAflcgJFsGE4eBzR54vHitymdJPpCx0SeGeJ8Tyo?=
 =?us-ascii?Q?SHLez0mxJ1PvhhLubvFs0W5/eDM7ccYcqRS43Im8nJtTGekx5HethDfIrQS4?=
 =?us-ascii?Q?ocVaa2WVaveZWgs0NpCxU1ulsMm8rFbCdCXOzoGDSP0jk4DiEQX4Z5LtjDwc?=
 =?us-ascii?Q?TZEmgUv78njUml3GCWUfdS7j5FeBhObfvOdMRccpiNUKSgPBM3Xi5K/puaML?=
 =?us-ascii?Q?F9FN4Qa70FLl0uVvAlwwy8FxkoMX+ewKY6K/CxYjSJ43gHEg1DZDtZS2opGv?=
 =?us-ascii?Q?ugNAXIgBM4TzYJBLxca4AFjWKp3pw9VBe9NaBHqMSLqh+Ekl69/Ia3iLRLyv?=
 =?us-ascii?Q?di3KNikYWbz7zaMyEbRj26CgocBLVZ9L/NDGLPAatoAesLSeIA5Ch5zYo52z?=
 =?us-ascii?Q?SOBueTk0BHtfP3KS8F+m6XciqBhYrOJeV7EDJ3bTPfmpV6kNE5RpiJGKXJyF?=
 =?us-ascii?Q?mnuejGiU/aKPqX+JbLRLg0K0h5XKzOoCRPSNOlt+M0r7L/0mGJZZEVGVE9A4?=
 =?us-ascii?Q?NRGsNzLvcfdsZHXg+McusLRTZ/5Seq/F9eH7ZHHgpEdxhiGR3yTP5q2pRAN/?=
 =?us-ascii?Q?JOdhW2QX8u7IhcqEYxXcX3D92Rjpx1fbjbNWXgNt+9MEJhCB20kGSSazTul4?=
 =?us-ascii?Q?wHqfewvFSVKtkzBf135H0DHWBy+QqH6kO7JKFB9GQDwh8oYP+AWveARoK3Zg?=
 =?us-ascii?Q?oKZ5p9ngaE8s2/AZRHIpBmfcsI+KS9Ex/qDDjtZEFJ20qlGuE9YEukNUnXH5?=
 =?us-ascii?Q?sDLmwC/VOkxzQoEKHPuLrSks6ZkkQq9ckMLm3Vdq6ETtLgOELQOrhZ3rr8TR?=
 =?us-ascii?Q?OKgxwh4k0Z8tS0NdjzJ77MGtcxeNsA7EDH0LteFGvCAtZQ/ghp8D1kFsRuLe?=
 =?us-ascii?Q?meuOv8i2HIzgDYiMBPgojSMvFBD4/Y2FYW04WRL8+PF6n5+7RTfG8qNFpiSn?=
 =?us-ascii?Q?fv4KEo/g8o2gE7nIInJ0UE3wN8PSBcRzISD6SlxN1mAUpZs22hCRxxeZQjsu?=
 =?us-ascii?Q?zqZ9hZ6NyLH5JUWOysAT+VTUbpbm3YSe?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 02:41:34.0880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3204d60e-e623-4ad3-ebc0-08dcd20b4027
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5781

From: liuderong <liuderong@oppo.com>

Remove unused parameter segno from f2fs_usable_segs_in_sec.

Signed-off-by: liuderong <liuderong@oppo.com>
---
 fs/f2fs/f2fs.h    | 3 +--
 fs/f2fs/gc.c      | 6 +++---
 fs/f2fs/segment.c | 3 +--
 fs/f2fs/segment.h | 4 ++--
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac19c61..4dcdcdd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3759,8 +3759,7 @@ void f2fs_destroy_segment_manager_caches(void);
 int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint);
 enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
                        enum page_type type, enum temp_type temp);
-unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
-                       unsigned int segno);
+unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
 unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
                        unsigned int segno);

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 724bbcb..6299639 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -339,7 +339,7 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sb=
i, unsigned int segno)
        unsigned char age =3D 0;
        unsigned char u;
        unsigned int i;
-       unsigned int usable_segs_per_sec =3D f2fs_usable_segs_in_sec(sbi, s=
egno);
+       unsigned int usable_segs_per_sec =3D f2fs_usable_segs_in_sec(sbi);

        for (i =3D 0; i < usable_segs_per_sec; i++)
                mtime +=3D get_seg_entry(sbi, start + i)->mtime;
@@ -1707,7 +1707,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sb=
i,
         */
        if (f2fs_sb_has_blkzoned(sbi))
                end_segno -=3D SEGS_PER_SEC(sbi) -
-                                       f2fs_usable_segs_in_sec(sbi, segno)=
;
+                                       f2fs_usable_segs_in_sec(sbi);

        sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);

@@ -1881,7 +1881,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_=
control *gc_control)

        total_freed +=3D seg_freed;

-       if (seg_freed =3D=3D f2fs_usable_segs_in_sec(sbi, segno)) {
+       if (seg_freed =3D=3D f2fs_usable_segs_in_sec(sbi)) {
                sec_freed++;
                total_sec_freed++;
        }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198..6627394 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5381,8 +5381,7 @@ unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_i=
nfo *sbi,
        return BLKS_PER_SEG(sbi);
 }

-unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
-                                       unsigned int segno)
+unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi)
 {
        if (f2fs_sb_has_blkzoned(sbi))
                return CAP_SEGS_PER_SEC(sbi);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index bfc01a5..9e61ded 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -430,7 +430,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi,=
 unsigned int segno)
        unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
        unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
        unsigned int next;
-       unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
+       unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi);

        spin_lock(&free_i->segmap_lock);
        clear_bit(segno, free_i->free_segmap);
@@ -464,7 +464,7 @@ static inline void __set_test_and_free(struct f2fs_sb_i=
nfo *sbi,
        unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
        unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
        unsigned int next;
-       unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
+       unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi);

        spin_lock(&free_i->segmap_lock);
        if (test_and_clear_bit(segno, free_i->free_segmap)) {
--
2.7.4

________________________________
OPPO

=C2=B1=C2=BE=C2=B5=C3=A7=C3=97=C3=93=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=
=86=C3=A4=C2=B8=C2=BD=C2=BC=C3=BE=C2=BA=C2=AC=C3=93=C3=90OPPO=C2=B9=C2=AB=
=C3=8B=C2=BE=C2=B5=C3=84=C2=B1=C2=A3=C3=83=C3=9C=C3=90=C3=85=C3=8F=C2=A2=C2=
=A3=C2=AC=C2=BD=C3=B6=C3=8F=C3=9E=C3=93=C3=9A=C3=93=C3=8A=C2=BC=C3=BE=C3=96=
=C2=B8=C3=83=C3=B7=C2=B5=C3=84=C3=8A=C3=95=C2=BC=C3=BE=C3=88=C3=8B=C2=A3=C2=
=A8=C2=B0=C3=BC=C2=BA=C2=AC=C2=B8=C3=B6=C3=88=C3=8B=C2=BC=C2=B0=C3=88=C2=BA=
=C3=97=C3=A9=C2=A3=C2=A9=C3=8A=C2=B9=C3=93=C3=83=C2=A1=C2=A3=C2=BD=C3=BB=C3=
=96=C2=B9=C3=88=C3=8E=C2=BA=C3=8E=C3=88=C3=8B=C3=94=C3=9A=C3=8E=C2=B4=C2=BE=
=C2=AD=C3=8A=C3=9A=C3=88=C2=A8=C2=B5=C3=84=C3=87=C3=A9=C2=BF=C3=B6=C3=8F=C3=
=82=C3=92=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C3=90=C3=8E=C3=8A=C2=BD=C3=8A=C2=B9=
=C3=93=C3=83=C2=A1=C2=A3=C3=88=C3=A7=C2=B9=C3=BB=C3=84=C3=BA=C2=B4=C3=AD=C3=
=8A=C3=95=C3=81=C3=8B=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=A3=C2=AC=C3=87=
=C3=90=C3=8E=C3=B0=C2=B4=C2=AB=C2=B2=C2=A5=C2=A1=C2=A2=C2=B7=C3=96=C2=B7=C2=
=A2=C2=A1=C2=A2=C2=B8=C2=B4=C3=96=C3=86=C2=A1=C2=A2=C3=93=C2=A1=C3=8B=C2=A2=
=C2=BB=C3=B2=C3=8A=C2=B9=C3=93=C3=83=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C3=
=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C2=B2=C2=BF=C2=B7=C3=96=C2=BB=C3=B2=C3=86=
=C3=A4=C3=8B=C3=B9=C3=94=C3=98=C3=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C3=84=C3=
=9A=C3=88=C3=9D=C2=A3=C2=AC=C2=B2=C2=A2=C3=87=C3=AB=C3=81=C2=A2=C2=BC=C2=B4=
=C3=92=C3=94=C2=B5=C3=A7=C3=97=C3=93=C3=93=C3=8A=C2=BC=C3=BE=C3=8D=C2=A8=C3=
=96=C2=AA=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C2=B2=C2=A2=C3=89=C2=BE=C2=B3=
=C3=BD=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=86=C3=A4=C2=B8=C2=
=BD=C2=BC=C3=BE=C2=A1=C2=A3
=C3=8D=C3=B8=C3=82=C3=A7=C3=8D=C2=A8=C3=91=C2=B6=C2=B9=C3=8C=C3=93=C3=90=C3=
=88=C2=B1=C3=8F=C3=9D=C2=BF=C3=89=C3=84=C3=9C=C2=B5=C2=BC=C3=96=C3=82=C3=93=
=C3=8A=C2=BC=C3=BE=C2=B1=C2=BB=C2=BD=C3=98=C3=81=C3=B4=C2=A1=C2=A2=C3=90=C3=
=9E=C2=B8=C3=84=C2=A1=C2=A2=C2=B6=C2=AA=C3=8A=C2=A7=C2=A1=C2=A2=C3=86=C3=86=
=C2=BB=C2=B5=C2=BB=C3=B2=C2=B0=C3=BC=C2=BA=C2=AC=C2=BC=C3=86=C3=8B=C3=A3=C2=
=BB=C3=BA=C2=B2=C2=A1=C2=B6=C2=BE=C2=B5=C3=88=C2=B2=C2=BB=C2=B0=C2=B2=C3=88=
=C2=AB=C3=87=C3=A9=C2=BF=C3=B6=C2=A3=C2=ACOPPO=C2=B6=C3=94=C2=B4=C3=8B=C3=
=80=C3=A0=C2=B4=C3=AD=C3=8E=C3=B3=C2=BB=C3=B2=C3=92=C3=85=C3=82=C2=A9=C2=B6=
=C3=B8=C3=92=C3=BD=C3=96=C3=82=C3=96=C2=AE=C3=88=C3=8E=C2=BA=C3=8E=C3=8B=C3=
=B0=C3=8A=C2=A7=C2=B8=C3=85=C2=B2=C2=BB=C2=B3=C3=90=C2=B5=C2=A3=C3=94=C3=B0=
=C3=88=C3=8E=C2=B2=C2=A2=C2=B1=C2=A3=C3=81=C3=B4=C3=93=C3=AB=C2=B1=C2=BE=C3=
=93=C3=8A=C2=BC=C3=BE=C3=8F=C3=A0=C2=B9=C3=98=C3=96=C2=AE=C3=92=C2=BB=C3=87=
=C3=90=C3=88=C2=A8=C3=80=C3=BB=C2=A1=C2=A3
=C2=B3=C3=BD=C2=B7=C3=87=C3=83=C3=B7=C3=88=C2=B7=C3=8B=C2=B5=C3=83=C3=B7=C2=
=A3=C2=AC=C2=B1=C2=BE=C3=93=C3=8A=C2=BC=C3=BE=C2=BC=C2=B0=C3=86=C3=A4=C2=B8=
=C2=BD=C2=BC=C3=BE=C3=8E=C3=9E=C3=92=C3=A2=C3=97=C3=B7=C3=8E=C2=AA=C3=94=C3=
=9A=C3=88=C3=8E=C2=BA=C3=8E=C2=B9=C3=BA=C2=BC=C3=92=C2=BB=C3=B2=C2=B5=C3=98=
=C3=87=C3=B8=C3=96=C2=AE=C3=92=C2=AA=C3=94=C2=BC=C2=A1=C2=A2=C3=95=C3=90=C3=
=80=C2=BF=C2=BB=C3=B2=C2=B3=C3=90=C3=85=C2=B5=C2=A3=C2=AC=C3=92=C3=A0=C3=8E=
=C3=9E=C3=92=C3=A2=C3=97=C3=B7=C3=8E=C2=AA=C3=88=C3=8E=C2=BA=C3=8E=C2=BD=C2=
=BB=C3=92=C3=97=C2=BB=C3=B2=C2=BA=C3=8F=C3=8D=C2=AC=C3=96=C2=AE=C3=95=C3=BD=
=C3=8A=C2=BD=C3=88=C2=B7=C3=88=C3=8F=C2=A1=C2=A3 =C2=B7=C2=A2=C2=BC=C3=BE=
=C3=88=C3=8B=C2=A1=C2=A2=C3=86=C3=A4=C3=8B=C3=B9=C3=8A=C3=B4=C2=BB=C3=BA=C2=
=B9=C2=B9=C2=BB=C3=B2=C3=8B=C3=B9=C3=8A=C3=B4=C2=BB=C3=BA=C2=B9=C2=B9=C3=96=
=C2=AE=C2=B9=C3=98=C3=81=C2=AA=C2=BB=C3=BA=C2=B9=C2=B9=C2=BB=C3=B2=C3=88=C3=
=8E=C2=BA=C3=8E=C3=89=C3=8F=C3=8A=C3=B6=C2=BB=C3=BA=C2=B9=C2=B9=C3=96=C2=AE=
=C2=B9=C3=89=C2=B6=C2=AB=C2=A1=C2=A2=C2=B6=C2=AD=C3=8A=C3=82=C2=A1=C2=A2=C2=
=B8=C3=9F=C2=BC=C2=B6=C2=B9=C3=9C=C3=80=C3=AD=C3=88=C3=8B=C3=94=C2=B1=C2=A1=
=C2=A2=C3=94=C2=B1=C2=B9=C2=A4=C2=BB=C3=B2=C3=86=C3=A4=C3=8B=C3=BB=C3=88=C3=
=8E=C2=BA=C3=8E=C3=88=C3=8B=C2=A3=C2=A8=C3=92=C3=94=C3=8F=C3=82=C2=B3=C3=86=
=C2=A1=C2=B0=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C2=A1=C2=B1=C2=BB=C3=B2=C2=
=A1=C2=B0OPPO=C2=A1=C2=B1=C2=A3=C2=A9=C2=B2=C2=BB=C3=92=C3=B2=C2=B1=C2=BE=
=C3=93=C3=8A=C2=BC=C3=BE=C3=96=C2=AE=C3=8E=C3=B3=C3=8B=C3=8D=C2=B6=C3=B8=C2=
=B7=C3=85=C3=86=C3=BA=C3=86=C3=A4=C3=8B=C3=B9=C3=8F=C3=AD=C3=96=C2=AE=C3=88=
=C3=8E=C2=BA=C3=8E=C3=88=C2=A8=C3=80=C3=BB=C2=A3=C2=AC=C3=92=C3=A0=C2=B2=C2=
=BB=C2=B6=C3=94=C3=92=C3=B2=C2=B9=C3=8A=C3=92=C3=A2=C2=BB=C3=B2=C2=B9=C3=BD=
=C3=8A=C2=A7=C3=8A=C2=B9=C3=93=C3=83=C2=B8=C3=83=C2=B5=C3=88=C3=90=C3=85=C3=
=8F=C2=A2=C2=B6=C3=B8=C3=92=C3=BD=C2=B7=C2=A2=C2=BB=C3=B2=C2=BF=C3=89=C3=84=
=C3=9C=C3=92=C3=BD=C2=B7=C2=A2=C2=B5=C3=84=C3=8B=C3=B0=C3=8A=C2=A7=C2=B3=C3=
=90=C2=B5=C2=A3=C3=88=C3=8E=C2=BA=C3=8E=C3=94=C3=B0=C3=88=C3=8E=C2=A1=C2=A3
=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=C3=AE=C3=92=C3=AC=C3=85=C3=BB=C3=82=C2=B6=C2=
=A3=C2=BA=C3=92=C3=B2=C3=88=C2=AB=C3=87=C3=B2=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=
=C3=AE=C3=92=C3=AC=C3=93=C2=B0=C3=8F=C3=AC=C2=A3=C2=AC=C2=B5=C2=A5=C2=B4=C2=
=BF=C3=92=C3=94YES\OK=C2=BB=C3=B2=C3=86=C3=A4=C3=8B=C3=BB=C2=BC=C3=B2=C2=B5=
=C2=A5=C2=B4=C3=8A=C2=BB=C3=A3=C2=B5=C3=84=C2=BB=C3=98=C2=B8=C2=B4=C2=B2=C2=
=A2=C2=B2=C2=BB=C2=B9=C2=B9=C2=B3=C3=89=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=
=C2=B6=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C2=BD=C2=BB=C3=92=C3=97=C2=BB=C3=B2=C2=
=BA=C3=8F=C3=8D=C2=AC=C3=96=C2=AE=C3=95=C3=BD=C3=8A=C2=BD=C3=88=C2=B7=C3=88=
=C3=8F=C2=BB=C3=B2=C2=BD=C3=93=C3=8A=C3=9C=C2=A3=C2=AC=C3=87=C3=AB=C3=93=C3=
=AB=C2=B7=C2=A2=C2=BC=C3=BE=C3=88=C3=8B=C3=94=C3=99=C2=B4=C3=8E=C3=88=C2=B7=
=C3=88=C3=8F=C3=92=C3=94=C2=BB=C3=B1=C2=B5=C3=83=C3=83=C3=B7=C3=88=C2=B7=C3=
=8A=C3=A9=C3=83=C3=A6=C3=92=C3=A2=C2=BC=C3=BB=C2=A1=C2=A3=C2=B7=C2=A2=C2=BC=
=C3=BE=C3=88=C3=8B=C2=B2=C2=BB=C2=B6=C3=94=C3=88=C3=8E=C2=BA=C3=8E=C3=8A=C3=
=9C=C3=8E=C3=84=C2=BB=C2=AF=C2=B2=C3=AE=C3=92=C3=AC=C3=93=C2=B0=C3=8F=C3=AC=
=C2=B6=C3=B8=C2=B5=C2=BC=C3=96=C3=82=C2=B9=C3=8A=C3=92=C3=A2=C2=BB=C3=B2=C2=
=B4=C3=AD=C3=8E=C3=B3=C3=8A=C2=B9=C3=93=C3=83=C2=B8=C3=83=C2=B5=C3=88=C3=90=
=C3=85=C3=8F=C2=A2=C3=8B=C3=B9=C3=94=C3=AC=C2=B3=C3=89=C2=B5=C3=84=C3=88=C3=
=8E=C2=BA=C3=8E=C3=96=C2=B1=C2=BD=C3=93=C2=BB=C3=B2=C2=BC=C3=A4=C2=BD=C3=93=
=C3=8B=C3=B0=C2=BA=C2=A6=C2=B3=C3=90=C2=B5=C2=A3=C3=94=C3=B0=C3=88=C3=8E=C2=
=A1=C2=A3
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.
________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=88=E5=8C=85=E5=90=
=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=E4=BD=BF=E7=94=A8=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E5=
=88=87=E5=8B=BF=E4=BC=A0=E6=92=AD=E3=80=81=E5=88=86=E5=8F=91=E3=80=81=E5=A4=
=8D=E5=88=B6=E3=80=81=E5=8D=B0=E5=88=B7=E6=88=96=E4=BD=BF=E7=94=A8=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E4=B9=8B=E4=BB=BB=E4=BD=95=E9=83=A8=E5=88=86=E6=88=96=E5=
=85=B6=E6=89=80=E8=BD=BD=E4=B9=8B=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=
=8C=E5=B9=B6=E8=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=
=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=
=82
=E7=BD=91=E7=BB=9C=E9=80=9A=E8=AE=AF=E5=9B=BA=E6=9C=89=E7=BC=BA=E9=99=B7=E5=
=8F=AF=E8=83=BD=E5=AF=BC=E8=87=B4=E9=82=AE=E4=BB=B6=E8=A2=AB=E6=88=AA=E7=95=
=99=E3=80=81=E4=BF=AE=E6=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E3=80=81=E7=A0=B4=
=E5=9D=8F=E6=88=96=E5=8C=85=E5=90=AB=E8=AE=A1=E7=AE=97=E6=9C=BA=E7=97=85=E6=
=AF=92=E7=AD=89=E4=B8=8D=E5=AE=89=E5=85=A8=E6=83=85=E5=86=B5=EF=BC=8COPPO=
=E5=AF=B9=E6=AD=A4=E7=B1=BB=E9=94=99=E8=AF=AF=E6=88=96=E9=81=97=E6=BC=8F=E8=
=80=8C=E5=BC=95=E8=87=B4=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=8D=9F=E5=A4=B1=E6=A6=
=82=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E5=B9=B6=E4=BF=9D=E7=95=99=
=E4=B8=8E=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9B=B8=E5=85=B3=E4=B9=8B=E4=B8=80=E5=
=88=87=E6=9D=83=E5=88=A9=E3=80=82
=E9=99=A4=E9=9D=9E=E6=98=8E=E7=A1=AE=E8=AF=B4=E6=98=8E=EF=BC=8C=E6=9C=AC=E9=
=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E6=97=A0=E6=84=8F=E4=BD=
=9C=E4=B8=BA=E5=9C=A8=E4=BB=BB=E4=BD=95=E5=9B=BD=E5=AE=B6=E6=88=96=E5=9C=B0=
=E5=8C=BA=E4=B9=8B=E8=A6=81=E7=BA=A6=E3=80=81=E6=8B=9B=E6=8F=BD=E6=88=96=E6=
=89=BF=E8=AF=BA=EF=BC=8C=E4=BA=A6=E6=97=A0=E6=84=8F=E4=BD=9C=E4=B8=BA=E4=BB=
=BB=E4=BD=95=E4=BA=A4=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=
=E5=BC=8F=E7=A1=AE=E8=AE=A4=E3=80=82 =E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=81=
=E5=85=B6=E6=89=80=E5=B1=9E=E6=9C=BA=E6=9E=84=E6=88=96=E6=89=80=E5=B1=9E=E6=
=9C=BA=E6=9E=84=E4=B9=8B=E5=85=B3=E8=81=94=E6=9C=BA=E6=9E=84=E6=88=96=E4=BB=
=BB=E4=BD=95=E4=B8=8A=E8=BF=B0=E6=9C=BA=E6=9E=84=E4=B9=8B=E8=82=A1=E4=B8=9C=
=E3=80=81=E8=91=A3=E4=BA=8B=E3=80=81=E9=AB=98=E7=BA=A7=E7=AE=A1=E7=90=86=E4=
=BA=BA=E5=91=98=E3=80=81=E5=91=98=E5=B7=A5=E6=88=96=E5=85=B6=E4=BB=96=E4=BB=
=BB=E4=BD=95=E4=BA=BA=EF=BC=88=E4=BB=A5=E4=B8=8B=E7=A7=B0=E2=80=9C=E5=8F=91=
=E4=BB=B6=E4=BA=BA=E2=80=9D=E6=88=96=E2=80=9COPPO=E2=80=9D=EF=BC=89=E4=B8=
=8D=E5=9B=A0=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B9=8B=E8=AF=AF=E9=80=81=E8=80=8C=
=E6=94=BE=E5=BC=83=E5=85=B6=E6=89=80=E4=BA=AB=E4=B9=8B=E4=BB=BB=E4=BD=95=E6=
=9D=83=E5=88=A9=EF=BC=8C=E4=BA=A6=E4=B8=8D=E5=AF=B9=E5=9B=A0=E6=95=85=E6=84=
=8F=E6=88=96=E8=BF=87=E5=A4=B1=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=BF=A1=
=E6=81=AF=E8=80=8C=E5=BC=95=E5=8F=91=E6=88=96=E5=8F=AF=E8=83=BD=E5=BC=95=E5=
=8F=91=E7=9A=84=E6=8D=9F=E5=A4=B1=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=
=A3=E4=BB=BB=E3=80=82
=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E6=8A=AB=E9=9C=B2=EF=BC=9A=E5=9B=A0=E5=
=85=A8=E7=90=83=E6=96=87=E5=8C=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=EF=BC=
=8C=E5=8D=95=E7=BA=AF=E4=BB=A5YES\OK=E6=88=96=E5=85=B6=E4=BB=96=E7=AE=80=E5=
=8D=95=E8=AF=8D=E6=B1=87=E7=9A=84=E5=9B=9E=E5=A4=8D=E5=B9=B6=E4=B8=8D=E6=9E=
=84=E6=88=90=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E4=BA=A4=
=E6=98=93=E6=88=96=E5=90=88=E5=90=8C=E4=B9=8B=E6=AD=A3=E5=BC=8F=E7=A1=AE=E8=
=AE=A4=E6=88=96=E6=8E=A5=E5=8F=97=EF=BC=8C=E8=AF=B7=E4=B8=8E=E5=8F=91=E4=BB=
=B6=E4=BA=BA=E5=86=8D=E6=AC=A1=E7=A1=AE=E8=AE=A4=E4=BB=A5=E8=8E=B7=E5=BE=97=
=E6=98=8E=E7=A1=AE=E4=B9=A6=E9=9D=A2=E6=84=8F=E8=A7=81=E3=80=82=E5=8F=91=E4=
=BB=B6=E4=BA=BA=E4=B8=8D=E5=AF=B9=E4=BB=BB=E4=BD=95=E5=8F=97=E6=96=87=E5=8C=
=96=E5=B7=AE=E5=BC=82=E5=BD=B1=E5=93=8D=E8=80=8C=E5=AF=BC=E8=87=B4=E6=95=85=
=E6=84=8F=E6=88=96=E9=94=99=E8=AF=AF=E4=BD=BF=E7=94=A8=E8=AF=A5=E7=AD=89=E4=
=BF=A1=E6=81=AF=E6=89=80=E9=80=A0=E6=88=90=E7=9A=84=E4=BB=BB=E4=BD=95=E7=9B=
=B4=E6=8E=A5=E6=88=96=E9=97=B4=E6=8E=A5=E6=8D=9F=E5=AE=B3=E6=89=BF=E6=8B=85=
=E8=B4=A3=E4=BB=BB=E3=80=82
This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you ar=
e not the intended recipient, please do not read, copy, distribute, or use =
this information. If you have received this transmission in error, please n=
otify the sender immediately by reply e-mail and then delete this message.
Electronic communications may contain computer viruses or other defects inh=
erently, may not be accurately and/or timely transmitted to other systems, =
or may be intercepted, modified ,delayed, deleted or interfered. OPPO shall=
 not be liable for any damages that arise or may arise from such matter and=
 reserves all rights in connection with the email.
Unless expressly stated, this e-mail and its attachments are provided witho=
ut any warranty, acceptance or promise of any kind in any country or region=
, nor constitute a formal confirmation or acceptance of any transaction or =
contract. The sender, together with its affiliates or any shareholder, dire=
ctor, officer, employee or any other person of any such institution (herein=
after referred to as "sender" or "OPPO") does not waive any rights and shal=
l not be liable for any damages that arise or may arise from the intentiona=
l or negligent use of such information.
Cultural Differences Disclosure: Due to global cultural differences, any re=
ply with only YES\OK or other simple words does not constitute any confirma=
tion or acceptance of any transaction or contract, please confirm with the =
sender again to ensure clear opinion in written form. The sender shall not =
be responsible for any direct or indirect damages resulting from the intent=
ional or misuse of such information.

