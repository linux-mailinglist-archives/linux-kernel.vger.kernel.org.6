Return-Path: <linux-kernel+bounces-288886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5141954009
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85128284635
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9029482E4;
	Fri, 16 Aug 2024 03:26:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DB1CFA9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723778790; cv=none; b=tmsO0CvsdwQe8HJHZh34jJ3BIUNV7iKC/HoWs1gdBMwJkO0Ml+xqHp29hHL8r0MK/hJLbP8qrVrALl253oHzY55r8lDXEtrbFvxlgT/dQ0TKpZdYNkZ4/smgNjhXzpddgY6D5dgANj/k67emHmU5rUG0H/Huzi7MUu0SEGOiyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723778790; c=relaxed/simple;
	bh=oD2hCBSH+oVTR2Akv9VgvdzoS4FWCluJXdudCC73LfI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=maguvQrq6QfkKImupTcJA030UIYKALpnRqqfAbIwelUlM5KpLOe/MAwXXbEs9NceMzeLfo10lA8H/jrdlNyTQX0e/UBzRTfeGH5OPjxLA8T0asVxX1AyGMOpIIcoJg63LTtkNETQ1WjrKgXKClTqmDCqUzEZ0vRYtyVvq6fA8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b0bee2173so14980685ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 20:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723778788; x=1724383588;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXespDQgFzxl0/FXMR9IwFB9Sp3A0v14n52CwmoVJco=;
        b=pASJ4u4Ttorzd0gx0UST3xkKc/3hwTrre+r1aix0ygu5r7SxnEyVIYsWU68pZtGUWY
         HowocrYuXGL78uJRsaW6lU+YTk/iPclz1b/fZ78rcZD8YgAqKlSaZ8ApeZx01aYjp5mw
         A1Q3hRlEdopOOypFMVoUChb5shpjDgE3lpqNnUhX51sBm2Q0dxObtAVaSd6/WoAkwCQi
         Wt3e94oGD8c6vrnoAfh4y8CDoV4KgZmj4JtQuvD+GAngmYzM5njfUCjlIcIv5Zw+MF9R
         GJBNQIgT/W8iujRn5xQ0KdxTDVG89aw0gKMSp236MVCnJ58QAMhxXbYrPcfJun6PNBQi
         oMnA==
X-Gm-Message-State: AOJu0YwEhwbmRcVsaxvwU7EYpv9RkBeL/KGGAGG1PTwvD8RFdYXxcuco
	086mxSwV6rT5+4T+F2hR/LdRUTdj/9fLnLXAcoiLyA3gcl3pMhVGABnxgZNFoRoipMV82LYetFt
	wh8RNUIc6u4zC3UotZ4cp3jK9SVrd7Eu186anksmaRJrzh3cQnVnz9ek=
X-Google-Smtp-Source: AGHT+IFVBD9HRDijV88B50l8qqVSBTioqvP4lbigqup5aWN9qEK5u33ZO8HmE5vsNa7vVEUdwYBBpb0TOcKRQGUs3ajozVgrs9ca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c7:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39d26d95738mr1661125ab.6.1723778787974; Thu, 15 Aug 2024
 20:26:27 -0700 (PDT)
Date: Thu, 15 Aug 2024 20:26:27 -0700
In-Reply-To: <0000000000004e582f061fb691ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005431d1061fc486fd@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
Author: lizhi.xu@windriver.com

clean dirty for the release inode, stop to worker wb it again.

#syz test: upstream d07b43284ab3

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..156943973aa8 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -115,6 +115,7 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 		}
 		bh = bhs[i];
 
+		printk("jbd: %d, dirty: %d, i: %d, bh: %p, %s\n", buffer_jbd(bh), buffer_dirty(bh), i, bh, __func__);
 		if (buffer_jbd(bh)) {
 			trace_ocfs2_read_blocks_sync_jbd(
 					(unsigned long long)bh->b_blocknr);
@@ -170,6 +171,8 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 			continue;
 		}
 
+		printk("rf, jbd: %d, dirty: %d, i: %d, bh: %p, buf lock: %d, %s\n", buffer_jbd(bh),
+			buffer_dirty(bh), buffer_locked(bh), i, bh, __func__);
 		/* No need to wait on the buffer if it's managed by JBD. */
 		if (!buffer_jbd(bh))
 			wait_on_buffer(bh);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 2cc5c99fe941..3b9a8b62a57d 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -489,6 +489,8 @@ static int ocfs2_read_locked_inode(struct inode *inode,
 		}
 	}
 
+	printk("can lock: %d, sysf: %d, blkno: %lu, %s\n", can_lock,
+		args->fi_flags & OCFS2_FI_FLAG_SYSFILE, args->fi_blkno, __func__);
 	if (can_lock) {
 		if (args->fi_flags & OCFS2_FI_FLAG_FILECHECK_CHK)
 			status = ocfs2_filecheck_read_inode_block_full(inode,

