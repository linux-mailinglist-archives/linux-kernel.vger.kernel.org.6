Return-Path: <linux-kernel+bounces-273294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DE946700
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F27B2178D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E66D2FA;
	Sat,  3 Aug 2024 03:13:54 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151363D0
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722654834; cv=none; b=g9f6TzMz6MQz0Gs13ZsobsdjS0NI6hJMOwlj1SCd58qHd3P1WFqZjIpaXhejik1GsFqZP/Su1Cx94yBEZd7L7JcQj5UfWzpZAtTQpqibzMT0tG7TwZJPgd/Ppb4TbqZvf0yP45qZuLk5zVPTHd/rtIq5QxYf0AFpacljEZLhINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722654834; c=relaxed/simple;
	bh=qvaz3WQsZTQVNJLkzMj5q7VIkhCPL8y6vsiqdzJQkqo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ATxIuSYNHt2CjOOPEW4ejSxC2RjbwxmUzn3p/ZQYwajHJ3VVXu0hxygwj6+kbyZEleH19IonIkcw9o8stsNXUeCxzNQ1pMyId5nKKvu+aubMebA9g+tYITcrhQG/lurDC3c4Asm1Ub0p9oRS+lHf4LvZ7kD9WIdpEyRBU+EnA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f89e62706so1272074639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 20:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722654832; x=1723259632;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzga0UeTEhHoKq5Bx1pfJLq0lCTSeaCYBsJ/LauSfFE=;
        b=okO5Jkq48YDRnm2Kp8627BsJPw+dJxu/RYLuo6uTAlIhUvRpxQd0hoWv7QZ7iNo6CI
         6PJQYgpMvgOHxOmx8uWYySdNcRPlWQqGML1Elek43TxVkUKab5Q2l+9MDZbdM+cCCVib
         LDOgAJwEv0cbeLiafNZFG3dM7iCWDYQtsyCAocGINCSZ0vUdbWM/cRuvDx3LcUV8506F
         DamI9ctJF2ggppPB+YWfe65jB4Fx9XH4RWOMOTj6oc1v1LlR+b7md7ibYmMetDC5OsEt
         O3XWQJGqyqETtDPHlKv+RV7fxBUIaUJeCvFMoU0CC7erkBwaAzebyxhsANVql2vwj+jt
         HJnA==
X-Gm-Message-State: AOJu0YxgYEyJVvdeTqbYlr11eo+SLZT79I0ZfSRNluFgpTOq5j8zWocI
	K4atf3afukSiiLrzKhLm4z0UHBMckgaHihqeqc/kO9hg4KjBt6kx3q9gJ6tEZ+3RCcB4YgjtLrz
	53bypqoN9Oszea0NJVh3l04t0ugPngbCumkys3e4ikuPYgh8hb6tbJow=
X-Google-Smtp-Source: AGHT+IH2kTVrtDQPlFFlp5DDBoH80US6AFVEXVYrwFvYAdmK1fIELqFnIA9YHBaxY8Dmw0iLogaRHidrHjQKlPzwQmpMOITNirJN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:710e:b0:4c2:8a0c:380d with SMTP id
 8926c6da1cb9f-4c8d5666409mr357669173.3.1722654831784; Fri, 02 Aug 2024
 20:13:51 -0700 (PDT)
Date: Fri, 02 Aug 2024 20:13:51 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051c7bf061ebed551@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

when i_size in read_inode, check it

#syz test: upstream 2f8c4f506285

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 16bd693d0b3a..8f5d89dc334b 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -273,21 +273,28 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 	case SQUASHFS_SYMLINK_TYPE:
 	case SQUASHFS_LSYMLINK_TYPE: {
 		struct squashfs_symlink_inode *sqsh_ino = &squashfs_ino.symlink;
+		loff_t symlink_size;
 
 		err = squashfs_read_metadata(sb, sqsh_ino, &block, &offset,
 				sizeof(*sqsh_ino));
 		if (err < 0)
 			goto failed_read;
 
+		symlink_size = le32_to_cpu(sqsh_ino->symlink_size);
+		if ((int)symlink_size < 0 || symlink_size > PAGE_SIZE) {
+			ERROR("Corrupted symlink, size [%lld]\n", symlink_size);
+			return -EINVAL;
+		}
+
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
-		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
+		inode->i_size = symlink_size;
 		inode->i_op = &squashfs_symlink_inode_ops;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &squashfs_symlink_aops;
 		inode->i_mode |= S_IFLNK;
 		squashfs_i(inode)->start = block;
 		squashfs_i(inode)->offset = offset;
-
+		
 		if (type == SQUASHFS_LSYMLINK_TYPE) {
 			__le32 xattr;
 
-- 
2.43.0


