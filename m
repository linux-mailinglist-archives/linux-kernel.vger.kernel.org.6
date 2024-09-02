Return-Path: <linux-kernel+bounces-311369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5696883D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A1E1F22C60
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDF0205E07;
	Mon,  2 Sep 2024 13:01:00 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD9201251
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282059; cv=none; b=FYzzrC6NtogOA+kQf2fHUwGyf6Fj9w+f90qDs5RqIoKnRFA1/Gez7liXQoh/bE1t08w5VFVyQ8LthgatZGwyRzHSHU/51boyoBYqUE+0Rbvj7IZYnGorq5t+dp40axlU7FsAL1Gx3WL1rMwjPrrMM083PlO+TlKN3fPQslxRqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282059; c=relaxed/simple;
	bh=LSyoNsJrt4xmwJKjc+8ZA14XovgyKEHLzkEhY1X82Ck=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p/KuACHZ6pyQJHWIdr5GrPJGH3DoERtr0Ak45g4SjqNM6MymE5h+WpuVKt5IguCVOHCudEQn1VQdiUlYIvuF+F3/1zjbuyDHITtsgqpfg+QVAo9Qv4qLAyrr0o8XrJmYKk6EhBIsR0+sT607UzSwnBS4crr7jybDv42xlf31KQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d17abca55so45033485ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 06:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282057; x=1725886857;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZece7UMwHVUVaB2eGQYYRwtN9PUX+TExglevqJpqSE=;
        b=nuLh0kuCmTUrb51w2IiLZ5+AcZab5VIdGD1wycLj3I57RriwIoYWlP2QkL7cOrR+Zd
         RS2hdOEferu0yeNhNt2jkbvOkDIJ1fANxbBU1DntD0BZ5o6t4toInqm8EDShRWH8n04b
         lWfgLFxc17op50qJjsA01SlpQQTJlgGIsA+lIJTpZBRSKX0TWp8Vh+FD0awriXhIYqTI
         qiYCax1Af5vk9cGSGErVQYyuqdmjWGcafKuZDT0S5k/ASrxEr62C1512yMKeBwwFGsVF
         XcNCdGZKwIa1yvaZ5fX2JsnDBL51rREve2wP5Pk6WBGSIkesPwovuRGq1JHOLCx9rU22
         Oahw==
X-Gm-Message-State: AOJu0YwLcJRTKCxgqJdMdQ4jYDCEXrAmsEJoU3KfPtGMxctnxlcMZecl
	omSHRhxcbXoX38nRSxDFYkDpBAjcv4plpRhLyP3nZtlzmGgo2CLPJuDZmNq0cbtzx9IzaeYFZYu
	gM4Bys8k1ie2epZTlGwrEFzT5580xCfCUE1X1ywMVTuvqi7nufHmS7Ls=
X-Google-Smtp-Source: AGHT+IFvb5k7vpw4Ir9oc3IfxWL1D8kLNLP5TgCmcgqBBdEkLVZL/zCtw3emOjaZ9IvnsCQY1gdK99YKI9SqdK0CkY60wP90HiBb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:396:ec3b:df63 with SMTP id
 e9e14a558f8ab-39f4107768bmr6473115ab.4.1725282056970; Mon, 02 Sep 2024
 06:00:56 -0700 (PDT)
Date: Mon, 02 Sep 2024 06:00:56 -0700
In-Reply-To: <0000000000009a502f061d1ada4d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024b5a90621228855@google.com>
Subject: Re: [syzbot] possible fix (linux-ntfs3)
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix (linux-ntfs3)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 1963a8928360..ab2abd323859 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1679,7 +1679,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_EA, NULL, 0, NULL, NULL);
 	if (attr && attr->non_res) {
 		/* Delete ATTR_EA, if non-resident. */
-		attr_set_size(ni, ATTR_EA, NULL, 0, NULL, 0, NULL, false, NULL);
+		struct runs_tree run;
+		run_init(&run);
+		attr_set_size(ni, ATTR_EA, NULL, 0, &run, 0, NULL, false, NULL);
+		run_close(&run);
 	}
 
 	if (rp_inserted)

