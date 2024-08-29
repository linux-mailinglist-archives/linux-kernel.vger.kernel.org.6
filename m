Return-Path: <linux-kernel+bounces-306473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897A963F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C128A1C221F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4618CBE9;
	Thu, 29 Aug 2024 09:06:50 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695452C18C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922409; cv=none; b=MkyJLC90+AyDzsyPOtsKKD3RpAWb2QKJPqHENJpErOlSexAB7FXVKPrIv8GEhRYl8pK32yawKgl4ZsTqzdorA+X3MqPU3D5Q7PWZiqqeZIiOUdW0CVZ/BpCi6rsBHRt3/ewt80OVMPud9TYh8TdfnRjhbTcgwhAxAaPqtoaTtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922409; c=relaxed/simple;
	bh=C5Te3o2BVXqy49pktFhQ3MUPr6xjVagPBs7hRpk2F5o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pnpOWiCXf59ICYJiYlYAqDr7n5vG6iS+n8Dh+I0jhUig3CcBuSam1elaqFuzY+ysv8qmozJmSUDBd6XtYSg63GQ5tCuOKnMbIpEj66Jp8LqZXqYnQGhs6ula/Gdt91wYlo2yvuNdYjzqHU9spkOliPcqdSMuIYAaqexctlr3OV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f968e53b0so52510939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724922407; x=1725527207;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6P4QN7SRHC91madBXE9vEdaIMhMGk6ZceE8oo7p2zjc=;
        b=fHdfbb29CBPGFwTieMty14anjtXbjYyOzZUJUzPeFNQXvNo5IuD23Fi6DnSDEkvgrE
         sK54veUDDcEQusOt2zmypyFrmw3IYkL1Gbxkz32/iC3tGnB/0yG1dANsPMlviSrr910U
         xYSn3uq7rh6PxyaGohMJ3wpvnw4fo/qhnsKjHAqCxzFc6VI4aEomNWOKgmL7cN/ouP5B
         WySuUE9j046Wk7fcXRGffil40iOKmSYSHtF0TLHAO3MEbNzEdAwxGBGahMrsSt63A1Os
         t1e3LNDfc7W0fspA6zasDYK8LuCa8q6tbx/3GOB4Wis7Yxtp5hkidS/TwgZbGN64SJPf
         EZsA==
X-Gm-Message-State: AOJu0YxVGN3/3wGKueh4VmSqPHdWD9MpW8pgJZZUXUoEK49WgdF0fQzb
	WdRyB9KRJI++vqm9HFoEwN9P9AAD+dhZVHhkyNU6e40hktNKm9NuKFtBVk6PCeWxPQ7vRJIJ9dz
	ATkQO4vhkwt6Pq98rIwsQdMtSAd6vuqURqWjUTyhaqbJo811VF1xiU4E=
X-Google-Smtp-Source: AGHT+IH9gEdCuAMev8q7wYWiceyqGunWEpDpIDZoEgAxOnVsgQbKUnc3JfV4Vm8I6BgYW4xy09aef4Sf0FlLSHmW8PzjihzsPsDO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:358a:b0:4c2:2ad5:bfd0 with SMTP id
 8926c6da1cb9f-4cecfd55f17mr144206173.0.1724922407509; Thu, 29 Aug 2024
 02:06:47 -0700 (PDT)
Date: Thu, 29 Aug 2024 02:06:47 -0700
In-Reply-To: <0000000000008851fe0620c5f51c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d74bb0620cecb6a@google.com>
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
index 10ac5f657e38..fc6e83c6e69b 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -384,6 +384,8 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 		free_extent_map(merge);
 		dec_evictable_extent_maps(inode);
 	}
+	printk("em: %p, blockstart: %llu, mblockstart: %llu, merged: %d, %s\n", em,
+		extent_map_block_start(em), extent_map_block_start(merge), em->flags & EXTENT_FLAG_MERGED, __func__);
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

