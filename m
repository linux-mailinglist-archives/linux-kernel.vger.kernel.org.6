Return-Path: <linux-kernel+bounces-323840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BAB974418
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AD31F264EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A151A4B7B;
	Tue, 10 Sep 2024 20:32:44 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC08A17E473
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000364; cv=none; b=a8fXcTXdSnY5DN7wfabKEbrD4s0oBEA9yzVkrojDHKZvCOeZ4fGhju/TbMCJEtyQ5EV5CYFyU1OYN4duKRnr7vH81QUAbxDKlIgndHj7eFzVUilf2UKFCsn5tRJc7aFWkZb01KF5rMaUBTWCF86ewc716ayn0TCChyEXzgMpjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000364; c=relaxed/simple;
	bh=4DQPIHjwtqh7gKICZd/SOTDF97Xnqa6T0H2Kb71YMSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c9uqTdhPfuOFgLIzLxs2XoNX0rEZEkTzaOky4U3PHkSlL9aT8rC9jwZ3BsZpi/WThzVK/IissAPMrUblb/vw9IQpU33tRLPwfAC6WzAKp5NMfnQxuvBuYvGgjSDjQiWEqaUZEb5gQU/8ZYFmcAozXOWiSaw+QivWkdd514+wr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82ce92f8779so582669039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 13:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726000362; x=1726605162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSfwNjhTbSE/czuLsNJKKxciq0u6UDuluDmGHJH2hj0=;
        b=lu3AnGEWJ2jbWBZDT6HWj92GC00tScODVqOmeXVZanaeuc5DyVucAs2Knb4YCurWmh
         EkTL6gHIIKuQxHErifjSxo2GcQh5Fz+b/DywkQrG6cx3+uKoFa5X28QXtIIHA+cFIZKC
         S4sheoY382auKUelPNoXn3OCGEx/F+UVx86+a3Jj86qGGo2Tc0kbqvPkKMqMcKpKV8s+
         7Hs1WffDOMUMBN3LVqYGt0V/AUClCQvDu8abe61/4gFRi9nNwBMIcyBPzbNrvewxxk00
         GEtW0+jLLH6rdJ4m/uY7c+dvJMNrGMe3Wbk/r6o2DOF6hP3MoEJXBbbPPYD30aPPR5cb
         FsUw==
X-Gm-Message-State: AOJu0YzfOnL2Qn6F5afeTqLf+GYbcbs3picA/0kbldGVkhb2i0lkELrk
	j5K6tFh1tChJSyCGctsHZdEUpHbCqpZoxg0gY4F/Rkolk7F5fYzUNYmQljOP2kerIgSdJQWanzk
	SnX+zYEAwo1ZEdAeoRlsuj+XYYOdpWoZIC6Lv9txv2l3JoOkIrD3CvQU=
X-Google-Smtp-Source: AGHT+IFYy6iugUxgst3jGWdi9yYVY27pWHQVuxAdW/SDlT8Kqkar61M5cwDxiil4RQUtM96jCKq8EGj5FcQEPZ7S3vZCJgYXWVzG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:3a0:4313:f504 with SMTP id
 e9e14a558f8ab-3a04f072ff5mr164727745ab.2.1726000361689; Tue, 10 Sep 2024
 13:32:41 -0700 (PDT)
Date: Tue, 10 Sep 2024 13:32:41 -0700
In-Reply-To: <0000000000009b8cd30621bf7d02@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070e31a0621c9c697@google.com>
Subject: Re: [syzbot] general protection fault in bch2_fs_recovery
From: syzbot <syzbot+1cecc37d87c4286e5543@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in bch2_fs_recovery
Author: djahchankoike@gmail.com

#syz test

When a sb is marked clean but doesn't have a clean section
bch2_read_superblock_clean returns NULL which PTR_ERR_OR_ZERO
lets through (returns 0), eventually leading to a null ptr
dereference down the line. Adjust read sb clean to return an
ERR_PTR indicating the invalid clean section.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/bcachefs/sb-clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
index c57d42bb8d1b..025848a9c4c0 100644
--- a/fs/bcachefs/sb-clean.c
+++ b/fs/bcachefs/sb-clean.c
@@ -155,7 +155,7 @@ struct bch_sb_field_clean *bch2_read_superblock_clean(struct bch_fs *c)
 		SET_BCH_SB_CLEAN(c->disk_sb.sb, false);
 		c->sb.clean = false;
 		mutex_unlock(&c->sb_lock);
-		return NULL;
+		return ERR_PTR(-BCH_ERR_invalid_sb_clean);
 	}
 
 	clean = kmemdup(sb_clean, vstruct_bytes(&sb_clean->field),
-- 
2.43.0


