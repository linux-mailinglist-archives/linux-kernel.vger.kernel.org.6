Return-Path: <linux-kernel+bounces-447792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AECC9F3706
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC388161347
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1E9203D5E;
	Mon, 16 Dec 2024 17:09:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AA1C9B9B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368944; cv=none; b=bzBA8XexfpJBj53WwtLBwJ1NyvuBPRL26x6tAGq4zkgswuuzz1OXsfYqO4cgpwFtYa/gA5RgGU2mIEnCtBPTljYIKTNCM/+n1WFHUlp20JdgLwOe2ymmB5q1Ebx41yd4cXWyMtX9NSOFVv751BKVdhQFgpbHzMSKq8l4fUICNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368944; c=relaxed/simple;
	bh=vGh+vjiWCmgl2N1Jja9qmEZA57c3O5o3k2pXsnEoJFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bmUrItewcrb5mQyUTSeCGcjjlswpvsvwDrNOdaaKDi6bxyJSWHVZp4VVRjLRrM0KSx2UZX5znawtmgpVixVAA3C6DNmmVY1mCni+rPWKSIZoynQF7wL3PShEBYdUVm0rQsEEE0Lu2DPc5q+qzoCrAlR8+bwM0JZrZCnzKD+AqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844cffcb685so366090239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734368942; x=1734973742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1IVfTym+dQAgGcjXOI2PlYHbpUuq0ZaBK9RUpEwSZA=;
        b=pCUv+TSQoCEHWIXFrass0uGqZRaKzYQiH5+LERmotUDDlXbGoKL07AeQEuZP3re6n/
         v4UpzLbwVoEkVHnVyD2dPCBdE+wlbt3Pg09CQxOex+4SXtS+v2qBXA5PNFPYBLSfCg4a
         VZzhyCuIfhth0ysiwFWErWZYmyhSES7RIdCDverfRq+HfPT4iRtM3rlxx4qnIIB9V29i
         DZu56hBovJ1/96GlTHLbHbu+9fw4fDQ3zFIXkx4DS+cHjYcG6BSanFbwlwlWDDS5e/sh
         vVjia24I4BlVLys7I/tOAWpBJZ7syPm5wUt5fi4qyqf+ZC6pgx+JPiN2OGtD/+ijcZhU
         gM/w==
X-Forwarded-Encrypted: i=1; AJvYcCVqJn1KAn5OKu7rQGmxzocJiKZH9QzBZRZ8vjWT7xI4LoxqnSy1s1HW5kD8yLHwJgMoW4nUnNwl4zUt0O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVaPOL1gBN/yuFvoUyCKwi6RButwmIFN1uwms6s/o1DBaYxIww
	J1DvMUGNhucGBcUZvhlMgLw2rq5g4dh2VUEk3IJnlOFqx7gKon2cUeXpUb4yJFcDQB+LDXNI9HR
	UhAbAJ/Yrlullxc0lz5Dx5XqOXngm5R5DeuiKhl39bTHGsBvuyZFWVCg=
X-Google-Smtp-Source: AGHT+IGb1KKFSNlFWIiws52V+46CQgj9Gu6JQmqOX92ts+FppMK3cos/qyLNW6fTXjZfXZptWPQsOb1uO+XiKmprVy6zV8dbeWSc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:b0:3a7:d84c:f2a0 with SMTP id
 e9e14a558f8ab-3aff69e2d54mr107591785ab.7.1734368942008; Mon, 16 Dec 2024
 09:09:02 -0800 (PST)
Date: Mon, 16 Dec 2024 09:09:01 -0800
In-Reply-To: <20241216164356.v_RSK%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67605ead.050a0220.37aaf.0139.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         78d4f34e Linux 6.13-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1159c7e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=abd9cdd473cf7437
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e99730580000

Note: testing is done by a robot and is best-effort only.

