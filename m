Return-Path: <linux-kernel+bounces-280383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85994C9D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3990528131E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B616C842;
	Fri,  9 Aug 2024 05:48:58 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2334CDD
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182538; cv=none; b=MmAcXRBL9kplzK1U5Mxxt7YMt8vm7ZdGEAGy5xRVmrYU8kL+HPXbVxs4GwRBxee6Y4Z/fJspgArW/UqqVEJAewgNkM6K42h+vKM7/JZ6Zhj/CgpurIz63puT0v/ZIsnfZeZ5Qu94PgmKOET9y5Pzt/umeVrRXG732i/1Nsz8jVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182538; c=relaxed/simple;
	bh=WqjYirTAXgCb7pTYn05qPZRfVrgE4pqF8SjVR68tfMA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AXN7IZ1+FAIyJGJ3ZTYfqHS9Y+eXdzxN24nsspCasmrWGQbwlwIrjCuB1MxMQcHxyE3Ub7IBMfkaSTEhkQt7C9qRSEPIGWdaMMWdEh6zx01vub8ZSyjHHPVhrIb+uP419g0BdZZHpKioOMLSybM87B1wbQxG33PmFZSDtT32fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8223c3509a9so229863439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 22:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723182535; x=1723787335;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThQc85dFfv3Q/q5qZCdiPp6YTQSnBC4VkugHyagGN0g=;
        b=fEmnpUlrhqcDB6+aS6t398hQUJiAeJYKj/bmd44v5D7HGg35AB2RCSqxjaTZLHPFBA
         mmn6SpIOJ0oYRuY1vEeNxZMjOrxFCN6mZoVUtlW+cs/WAAKdIDmbj9sjY5475OsfOpNb
         6sddCtT4oMxVqPDQdglrlShF+WnFaisxy774EGQrkDx4izrlLLieXhuDFX/dEVQ/tEqQ
         xLdGaH9w5m28Nizq3Wt9jpQiJlvIMxqaY5xaBEjwq1rEDeJJ1V1CGIZc8UTng9JEkJcR
         z0R8DBMgkcIdP2RcLmbB+h49lhX1ncnGJ+tMw0e1aQLkvClJ9dw+7Lv/zbKJ3zBUNGNa
         TWHQ==
X-Gm-Message-State: AOJu0YzllLRS1t1vDA4x03Ok882cu3LdlsFrRyxhPHTy48+LrR1rBXcn
	rvpOPT4LkSnSAwfw4td1cgSKcUDNdiZRDQvw20HZZZpo+Dx1a51B0tDz878Sz7+pNMsWeQMW093
	hgBjVYkP0HQKpHUAfkY+oqiCpwLXPU0TGlJ0qxgzgDLqWnejtze3zZxk=
X-Google-Smtp-Source: AGHT+IHMq0CSROIy3MNnCgRZm+kqZg+ovAGxfbXcNdw0QJmXkMxdcRCGo1BqUN8A5oeGxclNMKiLCwpqovI+ZrFzel6dfbHU5EM/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411b:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4ca6eba4580mr11889173.0.1723182535223; Thu, 08 Aug 2024
 22:48:55 -0700 (PDT)
Date: Thu, 08 Aug 2024 22:48:55 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e53fec061f39b2f1@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

wait for writeback done before release inode

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..d5eea95b8690 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -218,7 +218,15 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
 			retval = filemap_fdatawrite(inode->i_mapping);
 
+		printk("del, ind: %p, ino: %lx, ino is dirty: %d, %s\n", inode, inode->i_ino, inode->i_state & I_DIRTY,  __func__);
 		spin_lock(&inode->i_lock);
+		if (inode->i_state & I_DIRTY) {
+			spin_unlock(&inode->i_lock);
+			if (wait_on_bit_timeout(&inode->i_state, I_DIRTY,
+						TASK_UNINTERRUPTIBLE, HZ*30))
+				return -EBUSY;
+			spin_lock(&inode->i_lock);
+		}
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);

