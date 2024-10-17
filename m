Return-Path: <linux-kernel+bounces-369039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5AB9A181F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F01928875D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4BD224F6;
	Thu, 17 Oct 2024 01:52:19 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC084538A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729129939; cv=none; b=pidE5hxVrGkA9GrPx0S2JTYSXRomiFw2oK3+f7CjWv5iksXM0LOMByr0F4DEePsUQ21P7VWRTn81HQR62Ndoz92tUPsudcB2caI8q2dnzpYjGqJypLP/8JKWfZ/gwSgsIJ9ETn6XhgSSdR0ku9dM3kAN9HJVVb8DuWkuFy0i0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729129939; c=relaxed/simple;
	bh=dBy/0aOPjIgvtdTM/qTAQAumz+UuQ3GJpxSSWmrHK44=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T9oFPtgyaa450FO+q3FdNxsmlLSgXj1N+ic5ZOiODkPiAuduNcY8DfwIOWwap1v248k1QS2vw2UMoKYH7Aqzv216hfoEO2aQZGxaeCJlZTumdmePGWmCKDTYGpokaDMD0qxRT+0+803maLqTc/tEeVnFjKBSyirGOBVec6ZskjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c38d2b91so4644925ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 18:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729129935; x=1729734735;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ky3pG5eC9z5RbLSWMMTaWcmzaKk+eM6SObr69CPJKwE=;
        b=gY6q8hU6n4HbxnQXfuHgcH89gfGVM6+soU0+EHjyQmnNo+rh0fdi1GbnI9L4V7hYzE
         b4ecWTgd+PP7Sujnk3V3VaKrrYIfUoRHrMphV88xKlCt5rySsznimSjCg76mX7WdZWZB
         xD5GTkThTAIFlHLqUv21F4GJbOVyc/eJOkztcO0HTGKB9BdG5+BGtsu3clBzawkcgQ6+
         QV4WT+Jy1dpI1d5r9XM55FKs8SrYQZ7lXrT7/Z0EBrVO44y/yLxGvgPsB3Zt2EO39J5B
         W1QKAGzwojLyFaS2B1KBQC4ZFJkK6HatkVo+gj150WTI2D9jjxKPAWh3N+zkdBdHjn0j
         EqrA==
X-Gm-Message-State: AOJu0Yzfdl64uSj1vf3dD9pl2wUg56A8K+h3A+kEP1+g69UbTuBWQuZt
	QBFi/SffgyGM2WopseC24imYPcoct7TaOyWMNqsnNkW4vFRJEKYSfVNbccitD7C/cwq1yeCllpt
	kiFbD7nWArKO1GOeQuY3q4MDkpr7B8xXJpowXoDHChIbUq3ZH33NcLHM=
X-Google-Smtp-Source: AGHT+IFt1QNff8hihGGqBD2M2Knh2N8ny8ArbdEP7d9hPKecWRLWPo4YcIc74hlhvRnJC4uYzfoMk9GXXKFtnlk+4BHgxhY7M9CP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:3a3:76c3:fcb0 with SMTP id
 e9e14a558f8ab-3a3bce16c4fmr124452835ab.26.1729129934884; Wed, 16 Oct 2024
 18:52:14 -0700 (PDT)
Date: Wed, 16 Oct 2024 18:52:14 -0700
In-Reply-To: <000000000000cb688206213d1bda@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67106dce.050a0220.d5849.001c.GAE@google.com>
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
 

