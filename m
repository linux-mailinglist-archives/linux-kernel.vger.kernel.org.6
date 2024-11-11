Return-Path: <linux-kernel+bounces-404053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD29C3E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0FB1F223EE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9D189BA4;
	Mon, 11 Nov 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nqGc4sbQ"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD266139578
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328751; cv=none; b=GmnnFIx1BwslFy7+AenkU3A6+9J0yZzSASwRb28ZCwrdaWEZmnIldKL4AtcKATstViglg66GYkSPM8bct4ctoh4HqkzsQgSe+2ev+gxmaaxhIr7CwWO4kElE5Hw38iGJBHm65Z2BCslRs6LvZpjXSawuSqOOKgzNhlUa/QGJoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328751; c=relaxed/simple;
	bh=mC8sfjWs/Rl523rmlxQ+VfMuF6VJrFmOjNIzFPt4T4E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=P/lDHWdu5IOt7rUV0/oDcmgTG/e13/9eu3Uf0IDee7PfIjvHq3vH6UGkLkmw0vi3fUXiGBWc7+aoTQiHnwdNJiAYUCeXYPKgB/syz2qJ7LMiJfgS1p8UjGh14Rpj2rdLdugI6ULCj3eivRtzzFZb1uvM0um0t1CoG0hNQZrOpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nqGc4sbQ; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731328735; bh=yZiuuCavfx5+W/Wu6/Fyy1x+FZbd1JXobKAK+QK52Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqGc4sbQS4RWc0Hh+cnD5ZYo+9VRrU8Cp9Pwfg1ovL2gwYLgk5GY9qH1CE0+jyipQ
	 03HMAebXCYn2XQ5cT9lzY6C+Yc0U17Ipb2cr/pPYL9XKDd4OCa2V+dol/284qYrn3R
	 GFDzTKRPjS+D0cR5uxMzLNEg6snScNFtN7BKSZGc=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8D5238AC; Mon, 11 Nov 2024 20:35:21 +0800
X-QQ-mid: xmsmtpt1731328521thui2r24f
Message-ID: <tencent_046963B884499778B77A06CC9366036A0905@qq.com>
X-QQ-XMAILINFO: Nd/Exl7W9DK52FEGflF9l5x/W15u18C17Iu2maIvoqPRvKYSQLOB1pIl5uQCg4
	 sWgD49PRGLQ9ctuNR7G/ND3Eatk4wUkWKqiyTY1Ac6cl/Muo3x5BpUZLBe+ZfKh+ieXcKfU4pGsj
	 jeLr7gnn60r4+eazqgZkFVPldG471+3VideaGisAQn3WK0WmmxIR33GxUFqU9M3cvoJwquD5dEyy
	 XYWtX1PVeBbIkRY0RSx5ft79ZvkW0z7Xqw7Usno8t2wiqPC01+csAUgXiAPXjE461w8HlND4aOPR
	 2XwG8KnMSLjAULtT/qD4Nhcf/QCFOEE8z/SCzNBhKZsDCjscahAouWsr94IzXj/LRysDMuswcAIp
	 scpABGdBnDMErUNkueTl0vpPIhQrVQvANrmL34ZN5p8BoufMIEm0kH0P6VTi3YaX8t7t6XoIVPta
	 yTO1AEocxDVQggdKgRDPmuU0JO/91CpA2MK0BquLFWCY3iKLmG7x4kwMQWQWoV+l9qv0cJXfh9GC
	 N8exlV0ubv5QHPJcilBvbJHsILry0Od00P290kjOgT2NeNCueGaLWViFMj9q3vaK7P4RNnA/N9Ue
	 TfokCx3/7L1l5B9+ZF/xn5khAdAhj18o4EeZroo7vRsawy1VONqUeWXrBQ/Gj1ePwLQL9SM2Xy17
	 iRRboCJHzgxqAyu4OX58qReuNTlMB8GmSBiShEaJ5Ym6P/2TfgNmxZpKI6yBdIK1exZHK8hCHobS
	 Y9HpVHaSMseIxWnmNIR2SySPc9szZtFnCJ8GpRz0awTvD5VwpZkW3W7p0Qk9CVGAJOwH7Orp5rkl
	 A9pw134eVgEGZn22LC7vQ74+BHKWnF5JhNNVFyGsC3iZNmaQekeBrMs1Mo0XMAXzzuSFyP+STagH
	 iQ+XgWvkscw+I5CbIaTbhjfNdXVjYXtAzrRPKSxSts
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend (2)
Date: Mon, 11 Nov 2024 20:35:21 +0800
X-OQ-MSGID: <20241111123520.812518-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6731ef89.050a0220.a83d0.0013.GAE@google.com>
References: <6731ef89.050a0220.a83d0.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AA lock, move extents_lock out of the hfsplus_file_extend.

#syz test

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 9e1732a2b92a..ec6e9bdfe7b4 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -355,7 +355,9 @@ int hfs_bmap_reserve(struct hfs_btree *tree, int rsvd_nodes)
 		return 0;
 
 	while (tree->free_nodes < rsvd_nodes) {
+		mutex_lock(&hip->extents_lock);
 		res = hfsplus_file_extend(inode, hfs_bnode_need_zeroout(tree));
+		mutex_unlock(&hip->extents_lock);
 		if (res)
 			return res;
 		hip->phys_size = inode->i_size =
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..966252d129bc 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -242,7 +242,9 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		if (iblock > hip->fs_blocks)
 			return -EIO;
 		if (ablock >= hip->alloc_blocks) {
+			mutex_lock(&hip->extents_lock);
 			res = hfsplus_file_extend(inode, false);
+			mutex_unlock(&hip->extents_lock);
 			if (res)
 				return res;
 		}
@@ -455,7 +457,6 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 		return -ENOSPC;
 	}
 
-	mutex_lock(&hip->extents_lock);
 	if (hip->alloc_blocks == hip->first_blocks)
 		goal = hfsplus_ext_lastblock(hip->first_extents);
 	else {
@@ -516,11 +517,9 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 out:
 	if (!res) {
 		hip->alloc_blocks += len;
-		mutex_unlock(&hip->extents_lock);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ALLOC_DIRTY);
 		return 0;
 	}
-	mutex_unlock(&hip->extents_lock);
 	return res;
 
 insert_extent:
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 9a1a93e3888b..a589130e42ea 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -191,7 +191,9 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	}
 
 	while (hip->alloc_blocks < hip->clump_blocks) {
+		mutex_unlock(&hip->extents_lock);
 		err = hfsplus_file_extend(attr_file, false);
+		mutex_unlock(&hip->extents_lock);
 		if (unlikely(err)) {
 			pr_err("failed to extend attributes file\n");
 			goto end_attr_file_creation;


