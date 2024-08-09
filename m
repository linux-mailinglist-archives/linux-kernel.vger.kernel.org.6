Return-Path: <linux-kernel+bounces-280516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEA194CB8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01B01C22B45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84E17C9E3;
	Fri,  9 Aug 2024 07:41:09 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3A17C9F9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189268; cv=none; b=j0ihZA8M7tW2dA7zWjV3oGJqve4pj9h3tzeos/xIVnAPVR43jl+D3xuII+kDepvR85HO8SMKNVSUDEzbINacHpUi8TPvxPeq4aXWoErv8UWWCS8QU3o7B48KzkCk6Ru6pTeDoDlYRvQslQy79KYRdf7cocUft6E7wjxys86tMp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189268; c=relaxed/simple;
	bh=zOFJNnwtrBSgwaerWVAiPmTsRmbmmxBq8mjRvhzOee4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BqNQdyxFN58n2Zx5S1XJRTxmaM72GBPEfUDjgNP+AzPKgiJer+vBxhCDOmPIfnLjyK7bsSI86a7z7lfnd5HsWRn9cCIdOryknjeRuFS83bTYA9BhKYfSKKs3q8QQIDEB6SjHifp8BT5WurwcoMOJhSrNsD5xE1H8uRha6pnyeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3c9fdbb6so20597805ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723189266; x=1723794066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajqCRsP7p1VXgI0Re11CfOt/YWPqmtBzUPsQb9296qc=;
        b=Kvn/7YqrFij9UMu/frn2zGXzDT/nnjRAeMNl5itle6Bado3D1jNUfdZvG1CHQ5b8/d
         a/gPV0LEtyLuIc25GwXZ+2tif+JNtV019LkhIYmphQW+9hBu4cIK3ipyX/vsSGXSNqBW
         0c91Q3BnZzQpMOe7qdIWV6ES8s5eQqngT04Ci+QLjukHAXjoITJTMPvir/uJjCxL+2a5
         /uVG0FWQWgbInnhgwGCrGGv8iNhgRsBEcuD9Ktu4YkNdPIUkzFL98UhpoTSPGR/+uC1h
         6n3udHQwPwXidN5mZP9ICc01gwDsqGhfDLeyJ6dGjc50dzgZfxudwAGAyd6T19q3A5SE
         MMHA==
X-Gm-Message-State: AOJu0YzZAafHNXJ+5GhDncTiAp+8jRet4IDyEJT6FDjIJ5+lHnehefd+
	/PwnsXEssv6FVFxaim8n9TJzK1mFGATsbS+r+MGTKMeryEIlUoFXIaxuKCSK65IiU8sfK8yCl5h
	1Xx8e1s1y3xg1nMSChv8p/W8N307Y4pbRR/Of5J4qunOvPnHf09tQUa0=
X-Google-Smtp-Source: AGHT+IEouAXBVEG08RljD/vu3dfJHpBJ2niX8SGkfp4hGZC7ydCl53BBxjcmrmfJElaFH6WcnQx6EagSVGqC4QIGpnxGzf11IwRi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:39a:eb3d:8c65 with SMTP id
 e9e14a558f8ab-39b7a473872mr619925ab.4.1723189266510; Fri, 09 Aug 2024
 00:41:06 -0700 (PDT)
Date: Fri, 09 Aug 2024 00:41:06 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c85b0061f3b4484@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

add file refconut when add fid to list

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..99c7015396ab 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -219,6 +219,14 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 			retval = filemap_fdatawrite(inode->i_mapping);
 
 		spin_lock(&inode->i_lock);
+		if (test_bit(I_SYNC, &inode->i_state)) {
+			spin_unlock(&inode->i_lock);
+			if (wait_on_bit_timeout(&inode->i_state, I_SYNC,
+						TASK_UNINTERRUPTIBLE, HZ))
+				return -EBUSY;
+			printk("del, ind: %p, ino: %lx, ino is dirty: %d, %s\n", inode, inode->i_ino, inode->i_state & I_SYNC,  __func__);
+			spin_lock(&inode->i_lock);
+		}
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);

