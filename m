Return-Path: <linux-kernel+bounces-296152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EBB95A651
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0ABF1F22818
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E32170A3E;
	Wed, 21 Aug 2024 21:04:43 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEB1531EF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724274283; cv=none; b=ho0kP3HWS4QtVPYCrP7rsxVuSp8yAXJLhYOrnFSAi2+H6N/5P/aE+6b5dafMaMK/JQayL519tm0J/3gTBCRUFiZsP2aQGQoBaF5h3apDpkDV6ma469LNZYspVdQZKRcV6HnysrL5bi27aSgLNPKADGRjvaFU0ZoKCZoCXojGo/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724274283; c=relaxed/simple;
	bh=9Ks9JJr5vlqRuh5rwFlXvRo4NycJ4UBvYITxZHobzfU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UbCGR4rO4+lv7yz6Rs59SCUyPLbxJCQhLgb1A/SjBUzpBSrtBeI089YrMJF2TiB2pPPn6f68W3+m87kkrWymx45yye+JsJvByKf3yhHe+8H3lEz6xOfQWCX/NaACLtqLN35srhVgaGr7/1NVofDk1sfSrEmMARirHfZBPBwhXhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fa58fbeceso9070339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724274280; x=1724879080;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0xUun2BLURPI6ICBEEORNjTm30/dEXQk8G4FVa1+mg=;
        b=Y1/SV1psjUWcF8mvjv9vdAmG8F7C+juFWCu0BVCBcuP6HD+yTlo4IjrC6k0eL/zced
         M17MLtnnoYFZlcnb009s8btaX91oIAtyRa5T4IzQXhNrGj8FTHeduBK0+pY24EhmHFOS
         wLSkJIl0clMP9mbn/aogkYAcPoqdIhAXDe0gARQGu3pOCwZkIfjU9wgb+/UH6dpTTml1
         iLANR1D76KGRbqYff98QJlnTozcpJ70TmUPuuJCBWZVb1C2lDJ+ohH0tAOitrVfer38z
         Yw7g7jWWrT7hTY7aZ9RAuRt+oE/FCwwiq51o6NApPrc7ni/yx3jjFA31CdqpPZ/2885j
         Y51Q==
X-Gm-Message-State: AOJu0YwQABDGrszzVWkcvs3MINFIGe/IWU0TiSK/JnXr1O9ZYTH2lypE
	psmCYhpQHCANWnB/BUgcXeAvhlDoym50+H3TamwPRRd3qUqLypkrnINGb/Dsq/6UCuCHL8Ar3kd
	YQLe7BxGx0kUdXGJ6Ui7YLufU2XpZ2xUdXmvssdhK/vglFzryaPu1w0Y=
X-Google-Smtp-Source: AGHT+IFSABL1AzamIVm+9J9djhtn7vC4UcmqNWDbTrqzCgRMZ7ry9my72bxdxx7IDmcQDDnUrkJKBwn+890bbL/5KNjIo7RNrGPN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6297:b0:4b9:ad20:51f7 with SMTP id
 8926c6da1cb9f-4ce62dc0de4mr68798173.1.1724274280639; Wed, 21 Aug 2024
 14:04:40 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:04:40 -0700
In-Reply-To: <00000000000032dd730620055fde@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe6097062037e361@google.com>
Subject: Re: [syzbot] possible deadlock in ocfs2_try_remove_refcount_tree
From: syzbot <syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: possible deadlock in ocfs2_try_remove_refcount_tree
Author: djahchankoike@gmail.com

#syz test

Acquiring the locks in refcounttree should follow
the ip_alloc --> ip_xattr ordering, as done by multiple
code paths in ocfs2; otherwise, we risk an ABBA deadlock
(i.e in the start transaction path).

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/ocfs2/refcounttree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 1f303b1adf1a..32c0249ff253 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -927,8 +927,8 @@ int ocfs2_try_remove_refcount_tree(struct inode *inode,
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 
-	down_write(&oi->ip_xattr_sem);
 	down_write(&oi->ip_alloc_sem);
+	down_write(&oi->ip_xattr_sem);
 
 	if (oi->ip_clusters)
 		goto out;
@@ -944,8 +944,8 @@ int ocfs2_try_remove_refcount_tree(struct inode *inode,
 	if (ret)
 		mlog_errno(ret);
 out:
-	up_write(&oi->ip_alloc_sem);
 	up_write(&oi->ip_xattr_sem);
+	up_write(&oi->ip_alloc_sem);
 	return 0;
 }
 
-- 
2.39.2


