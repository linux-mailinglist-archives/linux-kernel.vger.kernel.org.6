Return-Path: <linux-kernel+bounces-240370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6096C926CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC68B2308A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F83610D;
	Thu,  4 Jul 2024 01:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YHsj+YGW"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CAFBF6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720054948; cv=none; b=mqrM8rd2AHcYHW7m6SPbmI2eDSQlXebkb8Ql6hFeVcQQMuqKZIcHBEyBKhMvIHAZf0ih33hjPrjYcnaIKXf0l7vM1hRQ6YnS+YOBC5WOyJA24fMcUxqXarY4LdlfR34o/THbXzud3NlXe0oP0RddRg9wA7uk8rxg3i1ccmflZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720054948; c=relaxed/simple;
	bh=T8bV0qkR/9fchtnuJV6c/xKL8rqww+QPHg9J2h1t1JI=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=Rnlwp/en1FpSQ07sN7iDDz6BYmhOaQwa3RQ8VIpWojYwZFN6v++XgJKEAk6E3WL/vhYC+l6QgtE/ed/KbWeuYwtwSQuVwwKpp+deZatYr6nc1ZKSQ19Jr5LEEneSabI66znwnEQEry2yvSy2x1/ZSeB8W/W55cr4UagxY4W8TcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YHsj+YGW; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240704010223epoutp03b3bf69cf3912832b62bd8c55158e9900~e3Nt--87k0413704137epoutp03B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:02:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240704010223epoutp03b3bf69cf3912832b62bd8c55158e9900~e3Nt--87k0413704137epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720054943;
	bh=SRywyYtqWBt1JqxXnaHByQq7LKdm/U99W5lYcjMpL4o=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=YHsj+YGWXPGSmlhEXGHg6nZcnKBSyW034s0SzLYCLJEEkR9qXfM5ewvEfeZ6C02mJ
	 tEVlbzZ6Sh7jSkJlX//yLZyD4EeYeunKdZOrBpGCs+zFNO0t5N8u8p7xXFgzc/mK64
	 0NWQeea+YRCguhyQ+b/rnuGyFo9PLIWO5/IR+Hmg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240704010222epcas2p243c529630d475eb5cbdafed0775a6576~e3NtasxUr1175911759epcas2p2d;
	Thu,  4 Jul 2024 01:02:22 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.102]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WDyzd75Fxz4x9QN; Thu,  4 Jul
	2024 01:02:21 +0000 (GMT)
X-AuditID: b6c32a45-1c7ff70000002678-3a-6685f49d3e2d
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.92.09848.D94F5866; Thu,  4 Jul 2024 10:02:21 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] f2fs: fix null reference error when checking end of zone
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "daehojeong@google.com" <daehojeong@google.com>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Daejun Park <daejun7.park@samsung.com>, Seokhwan Kim
	<sukka.kim@samsung.com>, Dongjin Kim <dongjin_.kim@samsung.com>, Yonggil
	Song <yonggil.song@samsung.com>, Jaeyoon Choi <j_yoon.choi@samsung.com>,
	Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
Date: Thu, 04 Jul 2024 10:01:21 +0900
X-CMS-MailID: 20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmme7cL61pBo+fWlicnnqWyeLlIU2L
	qe17GS1WPQi3+HHSxKJ/dzuLxZP1s5gtLi1yt7i8aw6bRcsfJ4vzE18zWazqmMtoMfX8ESYH
	Xo8Fm0o9Nq3qZPPYveAzk0ffllWMHp83yQWwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
	GRjqGlpamCsp5CXmptoqufgE6Lpl5gCdp6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUot
	SMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzujdcZW9YDlnxbTe9YwNjFfZuxg5OSQETCQ2
	Lb/P3MXIxSEksINRou3XTrYuRg4OXgFBib87hEFqhAU8JU5dWcIIYgsJKEmsvziLHSKuJ3Hr
	4RqwOJuAjsT0E/fZQeaICMxlkpjefghsKLPADCaJJQ+/s0Fs45WY0f6UBcKWlti+fCsjhK0h
	8WNZLzOELSpxc/Vbdhj7/bH5UDUiEq33zkLVCEo8+LkbKi4pcXvuJqj6fIn/V5ZD2TUS2w7M
	g7L1Ja51bGSBeMxXYuI8f5Awi4CqxMmNi6FOc5G4eP8u2HhmAXmJ7W/nMIOUMwtoSqzfpQ9i
	SggoSxy5xQJRwSfRcfgvO8xTDRt/Y2XvmPeECcJWk1j3cz0TxBgZiVvzGCcwKs1ChPMsJGtn
	IaxdwMi8ilEstaA4Nz212KjAEB61yfm5mxjB6VTLdQfj5Lcf9A4xMnEwHmKU4GBWEuGVet+c
	JsSbklhZlVqUH19UmpNafIjRFOjhicxSosn5wISeVxJvaGJpYGJmZmhuZGpgriTOe691boqQ
	QHpiSWp2ampBahFMHxMHp1QD065KsZCHmZ0SeSebJnzg8wrUlWWcGGIT3yG0QVYpztZth1ZU
	seOO0CkL3Zcf2fezuK+xU96fqVQ54NnR03d4hfM/T5esizZbdrDkePCdR/lp04TLVphkxCm+
	8eLSrF466ajY7xtPDVb8MLz/d6s7y71L8c4H/lUfNgjyPsIac3WFYfrBRC+jnRN4njpEcFoc
	z/87Q0T+woZWG/4zi1ckLV6ziKs0tYJBZVJp0OUyidXM29ndvkSf3sf71+SJQlVi8rL5Pffy
	7z3q0hRybFufKPFF/PzKpln+LU9dL6/m2X1p88H5n25cnDn9E4fol4dVxi79bB8mT4/ruVth
	Z/n6eJL748OCs5aWfTzOqvnfTomlOCPRUIu5qDgRAHRtqtMwBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90
References: <CGME20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>

This patch fixes a potentially null pointer being accessed by
is_end_zone_blkaddr() that checks the last block of a zone
when f2fs is mounted as a single device.

Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b6dcb3bcaef7..1aa7eefa659c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -925,6 +925,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 #ifdef CONFIG_BLK_DEV_ZONED
 static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
+	struct block_device *bdev = sbi->sb->s_bdev;
 	int devi = 0;
 
 	if (f2fs_is_multi_device(sbi)) {
@@ -935,8 +936,9 @@ static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
 			return false;
 		}
 		blkaddr -= FDEV(devi).start_blk;
+		bdev = FDEV(devi).bdev;
 	}
-	return bdev_is_zoned(FDEV(devi).bdev) &&
+	return bdev_is_zoned(bdev) &&
 		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
 		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
 }
-- 
2.25.1


