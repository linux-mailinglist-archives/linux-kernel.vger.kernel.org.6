Return-Path: <linux-kernel+bounces-311341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863529687C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B66A1F20C36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422319C554;
	Mon,  2 Sep 2024 12:44:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F918595A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281050; cv=none; b=i8k2/nOcvBIQIVCB42BBPWH0Xv8PUgfzZWA14jXaixdPnVkYYQgw8YIPVT0YAOPJG5ExNhYRp7OyOWJzpLQbzoR/QuTFut/cvXchCQAAn7zW90lhdYjI2p4biN/OeXt7j0gSV1r5omlf0SrJXGYEr/o0iiI/ykUWqj4bnWIbUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281050; c=relaxed/simple;
	bh=L9YjJdt5qVTpKb9hlKOMIDsT11P8UqN48zp8cgv5cvo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dcdmcfJohg1s0ZpWnyk154MFwCBxw69v8GkzRMdZqEE2BoA554+d1I81v5gGM/foUSELrFFKK7MmIvDJv5peHqZ8ka/Ld6ap7NxdZy7Ln1u7n1V1ShJnnacSdtcal97x/qA7mE8dC0nO65b4fjaTUSHh4L/7Raq1XUnV+1KEd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d465cd6ccso47210955ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281047; x=1725885847;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUjA9cwVlwiFdbkB5vcCY21opGMvCeBFa3O1hEtR/6I=;
        b=dDV6LCRPPUBm4BuKWHbHsMTLWVmoWOMo/aYTY6rzBR7fxZrDpwyCWwvwjjSG0xQFoP
         4alAuIFRvNj9/EAeyEGIzKeFjEfXgjJ4bku99uj928Uj+3Ja8dTSyTp2gBDs23kOeY+h
         yJ+NcAbW3ziDCfyCXDT1y/qzX+g4u9d672XkK5IU0XChZIV7H1av6QFNNb0vIUpbrOYt
         Y2VNkfUrFV/eEJdvM9ZFiP9O9dp1S2R2LDVUm5WIViSdqikDBD+HtUZtCVekLYN4V1Pb
         jaLnAziA/QMC6qEf3jfjhDJu27anaDRp57iflwZneg46CIWjESIkl6AkmBj6b7hPYeZU
         ZbLw==
X-Gm-Message-State: AOJu0YxWJc7FbPXRVM2V8oOTtWoNFoLF+2dWZVUV6cFUIw42QZ9OYxcA
	DIlxjNbSJkFyxuhsHJK7jQydnwRpiR2PGnt2gNibuRXIj5/IhJz/hBSz9V+QGW71HZjEw6LGeLN
	4ZAA5Lu4w80sw65JsWYXSgW5y7zKRuJGmGVv0kuUP6yM5PL9GriJVYzs=
X-Google-Smtp-Source: AGHT+IEeSO75reI9+XG6FmKTuAudSWK6vCVeqPMlIqteFW2EDKVJibn7EWH0pLFLUjkcpC1UjkABjftdYPkTHO+YF+NW7vhq3S0J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:398:d1fe:9868 with SMTP id
 e9e14a558f8ab-39f4108b271mr7269995ab.4.1725281047719; Mon, 02 Sep 2024
 05:44:07 -0700 (PDT)
Date: Mon, 02 Sep 2024 05:44:07 -0700
In-Reply-To: <000000000000acfa76061fcca330@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcbfb30621224b65@google.com>
Subject: Re: [syzbot] possible fix 2 (linux-ntfs3)
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix 2 (linux-ntfs3)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..c08bbacc0030 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -125,8 +125,9 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 
 		if (de) {
 			spin_lock(&de->d_lock);
-			snprintf(name, sizeof(s_name_buf), " \"%s\"",
-				 de->d_name.name);
+			if (snprintf(name, sizeof(s_name_buf), " \"%s\"",
+				     de->d_name.name) >= sizeof(s_name_buf))
+				name[sizeof(s_name_buf) - 1] = 0;
 			spin_unlock(&de->d_lock);
 		} else {
 			name[0] = 0;

