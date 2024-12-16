Return-Path: <linux-kernel+bounces-447095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FEC9F2D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D1A188832A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C82036FC;
	Mon, 16 Dec 2024 09:45:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B3202C38
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734342326; cv=none; b=lOpcWfnlZG0XlGD1HuUrZsZc0ksgT+pYUmtcl6DpPGMyml2tdRVsz18NfV+ntUXMigDl3kosc3TZElLDDnmLYFYcryua1BoikF0/oSLsbcz1Tj4RC95GLCsR07kwjtSt0O0upxWZha6fYwevUFX6GFPSnxOK/08LBnkHV395aFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734342326; c=relaxed/simple;
	bh=lXZiFv+CEHOS7uyt6Jip2Zs1p4I77boySkfSoHpYUo8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Mt4hZ/JGP5iP8uFbRWuL8iE9gFy21JdNGlJK7a0TWdmUcPTjyz6E/cmllP6a9UyZGZ1/XtGPug+52fKYh3zEyK9vb1AZRLU3a67Kne57dVxRPbYqnwFgiqaTv+KEhsNtnFHl+gWnUVuSyzU0amyKG/ttdz0uu6wA1ZK6VXxzQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a91a13f63fso37616325ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734342324; x=1734947124;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1nq5VCoNxjpW1/mUXdO6C3fW6ZjarCPw+ZnF4hsMvs=;
        b=nlKOCFXds0u+5QX6Q8IxbG1PEgIEypk/NF4g2UmmBKciSpQ2l1I782eaztSghjchbd
         a87RqwiUJy2C6rWF1lVJGD2rZ5bogzTQ1gntZ11300acbaZ7wFNncoY9SJnSELo+D0PO
         DAXBX0ro9lhdrAYooPB7nQK99B4bFCxQqNtXI72am1pPd+SMgntD7oWt0Xxg+oalz2KV
         IE/2pjzCq7eyAnItmtw6vENv4OKEcCJsSChlPKoFMzCK1LcxM/j1bl5vqzRWwPQ08MUl
         Xpe5ihThqGv0aTRhkfmpWsAraFqpabYW068/FM8eGPSIRiO5DVkQOvMNagy2ogG/ooW9
         945g==
X-Forwarded-Encrypted: i=1; AJvYcCUo1tK5q3ZrND7Hd9vcF4NzS9fpH1w2V01OZ5KNUyv/BI2RuGDA4QJVe+pynkhdjhazO7Pc6lTEFjjKJcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH8q1HxH5ylujnVBhlj8iHBqUY6QtfVR9/ojZiyLigYaYf+5Kz
	4PRbfHYp0cPqJDBzTqWUadMd5+05yRmPSSWpt1XYWqOfqdsJ59cbT17p/C6gA7rIO3fFY3No4H0
	wyuP+k4gHdSPKrlZmlYMxI2j3+4+JkE93nFd/X/IatfXQMP86KVvP5ZQ=
X-Google-Smtp-Source: AGHT+IFp4KY53q4pEwfPGA6wV1v8i9ESa6fRsvghoRgBsY3fYK6pmW3su8SemAIAdgHke3nhvdL1VWlIqcnx7q+/s/WnibYHs0BM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:3ab:a274:d68 with SMTP id
 e9e14a558f8ab-3aff50b359fmr126402815ab.8.1734342324346; Mon, 16 Dec 2024
 01:45:24 -0800 (PST)
Date: Mon, 16 Dec 2024 01:45:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ff6b4.050a0220.37aaf.0129.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Dec 2024)
From: syzbot <syzbot+liste1602da11e1e5a219c5d@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 22 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1094    Yes   possible deadlock in __kernfs_remove (2)
                   https://syzkaller.appspot.com/bug?extid=aa419d82b68e6a7e96c5
<2>  302     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3>  188     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<4>  73      Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<5>  56      Yes   INFO: task hung in kernfs_add_one
                   https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
<6>  35      Yes   INFO: task hung in do_rmdir (6)
                   https://syzkaller.appspot.com/bug?extid=4128a26fb0f85ec9e76c
<7>  14      No    WARNING in kernfs_new_node (3)
                   https://syzkaller.appspot.com/bug?extid=306212936b13e520679d
<8>  14      Yes   possible deadlock in kernfs_seq_start
                   https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
<9>  11      No    possible deadlock in kernfs_fop_write_iter (2)
                   https://syzkaller.appspot.com/bug?extid=1cfd86253864f61b533e
<10> 2       Yes   general protection fault in kernfs_dop_revalidate
                   https://syzkaller.appspot.com/bug?extid=e37a1730d63d207fe403

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

