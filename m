Return-Path: <linux-kernel+bounces-306107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50E963941
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED651F23961
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF754652;
	Thu, 29 Aug 2024 04:13:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750B200A9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724904808; cv=none; b=Fl5rX7hlLrVquRBh/m04esNL3La9TZhE546g5bv8WCTw/Zrgz25K7Mn4We3PbyIeAuzBus97xmXiLKeGEkzyu5+S9ItNRtuTIp9Qjh4L7iDNP6PG1mPnmAo3bn/p2Ux3ZlfaqqVUCW/KFLZq+hTJWijg6TTpwgPNuQ4f3rOQfS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724904808; c=relaxed/simple;
	bh=gVj6I+54PY0ytFOJPlAHfSJgBDPFp/ZRFV1IkPGF8L0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t0R+O0okZ6TK4ef89+qOiZJOBpeK0MxiKPdisipqchD3fJTx1mh0uOJeOxLQl4W4gmj+ttYr05eVN3VwSVd2zpcbJTSuU79knz+9VacoEVkM+PoAuzUnZ06D12zhJvQh2h3plSTiBPlbGj5KMF4cWP0CixxfVvGIIE399VRfjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8223c3509a9so25799339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724904805; x=1725509605;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqxDP+jnFjIJTZaiPmX+hEKF1cWzFR3zLYcK2b+mdO4=;
        b=pIwG6zctsaOdhNHiAeDq91D7CVwSu/3fcXFRNsAzotBnrPfVpjF/cd5vOFV++09SgL
         6xbEo4yKBRp35JOfqGPc/+Mq+0JwQN/29jJ+eMzHPgFy8znlrs4TB/1brA2InjUBYl0r
         yJQUmsKXapCn/E4nQv8Hgm5UhqWiJ7YyRfBBGyaQBVqoelnk/JwvoACVezTcWRonZDlW
         qhB4HO2hNAuiAIziTwkvOpjm21i8mZ+UYwgROh4qlTuP961ukLA2pBUsRY3xRYnAHyhS
         TUO/e03n0DQueIxAdbb7LoyLRcpm2gsgDOdbf2fDjYIC1GFeAnxmogmIw4JIvQ8wNw/o
         9EEQ==
X-Gm-Message-State: AOJu0YyrBc6TnGU8i/Ma7SqYr5X8sxr8T8JhBG6ChvqKYtu5AyN/b0UB
	IIyMNl92v3eVxjF/OSUnPseal1iSsnxe2De4R8LtleFmehdwey7/xuHcB4nHrj5Ekki3otH9ZFI
	ApMzN611fB9ttajPfmyRK8R1e9QiokJzehftsi0P8Z4iyPDrRbetZ2uk=
X-Google-Smtp-Source: AGHT+IEyioU02Gt+KmtyLGMWVsinEL4yxPtlO9GpGe6eqnamZ8r8nzOCVVg3uEnnH1lUp7KLDBPYCkN60nk4pi2fmyPqDPeOyIXe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c6:b0:808:7e26:8454 with SMTP id
 ca18e2360f4ac-82a10e225ccmr8051339f.1.1724904804805; Wed, 28 Aug 2024
 21:13:24 -0700 (PDT)
Date: Wed, 28 Aug 2024 21:13:24 -0700
In-Reply-To: <0000000000008851fe0620c5f51c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029829c0620cab26f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io
 (2)
From: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 10ac5f657e38..3a6d2b758587 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -384,6 +384,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		free_extent_map(merge);
 		dec_evictable_extent_maps(inode);
 	}
+	printk("em: %p, blockstart: %llu, mblockstart: %llu, %s\n", em, em->block_start, merge->block_start, __func__);
 }
 
 /*
@@ -493,7 +494,11 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	if (ret)
 		return ret;
 
+	printk("em: %p, blockstart: %llu, em refs: %d, %s\n",
+		em, em->block_start, refcount_read(&em->refs), __func__);
 	setup_extent_mapping(inode, em, modified);
+	printk("setuped, em: %p, blockstart: %llu, em refs: %d, %s\n",
+		em, em->block_start, refcount_read(&em->refs), __func__);
 
 	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(root)))
 		percpu_counter_inc(&fs_info->evictable_extent_maps);
@@ -743,6 +748,8 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			}
 			free_extent_map(existing);
 		}
+	} else if (!ret) {
+		ASSERT(em->block_start != EXTENT_MAP_HOLE);
 	}
 
 	ASSERT(ret == 0 || ret == -EEXIST);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b1b6564ab68f..d54c8d2ff1c1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6958,7 +6958,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 
 	write_lock(&em_tree->lock);
+	printk("em: %p, blockstart: %llu, start: %llu, len: %llu, %s\n", em, em->block_start, start, len, __func__);
 	ret = btrfs_add_extent_mapping(inode, &em, start, len);
+	printk("ret: %d, em: %p, blockstart: %llu, start: %llu, len: %llu, %s\n", ret, em, em->block_start, start, len, __func__);
 	write_unlock(&em_tree->lock);
 out:
 	btrfs_free_path(path);

