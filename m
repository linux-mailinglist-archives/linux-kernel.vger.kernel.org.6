Return-Path: <linux-kernel+bounces-261911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141093BDB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3051F22667
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ED9172BD9;
	Thu, 25 Jul 2024 08:08:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FA249ED
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894916; cv=none; b=Ch7wJFB1lU/VEmXowBgbg3u/hhBDJ4WrODsuLf2rNz2AjD3jAg4aEzs1EuIPzwtnJ8gec1ie9UMg7WSDnM3V9jTAbT4eEdwq33lfYIgLNWv3CAbmw1/dg0Pok/aZlDHU/z0eJMsMrOvks0ECrnHezUgN1ffS47zutAn8K72qQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894916; c=relaxed/simple;
	bh=XeiUxrwhAvAusskCNoQclL4KC913p10E6GDjwUOn694=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SpGFcsF5gAJFV/e9l+CGQn+52s43/3CffrRs0wHYfK/J2QZJWaMpSyM3P024Zln7YneDoksGiJBLVSUd6eVbTkjSgfWzqe+UtkknoiQjZ1XqruqnlwE693sm5cQ/uyiayU9XDNPeCiBEfTLXep52iu86mteXDlPKzxVHTIhaXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39835205d20so5560915ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894914; x=1722499714;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itgpCFpt5Q9ovIgvk7WE03fAJaHAFu1VC7zt5Xy8+5A=;
        b=tm6jkLtDl8xA1r6D/Y+JrLxEHGA4L66mWqbdC0twn62qfDC76CGhzQQdW8xlMJ1WDv
         fRQCueCCe8j6tvqZvBjmRZ/GfPk18C0TM3tu4UhXO6/+97u4F7IPJ5r0VMoMxWShWnk1
         nccp8xrE7IjxFmPrktnzK9n61seVwWG/hswudAdo/70K9tp53yuWfGWQjeRYJgdZU2mK
         yocRCZoLirGYpKhzENBdemWhxv/5/5QnD+kTOd9RCO3ZE2zu5972sAF/Sj3MVXzcX810
         54o7mPLoT/jK0VnjM7Z+ZOdaoaNEDp8lO1aWk7EzrPp2XMYyylvivYNM/cx4mHCiRReI
         BS5A==
X-Gm-Message-State: AOJu0YzXRjYAvs6ig09D88fFFRKDGMcCl1FOpzsNfP5XnvMbefeFvkR0
	fhhk78SfEbP94qxY43HYTynxFzzefFPtulhPKcq/2k4Sw1nA4Eea96bOh96QdGOLSLcdMRN6upw
	hnU+WKPGfmWhefPRzXVaTGXPCEEjTHqb6nQgahy9TzCfjgza9pC4pTrs=
X-Google-Smtp-Source: AGHT+IFfw1x/2nBbbZukZF63h1Sg2+kpreGE8Hd/Zp0WrqWSwBFBeVXM+2RoSmc5PAmkTxWjKWKLdEXloaeoN4rpD1WV/FIZ4jtq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:397:7dd7:bea5 with SMTP id
 e9e14a558f8ab-39a23d159femr1161785ab.0.1721894914045; Thu, 25 Jul 2024
 01:08:34 -0700 (PDT)
Date: Thu, 25 Jul 2024 01:08:34 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b14c3e061e0de63d@google.com>
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
index 6066c6eecf41..228cad05b32b 100644
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
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
-	kfree(gc_th);
 	sbi->gc_thread = NULL;
+	kfree(gc_th);
+unlock:
+	mutex_unlock(&gct_mutex);
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)

