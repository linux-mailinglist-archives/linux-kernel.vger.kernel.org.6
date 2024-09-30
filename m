Return-Path: <linux-kernel+bounces-343635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49B989D92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEAB2879DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB136185B48;
	Mon, 30 Sep 2024 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFaLNtPi"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B946183CAA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686978; cv=none; b=FC5myQZ4KmiB0DJLYmqr5y9/A6HaSYQgCIbSankQ4afE4HX8yf1wTuI/l5mxHtz9ZEAhR3DJEySRMORN3KSy56vUXQWY0ztEPpB/D2e54YQpaOwQKKGIXMybvZLJKJ7F0qUQRa76TSx5azxl7P8hJOUuCOOzYHLVoj4sheCwSbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686978; c=relaxed/simple;
	bh=zcULoAs2qCaoHiJt9VBIp/j2zPAaBYobPJI4fj6+h48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IGaAguDuviCINtaJ+G08PRkwh1rNwraJlBd4EpXOiiULi2vcWq2Y4E9PXoMUdhTAQxTpXCawkYCUDJgpOuC1LpgQYbdVnyY4IZoUJQdl6W8b2p9+Ya/KbrV6yI0VluRxCJ6Wmx5u0JeTTAMJXlh3zqbRF1zbiaIigiJB+/+IOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFaLNtPi; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so565507766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727686975; x=1728291775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4koKxXkPqyf3PTpI2r9SfRgcoCHSohiw3BXHU1GCzQ=;
        b=MFaLNtPisYHQrL2hbW45bYn7VDeymDFtG4h1/zHGsKYtN8euroyLGDidBmXbOP+By2
         bN8tG9zf5CzCFhLJ81/qyUQa4CfkDy+VfjuxFcOhDpwcIU4QKV4SU5BQy/yKwGP9CVvi
         f5dwC0qdO/ZNmYWxlD9hoJRsbisB/+RgRNxSaxVqa+AJqUGoJnA/1fdZi7Cksd7N9v6W
         DCDWhBzpM9P+yGI4Z5boINOvFr4JOqGNZkYtx+PPpkT/pC4h36N55/tp5YDrbsxkHn3t
         dWwudWbQUsJDfP2jiBN9VK642beYmWt7wUC7/VajHaMJJDRo9QJL6hfxqXfQaFXrtjGr
         hv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727686975; x=1728291775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4koKxXkPqyf3PTpI2r9SfRgcoCHSohiw3BXHU1GCzQ=;
        b=tlYkQ6ldKnKmp4mElUXfaKa36J/c52eRJGGnvYWULTEpsRHombajvEHfobRquBqu1X
         hsNIb39fHODj42pOcUuEUOUML43l1pWiOvwQ7QGwnradg87KSJ3CEdGnLqkjuncV0H2C
         yKJw6I0DDuxR9gQOHp6JdX6LZhdDXSH5SHomWx6qrkTqrO7rwRLXB0K3CZmjyEKoig69
         7FP9PLT9hSWOQDYQrmyE2pagDmpGmK86rMQZ9wB8Ma1z75ZoPCdvyn/CuzBkROKHFkvl
         kCALdO5uFZQAUpyy7N/IliqJAyNBqLBAO6AFXE5uwjaWMyEGGAt/XA6rS+IqiJ79xn3Q
         hwYw==
X-Gm-Message-State: AOJu0Yxbmx4UnDrUqKjoyykgclAc+6noiJUzdtUCECvRpcsFEHRs4zfb
	+/Euigd3pWkSHU0cgA8A6zvVqVxlRDeQQcg52iErNXQ94TNobutG
X-Google-Smtp-Source: AGHT+IFL+iAglPG3u8m7mGWjgGJAmGd2zc1ylorISr/PE4srt89U/Ata8UYC93xpt+7lvToJTSZCCg==
X-Received: by 2002:a17:907:3fa2:b0:a8d:29b7:ecfd with SMTP id a640c23a62f3a-a93c4aab828mr1362714366b.54.1727686974524;
        Mon, 30 Sep 2024 02:02:54 -0700 (PDT)
Received: from akanner-r14.netis.cc ([62.4.55.159])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93cd958fabsm433495366b.22.2024.09.30.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:02:54 -0700 (PDT)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: aivazian.tigran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Andrew Kanner <andrew.kanner@gmail.com>,
	syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com
Subject: [PATCH] fs/bfs: fix possible NULL pointer dereference caused by empty i_op/i_fop
Date: Mon, 30 Sep 2024 11:01:54 +0200
Message-Id: <20240930090153.505-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported and reproduced the following issue:

loop0: detected capacity change from 0 to 64
overlayfs: fs on './file0' does not support file handles, \
           falling back to index=off,nfs_export=off.
BUG: kernel NULL pointer dereference, address: 0000000000000000
[...]
Comm: syz-executor169 Not tainted 6.11.0-rc5-syzkaller-00176-g20371ba12063 #0
[...]
Call Trace:
 <TASK>
 __lookup_slow+0x28c/0x3f0 fs/namei.c:1718
 lookup_slow fs/namei.c:1735 [inline]
 lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2898
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
 ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
 ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
 ovl_lookup+0xcf7/0x2a60 fs/overlayfs/namei.c:1124
 lookup_one_qstr_excl+0x11f/0x260 fs/namei.c:1633
 filename_create+0x297/0x540 fs/namei.c:3980
 do_mknodat+0x18b/0x5b0 fs/namei.c:4125
 __do_sys_mknod fs/namei.c:4171 [inline]
 __se_sys_mknod fs/namei.c:4169 [inline]
 __x64_sys_mknod+0x8c/0xa0 fs/namei.c:4169
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4b42b2839

However, the actual root cause is not related to overlayfs:
  (gdb) p lower.dentry->d_inode->i_op
  $6 = (const struct inode_operations *) 0xffffffff8242fcc0 <empty_iops>
  (gdb) p lower.dentry->d_inode->i_op->lookup
  $7 = (struct dentry *(*) \
       (struct inode *, struct dentry *, unsigned int)) 0x0

The inode, which is passed to ovl_lookup(), has an empty i_op,
so the following __lookup_slow() hit NULL doing it's job:
  old = inode->i_op->lookup(inode, dentry, flags);

bfs_fill_super()->bfs_iget() are skipping i_op/i_fop initialization
if vnode type is not BFS_VDIR or BFS_VREG (e.g. corrupted fs).
Adding extra error handling fixes the issue and syzkaller repro
doesn't trigger anything bad anymore.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000003d5bc30617238b6d@google.com/T/
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
 fs/bfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index db81570c9637..e590b231ad20 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -70,6 +70,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &bfs_file_inops;
 		inode->i_fop = &bfs_file_operations;
 		inode->i_mapping->a_ops = &bfs_aops;
+	} else {
+		pr_err("Bad i_vtype for inode %s:%08lx\n", inode->i_sb->s_id, ino);
+		brelse(bh);
+		goto error;
 	}
 
 	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
-- 
2.39.3


