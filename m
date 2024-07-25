Return-Path: <linux-kernel+bounces-261774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFA693BBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8481F2260E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0318E1C6A3;
	Thu, 25 Jul 2024 05:08:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C218E2A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721884083; cv=none; b=ZdouZBDQSZucweStUKqTV0gXYnga0L9gQ2dr0gETgtR16L3hy6duNVnP4qZJJ4mO7P9Fi5JCU01FnrPefNce8g6YuhzvE1gc5rslU9aBV1XIP9rQSv7NSuVZ1onlvOChp1kINqsTKbrb2ufSeRQXay8s6JHpu5vrAmeSxFrAkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721884083; c=relaxed/simple;
	bh=E8sBtNYDy6EdlfoUxm6betGvTL8J6dMFV7dlXmMCaCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q4Y1Lo8BV5MSeFvmAGkj5+7UYbV/SUrEOAKAYaqzeC+Znef9aIP/M2XWxOJH1nK/ZNbw+ObNyatMyQ/KGjcDncL2GjVjXo+FBrHGWo9vgmE/TBUvbfp8OfyLU6YqaUwXnsp7Nn8o2wQfN5W6S4rZJ2Zf5cpZVmx9Y+7u+OQFT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39696c3f2d6so2224125ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721884081; x=1722488881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtVTCHXktOygG/0hkXblz37LoHKnCs1ISub2x/3u7NQ=;
        b=ojxsqX+RcTD6UmIkCug3W4NjwnDWbkAju/+BZma40+yNYbxwaAVkf0iSZ70yxaCCs/
         +3TZZSFwiRdadFNCclMJtusa9iPtzcu74uQiWtCAaljemAsZNL+0qSG7bhwfS4X2xZij
         CXwl9ylH8a5+U+u2ib0yjKDYNcF6D+sG479OpE1yxjiPOPHMLt1b7Ym4LASsT61lZV+o
         A60SMJwWKvTJG99T3fwvMTIsIdiFOSxVcRr5gyg9rbarnrwsARQPTyEB93tlJP7D8em6
         5fMK62H29hwKX5WGHGRJXwLjKQtwDBVfVg37xH4rlpAQ/g6CHmUZgeaWChzMb7BwR80+
         pFag==
X-Gm-Message-State: AOJu0YzlLC9KXoZxfIe9QISay6qVX9lFOM/pAOUqHz5vL5NnQLfR2rgH
	NPv0Ab62Ua/SLBpnTney9kJVSi9YqnALRQG+7oKKd6E8kVV/beWyjCzR783jw++Wwugu6AvRgk7
	LFsKvyii89rWjIKNpnle91Tx7Lts+Wv9YiCELpyJKY1X2gTRWGKta/YY=
X-Google-Smtp-Source: AGHT+IHrpgOb7jseY2oLWzkcu+QMZ/QNsGghD2xYW0MRDqoYQOIvUu+9t48+3yfOUvaN6jbayejtbpC9fd8funvWEWfvhD07N6I2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d93:b0:384:ff22:e5f9 with SMTP id
 e9e14a558f8ab-39a24007b9dmr804055ab.3.1721884081372; Wed, 24 Jul 2024
 22:08:01 -0700 (PDT)
Date: Wed, 24 Jul 2024 22:08:01 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003ce5b061e0b618f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
Author: lizhi.xu@windriver.com

before thread stop and free gc_thread, set sbi->gc_thread to NULL

#syz test: upstream 2c9b3512402e

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6066c6eecf41..363f95237383 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -204,13 +204,16 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	static DEFINE_MUTEX(gct_mutex);
 
 	if (!gc_th)
 		return;
+	mutex_lock(&gct_mutex);
+	sbi->gc_thread = NULL;
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);
-	sbi->gc_thread = NULL;
+	mutex_unlock(&gct_mutex);
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)

