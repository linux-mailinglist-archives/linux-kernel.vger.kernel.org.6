Return-Path: <linux-kernel+bounces-390212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D69B771A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F8CB239BB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1A19408B;
	Thu, 31 Oct 2024 09:10:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E10E192B83
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365831; cv=none; b=rl/65ho1xtveXU9rLww+XycZ+rj3xW1qWZZevupN/Veww9KppMlQwkzI5YMUkNdfcPPWAH3QhLKFEPYpTH0tcD0rL3dVnuB48PTBdoaKEb1rs8bog1NBlZp6/bAAZq59AMw4k5Y8xJO3QqDgMJsjI5V/gXplbcQAyfwfUQvOLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365831; c=relaxed/simple;
	bh=163O/Ucc+5WV8cV+djHy7aZiqGw7oFPmS3WfJQc/ZVA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e+Z/XnbSsdxo9xMnqtRDaAbZ3umZQkY0/mHV7skZkH7CrqWTmnoX9W3mVMRFS1ShAD9cJb8edPi5hRKH60iwlkWWE2+QpkJKlAVnk8lrx8VyDIuST1KT9n5pvljTGmXrcD+R30uaX5DaRO11pjFJ86Wwo3hQAi6QUBVCZ/adm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so4437475ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730365828; x=1730970628;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pllFhsMTTU+3e5QN9Fdfs0yUJvv8zYxTy7BrtxYTxPg=;
        b=o4XaeUxhqY92i3hrvODuUlIkBUQftrqVK0lkec5UXUHvZLEkhBvVS1cYVJRYQXpEHD
         vBSk/j7/c68hk0tMYHRtmorrulBHtI+6dVvQeISb5gf59XdxAVFg9Umpgw28SNe9jIUw
         yTmkGRieTM5+MJnJQ5iBpikKo/I71uKTq4wyYOYslObm06Ed7Uex5vXToUK2OlrG00C/
         2kRrCyu/FFwCVTo7P2TziHBwWJDqJi0ObBowK2EKUbCkyu0xuxu5o24R9Yq2sPMJFBLs
         /TeG7IYNiCb01Vck5rr/bEVKtqvqwMFB1rq1+cn71APcjltrY28T1D+G1wx8zdnOZEis
         ZCVA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7gK4QLSR4L4W4rumrqoqyDUoI3RF6nwWiKSqoAUzF3ncPU3kSswq/YGFhbw9zv5GEYnAKKxjyH6g8pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqGwefusm66pPZMcTFacmPgzbwIFyxN/m51BgjQOw0IICbgW0
	jc7MU0/cjMwlOnlR/2zsIy+JFMbctZZ96tc4KgDld7x4lw1QLGKc/dsyCdWkoSwkr9y5sMkYj0D
	6eX2i3kDb4WOPlq+ocI+79P/9YEp3hpWiNUmZvqnenIbwdTucCjOweeA=
X-Google-Smtp-Source: AGHT+IGeBseJGnuFoU8xnWO+MtB1URSw+AcYBSUQuMbpl/WKGMC+mTKqGfTrG5WmOu/m0OmZ0JdMGemFqnnBXsaeoZzC47JFhn2c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ef:b0:3a5:e7a5:af2 with SMTP id
 e9e14a558f8ab-3a6a947cf4bmr14177305ab.3.1730365828712; Thu, 31 Oct 2024
 02:10:28 -0700 (PDT)
Date: Thu, 31 Oct 2024 02:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67234984.050a0220.3c8d68.076f.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Oct 2024)
From: syzbot <syzbot+list7b3e748d81f2ae91c10c@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 33 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3357    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 11      Yes   WARNING in p9pdu_vwritef
                  https://syzkaller.appspot.com/bug?extid=94b73a3e8ea625efcd05
<3> 7       No    BUG: corrupted list in p9_fd_cancelled (3)
                  https://syzkaller.appspot.com/bug?extid=15a08eabe3d3838fb641
<4> 2       Yes   WARNING in v9fs_begin_writeback
                  https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

