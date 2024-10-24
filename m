Return-Path: <linux-kernel+bounces-379414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8F9ADE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EF32B234D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B91AF0A7;
	Thu, 24 Oct 2024 08:02:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3971741EF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756945; cv=none; b=ZywcHlS1a3UrZVPdcALvv0T4Uon2SzIMmtxT/f8BquiITBaMPlNOeoqwKvmqQ6WEJ4s6w2pmmXu02WGUC55mWJ95YAv4siJDJWjDNtOIEHGBCnmCdrLio6xlfnvyB4pDihZakEEsrcqjoGPGy5q1jhCqnYnSjJDrSlSjToaPoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756945; c=relaxed/simple;
	bh=qpOMR1q8pw0arXvHvTdJYdCW8hhLwDdbKEv7LfSOIhM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N8lJf5CvZAlrqlToCIvSKNzMmklXQyuKKz0ahLKlk6fPCLZ/uDMscuj8+00xo/uYt4zzmRAaQ+MirqleMOK8OFR7bbGIQtvQZhSamDFJOfDzSWI9HhV0eRydJJqTeRJbb8QmLtMkjIxJ18lmPvnKJk7JUzV3oqfs5/qnkF1qYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so6339075ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729756943; x=1730361743;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+eQAa/V/MnT5o4xNSk5+65D8LHOg6roAOmqiP7coYjg=;
        b=ZqyKOLYiBm92so9jScjxD4ZTBbhAZHAxUXzM8M/fzCuqIG0Q9HLp89IdyxYhfQPkbz
         zicg03raghJUFK8ojbS3uyezsQi1oVfSxpmowth4nBEaZZMg5sN2q0ro9IAYt/37NGD9
         MRkWq7ydZe4YdcycDrxk0yOl1Kds9X5XJIvXRnFkK5jjewUz7ehfJnSyCvztx0osijqO
         TQnl7t0NQmUOow3FYTTXn1Cw/QmV4xz4BPgRtViHRlHnJ0Pts+/YYImZ44yCc7vicHGe
         2OmlW1TsFG8dkCNRsUUwe033Nibk2EpIGzHygXly+aTpqZLXPx4j6/zUGIFnuRdfkChP
         NcZg==
X-Forwarded-Encrypted: i=1; AJvYcCVf1gGNl9onFUqPcaDl8oe4UwgL8hVKiLVOsoRFP+3wr8nFhJ1bOuDTF3Xo2WB7/hmd0R+EiAoSF7eB0MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dojWQBdwJL79pdczFmRuexgguDTsGc6MYH8adu94tST83eXw
	ByL+3CMXbBVhhi75NOnxZsmCvDqAUe7xs06ooV80R1CXQrwMqTNsn/7j91ybM9YJyln5Dpvaoh5
	7FCNmljYrj+QYJR6p97jEBrkr43IusM0S/Yxz3l6feUWlJIJNt/D/vr0=
X-Google-Smtp-Source: AGHT+IEWfx71AwnUYSROa+k69Z2LcfH3wprVRNEGD/3R9IfrNdYEOzK9yIRIHOrjep6gLcicC35qOz+XMGNVDip+R/GsXS6W4lSD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ca:b0:3a2:74f8:675d with SMTP id
 e9e14a558f8ab-3a4d59d808emr57190205ab.20.1729756943279; Thu, 24 Oct 2024
 01:02:23 -0700 (PDT)
Date: Thu, 24 Oct 2024 01:02:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719ff0f.050a0220.1e4b4d.00a1.GAE@google.com>
Subject: [syzbot] Monthly ocfs2 report (Oct 2024)
From: syzbot <syzbot+list62f8684d17ebec83082d@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ocfs2 maintainers/developers,

This is a 31-day syzbot report for the ocfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ocfs2

During the period, 18 new issues were detected and 3 were fixed.
In total, 51 issues are still open and 6 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  29174   Yes   possible deadlock in ocfs2_try_remove_refcount_tree
                   https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
<2>  4466    Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<3>  3721    No    possible deadlock in ocfs2_acquire_dquot
                   https://syzkaller.appspot.com/bug?extid=51244a05705883616c95
<4>  2419    Yes   possible deadlock in ocfs2_reserve_suballoc_bits
                   https://syzkaller.appspot.com/bug?extid=5d516fba7bc3c966c9a9
<5>  2175    Yes   possible deadlock in ocfs2_reserve_local_alloc_bits
                   https://syzkaller.appspot.com/bug?extid=843fa26882088a9ee7e3
<6>  1681    Yes   possible deadlock in ocfs2_init_acl
                   https://syzkaller.appspot.com/bug?extid=4007ab5229e732466d9f
<7>  962     Yes   general protection fault in ocfs2_prepare_dir_for_insert
                   https://syzkaller.appspot.com/bug?extid=5a64828fcc4c2ad9b04f
<8>  488     No    possible deadlock in ocfs2_xattr_set
                   https://syzkaller.appspot.com/bug?extid=ba9a789bd1f4d21fcefe
<9>  72      Yes   kernel BUG in ocfs2_iget
                   https://syzkaller.appspot.com/bug?extid=5bdd4953bc58c8fbd6eb
<10> 62      Yes   INFO: trying to register non-static key in ocfs2_dlm_shutdown
                   https://syzkaller.appspot.com/bug?extid=d7935821694d430624ea

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

