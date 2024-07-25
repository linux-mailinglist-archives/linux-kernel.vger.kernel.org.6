Return-Path: <linux-kernel+bounces-262202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262593C25F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11064B23178
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7A19AD40;
	Thu, 25 Jul 2024 12:49:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771D19AA7D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911765; cv=none; b=XGEiof1wUMwx4AZsL9IJFk1lAfJ83rpUeapZbsTFgg0m/6wX1iCykkK2GAU+XVgcnYxD1ptSB8CfziCRIkXYevItCCbUuIgr8eNaE69MxAcHsC2YJyYL3NGlOvAojO0TyTuCRX+z2m3xgFzm5qZGry9CZYqcz0WBvHnCzxDVUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911765; c=relaxed/simple;
	bh=xl3Ks8zHsUWTO/RX7exQfNvKWCS3F3lTqLIuAREAUfQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JkVLv4YKg1wlY69Qmssmp62OEBrGra12sQAdzwnGPWL4BarpQEpSUNGa/eALGcOLZF9bzQSeDHS7xubquBtvX/awN8XVtvBY75NgreyYhLB2cdNZNSsfX7a8l3+HoOzHmKkVKwtr+6Ub5C/4h1/KhxvVa5zgAlku78acE/95rFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39a143db6c4so8216505ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911763; x=1722516563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71+UE1V4azyu48PDaklVjF31ycqbaINxHTFBev8Z3sI=;
        b=Po4nBOHRinHj+OwfA8UQY612DqkcU142AO189fCoKcSQQgnJrp3MNt+0XRz+zR1HMq
         o1ozb4G3jhAkum6TuLLgGHTdIo0YfrKc1r+MEFyxpxs6nq4r9XcxaKrT4wihc6zYvPdf
         UoUaMqbNr4CqahnY1SMAa7/NfdRjKBPXRhl3bBdoXbUuVeJrMDqR7/feXuzRad7pdv4i
         rnjLA7ITKtJcWurS/oBqwRL2TDisMbM7JgK0hoY2QIZON/JSN6zev0Y5sAF00y5mHikb
         8gCSx0x761v6TbM93/IU5EidDnbJRWefDPcaflV+ca4HDBPYHRq7LztlI3MvgSTzpt5v
         E15Q==
X-Gm-Message-State: AOJu0Yx3Ju+pmbWEaqJ9WxnEWltM9OJQNlsIplsfJKEXEHcN3NVZKUgD
	km1aIch8D4Q8OZrv3yxHtfiHFDssLONzxuetXrhTW1/jvm7ZXkeDXewbVTXNoeamKfK4B9DH1o0
	WEdv2AyHa6VNzZK3nr/3M2bz+1YvONGhD6Q8MHX1Zz5SVwNCNrsdUuZU=
X-Google-Smtp-Source: AGHT+IEMbWhCD+bKYJsdeOCd6wGjUsABTzCb9IsNGSu2pr67eP58NmsMIY8H7F5gHwSETTGwu0LYKs4n19llCjtdaoPnIcAJ7ugf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:374:9a34:a16 with SMTP id
 e9e14a558f8ab-39a24031dedmr1372415ab.5.1721911763693; Thu, 25 Jul 2024
 05:49:23 -0700 (PDT)
Date: Thu, 25 Jul 2024 05:49:23 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000028216061e11d327@google.com>
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
index 6066c6eecf41..462f8957ea9a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -203,14 +203,20 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
+	static DEFINE_MUTEX(gct_mutex);
 
+	mutex_lock(&gct_mutex);
+	gc_th = sbi->gc_thread;
 	if (!gc_th)
-		return;
+		goto unlock;
+
+	sbi->gc_thread = NULL;
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);
-	sbi->gc_thread = NULL;
+unlock:
+	mutex_unlock(&gct_mutex);
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)

