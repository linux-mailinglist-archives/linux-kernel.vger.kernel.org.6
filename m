Return-Path: <linux-kernel+bounces-341990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096C988957
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05AB1C22A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C74B1C1747;
	Fri, 27 Sep 2024 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="YKC+aHS8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084F17ADF0
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455904; cv=none; b=Mg4p+lyot5vaV1DT6t2wlIvziZ6ZpTC4Px4YPJ90spJU5zPQrg+5zlpjzzcgXutq6JS+HntPCnbTvNCocrY7rIczQxNuwYeAJr1ehVK6NUXZVAUQBft7yXyVKgPz/DZ0UXlFqEblbsTMXJ9UopIo9bJsODxb2PbUZYV3q1Dqo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455904; c=relaxed/simple;
	bh=w1hDeaaqePkObd4w74ICxIIrNF2olAqnyLHEkqzZJjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lnnASOjlP3u67a715oJfV7E+TGNOMPqNdfgf4Wog1FgpnxqgvYuwGkdIByVDjqI+6aUdyaql1PW0Vxes/LVbZlGhOMLNUMEoM7aqgTj8W4cNo/8Yo+4khPGvfeLW0Y9T6Hx1PWEvrm0YK1kZa8zlGknWXSIjmFKaXLEYWbJlTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=YKC+aHS8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b0722f221so1841627b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1727455902; x=1728060702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEYw1gYmwA8Qrj5YShUHffTTF3dzo6EdcZl8qQYjRd4=;
        b=YKC+aHS8iqgPtd9KfGe7jBZdhN9K01rPv4gFMwMYdX+dnFUWctPZOO4kXAmbSTei3T
         erqG3zFX3oiHlTZoW9Tmd/5lDV4khto3iKSVluo8xWhKOmVhR9liLtiG8X/D36vs+qlu
         SkvK0zJ++1w1cwNwqif2/Zo/fDHlNt3Td/qUe40Sy0dBN2nIPlcDx2zu6RyDDQWBVY+9
         hiZOIh8EobziIoovz0x/WoOOjTh6r0GhmtvYKVuT8uPMcm56eosL6uOXvnlLbFnfzXhs
         YCQQlo75JXGI7YzsDUjO+tKCfDucBVwdWmQn0H/9FahSXixFKK60CfSLR/ZSkLies8Ad
         bnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455902; x=1728060702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEYw1gYmwA8Qrj5YShUHffTTF3dzo6EdcZl8qQYjRd4=;
        b=o/durInT/QtgWBLY/jY3FTzT4BE86Ocv+bvxRJDPGzUOp669nxw2YoW/UgtPjDlHqy
         PInDbcCgzf6IwTcHWY1Uv1qaz7RPLqIYI1ywqvKSvY4fwY0vL8kL43ME3FoD8rdzEVmE
         yA1XqMkaVLnBfCk2g/ERRiSLmbdyfeWSL4eJx+IQrgUrpcDWa1h3daG7aZJfDgogHkPO
         IiiZCDQ+uUuGDw0drOmkL2NItMvfBU5/0ZzjZaJ/LcukPiZst828NJIM61fKcwiiNXOo
         fI9+zm63YEoMEDYxNlj+W6FcElZPtFc8nYa4LOKxjfNTLW1deBlzmhD5HZLwGb9ohl9D
         UyRg==
X-Forwarded-Encrypted: i=1; AJvYcCVucTwA8pWCGKr2HpYX4ZfiikZ4Ni+KZnQMG7xmXWTz9CkFvkIPpu+rkVfhB3xQ5u4TZiPGerZnrIV5r2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+BhQlTcptO9MD4g8rXEM8ujEjug1sJSlJMHtwI7zV/es78un
	0n6/Ss7yaWyTUDmuYtjxDfuGayq5vKCdxxhI+REDAMRJASIoVvYqFeYFFjAVIb4=
X-Google-Smtp-Source: AGHT+IFhIGmE5LlhA55s0kcrgULqLsbgUkU+TsikBbl64f/xmQdYg/RN8UoCzM3MFKkvAI7Dpi4j8A==
X-Received: by 2002:a05:6a00:3d14:b0:717:8ece:2f8b with SMTP id d2e1a72fcca58-71b26057f9emr6125090b3a.17.1727455902352;
        Fri, 27 Sep 2024 09:51:42 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515da6sm1800938b3a.122.2024.09.27.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 09:51:42 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] ext4: WARNING: locking bug in ext4_ioctl
Date: Fri, 27 Sep 2024 16:51:32 +0000
Message-Id: <20240927165132.17289-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the locking bug with the bisection found by syzbot.

Link to the syzbot bug report:
https://syzkaller.appspot.com/bug?extid=a3c8e9ac9f9d77240afd

Reported-by: syzbot+a3c8e9ac9f9d77240afd@syzkaller.appspotmail.com
Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
First attempt at patching this issue. Verified the bug exists, and that
this patch fixes it, and EXT4 KUnit tests pass. Though I am not sure if
the patch should be higher up the stack.

Open to questions or any suggestions for improvements.

#syz test

 fs/ext4/xattr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index e0e1956dcdd3..2b30b9571fd8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -124,8 +124,12 @@ void ext4_xattr_inode_set_class(struct inode *ea_inode)
 	struct ext4_inode_info *ei = EXT4_I(ea_inode);
 
 	lockdep_set_subclass(&ea_inode->i_rwsem, 1);
-	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */
-	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
+
+	if (ei->i_flags & EXT4_EA_INODE_FL) {
+		lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
+	} else {
+		lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_NORMAL);
+	}
 }
 #endif
 
-- 
2.34.1


