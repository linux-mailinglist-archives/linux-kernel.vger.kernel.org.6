Return-Path: <linux-kernel+bounces-419055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C6A9D68F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D78D281CFF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D718873A;
	Sat, 23 Nov 2024 12:12:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670E14F9E9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732363926; cv=none; b=GRpk7O61qXceZkXzN04cgpDbSQgqJcN4nOf6d4gsSLDRKzke9OjNjuB+kmD7yn/bnnt2k0hZIjuG2wV8yIWlWIomEzC7dGOJ+4kVZfoYFcGc6Xbyys4CQKLkNsuP+nxmys72doTYZbhyJXfuGy5CmwiqD9ttHvqJ+f63DIX++B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732363926; c=relaxed/simple;
	bh=TYyTZ2XNG/9L4jjo5iRo0rrA88GdXZarZrUK72B7FsA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gyGmhy/kS54smg2CPXjapAAtFFsmn0YmXphbaz6BDeLyZYv5eFUtM6vIphiLe4rjdlWSel2RnxpsFkJZFQSYyjf86wKqsRyGTklHmaDaWi71zTTJOAOAW7eveMcY3jOJWkTzbsNuHpXt1xx73dMDyu0FIowl6pBXkZo+OUP33jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf9b6bfaso318167239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 04:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732363924; x=1732968724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqxBek+GG5i+/WKQLp+6iOq60RM5a03OPRmp+n2mpQI=;
        b=HFisrBmsQxahdS1lzCR4ZN4hvgbaQlZbnLGeheNtpSGUCRrd17nKfU5ib9tHAFvEDI
         5reeu8z6THfy9o80x1t5SWCefb6XU09fDRKOFWnCC1xMmPcti3J+ib8LC0uQ54GV6Gja
         kZzBsi7CJIFhoySsyU5ujT6OFwkZFqeW4lwbAR5IzQCWgESGmxfes+lptzCNBu9IJfuC
         Cqd8Jm/L0rxLMHBX1tUX3GB1VnzfATGxkeDUwgDt8j6fgYuoiyd340rEdVOUPIiI+p7y
         U1diti5qJo9DkKHgjsFtu8YimGCVWgiksXYA/kUSu0Q0XRLbvsuXALLIgcykFVyQs/+a
         deFQ==
X-Gm-Message-State: AOJu0YyJE1Rq9OzLvUxbenDrM04sBhUqayKLqvmnswmL3erhkZQeIYTj
	KWNvil/Ih/1sWIlaUJRKSAk8i/Fom2hO8s0aqvW+yWY/fU4GZg/LEhZ++h+R/1XNSlujBCnTNG5
	iCZwRpgX1OsdPZVWV8E9wFNcRdKYtTlhP0mizsC92jLcVkT/vVqQdUzw=
X-Google-Smtp-Source: AGHT+IHwx+RNMPYg447vEukiWAi/v6iigwrQYwR7xJAfhhfOLKGRgc4fI/dFRgSSWHl5dZnRgtKRfzFptO7bxSfRQn7aCgjxjnwN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a88:b0:3a7:6566:1e8f with SMTP id
 e9e14a558f8ab-3a79aeade39mr53033695ab.16.1732363923874; Sat, 23 Nov 2024
 04:12:03 -0800 (PST)
Date: Sat, 23 Nov 2024 04:12:03 -0800
In-Reply-To: <f1601b51-4c9a-4a99-ac04-9403f2939b37@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741c693.050a0220.1cc393.000a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] VFS: Busy inodes after unmount (use-after-free)
From: syzbot <syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com
Tested-by: syzbot+0af00f6a2cba2058b5db@syzkaller.appspotmail.com

Tested on:

commit:         adc21867 Linux 6.12
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.12
console output: https://syzkaller.appspot.com/x/log.txt?x=14bf36e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dfe7071ced70e76
dashboard link: https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c281c0580000

Note: testing is done by a robot and is best-effort only.

