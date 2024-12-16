Return-Path: <linux-kernel+bounces-447094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 314989F2D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9590B188770C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F548201269;
	Mon, 16 Dec 2024 09:45:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1238202C2E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342326; cv=none; b=ZVZQjn8lqOfJo6UOb1yXW6PRtFPokCvCiOC46xN4OlxacLeb3g7zPVb2wjsFTpNdX/3ihVjwmgHjSuAQeRoDiLpUT+E0EAAunkXX2YSdi/pA3LowoHvCMN62dXLyLzKxk9AmPzrDpmhW9hfRntyzv7etwRnnH8cCAOYiT+jt/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342326; c=relaxed/simple;
	bh=MdNuwWxHaHNB55o5d/y0WU1NWM8OUTr8sPf//hRa/Bw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SKMOQMd/aP7ApHLUBKjtNbD2mqSAIT1QcHnI7MhDgFvzEjWOgiFLG0aCGSYcJmQLadhO+C6NO3Bs47AdGEgxpX2w4bP+2ttsCs4x7uGRr3Rn32y+Vfj+yRkNJiUsHxtJZLdH03gpNS13+XJ9mxEZfiGXP+a7OyALAgx821IKOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3abe7375ba6so82154635ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342324; x=1734947124;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=frZhY6vqqExPDCyABVxZfOkud9Jo0Qj0ke4cTnmE9uk=;
        b=PojxuAVVioQKdXcvmJwAXR+dZSO9rJD5oxUwCCcJ9SmhuBZCJ7BJExPRx0aWWz2c6n
         GoGV8F5zoz+X5RKqimcgbhyR8qeY0oR2osd2CwrorOGrjn8qM6Ql2nv4SumckgYe7m5F
         G4uNvFPCdxC8M8qdtlbFSi4DmOM5kqJx0ZrUPRzSg2MmB80kV2nG2s8KKUDNxxbf3zn8
         zOBK8fytUKiQkBtHOfyfPC3CJuXjW3WplJoNNjpM7suVgXVPQ1kF5xbCkJv/2OvzhANV
         utc9B1KMPyGNnC8M7BbbEdkvsojSADS0x9RQWyMDNwbkVAIYQVLN203Ce3hO5RP8BkZd
         9cQg==
X-Forwarded-Encrypted: i=1; AJvYcCU6/sILt/RqPyqJleiy28tHHXohX47CLHaqw88yAjDFYK11gPCs6T9S+Zkhd16s+aaLdW0iTJPbJ6IhK/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1W08fcrJBW60TlI/St6OiVnPve0ayihe1vmwNv9YTy2zewOMk
	0hyX2MU80vPHrHZltbW5WZkXHdHA/+QRmCWFLto2LqSmaYiCXP+ZLmEgP1B2MfCW79CLOjD6sVr
	5gDSStZ9ADOji7x1hRobWomNkv1haUOepHxym7Lz3S2ythMjtcBHOy8k=
X-Google-Smtp-Source: AGHT+IHg8wCQ3njcbec1Ku/E57d+qhPCQ7zkrkNn5GeasVKOJrvaFGj+yk3HAmXPLEVyYsZkCHueqbRG3TMW3ypqe0xocYBRIMg9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348a:b0:3a7:e01b:6410 with SMTP id
 e9e14a558f8ab-3aff0c4d934mr123692415ab.18.1734342324143; Mon, 16 Dec 2024
 01:45:24 -0800 (PST)
Date: Mon, 16 Dec 2024 01:45:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff6b4.050a0220.37aaf.0128.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Dec 2024)
From: syzbot <syzbot+list6a0dba1c3237fe630d77@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 5 new issues were detected and 0 were fixed.
In total, 52 issues are still open and 51 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  26463   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  14151   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<3>  7614    Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<4>  4891    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  2640    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<6>  2635    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  2570    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<8>  2228    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<9>  1301    Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 1139    Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

