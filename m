Return-Path: <linux-kernel+bounces-287465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20756952814
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53A41F21527
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07512231C;
	Thu, 15 Aug 2024 03:00:37 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BAC18641
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723690837; cv=none; b=RbPGD18q5c1wGDxErhMAYwegaitCoxfSWKpKbQHmVl59nTgmEZQalmy0m49PO8cVA7bbsGx1CeyC62g94Y2BD8ZfFUPuDh7bvdCwqAxu1SJYNC4+mQdFhMz2arW5B4O2pwULOZbJFnQ9xJ/eqsx7L3Woz5iUewVwdNLYIJ0yN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723690837; c=relaxed/simple;
	bh=L2puwB1qaWdyP49tq60T5NvoRN2oruVvJ6wyKczpE0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pBUoT1up3pcOfxzZoUbBvvNrBtZGJ3bzdoG8VBYwOeYqZSsOsZcV2VT7OYia3uMnLowmP3YqS3p07+S1BwY/Uf8HC0ZhG16DdJmnM6m9hLOMLETj3NjaHh9XVIgSLGMR170Re1ZPhV3IiQxDW7ey9pj3EM2xFXBI3deLRF3G86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8223aed78e2so68718139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723690835; x=1724295635;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I+gIWxg5dsZIsatp2hWJDv5yzRQI5JZ8eTuaHX3O0Y=;
        b=oqtFmywkmbb2vueL4i2jt4Yp2yj2VUzm9MmQNY210ZmpDdMEuwpBQEdfTOXzYM2iWV
         aLdeOhCzXBYRZlJPEjDJS02u355F5BbFNrd/SZeDR66pslLJWyfLLBnK2l3BQjo4yHtw
         fMYluwNkHoA5b6SUY6WLrmNPg3kaDWojn4DGgTEDbeSPPOO3cCOF3oBEl04/u9x0ZN8S
         8IhvspXx+mAiPSAyCbf+SuYKf0byRENuJ28OA2M2aPbv1Nz2L2k04UOIW8yEPN9Sqn+W
         RnYvk9VfCwrdaZX3I7xtZRxNSCRYIPwYZBBCqAOtiarn3G696cFXTxCYLwzihhpYkgqx
         rFHw==
X-Gm-Message-State: AOJu0YxyjSUeQLk2O34TkjWAX4exEyvvQouA5QbfowdcNOgIV3rsNG2P
	ZOUaBl+Qjq/J8TXcMG/67qKYoBA0gMcSlII4U522yxFYqkDirNPakUW9KbxJKRnYRMgYC+ez9s+
	RYXjA41cq39NSLpuhffMjVPoptLWuIBwbwLEPCNJuKQU2WQjruRrb4Ns=
X-Google-Smtp-Source: AGHT+IGEVCZA+saxlNqhLzAF2ajTZYUmInut5GIz1l4iqQee4FV/yYmLuz+Z8fSBz31Gp540NsFk+F1wUcNwUUsfo7IZDRRBkpTX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b23:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39d1244769amr4533495ab.1.1723690835179; Wed, 14 Aug 2024
 20:00:35 -0700 (PDT)
Date: Wed, 14 Aug 2024 20:00:35 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef1381061fb00b6c@google.com>
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

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index e0d34e4e9076..85161f0bb749 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -218,7 +218,12 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
 			retval = filemap_fdatawrite(inode->i_mapping);
 
+		printk("fid: %p, fidnum: %d, ino: %lx, ino is freeing:%d, will free: %d, dirty: %d, %s\n", fid, fid->fid, inode->i_ino, 
+				inode->i_state & I_FREEING, 
+				inode->i_state & I_WILL_FREE,
+				inode->i_state & I_DIRTY, __func__);
 		spin_lock(&inode->i_lock);
+		inode->i_state |= I_FREEING;
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
 		put_err = p9_fid_put(fid);

