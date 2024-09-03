Return-Path: <linux-kernel+bounces-312501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B096977D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7241C23348
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BEC1B9831;
	Tue,  3 Sep 2024 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VjYup4e9"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2086.outbound.protection.outlook.com [40.107.215.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB41AD264
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352871; cv=fail; b=NSuJHs6Aa1sfxwV6BCxe0a+4y7/q2lvZlsrfZToJlARQKrtpzMMXuEizpCqWvS6nCGhp53mPvJU6aJEqIXwMYGmol8og551zBcNj9WSiDyehtjl79jxKIzW6mPHYpN8ef2UMoGsUURw3+WK2nn+oydjz1e02BcW7q9gWOo2ICKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352871; c=relaxed/simple;
	bh=sPwhHRrQKPW7G8PdPrtZ2iMW8M+G5Q+xTJppa6iDR0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbeWB9oUUnwASWAc/+VBFPJYGwt+vLRhjlPQra8Szib8d0fetYNQY05x2diZXpXJtSRZ3PxUU2dUDkOfO3Nh0Bz+6xAnZcqop32r/+txK9fJn3SiEnaHVWTx1xNbQbkPT5QJy/RhsRLyZFynTDepweXw/zioLFXEXLCFDHaCas8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VjYup4e9; arc=fail smtp.client-ip=40.107.215.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbFheJlEDdFnDlnwf8a19hADcu3pB7mJ1WNAff48ChAjTyGDaLtLy2mKLoYtlXCOzPxV8Fw/4qB1t4gaMJEEQOvcQQajmyKbRBQ//B44XMv+hVsjEEmHIYHfSq279bcYhMpF/7WQTHnV+5DE52Ngpj/CXGoeJ7uC0jRGWhJH55jIzle/ixj43SfBGmdbfG8zyl8lA+hEJCxyIAMuI5LJYIq+C2Yr43/sUWLOBkq7oxkFpiQ6zuU70vCE7C2AR5zR0U+jlfm1IScJHFsu/e65m4e/+5qcH3E6UTQEbEaKgKw02Cii5eIr+u0J/tpqIZu89JVPsu8geJ9vpuBLjrju2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YkUHWkSyaZim2/FraKiN+n8vb8EDsmqhJ3U8NImOxA=;
 b=sLfKd9fBbl4mbK0B5mHH+Ch/uzvKZZ6FVwG2yZHXIe6pxVMNhxpqU77sSkez1HPfCdb2VDXkBRBwrtvsvsFXTFUJ8Hlkp4dwpvC06baEf8uyMXbVlr0h76SUg4Y13g7u5xu9xFVREmSywl+Hmy+up3OTdKMR6IlwsQ/RvBu1AqnSopRQb90ahLJUlwdn5SCNs8Tr+0RdHqrHt97zZK4JVdrtkXp3jHkQlsSWeYZGbwEWVuqfGrSli9uoFbWG0ERCz9tIyOXONtV3P9HLR4LXQOWhuK1/dwr73HbwY7CLr2oWotAJkoH4Nlhtf8414Hj6EavSxVI5X0dlQx1T8haFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YkUHWkSyaZim2/FraKiN+n8vb8EDsmqhJ3U8NImOxA=;
 b=VjYup4e9dI6RuPcbU0kyiWBHTzPnlfVfTxpIBiMQu/E+lPhV3SZVX86HDE5RSGi8EiJN6Vuxi+1KNohdUdV3fKN4wA5HjxrOK2Uozdp1wQkfHIPe7ZwTucAtJilzjJCRd8a6saw8u7D/lZJUeTkNhcFU1i5rIGV2DAXpnzfcFtJ0LucM7rltTCdaif3N+b7AhY7fFJSjog6vTQXi6TQDobGIwWQBvsSEB31sHecW5rWnLfxKwfPw9kwo1FTFOeC8E8g9WZ+6quraKZaWgAcqYBJRo3CBiO0oBpHC+f3QiXEtIhQzoiW5UUXWHyQqeucPYVxp6eOfYLnCtGAuIYQdHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEZPR06MB6253.apcprd06.prod.outlook.com (2603:1096:101:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 08:41:02 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:41:02 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 11/13] f2fs: fix inline tail data lost
Date: Tue,  3 Sep 2024 02:54:55 -0600
Message-Id: <64857ac35515abdb00cfad877094131b471a8776.1725334811.git.bo.wu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: b05251c6-8a05-4229-6a71-08dccbf42420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9HLbtpGoWatf0EAjJJAbKtiUPN964yabSqYXeD07Q+/ejkPmAzG5u9SApPyt?=
 =?us-ascii?Q?RMFwjEk6iL5uvqMxjriAbMcehVCaOlwSp9dFUvc/Okh/IXkkscDf8eY/dU3g?=
 =?us-ascii?Q?ovS8rquN+njijAHQWDm/YdpMVEiMrGKSKPnwECyK9zsVrgBm4eTJ1aXrUnow?=
 =?us-ascii?Q?/8Rpo+nQ82qmke1Ixdq9WG30R+doTq2lHWcAdncZikBnPtJPnzBYmzlUO7P6?=
 =?us-ascii?Q?lx3gT2smAVSCG9Wlg9Zi5yK/Xb9A2utZULLQKHJ+3G+Ea71NOa+Zsw/Qkzzx?=
 =?us-ascii?Q?3p4U+GfCcTNPTybxeFTjbVFDnnDktUDEYzh97t6KQvRhEmKY+rQcQDMciO6T?=
 =?us-ascii?Q?JqIdMDw81u10BHeqpVZVZzJ+sl0lvXDHvSB0tO83wqyxW/4WeIUP9UliBdea?=
 =?us-ascii?Q?UtyAy6fm+oV7zmiOsLdXljWM/lbG8lISk50JKku+j08F9O/k77+RXii6rlQY?=
 =?us-ascii?Q?JOpDhqcB1vNFjVuOSpk/7lv29B7xljabJRnIyJYZ6dRVRjzlvwzwIJLJM70N?=
 =?us-ascii?Q?rqOgHI7A7yzgSBgPQC0YjjXNlbpmhXuYumEqSTVrwkMOWU73rBYMAnwtHQFE?=
 =?us-ascii?Q?UvTeE+g9nXaxMt72slycJPxL+/f7MxA8VK+JxfSwJKlDOD8VF6yCkpR6Pyg5?=
 =?us-ascii?Q?9/RCZOlFhJ2VcsS8LI38ica+kvojfqaySj39wEBQCivxWasAV3fw/cSXcaw6?=
 =?us-ascii?Q?ZEHrGMvBDzW4MSPaP0rzcOE9FVKIp+IZ96Ifjrcw0tjygnS9qur32q34JT4G?=
 =?us-ascii?Q?7S/8k9QCepcBvB9WRanHYu9fruwL8JXoTFYKqxPbuLW+bim24QhUbhME4WBK?=
 =?us-ascii?Q?LYPZJac6O3KdQsQqUozElMdN0jWnbh1b+TJi1MaV9gpaKVbpF9jSyYqAVuTj?=
 =?us-ascii?Q?nASyQOc4yfFbJ/x/KYKOAuVxsFuNXRIgzwKgUMh/9SbC+Fc+tw5P1XktIjCU?=
 =?us-ascii?Q?XDlrV6ItCVF/yDpkD1meqsIyetkKIIWFmmwTaymIW/R3p2ctbIypnmQWpdHe?=
 =?us-ascii?Q?Kg1J8mCNi9ic4GTVKTvie5RZ9xXniCbagxGX9qK8yug77VE+B645oC9IswG5?=
 =?us-ascii?Q?2eGyjTVkaZ+NgXawUDq+qz8CKbowHq0dXSuWFU0y7xhkT0oI0irM6yZ8TdOC?=
 =?us-ascii?Q?iKiS2B8ZcFEXwR7cXEH3asvbxTfvZXzjsaG1gTfAfLEsmNTvcKtqPMS1bbSy?=
 =?us-ascii?Q?4aFzlyb+G5aNc1vsUYA4Qqm2jFwv+dCkDdZ8Zr2YuR3eQ4mbJpIrx7KF8aSF?=
 =?us-ascii?Q?TKXO+QSmdcwUPRi24YZcBEk+xK3E9oM2ez0+qK5dron3Fd1ViRdm+8oMeZ7N?=
 =?us-ascii?Q?ZT/ObWZbX16YueCmTmbJ2eSo/WDsaKJLTAspbNrilemnb/SCCztp/Iec26v/?=
 =?us-ascii?Q?UFxg2YRoaoa0KyeDNV5gG0XIpmR+0J6SB5g75g9PHwsz5ICthg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1DDRNrlbHZUq7q1aM79V8WUgWXLESyEuvoNYX7AWIm3ERT3MWzZh1acwwRp?=
 =?us-ascii?Q?wfPTaS+KhL6zDiAG6UYi8A9xfc3T1UF1kG1q6XtSWgwfNMnbo8TV5Xc/0YrG?=
 =?us-ascii?Q?IodzdMPKqOb9xhcUU/dEk4r85PUkUUTCoIY0by2gC2Sw36jK4HwHsTjmVrv+?=
 =?us-ascii?Q?yOYPej8rRpUSA8lBy2+cJ6u63GNJRQuEy+6bn0ylARXHDIZaaH6tI0YauiDe?=
 =?us-ascii?Q?v+PT8za1AwVoYEN6OtEZGnEWPRekHuhKkOAYCwTVKG1p0OrYo7uFceET0FWa?=
 =?us-ascii?Q?lq9FxtPuaaA1zWtKacrUt/AF/5yfXkiim5TfqRiFE8+71j5JoE/+kt4j94aI?=
 =?us-ascii?Q?3LP8QI3Vu3oguqfg91guVsG/FkRMuHgNgZyufwxMsh+7mKuG8Z0CxdfMcZIf?=
 =?us-ascii?Q?aqsJHSeWwrvIlVpj3S37e7/GqCkPS8L/cEmnSrM1rI8ZkWn9v6Ievbzxm64I?=
 =?us-ascii?Q?vr/fz/l2VTvYXppM4nV7BdaI8tYsV9aICuH6zFH+PeA9qSgZpjAeZmm82pN4?=
 =?us-ascii?Q?Px970533TUwhYO1qDMu0MWoW5Rgc+/zO0BJvOXhRKG9IS/O8sdJydP0BDhJU?=
 =?us-ascii?Q?gPQKbi10PEQl3DMwE7djOe7/Cj6d5U4FpgbpjxYinpKnD/F+gRzp8/b6lFbm?=
 =?us-ascii?Q?SfDRYidrqzBwt76n/IsKin9IY9ecC/IZ3kflnfJYqSu5QpJnXHqvnl/Q4j0b?=
 =?us-ascii?Q?Wy7Czn76zJJFQMm3zh08ZHucWTb5ej0im5F5vq/IMQWJJKFekygFbtbpQkmF?=
 =?us-ascii?Q?l/QL19x8QA28AR3+JRpWV4DcTRUgwqZ3sRzvojB03eq1to524eZ8S09hnbFo?=
 =?us-ascii?Q?ieGXVc3felzsMmU6Cggc1zFr6hYdpg1HvuQRkAUaBAFnNJLq1ySz8iwAd1qm?=
 =?us-ascii?Q?KSyAcjGEjkvMFd51zO1fqWcY6c/IKeOd/wJnTgr8zH7VomjfqfdoTwglgeVX?=
 =?us-ascii?Q?oWhlJHPTMHYOR1YGhIad9/K7AhizFwD2BKff5PYlm5CXEuXW9tanXnX3YA21?=
 =?us-ascii?Q?WTLRxCiHwy2sHcXtf9FYBMqILricjAyxmDrk8uvKqTCUstZn8a0SGXkKwrHG?=
 =?us-ascii?Q?d478fGfnZkfVeIqJUNOVDPIazoVmdLqi2u0SuXpeL5eTL1Pw0zRvVxmRjTL9?=
 =?us-ascii?Q?V21gMt8FposQfIxbyPKw/QacamZJ86SNsuJz+gQCfgsAujAf5djC1+n/MQMn?=
 =?us-ascii?Q?LymuYcBkGuW3snFKObccnpeei3Hu+fxq2m5fKSIr27jauw26fMdHLe27vxbY?=
 =?us-ascii?Q?ifnW5REvHt02nfLUtIb/2v1LieAYQQYYHHtIdKMe28f+VXxGE49Tifbmofa8?=
 =?us-ascii?Q?w5i9xeQ5NG8NqhNDlnMZ5DgqfNsE8eVtRHve5hhMfjxczavoAPWtvK/PBoI0?=
 =?us-ascii?Q?c5Sa0oylFIAHnILUOA5CBjxV3DV35BYcmVgXSnMEBHRXVuJHOeZzrDVQnhEH?=
 =?us-ascii?Q?KxczL8S1n9Ol1Ld8Uc5SC8veOU5C8/eb6hAmzysYZWb4Opxg2zBQCEvrcErm?=
 =?us-ascii?Q?Z3cz7jzfVh/sgPRo4LbCUou7xmEA6B9ONV+7lPdsNCPtAyvEG2wKL5w1UEJ4?=
 =?us-ascii?Q?UyQHeRlQL/kkZ+uMNYBSz0M3ZN2T8rVi9HgKE460?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05251c6-8a05-4229-6a71-08dccbf42420
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:41:01.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO2CqehOjqQJwIVvlMS4X4uxOCCe8oR5V8nxoejEtCIqk5C5tRPBH81XtvpEx248dDTQfzuykZD3uE1NmGl93g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6253

Before adding a new page to the tail, the old inlined tail page must be
converted first; otherwise, the data on that page could be lost.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/data.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d7b6074763f..f52834c1cacd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3418,7 +3418,9 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			block_t *blk_addr, bool *node_changed)
 {
 	struct inode *inode = page->mapping->host;
+	loff_t i_size = i_size_read(inode);
 	pgoff_t index = page->index;
+	pgoff_t end_index = i_size >> PAGE_SHIFT;
 	struct dnode_of_data dn;
 	struct page *ipage;
 	bool locked = false;
@@ -3438,12 +3440,12 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			flag = F2FS_GET_BLOCK_DEFAULT;
 		f2fs_map_lock(sbi, flag);
 		locked = true;
-	} else if (f2fs_has_inline_tail(inode)) {
+	} else if (f2fs_has_inline_tail(inode) && index >= end_index) {
 		if (!support_tail_inline(inode, pos + len)) {
 			f2fs_map_lock(sbi, flag);
 			locked = true;
 		}
-	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
+	} else if ((pos & PAGE_MASK) >= i_size) {
 		f2fs_map_lock(sbi, flag);
 		locked = true;
 	}
@@ -3471,14 +3473,28 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			goto out;
 	}
 
-	if (f2fs_has_inline_tail(inode)) {
+	if (f2fs_has_inline_tail(inode) && index >= end_index) {
+		if (index > end_index && f2fs_exist_data(inode)) {
+			struct page *tail_page = f2fs_grab_cache_page(
+					inode->i_mapping, end_index, false);
+			if (!page) {
+				err = -ENOMEM;
+				goto out;
+			}
+			err = f2fs_convert_inline_page(&dn, tail_page);
+			f2fs_put_page(tail_page, 1);
+			if (err || dn.data_blkaddr != NULL_ADDR)
+				goto out;
+		}
 		if (support_tail_inline(inode, pos + len)) {
 			f2fs_do_read_inline_data(page_folio(page), ipage);
 			if (inode->i_nlink)
 				set_page_private_inline(ipage);
 			goto out;
-		} else if (f2fs_exist_data(inode))
-			f2fs_do_read_inline_data(page_folio(page), ipage);
+		}
+		err = f2fs_convert_inline_page(&dn, page);
+		if (err || dn.data_blkaddr != NULL_ADDR)
+			goto out;
 	}
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
-- 
2.35.3


