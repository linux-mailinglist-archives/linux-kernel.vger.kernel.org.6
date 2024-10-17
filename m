Return-Path: <linux-kernel+bounces-369123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0773F9A1940
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B681F226E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A077E0E8;
	Thu, 17 Oct 2024 03:19:43 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD71CF8B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135182; cv=none; b=JeX5giiAE/f8P2U3wwuJK47wJFm+5mIcC6vIkqR0Gx0b2Mg96Wclq+Rjd+yaxXBFna4v5nmvgmjuGT+Mxc4f597K232076x/9FqgWei2pi91RGHzBG9DML5v0c0moMtlikl2shQzVmQ2sotsZU4OAnsAcqFOtKImHoBbEXc5oFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135182; c=relaxed/simple;
	bh=pEFaM97afNzULAYiluxoNlgaJJ06koZ0S7CK4P52qEY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qdPiGMjFQHWZXSw9MUvtE5FyRF8Vo0peOZb+daESm+0FrSfIiYYAJYg3Koy1e4vt8TxEGJdIJH4SjfjDnX4OybKdLvphOFxj7TpRN98HaBEcud7qIlRS29Zf66vlfNCnj/XOddRHKXpAJP3qMZ4ya/VJENsdK3AHXF/reGn0TtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so4429995ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729135179; x=1729739979;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dZry56vZJetXz2Zs/FuQOg+kt73JmFgpKQdqTEL0wI=;
        b=kn+bC7Qc3BwwB+CvsnP3lY3E0g/IhYvpZ3e8nLwwRpjoJVMQbYsiOrMzEfbf9Jic+A
         OZ9n42cjumGtgdFJGNn6K/18McQHXfIElVObdYs3xMz8g/1Wgip2AR0HBtiV7Rc3ptyr
         cRapIBMxF8fJjMz8ZSu3UMGFO8UhM0ZCzX29XIGXEjH13n4jUQFDzRMlTLzoeafg9BhO
         FmN4ckZZ3xxxXB4HZhtBi1mT8RBv5v4jiG21Mng0750EV5fFYU0DFoTh5QjDIZGZCbr8
         iso896hA44xq282Gzco8L/lfVUTV1V9RJ1bcV7dCsw0jtBHDlCbJuJx/KKdE0FQwDpIf
         LvrA==
X-Gm-Message-State: AOJu0YxXBHGoMEwjKtwAS+3UvCNLl2re4h3NogMJuwSFHVY08Bs8+4K8
	Zc+L4fprxGAd7W03g7Hxt/C0mVfn312a8D4HgnumZN1Kl5c6pFQrjXtTHokjjrN+g8AKkfX6u+q
	dN4UyRSmddr4HUXDgYPPUnmxovZDSuVgnd9p99ubiXIaoJJqCQoepzzg=
X-Google-Smtp-Source: AGHT+IFLWsE6w6XEmdNdxqFL4ynwOoxhsfe5PHMH8BpHlVtoeFeeOLtpd60S1zDtiKEte76JocAhpvqozocCelAzkweNm/UnfOHj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:8703:0:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a3e52ad87dmr11926745ab.6.1729135178980; Wed, 16 Oct 2024
 20:19:38 -0700 (PDT)
Date: Wed, 16 Oct 2024 20:19:38 -0700
In-Reply-To: <000000000000cb688206213d1bda@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6710824a.050a0220.d9b66.0179.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_fiemap
From: syzbot <syzbot+ca440b457d21568f8021@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_fiemap
Author: lizhi.xu@windriver.com

#syz test

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index f7672472fa82..6d5ffa803b31 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -793,8 +793,10 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		phys_bytes = le64_to_cpu(rec.e_blkno) << osb->sb->s_blocksize_bits;
 		virt_bytes = (u64)le32_to_cpu(rec.e_cpos) << osb->s_clustersize_bits;
 
+		up_read(&OCFS2_I(inode)->ip_alloc_sem);
 		ret = fiemap_fill_next_extent(fieinfo, virt_bytes, phys_bytes,
 					      len_bytes, fe_flags);
+		down_read(&OCFS2_I(inode)->ip_alloc_sem);
 		if (ret)
 			break;
 
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 6ef4cb045ccd..f7863f7fb4a1 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -119,9 +119,6 @@ static vm_fault_t ocfs2_page_mkwrite(struct vm_fault *vmf)
 	int err;
 	vm_fault_t ret;
 
-	sb_start_pagefault(inode->i_sb);
-	ocfs2_block_signals(&oldset);
-
 	/*
 	 * The cluster locks taken will block a truncate from another
 	 * node. Taking the data lock will also ensure that we don't
@@ -131,7 +128,7 @@ static vm_fault_t ocfs2_page_mkwrite(struct vm_fault *vmf)
 	if (err < 0) {
 		mlog_errno(err);
 		ret = vmf_error(err);
-		goto out;
+		return ret;
 	}
 
 	/*
@@ -141,16 +138,19 @@ static vm_fault_t ocfs2_page_mkwrite(struct vm_fault *vmf)
 	 */
 	down_write(&OCFS2_I(inode)->ip_alloc_sem);
 
+	sb_start_pagefault(inode->i_sb);
+	ocfs2_block_signals(&oldset);
+
 	ret = __ocfs2_page_mkwrite(vmf->vma->vm_file, di_bh, page);
 
+	ocfs2_unblock_signals(&oldset);
+	sb_end_pagefault(inode->i_sb);
+
 	up_write(&OCFS2_I(inode)->ip_alloc_sem);
 
 	brelse(di_bh);
 	ocfs2_inode_unlock(inode, 1);
 
-out:
-	ocfs2_unblock_signals(&oldset);
-	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
 

