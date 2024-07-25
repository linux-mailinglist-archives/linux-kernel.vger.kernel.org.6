Return-Path: <linux-kernel+bounces-262281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3C93C36C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36302832EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0A919D06A;
	Thu, 25 Jul 2024 13:53:41 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2F19D06D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915621; cv=none; b=MQeFGF/6EwS17FLH1ECuFwvc0Y4R7zsZf1/6DF98OP4ox8ybJYRSysSqFJE/g8ZBN88JBWVuKF0k3e/7id7q6gMw4EfxYHlVu7cxUSjgQDqjuhYnhS6/NWWLf0XVSjeQkGhYHCv5YoAKGZ3sjhG/CuTAowQfgp3B1dn/gMC/nDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915621; c=relaxed/simple;
	bh=J97+8GDUyXu4RsMWTgGQJvhbjUN2hFSbpzDeLCK0hVk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=swOn6RjOlih5kpPaJlLBLd71pkE/S2IbK6vWqbGpPzDAOtAooToMySD2ysiFlI4ux5dWxipB4J66xy7YqxmZDg0AYHWos+y9yM+nkcDynNYEw24ylKhnjMYdwZP8L8U2+uJDLsNTIEjfib8ktFRwJYIKkVFQzllEfyPbkFNiS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39673758efeso9376655ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721915619; x=1722520419;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbSESdSfl8Zy6XV/J6M7oHTzF6wnNaXjH3/ukGJlvGU=;
        b=WHV2SOaD+DuILhx72LhotuRJkC/0NpjNIjYszBpx3+prKo1hMJKRE5jotk97G7sO9J
         /EIS1k2XHDy9mpP+//DDk+NPi8NZIIhlGMhF0rxG9aTrXDPUJCb0DKupXT4oWkdujRmW
         4gK+TxqZpA+zl18fSANT2W1Ifb1SH3cWv/W/c7Qxt9jlIGMQ4qAIRIKcbww/EQfSLPmT
         YZgKFpjJC1FIt9ymXx5NETiCeAR4i1iZd1bjIqGtqSRzQzWa81Skvkk3Xne8PgRwpYOD
         PEIvBZ4AR/oQdjkCIxKo8H0fuQiwpRT8nSRbDk/eMqis5DNvqU4fC3M+2cvmJY/Et/pb
         +vZw==
X-Gm-Message-State: AOJu0YwtE1AW5npec4rUDUXz/MQU6anVTilBCFn0cxtW44IUT2V7pqfg
	qvMhA+DG/wSSY4mqHlU6666725vRGnPq2ZolZxLv7HNpSWENzAOAKmM1JqESb6S1DpCa5dO/AJu
	Uy4GXG3vsbhfCcrt1KuhIc/ayfnnsl/HHT83ZoS0A9jvwE9L1kOMJW0Q=
X-Google-Smtp-Source: AGHT+IGJ/McZXe1+PUdkkxLpBU0pznv01yqwJwQWXb0ulcsoUnCK3JeRn7UyNIuNOIPe6q/Xj67KAc55W3TVbhZTDhyj0NLcFMWF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c85:b0:398:d1fe:9868 with SMTP id
 e9e14a558f8ab-39a23fcf0dcmr1378775ab.4.1721915618921; Thu, 25 Jul 2024
 06:53:38 -0700 (PDT)
Date: Thu, 25 Jul 2024 06:53:38 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cca23f061e12b868@google.com>
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
index 6066c6eecf41..484eb5082604 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -203,14 +203,20 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
+	static DEFINE_MUTEX(gct_mutex);
 
-	if (!gc_th)
-		return;
+	mutex_lock(&gct_mutex);
+	gc_th = sbi->gc_thread;
+	if (!gc_th || !virt_addr_valid(gc_th))
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

