Return-Path: <linux-kernel+bounces-311697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A7968C54
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73434B21867
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72DE1A265F;
	Mon,  2 Sep 2024 16:43:46 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7138DC0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295426; cv=none; b=bVg5JF4FGxuLWjpV0iu3zQUpxIeonPMYD70iHSktfBg8gMfqVErTQ0xOZuGo7V2Oy2m0jYOxPz965hZHGv1qCdU0LfNIPYhFLpU9Mccmx7T5mz/J4LGrRp9U+LlLgccms0vZ4a7BvJntoTW136bi5ty1q3ds56yTjPXJZ5xlKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295426; c=relaxed/simple;
	bh=4r7o9M00kRPeonQRa/m4I8+TrRmGG0aJOWxxixQw5DE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eFhyHmk60UAwNaDlHbMgcjFGnzFYATrtJTAYI9H+yO07HBKK8XRfYCau5DiBTb1k8YyfUbHlUKAa8wtUgqlnc5nlkF79V8VMXXRswLLxRGaD8+xfOR/NgzssgHh3VvUt/8biEnsm3nd7lCWBHZk3bJy9c1ifUastDo2YQLeNRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a246b5043so432851539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 09:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725295424; x=1725900224;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxtfzznAG69Y8webfTSrQFyiBIjEmTyyOzL2cb0NFkE=;
        b=L5ChOFiag/3rSeVjM+uhrQbZbiA7YXB48sozmQpHT3bN3ntw7s5difIfBMIn6zzx2X
         IFPVu3+KizAnj9WvAVldxTv937Ksygt2jnJccHDRIL+7fnH0QCN/ATMM69v1JALS0y0o
         DmKMCSra5bKgkibBQvTT8p7wj0FpX4renUGDD+3U8KsxEisf+ZQb7WgpRFcRkCl1oaVc
         tNu0taG8F8+k9KZSe/MZBgQCBlw3WaS5f7ic34D6Ce82kfPNHinnFjX4e0JDts+fic7l
         5dYXZiDqipLDnp/pEszECMUTEmNhjHLGQblXE+kD0iAeUpSb2g6OXvArj+0dZS+41ehn
         FCDw==
X-Gm-Message-State: AOJu0YwtPik3NQ3o5CKTyiEA3W2culP2wDCiAV66bytwq0fkL01CAjt1
	bFpBvln8yECdqcGcwA9RFSB1ifGmU4zpBNL0O5O+emFfrqfxXucDbOyTWkKJoDJlnyYqpOPmbmt
	Dnq71FPMaDdrzZzNT00f2VfNeadw5Y6m3niQp9WcQbeWaYs9UkCMTDAE=
X-Google-Smtp-Source: AGHT+IHVQTR5suVTvuWM3pj71SxMOsNBfbz+Cmr0+5uLrwcasKpkIy0lIE1y16YLOaEMzuoCJfFSdRVFuDsiG+f8SgGPoqDXKImH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:81b:d4:3802 with SMTP id
 ca18e2360f4ac-82a2611839amr92599939f.0.1725295424196; Mon, 02 Sep 2024
 09:43:44 -0700 (PDT)
Date: Mon, 02 Sep 2024 09:43:44 -0700
In-Reply-To: <000000000000adea7f062112ab4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e46155062125a437@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in ntfs_d_hash
From: syzbot <syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: BUG: sleeping function called from invalid context in ntfs_d_hash
Author: djahchankoike@gmail.com

#syz test

d_hash is done while under "rcu-walk" and should not sleep,
__get_name() allocates using GFP_KERNEL, having the possibility
to sleep when under memory pressure. Change the allocation to
GFP_NOWAIT.

Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/ntfs3/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f16d318c4372..d3d93651baa5 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -231,6 +231,7 @@ static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
 /*
  * ntfs_rename - inode_operations::rename
  */
+
 static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, struct inode *new_dir,
 		       struct dentry *new_dentry, u32 flags)
@@ -395,7 +396,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	/*
 	 * Try slow way with current upcase table
 	 */
-	uni = __getname();
+	uni = kmem_cache_alloc(names_cachep, GFP_NOWAIT);
 	if (!uni)
 		return -ENOMEM;
 
@@ -417,7 +418,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	err = 0;
 
 out:
-	__putname(uni);
+	kmem_cache_free(names_cachep, uni);
 	return err;
 }
 
-- 
2.43.0


