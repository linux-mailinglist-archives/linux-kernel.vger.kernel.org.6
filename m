Return-Path: <linux-kernel+bounces-410571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37279CDD6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE93B25C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6071B6D1D;
	Fri, 15 Nov 2024 11:25:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17D1B4F02
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669924; cv=none; b=vDT8lyn3Xdla0iDOHaQLuwf5zlrikboM0eGk0BoYl4ZlZijSOLg/5G3zd4+lwv133BqOb9E5F8KPhaSbaI6XlKIqMcCAq+fvnh22g/RON2RajlqaozfRo7j6iVeL2/qcTRNzZ0CQ7x75OQcRLxN/zWEFmmHK8kWa3jqoZofkVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669924; c=relaxed/simple;
	bh=sTnMQs74/1G+wKdFWH7kpUA7+bWrw0B/BT7AEzDLqBk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qgoaGjOuq6AoJz2/Z13ao330CuxfkrmK8YT37vgqRp/bkcuPkmu4ggItTqacnDJVMiL0ZoOZW3z1DeQSuaOJ+QfC4yq78tVePKrG8+mS84hjdhY4XY8cJpudbuxP3Kfx6MyAKO4uK6IL16ybnRE1OFY/4sTirn8Gacp1eN6tjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so17787225ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 03:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731669922; x=1732274722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7D4v3MfqOUiCrj6ascLgI36kHtN6saUw+dheo2x/Hc=;
        b=mRJCAuuFdL7pSezC5kK84TTft3GD0a0mCEyf100nKGi3SqwBkzAhMrvRjF75XV2O9/
         aTbrp+dg1mzsXbyAwwJmigFXXyrqXu68axjV1qXkh3MeLIdrb+KKWYrhfVEbwgpnO15v
         sBk8reavEhFpGhSC8M+axqGoiqD56z3GiCAlRrPbEjgt5hlNUNAh7uSW/nH1+8DKuBUE
         wHQaYtnZB6rt3g3WCNLyUewKbfH2EQOKYB6EwpBt1WAZv3U8OL96qMaf6HwGrq/H+uIV
         BXD4UBxGBMRuZp5Tee3uFaIoKCXpGPus/5st+LlI6xCPtJ32iOm2FKUQklQMXpZk8W9I
         xYLw==
X-Forwarded-Encrypted: i=1; AJvYcCU4tqTQO5RuvTsh9/goSyxWBppP1rWpZMOBgVx43h22oI0GaliCxiVH+nCEniN8xHiK2qVXi/wx8n4HgGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4GA3qldRHlElAqiODKe1hurgSNS+HRzm0Iko8qO3Ykm6ds5r
	p4w44r24LcCPZWFx7mFk4DN2BL8XnXwX2V7e/aXafQDftxmbIRWy12CPjnAcGBYAbfwlf5EW5oz
	xnbYVAI5pk2VoeLRdqlypdb2gpLArC1SQy51wjCvuhMNR4ZO2+8QL2ZI=
X-Google-Smtp-Source: AGHT+IEhJPLvH0bHTTY0MTmekc77TKs89jV1qH6ciEYOUxwqJYD3WMnd2PtTCWySSjTG/ltrkhcXkav2ic8EcWuphNsp169NJCIB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f83:b0:3a7:158d:e706 with SMTP id
 e9e14a558f8ab-3a748023468mr23045815ab.11.1731669921979; Fri, 15 Nov 2024
 03:25:21 -0800 (PST)
Date: Fri, 15 Nov 2024 03:25:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67372fa1.050a0220.1324f8.00ab.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Nov 2024)
From: syzbot <syzbot+list1e09f71c8e157d401803@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 24 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  335     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<2>  286     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3>  264     Yes   possible deadlock in __kernfs_remove (2)
                   https://syzkaller.appspot.com/bug?extid=aa419d82b68e6a7e96c5
<4>  250     No    possible deadlock in input_inject_event
                   https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
<5>  142     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<6>  71      Yes   INFO: task hung in fdget_pos
                   https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
<7>  69      Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<8>  54      Yes   INFO: task hung in kernfs_add_one
                   https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
<9>  33      Yes   INFO: task hung in do_rmdir (6)
                   https://syzkaller.appspot.com/bug?extid=4128a26fb0f85ec9e76c
<10> 6       No    possible deadlock in kernfs_fop_write_iter (2)
                   https://syzkaller.appspot.com/bug?extid=1cfd86253864f61b533e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

