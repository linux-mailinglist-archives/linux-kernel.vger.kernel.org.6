Return-Path: <linux-kernel+bounces-272006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6F69455D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE78DB22148
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE21DDC5;
	Fri,  2 Aug 2024 01:02:59 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CD8F70
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560579; cv=none; b=C/zR0V9K16BAPjjfPIuz7/ALXwo1i9VNoud6D9x7GdauUIk5TxVFvvoLsgcWfoOnSbO8GWjhpsdC75BVwctSXZFsxcd9+jOhYbdiFx9WQnPMik/L0zMsGoBmoSTUttkH29sSoTgtdXbVHc7Mq7u4nXh4SXoeBXhY+/nhCJ03dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560579; c=relaxed/simple;
	bh=nJT4/AO/Riu8PGzuBfVJef3YG629nPMpC47LNqj98bw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q6YOAwg0hP/q166tCoh3rfw37aKkILqvuTJsOVcGzM+yXO9qvtKhgLZ54kyC6DAmhZXnx7KqSHzpm+NqZ97qeeFufyZyo6TMdSp0qCtSVosmuem/b6EcWshfhvhyOeugmUGXDGs/7AmfmA+iIjzNLmtPCzvSEluVsngOxxbLlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f897b8b56so318312139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560577; x=1723165377;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owsp9VXX7ARDyJqaO4lMYNokANfxMYwQvhR96uETJRc=;
        b=Xb/E/d24AA7IP9ynUTu5EgPBdfgo1Qxp90sb4T0r0BoBD7Ln/IntpLw5OR53XQOQrk
         xcY3JiJ0tTtewEioj/0C6yV5rllMe1XDXBz3DfhiFb5iRnH6kZwNtYrln+x5Q+7ARd0D
         BV0Y6R5AAcsfpL4Fi4sdFdDAJoosu2NsvLQxAxj6RLvsNU3Yl9b4vvq4W8/rB5kT8ea0
         ricOv/jXli1r+Utu79VP2t8Kh7oJEyhrN9VisHouSrakyNx7KllhhwrKhNeXFllwsKGR
         quUA3K0RMSzpOYw8p0JUlFQDpml+Z7bWxfre2CXmqBBaCtLSYd4GdRbX+ucJymh5t7yk
         uViw==
X-Gm-Message-State: AOJu0YzJ8h+djTMHTaOxfeXZHKMgvOZYm7s7UbXcoAaz38cEWNpJDvkz
	9IOWaAHcGzBFXzapb1ClpGyUzsYahMOkdgTA1KwyfRDE6u+JEHNQQL5pxEbOVVKqHDxLqWIs7G2
	GeWJdYV2s/gi4tFWqgD8b0Acdv+mbGFec3XTz6yHhjokAeEGv4dTBWDM=
X-Google-Smtp-Source: AGHT+IEpoBC7mm0wc/gJr59FgSAdUKLzpKCEZLGH6hk4km5NGOpD2CMV7pmtMbMwt8Cn+J3euXey2kQT2ESWgrLm+LKT7uYN3Bfy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc8:b0:805:e4ad:66d6 with SMTP id
 ca18e2360f4ac-81fd48345a1mr7481639f.0.1722560576960; Thu, 01 Aug 2024
 18:02:56 -0700 (PDT)
Date: Thu, 01 Aug 2024 18:02:56 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b4ac4061ea8e39c@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

why folio not inited?

#syz test: upstream 2f8c4f506285

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 16bd693d0b3a..3c667939f1d7 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -394,6 +394,11 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		return -EINVAL;
 	}
 
+	if ((int)inode->i_size < 0) {
+		ERROR("Wrong i_size %d!\n", inode->i_size);
+		return -EINVAL;
+	}
+
 	if (xattr_id != SQUASHFS_INVALID_XATTR && msblk->xattr_id_table) {
 		err = squashfs_xattr_lookup(sb, xattr_id,
 					&squashfs_i(inode)->xattr_count,

