Return-Path: <linux-kernel+bounces-231446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8979198D1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AADB222EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0919005F;
	Wed, 26 Jun 2024 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrShMNOR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E812155749
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432972; cv=none; b=Gpbxm//fyRJ/6t21fXS3hS0wXm+cIsCmDMALaWiRKc2dWzOKjyXN/eGiiVKRvaCW/iiCBWSnHHTh2t5xqoFFDloc0h08+FOLIubde5BFrzUls1WdTvURId2Fk0isI6RogQBunkJ5Cj6mQ4GhQvGCnKxYu8ytmTNRLDU96QiCq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432972; c=relaxed/simple;
	bh=57yp1JvK39fo402WoHd9B0/azjUglczC0SomYnvtUlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npatOSaLXNicOsnHMzSuhy4ZlP6NtT0VacAb/24lGlI7BS/h4WqUOmeurKxnSnHp8H1PBmC/mUI+K2aaiToteDfeI5HNU355hxVJQmz3uZiY2YpE+j09axavko4kZBCIOPFmbFFhFDAzoP6trXo403w9e59EBONQYXtLHFxYnJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrShMNOR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719432970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAtyJo3C+DNzKsKiEowHQNwEpk0Vo0c/tZ83GDjcvuc=;
	b=FrShMNOR8BhwQJYZFd+NQhHi/wXUdTtRsrhQaEMBWrWEVxl20tEmh9panhbGEizVjmrscB
	uwDWhJtYuz52v19afXc4UybIq1ufQXAe53jHkb2sh1knyZBYWVfqAOTyuUysKwOc0J77dX
	P2SuaFezOeRbENdN3ANBaWcf1ol4uqU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-mDWbSIqhN7a5DA02Q8CNcQ-1; Wed, 26 Jun 2024 16:16:08 -0400
X-MC-Unique: mDWbSIqhN7a5DA02Q8CNcQ-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4ef7cfc3c0aso1995503e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719432968; x=1720037768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAtyJo3C+DNzKsKiEowHQNwEpk0Vo0c/tZ83GDjcvuc=;
        b=vTXlWOTWujQHdLjZ5NsoM+t5GfJW2bB+82+570QI99Bzmx353kOXvY12fSlUNnNIqQ
         04LbPDBgBj6BvezJV8ASSD1C67llDTYtDGzVzb/VB4vVQ6b8+CTT3CjtPuOTR8aabddm
         5UoK+Nut3xWHv175lztrREaPa85lvNX2Qa7e9mz+FWNV8vXKOWHVSxe8Fqh0G/r5mPzB
         OxZcHT5SNwNJE+2o6ak9Zj1QrQILm0vTUkfeeDhY9vsktq68fqODbj2iiW3KDWCA+7oy
         uVogXBn+07PzEfmdVjGK4Bs/xP+7C8mQMf8VCw6i6JrY3B/wV4BIfzSF/5L3b0PKlXje
         KKww==
X-Forwarded-Encrypted: i=1; AJvYcCXSyiHsaq7AVmISpoSTQ9Zj9mgkS9e7FeVueHppP75KMCMKmmDszrPEVzGgxzz3wNzmlLys2EfeAAzuKq5D9iXypz/j9tN5xv1dbNUz
X-Gm-Message-State: AOJu0YxKUXFj5EA/8jjmP44MjBRWjtkqzGOPkkHPYY8SH94NK0YjiVHv
	11MG6gAnCXzHMgTrJdooOsXlHGzi/ZRe719o3qz3tLNvH3OM4QpXz8wlfEz3Rx2wX3+RKRJhrwp
	o9IrkHZQOMjx6yVw/vbc/iWfP/DyeoJTt86RXYvQssT0sWquuNid+xaduOPIGow==
X-Received: by 2002:a05:6122:1ad0:b0:4ef:678e:8a90 with SMTP id 71dfb90a1353d-4ef6d7d7e4dmr10392699e0c.3.1719432968276;
        Wed, 26 Jun 2024 13:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+AVBumMcz1NhI8kTVR8vo0K9s+4+KliqaUtgF9wvd56bUA6NFigpFBYlBIceQ9rC2Wxb1nw==
X-Received: by 2002:a05:6122:1ad0:b0:4ef:678e:8a90 with SMTP id 71dfb90a1353d-4ef6d7d7e4dmr10392685e0c.3.1719432967980;
        Wed, 26 Jun 2024 13:16:07 -0700 (PDT)
Received: from localhost.localdomain ([174.91.39.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfef30sm57710316d6.17.2024.06.26.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:16:07 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: raven@themaw.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Karpinski <lkarpins@redhat.com>,
	Alexander Larsson <alexl@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ian Kent <ikent@redhat.com>
Subject: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
Date: Wed, 26 Jun 2024 16:07:49 -0400
Message-ID: <20240626201129.272750-3-lkarpins@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626201129.272750-2-lkarpins@redhat.com>
References: <20240626201129.272750-2-lkarpins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When detaching (MNT_DETACH) a filesystem, it should not be necessary to
wait for the grace period before completing the syscall. The
expectation that the filesystem is shut down by the time the syscall
returns does not apply in this case. The synchronize_expedited() is not
needed in the lazy umount case, so don't use it.

Without patch, on 6.10-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.07333 +- 0.00615 seconds time elapsed  ( +-  8.38% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
	0.07229 +- 0.00672 seconds time elapsed  ( +-  9.29% )

With patch, on 6.10-rc2-rt kernel:
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
        0.02834 +- 0.00419 seconds time elapsed  ( +- 14.78% )
perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
        0.0029830 +- 0.0000767 seconds time elapsed  ( +-  2.57% )

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Eric Chanudet <echanude@redhat.com>
Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
Suggested-by: Ian Kent <ikent@redhat.com>
---
 fs/namespace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..5d889e05dd14 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -78,6 +78,7 @@ static struct kmem_cache *mnt_cache __ro_after_init;
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
+static bool lazy_unlock = false; /* protected by namespace_sem */
 
 struct mount_kattr {
 	unsigned int attr_set;
@@ -1555,6 +1556,7 @@ EXPORT_SYMBOL(may_umount);
 
 static void namespace_unlock(void)
 {
+	bool lazy;
 	struct hlist_head head;
 	struct hlist_node *p;
 	struct mount *m;
@@ -1563,6 +1565,9 @@ static void namespace_unlock(void)
 	hlist_move_list(&unmounted, &head);
 	list_splice_init(&ex_mountpoints, &list);
 
+	lazy = lazy_unlock;
+	lazy_unlock = false;
+
 	up_write(&namespace_sem);
 
 	shrink_dentry_list(&list);
@@ -1570,7 +1575,8 @@ static void namespace_unlock(void)
 	if (likely(hlist_empty(&head)))
 		return;
 
-	synchronize_rcu_expedited();
+	if (!lazy)
+		synchronize_rcu_expedited();
 
 	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
 		hlist_del(&m->mnt_umount);
@@ -1798,6 +1804,7 @@ static int do_umount(struct mount *mnt, int flags)
 	}
 out:
 	unlock_mount_hash();
+	lazy_unlock = flags & MNT_DETACH ? true : false;
 	namespace_unlock();
 	return retval;
 }
-- 
2.45.2


