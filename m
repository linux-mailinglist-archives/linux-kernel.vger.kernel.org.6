Return-Path: <linux-kernel+bounces-178096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161028C48A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 23:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39DE1C22B42
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75882863;
	Mon, 13 May 2024 21:13:25 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B981AC7
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634804; cv=none; b=EBeMTtGQuUxZygcBfraxmxoDgSPJp5OtyotBPdL3nZJDU40074sDdnNqOMf3Y3GSdgpiO3/7JzL4dTQecf5kScwXWpL/ZYNEQvyrRWFCR5zdrQyGkW1aPnbpM/Tl12XPIrgPJ7/8aAVFCyjRImQo+3WAIxfHMdeO5djKB9020zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634804; c=relaxed/simple;
	bh=iKc3NBazYRgXe0iPQiF80oHoLKHH81gy4pKBcdcLhms=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=m0Min9TYnbTt1YIkyK3PpCkcE35/PvxnLFAvgJtKtzG0+PVZAv0AdVsf41RKlH9icPqdyUWuPdlUuIZu+JXGgwHPVflGp1fksRBKGJOgzkQnNY0kpzvFqSdknPZaK02qBnbHkGPQPEGzHhqN5NVe8UzovHWttFA1qr8dVqopy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1ed1af8aaso72701739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 14:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715634802; x=1716239602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EgXbfv/eMbOpCwyb7d9RyNLShFQSuXlIMBTcBxFKGYI=;
        b=JFc7RcX41WXyOHztWLwc44dYM3NXLTTjmDWWo6uL1+BLd4HDauRligKM58Ow8ZrZa0
         Q7zox/7Mos6llPHynvVSooufLJ0FZhjDthlA0wJLg0Wg09n3CwOKeWGgHTl69j7cvQnF
         Tzr8V2i/gUhyh1uFSwoXMHO6u+Nh0dyADm73D9bIGfAdim/9CJxI5/sPYHKzoMT/1iOI
         0OAEjQrsdumUMZ0LZQm3l4Y6d0i/lKR4GMR+xC7cxCfvJEpuoICsvvPPFERxUXPH0fVr
         xeDoO++bOzmeML2dDkT9iiJ9Jf/vGSSu8umps7tyvkFUsV5BWRbr05lol6xlIx5ZDC1S
         d/mw==
X-Forwarded-Encrypted: i=1; AJvYcCVhJ4Mj0fWTaeRUg2QwoXYRY3/FuYwZgPSA+0oCnrMBGBDKAJ4EuNRy18x1oucO2/LftScqHYnoUJVkxkeUh5pic+qVtzzn/PZmOzA+
X-Gm-Message-State: AOJu0YyY7/tuA4z4/BEWhIyVNdpnL3yNd0KbGMpZFdnR5RkxqejmpnvN
	OEzHHWikLPFfsQV+h6+FFr8pXtyv0iQ1lM+CF9WxJCR5Z6JjoiODz8vc//1FTyLZRGsKPoor48+
	X4vz36zIx1RP+nKykydNfC5MvQ35IvdDiSLgf44l5t7AaFQj5ZNsvWk8=
X-Google-Smtp-Source: AGHT+IEpih8LVFVfj8XXP1HXrxboZYYRnZSVtjWkxElSZgQ5GAVH++BpiXkYJS67bFb+9MvxRx7yt+Fcj9M5kYXAQIJABLKkyAoQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:272c:b0:488:9e3e:56af with SMTP id
 8926c6da1cb9f-48955862821mr785072173.1.1715634802668; Mon, 13 May 2024
 14:13:22 -0700 (PDT)
Date: Mon, 13 May 2024 14:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa454606185c5a0d@google.com>
Subject: [syzbot] Monthly btrfs report (May 2024)
From: syzbot <syzbot+listead278fb97880f3601f8@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 2 new issues were detected and 1 were fixed.
In total, 39 issues are still open and 54 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5930    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  2988    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  322     Yes   kernel BUG at fs/inode.c:LINE! (2)
                   https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
<4>  286     Yes   WARNING in __btrfs_free_extent
                   https://syzkaller.appspot.com/bug?extid=560e6a32d484d7293e37
<5>  227     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<6>  123     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<7>  114     Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe
<8>  97      Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  97      Yes   kernel BUG in set_state_bits
                   https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
<10> 83      Yes   WARNING in btrfs_put_transaction
                   https://syzkaller.appspot.com/bug?extid=3706b1df47f2464f0c1e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

