Return-Path: <linux-kernel+bounces-218965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2BF90C83C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F021C20906
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120EA15886E;
	Tue, 18 Jun 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MryuI+J/"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28315749D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703765; cv=none; b=Z4c5HOh4RCZyOYkxjKVUp6sxNdJ1ViD9LEA9B9UhPq4A3Z364PqPOyRIJsGAB+CisRGwWhvpOwDrRJBcthitfedjDzBjxKU/I6D/W7AGaN/fHlhdxxYzat7kqLLZrE3mTFglgQPeyyKQ7S35hOSNxxIJJPdXEX4mUeybIYsmxYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703765; c=relaxed/simple;
	bh=xLVb4y/9xJR8W/XNsR1Hn1CFra0UeE8DZDA/cIkKRTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uuCgKg792QPM30gOeCqcfK9iF9le91BHGBjFmZ3GwZAZSTOg6g2+iL95zevV1BSRnN3a9EkywqcL1G7TlEPpt+VjesyhOr5KXXGyu/avEd6GV3CRrsXwC53ol4ie2oGiY1dh8huXj+R2oZ9I/XskERl0eAAIp1qWyjZGXOjJ5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MryuI+J/; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f986b92acaso2996984a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718703763; x=1719308563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UALesfbksrHHNtNwGYa4E+DNFkRXivhYiDbx6+KbJc=;
        b=MryuI+J/vBdQ7sxu28WAqDUOekVSORhvHePCh3USB2GlTR9NqZ4LZpyrB4/NY3kAF3
         tyIF/giL8ud7mn7zXhYCvuENg34LzMBue+pOrkfwJL26cJdnKsbTZGVlTs3C/yBYPHr3
         udQgQV1feXaYGuU8/TnhUTpo7XUo6lzgWIbtijYmmNvt+04k2kQNcVflvB5+Qxc+OZAH
         1jzpWiAHIhk3/eoYtCpgMc++kfNdv2ArnC9vjMN0pqZ6GaakNvXhe42kgF/Up0FL4uEe
         kNWV13RX1hoxqtgU4rVpUa0iSPLpE3a/TyjSJ6nE8P89T32e28sG0e7Q8aTWCBk2JgFn
         UukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703763; x=1719308563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UALesfbksrHHNtNwGYa4E+DNFkRXivhYiDbx6+KbJc=;
        b=YRAcBHxqaQEFi1K45Ki3IiaPuaREFfw7KFTg9jfz/RHiK0vVLrdsaj6Adnp1W+Ds2A
         DVR2L+6yoQbs+W1TBQtwXw/A3O0SnE05fDrkJfOdbnuU2X4nPlj+4VRSnTKKSd0Zjiky
         PYXwsdTWS97ilhgK4FmfoVhC7Bk464tj5jvLYrFSVY7eKurO5Oc9PYWlV/ZygGcQWL+e
         Znu4fHk4KNeW1GkscpHV7TWiWwdec05QS8tshgQXtsrO1bm8MhGP5prbOJ+RtIZGKplV
         jLkmf/ix2v3i7LDodSjYFGEbR3A+pthbCPj8rXZfFVbJYqv5ngFI3+QZpEIU+DYb7C0X
         vzsg==
X-Forwarded-Encrypted: i=1; AJvYcCXZhbR3nFfatvrfDmgSZaENJA5AksoWKrmwe+CkL3YszYm7L5cgTb31IL44ord0oU8oCoO9i4utwoam1QKawng5rKsdvf9L7UZUmwzz
X-Gm-Message-State: AOJu0YxvbWKFIZelaDge7Z4EhVTyjQNv/xDapfN7C/gQnbFRzy2xps6v
	kvo7hsatwKLMOfKrUiMTPHjoNH3xu9ZQ9QE/ER8q36puVGxu+0SwkHsT8jWsq7k=
X-Google-Smtp-Source: AGHT+IHduV0HGFrVmQSxIvryeJgCIEd+h/riwq126F2u6x4F+za92Uiu45uPCTH4ThXJnQkPLkaziw==
X-Received: by 2002:a9d:4d91:0:b0:6fa:81b:d4f8 with SMTP id 46e09a7af769-6fb9364ecd9mr12749877a34.1.1718703762611;
        Tue, 18 Jun 2024 02:42:42 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf0bef16sm7753098a12.43.2024.06.18.02.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:42:42 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] xen: privcmd: Switch from mutex to spinlock for irqfds
Date: Tue, 18 Jun 2024 15:12:28 +0530
Message-Id: <a66d7a7a9001424d432f52a9fc3931a1f345464f.1718703669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irqfd_wakeup() gets EPOLLHUP, when it is called by
eventfd_release() by way of wake_up_poll(&ctx->wqh, EPOLLHUP), which
gets called under spin_lock_irqsave(). We can't use a mutex here as it
will lead to a deadlock.

Fix it by switching over to a spin lock.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/xen/privcmd.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 67dfa4778864..5ceb6c56cf3e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -13,7 +13,6 @@
 #include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -845,7 +844,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 #ifdef CONFIG_XEN_PRIVCMD_EVENTFD
 /* Irqfd support */
 static struct workqueue_struct *irqfd_cleanup_wq;
-static DEFINE_MUTEX(irqfds_lock);
+static DEFINE_SPINLOCK(irqfds_lock);
 static LIST_HEAD(irqfds_list);
 
 struct privcmd_kernel_irqfd {
@@ -909,9 +908,11 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync, void *key)
 		irqfd_inject(kirqfd);
 
 	if (flags & EPOLLHUP) {
-		mutex_lock(&irqfds_lock);
+		unsigned long flags;
+
+		spin_lock_irqsave(&irqfds_lock, flags);
 		irqfd_deactivate(kirqfd);
-		mutex_unlock(&irqfds_lock);
+		spin_unlock_irqrestore(&irqfds_lock, flags);
 	}
 
 	return 0;
@@ -929,6 +930,7 @@ irqfd_poll_func(struct file *file, wait_queue_head_t *wqh, poll_table *pt)
 static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 {
 	struct privcmd_kernel_irqfd *kirqfd, *tmp;
+	unsigned long flags;
 	__poll_t events;
 	struct fd f;
 	void *dm_op;
@@ -968,18 +970,18 @@ static int privcmd_irqfd_assign(struct privcmd_irqfd *irqfd)
 	init_waitqueue_func_entry(&kirqfd->wait, irqfd_wakeup);
 	init_poll_funcptr(&kirqfd->pt, irqfd_poll_func);
 
-	mutex_lock(&irqfds_lock);
+	spin_lock_irqsave(&irqfds_lock, flags);
 
 	list_for_each_entry(tmp, &irqfds_list, list) {
 		if (kirqfd->eventfd == tmp->eventfd) {
 			ret = -EBUSY;
-			mutex_unlock(&irqfds_lock);
+			spin_unlock_irqrestore(&irqfds_lock, flags);
 			goto error_eventfd;
 		}
 	}
 
 	list_add_tail(&kirqfd->list, &irqfds_list);
-	mutex_unlock(&irqfds_lock);
+	spin_unlock_irqrestore(&irqfds_lock, flags);
 
 	/*
 	 * Check if there was an event already pending on the eventfd before we
@@ -1011,12 +1013,13 @@ static int privcmd_irqfd_deassign(struct privcmd_irqfd *irqfd)
 {
 	struct privcmd_kernel_irqfd *kirqfd;
 	struct eventfd_ctx *eventfd;
+	unsigned long flags;
 
 	eventfd = eventfd_ctx_fdget(irqfd->fd);
 	if (IS_ERR(eventfd))
 		return PTR_ERR(eventfd);
 
-	mutex_lock(&irqfds_lock);
+	spin_lock_irqsave(&irqfds_lock, flags);
 
 	list_for_each_entry(kirqfd, &irqfds_list, list) {
 		if (kirqfd->eventfd == eventfd) {
@@ -1025,7 +1028,7 @@ static int privcmd_irqfd_deassign(struct privcmd_irqfd *irqfd)
 		}
 	}
 
-	mutex_unlock(&irqfds_lock);
+	spin_unlock_irqrestore(&irqfds_lock, flags);
 
 	eventfd_ctx_put(eventfd);
 
@@ -1073,13 +1076,14 @@ static int privcmd_irqfd_init(void)
 static void privcmd_irqfd_exit(void)
 {
 	struct privcmd_kernel_irqfd *kirqfd, *tmp;
+	unsigned long flags;
 
-	mutex_lock(&irqfds_lock);
+	spin_lock_irqsave(&irqfds_lock, flags);
 
 	list_for_each_entry_safe(kirqfd, tmp, &irqfds_list, list)
 		irqfd_deactivate(kirqfd);
 
-	mutex_unlock(&irqfds_lock);
+	spin_unlock_irqrestore(&irqfds_lock, flags);
 
 	destroy_workqueue(irqfd_cleanup_wq);
 }
-- 
2.31.1.272.g89b43f80a514


