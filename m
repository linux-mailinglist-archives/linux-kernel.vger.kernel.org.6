Return-Path: <linux-kernel+bounces-412865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237549D1053
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC551F218C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45901990AD;
	Mon, 18 Nov 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Xn7ccRUt"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013021.outbound.protection.outlook.com [40.107.44.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF7192593
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931546; cv=fail; b=SrV+OPa1ko+WfTxk3g8iv8XbAc8wl2xWMUh1u23TZM9UgWkHsTloCYPEj9g4kGKrlJ/zj8o1QrXJd4/ad+eiJO3FCD/QZXFp56+WZz2NQSpgpxYJhiKoRU+3xUhvxhh5DKk9tnnUK6YIT7VRih9Q6zZVROD9L65QbFPAR8nKFf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931546; c=relaxed/simple;
	bh=j7HprWoIpGpPQzwIh6E7H1WVQXb45XUu8b3lq5CR8VY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YGExLFUDgMZnOr69jjRScH1nvYxDa8V8L3bmDSBKsd9E9mNyDig4S7jc+4qv+Ed7XzrrM2Qe89lL9HV0ew/ikJGbkV50rbgAkGIzw0kld/xiZ1AM8QByRAxgqFVpckVhA3mmX6XAMhgx7x4WT1T6O/tXaH58VmEWW/18vQSOkAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Xn7ccRUt; arc=fail smtp.client-ip=40.107.44.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ax6nlAb/2WctJ6t0WXxQNoWFeeVac4O5z60Mf2UpgxbJh5GhpHck5G5uAE3y3HAlDUm8HDPORwN0Pav7gIZkCdtgjE718ZqGcBHKzNfdwey/UkHCgjraj/F27DCLO0ysYJwN68OWB4UdT7aeUrPJ+VAGBUCNI35DbUS2sZJFKOxzW8ico1q4AdKT94PA2cWC46Dq0TejALC/ZUYGHA6xwG3fejJ/9ph5KpRet2USUv3mo5DHmaGAyFrmcjbGpfqeRrEXGAtbMzTtp6Zklf0qi4VVZKSJTy+3wsO5KKXlwOdzvteoEdxev+NIZdephNcj86iNK0IfTIsxNixVZ7rF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhqZCPHAOOSYRPmvIeT2rkt1lLWK5UfH1AaPUsweE2U=;
 b=DIuVcE7+28EtZIQR2WpKcSuTgBLbxdt2P61nDAFSh7FZG0dwabu357A8dBUSqn7wIjOCU5zYMq7Xb7PZiU2V75rVwi+XlgN1BybahUvuA4jC9AlJJG5WnTJDkdZBgJMYYsz38rDK5ZKVPx2OD1LUhYQw/vLoQqD1Oq7OpqVIrkfTQuOwwpEK/OCPDhzO1dbY0uM6Pm52DdZyEMhaHtNBOqMOiOhlH2M54UXM1JiTTlF4e7SSn/MHoFkFbJvDBCQpZrUWKbxVUBaAQ9PQoAqA7LD3pw1kw8DltXObXG6k2c9sHDS5gN3Vgv82PKF1J6YdCaVfsMz0Dzd+lCT6aOsf+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhqZCPHAOOSYRPmvIeT2rkt1lLWK5UfH1AaPUsweE2U=;
 b=Xn7ccRUtbmkRQ6gsuf8JFBAzojKK6ky8FBzbmBAyVdmgvoFjTkMADavARlAnSm9WcgcYePENFyVIK7ktBRZfuar+Xe0CYyy9zMY4FCXooc+vIDru8ILDsW5Wk1rdUTZmBdJxeeWJJeBtsrkU6WekfjEcVjOWUPUu22GKIyVoA94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com (2603:1096:101:6b::10)
 by TYZPR02MB5834.apcprd02.prod.outlook.com (2603:1096:400:1d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 12:05:40 +0000
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796]) by SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 12:05:40 +0000
From: Sheng Yong <shengyong@oppo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Song Feng <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH v2 1/2] f2fs: fix changing cursegs if recovery fails on zoned device
Date: Mon, 18 Nov 2024 20:05:16 +0800
Message-Id: <20241118120517.3533055-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To SEYPR02MB6014.apcprd02.prod.outlook.com
 (2603:1096:101:6b::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6014:EE_|TYZPR02MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ad10b0-3c1c-457c-fe96-08dd07c951e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HralO9nQuDgo7cu5DG98xItFscOCFEk597s4PVYx3POuyopEddyYyIec0OV1?=
 =?us-ascii?Q?QBz3rW5bsZGdRHPLkRe6O8aZscrCmfJLbraO10a+QX8jHzfyeHtC22rMFO7o?=
 =?us-ascii?Q?NzlDfcj5gI2J2n/MG8tSuX9q6O+Ac/k8EVMGygJPbb9FdiBwhkIzr6fYrUI/?=
 =?us-ascii?Q?RfyvCNfhwcDIyAof0f4hBRefdRMMutCjr+/9wtw/0Le50BKyJ6AEVgFt0pDz?=
 =?us-ascii?Q?wcdz484mbOkagi4xt2xMFN87GW+qeKoPJpa1hwIwsD3l8a7wzjrQtG1J59wr?=
 =?us-ascii?Q?Hqqp9tnyMwoYJS08IROTTjPakv1E2lH1JcFJSxYQA7cgKpknJ96rT69Jm+fZ?=
 =?us-ascii?Q?jv43DoSQy3dOpsVOc4R9vTaP7PMvi5wIL3WGA/rksMtceFcP+UgwCAlgbYV9?=
 =?us-ascii?Q?W2IKljIp6sUZ3qykby6GJKo58XPQlZhk1cRdvSdMU5bpXfiTFcDvBHY5YJDs?=
 =?us-ascii?Q?nb5NYfjrhmi6ORpS5tSm6t5ssf3KptsEhX88IZYPG6QZELLWIYaMba2d0YgW?=
 =?us-ascii?Q?w1y3kS085scZC/I7IlaBEfOCfmY55rBqV7MlALG94tPJshYjHFaVjbTS0AzE?=
 =?us-ascii?Q?YrNl9Z4Xi9RZ0pBPvyRbmEeEfpIRmfL64Ga8PJTjvLZKbp0Epbde4FVVXBRR?=
 =?us-ascii?Q?qNlI+8dxSeOSTo89Gso2TocpaljSfEjX1l1FIXIPtd5SiflzYXCTvyPs8h31?=
 =?us-ascii?Q?l7CM/vUfPQ4TCBzCmevBRErl9QMsevCFbOPi7JqhFLsttEFLdwWxsSy7xF1l?=
 =?us-ascii?Q?0Y1hpSMfC0/A2r6NM24wSR35APFbhlftVg5qrB35+AZr8hcgKzJT5ARfUMI3?=
 =?us-ascii?Q?VEUVA0KaxT6Cuy4mkoq8Q+4WSiCqK3yHpFASQ2rhYbK9JxiMZAARRGLCInZV?=
 =?us-ascii?Q?k7PZt8dQke5W5zhLPEKHNZMhid/yotDJkeSfeo4RSJnYn27IgbEuJRI4h/eY?=
 =?us-ascii?Q?/eZPG1Yl2pEmSk/U4NAnW+0FUZMsjAniIxba8cc2CX38IftqJN/7pluVnWp/?=
 =?us-ascii?Q?VyYx67uRf0U0tIht/X0JSWW2Uqiz/ur87m7oOcQ6AoFQiK5I+lKeBDwxWXTD?=
 =?us-ascii?Q?s7A1allUWsQvXo0Qm7n13zSOcj7nfwzR50Lp6drg9/g/6ni1ybIE+6mPbNSH?=
 =?us-ascii?Q?0cISgqmC/NuOte2Ky3eqU4SVy6BJVBGscNoYXU+vGy/FuoWFbDqL6Gkic13k?=
 =?us-ascii?Q?fsIO09awj0iYayst/xre8jMcDDyCp0F51icZxix3tujUsudtb0J760/MAk4L?=
 =?us-ascii?Q?3KLMbALIMb+pf/5K/iYwh5OLmtIZIN4deqQPOYoznL8nSp69jAW6weVS9wE1?=
 =?us-ascii?Q?kprGSwokG8/lOoJBV5SNmo+wCArJ7plXUd2ogmFJWlXNExnkCTL7VV4UseD3?=
 =?us-ascii?Q?y1MLvBY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6014.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DChuRx7QLTiFPsWIYjJRJBvdKeNMNtmCAFDEexj3yLnG+fhpZtLSwwe0Psv6?=
 =?us-ascii?Q?XSZYtdE0B7E/bNFmHFVvveYuDK1VIQ0T6yBpmAfxuQ7jpCoQ15kWdo536xRg?=
 =?us-ascii?Q?3AmRD36W9YKE0IZF6TlAfqJFqFxuFePZ0Yx4LmSOdM9Q8JQFmqB2IlctIoF3?=
 =?us-ascii?Q?4Dlxh2zbOMGjFLtsIo+E/d7Hl18hmsxhJKWNln2Xdxl0JBB1f3Uzw8IsTLlN?=
 =?us-ascii?Q?j5KpqYCWPfO1Pb4VIlYQKxGGp3RJqd/GSjRNxY+pyBVbuEzJHcpdIvdWqObI?=
 =?us-ascii?Q?XplL3yBt1p46744kZksC2Co0yr9sp37KD1jVH0T3E8qfS4l9tAE65upi1c27?=
 =?us-ascii?Q?m+PaHaNF5pa7L1MJSPGBX5RvNoaG8lCKxTEFdHnAy+BqeS0GOHtFjKrGuEed?=
 =?us-ascii?Q?OzGURe3uH9zO5GpaiL+l2f+oGw9qYomz+SjPi6Re2DYAVPOEuoW9DibpLi7W?=
 =?us-ascii?Q?lN1eUisbkZJyJ2BpyPAEsI+ic7rCLLcllNDYo8XEAqhZpLQACRZcL7bynVlK?=
 =?us-ascii?Q?edDF9NQIOuUSjsfWbZoYKEP9mHdUxD1aVZebu00fNxqsDOSQQOvEuPyMaPjw?=
 =?us-ascii?Q?qFex5JI4CkR0Y3GqQnbmiLTckcvSuCPzhWKy4a6jRw5qdaGcbgOKVIq17ye8?=
 =?us-ascii?Q?yMrWb5xfpkWT6RJ17mce18NaCubUIrdFR8+hTbC0RMYMuKz1pqzDjQALhxW0?=
 =?us-ascii?Q?Vd7Cs4u4QgLpkWGth8fP1esjFxCYcuE76X+KKeox+z+vUn4Y44Nnd1M2fegN?=
 =?us-ascii?Q?GGD9x4DfIxv48top0F8FNYutZB/z7mQRosl6Bkkr84QQj9gTafLulLy+4I8F?=
 =?us-ascii?Q?uP6v6ZZZ0o1varh+FslnkvL+L0A+A3Fu2JlIAp2ZdiuVB4jToqIKW+ghL7JV?=
 =?us-ascii?Q?sDdvpHhvHs/VYwJWUx4xWcc61emA8wHIQ8H5wqsvvr9dWW/cZB85kATrzBhW?=
 =?us-ascii?Q?JUHw2yMcL3zMRnesQiMTksSugCCwHylE8kCVb7cH1CaP3aor9J5/KEF64aQE?=
 =?us-ascii?Q?9RwBGN8urR5eUv3h8B1pCvEcZ5QDA5JW3QwSeTv0cSiqtOrMddvfJiGy/jDb?=
 =?us-ascii?Q?Z/RXTCFeYMEanY4rinmWazCAwFoTi1Q9jFeeUiJrQLX0tBpqyCL0WB3CgYVf?=
 =?us-ascii?Q?WDAAUFIIOnIQ1zeDpXJ9BZhqWmtFvFrSDy3CBcZbVpk2dXFV5gK3yXFE3Zvw?=
 =?us-ascii?Q?QmhV/6qFtHYDcKCOTZlV08VxoegwCUgILhF0e7soDFHWdV1kva+lAM7pkGuO?=
 =?us-ascii?Q?eh9LIthkW5+6P8ak47xCk+aIiBppc/KBPStX4rhj1P399hFm9WEhNhHm2Bv1?=
 =?us-ascii?Q?1Vk/UoQ3nZaqDZkTi8tsPRFh9KI9RqgYmPyZQ8NiCOAcQgGCRbcHIl9ms3IY?=
 =?us-ascii?Q?dhEdQ6bWw8Xjz03OWDjSW8BDIWNjwI76uVwtixoADLxwHN+qJw7Mjoq4IM7u?=
 =?us-ascii?Q?aT3X05wgDf+F9xjdISH7EvzS/NVAmINLdenbp6v86zXyxXeLeUlyCB6F8Ql9?=
 =?us-ascii?Q?e6PIlTlPThnWacJqbleHFcdr/tM/dgr9Erzd6WI+wj/YrwPGBDD3vN9JNtJv?=
 =?us-ascii?Q?bd6StLO5jFU3sSkixhxFYeCNIe4heFhYFmjeWrSz?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ad10b0-3c1c-457c-fe96-08dd07c951e9
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6014.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 12:05:40.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjk7bz9M/y545iBFJsc3I1ZrFWkHJYVoVOP86wrddLHFH7LWamVIskGCJJsK210gV2hhBzvSW4ywZT3evkbM4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5834

Fsync data recovery attempts to check and fix write pointer consistency
of cursegs and all other zones. If the write pointers of cursegs are
unaligned, cursegs are changed to new sections.

If recovery fails, zone write pointers are still checked and fixed,
but the latest checkpoint cannot be written back. Additionally, retry-
mount skips recovery and rolls back to reuse the old cursegs whose
zones are already finished. This can lead to unaligned write later.

This patch addresses the issue by leaving writer pointers untouched if
recovery fails. When retry-mount is performed, cursegs and other zones
are checked and fixed after skipping recovery.

Signed-off-by: Song Feng <songfeng@oppo.com>
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
v2: * add wrapper to contain f2fs_fix_curseg_write_pointer and
      f2fs_check_write_pointer
    * make f2fs_fix_curseg_write_pointer and f2fs_check_write_pointer
      static and remove their f2fs_ prefix
---
 fs/f2fs/f2fs.h     |  3 +--
 fs/f2fs/recovery.c |  9 ++-------
 fs/f2fs/segment.c  | 22 ++++++++++++++++++----
 fs/f2fs/super.c    | 15 ++++++---------
 4 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 33f5449dc22d..85de64b74003 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3771,8 +3771,7 @@ void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
 			unsigned int val, int alloc);
 void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
-int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi);
-int f2fs_check_write_pointer(struct f2fs_sb_info *sbi);
+int f2fs_check_and_fix_write_pointer(struct f2fs_sb_info *sbi);
 int f2fs_build_segment_manager(struct f2fs_sb_info *sbi);
 void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_segment_manager_caches(void);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index e4d81b8705d1..f35be2c48e3c 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -899,13 +899,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	 * and the f2fs is not read only, check and fix zoned block devices'
 	 * write pointer consistency.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sbi->sb)) {
-		int err2 = f2fs_fix_curseg_write_pointer(sbi);
-
-		if (!err2)
-			err2 = f2fs_check_write_pointer(sbi);
-		if (err2)
-			err = err2;
+	if (!err) {
+		err = f2fs_check_and_fix_write_pointer(sbi);
 		ret = err;
 	}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1766254279d2..46f13adeb4e4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -5207,7 +5207,7 @@ static int report_one_zone_cb(struct blk_zone *zone, unsigned int idx,
 	return 0;
 }
 
-static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
+static int do_fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *cs = CURSEG_I(sbi, type);
 	struct f2fs_dev_info *zbd;
@@ -5312,12 +5312,12 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	return 0;
 }
 
-int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)
+static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi)
 {
 	int i, ret;
 
 	for (i = 0; i < NR_PERSISTENT_LOG; i++) {
-		ret = fix_curseg_write_pointer(sbi, i);
+		ret = do_fix_curseg_write_pointer(sbi, i);
 		if (ret)
 			return ret;
 	}
@@ -5340,7 +5340,7 @@ static int check_zone_write_pointer_cb(struct blk_zone *zone, unsigned int idx,
 	return check_zone_write_pointer(args->sbi, args->fdev, zone);
 }
 
-int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
+static int check_write_pointer(struct f2fs_sb_info *sbi)
 {
 	int i, ret;
 	struct check_zone_write_pointer_args args;
@@ -5360,6 +5360,20 @@ int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
 	return 0;
 }
 
+int f2fs_check_and_fix_write_pointer(struct f2fs_sb_info *sbi)
+{
+	int ret;
+
+	if (!f2fs_sb_has_blkzoned(sbi) || f2fs_readonly(sbi->sb))
+		return 0;
+
+	f2fs_notice(sbi, "Checking entire write pointers");
+	ret = fix_curseg_write_pointer(sbi);
+	if (!ret)
+		ret = check_write_pointer(sbi);
+	return ret;
+}
+
 /*
  * Return the number of usable blocks in a segment. The number of blocks
  * returned is always equal to the number of blocks in a segment for
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696bd48..072462896716 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4738,16 +4738,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 reset_checkpoint:
 	/*
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
-	 * check zoned block devices' write pointer consistency.
+	 * write pointer consistency of cursegs and other zones are already
+	 * checked and fixed during recovery. However, if recovery fails,
+	 * write pointers are left untouched, and retry-mount should check
+	 * them here.
 	 */
-	if (f2fs_sb_has_blkzoned(sbi) && !f2fs_readonly(sb)) {
-		int err2;
-
-		f2fs_notice(sbi, "Checking entire write pointers");
-		err2 = f2fs_check_write_pointer(sbi);
-		if (err2)
-			err = err2;
-	}
+	if (skip_recovery)
+		err = f2fs_check_and_fix_write_pointer(sbi);
 	if (err)
 		goto free_meta;
 
-- 
2.40.1


