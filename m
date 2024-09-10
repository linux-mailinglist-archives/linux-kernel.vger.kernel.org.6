Return-Path: <linux-kernel+bounces-322518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D619D972A36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F642863A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA6A17BEAE;
	Tue, 10 Sep 2024 07:08:03 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4E17BB1A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952082; cv=none; b=aH7pTv0icZAVmhhWJ4iXZKK8NoQpcGjT230GGS4CgtwvV5EGlhvSXuCzHdol+vu5e7n5haiqSwYoe0bLvwGBep0oNpnT8vOq18Q8oCbf2jyy9RochtXuU/ZabxK3eqir6NhQdQuvHUtWwgfGHi3+hubbrxxngozDfk2xKr42ItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952082; c=relaxed/simple;
	bh=8zjQeVCfrTPZKwwO8GSTiXQW85/s++Wt3Tt9flh40Jk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MVGT4q0YMmXeDzsQQjbbrrrDJAgJN5TVNK1H/0Q3RJvGOSpWCcekmLkCayBfMk3VVQk084GPvU90OgeWS2br06QMHtuRMYloPPoHfFd/dTDnamiHKveyDAmYkRralJ5PCyg8jaFWa/8Ptg0yCDZ/8hzenFZKCGVTT1JNEPED57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a05009b331so70379955ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952080; x=1726556880;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afiqXbDSiTRXSblLykc4woSl7krp7R5bsa3kEeHWFkQ=;
        b=mmugCIfBpbmoIC6ZXw8c6qPCpRteHDWTK/zqR/N5e8OH7y5w8zkbferbPH9NcePoMS
         xCNz8o2m6b6XWW7RU7OXHSoOOzsreLXYR85anYjbf1XV4dVmAG0OpHb2FvFCaJvprzDy
         zZuKFgpT6T7c707PLYUNg5taz1NgeRpqwrSnV+T0hcyt9BB5D1lwOWeWQe2TLd7ifiVl
         hbXqmpUd5BWNWYtJ3TVpP0EDAYkSamNs69XDrHynaT76vEn0/cyJTlk1yn5I8rz/ys/a
         rxFJulHZ1V3KFoZuBbxzKS/14MKO56akhxFlrI4yAbfk7E0K6KdxnyWmBEOOPxxq+Ka/
         nrSA==
X-Gm-Message-State: AOJu0YzNJiZWU0WYUIVFKH/wVTuvQg/onks+ZxSmWgXddwv1kGvdiWvC
	CQIIhjOyAV1kWJ6FM+XXi+9HD+AobjHU5Nt89EtCLS727tRDp4b8uGk3tO4FJ0/oFC6oqu2knOw
	/5HSswz7B5HHeotNg/04hYUyTjDs6XBOCEFB3FYqzeSxIpiMqtWgKdKM=
X-Google-Smtp-Source: AGHT+IGfyabXXmQu1HFpns1tYylgtQuG34c/56GnCjofJnBI7HsrUt+AapDYFhxCWHwNFBuYXZafgXKFre4Y/juh6/HbUHWiYV7W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:480c:6ac4 with SMTP id
 e9e14a558f8ab-3a0568a3bb6mr115129615ab.22.1725952080618; Tue, 10 Sep 2024
 00:08:00 -0700 (PDT)
Date: Tue, 10 Sep 2024 00:08:00 -0700
In-Reply-To: <000000000000acfa76061fcca330@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa39df0621be8870@google.com>
Subject: Re: [syzbot] possible fix (linux-ntfs3)
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible fix (linux-ntfs3)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..4a2062e481a4 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -124,10 +124,15 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 		struct dentry *de = d_find_alias(inode);
 
 		if (de) {
+			int len;
 			spin_lock(&de->d_lock);
-			snprintf(name, sizeof(s_name_buf), " \"%s\"",
-				 de->d_name.name);
+			len = snprintf(name, sizeof(s_name_buf), " \"%s\"",
+				       de->d_name.name);
 			spin_unlock(&de->d_lock);
+			if (len <= 0)
+				name[0] = 0;
+			else if (len >= sizeof(s_name_buf))
+				name[sizeof(s_name_buf) - 1] = 0;
 		} else {
 			name[0] = 0;
 		}

