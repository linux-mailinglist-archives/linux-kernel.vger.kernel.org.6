Return-Path: <linux-kernel+bounces-306030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B003696383C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E003B221FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47829424;
	Thu, 29 Aug 2024 02:35:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114E618030
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724898923; cv=none; b=rsaCN2pPghwQcAOCYOzH+8ZignLCphnvGbBP8a6t17SyKs5I7GwbyFDjOsyx6eLYw2N0tV44gAiotU5YyZfnYjKD4GSsPUUk4r4uwXVT/I7Dq3kBv8HXcW0jsF5CBFAc9n2aPIjnZjsOxOynZlWocn4J7a90lGJMJbm9fZ3JHC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724898923; c=relaxed/simple;
	bh=y+h5dyw+YngnrKeGh+K2Fvi/STeV6H5VdXWvXOtEnL4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YQohyycDNMnC2Cb4tIqaF0yybBmZCwJyckllHnXuS9Jw04/ZmMVBWfxb8ghd9BVhO+jOeqT/UVvM3Gt20iG6CWMMDU2E7dNtQ+B+ukVdLkEuzZItfo/jhF4X5t+T4NpOZ9jX/+02n1D/DQkUPieat0dfedq1Hb1OQdJTCs9L1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a06d2546fso23927039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724898921; x=1725503721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8g53F8AoJegYTu1dXHj7MrsHau951myOfgBYZu1ow0=;
        b=YPrMc8dWAzYa9+47SBZgB6vpZFcWWp4FTMmdvSqIy8O4JofQomAxVRq/5Ih1qjjASs
         hdrwZFMlSWeNjjQRC4wTM2Bkm7vllYku+pHQH1ZXtia29t22PJ8xMX9ay2URoZYwhI7f
         lxxJ4+VV58HWAipM1T3sBMW06MJViw2hXNLn/8fLUHfyP9MsGC6nTP5o7HAEBv3Sq3js
         RJ4rqf3wQpFP5w11QNN4Xvy59DApvZXBQupcDTgoTsX1m8GcocBRIr9wHZXHPQrBoYlV
         4MkL4h066JdFVPpjjX0Meydah6u+9rQPT3U6ZpV3fD/h++VGG4ukE94KAIBWd2vtNixr
         5vfw==
X-Gm-Message-State: AOJu0Yy0DWolQTxj0aIcBO9zh1xl8LF1CeB43aZzGNeNWCz6WZYYbIzc
	22WRLlfieLNbSrS5roPGEgpg4STKOSibp03GeZ/o5/NbFpskrpxQ7oVjTlENtOGrv5qrQd3M/j5
	vk6sq6nefJwQdoK34YdPhl9+GSYHs/Wu7UginuKw/cjSwLyi/p63HZeA=
X-Google-Smtp-Source: AGHT+IFDH7OroQ+RFgwXRNKTzCe5KkLxk5frpKopaaalWrn4DJX3tUF/DN7RiBr0lhUBLNqW7Zrnq2OPlXnfQRXbyKaJIoiAimIf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148e:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39f378fdc9dmr1112775ab.4.1724898921217; Wed, 28 Aug 2024
 19:35:21 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:35:21 -0700
In-Reply-To: <0000000000008851fe0620c5f51c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007910280620c95389@google.com>
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
index 744e8952abb0..c81b23d0d73e 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -262,6 +262,7 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			em->len += merge->len;
 			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
+			printk("em: %p, blockstart: %llu, mblockstart: %llu, %s\n", em, em->block_start, merge->block_start, __func__);
 			em->generation = max(em->generation, merge->generation);
 			em->flags |= EXTENT_FLAG_MERGED;
 
@@ -393,7 +394,11 @@ static int add_extent_mapping(struct btrfs_inode *inode,
 	if (ret)
 		return ret;
 
+	printk("em: %p, blockstart: %llu, em refs: %d, %s\n", 
+		em, em->block_start, refcount_read(&em->refs), __func__);
 	setup_extent_mapping(inode, em, modified);
+	printk("setuped, em: %p, blockstart: %llu, em refs: %d, %s\n", 
+		em, em->block_start, refcount_read(&em->refs), __func__);
 
 	if (!btrfs_is_testing(fs_info) && is_fstree(btrfs_root_id(root)))
 		percpu_counter_inc(&fs_info->evictable_extent_maps);
@@ -643,6 +648,8 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
 			}
 			free_extent_map(existing);
 		}
+	} else if (!ret) {
+		ASSERT(em->block_start != EXTENT_MAP_HOLE);
 	}
 
 	ASSERT(ret == 0 || ret == -EEXIST);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a2b902b2d1f..b588381458df 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6972,7 +6972,9 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 
 	write_lock(&em_tree->lock);
+	printk("em: %p, blockstart: %llu, start: %llu, len: %llu, %s\n", em, em->block_start, start, len, __func__);
 	ret = btrfs_add_extent_mapping(inode, &em, start, len);
+	printk("ret: %d, em: %p, blockstart: %llu, start: %llu, len: %llu, %s\n", ret, em, em->block_start, start, len, __func__);
 	write_unlock(&em_tree->lock);
 out:
 	btrfs_free_path(path);

