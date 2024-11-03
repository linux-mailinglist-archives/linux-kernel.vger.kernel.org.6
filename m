Return-Path: <linux-kernel+bounces-393712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C389BA446
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE26F1C20B5D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C514F12F;
	Sun,  3 Nov 2024 06:28:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4523B0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730615285; cv=none; b=buugbfrOhEH/en2XZU17EttqGZpwxEXb4zVzcuaXNxYPFym5+upAJoctAGB4gMNVkbq5pylf0qQN4Nd7gmkyRAuqgPuoU8zPrgwsujzF4fvSZvvtuqjFcUpAqSC9dRzmjLCm/VMDUxqIkmvGfFjlrGyNORbltdClWl+xjbQEaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730615285; c=relaxed/simple;
	bh=tVFbmFo0AeqvBCPH4tsqePWEbZj8ML/TymFnW4KKUuY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sFU9BBr0stOAheoSwVnqDKA1yoqlVPe1kWMtJqy/YdjZofX01tBwN1ueBH1F0gMopX3FibbZIB+MF3y4j5Vkd0Ai1ot6IPOoah59UQ2w6Twm6+ZlAyYG7d5LbFuIEMD0AhAqcXm6eg01BMsCzlPnaMgCQExFlF+hrHsOh5w0vOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aae46538bso339980139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 23:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730615283; x=1731220083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4gTj5tarbYBTVWljwWsaT/5MgzICjb8yxJW9eRgHv8=;
        b=J8fxjYmA3K/uRRcYHpgJ5qq2hHGP/nbEtsjur2YdkavhbzCqhmMqEMmdK+vouxYROz
         WK7Aa1fZ2Sf4O+umAG+lUkAVx9hB4mQASyikvZ3+/XwmJldQJTUIeB4tC1KxXojADI0t
         KgWB79JVXuyxpPCW7EWJDTYHO+EOY0+vdpE12UKmbbgTlTc5VaNEpF9r45AZu59QNKWh
         gmvKFs3ruYKbEohVlHzFgB9JUiD8+DmXW1usJ95jALcNV8/+QtphdoIDztmkt8ApnVBF
         T0xxnjxuw0l8siTZxtGtiOLSQcSs7q01A2jFkSM8/s7WrfuYgKTtsqJ7SKQ2n8KByQjQ
         ke4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1DT0aezk1OVGob70VZ+q7yJ04JIoRxtEYgzWoTrb/w0PzuBeL4O4Gor0C1SLe5vJ+uC1pFtMUg/OxqOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRxJ0dENqINk9y5/0GJp046DjT5Oiquvbgo9aERhhPOvxqVZ9
	NaJ0su0yxo5WNGSNPZjJuVG2nN/OE0IPU2SbWar7xzSuEx8RBTLm0ESkm5ylG2bDUhOG3GLs5TY
	GHLMUzIIZFw2vQQT+ch9lvbj29MZxxIz91mRYmYJfnhhjPjKUmCyCFEk=
X-Google-Smtp-Source: AGHT+IEb5YjUhCwxeei/Bt9FtDxSdNWQgJrAMKpHXkh1xTFSGRRaRpRuS3WHujdnXm+mqsr+TjaKo9xZ8WExtWdMdQ7VlZOag7QL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e07:b0:3a4:e9b3:22a7 with SMTP id
 e9e14a558f8ab-3a602f7e898mr126829385ab.0.1730615282739; Sat, 02 Nov 2024
 23:28:02 -0700 (PDT)
Date: Sat, 02 Nov 2024 23:28:02 -0700
In-Reply-To: <tencent_357089BF2EF46ECD4C8DE7DF46F312CDC606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672717f2.050a0220.3baf77.0498.GAE@google.com>
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
From: syzbot <syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Tested-by: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com

Tested on:

commit:         3e5e6c99 Merge tag 'nfsd-6.12-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b13630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f51a2a34984e4d8888fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14613630580000

Note: testing is done by a robot and is best-effort only.

