Return-Path: <linux-kernel+bounces-306153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7959639FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC1DB21A82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E65146D7E;
	Thu, 29 Aug 2024 05:42:42 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190541C6B2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910161; cv=none; b=cOy3qduI8hFwOS4QfLtx1/HPn6XjERWKZVlRMlE5yBsaYGr5mnzYx6ZapUJTOM0D6NgsRtDna5FuCeMFsS5Xeh9/huRolKkvAUwGDHw9M2viapZeVaoYYTm5UxmrrlZirpayorbDCoBsD48cW/SzBGGe5zK37jC6nSib0mhg3+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910161; c=relaxed/simple;
	bh=DPGIHL2xqCpRpIeuqliKBmpCZuFUzJXdjTOOZAr5/4A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oS8EtRKsgsQUGP7PVMsnThhHs86XS+TMSgF4H8tlyKe1lUYRShsh4eyx5AkOZTQ0y7ZsrjpGbO4++weUh8sX4BJLsduqABGzhDk33WlTt/sVcwXvFvn2PuBRdjriYtuYe952gDmnQYwr0jeJFr+mDW9DEdRJ68mGN/GtSg3wEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d51267620so2654365ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724910159; x=1725514959;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIt/byNmE3xDvUOKnOidaKkycTZU/pTAF1NPAuUVJZA=;
        b=f0wotsWgX0L3FXoFF7RqGaEta3UVh89ewcKknugRqgv6gsBo9kcuST+mloBjL18dUz
         n+otVOYPM72XSOGXNm5VBvCE+4Z6ulRk9HNSy8ZZxQeM1sP8/LIDj+cxhu028DYPApiB
         1baI4qU6JccD3rZjqy1tOaJhb8cJAOLHt/SSBqta42qahZGAWpa2w5tmxMXWhu/jJwQT
         gz59B/tethOtcuoU1BI8lKQ7+6B/KIZdRqp7BWspy3dlQVy17Iq/3ZKspwvYlUC+XRQv
         Sqm5e9NWgJavO6O0zxSvug27zwB/7WOPxxrs2OGhBqD3wIV9HPTmEoQhe+XdT4K4s5xa
         6O+w==
X-Gm-Message-State: AOJu0YwfkfLXkvnsg0sFacyZgWqCrhSOn4ndhLBLkXfSzsY8QCelOfKB
	MJOMxzlJkzL0109BGiGWyuTzkUQTsOTiRSVQ5gLL8yJcWiq3Fs9DfFr13bhHnZp8y26v+8hazj9
	ZSPqBrGjGc1kw3XOOI3R8MS0VMAxbQvW7v38geMqbaywpnbmm9Pmu4GQ=
X-Google-Smtp-Source: AGHT+IHmXNGXZ6X/bQ3/JO38jQSBaMrfCGhsbvH7Pywxcps8rC4iufPBHUogCujBe4ZyESsJ4jmIZa0WaD4dAG3szVJWlsg3Vb31
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1647:b0:377:1625:5fca with SMTP id
 e9e14a558f8ab-39f377ceda2mr1069585ab.1.1724910159194; Wed, 28 Aug 2024
 22:42:39 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:42:39 -0700
In-Reply-To: <0000000000008851fe0620c5f51c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004efde50620cbf13b@google.com>
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
index 10ac5f657e38..397eee4c4217 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -384,6 +384,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		free_extent_map(merge);
 		dec_evictable_extent_maps(inode);
 	}
+	printk("em: %p, blockstart: %llu, mblockstart: %llu, %s\n", em, extent_map_block_start(em), extent_map_block_start(merge), __func__);
 }
 
 /*
@@ -493,7 +494,11 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	if (ret)
 		return ret;
 
+	printk("em: %p, blockstart: %llu, em refs: %d, %s\n",
+		em, extent_map_block_start(em), refcount_read(&em->refs), __func__);
 	setup_extent_mapping(inode, em, modified);
+	printk("setuped, em: %p, blockstart: %llu, em refs: %d, %s\n",
+		em, extent_map_block_start(em), refcount_read(&em->refs), __func__);
 
 	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(root)))
 		percpu_counter_inc(&fs_info->evictable_extent_maps);
@@ -743,6 +748,8 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			}
 			free_extent_map(existing);
 		}
+	} else if (!ret) {
+		ASSERT(extent_map_block_start(em) != EXTENT_MAP_HOLE);
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

