Return-Path: <linux-kernel+bounces-293171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23B5957B92
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F091F21B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA17A40870;
	Tue, 20 Aug 2024 02:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q4WxWuQg"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBE344C77
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121904; cv=none; b=bcZPMcy0/VN+zE0WDwf81wePK9pDLpk2B11zhVEHQbc37iSxvfFeNFA0I/3LZ6ZQ2KT8Wp5K7HQwwfEA/60o7Jiiw++uCXox/nb+0A6Of7P11lMK+AqDPwPsfQ0/LJNF6NDLVBsWkBsnNB0/Wh0l/Pr2SzwQVMlTPSauAyGHy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121904; c=relaxed/simple;
	bh=muE33Svm4smr9PChgiBgnkHFcUkduTf5tDqHh6AhWL0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Hr1HF5Dwqa3lLMeq/1cxoGWOm0e7nFQmAX2v15vlBz0pBr3J5H6tYKIBu0JBGNkzSAWBFybdMVs7PTpwnEE3PU1siiyc/SNrk+i0O50G+zO86m13l2+nE5nK3+qzR6SCcMhxGFMourtNjaROMUQqfYwvThy+4su0S4866GeMnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=q4WxWuQg; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240820024459epoutp0433ae6bfb0c4323c6aa0e5f80deeccf0f~tT7ugRwUZ3253532535epoutp045
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:44:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240820024459epoutp0433ae6bfb0c4323c6aa0e5f80deeccf0f~tT7ugRwUZ3253532535epoutp045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724121899;
	bh=uOUsp2Icyjguhl9fIySIi7C6jdasryy0Oh8rEgg4v8c=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=q4WxWuQgYAaBvjCt1yEgHXRj1sXAd1df+OVfsohZ1bnDFv6HaFOWCfZnth5ufT2Qz
	 T6AcYX4d58bOckBjBZ51sL3s1x2hm0PYBghS+7M2pCbLnSEwmwo6pIdk6FMU7u3u1N
	 9Bbnct+C9GwakL8dxbrKUPAB9kEQ6V/p7bfzKW1s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240820024459epcas1p4ca50310821f59cc9142ec268a2c6ac30~tT7uI8iQd2303123031epcas1p48;
	Tue, 20 Aug 2024 02:44:59 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.225]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wnv2L6NdVz4x9Pv; Tue, 20 Aug
	2024 02:44:58 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	CE.0A.10258.A2304C66; Tue, 20 Aug 2024 11:44:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240820024458epcas1p4b3bf4d42997870503bf57de45cd70fff~tT7td12FV2862028620epcas1p4S;
	Tue, 20 Aug 2024 02:44:58 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240820024458epsmtrp2072307dfd3d3e9a2d3a7ed303a0d2bf0~tT7tdPJ7b2857328573epsmtrp2R;
	Tue, 20 Aug 2024 02:44:58 +0000 (GMT)
X-AuditID: b6c32a38-9ebb870000002812-10-66c4032ad489
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.11.07567.A2304C66; Tue, 20 Aug 2024 11:44:58 +0900 (KST)
Received: from sminjeong05 (unknown [10.253.99.183]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240820024458epsmtip2c7f645bd56dc25285a8597c9c5e341b3~tT7tN-7iD0770507705epsmtip27;
	Tue, 20 Aug 2024 02:44:58 +0000 (GMT)
From: "Sunmin Jeong" <s_min.jeong@samsung.com>
To: "'Chao Yu'" <chao@kernel.org>, <jaegeuk@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20240814134815.801303-1-chao@kernel.org>
Subject: RE: [f2fs-dev] [PATCH v2 2/4] f2fs: atomic: fix to not allow GC to
 pollute atomic_file
Date: Tue, 20 Aug 2024 11:44:58 +0900
Message-ID: <002e01daf2aa$f22d5430$d687fc90$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQLn9uQSv5kHFHDHqqjb+IXcXHMvoQHoUZ1QsAYfsRA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmnq4W85E0g32ndS1OTz3LZPFk/Sxm
	i0uL3C0u75rD5sDisWlVJ5vH7gWfmTw+b5ILYI7KtslITUxJLVJIzUvOT8nMS7dV8g6Od443
	NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBWqakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVK
	LUjJKTAr0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44fWoFe8F86Yr3XxayNTBuFuti5OSQEDCR
	ODGxhaWLkYtDSGAHo8T3xbuZIZxPjBKLny9lhXC+MUrcPtDLDNOybl8/E0RiL6PE2qdnoape
	Mko87/nLDlLFJqAnMX31P7AOEQFziT2LX7GB2MwCPhK/b90Di3MKmElsv3aBFcQWFkiUmPDs
	HxOIzSKgKnF0wkRGEJtXwFLi6PlvrBC2oMTJmU9YIObIS2x/OwfqIgWJn0+XsULERSRmd7ZB
	7bWSaO15APachMBbdoktu04zQjS4SDx+tpUVwhaWeHV8CzuELSXx+d1eNgi7WOLo/A3sEM0N
	jBI3vt6EKrKXaG5tBiriANqmKbF+lz7EYj6Jd197WEHCEgK8Eh1tQhDVqhLdj5ZA3SktsezY
	QagpHhJzl/9nncCoOAvJa7OQvDYLyTuzEJYtYGRZxSiWWlCcm55abFhgAo/u5PzcTYzglKhl
	sYNx7tsPeocYmTgYDzFKcDArifB2vzyYJsSbklhZlVqUH19UmpNafIjRFBjYE5mlRJPzgUk5
	ryTe0MTSwMTMyMTC2NLYTEmc98yVslQhgfTEktTs1NSC1CKYPiYOTqkGJunGfbr3xB2rvpcv
	Paa7ZUvojeNJDGx6LzhUWDy3v3KMi3jfEHla5eaBGR4vEk8tepWUKvtzo4fZ7x38advTzTcJ
	bijQ7JH8NCd0YsmuffUX1SZt5jdt05HROh2Qs79b92jd0rQ9K/pqGI0UfNuLxLPuaexPS5fU
	b/lXduD2EbZY1z07jJzkClPj3Z5fY3S6pFr8csf7ScLW3dInP12N9+OIrWeZqq7skaeZX9+x
	VvUlx03NhNjODRGb/R1vf717NnNDo8LlDKFbj1ieX7dky/cQ4j3L+UzU88EcuxLZ+EtvOP6U
	aRyUW/C6U94mn81usgHjc41mzYpzk4/7OB8pMOdIWJO3aEqAr1aRuZESS3FGoqEWc1FxIgA2
	rFlLEgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvK4W85E0gyWfhC1OTz3LZPFk/Sxm
	i0uL3C0u75rD5sDisWlVJ5vH7gWfmTw+b5ILYI7isklJzcksSy3St0vgyjh9agV7wXzpivdf
	FrI1MG4W62Lk5JAQMJFYt6+fqYuRi0NIYDejxIWbbSxdjBxACWmJY3+KIExhicOHiyFKnjNK
	fDx3gAmkl01AT2L66n/MILaIgKXEglnnWEBsZgE/iV0PVzBDNLQzSrzpWMIOkuAUMJPYfu0C
	K4gtLBAvMfPMREYQm0VAVeLoBAibF2jQ0fPfWCFsQYmTM5+A3cMMtKxtIyPEfHmJ7W/nMEPc
	ryDx8+kyVoi4iMTszjaoe6wkWnsesExgFJ6FZNIshEmzkEyahaR7ASPLKkbJ1ILi3PTcZMMC
	w7zUcr3ixNzi0rx0veT83E2M4KjQ0tjBeG/+P71DjEwcjIcYJTiYlUR4u18eTBPiTUmsrEot
	yo8vKs1JLT7EKM3BoiTOazhjdoqQQHpiSWp2ampBahFMlomDU6qB6Z2igq9KAeOXq/bhP996
	Vy6etd3Ki+9Y7sVHjsdizqS8m9pZckflsPUzhpIIJesu+QpL8eeHLO6+EVYK4svoWnayxN7o
	ot5Kztjr9zki54jXs/3U//x+AzvP+bBNa5cYLmm75an+PXLWr/9brwrqfdiqKKuyfcnMidb5
	rPyfg1sbzUKTXzjc5fnwii3sdsyK1Yuv8gm9Kr1XdL5Scvfqn7ee536r0ij99obxc0igOe+6
	L76L5vkwqV/qZD8gJKOwafaFQOEuXman9wvVTqxt9NP+VjffkF1Lq/Qgg7ZkI39ay345B7FN
	vWZLGLk89st92u7FeVLmmd7+qJVJ10o/XjAQF2p/2OIapG83o2C3EktxRqKhFnNRcSIAomEB
	+/kCAAA=
X-CMS-MailID: 20240820024458epcas1p4b3bf4d42997870503bf57de45cd70fff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240814135008epcas1p3e11d629481d51a4cc4af78dbe3e66fda
References: <CGME20240814135008epcas1p3e11d629481d51a4cc4af78dbe3e66fda@epcas1p3.samsung.com>
	<20240814134815.801303-1-chao@kernel.org>

Hello Chao Yu,

>SQLite App			GC Thread	Shrinker
>- f2fs_ioc_start_atomic_write
>
>- f2fs_ioc_commit_atomic_write
> - f2fs_commit_atomic_write
>  - filemap_write_and_wait_range
>  : write atomic_file's data to cow_inode
>						echo 3 > drop_caches
>				- f2fs_gc
>				 - gc_data_segment
>				  - move_data_page

We modified the code to make GC of the atomic file go to move_data_block
in commit b40a2b003709 (f2fs: use meta inode for GC of atomic file).
Could you please check if this patch is still necessary?

Thanks,

>				   - set_page_dirty
>				   : it may load data of previous
>				     transaction into pagecache.
>  - f2fs_down_write(&fi->i_gc_rwsem[WRITE])
>  - __f2fs_commit_atomic_write
>  - f2fs_up_write(&fi->i_gc_rwsem[WRITE])
>
>During committing atomic_file, GC may be triggered to migrate atomic_file's
>block, so it may contain data of previous transaction in page cache, we
>should drop atomic_file's cache once it was migrated by GC.
>
>And also, we should writeback atomic_file and cow_file's data w/ i_gc_rwsem
>lock held, in order to avoid block address change during
>__f2fs_commit_atomic_write().
>
>Meahwhile, this patch adds f2fs_wait_on_block_writeback_range()
>to wait completion of block migration.
>
>Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
>Signed-off-by: Chao Yu <chao@kernel.org>
>---
>v2:
>- fix error path handling.
> fs/f2fs/segment.c | 27 +++++++++++++++++++++++----
> 1 file changed, 23 insertions(+), 4 deletions(-)
>
>diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
>3aee71c9f3c6..a43054ab0cf1 100644
>--- a/fs/f2fs/segment.c
>+++ b/fs/f2fs/segment.c
>@@ -236,6 +236,9 @@ static int __replace_atomic_write_block(struct inode
>*inode, pgoff_t index,
> 		return err;
> 	}
>
>+	if (__is_valid_data_blkaddr(dn.data_blkaddr))
>+		f2fs_wait_on_block_writeback_range(inode, dn.data_blkaddr,
1);
>+
> 	if (recover) {
> 		/* dn.data_blkaddr is always valid */
> 		if (!__is_valid_data_blkaddr(new_addr)) { @@ -339,6 +342,9
@@
>static int __f2fs_commit_atomic_write(struct inode *inode)
> 				goto out;
> 			}
>
>+			f2fs_wait_on_block_writeback_range(cow_inode,
>+								blkaddr, 1);
>+
> 			new = f2fs_kmem_cache_alloc(revoke_entry_slab,
GFP_NOFS,
> 							true, NULL);
>
>@@ -379,16 +385,29 @@ int f2fs_commit_atomic_write(struct inode *inode)
> 	struct f2fs_inode_info *fi = F2FS_I(inode);
> 	int err;
>
>+	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>+
> 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> 	if (err)
>-		return err;
>+		goto out;
>
>-	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>-	f2fs_lock_op(sbi);
>+	/* writeback GCing page of cow_inode */
>+	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
>+							0, LLONG_MAX);
>+	if (err)
>+		goto out;
>
>-	err = __f2fs_commit_atomic_write(inode);
>+	filemap_invalidate_lock(inode->i_mapping);
>+
>+	/* don't allow clean page loaded by GC to pollute atomic_file */
>+	truncate_pagecache(inode, 0);
>
>+	f2fs_lock_op(sbi);
>+	err = __f2fs_commit_atomic_write(inode);
> 	f2fs_unlock_op(sbi);
>+
>+	filemap_invalidate_unlock(inode->i_mapping);
>+out:
> 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>
> 	return err;
>--
>2.40.1
>
>
>
>_______________________________________________
>Linux-f2fs-devel mailing list
>Linux-f2fs-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


