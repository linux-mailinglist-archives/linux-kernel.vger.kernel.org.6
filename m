Return-Path: <linux-kernel+bounces-287061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BAF952262
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E061C2111F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB071BDAB7;
	Wed, 14 Aug 2024 18:59:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A43BBCB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723661969; cv=none; b=Y6daW3w8QBHXNXrVEDAk5OWpUXt56DajZqS2RtFeayi5QrNpczAclOK8QLJQyAw2JrT+fozzUeAY1NvkitRech530pD7Ezh8XdeVWR1jDz/slUNZmcG2LvilFIjVJ3NxWtLyGu3K5WpE4tydmS2LYq7b9eojlSCeGV2UXh8e14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723661969; c=relaxed/simple;
	bh=g3tMJjJeiQlgWdwEXS6ArFvQNqcaCCsdcMVTW45iVDs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I3/ZOxUTLbr+s23Cw11WENon90+ljgADeH4WEHe/kYSGtifiRpEpRvlUOKy1gSAW9r5sW+6LmHc/ky/pg2vT6qGHb/ai5j9JE2RmWYRx7eMwPYOQRg2ExLIOH1QpqsgWvJqo6L9Pc3NM4CTpwqYmxNQKNG8uLwDlBU4pJlyrfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-824cad19812so27485339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723661965; x=1724266765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NYPbHpFKZDLMPjxtO9H8yQ3t7Ztak3dpAAu3jg2Qjg=;
        b=xOFS17uWG//mIHmAktphVzrJkKa77UzMW8XEhxD4vEgAgSvraCIrBnkM7b2kZ91hg8
         JBBd+m0I66hk+H+++pLWPkhl9WVLMoY5iRzS/aXVEnXA9kvBvN2f9cECHl/SO4uoNmMR
         QIvhcpoN42BOdIcjrB0i0tR3d6i40VdWkMQfQl9xEXtJmEFOi5uBvB4wXmcPZSi+yuPO
         ReAWAlxRS2jPFTfOUZRdzny/RE7M3nVAaHRt2O/AIJrJqASitAygUCuoFK0tw5zkIbgC
         eo1D7DI7+fbyGZ5nGktU2aLvNkQVte/guuc3QnIRKXXo9NXD1iYZHAYfOBkx0Hu6yCeQ
         eVEw==
X-Gm-Message-State: AOJu0YybbetgVqhjy6ic6s1/ofpMj+2zWnbJhBkaCEdfaCYlDPwMLlc0
	WsqUHr3gKIQZCNc8ifKuZ5vJROsQfTSWt+1sxaPBr0scVxRu73GQjTrVx0bf21uyHG7A1hd8oyI
	kzgBthvElTM/7byz+AZZIX7ytAY22q9qkavnbyuZXv5rPvsKfGsmHnbw=
X-Google-Smtp-Source: AGHT+IEg0S/rOCthXJCMo3rJQExXwBOg3chXkhPS5wQS0eQMAtWP8EgVz2ujhcUqnDpta5sbNzohXDNfM6LYezjv6KI6/dExu0UY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3407:b0:81f:904a:51b1 with SMTP id
 ca18e2360f4ac-824dacdc7aamr5980539f.1.1723661965571; Wed, 14 Aug 2024
 11:59:25 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:59:25 -0700
In-Reply-To: <0000000000007dfbdb061fa35855@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bcec5061fa95396@google.com>
Subject: Re: [syzbot] WARNING: lock held when returning to user space in f2fs_ioc_start_atomic_write
From: syzbot <syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING: lock held when returning to user space in f2fs_ioc_start_atomic_write
Author: djahchankoike@gmail.com

#syz test

Reader lock unreleased when returning upon error.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 270c32e3385f..3ce8478ae5be 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2172,6 +2172,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret) {
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+		f2fs_up_write(&fi->i_gc_rwsem[READ]);
 		goto out;
 	}
 
@@ -2181,6 +2182,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		pinode = f2fs_iget(inode->i_sb, fi->i_pino);
 		if (IS_ERR(pinode)) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			f2fs_up_write(&fi->i_gc_rwsem[READ]);
 			ret = PTR_ERR(pinode);
 			goto out;
 		}
@@ -2189,6 +2191,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		iput(pinode);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			f2fs_up_write(&fi->i_gc_rwsem[READ]);
 			goto out;
 		}
 
@@ -2202,6 +2205,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			f2fs_up_write(&fi->i_gc_rwsem[READ]);
 			goto out;
 		}
 	}
-- 
2.39.2


