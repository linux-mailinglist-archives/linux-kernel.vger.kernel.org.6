Return-Path: <linux-kernel+bounces-444408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C569F0647
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149F2281AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCD1A8F7B;
	Fri, 13 Dec 2024 08:24:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC219993E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078248; cv=none; b=d/TNKywJQU2kNOTFyYrucN1m8x7RgkbUlxUnOEiLW8sVIg8MwdgShIZ0Aih277mx9kXTEd3mJRZVZ6nYGHjH9abVne8Q734cJ65qM+2qkh+PZP1v7ZClxVm8ptWuY2dC0WzIyfRSozshQIsL0s46VVAlBS6Pg0CxDsoRdBjALOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078248; c=relaxed/simple;
	bh=7CG86/BX0UxasZ9xjKAaIfLP4d+H2OO09dVXP6TmXqQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=P6jOy4VsIKBJAW/bHXc8j2fXrg08DZPaALh2CkdS5lTwYVSVYXXUqtWoNzXiBsUEiQX1UCkiWabzKbLZRp0puQvYR76yU1h1d/NseOQpsBwbDGWeUjkWHb3qr9V1oARQQDySU3NMaGIiT6yXRqfVdkTm+bDWGoa5hjULH8mohuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso14212325ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734078246; x=1734683046;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8tOLBDN1texFiZK+kRAFXlCnppTDoXwP6TKtop8DME=;
        b=ILay5X/fLhGHvLT6mIgt4jFAK+kjSymNwo9libLf3HKUATYsR3OgsJG5AxtqZxqXBl
         O24wbYZAAF1O3B6yXt4NygugTBb8P41X4gIaj6s/5d7kembaomXWPxAa6cOdcWFmr7xN
         YTod/lEQYEaC9OJFyt+KNkH+vo0bIwZZ8w75x3AhOgw631QD5Rhfmr4LTn2PDMtPh5F6
         6FYxKopiyeIjVw2ao0hATPa+tkeEC3/KzTGl09qluYLifaiQF565SXESWB/nsu0BElWe
         pr/Riq9x5imcPgzzGfLROVvl9gxEKmDwKW8Lai+rvP7UW7UpVHbfC8Pc6TnveyZllDpT
         6KaA==
X-Gm-Message-State: AOJu0YxzA967BBubHZBYb1KL4926nTsFJ4AMFYovNxKACrkvWcqlrnBq
	E5mqADrbCecRXnJVdoFa4LoRsnxBbDHwCZxvhNG4ArLvsH/SRpaiq6W8QhYrVQmASLFE6f6bwSf
	8QxKaHk2pLx8mmQfMtw85g3XnZZxXlsh8/iQ5F14hjWMGkAjS0quqCOw=
X-Google-Smtp-Source: AGHT+IEDgrlac3ffDfyRgHlx1Qv0cHSeENIzPu7eyrad3CE+qyN2AY8cXlqdwbKljAAxWFAjMPU2IJ7nk+CI6wLZIhemNlHCQM6m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:3a7:635e:d365 with SMTP id
 e9e14a558f8ab-3aff69dc06amr19702815ab.6.1734078246556; Fri, 13 Dec 2024
 00:24:06 -0800 (PST)
Date: Fri, 13 Dec 2024 00:24:06 -0800
In-Reply-To: <672dbff0.050a0220.69327.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675bef26.050a0220.1a2d0d.0004.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ntfs3?] possible deadlock in
 mark_as_free_ex (2)
From: syzbot <syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ntfs3?] possible deadlock in mark_as_free_ex (2)
Author: lizhi.xu@windriver.com

reset the lock order for openat

#syz test

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 6e86d6619..38ebd65f0 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1096,9 +1096,17 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 
 		/* Looks like volume is corrupted. */
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
-
-		if (!down_write_trylock(&wnd->rw_lock))
+		struct rw_semaphore *lock =
+			is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
+					  NULL;
+		if (zone && lock)
+			down_read(lock);
+
+		if (!down_write_trylock(&wnd->rw_lock)) {
+			if (zone && lock)
+				up_read(lock);
 			continue;
+		}
 
 		if (zone) {
 			/*
@@ -1112,16 +1120,11 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		err = wnd_set_used_safe(wnd, lcn, len, &done);
 		if (zone) {
 			/* Restore zone. Lock mft run. */
-			struct rw_semaphore *lock =
-				is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
-						  NULL;
-			if (lock)
-				down_read(lock);
 			ntfs_refresh_zone(sbi);
-			if (lock)
-				up_read(lock);
 		}
 		up_write(&wnd->rw_lock);
+		if (zone && lock)
+			up_read(lock);
 		if (err)
 			return err;
 	}

