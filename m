Return-Path: <linux-kernel+bounces-446975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307B9F2B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B521660AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D31FFC79;
	Mon, 16 Dec 2024 08:10:23 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20981FF7C1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336622; cv=none; b=l/PGECdpxpQyeQKZEt281332pa9fW56oe81SdUG7k1F5JRyFFW9mGsq/IQWKhQzEfT2C4NRKojz7vEwYucteZWDesZUWjntafIwSYHcGDaJNVNcHbZNpfoUOCgLX5bTrIIVrzqaEF0Crd1iG27v50A9PrEZpYmlCCdN1VzlrUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336622; c=relaxed/simple;
	bh=KbX/MJdK6ZdyPAaE9FDaKyEEueArsLx9toG+wsNvEkE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O41gLRNOGXNFbmqCEBa1LbH2e/o3Wt8ujaY8ehRQ2m3X/vUgPVjwAz/1qugsGh6USYlFYCzAfhuOhyJ46JqmsdNpQiJSwJ0Dcwab6afSrqcYP+oD4/gPS2bOKyPMj6Bjg5ldJyxFwnrA1S9+nLQgUyKIR/AUxw4Vvnfmh3ZWDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so71394335ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336620; x=1734941420;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV8iIp9qpM2IB+djcYXWsqgd5g5+MlAIrnWp9CzwxPs=;
        b=DP1FoLeU/v+Tltpy8Z9z9+nJD/MVJIfjSmtVpdFYVKpkvXxCyWDeFel4+oRaGKGomG
         ATHjvCY+pd1XrvCSYWBk7atm0FAHIdafABpNdc7CTj2vc0MgqxpCJRtle4+Dtit+BcWm
         bYYaWnXclaa7LSqBKFwVMkcqmBnl2XFJSZ4bbo2In0oYcih/0yCKx8r3bsaw7pXicK9y
         dulC05XDiVimmjTcrOB5PQnhs6DDiUSfULx+U/Xm+utnOYYFc4Yjmo/zI+pNa5DuwZVX
         e2T+Sexv7JVu7sMqhVOjpdZoqEk+nZjOmKiF7lu5xW0BTTcdvWv90yhFMuf5g96mDvs7
         BW6g==
X-Forwarded-Encrypted: i=1; AJvYcCXfwOfhSZy7fdD6oH3vljGgW5gVmWbJvYM7my2qc/KesKlw72q2f/dQosx0DzugJDF54X4xrIEE8un/XV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5V7KQXc82HuO8Ueq2So/8egtUodQyZ1uyKGPcJfNf3MzUSCam
	9YbjIsNJ/LQHtWF24VFj7ro3zsqnmbOv7VjtwyD9FcS5t6cKeCtoSDexecAEECkjqoF+inutQII
	H9X9+JKwemlO0FNVglt1Xm1VoRSIrf40thXCbAuGbZUK/R/4/4ZFaRrU=
X-Google-Smtp-Source: AGHT+IFhLZx/D4YLRUo+eS+hjDg+ipRi+l48Zy+dYIUdALk9xwMeHg2kotV1B+iEEaApZlUAKU4z8lFOqZRpMEdgi4lfd9k5yDfI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1948:b0:3a7:8c3f:edce with SMTP id
 e9e14a558f8ab-3aff4619adamr121208775ab.3.1734336620090; Mon, 16 Dec 2024
 00:10:20 -0800 (PST)
Date: Mon, 16 Dec 2024 00:10:20 -0800
In-Reply-To: <6735aa91.050a0220.2a2fcc.0062.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675fe06c.050a0220.37aaf.011c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __journal_res_get (2)
From: syzbot <syzbot+53bb24d476ef8368a7f0@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2e7aff49b5da Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1129a60f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=696fb014d05da3a3
dashboard link: https://syzkaller.appspot.com/bug?extid=53bb24d476ef8368a7f0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b547e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10baf344580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef408f67fde3/disk-2e7aff49.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/414ac17a20dc/vmlinux-2e7aff49.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a93415d2a7e7/Image-2e7aff49.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6280c05687f7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53bb24d476ef8368a7f0@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/journal.c:359!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6423 Comm: syz-executor145 Not tainted 6.13.0-rc2-syzkaller-g2e7aff49b5da #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : journal_entry_open fs/bcachefs/journal.c:359 [inline]
pc : __journal_res_get+0x1d80/0x1f60 fs/bcachefs/journal.c:544
lr : journal_entry_open fs/bcachefs/journal.c:359 [inline]
lr : __journal_res_get+0x1d80/0x1f60 fs/bcachefs/journal.c:544
sp : ffff80009e026b00
x29: ffff80009e026d80 x28: 000000000000000a x27: 0000000000effffe
x26: 8111000080100103 x25: ffff0000dcacab40 x24: ffff0000dcacab40
x23: ffff0000dcacab38 x22: dfff800000000000 x21: 1fffe0001b959545
x20: 1fffe0001b9594a0 x19: ffff0000dcaca500 x18: ffff80009e0267e0
x17: 000000000000e53f x16: ffff80008045f36c x15: 0000000000000001
x14: 1fffe0001b959567 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001b959568 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c6acdac0 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800093532ec8 x4 : 0000000000000008 x3 : ffff800082b728f0
x2 : 0000000000000000 x1 : 0000000000000002 x0 : 0000000000000000
Call trace:
 journal_entry_open fs/bcachefs/journal.c:359 [inline] (P)
 __journal_res_get+0x1d80/0x1f60 fs/bcachefs/journal.c:544 (P)
 journal_entry_open fs/bcachefs/journal.c:359 [inline] (L)
 __journal_res_get+0x1d80/0x1f60 fs/bcachefs/journal.c:544 (L)
 bch2_journal_res_get_slowpath+0xe0/0x618 fs/bcachefs/journal.c:606
 bch2_journal_res_get+0x124/0x1b4 fs/bcachefs/journal.h:382
 bch2_journal_meta+0x9c/0x26c fs/bcachefs/journal.c:842
 bch2_journal_flush_device_pins+0x3b0/0x5e0 fs/bcachefs/journal_reclaim.c:889
 bch2_data_job+0x290/0xa90 fs/bcachefs/move.c:1065
 bch2_data_thread+0xc0/0x178 fs/bcachefs/chardev.c:438
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Code: 17ffff9f 976c947b d4210000 976c9479 (d4210000) 
---[ end trace 0000000000000000 ]---


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

