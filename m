Return-Path: <linux-kernel+bounces-261861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF36D93BD19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 422B3B2137E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71216F85A;
	Thu, 25 Jul 2024 07:27:54 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4AA1CA8A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892473; cv=none; b=oSXBvUfy/0i7Ol0H0nBn8+eVChWrq9i6uItJY2Zqof7sMoGTyza+KEuc8Catrk7zdy75GdMbeTNSVEm6eOS/W3T1ePlp2/G4oYQMNkd9DhmdDIaGhzp/VivWBkr9JsRt0N22pXVOXscqqXjfNy01HTZ035kPPimHPI+yJ+DclLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892473; c=relaxed/simple;
	bh=zng6llbHYwkbyhVvc1Ia5n1UWLvbaniSZc4/Gt8JySk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kZ9vJADYp80DDumPiy7ZGJfatbLpVBlSyg++kZYCHJuODKN7WN0FJpylNV2V3WMD6CCDTvVb5x3sDKt+9OxNZHoRXvsS+5XXQNKuZva8HEI2hfKFKSaCTZgn7as0YyV6Lk+fb84x22e6D54/5q8OBvKncTsTR6bz5/rGbdpuyZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81d1b92b559so94726239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892471; x=1722497271;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSRphCPXWq38X0VX8qusHL+i6fBu5dtYeyvNTTE93X4=;
        b=XtwaXomjjK0tGwdT5ox7WQ9k1LGbzNWmQbkz1zFMLdsTY8Vl++UTa+lXrxcod4BNLr
         5zdQfjVsul+Its/YPJkzg7pK5eFzNwbgInRhBSD+1Fr3w6uRxusY0RFGsTbomdILSGmI
         3NXorhWiy2d3oWRoiR8P8aiT3VAA4e5tX/U+Wf/PGF5OzeECoty9Z/DKEph5EBAzlp/+
         ugvTbYHoVu/2xws8j2eOR4BQ5gSOWn1Is0hw+mJ9+y71PH1q3TgQWeYocOH6SoD6327Z
         TGKLE68xai16PYvEdBdBixQdz5g3woxafuzpLENg6kZyPYTO0ssg6GV9dkfNNLP3z8nD
         id4w==
X-Gm-Message-State: AOJu0YwEoLrRJi7/6JUChguBkIqVgIkc7yliy57h74+T4iYVfJhaCcxk
	1Bnr1Z1PGWDJbMUe8GicTvLx3D1tjTpL38A1alFwyrjOtueZRTau2vIz0UNy7es7ByUi9ArzP96
	k2LZugPUOqLmaASeO9QVJ/fYhAVeADytZwQjIkz+Qr8v45GCTmWZKpLU=
X-Google-Smtp-Source: AGHT+IFaNHTUX+hD7NgsfG7JTrqQxYGR/9xtGBhJ4kxk02w9ZBtrUwGaAwunubofRv7cy3c3Tfa6OZCPoHAM2Ie13EtJGK+xpSf4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c242:0:b0:39a:1b94:975a with SMTP id
 e9e14a558f8ab-39a23fbc61bmr908665ab.3.1721892471573; Thu, 25 Jul 2024
 00:27:51 -0700 (PDT)
Date: Thu, 25 Jul 2024 00:27:51 -0700
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c1da2061e0d556b@google.com>
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
index 6066c6eecf41..9d7b10831d88 100644
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
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
-	kfree(gc_th);
 	sbi->gc_thread = NULL;
+	kfree(gc_th);
+	mutex_unlock(&gct_mutex);
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)

