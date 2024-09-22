Return-Path: <linux-kernel+bounces-335046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5297E04A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 08:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175D6B20F99
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C629CF6;
	Sun, 22 Sep 2024 06:35:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537BEEB5
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726986904; cv=none; b=JQFFPMZk4wChfAjuHzYzHXLsExz+Wb8j5FuPYo7FOsixo/9IOyG4a5ovl+4tEjgn7eQc1mq8S+2jfkVpPM5GHzEqa/J3hR5u8cqOhPmQMF/kWLA0X36n9e+3lFjG3mCgT5NPUoA+0AhAaBbUVvWgZ0ZZYarJBIyWI/4NYAmwVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726986904; c=relaxed/simple;
	bh=b9mtJm9xuGfFLelet8z9ZOGZWBAk0VRniYaNWoh5nmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jnJUxgebTXgcEVfC6NGOqySjG2iGTZTGqnAxrN/Owz+p7eLa281eVobnZ4NPzlzRkgu7IXKfDL5IVCLB5M3Y+i7zVGhDHY8QtpBbJZcwaMOUIgSHJQe2LYMEjAh0b/LvGBgF3mlvqd6rJO+XFSzR3Clgx0Yacfix2kml9VAKgnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f53b1932aso39987535ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 23:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726986902; x=1727591702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXbke1TSf/Lujspb4haKHNfN010h0/F5mBpaEuhZTCY=;
        b=tjRZUMrryLYnssETxvNOc40v9zUnlF9e09AjSbFROK/16NXPkr+tlVDAzd+hxT+JJ5
         0DMKfF2NY8tb//kw5N/4XOHocNc3QUCXHDR3zDfQyUdhkW3U+bNNWtE/yNmFSeyGSxww
         Ol4H56FgEHA202sX7bM+QPzrfph6NqTZTkxIelhzEdYpzMo5f+QT2EZd7AFM879PVoOc
         A+5UWORzgEL+/24NeHrAL8Yr84dB/A6RGh0jGYhe2/4weMTk12E0ynJTM1oKjeTJiiD8
         6yd4g70OoKNBsupUeLg3JUS9PPdNPVbaB6uNnAvkGH9dzSKvH0+DD36RYVdBoVbaO+eb
         LbDA==
X-Forwarded-Encrypted: i=1; AJvYcCUx2GgpAmBnFIUlEpSSPWKioq7NCtZQWiHdJrxxmnlMV17N4TJjWT0Mjb23VqBqyPyVymT5euVepaRdbCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1zG3Uqd46utVXlNS7rUiQS3piMNA2pNGAlbNGUGsXMpuxi7HT
	STT8wIik9ymDt57E3d/J9SndTK4iqUIjGHssolTqevVJBzKCm4hCtoyiXK+wnKB3gBkkK6CNL4Y
	kcn+Bm7YlMzFyxZ5vKTTh4krZeR0ZhjmMyy6IFlrL0htkkl8/AzAB0tQ=
X-Google-Smtp-Source: AGHT+IEE3fIYF7JYZfwfVso4xkEDFVA5x+Wqk04Kn4vv9c0N+UuSyQFLZJ9sTKVNLvN8mAgc36GMEMb+OyuZRTT0EpC1goCEGxx+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:3a0:c403:b575 with SMTP id
 e9e14a558f8ab-3a0c8ca4af1mr55887715ab.6.1726986901891; Sat, 21 Sep 2024
 23:35:01 -0700 (PDT)
Date: Sat, 21 Sep 2024 23:35:01 -0700
In-Reply-To: <Zu+vI3EipxSsPOMe@thinkpad.lan>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66efba95.050a0220.3195df.008c.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in ext4_xattr_set_entry
From: syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, qianqiang.liu@163.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com

Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c78e07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b5c53071a819d59
dashboard link: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16538e07980000

Note: testing is done by a robot and is best-effort only.

