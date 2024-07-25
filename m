Return-Path: <linux-kernel+bounces-261680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E493BABF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535DE1C23BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6179CD;
	Thu, 25 Jul 2024 02:21:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683833CA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874099; cv=none; b=iv8okJ943KUKXguotcCvTdSfXwKK+7SZhnUOne9UwrzeN2fwaT/nzvZONpfKHj77ksNvW1mrReMyT1nfVQuOkzpz8RZnRtN2aAsp0EVW5drabHuS8KvwqQExdCuRnv3UZd3+mbDL2ocfXlOCbLzeicUV05/oITnyeMsY1LhQFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874099; c=relaxed/simple;
	bh=1rkTBzSLmaNC2g0Vm7PJ3yUCdv43gNVLrQpgfvjK8Iw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WjfIEbm45YfTwCWuRlGvs6d0xNHRTm4kOnqF3EmJhwF8OM0QFTfufNDcGXh/7JB2BkTT7iahFbQPTkBLK3cqVPXrfb16vEG5DtBDEDegP6k26nuPTgK4UOkls7EGPBiBZBjZJQkNJ7Qk7Ea8iQJ0yQs9V0uZZ4kvv0RAw2MVjtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-398ae4327f1so1218185ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721874097; x=1722478897;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI+HB2ZUQQDxYpAazDNXYTlk31zFS/0yKjUfBlB9YEg=;
        b=p/3FaglbX4UG6ot2ijvWsb7Z1rtW7DA37eaufc3zuuGPVC0Ohw0pS5RPrREYpMrzHv
         /T9srGFcqCkYg3MwFMB/nOJuYQm5QJA4aYTUz5+OTE2wh4/uto/o+UfLjA81Hcf9exdt
         +UjuZispldwF2gBT6pYONkRfZcEaQqgQeGlUYEm2EKJUuw84eh0NI/rfRu2mz6+mEv/e
         nKiUEUXnm6N9mfrkVyBpTDof6zY00STckgnBvvYGC8LRt0POEzepJARjFrrkk4TPsVwR
         06LYrNtCVrWG00DQLetnu1jZDZ3Krivw4oHl9GO3OhFOBeOAUvU0YCAcXH7L+wxaOo+K
         GtMA==
X-Gm-Message-State: AOJu0YwSwKHWd5fAssLwlF2S39Y5s4hLAFw7sDXjfT+/pvHpbEznxxkF
	EwamP+bpEmprn5MLZ9dRWO4g0RrG4HR9uvuZrlKP3d/8FfZd9LsTQsqExoCGpDDmo8EvG0CbVrW
	eTmnO20IsNJPNQcUFHgSICHjcCzRhropGo8Mnvw8Yf32/WG8LpioWCBk=
X-Google-Smtp-Source: AGHT+IF7QMhbidQZovvqUP6rbLR0UrnsGRTxMWq0ikEDpSn6W9jVNzCoo8Ww/k11XZgeoBjQQg7bhxVJbca1eYaKSW3iMTFu7Bdh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1283:b0:39a:1336:ac98 with SMTP id
 e9e14a558f8ab-39a1a5df4bemr882925ab.0.1721874097137; Wed, 24 Jul 2024
 19:21:37 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:21:37 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e87c69061e090dbc@google.com>
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
index 6066c6eecf41..ef7b4b0ed164 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -207,10 +207,10 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 
 	if (!gc_th)
 		return;
+	sbi->gc_thread = NULL;
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);
-	sbi->gc_thread = NULL;
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)

