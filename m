Return-Path: <linux-kernel+bounces-235809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD291D9EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237A71C20FED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D983A09;
	Mon,  1 Jul 2024 08:29:51 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F15839F1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822590; cv=none; b=cBTIjIFCkcbWF2T3PuHwvgBEOX8CVaFXUjbJDTiYB7rlI2vkTIAiLwQutMCFFKV9GIlupx2DhrQlSp+7Hj+SHSygAtab1FB94yEUNBPDy+9dlJHzJJItMMpfhc9M+mCF4PLgljkbaX/DbW2LA8rkqscVB7R4Bvv2f2O5szpzm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822590; c=relaxed/simple;
	bh=dsLvM6A/NR+CxJT4/b0go59hFzrUqWywWs1EWYXaLz8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bhGVvTgKlDsRZb7K8jtowcfE2paC1KU5H7W56xvy6M/K77MpZFdRr2OvktcVsnbIue/g+IpyGcdQD4/Y6TxPj8erJOjUu5c5mTqgeqC3Wy3y7M2YvIGY00LX6LfjfNPmjj1JpvpVLzDFeqIuSyJXMgsKMFEpVmm4fYA0MT1QRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3c9764edbso280354939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719822588; x=1720427388;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjtIOKXXqcE84q6BVLWG9Kjx/jd/kn7ucqS4JTICZjw=;
        b=SujLdf3Jkgsp1F/OTWt+3g1elSuafknYJFpZKzQraA8zAU4vHFZwVZlfxq3oeNeIx0
         J9im0wzq/Ej0x9bCim12vh6rZFz9cHKY7HFsnXdmcpfesQMXF9+RsdlqX0GivHKW+ED7
         Sdl7nivUtefcksLz+7MSj1/cSwqa1EgiiaY5Rkq49NkGzJUCUc2mbnSdruUMqDKxhGzz
         SxExehYFxQVUzdnmGefISlpTh8I7uV+5C0sQcJpCKnMn8PFV9HMp82V4UGXhWUGJhxui
         UhSqW3pxhRt6XHfZ97ujYaAlA+CoYBGssBcsxTAMeBaJxZLxk/xf+Zybesk7HnVWiCO7
         mArQ==
X-Gm-Message-State: AOJu0YwnlX/UchG07TewTwfK3UJUgO08M/wTjBl3mgysec8j/y+3Y1/L
	zMDt9h26MFL1qu7uQlQ7u6xDGh6mza/dpk+/3njOPEP8uMmHf/hkTekT+nIP2uQPE/CbFWFR2jk
	DhJ6Q3lAMfXUQ5FX8GL8RHL4oZynhV3G8GO9bhzmuMNUDHnK1YWKhdHI=
X-Google-Smtp-Source: AGHT+IGawY8Cf6Y1SZaFyx8TXZZyXRH/Jjt5F6tcXVNmnnxymlk7FFOfOSNWdZ0GreP68Np4PlfWh4eW7Zu9YWXh7xJWRH39/qWm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3488:b0:4b9:ad20:51ff with SMTP id
 8926c6da1cb9f-4bbb6e8ec35mr369886173.1.1719822587664; Mon, 01 Jul 2024
 01:29:47 -0700 (PDT)
Date: Mon, 01 Jul 2024 01:29:47 -0700
In-Reply-To: <000000000000f19a1406109eb5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a2b4c061c2b66b5@google.com>
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

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux
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


