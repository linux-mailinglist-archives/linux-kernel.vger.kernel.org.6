Return-Path: <linux-kernel+bounces-322530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAA0972A53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8001C23F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E8117BEAE;
	Tue, 10 Sep 2024 07:14:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158E13A242
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952474; cv=none; b=BvB+S1YkQt1lof+xjDExxdOkw0eEYpZOeRNu2GZ0IJXtVIjtFwhx6va7CpIm/jtB+zl9DR9rfci8g0oEf55FH5Jicjo1gUkN/poFA1jcyZhB9eWCY5Fs7vY6wvOU4asjBHDT4Cd3x11njAVp+OByhUeJqs9qJqLgQq0tNDckKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952474; c=relaxed/simple;
	bh=h2wxjCymlnRMLxsDvaEZESRG2a29uegeljS+qR3pG8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qZ75FIjO5vBcR1UCsDTifwPBQcmjvhulbzPXGoa3/huyWoZYajbaK+SGzSADw4Yw7/4DdUr9ZUJ0RkFH65xiaY7/sVZB2QVu4hoLIdeHtHTF9tJJkYmNVKDwkXLINh81/vOXrAjO1+kqsO7jkfi9F4g5DkSOTyMV8AubwDLIoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a3ad86c74so1171586139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952471; x=1726557271;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+jf3KxE8qK4ehGhyYzrdxQNBV75iTvSyPk5AN1GjWg=;
        b=ut8ZS7Tf6E1XndbnWpsOKQ9RRzIb6PizVs6Tp/TFMWW3x7QyF3dgKUUSq56aa4UzRp
         8oHER9WGddJjGQff8ucBqYXSOA351UVTvJa8/6XuQJrlDriXO5+04OVNYI+i2qN6Wtuj
         jcGLbxIpADKRw8GdQM7J9Et16ZFEJr5iku0kmcB65tVUrZJfG4pYEX9dkFeSU0EakLFp
         Nea4YulefgpkgTA67k6Qr2MuNwecwziXQ4BfCP+QMDihXr8OH3cqbN1O6UQvyHWNMKEe
         EMrmkqrJqLx6/PNwkiLnxsqug+Lx+wwgY3aIKFw9h8+IdvwCrMbKMWK7Ga+N6sbK5KeE
         u4Pw==
X-Gm-Message-State: AOJu0YxrGrj6iC2fCJjtUYHkBwU9gJxv2uysqLIzDknXPB2L/Xmzmzrk
	p4A5h2Hw693WZLesYKtzQGBjM9THIaNsejWu8uYaCuo7X88yT9U1BNtUyWy0OSRU3to5cJtns7C
	W4ceJ1RpmBhDn/8ow7r8jHndS+01KwQ9uXvbdhwUgnspoGJub6NPo49s=
X-Google-Smtp-Source: AGHT+IGfsv1nY9y+wMRQVfyUob6soaXjTGG6+oWMexZTdJzohOJGOyRd3jzZZG9TFaKEzgx/JuMShxd0XZjut+jG4M0K5Ymr/L3D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f92:b0:82c:d843:edcc with SMTP id
 ca18e2360f4ac-82cd843ef9amr835462139f.11.1725952470709; Tue, 10 Sep 2024
 00:14:30 -0700 (PDT)
Date: Tue, 10 Sep 2024 00:14:30 -0700
In-Reply-To: <000000000000b3424a062114aaa3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea89ee0621be9fc5@google.com>
Subject: Re: [syzbot] possible fix (linux-ntfs3)
From: syzbot <syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix (linux-ntfs3)
Author: almaz.alexandrovich@paragon-software.com

Not sure about all indexes on volume must have the same index_block_size.

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 9089c58a005c..63fbb8ba6e1b 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -892,7 +892,9 @@ int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
 	indx->idx2vbn_bits = __ffs(root->index_block_clst);
 
 	t32 = le32_to_cpu(root->index_block_size);
-	indx->index_bits = blksize_bits(t32);
+	if (t32 != sbi->index_size)
+		goto out;
+	indx->index_bits = sbi->index_bits;
 
 	/* Check index record size. */
 	if (t32 < sbi->cluster_size) {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 3dd6215316e4..73d72fa8ab65 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -222,8 +222,9 @@ struct ntfs_sb_info {
 	u32 record_size;
 	u32 index_size;
 
-	u8 cluster_bits;
-	u8 record_bits;
+	u8 cluster_bits; // log2(cluster_size)
+	u8 record_bits; // log2(record_size)
+	u8 index_bits; // log2(index_size)
 
 	u64 maxbytes; // Maximum size for normal files.
 	u64 maxbytes_sparse; // Maximum size for sparse file.
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..f96641b80869 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -993,6 +993,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 			 sbi->index_size);
 		goto out;
 	}
+	sbi->index_bits = blksize_bits(sbi->index_size);
 
 	sbi->volume.size = sectors * boot_sector_size;
 

