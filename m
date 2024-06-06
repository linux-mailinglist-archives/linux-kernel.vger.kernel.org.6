Return-Path: <linux-kernel+bounces-203771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD58FE04A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CFFB24A13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA413BC02;
	Thu,  6 Jun 2024 07:57:39 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDA13A3EF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660659; cv=none; b=o6730OSn195rnrLI1U/FzLd0ru0pPE4He8FeNeBlkDdfeyCABCIrprGrF8J6BETB3sogFOX+wkYRBECV+Lr593TNDEpNGSEEqNXSzZdIDiZi4vdFAdrtx0j0QT6tBGRpIFb5JYXsnD/Dtb2GDQhK2dqJIOZYayfjsN1RSXFeUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660659; c=relaxed/simple;
	bh=IlSYBAMTeY3PIZNBpX/Fq2Bg2SS2LnFd574tJz2rVR4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rAyUwwb2uS1qnGiE/Go0ZaB1LcVrrtBoHhnXw4nTvok1n9uaIIf0cNWmUwJRNIVc5dEOKxlChqblftPYYUfd5T2obTjCNRGZYcrDNviZ6qd8jqd2Mxa/eMSUahk4WNPZ1rrEk4W1FXaHJwVPsOqysr3cULS6W4eN+wyO1CQbnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e7707356so78047639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 00:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717660657; x=1718265457;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4pcIAiWNjlXdi99BU7K5FJiXH4rBJFbHcL9/QfFe0w=;
        b=r8LYVpU2Z1xeJrXLqtZDax8KE0AjptDBFGpobET3FcCQ1mUP7V3ttJHUaPE9LlBxwd
         PM2T3xoxpvVqW5VYaj7yzkZf0mNMfW/bdUcG/j/cm995VMc9lIV4MJ+M9WJs7RQUSGob
         UmX7aeaIrUJlMCfztAAOc3lWP/eUTSFxENWMBhOWoOwtwyD11GK/2LAez7KepBZH4KAl
         NKr3v+AyoavwgYBtOJCqOaj+rl8Go+9xzb56/LzdSs1ThRIiItSDI+RZnV9ShYNJI5Qf
         /C6WGHqMQwJxWTmrVIX9SDxtKrAIC5Sod4k6M7UeZd35SYxtDdqDX8EFjmk8DEeIiUBh
         fWDw==
X-Gm-Message-State: AOJu0Yy1XgM4G8PtqN7zbSojX8kuP4u76JRsNdjvG1pPj/hrudEhyy7m
	NQ/xKeAdJxN/lakBWqGIZRrYOKg5xij4MmkG/UdNSB3U07+exd6jj09G2qk+qMSzIUXoeI4iFQQ
	kwwonOrQKni+zkiCe1yzYVBYuu+98uShL883ZB7zgcLxSbBDftio7cGM=
X-Google-Smtp-Source: AGHT+IEtTXFnz4DmNIOJLZXiRDGS9g9WOkIJx9oY/mTH6sH52SzYuFsJ8nDUQgKW3zSfnc0mrI0yZWJmaNzLAJF38gscmmeP+Rk+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841c:b0:4b3:292b:278e with SMTP id
 8926c6da1cb9f-4b63a76852emr273197173.1.1717660656832; Thu, 06 Jun 2024
 00:57:36 -0700 (PDT)
Date: Thu, 06 Jun 2024 00:57:36 -0700
In-Reply-To: <0000000000000fe556061725a7be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ba5d5061a340971@google.com>
Subject: Re: [syzbot] ff/ext4: Prevent crypto operation on unaligned blocks
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: ff/ext4: Prevent crypto operation on unaligned blocks
Author: norkam41@gmail.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it 45db3ab70092637967967bfd8e6144017638563c

syzbot is reporting an uninitialized value in aes_encrypt(). The block
cipher expects the bytes to encrypt or decrypt to be a multiple of the
cipher's block size. However, when ext4_write_begin() is called and new
folios are allocated and they might not be aligned to the required block
size.

To ensure that padding bytes are automatically initialized in
the ext4_write_begin, this patch adds __GFP_ZERO to the existing GFP
masks. This adjustment is applied only when the CONFIG_FS_ENCRYPTION
is defined.

Closes: https://syzkaller.appspot.com/bug?extid=3Daeb14e2539ffb6d21130
Signed-off-by: Norbert Kami=C5=84ski <norkam41@gmail.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4bae9ccf5fe0..1a8e47221e72 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1156,6 +1156,9 @@ static int ext4_write_begin(struct file *file, struct=
 address_space *mapping,
 	 * the folio (if needed) without using GFP_NOFS.
 	 */
 retry_grab:
+#ifdef CONFIG_FS_ENCRYPTION
+	mapping_set_gfp_mask(mapping, mapping_gfp_mask(mapping) | __GFP_ZERO);
+#endif
 	folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 					mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
@@ -2882,6 +2885,9 @@ static int ext4_da_write_begin(struct file *file, str=
uct address_space *mapping,
 	}
=20
 retry:
+#ifdef CONFIG_FS_ENCRYPTION
+	mapping_set_gfp_mask(mapping, mapping_gfp_mask(mapping) | __GFP_ZERO);
+#endif
 	folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
--=20
2.34.1


