Return-Path: <linux-kernel+bounces-517622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14611A3834C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3FE188F364
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6AA21B1BF;
	Mon, 17 Feb 2025 12:44:20 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6421ADAF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796259; cv=none; b=MJe4ctPIpAt+0t9QC2asNlOwJ5dU4N+WWXX3sArtkE1FY9GAYjUHYenmKCfliWOb5aSKBdAY5dRIAdM5diRbgSAQ38SEgjP991Aq95ROuRWZxsxh5JVe6xRRc66Kh5q5fdHPvwdVQeRe0Hwjpj1LrfYNLMTL3EGdfMCsOo5Ce+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796259; c=relaxed/simple;
	bh=aejBspab98kEMu3idWjPVw2s5cEoKFhrIZKkhW31lLo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tohJKwkn2yvGdUy45HIWA6xcFyRP5hsm/XAvz23RbCVfsEzwt0v7Ly3FP8mq24OF+jesrM4ueOcXlPv+ZcTmgEVucKOaVdsY4H0BqJdoRyeerVy55YtFbU44upxORKIKSAkhc5mdHxp81XShmnWJ086+4LigdwjcVqxhLuKaAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d143a42980so28494115ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796257; x=1740401057;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKIOjDj7Gj5x+iyQAQD3IBIaAOD34KuOpgNlpMmspaY=;
        b=xP9htuUVT7aja+EOrOXVinRoaLy1eaX78loD6+B7eE9oAYbRvqWIm+OEwkmuuK7NTh
         g/Z/YWUwnD9mAysaLDf/dAxp/fXIlBdTYonfBZgpVXo3Or4S6cuChoWHx+TFUAShiKfC
         uJNLfAN0Irl6e0tLYYrXvR9KZi4FuYkUIG4dG4zg5YQ7uwEuSQqLwFfdjxJ8JO16DtSv
         txTB2NjgzXyPNXraPL0yk2nZ3YFp1COl1zocJ0xbkWUl2Y83lIQm/Wh8Zu+uL3BkSlcg
         IfZzW6UoPSrvWB9cg737HOg6GdOTUtdhkBkP4poFfjlkgzhfbTNJobttvk83gjle4CQz
         /lMw==
X-Forwarded-Encrypted: i=1; AJvYcCWbgoDfxlvCFZdya6hEsiBlQhO9X9Kt3w+laq0M+Ol64rykUhnN7wDgk+gWSNPBCpbar5P/ETdJZNNz1IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVT6aTp/XrsOU91+7wq9uwCERNmnLp4fVex9Zez7jCuZrH6gMA
	qdBPYoPjww7FNQkmMmLZFdHPclce0OJ9P1Sbmz1QvHKMILYBX5nLELaUvvdlZo1LkoWTyaaSyv4
	iZql466SJK0W0kTb4rG9vpcecEl/FHgZVopO86Nr4AQDG+es5deL5gVg=
X-Google-Smtp-Source: AGHT+IEhwCub75T21RkKxTH2EPpAzGzMTmnjrPf2VUr+FPlZpsEHrImG3Tns7WMllPdPHD6sg4u/jRxUWEiYKutCdCb+1u10EG0E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24d:0:b0:3cf:c8ec:d390 with SMTP id
 e9e14a558f8ab-3d2807707b2mr87834055ab.4.1739796257588; Mon, 17 Feb 2025
 04:44:17 -0800 (PST)
Date: Mon, 17 Feb 2025 04:44:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b32f21.050a0220.173698.0033.GAE@google.com>
Subject: [syzbot] Monthly serial report (Feb 2025)
From: syzbot <syzbot+list67224c95d908c00ce68e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 2 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 44 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  758     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<2>  570     No    INFO: task hung in console_callback (5)
                   https://syzkaller.appspot.com/bug?extid=1fb20cf68d15e7c2388d
<3>  177     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<4>  164     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                   https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<5>  104     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<6>  66      Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  44      Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8>  19      No    KMSAN: uninit-value in gsmld_receive_buf
                   https://syzkaller.appspot.com/bug?extid=2f64914d6a3a8ce91bdd
<9>  15      No    general protection fault in n_tty_receive_buf_common (2)
                   https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02
<10> 6       Yes   INFO: task hung in paste_selection (2)
                   https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

