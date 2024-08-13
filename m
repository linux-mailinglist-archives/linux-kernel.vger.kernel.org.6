Return-Path: <linux-kernel+bounces-284393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7258B95007C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199EF1F2389B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7793817D346;
	Tue, 13 Aug 2024 08:54:24 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10B13C80E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539263; cv=none; b=rRBN5uAXZBvYT3d+5kMzrcixoeVu2AtBsSxNKMpxgucfBywOvOm4/bl7qy4Z96STnPRw7SY+cn8k/+sqguOppwirRNiCxYxMYkhL7PTQg9DwOJ4YsDlu02gNfgzK0XOKO7z+qmrokHRuQALhRDAqnLmKtftt4WdIBbsw8FNBSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539263; c=relaxed/simple;
	bh=ntZ7ki0U1JQBEN7NPjGQxQxlm5nJEP56fPEYesiwwHA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E5tJhlsPIPhHVykzmllyIPp0FnrzDxIXS+d0TH4AbSu8OGNrYndalAYJNCXVNj2YxNDtGuN6dQ+MNwbeBJf8ZMFIRT8CLWNmqhjyhCQ5BNsp1F2BxM8tzzX8dk11bZS/dd5V+xDpRCKBkCe1Nky4e31ZZjqaI1W3g8AyItERn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b3dc8cdcbso78132785ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723539261; x=1724144061;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzyHOexbn1EOtAlkf/o3rEeXCw0wodCIeE0tcNgnlUY=;
        b=BcPe1oeCKCVZAyRbDy3N64C/ybsmmQgOZs15U3P9N3Qqt8GjeP00+pivSl1z06Tfny
         kasK2p+N4SFv5jIgKA1n/1TtT0N3HoSFmh+45UFgN8BT456TO7wJ6caCZwoDOtNNdZzf
         o3pzH/jDVmmxJJHUlzcCGN89zgTEw3IoH2a/JAvHZiZ5qWAKYCPF7J23Qd+775WNllnV
         8uycD461fzNRjCNDRGxJbEgtajWsSkirytlChCdGrccxtoPTxwBw/uJg69SJTDi3JSqG
         ap4308/4+cfXOFsM0zrqhzXjLWmXkJj/lhcopFVfXO1j2RiLcEcCBrBYvEFPo1qtrDXf
         ILiw==
X-Forwarded-Encrypted: i=1; AJvYcCX3KS0sdr9S3Dzt5GNNijVsBvUcxXmuXI6FHV9R2YE4CuJ0rtpy/dAP4z8eoHogI1dQuRAhyMtzUAGE8JEdAV6dFkFhac/0TK3jTHlr
X-Gm-Message-State: AOJu0YzOPA9bfGUNd+rO/Qh0XpuDdev0jl9jarv3jOUMsWQZZwl3j2/h
	FFB3O8iy0clpcXeTFuWhvQB80qtE2SGDSbeq9n9TmufgMXEFM3xbE5qcW6LbgkabvD8A8CxNJ5k
	+clsRPWLD4YnzcAF8j3CPYm8ZzEsEhdPMXm8IaGGZCvmmewY/Wk5Rqk8=
X-Google-Smtp-Source: AGHT+IFyD5ghMIF2yVYmDj4jmGrhKlOUGR5SCL1/c/RG69lsGjVTh4cPc6DoXLedZjqI+rlUryuEEKeuJdOFW+o2FPuTcFwKnd4s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:39a:e909:29f6 with SMTP id
 e9e14a558f8ab-39c476a3da8mr1933285ab.0.1723539261310; Tue, 13 Aug 2024
 01:54:21 -0700 (PDT)
Date: Tue, 13 Aug 2024 01:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d54eb061f8cc12a@google.com>
Subject: [syzbot] Monthly ntfs3 report (Aug 2024)
From: syzbot <syzbot+listebf691b208eb1cd7d80e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 1 new issues were detected and 0 were fixed.
In total, 35 issues are still open and 49 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11997   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  6681    Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<3>  5512    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<4>  4793    Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<5>  4007    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<6>  3561    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<7>  1198    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<8>  636     Yes   possible deadlock in ntfs_set_state (2)
                   https://syzkaller.appspot.com/bug?extid=c2ada45c23d98d646118
<9>  338     Yes   possible deadlock in ntfs_file_mmap
                   https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
<10> 112     No    possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

