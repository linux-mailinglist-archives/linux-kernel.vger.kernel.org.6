Return-Path: <linux-kernel+bounces-289171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8120C9542A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1F9B23C87
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E512C465;
	Fri, 16 Aug 2024 07:23:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573084DE0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793006; cv=none; b=ee60xZ2GOtvslQuskrOrUiUtkd7hQGjjlLKV32WSH4nINkHgRbqmGeBzdfDz/1UnLqqHZSoXCEBdcbB9oTgF5ATiYLD+YGJ2eJisz+IbIfV+cYxZQvEaxZH6m3LQ1n237+uEdd4cHo+KCVqiEydKKq9blL9KxLaA4VD04k8eYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793006; c=relaxed/simple;
	bh=Qw29rppShCdDm6QOLmWc34/CLwzrzgi9ru94pb7hd3M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cTn5XfR2yFJi0QNMVWWSZCgEzDdhdYC0TFAVMyyTOjOdOk19sJTTEi8PIN7yWpMnyGZZs6F5wg3Cp3Q0ofpGqMNeBbdcxR+8N+yol976A/xZuDsceeWqA9MMAkMehPf2xXCS7Fs9b6+dN4okSV2nLKuqA3ejIQKXAEbL7lGxbSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2dee9722so378265ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723793003; x=1724397803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQeOsbshCLQQEsLzLhQBt7SxIOMZxubosBFbVjVhuLo=;
        b=Obo1x9M7/ryZqvonx4oca9b+2x1vfTWKUAhu4FvmOBX1tn06CiTVXyUil9sVUnmwEB
         lQ+zlercXXTVRxGaAh9INQPtTW3L/0CafsNDcdP4c/fAMaDy8tICQW++cXv+ZUhXIHwV
         JkMnkFyb+R00QtveGPGDTtlFf6De+ur21MrVUKtkBam2Q1tB5u2ysSbd2hRDVm6MWffH
         p7ZAYRN19Y5oO30DvxURnKq5bEyICGVmfUWt95ipfO5I46tvA4UN/PvGZa8we58CVMzv
         ZtYA64bFJogZCgHloCQHxgu7uIz7AnZ6vyTd2ElaJ1o1RyI6vlwSt2RMTFgW2A0gteF+
         I7Kg==
X-Gm-Message-State: AOJu0YwfgahvsNCzQPul70x65RE6snZ3x/4eWZmaYzYiakKKkJ36jLmS
	dws9ayjGTox73vGPM96pMW082fprvc5iKH2Pb4K+D+mWmPWY8PF4fwWOgbUYl6pwn/alFbIvgpm
	tPc/HKDONIEPQVEmnhmFp/VFl/tel1UWgg6qCWbsnNXWv5ww8aDEmHSc=
X-Google-Smtp-Source: AGHT+IGzD9XKlLU3aJsJrcfcLFhYtkCVjOUVQIFt/YjqcFouktBWJzCAjRWNHzSbhqa2h1VH9jJ7a3ljcpmpQiKsjTQK2bS0wOXR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcf:b0:39a:eb81:ffa8 with SMTP id
 e9e14a558f8ab-39d26d9ccb0mr1692685ab.6.1723793003296; Fri, 16 Aug 2024
 00:23:23 -0700 (PDT)
Date: Fri, 16 Aug 2024 00:23:23 -0700
In-Reply-To: <0000000000004e582f061fb691ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a0cd3b061fc7d549@google.com>
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
 

