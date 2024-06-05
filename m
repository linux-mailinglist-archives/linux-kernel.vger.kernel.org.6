Return-Path: <linux-kernel+bounces-203165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917858FD764
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8271C23D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7F15E5DD;
	Wed,  5 Jun 2024 20:17:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F015E5B6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618646; cv=none; b=f+XPhPGXTSiS8UsZTd7RYW74ZPMjIYYmtotOJx06pvShrCGx1FGm0ywRVnmmGME67CV1/fQleF+CxBXBiR1RE1JBcb9e+8EHkGXcS4UJbRCsKbo/lNaGFTEUb0JrlG2/A99/N+YjybOGeWbS2jxfAQ5phP7kLsIOgMOV3z0/G1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618646; c=relaxed/simple;
	bh=IlSYBAMTeY3PIZNBpX/Fq2Bg2SS2LnFd574tJz2rVR4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pjk79cdrv55huQzoB8Ks4LKyCpjHc+G2MmDG5fVDj8jKEpl3h5o1VVJi+0dyt7TF/oKk9UrwYtuEAhrWuwbFACh8A1Y1oaAaOmU4fVXO1FAzV41O9KPjoVfsQhROxdSSiRATgAAz4+xtQ6m07iZaxHMF/PVYBeIQEl6EyVVJFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-374b033db7dso1868805ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717618644; x=1718223444;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4pcIAiWNjlXdi99BU7K5FJiXH4rBJFbHcL9/QfFe0w=;
        b=M0JAXVCtoQU/qzVRCb/8od2CB2gC2mgrMWIjERfd9okNdaw3pc0dG7VfYfwoZKUBqG
         w26f3Lhk/UHNbigjnN74hWUNhfI/QNh0vJqBlu9nQvcj4qZUURUArrjQPAfhC7e84G1n
         WOxhlVWMG45Aj4taN5R0ohK3q77N/6XbYRfBX0sheNg5G/511QUJVKR4E/D7RGKP+No9
         U5oiZiCdxAyGTnkaQfcmLfLt2od/ywcO3TlWfoh2n+joZtcIF6sAwhQO0zTqI9akzTAD
         vmo7vbnirLdGflkPy4LZjgvLulbMk28tlFdvOI4wXJpQ0IdyDVYwqNf1m1tQcZAaFFqc
         G9hg==
X-Gm-Message-State: AOJu0YzNPrcRKTGHTvyaL18ZQCIo36dej3ZTE+KpaT/LHcyFuqpoo1PL
	qg+aI2ggdv2+j12sdlZXlCh35hlPLpNh9eUsdmjtcvBVtOLpUTZNlIB3CqNPgbywciAoe3AaS8i
	b6XI13E9pUUr3AFw3q4gf8kkaPJxBfaNJ4aF0IGzV/HiFdZPkqXGCYtE=
X-Google-Smtp-Source: AGHT+IFGwBoBvAMzjkGIPaarQlAnODAMnwOFPczzfR2ayh7CfNyDy0274s60mjlxeootkMFbyPnJ8s+TjGZ7Bs2rLeQFnodL6LhX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160e:b0:373:fed2:d934 with SMTP id
 e9e14a558f8ab-374b1ee192amr2046925ab.1.1717618644034; Wed, 05 Jun 2024
 13:17:24 -0700 (PDT)
Date: Wed, 05 Jun 2024 13:17:24 -0700
In-Reply-To: <0000000000000fe556061725a7be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000233b0b061a2a4102@google.com>
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


