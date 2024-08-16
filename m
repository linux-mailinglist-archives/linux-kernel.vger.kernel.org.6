Return-Path: <linux-kernel+bounces-289113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A57954227
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B1BB26EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37884A2B;
	Fri, 16 Aug 2024 06:54:39 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF883A14
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791279; cv=none; b=nA3Pmxj7KHktWWrb8wVrjoREQPExxsLbv82rGs5+qvfPrLItrDXT2UbV9vaJHRdulV0py+0iEXQKf9h1XA+lwYYLywqO69ugTLfjrXDHnT6oknkY+e8S8dXYjM79jwjfLvQ7R+dkf8Yo4xkb7B+Lxx2qHaVhAzynBlNjR+Fzh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791279; c=relaxed/simple;
	bh=Qw29rppShCdDm6QOLmWc34/CLwzrzgi9ru94pb7hd3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s76p9aqNKDr8wVEJgqL6pNfLyFDSAfwb5EjdxEKXnEFFXrl5UTIuAIO8v5Fixt7kNbID3fz3k4u4ji6jf+xIXOzTrQLz/O9gPFF0JOQ+82Jo/9YO4cC6c9INEdWn0L6wTDht2yELP7ZSbFbcKkOHml6mxRJPchXb2J08bYtiLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d17abca55so18357295ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723791277; x=1724396077;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQeOsbshCLQQEsLzLhQBt7SxIOMZxubosBFbVjVhuLo=;
        b=Y8VAxaqgCvhT1oUhjjQ5atasa+jKgy0FoaPeNveSAbdm/NTrXlMh2BsSz6Bbm0zB5a
         0ebBIZk3QIyKsduwdeA8iLyYjWS5x/r9mjZ1WVXamT75YTtgozaZZVmyug7dtybv3VXD
         NBMbMEcDZ0n2diH5z8sPjN/37huCHzm+09TRUyJohwEQCK7TvPoIPf/LayK0x7Rq6Y5w
         vDCKQlX6msFkovlQPBMmLWMwX7nN58fdNVQQEBisW+aPpzz0lbiPpm9ySFSjblvG5VFg
         lUxdduMcECDDP5tgnZA0b8xvc/zNdlZkDfCnD5H16iUNVWMzjTCKZFC+MtYRgvDKN4tS
         6V8A==
X-Gm-Message-State: AOJu0Yxuq2OX9JK7/ozCYRKrkTd9yTgGjLQFuRGgE+8plvjrdTPoW5bE
	5a5NBCfurQEdBZBaoDYH7Rul3MN3GKYZDoRCtHm/wMiNbhUbbs14nvx4fGBhhEOc9ivh3tXW3Kp
	tWxK3m6nqp/Ja69zQ06fRPcc5mwYclu+DszJ4WVD1UDThEcMxy5FVDYU=
X-Google-Smtp-Source: AGHT+IHa1GMpyU9w+TVNE28ktB2h9ho7hikUMpDE6thljRH3LgSg7K2zd5t7erDoqiT8JCjfN+N4fyOjOX8ELPYNxIZ8Td6jOre0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39d26d84a29mr2011825ab.4.1723791277029; Thu, 15 Aug 2024
 23:54:37 -0700 (PDT)
Date: Thu, 15 Aug 2024 23:54:37 -0700
In-Reply-To: <0000000000004e582f061fb691ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc0aa3061fc76e78@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
Author: lizhi.xu@windriver.com

BH_Lock state check micro buffer_locked not work?

#syz test: upstream d07b43284ab3

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..f67f82adfee2 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -148,6 +148,8 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 		get_bh(bh); /* for end_buffer_read_sync() */
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, bh);
+		printk("bio, jbd: %d, dirty: %d, i: %d, bh: %p, buflocked: %d, bfl: %d, status: %d, %s\n", buffer_jbd(bh),
+			buffer_dirty(bh), i, bh, buffer_locked(bh), bh->b_state & BH_Lock, status, __func__);
 	}
 
 read_failure:
@@ -170,9 +172,15 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 			continue;
 		}
 
+		printk("rf, jbd: %d, dirty: %d, i: %d, bh: %p, buflocked: %d, bfl: %d, status: %d, %s\n", buffer_jbd(bh),
+			buffer_dirty(bh), i, bh, buffer_locked(bh), bh->b_state & BH_Lock, status, __func__);
 		/* No need to wait on the buffer if it's managed by JBD. */
-		if (!buffer_jbd(bh))
+		if (!buffer_jbd(bh)) {
+			if (!buffer_locked(bh) && (bh->b_state & BH_Lock) && bh->b_end_io == end_buffer_read_sync)
+				lock_buffer(bh);
+
 			wait_on_buffer(bh);
+		}
 
 		if (!buffer_uptodate(bh)) {
 			/* Status won't be cleared from here on out,
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e022e40b099e..33c179fa522e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -411,7 +411,7 @@ map_bh(struct buffer_head *bh, struct super_block *sb, sector_t block)
 static inline void wait_on_buffer(struct buffer_head *bh)
 {
 	might_sleep();
-	if (buffer_locked(bh))
+	if (bh->b_state & BH_Lock)
 		__wait_on_buffer(bh);
 }
 

