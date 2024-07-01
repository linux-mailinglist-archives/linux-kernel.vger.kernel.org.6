Return-Path: <linux-kernel+bounces-235838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9191DA4F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E251F22201
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A3A8286F;
	Mon,  1 Jul 2024 08:46:00 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937536AF5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823560; cv=none; b=lNV78bJLJYZyqKDY6Xet9rDhyhPBxS5QNXCkCdY9W2i6BTKKIAlCmJF4l2YpJ6TFQ7uM9C35pnl9ppJssVeETVd2TuaflVn6WsnFec5A7lSXItX04I0sdVJ5UqKsInA6CvvgTypXBYmCiurvHqah8sp34T7g2LJIFtjTIgPcNdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823560; c=relaxed/simple;
	bh=Cq9CeYaW5DvHjzhAjJ0eBF81E0Q5j+R7YlaO4CRbdsk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RQducj8gUTWdJjVfkXQKlAGDww2QsO5wVxQDgRUCcD//ApiYNJQ+xe00HdbhQbsviHqOY4XsI7rPipqGM3sMJU6sZCBZFyfuWGnffcBNt8SGRTQ291i3J6Mrhl/2HTBQrqcMeQ4b0987WWDiy5Bv2jfd2RBJJJ3qs34dJax6pGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3737b3ee909so34321825ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823558; x=1720428358;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRl1TrLOvsoM5tfnEtPPLlkhvInFM5lQwLRHWYew8Eo=;
        b=eGhKlQVWZeHyb3ZFo+KnzGzSz7Z9FEThJ45q9bMyqxofLFvbljxTdNLix+ULEk68On
         kkZcT0xqASvPnTjxXyD0JUQFUoCb+tqoJ9aVcIpRZMOXGYdvr1tEJorjKHCBuNy233g6
         hFdVeR9Gtia/BR7n5YsisGFDLAk+Yx9vQ8UVGKib8x3DKGebVp684ioW1VqAVUuQP5T5
         FPLF4P7aIjjmzffpWeY0z+JBKZGE9fGRCcNI3EdZckmxiFOQrnSmIOcnjj3sWY6qOd8m
         81eoBrqjnoM1K4FWHyLjPhO26uHvJYUJGMw+BKCCloAbnEwYuegDC9gURbrYnzreLw+W
         p7lA==
X-Gm-Message-State: AOJu0YxopJVvnrfbygbFuy781HuNQrQsYEk/2YTTEQf28rca2ZWGjDbw
	/fjixZ/Eznjec9U7bqfZHYkxQ7JK/D7XPJk9SUEr8bv9qCFprNg8BPhaPoEbnp5pIoI9i9A8pld
	GLa9d5J898M/WDZROOhac8brH1L1XlfNIac040S6R40XmykerDtOFJcg=
X-Google-Smtp-Source: AGHT+IG4odfCmSnzCdrjrmy9Amkx446Fqz9czrDtKbt346p43MBNTtLUrdX7L4Ov28g8ta+I3NkVfdbXDeMrZz2JcrFk90HyT9pH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:dd0b:0:b0:375:e04f:55d0 with SMTP id
 e9e14a558f8ab-37cd0a0abd2mr1776735ab.2.1719823558257; Mon, 01 Jul 2024
 01:45:58 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:45:58 -0700
In-Reply-To: <000000000000f19a1406109eb5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000443e28061c2ba0ea@google.com>
Subject: Re: [syzbot] [PATCH] handle EFSCORRUPTED, drop EXT4_STATE_MAY_INLINE_DATA
 sanity check
From: syzbot <syzbot+18df508cf00a0598d9a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] handle EFSCORRUPTED, drop EXT4_STATE_MAY_INLINE_DATA sanity check
Author: wojciech.gladysz@infogain.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
---
 fs/buffer.c     | 5 ++++-
 fs/ext4/inode.c | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4f73d23c2c46..10514fa9851c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2163,7 +2163,10 @@ static void __block_commit_write(struct folio *folio, size_t from, size_t to)
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
 
-	bh = head = folio_buffers(folio);
+	head = folio_buffers(folio);
+	if (!head)
+		return;
+	bh = head;
 	blocksize = bh->b_size;
 
 	block_start = 0;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..e7a6958025ee 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2948,6 +2948,11 @@ static int ext4_da_do_write_end(struct address_space *mapping,
 	bool disksize_changed = false;
 	loff_t new_i_size;
 
+	if (unlikely(!folio_buffers(folio))) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return -EIO;
+	}
 	/*
 	 * block_write_end() will mark the inode as dirty with I_DIRTY_PAGES
 	 * flag, which all that's needed to trigger page writeback.
-- 
2.35.3


