Return-Path: <linux-kernel+bounces-394762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06F79BB38E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F74284B04
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E56D1BC069;
	Mon,  4 Nov 2024 11:35:39 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D81B3930
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720138; cv=none; b=YDCsFYukwugIoYWbeFs4H8mtbN7FG3ldKMaylB16dNa3KZvVb1zNp7y/UDcd6VL0lmE4DqRfVY8MwrHVk5C27ECZPpmPz31cnQNLqQ1ETKj7nQjtK8Ioyiji88kxfR+kB5eubxnhJLlOmM5FeA3JzXm24yheZlhW51i7Lefdb7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720138; c=relaxed/simple;
	bh=GY6Mz6PfLUH8bW+wr1XWib89qHZVObbGBgrF+C82dJY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=INAlaCLAzSOne2o1BJezu5l2+UP3wy4U/DTKOeqSePzVE16s7sbeIHHCgdp46dXr05ebJSpclSWDFSNUhgEVd+bJwidbVf8rom0quNaEAKHKVVRF3I+bZqHszhLc6tJ2+/UNus8VujGYqv3foIIuHSbhMFmYbXBgN/qtTyb1MbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b563871eso30786185ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 03:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720133; x=1731324933;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHjlaavy/ys1DA5hfO6azQ6n/g6gTwE9IC5ZXl2T7MY=;
        b=GlpTQejUUoYVISdXewDGtHqgyZntYHzp2InVAG2yOPhhDCVtY4uh3UhTV8ee9SaK4B
         Qqokt08tmFtB+5xbeeSYM3UTSSBKa6QWothlhhcbcGBwpA8XJJ9DbfBvOgF5rQjWuQjG
         PEAVPa4CjHjn9x6slBkPBgqHHRmIOMoKvnZcu8mC7fRl9RqqqtAR7mHIcEoJ3XC8tQyn
         UFkxgTEzlfNBBa+3pmyQeNLkNDo/S43wdIq+PgUddv18rIpiYgS77+d/dxgxOHqz1nw9
         kcoba73HiUK636AxiDUIJJ2J14qn8NWIVRYJhc6fbvFDMAIRng4NfMy9bhYSBIjqSybT
         uMlg==
X-Gm-Message-State: AOJu0Yxd0gohHd98DYKDv/dls7TiICG8QXeLXjX0Q/fIpiG36WUw4QNs
	JQ/qpP0jsB6QZbj46iGpbO+27/NPg9XglmK8jdBB2EsZK/g5n3ubi7ByuDZlUS+svPPBl1h0LCe
	xaX48P12ATR/J4TPv7/vqhpli63bTN+SHTjFNra5Ic2EOSTQUXj7SnVs=
X-Google-Smtp-Source: AGHT+IH2UJ/nWmBgACZteUOnYD2o/vD6e1F8rp4kU+C1Spnn24zOe3MI3Eiq5uSb551Z1ZKtf0Hc7FFHEY65TENgVxG9ntGt/+9G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca1:b0:3a6:b9bf:71ec with SMTP id
 e9e14a558f8ab-3a6b9bf7f81mr82286725ab.8.1730720133410; Mon, 04 Nov 2024
 03:35:33 -0800 (PST)
Date: Mon, 04 Nov 2024 03:35:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6728b185.050a0220.35b515.01bd.GAE@google.com>
Subject: [syzbot] Monthly mm report (Nov 2024)
From: syzbot <syzbot+list86ac6c834ba920e977a9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello mm maintainers/developers,

This is a 31-day syzbot report for the mm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/mm

During the period, 13 new issues were detected and 2 were fixed.
In total, 94 issues are still open and 266 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  10332   Yes   KASAN: slab-out-of-bounds Read in generic_perform_write
                   https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
<2>  7385    Yes   WARNING in ext4_dirty_folio
                   https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
<3>  6624    Yes   possible deadlock in lock_mm_and_find_vma (2)
                   https://syzkaller.appspot.com/bug?extid=b02bbe0ff80a09a08c1b
<4>  3600    Yes   INFO: task hung in page_cache_ra_unbounded (2)
                   https://syzkaller.appspot.com/bug?extid=265e1cae90f8fa08f14d
<5>  2520    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<6>  1786    Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<7>  852     Yes   possible deadlock in gup_fast_fallback
                   https://syzkaller.appspot.com/bug?extid=63ba90b81c16b86379bd
<8>  758     Yes   KCSAN: data-race in generic_fillattr / shmem_mknod (2)
                   https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
<9>  721     No    WARNING: locking bug in __schedule
                   https://syzkaller.appspot.com/bug?extid=46b40e354b532433eeef
<10> 606     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

