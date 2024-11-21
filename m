Return-Path: <linux-kernel+bounces-416971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4099D4D14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C931F23BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737FE1D47A0;
	Thu, 21 Nov 2024 12:43:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A41ABEB4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732193028; cv=none; b=swKeWf+CFfO3thiqii8s0Pe7aoBkso+uGT2ay+q8Z2FppvXjMF1TdVhQt2sGxxcfPkN1BvvEjlb6yVXv1/bhpnt+o37/LSkMC/nAOoqn3beQnqywVgipK7i5EV1vhzvnKFKIoc9BQhOnDx0P3UdB9EtGrAlDZixBxOnLLU1mzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732193028; c=relaxed/simple;
	bh=8lXij9cEl+LztDn+enk47Kw282aAwHf0qNpneRsjUmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TCoALGnHce8vWmj512z0bEAtOJrxxEz6STFau5TqlIR6WbVY4Nn829pkXF6wgMNV7GJbu/1NmjdKJ8bUKKlr//8q7KnkK14Khd8J6e/GWrU0cJESUwBIm0E64kIoh3NEn7KKosinYDOkcxZSWPcq7wz3n/KxjKhO/8ljmim6D80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a79088e7abso8102385ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 04:43:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732193025; x=1732797825;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dmP4afuoThztDKRYKtVREdz3YOaMB+momQUsx5KVLk=;
        b=KRC2ZWSkZs/7hcsP+Oh1IvsQXcxrtkolvR6tSNs9fMH/O1xc8TX2bLF2WHnX0OaYk2
         IF8uPgL+8JaB0dxrJtQcNPUFAcaQ1BUu4sgW0VFhJlMr97rgHLrQHhQhaGfLF2iScfHd
         LeWMfOJ5cYsfuKePeJStXDmZPhHtCJTcGgSxNvLkZosnZsr1ELl5A74LhA8JWDd8rx8K
         9Tq3DlRI/+4uHBs8wEyUakZft7tOoBweX0uNosyUnngtLmQWmHA8ToySPtbj5fTYVMrL
         I0t5keg2JksQuXbJPUozRYta8dh6zFCZxC0LgmVqU7wqs436uwx/9Su/oDHjnLV5CAGW
         vLwg==
X-Gm-Message-State: AOJu0Yy1dJ8gZ/5wH6CW+YUEW/PJEyHVxl9Br48p9HGkXssUYPxVusm5
	lFx1ytlTkke3vND6GD0KG4XBvGGd4HJsVcNyQds3gIYJmsfYnpw0estweVvhq5XrRCLpBkx687i
	6ERMso0jXe7/vcQvdX1RAjocteje/5ckeMaQq9IcDCwcyBqd7jQVWxEU=
X-Google-Smtp-Source: AGHT+IHN2z5YQCc800hzg5oiHZNBtS/qr8oDNVFH8CLnb8Vldhjt1oHR2crh8eAGtcQ+EsG6FnVyR9KK40ncP1gQn8whfy6gbB2Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:3a6:ac4e:264a with SMTP id
 e9e14a558f8ab-3a7864827c3mr75436575ab.10.1732193025665; Thu, 21 Nov 2024
 04:43:45 -0800 (PST)
Date: Thu, 21 Nov 2024 04:43:45 -0800
In-Reply-To: <673ef6a8.050a0220.3c9d61.016c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673f2b01.050a0220.3c9d61.0170.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in ext4_write_inline_data()
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in ext4_write_inline_data()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 74f2071189b2..759a0d69b277 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3558,6 +3558,12 @@ extern int ext4_get_max_inline_size(struct inode *inode);
 extern int ext4_find_inline_data_nolock(struct inode *inode);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
 
+static inline bool ext4_inline_possible(struct inode *inode,
+					loff_t pos, unsigned len)
+{
+	return pos + len <= ext4_get_max_inline_size(inode);
+}
+
 int ext4_readpage_inline(struct inode *inode, struct folio *folio);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct inode *inode,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..ec25f066a2c2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -668,7 +668,7 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 	struct folio *folio;
 	struct ext4_iloc iloc;
 
-	if (pos + len > ext4_get_max_inline_size(inode))
+	if (!ext4_inline_possible(inode, pos, len))
 		goto convert;
 
 	ret = ext4_get_inode_loc(inode, &iloc);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 89aade6f45f6..9fe49571bc93 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3076,7 +3076,8 @@ static int ext4_da_write_end(struct file *file,
 
 	if (write_mode != CONVERT_INLINE_DATA &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
-	    ext4_has_inline_data(inode))
+	    ext4_has_inline_data(inode) &&
+	    ext4_inline_possible(inode, pos, len))
 		return ext4_write_inline_data_end(inode, pos, len, copied,
 						  folio);
 

