Return-Path: <linux-kernel+bounces-341865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D10B98874D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E963282EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF30E18BBA5;
	Fri, 27 Sep 2024 14:42:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8080146A69
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448128; cv=none; b=Uk5eTlTnI+WHMdNRJNjQLWqXWiv3aUpRPOl9t4WVaswL+Ovv5W2WCLxdA7lUEGnSjOBNPAZ884OxR0iyRmQ/RDNlB6zBdmBE77a8iUmcYqZg5kpfe6OlG6ioCAkwjSQWJlSXuXDZvChWJ1T+ud23c7s7Pk+hxu6LWg84CcvhmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448128; c=relaxed/simple;
	bh=GsqcwSWlePH35BTIrSK66KGN2gKvplGVLtrynqehKYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GPKzasB1WAoGrJrURcO1AIO4QvCdgo0wvp4zSP25uuxbE1tFO4yhVcIIR9/x8ERRUtcDqjSA3F7Jyq/gnXnX/Soi34u3xwVE2DBlhE2ZiP7faBgqyTWJuzFHksleuo14zCUC6ZrwaJ1Aro1JOw3kQO5F+De4XLNhZw2mCwe02xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a19665ed40so19047705ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727448126; x=1728052926;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mjaUPBpeMJHACSDmLvMg+1Y0UD8wueaOTr5BwY8UXo=;
        b=P/3jyO7UrH0ZQc7seGOsjJ7h5fmST5wpDGSknVlMiUZa8IHX8JpOTPa8W1kQ8fO/ht
         wK13TZ/H8yNinqrWmLoQqUME8F6cyVL8kZWQofbRy2L+C4vah2TEFRXvmzletfNzAfHs
         Mf2fb/K/kbq+m/WAFQMMfMxzNtzceVhJGN8LlT/CPotMWDHvRDWyDquwbzuNFVZ+KJ8Q
         uZPdBcC4OZTo5zw5LnN34way7cAkDXF4Iwje8oq+547zrJYrbV6GoY7F179LayjOXjR7
         tTqDFqBwehsgwlO2lCc2Y4gMP6v9qUlfk6J33Wlv7YZvnrhXQprUdCsm0nRnFpMhGdvn
         Ytuw==
X-Gm-Message-State: AOJu0Yw6yKcKsftZfeyGmlz81zsl5oq0+ZJBvOINCxKlIDLuH/L5A9ED
	Mak1PErBJB58EgJp4FBYKupwvVl1gf5r3RnVnAiJKkdne2Fat37d2tBGU0bRR5up4aZ7J6dkCqq
	l6Zqkhst+yyfr+kJYiohqIRQMBsYRhCtM92dpaY5WWm3PY8H/Tb4ZQdU=
X-Google-Smtp-Source: AGHT+IHNU6/piwGiNkVEAWJe34PN9dc0oInM1hm8WR4HfDRclWRzn/4e3VMOm2/V+rUbkenCxljZ/m+zZj5JQxfuihK2kgLm7z+f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:3a1:92bb:1e70 with SMTP id
 e9e14a558f8ab-3a27687c994mr51542795ab.7.1727448126151; Fri, 27 Sep 2024
 07:42:06 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:42:06 -0700
In-Reply-To: <000000000000ae63710620417f67@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6c43e.050a0220.38ace9.0023.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
From: syzbot <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
Author: lizhi.xu@windriver.com

Use memalloc_nofs_save/memalloc_nofs_restore to make sure we don't end
up with the fs reclaim dependency.

#syz test

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 24e8f1fbcebb..2bb8465474dc 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -764,7 +764,7 @@ nfsd_file_cache_init(void)
 	}
 
 	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
-							FSNOTIFY_GROUP_NOFS);
+							0);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 46440fbb8662..d5dbef7f5c95 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -406,8 +406,7 @@ static int __init dnotify_init(void)
 					  SLAB_PANIC|SLAB_ACCOUNT);
 	dnotify_mark_cache = KMEM_CACHE(dnotify_mark, SLAB_PANIC|SLAB_ACCOUNT);
 
-	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops,
-					     FSNOTIFY_GROUP_NOFS);
+	dnotify_group = fsnotify_alloc_group(&dnotify_fsnotify_ops, 0);
 	if (IS_ERR(dnotify_group))
 		panic("unable to allocate fsnotify group for dnotify\n");
 	dnotify_sysctl_init();
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 13454e5fd3fb..9644bc72e457 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1480,7 +1480,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	group = fsnotify_alloc_group(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER | FSNOTIFY_GROUP_NOFS);
+				     FSNOTIFY_GROUP_USER);
 	if (IS_ERR(group)) {
 		return PTR_ERR(group);
 	}
diff --git a/fs/notify/group.c b/fs/notify/group.c
index 1de6631a3925..18446b7b0d49 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -115,7 +115,6 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 				const struct fsnotify_ops *ops,
 				int flags, gfp_t gfp)
 {
-	static struct lock_class_key nofs_marks_lock;
 	struct fsnotify_group *group;
 
 	group = kzalloc(sizeof(struct fsnotify_group), gfp);
@@ -136,16 +135,6 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 
 	group->ops = ops;
 	group->flags = flags;
-	/*
-	 * For most backends, eviction of inode with a mark is not expected,
-	 * because marks hold a refcount on the inode against eviction.
-	 *
-	 * Use a different lockdep class for groups that support evictable
-	 * inode marks, because with evictable marks, mark_mutex is NOT
-	 * fs-reclaim safe - the mutex is taken when evicting inodes.
-	 */
-	if (flags & FSNOTIFY_GROUP_NOFS)
-		lockdep_set_class(&group->mark_mutex, &nofs_marks_lock);
 
 	return group;
 }
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 8be029bc50b1..3ecf7768e577 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -217,7 +217,6 @@ struct fsnotify_group {
 
 #define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
 #define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
-#define FSNOTIFY_GROUP_NOFS	0x04 /* group lock is not direct reclaim safe */
 	int flags;
 	unsigned int owner_flags;	/* stored flags of mark_mutex owner */
 
@@ -268,22 +267,19 @@ struct fsnotify_group {
 static inline void fsnotify_group_lock(struct fsnotify_group *group)
 {
 	mutex_lock(&group->mark_mutex);
-	if (group->flags & FSNOTIFY_GROUP_NOFS)
-		group->owner_flags = memalloc_nofs_save();
+	group->owner_flags = memalloc_nofs_save();
 }
 
 static inline void fsnotify_group_unlock(struct fsnotify_group *group)
 {
-	if (group->flags & FSNOTIFY_GROUP_NOFS)
-		memalloc_nofs_restore(group->owner_flags);
+	memalloc_nofs_restore(group->owner_flags);
 	mutex_unlock(&group->mark_mutex);
 }
 
 static inline void fsnotify_group_assert_locked(struct fsnotify_group *group)
 {
 	WARN_ON_ONCE(!mutex_is_locked(&group->mark_mutex));
-	if (group->flags & FSNOTIFY_GROUP_NOFS)
-		WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
+	WARN_ON_ONCE(!(current->flags & PF_MEMALLOC_NOFS));
 }
 
 /* When calling fsnotify tell it if the data is a path or inode */
-- 
2.43.0


