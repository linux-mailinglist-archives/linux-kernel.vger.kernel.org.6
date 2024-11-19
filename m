Return-Path: <linux-kernel+bounces-414609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851D9D2B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AECB23C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E84A1D0E39;
	Tue, 19 Nov 2024 16:28:57 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9841CFEDE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033736; cv=none; b=gE58p0rV7P/6eb0eMUa4zkcGiERCQUJ+gKP+vtT4ZFd6YlAMzjFRYcD1G+kVQtAPJHU/ptmga9ADwgKtFX3rZhIc94YaE4afGtX45b84DVUOfjSGPgaBvxnmWfb6ebHsaZUgpQ9hJK0qEfCKhsjpn8uQz7D6PQom1ueUzILE5CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033736; c=relaxed/simple;
	bh=YRA7uRncoZGUK0aOzTQuzNC5MzjVDrgq1TlqxKc3f8k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ohIMyppWDa8K4ddd588FT6Co9VoA51o/EOL/ZRbI0QYp29H/iOno0nhPEaEwjcemAX3Fcehx3WgwSipsl2D2Ysz6iWFE9jeK3xo7JRYeR5Ni7bwFFcX9Dk9hgDCUIZjq851jeJSBuns8gjXgS/qzbc8k4l5dUpGNDtZQtlh5r1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83e5dc9f6a4so525120039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732033734; x=1732638534;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQnFOgoa4RQ3iLDxZmxINp35w8cWZfEqP8tLdwZ0lJI=;
        b=c0/HPvzl6DmcbhqHBLxYgjvYPs9fhjmswaOM1zXt2hKFou1QKV0CsiP88yHduGk0P3
         xPSdeIbJ1uJpzmGBDaBtxtdTz8Xj307H+EQomT4QvRxWKqwSnEIAHHHlfyIfdT/WXTBU
         n+IbBu4gYhufbUnrXzYdj7deWAXJrM9YeN0EgJfD48TeXSmuW1NH0fSIkpa7f1I2E4tR
         tqxgFgQBI2eS4XNyPRuR1jDTxFocINxqPUO0vzMF4jgE3ImZGZ1GFBb8d9hSu9AUBAYG
         ieC7uKvFne5fGv6lHBlK0H9KbhUBvJ3LTxvpjcF0tj4Xg+acMWpx6FFBTkZO531GKPQM
         bt+w==
X-Gm-Message-State: AOJu0YwbCTFAPL9R4kWR8u8/OEUKWzXQG08PG3wnz2wk2m8TPytC0K8K
	KHbvVIVTnoTuNZ/9KCnkJyAYsgqVv+cWh/TUXeGiMgMViJbZxXocxTTCALBOwFDaQ1zY6LBym77
	X7epf5nP1f2kF/NYom6J9jki+yCY3M3Yk/szuXKRpWeNR2bzPRh8nE7o=
X-Google-Smtp-Source: AGHT+IHoPDwaljr53TtxviYG458TcY0RkGk4OBfYW6jdZO7/qlXFuXnE2KU1s8ySPBA0J2M2QYXIN47qSeBHXsQQw5J1Lq2sLB1n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156f:b0:3a1:a2b4:6665 with SMTP id
 e9e14a558f8ab-3a7774a41c5mr31974285ab.12.1732033734368; Tue, 19 Nov 2024
 08:28:54 -0800 (PST)
Date: Tue, 19 Nov 2024 08:28:54 -0800
In-Reply-To: <000000000000e2ff53061fc9dfcf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673cbcc6.050a0220.87769.0079.GAE@google.com>
Subject: Re: [syzbot] Re: KASAN: use-after-free Read in ocfs2_search_dirblock()
From: syzbot <syzbot+b9704899e166798d57c9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KASAN: use-after-free Read in ocfs2_search_dirblock()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 158f238aa69d91ad74e535c73f552bd4b025109c

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 213206ebdd58..7a8040a47e82 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -378,7 +378,7 @@ static inline int ocfs2_search_dirblock(struct buffer_head *bh,
 
 		/* prevent looping on a bad block */
 		de_len = le16_to_cpu(de->rec_len);
-		if (de_len <= 0) {
+		if (de_len <= 0 || de_len > sizeof(*de)) {
 			ret = -1;
 			goto bail;
 		}

