Return-Path: <linux-kernel+bounces-306784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD4696438A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68C2B22EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA09192B7C;
	Thu, 29 Aug 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SXfQvmlq"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17187190679
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932359; cv=none; b=uMm0V7XuYtNK/fyTnrDsi7uqpAvakA3yH8vgvSxjtfN+9MTVvjMSWS5gXRnjW5LcyI8Kqkm/iuJZtazIN7LXaRrCxEN/Bwo2Rmsd07sB3UE6rlskW+H8zMSAzvtOdhUwz+yih0ntUqLOWxnjj4mpYn+CAeteUXx7ugQa09aPwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932359; c=relaxed/simple;
	bh=DSfj3DMcj5FnLCzR1eApVAgMxL/m9qF4qtAhqVIOcnA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=W3yhT4Y+0S3TCx/7RGDej/dpe3ZPkUHTvbOFfXy7KsrIDqOwsDrUY+a1nYkGsev98+NzMS318iIYN/dob//u1JXF9lmP61q2gY+j7xDHhDzkiv8Gro4BiRkrZrI5QhLUYRLYMT79hHXbOAFJ5lwNdP2ly6iGxgYcta6xWoX/spY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SXfQvmlq; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724932351; bh=I/6b/6trAgjGdtT/pGMgbHHJchrXPV/+fKWvr2SL+ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXfQvmlqWpMflrbbp1VW5vUM6S2HbrQaPInKlG6j3zrvHKchVCKhS7kPL6PnXo9mC
	 3cTOo3c72Ir20RQe8QVPDKhrHhmFBzz7NbYK73CkMUQL/kFkwMI0sav7Ugc8uW7KcD
	 c19q42E2DahWK/ZNJsp8iEi/xXfPQZ170s5hvZ0g=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id C4811C1E; Thu, 29 Aug 2024 19:49:08 +0800
X-QQ-mid: xmsmtpt1724932148tma8z4nyw
Message-ID: <tencent_82C82F756FE496A0E9E2EE16CC747ADE6C0A@qq.com>
X-QQ-XMAILINFO: Ny9b0zP53WzJ15C4Y0VWrNcxXIKsGFqqcMuoFuEz/TbGdGopp9LK8OeSr/nSaX
	 /hZJ08Q2TIl7UtBFtvaRC1KM0M9DpFP+GY3RtpXMqrZPdyIohRhljOyyqFM+VJcGFPqLtmW+x3St
	 8qqlAn5pTozXoM0QzgtTQ6eqRDUtTUOs2U86dEpzB3LqhCDl8/z8TN/fm2XuC2UVhsDzla52y2Nk
	 d7UDS3XlvnbMf0yGVwHQlhc3Ja9Zh97f1ZHtJkBrB7ljPmKo31qnFsEEFg+G4C/xKtM1i5qY3xIF
	 hfGgM6vV2xbQvy0uwS4PcWG3x4axmjM7+cOzosLsRF/FSbZmB0BFUgsEljFyBLTgaIOYA5SylLtg
	 pBH0WBkJsXE9LS72ETc0KrO70wLENDAylB+0cS8uizfcYyq2aMyHhwkgl8AAk2mzoTrVMfbKdYqo
	 fxOzjKFJ47x/GGFYOTGn5c5yfYI65pBWU7hwCKOFgKDlaJE+pSqhJtG5lBLtpmVcAnZw3ab/MzI2
	 /u/ZITeeFDyPn2bNbOO2ANE4OqCdY048uv9cGjrNS5A5T/t6onGrZR6e1VASIhUp2WChNEVtsOuZ
	 V8DdHWb8egUdxrerFF1nk9HS3d7hZSt9zy4ECuj41ycxbGv24anrjmhQACvwGpRiz036ckoI0St8
	 ZZCpgzWi1ujuMAXKoziNXv8JA5pwqydqk4zQC2xHe6yHt1LrG817Tf69Lp81tp+21vyOrC7lFx2h
	 aqoAJEhOIyoeVatbCo8IC/Iw5it6CrLQsWQPNeRP1q3Y+p+Tns/+4gfyaYpzqsBPK8sQAMQjCcIz
	 4Gp59u5/kSt/R8hH06Taq2kJThXEk6pXB5Ea98zKlxubNrZlYd270Jl+yCNmMJm1noBOxWLqSA3n
	 RFp1gzINRQTm93eIMuyEI3PazMDEW4M2cP9jguOlwu3Cs9xyv30nI=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
Date: Thu, 29 Aug 2024 19:49:07 +0800
X-OQ-MSGID: <20240829114907.755362-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000008851fe0620c5f51c@google.com>
References: <0000000000008851fe0620c5f51c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 10ac5f657e38..4e2c30acca67 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -384,6 +384,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		free_extent_map(merge);
 		dec_evictable_extent_maps(inode);
 	}
+	printk("em: %p, blockstart: %llu, mblockstart: %llu, %s\n", em,
+		extent_map_block_start(em), em->flags & EXTENT_FLAG_MERGED, __func__);
 }
 
 /*
@@ -493,7 +495,11 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	if (ret)
 		return ret;
 
+	printk("em: %p, blockstart: %llu, em refs: %d, %s\n",
+		em, extent_map_block_start(em), refcount_read(&em->refs), __func__);
 	setup_extent_mapping(inode, em, modified);
+	printk("setuped, em: %p, blockstart: %llu, em refs: %d, %s\n",
+		em, extent_map_block_start(em), refcount_read(&em->refs), __func__);
 
 	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(root)))
 		percpu_counter_inc(&fs_info->evictable_extent_maps);
@@ -743,6 +749,11 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			}
 			free_extent_map(existing);
 		}
+	} else if (!ret) {
+		if (em->flags & EXTENT_FLAG_MERGED)
+			ASSERT(extent_map_block_start(em) != EXTENT_MAP_HOLE);
+		else
+			return -EINVAL;
 	}
 
 	ASSERT(ret == 0 || ret == -EEXIST);
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 5154a8f1d26c..a84ef0c7d601 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -154,6 +154,7 @@ static inline u64 extent_map_block_start(const struct extent_map *em)
 	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE) {
 		if (extent_map_is_compressed(em))
 			return em->disk_bytenr;
+		printk("em: %p, disk byte nr: %llu, offset: %llu, %s\n", em, em->disk_bytenr, em->offset, __func__);
 		return em->disk_bytenr + em->offset;
 	}
 	return em->disk_bytenr;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b1b6564ab68f..45f3b31aacc3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6958,7 +6958,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 
 	write_lock(&em_tree->lock);
+	printk("em: %p, blockstart: %llu, start: %llu, len: %llu, %s\n", em, extent_map_block_start(em), start, len, __func__);
 	ret = btrfs_add_extent_mapping(inode, &em, start, len);
+	printk("ret: %d, em: %p, blockstart: %llu, start: %llu, len: %llu, %s\n", ret, em, extent_map_block_start(em), start, len, __func__);
 	write_unlock(&em_tree->lock);
 out:
 	btrfs_free_path(path);


