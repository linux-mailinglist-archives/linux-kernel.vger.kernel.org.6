Return-Path: <linux-kernel+bounces-287649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B2952AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D699C1F22504
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325B1AD3E0;
	Thu, 15 Aug 2024 08:13:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586D17625E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709607; cv=none; b=VcJ1f6eU1aW/TULalaMinliz3Rv3bLxfkRGk0mtghG+LbR14WjWmiv9BabBDya1vg9rs1wS1Oi+JNCnW5qXE6QK+Gu7ftAKfJ5IX/OmfujT0QXfDYZ344WP65gi8cSgnxGQarxLWNMYfB1AZvAIG0fr2p3nwzIyatZnv1Ktk1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709607; c=relaxed/simple;
	bh=ewhADhyT3fNtYCGKnT23K6eaLlgAh60N6lXGYwPq9eY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gCBpRl5Z9DZOatfgZ1W7t1S03UsyQ2KXmUeTEzRj2WyYHe/qRRcueuRx6ygzhVbROMo+FOal8sUZdf/RLTR0XS3Jj/U4vdI1mECMqSkX8+rVRCCGjac8WPl85/UvL0rEq9B3e48zsyjHcLcSVJ6AI/n0nxn28mSxvsIKaUtui7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3dc8cdcbso8467605ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723709604; x=1724314404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0L5d3bNE0mTcAv3mnFj57C89MwNgyNNLWWoM18JidsQ=;
        b=i+9b8BzrEOcOfdGOVUBCfZ1L9BjiqEatarwzvYIOlwlfBOuvRTyoaLgD75bxWgi97o
         HoqNw+s1n4LW/R06/0wUH1+cQTzJXiMbxhaGkW9AA9GNvI4mKeJJAMoNvlI/XW+zfKN8
         eoPnjTJ+xtYdEIeMg05jNPJo1CuCFLkDJZM77mS56rEhghNru1MJVBgbQSvkvJvVEapn
         HAfL22RrNFybK6KzDqVanJ8LtTyjfdGQ7q5Ec3Slh/ox9ko5/FJXHULajMhQ1cJZg+BB
         kB3PCPkazkm4ATF/09FVpJJ0S2HtuiWF2AS0txgqf/rmqGOmbAVUvsP0VZ9R1uStUQVR
         C/lA==
X-Gm-Message-State: AOJu0YyX7LSca/4PJUlb3TwTY7KWdM6vdd1gdDkZ6eE2NO8WzinPvOXq
	RWT7JCu5reCXVf7Ks25GN/o7PDNrIlPTaC5PJ1pJzHJgbv9Ij8rO2NyOHOkS0G4KffMbZCjIB2M
	Su63rJJMKdNdgLIEzYlePmt6qrQbh2IZf1WxDfOktHIo/K8Cok8zj2C4=
X-Google-Smtp-Source: AGHT+IElPG02X7Bm5pfKej7O+cBCiuyluGjZl8n6pQNhc8jWgU+bfnNCxZNUokolvYfvv5WETcoLPjYAJHrtrnZNpaXpNvM4hbyg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c3:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-39d124cd834mr4180145ab.3.1723709604147; Thu, 15 Aug 2024
 01:13:24 -0700 (PDT)
Date: Thu, 15 Aug 2024 01:13:24 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6c344061fb46a09@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

clean dirty for the release inode, stop to worker wb it again.

#syz test: upstream c0ecd6388360

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index ec6cf8707fb0..02b06e4e3596 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -530,7 +530,9 @@ int netfs_writepages(struct address_space *mapping,
 		if (netfs_folio_group(folio) != NETFS_FOLIO_COPY_TO_CACHE &&
 		    unlikely(!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))) {
 			set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-			wreq->netfs_ops->begin_writeback(wreq);
+			printk("ino: %lx, sync: %d, wsize: %u, %s\n", wreq->inode->i_ino, wreq->inode->i_state & I_SYNC, wreq->wsize, __func__);
+			if (wreq->inode->i_state & ~I_SYNC)
+				wreq->netfs_ops->begin_writeback(wreq);
 		}
 
 		error = netfs_write_folio(wreq, wbc, folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 876cc64aadd7..9176270fe35a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -438,6 +438,8 @@ static inline int __filemap_fdatawrite(struct address_space *mapping,
 
 int filemap_fdatawrite(struct address_space *mapping)
 {
+	struct inode *inode = mapping->host;
+	printk("ino: %lx, sync: %d, %s \n", inode->i_ino, inode->i_state & I_SYNC, __func__);
 	return __filemap_fdatawrite(mapping, WB_SYNC_ALL);
 }
 EXPORT_SYMBOL(filemap_fdatawrite);

