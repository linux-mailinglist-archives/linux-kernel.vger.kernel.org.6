Return-Path: <linux-kernel+bounces-418517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631D9D6277
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E8B21213
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4E1DED6A;
	Fri, 22 Nov 2024 16:43:09 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1913635E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293789; cv=none; b=NBO1Z4ylDivrVBsymmOfAapkoT3To3vUu9ZoBtjK/dG9YotTF01oGgWbj1T9oN4DHYK/BlKRrova+wDEr3IKTnzKYmZbNzYhjF4tKudqQty54g1rUp2POp3HE5Wncpf5aYtrTsfskbAbI9Y3gQ0mWIXT3RlE2mmSxbU9VT1D77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293789; c=relaxed/simple;
	bh=U/5/TdAjVqD9GBTdBzh+yZQRkU9Z09R9+OF3uZAdjuc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m2fkLS+iC0vZO2T0wEg2MmHRUVspR4f6etn9Zqww7fUfvAzr6VULeNpYPFTBIt/YGUSkFCRlX3M5dM/W9Xvn8YzTx/Y6cn5nCkVg+AtjKRcVD5a+VEXjif+hGk36qsutebUIRL3oZMr3PgwxPJzne9mitVNKMZWNIhwWKcWzwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso27388765ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293787; x=1732898587;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=po0ehGeqeCW4gAcbZwoNi2Bo3d6bm4Yz52TFjNvubiA=;
        b=FRaVr4qSVKgu0KInmyNA6nQ3reFrNwsyndulC7wVef+wTVPv5WhO2v95RIOno+RAsZ
         +Zpm5KecIycJ0GHgTSi30z/DG/18yExA1fsYkdteRzIkU4TPcQBrQG1kvRXN24ag2c+I
         hhoDnQy4Std5TaTaOfZ0SQFsLX6iYjFb2RwCYHWSvJ55O273s/Y1wRYcIDUs+E2ilfSF
         QOSH77ODk9zD1tpm/01h+ZJEXHj2WNBhYTuu91+GdHjdWBVIrijy0ampgMsTvaj+Na+B
         8TP7xU/hWWUOJrkwdpquLvCA2d/9yKtQdwSLkSMoDoYw7hXtoH0cnAtoH69e3jrdISql
         zRNg==
X-Gm-Message-State: AOJu0Yyu9+NHuBnlFjfwTInwKUnVDXgbggeqaOrgxFWDO2JYNL5a0UIR
	nXOXsyiVMdA3AbOLturzE/u84ysc5hoZ+wd/ONT7Jnggjsi2wlwKoq9ETyJxk142ebgJdQbAuYt
	kD5yso/q1Cg4U7F37G94BELS9u4uqlhhL9DZgZQFxgw0Fj4pGimnEQQY=
X-Google-Smtp-Source: AGHT+IHVzjLMKh4aQutWCzJB5sPZ1qW9jZ3102v5MZBxU+uAite0M3JI560y+V8zmeoRicDKVeOt4sAYZxx+VYFzr/vfVbmyUc8j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3a0:9c99:32d6 with SMTP id
 e9e14a558f8ab-3a79af6d1fcmr44653985ab.24.1732293787213; Fri, 22 Nov 2024
 08:43:07 -0800 (PST)
Date: Fri, 22 Nov 2024 08:43:07 -0800
In-Reply-To: <673ef6a8.050a0220.3c9d61.016c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740b49b.050a0220.363a1b.0147.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data
 (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
Author: bretznic@gmail.com

#syz test

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3562,6 +3562,12 @@ extern int ext4_get_max_inline_size(struct inode *inode);
 extern int ext4_find_inline_data_nolock(struct inode *inode);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);

+static inline bool ext4_inline_possible(struct inode *inode,
+ loff_t pos, unsigned int len)
+{
+ return pos + len <= ext4_get_max_inline_size(inode);
+}
+
 int ext4_readpage_inline(struct inode *inode, struct folio *folio);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
  struct inode *inode,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..ec25f066a2c2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -668,7 +668,7 @@ int ext4_try_to_write_inline_data(struct
address_space *mapping,
  struct folio *folio;
  struct ext4_iloc iloc;

- if (pos + len > ext4_get_max_inline_size(inode))
+ if (!ext4_inline_possible(inode, pos, len))
  goto convert;

  ret = ext4_get_inode_loc(inode, &iloc);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..d4c0e0a42b8e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3061,7 +3061,8 @@ static int ext4_da_write_end(struct file *file,

  if (write_mode != CONVERT_INLINE_DATA &&
      ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
-     ext4_has_inline_data(inode))
+     ext4_has_inline_data(inode) &&
+     ext4_inline_possible(inode, pos, len))
  return ext4_write_inline_data_end(inode, pos, len, copied,
    folio);

