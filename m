Return-Path: <linux-kernel+bounces-422917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FCB9D9FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 01:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86B8165A18
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FD191F81;
	Wed, 27 Nov 2024 00:00:33 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97C139D0B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732665633; cv=none; b=Neeb2p8a+WNQ6tJ51Q2feOQY6UGWOjyCbWUZFY51wY4gVQdJKv9lKPVtPC7KtSspkpYMRMVjESTzSwoqkOIkIVgm8tny5+i2PDK1avYffdJW07eJ8e7hYGu/MraTVNWcEeQ9cjwtzlSSbf5jYWGMqdq49ryzCNrg3JWeq7Df/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732665633; c=relaxed/simple;
	bh=mWEzL0tvE16IqAHquHQVa8Ew8pcBGNibUmxmgQ8sVeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jNRv/Z8ca9HJ265ne7446TNZ9WOiH0id3M+DQUlaAb66B8Cyjb2WjyixyHZwvHim/z+74SpAv+CPsq6eS4oavM5R7DUjbmRSMMotFgonNTCKAC7L1Jvf4Mih9ShM8yDvtMPn3R9L6J7V9B+rcHVtAqJdXGzhcl+oZx8FORG+WYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a787d32003so66613955ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732665630; x=1733270430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zTKc67zsogzHibzY2wh38trH7M0alUl75sjqNxOO28=;
        b=HFbFOAC4gQI4+iLgI9fsCJdY9T4IlK9ro2bIxlEDcKWjH8MnTs76hw63w/vX2GNbW9
         Cc4PNxIjVWXIZqolKkIB2yqIcTmeK9fbPq/FR+ClJ7aGAHuXlB7U9U7iOGZkVKU3Iwwd
         3uYxIJGgkj9W+0r9N3G2/tLboyVULEZ06qPZXdYTP4CNpfLEReGVgU0NndRIJgmC/3Ak
         5uNFn8hprH1OLlLOyW39gdhWJfZcsHIfgVOkXtCIrRj70n/kY5MLqDwxWbe9QT5ss2Jo
         CcUAV/vSSSs1AyHxyeTwjwAObAqYGWhGSgEZv1lyE5IVB+HXtHWIiyQ+XwyoqQ4Usm+j
         t1Kw==
X-Gm-Message-State: AOJu0YxswbSGDxzinFAIx85t5ijsK3nDRTByNX26T9qbF97KltQJDp4b
	Llv94mShXn2jFdbaYEY7/fDcXfYAX4A7fXZLcMyFQWOm5WOlQEArBrELIqIhtQTFAygu66d0HVX
	zt1FfYjBWid2qHu+64JGq/hVSKGo8zX+ya3fLHnsa/NswBYDCsuiAn3o=
X-Google-Smtp-Source: AGHT+IGAIYVdWsiq4ju8H9vQFHVYxA80MoAqBedfivL+/D1CLN5GCfJ8hrrRPvWoawYgYmlQIxYnEKekFu9QnvyUev9wFZ+e72tU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3a7:7124:bd2b with SMTP id
 e9e14a558f8ab-3a7c55d4993mr10599865ab.15.1732665630159; Tue, 26 Nov 2024
 16:00:30 -0800 (PST)
Date: Tue, 26 Nov 2024 16:00:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746611e.050a0220.1286eb.0024.GAE@google.com>
Subject: [syzbot] upstream build error (22)
From: syzbot <syzbot+f6c113186405efe2140e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cd69c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=604eacde21ba24e2
dashboard link: https://syzkaller.appspot.com/bug?extid=f6c113186405efe2140e
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6c113186405efe2140e@syzkaller.appspotmail.com

failed to run ["make" "-j" "16" "ARCH=arm64" "CROSS_COMPILE=aarch64-linux-gnu-" "Image.gz"]: exit status 2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

