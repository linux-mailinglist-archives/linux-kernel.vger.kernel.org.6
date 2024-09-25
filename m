Return-Path: <linux-kernel+bounces-339149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625D9860CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B101C2692F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B81B151B;
	Wed, 25 Sep 2024 13:26:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6081B1503
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270766; cv=none; b=QUXNvvjo9ufXj0ZMEX+7zJzc91krBN17VuOJiRVfIG2n6ibYRcbANH5Bz1eXbMvUhRzptSduIqCWZMh5QYL6DgJtxD4EV3xPkMv1XRRfJjl3qKuFEdSMqokVdLT1kxD5RjZI6u4dO+XXkUHyPqJojD0xCVWMbfT7xRdwiWT+T9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270766; c=relaxed/simple;
	bh=OcVk9z+JQ2eHsUYSddjIhwes5hEvqWXUc3lQIrKqbH8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B7+/LUkXb6uh9cXKXXcYjP6gzk+CD+riC0WEngRsUwnO5+13tKOhhL0YDX5hbt20sJIaUtfxymNEisf7R5ZaNbKHc+3BIUepmwGGA1bLHXnICArNtT53wYXbwuzkDGiQiENGTq7fZnP0/4Cfyjezsj7tUp5UhdHqN5q2BOmo3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8324396d0abso176819439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270764; x=1727875564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yU1nprWqQ7MBhICVILkqg5fd4/Wpey4UFcDJUyq0XJo=;
        b=hiW0eaYOpBdCIRqJ2gtHep1DfdN/V1cr8xQJS+IwLeJppWJP+xFFaGO3eXfKrpLBVY
         /w5MvoMeAmF4QxEFkrmIv37aO5oLmlTidi0Rkw643yKAU70280Y6WgeJl9k/9rX5vxw/
         PrS3NfJsOdhJtpnZn6gFSbHvCRavGQC/DHA9R29FeleyvR6QphiRW2Em3j2hoV8p1u70
         qVKb8gDZ4FghlXZo4xihOvC+yYYm62RQhpRQztoJIzVKLULX7slSpWf3Qu582ZPc0iv4
         93TzhjXwvaPjh8/J36eI7pGVt6SYU3fnoBD+uazqtXGFlrC59lo7xyokA9dsB0XHGMHA
         xx9g==
X-Forwarded-Encrypted: i=1; AJvYcCW3CdEBLraD5lW/QAQStNT7Mf6ONmKcnd3C3iNHjMGwghBQIDmNaw+vU+uTDGN+NhcLUdHu3QnO3LsC5Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM+dwOt36u5U9c/o/2DUYPSF0SI71odudK4E2Z3IyFKWtwj9Ts
	TWzzyuUyC/vcrb00sXq9HGpJwylVzZ80OM1oO6j8kM1+qTbjjG47RRsz0kmLqHJPH9gA05IjIo3
	qKGuvKIP91QCO4MaLQleujCepAo7XRzp+HqY9Q2YobGgHwA4YsFe3MuI=
X-Google-Smtp-Source: AGHT+IFZ18fr0KucuhvDTScndZ+8v6GBsIt+WRqOdrCH57Mjex+5M3SuRhuLGc1SvII0r2c2rmlGDpUDugbixPDHuc2E7RL4shbN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:b0:3a1:a3bd:adcc with SMTP id
 e9e14a558f8ab-3a26d7492ebmr27843515ab.6.1727270764101; Wed, 25 Sep 2024
 06:26:04 -0700 (PDT)
Date: Wed, 25 Sep 2024 06:26:04 -0700
In-Reply-To: <tencent_E8477769977226C7D37D8373E975C3AD0405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f40f6c.050a0220.211276.0030.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Tested-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com

Tested on:

commit:         684a64bf Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167b4a80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd75e1a00004094f
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b332a9980000

Note: testing is done by a robot and is best-effort only.

