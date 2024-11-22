Return-Path: <linux-kernel+bounces-418444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA0D9D61AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AC7160480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3C11DDC16;
	Fri, 22 Nov 2024 15:57:59 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89ED13AA4E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291079; cv=none; b=bYqC8hj+AV129gJJg+tjgUlWjdAyHuJueZr8+0WPXPxsKQQGTpmzlte9Fmlrw3hJRJDOQbyurEVOVTHssi4l4YVyZDoBd19ZS9Ato1OaVrUSLphPFj+Ief79ZTHJ45kFvebFcMmZy55bkqh8YPcPkzsZwaPxStIpMemIuHY12Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291079; c=relaxed/simple;
	bh=BkNHdOwtRxxV/1UFkElNOkdEV8Nry+Af7z1Yd40Uxwk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pXPJdiMUf4rn6g8ANLIGy3O8x/aqgom7W01ZWi8rMatp3aP4NenmpSJGc7UbChjc3ZYb6PkCZe9lefkq/miOA32qM5ZGNflv+D59zFn5piZ8BVl3uA0v0OoIUyfEGLYMNup38PDTUpAlPE46ZKZCBSCNqt2VfltHcfGMq62c9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aa6bcd7b3so242047339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732291077; x=1732895877;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdbqCATNser9H9Uf4HlN1iqoL5ga46TbjKWuGc0QRdA=;
        b=QJ0bCFPUkDlEq77wy8Eazddo6AQX5yIrm6ah8NxJQaQ6uDmhB2PvMZ64ta9V2yEpQf
         LCotVxCyWyONTM44QCfgYs4zrJkm6cjoeiWSKn97NU0HZ76qMoA2jT88DjDsB9rjZUI0
         s7dAe5pjeeKgct05WhiMDgOFY4UIwBqt46AWsX8BCpsLLfaBvtd6M8/G3dbY3eKtxmY/
         xgWAxO7IqPVlsP6zM4/+RtIm7wCP3LVcCiqepJ00sBR/i186XjdAOZIkZ7gBo6acv3ZP
         89XQaI3tUxA6x0GjAyFIcOaC5kmGjtsIoTWMlVd790UKjG4fxr+MUsELC6ml8HD3dSpf
         IR2w==
X-Gm-Message-State: AOJu0YxDAun1vMydm6uTGZNNMJck2/7D0EbxMyIkMKU+5qrgTVMkF1p0
	+JBIgvR5imLUNoa0By/cEAr1FbIbhD8JBK/pBglq0UvcDAaMM/rhPcN6rR1sddxvct0tSF+aRlR
	2XjgxINW1r6bC60g365jm7HlTYEV1gCruGABAWyXZCKzcJE8wj2bBROM=
X-Google-Smtp-Source: AGHT+IFgX7UETAK6IAAON0XQhGY1LpVPqTwpWXpzMje/MCt4VNKfHYd5kWwhi82gvjTK+/GwT/JpmdMNm8BykCBp8oKN/qyteNRw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:3a7:6d14:cc18 with SMTP id
 e9e14a558f8ab-3a79af9ec8dmr41573565ab.23.1732291076894; Fri, 22 Nov 2024
 07:57:56 -0800 (PST)
Date: Fri, 22 Nov 2024 07:57:56 -0800
In-Reply-To: <673ef6a8.050a0220.3c9d61.016c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740aa04.050a0220.3c9d61.0192.GAE@google.com>
Subject: Re: [syzbot] [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
From: syzbot <syzbot+fe2a25dae02a207717a0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (2)
Author: bretznic@gmail.com

#syz test

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..b9d128243286 100644
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

