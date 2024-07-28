Return-Path: <linux-kernel+bounces-264491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697993E418
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F2C1F219E5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD9168D0;
	Sun, 28 Jul 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p4M6jJUJ"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218C125DB
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722155028; cv=none; b=HPr5d8wlL2CUqVUwTl8DmEQXEcukMA1P1e/wrpj6EK4twiLao3yXs8pt/E3DWLcDoOpgCqGo7RCfuJlcNbWna4Y9o+fiA9PkQDyR4pBKMZYG1RYsFia2WbfQagxDTWd2LY2u7aD28vfVUQur2ts5ZsFuym4+JmYHc44PK42cKVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722155028; c=relaxed/simple;
	bh=4uMpq2KhlmtOhjMJWjHPD+KOGuaa+UIR/ABBDLOMPgs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NIP7Fr+rwxzLrnXCpKu9d8AU2aaMShxijtYTXAvFy6tRiw/D8NBNo2PMRF0nugN2ro9Y76UxOtFAkrCmlOANUu1PVwnVBHGg3XGEmDFzGAXr/ySHGqx4jF7OHZDEJcMG19xw9B1Zc4uLC3DSWZYmysB3KYP33vTrckaMrjLnoh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p4M6jJUJ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722155015; bh=SMVVMW0471qkIh+ODSUoaMHDA8UtlbzxqjHiqtGFbI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p4M6jJUJEijNW1uTB0S4a42E1fwb8IFdKqY3/2Sq4kenXjNNndyp8RnH3y5Xv1FIy
	 6X4a4G1kfL8ib5me8uOtZy8qkbRaveOgCVFpTJ/1oXao5mCzwSs7cSSZqLAlZzsgub
	 t7mHTaqZxK9gcTg4ikydTD3n6Yjs/MWeE2doBr88=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 45E91838; Sun, 28 Jul 2024 16:17:30 +0800
X-QQ-mid: xmsmtpt1722154650tjxa845ew
Message-ID: <tencent_44C3065D498F6EC66EC90CB967EA46FC5206@qq.com>
X-QQ-XMAILINFO: Nb6LX7dsrQEkqiTgdOv1j7j88FoPWHI6O0MFXFq9gjv3RWZzMt2lpnEOtKSi5K
	 FkHIcPVUSYTQ19ten2SmyLXXmXb52h8fBx5gl2cFibe9hv/CSZ1etVQ13C5i6RfjER63Vz29ouAS
	 iwTbcQxmxPSDJjBySvna3fCUoX7tekGjlcGnfH46U8BopI2KX35c9VpPdSlvflzIoSRAnyryx9j/
	 iH9vz3NHNXGFImt8oTB3SsfkrmnD0TnVrtsfD4yg2ltx8d+7xTxG875N8CyNts7jNEI/OY6VA//T
	 QRcEOg+VMb1BW2zdb1LPCdDUF50slBH3cBa+ziYG7aBmbk3sqdcUJfgQVn8kBRlE/dbZxLF7d5r+
	 2YpCvZDn1k1E6FE/vgPjzG/cWztzFtBRtqoB96eq8Dr6FqWOoGjKD5lVpZQA9Gvo4IiQbel/GXgL
	 T5usAA4D/8fNbrosL5yC/4OcsUWhczllRei0WqQiRb97Epc1T+fKpIQXaLij/gT7h/Oxp3SNJujJ
	 I1Xj9aA5+yf7fJw4NGngsbTF0pjGKrrnGW3kbE7m6IfWCOgrHvcA1B2jp++0wjDJjm5m8dTKtkYf
	 q2BOZDOjWAUhVARWMqyKBP6T9BhnVHDp1e39NsE6qvXpLFCqtkR5Kt755kDVOAx3k+enozeRGGIB
	 pGc+Hqxnit5YlY7I0OYUBIxqIAb1kpfGx1FoQLGcsGs8CeYd2SsdamaTSVAx7eBSLZYhQz4UBTwK
	 2Oc+ojtJyANAYn2kHcBYi1PXSpS18R1R4Ia4no5NvN6ulF6bNSzJeZlPER5ZqCMDcBmIZkhmah7r
	 JBrGow+GOxiuTcgd9lD5/9rKYNHOL9Y1An3My7UM1/x1TvkwtZI0haWJOskmfixUluG3outQ1faE
	 4LKDSS8uW/dBlmnvK+5S7KXGaL2bBqSpbzwUNYF8z+wcfxNg1d0KE=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_folio_end_all_writers
Date: Sun, 28 Jul 2024 16:17:31 +0800
X-OQ-MSGID: <20240728081730.3548044-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008a971a061dde1f74@google.com>
References: <0000000000008a971a061dde1f74@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in cow_file_range, only ret == 0 means succuess

#syz test: upstream b1bc554e009e

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d62c96f00ff8..d08138fc3dc7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -762,7 +762,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
 		return ret;
 	}
 
-	extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
+	if (ret == 0)
+		extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
 				     clear_flags,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
@@ -1043,8 +1044,15 @@ static void compress_file_range(struct btrfs_work *work)
 		ret = cow_file_range_inline(inode, start, end, total_compressed,
 					    compress_type, folios[0], false);
 	if (ret <= 0) {
-		if (ret < 0)
+		if (ret < 0) {
+			unsigned long clear_flags = EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+					 EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING | EXTENT_LOCKED;
 			mapping_set_error(mapping, -EIO);
+			extent_clear_unlock_delalloc(inode, start, end, NULL, NULL,
+				     clear_flags,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK);
+		}
 		goto free_pages;
 	}
 
@@ -1361,7 +1369,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		/* lets try to make an inline extent */
 		ret = cow_file_range_inline(inode, start, end, 0,
 					    BTRFS_COMPRESS_NONE, NULL, false);
-		if (ret <= 0) {
+		if (ret == 0) {
 			/*
 			 * We succeeded, return 1 so the caller knows we're done
 			 * with this page and already handled the IO.
@@ -1369,10 +1377,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * If there was an error then cow_file_range_inline() has
 			 * already done the cleanup.
 			 */
-			if (ret == 0)
-				ret = 1;
+			ret = 1;
 			goto done;
-		}
+		} else if (ret < 0)
+			goto out_unlock;
 	}
 
 	alloc_hint = get_extent_allocation_hint(inode, start, num_bytes);


