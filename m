Return-Path: <linux-kernel+bounces-203646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE968FDE99
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62B428763F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EED82D98;
	Thu,  6 Jun 2024 06:15:19 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BD74424
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654519; cv=none; b=te3yWiJF2g8azNBfSJmx/hKNgbwdg7kGtEv6TOGw5q4HN0/pwe366TB3FG9HCLHkceACOuUEqOf0Bp72oosnZ8JZfJLs8E0g2VUfP/PFgRX/mSW+gu8dOotdqt5uERL+zNhjBUdfIN5uwQ5hV5P1lhA0K6hWiI0mpafH+iewBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654519; c=relaxed/simple;
	bh=IlSYBAMTeY3PIZNBpX/Fq2Bg2SS2LnFd574tJz2rVR4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZPzPQElh7edxksjpDeDfDsJ7Bosj8eCEHRv+/B0p6cOc7mSYU7p9tA9xk44x84cXjaI1zijcJf5jkSNglwbFTSDp8wzKnWFA8iDh+gaC5gK7S5Y3X9E6/LQqCiBnEJNM+PTonQlBrr8YpLbKPizmnIlqiCGv4arbTROAh/OmlMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374b390610bso6291485ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717654516; x=1718259316;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4pcIAiWNjlXdi99BU7K5FJiXH4rBJFbHcL9/QfFe0w=;
        b=STiN+xN6sHI8WeO0DwXVuHv4xNPqWOOtVI9BFGXVFNSdkQPoK4UfRfjsMwmYmYRbDw
         tkAKrABXKtFFaYEnAq9T70P2zbpIjb7idfGHWt/+RhlUYITJBvwEKm4ZIW6Fni/T55El
         52mYz3KcpUrzHH1mXkzN31ClGQKE2PZcXlq3Ayk5xKZmQ1pKPfI43aiAqqbE+UsHmAp7
         whh2u3BUUAb9nAREXAoxHV/839PLKd7cCHoCdRK3mxMXdgNt8DG6OVmkoN6MJC0Lixj4
         qn9mAzGrlCeRTt5eJSaBp77gkXYILShm3dHdCi86WxdZ6RHYQcO+AlvOHOq45TR1ZwxU
         lczQ==
X-Gm-Message-State: AOJu0Yy40zJts1eWH+svG6J/D7GW5kcJjpdCRB/MU4rMpM1rx+eT98gc
	1HVSrcuyH3OABwkzlzker7Q8mNh86MGt1pASO1062/el67E/HkFEPYSjtxwjXBL50sLr31oUFFc
	PU8nH5nZi1GyBdrm6StyR0ofkfe0FKB/HoTo6nxZH72+mhcHY5s4A/zw=
X-Google-Smtp-Source: AGHT+IGJENhtcCJOCgj6fBFJKrXB+WDFizTxJqYTr4gXKFUL+G8nyHS4nA5ENtNjhZx8AjNGRWp23vN9n6shr0iPmBnkJzWer+T3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1544:b0:374:70ae:e876 with SMTP id
 e9e14a558f8ab-374b1ee7ee7mr2520015ab.1.1717654516752; Wed, 05 Jun 2024
 23:15:16 -0700 (PDT)
Date: Wed, 05 Jun 2024 23:15:16 -0700
In-Reply-To: <0000000000000fe556061725a7be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005176b3061a329b89@google.com>
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


