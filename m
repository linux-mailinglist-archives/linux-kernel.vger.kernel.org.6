Return-Path: <linux-kernel+bounces-386807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E19AF9B4818
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F21C26F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148A720492E;
	Tue, 29 Oct 2024 11:16:49 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4B1DEFE2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200608; cv=none; b=YxItmh+KmOMV1ymvkrcn1jFjn8z40o2Ov21PaQgFHc0Hv1MKS0bZqLNB86zDWUDxUZuorH2/Za3rRwAYXnsce4vu03MeY29OtD5Moy0suYp53wauInM3boZHePZh7OYmgQQ+nL/gPkmK1htQjI1CJeKMjoIWQlBWJatouElkPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200608; c=relaxed/simple;
	bh=wu2ewejiPfJDqviO15Xd4kn4KKxmLRzZWTmd4es2AFY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZJIdU7CNRrFSNMaHGGA4/FNWF9s1tN8jauRl1RkrAZtRcgn8uqBoJ0amynBMoIPm7RksjXcS6HMFc0x3mRmAO3DrHWk9Bf3gkC7zj6l00Wiyluiw1WgAMqDewsJ0n8Jy0oNkQTVRmEkc6QUrf/2EbXxnUygGbd6ezoLoB7Y7iYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3cb771556so46323185ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730200606; x=1730805406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0FEm/To/GnDoROuOVyUz33Gm3KH3KARtPCnlf1+kaA=;
        b=B278bzp0IjEV0Q1T/3V/pj11wwYdAXTEPa8Wl3TSqneMW0trO5ljuM0ueROTyYu9f+
         wYI8+DZPCiGGP6FHIbkMSuYoZH3yS3W1vaqYWbaY2Y0YMyf6GchdqE8zLawRY6noa0bh
         R4FYuS2FvNsKAGQn4bPN013J3PlIpwYqsb0g5BDijxrp7Mmlbawf9lAizC4hx3aFqi5y
         wWjB/DjL/AZiKEnDB5yOSo9FoHR+GN3zVW/mE/LRyP6XMPpOA07t8szRSvFA0sJtAzfb
         JHlelOCKe/5EMapRSZpLhhyg9SSeFVJEsWkbB/4aUl6YOueU++iFrMW+GWXONv3gYFCm
         f3jw==
X-Gm-Message-State: AOJu0YxRObr8qzobyW2wD2K6VHG+t1Lgq17yWYLX3GZ5tT+fnSQr4y6v
	ZwKaKzv5zCDgxyrBw88fopOnE1BbarI/kyXsLE8tgS/jGWy+MZ2vNDxS5qiBF4cQ95A2de5DsDH
	yQ4Gij4vYAgP1llBnYUKfYfgXhwr/63f1CK3+XUcbLnagw6ptOn9DDT0=
X-Google-Smtp-Source: AGHT+IEpu+dBEd/b8DBYClfZuobkwRUFm1ggSS6Q3UqkWnvzlL3sQXl6gw4SUPy87PHf7x3PWqUlAYcbz2hEQxqWq5ANmg/urQMg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:870d:0:b0:3a5:ce8e:a0d9 with SMTP id
 e9e14a558f8ab-3a5ce8ea2dfmr2574435ab.2.1730200606036; Tue, 29 Oct 2024
 04:16:46 -0700 (PDT)
Date: Tue, 29 Oct 2024 04:16:46 -0700
In-Reply-To: <671f4b6f.050a0220.2b8c0f.0203.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720c41e.050a0220.11b624.04bf.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in ocfs2_file_read_iter
From: syzbot <syzbot+a73e253cca4f0230a5a5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in ocfs2_file_read_iter
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e42b1a9a2557aa94fee47f078633677198386a52

diff --git a/fs/ocfs2/aops.h b/fs/ocfs2/aops.h
index 45db1781ea73..1d1b4b7edba0 100644
--- a/fs/ocfs2/aops.h
+++ b/fs/ocfs2/aops.h
@@ -70,6 +70,8 @@ enum ocfs2_iocb_lock_bits {
  	OCFS2_IOCB_NUM_LOCKS
  };

+#define ocfs2_iocb_init_rw_locked(iocb) \
+	(iocb->private = NULL)
  #define ocfs2_iocb_clear_rw_locked(iocb) \
  	clear_bit(OCFS2_IOCB_RW_LOCK, (unsigned long *)&iocb->private)
  #define ocfs2_iocb_rw_locked_level(iocb) \
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 58887456e3c5..1e37176ac405 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2390,6 +2390,8 @@ static ssize_t ocfs2_file_write_iter(struct kiocb *iocb,
  	} else
  		inode_lock(inode);

+	ocfs2_iocb_init_rw_locked(iocb);
+
  	/*
  	 * Concurrent O_DIRECT writes are allowed with
  	 * mount_option "coherency=buffered".
@@ -2536,6 +2538,8 @@ static ssize_t ocfs2_file_read_iter(struct kiocb *iocb,
  	if (!direct_io && nowait)
  		return -EOPNOTSUPP;

+	ocfs2_iocb_init_rw_locked(iocb);
+
  	/*
  	 * buffered reads protect themselves in ->read_folio().  O_DIRECT reads
  	 * need locks to protect pending reads from racing with truncate.

