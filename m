Return-Path: <linux-kernel+bounces-289022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE7954158
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651511C21E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C648287E;
	Fri, 16 Aug 2024 05:49:11 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098782866
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787351; cv=none; b=FifojmlI6q8/fMlxFqaiL5eI5o+cq3AmGjFyVEzoDv2xvyX19H3GGNtr/eDcIYpnwpTJTG+oZUgKp8AJCDLbtOIzmgXyZ7rPyjqQofUo4CKah2yGmujs0YinIgWZZ7HWT5SgofwV2fkBijyrP6mxgCqZEGXB/B2gJnjBRuyCb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787351; c=relaxed/simple;
	bh=v3PIqzlOSr38QmMYP4gs3QeCfvkQgNQQin/h8/6+ySk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sKKxnUucL2b6Cd6ylk2uj07ClIN1URf5/7dFrFVd3Vq4c618Ot04vMoBYNvUG4ZlvkRBN0ROEyjj4MiG5uOlVE2WTmQ6DMBStRLKmby6wzYo4zLLx+WQ7ONFYrBANAldNQk/3LQHKXaiapN9fTqp8kUufuwRvltEonA5HuN2FSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3d3c0dbfso19706045ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 22:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723787349; x=1724392149;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbPEh0rKlx2iTTeCdhdGo40oobYotIcuF/VfOcvGw5Y=;
        b=Hzjq7dHSrUnEldi3GLbnHhPiQ/K8FOXiey/qQ4pyxlz1XgVQ3EWJ/brd36/3CIiufD
         DunMFOQtTXcY+Ku/WhHbXJZN5ydczFVYUHy6WFvL+GWuYrhxR72eVvb2pLBAeV1S6edF
         NM6Kl+rQLgz4wuqN7tsQgcQQwzRgpHGt2n8aINJXbg/39pEzpJt/kaqTB1p1Df8btLHf
         /+vcHR8YijvAh4L1FD0PbmsXKPqiYpqKNYRhMKxfdDz7PvvyaEpClpffT5bpFsNEMTjg
         aVE+I7XBXT2kOtZcO9ZiBiOsViBa0gNUdF+qcN1PGQxMrP93tW9pYZXrna1tO9+9tk6H
         +lHA==
X-Gm-Message-State: AOJu0YzBlXf8eerQ1liwauF1k9R3ZaR8BDaojheH6DbNDBDBWWMQR5pJ
	Ps1LH7/SeX1fkBE7MN3lzgBi8EXt+5A8aBgMhUn5f5K3VI1krb4o0RyCFFfM5cET4C9QUsgjwBl
	A6AycF9Vux7oTW5TZzs+vtFOuOQKeV0dTmQVz+ojjwGeAbMZCnLcaCDo=
X-Google-Smtp-Source: AGHT+IF0FzBGxfaWSsht9SSvAnRtI7EKxjjttBlZLF88Ii3RmRp54BAFVLMLW6drYOWwWIL06/2b7mU+jtBRO4oMaRAPXwUYCSA7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c04:b0:383:4db4:cbe0 with SMTP id
 e9e14a558f8ab-39d26d84ad7mr1947975ab.5.1723787348859; Thu, 15 Aug 2024
 22:49:08 -0700 (PDT)
Date: Thu, 15 Aug 2024 22:49:08 -0700
In-Reply-To: <0000000000004e582f061fb691ff@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098e91d061fc684cd@google.com>
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
index cdb9b9bdea1f..a33d06069968 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -115,6 +115,7 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 		}
 		bh = bhs[i];
 
+		printk("jbd: %d, dirty: %d, i: %d, bh: %p, %s\n", buffer_jbd(bh), buffer_dirty(bh), i, bh, __func__);
 		if (buffer_jbd(bh)) {
 			trace_ocfs2_read_blocks_sync_jbd(
 					(unsigned long long)bh->b_blocknr);
@@ -148,6 +149,8 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 		get_bh(bh); /* for end_buffer_read_sync() */
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, bh);
+		printk("bio, jbd: %d, dirty: %d, i: %d, bh: %p, buflocked: %d, status: %d, %s\n", buffer_jbd(bh),
+			buffer_dirty(bh), i, bh, buffer_locked(bh), status, __func__);
 	}
 
 read_failure:
@@ -170,9 +173,15 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 			continue;
 		}
 
+		printk("rf, jbd: %d, dirty: %d, i: %d, bh: %p, buflocked: %d, status: %d, %s\n", buffer_jbd(bh),
+			buffer_dirty(bh), i, bh, buffer_locked(bh), status, __func__);
 		/* No need to wait on the buffer if it's managed by JBD. */
-		if (!buffer_jbd(bh))
+		if (!buffer_jbd(bh)) {
+			if (!buffer_locked(bh) && bh->b_end_io == end_buffer_read_sync)
+				lock_buffer(bh);
+
 			wait_on_buffer(bh);
+		}
 
 		if (!buffer_uptodate(bh)) {
 			/* Status won't be cleared from here on out,

