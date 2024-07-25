Return-Path: <linux-kernel+bounces-262228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 529FB93C2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0031B223F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53D319ADA6;
	Thu, 25 Jul 2024 13:19:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124421993BA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913570; cv=none; b=YJMizjReVfRdheua3039OcajfiZW15OdT1FKKOOwVtQx2orO7uIB7xnF3GwyGydHNOa/IJITuCwO/5mhzhP2u0YUH9cKZ/WZQsiMj4eb0EArIDToGB2OwIbdIqQJmAI0MZ1182omBXmqMrTLQgdOgQML5IsVMe+Dj04gRbpqMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913570; c=relaxed/simple;
	bh=IB/Db3LGGsMTycLDC3ShxtPYNt26Z8ZUqIMci7k567s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eHZiTdL28yL9oXSp75mpy7fZBvs/UKlYDvNbuH6SOOeW/oiE1qwzTAUjiekflBeEilXKwoX7lnSInXsNDcgvalaOzL7cln/1+o7YvHaeeImAU1Nx7CmpikVl4cnP/+V9AkTd7Td8Qs7EUuxYt30lIgzHFVVt8/WHlzPg8aBlodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39835205d20so9625625ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721913568; x=1722518368;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBhYlkD+ZUh2j5IqrXDeHriyOAhgczqx3wAJP3U3fHg=;
        b=kGW3qNSJfz5DgjfbH2/XT6wJQZodD1tjgSkciXC700fQ+5HdKPEfvVKRPAOV0lHcjq
         G2c/LsMKcYG4YdlHrG9WTtjWXBxIVrdnHlYbiEPZ0JFQu//rEXYPQ3qx6yAP8gcpAxWH
         aXlDH2AOsTwlqoHQ4ZSMT+aFmWJ8gm6CCAyxZsTjSYo521vtbItzSM1YbEwObGP0u2PB
         nyLsc0s26Bg/F5P+lhIiDv+NR2kq/2Y5iuFvQUi5CrFd8cKV1e4/Zq7OuXhRi6uZsp3R
         i3e+4sj8cqUCz5/im8KbetZFbY3COKbI/kTd1xy1u6gTKNVevELtZ14otjRQf41kgzCE
         1Cdw==
X-Gm-Message-State: AOJu0Yz96mxSX3bYbWMU98JxRX8Ysj3vRuBm7rPAZypddTmChmJulbom
	guCqNNVDOmV7BZwrYulOuJcD15mfLFt7BvsWqM02xUgHnH39OnqqQQu/NZQHusBX84JGj733Mmc
	HBZr/ESXiIFhDkprUhGjfz7J42PwB7qQIKG/+qfO7wZi5tMswBP+DIjI=
X-Google-Smtp-Source: AGHT+IEGZcta27VJJDUrywfnG4MMhwN6s6U9oYZ+UbXOQmkHsU5HXhqwxwHtjP/+7B9+mdpIrfStbhAjcGT7/dvRWrTBVATJwNm9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:397:b509:6441 with SMTP id
 e9e14a558f8ab-39a23fa30e8mr1571395ab.2.1721913568191; Thu, 25 Jul 2024
 06:19:28 -0700 (PDT)
Date: Thu, 25 Jul 2024 06:19:28 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090f4e6061e123ec6@google.com>
Subject: Re: [syzbot] Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
Author: lizhi.xu@windriver.com

before thread stop and free gc_thread, set sbi->gc_thread to NULL, 
and add lock for reentry f2fs_stop_gc_thread.

#syz test: upstream 2c9b3512402e

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6066c6eecf41..ebaf6b6fc65c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -203,14 +203,22 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
+	static DEFINE_MUTEX(gct_mutex);
 
-	if (!gc_th)
-		return;
+	mutex_lock(&gct_mutex);
+	gc_th = sbi->gc_thread;
+	printk("gc thread: %p, gc thread valid: %d, %s\n", gc_th, virt_addr_valid(gc_th), __func__);
+	if (!gc_th || !virt_addr_valid(gc_th))
+		goto unlock;
+
+	sbi->gc_thread = NULL;
+	printk("2gc thread: %p, %s\n", gc_th, __func__);
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);
-	sbi->gc_thread = NULL;
+unlock:
+	mutex_unlock(&gct_mutex);
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)

